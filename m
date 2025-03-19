Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1847C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E107F81F0B;
	Wed, 19 Mar 2025 15:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hnItWbnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359A081E47; Wed, 19 Mar 2025 15:45:01 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEBB881F0B
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-226185948ffso70546005ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742395497; x=1743000297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlfcCSyxjXc4mBEqDCF5XyQgy00CQHgvggx8KAAPYu8=;
 b=hnItWbnLbddziqoXhDh8t6Ax4BxU8ZtYTdf6A1O5/7Vdy62TEPtYrTx1k5MW3AnsrN
 p2U3kx9Obb6PpQH3xNvdIEXMzUggK28L3Qd8CEOlS5Aq/PzmjgXrTDiDX2ENWOT5svTO
 qvN6J2hQXsDAHuP87N3dsOHlTs7oOiR1nMPsbAcyCsFyE6FZKOGutYnf3ReOpsjvDIfr
 ItliETrZJ3WzCdqNWoR6RH3tkK2l0ev3VAQNDHuFUwvhSyfPXOU/Vo/SvbuCRCUJBkiv
 cgPDo4hL46A0uEu5FB4lUwG0uSa7wSUx8FxUdDPvV6tyceOhVbdBd3hIZtDphCAtLxTh
 yNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395497; x=1743000297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlfcCSyxjXc4mBEqDCF5XyQgy00CQHgvggx8KAAPYu8=;
 b=a43HAaQyu0CjqiQ0VNGBc12PyZIzgx/1Q0oUBurHpyIcAHeZ6Us8cwk18NajJKPFPZ
 De8D/+19hRAafXsVUM91zGFAJyoOVY3En3W6ZU3yOiymMQg4tUu8e+pcPEYUPsYDYXzb
 a0/y/oVD0DTFg4/bIgzXksWt972wRlG9JU797wMIniujZk6xTGsIp2YfgejrQ4BweEWf
 Fg1Io0mnYwfoXu1vBM6K7wd9bkvdjjGv6QrX4/lP023O+A8morsWFtvr9xXqLF+h6/rF
 W+1sB4iPzLcuw8nFate+i/kzFGpG4xa1D0JnUl51Ax+NiWdiiI2gXqJ0Q0tzSZwDdm+R
 aESQ==
X-Gm-Message-State: AOJu0YxuuEXmegR0uTyyRFAK3/ouo9kkk+J5hVzY6eFfyNxUdGhwugmc
 UkBJ86fZDRAnC7VxpNP4AaTMSRmV9fT1pFDCOfQ+7d0cxGD/45rM9Jo5+vduMJe6Zg==
X-Gm-Gg: ASbGnctdHCNHCtcGnKzt2EDAd3na4w0PifCtWkyiAMQftUP7nwtuklol7X6bNlWb3Yy
 GJnJ7TlNrQlTQG3EjGtHwjdiSdMYALgFOlz640zndQpuDqDQgWdrXZTWCIhH3De324JygyFJPse
 JAW3p1rJ8VL1X52ZjdScVb4sgJ/QWWWcu4HzItesjpeBi1dC8r7jg0DQtPScz+X7rnUdh+waIZo
 uM2D3IlVNagHzhvuxIajROc49hYuY41/ghoddtcyee0cRFfhGLY9XDszi957jWYD+N8mTKBOrqK
 Xnnro7PGpdPlmSG4zATS+oRtzMn/lDcwGQi+GbrSqQnnNSkIpsOQHM4=
X-Google-Smtp-Source: AGHT+IFj6whBmsBHl3XRfnIhnK3rixnydNpR+6g4Ty1gzQMZj43zds6s6QF6zBedpF0AHY3AszI0Nw==
X-Received: by 2002:a17:902:f60f:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-22649573a26mr50410425ad.0.1742395497201; 
 Wed, 19 Mar 2025 07:44:57 -0700 (PDT)
Received: from adriano.. ([186.175.132.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba734esm114812915ad.141.2025.03.19.07.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:44:56 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 2/3] efi_loader: binary_run: register an initrd
Date: Wed, 19 Mar 2025 11:45:00 -0300
Message-ID: <20250319144501.32277-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319144501.32277-1-adriano.cordova@canonical.com>
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
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

Changes in v2:
- Change EFI_RESERVED_MEMORY_TYPE for EFI_LOADER_DATA for dp_initrd

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
index deafb2ce1c2..2cf972343a4 100644
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
 
+	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
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

