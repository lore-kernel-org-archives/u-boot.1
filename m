Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA80C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B8580713;
	Thu, 16 Jan 2025 12:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GGjhEHo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBFC80214; Thu, 16 Jan 2025 12:30:06 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446798070D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Otwa7QNotMQ3rVWckbzN7wt9XmoSU7AGt3pv9CUfYKzW/4oEgf84YNdjb+G7vWY/eSPRGdDhknwJaJjf9ePyDUmr1svPDxPJwLprDxKRPB6YmFFFSBCPZ5EhbBIgHERwogiotPNGB4gyS4WmvoyonsBQughTpZHysFNEKzNnGOd4NQFJag48YmOVrKy4MHRqYfoXeFfTnmWHe44OOqdQX7jiEpigMfM4mtdq78olhpoWjWoCCLFSm5hMejM2GdyefMSRDbPjdoBVF9FAmbl5kohq/MC49wSeuwnC58OdG701gFCuLF09vBfSqtU6MwtuOFqJf6YVouaHbKKvSImVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxR3sLQ1OcfpAnJea5V3UU8AQ/fShu5Y7nEEIFQqjN4=;
 b=okjEQNSbwDUb2Wa5/zp/vTgBUebLiR9Dm6+rp5LjaiQFtbnf4KaQD9/iGc2q8v83NHKomuOwbdoXqhBOhU6i1tUmNyL4pTJD6rIBJmLLbO+X8XHWXHf3pMHHqC05g13kYc0GPZYP1wAgxZ7YM5Dqt7RP8NdO/TtTKaR0xxL6HEOdz80sqVZ6c7f/cJ+1IY3btP1FURWBDYJhhJor17z5BrPXDOZlY3NB7MidL+KQnvUBqTC8fAWfJUgexyQEYmj/f7kUS8pIop6tlUBah9WU2fuIG+NNfS5K3k3Fi2c/uOykr0+P5eSRypj2DGTOAXtil2hl3nJKGSqvsULm7cs84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxR3sLQ1OcfpAnJea5V3UU8AQ/fShu5Y7nEEIFQqjN4=;
 b=GGjhEHo9dkp2nTaVrHJqartCvcmRCLP2cQC6oR17RK/NgJ7udE04KzGz0SX6wZ6TYmHdGYmRXtq+zZfiFUy6CdUeRJ2iA7nsT1NnQW5So6PcmvTgd/PaHmyqQJSk0kP50330HH9WrKHn42FsRQJavPHgbjzM8ZAL4vMw61Dw8RSsw5fy6QkRht3Dojpy3djtb1cB0XV2N34ESp1zvMFByoLFyUtpQwPCDHgEITEO6ocUQHRxktemMWmFytYE+qh1e0gmnwBWOTCTIDasv1G1t2gycI8XzAnoU20TvrMdRY+3lexbYQgkcS4GuaPoJTT067xz6LP1RfvOgtuXVnXw6w==
Received: from DU2PR04CA0262.eurprd04.prod.outlook.com (2603:10a6:10:28e::27)
 by AM9P195MB1153.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 11:30:01 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::e5) by DU2PR04CA0262.outlook.office365.com
 (2603:10a6:10:28e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 11:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 11:30:01 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:30:00 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:29:58 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <n-francis@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 4/4] configs: phycore_am64x_a53_defconfig: Fix environment
Date: Thu, 16 Jan 2025 03:29:32 -0800
Message-ID: <20250116112932.1983801-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116112932.1983801-1-d.schultz@phytec.de>
References: <20250116112932.1983801-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|AM9P195MB1153:EE_
X-MS-Office365-Filtering-Correlation-Id: a05a5365-528b-4bdb-3128-08dd36211d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nNuvKXvL6VK3LrTirgNPPdZYcY3GXTkYQJZ20dyCah5CWZwEviyANDzWOdvN?=
 =?us-ascii?Q?zH170JnRVYqq8Bz0JRJY+ZmnMh/xCi4jBUZnKPX+rt7Htg3/yxYFuacUPpDV?=
 =?us-ascii?Q?vszxCZwqZD8H1QJfaVuRvfspBE+TQlrzjdAkNTWAa8aIqs0bJ0Pda0DXc69r?=
 =?us-ascii?Q?WG+l53hf1LESQxpAoVIBj0L3lqsxdkef3vV31aFAgLhAkJZPcWDK4u0pQefx?=
 =?us-ascii?Q?XM7vQuzSjYxhQXR+gPO8l8kCO1pCcon6MmaVocACQQDq1sbiafSMSrRWbGdR?=
 =?us-ascii?Q?fjV3KYUblnizsJAvuWS3zSKUssMWOVWSykOZedhxZVc0V2RtXguFzBPbQI+d?=
 =?us-ascii?Q?hoHjuNFemlaWqxpkwFyhzVem3sXvCEKbe6OwFsQxnBgEtyeeettEX6vftpf2?=
 =?us-ascii?Q?7xacTFi2gvxxKke2U+cJQxClddC7BTYPaslGAEszklz3LsUiG1V66I5kd0z0?=
 =?us-ascii?Q?okK6167UGOPJ+Sgyt0uDS6VPmJ9kExMNpkBYlEYfhELZE0DmTJ1w/LKvfoUc?=
 =?us-ascii?Q?yxO1GqWCedBtAwEl/TxoxLFb07ElKoO4l7ohwVgMO/Nmx8asUaS/ZKrlGGKR?=
 =?us-ascii?Q?mO50brYJFsdzqJ3NAruxD5eNBe3V42Qh2OwiQH4LdSbYz95efjpvO4h1DZDZ?=
 =?us-ascii?Q?XzhqJ6B30VwLXhd8YzpGyLEwDVwWsvh5nDSMYRUECivYcpLFfu7D1xHo0yEm?=
 =?us-ascii?Q?w/GqwAlXuCLxrV/VJdaEKuNNFvwMPQ50NOlwD8nXSj7UbJ1vGg083OMhtVRR?=
 =?us-ascii?Q?jdCICl6vFOw1/yk6qoiIFAxw2/IjoRxY955J6GQk87kOf3+YuL9beJleywNV?=
 =?us-ascii?Q?Q5ZRkV5Ewpr0cF7F2epmRCkWTeNoM2cXgC2X1LOZx9usmqdNC6k1Z/pKe45u?=
 =?us-ascii?Q?a6NRF0Fnzum0ejvXajbO4FhMoE7zCnd3opbZRAkjHz2mMbhc1weBqA0+uv/R?=
 =?us-ascii?Q?c2uL9Bh6TOFrDIaWdqArHWXPc7qXFG7XKMEuU72ci6/iHh8avQQeH/b2clzO?=
 =?us-ascii?Q?NsVWescdU0TrwZ1gQJAOAuOMXjoGeIez2xhcwwj9ugfLD9puGVzmlWSpF4Z2?=
 =?us-ascii?Q?ldt0VJQNcnPzApCJgaqj1ITh3Dpglrr7H5G8tWQHoxqDg/KRfy+5lUza3ZEM?=
 =?us-ascii?Q?Ugwm2ZJBdvHoob4yLXkHp9Iuy/E7Rmf+kYgM0rWfE5vogb7pcKc6Uub4pfLT?=
 =?us-ascii?Q?VF5ZqifiyKEPCyuxhnMhMvR/Imukvix95utGZTzym3VjUP5HhG061bUnYS5k?=
 =?us-ascii?Q?WR1p8HlCdvfYB5tNYKrJ1+O3CWNHSAvAUGOMXfXFnYd8/FgDS+Up3RgWIlsK?=
 =?us-ascii?Q?Gnq3LTN7X57GCeIQPuN/EpmZnQ4G+qytgz7laiySu2a1t+RFrx4eyMUusgNW?=
 =?us-ascii?Q?b6Um2uM+eMJP1cV9/x5Zt2KPBzftOEHPuVDZf9M66sZrC+lgisgfateN6FEj?=
 =?us-ascii?Q?VZp/uDbzftHShMaE6WeZ/FmW+uU8foqNbOSe4ANpPPv6FS9MutmX2ETKjKkG?=
 =?us-ascii?Q?QQNtzb4iNths+9I=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:30:01.0230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05a5365-528b-4bdb-3128-08dd36211d5e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1153
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

Enable ENV_OVERWRITE to allow environment variables to be
overwritten within the board code. This is required to add
MAC addresses during SOM detection.

Additionally, set ENV_IS_NOWHERE for boot sources other than MMC.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 4a91b72e700..3027a94b0d1 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -89,6 +89,8 @@ CONFIG_OF_OVERLAY_LIST="ti/k3-am6xx-phycore-disable-spi-nor ti/k3-am6xx-phycore-
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
-- 
2.25.1

