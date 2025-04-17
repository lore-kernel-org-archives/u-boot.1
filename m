Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E676C369C7
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E10383019;
	Thu, 17 Apr 2025 06:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gYGzSP3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C11582F75; Thu, 17 Apr 2025 04:20:31 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c004::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC0F782CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fllr/on08P5WLByGChpojoGrJJFltXe8mgHQZiY0MU1pwgcZsDJnpH+SoMHMhhTMhx6ezMM6ing3kK+MO7yj4Wm6uTDutUcKHSM5qk05JHcdQmqli1X+T/djuO3DaJRfFQGRI+cMCTYV5vrGvdn/EhJIoKoP8+ZvqY9PNXazLBNPLX+K18wwaeqCD0FJzjhnTwCM0lzxp39+iSPjTtk45N0chFh3aiU7aa9FAuJFdlyp7cs7eWfuAJs0RVbR0dx0zx/C1/CEnXsrcOXV3LWinh3xsDKiM+peGDV2xIRw9rVYFEYIs7z1kMIZJAJl6ZWtygA/cRl1csExpuKwt892yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTKUNr+p6X2gxKg940hh8IrW0Zlk4VCy88BnoA046C8=;
 b=hj9Fgh33L5muTVRBEUblp8SPFvoaWkB+MaGpKndXKgGIBRDN3JOSSq/1euuQrC8E5V2Z3CU2s9hJzZNBbjluSFdiJH8PN7oTgE3PqTxsZU6Q5M89faM2Rc1iCbp04GIlS68FSOg5z+iWvRsCNPVg//Yp7G3QaL15LY832NVgQ+sf0DQyx+x3/OrYwSzjxA+NFBvF7n9C+lRa/XFSLaPjb0/stwkdx6eEs21/XSZJqftqa9rxodQ+a9+I8WUZyHbzY/u4pA/PFfVJnsJPV4IATjcQEqtqZa5g7oygK6ySDAEuKiJTwbJCTVlcpTQE/ZVdW/GtW5gQJBFmZ0KYh+Bn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTKUNr+p6X2gxKg940hh8IrW0Zlk4VCy88BnoA046C8=;
 b=gYGzSP3z1l5quHGlfoPT1h5tlqQQww5BZmGo+DJsPLoEih7Yxz6Ciq15KQUr7o+x6QHCtdwg9qsIT2Zyljv9Evu5uAcwGjR8HLepobWD9SOZaEvQszpNQoRn5LL4UttGFfTxmNdm0GWLPFUGyzNs17rprZvbDgSttByMZ6M2+N1J4ELjclezIzADDL+Rh0whcqcc5HsJnYZvi9s81YC8P2RCcV5zs9kT2HcwDjNUfI0facG9KNxXtgoCq1NF7pU+inUukoBRHjL3zSQU9vhXBZeXhEyLVCZLrErhGsco2yRO5LKEZZZ0n7yxs34HPoKHzWYRYkgNIx9SpS0QL3+Y+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH7PR03MB7414.namprd03.prod.outlook.com (2603:10b6:510:2ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 02:20:25 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:25 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v4 08/12] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Thu, 17 Apr 2025 10:18:36 +0800
Message-Id: <20250417021840.6212-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH7PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: d23e2e91-58c5-492d-acf8-08dd7d5669b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tpqIE6xZl4CxrwvEXelrEtP8HGyKDpz/Pu/IU72BKbeOaC9BwLYL11ItKTUo?=
 =?us-ascii?Q?rxmLbdRLNONwM+xPdJQcibMwtlhhwT6eiVHdqmRZF2f5qxkEnPr/OYoodOM+?=
 =?us-ascii?Q?s+IYwlL4P2feb17k2ZSLcSDNa0j3xSMTA3epyH6esgFbTI+5+z5juvmYcJlb?=
 =?us-ascii?Q?BVLJ5+UMiEh3z6bAqi7+Y97kNXsQJTotPibL2I8Oczr5vplDACzWtrbBq2iw?=
 =?us-ascii?Q?QB3CAv2jOl/N3EJXkMIWTjKadrXPWCykMFg63/w8ImVrpXZxkpd/SffcXff3?=
 =?us-ascii?Q?b82ifurUvVxVd/a7QRasWBOyjFSgcAWpN/HXVsA9reb58YCBwSmYDxVWdktL?=
 =?us-ascii?Q?b4HWK7BfNOrd7h+LAoUO3kfEwuA0w+BTZCSHoEs5eS6llPikjOo6pB0RwtCt?=
 =?us-ascii?Q?p4M50oAVgWiygUNARzli3zs4/Y/0wh5TCUUSse1ADs4ZJYNgeI8btVefyRCm?=
 =?us-ascii?Q?resloPqDLnRAN0anLSYgurFeJhrMiz0UM+T4jPWix9cSa7FdVRWq5/iphiOc?=
 =?us-ascii?Q?UfJPZJqTetEbrIt2YYwCU+sOcPI+FIr7sNf9iDbpSmoDA2jkyup0vi2Bs7Z9?=
 =?us-ascii?Q?uQQ17yGES9PzUVEYZFWpuXa2BKH+VZJd6o5TiVlmdoixgzZ9dDm7DUv4+Osy?=
 =?us-ascii?Q?AfvGRnbWos73ap9Netj4aF0n3sXnC71D6wCU71VOA3jI3U1WoabaoHj41W29?=
 =?us-ascii?Q?TtXKmv1LXJon8hgv7EwDvMaa6k+WoOmpz0+BdR5JdrZ0dcbxuA7tn6nrs2/k?=
 =?us-ascii?Q?22cP0juweOOuFJpN2PG6B8rqVEcVQtDp/bglm7KaQSof6CmvXw1upK63LpGD?=
 =?us-ascii?Q?aL0Q38Krb03lRdEXncBy7RBN5H4Td0fTYIhVAMuJU+nV20rYkDZEMIA5DYSQ?=
 =?us-ascii?Q?17fFJUa4Rsqf1LFAk68JkXWj0J4QZsFAphD1b83ZG/42u5vAXnNjCGJe+oSv?=
 =?us-ascii?Q?XZTYlMDFWVEyuHXVXF5UQ4bqyyrup822Z9EzkXaP0Gm+P/gwWJo7e0C+P/e1?=
 =?us-ascii?Q?M5gVssFrkOPrOsHe6o0kg04a+OpPVOIdi+E/dGcpPI4ESWoWmqglaUYjeyrb?=
 =?us-ascii?Q?oGba9MBxvP1NYYo+8B8l2NbUaV2zzcwSw7oGKL3tUprsjjIyYVXCS1Rm0jBV?=
 =?us-ascii?Q?/dgkiuy9ymwNHi5F7Prqva1/rcRih8N0HkHioZ9qQBP6/1f0D86ISQ6GAen0?=
 =?us-ascii?Q?JQ0nfPrluIOlMWZVizsEl4SP+ZgDbHCiumY0o3WbngFrWrXA2Xl/XDpvpoRD?=
 =?us-ascii?Q?8RtZh9KzOUOU+SGPggaDMM7wTczeEeHrhVktjjj+mMd7PFjEbriJvWQ3KQbp?=
 =?us-ascii?Q?hwVfZZ7j0G6Vf5NMt88dpiQDdkX2lj6Ts66/QOLArtFt5+xcA2SwXZtQ91E+?=
 =?us-ascii?Q?aV1qpe4eXdQsQXagqiUNcJDmYwWuCkRatquOZcCagOCCBSCM1/WnzauqzdSi?=
 =?us-ascii?Q?eY6MaabNGe4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YmYpO5XmpUzAGxmUA4nQULahdS8Jd/c1i8jFQOeTxBXvGzaRQjWUruqYxIy7?=
 =?us-ascii?Q?CjFrb2EDHkxECTCrp02erdo0RcLsmqAP36I4vByiL13Fi/m2+GNTuenARaeI?=
 =?us-ascii?Q?izJbs2D1dVqjc4xcR+WXVmfJCbQWowGpvK4YB9G0aMXqLHVK77ZaSreJUfYu?=
 =?us-ascii?Q?VyG+t/ke+mEnfYBAgtedmNj3qVINXKJEEFQDCgkGzPTg/LfMdyrzf2mzms5x?=
 =?us-ascii?Q?QzLjLEnZIrY/7inYpaHt0EvRKQjreBPlWfQmO6sEHZsoVVHape4Bv05iUsNM?=
 =?us-ascii?Q?7Vf8J7C8tmwXJEPGSVlc1yXS89w7wO0ARkOn7NUKrpxtDEHvv37CgKEjl3ij?=
 =?us-ascii?Q?AzNr9NhpBUnbrgykEbme+62pkwyZU1PoatEcmV+f9kuMRpHJLI7pQUdvTzDJ?=
 =?us-ascii?Q?nWP5GT/G9WY9qnz28QRGaH13e32yX0FpegkwDZ/51qiplND9m8gxUFFUoK14?=
 =?us-ascii?Q?IhIF+NamfKJT89hDOoE6rGVnMuyncysCmpuAIEEObNaFSqhFLJok19Sqsamk?=
 =?us-ascii?Q?rpWNdAtsYhRC2T/FW+OIjAcbRNvwJ2rbulFlaP16JbKN3TW2fyDngxLllg2P?=
 =?us-ascii?Q?kis2vfUL7VNCein3GQ75b8H3mtIvlFx0DhcNGZIYJ2c5sMxyW4y+7i9JkkyM?=
 =?us-ascii?Q?e1hQA3PuFEkONwLcLXtF2g4JFqlM7duW9J0C5gjubP3WkNuNjC42hXpgfxcv?=
 =?us-ascii?Q?5VlzySF29RYggvytqeSUS7BPhbjzpj3ITSbEoSAvU9iw038vco/mvgtnWoqv?=
 =?us-ascii?Q?bXI3w8pCBHuRt5qttVxPrT4rlsDHU7oZ+AZOenKfuUtA3+k5dKElKmpiN8ou?=
 =?us-ascii?Q?z7+qweHYw14vin64lyvXd8Nrj+m+zj0zRy+ZD6lVpU/Ea3auVWG2R7WW7PBa?=
 =?us-ascii?Q?rTvvhXNfQzL8xrnQtDgwBf7vT4ApqMCJrfmJkORFeuUQXgJ27FCY4Cdqt9P3?=
 =?us-ascii?Q?0N9YNyOjyt6IRotbnopOAUe0r+tMoPFJBDL4HgrHHbE/K9a/fF5Z3NFEADgr?=
 =?us-ascii?Q?GdsR1ubKaighdo8E8yoI4ra+UeRPhAfu74GpL+Bq8RmJW6z9uGilpw6X684C?=
 =?us-ascii?Q?XH3+6eu4nTKM6QZe9Yk+69gKncHP6mGflVU/F//7mek+Ae1vfIh7KV9BysXL?=
 =?us-ascii?Q?rhc2ma1XTvjnGOo1mxYKAVJmC1BquMJtSEGmyhf9KAXhstoLE20tjH+ZPk90?=
 =?us-ascii?Q?o/MqSY3H0tard/ff5mZSTKgR5jnO3jMjYE/Sn6+8gOsuOkEemG3zdYKbQwSt?=
 =?us-ascii?Q?CsXnwFHXiwPyWzgBdeQYp6Kq9hXAr24YpTeC5+etqjz3wD4XBQt1U458uZ0U?=
 =?us-ascii?Q?du4FLhxfPUd901jkGeAjVp/ocao/OaT5Ildz9K3Nhyva2I/5vRAO+5xcrGqc?=
 =?us-ascii?Q?pgaZ3FaIszuCcd5ON8xM0G/YhbFVSPbeEmFqd+vh7F1Pu9uEsC0ggfZC9sbE?=
 =?us-ascii?Q?bmCTplshcYxDodiCPtRRmsO6rIDQlwM+w6zl+zI+dnLPFpXJetrBeAvzHt12?=
 =?us-ascii?Q?xtkbLiycl/0mh25ldx0cWKLuQNBwDdD6fvXQxGcRJKApx+fcAb4YynpPM8PV?=
 =?us-ascii?Q?UkckU2v8XnkPUfXJuO5WxTU5gc+PkDUKOyAv5zaswuH50vAWGOPqM7mbEPLI?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23e2e91-58c5-492d-acf8-08dd7d5669b4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:25.3305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/OeMyw0M4M0SG++KE53VXHTyp3WUNvwVUCkBHrztoEYsSMdOIef7o4PnLgMiWfxXxcDn+9q57VRVEMpysIK6JCZV1PG6lKrBvDWsDfbJ30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7414
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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
index a693845d32e..bf5d57937c7 100644
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
index bafb1448b57..c2391170ae1 100644
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

