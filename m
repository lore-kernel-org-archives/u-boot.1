Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D730ED70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EA889D2A;
	Thu, 28 Nov 2024 20:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XzyLpMo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B6789D22; Thu, 28 Nov 2024 20:14:05 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7246089D95
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f1ff6a2128so437464eaf.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821235; x=1733426035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhUshYojQ2NnQalF22HkZcgGxwxeb/BTYL/Vrq5UrFk=;
 b=XzyLpMo8IuhQGMgjBrSwYgzOskvRbqzm9B5EzetmNzGoJeHxbhvwbvCL4kw1iEqX6l
 vJZLdiuzsM2ywkNUUns7VP8jU5BAeorj4bjjVdtNYWvs+ZM/X/ntKtD9acUd+OLziFUh
 CZtbZIl0LVrq8f2H6KHgBJUrczvwDb4YfzOrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821235; x=1733426035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhUshYojQ2NnQalF22HkZcgGxwxeb/BTYL/Vrq5UrFk=;
 b=ungfKFv6CVOpg0MGew+Picq1mt7RCL8txnFC0akboyZBSaGxTVEeDEW68E6Fucq7mo
 BHBUy0chTWfK3S5oTorS2EKzn4cDyPYezEKvgQHngJipYxdFl0nnRD4uk6God3h0JOCO
 AwF2jnebVxjUU7OEURJcFAwlfKUXjev6s0EcsE8XJ+hapCPfU4VvdQv+lAzgXWEMtda/
 EecIFwDp0C1BNcXRuN52PK0OmOv/ajND+JB1cxfIGASjrH6cDz2NvWDdd56bSUZb6x/k
 maB+IdHZ8whRe0cja2MagTBRAFgy81xWY66MmmfxHzmC/uKcrEHnlEJSVoic4QW2KZ2T
 YkpQ==
X-Gm-Message-State: AOJu0YyA07GdHZ3LTuStOwplBAID2lB68dyeP0JZyW2bzqPxi+xkhKsJ
 P8hKOo74x3hXSR6pk5tfjOrYPs+F0I9AhCov5KqtyQCphjyYa/muHFtQYTGAOaXaAg+4+irPYa8
 =
X-Gm-Gg: ASbGncvjbet8gjmh8MPnUyYfpU0y9DOL6hD1x0hMqACKznUJd8WlFGrExDQV0Uv5FRr
 Uh7teojAgYKa+vA0fZ9jkjaO4+Km6arJONJSrtghR4iTjDK/4NxMuK35NtY7wKZUxklUjjGZYhx
 Bx4oYTHdGJkiSQtqamEGNcvadiy65u5CMMpxhK+OGFi4UusJT4l7xKa8rV6wH1szhMWRKi6w87B
 sEFOijAvn6j9FYMAS214msIk7ggLrbXKogdBVTD17tPOA==
X-Google-Smtp-Source: AGHT+IGTvCXFakDu4TdgA3oPm61XzmAnLyMX9RBxuNYyTu4Z/TbOrl68EchLU2RH3tm0GgIREfoxiQ==
X-Received: by 2002:a05:6830:410c:b0:71a:5f45:ac3f with SMTP id
 46e09a7af769-71d65c6f76cmr7508087a34.2.1732821235695; 
 Thu, 28 Nov 2024 11:13:55 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 28/28] efi_loader: Simplify efi_dp_from_mem()
Date: Thu, 28 Nov 2024 12:12:44 -0700
Message-Id: <20241128191244.900006-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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
2.34.1

