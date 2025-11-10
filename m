Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEE0CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B28F83966;
	Mon, 10 Nov 2025 10:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wYyU2h2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD29B839E2; Mon, 10 Nov 2025 10:42:12 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F9483A1E
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMw9bdIWSO81i5vGnxqd18Ldx3KaLMigHqUD81lMH1P+SoWviSetQmCv+bOz4g6zkx4/CiBazaHTJ2S+MhCKCbmwiKE2s5LDyg0FRFsKeS7kEamqgWN9BrXW+hPEp4jL//WF4CENso64XhwPhqYJUqGeiM12lRKeIhlJ5qgK3eSDLA9E76mFUd+cGXhVtBn4NXvzJt3YgG4Uy0Hd0LNjVmvyj1GBnnyRHgTF/phhfVoRK/MVUq5tASe3wcxpv3G3AjxgDdZZTt9Og+kmsXMhcAExFj58U87zhd/VoBxDjyhxa5vDFPP+o9lRzUEQZRAjGC5OzpAuOIMOUi+3kg9mFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGK3kVrGRLfI3EBHzbOuRA8EgkGcTcubnwNMEEDE9d4=;
 b=jp/zU7ZxA4cLb3wIJG/0tROM0KXx6w7o5H8/6Mdc7YVDswPGuz5GteisuiNGHAxnyRb9HEMRBAimiECVg2BEMzIvOPgAYOisHC+gLhkcLV3VEUNje1Y23ZCuh9plNsFkZUi7ppyE/Cz9Z5bd4f6rCEsQ+AJjaf6yISfJUPEEmdgsIY9KRUbjZKhB0avZCdShx8LruaC4/+PF9jwTSUf0zVpUTaN5kKEaplpHXW+H6Y6h3EVVY0wsQKjfQHsukt/t5st0NUXrUvOm/Ho/Io7ormjGv++iniIEk7/5fnUFAE5+r04PL8ty2hu9FfeZeQY9XTcDx1DvFaD5eTO0AbBuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGK3kVrGRLfI3EBHzbOuRA8EgkGcTcubnwNMEEDE9d4=;
 b=wYyU2h2tSVuTPmtkL6Ch5Toa9m1lrZBnNzsJI7C6Z88Vnv8iRA6+idksVNCej0JNuQane80sD5SDh610RxHk7uNPf86oez73tA8U6yejZbvgLbfqYmgneWyhOatDLQQPUQbF9dXP2EEdF2YH8Gi4dEKYbUYezbV9hxI5vMixHcA=
Received: from CH0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:610:e7::6)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:42:08 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::15) by CH0PR03CA0211.outlook.office365.com
 (2603:10b6:610:e7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 09:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 09:42:07 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:42:07 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:42:06 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 03:42:06 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA9fit43156252;
 Mon, 10 Nov 2025 03:42:02 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 4/5] configs: j784s4_evm_r5_defconfig: Enable configs for PCIe
 boot
Date: Mon, 10 Nov 2025 15:11:43 +0530
Message-ID: <20251110094144.886956-5-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110094144.886956-1-h-salunke@ti.com>
References: <20251110094144.886956-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SA2PR10MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: a913ceaa-46eb-45b4-4e03-08de203d69ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gb8iE0fb1fGVlxwaoXE8H0B9ricjbULdBrdL2xLzHxkw0qVnEdgR3s1xcJnU?=
 =?us-ascii?Q?GEC8TB9qHPgj/iQeiqb9CxPVtl7aOy2kYEGLkrmekYNsX+Iy0kX4hNz/yB1U?=
 =?us-ascii?Q?snMEZjYj4PCKbyLyJ1WrWhQ5YteAgeQEEsqlqi7dNoZ4OvhwVl3hSSo2KJvt?=
 =?us-ascii?Q?0RM4KMWHef/T9y0b/2aAsNv/u75hz9QN2+3/dmNuNxaNoDgaqOmQQCpWXm5E?=
 =?us-ascii?Q?MTBkcp2/BkeuyalVrj7TpkfhyEGK5fdPAb3eHnEf/fwNvNxTysOusnKHfoBF?=
 =?us-ascii?Q?OZNQ1uEj8DviS8So7mcnFrKPdL594+s+zwwAyDG3zH/oh6ALpEV2YXH+w43v?=
 =?us-ascii?Q?UWteL6XpZEyAMMBxHwElmQDQAlTCOXOx1kdQsGptafC+W0ufZcKzC8WZi+4V?=
 =?us-ascii?Q?ksIAH6knjSVN+oUkGR7uDg0Eoo68zR5Gwx0l+BXziWrUjFc2ACdekFSHrftZ?=
 =?us-ascii?Q?WS2jTL4I5i0GW1qMKzQU6QXzFXUa3VwPAF0CHpNd41lf/TvBqcuSaf6kGlvv?=
 =?us-ascii?Q?boc1pprgymhmyQKP+f+96VhLRh4m1rLuLXmESNSV3FzpRDDt8jJ9iUjbk8+M?=
 =?us-ascii?Q?yzhLFZr6kX8/+vgu4LCY3/9e66rbeTuwJVS9CLlCag0pQnLJM8ZL46vLcbGz?=
 =?us-ascii?Q?B9CbTNIGcOcwELPNG/0YUbtwWA9N4H1Xj0EjyBXkXYqGm6FuO/7bSbR+zGtB?=
 =?us-ascii?Q?9CassXmgsvsNyP0G99LrpL4ySe1BJJ5yqlCqhwmZZpfJ/mG5PEcI3VEgyWR6?=
 =?us-ascii?Q?dRfXvJLtZGd6izGbGLoB9pzx4lvIzppSSKWOUUqf6O0KyLh5f887bdMF13yP?=
 =?us-ascii?Q?0lUU2CEQX6Bl+htTeBiQrAS87nkGZtp5Iu15rMle/JtEX0OfFupsVITEhYls?=
 =?us-ascii?Q?zol9fuCaM7qofQrfSxJg3olkEVRlB3K9enB8IZOPUVxcyHfVWg4J41vBU7RP?=
 =?us-ascii?Q?2vaqZMuhgS5hMJIgvP0PlKnMMy9RN4POp46IKfVeKmShSV1pd4we2jmmKV2F?=
 =?us-ascii?Q?I9FDe6BP/JcX9axkNw0lcj6ILOgfX30woUEw8J0cCxzPI4GwA6NeQKbVyidB?=
 =?us-ascii?Q?TgUeRVBU2mA+NRhD2T5VvxFpcd1DSy4onsjorh5lsfjtsVAUOSFKEtskJkBR?=
 =?us-ascii?Q?NqyZLmIyrpfsBTka0x0QZGyjO1GeaGvqhAjVhRUhYGyT8DKRsdMeCGkYQLab?=
 =?us-ascii?Q?qSxaqMWL69/YndIudsPQYwSUdtFbBK0qB259kUc7y1SWEeuZFoFod5nmUukO?=
 =?us-ascii?Q?VnnhWnCDyAVAfhc3fD85u0YnR2pBoJ7C64PSLHQ36anISpYy4wX6Iqw8Xp0J?=
 =?us-ascii?Q?a/FpzEZcfF674BKQWr+EC/9V0YXPqbzXPAZho8jHNkYCoZPmzAY3aHOkxF7t?=
 =?us-ascii?Q?KS+ASnlq9YqqOcpYGO1ukuJUpfHRKd+knzuBWCNcMKc+5znGggh0JYXLWcXa?=
 =?us-ascii?Q?aA6BgNJ/SoWkDWzLkv81xqBISi+vcH8UcpdlF+Ri6AWZO0u5tdy4w9IJ+V3z?=
 =?us-ascii?Q?YYKfq1V1U4faUEoGdB1gEYy957QSlezhfSEqbNOqLD3sEk6H4HO76KprID/n?=
 =?us-ascii?Q?XySlfD8hzYHDgzyCwNFgAFwJ03oY9ToL3C0wxpJy?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:42:07.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a913ceaa-46eb-45b4-4e03-08de203d69ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
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

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
Torrent PHY, and MMIO multiplexer. These are required to configure
the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index cc340a2fe76..2279ba7f173 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -52,9 +52,16 @@ CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb010
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -122,6 +129,12 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_MULTIPLEXER=y
+CONFIG_SPL_MUX_MMIO=y
+CONFIG_PCIE_CDNS_TI_EP=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_CADENCE_TORRENT=y
+CONFIG_SPL_PHY_J721E_WIZ=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.34.1

