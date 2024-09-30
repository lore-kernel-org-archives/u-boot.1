Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B657CF6491
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 05:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC58288D8B;
	Mon, 30 Sep 2024 07:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KlDXz9tT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC428806A; Mon, 30 Sep 2024 07:47:24 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA04788D61
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdSwhMhKALaWkBc2xwR65cwgZ1IxtLwXNwS/P4XSkbBhvgQdh7akM4qPfUfEGdSnoXFPnayU7K7E+BT2HlJbV5nOofMmCc0roa9uf9N9GdeWg/JJL3KhbzyAkFpYKCK0P7Hzr1RS8NcfEKemmZfziYotINn1OBsIKDaSE+bExdJRmNfZDbZc0QBUdVx34TTWkTwaA4jjyjbFckuxJYdk0AC/Qp9pmQ5fi/HZnDWCFtyokaw+i3g7PDjTEmnLIhWKnRLlx2LuvOEgqyRx9OCsKb+KaUSzU3Lj/C4L5u1xTfTZiV0sbwRTAX7TCWYeHIFggnQUNV5HDJdcaKifgaHxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0XA6V7Uuz+XpH0f0aYZLwRJO/CJal081OMS/4DuSK8=;
 b=AWiP4OyIgR6eFPhBVjdSkNRwqRHYCcGZ5yE0LMTv8rCG23r0MhAlu59ntKtVEW0A3JO0GVgaz+yRHYYoJnSNpz93eztGsH3800Jreecdt9kSqo+qRgv9UrWPkwREl751KnmnkCFLG5bRDS3X15khB/+sB/dj/MvOZBqGKCz+D2DCoZe4Y3iwrIU2cvxSgr6x2PZDeeN6cIPBevTkw3smXKu/3duOyMj975gV1doMGRlPicVubQyEWSzLKDEHndEon2v0ulk6w8htLDpJsR/pWsiei6yvNj6ltHpKhpntKKES70OPkXbHKysi4obDBxW4+AYASB3vLiYPlnkPz+mr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0XA6V7Uuz+XpH0f0aYZLwRJO/CJal081OMS/4DuSK8=;
 b=KlDXz9tTgM90xdc+4WOHl5N2PIpL+0koqbsKGYqZCDY0mvvNpuRjZZu+1Ua6APXMqpSq4KiNY7IWpPUUxSSfdjiZhCGqFvZ4hWzD7Ruo9pf4t2UYHwl6lI8nIG/z0yPRZx8UKkuTtfM6+Ctd5DC248UMMMVHYWsW6+9z2GXKQ4ADe7s4p45bWKyFA9AxnpvPBw7xwvkBJ5wO3KHu7S+b5+q5PKmLAA0uW+ahV/OQZSKZup/Oz3i3r+mKkxPNz/MK2qxc8Z6prpukWWuoKXa2w0b3v/r6ATSV/q5+HxdGHIPIMMa8GrtJlztk6ic3Qdqc96c6YrszBZkVHsXS5iHqDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:47:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 05:47:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>
Subject: [PATCH 3/5] mmc: fsl_esdhc_imx: Fix host_caps issue for non-DM driver
Date: Mon, 30 Sep 2024 14:50:39 +0800
Message-Id: <20240930065041.5554-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240930065041.5554-1-peng.fan@oss.nxp.com>
References: <20240930065041.5554-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ab4678-8ec5-4f26-48f4-08dce11359b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HKaVwWe567fIBmTzhSq7RTIwFDxnVFNZu4qtpcrPahw/fCN3Zu1TiftEnrVL?=
 =?us-ascii?Q?8IQQDZeeI4bFOERpDMr+/XJMI4o8u7oia10TakysyRVcX1MhfwuUrZZ5XwhI?=
 =?us-ascii?Q?1fxMipjZJwDnEkkDgKjSg6wM+KvTsnC4Q6/WurbWcbcBtcQk5K2GKH9J7QuL?=
 =?us-ascii?Q?sI+NQ0GKJsWnv3at5+M6eM173jkFYYjRbQQl/2lcIJscjS/5LtsPlsFR52jl?=
 =?us-ascii?Q?0pAcXMf2qTgwzb2gAdGkvNk9htbXM3oQbUgYGHt9YyxNH2LKOVI8R82Mk7oV?=
 =?us-ascii?Q?B0CuWLMj+LRL4eufMG/LPxFl7qvy8A5ggqt8P5/qZDOuB46aSt2XTeQ2W/Y5?=
 =?us-ascii?Q?tFY5NBo7LheCs/nAFKQtrK2yD7pLAPZDY3HCDicGfRwIMUeM3RaFD4Uth0tw?=
 =?us-ascii?Q?43UIjXT31Sa8hCXbGj4Yvb6NHNJKv2SPdODYzBJj0eJOVO9J0BEymmgu6G+I?=
 =?us-ascii?Q?Hwo5EETxIGSQN227XaR9C8aCgWD3I0eITXHBSx80vPQHZzOrOnA+fasWqqEt?=
 =?us-ascii?Q?J2MwFJRDTWSUpj4kSvheJh+QUsV0QUT56OYD+J0l2ka/BfhNoE92ZHTCbB+Z?=
 =?us-ascii?Q?trgWu0MVEbOcy/ld3/6Ipcpv49TF0xhE4bc1vpBX87+6BAhumy0zNF0WiEuj?=
 =?us-ascii?Q?53CMbXxTGHbLXDwZtJeRwki7oTc6noInHvDRew7jtZ+z/FSqFijdUYPoGAbp?=
 =?us-ascii?Q?ikJyf6lT3k13NQQpDwANTnkH5NMfAH6mSJnfowy9PsfBSPjZJ2e6pE/t3mKV?=
 =?us-ascii?Q?38PhoJC/ObDeRY+hnHo9E4Vah92lg0AATUihM7Js3u7K2b+aXDXjr6y8h1nw?=
 =?us-ascii?Q?/wiaBgZc38clpmMt0ngzLuJnRb0CwP6I8xun7vKvl6uESpDmAaJosUoJn0ej?=
 =?us-ascii?Q?ei/C8ekkq+D+7MVEPnDo6SjZ9yquMkchJZ4eRNn4rQrZtEoIZv+16dw+Wzz8?=
 =?us-ascii?Q?P7ymXQIutMrcxieOzXtcc07lxs92xyhuljNL09Lw4ehST4f1PgG93E6mk1en?=
 =?us-ascii?Q?icpg0W40vnQ9kfoNZcL761E+AIBCg04V9M0NaP5pMHLmCSQkRKiV4m/i0P55?=
 =?us-ascii?Q?GQk5SZ3hPGcyHAid/iJnOR+YQw7L8r24xlyLbQsdjRJH5dvzxNMJAvw1wIjo?=
 =?us-ascii?Q?owjQp6+9jMiBF7+JnpJi4JqTYm8gSC8HUr1x4Np0AJ8/FmiWtuqOE3KHq/m7?=
 =?us-ascii?Q?+JC75WJKD80bIXjDwxiMNPKPyc34JJ8iGHeLtwwlrgqzOPTt++FbIOQGicN1?=
 =?us-ascii?Q?P36wobe8rseWzjdahJk90E7TSfYxBDcHCgrzSBfUbnbXOnwvEo239K2nWMyJ?=
 =?us-ascii?Q?Y66Rawa5OI4zfV717LYpSYq5pqeoZ7Ml/VcG9EXkPJp1neuy3UMJ99RYs9mB?=
 =?us-ascii?Q?mhaGpXjsanH3YkDzwm7iyEyeYZaIUgp7aQv8vQ/dEPJ/WoKWeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cq3cGxtptoem6ZAiO5JJyRul/1Ugw5xSxFL5qpNkSxElsUBdAkLUmSDpvPT?=
 =?us-ascii?Q?bmvMPctuchyy7i7ppQrfni4dxYEeGANRkI+C4krdsHwrAXNjt+eLEwbUGEKE?=
 =?us-ascii?Q?tKlbCx5FfXYNn2tUDHwHS4DOLFJDIK+mArP+hlXgIM0ryQeKj4266hTDCFDT?=
 =?us-ascii?Q?x/K4sNj3bWE7gQvghmd11hJteQOhcX5+sEgaDx1yG2Hfi8tQg4J4Q4MIyYbq?=
 =?us-ascii?Q?S61Pot6uWFEyK9oWe50KC/Xjkdqxq1VwS3boXfdYmX21S6e5OBjwEcG1YUxB?=
 =?us-ascii?Q?g2SlcG3vYo1IHzi+JCZ/SN+40eKcLIdyNbqtLUHrCAXZ6VXhAagHhYM28cFW?=
 =?us-ascii?Q?xIdvRh9F0jL3DuIFjww6mgeLXgoV88s01bJdtZnoJ6sE1DgmT+ZfEYsfWxe7?=
 =?us-ascii?Q?MaOB/4xEBV7dMjtJM3UPmRn8jT2QUSH51dOUF/eGo/DNtpiC9N2bG+c/vZ5m?=
 =?us-ascii?Q?jkl3MxEqI5PKX9GGeSo/kiGD4GvLjPU6+erqt6H+cJMMeh/MfQsLUHpoSsRe?=
 =?us-ascii?Q?3++tP6F1EqZrOQGCUixdA9rDGa96GEJiBeYZ3ynQcLWaE+1jylV2iECiwP2U?=
 =?us-ascii?Q?PcLL1eyehpCrHfa9OGesS6LFcwQd0tGLhSs9mMKrCTwhU0LYM7mJ0HgH4kxh?=
 =?us-ascii?Q?oBt5WLtgRmdeJLXYyiE7sYq/Eva8890IvWkFIKHVdz21Jsyfb09uphM4w5++?=
 =?us-ascii?Q?25I+1S7Hxxb28r1T8EgDhp/al8/5t+oPzs7vc1FKjHygyAfE1FwYqrLV8HoQ?=
 =?us-ascii?Q?H7tn9D2gQtMfrtgzEtyn4ieoRRbNeQ/YZf+wLuwuDWwnuX9Why8d8P4CGzp1?=
 =?us-ascii?Q?0iMGwx1bYqEVbhDGyuc8iPef52Bt7OQsI8UcEm9+mADewlMOMvuwswV8oa6G?=
 =?us-ascii?Q?uuOl6O/21QWdqvQmTF3NfcfoC9d34GW05LzdcwRCw8YBFm8w0jxx8FPidmC4?=
 =?us-ascii?Q?lvWxf/oHyJNIMSCyEaCr10d4XDuvCSD9kn1Jf3h/rk/lC2g6OxGGqD8jXyzE?=
 =?us-ascii?Q?TbHm33rjb7gKUfsZ+FgKXa38jpAn+1uVVeE9SSs5Dyua45MInhQ+HMI6oBI/?=
 =?us-ascii?Q?WQNTlCdVV0bys7wzBsWW/u0Dj/KF6XMahuW0beToKq8iDBqpcoG8yWi0L6aQ?=
 =?us-ascii?Q?/ZeRIS2Kc4+JOqwST8RRU+ihgf9QgDzCfrCrVEmOHsBiUHdPFYGhKQ3aRHzr?=
 =?us-ascii?Q?huyrctYFg8X5HW4UH4LJNWZF15NME2o0hyXQEh5fe0gxJBrB4oF+4LWLlR3H?=
 =?us-ascii?Q?gPMOIw9ZpbisVzWxIT8S4WrmFAgagbMAcrCF4NuCXVLv/Md+lNkHNCgIUY0G?=
 =?us-ascii?Q?SD0gOMeRfExlEGiWSsxBCT8v17P1m5YZnch59zS+He2do11OyJV5kEM7S0LQ?=
 =?us-ascii?Q?FC5tzgOUnZdbLfpSPgy5ojHZI2x2KFjuUlev7PinFB71bfn/zOmlE89nLguF?=
 =?us-ascii?Q?7XyfeB6Zej8cNB73bIEupZnjD1vX/Vow8j7XiZpH3ZLwMMaB2vkEf/rlzR7r?=
 =?us-ascii?Q?FRP76dwQl6XS7/VnGvMzn2P8uyx5CSGuNJRGlzi3Mf/6omEw+ntENgQIlDOL?=
 =?us-ascii?Q?XTor6GmsAAjvwWqqxuUrjlgylaCd52Y3ds2mtXWz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ab4678-8ec5-4f26-48f4-08dce11359b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 05:47:20.8116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsgcjejQc+CHJfDU9oy//ENo47HT+gfMpYnsBtD7nUF9eVhhs0+5DiChsjIbs5Yhq1Fz/PJLZKF4u6b7psaM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
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

From: Ye Li <ye.li@nxp.com>

The plat->cfg is wrongly memset to 0, so the host_caps value configured
in fsl_esdhc_initialize is reset. Remove the unnecessary memset since
plat is allocated via calloc.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 7215237c458..e371b32d2a3 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1195,8 +1195,6 @@ static int fsl_esdhc_init(struct fsl_esdhc_priv *priv,
 
 	esdhc_write32(&regs->irqstaten, SDHCI_IRQ_EN_BITS);
 	cfg = &plat->cfg;
-	if (!CONFIG_IS_ENABLED(DM_MMC))
-		memset(cfg, '\0', sizeof(*cfg));
 
 	caps = esdhc_read32(&regs->hostcapblt);
 
-- 
2.35.3

