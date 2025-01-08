Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2145E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F59080613;
	Wed,  8 Jan 2025 16:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="OlDiRb2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FCB8006D; Wed,  8 Jan 2025 13:00:38 +0100 (CET)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E242880040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 13:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1736337634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2Gast1UXXQjKLlJqyrzLp/kI2AyWZ6kxao2B7V8gT0=;
 b=OlDiRb2Weex4JJruffYMK68ZiKU+5pfpTDngFndm6B1JZAdRlc+SAJCXn0uyfKtY+ltWxq
 1ykdxJZMZ9uPhC+/1i8qvqv8HhWnV36fMGHZkXEh0YktCxRmcSBFGsbD01ly9ZXhle02AY
 i/DsIY/HXsuWxAExzheDKw0FCLoVBB8zN3KdSijLJm41KQ9vcIyQ1V/a8hEL3aEs4PBbmG
 sjXgcyxVftUKW3pgy68Ze/1WcBtRdFqzX+2zMIvYwsvoLHR4UftTCAnN6zn19gltzTg3QG
 nmyceUWoXKmwD1wDMZOxDosdWFYFxPgcYMP4LLWq+zANVGII/BnaPbK9BH9S+Q==
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH 3/4] clk/qcom: Port to new GDSC flags
Date: Wed,  8 Jan 2025 14:59:10 +0300
Message-ID: <20250108115911.4163437-3-alexeymin@postmarketos.org>
In-Reply-To: <20250108115911.4163437-1-alexeymin@postmarketos.org>
References: <20250108115911.4163437-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:48:26 +0100
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

Now we need to specify flags for each GDSC for it to function properly.
Copy .flags field from respective Linux GCC driver.

Turns out, even among SDM845 not all GDSCs are the same. Some of GDSCs
do specify the POLL_CFG_GDSCR flag that changes the logic to check the
ON/OFF status, other don't.

Some qcom clock drivers in U-Boot don't specify any GDSCs at all
(apq8016, apq8096, ipq4019, qcs404), or GDSCs in their linux GCC driver
don't specify any flags (qcm2290, sm6115) thus making them unaffected
by this change.

Add flags to all other SoC's GDSCs currently present in U-Boot that do
need this change.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 drivers/clk/qcom/clock-sc7280.c |  4 ++--
 drivers/clk/qcom/clock-sdm845.c | 26 +++++++++++++-------------
 drivers/clk/qcom/clock-sm8150.c | 14 +++++++-------
 drivers/clk/qcom/clock-sm8550.c | 16 ++++++++--------
 drivers/clk/qcom/clock-sm8650.c | 16 ++++++++--------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 5d343f120519..cacad0eda164 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -98,8 +98,8 @@ static const struct qcom_reset_map sc7280_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sc7280_gdscs[] = {
-	[GCC_UFS_PHY_GDSC] = { 0x77004 },
-	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
+	[GCC_UFS_PHY_GDSC] = { 0x77004, .flags = VOTABLE },
+	[GCC_USB30_PRIM_GDSC] = { 0xf004, .flags = VOTABLE },
 };
 
 static struct msm_clk_data qcs404_gcc_data = {
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index adffb0cb2402..53068bd3baa4 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -188,19 +188,19 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sdm845_gdscs[] = {
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[UFS_CARD_GDSC] = { 0x75004 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[USB30_PRIM_GDSC] = { 0xf004 },
-	[USB30_SEC_GDSC] = { 0x10004 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { 0x7d03c },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
+	[PCIE_0_GDSC] = { 0x6b004, .flags = POLL_CFG_GDSCR },
+	[PCIE_1_GDSC] = { 0x8d004, .flags = POLL_CFG_GDSCR },
+	[UFS_CARD_GDSC] = { 0x75004, .flags = POLL_CFG_GDSCR },
+	[UFS_PHY_GDSC] = { 0x77004, .flags = POLL_CFG_GDSCR },
+	[USB30_PRIM_GDSC] = { 0xf004, .flags = POLL_CFG_GDSCR },
+	[USB30_SEC_GDSC] = { 0x10004, .flags = POLL_CFG_GDSCR },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { 0x7d03c, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044, .flags = VOTABLE },
 };
 
 static const phys_addr_t sdm845_gpll_addrs[] = {
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
index 88f2e678f43c..3bff73de0481 100644
--- a/drivers/clk/qcom/clock-sm8150.c
+++ b/drivers/clk/qcom/clock-sm8150.c
@@ -281,13 +281,13 @@ static const struct qcom_reset_map sm8150_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sm8150_gcc_power_domains[] = {
-	[EMAC_GDSC] = { 0x6004 },
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[UFS_CARD_GDSC] = { 0x75004 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[USB30_PRIM_GDSC] = { 0xf004 },
-	[USB30_SEC_GDSC] = { 0x10004 },
+	[EMAC_GDSC] = { 0x6004, .flags = POLL_CFG_GDSCR },
+	[PCIE_0_GDSC] = { 0x6b004, .flags = POLL_CFG_GDSCR },
+	[PCIE_1_GDSC] = { 0x8d004, .flags = POLL_CFG_GDSCR },
+	[UFS_CARD_GDSC] = { 0x75004, .flags = POLL_CFG_GDSCR },
+	[UFS_PHY_GDSC] = { 0x77004, .flags = POLL_CFG_GDSCR },
+	[USB30_PRIM_GDSC] = { 0xf004, .flags = POLL_CFG_GDSCR },
+	[USB30_SEC_GDSC] = { 0x10004, .flags = POLL_CFG_GDSCR },
 };
 
 static struct msm_clk_data sm8150_clk_data = {
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
index c0249925cc7e..d8368688afaa 100644
--- a/drivers/clk/qcom/clock-sm8550.c
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -229,14 +229,14 @@ static const struct qcom_reset_map sm8550_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sm8550_gdscs[] = {
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_0_PHY_GDSC] = { 0x6c000 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[PCIE_1_PHY_GDSC] = { 0x8e000 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
-	[USB30_PRIM_GDSC] = { 0x39004 },
-	[USB3_PHY_GDSC] = { 0x50018 },
+	[PCIE_0_GDSC] = { 0x6b004, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[PCIE_0_PHY_GDSC] = { 0x6c000, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[PCIE_1_GDSC] = { 0x8d004, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[PCIE_1_PHY_GDSC] = { 0x8e000, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[UFS_PHY_GDSC] = { 0x77004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[UFS_MEM_PHY_GDSC] = { 0x9e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB30_PRIM_GDSC] = { 0x39004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB3_PHY_GDSC] = { 0x50018, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
 };
 
 static struct msm_clk_data sm8550_gcc_data = {
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
index 0ce83e9b2437..e5b8e6a10be3 100644
--- a/drivers/clk/qcom/clock-sm8650.c
+++ b/drivers/clk/qcom/clock-sm8650.c
@@ -226,14 +226,14 @@ static const struct qcom_reset_map sm8650_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sm8650_gdscs[] = {
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_0_PHY_GDSC] = { 0x6c000 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[PCIE_1_PHY_GDSC] = { 0x8e000 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
-	[USB30_PRIM_GDSC] = { 0x39004 },
-	[USB3_PHY_GDSC] = { 0x50018 },
+	[PCIE_0_GDSC] = { 0x6b004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[PCIE_0_PHY_GDSC] = { 0x6c000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[PCIE_1_GDSC] = { 0x8d004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[PCIE_1_PHY_GDSC] = { 0x8e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[UFS_PHY_GDSC] = { 0x77004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[UFS_MEM_PHY_GDSC] = { 0x9e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB30_PRIM_GDSC] = { 0x39004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB3_PHY_GDSC] = { 0x50018, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
 };
 
 static struct msm_clk_data sm8650_gcc_data = {
-- 
2.45.2

