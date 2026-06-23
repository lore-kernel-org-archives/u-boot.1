Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A12CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8438C84A6D;
	Tue, 23 Jun 2026 08:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oOl0TLEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A3A849EF; Tue, 23 Jun 2026 04:09:06 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5A5849E0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjkAVRSSivqKWzuO5f/ch20PqQwSkaZXPtliQgRehNUAVoFDaLuwxIbyeoEv5yH0yeE+50fJOpqcPuNmQgPbdZ9BV1OooE+Xyz3sjR6ogiKEU3Awl437LaQUmJzPNMA7cTTaqhooVs4JiTmiUaaCAPkX82+gFfw4czxzXXE9cJ/EisI+0Nlph+zDal7zF3R33Kgh5PwTuU8QJxo5+ob7fSf21BOEjN8h6CXWoLlYPPKgkDD2Hvmt6SJHT/myHDvH4acqKYUXhh86K8vvbUbFS1NtVn3XRF+1KMs5DZry8JCF5z8W5SjiCYJS18E/g489ZZC7U8Vv1QAoeJ2a6tqrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3Rm6wd5mrRhn50D73Fj8FNV97GXW2MFxL8iM4MVo9s=;
 b=oV61q/m1q6hRtoeVHgr3FT9PknYTbdWueYcaJT6pvezISS2g7d+LYG9tKaic73NT1wDaJygsYvZuIguSWElhvf2R1hkGLy7cIHKg8Jd71BCZrw7zhrLNOhNXkP0qkxm5yEJN+GhtMFwpgzCDRu4H8xI0wXeZWrUh45H4wBNwUEU6GbUj4yuPxpDG7NuPXm5NdY/ewk9S4PTD6GXG++5C0YWuxawbSvF2YGLC1NkwqBUwwdojIuKRPJXHyyWD5EwpSBigQEbh/CHHBhOh/Hu4JYLHddgo/JDpVZzlEoJN3qWlUjMl/32wnRx+9ohl1znItT6E9+0ePUDqRVkGfkcNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3Rm6wd5mrRhn50D73Fj8FNV97GXW2MFxL8iM4MVo9s=;
 b=oOl0TLEes0I7fFdVE9K8C3xHU2wMKT7ahx6/v0dtSTf8ZgrMdUj2NwBEVYNqd+OX+bLoBW3OE/sWYvkbXNY7OgbYCqXMSGGxCLzaSykn4+jHPA7RCkc1LNABalxcvkjNceOAaa5qpqNpt0LsVEXBoP4qo4GmAVo49fiWBeC3LoS8BhwYeoi087/OxlxHiDazOVXkpDWXbLSXLKmt6I1PAvGrEEtewEQMmAT905gOBNdzXkK1JFQ3rqjOt+DaFO4U+E2sCBPDLRKTkbJc068Pl9imkwS+rp5OQ0GxyDnoKAfLn3UOKu0+0KOzLVOgDkk4lpoCNn/C5w4Bm3Vn25kAcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA6PR03MB8010.namprd03.prod.outlook.com (2603:10b6:806:437::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 02:09:00 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:09:00 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v2 2/2] drivers: clk: n5x: Use FIELD_GET for EMAC clock source
 selection
Date: Tue, 23 Jun 2026 10:07:52 +0800
Message-ID: <eb0dd457ba2b8d8747de660995bbfc37204a7d56.1782178282.git.chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1782178282.git.chen.huei.lok@altera.com>
References: <cover.1782178282.git.chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA6PR03MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 889f200c-b39e-49eb-4cab-08ded0cc6392
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3ebg3R/jizvJyoZMWMXiYY12slMb9cOaCj7xBnStD7xw58EOzmzd8nuoQc7UZpX5t4DGt/sNetM9x5mVEu/70IGKigHphEJAnYYwlt8MzGMWN4kuaX3o2jqj1s9LfaIJ1eZMvqbTc4upy55NkLXm/RP1kQC97yEHO619ignDvQN2G9WkUcNBF8vdd426vdX4MxozvyO2zHtpLcLbog/md5CoBg85d1F9+mCmRKo5KxIV9tvDzCJbxGciSMbdPBpFIomVyO4C+VqsR+j6M6R0z+83YpSf7O5Uk03loPzLeVy5r2hgdnm6Mz0ZEmzAerXdI+TbnWsmJHrO8FK+eq7EHqaegvyvoYigjprqZ5dAHLOI9l+rnRirPWyZfWTuDWwJFsXiolh82vBd8dX6tA59aNTCchpGA0lPqYQKAcbWxNSNj1HQ9vna71TJ0yglspP7JzVTWdmESlw8hFBHpLqggasZ5aA+7p1Ro6jndXK0Ik6HjcoxLUKOu/J4jRYrO7RxAWRrEAFp77zisB+1Smt8jyXXRk8v34y4gdT7hAozsqw2YlSnmHs+k90zztt7xCplcUUehqq3cKxsGVOxIwyLsmJ9gNSjy40yK6zKCw3J7hiEEDwGXQ3vvDInJg7ibuIWg0GTWnzZKUpiHv2MXYyOa+R3K7NF2XD39PPh9bvY/jY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ieD8Ovvi0f6GKYZgG1h7nZYuGE2oz2kK80ypCiP7gDFFVAjGnHL9J/VVQhzq?=
 =?us-ascii?Q?f2L1zdaLmS5WxWq+FOB3Zrdstt4MA1emJrKWEmXt5AQ1sMm6/LBp8cJTj5uv?=
 =?us-ascii?Q?uvJQBP2YwgdOoHgaDi1P8CaEQMHzL9oqDUTgX/51CNBPb1n47jLhhLzDkWns?=
 =?us-ascii?Q?CW0hqqiznprzibCGYywAGKfUpaBC5NcgjVNCiWATSpi0HRuMMXxQwdZwqSEA?=
 =?us-ascii?Q?sV0wFL4B4NP1/6mxdb+N3UrvI9fX0MBDWKFV86RmbNoqrbO11ZvAItewOSp1?=
 =?us-ascii?Q?BifGOHkbOYpkm7SdFD2k9fgkpEEvRPto2AJjMC+TAnNHyjtFF3Sb+htogHLW?=
 =?us-ascii?Q?F5nJtMRR4Sq4eiJuv9QE+q6g10aH+KmB8C9Fgkp3kqncadMp6BF6HnZodR//?=
 =?us-ascii?Q?6lk2cymfmznFZcoKGxStVCeh/XMEoSAksPOFRFozxCbEEnk6QMjFma9UJyei?=
 =?us-ascii?Q?Yf5ipiXiSY7svjE/e6PY31ZzWceh7LUtLzsmy3oNtS1ZGR/ATWtL7O49go4n?=
 =?us-ascii?Q?er8h4/+usMNeypxB0ZqZXM6pcCxE84sJt8/Llqego1nFE6r3pJDEh/HED3AY?=
 =?us-ascii?Q?6EhbVc2McTBrDRSskFe0E0PluwSLgOOgvIc1eIQOH+NQRPxwwvLYfd/6/8K+?=
 =?us-ascii?Q?njONZiZ+Cp1AOc1zkN5zIj3VUo2YVAPE6uAqze6cIoqC/qMtTzGErqDECxcX?=
 =?us-ascii?Q?bLMutBoiZMzSEwILBLxvVIjzyiSB54D9NOcKLDfM3XOg2Eoyhk4rwLjDb3bp?=
 =?us-ascii?Q?M0WzRiHABsGj0w+H6S0jGGbrqXNruWRN3sWqzKw9SzVVyr3A8d67CjmUhiMy?=
 =?us-ascii?Q?VPIa2poL66hUTp/HnOeJkZ68i7aKS5QwNxigZ04LNTQ16/OUhVEXNfg0E0Dz?=
 =?us-ascii?Q?BE/p7HpAjI0L0T/uaqOB6Clsi+jfL3KxYPaFWPZB3nsHJip0dctZgHK3+lKG?=
 =?us-ascii?Q?L9qFKnyMyTmEjSvsoI0PZr84YmFobjWWEmASLdJqxFY5AzexgsbnvtX2iyx+?=
 =?us-ascii?Q?F3Mim1EP5zzpsk0odCyIqcDBCoOoTm6ZS2Efa50//JvX6RI4E1UfRKpLnAjq?=
 =?us-ascii?Q?cgxdbQ94YTlKmeB0r1oOioXbyWlX5wBYIpqx99OVaMHtVdKhmGoxEBgfz37G?=
 =?us-ascii?Q?l9Fluzi7PrYiw90hgFusE8j+bkWem1kDdfrLoazftzSwUPdqro8YiVWShsWw?=
 =?us-ascii?Q?OppVLOOG4CFTTlkt16PV/OUkCWIhrCWvisuMPOBfhgPBaoPOD9Wd+VA8sD/7?=
 =?us-ascii?Q?dc7sPQACCEyMzw2eBN2Nha5HtGaoiWbxbvHPxxWi3oIDb3NjilROOwaPCfGc?=
 =?us-ascii?Q?Gk6zXxX1L/2YFcqIDdDlH3cm/e3c5vAAO5X/HGFiu6my3NCixLmem4up2uYZ?=
 =?us-ascii?Q?r6k/R01Xocmc03HhkLsFkpEc9qvLZFKl/peWNVGi6agsrPfG+kgWuJMzCFmC?=
 =?us-ascii?Q?r0YP+tUhOOcJZ9wbHZyc1nlz+tBp9G1gM3AmwgsfzqJjYq2d12VhCiCiaTz0?=
 =?us-ascii?Q?RG8r2s+NV7zVP1NT9hmShCFuQ0DP2y0pYqGJGlzWJU3vw3Wq7/A55Q+JPKBW?=
 =?us-ascii?Q?SJI5QhgF1UuikiSF3Yw9yGYLocBH3gvGaq9TBwFlRfoJs+X19A/Y40hqGKO+?=
 =?us-ascii?Q?QtX2K/35IxNm5wNSjUFW9z0bZKFJJ+H3iwoTPBGm3DG5MZRHAWUjjlh/MPFA?=
 =?us-ascii?Q?L544mdzc3bSdjJM0L0X6uKfSppMHKkeeV+vl64BiPN0LrEHzBZsgln2zSLKF?=
 =?us-ascii?Q?M7irSweLBvlxaAr+Z+cAUCtJf/wNtPA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889f200c-b39e-49eb-4cab-08ded0cc6392
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:08:59.9931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NBWilZO2Mw5qkmLJdq/B1KBygStqz5pzpynobQd7QzA3yri7to6Rh2Yv6SWKW8f4hAkY3Kp9QfcSqf40aFd88UtnK3Ef120xpA3aWmSS/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8010
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Replace the open-coded mask-and-shift with FIELD_GET() to extract the
EMAC clock source select bit. This is purely a readability change and
aligns the N5X clock driver with the Agilex clock driver, which already
uses FIELD_GET() for the same register field.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v2:
- New patch: use FIELD_GET() for the EMAC clock source select field, for
  consistency with the Agilex clock driver (Tien Fong's v1 review nit).

 drivers/clk/altera/clk-n5x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index e0ddaa8e944..d75c77d5a38 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -10,6 +10,7 @@
 #include <dm/lists.h>
 #include <dm/util.h>
 #include <dt-bindings/clock/n5x-clock.h>
+#include <linux/bitfield.h>
 
 struct socfpga_clk_plat {
 	void __iomem *regs;
@@ -325,14 +326,11 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 	/* Get EMAC clock source */
 	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
 	if (emac_id == N5X_EMAC0_CLK)
-		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);
 	else if (emac_id == N5X_EMAC1_CLK)
-		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK, ctl);
 	else if (emac_id == N5X_EMAC2_CLK)
-		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK, ctl);
 	else
 		return 0;
 
-- 
2.43.7

