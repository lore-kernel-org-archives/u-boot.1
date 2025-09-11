Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E89CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A882F8329C;
	Thu, 11 Sep 2025 07:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oyrG3BeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253818319C; Thu, 11 Sep 2025 07:21:22 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD5E8323A
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpbxhgzjO9tUOCYA3glEjk7tfZ735X81N5ZgxNafX7BNrvfpLVxGo3cXF+5iatV6ML8Zj6/0RwGcdxnriA3vMAo5u+vhZgkfwlv8LlgRVViCN5rJ8yJ4YnIK0y1uaLaAhrXLYsqIc1MpCM47MBiZKHESAOUdHlEVTg4+FC2Yk4KapvVrI5RT0qMyYD2UGr//Abxw09JsSHJbp+bcyJKWG4qGGYcRICvRRbTN2XUSQhR23MOa+ryhjKbm8Z0mwfS3v0BjSTQJ/TWWbqW/AkvH7h2PcLxNwhXp4nTBufg/jvHWu0rqN/kc/DHBblTUnztl7E/TzrE8lAOHU3d8svqfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF+sUPpMA55zQ23hPeDpPnaLDSYGm1PcACVXddYWdsw=;
 b=RBSc0JKPO4BVsqrhXuY4PnEJ2W24vNzPI4IZBxVaRLAJoTJtK0VonanrbP1wLsBOxT26iBqGT78BwfCgpfHSwG7Oa3oPS1eYdAbV7YVTgftXlBN9/YQWtTQhNpyaK9ka0mhGUz8q5Db5en+3nVDMx5yJi1E0/xj6/W6LdZaJXHll6La54Fwxz8k2a6xw2HDTLLDU/6KVUIu/uTFNGcoMBaJx5BnQpboPi+bTHdkX5c7KN6vLEdVEDivACb9Y2R/paLQGY5m50EMoSgU7KESjiBEFYMcpOvttXfrQ9gYLtklvEs6fVUiWoSVEwrswcDQ2gHtt/AbNkeMc87y9uMAstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF+sUPpMA55zQ23hPeDpPnaLDSYGm1PcACVXddYWdsw=;
 b=oyrG3BePnIZ2t8r8AWrXgSy1lDyiizoq4ZjJlAVroSE3wFfz3SSkvSPV5sjDtkxVrug0xR6u5uuORb0/SfgWGXYasV7wdDGInnr/3oT+Wq/HK/KDtGbIer0bL11/ct9v3pF3bAwMYAAc2MkZslj3jN9Lv67xid6JGrB8NLl1hLJhnNuKGaiaA+MVrROhWCdUMp/z5azCH986z9EiKo1enD/gkvT4eLl3W756oXGh2D5K+vxI2iEkLx6vuH9C+7wzWD1WwVXOayFcDzblvG2yocoSpSiEzHd+wA0vR6Qv4oWYO5xnRicKQCse7hgufSAebsryofWoUDxYloZDEmNAFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:21:17 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:21:17 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 1/2] drivers: clk: agilex: Fix EMAC clock source selection
Date: Wed, 10 Sep 2025 22:21:11 -0700
Message-Id: <20250911052112.15383-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250911052112.15383-1-nareshkumar.ravulapalli@altera.com>
References: <20250911052112.15383-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: fee87bc9-fd0f-4a15-5cd1-08ddf0f308c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ffcr4jKjlIz84WCOo/6SrizWxzqEL0Ku5w0sjilRvePWGgUca3t25Bk0ZS7B?=
 =?us-ascii?Q?wky8/MYfsdfaVu4kUAY121f2HgFKrLvzQvJK9L7WXv8GszV+giKfNiK8F7LO?=
 =?us-ascii?Q?5p2johraPLZjYBgKpYzEIld7T9B3ChuZw1rGbTRvfFKABdn1tJEVOtDD74RC?=
 =?us-ascii?Q?QZVBzx6H9vACDYUd5nqnUbR8GplKaBkrxhOSJj9c2nfDSie+RB0oSNf0VwCZ?=
 =?us-ascii?Q?ge52ZhTpl2RKq9Xn2gz+LO6LEmx2FpvSn4f3RZudBU9/CyOBMCrY58qarj9e?=
 =?us-ascii?Q?033sAF/34xFBZ42BBQzkMzHUwPALbVL3q9tiJO3eUT8eHCiJmuu1bFO/rbzT?=
 =?us-ascii?Q?Y08yFBrcQTvWogV1LFBlj6FPv91xUPC854iIMpepTBHz216wRoGasFAtGvK/?=
 =?us-ascii?Q?2jQUf8iy+AgYLiXvQmZX8kiR9x41QQX/NNZ7M0gVkL4b2r1UoFd0dhQp8rxI?=
 =?us-ascii?Q?Ncgky+/aoxJmfa7Z35GIMpWS2rverTvxmM5OCBEOocFO3G+1kuIyPmGx8kxp?=
 =?us-ascii?Q?7DETP805pbgOpdW53oWCkWnPw2WSZuPkOQLgHgWcbBA4a3sbunrYLCUQjBU8?=
 =?us-ascii?Q?aCsZPmPu4xc2/CTDkfSPDgNePwBtIIfwquHAK3jLwT7/I5pjHb38ta8KxqUV?=
 =?us-ascii?Q?mgSS4FXt/VcDvLDXAzfqDEdSg7urN1zsm/tIWrvYqmGhzwX7259Dv0VtBcTM?=
 =?us-ascii?Q?KXJk4c8XC1CwXxIy9CUyBuxCT7/1mWDvfg714RllkEgmYY2edNHy9b11joug?=
 =?us-ascii?Q?gg/6nVnH5+XB58hExghMC+eqDflZHKU82XT3WZQ8Tt5zgEmhJBD7rHD3nfDe?=
 =?us-ascii?Q?ZJGAfFs5EsL+si3P0LjA/3ElzBDxsGLdoigJPLF00nDtPxSyZVE8hB0iilYV?=
 =?us-ascii?Q?sFzxCznr/X+PCjMr1hgzGvTqj0fgBZFIo8r/IK3RfHCjmUPEmaei/qeahqVF?=
 =?us-ascii?Q?h+XI5VuS8n1P7IeSIHCNBY5iX7OOOfQ2HpMm+uOLKo2Fx/IGs1xSgu9dIE31?=
 =?us-ascii?Q?rqN5g0Iq1L1i1A4Zq/HmDvfkv3wPz2pINww++ajGra6YIB2S/mTJgiv2OpMX?=
 =?us-ascii?Q?W9Y1P6nIrs2FLq0SHBfYvgjBtHnrY0A/A7NYc1IMgvNsNt0y0Ai7mUB4HkYD?=
 =?us-ascii?Q?0cwk1PlvwD1K76YSFP6t6YGV5EiiL7x4Cru18unJXZt9xs5zTbUR7m8/p8//?=
 =?us-ascii?Q?PiPI9JIWWfZ7w2maYgtnSjh7kxpT3QjfuQtrDT8uk2iPWpXWwKPuzbs9qqwp?=
 =?us-ascii?Q?/WVrFlI6i7M/xWfkZYS0VVro/+p0r4dgW4as9Fc0ZOpIUuSjaUsQXRYHRsiK?=
 =?us-ascii?Q?/73bFvjWtS/fvdmRYwDCweiioFngHLDpjJQ4gyR8ToE42dtl70AI+yvsUNX7?=
 =?us-ascii?Q?LWJdRkU2a3Ee7VpH/Stcdf2m/e0eyQr9+Cvb1oOinCGJ+4DKXELcMKLpDgwC?=
 =?us-ascii?Q?UMx+kMMa9sU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QzEJfLL5zZC6QFQxiqkkvMgT2klYP/dXwa3yxAcgvG2/RuZOB9n5y9eEuJQ?=
 =?us-ascii?Q?Ddf5Fl6LmiHwQdQHSyOtCzC4sLvdlVZyzSpiTmbqBBy0hxiFnJViOuTD+O0P?=
 =?us-ascii?Q?pwUuxebYtUh2T8ea9HdPq0G3q+naD4WotRGn16JFNxf8iL6BAi1lJXhN1qN2?=
 =?us-ascii?Q?WdrA+kX5s2gBEXCYLElQvdUGSZCgA/yNC1srfg75A/m2i9fd1oGmBwnWmV/w?=
 =?us-ascii?Q?BK6BUinKvHi7fzmO7ONbSiD4PbE69iUyn2r2Adr6K2JI040KdodaoEcQLjNf?=
 =?us-ascii?Q?pZ/SWn1ucbDXctAcfL/AlyWY9CWXebcNBwNpfCcrz3qVwON6xJhbL28ST/zQ?=
 =?us-ascii?Q?lD76jUcRO2sUfRSlZvdZle1RnoIgS8ORtVB3q2pVkyOtoN6EdEPygxzhtVRU?=
 =?us-ascii?Q?bqGWhhFpO359jQHPbqplLwCl0tAr+SCRzzdW3hhPwGRl7giusfvN36fRM9Wy?=
 =?us-ascii?Q?pw9unmeCBEC/IvbOGRjIPgTzC9lHr3ZMH/LmDCRssRHtJBVLdkjTYGeFB61i?=
 =?us-ascii?Q?KovDrxZwP357IKNechjwgFX7TZsyVJGvrNtUI453Jy6g8jbOf8x4TOIboiS/?=
 =?us-ascii?Q?k5X5Gvj6b2Ccymoep2M0dyqvYSFbkFDqblMJMm4c06X8nQfHycjpTu2vLPfH?=
 =?us-ascii?Q?qzYywosUpI+oX65vc8GAmL/VJgXfwDFaLr9US6HiIyUa2mR2kjHF1JpMxOfj?=
 =?us-ascii?Q?LryegB43v4+9FxXdgVc/Fw1QeCm4gzYOq+6ZvfA8S8POH7y3wvf9I5Awz1CZ?=
 =?us-ascii?Q?gk1dlwSdI+ggGmdkN71KpHuEdjXb6IGLvIw2op2wgc7/NVGi1YCJCJ1OTbKX?=
 =?us-ascii?Q?qE2XtDCZY+58qQ1fEag44QCPx7gJK5eQXQ+XBTwchULLutUt8xo6EhPo2JIx?=
 =?us-ascii?Q?OA+mXmXkO3rNE1dCvRLOnwlb0183y/pE13Tik/V7JCdS6EeAvVD+c+8cZVNB?=
 =?us-ascii?Q?ufS34sfgr8hrI4iWQISNTOJ8IIKBRFUegnckaZwYNJMpNexTBUEAP+Q8Ax8n?=
 =?us-ascii?Q?fZ8HeXd456LQPPP6xjAOU6OQXZXQZTfW4q9JPihnjFZJ9k5SJXl1J3gyjAKX?=
 =?us-ascii?Q?rNchSF4Nmg5ttBzMXvpwTfMGP0YB8zBrAneq+cOsfbeaionl28jGaHIZBEYT?=
 =?us-ascii?Q?PB5E/klXpRgSquea9Bb1b0KLWSlAFjVNHvgM59Svj1cPIuib7FNMMFRJwpvE?=
 =?us-ascii?Q?62+ncvKU6HBldG9l4FpBW6MT+oq8cIMReIXZm27o9cntbMPfu/mJZ2sCFkZC?=
 =?us-ascii?Q?3HqB0SIFVJFvudJjEjgsUT8RkYznsoB6vWUa2Qmnc/YRXTfxm4uSTKJLknx7?=
 =?us-ascii?Q?iYcMuWz3DlGZkjNp5vacTAUcl4ppOH77OPWKSUUfsP0YQOfXg7POeZyRrVQU?=
 =?us-ascii?Q?20xe/tmYlJRHAgfqVkK1IJsvyiGHeOvKzQOv2sBPxfMJScHt22GMlH0hbOvE?=
 =?us-ascii?Q?gjDhd4qABOoS/PTxN1mNwYEHiDzEUDc7tysBxwPaFJ4KvfMt8wau1rLI77jP?=
 =?us-ascii?Q?YwP9mkWYdrwKWGR+KRrihtWGTJfuX7ojS3zdeDyi0a3GkFgFXlrqu9FHzfSK?=
 =?us-ascii?Q?ud3qq5jtH8VyFE9QCgaxHTaq5uFre5gUghtpJi+DmRX6QadbRGJVERzA7wV5?=
 =?us-ascii?Q?NCg//XQTUoDulDXo1hUypz0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee87bc9-fd0f-4a15-5cd1-08ddf0f308c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:21:17.4185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVivvy5oBOgtUu2tkDZopvw8Vd7ltinrp2H6ZJWWQnwJveArp4nhdJuHVgdA0eYWXsxCuxqjUn9gveuuB4qttk8NY/m2qdeP2ENWJnPebRa+L6yY/68KIhLtKafm141n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

Fix the incorrect bit masking and bit shift used to compute EMAC
control which in turn is used to select EMAC clock from EMAC
source A or B.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index 242740a4b00..16a37b962cd 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -544,14 +544,14 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 	/* Get EMAC clock source */
 	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
 	if (emac_id == AGILEX_EMAC0_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
+			CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
 	else if (emac_id == AGILEX_EMAC1_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
+			CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
 	else if (emac_id == AGILEX_EMAC2_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
+			CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
 	else
 		return 0;
 
-- 
2.35.3

