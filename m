Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A609D5C0C5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84620892B8;
	Fri,  8 Nov 2024 14:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="DQtMEXlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A6288F62; Fri,  8 Nov 2024 06:52:08 +0100 (CET)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54A588EC6
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 06:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1731045122; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U5Y40clsynKBdK8uOIV6zUSc2dbvqq5JYMI+/E/hCm/+FhedA6189em5Kljg4xikXW8vSKZVqQTVN17310nwpRHXMsAuvg3gvqKILzdGtiC06ZIQLbYmow9ARJhadX0NPhUx8c8piBXMr/JOJcgDSKIsg1/WuZjfPtXv763BWgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731045122;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ip0TFFSG6FyknpVXhxrLdmq6vBHDq3i47Y/7W0zMWyY=; 
 b=Or0vfqyXSj/wQ4Q8XzA13YOwePuW5wJ7m/mYp65cV6F17p7MDA3GfmsdAZXp9zsYWicKaWphFnN1l52OA2vBQ1oxwY/baWIgnDvxwIUQyczpvX4rECbO9NkgKD0tZ1bHG7U2xguDw7bs5rtXENv3g9cWuyuTSVt3XtyBeez/EAc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731045122; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
 bh=ip0TFFSG6FyknpVXhxrLdmq6vBHDq3i47Y/7W0zMWyY=;
 b=DQtMEXlJT8ijPfMd/h3MT0v5KsBZDt2dq21dsxGAzFfYOBphv+lk0ym8R8LkBWd4
 wbZ/d0/EKLlGwp0qnO/VlfN4qfe9eg4Z+ANWEX6RVJlikcyQ5vcbQtACQRxlLmrlAG6
 fbVqOpXeEZuQXR1IHqPx3re9HeEOFNVOat2gVCM0=
Received: by mx.zohomail.com with SMTPS id 1731045120375689.0104922252991;
 Thu, 7 Nov 2024 21:52:00 -0800 (PST)
From: Khoa Hoang <admin@khoahoang.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Khoa Hoang <admin@khoahoang.com>
Subject: [PATCH v2 1/2] eth: asix88179: Fix ASIX AX88179A PHY hang
Date: Thu,  7 Nov 2024 21:51:35 -0800
Message-Id: <20241108055136.50701-2-admin@khoahoang.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241108055136.50701-1-admin@khoahoang.com>
References: <20241108055136.50701-1-admin@khoahoang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

The ASIX AX88179A locks up when the ADVERTISE_NPAGE bit is set in the
MII_ADVERTISE register, suggesting that this feature may be broken or
unsupported on this chip. In the Linux kernel, this bit is not set,
and enabling it also causes the PHY to lock up and stay in a
link-down state.

Additionally, the AX88179 and AX88179A variants do not appear to
support the ADVERTISE_LPACK bit, as setting it consistently reads
back as 0.

This patch removes the ADVERTISE_NPAGE and ADVERTISE_LPACK bits from
the MII_ADVERTISE register configuration. It also resets the PHY
before modifying the MII_ADVERTISE register, then restarts
auto-negotiation, following the same flow used in the U-Boot asix.c
driver.

Signed-off-by: Khoa Hoang <admin@khoahoang.com>
---
 drivers/usb/eth/asix88179.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 4bd3b9d1..4bd353b9 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -176,6 +176,7 @@
 #define AX_RX_URB_SIZE 1024 * 0x12
 #define BLK_FRAME_SIZE 0x200
 #define PHY_CONNECT_TIMEOUT 5000
+#define PHY_RESET_TIMEOUT 500
 
 #define TIMEOUT_RESOLUTION 50	/* ms */
 
@@ -285,6 +286,26 @@ static int asix_write_mac(struct ueth_data *dev, uint8_t *enetaddr)
 	return ret;
 }
 
+static int asix_reset_phy(struct ueth_data *dev)
+{
+	u16 bmcr;
+	u32 t;
+
+	/* Reset the PHY */
+	bmcr = BMCR_RESET;
+	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &bmcr);
+
+	for (t = 0; t < PHY_RESET_TIMEOUT; t += TIMEOUT_RESOLUTION) {
+		asix_read_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &bmcr);
+		if (!(bmcr & BMCR_RESET))
+			return 0;
+		mdelay(TIMEOUT_RESOLUTION);
+	}
+
+	debug("Reset PHY timeout\n");
+	return -ETIMEDOUT;
+}
+
 static int asix_basic_reset(struct ueth_data *dev,
 			struct asix_private *dev_priv)
 {
@@ -344,14 +365,22 @@ static int asix_basic_reset(struct ueth_data *dev,
 		 AX_MEDIUM_GIGAMODE | AX_MEDIUM_JUMBO_EN;
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
 
+	asix_reset_phy(dev);
+
 	u16 adv = 0;
-	adv = ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_LPACK |
-	      ADVERTISE_NPAGE | ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP;
+	adv = ADVERTISE_ALL | ADVERTISE_CSMA |
+	      ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP;
 	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_ADVERTISE, 2, &adv);
 
 	adv = ADVERTISE_1000FULL;
 	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_CTRL1000, 2, &adv);
 
+	/* Restart auto-negotiation */
+	u16 bmcr = 0;
+	asix_read_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &bmcr);
+	bmcr |= BMCR_ANENABLE | BMCR_ANRESTART;
+	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &bmcr);
+
 	return 0;
 }
 
-- 
2.39.2

