Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F23C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 04:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AFBA80AF3;
	Wed, 26 Aug 2026 04:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzyAZ8Iy-KyD; Wed, 26 Aug 2026 04:31:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787718684;
	bh=oVRrEqyRsPgTZKVLjBK8/ha6lb7JbVPKLn3qF+d8aLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nU24J3ds5deOAYHTaIxHwKdodlzOQfh9JTlj2YJfZCkO++R9ZwDUFnJvmE/MaZqem
	 OFSTJhF+JjmnkLU+HUcKam09dTabSLGd64tTVrBar+UJBzM8AUGVn4QXVZbHxWLsJJ
	 F/o1M0h20NvgTMtL8GdTljj1oGev00A+I55GZDNpd8KRvKNHmV1C5skUYF8BvnOT/M
	 thESSXMwFSlYUZCRwU2sr6ovpoW34z19Tl+7wWL4PBFjrNIXACfq1ohgn5PVsAjxjf
	 1RmAH9uh0v9WhRuytNu2+T0AJob1cY7GBph2rP4wX5MIx806CN6crNFt7tNKwHAaNz
	 fumqvVU5qS+Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BEF980B1B;
	Wed, 26 Aug 2026 04:31:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D17F396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F80C605E9
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDurb6SUg2p1 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 02:53:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=QJxXv0sr
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 676D660670
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkhe2/QjaW5QmBwoPVr/p+JmCjm911u76L+KXAvL+4MUMeUNw8kEGKeab2y165ZcPwCHrmbRW3vcDQN++eZtHBnn4GtWQ8OGuQ2508TO7gGEeTyTL10ofBNNYlTQ2R2VoVhNKAVej0I1xbolSA2yFDZnbUseM2uTV9rE7BXa7AnaLX4J4OptqoN6SSdD3feQ3bp3/7nEWul4qaLaE5m53czdOdlYAeBEdlmNp2Q+bn4zTe2oEJ1CNgPSJurIDpvl3PByfU892EYQKU7rw5b7WyzqeALdo/ujdVMhQNOAI/RqEh7hfxoX8gaQ7M9fDp/DXGbHAV2ZYMF0KxoB2GPrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVRrEqyRsPgTZKVLjBK8/ha6lb7JbVPKLn3qF+d8aLA=;
 b=eacyo3YYAC3xZVa6taHAzXQAT0A87hE5O1Z7ylxdEzDxeECkkzclJ7bMTQioy1USQJxXLvP4s55xshTEODbVD35QyAYeG2aF2SodUSxfbZ2yrFSS6vONHcIUQZcYyjDOog7pLN3qwXiy1L6p3b9bPPoJRHgHJGQq3HxzoKxHcLCGbWm1Bdp/Vh0CtnqaGJ0Y3s+ueiqJ5Vnk2KzqKZjnqrG7lSo/ZiGpFV/oQrMS+HWM+Z5v8NjVvfVl/2n8SdP/8G1RcD0I6UO0vOhZz+iLKvlki6paz6BmK20X3QgIZZA2zjOpRUzimDaOY8WVBBegC5MzHzShRyCkLiPNEPoj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVRrEqyRsPgTZKVLjBK8/ha6lb7JbVPKLn3qF+d8aLA=;
 b=QJxXv0srUySemVZzki2VHUUjefoHdvof/XbaS1uolfsHeRA92h6buRTk8qIA1e0zS0qwPxfJIoxB3QMzju4LE757fXNn5q6RLBU3eP3o3SIO2dIVHodiQIvrs3S16Ca1Cn3/vqVKR7Fn8gSNDXCy6kqxRyvB/84Wza5bZ/+X6kiQNJj7/g+lUVgzbH3NSG2Z6uJkfvMmFaUJaGQcVDSPOLK96rXp+MOMY7YXq8llH5tZ50y1X+Uvz3eYITRJBnXUB1loJCV0bLzlluy7OCW4KpiGrpCxdBvJ9h/cZsFqROV8YFRvg9wF2gJuLusGOnw6/VD4PoFKeP3fMOlMaSNHxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7167.namprd03.prod.outlook.com (2603:10b6:a03:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 02:53:18 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 02:53:18 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 2/4] mmc: sdhci-cadence6: name PHY and controller config table
 slots
Date: Wed, 26 Aug 2026 10:53:01 +0800
Message-ID: <ee6570ba9e857ecca961c72aaa82e4cf4533491c.1787710268.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787710268.git.tze.yee.ng@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 15718ba8-0ced-4b65-e6a2-08df031d2e63
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: tUTsyhl0d8qsFUDIZ7rcZOrZX8o6/SfBxkoqFYxxGVvKGnd2i+mITSJ8P9GTG0g/NWfaty7X23BUu2M1oGe2GRUAOUe2hKndAKZCyIWv+ryHQRyrvNgS2g0ub+FAtKjvgWSSg4Xvq9s5REoZjXDZ1KUQNUfiG17D65xvqBLTU/iFR97kixtkvtEb9cs9uEHTRYj7gKNxmxdNo48Ud1lACeSvGHstJlBXwEjRadKhzXsUmPM+sjXyKFclRDRzeRUHrra66QHFGlsdVoRMXaYNhqpf8Gh78qWKO+W7JTDkyhwZDEb1ct1ooJjA+o9If8LBDvSyQeERk1FbOjt7Ds/Vo/1ktR6EvEJGs5s7xlWHueJoZqYGcbwn0q3hh7t/6doNA52xmLyfv1I05kLt5P6EOvS/e9SA9NpYtGjy3KSTIPDt+iiXKMR7q2nDv+ZuonJ30V+WWCv53/uWsq7VcO8IwecSzWrsO8qEJZUnXVqFN3aoXWVKenrXQhZTQhVfPhL33fVKZhinN8JZXg8EKn2CeiVYnaBDtZ3SP5acRIdjOC9kLkk9M38UdL1NE08oz/GXSkWiu/NpRxzv3OtpBiE75BcmwBLcZ0drwHKuBGsWBbDPQ9DJ7W/0FnzSPV8BsfqVkrD/Gy65ChuygCNNOv/DXv3aodKiUlx/Ywq7U/wjYgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yg1bXO55rBJU7G6KryCufSWFdMbtOxpkoURCMzhRs8iV9LJgCezarcMklocU?=
 =?us-ascii?Q?QFSAWvIYciAB8KEtTuEIPga1jtCrHq0uv2ADe4mgRBb9+rVcxDay/XsVYJKw?=
 =?us-ascii?Q?E+fy9n4Bok9CbDlsVOdVCzNiLQITAyonZJyURnsGV7Z0T+RNCFRDFpNieqJV?=
 =?us-ascii?Q?qK/QxCIudgb6bxF+E80FSVNGQfev/0s8IFDlovyHW6GwfS7OUuCwFfzyO7e5?=
 =?us-ascii?Q?Z4o9R6PO0hB6+aNe1cyFuuFhlTWJCvNJ0fTgTjK7rQU4PTnJ5YOQWQ4PN1IB?=
 =?us-ascii?Q?M03KWBpo5Jk1PMJDm9NI2Sm2FMLvYTVc//3kj6RvAFGavOIrfwp4mYo3EebW?=
 =?us-ascii?Q?hlIRAp94DEj0XFsS8pCiD0UGugtIS0/kER7xCE3UXZrxdOcJ+aaUhBy2Vjeg?=
 =?us-ascii?Q?VI28bLpV5CggPrnDeprfcERlwIuJCtMucJ+U4Qr8EQWs7XGLvMndSp5cadPK?=
 =?us-ascii?Q?uKYAM153o9LMsCKEeKJvvZuE2GOWHLWzkNMkL9Smqcqz1tURY9DlITBrshXa?=
 =?us-ascii?Q?7P9luFvghxxBzQL9KZTELC/jufM7GXa8rkkeVLG5PyOEFu3dwVO3ZEdPtxNq?=
 =?us-ascii?Q?+gYrdWUa7Fcz/z4WWUDzM2/J1DxuMWRXsJ3crzd02//QZWajLom/7admzNWv?=
 =?us-ascii?Q?iW+hNbD77SIpZBX4YBfEdkDVNMIJVHIHL/mcYs66KJpEttVLiIDRK24hJpVw?=
 =?us-ascii?Q?UhtZk7VsVjtuWtBtIMgs3Gw9BuPKl3H3gEnnnN3a+BuTc88VwOKxFxKcafPY?=
 =?us-ascii?Q?tex5BnKf9Y3Mk4NkDZzA4evLbML7PgR9dsdISeh50NICYBSdQJGmZLRCZjXa?=
 =?us-ascii?Q?LbUgmFJirImHDl3q49QH5WIMhvcccpxN3EHpcBG5fQ/5vrG/gl3fTt09DNOD?=
 =?us-ascii?Q?VcRAbE3R6p+bLSM8XKPqFZZocSGPwk8CF2vim1UODfbCHcxu9GnX3ZOIqlwu?=
 =?us-ascii?Q?h5cMpG+KLIBzp9B6GtW8/dFc9/GC6yKvzQQCu6P5GoNI0tlQwU4jdWneKieV?=
 =?us-ascii?Q?bT6HmTcUZBvq34WSQ2gbA4KFuDgZvyg0bqxzfU8xuY+PfpPqOHViwMwcZapT?=
 =?us-ascii?Q?MmxDq7qigZokV6NSh17FSXnVKrnbDfltJvq3ZznXuUd4rw+9MxLkhxQ9c9mD?=
 =?us-ascii?Q?Mrv0Nye/LLLFWnST+GpFs31+44gfZEy/fZBN8+AiaZmngc7urlc9P4wx5ZVX?=
 =?us-ascii?Q?mkItIe0vu9ltjLwq1I1ZM1OMSo3AA3EH1nogMlUvFsCqLtsWxJAKipZ6Dx1x?=
 =?us-ascii?Q?st3OMuh7ik35ZJZG1R56M3g0VCj8B9dX9icprq+4HgWOs+/WWRBMa0NJhbQa?=
 =?us-ascii?Q?Z0tj3qEuP0kGdTjdPfT0O1O0FHUKCJNa1WPYiaWzJdrbXOm1Q4qryd9MHWnx?=
 =?us-ascii?Q?I84EKlOtLntx+4NnPK4mK2n3pL3OQmCNpd73SOGc6kQm1vu49E89njaSKmA9?=
 =?us-ascii?Q?mHNKoaHH/mXhDHHljF5vk9T+eUD4egF+Yd5uBZNQE/YYe9DgIAVGp4m0YEL4?=
 =?us-ascii?Q?iLO1pNFdjzxPRTbnukmxiBuHki1jkHCodlWanjdQa5e60YPyylY3uxvIPusp?=
 =?us-ascii?Q?mrXcthq9kFMfFVt0yLHRO48dvRW1PZoFzK01xPWgWUV6U/dJHmFn+baL/emd?=
 =?us-ascii?Q?eAMxVAIEmxQEpLCg5i6SH+HXEvVJkOvq/P8smr0wGoK4GGcj7UCqUo9zg+p4?=
 =?us-ascii?Q?Ur6JcbZD6MAEcpWx6Ktu4JXzt1NAtaOa5Wdf6rxjXp3uhIdo3G4bzj15jpqU?=
 =?us-ascii?Q?yQsSEyiSKQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15718ba8-0ced-4b65-e6a2-08df031d2e63
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 02:53:17.9839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gDJ3cfYRKVljhA3HhQCynIWe+/TF03wxIDHjBgLqpXOYnLg0J762JB1DFomX5s+tJQ4sbzODPEIRTKjqaOYKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7167
X-Mailman-Approved-At: Wed, 26 Aug 2026 04:31:20 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Tze Yee Ng <tze.yee.ng@altera.com>

sdhci_cdns6_phy_adj() programs the PHY and HRS controller registers by
indexing the *_phy_cfgs[] and *_ctrl_cfgs[] tables with bare positional
constants. This is fragile: reordering or inserting a table entry
silently changes which register each slot programs.

Introduce enums that name every PHY and controller configuration slot,
whose terminators double as the table sizes (SDHCI_CDNS6_PHY_CFG_NUM and
SDHCI_CDNS6_CTRL_CFG_NUM), and use those names when programming the
registers. No functional change.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 54 ++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 1ff974ecd44..7bd47b462a4 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -59,8 +59,6 @@
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
 
-#define SDHCI_CDNS6_PHY_CFG_NUM		5
-#define SDHCI_CDNS6_CTRL_CFG_NUM	4
 
 struct sdhci_cdns6_phy_cfg {
 	const char *property;
@@ -72,6 +70,33 @@ struct sdhci_cdns6_ctrl_cfg {
 	u32 val;
 };
 
+/*
+ * PHY configuration slots. The enumeration order must match the entry
+ * order in every *_phy_cfgs[] table; SDHCI_CDNS6_PHY_CFG_NUM tracks the
+ * table size so the two never drift out of sync.
+ */
+enum {
+	SDHCI_CDNS6_PHY_CFG_DQS_TIMING,
+	SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL,
+	SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL,
+	SDHCI_CDNS6_PHY_CFG_DQ_TIMING,
+	SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL,
+	SDHCI_CDNS6_PHY_CFG_NUM,
+};
+
+/*
+ * Controller (HRS) configuration slots. The enumeration order must match
+ * the entry order in every *_ctrl_cfgs[] table; SDHCI_CDNS6_CTRL_CFG_NUM
+ * tracks the table size so the two never drift out of sync.
+ */
+enum {
+	SDHCI_CDNS6_CTRL_CFG_HRS09,
+	SDHCI_CDNS6_CTRL_CFG_HRS10,
+	SDHCI_CDNS6_CTRL_CFG_HRS16,
+	SDHCI_CDNS6_CTRL_CFG_HRS07,
+	SDHCI_CDNS6_CTRL_CFG_NUM,
+};
+
 static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
@@ -277,10 +302,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	/* Switch On the DLL Reset */
 	sdhci_cdns6_reset_phy_dll(plat, true);
 
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, phy_cfgs[0].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, phy_cfgs[1].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, phy_cfgs[4].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, phy_cfgs[2].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQS_TIMING].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL].val);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
@@ -290,7 +319,8 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	}
 
 	/* Set PHY DQ TIMING control register */
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, phy_cfgs[3].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQ_TIMING].val);
 
 	/* Set HRS09 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS09);
@@ -298,20 +328,22 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
 		 SDHCI_CDNS_HRS09_RDDATA_EN |
 		 SDHCI_CDNS_HRS09_RDCMD_EN);
-	tmp |= ctrl_cfgs[0].val;
+	tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS09].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS09);
 
 	/* Set HRS10 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS10);
 	tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
-	tmp |= ctrl_cfgs[1].val;
+	tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS10].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS10);
 
 	/* Set HRS16 register */
-	writel(ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
+	writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS16].val,
+	       plat->hrs_addr + SDHCI_CDNS_HRS16);
 
 	/* Set HRS07 register */
-	writel(ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
+	writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS07].val,
+	       plat->hrs_addr + SDHCI_CDNS_HRS07);
 
 	/*
 	 * Wait for the PHY/DLL to settle before the first data transfer.
-- 
2.43.7

