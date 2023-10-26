Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A4EC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB6B87B0D;
	Thu, 26 Oct 2023 07:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oJVzt6qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDAB87B18; Thu, 26 Oct 2023 07:31:40 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12BD87B0F
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so58912a12.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298296; x=1698903096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rIcLEYEWKO2skUJC4f8/vOUI8ckO6+/lqe/F/PC0jQ=;
 b=oJVzt6qpzdJN2+Wek6bbrFmXNLvUw2xaP2V32vgOxaMZJLpQ4GnsQkCzc6nxDZ7t8m
 uHktIExV4Ibe18+cTnn/PMXCCyTk9H/zkaDkHorzLF1HHE49ew/ndL99RxHEdFX4/+iQ
 Jj8QXMhcC3DxFTg70Jw3j9J4Ve5m9JXJClyTxVsVPjnrA434p9xfCLV5Oj25M48feM9D
 wPr56c4u6kCaUrn9CDaXQhjZeftVKoJ4obJ+ls07iFac+noHkomJ/neHpO7z9VbYI3Kv
 LDNYRJiX0U9mGj9YNn4s4hIpC7tZsfyVSt5h5pA1u+5G3mqxqIhzNbcrFjMzlXo4U1Ed
 ptqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298296; x=1698903096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rIcLEYEWKO2skUJC4f8/vOUI8ckO6+/lqe/F/PC0jQ=;
 b=WuQ3rXcsJq9yyCMbG1l6jM11RqC4Aj2bls5dSiYZoHh+zUzbY9PYA+rXvLSgq+awQx
 ABhPObd+t31NZLhsss4RUNlPmz0b/+NKhgB83HG3P4FHCU/B0+1WevB7AuM4AYFKPOnW
 2+BWk1iaEWG+rbX1XUPGgUaAylQ3ZWSjBi7PVg8OuLVrTDyekqKvkbJVINNbBQXsyEIe
 X4ddmTm0ANk+TWwFhZYJHBdOnSD96yaoiSf521Xwm6kSOYTthtRLXQXgXVoDLwerZ+JD
 HSMP/XB+babZhfPCjPPrhCMvzCaXqfHJWSXSRBun6rMbVlAstjLEnr//IWtxmAfR6z/x
 92dg==
X-Gm-Message-State: AOJu0Yzo9JzOtIG1eKJxv2px+jjF/DpsyfKp0OlwMF3ZaXRQ+F8CWWyO
 mf5VRqlISzfAPo6CW33Y8tS1Ow==
X-Google-Smtp-Source: AGHT+IG3HDjH/SIPFnSeXvrqLUz78BbCuujDtXvGrHsneI8YJwksZOtwPkEQj5nO+PLLjPLtfTM33g==
X-Received: by 2002:a05:6a00:26dd:b0:6b2:51a0:e1c9 with SMTP id
 p29-20020a056a0026dd00b006b251a0e1c9mr17701119pfw.1.1698298295635; 
 Wed, 25 Oct 2023 22:31:35 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:35 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 07/13] bootmeth: use efi_loader interfaces instead of bootefi
 command
Date: Thu, 26 Oct 2023 14:30:46 +0900
Message-Id: <20231026053052.622453-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

Now that efi_loader subsystem provides interfaces that are equivalent
with bootefi command, we can replace command invocations with APIs.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 boot/Kconfig            |  4 ++--
 boot/Makefile           |  2 +-
 boot/bootm_os.c         | 31 +++++++------------------------
 boot/bootmeth_efi.c     |  8 +-------
 boot/bootmeth_efi_mgr.c |  3 ++-
 cmd/Kconfig             |  2 +-
 test/boot/bootflow.c    |  2 +-
 7 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index fabf6fec2195..a441fac8ade1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -511,7 +511,7 @@ config BOOTMETH_EXTLINUX_PXE
 
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
-	depends on CMD_BOOTEFI
+	depends on BOOTEFI_BOOTMGR
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
@@ -546,7 +546,7 @@ config BOOTMETH_DISTRO
 	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
 	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
 	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
-	select BOOTMETH_EFILOADER if CMD_BOOTEFI # E.g. Ubuntu uses this
+	select BOOTMETH_EFILOADER if BOOTEFI_BOOTMGR # E.g. Ubuntu uses this
 
 config SPL_BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded (SPL)"
diff --git a/boot/Makefile b/boot/Makefile
index 3fd048bb41ab..4eaa5eab4b77 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) += bootmeth_efi_mgr.o
+obj-$(CONFIG_BOOTEFI_BOOTMGR) += bootmeth_efi_mgr.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 9c035b5be886..029baac478ae 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -494,7 +494,6 @@ static int do_bootm_efi(int flag, int argc, char *const argv[],
 			struct bootm_headers *images)
 {
 	int ret;
-	efi_status_t efi_ret;
 	void *image_buf;
 
 	if (flag != BOOTM_STATE_OS_GO)
@@ -505,37 +504,21 @@ static int do_bootm_efi(int flag, int argc, char *const argv[],
 	if (ret)
 		return ret;
 
-	/* Initialize EFI drivers */
-	efi_ret = efi_init_obj_list();
-	if (efi_ret != EFI_SUCCESS) {
-		printf("## Failed to initialize UEFI sub-system: r = %lu\n",
-		       efi_ret & ~EFI_ERROR_MASK);
-		return 1;
-	}
+	/* We expect to return */
+	images->os.type = IH_TYPE_STANDALONE;
 
-	/* Install device tree */
-	efi_ret = efi_install_fdt(images->ft_len
-				  ? images->ft_addr : EFI_FDT_USE_INTERNAL);
-	if (efi_ret != EFI_SUCCESS) {
-		printf("## Failed to install device tree: r = %lu\n",
-		       efi_ret & ~EFI_ERROR_MASK);
-		return 1;
-	}
+	image_buf = map_sysmem(images->ep, images->os.image_len);
 
 	/* Run EFI image */
 	printf("## Transferring control to EFI (at address %08lx) ...\n",
 	       images->ep);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-	/* We expect to return */
-	images->os.type = IH_TYPE_STANDALONE;
-
-	image_buf = map_sysmem(images->ep, images->os.image_len);
+	ret = efi_binary_run(image_buf, images->os.image_len,
+			     images->ft_len
+			     ? images->ft_addr : EFI_FDT_USE_INTERNAL);
 
-	efi_ret = efi_run_image(image_buf, images->os.image_len);
-	if (efi_ret != EFI_SUCCESS)
-		return 1;
-	return 0;
+	return ret;
 }
 #endif
 
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index ae936c8daa18..2a9f29f9db5a 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -412,7 +412,6 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	ulong kernel, fdt;
-	char cmd[50];
 	int ret;
 
 	kernel = env_get_hex("kernel_addr_r", 0);
@@ -441,12 +440,7 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 		fdt = env_get_hex("fdt_addr_r", 0);
 	}
 
-	/*
-	 * At some point we can add a real interface to bootefi so we can call
-	 * this directly. For now, go through the CLI, like distro boot.
-	 */
-	snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
-	if (run_command(cmd, 0))
+	if (efi_binary_run(map_sysmem(kernel, 0), 0, map_sysmem(fdt, 0)))
 		return log_msg_ret("run", -EINVAL);
 
 	return 0;
diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index e9d973429f75..f2b47fac190f 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -14,6 +14,7 @@
 #include <bootmeth.h>
 #include <command.h>
 #include <dm.h>
+#include <efi_loader.h>
 
 /**
  * struct efi_mgr_priv - private info for the efi-mgr driver
@@ -70,7 +71,7 @@ static int efi_mgr_boot(struct udevice *dev, struct bootflow *bflow)
 	int ret;
 
 	/* Booting is handled by the 'bootefi bootmgr' command */
-	ret = run_command("bootefi bootmgr", 0);
+	ret = efi_bootmgr_run(EFI_FDT_USE_INTERNAL);
 
 	return 0;
 }
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 825a41d68aad..81e959c96207 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -274,7 +274,7 @@ config CMD_BOOTMETH
 
 config BOOTM_EFI
 	bool "Support booting UEFI FIT images"
-	depends on CMD_BOOTEFI && CMD_BOOTM && FIT
+	depends on BOOTEFI_BOOTMGR && CMD_BOOTM && FIT
 	default y
 	help
 	  Support booting UEFI FIT images via the bootm command.
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f5b2059140ac..47c552a94165 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -374,7 +374,7 @@ static int bootflow_system(struct unit_test_state *uts)
 {
 	struct udevice *bootstd, *dev;
 
-	if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR))
+	if (!IS_ENABLED(CONFIG_BOOTEFI_BOOTMGR))
 		return -EAGAIN;
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_efi_mgr),
-- 
2.34.1

