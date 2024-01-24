Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC81C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 10:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C310D87C3C;
	Wed, 24 Jan 2024 11:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YD5ETplj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6767887C33; Wed, 24 Jan 2024 11:41:56 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4E787BF2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OAfnBn112950;
 Wed, 24 Jan 2024 04:41:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706092909;
 bh=zSMZ1CRPjp+9Q9KFW3ZUGcXMvmCWcCwLy5QWUuGg0H8=;
 h=From:To:CC:Subject:Date;
 b=YD5ETpljqqZSCIljo5FNECFviMSNw0MSvBaHayqxRwPYHT7yj0UqVZ5T1WTIvVNow
 VeUpDrAmNr3ZS5bDgEm6Vi4dhozabkmWMHSBqViTL6ZGIp61TcvMMfJn888IsBZ5fi
 jvYgNtUQoY3WrtC3lKYIJ1Ie/qg3j9S/o3ZUCKoo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OAfnd6079211
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 04:41:49 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 04:41:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 04:41:48 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OAfjt0023202;
 Wed, 24 Jan 2024 04:41:46 -0600
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>, Nishanth Menon
 <nm@ti.com>, Neha Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>
Subject: [PATCH V2] firmware: ti_sci: fix the secure_hdr in do_xfer
Date: Wed, 24 Jan 2024 16:09:00 +0530
Message-ID: <20240124103900.201661-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The secure_hdr needs to be 0 init-ed however this was never being put
into the secure_buf, leading to possibility of the first 4 bytes of
secure_buf being possibly garbage.

Fix this by initialising the secure_hdr itself to the secure_buf
location, thus when we make it 0, it automatically ensures the first 4
bytes are 0.

Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Boot tested for sanity on AM62x SK
https://gist.github.com/DhruvaG2000/724ceba3a0db03f4b0bff47de1160074

Changelog:
Rebased on top of latest master branch

Cc: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Neha Francis <n-francis@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
Cc: Kamlesh Gurudasani <kamlesh@ti.com>

 drivers/firmware/ti_sci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6e9f93e9a302..f7675e383d47 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -236,13 +236,13 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
 {
 	struct k3_sec_proxy_msg *msg = &xfer->tx_message;
 	u8 secure_buf[info->desc->max_msg_size];
-	struct ti_sci_secure_msg_hdr secure_hdr;
+	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
 	int ret;
 
 	if (info->is_secure) {
 		/* ToDo: get checksum of the entire message */
-		secure_hdr.checksum = 0;
-		secure_hdr.reserved = 0;
+		secure_hdr->checksum = 0;
+		secure_hdr->reserved = 0;
 		memcpy(&secure_buf[sizeof(secure_hdr)], xfer->tx_message.buf,
 		       xfer->tx_message.len);
 

base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe
-- 
2.34.1

