Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F4D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB003890DA;
	Mon, 28 Oct 2024 13:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lYxWJdq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2052F89140; Mon, 28 Oct 2024 13:48:33 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BCC8890BB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so853054366b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119710; x=1730724510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0vBi5ci4Yva6L2VGMZqHC7AwQs0sTqI2BvT7/1thy8=;
 b=lYxWJdq5OfO0Qia1w23NYVkQI8pCUeC3C9R/m2KTDUKmVBs/8YbKUo+/7OwdSk5538
 ZMsi2jsFQGPuP1ngyAeV/9P8CJqUMFg2y01hypjGJebkHQ2Zp6xSfkoc6vlksj2wwHD9
 MV2wWvi0gNEZ1b5ltv9u2bQXwxAQbIW+oGBMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119710; x=1730724510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0vBi5ci4Yva6L2VGMZqHC7AwQs0sTqI2BvT7/1thy8=;
 b=lfnu6iBIdrMoxcczsvJcdrHZKdtkftfXZtkg5M6jLGmRBWz8MOOxV7Cmv5Mh1rOAVE
 Qj1KV+nI/H+mAwkyUPa6YvSmR6NQRoQy0ztNR7H4ODMEUPD/AHfyXvSEH+5j+m6Z5Akt
 iV7pddo+MPZtSoIARoyvYIY1pc5kajni+juwAVRyt9EOE+7PrkngJu7y9LGmRoqZsaaG
 TuG7EsJ1ug58VEN/TgovGlFl5Oo+8j5No4NOjvPEzQ3yRwrSqersB3oqyFIT/O9KDP9+
 z7p99xLywcaqY6WkX8eVmLVgggGAMSdPu3lcXJwwAaFUiJ57Zvy8wxgDEPqU2ihEftQ1
 0LXg==
X-Gm-Message-State: AOJu0YyrBGsLP17mcL5IAOyUtzHYE3tg3A3WCCO6dbaVoGcfoHhV13Cc
 ywltvnDzsxNjeSNl+17Xjpcyy1lw2bZIMiLluWbRcsSrbds4vFBg1qLXkijCn6YD4UXFxDqFozp
 S3g==
X-Google-Smtp-Source: AGHT+IEFr6NUo2kCWJkuoUm95BlvMqqMTr2wICkjPLT5Y9B2ptAJT9F52D+bTKfNCe+4oU1ZjUwDFg==
X-Received: by 2002:a17:907:7ba2:b0:a9a:17be:fac7 with SMTP id
 a640c23a62f3a-a9de35b3647mr810553666b.14.1730119709757; 
 Mon, 28 Oct 2024 05:48:29 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/15] sandbox: Convert sb command to use new macro
Date: Mon, 28 Oct 2024 13:47:55 +0100
Message-ID: <20241028124815.47262-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

Ise the new U_BOOT_CMD_WITH_SUBCMDS() macro instead of writing the code
out manually.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/sb.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/cmd/sb.c b/cmd/sb.c
index db485fddfca..9dbb53275b3 100644
--- a/cmd/sb.c
+++ b/cmd/sb.c
@@ -40,29 +40,10 @@ static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-static struct cmd_tbl cmd_sb_sub[] = {
-	U_BOOT_CMD_MKENT(handoff, 1, 0, do_sb_handoff, "", ""),
-	U_BOOT_CMD_MKENT(state, 1, 0, do_sb_state, "", ""),
-};
-
-static int do_sb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct cmd_tbl *c;
-
-	/* Skip past 'sb' */
-	argc--;
-	argv++;
-
-	c = find_cmd_tbl(argv[0], cmd_sb_sub, ARRAY_SIZE(cmd_sb_sub));
-	if (c)
-		return c->cmd(cmdtp, flag, argc, argv);
-	else
-		return CMD_RET_USAGE;
-}
-
-U_BOOT_CMD(
-	sb,	8,	1,	do_sb,
-	"Sandbox status commands",
+U_BOOT_LONGHELP(sb,
 	"handoff     - Show handoff data received from SPL\n"
-	"sb state       - Show sandbox state"
-);
+	"sb state       - Show sandbox state");
+
+U_BOOT_CMD_WITH_SUBCMDS(sb, "Sandbox status commands", sb_help_text,
+	U_BOOT_SUBCMD_MKENT(handoff, 1, 1, do_sb_handoff),
+	U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state));
-- 
2.43.0

