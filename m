Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6B0C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C4EC81CFD;
	Tue, 25 Mar 2025 04:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rNSMtfBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B55C681A0C; Tue, 25 Mar 2025 04:58:40 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC3D819B1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4QQSs5kJi23SrzgxG+v9WCK1Yxc6l2jdGWAzRTsbhBCMy+Fw5NrvsxpxG1sgKZAfwn/ZWZgiX+RDbg+7FVOf8d5euz1uhXC/lfhyq4xHnp2yeUIvCQMlarQVyVH84pJWX+JK3xXCBOeX07HVhot4ZKWLIX+59WSvbGlUwJnUc9KYbRMwh85PFDK6o6OSK8LQGhQt8QVBkdSRQy+cUJqE6VuAnBCWLzR/TcFBVjfneWL5d5OGnwvLuro3x5TGLwj+DsbMv6HvvXp/1wUYbxm09Kez1IrZ8kozdeQ0UWmEWg2wkum0fzzCQ5/alXpTQWoWnlor8QEtuiehNCWd3r9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHFCNM9LP8miPbdZhMNaeIlRCDJiXNosFdrpNoMx+Y8=;
 b=ww5sz6KGjjuAQrtCQzjDePsnROnDvnw7m9EtzofHZYqbEVo3HjOlSoKzvz9qtKGOuaJxQvDBqSMoqn2iaRLT/ybs97kGyucCeAlH1Lo6UT+kwtu4Iew6aiD7Fn92lA6IXTPqrTyyzSyvZz4T+c24GHTYl2eY/g+1KtvrX0MFVyVRxOub5yndU1tahVvSQ7JGhje/BIkchrVvwjZZxMRBrRwYRBka8mDXK/dcOGGub+HRLWwoQ5jCuhNN6RTNy3Ufgd9vq7JpDZ3pjUhXxTP+YzbSA3mWTgHFI0EhTXvj1V4SX86ibZdBnaC1YNQRmbTxL4TXcmmV66P1W6ZQWXj/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHFCNM9LP8miPbdZhMNaeIlRCDJiXNosFdrpNoMx+Y8=;
 b=rNSMtfBJ6k38AsQS2VIQqkHuCEyGg/S5kPFTZ70xmAhCB7pq6RFUm8p3KTqr+yurLfooMBR8Ytx4Uv77HLTMHB+josIEJAdsZPcf4h3qiJ7Q9k9DY/CRiwkywxzWGqNQdjHhDar4DG4gvpftCoTrzpYdy8ptJjDtMoHrSBWyIbhKV8Rx5JrU/dw1q3wXMCbJ08xO7lr47NOJnyr9+5mwKMmvUgahGTtL++ctLGVltEd1x+1PrrQE99tKEBXZKtC6ltpgtTr+ASH0lfxYcu3kTSQ8QOnuFZxS2eiRaY09u8sBO1NX9fqN6PCPCCKy4IFHAeIoRpFyg2yXTvpi9eiRrg==
Received: from DU6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::17)
 by PR3P195MB0667.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:58:34 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::3b) by DU6P191CA0023.outlook.office365.com
 (2603:10a6:10:540::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:33 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 2/8] configs: Add phycore_am62x_r5_ethboot_defconfig
Date: Tue, 25 Mar 2025 04:58:18 +0100
Message-ID: <20250325035824.2304200-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|PR3P195MB0667:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8fcc08-3115-40e8-0270-08dd6b51503d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OR3OnWb0gMOFdJgx8/4Kkf8l8pbgLF8qgs8+ltPkzt1TfKQT5ZWWvSD0uT37?=
 =?us-ascii?Q?odDDwnT1S8M0BL4RzlJjfNb4Ie2L0sUi/0iZ1gBR1CZuS5/z1zZO2HBpqxy4?=
 =?us-ascii?Q?Mk2aw+LJsUEz3YePASE1MSMeyLqBm2GlEhF+x2qZnbx0LmxYPpAxmAPrAWtk?=
 =?us-ascii?Q?O/St6TY5k+szoqQNaWmwvercw/KTTSJUNTTkj2VJHK+WLV+YsDdshrP434lK?=
 =?us-ascii?Q?8pRk581B9O7u2xEyfotiw7peIu0SC7Px5Y6NwF/onAvhAQ8tkHzHU3EmLVex?=
 =?us-ascii?Q?zu+NeBXKIHrgdgjzmgB9DhkzScoMGr0yvpHQpwFUqiZ/DPsCD8jdsvb9QgJ0?=
 =?us-ascii?Q?Ukfpfc/g9tLPrIyW603nCoo6Ez1650YrBayfDvk31oSJ67zb4QVAk2Sc+2ok?=
 =?us-ascii?Q?o9OaOmIdWihzttjibhtmaMhXAHgBr/owojeVB0rKYQjR/ufUxxwDTx27rQxn?=
 =?us-ascii?Q?MnT5qWkr3zqO678YQE2qxxAeLGAprHXgNS628uG1AmXjHxxVtfulP6JzU4zm?=
 =?us-ascii?Q?9yF/rgaRIivSuVGOGerlP7figQ0xoEWkelqwD/6W8LmhgD3hNYTP6clFLdQ0?=
 =?us-ascii?Q?UID8zX08jyQPvOFOMCKF/tjKTrx/TqC04zd/ZkjLHFo2YukxOQxqea+Zilgf?=
 =?us-ascii?Q?a7Wram+/d0siVE1v/L1UDZPiJ+bGIEDn4EMh4M3m4Tj9giX/uIJxHYSVQ6f+?=
 =?us-ascii?Q?bXobCjyMeczHTLekWx70V+21uv8hau4At7XDDJxu+rf3Vhltm+h5jcCtmTe0?=
 =?us-ascii?Q?/YHbTCH3kIIJgG2li1F2gofQT/PiUJyoMlCkqkzuHMRLnZ2CSF+Wk6sZcLQQ?=
 =?us-ascii?Q?z4kaVzCYGJ6XbQR4XE0AsLspspsLXwUBL0WGYrjDi7/KZ8sGo2hRH2ImuvD4?=
 =?us-ascii?Q?W/q/V6ENtNtqp22KYpthhiL22V9+LwtTVqLvhc9k5dU9vMRcXunefjfbUBkn?=
 =?us-ascii?Q?JPfaN0FMBWGPbw+uMkX8bT87FempXaTh6D07KkdnqdCPy/7PC9g14nnHslBG?=
 =?us-ascii?Q?T/Kkk/B+x1Q0/uBNea/txESH8pk0+tm74/4EgXu6DwsKopO1aV1GBdX+t59Q?=
 =?us-ascii?Q?9ntNwk6JhWKnPoVtzbyEnH1oFh2SjSEizTzvxgaKt//xdw34eh4D7L3n/svT?=
 =?us-ascii?Q?Qu2Je72QCkxHgVtcQOXZCJ7cUw0z8MNLDSFgx5R0yloc2DjwIbkPfz7eT5vp?=
 =?us-ascii?Q?dBfTigR7CjDfmpwjqQYGW3S/ekEVLYOnwR82s7xeVkMEdWmfrQ+rvatjzSus?=
 =?us-ascii?Q?jdZD5ZxNhwAni6JkNOFEDg69r3XVfl31YBlfx2rdGy7go/SamziizwQellqb?=
 =?us-ascii?Q?Sb9hnjSd6g1CUnOakfG/dPORvVNqkQ8vTz3VGVU7BYn24TjofGU3aH/L9L7j?=
 =?us-ascii?Q?tCG21/KtOT6pLXTqViZQ74Z0sebvPh2eq4Dp7VfUZoXDdJtErrlWWLlpQuLg?=
 =?us-ascii?Q?zz9BQQMolgpjn87sku2vZsyYuXA9iMZWOlPd0EmTZXGTMWoPXiIl+WhWf9YR?=
 =?us-ascii?Q?6Vmpsbs0pMRLws/3nko35IwjCWnH8ovMKoSp?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:33.7926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8fcc08-3115-40e8-0270-08dd6b51503d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0667
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

Provide a defconfig for booting the phycore-am62x via Ethernet.
We need a separate defconfig because the AM62x has not enough internal
SRAM to support all boot sources.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/MAINTAINERS     |  1 +
 configs/phycore_am62x_r5_ethboot_defconfig | 43 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 configs/phycore_am62x_r5_ethboot_defconfig

diff --git a/board/phytec/phycore_am62x/MAINTAINERS b/board/phytec/phycore_am62x/MAINTAINERS
index 670c7473481..106b4b80121 100644
--- a/board/phytec/phycore_am62x/MAINTAINERS
+++ b/board/phytec/phycore_am62x/MAINTAINERS
@@ -9,6 +9,7 @@ F:	arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am62x/
 F:	configs/phycore_am62x_a53_defconfig
 F:	configs/phycore_am62x_r5_defconfig
+F:	configs/phycore_am62x_r5_ethboot_defconfig
 F:	configs/phycore_am62x_r5_usbdfu_defconfig
 F:	include/configs/phycore_am62x.h
 F:	doc/board/phytec/phycore-am62x.rst
diff --git a/configs/phycore_am62x_r5_ethboot_defconfig b/configs/phycore_am62x_r5_ethboot_defconfig
new file mode 100644
index 00000000000..3bc426821e9
--- /dev/null
+++ b/configs/phycore_am62x_r5_ethboot_defconfig
@@ -0,0 +1,43 @@
+#include <configs/phycore_am62x_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_PHYCORE_AM62X_R5=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-phycore-som-2gb"
+
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot R5 SPL"
+CONFIG_SPL_SYSCON=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_DM_SPI=n
+CONFIG_SPL_MMC=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
+CONFIG_SPL_SPI=n
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPL_SPI_LOAD=n
+CONFIG_SPL_YMODEM_SUPPORT=n
+CONFIG_DM_SPI_FLASH=n
+CONFIG_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPI_FLASH_SOFT_RESET=n
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=n
+CONFIG_SPI_FLASH_STMICRO=n
+CONFIG_SPI_FLASH_MT35XU=n
+CONFIG_SPI=n
+CONFIG_DM_SPI=n
+CONFIG_CADENCE_QSPI=n
+CONFIG_SPL_DM_SPI=n
-- 
2.34.1

