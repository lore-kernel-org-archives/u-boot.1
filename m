Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABF6C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAE083A3B;
	Thu, 10 Apr 2025 10:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a4hQHTRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC9D83A32; Thu, 10 Apr 2025 10:00:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DFF83A30
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D245F5C3EDC;
 Thu, 10 Apr 2025 07:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A87C4CEDD;
 Thu, 10 Apr 2025 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744272045;
 bh=cH3LcRo+80HLAgx/CLp7hPKDvh4S6VkdY6wR1IOElGs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a4hQHTRcUo8FbHxZpkncPPm67GAM4b26W2hVUEl0jgpkv74vqHRmaMMQEOhatg12Z
 x2AKn901f5Lxps8EZV2HlBiUaQCT74WvbmUDou93LkkLMObethycMFxwNi7b61eiqK
 i3cnKHmv1TQTbhLjqkqBcaxWUqyDPRUrOSjIX7X0m+SfJZl0ABk/nxocJIZ6CV12MI
 TwE89d2Vge4CqUKSb4IGjJ3C3CZyAEjdOQxPDAGiopiu4hxTvDhQOIF+0W53n3/JTJ
 JblVhqZSAacm20XTtzgg8mQtPOpSjSWEwjsKhnflSRfqGlIZTPKsefGDKn2aqnU+6r
 NVIgR7myA4pfA==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 alexeymin@postmarketos.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 2/2] phy: phy-qcom-qusb2: Fix USB PHY power on sequence
Date: Thu, 10 Apr 2025 13:30:27 +0530
Message-ID: <20250410080027.208674-3-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410080027.208674-1-sumit.garg@kernel.org>
References: <20250410080027.208674-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Recent addition of support for SDM660 inadvertently broke USB PHY power
on sequence on RB1/RB2 and others with following error:

starting USB...
Bus usb@4e00000: QUSB2PHY pll lock failed: status reg = 0
qcom-qusb2-phy phy@1613000: PHY: Failed to power on phy@1613000: -16.
Can't power on PHY0
probe failed, error -16
No USB controllers found

The root cause was the addition of flag se_clk_scheme_default which was
configured correctly for SDM660 but incorrect for all other supported
SoC. Fix that by properly assignment as per upstream Linux driver.

Fixes: 475497dc3c15 ("phy: Add SDM660 support to Qualcomm QUSB2 phy")
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index cabd05bf5a6..d98f6108e69 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -230,6 +230,7 @@ static const struct qusb2_phy_cfg sm6115_phy_cfg = {
 	.regs = sm6115_regs_layout,
 
 	.has_pll_test = true,
+	.se_clk_scheme_default = true,
 	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
 	.mask_core_ready = PLL_LOCKED,
 	.autoresume_en = BIT(3),
@@ -256,6 +257,7 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 			 POWER_DOWN),
 	.mask_core_ready = CORE_READY_STATUS,
 	.has_pll_override = true,
+	.se_clk_scheme_default = true,
 	.autoresume_en = BIT(0),
 	.update_tune1_with_efuse = true,
 };
-- 
2.43.0

