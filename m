Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19409C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 13:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 783CC8191C;
	Tue, 18 Mar 2025 14:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G153auoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F958198A; Tue, 18 Mar 2025 14:23:44 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E8D8186D
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 14:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso93446865ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742304221; x=1742909021; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKrnmhNRNY4uL57JEtShA/gHdBEd0OK/nSxqFVu3XLo=;
 b=G153auoFdBlo+XzVlFvMoUDMb1+ECy2REc/6BswXIWAD/XhEHoZhljmLUuNpCnlaWS
 OEiIhoIOhzEJMEy4yzV5yNBLAbjV3qiwjxkwLhGTBB4YJsoQuf404pQndRABYPJTuq6h
 Inu+VfgG1x5YMlfLyYWHu1DpPKNQa5sxjxFPwiVpw4YTrtnhj8pJ+GNtpovjku5eHqES
 JX9KK73xC05vPK1X6jHaArG7IQ3CsfCgcWVtM7fEEkucR3iXZImEzgDoXrA9VOhMlOjn
 AmXcuJDkTg32wgbBwBkG72K6YitciE/QH6tLpW2MvB+YYZ5CG4BPgohGqsrLMU9CynJA
 e9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742304221; x=1742909021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKrnmhNRNY4uL57JEtShA/gHdBEd0OK/nSxqFVu3XLo=;
 b=v/jiKvp7i+vPbwhouAjbqfwceiqOv6KyyyD3vNngMYLu/GoZ8BAPcWVAmbrRDuJnIk
 GVckWWCIb6GgBtnTBJPHvcUyusFLfur4s0qFwIj82RcfUEIgz7239jmB8ySyd6CeOMbc
 oKfPXR5FlCADqPuBb2BAo/vtXeQgrmCOgdT/YHE1nCl3vgsEBY3RnIH5P6j9h2C1+bb/
 DbhJDS8LT1ISTrHMo60I9jKB+GGF8Q11GUsrX8AwzqCu0hSBa2Nqw65nIBnAWJEO9BQG
 e3Cd7EADbn+yASRQypwsIKCroyS9QLsbnBf7d1l0j3Rhn0I2MUEu6GpV7ZVJRf5xw+Jj
 WKhw==
X-Gm-Message-State: AOJu0Yx2hkh6z6CrPnHml+rp9ITVjkFVQ/ceZ9VSuTKww1uif9A03gqb
 Pm8UEv5khE0byOUL8yNwnroAbbM7yCvoqP5tUbQpM5PHNP82zRWCvSHMnWmxglQ=
X-Gm-Gg: ASbGnct/TBYbt8ftHU5vGLiN11p3VleeM0r1R642fF1pX1jpJbUUozihG9PuXy111ly
 pD2tDtvPOkUZTRfyp58bYGB22gF63two0JApiirFn8egYnkvojad5xKbKvpcRWvfaIr0hKUTEdg
 tREZcAwt+V/CCX0BWgRmdAJZZBjJV/ztRH1Tif6SK1CKdPqVUFZ+aamfka0VTxO3BiTF18yKlJJ
 NAUkrjHl1Yz9Ik3dJTimjHyGl8rqMGDKu5zcI1LQRmOUt9doHpWSs1G+HTUN22FaBh5oyMPXjN3
 yiAsM6OVLqhS00ZwZvBelSJtLCRSkc3tlZKblCD8V/WwA6UIm1BUkFog
X-Google-Smtp-Source: AGHT+IFlf3jxRsV7PlKif3RNbO0BGiEz7hPK3/e1E2iWGe9yW+6L22c34empghBFg12qYlJLXYEYwQ==
X-Received: by 2002:a17:902:cecc:b0:216:271d:e06c with SMTP id
 d9443c01a7336-2262c992535mr38382555ad.4.1742304220620; 
 Tue, 18 Mar 2025 06:23:40 -0700 (PDT)
Received: from adriano.. ([2800:300:6f53:4a50:2bbd:7872:4328:2b1c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba70f3sm93685945ad.157.2025.03.18.06.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:23:40 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/3] efi_loader: binary_run: register an initrd
Date: Tue, 18 Mar 2025 10:23:46 -0300
Message-ID: <20250318132347.646703-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318132347.646703-1-adriano.cordova@canonical.com>
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
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

Add support to install an initrd when running an EFI binary
with efi_binary_run

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 boot/bootm_os.c              |  3 ++-
 cmd/bootefi.c                |  2 +-
 include/efi_loader.h         |  2 +-
 lib/efi_loader/efi_bootbin.c | 20 +++++++++++++++++---
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index e9522cd3299..f403f352be1 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -507,7 +507,8 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
 
 	ret = efi_binary_run(image_buf, images->os.image_len,
 			     images->ft_len
-			     ? images->ft_addr : EFI_FDT_USE_INTERNAL);
+			     ? images->ft_addr : EFI_FDT_USE_INTERNAL,
+				 NULL, 0);
 
 	return ret;
 }
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index c1454ffb948..dce8285b047 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -211,7 +211,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 	}
 
-	ret = efi_binary_run(image_buf, size, fdt);
+	ret = efi_binary_run(image_buf, size, fdt, NULL, 0);
 
 	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index cc732dc4807..ad60805ae4f 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -600,7 +600,7 @@ efi_status_t efi_install_fdt(void *fdt);
 /* Execute loaded UEFI image */
 efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
 /* Run loaded UEFI image with given fdt */
-efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
+efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void *initrd, size_t initrd_sz);
 
 /**
  * efi_bootflow_run() - Run a bootflow containing an EFI application
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index deafb2ce1c2..8c1850296ad 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -204,6 +204,8 @@ out:
  * @image:	memory address of the UEFI image
  * @size:	size of the UEFI image
  * @fdt:	device-tree
+ * @initrd:	initrd
+ * @initrd_sz:	initrd size
  * @dp_dev:	EFI device-path
  * @dp_img:	EFI image-path
  *
@@ -213,10 +215,12 @@ out:
  * Return:	status code
  */
 static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
+				      void *initrd, size_t initd_sz,
 				      struct efi_device_path *dp_dev,
 				      struct efi_device_path *dp_img)
 {
 	efi_status_t ret;
+	struct efi_device_path *dp_initrd;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+	dp_initrd = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, (uintptr_t)initrd, initd_sz);
+	if (!dp_initrd)
+		return EFI_OUT_OF_RESOURCES;
+
+	ret = efi_initrd_register(dp_initrd);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
 	return efi_run_image(image, size, dp_dev, dp_img);
 }
 
@@ -239,13 +251,15 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
  * @image:	memory address of the UEFI image
  * @size:	size of the UEFI image
  * @fdt:	device-tree
+ * @initrd:	initrd
+ * @initrd_sz:	initrd size
  *
  * Execute an EFI binary image loaded at @image.
  * @size may be zero if the binary is loaded with U-Boot load command.
  *
  * Return:	status code
  */
-efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void *initrd, size_t initrd_sz)
 {
 	efi_handle_t mem_handle = NULL;
 	struct efi_device_path *file_path = NULL;
@@ -273,7 +287,7 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 		log_debug("Loaded from disk\n");
 	}
 
-	ret = efi_binary_run_dp(image, size, fdt, bootefi_device_path,
+	ret = efi_binary_run_dp(image, size, fdt, initrd, initrd_sz, bootefi_device_path,
 				bootefi_image_path);
 out:
 	if (mem_handle) {
@@ -355,7 +369,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflow)
 		log_debug("Booting with external fdt\n");
 		fdt = map_sysmem(bflow->fdt_addr, 0);
 	}
-	ret = efi_binary_run_dp(bflow->buf, bflow->size, fdt, device, image);
+	ret = efi_binary_run_dp(bflow->buf, bflow->size, fdt, NULL, 0, device, image);
 
 	return ret;
 }
-- 
2.48.1

