Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A5ECCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 23:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCCD839F3;
	Wed,  8 Oct 2025 01:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="b3HaNsQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9FB83959; Tue,  7 Oct 2025 21:22:50 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2708389E
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 21:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMI4jdErHdQMga7k8TURuWT5KTs+pEXeMPahdWYuhPFd7lDk+N3Ty3s1O0KhNpcvIlSzgEmOWXgxPJom3BzF442+cBSXwKkd1EJbgOr4Iak6tP9D0/IK9MOpEKW6FPJtYY+cWbUGV8FbseRGwUIMzzxJ6P8L5mXfw9k5qGg7wGCVgI4NaL041IH5YGibf5hgn82iu/z2TCGrj90Sw6fm0ecWutA3AWqk40dlYymI5WPvex5o6owVpg/UjffZZTgOiTWTZXggosJFJaKW0I8WFo4kxUdtjRhSKKtLR0NZGeprY3gFxP6k+nZRl9JaMM38xD1/G2cguOGhv+B6uWwpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haHIujnN76B0LahtgsYb1aiYdftDE73vOuQm2y1TCXo=;
 b=jIIBOhQ5hntRffk+no+rY3J0ob7129ijdEfBm2fiBAA3Rewd+QSSUK+axJt5C1NXT7KMItqTE4pew3S+5EINCNNyT1wwdex7fBwmvpeYjdX+TF+ylDCuHG9r2kJHqDRlOx9cigLZFWvbwVpuLaIwmF7gBNxujQryfPH4aRmY29RU9KHFbwI9+9tUS6n0hASXTp4VsPfF8n9Vi9zvaIlRAVdpzWo/blajxHGRxz+++l6uvDKrJn8SwPiYS8IlUTi27ZoZ4lQnHkir3vWnt77bjAnhjXzhIbZ1yZGF9VuCmlU3Id3SyeaUFIE4JAIhL1iZMS41MFPAZJOCce2Nm/nUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haHIujnN76B0LahtgsYb1aiYdftDE73vOuQm2y1TCXo=;
 b=b3HaNsQJNlsNlD3jU1E7Br5fdO0ixBACl37Xlpm4aiBwz1Ft7eGy0XM+4StZNzfVKthYsds69bKzudiv9ytPeCbVUIQuTaXuMnHSdxwaxwbFNxSCKWf/LFIB2PZL5hyvs9DT7Ki8WgncrkG3MhiSrGNQNyL75Z6mSLCDjvvCgSyCfFNgBZ6PvIoRCK4KEpL9yyZjn+FLMcBr3eOvZ3R6/HDn8Fse/45aPXA3vkzq7Psta5MIgeUC9p2RUmawwERzgx2Nh88shUagli+u9BFVExYWBmNKo81OULKX7dwTpIu6dKip7CUJK+v89EQJVYUEcR08DYkSxiLBFQqygMYE1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN6PR03MB7597.namprd03.prod.outlook.com (2603:10b6:208:4f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 19:22:41 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 19:22:39 +0000
Message-ID: <cc7087d6-d16c-4cc4-ab30-2f81510f278c@altera.com>
Date: Wed, 8 Oct 2025 00:52:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence6: Fix DT property value endianness
To: Peng Fan <peng.fan@oss.nxp.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, kuanlim.lee@starfivetech.com,
 weiliang.lim@starfivetech.com, yuklin.soo@starfivetech.com, e@freeshell.de,
 marex@denx.de, tien.fong.chee@altera.com
References: <20250928183816.25623-1-tanmay.kathpalia@altera.com>
 <f5d9836b-2b88-4903-938c-fb72b317bd0d@mailbox.org>
 <20250929030455.GH4184@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <20250929030455.GH4184@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN6PR03MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: e63075b3-3d23-481c-9d84-08de05d6e10a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2NXS1hyMkYraWxOSFVUUVhiaFhzY09tcCtWWEdrRmRFWCtCekFETWdmcGU3?=
 =?utf-8?B?MEdBMm1YUXZKSmc2Um81dmh1cmpMelU2ZTlRdlFuaWhsRVlLSDZtd0hqditl?=
 =?utf-8?B?KzRwWTl0b3lGb0QvL3RyQWhlaGFXcG1DdmpNY1lWb3ZiSG83SWt4b0hBaHlv?=
 =?utf-8?B?YWlSdWp0WUp0MENQaWtDNEZyeE4wYzFwcm1JRVowNmlBcTFGcFpoNm02KzBS?=
 =?utf-8?B?OHNWUkRPT210NEp1TmJ1b3pqWmhRY3pXSk9IcVJQdy9pbC83Tmh6cEhxRXZT?=
 =?utf-8?B?a2lxRlRkbXV4M2dkL3hlMkVmVEpWQ1c1SHNtSC8wVTV3dy96ODVDeWhGd2Nr?=
 =?utf-8?B?RnBjT1o4eXlaSHFIYU40MVlxVERrQU9Na3h0Q2ZDc1NvUm9QUm4vaEo3eFRt?=
 =?utf-8?B?Wm4xOXpUVnJManBSV3BFYkFYazZYTXV4Y0xubWxlUjJtN3YvSVphSmc0ZlpO?=
 =?utf-8?B?NStRREtHUFhwSmw4ejhySDZaYjR0QVZKanMxZkhwRGFkMFpCYzZ2MGxKYzdv?=
 =?utf-8?B?MXNzTWRNV2tUSldKQnN3dXJjTEo5NFJKbGt3a3ZjZWVENFR6QlF0RGUyVld3?=
 =?utf-8?B?aFRacXJDdG5MMGEybk80TDYyNXRxTm0wU053cmRVak1BSFJucGlWS1hZa2NP?=
 =?utf-8?B?YVhyOVVMRXpIOXVYN2JlaTZybGMwOEJKbmRZZ09MUEMybmpoc1lXdDBLUDNw?=
 =?utf-8?B?THJhM3hsbE5YVDZaQ1VMdmcvcVpHY2EwUnMvVjNUdmk4NmFpREZkWnFxWkJi?=
 =?utf-8?B?MVM5Q0FVNkZkeEJUWGUwaEVsdFRzVEhNeU9Ibm5KY3lXdWR4WmNUUnVyKytl?=
 =?utf-8?B?eVBrcUwxUGc0dlVrOU1NNWhaZGNyT1k0L0hzY2cxOUJMdEFYZjlVS09qS2xk?=
 =?utf-8?B?Vi9NS2VVOThJL1h3R0ZHR2hWNExyaGJkYjBrZDY5Rm1xM1FUVGJHc2VtdEhD?=
 =?utf-8?B?bWdvNEE1T3dxMzVQUVQ4aWY4SnkyU01xL2FyWmdlUmRJQkxvVzlQRjJHWllt?=
 =?utf-8?B?K01xbGs2ekE5OXpVV2NKSkFBZm5HZG5LS3VORGRIa1RjUkZUYkNuNVZzejBj?=
 =?utf-8?B?NU5NbEtOZ3F4Y013OVA5bFZlaXVpR3pGQXY0QmhUSmNLQ05JbllkanJYbmpE?=
 =?utf-8?B?MVBMQzNySXBlcisyWWcxTHVmdnJiUVFzYmtPUjdNMThzWVgwaWpkMng2UlI2?=
 =?utf-8?B?NjJCMU5CejdHWUJTeUN6K0RtamFTbzRFNzQ4bHJORXlGTEY4SDN3RGZWUWs3?=
 =?utf-8?B?cEIwbCtpUG5HWTFNUG9oc0x3TW1hNExnWVN1WFFxVzNRL0ZEUjg1R1RZS3py?=
 =?utf-8?B?b2RtTXNsVmppbHB6c0RSby9EbjVldXBuZ0FrZVlFZmI0Q1hQT0Jjay9zNi9z?=
 =?utf-8?B?U3dVNlN3WkRjYjhMOWx3Zm9SSzc5empsSEFXVjVsTjJzTGtYRFBRNHh6cDh5?=
 =?utf-8?B?RU5OZ2YvRlNBNDlhWG9pa1V1bW9rNlhWWHdjNHBYWTF4UXRmZzJBNEZuaFo0?=
 =?utf-8?B?QmRhWml3eEtDeVdpVUVManVzNURRanorTk1ybDhnWG04VjhsRUJrY1RobEpW?=
 =?utf-8?B?eEU3Qm1HSWJobGFveWVLOVVRZmRmaTJrdTFTejFWQ1E2TGVWWU9qb0ZUTzJx?=
 =?utf-8?B?aklHRGpKNlArdkM2SmFTTGpiZG9tczh4eTJFOGdFY21RbjFCOStMeGE2Ym9S?=
 =?utf-8?B?ekFPYnV0TmZoWWNVSFlCTHg1RHpyUUN6TWZMVjhFMHpNaXZLdFlYcndGYkpY?=
 =?utf-8?B?cUdZZmw3VDhmQTVMbWdkYVN6QlR3cTZlcUpJVndGWm5kcmhtTmxXRTh0cGt6?=
 =?utf-8?B?TVpVUktPWHIxK1Y0K0dUeXRRS3kxTzBOVTE5L05qQklpSlFYaWpXaVBRUzVS?=
 =?utf-8?B?ZDJDVTlGNGNMMEpHS0pBSmF5WGgwempYKzhrSkZURk1zbmRxS3VMcDE4WXBj?=
 =?utf-8?Q?XwX/dlsy0lfS4L6z1keQUpZC1h5kGXEM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qit2ZlF6VkhCcTZWb3EzODNwbHlqU1YzSENITDE4Q2ZxTExxaDBxNXV0RlBr?=
 =?utf-8?B?MU0wNFR2b09adWlsbnVIK0NlYU1kbnhmVStkYkcyYmxUeU54VnlpTEVsdkxE?=
 =?utf-8?B?VHZoczFlanFpakF0dk0vaGE4dUVQUVVhQnJFTFExZlp1UldrUkRDSE9zQXdM?=
 =?utf-8?B?WW5kNGEzQkhRODRGVGw2SWt4TWIydWlwdzR6YkJNdTNNU0NUMk1EOGl6c09l?=
 =?utf-8?B?WjRiVkMvNHNEZTRDK0pvTzNSZkFIYm9BMTIxK1Y3dVJaeDNZTUo0T1ZSeEQ4?=
 =?utf-8?B?WEI0WEtNMEVBei96eHJaVG1UNTJ6VHhwNmRTS292ckNqa3ViK1BqZnNEelFz?=
 =?utf-8?B?NS9kT1lRVlVIT2kyNlIxWnJLdC85WXJUT1l1RTZHNUJxcm82RDEwM2lnU2hZ?=
 =?utf-8?B?OUxKTUZmQkN0Mi9Yb3pJYjJ0TVRSRFNRTXlGM0dzY091TXFMbU5uZXRlSi96?=
 =?utf-8?B?ZERVZms3OUdCTGNiNGVaRkxvTVJYTExsTzRFVmZVTU1pM0Q1cDk2ZWtiNXJ2?=
 =?utf-8?B?UEZrdW9Zb2dxVUFzMnhDUE9pcXpFcGdOM3I5SnowNjE3cW96UFRVVjFkQ2gz?=
 =?utf-8?B?ak4xRXhJMTFNS0luNHJHOWVJN0FZOEdTT04wclFtN2VhNkFPL1BKRTFmR2dx?=
 =?utf-8?B?WkNjUVdtOXB4VUY4aHQ2UFRFVmsrVjJSVHY0WDhlZHljNXFDR0ZRak1RMDZI?=
 =?utf-8?B?L3FZckJuZ2J0VUswMmpoS3l4TWt5YUREd2MxbEZ1cE5QZXZIUnc0TmhHRkpp?=
 =?utf-8?B?cDhCTUx1Y0taNzJ6OWFUcXJhYi9ka3UyYkdDd2QxU0ZoMnA1aGw5ZjFDLzFx?=
 =?utf-8?B?azg4SEVybXk0RDVhUlcydXZNUC9OWVVzYmxxZ2NOSTE3NG1USlNFdjRBSDZZ?=
 =?utf-8?B?N25MOVN2MVJwQWhjS3p6TlhmQy9IQzBadjFoTFVKUzg5aUdTS2EreGwyR2wv?=
 =?utf-8?B?RStHL1pSS3VPWW5WV3ZCeHBDZGhjY0gydE05NEJpODdVdzc3UFkrZ2FucE9y?=
 =?utf-8?B?Q0psL0lhQWJTcUxNS2llbHpxKzAzVkRlN3NYZHJUcjQzelZHUHFyMEJySTVm?=
 =?utf-8?B?TCszQ2YxQ3EyNW8rRmgyMjRYdnRGRFNySWh0SEd0Y1ZQS3NYdVZqWFlwb080?=
 =?utf-8?B?dVl4SEZEVkhwZFVoak5ta283aTNTV2pKWGVidXhQVFBUV21obHZ3eVhiSW53?=
 =?utf-8?B?UnIraHBkWGlXZU1kU2lOcVVUSlB4blFkMFhRWk4zbTNQcFhXUzAyYVpZWm5J?=
 =?utf-8?B?Tjk0UjVxSEpsWGNWcjFjWUU4OG9WVXA1SGJHbkcvRUZNQW1RYkM1Y1hUZ2Qw?=
 =?utf-8?B?VmxzRjQySGk3ZFA5TG5MUUpTYlhDZnk2RE1DbVNZMnhTT0drOWR1cy9JcWV5?=
 =?utf-8?B?Z2dtZGJTTVdEVXhTRzZYcFJVRjMrK09WZWc4WWVWS0lyeUZka3pkYnRQU2FC?=
 =?utf-8?B?THd1ZHcvSlNvRDV0bmZRQjNTUXlXTkxFMmlhNmZOS1lRUFAreTdaZVAzRGF3?=
 =?utf-8?B?VHJkV1ptWGVHeG1GV3pESUc3WURCaFVVZDJOL2VmTTlRQkZFejlKd3ZyMitV?=
 =?utf-8?B?YjV1MCtUYVAyYXBpVEJjL3RacHNrOGIrcWR0ZklmQksvOXFyTkZ4OEVuZFps?=
 =?utf-8?B?NWpmNC9NbmpZZi8vRnovd3BTMTVsa01GTFlpbFZCcUZTdFQwYWFld1p5bzdH?=
 =?utf-8?B?ZGkxUmZCNWREbUU0NDhldlhGeTM5RVJEc3l6QWpMYStITzJSa1d5QzV1ek5F?=
 =?utf-8?B?SkpKUnc1ckp5K3E1cDh2T3IvTzEvYkJiMVJXSG5TcWlQOE1SVjhxK3VxRis4?=
 =?utf-8?B?ZmlLV2EwM3pYVSt5K09ZK1M1QlltanBsa21CYWxJRUZGWE0yYk5LaldIc3E4?=
 =?utf-8?B?dkErRGtxZUFWdjA3MUhPem92dFgrdHY0Ym9TNTd6bjBDM2kydnVXd01uTVhl?=
 =?utf-8?B?WURBYitOekl1LzZ3Vm1Rb1NPY3lIMGlrMWR2TmM4eU9RYnhIb1h1TXY1VnY4?=
 =?utf-8?B?dHhFYkdENDdWaTZkaHJ3THNZcllONlNCb2FmZjRCcG4xNmtRTlNJWkdVSWts?=
 =?utf-8?B?TzJ5LzVsQXFMaWdDM1N4cE5tWlJrSnhYZHR5MlZoWWpTdGwyd2FnV1FxK0Ez?=
 =?utf-8?B?VUxzdUlZcHN4dkF1a2IxOEplMW9DS3U1R2RlRjIyYlp2Vi9NNzl0TUYrWjJM?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63075b3-3d23-481c-9d84-08de05d6e10a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 19:22:39.3478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqohC0oqfFnj51UqDFBgvO7+dCMjFYODlYJw0zqciDedJjfCO+5t/Yn79LpdSbQpar6a4jXCGwV0C/EW+AGXWs8Kj7EX7S37M6655BJXS1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7597
X-Mailman-Approved-At: Wed, 08 Oct 2025 01:50:35 +0200
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

Hi Marek, Peng

Thank you for your feedback and suggestion.
I have posted a v2 patch that uses dev_read_u32() to simplify the code 
as you recommended.

Best regards,
Tanmay

On 9/29/2025 8:34 AM, Peng Fan wrote:
> On Sun, Sep 28, 2025 at 08:54:44PM +0200, Marek Vasut wrote:
>> On 9/28/25 8:38 PM, Tanmay Kathpalia wrote:
>>> Convert device tree property value to CPU endianness using
>>> fdt32_to_cpu(). This prevents incorrect values on platforms
>>> with differing endianness.
>>>
>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>> ---
>>>    drivers/mmc/sdhci-cadence6.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>>> index 9a92b8437a6..6f60fee6df4 100644
>>> --- a/drivers/mmc/sdhci-cadence6.c
>>> +++ b/drivers/mmc/sdhci-cadence6.c
>>> @@ -220,14 +220,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>>>    		prop = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
>>>    				   sdhci_cdns6_phy_cfgs[i].property, NULL);
>> Use dev_read_u32_default() or some such function from drivers/core/read.c ,
>> that should greatly simplify this code.
> 
> + 1
> 
> Thanks,
> Peng

