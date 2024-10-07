Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14950CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 872CE88AB9;
	Mon,  7 Oct 2024 14:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f3AlEykG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7734788B11; Mon,  7 Oct 2024 14:19:41 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C35889E1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 497CJWTR023386;
 Mon, 7 Oct 2024 07:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728303572;
 bh=/J4Nd0urbGjgnTs57CTXn3ClKxPyAlZ6Cj5nZse1Wko=;
 h=From:To:CC:Subject:Date;
 b=f3AlEykGHpOkZdWie4h/pW9o6ZVFuUwccnoVI2ElvfTp+wC4L6VKHc4YpEfNyA+hm
 NrA+2AO14pvJuSChnJqsP4lte4wPmFzTpS0U+4J06hDpXXeHk5dp99jPl1nBs1rbRN
 vbeRbWwTug76pljvJ4oG6NXaUenYgWo1oQw4LiC8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 497CJWpd045098
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 07:19:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 07:19:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 07:19:31 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 497CJSwp121622;
 Mon, 7 Oct 2024 07:19:28 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <lukma@denx.de>, <mkorpershoek@baylibre.com>,
 <marex@denx.de>, <rogerq@kernel.org>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] usb: gadget: cdns3: Fix cdns3_ep_config() by setting
 ep.maxpacket
Date: Mon, 7 Oct 2024 17:49:27 +0530
Message-ID: <20241007121927.1680039-1-s-vadapalli@ti.com>
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

The function cdns3_ep_config() calculates the maximum packet size based
on the Endpoint Type and the Gadget Speed and stores it in the variable
"max_packet_size". This value is then programmed in the USB Controller
for the corresponding Endpoint. This may result in a mismatch between
the maximum packet size programmed in the USB controller and the maximum
packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
Additionally, since TD_SIZE is calculated in cdns3_ep_run_transfer() on the
basis of the maximum packet size stored in the "maxpacket" member of
"struct usb_ep", it may lead to an incorrect value of TD_SIZE when compared
with what the USB controller actually expects (max_packet_size).

Fix this.

Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
dd4d130c8e clk: renesas: rcar-gen3: Fix SSCG caching replacement with MDSEL/PE caching
of the master branch of U-Boot.

v1:
https://patchwork.ozlabs.org/project/uboot/patch/20241007104239.1624430-1-s-vadapalli@ti.com/
Changes since v1:
- Based on Roger's feedback at:
  https://patchwork.ozlabs.org/project/uboot/patch/20241007104239.1624430-1-s-vadapalli@ti.com/#3389960
  rather than using usb_ep_set_maxpacket_limit() which changes
  "maxpacket_limit" in addition to "maxpacket", only update the "maxpacket"
  member of usb_ep.

Regards,
Siddharth.

 drivers/usb/cdns3/gadget.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index ac7e469469..a30c40ef80 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -1637,6 +1637,14 @@ void cdns3_ep_config(struct cdns3_endpoint *priv_ep)
 	else
 		priv_ep->trb_burst_size = 16;
 
+	/*
+	 * The Endpoint is configured to handle a maximum packet size of
+	 * max_packet_size. Hence, set priv_ep->endpoint.maxpacket to
+	 * max_packet_size. This is necessary to ensure that the TD_SIZE
+	 * is calculated correctly in cdns3_ep_run_transfer().
+	 */
+	priv_ep->endpoint.maxpacket = max_packet_size;
+
 	ret = cdns3_ep_onchip_buffer_reserve(priv_dev, buffering + 1,
 					     !!priv_ep->dir);
 	if (ret) {
-- 
2.40.1

