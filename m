Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4407BD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC67893FC;
	Sun,  1 Dec 2024 16:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RACJ8INa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB692894E5; Sun,  1 Dec 2024 16:26:28 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B542896C0
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83eb38883b5so109110939f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066781; x=1733671581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsv2efYvXaeN5cURMG95WL5fCXbL7b2OX9s508MFFu0=;
 b=RACJ8INawCxgSuDwEQZxR8Lgxo/F2x/+kyPJB1S60216PxYGlxUTG8u4WLwJgWT5Ng
 4XxQAvfhuYGdw4ygIHeAytkW8JIvtVx9gk6ZE2Zv8wMsK+bVRF5NKV34B6aj2MhFc+lD
 dGi7wQBVcFOJrieLZeLFfue8vz/F2BghhRvPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066781; x=1733671581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsv2efYvXaeN5cURMG95WL5fCXbL7b2OX9s508MFFu0=;
 b=KnexTkrbGzx4sfp+HG0jTIxoFlkKSeFw6XnOPw76MiaZrkqej7TRKZDWRsUpy+x995
 WtQF2fae0VZlXMrpnp85UOWSWrVW/P6/Wf6U2nWFfdfiMjdrsc15tWSEoiqngtcRJBMG
 jW/j7coARRXYU2sV4lnoCMfPSMYiaD34pq/jb16oPFicYLeVgb9GmVEExvuyj3BZW3dL
 n6LMkZLMOopd4s7wsSDzAn/3ai+eVePn90F8QkEz3HsTLi2mu2X8cSb/dRVBp6yuN0UL
 pyMFiWZWUFdHiRomI3zevcHmq+4ZRcumAlmBtW3U2fIbwVLPSuhdt0A/nKKiJxdktUXG
 O2gQ==
X-Gm-Message-State: AOJu0YwpAEnnsZpah2M3RpYJN0TK0pY5oQwlKAb4+vaCBLPap7P0nLfZ
 b2FR2D4av1PenJ0jGvy3SvWbIRQFIT1kH4qXArpmqLrLCoW4Ph9BJAbielilmXZPb1U+p+dU11g
 =
X-Gm-Gg: ASbGnct5GCNfx/sfGmdXhCfGkTd+rpom70Bkgbb83hSFOqLMhrQ7JrnLm2qPr9Q7MOf
 41K0mDMFRSax59ZAkwOIuXEsqOZ82Nax5fy4ap7ocdQJgyRW7R6r8fOAPJdCWbSX4eDzNRVv6m+
 4Gzxa2K0C4ejkuUIbWt1q1i6YWRRESLGGKXkVL9MvJ7B0EK/B9bTm0aDPRtKB4Lj1RvTUlQ00+A
 TkjLFk5e+WPn0P2J/9/ojTBOTaFnHnHcYyJYSfXT+Hb
X-Google-Smtp-Source: AGHT+IFtEexLhRIGLfGWR8UgrNcYf9FzreekiALiFNlFuJMtuv2xxvnGwm4f2Bum64XyY8MUZ2/pRw==
X-Received: by 2002:a05:6602:2dcc:b0:843:f261:60e0 with SMTP id
 ca18e2360f4ac-843f26163f0mr1772575039f.5.1733066781310; 
 Sun, 01 Dec 2024 07:26:21 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 25/25] efi_loader: Simplify efi_dp_from_mem()
Date: Sun,  1 Dec 2024 08:24:44 -0700
Message-ID: <20241201152505.1666789-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

This function should take a pointer, not an address. Update it along
with all users.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add comment to struct efi_device_path_memory
- Use a pointer for the values in struct efi_device_path_memory

Changes in v2:
- Drop patch 'Convert efi_get_memory_map() to return pointers'
- Drop patch 'efi_loader: Make more use of ulong'
- Significantly expand and redirect the series

 include/efi_api.h                | 10 ++++++++++
 include/efi_loader.h             |  5 ++---
 lib/efi_loader/efi_bootbin.c     |  3 +--
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_device_path.c | 20 ++++++++++----------
 5 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index f07d074f93b..f7da915b0e4 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -573,6 +573,16 @@ struct efi_mac_addr {
 #  define DEVICE_PATH_SUB_TYPE_VENDOR		0x04
 #  define DEVICE_PATH_SUB_TYPE_CONTROLLER	0x05
 
+/**
+ * struct efi_device_path_memory - 'Memory Mapped Device Path' object
+ *
+ * @dp: header for device-path protocol
+ * @memory_type: see enum efi_memory_type
+ * @start_address: start address of the memory; note that this is provided to
+ *	the EFI application so must be a pointer cast to u64
+ * @end_address: end address of the memory; note that this is provided to
+ *	the EFI application so must be a pointer cast to u64
+ */
 struct efi_device_path_memory {
 	struct efi_device_path dp;
 	u32 memory_type;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 4e34e1caede..1269907fa3c 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -919,9 +919,8 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
-struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
-					uint64_t start_address,
-					size_t size);
+struct efi_device_path *efi_dp_from_mem(enum efi_memory_type  mem_type,
+					void *start_ptr, size_t size);
 /* Determine the last device path node that is not the end node. */
 const struct efi_device_path *efi_dp_last_node(
 			const struct efi_device_path *dp);
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a87006b3c0e..7e7a6bf31aa 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -136,8 +136,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 		 * loaded directly into memory via JTAG, etc:
 		 */
 		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    (uintptr_t)source_buffer,
-					    source_size);
+					    source_buffer, source_size);
 		/*
 		 * Make sure that device for device_path exist
 		 * in load_image(). Otherwise, shell and grub will fail.
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 98799aead84..e3b8dfb6013 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -515,7 +515,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		 * will be freed in return_to_efibootmgr event callback.
 		 */
 		loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    image_addr, image_size);
+					    source_buffer, image_size);
 		ret = efi_install_multiple_protocol_interfaces(
 			&mem_handle, &efi_guid_device_path, loaded_dp, NULL);
 		if (ret != EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 9c8cd35b97b..5a93e10fb8e 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/root.h>
 #include <log.h>
+#include <mapmem.h>
 #include <net.h>
 #include <usb.h>
 #include <mmc.h>
@@ -975,9 +976,8 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 }
 
 /* Construct a device-path for memory-mapped image */
-struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
-					uint64_t start_address,
-					size_t size)
+struct efi_device_path *efi_dp_from_mem(enum efi_memory_type  memory_type,
+					void *start_ptr, size_t size)
 {
 	struct efi_device_path_memory *mdp;
 	void *buf, *start;
@@ -990,9 +990,9 @@ struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
 	mdp->dp.type = DEVICE_PATH_TYPE_HARDWARE_DEVICE;
 	mdp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MEMORY;
 	mdp->dp.length = sizeof(*mdp);
-	mdp->memory_type = mem_type;
-	mdp->start_address = start_address;
-	mdp->end_address = start_address + size;
+	mdp->memory_type = memory_type;
+	mdp->start_address = (uintptr_t)start_ptr;
+	mdp->end_address = mdp->start_address + size;
 	buf = &mdp[1];
 
 	*((struct efi_device_path *)buf) = END;
@@ -1061,7 +1061,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 	struct efi_device_path *dp;
 	struct disk_partition fs_partition;
 	size_t image_size;
-	void *image_addr;
+	void *image_ptr;
 	int part = 0;
 
 	if (path && !file)
@@ -1070,10 +1070,10 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 	if (IS_ENABLED(CONFIG_EFI_BINARY_EXEC) &&
 	    (!strcmp(dev, "Mem") || !strcmp(dev, "hostfs")))  {
 		/* loadm command and semihosting */
-		efi_get_image_parameters(&image_addr, &image_size);
+		efi_get_image_parameters(&image_ptr, &image_size);
 
-		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-				     (uintptr_t)image_addr, image_size);
+		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, image_ptr,
+				     image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
 		dp = efi_dp_from_eth();
 	} else if (!strcmp(dev, "Uart")) {
-- 
2.43.0

