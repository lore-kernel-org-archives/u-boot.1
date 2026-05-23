Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90821CD5BBF
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 13:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7314E848B3;
	Sat, 23 May 2026 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sfOg13g5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17006846CF; Sat, 23 May 2026 12:26:09 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C38844CF
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 12:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+federico.izzo.pro@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DAA543ACE;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75C78C2BCC6;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779531962;
 bh=C2DHT50jhzpe6aVB4HEDp4fjFDxszRK3KqOaDpo80Ck=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=sfOg13g5AAk37RwQe6BgPansF+RtXlx22O5KHNE3N7u3gHIQ5jxkMf/juMPL6nnHL
 ea9DB6fwbwEpc3FvZPSY9zfV87WS6ggqPQjDur4AMOK2CFbBFLgx9NM4uABmwJxdin
 trVbwiKGhikal0GC0H+mnPCrT+q4dcpvpViP1L777mJsni+wVOR5F1P/yCxwB4Mp1o
 2VqFV7MN56Rl6C8Q2L60bWsHXiMWQ2FVMn9vZQECDGbW/or6o8HpJVIJ0PfmoR1HmF
 1yQjiSGUMzZnMfOJRTb3UqZex3+F7aQDKL6YGMaWsH5Me8jdlhNLKqx+4bSSpwNuIr
 vGtIv4PVVcxjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 617AFCD5BAC;
 Sat, 23 May 2026 10:26:02 +0000 (UTC)
From: Federico Amedeo Izzo via B4 Relay <devnull+federico.izzo.pro@kernel.org>
Date: Sat, 23 May 2026 12:25:52 +0200
Subject: [PATCH v3 2/2] ufs: qcom: add ufs host regulator support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-qcom-ufs-regulator-support-v3-2-1be2a80a2577@izzo.pro>
References: <20260523-qcom-ufs-regulator-support-v3-0-1be2a80a2577@izzo.pro>
In-Reply-To: <20260523-qcom-ufs-regulator-support-v3-0-1be2a80a2577@izzo.pro>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779531961; l=3104;
 i=federico@izzo.pro; s=20251017; h=from:subject:message-id;
 bh=P+cGFj4YFRvaiYLl3OlzTsjPTMmktRwICoqneTQvwJY=;
 b=Nxe+dJV+W2Ia4tQZ4YGRhz66VSthJDMm92tAs14VUqjfw+G0sug54f/ZTp7hHV5e53/5mH0r0
 7gnNxV6iVK/A4ycWPvtGBLzxtarYjHBJnEk4sK79PnakBAYwNNf4jBQ
X-Developer-Key: i=federico@izzo.pro; a=ed25519;
 pk=XfmNfpH48k8jLbId5NKrp0yoKoFb/uLjr97qIxBImBw=
X-Endpoint-Received: by B4 Relay for federico@izzo.pro/20251017 with
 auth_id=544
X-Original-From: Federico Amedeo Izzo <federico@izzo.pro>
X-Mailman-Approved-At: Sat, 23 May 2026 15:58:45 +0200
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
 drivers/ufs/ufs-qcom.c | 33 +++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-qcom.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index dc40ee62daf..376be2eeaaf 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <generic-phy.h>
 #include <asm/gpio.h>
 #include <interconnect.h>
+#include <power/regulator.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -557,10 +558,31 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
 static int ufs_qcom_init(struct ufs_hba *hba)
 {
 	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	int mode;
 	int err;
 
 	priv->hba = hba;
 
+	/* Apply regulator initial-mode from dts */
+	err = dev_read_u32(priv->vcc, "regulator-initial-mode", &mode);
+	if (!err) {
+		err = regulator_set_mode(priv->vcc, mode);
+		if (err && err != -ENOSYS)
+			dev_warn(hba->dev, "failed to set vcc-supply mode:%d\n", err);
+	}
+
+	err = regulator_set_enable(priv->vcc, true);
+	if (err && err != -ENOSYS)
+		dev_warn(hba->dev, "failed to enable regulator vcc-supply:%d\n", err);
+
+	err = regulator_set_enable(priv->vccq, true);
+	if (err && err != -ENOSYS)
+		dev_warn(hba->dev, "failed to enable regulator vccq-supply:%d\n", err);
+
+	err = regulator_set_enable(priv->vccq2, true);
+	if (err && err != -ENOSYS)
+		dev_warn(hba->dev, "failed to enable regulator vccq2-supply:%d\n", err);
+
 	/* setup clocks */
 	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
 
@@ -651,6 +673,17 @@ static int ufs_qcom_probe(struct udevice *dev)
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
+	/* vccq2 is optional on UFS2 and missing on UFS3 and later */
+	device_get_supply_regulator(dev, "vccq2-supply", &priv->vccq2);
+
 	ret = ufshcd_probe(dev, &ufs_qcom_hba_ops);
 	if (ret) {
 		dev_err(dev, "ufshcd_probe() failed, ret:%d\n", ret);
diff --git a/drivers/ufs/ufs-qcom.h b/drivers/ufs/ufs-qcom.h
index de957ae60f3..115565db7e9 100644
--- a/drivers/ufs/ufs-qcom.h
+++ b/drivers/ufs/ufs-qcom.h
@@ -134,6 +134,10 @@ struct ufs_qcom_priv {
 	struct clk_bulk clks;
 	bool is_clks_enabled;
 
+	struct udevice *vcc;
+	struct udevice *vccq;
+	struct udevice *vccq2;
+
 	struct ufs_hw_version hw_ver;
 
 	/* Reset control of HCI */

-- 
2.54.0


