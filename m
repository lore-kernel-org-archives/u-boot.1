Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316ACC61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9384C875BE;
	Tue, 21 Nov 2023 02:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rk3jxiZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD4B875B9; Tue, 21 Nov 2023 02:31:36 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64ACE864F3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc2b8deb23so10682195ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530249; x=1701135049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjbRHjiZr+w34RNHzCx/XM1Riu2LAgDdjh0G8y9lKfI=;
 b=Rk3jxiZJcUvVkfiVnmqJXFAHVLezt2guSk0uaeiAGCKvTzPTRCcyh1NGOx25lRxB4C
 2jK6pfl1y21zZlNtWhEY+nd3H4kznQ1HruMPWJ+p+ZS6VAp9dlppcrnKJKJncwIxBKym
 8L8LTyt/6JuSKMvuVvuMgzdomJJ2pZzw/BAlZ0i5fHs8NYzYpVkMr9MPVdpqPLCV/sby
 ziSo1ZUWgxqBOI5xcXK4derqYRgQ/zDRkK3sf/qJjL6CDXMkzVxxiwuaSMA74T9TjX63
 SzVwhrt+udWDbiYojYBw11EaEgLp5ui9H4xOlbngGCK3CwT62Yb/E5PPOEBmVTB+rrVn
 9oYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530249; x=1701135049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjbRHjiZr+w34RNHzCx/XM1Riu2LAgDdjh0G8y9lKfI=;
 b=O+IYLp8mL0PTo7U4aqAJFjzonbwrA3SF61yrHRBhq75veBSEPle8jLMksAOkrS1LaF
 RXVIathyq2RQyUS74cTbRdEjJqAAq5VVGuoUBoWu5BXQHmy5j+AxhE4PluH51t4h+OHZ
 Dn2yzM9WQUaxO/Aedt2SdYScUrm+ucyrXcb8r258Xz7oJBBEoyQ3LFJZ58CPuje8ckQz
 onrVdwDZjlOwfJQyFx/tW0UYl+LeBUOMcCl+lQealj+3o+qzQY9dfyVC5kPSu7PhXLZC
 w4NfriV4I+h84Buhv9ktq099CKKtr5c+8JuvoUhAMZrp/dfyCiNrQQmD2H3KCK7RfSRn
 13Wg==
X-Gm-Message-State: AOJu0Yz9szaolgL7U7KQgYUd4xiGsFkRJDc/BesZ5ojesFjxj3qpdBYe
 VrVH7dbgtDs4Mbiv7cTGpiKP+A==
X-Google-Smtp-Source: AGHT+IFh78IDzjHNGXp+IAYWXdop6dMS8uI6KPh8wmwon51t7lAeF9zCR/CkbQ/E06NKGTTYWgqWuw==
X-Received: by 2002:a17:902:e74b:b0:1cc:32c6:e5fa with SMTP id
 p11-20020a170902e74b00b001cc32c6e5famr11565064plf.6.1700530249078; 
 Mon, 20 Nov 2023 17:30:49 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:48 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 08/12] bootmeth: use efi_loader interfaces instead of
 bootefi command
Date: Tue, 21 Nov 2023 10:29:46 +0900
Message-Id: <20231121012950.156539-9-takahiro.akashi@linaro.org>
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

Now that efi_loader subsystem provides interfaces that are equivalent
with bootefi command, we can replace command invocations with APIs.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 boot/Kconfig            |  4 ++--
 boot/Makefile           |  2 +-
 boot/bootm_os.c         | 31 +++++++------------------------
 boot/bootmeth_efi.c     |  8 +-------
 boot/bootmeth_efi_mgr.c |  2 +-
 cmd/Kconfig             |  2 +-
 test/boot/bootflow.c    |  2 +-
 7 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ef71883a5026..e879c63b84e3 100644
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
index 30296eb27d7d..c2f39cdf3f36 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -487,7 +487,6 @@ static int do_bootm_efi(int flag, int argc, char *const argv[],
 			struct bootm_headers *images)
 {
 	int ret;
-	efi_status_t efi_ret;
 	void *image_buf;
 
 	if (flag != BOOTM_STATE_OS_GO)
@@ -498,37 +497,21 @@ static int do_bootm_efi(int flag, int argc, char *const argv[],
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
index e6c42d41fb80..5f6f68e423e6 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -85,7 +85,7 @@ static int efi_mgr_boot(struct udevice *dev, struct bootflow *bflow)
 	int ret;
 
 	/* Booting is handled by the 'bootefi bootmgr' command */
-	ret = run_command("bootefi bootmgr", 0);
+	ret = efi_bootmgr_run(EFI_FDT_USE_INTERNAL);
 
 	return 0;
 }
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4cf9a210c4a1..dc4ea48f78bc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -273,7 +273,7 @@ config CMD_BOOTMETH
 
 config BOOTM_EFI
 	bool "Support booting UEFI FIT images"
-	depends on CMD_BOOTEFI && CMD_BOOTM && FIT
+	depends on BOOTEFI_BOOTMGR && CMD_BOOTM && FIT
 	default y
 	help
 	  Support booting UEFI FIT images via the bootm command.
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f640db8a2418..fa1bebdd02da 100644
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

