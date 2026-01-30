Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342EED73EB7
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 03:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A186A8418A;
	Fri, 30 Jan 2026 04:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FG4DqbZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FC6841CF; Fri, 30 Jan 2026 04:50:29 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD2408413A
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 04:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0FZkEMs2BQvTRWEU50K7nn69zzoUahj/ueTfmrpiyJARwNRmT0AfzJ8wIeJzZ3yqxVxkYf8DikvJF4ZXm0BDsL7dY/z0MMXUppAxatTBLCznLpUEHa4asTQ29kn0a//VZ1++T/q1lsMtSbkmpZjrzHA4SzPna10n7NvbwMd3UUTnzg7vP2uZzHL1Bodu13ryXu6H2XPRrP2SeebrTbPtLZLuPGm2K/QQ2skgKOX9ZVRu4yJOlNQp+E1XvYfFGxfMrdS13js99hGQ829J1l/mj+kdu0a6GN5z1E7qfIhq/ZrkHubOoxAVzGrC0qauXJ4Leo9wke4guwttmuc8AxtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du/zvAI5as4W0tzHU7p4ACSJQmSqNmsc8Rx0Zn8ZzOU=;
 b=yQ1zlclfYr0sMbDvvRN4JbJS4ntPnqtlPkYVbOXimE1gHj723ubyJa253Jges12XzaWEl2r4p79Y96ytb5HQf7BlhmPoEM3xo0fNZSwX0Nun9qQQTf9jkLbJahPp/qgrcG4sZpKO4BeBLbb/BJBrsp/vYs23NmjwRN9SrU+at+fAKmrfo7DnDqTF5EjhFqaC2MDX1QfGdzL+UlkbNCdIF6OdF55iiCFV6AbDoCY9EZ+/35qwiuX6gTbAoynvE3Fd1fiavWaNKHR5PqhZ/SQNTancORSW4P3+fZB3B1WZSLTQ5D3Oil9AA58IhYI+1lxAgilRIzuYcmypqPikeyjKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du/zvAI5as4W0tzHU7p4ACSJQmSqNmsc8Rx0Zn8ZzOU=;
 b=FG4DqbZHOovkoNxdgYvvlWPPB55BFAOJRxkc/zZrAKbGAJ8WAu4A1bgv6IqVw81hA9QtyPzaME9Qogpy80c9ikZ+w6JiAImZmhBfA0Ys+kagYvIUyp74xR0XPd+Sub7FIXo5m+oTGmBQbefbaFUCJx8Pa5JDBAo5IgZCZCd1iFE3GXBKSbUugO5J9G5anzcDqiADbscm9fvtOhpa/4+xRRCFXWvFL110Apxz5fBLW7iYJFhP4KTzpuurQqs2tViSxpDlgRczlmN9RMRqSvy3su74l2pCCplTa0c/zcLaR88hJN3YIRPQk/B+8qTwpm3TN8nPhWr9POJ/HOUZfs/Jbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 03:50:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 03:50:22 +0000
Date: Fri, 30 Jan 2026 11:50:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Gregory B." <gregory.b.dev@gmail.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com
Subject: Re: eMMC standard update JESD84-B51B
Message-ID: <aXwqgfEdeGuu4KUl@shlinux89>
References: <CA+ZXaAbay3Se5+ZorL6HRHzp-vYXD4Hk_n_NqHZNOMhk-o8M8A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ZXaAbay3Se5+ZorL6HRHzp-vYXD4Hk_n_NqHZNOMhk-o8M8A@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: b6062b95-7fab-488c-a013-08de5fb2b1de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UB9xcQqH6OU8hRfIPhSmrEIMrOq6l3+iFphDFTljbpcCD7x7cFeVWGnNpf4p?=
 =?us-ascii?Q?g8IynMStCR99Z4RWazefL0+MC17DLqwWX/9IKS5j8ux2jxzIx25zaTIMw8ms?=
 =?us-ascii?Q?57OqEKXd2HyJgOHTHKuIW8alOPekpBtNxMmmRQHhPIbWNBSEqD1rKWEDuytf?=
 =?us-ascii?Q?3szTIGLtIR/7oNO0xT7qrgw+8AzlXxTzbHgttai0Ytduom3FxyFz9rAcCxjC?=
 =?us-ascii?Q?8Q2uJuF9vCJCWVsuN+7Lzg9o0znP0zACBTGpK5xUdCaJe/6xRC2u2paiYIvU?=
 =?us-ascii?Q?nh8vkkh7fEQORTpvzh9pTsCxi0gLcOFC9fhIxSFLcsXozsWPULAwek6N+t7g?=
 =?us-ascii?Q?Jpis2MqiMNSaPB9d0zwcFprIlAaIhvoSWPR4R+7B1JzXxTLd1JusTnijCAyi?=
 =?us-ascii?Q?8IhvUtWAyyG15+fXU587wtLuipq4m5Ozx8lpU12Csa5TSQZFoDXN9DB7eD5G?=
 =?us-ascii?Q?azLrORbn37JCnZKR0DJZ2a26KDniffmIRBxuEAjYKasJzwMrvOPEwn2XF8yT?=
 =?us-ascii?Q?CuD6bzEn9S4Urhi4wABrA6PD8hQQL7g8srN4Jd2dzCeXnoEwnUzuCgY9erj6?=
 =?us-ascii?Q?6Eby8+ibcUHTPkkYQz51B8Eed8U6kUpC8SMmeJ8C0aRAvREvoq4pOrsWjzy3?=
 =?us-ascii?Q?a0c6/KstxcoQymOjJvOgKVlIVFeYl0qZF5gbz1rij0JDcqE68Z3F20jhXZJ/?=
 =?us-ascii?Q?QnJQ5gUN93L8GF6foFCDCiryn5u5iTzl6S42Tbd7oUGRH7OGNcINNkG2Vb00?=
 =?us-ascii?Q?l0oSJAE2zUYg5o7ZpvQsNo7fQc1lAeNFbdoR6i1zuNNP1FjDyVMf+6PoQawA?=
 =?us-ascii?Q?rxAoJgZpLKvjIRPfaaZs+fA0YKjHpFQv9wLh8rCe6nSsWFCAz0cDchOvsBGm?=
 =?us-ascii?Q?+xAmrpyF/wUwyewQpy41dpuNZhlL+lPNfE3QjYoBa+tt3GOsUqvWyyZLpCHi?=
 =?us-ascii?Q?8qI41Pfzuk9YnDTmm9BKadT4YZ/p8jAhcFYvT0bCULIaztJFaiDBb5lGsEMa?=
 =?us-ascii?Q?KemsFmzuWLoV2ubzC2FgoPj3h0maTobCrKlh8LzXg+sSXzScoVQSSoHqopOb?=
 =?us-ascii?Q?nX4oq2m8eTouDjX3jnS4MsPSR64BPTP3GMPUWBbXeUhxbqIxb3wEL8iYsjiv?=
 =?us-ascii?Q?GMi37RxGy415sHRbNum0M9LShPOT14SsidV/9aqz9AlFbSt5EYEBOgNo8136?=
 =?us-ascii?Q?DeZLm8DCdQ9eKPo42VklsO26f4tNtciog0pWjLXLjT25kEX+EQ75zqjrh9a+?=
 =?us-ascii?Q?PgVDvhgO9J/YSGHcAIq6YsBYUclBkkDhmc0pjTakmOfEgHppB6CHe017/RZz?=
 =?us-ascii?Q?2PGaDHt1cohQ2RuS2hC4Y98IGc0qFP7aw5zdztNmPPY4ybR92LvAmB5nbpWd?=
 =?us-ascii?Q?U7RQQv8RE+dpjU9yZyLBRVNF8b2ySOsHR7a7dnRkRjzVwsXtgYoSXVfA5Jcu?=
 =?us-ascii?Q?wNOvOAAXAcMNs6U2oV4DNZh9bOPOb1XHbqGp+US/vjGigBLaNVs92lUNSz/q?=
 =?us-ascii?Q?ADZke6QnXizYChk0CL6bq5pHvrrgzEmvY27KeX9bK4PfTyqFP+xTuz0rzp7T?=
 =?us-ascii?Q?M/ttF4wTwSGK++XwenkwsI2vfVCFbSOwjs1u1AbO3yh8Ln9fpwxv0Yaj+qlc?=
 =?us-ascii?Q?5b2pohIVZBMxTSPXBRWSySE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OAx5cOQ2o/n9LMODVPOFolfTUQ+80jvz5bjQ5yDmjgozbD5/Ukva6cLS3Fij?=
 =?us-ascii?Q?UFIVRr9fKwONOEIeswmxGw/GSED/zFcwHNQF4EoEo08FVkaWzR4hzLb/TD3V?=
 =?us-ascii?Q?x502B5CDKwUhfClcKzLQdR5YNL+ASbqPQo1c3+FwWfeXablipVh0eSou1SNf?=
 =?us-ascii?Q?txZp+8LnG8Dcuo/zqECqq8Af5of7Ad4cWT8hRg5GKl+n6kWhrILBXC3c+bzc?=
 =?us-ascii?Q?21MjKqVEj7cnTR+wlUGbnc0ioIdtgpX1M97OKXXhG51hpsPNculV46FfDu/k?=
 =?us-ascii?Q?62EQmcJpT+94b9vv1aI9/VwBLEUFiHbT+f64S4l7q5B24/096zKZH1PI/HY2?=
 =?us-ascii?Q?Hs7RbgLxJheC+qRcOnQLkq9Rh1fpH3ZC2THZcYvnpbSG5F3oxgHbGR8BSjCf?=
 =?us-ascii?Q?d76htkW4CoGg8SneCLMNrKryoVLdLXJwFbY2RtIbvb3G+wP29nF9CDvqiQsH?=
 =?us-ascii?Q?CJJxG7KqrgH5JH8iIiyLZJErhAu24baKkCzyy3l77EMjDZYjDo19R9o3Rwlz?=
 =?us-ascii?Q?F6NwDfyLpLWtwV6NEklJLy/W3T2VDAej2UpgFGL9FzXC1GmhN2rpMtZU7cnD?=
 =?us-ascii?Q?jr48OJcvbtnDTch0I1YXGOlHS0lJcocKelJcQpRo2st8Jcb41rQhcVimPSPd?=
 =?us-ascii?Q?QUuXGuh2C3v9kZpfjLsc2lQPMoXXHglwcHG8zg/C4w0Hur/k4B+vC7clXFa3?=
 =?us-ascii?Q?mBwxFW4y3AfiJO+OipS202X28TBMmjUUXjnjarrV+iYvM12QKtg4JKReWufK?=
 =?us-ascii?Q?bRBCWPZb4xnm5hLHQRGfPH/tCavCMMOmG1hdTHt4+hy3lIgIxeEYUXAPBEhF?=
 =?us-ascii?Q?N27m7suNTSbLVOQkHkfLbJGbsHb9UVLmi06Ng4JsJ+nkXZLZ3OMNhiMLhTsU?=
 =?us-ascii?Q?cM6G86VvKaATBvyACQt0TA/l/H+HLn1ye0tb9vIJGkwTmAbdKxs2SvEog/s+?=
 =?us-ascii?Q?5mwMY2VZD+27Sf61LvNpZKuHvXG89Eak+kO9I/RkJQijWcdmikyRVLwAoBbi?=
 =?us-ascii?Q?hd6MPbQhpUmAIFycik9O46/H7Zw0t4ip4vf1EEXJH4v816F90TTvS0SUOOCV?=
 =?us-ascii?Q?B8/xoBV2mavNslG+UnQZknYjNsPiaKHP2mLtP87gDuxbtygVtixuAwgSi4O+?=
 =?us-ascii?Q?OCMYg9vg4IFuUK8rcAaDFr0t20XQJHpn9oYoO6qSHa3ZlpT1L2bhcYQ3iKAs?=
 =?us-ascii?Q?Q84/mTYAaj6sGB7yOklWWKmvS/ZpN1VftVP2HccQbpGpQjjw+oZ9YDFfkd7H?=
 =?us-ascii?Q?HsJXSVT+QjWyviOrrYYlCFFpUJduF5A3GP9+Fb0AC7u6gKzQ31hvgAYk6Wxa?=
 =?us-ascii?Q?XycUZuy5iRFQ1GYi0+8irvrdjv1n4WDsf6DVBNslQbDadGcw4IKXTncl/J8l?=
 =?us-ascii?Q?jBIHz2WQaW0nPVlMiS8MxS2HvhFtLI9gVBtAA12K0fy5M60E/WVYXG4lV/OI?=
 =?us-ascii?Q?diP0cSh6+4FDFp/h/Fe5U6WTgSktHWnFHT636woJtBArbmJ6x5ArMpGyomYx?=
 =?us-ascii?Q?vKSl5SegnYyb3EpRxkkDUqvme6XlMeTPh/PK0bhLzA2JOnkrraiYV9GZxuaR?=
 =?us-ascii?Q?yl3JVrPkWhBFg2vieLlteo1u8fSoKkZlh/UorJeewD7gZOmFGKpmiurnOAkn?=
 =?us-ascii?Q?BsDEnDEnYmjIkzhW5AWUG/wb/vnsGPxzZ1hbLZj2s1qzKLJamNaiRmHsAPgL?=
 =?us-ascii?Q?uU1iU/IyA19tiXyJetCnUF+gA0kq1pV2RHkiFkgLJkT6vSGBtPits7+kbgyo?=
 =?us-ascii?Q?vpr/9VXy1g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6062b95-7fab-488c-a013-08de5fb2b1de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 03:50:22.7525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQmbMi2TzCl7yaQBVCCR7+FnSOS62Qp7haAl57Ru57nXB3xHX0eOO0QOa5cbZ14hy8i9Eww23nX8CVLSmdE/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

Hi Gregory,

On Wed, Jan 28, 2026 at 09:42:35AM +0100, Gregory B. wrote:
> Hi,
>
>There was a recent change of the eMMC standard at JEDEC. The latest version
>is now JESD84-B51B.
>The CSD_REV has moved to value 9.
>The update of the standard is essentially to redefined the manufacturing
>date field in order to be able to encode year 2026 up to 2038.
>More information can be found in the commits of Linux Kernel and mmc-utils
>reference below.
>
>A couple of patches are now being released in Kernel:
>
>   -
>   https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=bf60037e32e963f8053c3372c438ba272b7c30c0
>   -
>   https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=b40ebb75b7461c69ee4da1e49cc2fed309a96349
>
>
>mmc-utils is also being updated:
>https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
>
>I was wondering whether a similar update on the uboot code might be needed,
>and I haven't seen any patch or ongoing discussion on the uboot side.

Thanks for the heads up, I will give a look. If you already started to
work on this, patches are welcomed.

Thanks
Peng

>
>Best regards,
>Gregory Baudet
