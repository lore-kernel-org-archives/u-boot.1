Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E263E63CB7
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F18C83CF5;
	Mon, 26 Jan 2026 02:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hXrpPHOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00CA83B32; Mon, 26 Jan 2026 02:07:27 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9FC83D0B
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZ2ttWIZBHtBrCMiypJyQT0H/IXz84OX7n01xP32tfib2a183mPSvqI66F7F4W2VKOpZLs1QIOSRe/vXtmbviPrOmaN6ke4/sAuieC3nyZ410+3c/PpnOFRKSyuNUrA9J5K3FF6mvDOC4WaJoDxWtorZmRrhjQXVe1pAObIOWJWkXc37Oa/VgaYaEGUwgi35nG8K4wJUzOCs04JFb/0MWzOSQ73BInNRyW7FHB8Bhv+ovKzzjO+NSC9ZOqTtZNGghkxQNq5+S0CKQKGLCBDiHbIcsOzB9crEzCZXkaOrvDG3DSNDuvgtdBMhVv3X+jpCRRAAOejeTM5bC/2OIraulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At8+auajRMS9pZvrP1ho2lTnzk0TDiOXTsReMuPhHUY=;
 b=wVkOa1+6Q4++B2F7VAVAvq1HcG9W5v6VYVmlSBJW7D29mYHkTzLznm8aOwefBdvPYhq+qMHnKpUSEEkJShkQissKv6hsJfpDd+PiBz7aAjRy5F7eQGpbpbZEnNoKEKZNiTZbABC7IDH6uQE/FC6zqFYcHwKZsxajHXIxwDltPmjwMbfUsrUywR/kor25rqRaLttymRZisZHs2qsBXWm+hyzu8Z8QQoHGOHEm+4w5tbT8zdzYRuyRvm+WvJ9MPe6Q50a+zP/jd5dC01757bubjzCMorv013ux+KtfMu/rU4z6UvQB5Ulbme3FeO7DBk3d14G3BEj4oX69xjhTRGXUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At8+auajRMS9pZvrP1ho2lTnzk0TDiOXTsReMuPhHUY=;
 b=hXrpPHOLkNhOGhLRWiFJJqbU3MtEDpGCZpFQwmr+2yw7QUC1K9JBAymTwSZ+y+Cc/W6zo2sFBjl4jt/xDC4QsTxFLAHL5DmzYsDsrVWM2FM4cNkIqD+LVZW64olkiV2HloN6nivRdEobgZ4ByiLbON/v2chYOmQf8igRG3aZbxqi4aLrommmJxTlY6G4tXl10lp4Lg0I2bl2ThiBi45cVa7KdD2wpJFsGCHAPuCARUzziQA+mSZtTzuUg7eSH9yGc6hei9rtx4D5nFoM47Z/dCYUJ5Y+/ATFMmkaSJHotNNhPcp+YB90+8Q88gvkIN7RePHfFx8yN7W7tG3jjN6M9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:07:24 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:07:24 +0000
Date: Mon, 26 Jan 2026 09:07:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, festevam@gmail.com, ivitro@gmail.com
Subject: Re: [PATCH v1] mmc: Fix typos in comments and debug messages
Message-ID: <aXa+Qg+P1YYGnbFR@shlinux89>
References: <20260125123957.21295-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125123957.21295-1-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: 48002ff9-3ae0-433a-d660-08de5c77438f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oknxot/gYMxw+YZwRFtuao5gPdDEUi9fxzPEH9O7k783bqpB05V1vGSWcrki?=
 =?us-ascii?Q?jui/riN4BfVqFpMnwrrLucgNEVeSWk3f3RyTmZEox3EEdfTKuq/zox0+3foo?=
 =?us-ascii?Q?NHJ7OX8hVhCwUxHrhb9d48XLOfUShm44tKCv8kXaolgunM0j0RA+kb5wxCf8?=
 =?us-ascii?Q?DeyXvpYD40+i7OacAaipSl3sCwKEN5S3XWDHXzE/Sbe12YRvr1WYIszYWV6I?=
 =?us-ascii?Q?MoMu7AWnfYVZk+J0r2UElliEdAcs87K+glHpgtZS77SHYSYz8CRJKSC46nEe?=
 =?us-ascii?Q?WDGgABM4jhg6CZT3MV2R4RAYmbPA57tbUyuPs2aWvdgpYVO/IVQpxUyOIJcl?=
 =?us-ascii?Q?jJONY9mA0cEKkzZQQa5nfXgRwbQFo0E2Let7BO5Q6ZP+m9vvj68JbcKtLqhQ?=
 =?us-ascii?Q?TP03hfz/1XUfpVCn1T2v3YB5nHIlp47RR/VsqonHHUrtQEJsdxxC+L8TYtpK?=
 =?us-ascii?Q?crPB4kH4e5Joj7tZdceN+hYKfh90aZtAVgmgYG19Aju2Sfgl3Lw3L8BunHsq?=
 =?us-ascii?Q?bhnPGYbx2jPgfTJ6ZpLubjkUghc9lR0B41n8MT+SUdvounQfLQmV6o54bhIW?=
 =?us-ascii?Q?ZilcVY5CD1dC1R7VpMbuUxKX5wmHRv//HlGMDCxRwi1K+BbMA/C1EgO2Sj9H?=
 =?us-ascii?Q?wmWw0lTT9teVlEBI+LSCRc4uHRTHwFEy6+32pjJA9zetUGOPsWYC2GZqYWSB?=
 =?us-ascii?Q?0TePDwRC7GN0G1YsNraUepAj2j/xKgqT0FsoUkHkIStt7NwiRoFVgIoa5FYA?=
 =?us-ascii?Q?ilMRikrHmy9RC64cv3EgKgrIft5gqdkttF8hDaDZSFfDUZBL+/KJjubPxc1u?=
 =?us-ascii?Q?v8sZ2HyjsJSTJa67cbYPppX9B0qF5z2Uyqc+A4PHCOTTs23SWwp0RJKleQuL?=
 =?us-ascii?Q?1d92APHdbS/KAsaJ4vznicbWX5w2TwKMgqZeAXSfwQc9cb6VC+2vdZRKo9VQ?=
 =?us-ascii?Q?W6SUEo92s5kuny+b0zpwVzQgrklbnIjTqDrstXjns0ocbXJxQq/D1ZMT2avY?=
 =?us-ascii?Q?6/HYL3GgwKWV1G7EMA5mcJdGbB5OtLdp8ka78Xc600BtmpgqlS8e0ApwOCoS?=
 =?us-ascii?Q?Vf0ZYDuNT0eF+iyTH+2bfv1AkSzYSokaSSeLWKgrS81ubwjU2mleR7iO9x8z?=
 =?us-ascii?Q?oHlEWv/DnAXJavlkto9l2r7qo1wlkCj2KTo8QZJqHLdwgXqZwvE/jKKWvLXD?=
 =?us-ascii?Q?/Ry5+8V1/1z8Ecs4XGt/rSx+6O2FUpZani7wWAk1TpyA+uBF09e1pzwFFk0R?=
 =?us-ascii?Q?0gI+h070X5/B96i6m3OAwhaTjVMsjwW1+QUCi0T3fqd2OrrK8ox9ML8BmpRl?=
 =?us-ascii?Q?yBMwNcSNohddmaRP9G85wG2Wwpg6dWgf6A7Mm5NgjUXwQ/GAroYgE312ji6L?=
 =?us-ascii?Q?Oqso4oMbSVW/6EIRFNf/i9um4Sf1/5aypgxpIAMV80nzLrEBYhTGFBX74NvP?=
 =?us-ascii?Q?1H5BuUXOfhVvZWlkmq0Wv4eCkQ0mG9IDizv4jAgFPtV29hgOZO+4dzSbtSeZ?=
 =?us-ascii?Q?blstzWmH/zi49WzJBZUCHbVo27eVPeGLDKlnOxWuJFh5P3AJtfSNGjRV2duA?=
 =?us-ascii?Q?k/mus7rm2xPX8vyjprwH4hagbHhTOKcb+HVG14a+4kpwEIYGh0Ff8yMeICcT?=
 =?us-ascii?Q?SGzCryQ3a8CSu+Mei70Z9MY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoV8Wirp8HZfA5GTtbPeJ8GLoqEvePnXKoITReYF9npQa2Ughqcs/glHaZVz?=
 =?us-ascii?Q?zJ2H6jCEnNoV/pKq5F6GYutNig0PK5XxdlGckqCWPWoBxGuqWjomXrcPUj3W?=
 =?us-ascii?Q?CYoFqWxgz8snwffo3FLamWqxrFB8x9ymFvnR0ysGzmZSMOG7vmEid4d5J0MF?=
 =?us-ascii?Q?571M3y+5ibxDdlv81dECqM6nik0RK8bLqIDGiVQg0bkk3vYeJblcaLqos7L6?=
 =?us-ascii?Q?VtLl34+rZx+rGcbiqOyy9m9nLoexLgf7T7Q0yRDROsg70BJNtGMSdo+I7UxH?=
 =?us-ascii?Q?F/0Z4mvfJdXMbZAS4HaIyEvL3qaF4AeF6XE6UCj1cXWJLtWLyzN4x0bCLJE3?=
 =?us-ascii?Q?WL0td7MiIZth416avSCFYIsT3023vX+3JugoFnT92u6j5/dfXk75WCr5FHUw?=
 =?us-ascii?Q?YFRIh7Na5ja2BfudOg008vVL27vuAt/B1K3vom1nfDCqXGHAszatQGTi3Fty?=
 =?us-ascii?Q?kch/iROCJFfSlhAa2DPze051JkRZGK7J5mf0/FQn6xSI8ebIUCcwEkt8zWLB?=
 =?us-ascii?Q?7VNGZ0q/6b4Ym+sU3g/CKqDx13/GLC6hbcAjFSsTDvMTWM6qT2Uiwpncpn4U?=
 =?us-ascii?Q?MZkBuQCws0T6tiY26mapsLpFbJeAehIbxX/+oEzG/w4w8Hu7z/OZ5YPXZEOV?=
 =?us-ascii?Q?+B1sZSSuLW8B3x5dFvJWthEh0AODsxPboNeCTW+CHTcUB5Ns7MhlFwe8jfsh?=
 =?us-ascii?Q?iRyJFXraHCEVXJo/Mjqayb8nYLo7q9fvUFV9nv9EpmYk5gSgKykLVk8puyjS?=
 =?us-ascii?Q?eLYYz+lrc4wO0dL/+Z/OXCwMX1XEf6YgcHp6IUg5ilHfnkrsiM9TdLzMX7iD?=
 =?us-ascii?Q?bnUVDRe+tal4+hgGhXxwLSPGvu63RgfE3jXulvx9UeskWq817NrfHFa5ETeY?=
 =?us-ascii?Q?IKMlCSCBumykkmHrz3KyvwIAeDwV4lPz9etLdUUIeeB33NJSv6haOptnPVwi?=
 =?us-ascii?Q?9wuscqbmWOAr6qXJAldPVQ/i4DjYKaJjUavTFHiPPwoJASZo/GY8WZUmzL4i?=
 =?us-ascii?Q?DpGPXif8NhW+QV1Ex9aUp+SYkyXZ2OaktSL5yl655RwA1gvr7szTtXW5Z+PD?=
 =?us-ascii?Q?5rPnz9g9ufBiGPpXineV4+uhHg8+5KofslIadweNGsoLuyHoDN3NSLHb74SF?=
 =?us-ascii?Q?7yOk4FiXzx+PQj5J6U0EiDMVbGNahw50ygU2pAyIPdKKDJENLO2se2U3MGX+?=
 =?us-ascii?Q?C7tGmkCFGi4jkYwF47pL9UzLiR0ZZT9SVqFldA/8Jog0TdjYhx6nFAXbeSfp?=
 =?us-ascii?Q?lqhNjOg5gwSzO4tW32jQiCy1DgThrf7aodlLUQblek8f+xQKvO/mCWzrYI/8?=
 =?us-ascii?Q?GlFuYW3vIus/xufNO/WJ3hVjc5HqRJYkQTccjCVPrN1/WKJ7xDX/+ZfX+89I?=
 =?us-ascii?Q?+Q9f/dtkIq3v6eq4Kvl4ocTr1zvdYV9t2I4OqOmNLfLvvVrwG8SfHL9U7O/4?=
 =?us-ascii?Q?Td3LCda8JIbduQzy3cPL/QNI9QhjeGDMDhkvdiKTmuUjHoEvrwSCINHoGdzF?=
 =?us-ascii?Q?eIxPBjHQLacYpIJzz9X+tUGanRO54o+HGh3dFmR3qXlllQHHEv183CItbVAU?=
 =?us-ascii?Q?SEaxJ/JIw4h+gqYtk2HL03g+9s/nWGZHOuM7rPuWQG2IM61dt4GLy/3WmPgZ?=
 =?us-ascii?Q?5bb9Mr/CfYiGfwYSju2eB4y8cuoxiykYvYg38fqUzxRIOAvT5EZAph5tfsM1?=
 =?us-ascii?Q?0cE+kKxRh3QayDLGPc03lP8zI6jvdQDvhevUC3A2M5/QEqBIKHsSIyEDD1NZ?=
 =?us-ascii?Q?H0bQ3TOfiQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48002ff9-3ae0-433a-d660-08de5c77438f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:07:24.1569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWFjQIFKbWA6oedwybN304EB57XFouj9yhfjwY0mxVPnJmMdrysO7BD+INJfaovZQjPKlNX+kKyW4rEjT7b/bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779
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

On Sun, Jan 25, 2026 at 04:39:57AM -0800, Tanmay Kathpalia wrote:
>Fix the following typos in drivers/mmc/mmc.c:
>- "neiter" -> "neither" in __mmc_switch() comment
>- "witdh" -> "width" in bus_width() warning message
>- "enver" -> "never" in mmc_select_mode_and_width() comment
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
