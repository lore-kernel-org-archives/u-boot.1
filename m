Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A68C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 23:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC3387EA9;
	Sat,  3 Feb 2024 00:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bfDcftrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD8387E9E; Sat,  3 Feb 2024 00:02:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBD787EA2
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 00:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9A827CE2EA1;
 Fri,  2 Feb 2024 23:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D755DC43394;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706914913;
 bh=IznTH/XzjbBzeqi7ptBh+Iqdgyxq4a1NRoFUOSqtx4M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bfDcftrHd9lki3OR9moTERfAS8w2Mqs97tAp6havU76MfSLenmAKJ4UuKTb7EsLZS
 IWb0UkN0AXNoKj6fizuOLth49m3isC2oo2CouZT55nVFsFjMbtOdQr6IBGMydnQy6z
 tx3hg68GgK+WNRQkNwjlyljxeGHdrwkpxMvDpGBN4pSQ+r9CSlCzVIFudCcYLKdyfp
 i90N7yRGO/HUohY5sEazCwhvpb1OihYMM1QzOss90yAR/TR5zQ8H/WgAMU+l+BtYLw
 qgPKaDFP4PutiqEWBzSaXLMpzYIdgLOtZFh2Oqv28va3PqPKt4vH3syxMke5+9i35+
 LZwhRQJXOEBFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C0F54C48297;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 03 Feb 2024 07:01:56 +0800
Subject: [PATCH 3/3] usb: dwc3: add glue driver for Hi3798MV200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-hisi-dwc3-v1-3-448050c7b690@outlook.com>
References: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
In-Reply-To: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706914914; l=2367;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=s/uGat4mcwI1MhFm8NxotPzNvm6CCqM8lql07wQqGF8=;
 b=5csjwcPLU0HNyGZJ5J6U4IcWGbfoQ3dXdm5Q5+cGpTyjUms39eDS38ZfH17DtVjpVLJtTkeWW
 /ZdE/0hDMQ9A+XI9vp0W1aCKPMigK3e+VENZIc43uU75xKMzm2nOhL6
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

It needs some platform-specific operations before generic initialization
code.

If nano PHY is not initialized properly, it must be disabled. Or else
 USB host will complain unable to reset port.

USB2 is always supported, so it's never disabled.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index d892042b91..a3200ff1ab 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -419,6 +419,45 @@ struct dwc3_glue_ops rk_ops = {
 	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
 };
 
+static void dwc3_hi3798mv200_glue_configure(struct udevice *dev, ofnode child, int index)
+{
+#define HI3798MV200_PERI_CTRL_ADDR	0xf8a20000
+#define HI3798MV200_PERI_USB5		0x134
+#define USB3_U3_PORT_DISABLE		BIT(5)
+#define USB3_U2_PORT_DISABLE		BIT(4)
+
+	// Disable super-speed port if maximum speed is high-speed
+	void __iomem *peri_base = map_physmem(HI3798MV200_PERI_CTRL_ADDR, 0x1000, MAP_NOCACHE);
+	enum usb_device_speed speed = usb_get_maximum_speed(child);
+	u32 reg;
+
+	reg = readl(peri_base + HI3798MV200_PERI_USB5);
+	reg &= ~(USB3_U3_PORT_DISABLE | USB3_U2_PORT_DISABLE);
+
+	switch (speed) {
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+		// disable super-speed port
+		reg |= USB3_U3_PORT_DISABLE;
+		pr_info("%s: super-speed port disabled.\n", __func__);
+		break;
+
+	case USB_SPEED_SUPER:
+		break;
+
+	default:
+		pr_warn("%s: unknown speed class %d.\n", __func__, speed);
+	}
+
+	writel(reg, peri_base + HI3798MV200_PERI_USB5);
+	unmap_physmem(peri_base, MAP_NOCACHE);
+}
+
+const struct dwc3_glue_ops hi3798mv200_ops = {
+	.glue_configure = dwc3_hi3798mv200_glue_configure,
+};
+
 static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 {
 	const char *name = ofnode_get_name(node);
@@ -611,6 +650,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },
+	{ .compatible = "hisilicon,hi3798mv200-dwc3", .data = (ulong)&hi3798mv200_ops },
 	{ }
 };
 

-- 
2.43.0

