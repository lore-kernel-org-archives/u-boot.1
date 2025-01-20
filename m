Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AA8C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F437807E5;
	Mon, 20 Jan 2025 22:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lwHpXqBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9CA480817; Mon, 20 Jan 2025 22:26:53 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CFA807B6
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a8165cfae8so13797245ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408410; x=1738013210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n53o/zg2xLhUz88+KxfiJ/E24LkfRCgOfBCq3/tMrt0=;
 b=lwHpXqBEoIhygBqpyDhdR26o/IG0GhLGMnumFp1Ykroi3Hqyl2GeGfQNEaqqBv1YXl
 35Ar1ZpunhSiWhGRep07YvwjLPA7eqSda8ZPbWd5+Y45UOibc0A9VL1exkM1AI0sOhHd
 tgIs87ZME9dScA5TtXdadnbO/a6MMoHjStym8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408410; x=1738013210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n53o/zg2xLhUz88+KxfiJ/E24LkfRCgOfBCq3/tMrt0=;
 b=u+I9bybElUT5jWJkVoy76Ty2fAG+JcTAecdHG8LcUr0nXY32CSAp1tzR4os996qfkB
 8yZuMDjDr3DBq0bQA8kpK5g+9IWhpEAh4kSH+cH/ggv74YKLrVUWRmTeT7pgVzLyxG0L
 twUkFLhlVnzDS/G5Lh8tDOqP3n5fREit0TxaF4yWrBZcrVu5ffI1NnLM9H7PgKVIhaHF
 meP7Ufpdn4o8XNNFzrFLEqnlXSXLMTdHFTwHgjMcW8QsmNpyFlQbeB5mhR6AdqAUyg8E
 JOCxfS9E7G16R6USlowOfvAW/J4vzXH0/VDXPuESv6LBFUxQi/9XubnhXhaIn6ptbcw/
 sgwg==
X-Gm-Message-State: AOJu0YxKtra0R9yVeWUm2pVpIN52XUQErgBcC7u8xtC8SzV6NsD6kZzA
 0JLJsfgxrV5B04x/eo6qbJ3a7ygA/lokv4tpi8dp4/zKLBqLey3I0TTAfOgnqIJIF3TU2IKEazA
 =
X-Gm-Gg: ASbGncvZ5cH55g5eF30wHS8Lj2gSCC7YFIBtkiQv2Jqylg+xV+uaCmSqWW0ffcbHzfy
 BU2wc4hhtHqNVfcn7ke85OsI0SeHtkXP0n24NOSG90Uks9bG7khUTkvjjq7uKQQKuNqtVpM6oHa
 iFDf/DzQ710ami6yI7AFH7oiiYGyOxKOcAPRPQEh/N3MvetQBBLgcccDI/WrJlp145oSpqiGoe4
 sP/PZggUZEbrx9CHPrn8X1uLZ/3URFYOw0rYXLiv8s4SETwPO33i9a7NsGVI5rRRV/hijpEfPaJ
 RuWTGDbZXXA3yRtTwgeIm4XD6Vh3G3Y=
X-Google-Smtp-Source: AGHT+IGl/SyJGCkOQsEPEUklqTEMUavKY4AF3EJel4/o+hWMwXXo14kndYoEx+h2c0kMZfNw4Gfq1A==
X-Received: by 2002:a05:6e02:178c:b0:3ce:6aa8:6c56 with SMTP id
 e9e14a558f8ab-3cf743e909amr120131665ab.8.1737408409918; 
 Mon, 20 Jan 2025 13:26:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/44] test: Drop the function for running bdinfo tests
Date: Mon, 20 Jan 2025 14:25:34 -0700
Message-ID: <20250120212613.516664-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h | 1 -
 test/cmd/bdinfo.c     | 8 --------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index c1119e44999..b6af9295424 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -32,7 +32,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 
 int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 46482b1f56b..11f717bf43e 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -282,11 +282,3 @@ static int bdinfo_test_eth(struct unit_test_state *uts)
 	return 0;
 }
 BDINFO_TEST(bdinfo_test_eth, UTF_CONSOLE);
-
-int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bdinfo);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bdinfo);
-
-	return cmd_ut_category("bdinfo", "bdinfo_test_", tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index c5df8b397b3..bbd329912d4 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -123,7 +123,7 @@ SUITE_DECL(upl);
 static struct suite suites[] = {
 	SUITE_CMD(info, do_ut_info),
 #ifdef CONFIG_CMD_BDI
-	SUITE_CMD(bdinfo, do_ut_bdinfo),
+	SUITE(bdinfo),
 #endif
 #ifdef CONFIG_UT_BOOTSTD
 	SUITE_CMD(bootstd, do_ut_bootstd),
-- 
2.43.0

