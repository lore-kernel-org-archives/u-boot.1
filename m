Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BCFCDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 11:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264BE849CE;
	Tue, 23 Jun 2026 13:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UN/EZhMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26895849CE; Tue, 23 Jun 2026 13:00:18 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A82847C8
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 13:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEx0L54WusxNJZON9L1lVxl9Y6EeIHGpVPvSdLeWhutGOvAB3KeZTthAA1dtq42ZOnG1CWNFLpLasATMLNWdHTeyeZzL1L4VhjVw2xq3elPkyEDKdn0bbmm+PTSeW4vgVYTb3J09/vtifWbALiCaNflRuFpVL76l7tVXXlCBh+AFOEyFPn5broYiZArUnTeM+KDL4SaRHyc15h/mPMqHE2+wty88h9g5IfWkjMnAecOXYW0YhuYsthqWkXUa5R5ldVoHXYfyQThXCRtehcdZ1iYwOX5NNSjAQ8O/2g7wwyvcLCan9+fjOfE6NzjsFBdoVXcaV9F0PGWYNVPzpWzMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9+Yr5KbIUcDhbsqjB+63UqWSgJaicCxJ9Op98ni67Q=;
 b=lH/Y3vJM0O7bzs08ilgHeP1QUlJqc8gkjG/7qlKQAgZzY5fCz45Bi+w9/A/q4V7+hwEAZcJMUXEMZpr+ZWPf08JNkPvgsHXE9C9PoUk+N6d/WNoZwn76/iWkD2vuwtRQqDMhPZpXaR0g1jGYV4kPW2yT2lXZNKmSDOoElV6beoEHtkPEVARbzCQ3tKVl3XG5ZxfQtSoVermKJT+k8Ij21+NYksAGh5HoxMEYL0CSOEAcS7kALTSETHXlhqM1KxPFNALnqjWq/Y5pxJe/jM2BRYjwmx8d0G5gxCImVw7Ce3hIyg/5Wce2yT78v/W0Ycolz/Eh18cROawwE8Ziq3j24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9+Yr5KbIUcDhbsqjB+63UqWSgJaicCxJ9Op98ni67Q=;
 b=UN/EZhMTZuRfc4Lz4dPYPOYY5EKOpvWEdIYaX6FuIbUXSINttJIYxPGQrzWuai1NbPFfOqc6JCxv/2FxmMyJBFwqsemOe3UByS+TuMg5hvk2IABxqknHwhnMLFIfVga5P5L5weGUtDu32YZsGcblNu6EJOHyJHbd9Qv4/LPZc0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB9579.eurprd04.prod.outlook.com (2603:10a6:10:306::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:00:11 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:00:10 +0000
Message-ID: <b6f28a7e-a009-45a5-8197-f2d9a9db4993@cherry.de>
Date: Tue, 23 Jun 2026 13:00:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rockchip: odroid-m1s/rk3566 watchdog support
To: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
 <0ee5047b-3421-4657-a4ef-6261954fe526@cherry.de>
 <CADU25KKvYc4xsPY6E7-r_pQvuKAdMBY3w0D+-R-x=zh+vfL_5w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CADU25KKvYc4xsPY6E7-r_pQvuKAdMBY3w0D+-R-x=zh+vfL_5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008AC.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::646) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e434b3-2dbd-4ff3-b519-08ded116983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BVt9qAWzTMTNPZ721o8xfL8TXcDc7xihMvbtXzi2d8fvw1HRM9u9cvd61IRL1qAbWWPnDNzO6l8hIYCXWSwTsGHODY9CT9RqX4kuEk43/H57kGMncH2hOivEkCou84dhNn3Bl7YOw5cloqxY9uUn5/KsVXJf0Q/C/TOHEhAe+4OA0/fMS8wgs0nXKtZ+tYofjicpBtxUyoCJ6Va5fGkE50utqCXOjAyQnP1P00BAsNM1gnPpJijSSQv79GX7bRl9iG0cl63hI6jI95J6x5p6uGDd5xFtT4aTju14dEpVNUh+s5MzbXXYqAwujb9kLLmLk/5nbj1Fh6+7Q2mt+dazH6LjEc3ca4WTcMGrPIcRpdtpZapbChiW7n7+tVkgC/lq+6smfYS0/B7DuLB+fAYwZhu2Is6UNScgpGyhUUzsHvwVCZKuiyQ6hB6Pq4uP2+GMC8SEiP0KtjclVUwHeJd/ByCNuaqErPAUYM9GYHWVOYUAX2hjWQ8SDLYd1mca1QlgKbB9zNE8pr63XNmhvU1kNPdZoWg8BjTHUsL+NBmdSzL8N7QVK6OSSxGe8A/i+UgngNP7m1KrzbthmQkVWxXeJyplhnTq4sDXLvE2PP+RyoinUVWOAw346kZTtVPkBlFfu7yjPO434BpM9FNuSIV4FKTkjJjT6vDl+Pl+mp/GU9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0ltR1IxK2V4QUgrT1VSclFzK3hhb3JrTThSWnNCMnZpU1pIWGU5ZkluZVE5?=
 =?utf-8?B?RlBhSGtRZ3ZBVnNIRGZLQXFSYzU2OUlVSjNLQlk3bnk2YzdPelhHVXJreGRt?=
 =?utf-8?B?czBwVXVIdzFQZ2treGl2MlI0QUtMTitxZ1pocmxRMTVHNzBKMjA3cUdCUmRv?=
 =?utf-8?B?MWhWMi9KK3JSWXk4QXhyQzlWeVhPRjh0b3Z6VTV6dS9ZajVOZys2NVJzQ1F4?=
 =?utf-8?B?eFhtQXJoSWlxSkZnKzdsR1ZmelR2TmtKM0t0YjdkUTZreU9iSDBLNGxXL2dG?=
 =?utf-8?B?YSs1bDdwbjl3S0ZPMDNucEhTcVJaUVRtb1hTZitBVGV5RlA4UWQ4U29tNHlK?=
 =?utf-8?B?OTNLNXhXVVRqMHgranRwVjZKRDdscWV0VzVsZ3FOWmc2TVF4aStaa3d0azFa?=
 =?utf-8?B?NmlrUHpEQzlKY3F4VXJwL3QvT0hCUURHUm1UNTdUUE1IRWhZR2VqMnhkeXYx?=
 =?utf-8?B?RlN6SmhiQ1Vhb2xLN3d6WDBTM1dEdUprOU9XYXlpa3JrRnM0dDdmYVFvUXpX?=
 =?utf-8?B?UlMxblBCYmVzMEtrTEx1QkRGRnhhaXkrQi9nWVBQYTJzSXBycmY4dnlsQ3dU?=
 =?utf-8?B?T3NZS0x4U1h4cjNtdXUwQWhVcGZLcm04WXpaK21JRG1aRnhJZEdJUkZPamxV?=
 =?utf-8?B?K1lPSTA0QmJrVEZReEF0ZnJtaDdROEp2U0JITk1iNjA0dFZLOERXeWJTTUFZ?=
 =?utf-8?B?UzBjZzR5bkZ3TWcycm56aUhoRVdnd2p6LzE5djRENWg3R1orV1JBdGxuRU9P?=
 =?utf-8?B?SWpINUszclVkK1oyS3Jtdnp3MG4xQUxrMHNlV3JNUE1DY3J5bEZtUk03Wmkw?=
 =?utf-8?B?Y0ZwWGxQSXBDaGFRblBNS2FtN255ZlpGeW5wakFVT3lLWEdpWmFhRmxRSVh3?=
 =?utf-8?B?ME1uTEFDcDQ2THJaNE1oUmtpNVpOV2lsU3dRdmRCS05LaWFISjdITm5TQ3NG?=
 =?utf-8?B?SEJ6bkhaVXVXVitVdGtKMDlQTkxTYTRyNmY1L1JKcnhBYjFQUEI4Q1pxeEN1?=
 =?utf-8?B?NzJrOGdSbndiSWZTVkFMT0Mxb1p3Tk5mTWhZU01GZkttRy9FajNDWUtXSjIz?=
 =?utf-8?B?YUZOZ1RDODQ3QlMxMzdaNDV1ODl0elpBbFpBUnRiSnpRSE1RV1grZWlrZUxH?=
 =?utf-8?B?TXorR0dWczZDMkZYV0dwOEw2RWJ4VlU4ejc0M3dYelNwOFo0RnFFeVZHbWFt?=
 =?utf-8?B?RThGWU9xOUNsandOZnJJMnlObWRhbnVXQ0tFdFFOTXVTcThnSU1pMHZNdExu?=
 =?utf-8?B?SUw0cFFseUJPdjBjbXcyM0FVTThEaTE1dS8vc01GdjJoalhOOG5OK1JkZzJN?=
 =?utf-8?B?YzBKWkpZMGdwTmhuR0dLRkllNExGOVpkaHd6NHRKZnZMM0QybGhFZ054QXlC?=
 =?utf-8?B?RUdPbDBPcFQwZDJ0SVIyQmhtcmFrS21zZmUwRzcrZmRmcEUxcVJVb2lJd0JK?=
 =?utf-8?B?dktuSytGa2FCVlhwaGtsbEFwK2JidWRMNU5welZlOXR3R2hWak83c1pwMDVi?=
 =?utf-8?B?U0FqYmdsckxWOXc3eWc5bTgwZ1E3Wm41bGxLc1RnTlNTRG5ZUm40Rm1HTE01?=
 =?utf-8?B?Tk1QT0FBZkZvZ0pMVHp0NjlRSzRtdDZmQVpFVFEzZ253dGJMeEswNkdIbVB4?=
 =?utf-8?B?VmFHYk45UWVPc3p1TGVFZEdma2pZbjBES04wYVZycEVRZFRIdnRadmIzdWV4?=
 =?utf-8?B?bGNPY3V4L1YyNHhZdFpqdm4zSDQrZ1RJMjAyYVlseEJETHZ5OVhyVWt6MDJj?=
 =?utf-8?B?Q1ZxVk9CblhyOEJZUDFKeE5RMm02TDZwMmR6Z00wSFpObXdwbW9OSnd6MFVQ?=
 =?utf-8?B?WXVSRmlXYVM3NDAzcWhYa2lkVTdVM2REZkVYeUtXN0wwdFV1QVU5NzhtZVBv?=
 =?utf-8?B?dUdRZ3pKVGQ2T1JqclMxQVF6eVJRRGR3dE9yMlppQ1Vwbyt1eUxqMlVSUytr?=
 =?utf-8?B?L0R6cG43b2RzZENhc20vVXJHa1d3NndCN1hzRE9uK01McjZOY0ZqWld5MFJT?=
 =?utf-8?B?UC85WDEyZFpOTGJqdStPaTF6ZS9EZmhIZDl2c3JzSVE0TFYxVExIQUxVWTJ2?=
 =?utf-8?B?RXdzNHVZajcvTGN6SDJLUnVMU0ptd1A5SFBSNkR1VXZFZzFDRU4rOVNHU3dY?=
 =?utf-8?B?Si9tZU9lOW1XL3BBVXAvRFcrbEg4TVQ2SXc2K0FkRlpiREtMclZ5SXR0NlJs?=
 =?utf-8?B?alJsL1BYMGNTSzRjeCs1N2VkYklLbFFMU2oycGo1dVlpUFVuMDVweHh1WDhN?=
 =?utf-8?B?RXczY1VYcXRtWEsyNkZsa2JRaHZpU1JlODVMRFRJeFFVcFZsOFZTTlI4eFl2?=
 =?utf-8?B?NWNzWjVwSS8yVXRiSS9LbktVOXRiK3p2R2Z0aXFzMHFGWFZuMTFudz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e434b3-2dbd-4ff3-b519-08ded116983e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:00:10.8965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtoByrlFUhOVgavKnn/jb2w2vTTmlL9NTGt82wqst3hUnMaSrxPftAzCY9991MbsmPdVFG3scyxO45GHpUVhHN+vD5/R5PWID4akzi1hRXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9579
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

On 6/23/26 11:42 AM, Andreas Zdziarstek wrote:
> Hi Quentin,
> 
> Am Di., 23. Juni 2026 um 11:10 Uhr schrieb Quentin Schulz
> <quentin.schulz@cherry.de>:
> 
>>> Unfortunately, the TRM is rather tight-lipped about what each one really
>>> does. Per experimentation: Setting it to the "first" global reset fixes
>>
>> As per TRM (2.8.4 Global Software Reset):
>>
>> """
>> glb_srstn_1 resets almost all logic except some registers just
>> supporting hardware reset.
>> glb_srstn_2 resets almost all logic except GRFs and GPIOs.
>> """
>>
>> which is similarly worded in PX30 TRM for example.
>>
> 
> Yep, it certainly sounds like srstn_1 is the more "complete" reset but that's
> mostly just a guess from the wording
> 
>>> the hang and makes the watchdog work as expected in U-Boot. This is the
>>> first patch. As the PX30 does the same thing in its arch_cpu_init(), I
>>> believe this to be the way to go but I am curious to hear if anybody has
>>> more technical insight on this.
>>>
>>
>> I'm not sure there's much more we can know (would debugging this with
>> JTAG help? I've never used it so don't know). But it's been a pain point
>> on various Rockchip SoCs already, I'm quite surprised the default is
>> still global reset 1 and not global reset 2.
> 

For posterity, I meant the opposite :) Why did Rockchip decide on 
"partial reset is a good default"? (second global reset is the register 
reset value, and here we set first global reset). But that may be the 
reason why I cannot boot from SD card after a watchdog reset on PX30 
Ringneck from Linux then. I wonder if I revert this back to first global 
reset if the IO domain (configured in the GRF!) is kept properly 
configured and can again boot from SD card after an SoC watchdog reset! 
Will give this a try one day.

> It seemed to me that the default is just "don't touch the register bit". The
> hardware initialization value is 0 which triggers srstn_2. The question is if
> srstn_2 might be the correct choice for some boards? As you say this has
> been a problem on other SoCs already, I would guess "not likely".
> > I have a little prior JTAG Debugging experience but no usable hardware in
> my private posession. (Don't think the Odroid has the relevant pins even
> broken out). However, I doubt we could do much more with it than confirm
> if srst_2 locks up the SoC or if it hangs for some other reason.
> 

I guess we could check where the SoC is stuck? I believe Rockchip always 
expose the JTAG on the same pins as the SD card controller. But again, 
I've never used or set up JTAG on those boards so wouldn't be able to 
help here.

Cheers,
Quentin
