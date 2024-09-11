Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05AFEE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7431F88B0A;
	Wed, 11 Sep 2024 23:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="tt3Jv7Nn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 103D388BDB; Wed, 11 Sep 2024 23:50:04 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F263788A74
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8000E10002A;
 Thu, 12 Sep 2024 00:49:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8000E10002A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726091395;
 bh=44Xp5E2RuQIq+PXRSv49fDW7CEv45vgw17G2fnW5gps=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=tt3Jv7NngxVGi+VjFIxfFxCDe5cyW42tjWySLVyOjykTvnbXNmAthYdMBsLyN9I0Z
 mV2zxKV6hCGLX7N+rlColBpyKCesH7ae5BRaLzL5w4OzJWvwce43p7bSox4InNCZ51
 wOQ+1Qa++ke26lIhF6gKoYl5Ou1MdNrNqkzOPVi6n6vntp1BmJghaH+5aVelMncINl
 IQgMi3m/9D/VytLRs1TTL9kHIu3WjgxLQf3h4aLd500l6aTVyMIg/2KXCI53hw/F92
 XrYdlH8tNsOHAYZMM1L2l2e7GgCLnZL0459Fyrax8voShXOrEPojilBYmw5LfPtRdf
 hFdczTL2+1vbw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 00:49:55 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 1/6] include/android_ab: move ab_select_slot()
 documentation to @ notation
Date: Thu, 12 Sep 2024 00:49:09 +0300
Message-ID: <20240911214945.15873-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911214945.15873-1-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.192.196]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/11 19:25:00 #26555689
X-KSMG-AntiVirus-Status: Clean, skipped
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

There are new function documentation requirements in U-Boot, so apply
these changes for android_ab.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c    | 43 ++++++++++++++++++++++++-------------------
 include/android_ab.h |  7 ++++---
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 1196a189ed53..0045c8133a8e 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -13,13 +13,13 @@
 #include <u-boot/crc.h>
 
 /**
- * Compute the CRC-32 of the bootloader control struct.
+ * ab_control_compute_crc() - Compute the CRC32 of the bootloader control.
+ *
+ * @abc: Bootloader control block
  *
  * Only the bytes up to the crc32_le field are considered for the CRC-32
  * calculation.
  *
- * @param[in] abc bootloader control block
- *
  * Return: crc32 sum
  */
 static uint32_t ab_control_compute_crc(struct bootloader_control *abc)
@@ -28,14 +28,14 @@ static uint32_t ab_control_compute_crc(struct bootloader_control *abc)
 }
 
 /**
- * Initialize bootloader_control to the default value.
+ * ab_control_default() - Initialize bootloader_control to the default value.
+ *
+ * @abc: Bootloader control block
  *
  * It allows us to boot all slots in order from the first one. This value
  * should be used when the bootloader message is corrupted, but not when
  * a valid message indicates that all slots are unbootable.
  *
- * @param[in] abc bootloader control block
- *
  * Return: 0 on success and a negative on error
  */
 static int ab_control_default(struct bootloader_control *abc)
@@ -67,7 +67,13 @@ static int ab_control_default(struct bootloader_control *abc)
 }
 
 /**
- * Load the boot_control struct from disk into newly allocated memory.
+ * ab_control_create_from_disk() - Load the boot_control from disk into memory.
+ *
+ * @dev_desc: Device where to read the boot_control struct from
+ * @part_info: Partition in 'dev_desc' where to read from, normally
+ *             the "misc" partition should be used
+ * @abc: pointer to pointer to bootloader_control data
+ * @offset: boot_control struct offset
  *
  * This function allocates and returns an integer number of disk blocks,
  * based on the block size of the passed device to help performing a
@@ -75,10 +81,6 @@ static int ab_control_default(struct bootloader_control *abc)
  * The boot_control struct offset (2 KiB) must be a multiple of the device
  * block size, for simplicity.
  *
- * @param[in] dev_desc Device where to read the boot_control struct from
- * @param[in] part_info Partition in 'dev_desc' where to read from, normally
- *			the "misc" partition should be used
- * @param[out] pointer to pointer to bootloader_control data
  * Return: 0 on success and a negative on error
  */
 static int ab_control_create_from_disk(struct blk_desc *dev_desc,
@@ -122,15 +124,17 @@ static int ab_control_create_from_disk(struct blk_desc *dev_desc,
 }
 
 /**
- * Store the loaded boot_control block.
+ * ab_control_store() - Store the loaded boot_control block.
+ *
+ * @dev_desc: Device where we should write the boot_control struct
+ * @part_info: Partition on the 'dev_desc' where to write
+ * @abc Pointer to the boot control struct and the extra bytes after
+ *      it up to the nearest block boundary
+ * @offset: boot_control struct offset
  *
  * Store back to the same location it was read from with
  * ab_control_create_from_misc().
  *
- * @param[in] dev_desc Device where we should write the boot_control struct
- * @param[in] part_info Partition on the 'dev_desc' where to write
- * @param[in] abc Pointer to the boot control struct and the extra bytes after
- *                it up to the nearest block boundary
  * Return: 0 on success and a negative on error
  */
 static int ab_control_store(struct blk_desc *dev_desc,
@@ -160,12 +164,13 @@ static int ab_control_store(struct blk_desc *dev_desc,
 }
 
 /**
- * Compare two slots.
+ * ab_compare_slots() - Compare two slots.
+ *
+ * @a: The first bootable slot metadata
+ * @b: The second bootable slot metadata
  *
  * The function determines slot which is should we boot from among the two.
  *
- * @param[in] a The first bootable slot metadata
- * @param[in] b The second bootable slot metadata
  * Return: Negative if the slot "a" is better, positive of the slot "b" is
  *         better or 0 if they are equally good.
  */
diff --git a/include/android_ab.h b/include/android_ab.h
index dbf20343da62..1e53879a25f1 100644
--- a/include/android_ab.h
+++ b/include/android_ab.h
@@ -18,7 +18,10 @@ struct disk_partition;
 #define NUM_SLOTS 2
 
 /**
- * Select the slot where to boot from.
+ * ab_select_slot() - Select the slot where to boot from.
+ *
+ * @dev_desc: Place to store the device description pointer
+ * @part_info: Place to store the partition information
  *
  * On Android devices with more than one boot slot (multiple copies of the
  * kernel and system images) selects which slot should be used to boot from and
@@ -28,8 +31,6 @@ struct disk_partition;
  * registered before returning from this function so it isn't selected
  * indefinitely.
  *
- * @param[in] dev_desc Place to store the device description pointer
- * @param[in] part_info Place to store the partition information
  * Return: The slot number (>= 0) on success, or a negative on error
  */
 int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
-- 
2.43.0

