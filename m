Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1C4CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 06:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F8C83281;
	Fri, 19 Sep 2025 08:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="TEZrhkf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAE98323A; Fri, 19 Sep 2025 08:40:04 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459CA83281
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q90lCVNabdS8RorzpEeo15GQsIy4Q1GubO6JSjZCrMst+gDqWVfXxMFWJ1oa0O7CwUF+KlqA2h4dvhG+q3gAyTeuF0pBeYXoFsUITIAHjO9Awa4Wh45EMRZSqynpYozbVArHL7srOCbY5l6dfT3PrHF/8l+W6gpNBHE+V494qIF4Wep3PJCmxnGovSVPhVvJ7PelsBrY3+50zmK1qpgURcsqbS+7oy6JTvXkjeIADNuftGVtnVd8oAHnzESDJdpBHKZK/NeQTatJ7XmTbly5gzgC4IRGnvh6aSVOgS0iVJRxQalZI1k0uCPpKFgUwaYfT//C0zZkO12B40g+B8Wv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwcQKO1szCkxEAG5vmJ2ZgFl/atfPuFAICYcL3nVIyc=;
 b=KXFzWyCvMVTK+FB6pZvaKVFD4B8wHblTbyxMdW/ja7f41Q4SUwWsCCDYIwFYi+Do/c9FfdK8sFj6kiyN4dwWBlc2EwfVcnjrSrqcReBq664DuRB946eCFlkUvUTOLKmCNy8FO5zso1AJeP9bifWBPs//1Y0kkiHeKxo8lhIt1x+ID5i4NHklDWJgwtVq1sWFMDhkuT2cH/YOZUXs+tl9yHjPcggfkdONu+14nKkYOjTyVtFw4g64nBn4sJSi8qa+MFp51OpMa/P+WuV6zaS5JXy/Fgv8vhGQ2ihMtfd97b9FDvXm9SSj/PFgRdxx/3a8SZbOXJwfQHHzxvwem6AdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwcQKO1szCkxEAG5vmJ2ZgFl/atfPuFAICYcL3nVIyc=;
 b=TEZrhkf1/MsietW9/jdnSTbrIsQB6kdFQB75OIM/UUgtoDuafc23Iv1qX70vF/TWIp4I1NsqG5t/8bmO1awcdznUBx99hvpsEWRQS0aUNHfCVSKYzQWlW7JeEZ1wWSXAbs3KSwUMksMV0xe0m5cUhFgSWAdgb6JkX8jXg0luE3qhO/e8i/rkG4fgtdBXS1Yc8dVyeFHpGwgv90W++NwM+9McE8okGlDd8aSXkcZkV8r2K+W9ZUPF1X+d6orHEEyYNN5seEw1sh55+t6I+qjwFpuYZ2TPHTVo2sfE0fbnFjrdpFE1+G2qgTJKF1ASTF6UP9afu51Awqlyhs6dZJEgqg==
Received: from AM6PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:20b:92::29)
 by VI0P195MB2713.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 06:39:57 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:92:cafe::41) by AM6PR04CA0016.outlook.office365.com
 (2603:10a6:20b:92::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 06:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9160.0 via Frontend Transport; Fri, 19 Sep 2025 06:39:57 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 19 Sep
 2025 08:39:56 +0200
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 19 Sep
 2025 08:39:56 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <bb@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 0/2] Fix boot w/ scriptaddr & minor newline issue
Date: Fri, 19 Sep 2025 08:39:46 +0200
Message-ID: <20250919063948.3093358-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|VI0P195MB2713:EE_
X-MS-Office365-Filtering-Correlation-Id: 18842f95-aa4b-4413-2406-08ddf747597e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v0XUbUcqXGW+yk0mYOwY3Raar1+OHOmQIHyaHoZUSV52bEAY+QrR2HxhP879?=
 =?us-ascii?Q?baLDU//rnBdQGmIRGe3uPLEUg/ONs3YJTYkImZ8BFJSqo3tf5YFfZXch/Z72?=
 =?us-ascii?Q?BM3bAJiV2Jpq6OMk91km5XLrAscNAW+lf4vkXZVChNtzmjEhVrAMfZNdsk1y?=
 =?us-ascii?Q?wSPcJwYuRYayQ+652qD2iudbTa2QDASPOJNu7Qj1thdD4g6MjSCFbbq39WVK?=
 =?us-ascii?Q?VBWSA5macL8V6VUVrVQ+oLOwT9rcTF+Oo6eKkKBNBSHHmM0Mp48+51IWANj5?=
 =?us-ascii?Q?pIqhqbfGZCMFWvB3iBiJMOoSdK39iLdKTd76Ic8fsX2Ot4VtMDLOokdz7atl?=
 =?us-ascii?Q?whXcABw8ZzR5KZBqI+IApXT+r6o881QqY6iQYVuXpGEk852bjZb2K5+NevTb?=
 =?us-ascii?Q?9DtzrbxgQT5SPksIkQQQEYO9uR9bgeehvyjE1wvJqkErMmUCqa6jvWQ++pQw?=
 =?us-ascii?Q?Cu5qf9qa86CvR5GjmoOtjLmdZT+AjwZvApEXcT8GsRRrzLfEdEfeqj0mAtHX?=
 =?us-ascii?Q?C8PzyV0GjdlQWG/iHtO2Kof4m57sYBFxB5zpS3Ug6CTiitXUBQg2SUVwPihj?=
 =?us-ascii?Q?zYURiqCJrvZrF6WVEMtNKyNAYRLHw8xQJjU9xw/V00UjQbUCEwfRiD4P6237?=
 =?us-ascii?Q?kun6xHsI1sFs5hmOvsBXpL2bwd9fJ2VcZefHYlGshiy9BcZGcEcxd2DnFNN2?=
 =?us-ascii?Q?Y5FBR1mcQuOwx/b5Th27lOLclLsI9nkRj7PrV6HiOtiggUqA3gYCBvDgIvyI?=
 =?us-ascii?Q?y42ZKUjwDw6XF7Su04oQA4e4Xt6atPGAGlF6KaYoPhyGABF8iJpSVt1Txb5m?=
 =?us-ascii?Q?S+5/RDMKyRNjD0ZpCcz1EHHYFEch5tyy/o3NO6RcOeP9TbKm917lZNDwkx4z?=
 =?us-ascii?Q?dfnXseloy27dOtFr6Q+u0IYQyX7OHWYvED+i9bpRTwX0X0adlBvGKLXdmgKU?=
 =?us-ascii?Q?5e+K0AdOBIeEKb6cqwRoDoB8+p1WCh5x9QKgGd0GnwswBYMzk1UQv5de+Bd7?=
 =?us-ascii?Q?tgNaJsnx/ErbeNB1OApJrSoteabXSNUVlDCRNGhAUQ+N10Eh5O14NQjCmBQH?=
 =?us-ascii?Q?BZgcS9uD+tSmgMMbaynMe1+fIcJCDckkdBGz9Ug1FFdR5gqq0/+HZU44GRPe?=
 =?us-ascii?Q?qpKCv05/z9CNDu7/C8IMy84tDPC1n3Tqn3Fi8Sfdpnw43Xe3nUYQlKKzcGhg?=
 =?us-ascii?Q?61sH5ibPM9IX4RgBJw3A20k+n6W8pzVzdBBqNptlpoV+Ab+eZWUaL3Eu+6q6?=
 =?us-ascii?Q?d3pMM4Gd1aTk+rxxrOerWqX0mCcG7o6fWHu1fSGLkg5y3H8nCVexT6ixsd07?=
 =?us-ascii?Q?2I5egEIURpvXIAbxDOjknB72/RxSI/rVMJo+u9RIFsI5DSRuJV6Fo0YeEmNt?=
 =?us-ascii?Q?gfZDXaArrFW/Gq7vFGXmaeNgmgiCA8u8QiRU7u8AgKQnzcmOZGUC01KZZffb?=
 =?us-ascii?Q?Pf/RtPP4OTP8XVERmUlvLJkvn5yZX85M0C/sHgTO8uDEgNCi/8xl0uDV359Q?=
 =?us-ascii?Q?ktR/qKQsr7D7MkhckEJD82Ody+Bmz1aA6cXX?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:39:57.2205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18842f95-aa4b-4413-2406-08ddf747597e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2713
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

First patch fixes boot issues with script boot method and the
second patch is a minor formatting fix in our board detection code.

@TI: I think the scriptaddr should be also updated for most TI/K3 and
beagle board boards.

Wadim Egorov (2):
  board: phytec: phycore_am6xx: Update scriptaddr
  board: phytec: common: Fix missing newline in error message

 board/phytec/common/phytec_som_detection.c     | 2 +-
 board/phytec/phycore_am62ax/phycore_am62ax.env | 2 +-
 board/phytec/phycore_am62x/phycore_am62x.env   | 2 +-
 board/phytec/phycore_am64x/phycore_am64x.env   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.48.1

