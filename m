Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83203CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 09:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC89888CA3;
	Mon, 30 Sep 2024 11:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ChVNW/7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795DC88CA3; Mon, 30 Sep 2024 11:34:28 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB1B88D4F
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U9YBZW062091;
 Mon, 30 Sep 2024 04:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727688851;
 bh=vJ945bPOtPS67zFmt7xl/wYPhbPgEdsY/ZcmZ9XCqCc=;
 h=From:To:CC:Subject:Date;
 b=ChVNW/7C6JaxpR2gfHDFxUuxQex/bVdcFgKVjtab8u28IN5KZx+I0JjjKiQC2PNG8
 9hZz5ir2uXGJ0LZx8qcNh1rGlYLidNF5VBrgHRNKb98xpmcOFu6onU76lRkxTnOsi1
 hw4KKWIt0uCFOWFR70ephX55yVkFbNh2CAfDihyQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48U9YB9N064723
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 30 Sep 2024 04:34:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 04:34:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 04:34:11 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9Y7Mh023165;
 Mon, 30 Sep 2024 04:34:08 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <lukma@denx.de>, <mkorpershoek@baylibre.com>,
 <marex@denx.de>, <rogerq@kernel.org>, <vigneshr@ti.com>, <jjhiblot@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] usb: gadget: cdns3: Fix missing cache operations for non-zero
 Endpoints
Date: Mon, 30 Sep 2024 15:04:07 +0530
Message-ID: <20240930093407.2998969-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Transfer initiation and completion for the non-zero Endpoints are
handled by cdns3_ep_run_transfer() and cdns3_transfer_completed()
respectively.

Failing to flush the cache associated with the TRB Pool within
cdns3_ep_run_transfer() results in the transfers never being initiated.
Similarly, failing to invalidate the cache associated with the TRB pool
within cdns3_transfer_completed() results in the transfers never being
completed.

Fix this.

Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
56b47b8b6a Merge tag 'u-boot-stm32-20240926' of https://source.denx.de/u-boot/custodians/u-boot-stm
of the master branch of U-Boot.

This patch has been validated on AM642-EVM in the context of Fastboot.
Fastboot is non-functional without this patch. EP1 is configured in
Bulk Mode for Fastboot and is non-responsive. This patch addresses the
issue, thereby enabling Fastboot.

Regards,
Siddharth.

 drivers/usb/cdns3/gadget.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 32b2c41206..ac7e469469 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -965,6 +965,12 @@ int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	if (priv_dev->dev_ver <= DEV_VER_V2)
 		cdns3_wa1_tray_restore_cycle_bit(priv_dev, priv_ep);
 
+	/* Flush TRBs */
+	flush_dcache_range((unsigned long)priv_ep->trb_pool,
+			   (unsigned long)priv_ep->trb_pool +
+			   ROUND(sizeof(struct cdns3_trb) * priv_ep->num_trbs,
+				 CONFIG_SYS_CACHELINE_SIZE));
+
 	trace_cdns3_prepare_trb(priv_ep, priv_req->trb);
 
 	/*
@@ -1153,6 +1159,13 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 				priv_ep->endpoint.desc->bEndpointAddress);
 #endif
 
+		/* Invalidate TRBs */
+		invalidate_dcache_range((unsigned long)priv_ep->trb_pool,
+					(unsigned long)priv_ep->trb_pool +
+					ROUND(sizeof(struct cdns3_trb) *
+					      priv_ep->num_trbs,
+					      CONFIG_SYS_CACHELINE_SIZE));
+
 		if (!cdns3_request_handled(priv_ep, priv_req))
 			goto prepare_next_td;
 
-- 
2.40.1

