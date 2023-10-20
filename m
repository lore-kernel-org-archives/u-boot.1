Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6463FCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 10:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FFD86F64;
	Fri, 20 Oct 2023 12:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pD73eSvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD3D08724E; Fri, 20 Oct 2023 09:01:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E6D86F78
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39K71T69046163;
 Fri, 20 Oct 2023 02:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697785289;
 bh=+qic45AkTuZB8kxI+7liZkc/TMiD3ukbVfL1QnHh76g=;
 h=From:To:CC:Subject:Date;
 b=pD73eSvcWUTGaKNZ+gmaDzJQd5uBiWZaFMWvtu1622yHSZBf8uiYjsLPqQ1SEVpI+
 B1j3+9wwBKacCV3DrWkLPECagaLeMIxz6ChjMBFOxdQiPLshxwGtvWHDd3OS2qdZty
 ZX1f/i6jYrNKVROEcL+dQfPdhLpvLYh4WlyS0nNk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39K71T48008795
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Oct 2023 02:01:29 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 02:01:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 02:01:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39K71Sb3003807;
 Fri, 20 Oct 2023 02:01:28 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-nandan@ti.com>, <n-francis@ti.com>
Subject: [RESEND PATCH] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
Date: Fri, 20 Oct 2023 12:31:28 +0530
Message-ID: <20231020070128.28320-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 20 Oct 2023 12:43:12 +0200
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
offset_test, but the pointer used to match was still ep. After reading
with an offset 1, the second byte of the header is compared with the 1-byte
data read from EEPROM. This is taken care by comparing proper first byte
value from the header.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read quirk for 2-byte)
---
Resending due to incorrect patch tag last time.

 board/ti/common/board_detect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index 9a53884c98..17fe8f8069 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_addr, int dev_addr,
 
 	rc = dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
 
-	if (*((u32 *)ep) != (header & 0xFF))
+	if (offset_test != ((header >> 8) & 0xFF))
 		one_byte_addressing = false;
 
 	/* Corrupted data??? */
-- 
2.39.0

