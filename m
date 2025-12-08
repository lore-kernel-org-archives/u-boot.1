Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE2ED3B7F3
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 15:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B77833C6;
	Mon,  8 Dec 2025 16:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jyjWgLRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19796838A5; Mon,  8 Dec 2025 16:15:13 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4E780433
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 16:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso29034045e9.0
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765206909; x=1765811709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NX6QbgGJ0ui5pW5lpBKvdNtRJO7lVaB2jNAiw9risps=;
 b=jyjWgLRlAj5iqOFjWtwvYbM2Au4SsojFhboI8/5KcKRHFJhgB4g5mGLvo1DqPxr5mO
 DR8LHvtx8HXOzHfYQYzthB12ic+PwljeZh++f+rZ/W+YWpckrZi7nnPsKX29XHk+cxV8
 68zMiosaaLI4mc1QKDWN8ZJV8Zn4LoZUd+dNghC/4hqbX4MRg7A3v60Qp8ZtV6RZq7rn
 ZZ5o+ym7iCpRS1f/MXDVOfqTALt8xeTIcJ9SyJTfuClUd75qiqPcxBtKmnUE5uhH703o
 98UqR2lComGbkp8Lz1BsoJYKikSIpid0fYVXj0d49ZYuUi3yC2eD/GK/u33ZT54c3SkA
 dYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765206909; x=1765811709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NX6QbgGJ0ui5pW5lpBKvdNtRJO7lVaB2jNAiw9risps=;
 b=mAiwicwAKBS2xRxBcd84BPUCCOYLMT91Ii2waRpvCSESJSv2EA00Kb2tMH2OKWY0du
 YVCEqJX0Bnmk5CqhDe1imjnhqmo0bfcaPCLJbR/zx8bOusI/Fsfs4JATOg0VT9DqH4i2
 5HFz18fBfcFDPFP0TXgNcXqELAsNLKwQj6HTEH6KyNI/66wjtl7u781+o3bDSQB42KbV
 PO9msHOAnDIcIVyQ6jcvodQNqsivJdp0iA+MFlQyUJKmp3NGSIAtzNy/svlQZPqOXXI6
 X/sOhRsLQElobLXkV8NqsstjDYxfGDAZeDan5RZfvuij8wdecsKuc3QkTh9I/KSL6kz9
 TNUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYL7n5G05ELk9v8qCRs/3segLoPitJK8MVxQB1DW9Ba1+MAtU8M7um/Pvnr/7zVGPlmtoYdrs=@lists.denx.de
X-Gm-Message-State: AOJu0YxJUOI64IPVHaw6Qp09Kzr+w8oC9u4B/mV3c4VwWdNiFGkNdI9o
 BUO/Ovdb8frbSKMNNjoJNOhp7EY7zo5/d8ticq3G9McOhFnVks0tPxBYR0KND2MOA4A=
X-Gm-Gg: ASbGncvK4sEv8MvnmK2keH0KwOfpX51K0EkOTGNtxV7+6bvKeRqRhDYX3E3Dh1r2THp
 HyYdRASzD3RMqKWkCzwPuBfJ5ghtSpzBHAEF5/7b2QJzmNWFme9ni5RHO7ghQ0i8b/gzvQZtimZ
 Z68STWqli/y+qSY6Koad9syLybMDI899NnHz+hmfMW6BAkOBHuwFozmsT0j/bXyC3fSP1Sn3bom
 zv0fKjHya1rCnOW2y6LH7/Os6FGEBk4Ce1/j7Nn892nqBz6MTMiCs+VQq9WoL7bzyR5cHxVhpv1
 lykYnMSSJITVEHQBk4yJwhvPqgxxDyWJ9daN2p2SRbD5opFplpHpwVcVtxc+9lgr8N2I6cB+QRX
 B45McSwdFph3UaV2YYHSFpvDNwhiZmyOdmKQJeAD+Ym2szPigZKGMIQKwMiLu/ybZxQQU1Lovdx
 VNCANpk81HJcfDmrhv9jeDYicDUH3T+u9WEqWGrKV+n3ime6uv30UR8IEpkezyX+yom9XC15ZNs
 Hg15Al/Vzw/BWjBLHPIg7TyKG71Qg==
X-Google-Smtp-Source: AGHT+IFHiomxzRa4HTvj582uAbp7hrNTNEi1wKQDopiB/t39hH+l2RNeOdTHaPdo0BpcrKz0JacMzw==
X-Received: by 2002:a05:600c:1388:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-47939df12a9mr83105755e9.3.1765206908876; 
 Mon, 08 Dec 2025 07:15:08 -0800 (PST)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d353f75sm26420337f8f.42.2025.12.08.07.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 07:15:08 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Javier Tia <javier.tia@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Yao Zi <ziyao@disroot.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maks Mishin <maks.mishinfz@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: Trigger capsule updates with automatically
 generated boot options
Date: Mon,  8 Dec 2025 17:14:56 +0200
Message-ID: <20251208151503.1681988-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The EFI spec in §8.5.5 says
"The directory \EFI\UpdateCapsule is checked for capsules only within
 the EFI system partition on the device specified in the active boot
 option determine by reference to BootNext variable or BootOrder variable
 processing."

Automatically generated boot options don't point to the ESP, they point to
the disk itself and find_handle() won't match when searching for an ESP
during a capsule update.
This happens because find_handle() only matches device paths that are
shorter or equal to the device path passed as an argument.
Since the EFI spec allows it we want to allow capsule updates, when the
boot option points to a disk, but that disk contains an ESP with a
\EFI\UpdateCapsule  directory.

find_handle() implicitly changes it's behavior depending on the passed
arguments as well. If the 'rem' ptr is not valid it will only search for
an exact match. Otherwise it will match on the best match and return the
remaining portion of the matched device path to 'rem'.

Tweak this slightly and pass an enum with 3 options
- EXACT   - Exact match, as if 'rem' was NULL
- SHORTER - Match a shorter device path and put the remainder in 'rem'
- LONGER  - Inverse the logic and match a longer device path. Put the
            remainder into 'rem'.

To avoid any regressions, LONGER is only used during capsule updates and
since 'rem' always carries the remainder of the matched device path we
can plug it in with minimal changes.

Reported-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reported-by: John Toomey <john.toomey@amd.com>
Tested-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- Fixed the function descriptions
- renamed device_is_present_and_system_part() to device_has_esp to
  better match the updated functionality

 cmd/eficonfig.c                  |  2 +-
 include/efi_device_path.h        | 21 ++++++++---
 lib/efi_loader/efi_bootmgr.c     |  6 ++--
 lib/efi_loader/efi_boottime.c    |  5 +--
 lib/efi_loader/efi_capsule.c     | 29 +++++++++------
 lib/efi_loader/efi_device_path.c | 62 +++++++++++++++++++++++++-------
 lib/efi_loader/efi_disk.c        |  2 +-
 7 files changed, 94 insertions(+), 33 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index d8d946c87ac8..e317f3c90c14 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -1321,7 +1321,7 @@ static efi_status_t prepare_file_selection_entry(struct efimenu *efi_menu, char
 		return EFI_OUT_OF_RESOURCES;

 	/* get the device name only when the user already selected the file path */
-	handle = efi_dp_find_obj(file_info->dp_volume, NULL, NULL);
+	handle = efi_dp_find_obj(file_info->dp_volume, NULL, NULL, false);
 	if (handle) {
 		ret = efi_disk_get_device_name(handle, devname, EFICONFIG_VOLUME_PATH_MAX);
 		if (ret != EFI_SUCCESS)
diff --git a/include/efi_device_path.h b/include/efi_device_path.h
index aae85228f681..ffff93f64833 100644
--- a/include/efi_device_path.h
+++ b/include/efi_device_path.h
@@ -71,15 +71,28 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
 /**
  * efi_dp_find_obj() - find handle by device path
  *
+ * if @match_longer is false, the function will only search for device
+ * paths that are either an exact match or shorter than the provided device
+ * path.
+ * if @match_longer is true it will also match device paths that are longer
+ * that the provided device path.
+ * The function searches and matches DPs in this order:
+ * - Try to find an exact match
+ * - Try to find a device path that's shorter than the provided one
+ * - Try to find a device path that's longer than the provided one
+ *
  * If @rem is provided, the handle with the longest partial match is returned.
  *
- * @dp:     device path to search
- * @guid:   GUID of protocol that must be installed on path or NULL
- * @rem:    pointer to receive remaining device path
+ * @dp:			device path to search
+ * @guid:		GUID of protocol that must be installed on path or NULL
+ * @rem:		pointer to receive remaining device path
+ * @match_longer:	match even if the provided dp is shorter. @rem will
+ *                      still hold the remaining device path if specified
+ *
  * Return:  matching handle
  */
 efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_guid_t *guid,
-			     struct efi_device_path **rem);
+			     struct efi_device_path **rem, bool match_longer);

 /**
  * efi_dp_last_node() - Determine the last device path node before the end node
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a687f4d8e85c..df7500a94876 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -84,7 +84,8 @@ struct efi_device_path *expand_media_path(struct efi_device_path *device_path)
 	 * booting from removable media.
 	 */
 	handle = efi_dp_find_obj(device_path,
-				 &efi_simple_file_system_protocol_guid, &rem);
+				 &efi_simple_file_system_protocol_guid, &rem,
+				 false);
 	if (handle) {
 		if (rem->type == DEVICE_PATH_TYPE_END) {
 			char fname[30];
@@ -625,7 +626,8 @@ static efi_status_t try_load_from_media(struct efi_device_path *file_path,
 	struct efi_device_path *rem, *dp = NULL;
 	struct efi_device_path *final_dp = file_path;

-	handle_blkdev = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
+	handle_blkdev = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem,
+					false);
 	if (handle_blkdev) {
 		if (rem->type == DEVICE_PATH_TYPE_END) {
 			/* no file name present, try default file */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ddc935d22409..0391b92a8be4 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1816,7 +1816,8 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 	info->system_table = &systab;

 	if (device_path) {
-		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
+		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL,
+						      false);

 		dp = efi_dp_concat(device_path, file_path, 0);
 		if (!dp) {
@@ -2016,7 +2017,7 @@ efi_status_t efi_load_image_from_path(bool boot_policy,
 	*size = 0;

 	dp = file_path;
-	device = efi_dp_find_obj(dp, NULL, &rem);
+	device = efi_dp_find_obj(dp, NULL, &rem, false);
 	ret = efi_search_protocol(device, &efi_simple_file_system_protocol_guid,
 				  NULL);
 	if (ret == EFI_SUCCESS)
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 31b47a20186e..bd40ef5f57c4 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -887,26 +887,26 @@ static efi_status_t get_dp_device(u16 *boot_var,
 }

 /**
- * device_is_present_and_system_part - check if a device exists
+ * device_has_esp - check if an ESP exists on a device or partition
  *
  * Check if a device pointed to by the device path, @dp, exists and is
- * located in UEFI system partition.
+ * either located in or contains a UEFI system partition.
  *
  * @dp		device path
  * Return:	true - yes, false - no
  */
-static bool device_is_present_and_system_part(struct efi_device_path *dp)
+static bool device_has_esp(struct efi_device_path *dp,
+			   struct efi_device_path **rem)
 {
 	efi_handle_t handle;
-	struct efi_device_path *rem;

 	/* Check device exists */
-	handle = efi_dp_find_obj(dp, NULL, NULL);
+	handle = efi_dp_find_obj(dp, NULL, NULL, false);
 	if (!handle)
 		return false;

-	/* Check device is on system partition */
-	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
+	/* Check device is on system partition or contains one */
+	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, rem, true);
 	if (!handle)
 		return false;

@@ -918,6 +918,9 @@ static bool device_is_present_and_system_part(struct efi_device_path *dp)
  *
  * Identify the boot device from boot-related variables as UEFI
  * specification describes and put its handle into bootdev_root.
+ * The function iterates through the active boot options, including
+ * the one defined in BootNext and tries to detect if an ESP is
+ * present on the disk or partition of the disk defined in the boot entry.
  *
  * Return:	status code
  */
@@ -928,7 +931,7 @@ static efi_status_t find_boot_device(void)
 	efi_uintn_t size;
 	int i, num;
 	struct efi_simple_file_system_protocol *volume;
-	struct efi_device_path *boot_dev = NULL;
+	struct efi_device_path *boot_dev = NULL, *rem = NULL;
 	efi_status_t ret;

 	/* find active boot device in BootNext */
@@ -949,7 +952,7 @@ static efi_status_t find_boot_device(void)

 		ret = get_dp_device(boot_var16, &boot_dev);
 		if (ret == EFI_SUCCESS) {
-			if (device_is_present_and_system_part(boot_dev)) {
+			if (device_has_esp(boot_dev, &rem)) {
 				goto found;
 			} else {
 				efi_free_pool(boot_dev);
@@ -987,7 +990,7 @@ skip:
 		if (ret != EFI_SUCCESS)
 			continue;

-		if (device_is_present_and_system_part(boot_dev))
+		if (device_has_esp(boot_dev, &rem))
 			break;

 		efi_free_pool(boot_dev);
@@ -997,7 +1000,11 @@ found:
 	if (boot_dev) {
 		log_debug("Boot device %pD\n", boot_dev);

-		volume = efi_fs_from_path(boot_dev);
+		if (rem->type == DEVICE_PATH_TYPE_END)
+			volume = efi_fs_from_path(boot_dev);
+		else
+			volume = efi_fs_from_path(rem);
+
 		if (!volume)
 			ret = EFI_DEVICE_ERROR;
 		else
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index b3fb20b2501e..e5b113c331bd 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -30,6 +30,19 @@ const struct efi_device_path EFI_DP_END = {
 	.length   = sizeof(EFI_DP_END),
 };

+/**
+ * enum match - Options for device path matching
+ *
+ * @EXACT:   Only match an identical device path
+ * @SHORTER: Match device paths that are shorter than the provided one
+ * @LONGER:  Match device paths that are longer than the provided one
+ */
+enum match {
+	EXACT,
+	SHORTER,
+	LONGER
+};
+
 #if defined(CONFIG_MMC)
 /*
  * Determine if an MMC device is an SD card.
@@ -109,10 +122,11 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
  */
 static efi_handle_t find_handle(struct efi_device_path *dp,
 				const efi_guid_t *guid, bool short_path,
-				struct efi_device_path **rem)
+				struct efi_device_path **rem,
+				enum match match)
 {
 	efi_handle_t handle, best_handle = NULL;
-	efi_uintn_t len, best_len = 0;
+	efi_uintn_t len, match_len = 0, best_len = 0;

 	len = efi_dp_instance_size(dp);

@@ -137,22 +151,35 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
 			if (!dp_current)
 				continue;
 		}
-		len_current = efi_dp_instance_size(dp_current);
-		if (rem) {
+
+		match_len = len_current = efi_dp_instance_size(dp_current);
+		switch (match) {
+		case EXACT:
+			if (len_current != len)
+				continue;
+			break;
+		case SHORTER:
 			if (len_current > len)
 				continue;
-		} else {
-			if (len_current != len)
+			break;
+		case LONGER:
+			if (len_current < len)
 				continue;
+			match_len = len;
+			break;
 		}
-		if (memcmp(dp_current, dp, len_current))
+
+		if (memcmp(dp_current, dp, match_len))
 			continue;
 		if (!rem)
 			return handle;
 		if (len_current > best_len) {
 			best_len = len_current;
 			best_handle = handle;
-			*rem = (void*)((u8 *)dp + len_current);
+			if (len_current <= len)
+				*rem = (void *)((uintptr_t)dp + len_current);
+			else
+				*rem = (void *)((uintptr_t)dp_current + match_len);
 		}
 	}
 	return best_handle;
@@ -160,14 +187,25 @@ static efi_handle_t find_handle(struct efi_device_path *dp,

 efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
 			     const efi_guid_t *guid,
-			     struct efi_device_path **rem)
+			     struct efi_device_path **rem, bool match_longer)
 {
 	efi_handle_t handle;

-	handle = find_handle(dp, guid, false, rem);
+	handle = find_handle(dp, guid, false, rem, EXACT);
 	if (!handle)
-		/* Match short form device path */
-		handle = find_handle(dp, guid, true, rem);
+		handle = find_handle(dp, guid, true, rem, EXACT);
+	if (handle)
+		return handle;
+
+	handle = find_handle(dp, guid, false, rem, SHORTER);
+	if (!handle)
+		handle = find_handle(dp, guid, true, rem, SHORTER);
+
+	if (match_longer && !handle) {
+		handle = find_handle(dp, guid, false, rem, LONGER);
+		if (!handle)
+			handle = find_handle(dp, guid, true, rem, LONGER);
+	}

 	return handle;
 }
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 130c4db9606f..0d3d7c187d72 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
 	efi_free_pool(file_path);

 	/* Get the EFI object for the partition */
-	efiobj = efi_dp_find_obj(device_path, NULL, NULL);
+	efiobj = efi_dp_find_obj(device_path, NULL, NULL, false);
 	efi_free_pool(device_path);
 	if (!efiobj)
 		return NULL;
--
2.43.0

