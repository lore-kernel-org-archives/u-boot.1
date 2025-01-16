Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862E2C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1F58022B;
	Thu, 16 Jan 2025 12:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="h84LzjZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE6E98033D; Thu, 16 Jan 2025 12:29:53 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEBF180214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m32u8QIeTbSbnamMhEkzoDZrLC0LzguSR2za4qx/UPud73VwG4kBbQ9b0J61wsiLneS6gsVvYU9BSs51TTzluAi8IBvs8laOYxHz3sfbrtf1TQQ0s4PjmBrHTGtcWKc+5N5K/WeDT7XUY/ceYvj8eDN0tbtXSrFaDskPcTBVxxK8iVXJ5c7VAfrSGuYSVVmrqFwPd+4OFu+q90Y4tDYJmpr0CM00DKtaQ45fu/xodxGB4hf8LX0APJjfWASuY2OJO2zcxMpGLo6A9+pWqLk7SiYlqr48oNjo4pRdPHZNhULKIMlF0Yp3ur2wvbFF5ZB8skeC/dJ7wEpTdttklP+P3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1tJqH5SPBaFJcyZ0VZPJZbbzJ8xbeGWA5g9g7mOYAM=;
 b=Tzj7/vXCess06eUxPENnfKfHwSHKd7mGJukwzX+F4b4KCGj3D99GpF2Sej0CN74MKKv5mDAA971Xgl0PJF1LooTK2viSs8uMq+nJ3p4bkrdEK4i5xedlXMkKjxT0CU+OHE52DuEiPT5lXUiieHIQrs1S0Rwk5cfbDBJP89d/vh9WepCs7s4xJ6sjEKSunjPayMFlS6HgnrgjjPYXMONEY4LLouVnuWAnOf8oVKSH5PKnO2YHh2/4o3RnBx8wXQtcIttHKbXKpoZGdL2uo4n6UihVSFokQfxrl/QoUSZcPAx3ZO4KGTIbhZNDm5MVsn910biLOZA5V3FPNke58QfQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1tJqH5SPBaFJcyZ0VZPJZbbzJ8xbeGWA5g9g7mOYAM=;
 b=h84LzjZeCYmgSfQC1DyR0zCssbvXbNOqLgFjM1ONtoi2c9NUb4cj9PkwpxfH9dzAFwsCr4zzvJalq5+/0VPXkAaDUnnMX7qpc1GZptbC75XLDEwkDJ6AxDzK/JoplaQUam9v6qgjoV3jdCgMYwlD6/HpImtlGEqVLhXMSE6asGB+YNdhmhfm0MLzJxrzJ+HfT0JybFL522xNnetgogIPgWLq9NXKmxN8H/DKGrvipQ2PEeDGRVJROr1lTghd6/f0iF3ysVdBKXVC58KVObfiUc6G/Z+wZk7SMHnAgVjmAkYvMTJgFr180qr4VWkNZ8BgAiEhLmYBhqKNWnwyAUQKjA==
Received: from DU2PR04CA0216.eurprd04.prod.outlook.com (2603:10a6:10:2b1::11)
 by AM9P195MB1252.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Thu, 16 Jan
 2025 11:29:49 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::74) by DU2PR04CA0216.outlook.office365.com
 (2603:10a6:10:2b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 11:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 11:29:48 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:29:48 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:29:46 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <n-francis@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/4] board: phytec: common: k3: Add missing boot source to env
Date: Thu, 16 Jan 2025 03:29:29 -0800
Message-ID: <20250116112932.1983801-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|AM9P195MB1252:EE_
X-MS-Office365-Filtering-Correlation-Id: a6812f05-cf91-4015-276f-08dd362115e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zxgccqou/oCtn3Gmrr47dlwL6QA/W1Hnq7M6/K63a+N6kTSB+nQIvMckkYBu?=
 =?us-ascii?Q?3T0BJvzODLG48Ctix+rb8xhPVYww/M0J9n1/5RkKtkTzTu4iWuLZ0MKnJtW8?=
 =?us-ascii?Q?fiD7zOwaVZx9jpFnlKUxgzwMt++qWFfkALZNPDotjeaORlQsX7TSENMNexW0?=
 =?us-ascii?Q?dL1yWwBSA8mjhtxQ/BAdvWnVvrRZ+gCtvVmB5quPv9S7UjLF42ZxJINjKpku?=
 =?us-ascii?Q?PEUTr5rgrMWmPRWL6pV55lS/OkZ8J95OL5c+bcN+AmQH/HLWnhrUkUe7oxSd?=
 =?us-ascii?Q?a3a9ld4FecEVFqDZiEvIkYF4QWWrLDEExDSsI7DYahZxyNuRMfeiusQ7VQ7H?=
 =?us-ascii?Q?udJu2QLkXD1U65du4aPzld+bHLIP5sovJgRsLtpfJfempeL0Z3M6XjpNEqdA?=
 =?us-ascii?Q?wZofgjKntZSsLWs0nqYC0h6ncTGXxlleNPuOmhXYiO/O93gkgThBnmhtUMNK?=
 =?us-ascii?Q?B+mPFxoj4KtuB9Bpw8/1lC1lNBl7cBarViZBozvujJlba8YUiAMK3+coEbWg?=
 =?us-ascii?Q?RDoXH7CxUYWfmKcpYF9sVVBGO8mQiJo43EsjjuXVBM/PwioUhJWSmos6WWK/?=
 =?us-ascii?Q?EQBz1TX84JFkw+1UcsZbUGnMQU/HC7SvHVnyWYhrFaWcZZcVy/WPjmggMop5?=
 =?us-ascii?Q?sT2OqGKSasHq2wHLGiQzRGtrzYjaKX1S7LAe3IoJ6R1rAv4BhNlaey5a7fYZ?=
 =?us-ascii?Q?kIpqIBJEOaElnTd080Kz08W48Vvnb1GjEiqng27QnleNDzBiytgSSlTif+Er?=
 =?us-ascii?Q?1rd315oBE/KlcEutPBGVsDDg8PTo+L2eEQPCJzoViSqMyhoTrLGuFxhyWIyk?=
 =?us-ascii?Q?o+5o2nSLQXfYOP1+0/uWhxNk460lg6XKfL8tWNZwzUQ/HIHTbnk5jYdJrCap?=
 =?us-ascii?Q?OJr0bhuDMYK2RmTYcA8/aZmX8yhFAWve+nz0rCWledya3ZzIgBymFzhlpJlg?=
 =?us-ascii?Q?MkJhCnekBR+JLn/EWIGNt/V5TA1eyZflhpRCwID18V9MOcmq1JBdMJjPnnWu?=
 =?us-ascii?Q?hi/11HKuFrD8HXysoB+Zd7Ave8OKcEZ7RpS/NU5260IeFPrdmJ1JK1yawqP6?=
 =?us-ascii?Q?uMvDD6Nvy7BP+kbgxfmRoKvkMnkeATlLouN7cX+KNvmZlFTAs/pjATtkE4NX?=
 =?us-ascii?Q?di8A195x37uXdW5lgY6kpdpGGX10DwOZ5moTNli5lSB6ZHGFa/sZ1Bf/Ya8l?=
 =?us-ascii?Q?OYoBhGB6kqJJxgngFp6jCzT76moFq96UM9F9zFZPnNtN5Mt1mewFBpq3vGQp?=
 =?us-ascii?Q?EbPcFW9MfUh0E4PKpgc9xipnCi+gsTpEj1VP9M0IKp3iek30KUp5IvXv8jdJ?=
 =?us-ascii?Q?oRrMo/a1lRyn7+yvaSp/1SUuF19eRffdWGcEPLj7v1bIipSqLSyKP4EFnlo5?=
 =?us-ascii?Q?J2JnWT/K6KVSg/krpTyfuWNb41rRf+zNmdobqfBvdgfX8vMQAl+fEK57PBTU?=
 =?us-ascii?Q?n5dliuU9X9htoQSAedorHPeJ18MUWHF2DZw4e1hJAI2q+2D39q3TgeJ39XcT?=
 =?us-ascii?Q?JmAo77BxSSdNStM=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:29:48.5275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6812f05-cf91-4015-276f-08dd362115e9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1252
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

We set the boot source as environment variable 'boot'.
Also include 'uart' and 'usbdfu' as possible boot sources.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 9ff861cd3f4..ebdd5fb2abe 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -148,6 +148,12 @@ int board_late_init(void)
 	case BOOT_DEVICE_ETHERNET:
 		env_set("boot", "net");
 		break;
+	case BOOT_DEVICE_UART:
+		env_set("boot", "uart");
+		break;
+	case BOOT_DEVICE_DFU:
+		env_set("boot", "usbdfu");
+		break;
 	};
 
 	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)) {
-- 
2.25.1

