Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BB8CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1911E84886;
	Thu, 21 May 2026 21:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fT3IUIAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAAD84825; Thu, 21 May 2026 20:39:51 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844D784879
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+federico.izzo.pro@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BA5E244561;
 Thu, 21 May 2026 18:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CF7CC2BCB8;
 Thu, 21 May 2026 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779388784;
 bh=wGEaylk1gGcuy5ouCqYA+6dthSbGic4BMSkMepjwGQo=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=fT3IUIAV4PotHk9P48334erH6tWyh5mrPDfHAKkw3ENeJBYFVq7bpBMXWgr2fj0VH
 szly9WK60BDuHKGzpQUVriQLoBL/b40/4k7YlBok1BZzal0akq9gzi5OOzrxEe7CjJ
 xGbcH1jcTIT1vkVo70dpTIy6aDFzx7ZM8vX4KedoyK7htIesHBzjeiV+hOvSC0u0Jg
 FkOZP5eSQZQqckA0VvsowRYfVUkq3jPxXu45txNaD/tNL4PHWmlh6mHB/qV4xb6Suk
 SgWCe6hZ/uu33TyyI1jMZmC7qpdI0sXySDhN3wSMiFKhxz7NCGd8uJmCvTeArby+aG
 SEinBy2OyhwWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 761D7CD4F3D;
 Thu, 21 May 2026 18:39:44 +0000 (UTC)
From: Federico Amedeo Izzo via B4 Relay <devnull+federico.izzo.pro@kernel.org>
Date: Thu, 21 May 2026 20:39:30 +0200
Subject: [PATCH] ufs: qcom: Add UFS host regulator support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dpu-add-dspp-gc-driver-v1-1-83372488cdcf@izzo.pro>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm0yM4mIXIW4gLZgWeCkFWJCu
 LujLN/i/x1cTMWhrXYw2dT1tRTESwX07JdJULkYUkh1uKaInFfsmZE9Z5wI2XQTw0B3oWYIY0w
 3KHE2GfXzH3eP074Os9D7d4Pj+AKKzVFXegAAAA==
X-Change-ID: 20260521-dpu-add-dspp-gc-driver-0c9ec8b0f127
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Federico Amedeo Izzo <federico@izzo.pro>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779388783; l=3453;
 i=federico@izzo.pro; s=20251017; h=from:subject:message-id;
 bh=kImFQ15hiUAyNumZVACuN2HK3ivvLJIDhRhAaCelwwI=;
 b=JHF21JXVprnUPrVb2djGiLTwC1pNU3JRCqM4KXHyKHcALuCY9MRAPi1+xTuOTR7bzOkQhaVm2
 Tw3r0vAi11HC0gtKX/D7H7/C3xrOrJ7oQea8POREjiQDyG1db9Lrgb6
X-Developer-Key: i=federico@izzo.pro; a=ed25519;
 pk=XfmNfpH48k8jLbId5NKrp0yoKoFb/uLjr97qIxBImBw=
X-Endpoint-Received: by B4 Relay for federico@izzo.pro/20251017 with
 auth_id=544
X-Original-From: Federico Amedeo Izzo <federico@izzo.pro>
X-Mailman-Approved-At: Thu, 21 May 2026 21:11:12 +0200
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
Reply-To: federico@izzo.pro
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Federico Amedeo Izzo <federico@izzo.pro>

The qcom UFS driver works without touching the regulators on most platforms
as ABL leaves them already configured and enabled.
On some SC7280 phones with UFS 3.1 like nothing-spacewar, vcc regulator is
not enabled by ABL, so we need to configure and enable it to use the UFS
storage.

Tested on nothing-spacewar and motorola-dubai using Tauchgang U-Boot.

Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
---
Add support to qcom-ufs driver for vcc-supply and vccq-supply
regulators to enable UFS support on SC7280 devices with UFS3.1.
SC7280 devices with UFS2.2 were already working.

The root cause was ABL leaving vcc-supply regulator disabled on UFS3.1
devices, and enabled on UFS2.2 devices that worked fine without
regulator support.

The tricky part was enabling the regulator in HPM mode (3), which required
setting LPM mode (1) first, otherwise reg would stay in LPM mode.
I discovered this by changing the regulator settings from U-Boot
console. Enabling the regulator in LPM mode resets the phone.
---
 drivers/ufs/ufs-qcom.c | 22 +++++++++++++++++++++-
 drivers/ufs/ufs-qcom.h |  3 +++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index dc40ee62daf..6c4599a6453 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <generic-phy.h>
 #include <asm/gpio.h>
 #include <interconnect.h>
+#include <power/regulator.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -557,10 +558,21 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
 static int ufs_qcom_init(struct ufs_hba *hba)
 {
 	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
-	int err;
+	int ret, err;
 
 	priv->hba = hba;
 
+	/* Set regulator to LPM mode first otherwise HPM does not get applied */
+	ret = regulator_set_mode(priv->vcc, 1);
+	ret = regulator_set_mode(priv->vcc, 3);
+	ret = regulator_set_enable(priv->vcc, true);
+	if (ret && ret != -ENOSYS)
+		dev_warn(hba->dev, "failed to enable regulator vcc-supply:%d\n", ret);
+
+	ret = regulator_set_enable(priv->vccq, true);
+	if (ret && ret != -ENOSYS)
+		dev_warn(hba->dev, "failed to enable regulator vccq-supply:%d\n", ret);
+
 	/* setup clocks */
 	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
 
@@ -651,6 +663,14 @@ static int ufs_qcom_probe(struct udevice *dev)
 		dev_err(dev, "Warning: cannot get reset GPIO\n");
 	}
 
+	ret = device_get_supply_regulator(dev, "vcc-supply", &priv->vcc);
+	if (ret)
+		dev_warn(dev, "failed to get regulator vcc-supply:%d\n", ret);
+
+	ret = device_get_supply_regulator(dev, "vccq-supply", &priv->vccq);
+	if (ret)
+		dev_warn(dev, "failed to get regulator vccq-supply:%d\n", ret);
+
 	ret = ufshcd_probe(dev, &ufs_qcom_hba_ops);
 	if (ret) {
 		dev_err(dev, "ufshcd_probe() failed, ret:%d\n", ret);
diff --git a/drivers/ufs/ufs-qcom.h b/drivers/ufs/ufs-qcom.h
index de957ae60f3..4e502e7b3ca 100644
--- a/drivers/ufs/ufs-qcom.h
+++ b/drivers/ufs/ufs-qcom.h
@@ -134,6 +134,9 @@ struct ufs_qcom_priv {
 	struct clk_bulk clks;
 	bool is_clks_enabled;
 
+	struct udevice *vcc;
+	struct udevice *vccq;
+
 	struct ufs_hw_version hw_ver;
 
 	/* Reset control of HCI */

---
base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
change-id: 20260521-dpu-add-dspp-gc-driver-0c9ec8b0f127

Best regards,
--  
Federico Amedeo Izzo <federico@izzo.pro>


