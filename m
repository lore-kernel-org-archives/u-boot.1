Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77555C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E68181298;
	Fri, 28 Feb 2025 11:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OOIrh26O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98717812C8; Fri, 28 Feb 2025 11:55:47 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D9281298
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmv6u0Z3XrWX88RigMPDw86Pf82aNBI66jHhbnG734mcnF/oYiQCNvuXaTY5tle50Akf2BbodHdeHyVqz0DJHo4TnXn9v/FpxyfLIyHcuOgU8mPTP+GOp/gOwZzxSKcy89ipbxpW4ApI7uOI1px4zGcOEIgdI3ZLeDS5A7DCDgc/p1kU1zzBhGuZt8XpwOl6CrWo4iYVTQrgPt76Bup8xkekEZwrEEtJcBeD46kJ5L8P3GrFgD5QJFlLt+uDXjaBhvQXO2hjSZokSYvD8vh47O/v6Nb56qI3dO5dGyBbdDn8TN9XnPSwbUJi1u6BhKzl9cmSLil9fWAm6qmsYMURCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4lWJ7dvEATJESzuWZXPaxq+vC9sNi8pdJ6k9zQkKsw=;
 b=lztl5wWIcjCTAdR1cDuKCBbKsAWPwtN+5ruVEdi2cwz4+qZwazk/It/jCl3/wg3lLn45V5Y1n6TbQooQa0ZEM7LU5Xzr1u/kJPcjae9ob1pu9oMejV+d86Rl/vf6T/2eTXJL7TgeK6yvZT722tsJZRGfi129BQNp0Thum4W5pyW3PN4hftdkQr2mPvvIgZdNlke2bVs88IyRg5MuUkxW1WalzPJ9dy5Yxl2OSpYb6NRdu04ihqaGZJ8OCC7gIOe8dXi1nsFLCiqtBANyuw6zVnIEbEX8l6pVUjEE4tKykJXjfL1eKW9lsQo3UBzgVruzW+3LiF1yU23ZGJII7Bwopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4lWJ7dvEATJESzuWZXPaxq+vC9sNi8pdJ6k9zQkKsw=;
 b=OOIrh26OoeMzLUlgpSgTQQx16j+K8Jbgw2MS+9/e9XtFlm1BW+iBGesxOR893srTg/tpKAZwuW07EJbgwrEmAY7BX5yGtwJsL6zL2ehFgVeZT+dBqxHy/D0EFkEM1UfnFbxOhBAzaFgU52QRol9ylepXZgz3F8gaFi+x47yzkl/XHN+g2P4dvUKUqNiLLfvlMNgLmqCXDeE4YCMAut8l/ZeIEeGxEZTHl/fHw7RoVA/4qGJeVZ/OV8Yz0Rp4ZOud6i8hXxVmF9prKnrO0zovc1KrqX2Spl0GMLdSlS3+fP9v/aTJrp8F2SgOGkDVM54pfbzFJstaY9GGj7o4le3uLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:44 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:08 +0800
Subject: [PATCH v6 17/20] imx: add V2X container support on i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-17-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Teo Hall <teo.hall@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1ec255-ed23-4b24-006e-08dd57e6730d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azNvRjd2amJaT3VaSURwUlRTelR0bGlDN1dkaHU1MXZFd3hCQWJIa04yeDNY?=
 =?utf-8?B?NzlXYSswV1M0NmVVQnA2a3Vod3gzY2VicTY2ellhMjVmZlJTUFlHeE9ZNmlt?=
 =?utf-8?B?ZVFlR01tcHZ2TTlJdEM0NUdJbDJlc3Rkd1V2RHM3V3hKQlNrTVd2ak5sTkYv?=
 =?utf-8?B?Vi96Ui9VMDNSTm11TUJGSEhQN3VQd0xJb3k3Rjk1VWRFN1BCclNEMVFlTjVx?=
 =?utf-8?B?bnA3QVBVSzYzSllNVG9hcUdKTEQrWnI2K2swMnVhWUJPMTU2d1lQQ1JpVE5F?=
 =?utf-8?B?SW56MjFNK0JXNDZYS05ST0JEa21aSDF6NmRLNVJzVW45aFczUTJjL1VsVEU5?=
 =?utf-8?B?VzN6T245YnBDU09LVlJnUG1tVDZRelNMZnVESTNwYW1MbzNYNkZnT1Rtd3Fu?=
 =?utf-8?B?THp4UXhKdzVteStiUVBmU3Y5RFlscGhncDhrL0wveGc5a01BY3FJRW45Unk0?=
 =?utf-8?B?UkUwdk4ydGlyL2pzZ1hCQWZyRlFzVjVwSWtlRWVKQ2lXZlAraDRuYUtJSkFq?=
 =?utf-8?B?YlkxMGQyczBNU0J1bVppcEo2QXR4Q29ZKzgwbi9QdDhVVWgzWUR0ay8zYVFt?=
 =?utf-8?B?WGVkMmZOSUVHNjA3dS9meDc0VnpyZXZ2UzQ1OTBManNiMXBGaEY0MmhLWHBm?=
 =?utf-8?B?bGx1MFYvdk1Va2JoN0NZc3NLdjlKRllOc05zVmZMOVRXYjdOS1hNelRES2VR?=
 =?utf-8?B?ekRORUVLOW1oZUJvNmREOG13MUlQU0p0eUtxZjBmWWNrRS9oU2FZd08xR2lx?=
 =?utf-8?B?V3J3LzUxZmluT0Y0eW9GWnVhbUJvVTJFTmlDY2VJVzJiKzZnak1hSDEvZURq?=
 =?utf-8?B?dWFYRW9FYkhlZXFGQ0czZlg3OFozOUFYQ1ZpZy94eHlOTjRCSHZzWmVjdWZ2?=
 =?utf-8?B?cTFBbU9pVFdBS21OM0ZSRUR2SzR4V1IrbzZheUwydmx2MmtQZ2pPMmV1dXZ3?=
 =?utf-8?B?Z0hOVjB3ZDdmNDFZbjlRb3FCdTNLZkZIRWpVOWRSYUswN3JmSDZhRGh4ZnNS?=
 =?utf-8?B?V1JsTUJxVHV6VHNsRDU4eis2OVZBWTcwZDBIWCtuK2ZPNHRURmFZTFBESnpx?=
 =?utf-8?B?aDJFVmRhbnVqaDh2TTRDUDRSbzRHYTh3K21SOTlobjBSbm9WSkI0K01nR0kr?=
 =?utf-8?B?ZVZxV3dYUXlLTjhueXR0VDZqYjEzejJVTzZiRlM3RlJzUGMwY1Nta1B4VStj?=
 =?utf-8?B?MGZVeEp1TTNFZGxiVmR0UllpUzMwR2psZmJXdlYxM1F5VkZVNjdVS3NvSjNO?=
 =?utf-8?B?Y2RKbFozWk5jZGdYTGlicmpJbklnZi9mNThCYXk5K2ZRMk9XdWpnRWdSczlF?=
 =?utf-8?B?bHpWQ1dzU3NsSDY0OUM5V2ZHZDdDbFQram9BTE5IN2hRTVl5THlEYUphWlNx?=
 =?utf-8?B?VEFUWVlsL1RMbnV3RnY0ajBDRlVjMmd4UUFMWE9rWm1mUzM1MVlpZFNjdGVR?=
 =?utf-8?B?SFptTHVkRWFzWDF4QkwvK3JZcjUvM3JIT0xBTnIxTkpuQ3dsZWRpWGEzeVV4?=
 =?utf-8?B?OFgyczdoVTlWdys3dTVJTWhIUDZtK2tESFQ5SEV2TEEzNVdWckZ6aTdQZXhG?=
 =?utf-8?B?bko2SitNUERDZFpUREVYZzFOa3FqTk01WTEzdk1NeDNlME53T29tZFhIQ3Ix?=
 =?utf-8?B?a1FEelVEdXlYZjIrQUYzT0RkNGJjTllTcGZ4NG5FL0Fha0c2dUttVUtRVFNw?=
 =?utf-8?B?MEdYYnBnL0h4dUZEcTRzMnNrakdnbGxHempERXpwWkxNeUYzQWxZNTV2TGNW?=
 =?utf-8?B?b242UEFSSmpqNDIyRUlNMXJ5MjR4UURCNTVGZXhoR2NSS09iVkhlSkJNT3Jo?=
 =?utf-8?B?SXFZTUJVTVZlM2FlNldkb0xSWTVWYUhFNjFpUGErQVRiMGdxV25WK3pWMWVW?=
 =?utf-8?B?OWpTUUs5UVJITWpib0htRTRZc0k5WUFiM1RVVmNhYVR1UVRGOUNLaldFb3ZT?=
 =?utf-8?B?K2hJU1JmUUJOSzRRZk9pMFo4VFJ4TGp3Z3J5UWRwV1RkQy9sOUtwNHdlcFNs?=
 =?utf-8?B?VEU5T1JOQzVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhsci9mSWgxYldSTmdOUDVPTkdMVFFaM0IyTGNvem9vVEthcExsVVEyMkgr?=
 =?utf-8?B?ampvZHpOOG9tMCsyZVNKZHk4NjZkWlY3cmZyRHN3K2pqcVhCTDJQeHZNN2o1?=
 =?utf-8?B?RVhBN3RZc2pFa1FmZUE0dTNPeWxCd2MwN3U2Zzl2Z3BrMUE3aWN5SWVlaXAr?=
 =?utf-8?B?VEJPWjEwdDlBSXp6R3BYMVJZOWZzNExZRHBqenpCZkY2dE8xVW9sUEY5cE9T?=
 =?utf-8?B?U2tMd2dMemdWNm8xK1FZamU2T0F2YkZyd1U3YzA4WG1PUHJtcjNiQWttbFdX?=
 =?utf-8?B?VGZWc0p2T3dPelJUVDlKZlZKYlM0MUJPRDlUUlAxVElFSk5oK00rKzM2anha?=
 =?utf-8?B?TWpMUmJvNENGVUdURXFOdlRaMlI1MmxOZmloZGM0dUpZVDR2WFQyMnpRNG1F?=
 =?utf-8?B?c3MwUEEzc0x3TkN0bDIrNmN0UndhMCtwdy95QkhUTVJySTl5bXdsRVFocWwy?=
 =?utf-8?B?T1J0a1ZsN3dlVThKaGwxb0t4WmJhVFQ4VjVmSWZRd1hKcGp5ZkVJTTExNUdr?=
 =?utf-8?B?MzlKNWFoVFh4UTlvelV6MEgzUXQvZkJSWkROK3VoTjE5czQ4VTdUWDVtdDVD?=
 =?utf-8?B?TUtSQXBVNTMvRnUxUXgrTE14d2NhY3FYNHA5QzdhT3RoS2MrVS9iVEFIN2Vz?=
 =?utf-8?B?NmNiNy9KUGFITU1sRm1rYVhHWXFNd1prc3VoczZQM3pIU1FTTXk2V1N6QzNk?=
 =?utf-8?B?eHdUZklERy96NE9JTXNrR0JjYUJsZitNanRQM2FUeVBneXFkVnlBY2Rnc3hQ?=
 =?utf-8?B?bGszUTdHVXorN25uNEtqbVlkK0JVcVNWRVJ2V3dBa1ZPSHRIZERMTWMxbkI0?=
 =?utf-8?B?ZHNjWEc2TUl3MHRhdzhvWDdWTmVFd0FkVVlrVzZrdUNWNXVnZHdLUnVnMXBy?=
 =?utf-8?B?TUdkQzdsd2ovRWppTmtRRlFHTjg4WFR3NlJ1VU9OcUN0VTVXQTBncWtTZWNU?=
 =?utf-8?B?Sno1QzVjL3J5WWVIeTZVbXJrcCsvN3ozQXZiSmN2eitPWUp6Qi95bWRKUEJ1?=
 =?utf-8?B?b2x3WkdiU1FGYWwwekUzRzJoZTJZUkQ4L3dIaFhnNjl2YkJGV2wvTFI3aFZV?=
 =?utf-8?B?WkljM1R3ZjdLKytXSjZlUmRneklvOXdRRlcxRVdKOFZoS1RNT1lwakdnZy9S?=
 =?utf-8?B?VGsxcmVXVENtS3BJWGVMZklGc0tFNG9qc2dJTTR1NU1RcnAzQ0wrZkxvMnNz?=
 =?utf-8?B?WVpDRmFNaTc0YmprRmcraDNEY1EyRDlJVU5oOElmOHhsQkVSbkN5NUVKTjhT?=
 =?utf-8?B?SnE0amFEVisvUGowd0Z2Y2pKSUcyczRLa0h4Z24rVmxZNEZrQUU0UklUc1Ja?=
 =?utf-8?B?clkyNjVSNXFTSjRVRmFjeGl1Smk0Wkp6REc4bElOa0R0TGMrUFBJLzhKOS8z?=
 =?utf-8?B?WGY1VDZSOFlZNlVMNjFvNExDY1Y2SGgxRGxHem9LNUpYUjlsRW1sNTFLZ0Rm?=
 =?utf-8?B?MHRGYTJhWHVjZ29HaTI1a3ZjRVJhL1M4KzVtbEhyamd6cnhPTjBIY3FIenBT?=
 =?utf-8?B?OUFTN2FSVU8waStTZDZucEF5T2h1d3BkQmRxckcyMWs0Z0FMcFJiVjFYSGZU?=
 =?utf-8?B?ZDEyOVdpUzBZU0JPaTdKaDk4akJHSVVTSUhncmQ1NHlaUnB2OUJWWjRsRCtv?=
 =?utf-8?B?WUtyWk5YYzB4eko4RXpSZG4rZzhITnJtcjJGcndUSHk4SmxkcEFqWFo1RU55?=
 =?utf-8?B?T3lSWDRvdGNyZHZJVTYrdFFFRlQzUVhvb3p1OHl6a1hZVFlJMEFOR1BsQit0?=
 =?utf-8?B?TlU4VXd6RU4wQThKSlgxeXlOeXJPL256T1dad2JzbGJpQ1M5Tm8xVWdQTFdT?=
 =?utf-8?B?a0Jualhmc1RtWDlLVS9sZC9YeFZlemlmM3JkRW5hbWdOZVh4ZmpNTkRtRThO?=
 =?utf-8?B?RS9QNGZVWXZNaURabkxFaFZIZUhqT1Rjc3g3eStXUWJSSTAyMHFQUVZFWTJv?=
 =?utf-8?B?ZDlhZ0poZ0c0c3lSb1BIOHpHdVArZ3U5TEhVNlUxaXdkT2laVC9Qb3B2cktz?=
 =?utf-8?B?NDVYVzd0TmZGQngzakwwWWdvMEx0MGNIZkxUanhYUDJURVVnRWpQeXFubGRM?=
 =?utf-8?B?ZkZocTdYRVgvZVRRRGlreGt3RXlCOENsWXJqQ3lRZ21NdzYzNU5UMU9PL2VP?=
 =?utf-8?Q?OU/dVNyUlJfqtvOtCeyGyEOrc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1ec255-ed23-4b24-006e-08dd57e6730d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:44.2199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZDJnRhIawyopX2rY/KVF54Zky5j74y1RL/XLg4NNWZM7dQRwBEdOhoXMMdR6s5qR3hCQFM+Qy/GFcsjiNWcsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

From: Teo Hall <teo.hall@nxp.com>

This patch adds V2X container support on i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a0..54ae772188 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -231,45 +231,62 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		debug("v2x container size 0x%x\n", value_container[1]);
+
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
+	}
 
-	return value_container[1] + offset2;
+	debug("scu container size 0x%x\n", value_container[2]);
+
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +296,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +329,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +343,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +356,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.43.0

