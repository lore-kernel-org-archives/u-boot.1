Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE92BC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E86F80882;
	Wed, 15 Jan 2025 14:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oayQLbCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DADE9807DD; Wed, 15 Jan 2025 14:31:45 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC27807E1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84f1ea04c64so485010539f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947901; x=1737552701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aU8R8AN33Fiet5MHRqBAjXjgJpaYK3BRgKl9z/qyz+M=;
 b=oayQLbCWiPY1Y1S+PkvpsPbeW3H9AqgCCiuSMefXOQl0sS9oTwMdaulCkiX+AtHu5w
 4TjNLvWRBzc7fFthW7TlCKExJ0Fb3hBRvmgsMPPHNGAxvzUf/UJ72LW6RCcZ9BpENyje
 KTO9NTMF1vCfVMWZDtjAteRWzamhYfqeqUTIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947901; x=1737552701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aU8R8AN33Fiet5MHRqBAjXjgJpaYK3BRgKl9z/qyz+M=;
 b=wazuHpnSzoZKYmz4VTNkDZ18H0JgZeLcVZ2TgkTwE7OvkyaBL5fMYRp8oHua4g6xxO
 21geoSxze3vn5me8ShE9iKahR4TNEwd+A+K+OA7L0YDIjUtMt/sTi6krj+4Jqht5Knbo
 +3NYkfY4mIQzXTqBE9oRzAcA8gLCj9UKx79u6VxGx1mMaWikylWVAuXWo290cZxu8DtQ
 yRE2bZ02Xr4SvxMQtRYd4L2Vqj7z2pyxCc9swmCPeRkvDWRRvtZzRNAKVotvm+HvwEcu
 TPOV5i3wQmHQxH2iUZ4FPQ401v7zOK8CGa1q9mXtO+ssQ6QP1UmpDgcsduMoaiXtSuox
 WWmg==
X-Gm-Message-State: AOJu0Yw6NX16se1xysVY+h91fNe/mvSja2n6z1FC39kFXa0gJGUOqWer
 21DP0c05bDCUBsSMKEk16I5KZ7xYXr9AGagcpi5KH6jaYJbbyBNr3WL3Ge9z74c5dIbqixyGnRo
 =
X-Gm-Gg: ASbGncvP5vvYe8mmRHu0nxm70wtXRnH7kDE8cmYvGEtMV79B1bK3ibGu6cUC2HjSNVm
 Y8XNrOeI3WVy70Pq+bXnuc3PPOABotE4fJr9h4wVPpB4BxljV8gB3xTmGzrucuwYO8T4AZoBaaW
 LgpZBI4hRhhw1rODyU0K5vbi67GKXFdfbJFIFx67uAq+dxDqzZhzdJJjrUKuTBLHndTOJf83kGL
 n1X9wx7bF/G2QkkZX5ONYdUSHUjFOe89tfb6E3yF3rufz8kC6+dhsEizof1gR8Ys6C+4dTZ8SBP
 glAtfUvOBMLmZCBw8A==
X-Google-Smtp-Source: AGHT+IHY5HIlVXeSPHJ7WVLuvBttQfI9bbc4v1LQna78mr74uPFNSiYDVgMDoM7SflyAA8ra1kDZ5g==
X-Received: by 2002:a05:6602:418d:b0:84a:7902:d424 with SMTP id
 ca18e2360f4ac-84cdfdce129mr2838643839f.0.1736947901270; 
 Wed, 15 Jan 2025 05:31:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/43] test: Drop the function for running bdinfo tests
Date: Wed, 15 Jan 2025 06:30:42 -0700
Message-Id: <20250115133114.590375-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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
index 10557be6d6d..2ee9b589b52 100644
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
2.34.1

