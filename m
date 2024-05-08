Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7999C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 11:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B42F88393;
	Wed,  8 May 2024 13:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BWcxzvvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A53088427; Wed,  8 May 2024 13:24:24 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F2F870AB
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 13:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-602801ea164so2926238a12.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715167460; x=1715772260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GjM3dnQaLwO6IdvZcSjpMlgvXpYtiVSIK43UDVe4/Ac=;
 b=BWcxzvvlpu9Jgs1arNdjLzNT2l2zptmUs2bs8mM2mIFCjG04ITLG2+T+L0PGFsHhwa
 O3DaILHmJD1aUefYf6Jt09T1XQIx7LlyydHkzB5/mYyH1o2tIDT01mOZakRTtUfjEs5p
 OAD/byCaO2UICUQ28l2xnfDM2Wexn55vSWHMEkH4fcaZKQ+Wsmr+IKUokHab1Za7dHxq
 u8u0AV9vHHfRMZBBmzGuJ27Nb/eJ8VWvdF3X1j3bOQK25/znBArU2NTSNNymIGERrJup
 H5XEhOCPtP86XgmGU/fDERNMxIS/o6oDclnaRWHLmOISEHi6dznwXPM86lYFBMZawp6r
 6uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715167460; x=1715772260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GjM3dnQaLwO6IdvZcSjpMlgvXpYtiVSIK43UDVe4/Ac=;
 b=r0GullpOQJU9VizAgCv4VJHxIPOg0y8498SXcwpUOq17IhYDS65ulNIH0kyaDdVkiv
 zIUQoMljjaWe40HGp+XORmKmg9Iw+yiA3DmhOiUDJfZzmDZ/h06fw1xiSDeE+nx5Vj4K
 TprRx78s6rYCA7a72PMqU6gFXhNdSSQgV8wX+kNijmZUfozoJg1JwFNFwKoFeXLRHX3X
 2pX0fAm9l6iWo46I1y0rS6uy4iq/ZhTxdRrJs+0/gyeW4/k9ULEeqxWzpimLedLaKSSe
 ZJZ8x8mxgYwIcghUeXrXrQkk1UefUIE3ooeBxlwYRndHENv6SheRL5umA9A4hTA14jli
 DRpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeoP5X8ZkrNzA+CvjlLYMA7C4BxZm+lOOYG0gSD/eXj/DUSElWUISfrOve1eoETAMxfgcYDoq8O7uO4t8LPaABY/0dOw==
X-Gm-Message-State: AOJu0Yy1nt+FWCe60SSnxsMelrPCjZdTcRyGhriq9xgKxKW09S1X1VaU
 edW6EKNhsDflVwscinJwoJ57GI4uGjT6utVY3bU6iN4VaCo3db35
X-Google-Smtp-Source: AGHT+IFK93VcuC9U2COoiqCMwIA+v1vHlzNRIU4ooNV3nOgTqALZEsDSk/O7gp9jzQCJYMatXPHzOA==
X-Received: by 2002:a05:6a20:1019:b0:1af:cf63:3742 with SMTP id
 adf61e73a8af0-1afcf633926mr276947637.42.1715167459826; 
 Wed, 08 May 2024 04:24:19 -0700 (PDT)
Received: from ownia.localdomain (vps-bd302c4a.vps.ovh.ca.
 [2402:1f00:8000:800::34b0]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001ec5cbd4af5sm11600081plg.305.2024.05.08.04.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 04:24:19 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: capsule: detect possible ESP device path
Date: Wed,  8 May 2024 19:24:01 +0800
Message-Id: <20240508112401.155528-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
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

When using CapsuleApp to execute on-disk update, it will choose the
first boot option as BootNext entry to perform the capsule update after
a reboot. But auto-generate boot option will ignore the logical
partition which might be an ESP, thus it could not find the capsule
file.

Align with the EDK II, detect the possible ESP device path by expanding
the media path.

Fixes: f86fba8adbf3 ("efi_loader: auto-generate boot option for each blkio device")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 include/efi_loader.h          |   6 ++
 lib/efi_loader/efi_boottime.c |  15 ++---
 lib/efi_loader/efi_capsule.c  | 110 +++++++++++++++++++++++++++++++++-
 3 files changed, 118 insertions(+), 13 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9600941aa327..9d78fa936701 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -683,6 +683,12 @@ efi_status_t efi_protocol_open(struct efi_handler *handler,
 			       void **protocol_interface, void *agent_handle,
 			       void *controller_handle, uint32_t attributes);
 
+/* Connect drivers to controller */
+efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
+					   efi_handle_t *driver_image_handle,
+					   struct efi_device_path *remain_device_path,
+					   bool recursive);
+
 /* Install multiple protocol interfaces */
 efi_status_t EFIAPI
 efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...);
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 1951291747cd..2c86d78208b2 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -103,12 +103,6 @@ static efi_status_t EFIAPI efi_disconnect_controller(
 					efi_handle_t driver_image_handle,
 					efi_handle_t child_handle);
 
-static
-efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
-					   efi_handle_t *driver_image_handle,
-					   struct efi_device_path *remain_device_path,
-					   bool recursive);
-
 /* Called on every callback entry */
 int __efi_entry_check(void)
 {
@@ -3670,11 +3664,10 @@ static efi_status_t efi_connect_single_controller(
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_connect_controller(
-			efi_handle_t controller_handle,
-			efi_handle_t *driver_image_handle,
-			struct efi_device_path *remain_device_path,
-			bool recursive)
+efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
+					   efi_handle_t *driver_image_handle,
+					   struct efi_device_path *remain_device_path,
+					   bool recursive)
 {
 	efi_status_t r;
 	efi_status_t ret = EFI_NOT_FOUND;
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index de0d49ebebda..919e3cba071b 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(struct efi_device_path *dp)
 	return true;
 }
 
+/**
+ * get_esp_from_boot_option_file_path - get the expand device path
+ *
+ * Get a possible efi system partition by expanding a boot option
+ * file path.
+ *
+ * @boot_dev	The device path pointing to a boot option
+ * Return:	The full ESP device path or NULL if fail
+ */
+static struct efi_device_path *get_esp_from_boot_option_file_path(struct efi_device_path *boot_dev)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	efi_handle_t handle;
+	struct efi_device_path *dp = boot_dev;
+	struct efi_device_path *full_path = NULL;
+
+	ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
+					      &dp,
+					      &handle));
+	if (ret != EFI_SUCCESS)
+		ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &dp, &handle));
+
+	/* Expand Media Device Path */
+	if (ret == EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {
+		struct efi_device_path *temp_dp;
+		struct efi_block_io *block_io;
+		void *buffer;
+		efi_handle_t *simple_file_system_handle;
+		efi_uintn_t number_handles, index;
+		u32 size;
+		u32 temp_size;
+
+		temp_dp = boot_dev;
+		ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
+						      &temp_dp,
+						      &handle));
+		/*
+		 * For device path pointing to simple file system, it only expands to one
+		 * full path
+		 */
+		if (ret == EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, END)) {
+			if (device_is_present_and_system_part(temp_dp))
+				return temp_dp;
+		}
+
+		/*
+		 * For device path only pointing to the removable device handle, try to
+		 * search all its children handles
+		 */
+		ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &temp_dp, &handle));
+		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
+
+		/* Align with edk2, issue a dummy read to the device to check the device change */
+		ret = EFI_CALL(efi_handle_protocol(handle, &efi_block_io_guid, (void **)&block_io));
+		if (ret == EFI_SUCCESS) {
+			buffer = memalign(block_io->media->io_align, block_io->media->block_size);
+			if (buffer) {
+				ret = EFI_CALL(block_io->read_blocks(block_io,
+								     block_io->media->media_id,
+								     0,
+								     block_io->media->block_size,
+								     buffer));
+				free(buffer);
+			} else {
+				return full_path;
+			}
+		} else {
+			return full_path;
+		}
+
+		/* detect the default boot file from removable media */
+		size = efi_dp_size(boot_dev) - sizeof(struct efi_device_path);
+		EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
+						  &efi_simple_file_system_protocol_guid,
+						  NULL,
+						  &number_handles,
+						  &simple_file_system_handle));
+		for (index = 0; index < number_handles; index++) {
+			EFI_CALL(efi_handle_protocol(simple_file_system_handle[index],
+						     &efi_guid_device_path,
+						     (void **)&temp_dp));
+
+			log_debug("Search ESP %pD\n", temp_dp);
+			temp_size = efi_dp_size(temp_dp) - sizeof(struct efi_device_path);
+			if (size <= temp_size && !memcmp(temp_dp, boot_dev, size)) {
+				if (device_is_present_and_system_part(temp_dp)) {
+					efi_free_pool(simple_file_system_handle);
+					return temp_dp;
+				}
+			}
+		}
+
+		if (simple_file_system_handle)
+			efi_free_pool(simple_file_system_handle);
+	}
+
+	return full_path;
+}
+
 /**
  * find_boot_device - identify the boot device
  *
@@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
 	int i, num;
 	struct efi_simple_file_system_protocol *volume;
 	struct efi_device_path *boot_dev = NULL;
+	struct efi_device_path *full_path = NULL;
 	efi_status_t ret;
 
 	/* find active boot device in BootNext */
@@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
 			if (device_is_present_and_system_part(boot_dev)) {
 				goto found;
 			} else {
-				efi_free_pool(boot_dev);
-				boot_dev = NULL;
+				full_path = get_esp_from_boot_option_file_path(boot_dev);
+				if (full_path) {
+					boot_dev = full_path;
+					goto found;
+				} else {
+					efi_free_pool(boot_dev);
+					boot_dev = NULL;
+				}
 			}
 		}
 	}
-- 
2.40.1

