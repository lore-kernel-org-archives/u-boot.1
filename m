Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBCDC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 05:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF63A81DB4;
	Fri, 28 Mar 2025 06:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Kz0tLqBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C9981A0C; Fri, 28 Mar 2025 06:58:50 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D39805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4DbxGjc88tyBeCTwV0E/man9edlpb+86OQk2ilTDblM7rAWcJ50zKwsk6njJkzMIB/ADnAW1viPNkdkVd766pfcGWkBP0GExIzqrtPv5ah3cHzYnp+YHJHj7T4P6fviwdQx61UDpYTT7FZUyGir+V42iCReZhdLCPzBG+0kJQr1DJsfItOtt/o3E0Bs2il/AulylWqAG9wDZhB7JwFlkzZSmSJ6qLqYL+u/qCsF9o/XuUynYQb5kTfrqZQkYAh8B90s030+OYhgNtDnQKTuxMI6A7EG0IjVje8o0fROJX20FdwvvOU4MiPSWB9FPeg+525nlJ0fzdifnNhoXm/G6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ho86XNYSUQG2cJ/HLxZua+XAtFbqaX44s7UgaBHj84=;
 b=YvNTBpN8Ly2td/9kbkjVlZpC6j4J7ZExfcOp4/OJ1UZBC8len1PvqDFhk9n6K8WMgDeC+Z7V69J0c1ULATkeJCEAqG3QmOvsqiU8ZYELj3TRhSvFvYanN3IFOIQfMo72yFo0RhGFvFFssM5iMcdX8oq4/KL31Emn5QajoCBfs084KzEumkpZLRAtaDahrUO1KFjPGrxoTgdn7gELk7b94nTASpTQn6LComFlyk3ZI3x8ZpmdXNIFwrY9goPpGOnJgj8QSxGAeLPfTX7DrwSNznLuBWlcLoYxH3WIGEmfjuTWjQ3GY1cpVCCSUKl297YNyIfIHhanSw6AKjJUZ3ioEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ho86XNYSUQG2cJ/HLxZua+XAtFbqaX44s7UgaBHj84=;
 b=Kz0tLqBGKC3bB5mEzBPKnPIXIYmMPB2PF8ZqJ9AFYT55MERQnxEkl99S/aqFWyVItr/MYNdw8lsK/VXwKncjKHPHPjE/qR0lW0NtskLsHw+MFwBs8AcXFMNmVF48P7Acs6hStQ/UdaYdg2ywOmNmt9IHSL9jBZKxLDANIbRz5Fb1QjCii8z3+qvrFvmkucuLlKL3IP+ztm9hXj2D8lw7ejjEcX4IJxCLoYcpEpSL6y+c+LtRosQnpfahIAbdhZKNiPF63nYIx7URKvPf9I+Bb4vLAjOeN028ZTEXTYhNno8kJuy2xDXtl4wi5Kjw/iTrw124vXSQYHSGXspV7Hb8pA==
Received: from AS4P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::7)
 by AS8P195MB1205.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 05:58:46 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::3a) by AS4P190CA0036.outlook.office365.com
 (2603:10a6:20b:5d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 05:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Fri, 28 Mar 2025 05:58:46 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Mar
 2025 06:58:45 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Mar
 2025 06:58:44 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <mkorpershoek@baylibre.com>, <B.Hahn@phytec.de>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 3/3] configs: phycore_am62x_a53_defconfig: Enable gpio
Date: Thu, 27 Mar 2025 22:58:24 -0700
Message-ID: <20250328055824.3849523-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250328055824.3849523-1-d.schultz@phytec.de>
References: <20250328055824.3849523-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|AS8P195MB1205:EE_
X-MS-Office365-Filtering-Correlation-Id: 767b07d7-a371-4e7c-1bd6-08dd6dbd9a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VLlzYB++kH7LmUZUiey1vWRRp1XUZll/7FGXU4QIVdNIoo/YVIXM/R4zvd1I?=
 =?us-ascii?Q?ywRDNCoJriLfMeoxZd5XNi42PmFpYpI7/Ji7Aa9OLPCc9pFx4y1txXXCv4Kr?=
 =?us-ascii?Q?RyFEg35JGmUG26lE+ez8M8sAUaOIKd+fqEr1tEH0r7h2zPM+M9kFbz4/FF9C?=
 =?us-ascii?Q?GfAwyXmlQ4NVgOYynCjLoU0GcFurN9jlEQBjMAoEpXdMQo6AU9asWRFYevR3?=
 =?us-ascii?Q?e48NZC3RI6YX3XJ9aqsbnnD6n+v991mZe+caHq/Bzn31YakAOi+P/h2MI40U?=
 =?us-ascii?Q?heCG5aByRk3oTzhr8QvQQKGETcN4SIxBUl1vwwIMLJdpCMWOkesgX9DmE5pY?=
 =?us-ascii?Q?eyjYn3ACFkrvdPAoGsYKSioNHdH4VCkghhtISqBniR+lks6WKvh2kGTKtYP9?=
 =?us-ascii?Q?Qz2I/o6ZLUUrViuWNZMA2XPVBNtGoCW4evy2JqCWkit8gfJS27RX243iZyQg?=
 =?us-ascii?Q?3pDCwk6zUlBSDeOmwzPlCKAjT1Xm9Qn68wIcbjQrHur52IhvX8chq+r4OPT2?=
 =?us-ascii?Q?cRjDtidwV5NSgTrDimSVOMDTjORWSHcOeuinm/6qK5ApYMZ0c3zGbfLfT3kT?=
 =?us-ascii?Q?6vtJEo4kuo3G7Q5wxJJV8Lrf/qMTfdr/Dc9TQvQk3nJK5EJrVS/6HDUwxHea?=
 =?us-ascii?Q?RrjcpdvsQqhVX5QHwWgPQ1rQZNYaH9PVEuhuRy9y7dWv6yLuyAZWuo0BWUHP?=
 =?us-ascii?Q?BN4VNAwFjpCADQseXqc7gIZylQsD0VNoXaUbrUw+mmffAnwzz1zO0QE64yo1?=
 =?us-ascii?Q?Zj7xIxBy5a2Xwl6pULo7VYZgoIGNJYq2aATcIIsBRwNAT1WCHhcQGaudb1Ut?=
 =?us-ascii?Q?F3JUzBV6Egk/zQHl/NNa5nveZFJS6WhoqaeVQwtC1DThQ2+4ZXMrY0PzY2Fx?=
 =?us-ascii?Q?VU5dbIm97ko17Tuts/qDNgkF5pKRxCBKZ/0gDEQTHyd/FTEFpkwQoVJZtBwt?=
 =?us-ascii?Q?Uc04jGFxrPOzhB1rPBcIbY1OGTy3XUOQc7DDv1c4/omUv4v5AGbWpJlteF1A?=
 =?us-ascii?Q?dddzNpp/CjlzNdBeRn6FIdKTPt4p+OhmXQZZ3CMOcd6Zydf5DJ4ohPAwB4eU?=
 =?us-ascii?Q?Wqlr+FQCcqp2NIfb7rCr3aKNFVyHZO4mWp/+jWAqeCBKtRxpj7PAuSUnExF3?=
 =?us-ascii?Q?XINLCiLN+KR/mKLvnvMpP7auKnilbUhg/G1Nx5dKjgLzjGzu1SuQcxcOOSav?=
 =?us-ascii?Q?dKItxxjSpDFUWnZDjs/eiWxrsaIVviJt960/qSkHFsMp43uPpKz+g5zzzCWW?=
 =?us-ascii?Q?cTO31+mUs3sHFj/NHUNX9yRWHCB+bNQbQ/Twww7E3wp5aLCPWqJN+FbflaBS?=
 =?us-ascii?Q?9EEpfQRVZhg4QDa9hLrh+U2eqc6ZWVHqZXqzbFQcTMGf1q9Da4Zd1paHSX9/?=
 =?us-ascii?Q?OpMdWjiZ2VB19OKIDX5hFhhF95xFjmFqThOqC0Lzm41rPUUG4eOLuS9ZVyVb?=
 =?us-ascii?Q?4bCB33Yn+v0tsuEbY+fEDIdp/p+Ei4M1eqSleuNwQq5RSzeuT4iWxLAWDa2W?=
 =?us-ascii?Q?QDb9AzMex//jHhc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 05:58:46.1056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 767b07d7-a371-4e7c-1bd6-08dd6dbd9a4d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1205
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

The AM62x uses the DA8XX (DaVinci) GPIO controller. Enable
CONFIG_DA8XX_GPIO to support GPIO access from the Cortex-A53.

Also enable the 'gpio' command to allow users to interact
with GPIOs from the U-Boot shell.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index c1a46bc40a9..3622e1a7cf2 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -3,6 +3,7 @@ CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_SOC_K3_AM625=y
@@ -14,6 +15,7 @@ CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
 CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-phyboard-lyra-rdk"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -73,6 +75,7 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
@@ -112,6 +115,7 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DA8XX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
-- 
2.25.1

