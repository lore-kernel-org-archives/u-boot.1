Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF1CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A9C839B9;
	Fri, 17 Oct 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TblBx8v4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B9483826; Fri, 17 Oct 2025 17:29:08 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2509383826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E01F922C39;
 Fri, 17 Oct 2025 17:29:06 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B47xghEigQOp; Fri, 17 Oct 2025 17:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714946; bh=s7ob13IRHpQiVcg6nSJXqSGs1JEb9Lz3puls4kbDCEk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TblBx8v4J1ov5ZX10qDVmRlAkkQkejkjdulnZMS59pHocIQHQuto2om2Ctu58QhYp
 vjHUurzNT3HsNNUT/e87qu9KxnIxVCdTf0xlbPR0Eod1L2wYKaBiPwa28pK2UCyIOW
 zYYqal8L0Gwj8fZ+tck64GHqfA9+4nDRL7vHY0wAlqILIio/GHPlT5RcZcAFU3mLnE
 AjiExV5jnW11xcwbV/YnstTt/xUTu4dSql/jYiJEFdGouw5L1w0wyX5Brtz1HfcigB
 wPkaUOhELMRtDsPVpqJM3U/QCYHYMxWPnE8LLpBXx8XbVsKt6NJn/iPMHNx39nX6z/
 032qP5bVFcKBw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:58:21 +0530
Subject: [PATCH 6/6] power: pmic: s2mps11: add support for Samsung S2MPU05 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-power-pmic-regulator-s2mpu05-v1-6-91cadc0f4156@disroot.org>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714904; l=1814;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=s7ob13IRHpQiVcg6nSJXqSGs1JEb9Lz3puls4kbDCEk=;
 b=xcp8w8JrifAT6E4QEjNkgfeVI6vkk26BPWFVwwUv7uZCu2dCmt866f823PemkdD9ynasq9dCw
 Lw2F2ridIBaCYD690TNwiCd3UYDHX3xPdsvxpuGtCOXhO8maQ5rOGL7
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

Samsung S2MPU05 PMIC is used in devices with the Exynos7870 SoC, it
houses voltage regulators and an RTC module. Add support for this device
variant in the driver, which also binds the corresponding voltage
regulator driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/pmic/s2mps11.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 51c98afb17b2b1a790860419b55e211b0c533685..5cf9d34ffaf8be1c05ad8ec719b7dcb6bee63d08 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -19,11 +19,19 @@ static const struct pmic_child_info s2mps11_pmic_children_info[] = {
 	{ },
 };
 
+static const struct pmic_child_info s2mpu05_pmic_children_info[] = {
+	{ .prefix = S2MPU05_OF_LDO_PREFIX, .driver = S2MPS11_LDO_DRIVER },
+	{ .prefix = S2MPU05_OF_BUCK_PREFIX, .driver = S2MPS11_BUCK_DRIVER },
+	{ },
+};
+
 static int s2mps11_reg_count(struct udevice *dev)
 {
 	switch (dev_get_driver_data(dev)) {
 	case VARIANT_S2MPS11:
 		return S2MPS11_REG_COUNT;
+	case VARIANT_S2MPU05:
+		return S2MPU05_REG_COUNT;
 	default:
 		return -EINVAL;
 	}
@@ -71,6 +79,9 @@ static int s2mps11_bind(struct udevice *dev)
 	case VARIANT_S2MPS11:
 		pmic_children_info = s2mps11_pmic_children_info;
 		break;
+	case VARIANT_S2MPU05:
+		pmic_children_info = s2mpu05_pmic_children_info;
+		break;
 	default:
 		debug("%s: unknown device type\n", __func__);
 		return -EINVAL;
@@ -91,6 +102,7 @@ static struct dm_pmic_ops s2mps11_ops = {
 
 static const struct udevice_id s2mps11_ids[] = {
 	{ .compatible = "samsung,s2mps11-pmic", .data = VARIANT_S2MPS11 },
+	{ .compatible = "samsung,s2mpu05-pmic", .data = VARIANT_S2MPU05 },
 	{ }
 };
 

-- 
2.51.0

