Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD43FCFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 08:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C1183CF3;
	Tue,  2 Dec 2025 09:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nt9FepwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995C383DE0; Tue,  2 Dec 2025 09:51:18 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D73F83C39
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 09:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso58311555e9.3
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 00:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764665474; x=1765270274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ERVFdYrDPLWMh3HNkdZW3LsDNl0KDysi/f7WviCxZe0=;
 b=nt9FepwPkMiDOUOJtkWCVZcG5VVMspshPVgJfUR2k42FD5BrdRhzxtMJC+C38+MyNr
 MuLLFp5hyVnnNat8KUfxS9Z4aucTMCNEDxtqhe/itiBsjH2gLiMJ9uVWahDQoS2/S0Bk
 4gc2x2bEysvtdCQe2gVx87WEgZ9ZxVp7Ohqlt8jWpuXwNsDPKynYtuSKbPnBU4RYmRDm
 A1A6YkumqHsL6qtSXwBlPt9ZJzmlaOK183Ex4tdWRD0TCQ1XscL//yFdvHbzxdzPTSyM
 3nE97mw7rUA8bFP73aAokSrQjc1eTdthmZxqqbpI+aZf78/rFy8SW9Wbn6WeTCGvCZ4w
 oCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764665475; x=1765270275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERVFdYrDPLWMh3HNkdZW3LsDNl0KDysi/f7WviCxZe0=;
 b=coIeOQLPY3G7eGu549+3QQDS8go9j7nBYvqNxylYTOPiwQ0/2fihOkMKcgX3aoY9Ct
 Z0yyHci5AIDUzvnQy7iGMA7xsbUzOCXEzAQexJnxaSFFlw0J3nsUJvgZ9CWuSMEVE0t9
 S57IOWXy4GgXTjnFNKPxvrvy+yHNPjD7gm+m+caSpGn7oy2rPjCcgH6cAz4evbMxUIa6
 aia2Ss7V3b/DRrewVf5YsOLPVRJ03PbjPTMJOCsuvkzFmuMHW12+rr87GY30dweew96r
 SRkzEPGl4VI4bzhwLI1AjL3HrFRUHu9Z07ZQv8d5L00q5teYHxbi4RQUbHa+7pUELujw
 aN5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLhC5J0VrPXoMTOU3xwTmewzAvmGnbw/AVvgLxWtieCz7Fe4gyYZXtw5zAQNqJgxY3Jp6q2VI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj2HW6SsL20Pa6bdSex12N3ZGTFEledpcjCD7iH3oPCJUodslK
 D4+Fb5UJ86nR2+cnsxbI9YzJQ2xVMGWj8157uqFMq/7jzhTfk3SkWz0XYzKTgNpfE08=
X-Gm-Gg: ASbGncvurQblpT4a6p0FApAtsPb+rJtY7mFi/tPIB2YIY8RBRY24f5Bndu4WJAvW3Ba
 3UlscPYnhpDq1e3HKYQDPvtCUKSPB+Xes/tENyKBGeo3rGUK0ivqhm/XZvKEek980KTNhxZZ02d
 oHsPb4vjcgxnx34XSqJ5k8cpeq1g/VOVjgnRDX5Abx8LdQTpOrHs92M5ohBGNxkZNBdZUCrM8C6
 jtlSwJyqk5RTICcd+Fq4YxQ+E+SKUsdlhz9RO8Sve6ZxS3FZjKQCo7Cos2ctwkG4gyrIt7iysLX
 WlGin6YryH5dbq6HgG60clmCFr8/VjSpjw23cpKDSFz48TrJU2mXNXc697KBaSqdOBi67WWbZwV
 1KTL2qLTdLXd6JIQB+Fgm4n0zplV5VlBMC5fNshjizfYO4367ppQcWjuDnsqhYlcCeryQkq1cZp
 RL1k8MAlV1MyTtwrrO9ONPnPSoV12vR/g5k7fDcDu3VvnR6Yar1cnMANcGDtN1hg//zE/vbrPny
 FsUjwzkSeaSluAAXRB1Ci8O7F4=
X-Google-Smtp-Source: AGHT+IHZcn7TMLy5ILYxedL9FUqpbbSR1uXUJqmIQmvffBf+NDxgFYeiOteuktDpUhRchFtqPFqBhQ==
X-Received: by 2002:a05:600c:1c20:b0:477:9d54:58d7 with SMTP id
 5b1f17b1804b1-477c1131d60mr444666145e9.29.1764665474529; 
 Tue, 02 Dec 2025 00:51:14 -0800 (PST)
Received: from hera ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4791163e3dasm288959535e9.11.2025.12.02.00.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 00:51:13 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Yao Zi <ziyao@disroot.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Trigger capsule updates with automatically
 generated boot options
Date: Tue,  2 Dec 2025 10:50:58 +0200
Message-ID: <20251202085101.1344799-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

John, Balaji, can you check if this fixes your problem?

 cmd/eficonfig.c                  |  2 +-
 include/efi_device_path.h        | 10 +++---
 lib/efi_loader/efi_bootmgr.c     |  6 ++--
 lib/efi_loader/efi_boottime.c    |  5 +--
 lib/efi_loader/efi_capsule.c     | 20 +++++++-----
 lib/efi_loader/efi_device_path.c | 55 +++++++++++++++++++++++++-------
 lib/efi_loader/efi_disk.c        |  2 +-
 7 files changed, 70 insertions(+), 30 deletions(-)

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
index aae85228f681..f9c538730c94 100644
--- a/include/efi_device_path.h
+++ b/include/efi_device_path.h
@@ -73,13 +73,15 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
  *
  * If @rem is provided, the handle with the longest partial match is returned.
  *
- * @dp:     device path to search
- * @guid:   GUID of protocol that must be installed on path or NULL
- * @rem:    pointer to receive remaining device path
+ * @dp:			device path to search
+ * @guid:		GUID of protocol that must be installed on path or NULL
+ * @rem:		pointer to receive remaining device path
+ * @inversed_match:	Match even if the dp is shorter. rem will stil hoild the
+ *                      remaining device path
  * Return:  matching handle
  */
 efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_guid_t *guid,
-			     struct efi_device_path **rem);
+			     struct efi_device_path **rem, bool inversed_match);

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
index eafc647f558f..103328c76a6e 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -886,18 +886,18 @@ static efi_status_t get_dp_device(u16 *boot_var,
  * @dp		device path
  * Return:	true - yes, false - no
  */
-static bool device_is_present_and_system_part(struct efi_device_path *dp)
+static bool device_is_present_and_system_part(struct efi_device_path *dp,
+					      struct efi_device_path **rem)
 {
 	efi_handle_t handle;
-	struct efi_device_path *rem;

 	/* Check device exists */
-	handle = efi_dp_find_obj(dp, NULL, NULL);
+	handle = efi_dp_find_obj(dp, NULL, NULL, false);
 	if (!handle)
 		return false;

 	/* Check device is on system partition */
-	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
+	handle = efi_dp_find_obj(dp, &efi_system_partition_guid, rem, true);
 	if (!handle)
 		return false;

@@ -919,7 +919,7 @@ static efi_status_t find_boot_device(void)
 	efi_uintn_t size;
 	int i, num;
 	struct efi_simple_file_system_protocol *volume;
-	struct efi_device_path *boot_dev = NULL;
+	struct efi_device_path *boot_dev = NULL, *rem = NULL;
 	efi_status_t ret;

 	/* find active boot device in BootNext */
@@ -940,7 +940,7 @@ static efi_status_t find_boot_device(void)

 		ret = get_dp_device(boot_var16, &boot_dev);
 		if (ret == EFI_SUCCESS) {
-			if (device_is_present_and_system_part(boot_dev)) {
+			if (device_is_present_and_system_part(boot_dev, &rem)) {
 				goto found;
 			} else {
 				efi_free_pool(boot_dev);
@@ -967,7 +967,7 @@ skip:
 		if (ret != EFI_SUCCESS)
 			continue;

-		if (device_is_present_and_system_part(boot_dev))
+		if (device_is_present_and_system_part(boot_dev, &rem))
 			break;

 		efi_free_pool(boot_dev);
@@ -977,7 +977,11 @@ found:
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
index b3fb20b2501e..ad7f452c411b 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -30,6 +30,12 @@ const struct efi_device_path EFI_DP_END = {
 	.length   = sizeof(EFI_DP_END),
 };

+enum match {
+	EXACT,
+	SHORTER,
+	LONGER
+};
+
 #if defined(CONFIG_MMC)
 /*
  * Determine if an MMC device is an SD card.
@@ -109,10 +115,11 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
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

@@ -137,22 +144,35 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
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
@@ -160,14 +180,25 @@ static efi_handle_t find_handle(struct efi_device_path *dp,

 efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
 			     const efi_guid_t *guid,
-			     struct efi_device_path **rem)
+			     struct efi_device_path **rem, bool inversed_match)
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
+	if (inversed_match && !handle) {
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
2.51.0

