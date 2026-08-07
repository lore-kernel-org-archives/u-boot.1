Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642C1C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7471D40A52;
	Fri,  7 Aug 2026 16:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEOmbOanym6G; Fri,  7 Aug 2026 16:44:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E41A8409DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786121065;
	bh=RAXun6QhrntnUJoWQuCV5/HzPhSCVdArj57jx029yps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uzg+ESVFD1ni72QJ7+uwlfs4cxXugKpnGiggyLfCEvSqxuoa5KEL89cOi5RXhlh8Q
	 upMDYK78SXSKJ/TCOrqOEaQ97wlcBo3RTbwcBS9dpck/iiuk4r8SuW5/tKSKwFv1Ij
	 NLKd8oSSINILUtvZjeN0V9oYDGOC8jZSBO+vvm3zxwJei37uPqn9QpkfcneVD4/qQn
	 I9YKdhJ5/9cxoJgmPF31EIkC0DKg7lphrmyfhjaSFBeWkpkEipc1bQGQfKabeOSGBX
	 8FR7OozJ5B9/RNVpnGEZbq06fB7epgSOvymLDkKpqWJilmiYojc1rCBcHetD9q+Q0o
	 BbVUKW1xVY+Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E41A8409DA;
	Fri,  7 Aug 2026 16:44:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D756296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 334534010A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ejY001mduhj9 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:44:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 653884008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 653884008E
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 653884008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgJa8+hgBb+KO4RlT/bRMPJEOXtaWYauS17Z41FZR7CMwOSNCpjIJf3zC3LYcOq+xU9mYuUea2AaRtmPwy8n4DoEvW/LzKkCTi1Hp77b4crFV71I3Mf6GVIzOmGIg9qovvnDee5FkiIXSBErioCEgsRqXZzwOpM2Vfgv3Ha9/1ze4ZKKKHvMGupxxZJdXKJjqHZtjEMuuonnKiXBy2LVQIKsC9gK+FgMm8eRoLPB40f7MV4bItTBjH6taoJkVrYSKyQ3m3hmC5f3r0dgxVkLwzXA8tqMLGmu+W9sFyi/pudjv7hv+WdBGBT4OySqHjrCYgGloFNQS6KRBgKwtRZEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAXun6QhrntnUJoWQuCV5/HzPhSCVdArj57jx029yps=;
 b=VKgjyJ4I2CO4RWEd3UWEiBUIsCi+WNNZen4ZJV+LiD5hPqoQBnpeEINDbiirH8WKhTrhqnMKOM+Bp7IvOksZmsKVQz/Mgjl4RTiFIdksw78mEXxYSp+nvQ1yLMiA4f54LjawSf+B9QEWt/BEY3N8z22HUEMVXDlJUJd/dsGJaNoK/6hzeXIqrbox0dIIrwHBGGLmSrJX1NpeyoLSwIm3vjUK91B5Fgk7kUtKWauJE7OsN1xTAR+mYBblEfk/BWwBIIdGH8chlE19Jaa3/vReS8OXetKwYXXvclRmR5C+UgxQKOUqCQRba3SDZojL1TEUVL6grJo7DWpUJuhsw898og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 16:44:17 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 16:44:17 +0000
Message-ID: <3ee5d07e-369c-4220-ad45-19adfc63465d@cherry.de>
Date: Fri, 7 Aug 2026 18:44:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] rockchip: rk3506: Imply OF_UPSTREAM
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260803190946.2259514-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0044.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::15) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f84a6d6-a530-43c9-519b-08def4a31ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: yHl1bvxTUaInnGMAGVFbAZuvW33bjEiD7GBn5JGj3UYPJvF1Y17rIUYKoAi+8x19pe4W8repNBHoNVDsWx02/z5reFUMCwge/jXXlNmt/Eq2BtbYsX8Be2onEh8l/o1V5Hf1s63m8xzyRBm0748vvC+rLF5HFwHAECb+Zae5+aWJTywqWzuxjL2OTNGw112foboCYh/FLSl8ZannU1GjYryah/sCLbCl4TXab1NkfJsn/H4+LyS3+HrQ2kSqeH4GmWypmuZ55V3vws0i6xQyQyTk3eT/rkHYPcmTuyX22Jh1PGB98qhvFi/SkP1Oh/idxl3ywRB9xRwHj7ChGulYzjEh2qOevroDBhuDFHG4O84Qw5SeaWQvukftRuYtIgr0K2+yDxvwHerKfGcw2REelQpA7Gb3cR/HCjVub0d3Pgwzb3zSXhRV+K+ALwCCoJV5h4vggtFr6fQfoLhrfxJQZY+Fml4KebfHZKuogTUzJBXPDbvhxWeVu2LQanUVWMYPimtRYYV9B4LHU1hSh5BCaD8pcr0QjehqMgaE49MIYcwUcCiKIxjuiw33do9/Sf/Nik5gI++mg9Vsmx8ry+/+dD3lPjvHeLMN1LcvG4BxpjmBrnL92E8GyRwYPk3mnFKkaMq2zKVyq8bJKYniEFzIx2i+lDG0C5Qlu/8aTi2Tuno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWU4K2hKOVVoV1djN0tJblNqN0NWNnQ5cXFtWkZHUHNKcUN0WDd1RkcxNkpN?=
 =?utf-8?B?bXByZkF6VGVHUVo1R1BCL2ViVTNDN2p2SGkzRkNhK2ZBR255SHFDMjh2MmFw?=
 =?utf-8?B?QzhTOWxOajY1ZlRzT0YyR1hJTU5FL3hEazZwS0ZXbnh4RVFkU1pZZHZucEJz?=
 =?utf-8?B?dTZGWVlCU2xJQ21SK3YrdWdQTFFXMmtSN2hRcGJPeUdzRWhpdGNaVkZuUm1u?=
 =?utf-8?B?RytyRUE1aGVkVmNERmxQZWNWa3dNNDZTbWJ5djU2b1BkN2dqTjEwZGVCTVlZ?=
 =?utf-8?B?azhqVFZaM0ViUGZxcVlYVHEzdWthRVA2VkdvaFAzb0RCd1Z5R2VVbGl2cThW?=
 =?utf-8?B?WnE3QVJybHJOUHQzcG5rRW9lbzB1UURWQmlnTDh2WTJ3TkpYR081aXFPN3RM?=
 =?utf-8?B?bzFCeEJLZVVhL081aFFsVGcrZ0gxZmU2RXd5Tzg3ekI1TmFvZUtvS3VtQnlB?=
 =?utf-8?B?MkZpWXBiZXBBNENzQ0pMNjAwaWpFMWd6MzNmUGc2ZEs5SUZnT0cydFJ5V1l6?=
 =?utf-8?B?NG9wemQvME5FblpGUzYza2Z2SWNpSGYyMTBPZmNCVmNuV3pab3lvWG1PRnc2?=
 =?utf-8?B?d0JpN01LYjJ4ZHB6NE1pa0phR2NUUTVhTzlOSGJTMTd2dFY3alo5NWFPWHNH?=
 =?utf-8?B?aVN4RWVYWG9rR1VodkdHUkUvaTRkcUJ0NnhxM2krclg0WUJycENHMVB3eVNV?=
 =?utf-8?B?bGRmc1dET3JTOUNNQVZBRjV2NElFeW9EbzF1MHlOT05OZXA1eTQxT044WnBI?=
 =?utf-8?B?NnkrOUsyKzlXajlINkp1cFlGUkxMcW9hQ01FNGhvaTNZMEhKT2hUcXNrTFlW?=
 =?utf-8?B?TmJBR2tsS1EzN1BGUks1MlduSjRtejkrRDllRU5FTjEya1ExVVVCeDh1VXp4?=
 =?utf-8?B?aCt0eDF0VzN1OG03YjJMSWNNTWlRSmFUaWV5aGdNdUc5MTh5WldGdFgyRWFB?=
 =?utf-8?B?aTdmMDQwUzhCSWxGTUhYZDFtbTJpZ3BWMlE2OXNIUGtCY1lzR0R3REpmRzlC?=
 =?utf-8?B?STNNdCtVdlpCblBBNWlKS3BidkFuTmQwcXVLbVAzcGtzTUdmbTZicDBFTVVw?=
 =?utf-8?B?UkhYdjMxeTRmQW0zcEw1SU5CS29SVTF0QVRPalRGTUVJV1hsY3BjeEFwajZK?=
 =?utf-8?B?bTY5SU1iaDBjTFcxekhuQjNHUW9raXZCQkJQYkpMZTVUMzhXUVJLRzFKL2Ji?=
 =?utf-8?B?anNqNHRkZ1NKUkttelRrY1lyeTNkMXpROWNqaHFNTGl0VE9ncHNyNVIvQ2No?=
 =?utf-8?B?Snl5VHVFVGd6NmNFSlRkdVJUSm1nVGpGS0l0bS95NmZ0aHpSejBPcE95a1ZX?=
 =?utf-8?B?c1VWM0I5N1FMTEoweXNkK0dtaExyNzBCblIyNnVNeEkzdHMrTm1ubGVyZ0xi?=
 =?utf-8?B?aDJ4VnI0U0FwdlN4Y3QyaURtWVFaUmRvcXdmLy9kM0U4cG4yekFuRGxZT1BJ?=
 =?utf-8?B?Vk0yOEtqMy95Y2JsMDJ2WXp1aVdnSVRMc0NGTTZVV0gyUzFhVnM2YzVNOFRs?=
 =?utf-8?B?bkp5SGtKSWFTNE9vZ1YwY25jNTE3ZmVkcXExSjhBUGlsbmU3YTg3d1E2VEFF?=
 =?utf-8?B?UUVJSGhrUDBqWUVzWkljbzhqOEI4Vll0NDZ2cUF1cDB5NDQyaGovNmlqU0Rj?=
 =?utf-8?B?b0s0eWsyOHFYTGR0UHJXR2lsaC9VaWZYTWtxdEgrbnVkWHdMTW1WUmQvTmxM?=
 =?utf-8?B?K0k5V3lPamVOc1k3OUdMK2h5TlJHWWg5ZEdHRHRwRUFpQlkwUzFpZUQydkVH?=
 =?utf-8?B?MW1MNDVJeTJlVVMrQ1dVSW91Rmt5WkxCSWltVXdpcmFYNDJSUFdSU3YrRG9C?=
 =?utf-8?B?bUY2MXJKajNicWJFcGtoME94NEVTMEFnTndHTGlETVhibnQ1RHBWRVNLL25a?=
 =?utf-8?B?WTNybWl3cEhWN3NxeDlCeTR0SWNvYklnLzZFM0lOb0UraitsRHRhNmZpbzUw?=
 =?utf-8?B?VmVaNUJtMzY4MitjUkVJR29DTVZKZVVNbXI5OVc0T29HUTZnR0ZVRHZtcXJD?=
 =?utf-8?B?M0Z5UVQ3ZmR2RkNrYmhpTmd2MUpQUkVFRC9mOFdJRDQvRjBUKzdOTWNtRGtU?=
 =?utf-8?B?dGl6OGJZMWNqaXVJREhQeWlDa3dHQWk2NWZGa0hCWXA3RnFBTVdXZXF6Qkdo?=
 =?utf-8?B?MkJiaWJuRGxVVm5zL0Qya3hnM2VSNkRvOWJEUVl0ZFlNdkRkL0lKODRiczFY?=
 =?utf-8?B?Qlo1QjR1bEUrWm5rQnc0RUg0aVE3cVJIWTJ3cWp3RE5KRFZFMXExRERvMmFR?=
 =?utf-8?B?djQ4bUdVRVpSd2FlSWxoelBqaEQ5S1FJN2tYWGpGY0paNHRJbWlDTmpCcHBS?=
 =?utf-8?B?YkNZRHpJU1dKMDJCdGNuekxrTVlySVZLMm5VeVNNM2FFZnlERzR5RFlPaTFk?=
 =?utf-8?Q?9RLJXAAJwBwE9+sXIGVQfLNDxYPpdSLPc5KkP8AccZuFq?=
X-MS-Exchange-AntiSpam-MessageData-1: 9Buys67EtpLlDvZqvJKZ/PCuwyd8xZZQrPk=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f84a6d6-a530-43c9-519b-08def4a31ee1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:44:17.1186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2MrJ59EDcmZDuq6jI7a8/hvD92hUxa8dqthvQyVDWj3I6SbCrS4H58U2YnDa9a1bL6BYhC3NJxZXAloxAXomDxzEsY0DHiwqjBe2hPzq+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAXun6QhrntnUJoWQuCV5/HzPhSCVdArj57jx029yps=;
 b=mucoBpn+PUfUgiGuq3FAFlDLwaOG54mdIFMF4qIwjeW8Pah2hcOD4CvDaKIiJBAONL+l5/09l/tgy96dzukc9bH2lpS/2lmjgpmcnQZPiiH2vayIjgVlQ9l8+Pyexh6ZIMKQhJBS5dSNkrKlAt7lcMCcVVIxPYI8FryAGDN6k8c=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mucoBpn+
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/3/26 9:09 PM, Jonas Karlman wrote:
> The Rockchip platform typically require new board targets to use
> OF_UPSTREAM and board device trees from dts/upstream.
> 

We should eventually make this clear in the docs, and list the possible 
exceptions (namely, the "generic" defconfigs that help with bring up; 
OrangePi 3B is such a corner case that i don't think it's worth 
documenting as an exception).

> Imply OF_UPSTREAM at SoC level for RK3506.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
