Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD969C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F988092B;
	Mon, 20 Jan 2025 22:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="awKRvrcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C316809A4; Mon, 20 Jan 2025 22:27:16 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6547D8092B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a8f1c97ef1so16524165ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408432; x=1738013232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUeTW9CzZGusrhJYdGzarSd3gyaj9+IO33f5AliF3SQ=;
 b=awKRvrcgD/YiWt0cglQa/0xqOGLmCHhmVWHgGZVGDnaAbMdBiacaUZtzK5p9IW75QG
 tD+NO/I05XdXpMrcy/ntJxVlsOiwn+B0c/QfA4bl+Ibn9weFz+mIPLRC3YFTln3pZ0Qx
 tJ+/XSXPF19t9SJagDpzYQWSu5Sv+intnGZIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408432; x=1738013232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUeTW9CzZGusrhJYdGzarSd3gyaj9+IO33f5AliF3SQ=;
 b=MOQ6c7yyESHF1R4tq08GDacTwPgCpTZQx4OZpCDrgq1mrz0jPK26cx8TGEOTHJrcKy
 860Er4xnPIdJq39d433gr8cyWyPGL9+mh8QYdCCjwn8dQiZrJdj3+FcUwt91xPQ4dm7I
 seYufrYRV4uafea6m1ptT9v03Ogpq0Pg6ntDkJ9N7mmzOwfIZHpKYK4TSbYnJo2qKKVb
 POQW06+dtWSPdOPc+UvqgV/bIYmGH5szy8iSVw6bxTau9FpxLmKG2P6CyzFaoISgSsbE
 Fb19r+gxr4mbhxhS7/sdelyeMMyjxjyu2EHHvHDnsSWHHbQ1OVe2msG8uCpgl1UBquG+
 H3Pw==
X-Gm-Message-State: AOJu0Yz399vjaiqARuTHBILWa4JpRtjlaCo89/UwYW7E0wI73ERBm1ic
 POkOHASetuXEnppqUkIVQkF1EFB6W5S0/H3NhAmCIukyMPHfcQJC3l0fiH7H6fwPXsJhMe9TW2w
 =
X-Gm-Gg: ASbGncuDJBCcMmWBNol9SKUqMhcCh8yR7MFRnJAMOK4S/5vpIg6LMSD+52/DGqBWOod
 byPMiRePh5drVvNdHtxo7N7KWo1GbyMK4TfRuGE+cNGKEzcbmo6gwB/WQyB3yNCBryr1AH7CMxI
 y8fq9u9KktOPWxfHG+1fpQr79a8Jv1zW2qukIgMiPuzUk+nDhb3CkMGNkEvRoR7Y7c2KT2dVk1s
 T/rPTUhVd0PtKVklt85z9FyceCbVLr5tLz2C+2EpaO7EUCv1I9fqGpQThK7SUmZpnxDqRgw8ejb
 9wtq1ichM9dcNK2xkA6Of9mjG8i0LEc=
X-Google-Smtp-Source: AGHT+IFGFEh56/4Oax4wG7QswYoifPq2HA0AZ792yGaKx5k4NL6Rjt5iT7oB35QepNOhZ8O+bZHLRA==
X-Received: by 2002:a05:6e02:248d:b0:3ce:5a7c:6b5d with SMTP id
 e9e14a558f8ab-3cf743aba4amr128956855ab.2.1737408432660; 
 Mon, 20 Jan 2025 13:27:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/44] test: Drop the function for running setexpr tests
Date: Mon, 20 Jan 2025 14:25:46 -0700
Message-ID: <20250120212613.516664-25-sjg@chromium.org>
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

 include/test/suites.h | 2 --
 test/cmd/setexpr.c    | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index cb6b6fba240..775b0a5a131 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -46,8 +46,6 @@ int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 49eac5890aa..7f318a42ead 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -479,12 +479,3 @@ static int setexpr_test_fmt(struct unit_test_state *uts)
 }
 SETEXPR_TEST(setexpr_test_fmt, UTF_CONSOLE);
 #endif
-
-int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(setexpr);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(setexpr);
-
-	return cmd_ut_category("setexpr", "setexpr_test_", tests, n_ents,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 8ab29046969..f2a72adc16e 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -163,7 +163,7 @@ static struct suite suites[] = {
 #endif
 	SUITE(mem),
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
-	SUITE_CMD(setexpr, do_ut_setexpr),
+	SUITE(setexpr),
 #endif
 #ifdef CONFIG_MEASURED_BOOT
 	SUITE_CMD(measurement, do_ut_measurement),
-- 
2.43.0

