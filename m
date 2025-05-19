Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF8C3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 08:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCCC281E72;
	Mon, 19 May 2025 10:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c1SbGtKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF8A81F66; Mon, 19 May 2025 10:47:31 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7DB803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjpfiXrjxBMpKpRIChfK6GTnAByp6yr4EwrMAY43DAxQZeGCtvqw7E52NxOxwYRTehPCL7iySrGOxhyq8peq+Dp6ckLRWrQe7xUGhSxsD4uRHXgS7eo20puZPeT6HUtt+PK5ppr5FlqWKKxJKOfAvtlnHnLK/4700eLYDxVEMnBImz3mqaaZNqPLaezSXRBq/rAaHfcyzKsiTCfChIw16iDPL1riDBTBdnKtGZ/pca8DagDchHBd7dZIbuXBuQavy2A3KWk9cXiG8NNHzWH+NRo+IPhZAB2I5IGDtyvral1xMZNmUTWEET62YNNcu2LcSvlMuYZzr8zmBrnL1EXpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oer5O1lTN+R+D04GzQl6KM2o4ikC9by66ccgAv7BP68=;
 b=p8q3OIa/aB01ESHRWpusZkXfjD9PrBj2EIJaOb4QKhZmTbWhU/rz3ylRlT2LMxIAU51NlUWKVcH0nyYPfxCKpM0WGkSKLjt3P1ksit9WQ3Eu3AdD1hAtn/185ftNM7vH9T1Cwgm1WJIbmVtWua1eIVy2aUajCf7PvXYh0KwuNPc+XbzdZr+BQ133fPtV4ot/kLaQQ3IaVk2N41TJnDhB63ms7kiI0yKLovPvweB5yWL1vZuPomoKHZtzTDvOPDhdQv8FTNX+JY3THxCTDJu9sjKtbT1xj1x+uAbEW3uuq2u/dkNlZ/odSRZMuTgvRBVK0rUuM/V8P0tW6QjrrHPgZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oer5O1lTN+R+D04GzQl6KM2o4ikC9by66ccgAv7BP68=;
 b=c1SbGtKSi9zHKRFomIGpl6mc9LRkq9zHnQP6bs3FcbcJIk7jN3a8SZEUyO4oJksNs8W+slhtK5vs9++GM7mZqI86T3cQiDdB7Jlogq7Yy0ze92dv2Cc+iMXUmkee5X/lAFcA1iKcyYa26GCCAaNlGvrapcq2tw991204Ru91iXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7610.eurprd04.prod.outlook.com (2603:10a6:10:1f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:47:27 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:47:27 +0000
Message-ID: <2934aab5-6b55-4e21-a84a-87b52921a15b@cherry.de>
Date: Mon, 19 May 2025 10:47:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: fix handle leak in ifdtool.c
To: ant.v.moryakov@gmail.com, u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20250516152538.75325-1-ant.v.moryakov@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250516152538.75325-1-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: af0f288a-971a-4d6b-6466-08dd96b1c824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHNDRDlvVkd6TmNLTEMxYXVzbWF4ekNjeXhoWWJrK0Y2UlpGeUJrT0JBY1kw?=
 =?utf-8?B?eHcrQUxJeXFmL0Z0R1dxMDlFYVltQVhuQTVUaElFTlFMZmtBc09iNE9jMStl?=
 =?utf-8?B?L3N1dU9oNldqNFpycFVVZzBPSUp4cXczajM2NGk5S21DVmdrN1NuMGlWN3hH?=
 =?utf-8?B?UnF3QVdTaTUrcWdLOFhXM1JlRm4ra0Z5WnR3VWt0QXBpeklkNC9nbTVSeEFF?=
 =?utf-8?B?VnA2UUlHUXkyT0Fta1JPM09UMzl4V1hXdGlkdC9lQWtaeTZzSlA2ZmVvQmwy?=
 =?utf-8?B?cUQ2SEVZWGpWYitvR2loNk9qWm1RWm41N2p4dlBxb0NLY1ROK3hpdWUzeXJj?=
 =?utf-8?B?MmpMeEpFTHAwV21KSm16bkVuSFd4Sk0vbnVabFUyQW1FdklYVmdXL28zMFVw?=
 =?utf-8?B?Rll5UG1GUm1xYSt6K0Z6b1ZYN1BPTlZ1ZEFxKzZOYkg2clVWMnBIdEpSRit3?=
 =?utf-8?B?YnUyVXpyZFRISmM2S1R0bjdXL0ZlaVRjODhFUjdVdmlyNjZocWtSZFE1QWx2?=
 =?utf-8?B?YktNamtuUUxzNW5pQ3MvLytxTDJ1ZVpnRUIzdTRMSk5CY2pBSDcxS0F2NWs2?=
 =?utf-8?B?VG04TDd3VFVWOWUwTFhOK2tZZEFVUVpZZU11dkFzbGRrK3JZaUFiVE5jbitB?=
 =?utf-8?B?T0VmRnlQVmhzNzdxQVJ0NG1NUnJHS1M1dmppQ1B1MWRGUnFQeDljNlBxTWUv?=
 =?utf-8?B?bG81SlhSaVgvWnM0N3pvYjROTlduWXFOeDhRZEZ4THhaVmlycmdtb2V4UmJD?=
 =?utf-8?B?RFZwYmxvTTcvTHIzYnJuL0ZPWnBWcjc1b1RwMm1JNXRSUFBrV05mcTRjSnZt?=
 =?utf-8?B?UHczNkZScE9zUXlvcVhrUWluRGZPTkJ6SGxWbWtHNVZ3R3FJN0tWelhVaDlH?=
 =?utf-8?B?NU8yN0x2WTZlM2ZxRnhDVVpMSy9GK0tjTHo4c2t1N2VoREQvZ0Ruak15VzFF?=
 =?utf-8?B?eUc3ODZhcTdVbVU1RU9icnVNSE1VOWNmanpIWklabHVXZ0Y1eng1L09rUm10?=
 =?utf-8?B?QWNESE5ONEZEMFNTemEwZkZUV01uMXlVNkYrWkdwb2daNVlMMFRDNEE5djJI?=
 =?utf-8?B?K0ZONFV5R3lRRHdwaUtZTjZpaU1xODF1SXBySXovY0RxRk91ZEFUcHdzQy9w?=
 =?utf-8?B?WlJxaUY4K29qS3RNOEd1TmpGSXhOTkYwTVdweUhmTGdOVWZxUmY3L1MwNVgr?=
 =?utf-8?B?Z2x0T21LeTRQNEYzMUY2KzA3WnpWTldreXRWejZsK3JmSXZKekVBQXB2Y3pX?=
 =?utf-8?B?OVF5dEh5R0Rta1haN24wVENuMWRlZVZFRFlleTRESUdHTWxRb2FrR043NWFi?=
 =?utf-8?B?ZTZSUHdsbXM0cHlGUkpoTUNxVWQ3MitYRFFJVFQ1MXlxVitzTzNnTmNkUG82?=
 =?utf-8?B?UTJ5NUZ4S3lVVFFjc3NCVnE2VHpGUFpVMlRtdE94bVRlY3hMR05BbDdLMnpH?=
 =?utf-8?B?cHltYWNzY3Y5ekFva2lGSDFEbzRhd1dnZlU5VEhHb3pQQTNpNHJFOXZ6dXpU?=
 =?utf-8?B?WGdrV0RjYlRDWE8yeks5RTNtcUtJMGxYZENDS3lYZ1E5Tlg2YW1BbncrRTNL?=
 =?utf-8?B?NXliUDl5cmNBY3dMOXRNNDVaQmxEdFVFT0xCYTBsc01OWnI4cFYrTkY4N0E4?=
 =?utf-8?B?cm1PeDN1TktVNkZZUlR4QlZCRjkyZXdSWlRIekhzdi9HdzFTZU1TOHRMczRB?=
 =?utf-8?B?d3VSTTlRV1I0Ung1b0lEaFJlcjJlamRETDROMFBMalNSbXlid1VLMkREdHBG?=
 =?utf-8?B?R3dRU3J6c0J1S0pwcXpKcFRZbHB6b3ZQYWZvdG02UEJJOXExZk1BOUhXTzR6?=
 =?utf-8?B?M3NiU1dpQlFBRjhwUDFrYVRwRytMUzdkNzBzSTVkT2pVZTNqa0tJZTJoOTM3?=
 =?utf-8?B?WkNHcC9oNlNhTnI4WGdZaFNnNE5Vc1Z5alZNU0NrNFh6cS9Pb0Q2eGRCUzdu?=
 =?utf-8?Q?tuUvzjtVfGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEw5cXdyMUVzL0M5YUtYc0lUUGltSDg5Y2Q4NzZGOFdwd2ZBMlRkTHJFMDdJ?=
 =?utf-8?B?bkhWWlZRRU5CSUwyQzNPT1hxY3RTanAzWGNQclZ4bC8wSDg1a1M3eGVwQm9R?=
 =?utf-8?B?S3UyNC90NW5WSHlOdWpOWHJJcmhQSXdNQnVRMCsxcG5uOC9qUjhqU0FQeGVF?=
 =?utf-8?B?cU12ZEphcTdCQWNtT0lHMDljTDBDeEk0b3ZBQlk4RE9lVGZJWHRwMW41TE1U?=
 =?utf-8?B?Z3JhNnA2Ti9ic0ZlVUhMZGY4U3RUMGRHeEhFN280M1hJNlRwWWhFVmdVTHlS?=
 =?utf-8?B?TEJyTS9ncmsyUEpTMzU1Mldaand1NS9hbFJHUWthTTVMTkVOUjQ0cEpwanlG?=
 =?utf-8?B?M21leWZJclBIR2tTMGI3dnJ5ZTAwWjBsWUl1Q1ZjWnZKQURVczVzRFFJb01k?=
 =?utf-8?B?NXRETDdReEZFMTJQUitOVkxBS1NrVW1wbnhMcXB2SGNacWZDZGxPYW1Nc2tM?=
 =?utf-8?B?ZFVWd3NDSy9SM2R2NmhRb2tqdmFUN0lmd1hlQnRtUXY2YkFISDRWUVNVV2gw?=
 =?utf-8?B?NE1MbjNXRGJROUVHczBPZlZJVkVuOEVqOTdSeG9NV09neFk3S0RVYWRYSGNr?=
 =?utf-8?B?RmVJelBUMWpndnBKU2ZHNG1vQy9tRnNCNmNpdk1JdlBZTmdNMVZWcTNKd1Uv?=
 =?utf-8?B?bHpiUlN5SzVCLzR5QmxESm16UG5PSEo0OHhpRlZqdm9qMlFqSVJPeUs1OWFC?=
 =?utf-8?B?RkVabkdLZWF3WG52YXNCZy8vc3hTWjNBWi9JRGNjWWFTa1VsS29Pajlmb0FC?=
 =?utf-8?B?cllDd1VaTFlnT0EwcXVOZGRsVjd0QVNmb25FSG0zREd2RW5NcXFETHVUMk5y?=
 =?utf-8?B?VGFRUHUwNGorT1ozeStBQ1N1K29EMEMzK2VmZEt4RCs4MVF1ZlA0Yjk5OWl5?=
 =?utf-8?B?dDJjenR1U0lNNXQycEtSQTI0ejljaEJXSlhGZzNIR2o4eWFnNFZra0R4TXRj?=
 =?utf-8?B?ZTFaZWkxTU9KSGtsWDhieVd1YlZMK0FoejVwcWxnNUhQTzVieWJ0MFllaTNS?=
 =?utf-8?B?Q0tqVXloYUdTd2N3bnl4cDJrZ2lnc2g0MXROd01XaGVNSDByUkZycURCYUQ1?=
 =?utf-8?B?Vm5IbjBiZUpYdFY5UDdMdXFxT0N1RTY0anY0L2pxa0NtMWkwSUJkRitNaC9F?=
 =?utf-8?B?NFFiQ1RVbW5GSE9pa3NKREo1TnVGYnV2YmVKWnJGRVpQem4zRE04TUpiTmZ3?=
 =?utf-8?B?S1FJWjVZWW13cjlpUVZPL2hWd05LeThwdlpWcXdkbTZxNVMyM2E1dFZ2RE0w?=
 =?utf-8?B?NFBYYS85Z0xPSDgyMVNZRXNERjZYckUvZFhzNzZBRXc5aTJaU3dDZmY2dFpS?=
 =?utf-8?B?QWxMVTgvYm9QV2hkcm9ZTi9TRFI5cFh3NUJSMXk0emxsWXRrWWtlc0pnQzVl?=
 =?utf-8?B?c212S2pob0NwWlJUQ3Q2S2VWc1lpWUZjT2pMYXB3dGhoV0hZY3VoQjRUajZs?=
 =?utf-8?B?TjNqTmFJamg3WjRPaFdFM0FNbHFTNUNVYWpORFBaeDlOOGtWMWdKR0NIU3oy?=
 =?utf-8?B?N0JnQ3pUYW83SUFXVmt1VDcvZVEzZEtudklVSGg4S1E3MU94Nkpha21NTzh3?=
 =?utf-8?B?YnZQMlM0ZG1ld1M4bWl1amREVmpyR1RMdW1YVGJtK0xPVHF5MXpCRHU0UVUz?=
 =?utf-8?B?STlmTWdGY2ZXbG45d1BucGYxQ3A0UU9kR2FzZ1hFOTZLUEdVNVpnd2E3czdO?=
 =?utf-8?B?WlVRcG5QR0twUTJRam5rd2pOSHc0UW9kNW1FM3djK0RWTUFaaFY1TmpzdFJZ?=
 =?utf-8?B?Tnh0K0dUL09Yb094VHc0clVKZyswREpmLy9rWmJBdHV1aXVQaDFDa1kxVkxG?=
 =?utf-8?B?a2tEMWwvNFVzS3Z6N3BPRlNJc2dmcWlleXNjRjZWOHg0Qk5EVkdvcE9WOFdj?=
 =?utf-8?B?NnV2K1JEWkc5UTVJL0lRN2xSeUJhTitNUXUrdk1RUlpFTGV0bWNmUG9VQk02?=
 =?utf-8?B?WEF6NGhrL2UyZzZsYVJSSk13RU9aeUFBNzR6dWs3QkdtcDhJc2J2NXk1NmZF?=
 =?utf-8?B?RmxiSTBNWXNSYjlpazVZRElFS3N2bVk2NmVVMUtNMEZlREYxQmFTVTgwL3d1?=
 =?utf-8?B?OXEzMERBbnZiaU1rV1FlanVRUHRvRGVSZ0ppTTBrUHFYMThYVXFxNW5BUmFh?=
 =?utf-8?B?YWk5MFBHdU1URis5R3VEa0NzNndyMUtEOVROdjNURU9vZVoxUWFvYXNRaXMy?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: af0f288a-971a-4d6b-6466-08dd96b1c824
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:47:27.2229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08WwNhzpXzAb1Pm8zB2CYuyiSmv0+2aFdh+sl60b3SO6I0Xfb0/wYe5qVplzoONYeJrRiHL6VQimFBchrSvhQ3zI5VXn7Nxhuaicaoqzxqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7610
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

Hi Anton,

On 5/16/25 5:25 PM, ant.v.moryakov@gmail.com wrote:
> From: Anton Moryakov <ant.v.moryakov@gmail.com>
> 
> Prevent file descriptor leaks by properly closing 'fd' and 'new_fd'
> when fstat() or write() operations fail.
> 
> - Added close(fd) before return in open_for_read() if fstat() fails.
> - Added close(new_fd) before return in write_image() if write() fails.
> - No close needed if open() fails (fd == -1 is invalid).
> 
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

Looks fine to me

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I believe there are a few others in that file?

inject_region returns without closing, same for write_data, same for the 
main function with bios_fd at the very least.

Thanks!
Quentin
