Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CE6C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 15:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E687B87E36;
	Tue, 30 Jan 2024 16:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fKT+KVyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD3DA87E31; Tue, 30 Jan 2024 16:00:32 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4BF87D5A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 16:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UF0RX9005551;
 Tue, 30 Jan 2024 09:00:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706626827;
 bh=Lkt82r3PeToNTgFka07Skh0lw85Nba4AwHu1VRIIo3c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fKT+KVyRcov3/pQS2+fzoCExTiinAARWeXVR1qrGgX36BJXO8M70D+GyN6iILmrTm
 nfp5BtH8a7iC3/INrTUvT+nRtaC1z6ebNcYuwgkSTcgKZZX+kXB9cg/fdvCnhhR4NL
 Bk6CBkXQ2wjepm+fh64GqYfL6zPUhbTACFNscd9s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UF0RMP015620
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 09:00:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 09:00:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 09:00:27 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UF04UT014959;
 Tue, 30 Jan 2024 09:00:26 -0600
From: Dhruva Gole <d-gole@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>, Nishanth Menon
 <nm@ti.com>
Subject: [PATCH V5 1/2] firmware: ti_sci: fix the secure_hdr in do_xfer
Date: Tue, 30 Jan 2024 20:29:59 +0530
Message-ID: <20240130145959.879882-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130145959.879882-1-d-gole@ti.com>
References: <20240130145959.879882-1-d-gole@ti.com>
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
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6e9f93e9a302..b77ac36af284 100644
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
+		memcpy(&secure_buf[sizeof(*secure_hdr)], xfer->tx_message.buf,
 		       xfer->tx_message.len);
 
 		xfer->tx_message.buf = (u32 *)secure_buf;
-		xfer->tx_message.len += sizeof(secure_hdr);
+		xfer->tx_message.len += sizeof(*secure_hdr);
 
 		if (xfer->rx_len)
-			xfer->rx_len += sizeof(secure_hdr);
+			xfer->rx_len += sizeof(*secure_hdr);
 	}
 
 	/* Send the message */
-- 
2.34.1

