Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD74CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D31D84A97;
	Tue, 23 Jun 2026 08:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="IPey/WT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F59C849EF; Tue, 23 Jun 2026 04:09:02 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A62849E0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsTugrFdPBqLlbn7TAF3Hs0drTqts8zRv7afLTzllHhYMU8swk85OTF29dPxt5iU+2OriRDzijGab7a6VMPI/5hXsuIWnDqEvAYtDL43AiN2uLdX6XGkUS1QJz4QictXT8kqk8pmUqR2so7A8VYHaShYbNSRl+FioByqB6Y28JVBL/MBs9l8hAcDjC676a9ubkm22HsefG9bCPeLlu4jvUMs6kkp4/pUT9zaLgALc1jQ4LmGx9QDBPUZiFsPJL30JfCMSAV9x/yFM2oYODHtDB5e7Lbc6ywCoe5EiQLMwpj6vQ6CheLq5qoeu5cxswErX+aPlfnPfn90FhDDBUjZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZvViWZDSpTCYtqO3J1eUoVhXEtOgFnHzvbhZ8qPoYM=;
 b=QUSztmAC6AdbyS1JpbHl5i+Pk0lx+ckB5I1b8c9GxzgLLp4o5J1IjnUKl8hmTULMeK6Zg1AKqyuj9xCKasnaOD3WvYQkIZBuKHo7BSwrFeyssmby9B2V5g06y9U0VO5pwIDjDLJd7/03BkMX9SF3geSn51GvAkSMjBHsKt7pJrBK9iAkh61L51bPl0GLPjfs3qugPfiPyMYnrE5SOraj8RGibMAOABztBhvEpsQeSDKYiX659QSpl3F4tyU8QLdqgWaBzitFe197EahQWoAsG6fF/2aWdJW934Of1xydDxE0hhVKztUxryxJseyt1MrHvmXMFvpn5BBx2DX7KwiZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZvViWZDSpTCYtqO3J1eUoVhXEtOgFnHzvbhZ8qPoYM=;
 b=IPey/WT5/1qtGRl5TnwdSGEc6bvxDsi8Qw9Sxqi9s9aMkvKmTc3fV08gPVrcq/85DxOCfUh/24joBQ1tEROgfDcnp1NMCwxKebDD9ppaQsQKEEahLDKUJim/9bAkdoNC2xoJ/2NeXnLOZqeu5cAgRKALmp8k2kNd5lP/TUH07CWA1KRH3Tckrvmx8HRgDbQ+z3ZDISzd5KbIf5kHy5s1nW/3/nIjeyXyiNTaJ0LW4sWtMbj9mPPfDUToUvEws/0n4Juui6mEShRFvBwi17ZawFEv+NU+OQnywYSvXrmCSO51BeHdjlelzgXxNIETxB1YgGef6UanwBoOEAsWF3E0XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA6PR03MB8010.namprd03.prod.outlook.com (2603:10b6:806:437::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 02:08:56 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:08:56 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v2 1/2] drivers: clk: n5x: Fix incorrect EMAC clock source
 selection
Date: Tue, 23 Jun 2026 10:07:51 +0800
Message-ID: <43df95e9b78fa4cd1d2e6b35c34cd4dba1ea84f4.1782178282.git.chen.huei.lok@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6f458d1-3589-4d8d-05aa-08ded0cc616b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: kf9ovMkLNnILawD+LBNTAKqhess8FC0a4JIvW4Ag8CJTuvJWO5eAxNjVs7YfvRxASOCeH3ZguBFqFCqdeUq5hWSylx1lHh7CjOT4qKqsFQzXubfwIuCfCxrfZmwaHUjQx76nL1gF7i5XI53Ohy+FVJEaTBy+6F6qGlfwC1WkEWqu8cG3bntVdc2SfsbYXzvmb+Gnsav4/VLcyaWKl13FmSc4lOMlwD+qT7QHr/AmSrS/FAcx2EBVfaDSc6d+RdS5rZWDbuXxkFF9BfPgash6OSTlnGVIf92N2M2qjnRTQQOd5K8UzmvmDIbSfgCdE/vX0SiPH3Z/btKrfv3HMoGzWuYXeOjMfnlIrY/Q9EzhKMTqWpv719OGaafh7VDvaIwGZeTx/1P0xI3WnqMuYr4kcX90cP5T2Vzfnu98/+WnCFLu3jUcvKJOFDUN6nSHGqTWaNXvhcDuEUAJD10qEyrOx+x5n7JBedqsxH1k7p/TzcHxYiQIAn8ivHdDDntxW0sd0ZkfzijLP2MHvmDY9wVjPBqr1Hav5y2i/VE9H/I0SmDYNk1FlIbuYmrppGLJ5//e/zor3O32c6SvPzVr6d01HmxrW1D4mTvxAstKGYE0oBE8PLshDl0ntQYoNasXcBeXZz+v2H20aw8L5FhVunItYfLFltExXBBTDiPyftrXCX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jm1uR1m4pVc29LqFGiDOHLjPmY6kexiQ3TCivM8fQ44PvtKTALYsFCrZ8eok?=
 =?us-ascii?Q?7/NDs2fN7agDJaRY9vDYOWfsJmcURoQ7PDIWjJONGHZ6qh50kiywbpWX2Tu4?=
 =?us-ascii?Q?BwwJgdbO0X01g3gda0ZHSDnOrkDcBicaWdwAQ9H28xxNub5hJgUfB91RwVxo?=
 =?us-ascii?Q?QEMl/vkUkQR+OfHG0DpdR0poxS1jau1D/c6gBKHEujT1J0VbjvekrG0yHXnB?=
 =?us-ascii?Q?EsFCHZkb/PjUXYqQPuvtChfXeNrynhJOgL5SDRsrZn53YRWwmh8rnzy+3elg?=
 =?us-ascii?Q?LQulJbPNkUZFWOvjNAz40ya6mgeDBx+pHWXnCuG4VjCZ09RWapU6NkXKIll6?=
 =?us-ascii?Q?kIpGZ/n/bJS2GX3ChBonDaJF8fIFAhVZfGYuy1q4maAa5tD5xZpS254vaBT0?=
 =?us-ascii?Q?dJRvylPDR9amr7CrhhP8QBd/86hzdXov86rVUN/Pj41+WPr3VMVcFQU5Aqow?=
 =?us-ascii?Q?KCb1n4S7aMWgM95KASjKpEAsawbffWiLOPW0jGhpVEU9cDVUDYvr/zrWbYGO?=
 =?us-ascii?Q?Wn9JwT2TQgzh8SYCPOYOFpNwi/yfnE4kpU0qSHP794q1KbZEkr0b98MC7tD9?=
 =?us-ascii?Q?bMRheQNdYY+Cqn4ikO2bixfcYPltCUWAm1PhDVapsU9Hbc7rcLqFWBo8+BPF?=
 =?us-ascii?Q?XObww1+SZL4p0evovJP7TE2OyIIF4/h5oF4+plStR10hZAoINT1WSyyi7/k2?=
 =?us-ascii?Q?2D/1e42U1Hs9Bj2ZhesO4dvL1z/ZiYdis3/TMFHVI1zjcgBPYLNsmQ7pGO4t?=
 =?us-ascii?Q?bC5tmvxaCFq/52Jd2b/fBrb0o8D96H5xo2eba2Wx4xQTdCH0wq6KeQpF+PPC?=
 =?us-ascii?Q?cfs3QFErFplhN+g7IMYhEyfexwOFmsHKvxITo3FzSRYuIuQa3dfLv93lImFA?=
 =?us-ascii?Q?MuqC/ifSz/18txVW8zaQgzD+3CWI+LddQN/kZ3vY2Ifk1gh40BPiEnZ2+V1W?=
 =?us-ascii?Q?UdiLhO5i1f/YaYfzFzFRlKSKNG0NLJ5rpSnJP1otjtKVHT5TGJ+CQIUh7xnv?=
 =?us-ascii?Q?rpu7YI7gxWDezYikV/J5fSeWF8NX41rL5MKbFWE+IunGnA9SJBI9CV14M31d?=
 =?us-ascii?Q?MuC5xVjQp+gxoegC94OU2Xn6QazUFcYqGB1CbkCFUcA5kXEoN5lX0Gfg2puW?=
 =?us-ascii?Q?aofdK7/3VyXDfZPI4/rkhBUNZ/M1QD19y34hOPFdSiKbK5/6uNjRwzgyDJkM?=
 =?us-ascii?Q?9hy8A9bBT8ffCI2blA9rWRhXpId+cbFUfY5AyMCwYahc/t1SDLHIWwqMZGks?=
 =?us-ascii?Q?6HEmh9TGyvxfMOcFQ+z8OJax4CyTfet1CS4TmHPbx0OTjQJ5MSzOH9Z6kSaU?=
 =?us-ascii?Q?PzTUAvER1L80nUeL8ByVaPizWa/Vc1x79f9qGXhJoAwhYbHqVABZ8fpCWDG0?=
 =?us-ascii?Q?Y0oH4RiqxIRZ5U4AgGcXVtfdCvFbE5SvzkrTKhg9pXgeiwxPHGNx2v1XMe+Z?=
 =?us-ascii?Q?ulnneJBHg/qd3EaSwP8USzPvvPM/X4HM76Xh21+4gF8EKaldf/rq+28IIbf4?=
 =?us-ascii?Q?xtNk8TkAgGwzfSUy21ldh1MJqna9wwPMNYtHcgN1AiRqRkzHsXN/MurzfMlJ?=
 =?us-ascii?Q?8D1DkNP7CsAyPB58W+oLpmMnVzuIuBA/4VDCHvr5/wDKT/PBLdrP2xJE3f6t?=
 =?us-ascii?Q?qTry+rrOIqBDVP1AJgZs+pAhIfM/EhEm0CEgTgxk24P0YQ2VOUTT5ByEMP56?=
 =?us-ascii?Q?Gdy6dyc+99WKUprANdZX9GFjM71oslerBwc5yHT8GayGVd98LKhzjCTfFhPY?=
 =?us-ascii?Q?iclcif/7Kyy0sP2d7dolLGnnZylbBAA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f458d1-3589-4d8d-05aa-08ded0cc616b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:08:56.2922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqqbTqyCbkL19Ht9qOT8jfv4QkjzlcZocv5+JqyclmzXI3jFAVZbNpRwJDRCUy4z4GSZhxKQrIU3atjnZi3i5T6Q3rpGZQMMjOezQzoByN0=
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

Fix the incorrect bit masking and bit shift that caused EMAC to always
get the clock source from emaca_free_clk. The mask must be applied
before shifting, not after.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v2:
- No functional change; resent as patch 1/2 of the series.

 drivers/clk/altera/clk-n5x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 185c9028a78..e0ddaa8e944 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -325,14 +325,14 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 	/* Get EMAC clock source */
 	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
 	if (emac_id == N5X_EMAC0_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
 	else if (emac_id == N5X_EMAC1_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
 	else if (emac_id == N5X_EMAC2_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
 	else
 		return 0;
 
-- 
2.43.7

