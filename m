Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74454D3C932
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2261189251;
	Tue, 22 Oct 2024 14:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XDEfjwb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8310288F4D; Tue, 22 Oct 2024 14:00:44 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7444D88969
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c94861ee25so2852622a12.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729598440; x=1730203240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwGmm8iwzbyyx/wxUS/qi5lpuro5bgSJ/kuI0eHHfXA=;
 b=XDEfjwb6CLrr6UqIuq+W0DlE7txg49DPlbX1oakAsx19NEOdbo/Ek46HFphSiaqZeE
 Y4qV7evfC5hZ6GdV12DyUPsgmjFIL666LyaOjl1q9WmJMf/L4bu4RAypm/qP3dGE+NBI
 oYBSP+HQm86GXQqhWrPKHrjNp3QYDG0CLKbBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598440; x=1730203240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwGmm8iwzbyyx/wxUS/qi5lpuro5bgSJ/kuI0eHHfXA=;
 b=qzl6FQTEOaecV33WAa7oJ5eJqXEuojOLYn3c84TO4oAd/qbJwgRBwfdptQdaF3sGrn
 z2P4AcAbPFwSNv70SMHnaiEJK6Oy2/8AFE1HuloHHnoBrm/shyqryWMUOtkXa7QrViLN
 4zMEPX6Is+pVt4KHTCP/vCKm1xuDJWPKO6/U9i5bvX1r2DoL2lUYArdIVdTmEVe3L6B/
 us3Dr2hfrVWhHDG58pA4jlL7ElfB1E2v5gmdtyg+NhN+6gFLN5/XcZAK7KvScMmRwamS
 aIHMaKpjmAjOoPprt2PlOt1fkzfXkK5N2G+AKWO3cUPEI+FsrKnAb97/3wbdR3T0nfu+
 SOIQ==
X-Gm-Message-State: AOJu0YyyiPe6gpuwbU0TDsnpazRxttJDsE6Avp479xx+eWqgKr8OwTL+
 hacr80YgAUwDo1pXhVArwaQLkuDkiAShJSg6OHCykgrHQ7o47W7z4zhr4csnFfH+U1IBOK75cGW
 V+2pV
X-Google-Smtp-Source: AGHT+IFW70j2fq8n8Ev+4ZXcKc4Q+rEGQf68uA7GEgITOCB4H4adrQETokmgQzPX72yXCsNRxj0IlA==
X-Received: by 2002:a05:6402:4409:b0:5ca:d0d:6bb7 with SMTP id
 4fb4d7f45d1cf-5ca0d0d715amr16333579a12.1.1729598439457; 
 Tue, 22 Oct 2024 05:00:39 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0besm3083100a12.57.2024.10.22.05.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:00:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v8 3/8] efi: Move default filename to a function
Date: Tue, 22 Oct 2024 14:00:24 +0200
Message-ID: <20241022120032.196311-4-sjg@chromium.org>
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

Use a function to obtain the device EFI filename, so that we can control
how sandbox behaves.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v8:
- Add new patch to move default filename to a function

 boot/Makefile                                      |  4 +++-
 boot/bootmeth_efi.c                                |  4 ++--
 include/efi_default_filename.h => boot/efi_fname.c | 11 +++++------
 include/efi.h                                      |  9 +++++++++
 lib/efi_loader/efi_bootmgr.c                       | 10 +++++++---
 test/boot/bootflow.c                               |  6 +++---
 6 files changed, 29 insertions(+), 15 deletions(-)
 rename include/efi_default_filename.h => boot/efi_fname.c (93%)

diff --git a/boot/Makefile b/boot/Makefile
index b24f806d5bf..d3f2c02068c 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
-obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o efi_fname.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
@@ -40,6 +40,8 @@ obj-$(CONFIG_$(PHASE_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootflow_menu.o
 endif
 
+obj-$(CONFIG_EFI_LOADER) += efi_fname.o
+
 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdt_support.o
 obj-$(CONFIG_$(PHASE_)FDT_SIMPLEFB) += fdt_simplefb.o
 
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 2ad6d3b4ace..371b36d550b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -13,7 +13,7 @@
 #include <bootmeth.h>
 #include <command.h>
 #include <dm.h>
-#include <efi_default_filename.h>
+#include <efi.h>
 #include <efi_loader.h>
 #include <fs.h>
 #include <malloc.h>
@@ -168,7 +168,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	}
 
 	strcpy(fname, EFI_DIRNAME);
-	strcat(fname, BOOTEFI_NAME);
+	strcat(fname, efi_get_basename());
 
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
diff --git a/include/efi_default_filename.h b/boot/efi_fname.c
similarity index 93%
rename from include/efi_default_filename.h
rename to boot/efi_fname.c
index 77932984b55..a6b11383bba 100644
--- a/include/efi_default_filename.h
+++ b/boot/efi_fname.c
@@ -8,13 +8,9 @@
  * Copyright (c) 2022, Linaro Limited
  */
 
-#ifndef _EFI_DEFAULT_FILENAME_H
-#define _EFI_DEFAULT_FILENAME_H
-
+#include <efi.h>
 #include <host_arch.h>
 
-#undef BOOTEFI_NAME
-
 #ifdef CONFIG_SANDBOX
 
 #if HOST_ARCH == HOST_ARCH_X86_64
@@ -53,4 +49,7 @@
 
 #endif
 
-#endif
+const char *efi_get_basename(void)
+{
+	return BOOTEFI_NAME;
+}
diff --git a/include/efi.h b/include/efi.h
index 84640cf7b25..1b8093bd4d3 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -669,4 +669,13 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
  */
 void efi_show_tables(struct efi_system_table *systab);
 
+/**
+ * efi_get_basename() - Get the default filename to use when loading
+ *
+ * E.g. this returns BOOTAA64.EFI for an aarch target
+ *
+ * Return: Default EFI filename
+ */
+const char *efi_get_basename(void);
+
 #endif /* _LINUX_EFI_H */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a3aa2b8d1b9..cb9664c91a2 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -11,10 +11,10 @@
 #include <blkmap.h>
 #include <charset.h>
 #include <dm.h>
+#include <efi.h>
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
-#include <efi_default_filename.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <asm/unaligned.h>
@@ -82,8 +82,12 @@ struct efi_device_path *expand_media_path(struct efi_device_path *device_path)
 				 &efi_simple_file_system_protocol_guid, &rem);
 	if (handle) {
 		if (rem->type == DEVICE_PATH_TYPE_END) {
-			full_path = efi_dp_from_file(device_path,
-						     "/EFI/BOOT/" BOOTEFI_NAME);
+			char fname[30];
+
+			snprintf(fname, sizeof(fname), "/EFI/BOOT/%s",
+				 efi_get_basename());
+			full_path = efi_dp_from_file(device_path, fname);
+
 		} else {
 			full_path = efi_dp_dup(device_path);
 		}
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index cc894e804a4..539abe63ebe 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -12,7 +12,7 @@
 #include <bootstd.h>
 #include <cli.h>
 #include <dm.h>
-#include <efi_default_filename.h>
+#include <efi.h>
 #include <expo.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
@@ -184,8 +184,8 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
 	ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
-	ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/"
-			   BOOTEFI_NAME);
+	ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/%s",
+			   efi_get_basename());
 
 	ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
 	ut_assert_skip_to_line(
-- 
2.43.0

