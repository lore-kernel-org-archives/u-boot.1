Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D979C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F22287F65;
	Tue, 20 Feb 2024 11:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OMlrIIwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0364807BE; Tue, 20 Feb 2024 11:05:23 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BDFE807BE
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KA4tUL051378;
 Tue, 20 Feb 2024 04:04:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708423495;
 bh=cXhIgJKS9jvsgmfHLNG3P/zTzHrbP9HK1ag2zvTkxjE=;
 h=From:To:CC:Subject:Date;
 b=OMlrIIwfGzZ6KSyzOiCcq1sNIBlb/movqxtj/zdKuDIcIk/4L8Za25vxbdk1FAYnw
 L2UcZjNYTxSjmK0Kau1Og9Gqt6Y+dPMrsBbDeJiJqfXwiieYVnPw/ETU8VS+vpYU60
 WrOpVpBdV1L2OT1BXnZ8ZFvWUPNXIT8HCZue4HqI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KA4tJ1025520
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 04:04:55 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 04:04:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 04:04:54 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KA4peu044180; 
 Tue, 20 Feb 2024 04:04:52 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <vigneshr@ti.com>,
 <matthias.schiffer@ew.tq-group.com>, <nm@ti.com>,
 <dan.carpenter@linaro.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] dma: ti: k3-udma: Fix error handling for setup_resources()
 in udma_probe()
Date: Tue, 20 Feb 2024 15:34:51 +0530
Message-ID: <20240220100451.1053667-1-s-vadapalli@ti.com>
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
3e6f2a94bf Merge tag 'u-boot-imx-master-20240219' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
of the master branch of U-Boot.

v1:
https://patchwork.ozlabs.org/project/uboot/patch/20240216104105.494602-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on latest U-Boot tree.
- As pointed out by Dan in reply to the v1 patch, since the return value of
  setup_resources() cannot be zero, update the check performed on the
  return value accordingly.

Regards,
Siddharth.

 drivers/dma/ti/k3-udma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index eea9ec9659..ed0a9bf487 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1770,9 +1770,11 @@ static int udma_probe(struct udevice *dev)
 		return PTR_ERR(ud->ringacc);
 
 	ud->dev = dev;
-	ud->ch_count = setup_resources(ud);
-	if (ud->ch_count <= 0)
-		return ud->ch_count;
+	ret = setup_resources(ud);
+	if (ret < 0)
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

