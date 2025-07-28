Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A31C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71AD58320C;
	Mon, 28 Jul 2025 10:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LsSsQwNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6032282F00; Mon, 28 Jul 2025 08:57:22 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D0D682F8E
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxZ1c/6RKhfR3ZbGN2j5IPIOVn8NgyvO7ym3SS3JeUCiy9w9yK7g9REnD7Zbr/hTgV3HBXpUCH29HXRweC0OEVpwZWNko9HAeM8TztZGnxeOb7Q67ZZM3SvxBiRyIRbqjlClqG73YB9+x0BDAn7nHvyXkAV2IQ9eOgLISZ9JSCMG6gBFRAv7+OFZtCCeC04jo/Tyg5QPIJDdjiKpnSx979AN92bmU4PAYrWvmcFajrUAnOJCUfLkV2xJNJ3fFQt9m8O+DKNTsYx2reC8achgiGLiiIJ3fd323R92nL7gzr+9gQQxdTsWpYBFdipdwi1VKVHkKkUT/7PrDRzebHoD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOSAMQ8SqgsOZ/ij5sz9RnuM/WHcchQndKgC6pJukZg=;
 b=qy7dJGGC/rtpnKNNRHoj45hZNh9umtq1oeSjn89N5cA/nxpdWj48+b5Bwhh4xHKH5uxI7DZK80eKAAV7UHLBsm9EWvuhVNHBXI7ILNQzEGS/mf+r5ujCQTvqhB4iKahD9b9l0ufUiaGO7YIBYmctKYXu9LsvVhoMv6IDsmp3lwo3vKYwdKZ34zdgHz7BTZAXe/BjX7oQhyLJYjfU6cZEblWscw+TjvwgoZFytSH18H0dBAfBK/ZNDz3/CGQDUnW+keNHV+Lu5aLxwCVFF6XIX6q1vPqjJ0O7hdebqdgCjZJf6NSTUObjY4G+mGGwHL/M5VuW74ICIuofRJ9ljTKOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOSAMQ8SqgsOZ/ij5sz9RnuM/WHcchQndKgC6pJukZg=;
 b=LsSsQwNc+3gTTOfgLdctledYEVw+JPgvKOnZMYa2s7GAsInFUOqpk2CVmZQqb3DjvNKCiNpDOGSSsHUpsDBN8Oq3cr4AiWA7K3ds7BjArJX2BZfRTzOUDIQTvrZbsFn2oDNz1R4Xhjxi69d1vfPlapYhNkbFqs+vfzqgp8QPsOaRJMd6n/U4OHROIOKI6th67bAg4t67qKHzG32Y+ElVehSeWVjj7vkgER7zKuzuDPyZSQcYq4avQiz9Yi/ZzonJO8QjVbTSkvmoU8kHCi+FZVVkNdk2slC8ukV0St1CSfeZe/JApPP4QPpqVIIevd17QAU1qXmh6BIjcUgNzNYYJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:57:18 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:57:18 +0000
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
Subject: [PATCH v7 08/12] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Mon, 28 Jul 2025 14:56:08 +0800
Message-Id: <20250728065612.6039-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 080854b0-dd6e-4a32-eb6a-08ddcda3fcd9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RYAq3wZx36yFdYIs0Sb9n3nq5ONWmJDR86DjQjoEeA3PsJPAbXHYo/WvrUfo?=
 =?us-ascii?Q?trtUDVa8eTCPac2wEiqazUoqq1wArQAcTDcXgqHf6BYTm0thq3D73pacPbx9?=
 =?us-ascii?Q?0vvIFTOwA4xDQVbnXH3Hzlz7maPHsTe5DLCynqObuNfdcBTA+AMWQvmEdJSZ?=
 =?us-ascii?Q?SeOOHjLeutwgsy57WFiQEGLTXwm8sVJiPswAZ4yc/aYIfSyR3yk9xg5mhgcE?=
 =?us-ascii?Q?9hN19goWMsRopbNwhNxnncf/5DQFtcYhwBsADahzAfLyToHMNMbsJKE0Qntg?=
 =?us-ascii?Q?unqg1A4nM9KMq40+AYTzaOl25zHZx+pgfyigPdXi5/u+heXPtPjIdqd5y33f?=
 =?us-ascii?Q?IS8giZMGAE032dPPd1c4Di3DaIuEdv7edNercdlmC97OX8o2ryf0dndfSCBx?=
 =?us-ascii?Q?ceRvNxVnhhaem4NzUFKf1B6Q70x8QkvLKkPwYoFRHb112AERB5RpLVrmqnKh?=
 =?us-ascii?Q?sEGTEMP6W3vH05NUlZMJchp1fb89COFMWO8wlS7xQoc20J+34Ke+DvKyCWEF?=
 =?us-ascii?Q?fcFGw1HvsY53lT3pbUJuUf/EtG+P67zymVaXPVwC0LWWpJOGHkYEA/UOfCNo?=
 =?us-ascii?Q?f6ZZX0g66dhiGI+Z/Za8t5NH39Jlj2ZTl2cVnYGNSuPApJZoWrqTqfLWpBwp?=
 =?us-ascii?Q?apaLSwZ+SQotaDfr0doPDRtWIjYxvv9YdfWVXMu4mnoE5BW3fclmrx187RUa?=
 =?us-ascii?Q?rmyAVGSHiQvrpjNFH7m5+WSj+xpdQilWPEWUOAiM4xwP+XAV7+1dMh+buLB2?=
 =?us-ascii?Q?A3DZjV73UhDZyzstIz4ZNLXNccYxt7SBlsMzStwHT0I2BDVj37ruWr5BuWh8?=
 =?us-ascii?Q?v17RuuNKXhoOR1ve6dK+fvGWosvg/FLWGyJLPS2WTHQAEzkUTxXfG2mZ20er?=
 =?us-ascii?Q?Y6F5iKIPetV3/MBJfc0rzQIiz7R7OhgvLlKhd0nHIRwwPMLeuuZgGs/Nj1kV?=
 =?us-ascii?Q?iUpX4j+7uyW9QUuXD+0RnEcb31wG46ckWxKs1wWZA0S2KKAjMPd3ltNrrm1B?=
 =?us-ascii?Q?G01tP3aQ+qE+Rgt5LTAQuODeFIfMzGme3Ud9SUPauqx5UKud+4gkprR0xAhp?=
 =?us-ascii?Q?iT3521QJNJtEVaQknoagBiu/Wz084hYVPDU55K8F3uhKiMzR16v7sWrzodGb?=
 =?us-ascii?Q?+HiZg++Crc6zbit23qk5Pz9FtQImuP1Wk1kOd+OCP/8xrP3iTWeCnKzVmd5g?=
 =?us-ascii?Q?zNARi9mYc45PeWopcHXRJddKlgrityvQKZdagsiAsTdKFnm/G0kO6+Gd56UM?=
 =?us-ascii?Q?uvszA7Uzw+ZXLfFIxGNIq22x9N1pcqKbxC5+hhEtaMfWbXfvkxtNv1jYb7+2?=
 =?us-ascii?Q?t+/n1oDXz75K94euIWFxy8hgMbhzy/Rzydu/Bnd1+dCY3GqaCSaFD2R4nE3/?=
 =?us-ascii?Q?XGwl1+9jv6HjZ7hLiWdKSU2Pl+j2HxnYufIvKQzEGVfGEWvpS/k+xV/7WiVX?=
 =?us-ascii?Q?rYQLec6o1uQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOOkq15kJQK/FUNKF/BVzh9snU5D37LGPa201HY0ziqVSTQhLHGN+HvDAh1F?=
 =?us-ascii?Q?RtwU6gr+TvScHrgI/k3itxyYg5GSNA69lxlCtM86TRlWFZ+Nk4lHGLsDWXJS?=
 =?us-ascii?Q?Zuguup79Buid5iAqsRW8XtOtiNAT2SSbPzgz2OR3080LQPbzAdYPv5QzoO05?=
 =?us-ascii?Q?3ZllBh/kqHYjjvUG+uImKHQcOzQJpV9kQsipkVnwC9623JSfwNVzWlE9NFAC?=
 =?us-ascii?Q?4qLbGM5Ds01uXmM89tW3xWrtl24MeB8AF+oh2dZfcOgaM/lw/lRdcG6W6CTT?=
 =?us-ascii?Q?5zLM3aoXABIQhWEUbBXPzP9BdVzQKtMgWTcleTXp25OBiUMg/V6Sj5Nm1TPK?=
 =?us-ascii?Q?Dha9Rp3u8Rb7t+ttUTn0yVkORG0qoum5qkGanslRm0rfUZsY688Mnfv9dixW?=
 =?us-ascii?Q?cBw9tL3pO0AaORwGOaRmvjkfknjELnMQ5jCaF6hb6RvWnuECyzwU1dFBizvy?=
 =?us-ascii?Q?XSTmVQQi53HrSV/9ozWw8HVShIPOHvZI6HrZ1/NdIPTBIN37qeC/yu9v2GUP?=
 =?us-ascii?Q?vTDZfnv0kUNMjnS9IkD8bmWI50FcOYTsaWLhY+b3VPInWSXId1JC7Ca7UycT?=
 =?us-ascii?Q?AK68frocStxSHx1mFKT1JopkzqjsdXSB3jLam23DKwmyrwcgwkD3sgxISuoP?=
 =?us-ascii?Q?zU/N7OPiDUpeaCOl3wrT/hjNaA82r06WeAoxUQgh2z0c3Zc+bdY+sMcamv0A?=
 =?us-ascii?Q?cLZjeXYSABjapyfPayUQ74Kz+4/oiU2CB8QwGgofw9ptJkMxQ3+sf9FTPYWP?=
 =?us-ascii?Q?O8a7UaZYQRxMugHsUXPadCzVqaHChCdPxeaJxX7Mf66DFlwZfNnjJd3qjLJa?=
 =?us-ascii?Q?e2kmPnIYrlb/tuTv5dVUVTByp9OuAubnCrHLSBi5QyQZSBOV008hmeuukRFH?=
 =?us-ascii?Q?BSZ51ESOsjDNMIGj4uMY+oPXYbHikYUIINbshMWl0guShTDBRC2sMrTASePT?=
 =?us-ascii?Q?XJ8eXEtnVrnzj5aSaixnoKvKmt46SZw5oQN/m15tBAJoeR/+mk13tDV/iidX?=
 =?us-ascii?Q?dzv3rYgzqzCsg+BA7d+wrmLdoOT6RDkjUCRdPB9ltNGNaaBOv2iaL5vJf7x4?=
 =?us-ascii?Q?oUPRaB4L4B5nos2a4NOeViljIteR0sWmse0uB+58omRPMuOERE0/pp/CiVPo?=
 =?us-ascii?Q?Rtxgs8JqSrkse+IXVKQE2eexskm+ndSiXJR8fTYJI4/booI4zDhvrT/6REaj?=
 =?us-ascii?Q?jdyTIq7nXqubMAjNczW2frfDT36jj+HPePKEzHAYQE/3Ua+RQVvnVetN6R9w?=
 =?us-ascii?Q?NS5An6d0G2g9z2F4OIrsJW0Hhdw+AahINR4uVoq+OVAdGACuQVFcoax5gWdX?=
 =?us-ascii?Q?P6wagEBJLCxJAYukrQxsz6wnqGJhKqyzFtM5cRAEqmDoGLW6IYwv+aLcLDtG?=
 =?us-ascii?Q?kUjzTE/CDcuWYPx8Y+vM1z9/wvOoerekEBEi4IcwpYRoKjF1g4dpmB3Peu1i?=
 =?us-ascii?Q?bBwDcHiNhzlhohKAQEmENJnh/foQ5lT20yE3GseIUcf5M3A6RvgRXawG5Nx+?=
 =?us-ascii?Q?rhQ1GMZqNigbF/4anu6E/fAF2zwmSFV0Umgx4FeIK3bo1S6Xiht4GoWCPR+t?=
 =?us-ascii?Q?yul0CjMSoNDYYHA1P6Ai0Xwr/yRO6kyTe805fD4ePob2TD1M2uAEOlkn2KKp?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080854b0-dd6e-4a32-eb6a-08ddcda3fcd9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:57:16.4860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyb5+Qu0cBR+Sxaaey63QuD/L04KlLhq/S3QajsjZS3jYarsxTyw/dplzJBGKqX0MwzrrxWjrHcH0D4buw9fyuyBJ0zmC0U3xT6/uWg1504=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

