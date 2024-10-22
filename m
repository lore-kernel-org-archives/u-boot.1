Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E287D3C939
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F142588F8E;
	Tue, 22 Oct 2024 14:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hhLzoQ8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C400C892AA; Tue, 22 Oct 2024 14:00:47 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E118988EBA
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so6560416a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729598444; x=1730203244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI+nRjDslmW2Ljr5I/nJTo+p3Giei3MfIbkfguYWg4U=;
 b=hhLzoQ8WcPSAYx2JDQGzeG+dft+LYpugOfaZJfGCFmQT2Dd6P13xlB7hj3e+/wCndn
 StYuLiTQ+Zr6qy9P7s7oahygAAqLwMLj2MEFidvP8VTkvz+IJ+RmzroPABXJXELM/au0
 4Pce1mytpzCdrDyUygo1CCBwjawAaay8weSS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598444; x=1730203244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JI+nRjDslmW2Ljr5I/nJTo+p3Giei3MfIbkfguYWg4U=;
 b=jDzvNFF6ncqEAFwT+OD/a10fsdQ4/NcQa2Ii1nCjzzWSmyubD7m/oMWAtxFcgbTVAu
 i14+jbNl0wDjJew1/k/Uv2IuduN/aVbgfzNxpeG1PrtTqbXBPnk+fn5TsNEez5s68efU
 6l+mxyxZUjasY6EUHo5wQqigDmBCnMMfOE8IR6N4QoZFYSXilL1v64h+v4UMSr6RYSXL
 4Ag1jioe4Bb5lCxqT099j87T0IFop1oHZuymtZBnaeCEy4113PcsCN4bYj0TEFB8DNcZ
 RVK/Y0Xv5G7m+S2+bE6tujBISynZ8+inprrxUWBqPK6kgnArMNz3+bd8T8zsstJWbhjo
 m/sw==
X-Gm-Message-State: AOJu0YzbX+p7Jt5XGBmJ+AEFiWF0zzV2yqqQ5dJJoWqjyr3W+wEb83Qy
 S7zuofyQPrtEZWEGjDn6Wq5jDl6gIBXiH/XIF1R7DDcO4lUFFy2GfemFFpAksWUg7vU/CTVXxHB
 Hd3bZ
X-Google-Smtp-Source: AGHT+IEaTBFzygvCr5TB1S0TtZ0yaO8sKvZCf2pfdEEYDb00KrHO9Kn4VNgEhSD2yWd2RxFepltzUA==
X-Received: by 2002:a05:6402:2745:b0:5c8:845b:c4a4 with SMTP id
 4fb4d7f45d1cf-5ca0af827dcmr13836034a12.31.1729598443651; 
 Tue, 22 Oct 2024 05:00:43 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0besm3083100a12.57.2024.10.22.05.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:00:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v8 5/8] sandbox: Report host default-filename in native mode
Date: Tue, 22 Oct 2024 14:00:26 +0200
Message-ID: <20241022120032.196311-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022120032.196311-1-sjg@chromium.org>
References: <20241022120032.196311-1-sjg@chromium.org>
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

When the --native flag is given, pretend to be running the host
architecture rather than sandbox.

Add an 'efidebug filename' command to report it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v8:
- Add new patch to report host default-filename in native mode

 boot/bootmeth_efi.c | 25 ++------------------
 boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++------------
 cmd/efidebug.c      | 25 ++++++++++++++++++++
 include/efi.h       | 25 ++++++++++++++++++++
 4 files changed, 94 insertions(+), 38 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 371b36d550b..f836aa655f5 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -25,32 +25,11 @@
 
 #define EFI_DIRNAME	"/EFI/BOOT/"
 
-static int get_efi_pxe_arch(void)
-{
-	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
-	if (IS_ENABLED(CONFIG_ARM64))
-		return 0xb;
-	else if (IS_ENABLED(CONFIG_ARM))
-		return 0xa;
-	else if (IS_ENABLED(CONFIG_X86_64))
-		return 0x6;
-	else if (IS_ENABLED(CONFIG_X86))
-		return 0x7;
-	else if (IS_ENABLED(CONFIG_ARCH_RV32I))
-		return 0x19;
-	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
-		return 0x1b;
-	else if (IS_ENABLED(CONFIG_SANDBOX))
-		return 0;	/* not used */
-
-	return -EINVAL;
-}
-
 static int get_efi_pxe_vci(char *str, int max_len)
 {
 	int ret;
 
-	ret = get_efi_pxe_arch();
+	ret = efi_get_pxe_arch();
 	if (ret < 0)
 		return ret;
 
@@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	ret = get_efi_pxe_vci(str, sizeof(str));
 	if (ret)
 		return log_msg_ret("vci", ret);
-	ret = get_efi_pxe_arch();
+	ret = efi_get_pxe_arch();
 	if (ret < 0)
 		return log_msg_ret("arc", ret);
 	arch = ret;
diff --git a/boot/efi_fname.c b/boot/efi_fname.c
index a6b11383bba..790f9e2fa36 100644
--- a/boot/efi_fname.c
+++ b/boot/efi_fname.c
@@ -9,29 +9,34 @@
  */
 
 #include <efi.h>
+#include <errno.h>
 #include <host_arch.h>
 
-#ifdef CONFIG_SANDBOX
-
 #if HOST_ARCH == HOST_ARCH_X86_64
-#define BOOTEFI_NAME "BOOTX64.EFI"
+#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
+#define HOST_PXE_ARCH 0x6
 #elif HOST_ARCH == HOST_ARCH_X86
-#define BOOTEFI_NAME "BOOTIA32.EFI"
+#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
+#define HOST_PXE_ARCH 0x7
 #elif HOST_ARCH == HOST_ARCH_AARCH64
-#define BOOTEFI_NAME "BOOTAA64.EFI"
+#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
+#define HOST_PXE_ARCH 0xb
 #elif HOST_ARCH == HOST_ARCH_ARM
-#define BOOTEFI_NAME "BOOTARM.EFI"
+#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
+#define HOST_PXE_ARCH 0xa
 #elif HOST_ARCH == HOST_ARCH_RISCV32
-#define BOOTEFI_NAME "BOOTRISCV32.EFI"
+#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
+#define HOST_PXE_ARCH 0x19
 #elif HOST_ARCH == HOST_ARCH_RISCV64
-#define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
+#define HOST_PXE_ARCH 0x1b
 #else
-#error Unsupported UEFI architecture
+#error Unsupported Host architecture
 #endif
 
-#else
-
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_SANDBOX)
+#define BOOTEFI_NAME "BOOTSBOX.EFI"
+#elif defined(CONFIG_ARM64)
 #define BOOTEFI_NAME "BOOTAA64.EFI"
 #elif defined(CONFIG_ARM)
 #define BOOTEFI_NAME "BOOTARM.EFI"
@@ -47,9 +52,31 @@
 #error Unsupported UEFI architecture
 #endif
 
-#endif
-
 const char *efi_get_basename(void)
 {
-	return BOOTEFI_NAME;
+	return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
+}
+
+int efi_get_pxe_arch(void)
+{
+	if (efi_use_host_arch())
+		return HOST_PXE_ARCH;
+
+	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
+	if (IS_ENABLED(CONFIG_ARM64))
+		return 0xb;
+	else if (IS_ENABLED(CONFIG_ARM))
+		return 0xa;
+	else if (IS_ENABLED(CONFIG_X86_64))
+		return 0x6;
+	else if (IS_ENABLED(CONFIG_X86))
+		return 0x7;
+	else if (IS_ENABLED(CONFIG_ARCH_RV32I))
+		return 0x19;
+	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
+		return 0x1b;
+	else if (IS_ENABLED(CONFIG_SANDBOX))
+		return 0;	/* not used */
+
+	return -EINVAL;
 }
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index e040fe75fa1..02f1e080e88 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -511,6 +511,27 @@ static int do_efi_show_images(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+/**
+ * do_efi_show_defaults() - show UEFI default filename and PXE architecture
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ *
+ * Implement efidebug "defaults" sub-command.
+ * Shows the default EFI filename and PXE architecture
+ */
+static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
+				int argc, char *const argv[])
+{
+	printf("Default boot path: EFI\\BOOT\\%s\n", efi_get_basename());
+	printf("PXE arch: 0x%02x\n", efi_get_pxe_arch());
+
+	return CMD_RET_SUCCESS;
+}
+
 static const char * const efi_mem_type_string[] = {
 	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
 	[EFI_LOADER_CODE] = "LOADER CODE",
@@ -1561,6 +1582,8 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(dh, CONFIG_SYS_MAXARGS, 1, do_efi_show_handles,
 			 "", ""),
+	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults,
+			 "", ""),
 	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
 			 "", ""),
 	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
@@ -1653,6 +1676,8 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI drivers\n"
 	"efidebug dh\n"
 	"  - show UEFI handles\n"
+	"efidebug defaults\n"
+	"  - show default EFI filename and PXE architecture\n"
 	"efidebug images\n"
 	"  - show loaded images\n"
 	"efidebug memmap\n"
diff --git a/include/efi.h b/include/efi.h
index 1b8093bd4d3..70bb47e742f 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -678,4 +678,29 @@ void efi_show_tables(struct efi_system_table *systab);
  */
 const char *efi_get_basename(void);
 
+#ifdef CONFIG_SANDBOX
+#include <asm/state.h>
+#endif
+
+static inline bool efi_use_host_arch(void)
+{
+#ifdef CONFIG_SANDBOX
+	struct sandbox_state *state = state_get_current();
+
+	return state->native;
+#else
+	return false;
+#endif
+}
+
+/**
+ * efi_get_pxe_arch() - Get the architecture value for PXE
+ *
+ * See:
+ * http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml
+ *
+ * Return: Architecture value
+ */
+int efi_get_pxe_arch(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.43.0

