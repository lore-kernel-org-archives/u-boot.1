Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F26D59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B1A89A8D;
	Mon, 25 Nov 2024 21:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M0ZuBEyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120D589A8D; Mon, 25 Nov 2024 21:45:42 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD82889A94
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83eafef523bso150611839f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567538; x=1733172338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+KfB92Ul9gyoRpg+jZWy2BEFYQweKmriei6ITJcL08=;
 b=M0ZuBEyI/zurMjWbSMgUTA+RMkbQID5/OP1kFpdwLOSYgUFulO75WN4QpbZN9usMwV
 MFx3E8IY9gfL26roQELqAfLpT5biHDGcGamiLKiTYTdFR7My/mJw/dmd6Lxw4Iz9Hq8Y
 rrEvqFqOtmx5wyU+aPDqwy388jVTpdMfjKHXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567538; x=1733172338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+KfB92Ul9gyoRpg+jZWy2BEFYQweKmriei6ITJcL08=;
 b=vlbfrO19n5ZVL8XzZKaaufkRiYyMf9t7/Bi2gv5bmo0XHxAByYeh3zadiaer7WGgp4
 iOoxsvyh3BgGgUTN6Zi0pYDUK/RgOcldmVml3oNMUDaCCVYGIEBR9atfVOE37aGANo0k
 QCcymGJaJMC2nTpPlFj+oEUKJrtOZ7Uura+LM0iv8JdYZVd0u83XFj1BMSuJhENDGA4N
 mV6qw0p0KdLG9ulUJbU4dVo+T/b28w4e95MGzdSqJfyU2LRFp7R2STKW37byg5hhF76L
 Twvv6dgk9DzWewoVy8DlLCT6SWY+CrCyhUiHymvocXyUu1EBMLoD8oy1vBqyWn11wr4z
 GDNA==
X-Gm-Message-State: AOJu0YxTuBmMyxwRyfVsB5Ox9D6x7LmPmCFjYJko8xbYYaQwFnqOMhvd
 H6Rsr+96TUcyfWhYaMe/s09qf5Ctdn5rCA7bc/+q0yDRzbPlhMa/ibVUH199W64/7QlwglWswAw
 =
X-Gm-Gg: ASbGncvZnRRQR7j3eYP0o37XIR1u7sCXKRWb23LIhduCo/K0h0WSjzES2or1HcCqV2w
 3lVReeN9Mv9u7Qf9/67pbixGT6Gj4MVekHaX9umnDrsinPtTNKx9M0B3xAMpZuPkvUvX+tKcLmh
 DhiTuXYwbwcv0soRIrZpw2TQCFqTSdu7KDF6Cvc3bLBYTfxkmaqr3l6zRay5r+zBoYu85RxOyOL
 MlbHdK0NhemATwG12c82TtRienI+x+DmqfZs9D94GINYIM=
X-Google-Smtp-Source: AGHT+IFfyak45Y21DcIsQ/07EP8ek03PvOmDSiKNgJIUwtBcA1Ho6eRLVZTvRTvIvwTxsE0s4t0wqg==
X-Received: by 2002:a05:6602:6b82:b0:82c:f30d:fc72 with SMTP id
 ca18e2360f4ac-83ecdc53c49mr1675983939f.2.1732567537918; 
 Mon, 25 Nov 2024 12:45:37 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:37 -0800 (PST)
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
Subject: [PATCH 10/13] efi_loader: Simplify efi_dp_from_mem()
Date: Mon, 25 Nov 2024 13:44:49 -0700
Message-ID: <20241125204456.1525752-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

 include/efi_loader.h             |  5 ++---
 lib/efi_loader/efi_bootbin.c     |  3 +--
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_device_path.c | 20 ++++++++++----------
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index c4afcf2b60b..7f3854a2d6c 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -915,9 +915,8 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
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
index 9e42fa03921..f435c7225b9 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -515,7 +515,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		 * will be freed in return_to_efibootmgr event callback.
 		 */
 		loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    (uintptr_t)image_addr, image_size);
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
2.43.0

