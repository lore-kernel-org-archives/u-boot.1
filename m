Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5720D6911B
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B54989D3A;
	Thu, 28 Nov 2024 16:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TX2bI6FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719FB89D3A; Thu, 28 Nov 2024 16:49:11 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1381E893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea5f158138so477187b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808945; x=1733413745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjNYaVlDFqJABuDpf46t4kEvTW7lIv/c9hBUTQLHclY=;
 b=TX2bI6FMRgU7m8RNWlIeZNLb8aFWGDVc/XYyE4KGmYMTYFSbHr9Il13qII91Ia7QGs
 eJcTOSwDw1i5B9SITRE/RcFQmIK1/yUC4OhXpD3TGwdPBn/jGBKI1Dar9UTHYFBD4LP/
 9HnrfotWzZSNwGDUgSbpya0LCieJG/Jo4sgPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808945; x=1733413745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjNYaVlDFqJABuDpf46t4kEvTW7lIv/c9hBUTQLHclY=;
 b=gjw0tZbhCJEz1yxO3h1GHc6RoM/9+owrXT/dwFkAiNt86WA4Gd32vXWJvuMxCtHFDY
 DiPCZhdqNmoVmaFI9lc53xuRKw+WLkt/3aPqZy7SOQ076ISK1u7soFh03phZCnsokc2y
 HozCClWJ32x5RS7pv9DK1xMIrLYb9syWLu20GuFwhpO2CrzAXAP8rNHKTgzUEn/k6yo3
 jyQjvJfBJ84vmH9+3lNYeE/h1F/HAzuXzGirkSeo+0Tx588evBQGHCXBPbkL6NF8WeYV
 td3sg6KAvjOoFZGe/B8eDXmbmRMNMvE1paNYk8NLgk0AJXkomMQK/zLqupevjVltKR8v
 hSsA==
X-Gm-Message-State: AOJu0YyZT0Cfz8uTYfEB1z1XlPQkFnWO72edGozpMhXCB9d96dKMidTs
 Lf4P0KHyhMS64JlZdkS5X9kqADImOlnzGr1PlECQh1ECpjbuPnStXble5BTparlxEmPpy1mlSRM
 =
X-Gm-Gg: ASbGncs8g4OzYZ99fW6O9Js8gKf9ze72pHoH3gaEAIDvXkR/V0L9udoB9VkKwOMYoUN
 XUnoxKTclfVwQ3v4q39T6bvAIk62Z2JYMrHsjS82YcnaL3S3/Q+dRPDKWSiyixG04Mml+wjsbM/
 pb/iPIW5vTQVC9TKbZ1syUtzYws1s7wOr8O0deD8Punw6xFGTAmNPPS2OefNULAQlqqihRp1V7e
 5cWyav0THlYaYrgH3DL3ggvR5w6CVnmhlQ9A89Nc31DfA==
X-Google-Smtp-Source: AGHT+IESYp/wLpaXuy+B/tcnJTHzL03sCY+LB4u6AgcQMg6l322Un5gpDvJ0L9K4keRZXM7DcP+spA==
X-Received: by 2002:a05:6808:2018:b0:3ea:6b4f:f545 with SMTP id
 5614622812f47-3ea6dd49260mr8997867b6e.28.1732808945526; 
 Thu, 28 Nov 2024 07:49:05 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:49:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 28/28] efi_loader: Simplify efi_dp_from_mem()
Date: Thu, 28 Nov 2024 08:47:27 -0700
Message-Id: <20241128154727.771871-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

Changes in v2:
- Drop patch 'Convert efi_get_memory_map() to return pointers'
- Drop patch 'efi_loader: Make more use of ulong'
- Significantly expand and redirect the series

 include/efi_loader.h             |  5 ++---
 lib/efi_loader/efi_bootbin.c     |  3 +--
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_device_path.c | 20 ++++++++++----------
 4 files changed, 14 insertions(+), 16 deletions(-)

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
index 9c8cd35b97b..025a17b19fa 100644
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
+	mdp->start_address = map_to_sysmem(start_ptr);
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

