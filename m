Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6D6C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 11:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7034287186;
	Tue, 24 Oct 2023 13:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HipT6H6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E182487186; Tue, 24 Oct 2023 13:32:47 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB278870C4
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507b9408c61so5974965e87.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698147163; x=1698751963; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zEV7+twKbIVSOsIo/ryAyQkr1WrQabwaUWb8DUXULpE=;
 b=HipT6H6yUwI3JPmg7F0obOKm2w9MgYqA1Efq+WwGcKXHNorkS5yOP7wix7muCtICJc
 o6f8drqzDZQjy5HZDuvcOcBCj9H16GUMi2yxXQHKFebEdD3OSh1QBizm0iG/DfBwODLo
 oO9SImZfADMYEOS+F5tzZbJ4yzLFMLoXoPBkHE1kIbZrIsfMQyz7S2+u9S2P+qU4PFmZ
 cfzmZio/zGxzW9gyn1PBch0+miwqWId3NucCyPhd8iOgNvBQAyoPWSIm6XAt2gZBvpcx
 lHdJNHSHqj8SZgomf4OtvZ0SBXQISWoup+nFvlwvljw5J/5to8v8vaKVbPqK9anKQo3B
 StTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698147163; x=1698751963;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEV7+twKbIVSOsIo/ryAyQkr1WrQabwaUWb8DUXULpE=;
 b=p/2pDbUYQuwjSe2xUyU06YfWoFayORD/rUqepuWCy9zdYIsxH8xG2doouW1Mt/kbEd
 u/eMdsZ4rMFvPITrBItNPVso2IveSsAb9OX6iHVUanuTmzt1qUbebrNu8yrt3OQiLtuX
 WLQrFf2mFH3RzqEQSA3rIQuAleRZ4PeSiM902UztjZ+ucfieyUiAJRLWFxEwPn8vmFMe
 kJwXzh5AwCNJQxPxlo+LfugNAq3NAgGEFD6Se2dPCg/ByNlEh+WqhXqWVqCdS+iaY6YC
 9bl8DDLNAzxgz9k3I7EmMNtwYxq50SBm+sTjtp3L+oDzeNdKxAUMTusDMWL+oQ0UoK3E
 T6xA==
X-Gm-Message-State: AOJu0YzqNwdPIQ9XfYOGVk9ofKnaRv09vRCkjsj7T4adcGaQnQYJ6Zi2
 bODdbWXXtRl4QdJaWJYDSkgj7g==
X-Google-Smtp-Source: AGHT+IHTz+ngprMFYjiDOG3j8q2MVY1WkZURlJJ08cT3Ye3ml0qcqJSkAC1Aizg42miRyAwSashF0A==
X-Received: by 2002:ac2:5594:0:b0:505:6eef:cf2d with SMTP id
 v20-20020ac25594000000b005056eefcf2dmr7937978lfg.17.1698147162857; 
 Tue, 24 Oct 2023 04:32:42 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a5d62c6000000b0032196c508e3sm9680584wrv.53.2023.10.24.04.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 04:32:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 12:32:35 +0100
Subject: [PATCH] arm: init: add an option to use FDT from previous bootloader
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFKrN2UC/x2N0QqDMAxFf0XyvLC2Fjb2K2MPrUk1sNWRiAzEf
 1/18XDu4W5grMIGj24D5VVM5trAXzoYplRHRqHGEFzovQsRc8RvG+Y3FlrQu1huTHfiSNCanIw
 xa6rDdFSzyij1+km2sB6+pUV+59/zte9/ONRa4H8AAAA=
To: Simon Glass <sjg@chromium.org>, Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=EwjlZLeF7yY/S8iRxCk/sXW9JVKKEm9ldb/zFjoaLAs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTz1VF1rmsbNB+EvZDT3vNeyXGzbruNcIfb4v6vzXIsk
 x2sTD07SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESOODEyLNKcdV2whMdAePYM
 DXbtaROWOe+IZsxSsdTfLbhwZ5LHJIb/cYzaNUViHzxe+3lWfDPfc7RllWmitc0P8WvsE5MXnrX
 4DgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a new config option to allow u-boot to reuse the FDT provided by the
previous stage bootloader when available.

On some boards the previous stage bootloader can populate
platform-specific parts of the devicetree such as the memory node, this
allows us to avoid hardcoding it in u-boot and instead determine it
dynamically at runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch will improve generic support for Qualcomm boards by enabling
us to configure the memory map at runtime rather than having hardcoded
maps on a per-device basis. I've gone for this approach initially to try
and avoid introducing board specific code where possible, but I'm happy
to rework this into mach-snapdragon if that's preferred.
---
base-commit: e65b5d35c9116485366bb08138043d51220551da

// Caleb (they/them)
---
 arch/arm/lib/save_prev_bl_data.c |  7 +++++++
 boot/Kconfig                     | 10 ++++++++++
 include/init.h                   |  9 +++++++++
 lib/fdtdec.c                     |  7 ++++++-
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index f7b23faf0d66..b0608502535e 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -45,6 +45,13 @@ bool is_addr_accessible(phys_addr_t addr)
 	return false;
 }
 
+phys_addr_t get_prev_bl_fdt_addr(void)
+{
+	if (!is_addr_accessible((phys_addr_t)reg0))
+		return 0;
+	return reg0;
+}
+
 int save_prev_bl_data(void)
 {
 	struct fdt_header *fdt_blob;
diff --git a/boot/Kconfig b/boot/Kconfig
index a01e6cb8aafe..c127ba254589 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1599,6 +1599,16 @@ config SAVE_PREV_BL_INITRAMFS_START_ADDR
 	  If no initramfs was provided by previous bootloader, no env variables
 	  will be created.
 
+config USE_PREV_BL_FDT
+	depends on SAVE_PREV_BL_FDT_ADDR && !OF_BOARD
+	bool "Use the FDT provided by the previous stage bootloader"
+	help
+	  When u-boot is chain-loaded from a previous bootloader, enable this option
+	  to use the FDT provided by the previous bootloader instead of any built-in
+	  to u-boot.
+
+	  If no FDT was available, u-boot will fall back to its internal FDT.
+
 menu "Configuration editor"
 
 config CEDIT
diff --git a/include/init.h b/include/init.h
index 4e7fe26c2004..58604cd98758 100644
--- a/include/init.h
+++ b/include/init.h
@@ -168,6 +168,15 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
  * Return: 0 if ok; -ENODATA on error
  */
 int save_prev_bl_data(void);
+
+/**
+ * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
+ * of the FDT passed by the previous bootloader.
+ *
+ * Return: the address of the FDT passed by the previous bootloader
+ * or 0 if not found.
+ */
+phys_addr_t get_prev_bl_fdt_addr(void);
 #endif
 
 /**
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 7a6916764835..85425f2dc1ee 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1222,7 +1222,7 @@ static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
  */
 static void *fdt_find_separate(void)
 {
-	void *fdt_blob = NULL;
+	void *fdt_blob = NULL, *prevbl_fdt_blob;
 
 	if (IS_ENABLED(CONFIG_SANDBOX))
 		return NULL;
@@ -1234,6 +1234,11 @@ static void *fdt_find_separate(void)
 	else
 		fdt_blob = (ulong *)__bss_end;
 #else
+#if defined(CONFIG_USE_PREV_BL_FDT)
+	prevbl_fdt_blob = (void *)get_prev_bl_fdt_addr();
+	if (prevbl_fdt_blob)
+		return prevbl_fdt_blob;
+#endif
 	/* FDT is at end of image */
 	fdt_blob = (ulong *)_end;
 

