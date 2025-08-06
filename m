Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428B6C87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 872B7842A4;
	Wed,  6 Aug 2025 07:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ot8hs6Jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B3783965; Wed,  6 Aug 2025 06:34:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0531C8399C
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF42P1Tl2TotRbwgd6lnAghvmyc8X2Ris9SzhFBwDjmoJthVS7XgPQre1hdTmsvDAa7wY1g2eUxouvOdxMZQICIbi8L3yjbaRNTDYhfG7bFC/BjjLbetAb6vDRxGOu2XeMpZbvHcLty2fdKyyq7FjZCsZ56k9zZPTk1IkgdYngIiztnXpM9BVlExQJYoGGKCiPjR2lGdR3CxkEdmThgW2KFlkFKZq7KebfIm+Hmn1bnKIzUiIo9Plt2QiT/fY/O36FYcSxfPqfdFdpdrMob4ozjjqBRbsZM0m8ud44O/X1xyfaxRg9XaK6gY6Zi14VnpuymextabOWYSrSsHYGf0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOSAMQ8SqgsOZ/ij5sz9RnuM/WHcchQndKgC6pJukZg=;
 b=Pj0tyQZMFHHZ0ZpsR+PI0ZEL2U/qUidC5MO9cWINH2f5CbU8fIhUgTHEGIL3gkgNStxIvzZueEeHF4qOmqp6K8q3Bq/KT3vwdvUT/phwK79OapVW3F50C6A/AQOQabjQzqUqlOPoSpQdwbCHRYrADC+6TqkKtaBnu3aDVxdu8cZ+YrOZTJoHxJuSXm8rGOdCWfee5vDAhwVxn7txSO1qwoZUXzGlWz9N5ZBMfjK41WmMI33A+DzIXJKLwmHFgolIYCa7JJstob+ccOICp+c+dYPt/5mFeVQ7HweEFib/K0Mxg9jWORlk81DmaV1dFpljAW4/HLlPSBkj/1RCyiUR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOSAMQ8SqgsOZ/ij5sz9RnuM/WHcchQndKgC6pJukZg=;
 b=ot8hs6JxO6OKVkD0EfMhDwLRPuCWsboKq8mtfZ+68+kC1MlQ5l9YcDzMrqxeLPTuJMI0AWdY9jLajhEOWKLIi3KbQESdE61Du8HnqfisqpqoJpoVdJ1HCyC2OWVOcafTj8VXG4mtOIKDBTYPSUNMXJqnG+iFAaQFntOAIKDCnS5LYF4JX9KvDLgUmHH/Efoh4fRzdydS+aGfIN0qMj5PM+G7Meh+UxLSYyu9Ox3HD5W1HlZs//clfVWdx6Z5M8QlESPSRRwsYFo1uEW/AL2E3brasWbsP8ikLA83xXQg0ZF2Am6BdXGh+LjIP5QPf7pqjZmQOARE1tKILzbN3Li7TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:53 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:53 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 08/12] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Wed,  6 Aug 2025 12:32:31 +0800
Message-Id: <20250806043235.2260-10-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8cabce-d07c-4769-f768-08ddd4a272c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M6PXDqS3g0jweeZoB4leKAt9awn7h36DWdkDdITmFAQDsX4LnTvazfae0cy8?=
 =?us-ascii?Q?deXvrAm2UEAh0JSDBBlSvssj5UQCn8NAEHFLs4kPEhesKW97nSs2gYvVE8fC?=
 =?us-ascii?Q?K099FqM4s0HXo98YZVMiJkOV8fAii9JLtGpqKrv0r9q5diOcOTHGDZ9pyzqY?=
 =?us-ascii?Q?+tCrw/RIOL6Yyx4pbEVBNYQ0G8MKoC/eV4h45Fb7KBl8+MQ/P7gIj2rpLbx+?=
 =?us-ascii?Q?g/o/mFURXT+p/+YpOfHKT3pDuqUjfbVzV/ZHVagibh61uaBVFqUqs0FTM/EY?=
 =?us-ascii?Q?X6EwSbJ9zXt6aljHWG/dff41YhTAXeza2+Gvs3nddp84ZhcXVyvhI3A1BmNm?=
 =?us-ascii?Q?RcY4QiiY3trgZPoXBIO59LFUn+2cTNKGJKbRWEe3cxsS9MmRb22CtjWdYt2Y?=
 =?us-ascii?Q?OvFGc6p6XbqgsXavN8o+hJWdQQUtq1Z+aVJrmXvFphSKxsSYo3vtNg07aJ1T?=
 =?us-ascii?Q?rsKIaqD8F33NaoZKchOReKpLKy5tPjcyV2S5zknw14Xz8vwJVnOzhDlIKg7d?=
 =?us-ascii?Q?4ALyVM04zs4ycCzJtU87WBXaHQc7Z1chazCm2coffA4EFXHRN1i4VuaAx3kg?=
 =?us-ascii?Q?+qIv96ZqCt8iEVsYRCrn9I+RGo4MY8ZzL7j5PMu1x+9SJ15Ejk93L8rLOAv7?=
 =?us-ascii?Q?UQvEQSZRKdbEYfxoDyeJM5hHkD/xIsNZaqpttpc5YN1hWVpH9XOU6c942eV8?=
 =?us-ascii?Q?wHv1thQtARtXOJU01NJWwIqQNbyPlMXF99ygJ9We4U6gP6kXddmP6l57t5hm?=
 =?us-ascii?Q?dl45qKJ3THTTMWRnHIPD1jFSzZMvGPm30RI+Vlr0LyQhXaX/4DpDrDIVxN4I?=
 =?us-ascii?Q?hb3ifAWA19MxxmhQDontd5E/LMCa9yzq8MbdTdk79icJL5w64NUXJwzp3QUY?=
 =?us-ascii?Q?7ngqj7F9atv5ydbCnvYPn1GX5ZNngEXVeAvYnZTy5I30dk8oTqIo412G+IE2?=
 =?us-ascii?Q?2lMKgJuW+Of9r8licI/YFMRmCIDRvQsNq9IljnG2Tf08YMluCceKqzWeFwCK?=
 =?us-ascii?Q?5uNtuDusoPZItkVHYUun5DgLCD7s2TmXPJm9P4x4CYyOC7YzykAqijdBzEqG?=
 =?us-ascii?Q?2/iwLca/mciNuO1rKNHg5yyUIODvMVWzvi0/gos7Cm50MVtRDr/EE1D/HQqg?=
 =?us-ascii?Q?v9V2BPVi5VuFit3mS2rOUVRYguaQkuYluNETITANILisz2sCrx24PrKwhnBM?=
 =?us-ascii?Q?h0qZSBVTD1X6Mwped9mSyKUbzrn2E70HdInCgzsRpSwhTf69bnF2dH78ehI1?=
 =?us-ascii?Q?oJQRliIHlxoYE/Fr5J1XKgfX0fUPnbuX+iQnn3APd4KeU4Lfohlop4Piuj49?=
 =?us-ascii?Q?ERunMHRXxCIVtG9pIHArl72jqdqZIB4vzzbzS/3TkXqBnGmxSogipICFiZgw?=
 =?us-ascii?Q?FgEXled1qpolaxRgHqx0V50jjz0qC+AxrLyg9cUcuBxjLiDyChy2liJ8MsPP?=
 =?us-ascii?Q?kRIESbPC+VI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?252wVQp6uxtev8/U3YLpSMfZMBG81ccN/MqVPH+fBRRwx8JF+v57CQIYUDu1?=
 =?us-ascii?Q?2Xi7Y6mNEMPBsu6L05gMCXFZ5K38SGcPY3AbMM/7mkiuMypBVMTKfaipYrBv?=
 =?us-ascii?Q?DHXIL/jR45xTSfu4uyG7fH2QvHrznY9KOrMevTC0rMVuJ5LFpK8DM9cIZtDf?=
 =?us-ascii?Q?mS5HyfeLIBeW9w4oULYz5mseOap0wIyef7Ai+PNykKTfrApgUDP4/7b72MnZ?=
 =?us-ascii?Q?7r1//tvxVDVTVLgPU3WDbk/UJcA8wQAJqktLVb1/4dOzn1KtRqIXCtjFaV6U?=
 =?us-ascii?Q?98QJA61cr1ee8ZqOHZWfwxV/TIndsafWr3T7XZhfZOXY7QqQNm0qwB/TtcKm?=
 =?us-ascii?Q?eBu5Mz+F5RZH1B+OznNKPudRD6gROwSIR6VQn+DLZCDqnV25bU16n2bs9gAk?=
 =?us-ascii?Q?J3aSUqU1HX9KL2B1Hk6E7+0D6MAeFZiN4dDRrbI0rqnEKk4Cx/AUcS+Q7RMx?=
 =?us-ascii?Q?VqU+NK/OGS+38gqGguPuDDgKPXqI13tVeoEwZXOTA7g3jk0QnR9qvWJIRjZw?=
 =?us-ascii?Q?tjHvtn9hpK8E0UjQEpp1GzSuamZPyXmorGO2hW/Yx1FS/zGwKE7if1oO2d4T?=
 =?us-ascii?Q?xq1Mb5/stm1jIjiUlyKUjGJGoWclZU9TIAKT94KEE8Z4GLmMF/ie8Foxb+Uv?=
 =?us-ascii?Q?eJYCwNRKilgtn0TK2d1a8vepvP3LG5nU8loghtXFftmNe/JFCm2dOaQZR0rB?=
 =?us-ascii?Q?jQHm24y5PN1LWJYPSMO9+hMQHLMPPngEIg2E17e6q/O4jZWBdpjl+RUWVxjC?=
 =?us-ascii?Q?ZlacilPtB4MWybN2Tu1EJkQao4sWzIJjY8FLiVMthk7L9RVaxXzFgyanNtl/?=
 =?us-ascii?Q?7yv7LXL8Ak4cDLz6Xq3072biYCFL/8d2nSR7mbU3vr/bLuQdToRRkwurN806?=
 =?us-ascii?Q?t5WyQuhOevi3jJLleJuNOtXikN1/riyHDC9Yd4ugYcd4XVcEYIHW7R6Jni2p?=
 =?us-ascii?Q?OIkIQzta0p4LmB9JSIp1u99KmyyBoteNtkhx/LS+lp4VCsbx/JFbof2MdB32?=
 =?us-ascii?Q?By9dggPXSmqXEQ3lFchkM/S7w+z0y6ejRahfR5RJLtysMbhIxgBk/QZUR+Pf?=
 =?us-ascii?Q?N5tZhNaMyJaWgIoQmepdCCjJFkya93nrSRmQ/MYXgnbIImp8KhF/NFAceT2z?=
 =?us-ascii?Q?1J4bXH1yc+Ile2uPhYOoCMGbZYz35hk+ZsI9WT69yzudpmSsg9eijjp15/7K?=
 =?us-ascii?Q?e/3dNsvVMG1UoPv2mBXK6dCVNkX6wkIdn0kiUrNF1HyNb+YDxZwVDXm0ekSR?=
 =?us-ascii?Q?9Gwt8QEK1mSKnRsnp+01CTjK7n2xgzU9orJF2g5sfYf6x2WVD2Sa1NStjPMH?=
 =?us-ascii?Q?QoCeMGqSJCluEte8exIDr1hoUBqyOpRYxkMsjM/ONRfKZhRUg+xGGsK7vLle?=
 =?us-ascii?Q?hjasJyL3yRmwKVt3KHWIcnGD70Zi0+QOoDpV18uSBVXIul3e5plY+wTx3Sdq?=
 =?us-ascii?Q?UW0YKWQIPXCFyqHnFPObnM30Pzvh4mV0u+OHaFEB8BgasyJLL5HEt+8DXNhJ?=
 =?us-ascii?Q?fz8AAt1PFroRm2BJ0Y/iIXPZ8mDco6VnNF2zwCgdCP4Geedfp1GnkTa7lwW2?=
 =?us-ascii?Q?slwXnZSq0VzbIAqp1EJY8aUCddbqJijLjIyV7lFDK0b94EHl3myuVvrSlBWa?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8cabce-d07c-4769-f768-08ddd4a272c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:53.5377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2w9UT9GCExTivtjFCsqh+pi0PKaiMy+h3qnoIAIx8VvQ5JDBUgabmxZuXx41dH0sNNgtqt7Jd7X6+IqC+VCp0dt79cGknZ+UA/qGDhfQWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Fix the I3C device with spike filter unable to detect issue by setting
tHIGH_INIT to 200ns for first broadcast address.
This is according to MIPI SPEC 1.1.1 for first broadcast address
which is already part of linux upstreamed patch.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
 include/dw-i3c.h                   |  1 +
 include/linux/i3c/master.h         |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8b3d5531a7f..6d3d2ab5e71 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -334,6 +334,14 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (!master->first_broadcast) {
+		lcnt = SCL_I3C_TIMING_LCNT(readl(master->regs + SCL_I3C_OD_TIMING));
+		scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | lcnt;
+		writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+		return 0;
+	}
+
 	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
@@ -351,6 +359,9 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	lcnt = max_t(u8,
 		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 
+	/* first broadcast thigh to 200ns, to disable spike filter */
+	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_INIT_OD_MIN_NS, core_period);
+
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
@@ -406,6 +417,9 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 thld_ctrl;
 	int ret;
 
+	/* first broadcast to disable spike filter */
+	master->first_broadcast = true;
+
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -485,6 +499,15 @@ static void dw_i3c_master_irq_handler(struct dw_i3c_master *master)
 	if (status & INTR_TRANSFER_ERR_STAT)
 		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (master->first_broadcast) {
+		master->first_broadcast = false;
+		int ret = dw_i3c_clk_cfg(master);
+
+		if (ret)
+			pr_err("Failed to set clk cfg\n");
+	}
+
 	spin_unlock(&master->xferqueue.lock);
 }
 
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 920f18bccb4..42c37d6dfa2 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -240,6 +240,7 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	u8 addrs[MAX_DEVS];
+	bool first_broadcast;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 213de4ca06a..04017f34822 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -278,6 +278,7 @@ struct i3c_device {
 #define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
 #define I3C_BUS_I2C_FM_SCL_RATE		400000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
+#define I3C_BUS_THIGH_INIT_OD_MIN_NS	200
 
 /**
  * enum i3c_bus_mode - I3C bus mode
-- 
2.35.3

