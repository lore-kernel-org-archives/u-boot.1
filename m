Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828A3CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 13:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA46848CE;
	Sat, 23 May 2026 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VfKbofSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94EEC848B6; Sat, 23 May 2026 15:04:36 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B26584881
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 15:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+federico.izzo.pro@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7989343683;
 Sat, 23 May 2026 13:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 525FDC2BCC4;
 Sat, 23 May 2026 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779541472;
 bh=9yceUti7c/VMk/vBEQ0ku2RNQEtukfCqUPnZFiBCZ40=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=VfKbofSKil1q5DQ+UT6dFQO5O3kEutGW0oKwRNqcwooHR7HxeGz2Ryys42Kh4pL3+
 W1yXXVCp98sqNnwPvHZByKo4OEpuHmaHqmXfz2zZ6leE/8hGsf9MLFvSMecAXEKgbt
 8UJoZFELOQOrTAYXBlly+CMiNjkEd5FRitSMye2xTiJqv4pDjebIlgkjYg488QIrqp
 1QnZIqoegyLNoLF6V/dm92lE6REOh5sxZ0M58mKUMfcdX1EWKH8WjQDqaM8AlIv446
 GNS1G217lsGkjIgda3Q2nnaMM5i6CEyqy6tUdTFxv/E2GorGP2g3cPk9DqdGa7IzXN
 ind5hjSyajpvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECE9CD5BAC;
 Sat, 23 May 2026 13:04:32 +0000 (UTC)
From: Federico Amedeo Izzo via B4 Relay <devnull+federico.izzo.pro@kernel.org>
Date: Sat, 23 May 2026 15:04:24 +0200
Subject: [PATCH v4 1/2] regulator: qcom-rpmh-regulator: fix regulator mode
 mismatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-qcom-ufs-regulator-support-v4-1-45639533b06d@izzo.pro>
References: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
In-Reply-To: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779541471; l=4160;
 i=federico@izzo.pro; s=20251017; h=from:subject:message-id;
 bh=gIA86klRMSfHRKLYFrFp1T+qxtIMBgdBtmC5m0tq2AE=;
 b=1qGgd4Gw7UcodrxhQP+CDV1WCTEy7QAKjpEDxhDapR8Aa+cPoTn8oEcoQ0KOXFiaqGfbO5gIL
 qYBchOfjyffCLuv/ICrHsmiYQPZAQBlcKAflDwk3+vJOk0niaQBSAjS
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

Initial regulator mode was read from dts but never applied.
This caused a mismatch between saved mode and actual regulator mode.

Apply the current mode from priv->mode during enable() and move
rpmh_regulator_vrm_set_mode function before rpmh_regulator_set_enable_state().

Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 106 ++++++++++++++------------
 1 file changed, 56 insertions(+), 50 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 4d65aae1690..f789b5b6f86 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -295,6 +295,56 @@ static int rpmh_regulator_vrm_get_value(struct udevice *rdev)
 	return vreg->uv;
 }
 
+static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
+					      unsigned int mode, bool bypassed)
+{
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
+	};
+	struct dm_regulator_mode *pmic_mode;
+	int i;
+
+	if (mode > REGULATOR_MODE_HPM)
+		return -EINVAL;
+
+	for (i = 0; i < vreg->hw_data->n_modes; i++) {
+		pmic_mode = &vreg->hw_data->pmic_mode_map[i];
+		if (pmic_mode->id == mode)
+			break;
+	}
+	if (pmic_mode->id != mode) {
+		printf("Invalid mode %d\n", mode);
+		return -EINVAL;
+	}
+
+	if (bypassed)
+		// XXX: should have a version check for PMIC4 but we don't have any yet
+		// and we don't use bypass mode
+		cmd.data = PMIC5_BOB_MODE_PASS;
+	else
+		cmd.data = pmic_mode->register_value;
+
+	return rpmh_regulator_send_request(vreg, &cmd, true);
+}
+
+static int rpmh_regulator_vrm_set_mode(struct udevice *rdev,
+				       int mode)
+{
+	struct rpmh_vreg *vreg = dev_get_priv(rdev);
+	int ret;
+
+	debug("%s: set_mode %d (current %d)\n", rdev->name, mode, vreg->mode);
+
+	if (mode == vreg->mode)
+		return 0;
+
+	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, mode, vreg->bypassed);
+	if (!ret)
+		vreg->mode = mode;
+
+	return ret;
+}
+
 static int rpmh_regulator_is_enabled(struct udevice *rdev)
 {
 	struct rpmh_vreg *vreg = dev_get_priv(rdev);
@@ -331,6 +381,12 @@ static int rpmh_regulator_set_enable_state(struct udevice *rdev,
 	debug("%s: set_enable %d (current %d)\n", rdev->name, enable,
 	      vreg->enabled);
 
+	if (vreg->mode != -EINVAL) {
+		ret = rpmh_regulator_vrm_set_mode_bypass(vreg, vreg->mode, vreg->bypassed);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (vreg->enabled == -EINVAL &&
 	    vreg->uv != -ENOTRECOVERABLE) {
 		ret = _rpmh_regulator_vrm_set_value(rdev,
@@ -346,56 +402,6 @@ static int rpmh_regulator_set_enable_state(struct udevice *rdev,
 	return ret;
 }
 
-static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
-					      unsigned int mode, bool bypassed)
-{
-	struct tcs_cmd cmd = {
-		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
-	};
-	struct dm_regulator_mode *pmic_mode;
-	int i;
-
-	if (mode > REGULATOR_MODE_HPM)
-		return -EINVAL;
-
-	for (i = 0; i < vreg->hw_data->n_modes; i++) {
-		pmic_mode = &vreg->hw_data->pmic_mode_map[i];
-		if (pmic_mode->id == mode)
-			break;
-	}
-	if (pmic_mode->id != mode) {
-		printf("Invalid mode %d\n", mode);
-		return -EINVAL;
-	}
-
-	if (bypassed)
-		// XXX: should have a version check for PMIC4 but we don't have any yet
-		// and we don't use bypass mode
-		cmd.data = PMIC5_BOB_MODE_PASS;
-	else
-		cmd.data = pmic_mode->register_value;
-
-	return rpmh_regulator_send_request(vreg, &cmd, true);
-}
-
-static int rpmh_regulator_vrm_set_mode(struct udevice *rdev,
-				       int mode)
-{
-	struct rpmh_vreg *vreg = dev_get_priv(rdev);
-	int ret;
-
-	debug("%s: set_mode %d (current %d)\n", rdev->name, mode, vreg->mode);
-
-	if (mode == vreg->mode)
-		return 0;
-
-	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, mode, vreg->bypassed);
-	if (!ret)
-		vreg->mode = mode;
-
-	return ret;
-}
-
 static int rpmh_regulator_vrm_get_pmic_mode(struct rpmh_vreg *vreg, int *pmic_mode)
 {
 	struct tcs_cmd cmd = {

-- 
2.54.0


