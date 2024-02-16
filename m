Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF431C48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 10:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E5E87B50;
	Fri, 16 Feb 2024 11:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d+UPLgiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A6387E44; Fri, 16 Feb 2024 11:41:20 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C870D8780A
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 11:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GAf9RA063071;
 Fri, 16 Feb 2024 04:41:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708080069;
 bh=u787QNlqle7TtFiaOBcItkhipSEE4abj/m70ZNvmZ9o=;
 h=From:To:CC:Subject:Date;
 b=d+UPLgiUHvngt+UbuBytbv9940MUcC28t2UxOtPlGlqRs7b/60MfisQwvQrQLH8p6
 QgOY5IIzhXvk61pm1vga6UxFjgqfHh+wDN0oM2rM/P+ZXfc8F5kCR4VOlUJcmafwT+
 yVnvF6oTvO1t6QsmadVghco7WRCfTW5yakxpQEQQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GAf9rQ031468
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Feb 2024 04:41:09 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 04:41:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 04:41:08 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GAf5HR011657; 
 Fri, 16 Feb 2024 04:41:06 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <vigneshr@ti.com>,
 <matthias.schiffer@ew.tq-group.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] dma: ti: k3-udma: Fix error handling for setup_resources() in
 udma_probe()
Date: Fri, 16 Feb 2024 16:11:05 +0530
Message-ID: <20240216104105.494602-1-s-vadapalli@ti.com>
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

In udma_probe() the return value of setup_resources() is stored in the
u32 "ch_count" member of "struct udma_dev", due to which any negative
return value which indicates an error is masked.

Fix this by storing the return value of setup_resources() in the already
declared integer variable "ret", followed by assigning it to the "ch_count"
member of "struct udma_dev" in case of no error.

While at it, change the "return ret" at the end of udma_probe() to a
"return 0", to explicitly indicate that probe was successful.

Fixes: a8837cf43839 ("dma: ti: k3-udma: Query DMA channels allocated from Resource Manager")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
9e00b6993f Merge tag 'u-boot-dfu-20240215' of https://source.denx.de/u-boot/custodians/u-boot-dfu
of the master branch of U-Boot.

Regards,
Siddharth.

 drivers/dma/ti/k3-udma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index eea9ec9659..8a6625f034 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1770,9 +1770,11 @@ static int udma_probe(struct udevice *dev)
 		return PTR_ERR(ud->ringacc);
 
 	ud->dev = dev;
-	ud->ch_count = setup_resources(ud);
-	if (ud->ch_count <= 0)
-		return ud->ch_count;
+	ret = setup_resources(ud);
+	if (ret <= 0)
+		return ret;
+
+	ud->ch_count = ret;
 
 	for (i = 0; i < ud->bchan_cnt; i++) {
 		struct udma_bchan *bchan = &ud->bchans[i];
@@ -1831,7 +1833,7 @@ static int udma_probe(struct udevice *dev)
 
 	uc_priv->supported = DMA_SUPPORTS_MEM_TO_MEM | DMA_SUPPORTS_MEM_TO_DEV;
 
-	return ret;
+	return 0;
 }
 
 static int udma_push_to_ring(struct k3_nav_ring *ring, void *elem)
-- 
2.34.1

