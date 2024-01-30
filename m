Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712BDC47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 11:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E0F87D58;
	Tue, 30 Jan 2024 12:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d8fsI1zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A125487C0B; Tue, 30 Jan 2024 12:59:06 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250E18796B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 12:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UBx29a091480;
 Tue, 30 Jan 2024 05:59:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706615942;
 bh=3mx3S2HOJ6vJLe34L3PPYxCTH/QMepeZ0I88IiuFTUw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=d8fsI1ziVu3JMZ/xm2Wex3sZFTiIDMvKWUdpwPtoRuLp8k2eTsiH57A3EH/967azQ
 A/1+gg5mBYqZISQVsRh/kkGRMUgk3gyFrROUXOnQIwElfM+RIVcvi87ksHyT1NatUb
 IJoD0e2V5C5HikfqWKdq4aqcDar0Hz2Kup7n2x7c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UBx2dI028217
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 05:59:02 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 05:59:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 05:59:02 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UBwqAN035769;
 Tue, 30 Jan 2024 05:59:00 -0600
From: Dhruva Gole <d-gole@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>, Nishanth Menon
 <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH V4 1/2] firmware: ti_sci: fix the secure_hdr in do_xfer
Date: Tue, 30 Jan 2024 17:28:46 +0530
Message-ID: <20240130115847.860345-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130115847.860345-1-d-gole@ti.com>
References: <20240130115847.860345-1-d-gole@ti.com>
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

The ti_sci driver in U-Boot has support for secure_msg as part of it's
do_xfer function. This let's U-boot send secure messages during boot up.

The protocol to send such secure messages is described as part of the
struct ti_sci_secure_msg_hdr. As part of this, there are 2 fields for
checksum and reserved that occupy the first 4 bytes of any secure
message. This is called as the secure_hdr.

As of now, the secure_hdr needs to be 0 init-ed before sending secure
messages. However the existing code was never putting the zero-inited vars
into the secure_buf, leading to possibility of the first 4 bytes of
secure_buf being possibly garbage.

Fix this by initialising the secure_hdr itself to the secure_buf
location, thus when we make secure_hdr members 0, it automatically ensures
the first 4 bytes of secure_buf are 0.

Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
Cc: Nishanth Menon <nm@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
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
-- 
2.34.1

