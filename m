Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A06CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C8383990;
	Fri, 17 Oct 2025 17:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="fdaQ80fW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88DA83852; Fri, 17 Oct 2025 17:28:44 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01FFC83804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C2EF425D5F;
 Fri, 17 Oct 2025 17:28:42 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JL895BhcXglE; Fri, 17 Oct 2025 17:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714922; bh=ZvpQENbFkb2WSS+7mUcXWU0S+MZcBDjz/ixclkKO1Uk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fdaQ80fWFcbxuouwPSJorbqeY/glRuyUddBhx63Ac31H/7VJLOimlYim3dkByn2ly
 onsHY76Ps8Hn61Ch4D/cANDcsVXQx9/l3PK98a2ILV5g72eAMz1062eTFyQAYBVBrS
 u53R3D8tl06/HnXiWyrE9pjmqfL2VfSm5sWpcwoVISS8Y7g0aYAEzzHAr+VzvxnJxh
 un+1fxRK+2yPeFCUBp3nW3SKgMNFSxwPxkOZIUXeegW1OwjdsvDQCO9bQljfc6cUPn
 mTGA5Kjtxb3I6TMHmzUDPj8uAp9kWBX2VqrAtFmi8TIt3kUusFpCJSZRPa/Epm0sGz
 KP+uZkLTevaCw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:58:17 +0530
Subject: [PATCH 2/6] power: pmic: s2mps11: add support for allowing
 multiple device variants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-power-pmic-regulator-s2mpu05-v1-2-91cadc0f4156@disroot.org>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714904; l=2995;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=ZvpQENbFkb2WSS+7mUcXWU0S+MZcBDjz/ixclkKO1Uk=;
 b=7OGYzjmOFy3Q/sAweHisVlq9uRs3gcE504KPStD/ZYQWmdhkMC+Uita+HnOguIOLspekI/pDz
 LR+UyKjG9mlA6ExVSOuFKf6Ik9akjgR/zoFOI2OVvQeynJOLql0fk67
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

There are multiple PMICs by Samsung which are similar in architecture
(register layout, interface, etc.) and is possible to be driven by a
single driver. Variant specific code and data should be managed properly
in the driver.

And an enum which describes all supported variants. Pass the enum as the
device driver data. Introduce a switch-case block on the enum for any
variant specific code.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/pmic/s2mps11.c | 21 ++++++++++++++++++---
 include/power/s2mps11.h      |  5 +++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 23c96da3fdf485e171252f76f54a8778fa8bb20a..51c98afb17b2b1a790860419b55e211b0c533685 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -13,7 +13,7 @@
 #include <power/pmic.h>
 #include <power/s2mps11.h>
 
-static const struct pmic_child_info pmic_children_info[] = {
+static const struct pmic_child_info s2mps11_pmic_children_info[] = {
 	{ .prefix = S2MPS11_OF_LDO_PREFIX, .driver = S2MPS11_LDO_DRIVER },
 	{ .prefix = S2MPS11_OF_BUCK_PREFIX, .driver = S2MPS11_BUCK_DRIVER },
 	{ },
@@ -21,7 +21,12 @@ static const struct pmic_child_info pmic_children_info[] = {
 
 static int s2mps11_reg_count(struct udevice *dev)
 {
-	return S2MPS11_REG_COUNT;
+	switch (dev_get_driver_data(dev)) {
+	case VARIANT_S2MPS11:
+		return S2MPS11_REG_COUNT;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int s2mps11_write(struct udevice *dev, uint reg, const uint8_t *buff,
@@ -51,6 +56,7 @@ static int s2mps11_bind(struct udevice *dev)
 {
 	ofnode regulators_node;
 	int children;
+	const struct pmic_child_info *pmic_children_info;
 
 	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
@@ -61,6 +67,15 @@ static int s2mps11_bind(struct udevice *dev)
 
 	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
 
+	switch (dev_get_driver_data(dev)) {
+	case VARIANT_S2MPS11:
+		pmic_children_info = s2mps11_pmic_children_info;
+		break;
+	default:
+		debug("%s: unknown device type\n", __func__);
+		return -EINVAL;
+	}
+
 	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
 	if (!children)
 		debug("%s: %s - no child found\n", __func__, dev->name);
@@ -75,7 +90,7 @@ static struct dm_pmic_ops s2mps11_ops = {
 };
 
 static const struct udevice_id s2mps11_ids[] = {
-	{ .compatible = "samsung,s2mps11-pmic" },
+	{ .compatible = "samsung,s2mps11-pmic", .data = VARIANT_S2MPS11 },
 	{ }
 };
 
diff --git a/include/power/s2mps11.h b/include/power/s2mps11.h
index 22b38fff7032b510d646dac4e7f00723727d8d06..c08bea5a516a8a48e8ffea993e28df158da026a3 100644
--- a/include/power/s2mps11.h
+++ b/include/power/s2mps11.h
@@ -161,4 +161,9 @@ enum {
 	OP_ON,
 };
 
+enum {
+	VARIANT_NONE,
+	VARIANT_S2MPS11,
+};
+
 #endif

-- 
2.51.0

