Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB5C3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F10488DF9;
	Tue, 17 Sep 2024 04:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hl2cuo1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CEB188E6F; Tue, 17 Sep 2024 04:31:07 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF1988C78
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNHKIxGYaGDUuAwph3j4DhIdh23L5QTbkExl8vSvrCJdq8EpQYfkdIpgBFVWNhpIXhFfaXjywXhFBdH6gat/Gy63fWoDX49s3+gFxBjMskfnBJoWb0z90UPqHHJ9sVOwzSREoOjZmbQys6JeHXGQ0gmOjsZfWzAPlOmCvmoCXHbCcSgZivaog0QtHrOU/yFxgY0T8GUCeGK30M/w3d9Ppu0CjCzlO0y+cVhHgisl0VXNQMJC1mAQsEKUKsgfkwPTaBKXb/r4idLg+WP6O6pJUr/d4qU4Bkh+SK6I6jldQMmmOzu67rm75wuGZZf3SAqIuhLagNI7vJ+WUIN4AIPfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym7glaHqf5tRgAWf3Zop5kKcoOQurd3OX6hQyHSYWSA=;
 b=NgaOT8aAcu+GPiaMvAEJZk0Y0UtQWNZ4v9ST592dETaV6K1ybqOobSg8pZE/VW1rm1VP3pKJuZw3NUyqzUfqk+EnHUuKGGYvko0IztXCNXFruqTA3FDa7VEt/5RTS62TGK+JRaJkcn6ExrGu55eKwbF55z1HFopTUEF2Z/Yc7OHaPRPQm5IcliMVvxfrErYxMcMUZdgWncAO4t4f1+Xx9EM6F+jwZvKqVHB/XXW25rzS3P+OKlsPLo5/ZI9pGPuRGKSNWeeGN4kuMkVqHewJ1ATdIjrkYgtruRpXqMdi4fvtTm60bklRmhBrf9vXntGsKAma+eB2V8qGx7QjeeoS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym7glaHqf5tRgAWf3Zop5kKcoOQurd3OX6hQyHSYWSA=;
 b=hl2cuo1wYgqa+I3UhMXsF9K5y+t8GsFzQeam6GkLr0TGiUMZqnJfpoGUhg7LRDcaFrXY/UKRg9YiPGp382vkQcyF3ol69yfieQeiCtZ6yep0TGgK1MWsD4aIjmt+lJnpr7AjFarsBx5DmVoL99sulEUQLubjM2GkvTXyAI6XxX8GE3sHZlMaDBq0iyjajAhAAicGEtAFZv6RNXcceCS8SB9PpJ4P10kglG38YMjkNwmxJVXVQwm4dCPvPn307ENB66z2GTHl5f7CXm+C3KPHiGmM9rhKZSe+Q/Wzf6OgmyuNqqRk0+Q4nUblfo00zcd1P8sptCNfRguO9VVXFIlfKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 17 Sep
 2024 02:31:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:02 +0800
Subject: [PATCH 10/21] imx9: Add 233Mhz DDR PLL frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-10-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 98618f6d-a0f5-4f27-cf07-08dcd6c0c4b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXAyS3gvcmpDR21YcFpiMmh3R2JjN2Vybks1dmxHaU5XREwzVGNud2FLUzlF?=
 =?utf-8?B?WXVvdjhXSTEvanJtbXd5WmxYYzZnT1ZmR0hISXByOGNOcmdsOHF3cm42RS9k?=
 =?utf-8?B?RlZnOURGN1lXR0N3dWtMYWVuK3F6S3NaVE45K3FKcUE1T3pFVm5TNHNXTUs4?=
 =?utf-8?B?RmZKUEt5RXBtMGRhYXlsK2lWdmVuOFV2K1ZWaktnRGxoOXZLR0tWVm5iM2JL?=
 =?utf-8?B?TTZtSURsemx4d0Z5YnFvZkU5OUQ2T25hN2pCRjkrbTBFYTFLbVhKSVpMVjM2?=
 =?utf-8?B?R2hFb3NvL2JQSU1hRnpwWWV0eitWV2tEV1JGTzdGcnBDWS9aTC9YZmVUd0pM?=
 =?utf-8?B?QWFKM3ZRR0liYlhjVFhSaG1xMmk0VEU3Z3F6RmVmYWR3T2pTRXZaVEFuN3Z6?=
 =?utf-8?B?UHNuWWRndkIyY3JDMjNuVkZROXN0WXk4dW9sL0VpSkdlQzlFaDRIZUhpaU9a?=
 =?utf-8?B?TzM3TEI4T3JmWnRzTXFoZ3dKYkpybnMvc01UYnJ5MGxyekM5YUlrTnA4YzJv?=
 =?utf-8?B?UzQ1Ri9laFZoRWhkU292K0NLTDRWWmROZDdVdllDOFQycTg5K3BNUzkvMEVq?=
 =?utf-8?B?M1Fhdjk0ekd2YnJZVUFjVWFZV2w5YzBaQ1ZrNlVoZGF5RDZSRkY1OURxOUtJ?=
 =?utf-8?B?MWM4ZnYzL1hhZG9PRzlCRGU4RnVFUXJhbEpxa3RETkV3NGtUWk5oWXhMTkVv?=
 =?utf-8?B?MUlSY0JDNmFwSnNtUWpnU3JzVlEvZStma2hMQUlTK21Ta0xONzVyMTZmNm1P?=
 =?utf-8?B?dVFjVFZVOXVuK3BWaXQ5NTlkWlA3WE00NUhvUWxKcllqMHRKQ1ZBTHpsTUc1?=
 =?utf-8?B?MkYyZ1hiYzZMVFZLSDR1MkQwbC9JRkU2Z1o0bjZkakNNVnlrbFBjSWo4cnpv?=
 =?utf-8?B?bUtXaXBMRGtVWU5jckFLZnRQcUs3VXZJdzJ0VnU4ZXhUSTlJM3R2MlNOOUdO?=
 =?utf-8?B?NjJFYkZOeWlFdWVMMEJGWjkvdFA2L0pHZWRhNjVrenVmU0NVOVRncFRnYWN6?=
 =?utf-8?B?KzhHaWZmcFNHdFkrYitBcmkrT2J2cVZDbDIxNHlSZVh5aTlENWhSVjdubmpo?=
 =?utf-8?B?czM2SWc2ZzcwV2JFMlNmZmdPVzk1eFRPdFI0NkN5UGJDekdqTS9hcDg5Zm1Q?=
 =?utf-8?B?V2hmZE5Hc2hpbzhpLytkTVVZSDUweVFkMFhlMi96dUFmMnFsZ3J4TmFOZStT?=
 =?utf-8?B?c1lNUWxIVDlmaHRVRnRoRFMvTzdEbW1ya21kSm1FSzdsUnBaOFRhSUN2TWtR?=
 =?utf-8?B?cXBxa1ZKK1QwRjVaRm0waVphR1lyQU1PUGRBbXY5Q1lGSDlUYW9sRTFRdXBQ?=
 =?utf-8?B?MDNoSkVPT1ZhQXVOMkZYVXlGNGZsTHlOZ1lsMlJ5M3AzTE5OYzUrMDVJWW03?=
 =?utf-8?B?UFYzRWJZY0lmY1RSZUJnRXBsRnlmbTFxTm9XZFJlU1NoTm9ZVk52RksxVlBX?=
 =?utf-8?B?U2FObFlqUHhKSTBrRHZzQmVnYmI5TnBDcyttVXpXWVE3MnI1ejRuREZPa1p2?=
 =?utf-8?B?VjBkRmV2QTlWN2ZvVDl5S1ptdUl1WVJKeDhLOHgzditCNFVnT1o3c2Y5WWd6?=
 =?utf-8?B?dFVMekRYRy9xVjg5S2h0VDJjUkZ4Tm5QNnlCZHAxZ2xHNEtxMmNUM1dHR01E?=
 =?utf-8?B?QmpsYVlBU1Y2cUxLNkFZcmpsV2NYMUpLNGZtcHIwZlk2d2oyWXkxc3NQL3Jx?=
 =?utf-8?B?T2kyTVRmc2hWU1JVOFczYk9uR29uZGE2bkpGcjFMWE9KWXFXVktENytyOHBu?=
 =?utf-8?B?eDgzQWgxdHltRUc1RnJ4WEV6SmIrWlFuVjNyUmYxNTBEeDR1eXJiVnNVWlhv?=
 =?utf-8?B?bDZRdUxQclVaeFhHOVJBK1A3anAvYVluVDh5VjVlOWNXeEVaNTRvUVNmY3Iw?=
 =?utf-8?B?aFNIZ3Jna2lJZ2RvcUZKcDFMOWk0dFpLVDZuK1BrK2ZOMUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHpSZXlOUmxpbkVZZDFKU1lOTkIxT2lkVGhZMFY4ZlVYSjdBN1hxRFJWdHZ6?=
 =?utf-8?B?WXd5OGMrWmZzMUV0dlJDUm5LNGFqZTRuTThrZ0I2M3l6U0I5WjI4N1kvVHJP?=
 =?utf-8?B?YVJySUFiNmVmL0REQ1Fwc1VKOHV1SWY2Ni9zdm9OdDdmelFzdlIxQ3RXaFNN?=
 =?utf-8?B?Zzh5SU9lVjJMalBOTXJrZjlESHpob1pTNkdKd2xVRGorVTk0cW9wTjQvaXdm?=
 =?utf-8?B?ekRqd0RuUzBta1NGaWhabmRHM2hrdjZqTG12VHZzN3hlSm9hT0R0TG11R29B?=
 =?utf-8?B?bEdIZkMvemtWZGZjUjhQcTkvQWJ2VHNBaktEWjgwbE5VME91RWE3RElSTisv?=
 =?utf-8?B?VW1yVVhGL2hWa0had0orVU9yck9ZOVcrM0hWT0NuVFUzbkh0cXdVT2FYRkp4?=
 =?utf-8?B?RzRTN0RESC9OdHlreXQweVNNbUE4UWg3U21CNzVlU295cnBrei9mQmh4Vmxp?=
 =?utf-8?B?Y2N5VUh0cTNaTkNkempvZnhOTWVBSmR6UEthWW0rektualVBN1F6ell0emhP?=
 =?utf-8?B?OHFYQ3ovNEd4azJYYjZWN0xpSytzVUhRUkcybkxqQThYZVdBbmFXTFlULzBw?=
 =?utf-8?B?dVJuUXVuNTYrTTVsS3pTb1NOTVlBTEFubVlvQmI4M2Q3blB1YW9Ndnh5UjBP?=
 =?utf-8?B?djUxdWw4b2RDalhrN1lXSXJGSzJqeEVpcG9VaXVrYnpOekJuWTZOSnpmRkl2?=
 =?utf-8?B?YVR3SFkzUXZvdSs3T1BFTFhEaVVaZjc2bWRNUzNUd3ZVZEV4VG0xUWV0SVpk?=
 =?utf-8?B?UEFlaUk5L3hUZ0JLVzZWa0kyUDVpUDFMdEJQWE1UTzFCS0h3VGZOQjRTYi9o?=
 =?utf-8?B?UmZmUjZsOWhTWG9LMUE3VisrWlBtZ0ltdHphNFdoNW8vVmpJbEY4ZUd5SnNZ?=
 =?utf-8?B?Rk91MzhDR3VISkcrUTNxK1NvVldZV29tT1E4QWliR2pQUGdBSGZvaXNlRk93?=
 =?utf-8?B?MklXeVhES1FEU3I0T0ozcUprYURUU1lBVDZmMlBmejBIN0I2bkhhRFl6RXpY?=
 =?utf-8?B?ZlVsQjM0bjZwc3lJOU9GWFJ3L0pzOXpNWVVLS3B5a0UrdFR5c0tEVXljbmVO?=
 =?utf-8?B?OHg0SkJqRWhjQUZwcUVHQWpjdVpMUjJyY3BVNzdnQzJpaEczYW9BdWNCRTF5?=
 =?utf-8?B?TWRuZTdZc2lXODIxenB6UnlVMlF3MU5aYXJVS2d2SDJ4VnBOVU8xaDM3ZWdT?=
 =?utf-8?B?a3RBT2VZU0lkeXMvbWxtNEE3Kzd0R0tqa0YrK2ppSnhkRXIzMTNhSTFsVGY5?=
 =?utf-8?B?VktsbkVpK2ZCU3Y4d1A2TFF6azFZNDFZR1VvOHFQQVJGNFIyMG93ckxTYklC?=
 =?utf-8?B?cVlaVWN0bis0U0NVYlJMVStRdURRS2JpbDVpekY4T05TUm9vK2FsRUhNcldo?=
 =?utf-8?B?eHJtclBoSmlrNGZRWlB1WmcwU2lCQzI2bHE3dnNnK1h6TGFnVHNWeHAyWDNF?=
 =?utf-8?B?MXRjRHg3VGJmMndPZ2o4MzliTm1zNHlCb2ZiWEFpOVhtQ2xjU2Z4WE5xOVVo?=
 =?utf-8?B?c0tsVm9BNUlQcnU3ditPUUs1alYwbzdqeko3Vy90VXp0b29BZXNyeHk5OTR6?=
 =?utf-8?B?Nzg1YmhoU3ZFRzliWEtwU2lXUWw2UERZQlFBV0FMQUtwaitmK0lNdVgzcUUx?=
 =?utf-8?B?blhpZHprK1FOckR1NndSYktuM29vYWNxQzUzNlo1Ri9xeXJRNXdpZUMzSXV2?=
 =?utf-8?B?STVpSnhleFVNSTBKdSsyaE41UDBidVVzVVdtVjVZTzR0cWJQUUJ6RG5GQWtV?=
 =?utf-8?B?ZlRuSjB0R0dsZFdYTC9LelQrMTltS3hCNEZnWjNzVk9JR01RdXB6UmtndzA0?=
 =?utf-8?B?V0pkcTJRbC9JTnlnVDZNT1owZWxobUU2SExVd1R5M3RFYW1vZ20rQWRDWldx?=
 =?utf-8?B?d2U4cnFJQURBWlhiTUhZUStBS0ZzWHBzZkVJbWJicHc4WTJPNmJBTGhXT25t?=
 =?utf-8?B?K0VxbUtHNDZwUGlJR0FuMVlvQ1E1VnRPaE9YL2RhejlXcm9pSjVPS2dvSFJz?=
 =?utf-8?B?MVVPVHB3YW1JcDVXdVFYYlBMMHRnK0pEcVYyQmtFSE5ITXNxbklSV3VWL2Nj?=
 =?utf-8?B?ZFJ3RTgzRTdnam5nbmdweW9xYjFxY2RDT09ORTZzbTFXdmZTeFNudUVLVGhz?=
 =?utf-8?Q?cWT/4F+IzG1U6uOgz12X5DDJb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98618f6d-a0f5-4f27-cf07-08dcd6c0c4b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:00.3251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW2R9DpvS0p+UIh67oFC7RT49HjXmT5OgBt49/K1BUs7G/n13H5ibNBO4r5utU795Y3euw46/6eiRXsS1bVytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
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

To support 1.866GTS LPDDR4x timing script, need to add 233Mhz freq
to DDR PLL for second mission point at 933MTS. Otherwise DDR training
will fail.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c     | 1 +
 drivers/ddr/imx/phy/ddrphy_utils.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 76d19f1cba3..12685f970de 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -41,6 +41,7 @@ static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(466000000U, 1, 155, 8, 1, 3), /* 466Mhz */
 	FRAC_PLL_RATE(400000000U, 1, 200, 12, 0, 1), /* 400Mhz */
 	FRAC_PLL_RATE(300000000U, 1, 150, 12, 0, 1),
+	FRAC_PLL_RATE(233000000U, 1, 174, 18, 3, 4), /* 233Mhz */
 };
 
 /* return in khz */
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index cf5bdad7abe..14278f5ad8f 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -148,6 +148,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(266));
 		dram_disable_bypass();
 		break;
+	case 933:
+		dram_pll_init(MHZ(233));
+		dram_disable_bypass();
+		break;
 	case 667:
 		dram_pll_init(MHZ(167));
 		dram_disable_bypass();

-- 
2.35.3

