Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F3D6B6AE
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760FE89216;
	Wed, 30 Oct 2024 17:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="k8+rpRrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70DB89229; Wed, 30 Oct 2024 17:48:34 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E62E8921A
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DejDpooq2jwjCteJ8lwPoNktc042QYPp/iG49cyVVg0s6+hAZqf+J4dywianvxGyebas6RhyVxYI012liiv6UhyyCNWBFpdo1bME1J3EA8co9Y7a5IuTN2nuCucGtiVwnNuEwOy8DrKmKtdvwjp7ukmA/jsvcSDarFyAUXpXOPD8ZMobAmEoQ5eEDpm4zrJApixlYrPGMI/PVDD29L5quOfEO4pesjppBFSNCqplHPgMxAZ4zpha0pAyAS4klwXIUGfS2s7sVNNn8IqT/n5CDdwUJOW+ykqdd8lc/rT/1eEGiNwM9i7ZU8wNDEeWG/6hunolqBxo+RqQ9Ax5EzZdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDB3w/AqutDF4ncr0QdSLW59HkYj/zGCLG+ZtNqsRjo=;
 b=UeFMseNX4OaVZTemoNq+D+tYEnoIDibcVdEasHGpG6F46NAXRrbfNRiuGRpkvQidYDSl5l/SDdyM+uqbqZHMeCfNPpmEIffweRleYNc4TvD+80Ze1oOy/ZWmzPzaYltl3PiU7+6Xpxyg/+c71xhDyPDH+UgCBru1WBKKTGUuhTkgsA9KU+3wLpBeu/V3YCvI8nZK17oHorNQadvdgHZ9ytGbhHW3q6V4HxTOZzu4Ad0ieyalOw9/p2msdLIzdW5K838CcezhJtkbD3NuLtjkEJytkOueQ9BhDizH2KfZHLhL/g2zg3wOGbrFuDhU8OhqDWGCq9b2IRHBF6o3wQQz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDB3w/AqutDF4ncr0QdSLW59HkYj/zGCLG+ZtNqsRjo=;
 b=k8+rpRrgCuFJj7QHvSw64FOg4HL/VW4efpE+71meUeMuiqOa3baTUk1LHVTpnyo1VuB0lFIPP/JC+zVohacq2iTjo8abMP08Oekd7ARK2AJDC8yuIfewHhdpJsZ95j4HxgbmKLto57iEDqY2b+XeVCiR5eqiAM9yh1LhEjWyU18=
Received: from AM0PR01CA0129.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::34) by DBAP195MB0842.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:1b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:48:29 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::52) by AM0PR01CA0129.outlook.office365.com
 (2603:10a6:208:168::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
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
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 16:48:29 +0000
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
Subject: [PATCH 3/6] configs: phycore_am64x_a53_defconfig: Enable
 PHYTEC_SOM_DETECTION
Date: Wed, 30 Oct 2024 17:48:12 +0100
Message-ID: <20241030164815.1763506-4-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|DBAP195MB0842:EE_
X-MS-Office365-Filtering-Correlation-Id: 649ea6dd-7245-468a-9f51-08dcf902aecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xV2blaoLqopbBIi7I+CuRiXHpfjrsU18L27x7wd3kiPCM1skIUxK/FDbLePb?=
 =?us-ascii?Q?gWGVQL2eliA23Ja3Ce8y9mRDLbcK+HXV99ly1m+1XQS+5DtMQvva0a2iiNJw?=
 =?us-ascii?Q?xvIRWhUjpovSYfG+DwUc7LQmLOixzEx/UREjauTGEBW6VxKvsOf/9R++p3lX?=
 =?us-ascii?Q?bE9LOazEMDalwDEEaSJK33TRnI/I5PX/VxW4FpLXbvS0DqPs5lgentC0jsXd?=
 =?us-ascii?Q?/622y6hgoLLc1AnIGbN2WRXQmKJoV5/XpgvDkdlvx2fCMtrjQtY/K39cn6Lm?=
 =?us-ascii?Q?ha/jPgHaM/rAjJpuN/i2RVucdZKJ2Vu7qeJpd6ZqWH1cAX8g+BlmXBzM05Um?=
 =?us-ascii?Q?yETqobOnEHLMnO+o2I3evPrucrkW5k6gtflspXYpMm6WGOacK9bHsHDYP8xf?=
 =?us-ascii?Q?HskMCuNeORlFvQF5nSuCaBCrmhywpA4tBg/MYaom+/V7N5Tw5h7ULGCStoDy?=
 =?us-ascii?Q?3cVoSylPmC41TXHCeFWZnv56w4+fAMjbuSWxc63je68qdlZUTRQ4s7kh7tTa?=
 =?us-ascii?Q?jV1zWMa281qdpJRZM3PvEDydp+9OAxp0ggCcX39pvA9t4VIE5IKqEqHgjeRN?=
 =?us-ascii?Q?szUZTmj/lrur5L14QVjqcU0VvlrpCuMuKZXEOXzaZsn3U2l/NrH7XXeop1i7?=
 =?us-ascii?Q?rg0GzstVQwF4hDmYuxZibRc45/NOjFwGB4GPqVvUqS6LY/3Pml79RgOfgrh6?=
 =?us-ascii?Q?Bw2459imRO4pCkfEUBPFmETXumIid/3DP1pSqJp1F+I43uV4axQxRZcgdpnb?=
 =?us-ascii?Q?txQGJy+ClXJvS6yUvJbwerRMfQG2ZQw6eXe4aH0jU6IhvYNOcUlJuFF2xdj/?=
 =?us-ascii?Q?5PtIX3/7Dy53gfTMtyQerseXWqX+vy8N7p7OEBrP65gl9IM+npsKdNLXlCb5?=
 =?us-ascii?Q?0HimRVIul5bf8tlBeFYSty0GWdVGxfwdwdO+DEXf0/Cp9IXDU+JmRuWWTlaA?=
 =?us-ascii?Q?nx+AMlO2nCes3hszMMgDgeEPqtmOUqzW34a4RYWPdnZ2MLfLrf8u3AHcmT+i?=
 =?us-ascii?Q?7BJGzKmpF+Dkgtroc+fJvey29sGgjFQNSmxIdisWSEF/PoT3Wg5Y91PVlq8n?=
 =?us-ascii?Q?73Q0iToRKEqejTHx+RWTvFSOEhhCnhWszVI+XX9mebSvNKqo2Dahw1ePxCVe?=
 =?us-ascii?Q?cwlon6j5O1Y24DmYoC0+LmeLVxbE/Q5FVQyi1KV6bOTVmE9Egi4FD+DmRZbK?=
 =?us-ascii?Q?ZKEsA+XL2nhxbqcWe8Y780RLkXR2h2S7EE65i/LR+ryjD0mkLL4NZ/+o+Ilr?=
 =?us-ascii?Q?tkqTOD6X+1pqb+7HiJeFX2R+UuwIuhIEirmxGmx7RFwl+JTjCgdicex4APyq?=
 =?us-ascii?Q?nUxxcmeoukh4dMztgTPd24Hym65t20SYaytBprs5I+qrVTQklQHUUg6JuH2J?=
 =?us-ascii?Q?249Nrw2416BbDfvrFvUDWwIBk1PvwPxyI+ORJOw4E6g6o4rDFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:48:29.7351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649ea6dd-7245-468a-9f51-08dcf902aecc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0842
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

Enable CONFIG_PHYTEC_SOM_DETECTION to apply SoM overlays
based on EEPROM configuration.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 3db18d88c85..ac9731d9674 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -10,6 +10,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM642=y
 CONFIG_K3_ATF_LOAD_ADDR=0x701c0000
 CONFIG_TARGET_PHYCORE_AM64X_A53=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x20000
-- 
2.34.1

