Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECB7CEFC56
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 20:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00EDA88FBD;
	Tue,  8 Oct 2024 22:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="tBwQHTvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3814688F85; Tue,  8 Oct 2024 22:18:32 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D13F88F83
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 22:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id A9E02120013;
 Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A9E02120013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1728418705;
 bh=+4tZBmh/lI9DtMyRTXGOJq7dc4yav+xdOXy2/odWiWQ=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=tBwQHTvHBmGXFb+HU7oOH+nv9UkQIjEIw/gfHqbnDjd9htQbafy4q21Wotl9Iv/99
 Vb+UfXjO9vRYAQx11+5QBm6ywxn6cA+HJNpfUNB0iXjY2KKDASSODVjl6ZbO1SfuXS
 gKRXHiu8d3Qvs7uktkJyX8MW5+yc5YgnFP8cRuLzU4MxaY9Vu5nuEIS2AFwYFrsm2k
 TfdRakAp5DfLOW2Aseyo/Bvor8hhR5vn9oJC/dP+T97bNxKgKfAKO38W6ra9QV5DBP
 IDJihigquZV8/X9xDiaNItrMPfEg9dzuf7m1lB1GdFfV+FgnlPyDZWNmY7N+Sqn1lv
 HIl/n0sFjHD0w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  8 Oct 2024 23:18:25 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Tue, 8 Oct 2024 23:18:08 +0300
Subject: [PATCH v3 5/6] common: android_ab: fix slot suffix for abc block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241008-android_ab_master-v3-5-f292c45a33e4@salutedevices.com>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
In-Reply-To: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>, 
 <kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728418704; l=1671;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=208R8dtiyg8qmtHsgLhfoLZrx5Xoo4J1Dsl1h2eWiZI=;
 b=+1PA7KbScsmA0dXlTFv1yg3gsifzdd94jACbHHRkCbgrpvG9IC9AoIZHpTQEZqlLFXHw0izrt
 fKipYv7up5PAGE1/yoXevKx45zl4KN4EWwUwpkg9M9P4gns+BhsBUAM
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.129.94]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188309 [Oct 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39
 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 android-review.googlesource.com:7.1.1,5.0.1; source.android.com:7.1.1,5.0.1;
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/08 14:31:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/08 14:31:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/10/08 14:43:00 #26717371
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

To align with the official Android BCB (Bootloader Control Block)
specifications, it's important to note that the slot_suffix should start
with an underscore symbol.

For a comprehensive understanding of the expected slot_suffix format in
userspace, please refer to the provided reference [1].

Links:
[1] - https://source.android.com/docs/core/architecture/bootloader/updating#slots

Based-on: https://android-review.googlesource.com/c/platform/external/u-boot/+/1446439
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/android_ab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index c93e51541019d0fe793303c4b3d5286df061906f..a287eac04fe88ad08bdcf1b1b1d6e564d503d800 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -52,7 +52,7 @@ static int ab_control_default(struct bootloader_control *abc)
 	if (!abc)
 		return -EFAULT;
 
-	memcpy(abc->slot_suffix, "a\0\0\0", 4);
+	memcpy(abc->slot_suffix, "_a\0\0", 4);
 	abc->magic = BOOT_CTRL_MAGIC;
 	abc->version = BOOT_CTRL_VERSION;
 	abc->nb_slot = NUM_SLOTS;
@@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 		 * or the device tree.
 		 */
 		memset(slot_suffix, 0, sizeof(slot_suffix));
-		slot_suffix[0] = BOOT_SLOT_NAME(slot);
+		slot_suffix[0] = '_';
+		slot_suffix[1] = BOOT_SLOT_NAME(slot);
 		if (memcmp(abc->slot_suffix, slot_suffix,
 			   sizeof(slot_suffix))) {
 			memcpy(abc->slot_suffix, slot_suffix,

-- 
2.43.0

