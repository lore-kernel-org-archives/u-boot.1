Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B963CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2C083D5D;
	Tue, 18 Nov 2025 09:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HBZkueaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F73A83B99; Tue, 18 Nov 2025 06:00:59 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FCC83B8B
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tH8JZIjr9lXeAh6JIjVeZ56O6gLHxwT/unuiGR/7IfefcWUcnDAE0cwWktlRomNVQT/0L3Pd3VmGnN0Z9sfXA4NiqiHf5M1krurDBLnMirFn8ukflmlRnU5WaDSpN9EfS5YMpmt2Y/zLjdoBtZ3jHMHOsxzk6q5ISv6E9dCbG0WaCyZTaijlzctlXfUnumWAvz4q8j2tCB6hiyxrqz/OoPHXLLqisrZ5aIFaPdc2bWTL71EZHGfEYeqAbo21K2vGwO4nDphHQbumZjM3FrtBkrGoBVOZnFyjKJPwxHpHEPswP36fhU6AYwUUn2o1BBc9OxDJQGPDNOAzIhXPsaH0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI9WQfYJ3K/5521rV9JxGyRvCpZAGi1EAAva6gh+1w8=;
 b=BxCbeTUMf/NDoN6JidwoEXmRIGVxyO7+2UiU2UtEjeU/XXLmhK+B6z2SWynFo7jNzDAuV8kEANI8g7sC0DS/PlNQSvUjLaej+r+15e2qBSlUwwWUbaAVBqE6ZJtAfhWw5erKzZebkvFTzwDk6xiAvWI4Ofh/MmRHWnmgSnpqgN6sTkEcl7VsYBpbsZd7RwG0NkbPeLns5WR9ZYjjYlHxNVon9qox7YkGPGudV5hHe2q/7cuIueAk3IzGbx9tppf7Kxf4JRkfDzB6SbGIWCV/15EfHDL8dF8DpGaemsmZpeXhI8Of/7tkHfWRrgF1daz4+XDIuBmgdUapsSVjaBFS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI9WQfYJ3K/5521rV9JxGyRvCpZAGi1EAAva6gh+1w8=;
 b=HBZkueaPUdGlOzi0Fp2LMwBU+YTj7/6VsrPQVQWDRHa6VDMoj/vk48sQD3UaukMD8Sd0ShwIptEqPjreMSzN0bknbyDm6oOvunvU4M2z2xNjYUYrCARB4H0d+8qvpVggsefSqIFOhvcut25O0qRIXOh9KGfqyuH8qGYf0d/h8RyxIXTLcy7fleLkyUcws7por5D9AfZsMy03Sk4VRhyjMebFnOjGf6zC1xi5sAIJtuFKumWq0jdidHznuN0t67cj49EPlyMjASi7qHR65R0zgqN///fIDTbb0t0oWj8ddhAWfmt+/082nVG9W34aRa4uvGTurZpStRq5aCGnXlIesQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9704.eurprd04.prod.outlook.com (2603:10a6:10:303::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 05:00:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 05:00:54 +0000
Date: Tue, 18 Nov 2025 14:13:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH 2/8] mmc: sdhci-cadence: Use max-frequency property from
 device tree
Message-ID: <aRwOmpXU5__RLICN@nxa18884-linux>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-3-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110173737.24545-3-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d98afa-f5bb-43d2-99e6-08de265f7409
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zvlp5auVFzp/MAQDBV1ppPn/RKZPfakgEeKjmw19adikNFARFG3hl/P+hiHt?=
 =?us-ascii?Q?kvp6p20qrcdt1dzcSmVnKF5gIwenLIPN1EnPrD3P88Matf1GRRSyukqfKgQn?=
 =?us-ascii?Q?dsVGgCeWUWTcdPztw9PodmEiViPpXgCkkdow0UlLKEaHBIJc8wrAyg/6Ecdx?=
 =?us-ascii?Q?07UtO7SREHyzLCl69kvjtfytqddgzd0T1bTAGZGwlv4vAKBfen8MXRl5X3ys?=
 =?us-ascii?Q?2xEdB/UiuFOj1J67u3ko+NURQALBIuh8xVpNflZADeC67fMuCmxcIsFsqBq0?=
 =?us-ascii?Q?MyjuYjmZwieZugvYsBkrT25fmifzfFV+hMWqkcfSw7S50m79ZGt5o6Pc6HB8?=
 =?us-ascii?Q?Gqnc4621VBHfoAmZT4eiZgbCufyjiU9ItBLfmT13+D4A8EDWWLA2qXmqKOl4?=
 =?us-ascii?Q?78xeKn+CkPVBnEJyzTdiELoIrxC8RVJDDPVkMEapbZuxlnJwCZBPD1ApNiAp?=
 =?us-ascii?Q?1VQJloYQx/SybN7quJ31ez38aNnWdZJgzlUl2uNLzGOX0lGc4V0N81eh2xul?=
 =?us-ascii?Q?vCsRj4m+eQvSp/pg9MqIc5bNysMRrLK/GGEh+qPxmzdnmPR3NnCjN/zszr+8?=
 =?us-ascii?Q?nGCCpu9Xwb276x5y7XHEVPjae0H0B5v1StLocZNUh//qtXqDQQULeKOddMfe?=
 =?us-ascii?Q?EKsIkRs54y+8FMke2m+bqXYdake7HBw3RlRRMTgr5877TAYadvCNcng0et/V?=
 =?us-ascii?Q?2YLqAZxEyuF7jg8RfcHgZHoYu9nlpk1l0leXVjOLH/avvVqzmTHqTFdbD1K/?=
 =?us-ascii?Q?Q8zZob2ax8KLDHBq5Ui8QGPb/Ls0EQ/yZUcTi/MA9A6mEidwXpQGTbZzM8cR?=
 =?us-ascii?Q?xlmfR8sirn2E6wCDY9qz5e9FhEYWRQDLEBIE7yf6Kt6kycDw+FbNbBGqRKCN?=
 =?us-ascii?Q?Q3qnMtnTfKYeMQRlB6hm05HX7gB330yL9Fk7jpe1WqrVq56I4G5pe6IDJhwa?=
 =?us-ascii?Q?Wd7rTJTB5HN0N/Wh85uYkP2alIIjtg+kUS9T2NoLY8ZOu3VVgh+78GYM7CWe?=
 =?us-ascii?Q?zCDUBwZPGVjzNqBa9+DE3fPDrQ1LXxIgE4uYX/R1HmvyJ1pb1sjlA10E1NcO?=
 =?us-ascii?Q?uOBQKFpeVwjs3Jz/oYWO2VyDekJGEcVQzUJ4k1E9AYEZyfAqNk0uMjUT6HaL?=
 =?us-ascii?Q?9JPA6vcLMN/9OT1T4y5qZpLImejGlIOiOCwgZK9ccvT3FPuxeJHRc2hFl00V?=
 =?us-ascii?Q?8W6zrd3dcQIkZAZ7Z6pM4FwiNIS3APYT7u09tpLkeLJwfEx3GLFRqI4Qhs85?=
 =?us-ascii?Q?unfV9eGFsfBqOEhAv6klm5EPTfpNxOSpLG0o0W6YQzLMNMNkUiUjIHjEMpdZ?=
 =?us-ascii?Q?jzrjQPcMK0CsWBZh9n5O8cpCSivq+1HSL2vUtrPsXO/ehxC8X3AvjFbRi9zu?=
 =?us-ascii?Q?CAr5Aqu/eLnj7X+wdXDz9VGcuHILiKuDuf0Q/ZF92w4tc3TqcAwvRIXEOMhv?=
 =?us-ascii?Q?GiV5Ebw6UND4ALLr0pnNw+lIpFuwGQnFZ59gbOCa0mg4lEmv66I4lg3Oc+Qh?=
 =?us-ascii?Q?vyEfUOnNkCtJ8GJkSPvO24M6sm/49CD4bs69?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C40maE4mBKhcHHev4j7hsTjc/qbTl9PlzADtrEADKFYromIk0R40KMkKY5J1?=
 =?us-ascii?Q?VM4u+hVKIvUVFCu/JOM6FfRZKvVB7zGgeJgrVgM76pzu2VfDigrAu1iASGMW?=
 =?us-ascii?Q?3bWNeX71IHIA42bnM+aaOV52jc4OPdjQc6j3aERNTSMbVNdYratrFOetJ1HE?=
 =?us-ascii?Q?nBVMFKYxQyUbDOK7zXwRYYynei8O2PtDMvGoierqVOOaSWcKOkiFwpnb5vsP?=
 =?us-ascii?Q?vM+Nm6gAHGAsm57cCxELZ203zBmemZvPJDmpQmrvi63yDv244Ze5GwktQgTL?=
 =?us-ascii?Q?UYCejfEBzvBUtXxpqYm6TXWqR/jOHrOuU8epF+P40gLVpxgyRgwMMXJ34WJl?=
 =?us-ascii?Q?J8eyi88J9/Rqh6+HO8xThwcMugzID6jmXacDW+Q8vyE/RgYyjzo8Zm0hVsV+?=
 =?us-ascii?Q?dH6haiuyvzuD85g2JWj4fqrvXei93YzHbim2pQW1DVRd+TCthYferAWC2MSa?=
 =?us-ascii?Q?4vLwpLCZJGtv9+F21wziQ9BOnSSRCCyNnHLGp2JQPdTnGI5Kg5CzJRqWDe51?=
 =?us-ascii?Q?RTTy0h71pGeVR//zplzbZ9MrmbNW0wd4L0Z3yHMQrWb/7ljAVcJ9oVm2w9IB?=
 =?us-ascii?Q?iVzw/sHw8evJN6z2cgbYPI/+87z+9d4/EbDAh0cgEx2+WJH2LG8AlwFeNMiC?=
 =?us-ascii?Q?Y36z5nnz9uODs1w2+W9BYR/TQfuzFZgbkst7ruxF4BhU3dI0Hbwvav6cq+lf?=
 =?us-ascii?Q?2YStfoa8dtxOWkFxACJg+gz3vd+GLYUKuWeQNV5sP4R5gXA5JUw1/4Os9iiW?=
 =?us-ascii?Q?Um6iB1TdTgCmuk9CHlRU6xWrMGwf+dcJ+F6uZ9uW9iq7LbwRPyEDlpj8fZMN?=
 =?us-ascii?Q?QQlQqDzvdNRaNFDlboyptB4/Pa8h+zNb/jJy3gMiysBvMZEupGhArObwGjP3?=
 =?us-ascii?Q?6Hhv6iYikPO3icr4/SHy3Qn5+i6h/jmLeVyA2Qo5ByebJsgf1gkfBBFCA5oc?=
 =?us-ascii?Q?qkbg1N+6w9J5ls2BNIyyGJVIzi1Z3sGYcf1CG4Sa6q58Olbkk9jKDwwhTnhc?=
 =?us-ascii?Q?mwefWk/1rqtZyG4y2wUpXDrLYHMj3UPi5tWoPxRoHVRbFlnLuqY634udAaOz?=
 =?us-ascii?Q?BHI9NhCVpAz+owyv+g0Cf2pP1fuqGDD2EErLb7pwtZpdrYMr1XV3vqaequvs?=
 =?us-ascii?Q?Kgr/pu4Hj4Ne0zC7NPo/WFZKOcArJTFSA1p7S1ot/2ZBIvCPYnGRG47Z8EGE?=
 =?us-ascii?Q?Lln3KewTCvQxhR35WQkOJ0PWT8xv7Wocysgvtu5dqa5mTbvAezjZ/BzbJANo?=
 =?us-ascii?Q?1B7DwVzfpR6rgquKlAmlX9J1OBSC0MextwPIu8bwwnXPcsCBfkZmiJluiZjH?=
 =?us-ascii?Q?gHosrCIU1LPXQrhsfU0aCUnElAI4g937GJjGjdzu0MElBtXw3GhIYQcq7YyG?=
 =?us-ascii?Q?83Uv9uH9JcaITF/TbdD2iZsZGHj2BoBw2JTHsxLeUe8jmxtM7AKKzevN5jWu?=
 =?us-ascii?Q?UdNwLub3abJvMq2HzlkN5QbHW02Ijc8+SEt4lUTqKSCI17G6hZ7msQ7n3txp?=
 =?us-ascii?Q?HlzLbI3KCHZmT3SpQ1EhwNP1wNadomnSS9Gka7re4VYdZ9ywORaHRU6uWUb/?=
 =?us-ascii?Q?zUaZ1bmxdh3BuBH0VxJZYTN6XH6QfvBIzEmX0/Ig?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d98afa-f5bb-43d2-99e6-08de265f7409
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 05:00:54.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKrpvk0DX8LiYPSp6sohCl+b4Jripfr06C3+TqnBXHiI0f/5uST+anzk7c4AvIs45zmNBzIGw/muKxkNOcZwgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9704
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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

On Mon, Nov 10, 2025 at 09:37:31AM -0800, Tanmay Kathpalia wrote:
>When f_max parameter is 0 in sdhci_setup_cfg(), the function defaults
>to using the maximum frequency from host controller capabilities register
>instead of the max-frequency property parsed from device tree.
>
>The max-frequency property from device tree is parsed by mmc_of_parse()
>and stored in plat->cfg.f_max, but sdhci_setup_cfg() was being called
>with f_max=0, causing it to ignore the device tree value and use the
>host capabilities register value instead.
>
>Fix this by passing plat->cfg.f_max to sdhci_setup_cfg() to ensure
>the device tree specified maximum frequency is respected over the
>hardware default.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>---
> drivers/mmc/sdhci-cadence.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
>index d9fda902076..f31437e5eeb 100644
>--- a/drivers/mmc/sdhci-cadence.c
>+++ b/drivers/mmc/sdhci-cadence.c
>@@ -255,7 +255,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
> 
> 	host->mmc = &plat->mmc;
> 	host->mmc->dev = dev;
>-	ret = sdhci_setup_cfg(&plat->cfg, host, 0, 0);
>+	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max, 0);

plat is allocated by setting plat_auto in U_BOOT_DRIVER, but it is not
zeroed. So f_max maybe a random value if max frequency is not set in
device tree. You need clear it before mmc_of_parse or
change to use dev_read_u32_default for parsing max frequency in mmc_of_parse.

Regards
Peng

> 	if (ret)
> 		return ret;
> 
>-- 
>2.43.7
>
>
