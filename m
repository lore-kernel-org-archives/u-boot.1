Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB17E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 01:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835C48021D;
	Fri, 20 Dec 2024 02:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OgLH0XgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41C780291; Fri, 20 Dec 2024 02:58:49 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2150F8021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 02:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIH0GJgJ3yuqU5p+aY9Cuttm4GexZW2NTclJ1WHGy4L/oPDwVAU7VolGLIwgyUKzhneeztG9z8CP8c7Tpy92A2iseJvCxDKMnbsr+3pYQdz0pxJu43J3gIVKOPN9+wt9BH2gw61IPcJNVHPBZrddVNjMhZgceR2ZRCYLy7HX2ldjj5zoyGnqtYYw/Gxtu33vPWwZjOBTmv0wXH0h4LanXLD30Rdwqhil4LtdUyS90610bILqIsqWGe/AZ+5TGYbNXXksh+uaQkW1tlWXetAA5OFz53IB5dtke9W5ZNV2DP86VWCOmgwgZoMrGp775sFCq1fWQtudBVa9nXtCICM6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFb1udy6xT5bFcJqoKpd1Kw7nA9pyu7FskAsrkuvS1I=;
 b=OjhkkQXDxm/VD8Aw2K2r5ep0tzdloL8PrBYHQWednhUjvaMqBZf0i8jU9+fx71Wqs3e4wXxexb9RI4S8STHhO0S4f9LquPYtLxznaTss1I0GrWXxGYSnlxpd7gRW7jrN3R0z0t68b6Syl0IpbcN7el3DJNCaEhprHd0pHoqk3IU5TpJ1JLS8BTj3fVwp61aHqFlKTBgLhY5C9lxM0xwphqEz/Q6+ke7R0SfP7yPlQNpNUwHQ3OSbX20MayWkN/FVMcL9yQBrOWU8/I9rZQRpgeTPw4iPQrgYkyqFI3fpvto2yYMSiVOzXhA2NFa9SWWecfNiWMNsbCRVvvUMF8OSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFb1udy6xT5bFcJqoKpd1Kw7nA9pyu7FskAsrkuvS1I=;
 b=OgLH0XgFrWD+WZcy74axs5Sy7ouerPsnmY+cBBJke6C67KslmmU0e0PhiX7uB8b0Tb0tomemsyja+8EjS9MQOv7zZq1g3CH1bK9/08uWVg3PpsNmpvHpgRwJo/iQUB7TrS//ko2Na3qGzfpsBW/aIWj+uQJMQ7InANVeu3hG+UuYg9i4yA2qYfk0D+HWBPjDePEFlHyoAiq3ZfChN5hz1F+oXIXc73NI1vh50qlswCTKM7IAs1TfzfPnhV8AavzSQcpa39uXsfPQNxhqdGPiL9iQM268cqlgweGMD9tnvnJUp3XZ20fDks4nDcCXE4Ru5RI4rXMoolJN2Zj92sB/TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 01:58:44 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 01:58:44 +0000
Message-ID: <d4acb710-7c80-4b71-862e-cee0a16d8cba@oss.nxp.com>
Date: Fri, 20 Dec 2024 09:58:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX8/9: question about unused DDR PHY trained CSR board array
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 "barebox@lists.infradead.org" <barebox@lists.infradead.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Steffen Trumtrar <str@pengutronix.de>
References: <8074530f-720b-4aea-934b-c0643c356617@pengutronix.de>
 <PAXPR04MB8459A8BB89FAB50D6871EA9388762@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <2200ece8-593b-4ac3-be3e-b05570165e5e@pengutronix.de>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <2200ece8-593b-4ac3-be3e-b05570165e5e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA1PR04MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7fb16e-6661-4e7d-a764-08dd2099d5c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlRsVU1DL2lyK09EaXRxM2pQa0wrSERvV0ROZXdXVmpRTXdXdlVYYkRGTGZM?=
 =?utf-8?B?VVJZTFZKM1hrOW4xcXI2bjVXcm83VE5GTmNKeWhqSnRSRGNxdTZJMmpkZDNk?=
 =?utf-8?B?Sml5cDhUUDN1cFBJWEhuNTBTWjVJVEhyYkxscXdhcWdHSlo4dlVqRmJaKytG?=
 =?utf-8?B?eVEyQkR3SFBtNzErUmJlU2F3QUl4bFlpSGZGMlI2RmdGRnRqa3FQOW0xaGlq?=
 =?utf-8?B?VE8wdU5rVEZqTGJjckFVZkkweVlNUEZvOFpTSS8wUUtSYlBmbzFqd0dWa2la?=
 =?utf-8?B?bk8wZ2tsbHRheDZzcGN6UjFBMCtWdFIyMkZYRkk4b21hSE5VYXBWUEVpWjVh?=
 =?utf-8?B?ZXljUEVTbHBkU3cxdjkyeHZDbDYrWE11WSt0ZmNPZXErWlExYndZTVZPZFhy?=
 =?utf-8?B?QVBJeWcvc1dreTNtRjE4SHZieW5VMzdDUHEyZHArNDExQW9WMlFBOGRDTUNX?=
 =?utf-8?B?S1BjUkZlTTErcG9FeDAxa3U4VXlqTjZNc2NNTWdUTk4yd3BiczQxYW9hcnc0?=
 =?utf-8?B?ZDBSSTdSTGNQOEVNVFVLWmFQWDdGWVc2ZTNYL3JRYUNKVFpVa0U5QllRRC9z?=
 =?utf-8?B?bXgydEsxZW11TjhEVjZmeldrbVVNcTlkK2plKzE0SVllZEhkY21ZcE91T3A5?=
 =?utf-8?B?T1VZUXdHdk0rTjZPa1dIZXNlNlNyRGltVnZrY0pYTzEvcTFBN3BncUxKZnpF?=
 =?utf-8?B?enNXcWIwcU5BY3hPNHp3cWxoUHBmSXRJVHZVVkFFY3ZhTlFVV1FCV3pvbGNr?=
 =?utf-8?B?dUdKSnl5ZUJ6SUhpZEJjanYyS3NTanUyWTAzQlE2cHJuazc2Y0EzZTBpWEcw?=
 =?utf-8?B?cGx4UXI2bVN4VHRxZUFQKzNtRXQ1R2pENGZYczFadVZZN1FISFRZY2EvYTE2?=
 =?utf-8?B?a0NHU1ZIbjlFTEpIKytzYWlnRjAzeWhoVzhlVjBLb2k5OWJ1WURGcUdRUTl0?=
 =?utf-8?B?UFZyaTd0WFNaMFlKQXh0YzNUc0RDNkxKUDYvMDZsODhubkFOOFBVdHBqY2d3?=
 =?utf-8?B?MS9yTTFuUUZSa0drMmJUdit5VlBvSjluRGxWRnhUb3M0bDZYeWJpMnBkcUYx?=
 =?utf-8?B?cFVXdlZhRzVuRjZMM3N3a3ZnS0tuRUdIR2hJN3R5Q3RLUDBLRDQrRE8wWnNw?=
 =?utf-8?B?NXBYR1FhZVBld0RXNWJsVGE4ZGRXQ3l2aTN0ZVB4OGNSTXQ4aWJXWS96amZn?=
 =?utf-8?B?bTl6MVhQQWlGMmFydjJ1UVNzNk01UytkNGFPZ0VZSVZPRko4U2hlWmZsU2Js?=
 =?utf-8?B?c1ZjNzVsTmhRWG5NZkFoaVVIOS9sN2xrK1duK09UVFJ4aW5NQ1Y4c2txRTFp?=
 =?utf-8?B?YW1BT2x2ZjZhUEpGUjhRUVhxdTNoMWdrQkt5enNueTZvaGRqakpzTTlRSGo3?=
 =?utf-8?B?VWN6VDNSdUlBWmNYcXRqTVdLV1IxaExTazNnR2swaTlWK1pSTUdDcUN1aklm?=
 =?utf-8?B?NzUzQzNzK21tbjFOS29nNS9EaHpKdXR5RUE5Z3RJRmNmeUJ4MjYxLzc4UG45?=
 =?utf-8?B?YlNjTmcvQThoeVMxb0NENzBLT1hCNWhuQUE4UUd2TGV4K3JveGpQd3pHb2U4?=
 =?utf-8?B?ZlduL0ZzQ0w3M056Z3RMTnhsMTFtQUtoeEpPNWZ1Z3ZZY05iM0NSQm5aSzQz?=
 =?utf-8?B?b0xWSnBOaGJ0YlRraVNnUzc1MjBjazFpREMyeW9semRyV1FTVFBUYkFBQXVl?=
 =?utf-8?B?dlVta2RPdHFoT2wzM3lEUkxhQmV2Ky9qb2NncHNWR3g5TGdHWG5rbklBRWRS?=
 =?utf-8?B?bkNlamRjeXVxbTRXRW14TWMrRTlGUXlaTXhqMEdVUGJtbWJxaTJvYkk0dS9a?=
 =?utf-8?B?RWx3OXZsekdMQU9OOXpzYXBnV1lNd3FCZFFtVWZhRHFnaVFoc09IQnQzcW83?=
 =?utf-8?Q?jHkp2fzqugv78?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUZHSyt0YkhSNlFBQjl2aFNZNlM4Uk9qSWd5TUtZajMyUlBINVRiL3RwVm96?=
 =?utf-8?B?OWdscXB6MSsvdCtHeG9tcWFhZmk0Qmk5aTdLUTRXZEc0OXVnZjVyYnpoMXZI?=
 =?utf-8?B?ZS85Vys5R1FRVzZ3TUw4b3ZYUkpPaDBDdnFRd05MMHN6OUxaUlRsMmN5UEdQ?=
 =?utf-8?B?MHU3SVhtYUlrSk8wdlRiVEhRazc4NUhZcEViVEV1M1ZuK0MzU3BEVWhLSzVl?=
 =?utf-8?B?dVViV3hzQzF1WktMeThFK2lEelhEVUh3WUxJRytLaXlaS0FlNDNjS1hKaTZD?=
 =?utf-8?B?bjk0bVF0Qm5BSEF3Nk9acW9lVU51MDd5ZkdBRmNxSVByNEtWUkRLMGYvakdT?=
 =?utf-8?B?WjFyNUhGbTl5TloySFR2NmRZZlNOOWFVdVFEa1lpUXhRZ3dUUkw1Uk1GSmpZ?=
 =?utf-8?B?TXVDTVlhaFdPbE93UEFjM21lZnNKZVB0NUg3TjFLZUJHRFlsUHVUUjhvM3Z5?=
 =?utf-8?B?NkUwb0pRSGxsalRFRit1NWMvRjlsQTRlSTJPc3N0RUhhSnBpUkh3eGprNHk5?=
 =?utf-8?B?WHVUKytXY1E0RW9lQlZnbWNlWjlBMlBMeDZHaDRXdlVyYXMwdWZsVFE2Q2tU?=
 =?utf-8?B?ZnRYejNrOVhQbWh2M210YzI3emNJeHhLNngxZGpGUEZTZTFOMEFjVFN2NGth?=
 =?utf-8?B?ZlVCUGNRT2dJbGtDc3d4aWZBclQxQWRzVGIwZEdPTW5QVWZILzFqZ3NlRmY2?=
 =?utf-8?B?aTR6dDVhblIzZVo3TXUvdlRENmZPbHpEQ2VpV0pjZ0JCR09SRzlpbklvWmhH?=
 =?utf-8?B?ZTlWMG9LMzRsTXBKV3lSck1zSUVKb2h0Tm1SQmFKaWdCNU1RSnFkWlJaNDZF?=
 =?utf-8?B?YU01TTM2Tm8yRnB5UERIUVNpR1J4NTF1RDJlK1ZZN0tIdHVJUWx6RENsR2NG?=
 =?utf-8?B?UGY4NmpyWm5lQmovZk11a0R4SElmRzZDWWNvRUs1S2x3eWdVUmQ4b2EyRTlP?=
 =?utf-8?B?K09UTmpRMUYxc1ExdE9JUkJxTVRabm5BcERMb1VvUnJNTVlpYjZ4ZUZuN2VY?=
 =?utf-8?B?TEpiaEZub1EvbHRMdFR1dEt3TiswN2lMRVNXc05QZ3dhZUd0Y3pNLzdZZEN2?=
 =?utf-8?B?eG9wT3FOVTVWa1lMZHk4ekZ2R3ZuanREZER4YzcrMERNSlF0T0Q1WFp6NmEw?=
 =?utf-8?B?eXVUa0dQaU00OHJKMEh1TXhpN2VzeGcycURsOEFtcnNLdzFjN3RCempHYnpu?=
 =?utf-8?B?OUx6OVN2Tk1aMGtKVE43K0RtWjVYTTZYdlVrcFExNkE2czZJRTV2Rzlzclp5?=
 =?utf-8?B?ZVRDYnRWQm1uWmVLRm9CdFNGSEhOcHY2SlVyTVpkNEFqOG5mTkp3bDk2YmdT?=
 =?utf-8?B?R1VaYzF6bm9URnhVcTM3MlVFcloyYmFpdThLUDZaOExSVnZza0xuZlJxcGRV?=
 =?utf-8?B?dlBFb2F3MmwvODBLNkZZWWQzMHVtVjA4bTY3MisyZ3hpRHdiZkpyQWZwZGxw?=
 =?utf-8?B?SVhVYnZwUlFYbzFNQVJRZzdDYktrZmtXTG5sc0JJVk53WVUrRnhJMnQ4R3lS?=
 =?utf-8?B?N0ZkSGJKekl5cHFaRVJITG9NQU9wME5DTWM5Ykd6bHpaMTIwV3RFWFpWMU9J?=
 =?utf-8?B?ZitzNFJaU1hQYzh5dGFLbzVIdldDVnpEQm5VaWFrRXlOUjNWa0NaRXdYU2p2?=
 =?utf-8?B?QW1Xamg3WDc4WUwrekFvNXV5ZTExTkpJK0NVVEU1Y1c5UjhsbytsTll5a3Fa?=
 =?utf-8?B?ZEw3eDRQemV1KzFLekt1ejEzK3lRR3pRSGZnYU5vcHpQMFlRamV1N3BUN0xD?=
 =?utf-8?B?Y3NIOEY4YjA2UGVrS3Vkc3VmSnJyVnRsVW1oQ204d1YxVTVXZUdhbTZ0eW80?=
 =?utf-8?B?VENKSDZBTjNleWY3T05OWjVhVGdXb2QxRUptbi9jNlU0NFRxcW91YTRzSEhz?=
 =?utf-8?B?RjdURzVLeHZjN1hxand3Rk9wL3VxWmNPK1EzR2dKb0J3czNiLzhZdVRpSHJx?=
 =?utf-8?B?cUxXRmpWdk1TcTVOeTgydkdiVWcwMFlla1diSkNlWUI0SkdXc0pybXZEaXB3?=
 =?utf-8?B?QjJwN3gvNjR4MHBFbkRSOHdJUHhIZW5qQlJzUlZEUEJVTDI0Y01qYlVKc3FY?=
 =?utf-8?B?K1ZGRlljS3JESWt1U1F6YUE1SGdEd25kTmRneTZQaWg3bXRJcFh0aklLMGtT?=
 =?utf-8?Q?om4Ujvi8jNdzZW0N8TLV9lth6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7fb16e-6661-4e7d-a764-08dd2099d5c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 01:58:44.8804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz5v7sqqlC/hcypgljhIr0d5yHkVj1lNElP5QAtMkv/0o66t49fgGjCFLKyTB4X4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179
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

Hi Ahmad,

On 12/19/2024 6:27 PM, Ahmad Fatoum wrote:
> Hello Peng,
>
> On 30.09.24 08:38, Peng Fan wrote:
>>> Subject: i.MX8/9: question about unused DDR PHY trained CSR board
>>> array
>>> Looking at the DDR setup code for i.MX8M and i.MX9 that you had
>>> contributed, I am wondering about struct
>>> dram_cfg_param::ddrphy_trained_csr and the global
>>> ddrphy_trained_csr array.
>>>
>>> struct dram_cfg_param::ddrphy_trained_csr is presumably generated
>>> by the i.MX DDR tool and it seems populated by all the i.MX8M/9
>>> boards in U-Boot.
>>>
>>> This struct member is wholly unused though and instead a global
>>> ddrphy_trained_csr is used.
>>>
>>> What I wonder about is whether it's possible for the DDR tool to
>>> generate a different ddrphy_trained_csr than the default:
>>>
>>>    1) If yes, we should drop the global ddrphy_trained_csr and actually
>>> use
>>>       the board-specific array
>>>
>>>    2) If not, we should drop the board-specific array and perhaps ask for
>>>      the DDR tool to be changed
>>>
>>> I initially assumed 1) and because all boards supported by barebox had
>>> a board-specific ddrphy_trained_csr that's identical to the global
>>> ddrphy_trained_csr, I dropped the unused array[1][2].
>>>
>>> I now have the DDR settings for an i.MX9 LPDDR4 board in front of me
>>> that has different contents for struct
>>> dram_cfg_param::ddrphy_trained_csr than the default.
>>>
>>> I will inquire how that came about, but in parallel I wanted to ask you if
>>> this is supposed to happen and to alert you to this issue.
>> Thanks for raising this issue. I think board specific csr should be used.
>>
>> I will check with DDR TOOL owners on this.
> Did you hear back in the meantime?
>
> Thanks,
> Ahmad

We have discussed this internally. The DDR tool may generate different 
board specific csr. Currently in DDR retention, because we load csr + 
ddr_phy_pie, so it is safe to use this global csr.

But we agree this global csr is confused and waste some memory. It is 
better to switch to the board csr.


Best regards,

Ye Li

>>> The way things are, this is either a bug or a missed space saving
>>> opportunity for U-Boot.
>> Thanks,
>> Peng.
>>
>>
>
