Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EC6C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460F087553;
	Thu, 26 Oct 2023 14:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HuOywY6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291BC87B44; Thu, 26 Oct 2023 14:24:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5285F875DA
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39QCOI57102747;
 Thu, 26 Oct 2023 07:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698323058;
 bh=KMr+3B0wlFMWCf4oJKVGBAuf3tHwT2LUQhCMHxnYwzQ=;
 h=From:To:CC:Subject:Date;
 b=HuOywY6T09TY4LV4ddtclaFHcbAS11xvI0BVXZI6eeq9JJNIj3mIIhGz83aNqsI+a
 FaXn7CbEWBSkriZDushvZgZacTBYVds9SU2weiFjY3d4CeZe99Bo4X5wf37MtYHQqW
 eDPZLSB9r3dkNS4q+p1q9xpfqz8HQhwZ+Xui1Jm0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39QCOIOQ076932
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 26 Oct 2023 07:24:18 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 07:24:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 07:24:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39QCOHE7106840;
 Thu, 26 Oct 2023 07:24:17 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <matwey.kornilov@gmail.com>, <jkridner@beagleboard.org>,
 <robertcnelson@gmail.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, 
 <a-nandan@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2] board: ti: common: board_detect: Fix EEPROM offset read
 for 1-byte
Date: Thu, 26 Oct 2023 17:54:13 +0530
Message-ID: <20231026122413.4116-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 26 Oct 2023 14:56:48 +0200
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

EEPROM detection logic in ti_i2c_eeprom_get() involves reading the total
size followed by reading 1-byte size with an offset 1. This commit fixes
the header matching issue in commit 9f393a2d7af8 ("board: ti: common:
board_detect: Fix EEPROM read quirk for 2-byte").

In the previous commit, the value with one offset is being read into
offset_test, but the pointer used to match was still ep. ep is the
pointer where previously read data is stored, resulting in an invalid
comparision of the values. The intent is to identify bad 2-byte
addressing eerpoms, which respond to the initial 1-byte addressing
request and gets stuck on the succesive reads. After successive read
with an offset 1, the 1-byte data is compared with the second byte of
the header to ensure it as a valid 1byte addressing eeprom.
This is taken care by comparing proper first byte value from, header
with an offset 1 byte, to offset_test having the 1-byte data read from eeprom.

Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
v2 <--> v1:
Fix inplace for the else condition of CONFIG_IS_ENABLED(DM_I2C).
Improved commit message.

 board/ti/common/board_detect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index 9a53884c98..869f7a47f8 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
 
 	rc = dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
 
-	if (*((u32 *)ep) != (header & 0xFF))
+	if (offset_test != ((header >> 8) & 0xFF))
 		one_byte_addressing = false;
 
 	/* Corrupted data??? */
@@ -180,7 +180,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
 
 	rc = i2c_read(dev_addr, 0x1, byte, &offset_test, sizeof(offset_test));
 
-	if (*((u32 *)ep) != (header & 0xFF))
+	if (offset_test != ((header >> 8) & 0xFF))
 		one_byte_addressing = false;
 
 	/* Corrupted data??? */
-- 
2.39.0

