Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0810FA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD3C084227;
	Wed, 15 Apr 2026 06:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nyiwuhJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDFFA83E36; Wed, 15 Apr 2026 05:18:19 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF40080086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXR020vMiL+YTC7oa6kl4/+kJtH5HGx1NhB/JMFX8JTeZDH4K+WlbzXxarbWzjUoywe1cMhsO7SkKElzRMeMUw/HIFz774dO7bneU5Y8YI+vws3f626kNtUae/oGvCB8dVf4j3QNHnw/pKR4Zgd5zwUxT/Qitx8wvfMVnQqga/ecvnxZwMdret19ub0q08Mjaxggl81ZBcviJU1RAnyb9RwxXy+jkax7GSM0VY02JYU17weYD9DeVo3kaEcJQ14dq7WZ2+jvVYLeVo9qmevxMJxuouPjjxf9ZXnS9P7q8UNQLu9/BKe5rSDvpkeYN1ZLMsXRxUigiJ9PpMH/7qqaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8yBE3XhvZxdNE5l4LBdE/7n5Xs6XYqbQqrbwkgmH0w=;
 b=hWZFUkaGEWnIZchzJYfUHZ0G/1nX4RqGSRkyD5MD6iiT9Z5Va3l2Gq/0ZRIZQi9xRWV8uFLAuLDLSwzRPAK2Fq/CqfOdpeJLY5OnV33uFIKDUaVJIj4Bi4dmEleIcRJkRvYqxdi0h+uYYEbjr4U3nheKbriT0cb7j2aTbNGd45UiwvUOl5HdFOqPWrkrbKI/YAONANOYfl6Zzajk+HEUTGYVEF1WFcXlwgq8e4hNnat4E2P6t/JV7Ec00Xp/niuwS2DCLtGn906IRB2RjayETvFpRVnFudxYJouuUwRYBwZaLgcxG1NC0PsBjReIsb1DBCynOqeaxfbSfti/m5959A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8yBE3XhvZxdNE5l4LBdE/7n5Xs6XYqbQqrbwkgmH0w=;
 b=nyiwuhJOT6Ia41bepQclEpqgRIQgj2wCfNiOqbro7o0/Qi/L7ClH1ro0R7PrULrrkKC50wmb4x45NqEzd4+Mw+aEKIkEPZ3HZi1qR6X+CTWuh8LM+RNIUJ0i6DLbQ7e5UhynpaO0nmATOrh8ZOsz4B9Z3hFT7vjALhSphrKdKyyAdyvKEkuH8t+5q1l4f7yhtXF2NOGkRy7Qn8qhhZ7z/9uDu1jyh/SHFXin9J/hbRneVjHlBpWlSOBOLLGdrWCzHBCIlebhX+Io69neseY4cWFwXBvRUbzP8WuaE0TLP/txtv4xz59Wb36nsLboGt9gTp3+LWErjo0UmBWRLgUK+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB6872.namprd03.prod.outlook.com (2603:10b6:510:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:18:13 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:18:13 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tze Yee Ng <tze.yee.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH 0/2] arm: dts: socfpga: agilex5: Improve MMC/SD device tree
 organization
Date: Tue, 14 Apr 2026 20:18:09 -0700
Message-ID: <cover.1775640837.git.tzeyee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 51141b66-09aa-4968-2bb1-08de9a9da11a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: 6wC6e3w9OD2Ee0dfWCPqAWPY8kJeF+puCN29aZaYzFrOI510kcN4+uJZ6R/40WMqG9ihWFVAfo47IgXf1xjyZPeCGMtuu9RekDzAjI/BEhEFYR6Cy6KPelOVB4n2NXqCUDbkxUPfbNNGKIdGBt51HX29Uw9LA/G8le9HGOxZviV+0ZcDDs9TFpDU6BTtoU0b8aZMN3qFugfzXDQax6uGzNyxgnTwRLH1DPl+4cwFYMEGIgMM3llYW0UY1y+BQdG6FLf42/w1Hf1od3WMiEtECv/b6D1mo4lkoXEtLC6CST3K206JlNH0z+Xn5iO8AsMDJ6lszwG8ORiPAC1Rh04Hfbyy1EpzMP4DUmgypDuN5uFhZiP35qmXsyE+PRoqbY7ffogK57b95kBC7cbmseul2Gi9yRUe17P+HfYNXGfVVdtlWzBh13e3MDvHF820mpcvuqyH+ZvisiH1jx4GFKrjtm6lMUcNMawwpyZUFulRTvBUtNJWCkCT6/OuhBqFapU1G/9wc122S6E1PsfYNW85x6m6z8Xz9ojt3U9ztRchrWpI/I4NWSfQ0r4f7YLnsFpmXtvc7JQ6eOCCS+Fc4PH+bVICmhJhCRqbGPsuIOJSW6fVksPNpbaoSLEjfAAwzCEcEbiu5NZqYR0J3ZXXd5EvwVDUa8fGUKHwNEO5KSN5reqDQ6GBhq/o2xuCpRykZ4+MjyUUOVjl678fXPT1NtbPAUmyMy+GbguP43DPmG5rSZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aKcyW2CZ2GZjEjWJtMjM7skdLkwQez9tcZbs6V0YqA3zJxjYa3mBqAU088K8?=
 =?us-ascii?Q?6SzHZAogCRl1kQIjLBqdkENHIqLXNmFJOS3eWWrHGoFT184dBvxRHvMeytfw?=
 =?us-ascii?Q?XAxwYS7pBuzZcapRw1NaNZucNyYQfCMyzg/SCgGx1ihjIjZPoth6+B3mLOlA?=
 =?us-ascii?Q?6cCE23NP2W6YIL7Hkvm0sp8/nKZAzWQwLibpypLvf3mXZ6hxM4QRC3oi3QAe?=
 =?us-ascii?Q?+HOJ3Hbkg4UGgSpe73ANRklrqQEuYfiV3HYAdr8GWLYcUoJ01iaWgmCj2gGK?=
 =?us-ascii?Q?Cd0sa2un5yeTP/vyjE6N4VAru0kpgQ8x3vH4skPDBOVw47bWzKibSloCTGiE?=
 =?us-ascii?Q?4DSKFhL4rCY8arlB1CuwnXt05A+ZujRD8lI1zq4PsJbemj2ckq4l3beySA0m?=
 =?us-ascii?Q?t/9gmNUzTWq5lqKj78rvL/P7niS4iRMh4oAanenmj8FLXRVV4VIii8nZ/9LK?=
 =?us-ascii?Q?lMT07rL85skJan5gvHkofoJIO4CuxRRjS7J/BN1r9ifat1sj/zBiWbjlnufc?=
 =?us-ascii?Q?ynCpMHxRxD7RarnSMx9O2h4CuN2sfOkDgpC2XbVIPUgWQaqAUKY1Ru4dXVdA?=
 =?us-ascii?Q?4CHtPhsO3LapRFGF/Pl52RwZkbmCwWZ+fb7AnlZpIA1u8Fe/fsl63XyOrCoP?=
 =?us-ascii?Q?BcYCZ3Ft13sI8IdsJmkSBVt74+pv47eB62X+NpG9M1kRbbkKmuACnAjQknyz?=
 =?us-ascii?Q?vW/gAGCAnYjVIP59F34C6HyQK/rNXETztpIxl6BOEo2qL05s7cfumPS4JN7Q?=
 =?us-ascii?Q?6LGRGQyjD5tZufcI8cIsKY/ApR6Cu/8O9iDgaNn1FQc9fGGaHWw31/GKCYuh?=
 =?us-ascii?Q?8BIvL4O3MS35Njt0ao0aPNUi9yRYPObk+0rfgMu97oYvqfBVZEXABDdljNQU?=
 =?us-ascii?Q?IBDrzLqhquulSQ8ZvXwF2MYYjlK+R1oKjK8s39HByOwzVjwvm1U+ujgFsBSP?=
 =?us-ascii?Q?P5dIYYdZ7o1ed6VQ4G2MaG0IrGWTRwT1tmF4b3oz/kQo2h9NqHcRfkbagnE1?=
 =?us-ascii?Q?SspsTZPRH9I+tlZlUoeJjbK+tY9tRJEYsymtsa63WJyjaMdjbrYr8I34Bs0e?=
 =?us-ascii?Q?qUE8PfXb+6Fsz4nlfvI7FXhWVZo3pjWBlFUoUnY8+ak1heNeMnXVh0nbwDyu?=
 =?us-ascii?Q?O/83x5dEi63JPk1b/k1pg6Cs8FFbtWpnqozIachNhu32gLpRLcMNRSrMsJ5w?=
 =?us-ascii?Q?lU3W6kvrJ1EhI74zEDU0yRQ2l2y0TpEO9AnXKtmQ+dDRlPnieGJi6tJbLRVz?=
 =?us-ascii?Q?Fo9qYmdqtXz6CMvtaOKycpbT3dJ0dN8oB/QA2jJqVbPsLG2KngGKCSxSl1br?=
 =?us-ascii?Q?lKc6GmyCl4N2qRqwAjgl5NOljHHTHtqz94jaSvKErznuCX0E1WpEIlVvhKE/?=
 =?us-ascii?Q?yzsJjR15BPDQO6ulKPlCeVeGDRNCJTklYGrCfzDv0qVqqbkPeK9giB/cJ9W5?=
 =?us-ascii?Q?QKb9/Zyu5NlG1EvLJ8C7+LrlGOWTO2F2n+NFqQ2E/hCOgwNQtMPeE+4lm9OW?=
 =?us-ascii?Q?4e/OWyl+UbRgPohlKKEF5PnNkZuz7eKPD6SucloBYvgTI/E53NKiqeLrMiBn?=
 =?us-ascii?Q?0sRgwP9lE+TKXPuPTX9K4WdHPDGrQr7jN076QjSqu9oZEWrBEzBpKABYgz5b?=
 =?us-ascii?Q?6N/obb4qCdLs6Fkv78gSHndUhq1HHZQeHtaImF77NdZ/fc5zSbP4Qu5wBOmk?=
 =?us-ascii?Q?vQqIKUhRuI/46bI0lOpgGk+qiYJG+eW9fFqrg4fzIqhkQkh80Gg716/qEsgN?=
 =?us-ascii?Q?6zrW/auFXQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51141b66-09aa-4968-2bb1-08de9a9da11a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:18:13.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlvNAc5vLEqpy5z8kc0Yfry5p8xnylHICJ4Bc5LMqzRttUHj72Z5LHQmPaRcK5AETCcREquHvjKTPAAri3aywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6872
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:44 +0200
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
Message-ID: <20260415031809.HcH4ZUuNMPAA7k7NSZ6xILf4JAyyrVfDs7vBz1dpMBo@z>

From: tzeyeeng <tzeyee.ng@altera.com>

This patch series refactors the MMC/SD device tree configuration for
Agilex5 SOCDK to improve maintainability and correctness.

The first patch reorganizes the configuration by moving board-specific
MMC properties from the common u-boot.dtsi to the board-specific dts
file, keeping only truly common configurations in the shared dtsi.

The second patch addresses a configuration issue where the eMMC device
tree was incorrectly inheriting SD card-specific properties. It removes
the SD UHS speed mode properties (sd-uhs-sdr50, sd-uhs-sdr104) that are
not applicable to eMMC and properly configures the capabilities mask to
enable 8-bit embedded device support.

tzeyeeng (2):
  arm: dts: socfpga: agilex5: Move mmc node differs from base board dtsi
    to dts
  arm: dts: socfpga: Remove SD card properties from Agilex5 eMMC device
    tree

 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 1 -
 arch/arm/dts/socfpga_agilex5_socdk.dts         | 6 ++++++
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts    | 4 +++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.43.7

