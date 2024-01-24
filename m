Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2841EC47DDF
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 13:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB9D87C5A;
	Wed, 24 Jan 2024 14:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wpa+R6fL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCFC87C54; Wed, 24 Jan 2024 14:08:15 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 000A587B90
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 14:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OD8AvV001557;
 Wed, 24 Jan 2024 07:08:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706101690;
 bh=t6qcznbrgP1uId5uDCyieF80p43m1FinJU5Dv3hk+AA=;
 h=From:To:CC:Subject:Date;
 b=Wpa+R6fL5qpPYE6Z6Y88g0v3q2piV2bOZOTxaM2gApqQNRC5/csMJBcmZHbGgGXsq
 2tfniaPFZFSSYVcjcey1EOqT1FttlpfleTeqLwSyISvDXtCpKBdJ9qeGHR5pXtkKWC
 WbbB5jpQ4cEIzZVkXWsPKYB3k4/04k4WuoprAjWM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OD8A5I011593
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 07:08:10 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 07:08:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 07:08:09 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OD86CH076739;
 Wed, 24 Jan 2024 07:08:07 -0600
From: Dhruva Gole <d-gole@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>, Nishanth Menon
 <nm@ti.com>, Neha Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>
Subject: [PATCH V3] firmware: ti_sci: fix the secure_hdr in do_xfer
Date: Wed, 24 Jan 2024 18:37:59 +0530
Message-ID: <20240124130758.237233-1-d-gole@ti.com>
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
v2 --> v3
Address Kamlesh's comment on v2: use sizeof(struct ti_sci_secure_msg_hdr)

v1 --> v2:
Rebased on top of latest master branch

Cc: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Neha Francis <n-francis@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>

---

 drivers/firmware/ti_sci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6e9f93e9a302..49d2696a6d09 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -236,21 +236,21 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
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
-		memcpy(&secure_buf[sizeof(secure_hdr)], xfer->tx_message.buf,
+		secure_hdr->checksum = 0;
+		secure_hdr->reserved = 0;
+		memcpy(&secure_buf[sizeof(struct ti_sci_secure_msg_hdr)], xfer->tx_message.buf,
 		       xfer->tx_message.len);
 
 		xfer->tx_message.buf = (u32 *)secure_buf;
-		xfer->tx_message.len += sizeof(secure_hdr);
+		xfer->tx_message.len += sizeof(struct ti_sci_secure_msg_hdr);
 
 		if (xfer->rx_len)
-			xfer->rx_len += sizeof(secure_hdr);
+			xfer->rx_len += sizeof(struct ti_sci_secure_msg_hdr);
 	}
 
 	/* Send the message */

base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe
-- 
2.34.1

