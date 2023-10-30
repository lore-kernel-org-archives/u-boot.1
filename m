Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2063CC4167B
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 17:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7572287997;
	Mon, 30 Oct 2023 18:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gCizis6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA8587AB1; Mon, 30 Oct 2023 18:05:10 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3766C87A86
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 18:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39UH53wp005011;
 Mon, 30 Oct 2023 12:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698685503;
 bh=8RFpSQOG7WQGm+cik+ClWcJQotOv1W7EEjiSkN0f1Bk=;
 h=From:To:CC:Subject:Date;
 b=gCizis6EvGXJ/kTh8Rl+HU7DFjA2QOQp2XXxFqUOg/YgUtDJgBLy40pD5beb/9QmB
 9RVvLrAdODDakc3aXxUriIvoAHFV/gBNMNZutNBTLESIGfBEFZb3vuCJPl1+gN1UHB
 i9ClPjBRxWJO8acSDxpif0pdHrY460eVWzj9HPPo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39UH53Gw071560
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 30 Oct 2023 12:05:03 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 12:05:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 12:05:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39UH519N060605;
 Mon, 30 Oct 2023 12:05:02 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <matwey.kornilov@gmail.com>, <jkridner@beagleboard.org>,
 <robertcnelson@gmail.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, 
 <a-nandan@ti.com>, <n-francis@ti.com>
Subject: [PATCH v3] board: ti: common: board_detect: Fix EEPROM offset read
 for 1-byte
Date: Mon, 30 Oct 2023 22:34:58 +0530
Message-ID: <20231030170458.21668-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 30 Oct 2023 18:13:36 +0100
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

EEPROM detection logic in ti_i2c_eeprom_get() involves reading
the total size and the 1-byte size with an offset 1. The commit
9f393a2d7af8 ("board: ti: common: board_detect: Fix EEPROM read
quirk for 2-byte") that attempts to fix this uses a wrong pointer to
compare.

The value with one offset is read into offset_test, but the pointer
used to match was still ep, resulting in an invalid comparison of the
values. The intent is to identify bad 2-byte addressing eeproms that
get stuck on the successive reads.

Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
---
v3 <--> v2:
Improved and concise commit description.

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

