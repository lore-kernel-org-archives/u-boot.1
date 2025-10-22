Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF928CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528D583885;
	Wed, 22 Oct 2025 09:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HPcNhl1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A83A832BC; Wed, 22 Oct 2025 08:44:42 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9065882E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 08:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3+TldpBLxCg2FakFFTGRhNO6OrXfTanOSwu5TCjUpJu0/d4NnhDXiN5qfzzLLdz5PgVHWythO/sGtvGUaENt8MZ3YQxP4i89oGhIlEpchzM5+VKeSNiiOpDo1HUpVzAd8G0IeqDXCM/A9cKHzIGXtWpXgYUPS3fw17rPrzyqzb3rZwe3toT4DWBk75FbGLnXKG3MQuk6qMVheCopRBddw0lebplD1PlenNO2BwJC1IEM4+pLx3nTClXVDW74+GoAc9g8Qfk2gfIOInQYytU0tQCKWernX/+5Le+xh8Xe9GclZC5D84IV/Z2pCAQ451NNSfQhGCgVEFXGVXuJybHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96C8GENuRnmyzZk/ZudCfqZX1sIw7tFbnt6xB7rUN9k=;
 b=PEYchfWi7FtPWE3KW3RGJGETe1f5SVHBJ+qsvNc6rbIFdA+rmtuPjyfRhfG/wqJcuYeluDfNL4dVe6CRwMudp9W6Qnh6MnEtjNnSztdxnwR1/LE7L++AwocHdHaxurZuNeXUBJpUCU4rhmf3uJe/dBAgkDLQUQWDRN2a7MmguS0B1NcnxhUk8bWzY8OW9YIk7KoFJw8wTzky0/8PHIZmp1QzFPAGGJsa7wcpYNwowffmIYPINVQLNlqrpSQlq0YPMoLMKXdqTUwitTIAF9ubCLu9zN9w0EdkffyTZZykJnkA5r99J5X+UVfWJpkFFwy96fMAv2HR2jmXAhNgAc6/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96C8GENuRnmyzZk/ZudCfqZX1sIw7tFbnt6xB7rUN9k=;
 b=HPcNhl1lESgnQCjqdXGHJ3JuwAdb1xCh1TCpgZ10EwB8lQwYlufO+2ZWjaS+AMIB3mMrvIaAOjHz5/o7jid9zJuWM8ldky5UGeX14iP0kosKW7ZthY7Ih3Umu5DQcn/P5ORxdQri9P6t9BGj8//sC95GRBsloxvczYG1pyKu6RMn0HaZzVO1h9xi7qWXbuNIIClwiljmRq2bcKTt1nBpfdfKBcnTx9F8Xo+kuly3IGG34oYyw5TvOgXWrKtvVjhbeGAtxCJthrPzWtD7k3VR3mTSij59neIYBcWPUR106T0V29jeVErUu/tFo2UTREPfo7uCFlrzO2/UE53vEzaTtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10763.eurprd04.prod.outlook.com (2603:10a6:800:27c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:44:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:44:38 +0000
Date: Wed, 22 Oct 2025 15:56:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 3/9] mmc: dw_mmc: properly address command completion in
 dwmci_control_clken()
Message-ID: <20251022075649.GB30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-3-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-3-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10763:EE_
X-MS-Office365-Filtering-Correlation-Id: 4706c1f4-dc07-4540-4869-08de11367839
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rcS1tos5md+kAfz5vvhZIoO0VgySX4uIIGMuOHn2jcFMcHfAUL+S+fpgNdk7?=
 =?us-ascii?Q?ta0mhBe/l6Ht5eGM+cER8UaM0/IPz7sFZPec+9fIa9Y8/88dxyIRK2K+pMIU?=
 =?us-ascii?Q?5W4HHbeX/UwUC/AL6OyLNbIH+ApLpN0u43S22KX0Hkk6hdOuQWXEv9AyIsWd?=
 =?us-ascii?Q?j8OosbTUVSt4QONwlczYK3jtKhd9lILNXwxOVesUFZxTUgFQlxq3iHx4uX8s?=
 =?us-ascii?Q?rNg8HI3qKZarER0w3lSb+f3R7RZMGdAAelYemLvyrVxjHD73BVgfN9oZg+Ay?=
 =?us-ascii?Q?rxeEz3m56rU/gIvIVRMcwOzxYSf4u2pbhesj7YqQc9yBRqALGDPbdWgG/eNR?=
 =?us-ascii?Q?O0SHsnWyqLfqmyxZI4w4hW8qv8hIltXToTvi31bpqU7ij0mldW5TauKVfE1F?=
 =?us-ascii?Q?8ZpFZtmvltzNbXZJLUJSmIMtE1uBdskLwDdu709BpsGucB/3TruOTmBrBh2U?=
 =?us-ascii?Q?T4LXHBKtokqWFwxspS6FC9VDmadE8vc7/+uunvifGuF0Rg407sf1SsNqDFOi?=
 =?us-ascii?Q?RlHFJVnlLp482Pxbth+pra/gZPc8fczNGEJfC2cPkQRykGcPzFGEbuclp/4O?=
 =?us-ascii?Q?Mop5n+vMIf18Il7kaav2GMR6bcMwuS4uJzBPK7bHwIlJHIdvg53vpizLqDG4?=
 =?us-ascii?Q?cW8MRcyrGpPdWaUSdwUt9YgFWmLAID/2nMK6i97NXpn3XbxIhGspz276y0sQ?=
 =?us-ascii?Q?BZzBv88ReskOt6DkyeZQyy9lJrAhC4NorOSC2/6oiWAKEy1UCv8syxcN9zFw?=
 =?us-ascii?Q?Hs9bQEZ66Mo86jvbNtMEdJs4ei4LDLTOY9rnoum/+lyE0Apd34lVzhpeocUN?=
 =?us-ascii?Q?SBBFdwa/CBSeGsdeu5Ve+/m9tR4n95GEaJszv+BBnjzvWXa+ykmnMkrVOsPK?=
 =?us-ascii?Q?CRfZ227odf+7DdDVV7Apd4xrRJ4OJ4HcE8SSbMPB87HeidDVdaHaSQq6JBW0?=
 =?us-ascii?Q?1kYVXmDbazqF7TOX23y1KRkB9y/p3LDOqfTidwKX+4WTesbgiXdb7LtizY8U?=
 =?us-ascii?Q?u7kOSvQOKJhlj1nTqNTFJEEG+nGxcvfcBXe9EjWTZNtJ1Ar2rt17hIxZNiMu?=
 =?us-ascii?Q?C/HQCdCHkgeOTTH0lkKgcHuv3J+aX+J51ySDHbijW7s64ZnrJ/kOTa4O0pbb?=
 =?us-ascii?Q?Vsrg4xLbzqIubqGcfGmGZsvEAD2zfYjToILHd47dkI1toc1GI9ESNltqm5Gl?=
 =?us-ascii?Q?cxQ+Iv0B+F6YurdqmwbIcOySgCCG8dAhxU56esnC7LSTNvCpx9KQuBxTCgaQ?=
 =?us-ascii?Q?7EGgd8XNjPevdaL3okuUnUx9mSCy7sKOgbYWG+3EuDncElcULTpyAfDMMX6k?=
 =?us-ascii?Q?VzIvY+hjyWGh775HSPnWOK263SraHlTJiDxeXFndBU1EDi5iLvqKyWVhBFqN?=
 =?us-ascii?Q?2BWQm+wEN0Oy4SwTmfb8Y891eJQ2jDCXDBm+nykwhYTh+7FKFWIVf/HwaRNM?=
 =?us-ascii?Q?9TCW/rbvBk+Ygqh+fbUq1YMnzjX2kw4BHZPn2KRD0GM2T8iNwidFaiRCien4?=
 =?us-ascii?Q?0l5XiZzFPEwfsc/5B30ERYjzaOQwON3xt4hh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GevbAJSZ7r+HhP9FCf7CNqHii7+vYWsWkoac5izfgGZtuMN1NHab+bkhDWF?=
 =?us-ascii?Q?lCXmtql24wYpI+fxm8ua/Xncpj1YkbmZA7g2DoAoCX/ceKOFLE1RZISTXlan?=
 =?us-ascii?Q?r2JSYE/MpH+wJoz2naSZ6T9mtlz96UmfheSxlP/1r5soKTuQfdwtDmVGeJ0q?=
 =?us-ascii?Q?gdBuEBCbrgEyWMr/npj6j/6srb5uV0F3Kcpdbfy9cMOJexK/fr6aRcMvy8p3?=
 =?us-ascii?Q?miHAI6horLjQAXYuJql1MLxmwHXFbpup2xV6KBVPcbUKHbPa4DmL4ven1CPA?=
 =?us-ascii?Q?GSuQalWoB7fOzhMJPUCmOoxW/++TeVgBxFIXH8iu5ZItMFbqFNNI3kZR1K+Y?=
 =?us-ascii?Q?WBKMHDbUmlkU13f+Ak3SiDVtUU5/McBuu3GYQwsG8J227MfQeYQ5GUwZHSwd?=
 =?us-ascii?Q?sRT+e2wxM80WKa7r6e7ws57RCFLg67j8CJWl3ZH24MUDfdqjYpNAhubsEvsJ?=
 =?us-ascii?Q?iu91LJe23UFGskXaJAUwU252+hpRjm+mbSI1+4a5+NyEn1DazC+W9A34Xg/h?=
 =?us-ascii?Q?Ls7JqbZ3M6yhSgbdLtGgc1gvRsM41GjCHti0X0oGe3oDSz5e2v/k9mPdaArM?=
 =?us-ascii?Q?g8RGaMtOI1J/j6qQGjZ5EtKZ/kA+8PEQEEC5oz/Tz4fevQirID8KeTCd+UnU?=
 =?us-ascii?Q?OC4J0V0CcLDpqub3SxQH94wytmnw8XkHQx1Qzl+SI+Wjb+LEMHulNFSJxbWP?=
 =?us-ascii?Q?ddjbCTvhOlKezOVbtMD8jcIvVWDN6XN7W7YBTRYcMphHDhvF/rqwti5Cx5Ce?=
 =?us-ascii?Q?E1XZ7Frin+FnsT0psBvFgiTQ/Hfi1Px2YRD51lCDbfRKNKGzQLBSwxvHuHC2?=
 =?us-ascii?Q?YvCz8OLuy68DJoXK+wPvcaXGiB7EILoSpM5WafGhQv8WWxx2IJ2RWEsdw9Us?=
 =?us-ascii?Q?xLR5Eop1Xn3TvB4OauMzw94Fc3fsfwY0MAlchl0srSiwhh0QjmYjOWZ4ZVO5?=
 =?us-ascii?Q?v1sny0aTqvQRFxAVP0G8ipwA6AvP5yavFixmjk47kW5vTgPTL2udN6N8qMw3?=
 =?us-ascii?Q?OPrW7va2EJmgkYEVWO/BGnaUX5xtitCVmCKI86QK3zq5aHzltHLVG6e71/Rn?=
 =?us-ascii?Q?LcUca1pR4s3tPvBqpw0Z2r/esu+oStfCZtfWk98B9irR7uYWTB3Z+SEmK9jB?=
 =?us-ascii?Q?ajFdi0bQscv/LimelRWw3WejbSxoF92bOxDDh5X/xEDJkDXL+sUXWInzXspv?=
 =?us-ascii?Q?VPnjFqnUfwK0SMN9OLq6wt45zHIrdrn0e1SXTssP+0nxkKB3t8Y2yxsJtgXV?=
 =?us-ascii?Q?MGfT2m+bWmkGVow9XHH9en4fETrm9/wYQDDEK/2QatnK4mgHnT8IPySL5tPv?=
 =?us-ascii?Q?iq+FNH9KlCngOVok/cTFNKn4D3rAtpnhEWyGVmXoq/pG4TEmteXhTBT+LxjA?=
 =?us-ascii?Q?dFaULYg+qLHZAG19IKViNykmsNYguWLm1SBlAGcTvr1+S5ZY2rOwhBhtItlM?=
 =?us-ascii?Q?pOmucTQ0ZGUbrdTEBqLicxh6Cfx7dUTx3JgYXC3K8AVLUvWBfuWvwyCbVTRS?=
 =?us-ascii?Q?vQS2fOCwKnF2epFWrxkky25fVEZkq9LAgQ1LfI/DQ/fjwxV3MyoEDqMTHCBI?=
 =?us-ascii?Q?06CHiTq3SrkG853yFvhnhHbnTsnyTNO0Txzz/Kjn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4706c1f4-dc07-4540-4869-08de11367839
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:44:37.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsEFvw0//OcEufyqPJHsSBqfH0SqALI8JpAfu9SnrAjelKBqV04nJ9v0eA4z+MHFvV2G9isUN//qD+rStgvTPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10763
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

Hi Kaustabh,
On Fri, Oct 17, 2025 at 08:54:08PM +0530, Kaustabh Chakraborty wrote:
>The current implementation polls for the DWMCI_CMD register, for the
>DWMCI_CMD_START bit to turn off, which indicates that the command has
>been completed. The problem with this approach is that it doesn't
>address the DWMCI_INTMSK_CDONE bit in the interrupt register,
>DWMCI_RINTSTS. As a result, subsequent commands result in timeout errors.

This patch looks good to me, but I need a few more details to understand:

Do you mean that DWMCI_INTMSK_CDONE must be cleared before sending
out next cmd?

Per my guess, DWMCI_CMD_START will be cleared when CMD done from
controller perspective, but the card may not return back response.
DWMCI_INTMSK_CDONE means response done. But if there is some commands
does not have response, will DWMCI_INTMSK_CDONE still be set?

Please help clarify.

Thanks,
Peng

>
>Re-implement the waiting logic by polling for said interrupt status bit
>and setting it low if raised.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>---
> drivers/mmc/dw_mmc.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
>index 130a5bb57f3cddc50b3cd0df2f40981de680e852..1aa992c352c3f11ccdd1c02745fa988646952261 100644
>--- a/drivers/mmc/dw_mmc.c
>+++ b/drivers/mmc/dw_mmc.c
>@@ -507,20 +507,21 @@ static int dwmci_control_clken(struct dwmci_host *host, bool on)
> {
> 	const u32 val = on ? DWMCI_CLKEN_ENABLE | DWMCI_CLKEN_LOW_PWR : 0;
> 	const u32 cmd_only_clk = DWMCI_CMD_PRV_DAT_WAIT | DWMCI_CMD_UPD_CLK;
>-	int timeout = 10000;
>-	u32 status;
>+	int i, timeout = 10000;
>+	u32 mask;
> 
> 	dwmci_writel(host, DWMCI_CLKENA, val);
> 
> 	/* Inform CIU */
> 	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_START | cmd_only_clk);
>-	do {
>-		status = dwmci_readl(host, DWMCI_CMD);
>-		if (timeout-- < 0) {
>-			debug("%s: Timeout!\n", __func__);
>-			return -ETIMEDOUT;
>+
>+	for (i = 0; i < timeout; i++) {
>+		mask = dwmci_readl(host, DWMCI_RINTSTS);
>+		if (mask & DWMCI_INTMSK_CDONE) {
>+			dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_CDONE);
>+			break;
> 		}
>-	} while (status & DWMCI_CMD_START);
>+	}
> 
> 	return 0;
> }
>
>-- 
>2.51.0
>
