Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AF6C54E60
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A8A87F4F;
	Tue, 12 Mar 2024 16:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h5IBtASe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47CF87E49; Tue, 12 Mar 2024 13:57:37 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9252587D6F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=colinmca242@gmail.com
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7c8d3da056aso6778039f.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710248253; x=1710853053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ8GKAmxUgXQG4/cVxLujZ5xSDNNGY3TrPBEbRZK8No=;
 b=h5IBtASed3aoafFQ2cPZyPiRixZuNi7ms9yq8FvKIRbHX3KyVC6xuo+hCuehv5p8Zi
 62g4ecEWjR+M9YTQXaXC4J1r0TYa7QIX5Rw13wAOi7PKGmcC4N2jdnf9eBUpRFvYr8yp
 6ynchHmM1jAmhT4rSspeUD29HpcBlYtKDq36+nDcx17ircBa3yFFPKZlKlM2Q4eQkv/T
 LSqvHOCjf1pG4E3/10tzEbv12dCOEJEWeLGu+nmirusvzGf5XOc9uWLLJ+KdPjA9a5dt
 oa4ayd2jbeGy3wI1toDThMvzbRPguG0KDUw6ODwFCtdJHfpJURHDG5VCj8xfK3Hek74+
 R7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710248253; x=1710853053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZ8GKAmxUgXQG4/cVxLujZ5xSDNNGY3TrPBEbRZK8No=;
 b=nySEME+FcWYhytX8KE4BbErmOX2t92uhVVIbgqwxpPurwN0l7otwaHeaKza/BOaLQy
 mw5iSpEep76UuQdEoY6PmCUc+fiRoZ0i4UMOq0TQ5FkinD3salGKiJUHsWFqcDQ4GY87
 FnADB7ncJgEasf9QG5gWvz735clcryXDw9jJzGAAM6UCOVktDWX9lZOCYUpBbe3dWCJh
 PC1MlUMo1KZ8xeEAe6rx9NRJNLRJXxPhXwuPWP16WaIt5pqdsQHP8QZamvS0tyKTgIFX
 eVL1BOa73jvGmrafWWfCXpe5tdblOrPXzFC2inlGYm8B9S8KUyKhRFo8+x0XTf/9mYzT
 11wg==
X-Gm-Message-State: AOJu0YzIGinuPGM8fVRpvVcszeZBdBVVibfopUFwg4B+lnUjvZFpb5rh
 Z1DEIxiRLuc3Qpjk6cIk8DcwsC5ZadjJOD7B35aCfQupvFE8pMSboqT7Pavt/cE=
X-Google-Smtp-Source: AGHT+IGvk9lZsc6PZdAWk07B35SnwfqRyLLchQQYG9EYgrlDRbdD8ct5TLbkbodyOa3lJkcrewGAmw==
X-Received: by 2002:a05:6e02:20e9:b0:365:1750:cdae with SMTP id
 q9-20020a056e0220e900b003651750cdaemr10680897ilv.27.1710248253509; 
 Tue, 12 Mar 2024 05:57:33 -0700 (PDT)
Received: from rehoboam.localdomain ([136.37.200.217])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a92d485000000b0036577b41481sm2278595ilg.73.2024.03.12.05.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 05:57:32 -0700 (PDT)
From: Colin McAllister <colinmca242@gmail.com>
To: u-boot@lists.denx.de
Cc: Colin McAllister <colin.mcallister@garmin.com>, JPEWhacker@gmail.com,
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Colin McAllister <colinmca242@gmail.com>
Subject: [PATCH v4 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
Date: Tue, 12 Mar 2024 07:57:29 -0500
Message-Id: <20240312125729.82695-3-colinmca242@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312125729.82695-1-colinmca242@gmail.com>
References: <20240312125729.82695-1-colinmca242@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Mar 2024 16:00:41 +0100
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

From: Colin McAllister <colin.mcallister@garmin.com>

Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
not actually enable the #if protected code in android_ab.c. This is
because "CONFIG_" should have been prepended to the config macro, or the
macros defined in kconfig.h could have been used.

The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
longer be conditionally compiled by preprocessor conditionals and
instead use C conditionals. This better aligns with the Linux kernel
style guide.

Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Colin McAllister <colinmca242@gmail.com>
---
v2:
  - Replaced #if conditionals with C if conditionals
  - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
    macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
	boolean or tristate value and doesn't have different values when
	building SPL or TPL.
v3:
  - Added "Fixes:" tag
v4:
  - No changes

 boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 9a3d15ec60..f547aa64e4 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -187,13 +187,12 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 		   bool dec_tries)
 {
 	struct bootloader_control *abc = NULL;
+	struct bootloader_control *backup_abc = NULL;
 	u32 crc32_le;
 	int slot, i, ret;
 	bool store_needed = false;
+	bool valid_backup = false;
 	char slot_suffix[4];
-#if ANDROID_AB_BACKUP_OFFSET
-	struct bootloader_control *backup_abc = NULL;
-#endif
 
 	ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
 	if (ret < 0) {
@@ -205,53 +204,49 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 		return ret;
 	}
 
-#if ANDROID_AB_BACKUP_OFFSET
-	ret = ab_control_create_from_disk(dev_desc, part_info, &backup_abc,
-					  ANDROID_AB_BACKUP_OFFSET);
-	if (ret < 0) {
-		free(abc);
-		return ret;
+	if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
+		ret = ab_control_create_from_disk(dev_desc, part_info, &backup_abc,
+						  CONFIG_ANDROID_AB_BACKUP_OFFSET);
+		if (ret < 0) {
+			free(abc);
+			return ret;
+		}
 	}
-#endif
 
 	crc32_le = ab_control_compute_crc(abc);
 	if (abc->crc32_le != crc32_le) {
 		log_err("ANDROID: Invalid CRC-32 (expected %.8x, found %.8x),",
 			crc32_le, abc->crc32_le);
-#if ANDROID_AB_BACKUP_OFFSET
-		crc32_le = ab_control_compute_crc(backup_abc);
-		if (backup_abc->crc32_le != crc32_le) {
-			log_err("ANDROID: Invalid backup CRC-32 ");
-			log_err("expected %.8x, found %.8x),",
-				crc32_le, backup_abc->crc32_le);
-#endif
-
-			log_err("re-initializing A/B metadata.\n");
+		if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
+			crc32_le = ab_control_compute_crc(backup_abc);
+			if (backup_abc->crc32_le != crc32_le) {
+				log_err(" ANDROID: Invalid backup CRC-32 ");
+				log_err("(expected %.8x, found %.8x),",
+					crc32_le, backup_abc->crc32_le);
+			} else {
+				valid_backup = true;
+				log_info(" copying A/B metadata from backup.\n");
+				memcpy(abc, backup_abc, sizeof(*abc));
+			}
+		}
 
+		if (!valid_backup) {
+			log_err(" re-initializing A/B metadata.\n");
 			ret = ab_control_default(abc);
 			if (ret < 0) {
-#if ANDROID_AB_BACKUP_OFFSET
-				free(backup_abc);
-#endif
+				if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+					free(backup_abc);
 				free(abc);
 				return -ENODATA;
 			}
-#if ANDROID_AB_BACKUP_OFFSET
-		} else {
-			/*
-			 * Backup is valid. Copy it to the primary
-			 */
-			memcpy(abc, backup_abc, sizeof(*abc));
 		}
-#endif
 		store_needed = true;
 	}
 
 	if (abc->magic != BOOT_CTRL_MAGIC) {
 		log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
-#if ANDROID_AB_BACKUP_OFFSET
-		free(backup_abc);
-#endif
+		if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+			free(backup_abc);
 		free(abc);
 		return -ENODATA;
 	}
@@ -259,9 +254,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 	if (abc->version > BOOT_CTRL_VERSION) {
 		log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
 			abc->version);
-#if ANDROID_AB_BACKUP_OFFSET
-		free(backup_abc);
-#endif
+		if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+			free(backup_abc);
 		free(abc);
 		return -ENODATA;
 	}
@@ -338,30 +332,29 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 		abc->crc32_le = ab_control_compute_crc(abc);
 		ret = ab_control_store(dev_desc, part_info, abc, 0);
 		if (ret < 0) {
-#if ANDROID_AB_BACKUP_OFFSET
-			free(backup_abc);
-#endif
+			if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+				free(backup_abc);
 			free(abc);
 			return ret;
 		}
 	}
 
-#if ANDROID_AB_BACKUP_OFFSET
-	/*
-	 * If the backup doesn't match the primary, write the primary
-	 * to the backup offset
-	 */
-	if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
-		ret = ab_control_store(dev_desc, part_info, abc,
-				       ANDROID_AB_BACKUP_OFFSET);
-		if (ret < 0) {
-			free(backup_abc);
-			free(abc);
-			return ret;
+	if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
+		/*
+		* If the backup doesn't match the primary, write the primary
+		* to the backup offset
+		*/
+		if (memcmp(backup_abc, abc, sizeof(*abc)) != 0) {
+			ret = ab_control_store(dev_desc, part_info, abc,
+					       CONFIG_ANDROID_AB_BACKUP_OFFSET);
+			if (ret < 0) {
+				free(backup_abc);
+				free(abc);
+				return ret;
+			}
 		}
+		free(backup_abc);
 	}
-	free(backup_abc);
-#endif
 
 	free(abc);
 
-- 
2.34.1

