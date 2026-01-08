Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB0DCF6BE5
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 08:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50AC83B8A;
	Thu,  8 Jan 2026 09:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Fjw38VUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DC183BE1; Thu,  8 Jan 2026 09:08:12 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223D483B0D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 09:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1gpw5iXbwiIH5XFyTYSNqbv0zlcq45w30gJ6f5ih5k7NNPPYARrXYLSr+C/m+EcrDQ/1o9IP0ToeWiNMXAZpayEGCvQMxs+buG3j0Sf8egzyKTkfIxIOnAmwae0i8QIkYdFd3b7A/fz0bRac2LC9V/YseVDTZ51/vNPX9ETyH16wHzRN8D++gpm2Z/VscOpC+TJgEBfGI0gSYAn2TH94EHB1QHhADYZe2pNJ0lMuObnxf6yQU9kj09sr8U7nlcmzAGScbmRF4I55+G2eBRK18eKyvZh+JUKXaPyDZUt7kbX5fO39Fr7cLvK0vF+/XriPlK1QlZQKUgQGxMD1hGeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yza8y4CWkIIEM1DE61Vx0y4hzzBRMbE5aZKc8JLiwyQ=;
 b=pwwyTnWTPWD96TiPagoqdAE/IoLt3fVBJdrtd0rM6HvW5AHr5sXmMlPwT2AqjzrS80xt7N2N2YvroQ2GHzlw1y4qqx+rXVNjW94wjYeXKCVlcmdDo4CxttAN+x3+v7XjTy9TZdA30hUhszEhRN/XflbXHR1a6R46vsn0iU2ystDlpIGStAZh/GAzVR3zZsdJhQeR1+fkbeNMnAOHxVMUxsDk14iAPC117eneouJhj5Q4Bi5mBRh9pHZSfkyU1m8hwqCCqjVZ8Kcqu5KkOss2aKMQ8sWjJixuBowWXb2SNBA3bRB58eUyp5ipr7rLa6fJOMMx9QiVI2ZfrTnzXLQ6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yza8y4CWkIIEM1DE61Vx0y4hzzBRMbE5aZKc8JLiwyQ=;
 b=Fjw38VUFtzvd7cHBD0M9fn0fzNbpoWttvQcefVRP6aAyW61ARdb3AlcZvc7m1rbY3k0OPdit7n8sCPI5HqdOaGXkI4QvCLHxTBPM5RkI1y52dyfVMR5OtqUBG5MZEHHUEYmujh61xqu8ig2rkbyp2tspNQK+/WB8ewplpbj/9A5qeRrvZuomRrhvP9PVJPSpFIJlkxMT9N2l39cc2vnvBvnsw/NJePf8/d7Cc00EDM6fAVxwWrFOfmMZEI/BTGvm03gpIlvrIC82tH6jZqRb4l7eMyHB/tI6/QBXMrgzwiXChpQD9fdxs/0QmqECASnNpgAIh36xBB3FeCfAP1WvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7878.namprd03.prod.outlook.com (2603:10b6:806:42e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 08:08:06 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 08:08:06 +0000
Message-ID: <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
Date: Thu, 8 Jan 2026 13:37:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Max Merchel <max.merchel@ew.tq-group.com>, Vitor Soares
 <ivitro@gmail.com>, u-boot@lists.denx.de
Cc: vitor.soares@toradex.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: f18d1328-fd89-40ba-83e6-08de4e8d0db8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2dKUmc0YTV5ZmhDVGhDNkpMdzRVVkY0K3ZiSURMVjFSN3VTRFZSWW1BU0NC?=
 =?utf-8?B?aDMwZ2xzSHc2VkVGRHhSN3J1ZVRWdGF5dGRkcWJxZEFHRHVwcWY2d1FGdmlI?=
 =?utf-8?B?N2dRdG1mbkc1d05FVzR2VFpEOFVBWWtodmU3Wld6NVFNUytYUVJhY21LUjlD?=
 =?utf-8?B?ZW9tV28yZjJWQklMNlh0VDd2ZDdNRkhLR1Q0ME4rMlNKNS9KczlSMGJqTUdK?=
 =?utf-8?B?RU50WjFCdXNMNGJlMzdVWGxFY3ZZZ2VpQTF6YmNWem1VdU5CbCtUVFZrMElK?=
 =?utf-8?B?NlFsR1V5V3VWL2Y3M2NCL1A5YWE2TlJ6WFMzWjFVVnRIKzVkNjBrbmQvQmxi?=
 =?utf-8?B?OUtPK2VsWEg5UlRSOEl0MDdVNDRIMnBFVTVFL3MvdjNhRzBPU0RQSnVqTXNM?=
 =?utf-8?B?ZFZLYktWclJFRnZFeHQrcHdhM2RPcWlVaEswcUFXdk0yQ1NWWGpjTlBIY0NY?=
 =?utf-8?B?Rk50d2RRdHNIM29MZHI2RXZ4c3FqYkR4cHhibXRzUVB1cFkxR3BQWmhyT1dW?=
 =?utf-8?B?SnFWaU9RNzgvbnM2WVVwSm1FaWttVklodjlWcmxIZi9mZVhzbEptVzNncVhK?=
 =?utf-8?B?M2JKNFVseGpGRkx5dDdEdUNxaHdLbHNBYytHZ3BtZVExUjFiWlVkVmwzMHhN?=
 =?utf-8?B?eVptZmpCbmQvZGFKT0VpdXR1SGZndUYwWU5uKzU1elZKQUczY0tPK01GcXRn?=
 =?utf-8?B?RGNkZlVFV2JGcGRQUVRaejZxN3MweThCcDRxeFl0b0JMVzRRbHVWcTI5enln?=
 =?utf-8?B?alJGL2g5Skc0THNxam84SmM0cGFpY0NISjBBdWY3SXlpZzBYcElPeDNZc2FN?=
 =?utf-8?B?ZGRWR2xVUzNRbkRLSC9wTHVCdzNWaHdzaGtXeFdtUVM0b1JqeElLdmN1UnFU?=
 =?utf-8?B?OTVhM3VsUVdpSk80TlZUMTFibjRYTXloYVc3VHZDQjdEaUxla0xOTXFYMlE1?=
 =?utf-8?B?U2pXLzRVN0ZBa3dTVkZEdnhpOUNQTDNrQzdlbVBEVVBPUnNJOWRnclFqRExr?=
 =?utf-8?B?VlpNWnI5Y1RXNEZlc1hoQ1FzNDcrcVBaUzIwWlM2NEZpaUNPVVB2MzdZcTEv?=
 =?utf-8?B?K0dXK2x6NzZ5eS8vUk5laDMyYkcrb0tkRy9NV0phTnNqdTE1b1FQcnZFekVr?=
 =?utf-8?B?Mjltd0UwZG5vUDcySFl4V0Z5YVBRRTBsMTRnMnVIeTR3am03VlgxektrVlQy?=
 =?utf-8?B?ZVJCcEVEVWpkdGlON1p6dGRGYVJJVWExd3FmSEJzRUwrWkxDVENoK056OXQr?=
 =?utf-8?B?NEhVaktiWlFoOGxCWnJQTURUbGpncXk1RDVsU29nZit6Nk1UN1hWU3M2d0tw?=
 =?utf-8?B?QUZFOU5LcEFRcTFjRkk1UUs5eE9jWjBIVitGTG1lYU03U1BGVk1nK1pnL214?=
 =?utf-8?B?OWl6dEdYeUZJMHE3UHIzUmpacUxMWG5qdXlsUzgyd3FWQWcwK2Z6M3UrTWV3?=
 =?utf-8?B?NytzenV0ZDcrY1J5WUtSQUxvckxpa29Gd2hIa1M4TmIyRnhDdWFhOUo0TWtV?=
 =?utf-8?B?QUpQUGtpOW4wNEtHUE9uZXhiT2pZQ2loVWt6aGpJK0R2OE9BY3krK1RCbkFa?=
 =?utf-8?B?VDVvaHJVcEViQTdoSTRLUG5SdThlbW1qM09ZSC9paHdyUmU2aHBQcXlDdDZl?=
 =?utf-8?B?NFNZMEVUQjZESmRIOFBZNGlzV29zZU1OQmw3eFhhLzMydG5USEtRcVZWUWxj?=
 =?utf-8?B?MlBkNTlGQnBUYUdKL0Q5L2VvQzVsWWNROTBGY3ZndWlUZCtxdythcjZLUVR6?=
 =?utf-8?B?MUtLbmhGbHB1c1lIYnllLzZucC84RWNJUVFYTlMxcVpzNDk1QjZMWlFIVHVn?=
 =?utf-8?B?T1RsZmgrendxM1ZiY2ZRM2dPR3dmeXdoZFpqcUdRa25SNTZlREIwRGpyd25X?=
 =?utf-8?B?dFllM3lONzZYSlRYeTdKY05KTTMxYkVrTXY1Vm9jWXJONldlUjAxVHJqdTlZ?=
 =?utf-8?Q?a4a4VtuECoi4F8elIUPE8zyhbxYsyeHh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZkSDE4amN4QTUyS2s2WUhnVDVSQ0ptNUxQK1kvUEZ4UXVob3FVbHFvalRH?=
 =?utf-8?B?RmpId2dHclR0QktpN2ZYWXU0ZnRQTUlvWVA0dVZ2ZlNEbmdOa2l6VUtUWklG?=
 =?utf-8?B?d1RBVUVFOE5KYkZYK29HUk9yM1VONldLdlBQc1ZTc1haNXZDVFhvZXhsN0p1?=
 =?utf-8?B?NURrZkd1Y05QaTlGaHBvRER4MGFOZXc4cnlPaDZKVHZiRXp4Mzl0a25nRytH?=
 =?utf-8?B?bi9XZjBTVzNNV05iSDdHTy9zbEVFMDBRcW5iZTBESlVSK1JjSDBiRWo0d01H?=
 =?utf-8?B?c1ZoM0ZLVjJldWtObFBpUVd3YVJ4ajFSd3BNUjZ6MmJFWVdoK1loM0dDOGhM?=
 =?utf-8?B?dWVrY2J0bHFrZDc1M0NhRFZkaTh4VWNId0xuckpBaitoS1BrN2t6VlkzNks3?=
 =?utf-8?B?YnN5RWpSSklhMEpESUdFRHdNcnl0SzJXMHp0WVpxY3ByUGRsZVJXMVhZdkRH?=
 =?utf-8?B?OTBEMWpVcUFWRFFLNjJVeXZCak15VEhPbDAvVDd5K1BoN0xaMm5YSmxJN0hK?=
 =?utf-8?B?T09VNVUzbG0zcm5JNWF1Vm1JNitMSGFNa1duR0xhMWl4YTV4TERRNXMzZ3dy?=
 =?utf-8?B?M0JqOVQxUjBoNFk5d2c5WXp6NlcyNkdlcEJKRjlTSWRTTEh5b0xqTjRnQ1N2?=
 =?utf-8?B?MHFHRUM5UVhlZ3AvdFI0QWV0aUJRQnBSU0VJNU0yNUJveWIvR2FicTl0b24x?=
 =?utf-8?B?WmwvZC8xdE1HeU9ZWFJyY0Jrc2txTFFJRitzb3FsNGlwcHVWTjB2K2FsTUo3?=
 =?utf-8?B?d1NuNHFUUmYwTk1WSk43UFpPU0YzSi82RXcwUFFyNThGVE53Y1JzemkrSEQ2?=
 =?utf-8?B?TWVKTE9NcFFPZTJhSk1VeVdyckdDWU5VdlZTeGhnQnlpanZmY0E2UTNEUzZU?=
 =?utf-8?B?M0t5ZHh6RDA1ZTZ0djdMM01hV3I2T29yTERrU2V6ZVRSZTczVEVSTTI0anZ4?=
 =?utf-8?B?dUVYYzJsRjFTQWNnQllqalhlTkNZNFRtU1d2NXV4Z3FPTytzbnAxZFN3Wktw?=
 =?utf-8?B?Qmk0NmxPTldvZzN0NnV5V0RLQ29OYU1IU2RidngrM2xuWHAyYW03TllpbEtp?=
 =?utf-8?B?RlpSUDM0UDJPUWRDTnIvcHBaUmFBS1laU0c3bFNsekU2Y0praDlhWUpvYU9i?=
 =?utf-8?B?Z3lPSDd2akNZbHBGc1dxcEJlcG8zUWFwMWxnOVdjMGQyekhqaUtDZlpDdit1?=
 =?utf-8?B?T2tMZkQyQ2daL3E5Rlg3cWI3UlJvaXRYWnF3ZjFOeVBqQ1BodWVSdy9DVGxh?=
 =?utf-8?B?RWVkeG1JUUtVUzlKaElJd3pHaDZ5WUpJbU5JQ2VLRjJjUVR1bWI1cXFCWTZu?=
 =?utf-8?B?VEk4aEE1NWZvQy96cFFWNlVQbkNqM2kza0RxM0RTcEpCa3JIblU2YkIwckRN?=
 =?utf-8?B?VUt5eFV4aDRINThHeUhXM0xHeFJ1bEZtUnFyWTlSL3FlYXdHcHNRaVA5Y2VN?=
 =?utf-8?B?YW5WTjJBNGlLbzVhYkVJdDlZMzhUOEo5Z0pnUjN5eGNrMUJtWEV4bSt3YUsr?=
 =?utf-8?B?ZWcwVTRkZGozSVZXKzhON01BbHlDU1c0VEI1MmZGQU54RWZPWVRkVmpXenhB?=
 =?utf-8?B?SWNHOXk3bkI0NDFOMEFNeG5zWjk1YkRrWjFDdWgxSE82NEljRE9ZYVhqdSta?=
 =?utf-8?B?MGRvUlBOUDAvVjNnZnIxeWY2QUp6VlJKL21vZ25iVDE5SkZ5VGFCaCtad2I4?=
 =?utf-8?B?SWFNYUtETEtuaU1TT08zSWUzTmNBbG9HZU9IckJ3aE5YaWplRk5sTzBqaXVX?=
 =?utf-8?B?aURoancxcjZhaUFRTjNydzYvQ2lxUzJ6TENrVGVJa1ZzamNlWW5BRndDVXo4?=
 =?utf-8?B?RFNqM216R1Q3bjhQWE8rYzRtRGZOdHhlSEU3Y21XTldyYi9QZ3FBeDNQZHYw?=
 =?utf-8?B?MGJ5OVRVNkJwKzFlZTFhcHNyV0MxR3hQUjFTUWJJOXhyL01PYVZ1VTh4cUZj?=
 =?utf-8?B?bVd1SUpWOHNIQitpN1EwWDR1RUVGdE9VK3drZ2o4Mk9WcW9rclBtaXFDRENs?=
 =?utf-8?B?UFJaNUY1ZFJ3ei9YcWZaaE1VRzlRWlVvNEF6b01aTzNoQ0NPcVZSckltc3p2?=
 =?utf-8?B?MzRCbUEzbGZYVnVkY2l5VmlZczZJZEgrUldIMG1aTGVUVllUODhGdnRMQ1ll?=
 =?utf-8?B?KzIzUzFaVEd2d1lYK3pENCtqUG5xdEZOWlhqcG9ZM2ZQRXhoQnF5ak1BRWM3?=
 =?utf-8?B?a3ovMFJSSktreDN2UFJFUEhqaklOb0FYeklBR2xlZmZuaEZqN1ZaNUw1aTc5?=
 =?utf-8?B?cVpLVmNkQWZpQ3ltay9JS2N0RU9KSWZoSks4ZktLejZXK2hUb0pCRWF0OXNU?=
 =?utf-8?B?d1dXbW9wVFZLcWhCQWlncnNncHE2Q0hOVi92bFFXclpTcG5qQVlKWWlyaUxy?=
 =?utf-8?Q?Mg54UqTv6+PADbtw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18d1328-fd89-40ba-83e6-08de4e8d0db8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:08:06.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXFIQvSqzu/AMrDh2K4RX+y5+L8Nqw5itposIK2cK6859e1VE7ciXF87jo5qJR9rtIEfWeTvpdbpYBGjbuiPlym52MJHS45paC/q7y3+9Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7878
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



On 1/8/2026 12:32 PM, Max Merchel wrote:
> 
> 
> Am 08.01.26 um 00:15 schrieb Vitor Soares:
>> Hi,
>>
>> U-Boot 2026.01 fails to initialize MMC devices on multiple platforms
>> with "unable to select a mode: -5" during mmc_select_mode().
>>
>> Affected platforms:
>> - Verdin iMX8M Mini (SPL boot failure - cannot boot at all)
>> - Verdin iMX8M Plus (MMC init fails in U-Boot proper - cannot boot)
>> - SMARC iMX8M Plus (MMC init fails in U-Boot proper)
>> - Verdin AM62 (boot failure, no output)
>>
>> All platforms use eMMC and worked correctly prior to this regression.
>>
>> Bisect results:
>> - Last known good commit: 228810d0bac3
>> - Known bad commit: 36aeeb591b0d
>>
>> Between these commits, several MMC-related changes were merged. These
>> seem particularly relevant:
>> commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency from device 
>> tree with
>> default handling")
>> commit 1e40e419aeb2 ("mmc: sdhci-cadence: Use max-frequency property 
>> from device
>> tree")
>> commit fa7e82127fad ("mmc: sdhci-cadence: Set controller and PHY speed 
>> modes for
>> SD and eMMC cards")
>>
>> Could someone familiar with these recent changes help identify what 
>> might have
>> changed in the mode selection logic?
>>
>> === Example logs ===
>>
>> Verdin iMX8M Mini (SPL failure):
>>
>> U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 
>> 20:44:27 +0000)
>> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s 
>> timeout)
>> SEC0:  RNG instantiated
>> Trying to boot from MMC1
>> unable to select a mode: -5
>> spl: mmc init failed with error: -524
>> Error: -524
>> SPL: Unsupported Boot Device!
>> SPL: failed to boot from all boot devices
>> ### ERROR ### Please RESET the board ###
>>
>> ---
>>
>> Verdin iMX8M Plus (U-Boot proper failure):
>>
>> U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 
>> 20:44:27 +0000)
>> DDR configured as dual rank
>> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s 
>> timeout)
>> SEC0:  RNG instantiated
>> Normal Boot
>> Trying to boot from BOOTROM
>> Boot Stage: Primary boot
>> Find img info 0x?, size 1208151552
>> Need continue download 1024
>> load_simple_fit: Skip load 'tee': image size is 0!
>> NOTICE:  Do not release JR0 to NS as it can be used by HAB
>> NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0-dirty
>> NOTICE:  BL31: Built : 08:15:07, May  9 2025
>>
>> U-Boot 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 
>> +0000)
>>
>> CPU:   NXP i.MX8MP[8] Rev1.1 A53 at 1200 MHz
>> CPU:   Industrial temperature grade (-40C to 105C) at 23C
>> DRAM:  8 GiB
>> Core:  309 devices, 31 uclasses, devicetree: separate
>> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s 
>> timeout)
>> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
>> Loading Environment from MMC... unable to select a mode: -5
>>
>> Verdin iMX8MP # saveenv
>> Saving Environment to MMC... unable to select a mode: -5
>> No block device
>> Failed (1)
>>
>> ---
>>
>> SMARC iMX8M Plus:
>>
>> U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 
>> 20:44:27 +0000)
>> Training FAILED
>> DDR configured as single rank
>> SEC0:  RNG instantiated
>> Normal Boot
>> Trying to boot from BOOTROM
>> Boot Stage: Primary boot
>> Find img info 0x?, size 1208152064
>> Need continue download 1024
>> load_simple_fit: Skip load 'tee': image size is 0!
>> NOTICE:  Do not release JR0 to NS as it can be used by HAB
>> NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0-dirty
>> NOTICE:  BL31: Built : 08:15:07, May  9 2025
>>
>> U-Boot 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 
>> +0000)
>>
>> CPU:   NXP i.MX8MP[8] Rev1.1 A53 at 1200 MHz
>> CPU:   Industrial temperature grade (-40C to 105C) at 23C
>> DRAM:  4 GiB
>> Core:  317 devices, 32 uclasses, devicetree: separate
>> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s 
>> timeout)
>> MMC:   FSL_SDHC: 1, FSL_SDHC: 0
>> Loading Environment from MMC... unable to select a mode: -5
>> *** Warning - No block device, using default environment
>> unable to select a mode: -5
>> MMC init failed
>> ---
>>
>> I'm available to test patches or provide additional debug output if 
>> needed.
>>
>> Best regards,
>> Vitor Soares
> 
> Hi Victor,
> 
> what frequencies are output when you enable DEBUG output in mmc.c?
> 
> I'm currently trying to find a solution for why the SD card and MMC in 
> U-Boot (they work fine in SPL) are only running at a minimum frequency 
> on the TQMa6 (iMX6) and TQMa6UL (iMX6UL).
> 
> My problem comes from commit aebb523a2381 ("mmc: mmc-uclass: Use max- 
> frequency from device tree with.
> 
> 
> === Example logs ===
> 
> U-Boot SPL 2026.01+g6955caf8885+p13111 (Jan 07 2026 - 15:26:17 +0100)
> SD
> Trying to boot from MMC2
> clock is disabled (0Hz)
> clock is enabled (400000Hz)
> clock is enabled (50000000Hz)
> Device tree: imx6q-mba6a
> 
> 
> U-Boot 2026.01+g6955caf8885+p13111 (Jan 07 2026 - 15:26:17 +0100)
> 
> CPU:   Freescale i.MX6D rev1.3 at 792MHz
> CPU:   Industrial temperature grade (-40C to 105C) at 20C
> Reset cause: POR
> Model: TQ TQMa6Q on MBa6x
> Board: TQMa6D on a MBa6x
> Enet workaround: Unknown
> DRAM:  1 GiB
> Core:  104 devices, 27 uclasses, devicetree: separate
> WDT:   Started watchdog@20bc000 with servicing every 1000ms (128s timeout)
> MMC:   FSL_SDHC: 1, FSL_SDHC: 0
> Loading Environment from MMC... clock is disabled (0Hz)
> clock is enabled (400000Hz)
> clock is enabled (400000Hz)
> Reading from redundant MMC(1)... OK
> In:    serial@21e8000
> Out:   serial@21e8000
> Err:   serial@21e8000
> clock is disabled (0Hz)
> clock is enabled (400000Hz)
> clock is enabled (400000Hz)
> switch to partitions #0, OK
> mmc1 is current device
> 

Hi Vitor,

Thanks for the detailed report and bisect results. I've looked into the 
issue, and it appears the regression is introduced by commit 
aebb523a2381 ("mmc: mmc-uclass: Use max-frequency from device tree with 
default handling").
The problem stems from the probe function in the FSL eSDHC driver 
(fsl_esdhc_probe). Here's a breakdown:

First, fsl_esdhc_init is called, which sets cfg->f_max to the minimum of 
the controller's sdhc_clk and a hardcoded 200 MHz limit:
cfg->f_max = min(priv->sdhc_clk, (u32)200000000);
Subsequently, mmc_of_parse is invoked, where in the commit if the 
"max-frequency" property is not specified in the device tree node for 
the MMC controller, this function overrides cfg->f_max to 0.

This results in f_max being set to 0, which prevents proper mode 
selection during MMC initialization and leads to the "unable to select a 
mode: -5" error you're seeing across those platforms.

A potential fix could involve either:

Adding the "max-frequency" property to the relevant device tree nodes 
(e.g., setting it to 200000000 or the appropriate value based on the 
hardware).
Or Revert the commit aebb523a2381, since platform data from 
dev_get_plat() is calloc-allocated (zeroed), so prior behavior left 
f_max at 0 until the driver set it—restoring the hardcoded limit.

Let me know if this aligns with what you're observing.

Regards,
Tanmay

