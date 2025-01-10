Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E28EE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 12:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F72A805EA;
	Fri, 10 Jan 2025 13:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LvjHo0e3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F6538061B; Fri, 10 Jan 2025 13:35:57 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089D98036B
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTqdU9Ycw04wCUG881GUWc/kt8TM7grKroRfV/TcOa7J1WpY4EMTKq4284Ty67Py3QTLCcWkcIRCJ59AbuQqtWGIQak3P2WvadFbOKQ7H2s3V43Sq2jI9u+3ZltToglw+HFNIOV9wx3DkqS3nBsJXgTq1ey6Mh3or4S56iJnr2jfrVCK3Q2kasCVh+2hYOjmCPtX75e/UidStJ5OpVIR1pO8egYS5qdkfgKPonaX09uN9oTqP+lkug468IX4i+EqqaDv4N0A5hm8KNQp+kZqYOXYDtUS8WbXdQFy/Yaa6YJsVegxC6Pp8kbrpFz+UNY6OWJIxgHB1sRThXLBA5zgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnnmoYPrqt83H1XIb0KuVwKpjGehoiG+u7MSI/tmpWs=;
 b=UuUgmNx7HUjJoEceqAuCVTcGuUVZOXubjfiI9N3OAlNUJeSTo7EJY2kYc6HfnDbnxZoFEtQfHNewoW/KdAH+YEev1LJU8qi8dyG79B/Uq/fu3nGnVOcP4ssjuIRko/MWhXiyZN/+qQOpf670L7JAxvru4y6AByb+vhQNUwEi5G9rma9n0148/DFiaZU75ptRUeKg67tr+1Af5LfnKACUD6dQn//gExW24ewi4RSIT1zSiGbHgCkVA/shWSLTH9Z9hLHe628uMdRC19cbFiOiNsqe6z3NiawEyVnVsbQoFH4jRR4gRT8IQTYDpXR9R2yaeNYKeovkjmyUOZzY8ZxdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnnmoYPrqt83H1XIb0KuVwKpjGehoiG+u7MSI/tmpWs=;
 b=LvjHo0e3sPaAshojxS0qYV5R9Ex6rZ4twgM9HzZdaRwg7RjjCHMqjNc1yFQg78WbYvHhHLKpOfquWC5vZWNGfpSalfzpazg5mw38EPJxX4i5tMrr6C8+CyW90+lyc0BOAyaOeOJXzbWt1c0g1CSo9XoZSP9lnrr6O9/RatgxWBYMV31fmvU59zmrwShTFsikkjBPvt8za05+Qb+MaxBb9cLyoXZWJlrqw9uUPDLudfZABnntfO+IEXWTuKL1K2HCcLKQ/JzQ/9MRD73mB+Fm7x2BRL8Dzz/6cckYfhsR+mdDqV+J69dHzCocNJousc2wuH0YvdRIT3IiLM/pZwV7oQ==
Received: from PA7P264CA0140.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::18)
 by AS4P195MB1886.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:576::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 12:35:53 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:102:377:cafe::43) by PA7P264CA0140.outlook.office365.com
 (2603:10a6:102:377::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 12:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 12:35:53 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
Received: from lws-moog.phytec.de (172.25.32.31) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 10 Jan 2025 13:35:35 +0100
Subject: [PATCH v3 3/6] imx8mm-phygate-tauri-l_defconfig: add optee load
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250110-phytec_imx8m_optee-v3-3-6c39dab15592@phytec.de>
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.31]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|AS4P195MB1886:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e56f8c-1f56-4da5-be8e-08dd31735295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1BFNGpwTVZGK2ZMMW1QOXhNb0RnbzRHUlZ2M0pFY21GVitzU3pPeXoraUwr?=
 =?utf-8?B?Y2dUT0dqY3VXb1JFdUdUenF6RHduanU1b28wL1EyOXJJQ0RET3BVeVh4YW4r?=
 =?utf-8?B?ZzVZMklSemJqQndCZmFUMDlQc3phQWtrR3ZXdkNvVVJZSkRDNkJlQmgwUDFj?=
 =?utf-8?B?Rlk5UUt3by9OVnU4QXhZcGRrL0hWdVRLeFB3UC9GTzYwdDEzUElxWnZ2MUdE?=
 =?utf-8?B?MFlaRUprZGdWN3N2SDZSeFNzQldEL3ptM2J3a0orc3UyaythVk1jK2R3akJj?=
 =?utf-8?B?T3dMdXhMNWFKU2oyZUNhdk1aSlc1UW9JemVIMXNXUGR5MktlZ1N0dFJNLzZL?=
 =?utf-8?B?cXFuL05NRTduZ2trRTRYWmJJbERWUkkyajlKMXlMNy82OXBCSlZKYWcrQWd2?=
 =?utf-8?B?OENxMHVDdml6d3ljb04yLzRLTytGeW5VN25kdmw1T0RWQXp6WW1kMnpOK2Q5?=
 =?utf-8?B?cXBDWkxENExZWkFvS3dHOW5PWUQybDExSUs4a21iTzdCTlNNK3V2VGJPUUpv?=
 =?utf-8?B?TkFZZ2xmcUFGZjJEM1hZQkN1UGRIeWF2WVdkeXNjdllaUHRJTDhuWGswV1A3?=
 =?utf-8?B?R0Z6WDREWGxQZTA4UUFMY0pZb0pzMDZFVDl6Wi9pM3M4N2ZHTThwUDdJampJ?=
 =?utf-8?B?V2duTXpMUkM4dXBySytTNldEOEVrOE9uU2ZDdUt6RTVGUVdOVXExM3RzZkZi?=
 =?utf-8?B?MjBPWWtXNVBBVWcrT2VwaWw5Q1hCWDllNjN2djBoOWNseTZhbFhvWDRJNVJO?=
 =?utf-8?B?TEcwZlNuZDg4dXV0Q0NXSG1JdTVoYmh5L2xqY05hbkJ5bC9HV3NuRHBJZXlQ?=
 =?utf-8?B?ZnVwT0wrK2xSTVBnVGRKZTduNzdjZG44TmhHeUZHeWQxdnBnMXFTclVwc2dZ?=
 =?utf-8?B?NDJHYlBzcStUUWYrbzE2NDh0eEh2aGFlT3JCdndsby9hTFN6NXZQNkN5R0kr?=
 =?utf-8?B?SUducE5aMU11WnJ1NVZtSzlrc3JyNDhaRnc0S2hLTXdKenI3cGtDaU1jZk82?=
 =?utf-8?B?bk5qeUVJVzZBUDlxTHErRTZVMVpUbitsNUJOcG45RTREcklLeEFydWNGUVp4?=
 =?utf-8?B?T1VKRUdaRWgwcy9PZE8zc1ZQWUpONUJFN0E3L2szckszTlZFaFVBbmFldzIx?=
 =?utf-8?B?elJ5WDVveXB1ak0xelJ3ZUlGN21icU1hZmNHZ1RvSXNmb3FEVFpPOFFYcVVE?=
 =?utf-8?B?QStsaUFxMUIyc1Iwa05FUWMybk5KTEVITXdEdnROT1grcW42d0dGa1hLVk5F?=
 =?utf-8?B?czhacHhicWY0Rk8rWTZWZVhKVDhOcG5XeVcwajlqalFKRmZQdjBSNWQ3bW9v?=
 =?utf-8?B?djFIamNOVzYxR2p4M3BaZm1BaEl0Q1U0dmdjcmZyZmx5U2M0REVORlFZSkxt?=
 =?utf-8?B?U0xseTZsaFJaalJVRlZyWE9KTmp2RG5nTlV1dTIrQU9LZVU1QUlCUmVucDNt?=
 =?utf-8?B?YnUvbm5sVk9Eb09HSldKUXFMNzBwZDgvR2JkZXVpL05TMDE4MTBVVDdFbUVH?=
 =?utf-8?B?bnFMSUhCUW1xTzIwajFQbk55cmhnNElWMWVRZkcrS1J5N0lKcXRMZWF3R2kx?=
 =?utf-8?B?bG85aW9WcGlQdGVPM2Jta0tTV3dTdzRHQStBREx5SmVlR0paRmlWWG5HSk5P?=
 =?utf-8?B?Mm5halkwTmswREFGNjZQOURNVkVlWTJXRXB2VFE2cENNbGl0YXdmd2RmRFB3?=
 =?utf-8?B?M2xoMTNmQWJNdFdJVFhCc2NPbTRVaUwrQ3JkQnhpcVdEUzRzZWI4ZXo3RUJG?=
 =?utf-8?B?TUY4Q0FvbU52T3NPQTk2MElWNFJCa2ZBUi8vNVlTVHZScGRPcXFZT2FwYmkz?=
 =?utf-8?B?WU01MEQ4MTJVbW9Xd1NTSzJCZkhBSjZjdTdjcEwyb0I4SXRkNGJoSStua3Np?=
 =?utf-8?B?eG04eVFTVlRyVFl3WThNZXNmYXhEUXBLMzhBWE00R0ZVdEIvdHdrN0hvRmpo?=
 =?utf-8?B?ZVVkOXRMTDdFOWQ4dEUxRitmTzFwalBkTURNOHRGcTUyOVpkeDFPV2pwanBo?=
 =?utf-8?Q?wNjy4vp5M70g6OPf5G3PXYxHz7Bm0U=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:35:53.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e56f8c-1f56-4da5-be8e-08dd31735295
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1886
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

The phyGATE-Tauri-L expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 18fffa7405e..c87062404da 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y

-- 
2.43.0

