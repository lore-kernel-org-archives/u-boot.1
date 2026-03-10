Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB421FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F58783FE9;
	Tue, 10 Mar 2026 14:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pKEp3nEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DC783FB6; Tue, 10 Mar 2026 11:06:32 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A17F83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 11:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yke+Hd5j5t7QYwnQ23dYWJBjuREReyakjvNqB4rEEwB+zdY/4ajxJVG7HVD+VffqHzSVVSSo7roQl1s6zrTUpKkvkTpoeMJ1N9MUbfkgb+a0IbuQ3UimT6CVVAe+XeQjGeExPirF+f251se9qQ02vDD+GDcOintJLOZAZiW6coth9V1Gn8/leGnOzf4WOjP26ZnSN4KtjXXqwCFGCIINP4q31/9saABY81EWo2pLdcpK4V9lw3FDak8iG8/Z6pplsO+DuFjYaKSkkfBR+rCxzwTX5wKcQjHkU7WoXhP26tjlxOQrn0lq2XvN6Qnng/OPYsPAPrhmHAwble+2hnokbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOqXk6gvJMdvHBJAk//rUX/mzWlOgu3H8MACJqFBmgU=;
 b=uPxJ59Taj7Qa4UCmSbFPzoxXDVrPUffPVeOKDST8oMQ2ug/rN/cHvKkVtSgFjxQipypqp4Ee6qp8w48jCFcgwg3RYZCX47GdCTatMoCLT9iyz/cb49Ikw9Np8ubDQap9WtA9wNDJHQsEVuFsvVP0e2YERSCE5kJbaj63X2eCCXDxFzx+JBkdLpJ+mjCXM0Xs4KVv6CjDj8VDIWZuuJlFEKud4Hs7ZAIpN+mDgQPTyDUli/tpm3CEM+15hwUO9/4HzorjPfk9HrwpJuLI79tEFmVy7F78LxLiaKFkf9/qtR2gFpfibeH3KwtyOeuim6bUMuR9izVZfAh4oa8WZtauiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOqXk6gvJMdvHBJAk//rUX/mzWlOgu3H8MACJqFBmgU=;
 b=pKEp3nEuIORCH4SZp2wMmtMwIHselQLl7W1b9Crqm6D49xQR9Xkr1OM6V5djGv46B3gL5LxsTrbwKqHso2sRb2laK3YGf60g6Tg05FLus2Y17GmXtj2aNEaSGd1ipd8uRahx7KHCky5SRaZMDMuK0af21xE2kNT3xy5jS8whwoU=
Received: from MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24)
 by IA3PR10MB8684.namprd10.prod.outlook.com (2603:10b6:208:576::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Tue, 10 Mar
 2026 10:06:27 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::47) by MN2PR08CA0019.outlook.office365.com
 (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 10:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 10:06:26 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:25 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 05:06:25 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AA6Hr12355078;
 Tue, 10 Mar 2026 05:06:22 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <d-gole@ti.com>, <k-willis@ti.com>
Subject: [PATCH v2 1/4] ram: ti: k3-ddrss: Add workaround sequence for errata
 i2487
Date: Tue, 10 Mar 2026 15:36:11 +0530
Message-ID: <20260310100614.951573-2-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310100614.951573-1-a-kaur@ti.com>
References: <20260310100614.951573-1-a-kaur@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA3PR10MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db10ee3-8352-4a6b-8e1d-08de7e8cb121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: OePfkTj8Iom5CC5lDi8i0dyEc+Qmk8EdGGiniU1GCUpS4x0ajXRXQ5iFvOfdyU3GilPnvTjnh79p2gzI6/AhIZl1hkaP+Eek/hdYkL4puQcL6Lu5GCkfSs4f3WOKNEcg8bPG1hKMCVvEumyDs/IlEjNAQ2z+AQkxbrLpvY673fBK1OtQKssnJQFzflAv7PVVFDhwrBhdBVmecvq9s8zPS4nCSFqyLQU9jXH+Rd3nycYpiP30aLR2JOUD8fyLmoQZeGVJ+A3ay6Rzj6CzcMqKQOieCevD9Rz32jm2EhK2w7Idc8DC0DggX2jBasI+gwLvXir/Bn2JVx4TUfCOD0yL1jS2C/NPLh/cEpRi/Y2Zh+4SC53+nGHPgSjTn1CZY6JzWCJYsI0wrE/9+ORepX8Vx0piOIeV7GbARNbzVPDU8A62oS7v6wtrQbugrXyq78qCvlfOO1JQJ6AbkWen+wcqUB57b+NXIjf1IMdixDxW0D2XtovIRP7ocE5vIjNizNfGr0Kqoa/6JjlS/Iv/PaETjaVwDadnGIq2xWrkYyPhnbFKjuHHrqSw/69/PULsI8nXhL++0V/J556DXxvnmMhBY2AZ9Ni6ahJm4FPptDCJFwFCsNzYmgE8kzJlXYqJG7GCZnkVe5OTtrHTSbavWb2sTQcf/GHBHoHkls/Eoig+C1XrDg6gqk3zXGxhJsMVxQ9i6C3mERtyRr9oAXPeBHq1bB6KAbHls3qXDdjC51G7Yws=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6j/nhVmyedz+3lkBe2cVf+ge3Z2kCjBml0nOvCMlUCs7F1smzHSQudjANtZHED/0yP83sjLr6quo/RfATLFkeNeMCh8e1ixdKE5BuRyDk6n0KdorSwXEcHVG/KkNnHsWKvAMaGhv1D/aSTPIdZ9EVuBRu3nblkEid/5gncHI0HIXgo/C8ac+uIfJ+jfL3JCdqlSsbzJ5B+OKTx8R+dj69XumtgPsql/LZUb7HLBV94vpeUN6yfoufUcRLsWhVlqxubygamVeqsWfZWYEv10+iY95petY2L219bwOBt/Wpsts1zqCeM9sKYv1FVWrFJ1ljI4ecxtSOKrRXvHzyrMLMqODX+InrMWKeE/u32bvOD/3YpPUo2xMfjDtRizV8E82FvMl5VPSfV47MMxYaWIAk/FEE5IC+2gf9NdvxtnRT1rwiAxgH/rgo3zU71FnRMG+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:06:26.4078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db10ee3-8352-4a6b-8e1d-08de7e8cb121
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8684
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:02 +0100
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

As per errata i2487: "the low power modes may inadvertently corrupt
DDR contents" for AM62AX[0] and AM62PX[1].

Based on the recommendation, add SW workaround sequence to
clear data retention latch on every boot and/or abort scenarios to
make sure that latch is initialized to zero rather than unknown value.

Executing this sequence during boot helps to successfully resume the SoCs
from IO+DDR low power mode.
This sequence is executed in partial I/O resume as well as all the
other conditions when reset is issued during low power mode entry/exit
or when the SoC is in idle mode.

The sequence should be executed for SoCs that support IO+DDR mode, that
is AM62AX and AM62PX.

[0]: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
[1]: https://www.ti.com/lit/er/sprz574b/sprz574b.pdf

Tested-by Sebin Francis <sebin.francis@ti.com>
Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 80 +++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h |  1 +
 drivers/ram/k3-ddrss/k3-ddrss.c     |  5 ++
 3 files changed, 86 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
index 20181d0a876..85fceb080d2 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -25,6 +25,15 @@
 #define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT			0x43018318
 #define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
 
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL				0x43018300
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD			BIT(0)
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW			0x55555554
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK			GENMASK(31, 1)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE			0x43018310
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW			0xDD555555
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK		GENMASK(31, 0)
+
 #define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
 #define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
 #define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
@@ -51,6 +60,7 @@
 #define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
 #define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
 
+#define AM62XX_WKUP_CTRL_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS	500
 #define AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS	5000
 #define K3_DDRSS_LPM_TIMEOUT_MS				5000
 
@@ -179,3 +189,73 @@ bool am62xx_wkup_conf_boot_is_resume(void)
 		am62xx_wkup_conf_canuart_wakeup_active() &&
 		am62xx_wkup_conf_canuart_magic_word_set();
 }
+
+static void am62xx_ddrss_clear_retention_latch_and_magic_words(void)
+{
+	int ret;
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK |
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW |
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD);
+
+	ret = wait_for_bit_32((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
+			      AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      true, AM62XX_WKUP_CTRL_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS,
+			      false);
+	if (ret)
+		panic("Timeout during latch clearing sequence %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 0);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
+				 0);
+
+	ret = wait_for_bit_32((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
+			      AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false, AM62XX_WKUP_CTRL_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS,
+			      false);
+	if (ret)
+		panic("Timeout during latch clearing sequence %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
+				 0);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK,
+				 0);
+}
+
+void am62xx_ddrss_run_retention_latch_clear_sequence(void)
+{
+	/*
+	 * Workaround of errata i12487
+	 * Errata states that During entry to the Deep Sleep or RTC+IO+DDR
+	 * low-power modes, SoC may not properly transition the attached
+	 * DDR into retention mode, which will lead to corruption of the DDR
+	 * data.
+	 */
+	if (IS_ENABLED(CONFIG_K3_IODDR))
+		am62xx_ddrss_clear_retention_latch_and_magic_words();
+}
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
index 742d224327e..0b292d06138 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
@@ -16,5 +16,6 @@ void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
 void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
 void am62xx_ddrss_deassert_retention(void);
 bool am62xx_wkup_conf_boot_is_resume(void);
+void am62xx_ddrss_run_retention_latch_clear_sequence(void);
 
 #endif  /* _K3_DDRSS_LPM_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 27823e91d5e..1c313948611 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -122,6 +122,7 @@ struct k3_ddrss_data {
 	u32 flags;
 	bool (*is_lpm_resume)(void);
 	void (*ddrss_deassert_retention)(void);
+	void (*ddrss_clear_retention_latch)(void);
 };
 
 enum ecc_enable {
@@ -888,6 +889,9 @@ static int k3_ddrss_probe(struct udevice *dev)
 	is_lpm_resume = ddrss_data->is_lpm_resume && ddrss_data->is_lpm_resume();
 	if (is_lpm_resume)
 		dev_info(dev, "Detected IO+DDR resume\n");
+	else if (ddrss_data->ddrss_clear_retention_latch)
+		/* Clear the latch after any reset or partial I/O exit */
+		ddrss_data->ddrss_clear_retention_latch();
 
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
@@ -1042,6 +1046,7 @@ static const struct k3_ddrss_data am62xx_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
 	.is_lpm_resume = am62xx_wkup_conf_boot_is_resume,
 	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+	.ddrss_clear_retention_latch = am62xx_ddrss_run_retention_latch_clear_sequence,
 };
 
 static const struct k3_ddrss_data j721s2_data = {
-- 
2.34.1

