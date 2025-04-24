Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4390DC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17618056A;
	Thu, 24 Apr 2025 14:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ABCF8070C; Thu, 24 Apr 2025 03:51:39 +0200 (CEST)
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF888056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 03:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@minlexx.ru
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (envelope-from <alexeymin@minlexx.ru>) id 1u7lkU-0000000049X-3PNu;
 Thu, 24 Apr 2025 04:51:34 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Alexey Minnekhanov <alexeymin@minlexx.ru>
Subject: [PATCH] button: qcom-pmic: allow to specify code in devicetree
Date: Thu, 24 Apr 2025 04:48:11 +0300
Message-ID: <20250424014811.3809818-1-alexeymin@minlexx.ru>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Apr 2025 14:39:53 +0200
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

From: Alexey Minnekhanov <alexeymin@postmarketos.org>

Most device vendors put "Volume Down" button onto PMIC RESIN.
But Sony is special: see
dts/upstream/src/arm64/qcom/sdm630-sony-xperia-nile.dtsi or [1].
They put "Volume Down" on PMIC GPIO 7 where others usually put
"Volume Up", and KEY_VOLUMEUP is inside &pon_resin.

Currently if you boot U-Boot on such Sony device, you end up
with 2 "Volume Down" buttons, and no "Volume Up", which makes
navigating menu problematic.

Support reading devicetree "linux,code" property and override
statically defined button code & label based on that.

[1] https://elixir.bootlin.com/linux/v6.15-rc3/source/arch/
arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi#L263

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
---
 drivers/button/button-qcom-pmic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index e3bb9bd758a..85addfe32a2 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -143,6 +143,21 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 
 	priv->base = base;
 
+	ret = dev_read_u32(dev, "linux,code", &priv->code);
+	if (ret == 0) {
+		/* convert key, if read OK */
+		switch (priv->code) {
+		case KEY_VOLUMEDOWN:
+			priv->code = KEY_DOWN;
+			uc_plat->label = "Volume Down";
+			break;
+		case KEY_VOLUMEUP:
+			priv->code = KEY_UP;
+			uc_plat->label = "Volume Up";
+			break;
+		}
+	}
+
 	/* Do a sanity check */
 	ret = pmic_reg_read(priv->pmic, priv->base + REG_TYPE);
 	if (ret != 0x1 && ret != 0xb) {
-- 
2.49.0

