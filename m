Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00802C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580C7875A7;
	Tue, 21 Nov 2023 02:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="to8s09Rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0887A87582; Tue, 21 Nov 2023 02:30:47 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39EDD875A7
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc703d2633so10670275ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530238; x=1701135038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Azv2jiokxdDjjZVQpsj4tHdv10eu4UK1JN/knIvXPu4=;
 b=to8s09RlkP4KblHZ4l5HzIY2Kgl33PqP7HPOiHo2NPH54FVlNoShcsinFElqF2729w
 YzgfDmJCO2+OL957r33LMGSVL7lifcluUL+/K4SGiFXUTILnvLhYlLtBQFQoIBOplLrF
 FbQcpuOVODErPp/BM1G8b01bQsLr9bibMZ7/zo1R0rtEe0RbQ7WoPfVN+vhXwsvnxxSF
 fq2dYm1lk1QMz3D16LmoRfaU8p+dHF9KRjKkBrnuyvaFPIAYZf/op41Y73pmKs5g3qDF
 m9oNLsiNXGB1O7mki1yifJ4iqshqRPA7uIoNzz8FF87lXzhqP+8cup2Nh9gJGwRWZk5J
 fSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530238; x=1701135038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Azv2jiokxdDjjZVQpsj4tHdv10eu4UK1JN/knIvXPu4=;
 b=elAG2+qQlHDIGakrFSNDjcfE3EZZc7frGmD4+NEBzLAyMDVORKSAMnc6HrMOThCgBt
 qvpgoylLFqsb+A4SI4/vxOYoSiQcDQwnzZ4UbTL1u92ZXcmeOhqXnfqxJfcXRfwJ3nPQ
 iJkeFdb/iO7mdjzcKzF8fjgAygcBPNyDgJGJvF8/T4zMHEXiZv813JOKzOpwGNUh50uE
 pCJA52hZmxZRvYFX6twdOZ56ZJz4nuKCNkMZWYM4TZnLiWBwjs791eXfRUv6KAdiRN91
 rLNcbxYCa0EIgUTEkKFyzLTYO8oHBMOvAF1eRl1IhYdKYRqAm62/62RMA6zP7/b/iIXg
 aw6Q==
X-Gm-Message-State: AOJu0YyDZvjjGbxjJOzrpH63OU7XQ3+bTBjechxYfZZkiDK6a6aI0dng
 px+PgQGyYQ+yMAl5L9N2o601dg==
X-Google-Smtp-Source: AGHT+IF04qVJQGdFp8aEJGB19y1PonWyGOfxKACdgUsijqPU53XRtT9evGaDkzMKC42xwI12NMTBtQ==
X-Received: by 2002:a17:902:e74b:b0:1cc:32c6:e5fa with SMTP id
 p11-20020a170902e74b00b001cc32c6e5famr11564552plf.6.1700530238103; 
 Mon, 20 Nov 2023 17:30:38 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:37 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 03/12] cmd: bootefi: carve out EFI boot manager interface
Date: Tue, 21 Nov 2023 10:29:41 +0900
Message-Id: <20231121012950.156539-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Carve EFI boot manager related code out of do_bootefi_image() in order
to move boot manager specific code into library directory in the later
commit.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index e9e5ab67a1f5..87910c42333a 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -413,28 +413,40 @@ out:
 }
 
 /**
- * do_efibootmgr() - execute EFI boot manager
+ * efi_bootmgr_run() - execute EFI boot manager
+ * fdt:	Flat device tree
+ *
+ * Invoke EFI boot manager and execute a binary depending on
+ * boot options. If @fdt is not NULL, it will be passed to
+ * the executed binary.
  *
  * Return:	status code
  */
-static int do_efibootmgr(void)
+static efi_status_t efi_bootmgr_run(void *fdt)
 {
 	efi_handle_t handle;
-	efi_status_t ret;
 	void *load_options;
+	efi_status_t ret;
 
-	ret = efi_bootmgr_load(&handle, &load_options);
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
 	if (ret != EFI_SUCCESS) {
-		log_notice("EFI boot manager: Cannot load any image\n");
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
 		return CMD_RET_FAILURE;
 	}
 
-	ret = do_bootefi_exec(handle, load_options);
-
+	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
-		return CMD_RET_FAILURE;
+		return ret;
 
-	return CMD_RET_SUCCESS;
+	ret = efi_bootmgr_load(&handle, &load_options);
+	if (ret != EFI_SUCCESS) {
+		log_notice("EFI boot manager: Cannot load any image\n");
+		return ret;
+	}
+
+	return do_bootefi_exec(handle, load_options);
 }
 
 /**
@@ -624,21 +636,14 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
 	    !strcmp(argv[1], "bootmgr")) {
-		/* Initialize EFI drivers */
-		ret = efi_init_obj_list();
-		if (ret != EFI_SUCCESS) {
-			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-				ret & ~EFI_ERROR_MASK);
-			return CMD_RET_FAILURE;
-		}
+		ret = efi_bootmgr_run(fdt);
 
-		ret = efi_install_fdt(fdt);
 		if (ret == EFI_INVALID_PARAMETER)
 			return CMD_RET_USAGE;
-		else if (ret != EFI_SUCCESS)
+		else if (ret)
 			return CMD_RET_FAILURE;
 
-		return do_efibootmgr();
+		return CMD_RET_SUCCESS;
 	}
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
-- 
2.34.1

