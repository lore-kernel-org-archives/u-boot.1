Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FA6D2F7F2
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 06:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C305B88FA4;
	Thu, 17 Oct 2024 08:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vfnkH39/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD9488FA4; Thu, 17 Oct 2024 08:37:51 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951E488EFA
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 08:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bjT2042446;
 Thu, 17 Oct 2024 01:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729147065;
 bh=ZXfcSdowm1pIO6EAZ61DqFuDtTBKuaibx4dBOoUhF1U=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vfnkH39/KtHA3SK8EuL5ZtHVsxv6LmUCGg1dSkGKSNyVcbDqo78SmdH95UXaZ51R9
 FtTeUhWVgm+brsMzXZckkUXPvNZOAHUpc6oIv3NOuG8Y2pvPh7nlKS6cNSWtDp81Q7
 cYy1rByzXo/3c10HLazBsayIAJlqzhxQmIM2psYg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49H6bjOQ011952
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Oct 2024 01:37:45 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 01:37:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 01:37:45 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bFOZ090460;
 Thu, 17 Oct 2024 01:37:43 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 6/6] DONOTMERGE: For testing only
Date: Thu, 17 Oct 2024 11:59:13 +0530
Message-ID: <20241017062911.2241167-7-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017062911.2241167-1-a-limaye@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Reid Tonking <reidt@ti.com>

This just provides some useful print outs and the proper config to
test the functionality. For J7200 boards that do not have efuse
burned in, the hardcoded 760000 is needed in the vd_data, since
it would be populated otherwise

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/mach-k3/j721e/j721e_init.c | 9 +++++++++
 configs/j7200_evm_r5_defconfig      | 2 +-
 drivers/misc/k3_avs.c               | 4 +++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index 0620759c36c..19865f7dd40 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -152,6 +152,8 @@ int fix_freq(const void *fdt)
 {
 		int node, ret;
 		u32 opp_low_freq[3];
+		int len;
+		const u32 *reg;
 
 		node = fdt_node_offset_by_compatible(fdt, -1, "ti,am654-rproc");
 			if (node < 0) {
@@ -159,6 +161,11 @@ int fix_freq(const void *fdt)
 				return node;
 			}
 
+		/* check freqs */
+		reg = fdt_getprop(fdt, node, "assigned-clock-rates", &len);
+		printf("OPP_NOM: arm_clk:%d | gtc_clk:%d | msmc_clk:%d\n",
+				fdt32_to_cpu(reg[0]), fdt32_to_cpu(reg[1]), fdt32_to_cpu(reg[2]));
+
 		/* j7200 opp low values according to data sheet */
 		opp_low_freq[0] = cpu_to_fdt32(1000000000); /* 202-2 -> A72SS0_CORE0_0_ARM_CLK */
 		opp_low_freq[1] = cpu_to_fdt32(200000000); /* 61-1 -> GTC0_GTC_CLK */
@@ -170,6 +177,8 @@ int fix_freq(const void *fdt)
 				printf("%s: Can not set value\n", __func__);
 				return ret;
 			}
+		printf("OPP_LOW: arm_clk:%d | gtc_clk:%d | msmc_clk:%d\n",
+				fdt32_to_cpu(opp_low_freq[0]), fdt32_to_cpu(opp_low_freq[1]), fdt32_to_cpu(opp_low_freq[2]));
 
 		return 0;
 }
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 7d43d8d702a..6fdf34c9644 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -103,7 +103,7 @@ CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
 CONFIG_K3_AVS0=y
-# CONFIG_K3_OPP_LOW is not set
+CONFIG_K3_OPP_LOW=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 932b355a5c1..e93aa267d51 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -121,6 +121,8 @@ static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
 	if (!vd->supply)
 		return -ENODEV;
 
+  printf("Program voltage: opp_id:%d | opp_volt:%d\n", opp_id, volt);
+
 	if (!volt) {
 		dev_err(priv->dev, "Fuse is not set for selected opp %d\n", opp_id);
 		return -EINVAL;
@@ -532,7 +534,7 @@ static struct vd_data j721e_vd_data[] = {
 		.clk_id = 2, /* ARM clock */
 		.opps = {
 			[AM6_OPP_LOW] = {
-				.volt = 0, /* voltage TBD after OPP fuse reading */
+				.volt = 760000, /* voltage TBD after OPP fuse reading */
 				.freq = 1000000000,
 			},
 			[AM6_OPP_NOM] = {
-- 
2.34.1

