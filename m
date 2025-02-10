Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4718CC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69697807D6;
	Mon, 10 Feb 2025 16:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CcGESYtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2964C80BA9; Mon, 10 Feb 2025 16:26:17 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AB880C6F
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGYEpsp1vSk7v4WZAYGvceogOts0prNC7ZFiepCONJoN32X6EokJhqQ9XkfQiklmANXqJehRkJm9cbSOtKoZkyAWYFU4Lue/cY8kMoZy0waOsyrgODjrFkkvy7njb1WjwSm+7xej/9TpY4BnNJf885iandEuRcD7uHmIyAxYLBnx5OV/07kH3nXVsEQ3XbsjgCvxPSRsRjZZnd+XaPuBf517Wih/lpK4xVqRz50g3II+JNkOqwq0vIlsbcphG5ezLyEUiMWKI0lXmJgW4/N4unWXKzsH/JGODOTFhXFSrDP0Klsi2Ba7SueQIz33lA1c72gSsDfeDooaeNQNi8HFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFr1MMcSARH5kOZivq325ELQbP9L6JBmpQdtkyigPVY=;
 b=CP3zUX8FeKQ0pFMgmnXCTIBr7QIJwjHof3tX52lYaxNfFINPgectBRfDZRzhG4m5emzVPkaKCkNIQX4R5ZXIr/m6dT3WDLBfGKOSQz4af6IEhSfElYP9Sh/kdQXJPEXydWTxg2zLLiDjINjxCfdoSI/3ByNj/wD6ACfYVKB48Kw6FS0ed3VZGS5B0+DGYVCmaHw0VTSJAR4mfFdQIsv9s0fvcqQLzXxzt0L7bhaekX1NhY9V0SB43eHWqt5UwHp5A4k+ZDisZzNu4uq3O9ZKNQqcRzSjER05eAZMbZQcwgLichamL8NJ7xNqAi97S7l8p8yxdUxALoGcU35+oT0ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFr1MMcSARH5kOZivq325ELQbP9L6JBmpQdtkyigPVY=;
 b=CcGESYtA5SNMDndgvPIrTrywfIk6jvx3L34QksF8v6+ZwlChrW2pWoUQYxHNLZwaXEwfrPo/Rl00fmDbT1qsDUD/OjtIGeWNTji97lQv2xKWdy8KqCheBzRUDJziofMo6OESQ4EkMA4xoOWRotu5whN0HXVS7DLaN+3X+jjjsREo5JWzIBkENlKKW5uYKaycB8B98NohgdLloFScVUzGYqsIO2vjP/N/dkpeimd2pS81KSCqkM+exDlSttUSedkkNVSJ0j3qK8QE6a2DkK0JaEGRrMg7vOhMe7kRha3+uhvTPgaUVKPiwN+MKRUNiwXAxX9sCdvAJtbikx2IrbwyTA==
Received: from DU7P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::7) by
 VI1P195MB2460.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:1c6::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.15; Mon, 10 Feb 2025 15:26:09 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::23) by DU7P195CA0023.outlook.office365.com
 (2603:10a6:10:54d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 15:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 15:26:09 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:07 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:05 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 4/4] board: Phytec: phycore_am62x: Increase size for Image in
 SPI
Date: Mon, 10 Feb 2025 07:25:48 -0800
Message-ID: <20250210152548.1263498-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210152548.1263498-1-d.schultz@phytec.de>
References: <20250210152548.1263498-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|VI1P195MB2460:EE_
X-MS-Office365-Filtering-Correlation-Id: 0220733a-b93d-4115-a91c-08dd49e73e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4nsQypuyRLFRbLg81nGIlEzw6u5Zf5z1e3Xj4DhnikpxcZB0wSJqw1zcKHiF?=
 =?us-ascii?Q?Nqbo94e8GwoC1vQjEte8m0NSP4cvnizF8GmFXTJbotYk4X7ITzCGf9NC3N0K?=
 =?us-ascii?Q?eNawVuTjDux6hmuwxHSJZDB3yF1msZVZ525NDKBl3ZAeUJFTpLr4602Cktyb?=
 =?us-ascii?Q?BR8dRQT74kDwisRD+5gRLS6oBSXxhqTaH9Szp1kRJ69c8Q2TLIHZHWIpgdAp?=
 =?us-ascii?Q?oU67aUvoYXZUaUZMgj3iagAYBpOm69590cpcg42+hu/OUSPPYZjaHn3W6Sb9?=
 =?us-ascii?Q?wL+aGHy+JY5P6Q4gT1MWXjYP2hn63iTKqgVGHZIqVx2t0he0TNyQWHVyAy5D?=
 =?us-ascii?Q?yOMZf2ekZdu04hksgzQgVFgDAaolVWMqcui16uXl9PbbHD3x7qZi9D5DPwv9?=
 =?us-ascii?Q?gWtRTH1PC9Tx01PFlctEKH9OYHChSr94UK3VmxEp67ZVUNlRRCjXH9awdWdH?=
 =?us-ascii?Q?8b2/C7+fSyHqbKVJ+41HbvsXwK8Z0QMmeRdCVN0Wr40ZadDzXjLgItUXyERt?=
 =?us-ascii?Q?6E81yJ8o0dgMofkZVhoXD4cneIA1yYDo2ZTFdSto36YCHfsMobtFJv+KUj+J?=
 =?us-ascii?Q?uah5Rih5rpwJdXQwOA87K9dnWwy9fr8MwfULn0JvRYJMS60zTC3YcSDP8qP5?=
 =?us-ascii?Q?jChVvZgRQqQVw76dvmtPRIGfGhvV7nLrPRnCkNSaJKa4Nw5b0l/la9NYXBYG?=
 =?us-ascii?Q?rSXFGWkucHGA54mmzR7cJi8eCpVwQUJwfERRLO539jJHmiIZvXeShlFhTams?=
 =?us-ascii?Q?xz9WJYAbyGyaH8RbhxajvFhvgDMqGy3eTSQ589IPj7aCUEdXnCXMngEjf/15?=
 =?us-ascii?Q?Q7tlwJxf0/5quL4StH4isT4d3+v1I+XlsUcFyYwVUzPV3cusuAT3Bzgf9ypi?=
 =?us-ascii?Q?yUNhPD3HFF/tpPpBikat8ahmyzjhYpqUaMzLwtkA3hbzsk8yV6SklAhUvAwC?=
 =?us-ascii?Q?6XZXEG/QxlfGf6eOcL8EqCB5ynrZY8C5uchO0e26Cj5z2WJ0P3T8MCicNsDh?=
 =?us-ascii?Q?RiJn43x4y6UcDWaQz8dOB4rda/bMqGIEhat9suItvG1xvxYhJ3Zx6re7g4I3?=
 =?us-ascii?Q?djTlVguWbKZMHhFlBn76IHqavMX4udtHmTZ58WdMxZkCdEI5bmr0sy2YSYEC?=
 =?us-ascii?Q?KqkBJ4iUD6hoa+4e/xX9kEx5sReooMHArTTpt7KXUu54lHJV/7ol3LmaDJFN?=
 =?us-ascii?Q?fvIHhYbgYC8zYLpznW1hFz3NAOmhR9aQBckmUKNvT7pVUjNUITr2QlxIveEX?=
 =?us-ascii?Q?HCayF2J6JoAtOIltlCvLs9PP+tThftCuBImnvIn/YOHEvV/TwPF6l3DJYKD3?=
 =?us-ascii?Q?j0dVKKIDL6MqjPHeIBOQspvxmiNUvFyGJ+DHaI5hOVeNE6ZEgnPuWJNAr23X?=
 =?us-ascii?Q?IcKxw7v01HMkdFGUIghsJWNN0/rN2akOF4Z68fdToSOr3nYv2IjjdpckX7+v?=
 =?us-ascii?Q?ZhugQ9wkwltdaiNWHq4d/9YDUSO/hnW+w1vabEy5CPWV8jzhzUoAaK/8Xgcc?=
 =?us-ascii?Q?NdtWpoACbqVQOJc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:26:09.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0220733a-b93d-4115-a91c-08dd49e73e7b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB2460
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

Increase the maximum Image size from 23 MB to 26 MB by moving the
initramfs start address up. This gives us a bigger ranger to
provide kernel images which are not stripped down too much.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 711ca3040c4..024f38ebba3 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -22,4 +22,4 @@ get_cmd=tftp
 
 spi_fdt_addr=0x700000
 spi_image_addr=0x800000
-spi_ramdisk_addr=0x1e00000
+spi_ramdisk_addr=0x2200000
-- 
2.25.1

