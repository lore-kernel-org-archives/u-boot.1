Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDBDE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBACD803C6;
	Wed, 11 Dec 2024 14:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oC1ReQgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08596800C2; Wed, 11 Dec 2024 14:55:09 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A998033A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-844ce6d0716so51440239f.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925305; x=1734530105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7GFQGiDl1Wa3u+ycwRm/yk4J20HKx3i7XCdOafiVXQ=;
 b=oC1ReQgPZikMImhman3FofgivYBasSUfocG2UzCKhEnU0AhT6TkQdM9jWmP1AsrS0a
 4uqLUveaKyKmOFFoJ0kynN7D0w5P6gUJMJPXFVjUKAEejiCtUtWnOLY0jGOT0SKOJeDZ
 Z3VSd8e60BEp0XULx4la2nbH+R1WLPneK0SH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925305; x=1734530105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7GFQGiDl1Wa3u+ycwRm/yk4J20HKx3i7XCdOafiVXQ=;
 b=hISfbkKMT10JTKVVD6LfAObJe0Oyij5a1f0/BeW8Fgall3Pgvi8pwKIBlvZmqcfdEq
 ubjBKDMlTrb3sB8drldh95GSyOynFgX2ZLQ1SAypwxZXJ4pmt5sh8vcIhjaAQbv/OR58
 OGv5NybTTP9Zp06nKj0Oe1eZIDSo58kJbNiykWlSYDYBIrh4DP9+QtdcwqxG2DoL5Ra8
 OQw2tuL7GGgTHi0AemJTxrL3wAdbJ7rUBBgp2z0TlZTX2/QRPY6dWey50MR2USTlzcgj
 c+F2dBHT6v62pUxWL0KiEYyo6+jzPLcP1D6ZErEvnVmi2rnR6rKfdKSJibEklup2ChHo
 4TXw==
X-Gm-Message-State: AOJu0Yzp4reayLCaN0JCC1VNWVy+jf/Y8qddcZ0/I6HOhLCr9aVctZLN
 pswyJ1mBSq0EegHMEh97ZbbewHsZrDUJtSUYYxTevduYIQhYuNR64UuxqE3bs0FXkNON8ZsTocY
 =
X-Gm-Gg: ASbGncvjKhjEXTdtJ/60cJ3Q9nN/3/RjT6FIfpeQBBHfCzMMNlTDzk+nRjY40n0xTmw
 O/HaF60uL971T9NFM9nf46J/R1ApK0BGfI2F8j4xlq0ab0NU1wl2tjVNL2SSXJEMoskMTHF+Mkw
 sjdDTy6iDDEH5JQS2Tf5GDEBL5E4SqUscGrumdDOQyLDKz/rxVxlDiVVG4ISbovR5BzIUF9joge
 KI9cwFeCgW/0oPqnkcZnopCP6HUFzZxxnxONrSEL0xEsuXF1eq+uNssS3iY8zntqEz1vMhP9BF1
 gdmRwBYptWVqe4w=
X-Google-Smtp-Source: AGHT+IFlEkUjNbROqUjoBYzicZiJQxjEuku5xD2mEtYeI1Ayx70ykwqqrcuKsyGs19JZ5nFvXEvuNg==
X-Received: by 2002:a05:6602:3416:b0:844:c98e:b1ad with SMTP id
 ca18e2360f4ac-844cb6a9722mr380139339f.15.1733925304856; 
 Wed, 11 Dec 2024 05:55:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:55:03 -0800 (PST)
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
Subject: [PATCH v5 23/23] efi_loader: Simplify efi_dp_from_mem()
Date: Wed, 11 Dec 2024 06:54:17 -0700
Message-Id: <20241211135418.563803-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

Changes in v5:
- Drop the enum / mem_type patch as it is not needed
- Drop the patch to remove extra brackets in efi_mem_carve_out()

Changes in v3:
- Add comment to struct efi_device_path_memory
- Use a pointer for the values in struct efi_device_path_memory

Changes in v2:
- Drop patch 'Convert efi_get_memory_map() to return pointers'
- Drop patch 'efi_loader: Make more use of ulong'
- Significantly expand and redirect the series

 include/efi_api.h                | 10 ++++++++++
 include/efi_loader.h             |  3 +--
 lib/efi_loader/efi_bootbin.c     |  3 +--
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_device_path.c | 16 ++++++++--------
 5 files changed, 21 insertions(+), 13 deletions(-)

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
index 9143471c1ce..1e5a067deca 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -918,8 +918,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
-struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
-					uint64_t start_address,
+struct efi_device_path *efi_dp_from_mem(uint32_t mem_type, void *start_ptr,
 					size_t size);
 /* Determine the last device path node that is not the end node. */
 const struct efi_device_path *efi_dp_last_node(
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
index ee387e1dfd4..75745214501 100644
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
@@ -975,8 +976,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 }
 
 /* Construct a device-path for memory-mapped image */
-struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
-					uint64_t start_address,
+struct efi_device_path *efi_dp_from_mem(uint32_t memory_type, void *start_ptr,
 					size_t size)
 {
 	struct efi_device_path_memory *mdp;
@@ -991,8 +991,8 @@ struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 	mdp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MEMORY;
 	mdp->dp.length = sizeof(*mdp);
 	mdp->memory_type = memory_type;
-	mdp->start_address = start_address;
-	mdp->end_address = start_address + size;
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

