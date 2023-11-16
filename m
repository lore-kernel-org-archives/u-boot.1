Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FD4C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334568748C;
	Thu, 16 Nov 2023 05:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HgJoGlFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0EF874A9; Thu, 16 Nov 2023 05:11:38 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87CCA874BD
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-359c1f42680so1377555ab.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107895; x=1700712695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VG/uHSDrLH+LU227EYsPqcfJGoFVNCcEo7Jxt4ppniY=;
 b=HgJoGlFMD549KHAEFYp7LU5ibUby70NrFVe1c4JzYLZ3EpkcuFZg5AH3Y7Tp7JEesO
 Ja7ZyVplBsFt4uo2WK7umQSy+G86I9+miy/78BQ10O5WCpm+gYZVbZ67CoX4BgQ2Qpyn
 siHRMd3apJoHXGQYBC+7adh+gbF61JDdkMHdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107895; x=1700712695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VG/uHSDrLH+LU227EYsPqcfJGoFVNCcEo7Jxt4ppniY=;
 b=Fg/+obTVSuoG+UYDIDlOwz//Lo3SwGKGO5XUEPAYSJfBmFQNRh57LdJt0B+ofz5QNW
 EtvTJCEGw5iY0/GrivpqnG5Ri+GS+2N30H6SH2Nyp2hhXdNIPDOj4oVLNlox820FQBO9
 1HSnJzU/l8zzYOk1YF2kLjXu1VCs4jYmut+B66uSqlf114b7b5PmlY/m7nsvO+AeKaaJ
 J01oaRS/2j44lZGJwcA2+yUYZvQHiRWtI07McmzSkHRRWke9081Lc3X+QNKOU6rh0kjo
 +qlBgSNL5IQfsOxin911E8FCD94ChMjXPnBf53bcrm0eNLqWfauaTjEr1mLMvB+BMTPQ
 0PHQ==
X-Gm-Message-State: AOJu0Ywc5NpaoZWKNlYU8nMWCvp8ZLtUlIJqCcY5NdsxnQsuGi831beG
 uRPzCTkzMSJwcNfNnacfC54C2VUpBZV0PHpTM/sZlQ==
X-Google-Smtp-Source: AGHT+IHpBRBzI72oT6DyxyyoFzjsYatlIBVmQ39YJ6Reo9g95RuuzX86qlvVUU6Lma0r+/9u/iw+Rg==
X-Received: by 2002:a05:6e02:1c83:b0:359:6af2:67bb with SMTP id
 w3-20020a056e021c8300b003596af267bbmr19057060ill.23.1700107895111; 
 Wed, 15 Nov 2023 20:11:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 18/32] bootm: Reduce arguments to bootm_find_os()
Date: Wed, 15 Nov 2023 21:10:18 -0700
Message-ID: <20231116041043.362055-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

This function only uses one argument so pass it in directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Fix 'boot_find_os' typo
- Pass in the command name

 boot/bootm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 7aca2bf8146c..922989b9cfcf 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -304,8 +304,14 @@ static int bootm_pre_load(const char *addr_str)
 	return ret;
 }
 
-static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
+/**
+ * bootm_find_os(): Find the OS to boot
+ *
+ * @cmd_name: Command name that started this boot, e.g. "bootm"
+ * @addr_fit: Address and/or FIT specifier (first arg of bootm command)
+ * Return: 0 on success, -ve on error
+ */
+static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 {
 	const void *os_hdr;
 #ifdef CONFIG_ANDROID_BOOT_IMAGE
@@ -316,12 +322,11 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	ret = boot_get_kernel(argv[0], &images, &images.os.image_start,
+	ret = boot_get_kernel(addr_fit, &images, &images.os.image_start,
 			      &images.os.image_len, &os_hdr);
 	if (ret) {
 		if (ret == -EPROTOTYPE)
-			printf("Wrong Image Type for %s command\n",
-			       cmdtp->name);
+			printf("Wrong Image Type for %s command\n", cmd_name);
 
 		printf("ERROR %dE: can't get kernel image!\n", ret);
 		return 1;
@@ -987,7 +992,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = bootm_pre_load(argv[0]);
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
-		ret = bootm_find_os(cmdtp, flag, argc, argv);
+		ret = bootm_find_os(cmdtp->name, argv[0]);
 
 	if (!ret && (states & BOOTM_STATE_FINDOTHER))
 		ret = bootm_find_other(cmdtp, flag, argc, argv);
-- 
2.43.0.rc0.421.g78406f8d94-goog

