Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A918AD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C3783B48;
	Thu, 11 Dec 2025 11:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PVL4qu4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828B983CB5; Thu, 11 Dec 2025 11:29:18 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EE783642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzYcv7+XOi4LpbW+v6imkHTCswzjldKSSHt8UcilnZKRoEYPUlHxo5rjUl5rLmYQ4fIje4D9Pn5ryBa0qbegTSvh5iM8hpFhIdAvW+o6UpMueeXkBikWVa9LgcLQ6TF6YsZPiAfQjNaXUfxuE6Y7tBU6L4mr7yqbCjUy/UfItld/jOD5vb+7tldQCgqL9eMxADWzGjTz9enRToQm1gsntB5P0tFi2QhDtJeVSf4G0giHm8oeifRSiuD047079wV/Vm+/m2fm1sSkhAFYBRJgym1pCIYmBtT9CEgy57LbuMW9n3PjNRMhBhER5SJIzibz+CqhQbO2zpQyE/zD5OTBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU9MULnEw0cOkFz+T2xF7qxDfBM8gzWETPcOhz500Fk=;
 b=Rs1RvvB2l4cfV6t/uzXcsCqxtSHSgFoNIiQaqjCbvrdA9WStYfFrurbYlDt1cPUXfCSY3CC0ydACh2C/a6GgbOPP2mHMTo7rPLzA08PQoabskP5P0maKdjTwnlBr/Tl3CVfJ1uGLfbbjiohwfXwjMAXV0QRiWD35neW5tN0LRLshciaa6keq3cT9By1nVEDRRhzSwgw49nXxW67FBY6B+OhZePCAZ0UUUz7DUe2FeC8yaJopy5a1ckdOYxkZalgZogYu7LucEaqq38k+hB7+Gt2dWFE9D6VgSGlPohNEpwWhxE+IxxjpsZHsRb98rG9iAXXqhLvEoK6hxfmllpic0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU9MULnEw0cOkFz+T2xF7qxDfBM8gzWETPcOhz500Fk=;
 b=PVL4qu4AzmM4+J1KUm7i2s0TZD6zjw/ZDrHsTgyS26B+DCIEFg4KWzt02jhijJGvWGmqBDJiUqLQ3R5p5w6snQ525hAzK4EpWg67rx09cG4hE6VOonr4m++KO1jaCLr3KxkMhqtdjTogGKjeu1fDRxILsl+F+K9Lg5EdrDf0gTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 10:29:09 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 10:29:08 +0000
Message-ID: <3ed223c7-a520-4be7-83cd-608e6ab52e0b@cherry.de>
Date: Thu, 11 Dec 2025 11:28:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: ext4fs: Free memory while handling errors
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB28057B9D4D4DD62897778E7BDAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <BESP194MB28057B9D4D4DD62897778E7BDAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0f6de8-1265-4fe1-83fe-08de38a01e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2psWVNIRXJHQ1FpZDJhck1kM1c3bXVaNzNFaER5M0hWd2puMGJDVFhSTWlv?=
 =?utf-8?B?MHZ6NzkyNXpaUndpMDg3ejJnS3A5Zm5RQlM0V1MzK1lORWJnMU5KdkNPQmRa?=
 =?utf-8?B?cUZSVFR4ZW5SY0VQUHoxK2o3TEdtendzNVpnRUF6blBycUJnZmxXeWpNWHlP?=
 =?utf-8?B?dEJpbEhhSmo3bG16SGdxYTYwOGlrK2Y5NkxFMEJMUGxUcElRbnZsTEZhRUk5?=
 =?utf-8?B?cUI5TVptaFg1VzdvTjRXV3RvSEhjcytyOVo2cy9KTEJjaE85eTFxazAvcXJZ?=
 =?utf-8?B?MExhS0J6Z01GT2xnTWZHVzRRTk11aUZCZHRaa0cwUEFkUDEzbmMxUjVnbkVT?=
 =?utf-8?B?dWZySnd1OFFaMXZXYk1nT1FlYXNOdHhqTk5IaHRkamYyd3dkRHh6VmwxYjJs?=
 =?utf-8?B?VUFDNG8rQTNiMDBoODNOcWRHZmVGWlNTc3BSTzVYRTdGRHJ2RnRncXllYWtr?=
 =?utf-8?B?ZDhmWmxrTjVVOXJUU3JxdlhFU3lOUXptL1FiSGFITXBweGdkQjY0YnF5OXd5?=
 =?utf-8?B?Nmc1ejNOM095MmtQV3l1NUgwZEVINnQ0WS9oSFVPTGVKMG5IOW5KWVBaV0Nn?=
 =?utf-8?B?RmFrRjh4QS80cDJhbGd5SUF6OUUxODN6MFgyVExTWnpjemFnWlRYSWE5eUVJ?=
 =?utf-8?B?WnZ3WWVaNnlpNlhJaytKbEJVRkVIU2dUcmNHNjZyM3I0eUNQVkJsT1dGMlNL?=
 =?utf-8?B?dTZ4OFA2RzZKMUt0TmxsdkFZWkNaQW0rbGJKenBvTHZ5RGszZ01sZFBOQlFi?=
 =?utf-8?B?SU9FekhvZmpoZG9zbS9BOVROaG5vQjVZVmxydk5xY0dkZDJ2MG52eVpHUTJK?=
 =?utf-8?B?Y0F1VTk5VUZVSENTRk5UbHlGd1BwT3U1NXU0eGFUblF4YjJmRE9jRVYvamlt?=
 =?utf-8?B?WkZ5YndlYU9ab3FMZHZjNjRvNnloUFg5Uy81YW1BVXMzY3BqOU1vZW5nV2lr?=
 =?utf-8?B?WGszTTdweTZIZFRneHRZY0g2a2pWU1VLMVZhbytYaUgzOFcyU0RUSXZpTTdi?=
 =?utf-8?B?VTlkak9lWXRsd0RQWHV1UDhVeUk0Q3R4bDBOMnVvZW5WRjliVURzZ1BEU21i?=
 =?utf-8?B?UGd3Z2pNMmcwUitYNlZCUTRwRzNUcEhIRW5BQ1ZsRUpVTHJYZDEyeCtoNEI0?=
 =?utf-8?B?SUJaclY1b1hwWEFZWTZRS1pKZlZxQno4WnlhNW0xNVlOZlZnTngyNUcxNGhX?=
 =?utf-8?B?cDBySlBnekdJbkJXR013dTYxODdaSDBkRXErcm1LcGFMaGxlekFtck9QQnJw?=
 =?utf-8?B?dFQ1dGM1czdyT1doWDlFSTJMT3NYQTlJMWdhVHl3TE03eUNKbm1JUGtnenB3?=
 =?utf-8?B?akx3a1VCM01CK1grbmFaZ1RRZXI3ZHJrYkp6OUVFRjl1WnFHZnZyYVNPM0po?=
 =?utf-8?B?a21uUUN5b0pva0FvUE1VTjFhdGxYS2U5eG55Wk16WEpqT1BvSndTakF1bFNG?=
 =?utf-8?B?RnhXK2NhYkRlTW9KYm9adURXRUJwWjF4L2dBcFdmYmgzeUN1ajNHSVo5b3hG?=
 =?utf-8?B?ZHVOQUs4VlhHYmxJMThTemF2YmhQTjNFR2VETlhQYU5BYjRBOTE4bktlbjhr?=
 =?utf-8?B?d3ZadFJtZmhyOU10VFdZQlJRL3Z0eXZpT0M2MTgzdGlQbVhvdnRmdFJZYnk4?=
 =?utf-8?B?ODA2eXcxVlFhM2pJNXE0VnNqZXdGYzYvM2o0MytibFd5REtLQVBvazg3Q1N1?=
 =?utf-8?B?SDMydlRpdmZaUWxTQ2dEc0U2dE12YjZnZGZJSUhMbFFldEVCNll0aFZEZDJx?=
 =?utf-8?B?STZidHhTNVFqQ1J2VGgrY2pJeU5DWDZpaHNuMkNwK3JLMDhDYWI3dEVlQXRT?=
 =?utf-8?B?cTRaUDh6dUd2S3RXUGhoamttV003N0dvS2FWVGpsdnRNNW5la3BPUXdLRm5l?=
 =?utf-8?B?R1duSFMwNVVyekJHcTZFbCtHbGVvNHhTVzZWQWxIZVNZdCthM1d4TXlBTFM0?=
 =?utf-8?Q?LVRqAiX7EPXutC9/xUk66T8dyhFbe6qT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3F6VGpIOHIxV2VuZ0lyMGNwNVJwYW1pelFQV3A5S3I2THBrd1BNSHJOQXdt?=
 =?utf-8?B?UGphTnhTbWhaclZOSVFIWUxsQ0l6SUJ1ajF0UXh6TGZ4VVdjRW91T2VoRkVp?=
 =?utf-8?B?aVByYmlUb3NkUVJ6d0U5eTBXQVh3N1N0dDhxeTdRMWRoY0E4anU2T0hoQkVY?=
 =?utf-8?B?ZVd5YkxKTXNXL2xOV0d3TnFaSmlyNGJDUWlWMlZQTDF4a3o4bWYwNHlsQ1Rm?=
 =?utf-8?B?clBTQVk5UzczRTdHaGdOUGM2STNINVROelN3MUZOOVliS2pKWXJkSWlvTHZy?=
 =?utf-8?B?K2xzVkcrY3owREx4Zkp4YjM3UVRSZWpoNUhCTUM4Z09oUWkrdnR4Ni9icTAw?=
 =?utf-8?B?QU05MkxHWHhCVnRzeDNHN09aeHpDSkpLQTcrMkV6Y2Z4UEJWRHNlVzhRWENJ?=
 =?utf-8?B?b2UrUGZCSTl6ZXp2c1IvYTFGY3JEYXlwU3R0NzBjNitoMzFrcCtDRTVBRTdv?=
 =?utf-8?B?d2RrRytZNkR5Yk4zTk9icHRKaXV0TWxSMmY5SFF2R3FYa0tXUTdpOW9sb3dD?=
 =?utf-8?B?ZG1hU0NZSTFQaWtlMk53Qlhqd1ZGOXh0Z1AyMnVBUG8vSWdwNVdTYnFtMDVC?=
 =?utf-8?B?eGdUNTBKcWFjQzlvRnRaeVhFL2dpOFJYN0hGdjRuMjNBamtEcGJxNE9JOTh2?=
 =?utf-8?B?YW40dVF4OHZBVUNSNU9maUF2WjhJdzZ1WWtLbjBIN1dNY3gwU1A5MTNIYldh?=
 =?utf-8?B?LzRWc1FvTDNCNmtzZHpybkV5T3BROFlkWlNsMWFxbzlvOHRyeG92QW5MVW9R?=
 =?utf-8?B?MjlLZ2tucDZYOVZ4a1BSaWV0bnBKa1FORjFhcnBZUVpwRXNRM1lITDd2OGdJ?=
 =?utf-8?B?aEtDeXBIRVVTSGNNY3FtbmE0VVpYYlhKdkIxdnR3eWwxR0YzM0d6akRHdW40?=
 =?utf-8?B?Vk9KcW4xb3FuazVQTlNhU1dCMjliUENzSUtOclRHS1dRMWRuc3EwQytFaFdS?=
 =?utf-8?B?NXFEbUU1Z0c4SDRHdktVaUhiZHNjcDhKOFIxaVFFdVFTM08zTmdGb0dnZVF4?=
 =?utf-8?B?bE01c2VkMEhyY2xlbk1mWGJ3MGRZMlNpL01tMWlHbkhPbWFiUUNkZjAwRFZN?=
 =?utf-8?B?TElqTTR0VUZSVm5aVWtKWkdBYXFYSGdJNjZOZEhYSFZRYjNxdjZzZ1JaVHow?=
 =?utf-8?B?S0FPZG1lSXlzZzdjQXk4WE10TVFiNFN1b1BWcUhrMjVkNkpVLzR4UmxBV2hi?=
 =?utf-8?B?MWRwYnl3YVAwVW15Z09BMTNoREJlNXZ6YTc1d2REM1JLc3VnM2tVcjFBRkxV?=
 =?utf-8?B?aDlqVlFpMFk5L1UvL0RtcHZkc3RHZ2ZHYVR1NW9Rdyt6ejNSWFlzTXlRclBQ?=
 =?utf-8?B?eEhNNTMxaTNYckd4WnlJaXJXZ3c4K1pMbjdSelBzZFZnOUczVE1vZUlGMkZF?=
 =?utf-8?B?SEQzWWR3UkdqT292TW9CaGU2UTNuUmorNU45YmJEcFdSdnZYdWtqY2tyRm4r?=
 =?utf-8?B?VStUOTJGRWhYUEc3ZVgxc2lGQTRBeUw5L3JqL0ZjeC84Ui9uMVFlcDZGU1Vw?=
 =?utf-8?B?OXhRdjFYVFpDU3g1QytMUS8rMG1uQXp0ejUyMlkwUytrZ1d3WWhHMEN2VVda?=
 =?utf-8?B?MzVTdkdnaUVBYjc5SnF5Q25mR0JRd3ZLTzdxd3N1OUpoR1FDTXRJaGJ3Sjda?=
 =?utf-8?B?cmhnQXBwVHp4WWdNUGZsK0xYdWg5NVNXOXZWMzdyOUdVNWdLMk1tUGVqQTRt?=
 =?utf-8?B?NzdBZ09ldmxjSWVmb2N4eGlpd1JpcGVXUC81ckxrbFJNd3V5TmNyS3Z1RjZF?=
 =?utf-8?B?bXExUG5QdWMvWnJXOTBBYXVnNkhMUWZxZDJjeWJ5YzhiMVVkbjVTM0F4aXdI?=
 =?utf-8?B?d3psWm5MTnI5ZHlmVU90TmRDMG5WdXJCcHBOOEdweGQzZTZSSjdTcy9zUVJK?=
 =?utf-8?B?Yis0K242bHFYWmVodDBYcVpOTFU1MEhLODAzOUZJTW42MFFaWm9XZyt3RnNy?=
 =?utf-8?B?eGF4ZWRaRUhKcnorU2pvd2IybWVpamlqdzVjOFpOVG5jajdLcmJWOXJuS042?=
 =?utf-8?B?K0ExQUI3bnZpYVVqeUM0OFc2c0F3NTZpSWlHSFA3RVBUK3ZWaExFL1RsZzM3?=
 =?utf-8?B?d1B6MnRWVTVFTXhLRWNiWmZsTGYyODcrOG12aEhnL01FanBEODAxL0d6OWNp?=
 =?utf-8?B?SEJ1bHV3ZmdzL01EOE4veUEwQUJKcmtnVUpPOFpBUlI2OERkRkNSM3QrWGxK?=
 =?utf-8?Q?gAMTHoOcGjFWUoltp7bzOt0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0f6de8-1265-4fe1-83fe-08de38a01e3e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:29:08.7871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yId89xUmx8iidN1YL0TlY2EYT+jdnZxSrw3Ot8YV5B80z8kEm7Rx03RtX91F7NumUY/EZx9uphzqcmG2pmPmED+YTmv2FUWvghoHMttmsqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
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

Hi Francois,

On 12/9/25 9:59 AM, Francois Berder wrote:
> If zalloc fails, one needs to free memory previously
> allocated in the function. This commit makes sure that
> we do not leak any memory.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   fs/ext4/ext4_common.c  | 8 +++++++-
>   fs/ext4/ext4_journal.c | 4 +++-
>   fs/ext4/ext4_write.c   | 2 ++
>   3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index 8e6531fa3f0..f48a8ca48d3 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -727,8 +727,14 @@ static int parse_path(char **arr, char *dirname)
>   	/* add each path entry after root */
>   	while (token != NULL) {
>   		arr[i] = zalloc(strlen(token) + 1);
> -		if (!arr[i])
> +		if (!arr[i]) {
> +			int j;
> +
> +			for (j = 0; j < i; j++)
> +				free(arr[j]);
> +

Simply reuse i?

for (--i; i >= 0; i--)
     free(arr[i]);

? (i being an int makes i >= 0 safe in the loop condition (as in "won't 
happen") wrt underflow)

>   			return -ENOMEM;
> +		}
>   		memcpy(arr[i++], token, strlen(token));
>   		token = strtok(NULL, "/");
>   	}
> diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
> index 868a2c1804a..3a2e9f30c12 100644
> --- a/fs/ext4/ext4_journal.c
> +++ b/fs/ext4/ext4_journal.c
> @@ -256,8 +256,10 @@ void ext4fs_push_revoke_blk(char *buffer)
>   	}
>   
>   	node->content = zalloc(fs->blksz);
> -	if (node->content == NULL)
> +	if (!node->content) {
> +		free(node);
>   		return;
> +	}
>   	memcpy(node->content, buffer, fs->blksz);
>   
>   	if (first_node == true) {
> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> index 5b290f0d80d..20d4e47fd38 100644
> --- a/fs/ext4/ext4_write.c
> +++ b/fs/ext4/ext4_write.c
> @@ -204,6 +204,7 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
>   	if (inode->b.blocks.double_indir_block != 0) {
>   		di_buffer = zalloc(fs->blksz);
>   		if (!di_buffer) {
> +			free(journal_buffer);
>   			printf("No memory\n");

What about just doing

goto fail;

here? As it'll free both dib_start_addr and journal_buffer (and that it 
seems free(x) shall check for x == NULL before doing anything).

>   			return;
>   		}
> @@ -303,6 +304,7 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
>   	if (inode->b.blocks.triple_indir_block != 0) {
>   		tigp_buffer = zalloc(fs->blksz);
>   		if (!tigp_buffer) {
> +			free(journal_buffer);
>   			printf("No memory\n");

Ditto.

Cheers,
Quentin
