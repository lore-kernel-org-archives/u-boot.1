Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3A5C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBDB8874ED;
	Sat, 18 Nov 2023 22:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EJhlzJmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E018E8708B; Sat, 18 Nov 2023 22:06:20 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB78D8710F
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a6889f33b9so109285839f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341562; x=1700946362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fEiG6ygPn49L0QzdEP+Az3DUJ0GD8lqNixhGFnsDVA=;
 b=EJhlzJmg+AIrRJK8FTO2ROuIk5C3WusfUPjKRWsgR68rl2jsGOUCBAUUWQRQEWCd9Q
 7H2r7O6mKNU+YV2KGSyCXOFHbBz0Z+O9PLaLk4foBRkk2bixXOGG0sHZvSr+6VnjjgNk
 Wm3NkJY49yj2TaFPlDChROKmA1Qk1VhOi0ZiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341562; x=1700946362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fEiG6ygPn49L0QzdEP+Az3DUJ0GD8lqNixhGFnsDVA=;
 b=mLtI/PHoQWCmI5V7dV3+J/H7tAq5FLPqfs2FP1Xds0USx/3tOtpUmdMFL4XG1ssmQ+
 BJTR+5LzCxECbJnObWsmNSHzCTrdrOH/O8cJdwYdVSI3dAMSzTqUa+tPr+BCuJ7CAhru
 e4n+/vRNEW/8a/NRwtsw8/4YwffWpL/xFeXRLVNWGr3oRfp4+LYu6gsGOXWIKYOXe2l7
 FCOrwy3oA/Kf4Yh8uly5Jt8/kud7ebug8ZQ88EhiMwml0bP+7uCPw4y2vrXr0ZTLPt62
 f29j4pRyVUvucqpfeVvmZUgTJJ9XElJxZ/M+1LY7GW3zRarTbGFTPX1DjMqVdmaTj1qW
 eU9A==
X-Gm-Message-State: AOJu0Yxb9E+kglUZIwNbiqTtOVWHbn4Ikc35FcszquRye1F0ohF4riqv
 pmBstof4HFW/HtBi68uVETsftpnCVkpkVdAeVcYDWQ==
X-Google-Smtp-Source: AGHT+IHsKmfrFVbh5ZxOaTFNGJobFG6sffUXPHwGJRv3ySrJEAri6LUGaqB/yvq9vKh2ulhPCsORdg==
X-Received: by 2002:a6b:6906:0:b0:79f:e9ac:f60a with SMTP id
 e6-20020a6b6906000000b0079fe9acf60amr3352027ioc.20.1700341561858; 
 Sat, 18 Nov 2023 13:06:01 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 07/32] bootm: Simplify arguments for bootm_pre_load()
Date: Sat, 18 Nov 2023 14:04:55 -0700
Message-ID: <20231118210547.577026-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Move the argument decoding to the caller, to avoid needing to pass the
command-line arguments.

Add a function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index fda97706fc26..1482a2cc783f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -82,22 +82,31 @@ static int bootm_start(void)
 	return 0;
 }
 
-static ulong bootm_data_addr(int argc, char *const argv[])
+static ulong bootm_data_addr(const char *addr_str)
 {
 	ulong addr;
 
-	if (argc > 0)
-		addr = simple_strtoul(argv[0], NULL, 16);
+	if (addr_str)
+		addr = hextoul(addr_str, NULL);
 	else
 		addr = image_load_addr;
 
 	return addr;
 }
 
-static int bootm_pre_load(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
+/**
+ * bootm_pre_load() - Handle the pre-load processing
+ *
+ * This can be used to do a full signature check of the image, for example.
+ * It calls image_pre_load() with the data address of the image to check.
+ *
+ * @addr_str: String containing load address in hex, or NULL to use
+ * image_load_addr
+ * Return: 0 if OK, CMD_RET_FAILURE on failure
+ */
+static int bootm_pre_load(const char *addr_str)
 {
-	ulong data_addr = bootm_data_addr(argc, argv);
+	ulong data_addr = bootm_data_addr(addr_str);
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
@@ -785,7 +794,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = bootm_start();
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
-		ret = bootm_pre_load(cmdtp, flag, argc, argv);
+		ret = bootm_pre_load(argv[0]);
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
 		ret = bootm_find_os(cmdtp, flag, argc, argv);
-- 
2.43.0.rc0.421.g78406f8d94-goog

