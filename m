Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F65C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A11F680562;
	Wed,  5 Feb 2025 09:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="T8bPSzkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAA2805D7; Wed,  5 Feb 2025 09:02:13 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D54780207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjlxKhi1Ovzgh8eSrTpZwOQnR82lKD/XiPaot2lI01fbLWFEDknLhyZf2MtCUAsbdW/zn/lL+GHboD2jg3sydcc15um3eNBO+3c220lMkE7O7SKZealEJU8i4TR+9vQXi3gDYGTMJ02OmA5IAl8WEVW5sS11pVtzUDVqwH6mWIEicCJYusp3VkAM6af8EgFCoa6MgIs9lSuzqvtPF0+oFKqFFUQjfBLp4IB6Tr66I7a0ElcbXCeqcaN1Kb/s5Pw03TH2FVENZZ/blYG9jRranwaIJys8snoKhM8lBMmv3gXm4QEUX98vybEBUCZmpY3/mlKre8HKSLIPuKRiDMzVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP+8GBDuDhJP0HzjdwXdIptKxWJOLyKJUCzpcxve7R8=;
 b=cb0s0z/04BOcYHXasRA9f/PBe3Zj9sanXahuKdTgB1KZz4tUaE4Zvf77Q+7pTSeTMNT5XurwBVbKJ1WxksCQnVDD9IXZjdmfn8nVjokjDDILQPDtIIFa1TDseDtsnf8x4v2QdXyv1m3QJZFMGZ6nVB9Vt5BEUySj1NggsZTXM/kQ1Q3JobKFo08brAROaMYtEr+6Bk6yOs/kBJwqifpojSTbQpOy+SaYVuSmWXAXMWm+BIfBhlbZbTkqamEDe6cdBsUuIqEeywNv5MXzr0QF5ZDcNvZExWtdRXVCHhEahxnfcwJeexjn6EF2gnO+t92LQOLzUVbbP8392UjSDkNsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP+8GBDuDhJP0HzjdwXdIptKxWJOLyKJUCzpcxve7R8=;
 b=T8bPSzkT1fo7vm7jQgFOgxTz4IX7+035Xim2gputrx9fO0gCA2LjPaWPyvYlfBVM8bM/31S9FJbjCf6Cs2+bpG+EbFoPqIVWTqsVdIcdyc4tVkaviXLW7GdEVE1OrEfyrkVE9rahfDq17TJ/S0xruaC0XLJUUAMXZTjErpyi1v8p9IPNpB1bbPWjgIel0sZu+OEIENP3xBDKlubYBDI9NeCL5Kfiec3NSJHmMRfRm257VjAUSU62IM/iHqVo1JAyLNV2dkEbdB32AluItbxGiX3sgI863SWoaBJlcj/HZfPyd9ijLhUexNu7+Bx0abtw2FzEmskwOw1nNgQT5v1OXA==
Received: from AS9PR07CA0059.eurprd07.prod.outlook.com (2603:10a6:20b:46b::34)
 by PR3P195MB0815.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 08:02:08 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:46b:cafe::1) by AS9PR07CA0059.outlook.office365.com
 (2603:10a6:20b:46b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 08:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:08 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:08 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:05 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 00/10] phyCORE-AM62x/AM64x: Add RAUC and Secure Boot
Date: Wed, 5 Feb 2025 00:01:36 -0800
Message-ID: <20250205080146.1944928-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|PR3P195MB0815:EE_
X-MS-Office365-Filtering-Correlation-Id: 4460022c-5615-4abc-d329-08dd45bb6364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aFmj95cJ/u07MFFc4ie8C01gxcpK9EOkBQX2v1emXwLTvGACc3X5MlTraJwe?=
 =?us-ascii?Q?tPHhcfN0t2XCnNDQAjMj2jOK7E8UVTjVJsUS0TTzhICRDC3tEq4EKtBk3U7V?=
 =?us-ascii?Q?JHpgC853bSRX2KQINI84YX9K4BcCtwfhIcFxmKt33GO1xN7XLnOvR3T3J8Lm?=
 =?us-ascii?Q?T3dcB3NaIvVHlLKk36MJzviqwIq1Rz9AXpgwiNSz2Gii5Y2wCGZAn7voew8C?=
 =?us-ascii?Q?8bmYddc8AR1M/Ez7Zj1vdAdE1j5AS2+dEDKgpw3P45yjO4IbYUC3EwpMFMAt?=
 =?us-ascii?Q?ZyqEfBaa8Y3jr/0NqK8+6W75heaHkJhUJt/mBjtzoHxQCXROVBA5Ua1c8+6f?=
 =?us-ascii?Q?luMP0NFu6vh61CoUljFrhG/jbYzutnYbpgBG1KBEkqebQkhyOX/o5dnB1ViI?=
 =?us-ascii?Q?mVxulz8LHxbZ2rM2OTZbxKX7Hh47ONM9W6Qvpco4RRvMkoc74YVC+3wbxBEV?=
 =?us-ascii?Q?zXnaQt0L16loSGtF05DL8lScgsTKcFOIDQlsk3h1GvX8HRh5IZcQg7fb2e9z?=
 =?us-ascii?Q?557PndQEHEC+il90ozYStwgvcsHMHOjS9wTm/MQr6dKre9r9sqcArc146CE8?=
 =?us-ascii?Q?h0q3Hz3meTbierUZsnTUAohslolKbB9CFUaPwyliIpZu1e+uxe7SnJ5ETbqn?=
 =?us-ascii?Q?ThiZ0uBTWJKZ7xFw3cQjUjDA43DTvXRH3zy6JR+OjdXD7wNWhDT2l4jI/z03?=
 =?us-ascii?Q?bZMUKSip071oy72yGmwTYRh5CJUW00b8qu1eyngbn/JIHCxzMYAilN2R5MFt?=
 =?us-ascii?Q?B9uTlgiwLvKOTDDihBjj1O84eAnXg+wgxP/GGkazAGDVrDk7K0lzBtWAzZ6G?=
 =?us-ascii?Q?8BkqOHJrxprQzHWE9wn12hq0xormkKHHt13my4qpWrCWwoOSUetRvw1s4nJ1?=
 =?us-ascii?Q?8/um8iVjJD/MBQBod7d5CIm3wfpgSZtBtnLm5EBKUeyke6gmhELKoNqK/Dib?=
 =?us-ascii?Q?Pxz19gGzvsKwiKvcxIHLR9TJLcGJTeHoOc0I/pPl5pjAsPsvBXv3YML/Da9r?=
 =?us-ascii?Q?/ZinDGrj++wRWmuCGPA7bV1PvtJSod5uNTOqRf9Gtr2yv1/m2CTroQ93drrJ?=
 =?us-ascii?Q?kU0zBQYXKn9dsbTJgH4hLwPHFfxynihHpvKklmMlBtr04bvIbPYRqRplYRzL?=
 =?us-ascii?Q?i0ZZipx5pQeynzWyjyHFqiENkYo93xNW9saGAUr702K4lnTIm+mjakNHRXel?=
 =?us-ascii?Q?Au/R/1PsOZYJtk/67MDSR1HnR/HiqWblYC+NvkhFWI+t2GGxCq2rRUK7Hq2n?=
 =?us-ascii?Q?41Hk2M2pdBxbXJ/rzRF79PlGFvzpvlNFN2CazSUhH0+ROxaxAHm5NrxvVpu1?=
 =?us-ascii?Q?JSe1JUKQKmuWV4N1eJf16VpTCzkEHkxm+DxK+jUCFM8A9QNKzgEUpRHZd1H8?=
 =?us-ascii?Q?HBOkt+Jl4RDpX1QSpFwjz1JoA0S33GwtCcrUKOtNz9Rxfi5XRBmE3jcegR6s?=
 =?us-ascii?Q?XlO3M8eM/wY+/YJDGnCPLS5lAxxR2BARHESl5kN+WqZzS7Rf+G0yK9Vjht9X?=
 =?us-ascii?Q?zVHzlmW/rJNOHVs=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:08.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4460022c-5615-4abc-d329-08dd45bb6364
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0815
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

This patch series adds support to boot PHYTEC's reference distros for
RAUC and Secure Boot.

It adds a new Kconfig entry to embed the RAUC boot logic into the K3 MMC
boot logic. The boot flow itself got extended to run the raucinit function.

It also adds Kconfig entries to pass private keys from an external location
to U-Boot to sign bootloader images. An additional config entries allows to
enable FIT image, because our Secure Boot implementation uses fitimages
instead of normal images.

Daniel Schultz (4):
  board: phytec: common: k3: Introduce Configs to Sign Images
  board: phytec: common: k3: Introduce PHYTEC_K3_EMBED_RAUC_ENV
  board: Phytec: phycore_am6*: Add k3 Kconfig to A53
  include: env: phytec: k3_mmc: Use PHYTEC_K3_EMBED_RAUC_ENV to enable
    RAUC

Nathan Morrisson (6):
  board: phytec: common: k3: Introduce PHYTEC_K3_DOFITBOOT_DEFAULT
  arch: arm: dts: k3-am625-phycore-som-binman: Add custMpk and
    ti-degenerate keys with CONFIG entries
  arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk and
    ti-degenerate keys with CONFIG entries
  include: env: phytec: k3_mmc: Add support for FIT boot
  board: phytec: phycore_am62x: Update environment for fitboot
  board: phytec: phycore_am64x: Update environment for fitboot

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 72 ++++++++++++++-----
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 70 ++++++++++++++----
 board/phytec/common/k3/Kconfig                | 50 +++++++++++++
 board/phytec/phycore_am62ax/Kconfig           |  1 +
 board/phytec/phycore_am62x/Kconfig            |  1 +
 board/phytec/phycore_am62x/phycore_am62x.env  |  1 +
 board/phytec/phycore_am64x/Kconfig            |  2 +
 board/phytec/phycore_am64x/phycore_am64x.env  |  1 +
 include/env/phytec/k3_mmc.env                 | 14 +++-
 9 files changed, 180 insertions(+), 32 deletions(-)

-- 
2.25.1

