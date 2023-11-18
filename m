Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFF2C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E360F87252;
	Sat, 18 Nov 2023 22:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hIz+cMyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E5F8753E; Sat, 18 Nov 2023 22:06:28 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7E887125
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a6907e9aa8so116323339f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341571; x=1700946371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaIgddT/dB7ha/+hH167nIw1BHL3eYpYKn9geyc2ZHk=;
 b=hIz+cMyq6q8eIJEISovORWNF0OWIgqW85Z8A8qWLK7Z84ge5pYTwiRSe8NmjKEA49F
 be+PGuQRCGWCtY1wilBHASf/Jbuz0P+e9/KsEprWXSlnpzQWAOJwnRanpj7Kb7ykyIHS
 BF6f5AHaR907pCWVYN/P7JSPAzGRuQ9ChyPMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341571; x=1700946371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaIgddT/dB7ha/+hH167nIw1BHL3eYpYKn9geyc2ZHk=;
 b=TZheMxROIBvs8lFbvo1XGWje4ewk8JmZY2BZEdCJ0Pk+uCMf1M97Te8vVAT6VPmTf1
 oKjHNaqHt8LBfPY1kqYejCJrCeKA0n/i1kU8BuHvZw0+oWWYdHpZFSMqJsYM8/0DNKYd
 GmMfsUTV0QyBnK73K6jruVFAVQR5EZNYQYYntZLlmmyvdIz1QSJQC+hj+qP+lDjqj1yZ
 w7fMbEm6kvAfEYVfjwrXN5O+jDYkNCQD/hpDG91vryihJWu+VJnB/3ihd+pA3mKTelsI
 5M5hvLGYtMhUKNND47W49Acah0V/T/suZPbTlfP2vxuZ2SnHcwFesJVMz9+PSavR/1wq
 AP+Q==
X-Gm-Message-State: AOJu0YyldWheuKvwLdm4CeH+LPPrW5SIXhE41LqTuxobPyAf/M/X9NXJ
 cpwcxlOxuJwQSzxamaxPEjNqWIUOw/ajH5gpb51A8A==
X-Google-Smtp-Source: AGHT+IF1qHvqHxv3AxV8piG+roNUV71BMYVRkQnWBkZAyzP4LeuQTdCPRSVb4+bdxgY4/MlpamH0AQ==
X-Received: by 2002:a5d:8348:0:b0:7ac:cede:7b4 with SMTP id
 q8-20020a5d8348000000b007accede07b4mr4094139ior.17.1700341570972; 
 Sat, 18 Nov 2023 13:06:10 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 17/32] bootm: Reduce arguments to bootm_find_os()
Date: Sat, 18 Nov 2023 14:05:05 -0700
Message-ID: <20231118210547.577026-18-sjg@chromium.org>
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

This function only uses one argument so pass it in directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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

