Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9D0D6B6AD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627DD89249;
	Wed, 30 Oct 2024 17:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Vmnwc3p4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D4089206; Wed, 30 Oct 2024 17:48:35 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853C089216
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5SH4tFGEUnxuWFjH1HDyMtZIWJ3nANsGM+nXzlsUUkD95mfHUJvpEU4rT6i7THzTaXS9WAkhUY2g/CdCA6ZS42LakNAsS8OV5IzHEgND3jRFMBv37aMa2nLiE1VuPIUdl7eBUvyXfnbwXOF+iV2Cr3SEuPuUnKkimjGfSd8OXWYFDrWE+mPpieh5qv77uY0ksPxgIW7njJnc3Upju8Kvw4PtoTefoesT+eleDV6bpKhYn01v5k9pclVyI4HbZtYjpk5JK2xAdZ3lLnc5Wgmx9srWjEAV/l2G3VRmyLj8rUQlplUGwkc8IvaYbo/PReh1tAqRaUz1wlTn4cIQOd8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T03zYYQx84dzjIsDOsk6oQ5M05IHHe59oZ+Q+f6o2b8=;
 b=FHmPd1lPj/awOvfmJBCZt4wNjzy8W0ipFpNh3CorY1d8IcY2Chkzo3/9HxLI9MTQEoMfm5C18w/MRHPuwY+hVPSELCtcET8g6mU8VCelPkGYJclaUzdvm7RMlHGJ/Gmyl6sciznI4Uu8w1kZOylSdliBh4aR02ZCySB4lBR01F4G+HIEVnEZpHgopWr3c19D6/HWWC0wwb6PPllwHeBVEl6KJ1Q6qICI2lY/dxjBI8JbS/ythdE9K0Oy1xlTTfEJyqegpjRKKh8tZzwaihr2QZjB+ea+9+zWjLvdNxbt7Rka0OHtLMgHDPMUbUT7yzDfKqNuTfqpINQLRlBlsDV43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T03zYYQx84dzjIsDOsk6oQ5M05IHHe59oZ+Q+f6o2b8=;
 b=Vmnwc3p4mN3CVmIPLDrRLMbY6X9BLf02m82tp+iP9WMu1/6eFYEO72mQscHKWd2fQYI98lsvEcu97RKbjbMid6ipN7AO8hYUJPNGO1MfQl65MMxaY/2nk2jqeRmJWeMZBQXdXNbNbDS3wY7tn/IAWYHufAHqH+hfgjlK5WM3hvY=
Received: from AM0PR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::36) by GV2P195MB2306.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:d8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 16:48:29 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::3f) by AM0PR01CA0131.outlook.office365.com
 (2603:10a6:208:168::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.34 via Frontend
 Transport; Wed, 30 Oct 2024 16:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 16:48:28 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <afd@ti.com>, <d-gole@ti.co>,
 <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/6] configs: phycore_am64x_a53_defconfig: Add SoM overlays to
 OF_OVERLAY_LIST
Date: Wed, 30 Oct 2024 17:48:11 +0100
Message-ID: <20241030164815.1763506-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030164815.1763506-1-w.egorov@phytec.de>
References: <20241030164815.1763506-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|GV2P195MB2306:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b1784e-4bd9-489b-cb84-08dcf902ae57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g218hne+V0NYC/f8FUyMHLUZk2uafEymglMrusmM0457jLYn2xNvXsErZwLG?=
 =?us-ascii?Q?ayt9yNxMTzYsn22fk5ROwNXfjPCaexCPvbX4WXwBtOIe9JjhFkBblgxcLFIK?=
 =?us-ascii?Q?V2encMA8hMOyp1NehbbaysjKEcw4VaLEOm+OT72bE8FwDSFUtGP851rzhSIb?=
 =?us-ascii?Q?LXokdXZbBWbTQ/Tfg9mR9uE/oweQvliqmwXcv8tPTslVSbPTZDx3MbKcE5TQ?=
 =?us-ascii?Q?9XcH70leFc7NwhsDiN1habPRieuliVGCfYZE8rxpo+nFz0bvTNtXFBeDWGMC?=
 =?us-ascii?Q?xC4f3MEBDJv/KjSsmfjhxOyHTU9fBSIPVTBQJa1/3pMsCrbhugBFX1ueiFfu?=
 =?us-ascii?Q?u9kXwkiCe+n2i+cbK68axkpNqCQIIGbxY5fK2bXEdIucsnnm3CxKOojd5HT/?=
 =?us-ascii?Q?f6GP4V5YbdpkW6q/2vlvVm5l9uBr849PVdBO4NBU4hAPRVanxv5BhoGJ5TWj?=
 =?us-ascii?Q?b8KGmlssrkmaBDn8B++rYJKIHw2oA9c8V8J0b7uYmHVY4KhzI5DDhc28n1qR?=
 =?us-ascii?Q?R1xwyQeqwdnmEJRmmKkrkBOIm53sax7vKcEc5LPNEVNbGO/2QSo58fljc6To?=
 =?us-ascii?Q?E/CktwM4NqPBsxCZ3IzTPyUIwW1N0A7MtimCkfMnXv9DUZIssBZrP1Hk9lem?=
 =?us-ascii?Q?61rvsefVfjmVH1kKTFB6DF+qISaZW3nKK/iY1vgexVuDacFw4nHT3R5nC6hF?=
 =?us-ascii?Q?BF0EpKiPCufjhuTRxOjbdzLdCeblGqFJ66Spwt1hGXFCNq66Wz980/JZyZmx?=
 =?us-ascii?Q?qYdmVQn/6sYiBXMCkDCdJap1iSxuBj8pu7XsGaese1LfpuBh8q1dxr5Cr1Tn?=
 =?us-ascii?Q?5RENJL8GUHNx8Ed2crblfB5zQ29LAxm4VQPVgONhS7869PkhkRswqzT+yUf4?=
 =?us-ascii?Q?iQEMSRaFxaOPPnre/B8lG3sr1kg2ui7yMjhtx6AS6CH7r4gzrnAGPdEq1RFU?=
 =?us-ascii?Q?H6VniB8rban9TesRt0fHe/ZPjTMAYp3k6UhDwZIVMZ3LzaQaf7MMV3Po5ASc?=
 =?us-ascii?Q?XY/t0PYbSvvNj6yGi+nX1rPQ0wUHMsfXE6ZG9Fj4IX5tx9fNvgnyBu8M+WL5?=
 =?us-ascii?Q?skpQcJDNZ15QL3OewoixDtiL0NM3/zsfsatcoQspR+wSocfFyGQ+icKfZwfc?=
 =?us-ascii?Q?akNMZDec/WyyHApJYFPcJUeXLE9J6F9bs2NV39yGqYOT/2X/BUzUEtrvNp/z?=
 =?us-ascii?Q?SCN6MpT7ApKiJLzyrCAdECmP0Wcrt+AWAT/4KuDEy9wONQywuxWQCWxyj9QP?=
 =?us-ascii?Q?H4++TE9F3QF7w3VbxuTcQ8br6uoJaqzg1WoBikzSdjz3AXPrzP7lqdXXuE0C?=
 =?us-ascii?Q?aad/NBmaB3bpy0eDxPpSjNVs5lO5MNnltEW1Ax7pUDvPJOwECKax2KFyJNUs?=
 =?us-ascii?Q?AU1cOissS/rQqQ0H4/XyzbvFRMPrAK1mBKiG5qtl3TCldO6oEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:48:28.9695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b1784e-4bd9-489b-cb84-08dcf902ae57
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2306
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

Include SoM dt-overlays for DT control so we can include them
into our u-boot FIT image.
While at it also resync after savedefconfig.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 662fc708d0d..3db18d88c85 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -17,13 +17,13 @@ CONFIG_ENV_OFFSET=0x680000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am642-phyboard-electra-rdk"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
@@ -77,6 +77,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_OVERLAY_LIST="ti/k3-am6xx-phycore-disable-spi-nor ti/k3-am6xx-phycore-disable-rtc ti/k3-am6xx-phycore-disable-eth-phy ti/k3-am6xx-phycore-qspi-nor"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-- 
2.34.1

