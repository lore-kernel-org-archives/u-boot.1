Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFEEC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 08:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE75D888C1;
	Thu, 13 Jun 2024 10:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jVY8rBXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8B8888C5; Thu, 13 Jun 2024 10:38:45 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F75A88897
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 10:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw4LQKlGBNb7mYQ77j5SzteixgEKMwE6Oyfz3NGS66ksdK8Zv9Pq1b85W4wx28ayo7KAe7FSuvj760vPsMpdTgXHoDsueZ4O2lNu5geriQ4NJxZBzyGjwmPvgcfZkWhmOef4oqBPudXIhc4is9pf1sHCjq4NUTGSLKlIEPL485myeY3G2J9PjG6oRn/65hGG9txw8lC9QlB7V/SHTfWzTD4y1lPCu/RhaYm1CcQDLkbL7UXty+8rgCXWeP1yWgr5t7pNAupM9JdTm3+NCkQ2dJXmdFNFdkRaJaVhZzHGr6TfC4ZBTtbe5pk1pZpzY8+96JMmiX4hq7/sdntabyg8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKvn/vzl1cVmwsTO3+yp61ufBs2yEhPstZWIb1SyBoI=;
 b=WYxjqxOYWGhrWFJ2404lJvb2WsUZwStA+R/R9kTjnqvDjB3/sJnn5yEDcqv+Btt5DwqylCzOoSl3UEhKlwRckHoYUcHqeTQBiJns/1lQcNmveb65NI3/g/6+7uXD6YyqzJDI4zN/Dj/HXYHEGqiSCJ6poMsVnAEsaB21VBnPLFbl2Hqbf9a3OxcFoawpIxx2VxNDcNb5WZtB1+mtBFeOGh5gU/cQUQzogmNNSGAK4miCIjufh37R8OzjEq2N+KcUGB6eXqCEaTlEbVABxqRvzmf1dopitUkVBFz8mSINleaeu4SdbATy0jSehXBBnIv+cxSXI5sGIaPt+7HVw8ZnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKvn/vzl1cVmwsTO3+yp61ufBs2yEhPstZWIb1SyBoI=;
 b=jVY8rBXUOrJSYZ4Abwi+R1y0g8k26XhXrKpmUnyAxh+d34JselNbuD6G9raL0k4ULR/0AOJF+ER0nvt9m33O/43hzwyfPQHG6iTsQOQp8SoWk3QrqmG/nutO2VWxnAetfdweJF+kT2QW1k+6o3XYVTtiRd0fY2FLZEbhFh4zKf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB4PR10MB6309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 08:38:40 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 08:38:37 +0000
Message-ID: <2653281d-1038-4a39-8792-826a78e1187e@prevas.dk>
Date: Thu, 13 Jun 2024 10:38:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Claudius Heine <ch@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
 <738ebfbc-aefd-478a-a49a-5763e2e24e71@prevas.dk>
 <fff4530f-1730-4a54-a934-c1998425eca8@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <fff4530f-1730-4a54-a934-c1998425eca8@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB4PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1c6738-3770-41d7-da76-08dc8b84382f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFZOcGtWWEZnQ0FKTW1MeUpCd1ltVGxXTUt2Z1lmYnFmMGgwNjRacXUzNFlF?=
 =?utf-8?B?Q2tCL0tSb3V2bHN3YjIvSkZDMEJKakFSdGk3UVFUODFYQ0o1dFJkSUtjZXRO?=
 =?utf-8?B?VkZ5dThENXVEMGZ4SE5QS1BzYno0YkJxZ3N3U05NZFZSdi9CVzhNTWJ0Vmt0?=
 =?utf-8?B?WkZqdS9Ca2dBd0lIaFYxWWNHSkw2anVsNjdOYW1zNUF0Wk5zT1d3aWdMMEcw?=
 =?utf-8?B?QXlncXA2RDdqRFBHcitTR2tyYUdQNVQ4cjJJczA5VUZnQXJvejVweFpGYWZ0?=
 =?utf-8?B?SWdDcS9IWExlZmtIL0ozeldpVWRydFZiOTdLb045d2FqVHhOYWl5akxzUUdl?=
 =?utf-8?B?SWJEdzRiNVljYmFNN1QxQzd0WlVoSnpsSEI1MTdDemdNRkxtM1VtUFVDNkZr?=
 =?utf-8?B?N1VlK2s0M3VhbGpURm5qMkdKWnBFZWgyRzVKM09IbnllQzFIS2VOekN5Zzc0?=
 =?utf-8?B?RHJjOGdpK2p6RVBiVnVZeEdGTnY3SzNKWEk1TlQ1aFB6UHlIdnB4N0dlWDJP?=
 =?utf-8?B?REFPbGE3RHBtcEZlaXE5R2orVWY4RnBaeFFxcm5XdUVVU0hoTHB2SWlia3Y5?=
 =?utf-8?B?ZzBDandiZHJURmNnOGd6SGhmWTRyM3J2ZG1OOWU5c0dkK1o1emtSRXdIb2ZL?=
 =?utf-8?B?S1BCbVJTRGRuaDlwTkU1dkhHZUdmUkNEY0phR0NiaU1KN0Rrb05vQmRRUXVx?=
 =?utf-8?B?UEVuSHVDU1dOaGxJWEMrWkovS1pabll3R1JZbUdqeThSY09UWSt2WEFzZThM?=
 =?utf-8?B?OXdPWEZubVArRGJXb1dFN3p4NHY2UTdIaFR2QXFVS1BTRXhpQzZpUHRwQU5R?=
 =?utf-8?B?UGJWMkZjZ3JGd2dqTGUzZ0tIY0VTNThSU21rVi9xekhvT251NHRrcm5rMHZW?=
 =?utf-8?B?R1RkVVpuTi9kbmRWcjF1Mm10UE9jQ2FTdlZXYytvS0M3U3Y0UHJhZlZTQ3U1?=
 =?utf-8?B?NnR4djN2RnlFSmJyRW9rbSt1d3pTT245NXpiSUVJdm80UDJFOEJJait4bHZn?=
 =?utf-8?B?cTh4VCt2UjIvL3pucTZPeVE3anJzRWNWSjBWWlBFSnp4U1BmN1VKeGtKbUF5?=
 =?utf-8?B?d1JVRWcwVzhDK2VpVjNKZzhtWGVjR0hMd0pjVm9COVp4K2NOZGQrbzlmMGQ3?=
 =?utf-8?B?dEVHQ2g3NUsyRFlBVlJsY2VrUW9sbDVDL2JzblVJSkxNdklMZTJMVUQ0bEx1?=
 =?utf-8?B?YTFaY1RFSUZLSzMrU00vVEt1ei9KRUZWQUNkcDRIdzRrSU95NFpOUVl0azl2?=
 =?utf-8?B?S0syYU5mTmVjeFpXakRWK3ZFYVMxTlVkT2lIUkJkd2Z5REE1ZUFrdDRzZXFC?=
 =?utf-8?B?aWZsRGxrcmVjRVhhSlJqbkxWNUhuNGpsNXE3dWFBcXJZbDV1NEZYdkF5SzB3?=
 =?utf-8?B?UTRzZ3dMaFQ2SDBxazkxUjhXRXNlTzFLRzRMWHdwekhKelF1OGV3QVlpMFVS?=
 =?utf-8?B?am1UZnZCMzBSRisrc3lWeFJJQWlkcjA4YjNRdjR3amdQWTN4MGZrU2svbXlJ?=
 =?utf-8?B?UWpKRWFQNTZRWnFEOW1uOUI5TlAyK2w2a3cvLzBrRVM0bm5ldzVac0ZxWFk4?=
 =?utf-8?B?R3ZyaFoxc09CMzkzdVlqRFR3UkVjSXJJczBiTTFOL1FlczhxeUpSdnZkYnZW?=
 =?utf-8?B?NlpQZ0xSendEYkdIdjVPMnA1S2pxaG9kWnlQdmZvTHBvTUZnMVcvMnRvRlJP?=
 =?utf-8?B?ZTZKZ2VPMWI5TEtjOVpyT1ZTdEQzbHVFbDVaOWFZM09qcnZEYm5WMGliWVdj?=
 =?utf-8?Q?m/WaolqzED5drJU1Extg/eHp8nKpoBwREAfp+2E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmMwUlpYejVyYm1KZnhOei9SOVV1bkw4Q0RrTzNRRms0dUtYTk5XUmFOS3or?=
 =?utf-8?B?bjR1VlZ4YzdXRE5KaWIvVVhGY2xjSDFIdCsyaExJVEN5VFN6VWV1RmhxcmdC?=
 =?utf-8?B?ZmlxZitncWZPYWp0TkJ3WVhmZUNIMkZPa0pzankwd1FWUUs0NlZUbGhVUjJs?=
 =?utf-8?B?ZXlCTi81OXRTRWJqM0ZGRjlkQnkySzExRGN6TFVFT1RValE2cGdCemMyaUc1?=
 =?utf-8?B?RE51c1dySGFQVDVNanZGbERvcGRJbktrVWl5S1ZaRDZraS90SldZcTZlcGF1?=
 =?utf-8?B?TXlncUh5M0d2RHRyRlY0b3ZTbytmbEdvTjlqOUYvY01iU2N1R0ozdkNWTXN5?=
 =?utf-8?B?NlQ0ZHhtTElDcW8rMC82eEl4L1BBSW9PV0Y2a0xJVWsyMlpScGIrak80ODFI?=
 =?utf-8?B?Zk5OYlQ1aWhPRHE4QzBwV3JHVVNWYVdhcDI4Y09kV1BPejVlbXd1d2NLMlhY?=
 =?utf-8?B?V0pKbU9Hdy9DWVFZaUs4dWpCaUdLQXc1eGF3MnArN0JoRFo4M04xcE8yanpw?=
 =?utf-8?B?UUZOekgzTUVOd3ZVUXhob0F0U3I0U1NwNHNMVWsrL1dlTFE2cGNrcmhSSEd1?=
 =?utf-8?B?d2g5eHQyNEtGQ2ZaQzNpK0JoQ2dWRDk4c0hjeldvS3JLRENjYUJrMk50SHUw?=
 =?utf-8?B?UTUzQUl4d2JlRGRaUXM4aVdrNDAyYlZFNTNET0lCcWtGZFQwMFAyZnA0R0VQ?=
 =?utf-8?B?U0VBbFVjcjVCSGJvL0xCdURtV1N6cnU3WFFBcG9sZWY3Zk1yd0ZTVW95eXc0?=
 =?utf-8?B?NjlkRS9hYkhLMTlWZ3RaNGd0M3BOUGFKOVppay9UMjE3czJaRW9uVk1STXJM?=
 =?utf-8?B?UnpJTlJxeFdkWS9yQnZxc0dLYm0vTzRsZHNwUUZWNldzOEFqTmJMVmd1SzNq?=
 =?utf-8?B?U1JnUjRoYkxhTnZueWlCKzEvbTNpWnUwWUV4MVhCQkFhUCsybnN4Tnp6OVlZ?=
 =?utf-8?B?VGRRRGs0YVVKenJIVGZ3V3k0c1QrQ1NxaEVhSVlncFNrWkJPN0NNVkt3OGx6?=
 =?utf-8?B?STd2RStBK0ViT3ZyR3VINjhmZ2Y4Y0FkcU9DNmxVMUlTRENxN1VacytzZ3lI?=
 =?utf-8?B?WlVsbTBzY2UvSlJCUm9IYWxsMGJoVkxwYWVPQUpDUy9FLzl1NGJJdW9ZV2pU?=
 =?utf-8?B?OXBjT1h5NEVhTVNrUDNvby82cFpnV0RwM2ZSb2lNcFhlbXRya2w3cGJhencv?=
 =?utf-8?B?M3o0SmJXWmdpQm5YVTVPWmF5T09PYW00YTAvdVorcE1lUkE5ZCtScDhHbDBD?=
 =?utf-8?B?TWd2VlFpRXNpZTVSRjdGVU1SVmhlNjVxR1N2eEo5VmpGZkRaZHAwQ1pqcmpG?=
 =?utf-8?B?UkswTWpGSlVPNVk5MytqUmFzSFFXZlM2THJlK3FIdHJnYkxlTnEzbXh6TWp1?=
 =?utf-8?B?dWhWeFpjWGtGaEpEWlFwWWZzQm4xL2pmZ1dJbXRVbW5Dcis5eUQxZTArNlVm?=
 =?utf-8?B?QkgrVS9GenBDMnZ5L2xYMDlHUXJsTkx2UEFPbEgzall3WndRWlhIRnNveTMw?=
 =?utf-8?B?YlhLSUtyNndwTFRyM0w2cDBza1ExamFtcUdBZXlKQllSc25LZnZWcWhBU2pH?=
 =?utf-8?B?ZGdQZGFxMXJuMmsvYk56dm1scmdVSmlLbHE3RWRTaHJjRmFRY3VxTkM0L0FS?=
 =?utf-8?B?M1VwR2NLRzRHeWNzVVlGdHR4RjJCc0JCNkhoakdMQk82Y3ZieVpDQ3oybWpj?=
 =?utf-8?B?OHBGSXBjWkpmVFFxdUpOOVFVQzVsVDNrR2JMWWxRdGNVcCtQZGRYY1JVR3Bj?=
 =?utf-8?B?SkhJSGErNWdqNTByOENOTkJDQ1hFSm9Nc3VtOWgzbVh0eVR0T2VYeElQd3k2?=
 =?utf-8?B?MG43YjZCclViZnFzSE93RlNEb0xMR2ZHWFoxZW9uSThlQXh1c1pZdDBEQ1Bo?=
 =?utf-8?B?dEJpbzl5UWxPM1dLZDhiMU1jbEQ1Vk40V3c4RVVKOHE4alVxcG1Uc0NiaDlV?=
 =?utf-8?B?S3JVWHpweUl5TXhobWczOG9aNGpITDZGT2pDNExQRklpN2ZxSXpDTXVKUy9T?=
 =?utf-8?B?SkdaVW9rRXVYYXlyVWJEQjZVVXUzRG45U0pjcXhQMHlFTWIxNWdOdEZIMEhx?=
 =?utf-8?B?aGVoWGI1V2grZ2xPVGxBVFNYYmJWUStCRVZNMzFqZzMrTWcrOXVmcEY1SjdN?=
 =?utf-8?B?WFhRTEV5OFBFR0dWU05UR04zblpoajdlRXFZS09Od2lQWlJuN2RuUUdlRkRj?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1c6738-3770-41d7-da76-08dc8b84382f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 08:38:37.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDcPICVvAB0AnGqrmBFBPYq5grUjGHr1dlw+/a51u3H5aqJOKHLiYzpvyTpgBixcVrnM3FqIhZNyBAKguSeKufEjOQHRyA6cDv2A3G6xvM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6309
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

On 13/06/2024 09.32, Claudius Heine wrote:

>> I'm just wondering if it's possible to have the server send some message
>> to the client when the git protocol is used, for some deprecation period
>> (6 months?), so a developer doing "git remote update" will get notified.
>> He would then also have a chance to propagate that to whatever local CI
>> he's responsible for, instead of only noticing when things do start
>> breaking.
> 
> We are using `git-daemon` and there is a `--accept-hook` which can print
> a single line to the requestor, but only if the request is denied.
> So there doesn't seem to be a way to implement a deprecation period.

That's a pity. But perhaps, when it breaks again, you could still make
use of this to keep a stub up and running for a while: point
--accept-hook at a two-liner script that just prints a notice that the
git protocol has been disabled, what to use instead, and exit 1. That
will still be nicer than just "connection refused".

You could also point the user at some mailing list thread (this, or a
new post when you do pull the plug) with a bit more info than what can
reasonably fit in that --accept-hook message.

Rasmus

