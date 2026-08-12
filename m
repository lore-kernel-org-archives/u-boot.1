Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC26C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 12:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAFEA80FF2;
	Wed, 12 Aug 2026 12:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lN6oEV92mOtq; Wed, 12 Aug 2026 12:51:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 274A080E19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786539075;
	bh=dlVLklTuazlO1MpZrhcjX3fy2ptFUZm1Fg1bSBNC8vA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jc3SMnQGKNKx4j1f/8xU1kzQkcuVOLRqEkvK/ltz3GXuqmvxNXpSTHXJqoWpqqsNK
	 yakNMMp4zpG3fjlo0c8S+S9BvQ4JtKvGCT71OoYW68x5aXutbo2QPWevWaMh+GVrbJ
	 pnP3Pg1OqSqUI2mhv54iVVLh1yAK4H1mX0JFxPaWP00vdsBBo4roeVE9vsq8zGRPd9
	 8cIBdm5nKfYrY4xIvNd+7X3MUT7DuZ9tK3xDaufM8Cub9nIJekBmB6IOCo186puPMR
	 FTIJprO/CDMO2OiMEnxSpN6wNqjwTGd5tjNxpB7nLbc0LSaGBD6qSKU4hOganQ92q8
	 yMkXBhAw/2m6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 274A080E19;
	Wed, 12 Aug 2026 12:51:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 74E5E10E
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AFBF80D89
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZ9Y7jHvVgn4 for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 12:51:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 707D9807B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 707D9807B5
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 707D9807B5
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 12:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilzby2+QSLxUIMS1BdwNZT1Cj6whTW+iKuxF2jDrwxRbwO6DDcMgS9XHIMjFyFAQNUY4bQd+6alJN/MQ0pZb9cpD8tglNAXUpwYzNqU7wxVPYgb0UmiYgtV84vf9i+dRderI/uvRW5McfDVGQUxJn59N4r6wtsIRgfzLyyTJ6gbNofwiOBalQHH4+gcORp/vvgjF0vuQ3vspZMTHCQrXh+7pBdrlhODMhwWdDtFRJwy8aNx2WpUet1uoxy2kR0xl0DEcvgHkWu4IStpvRoTS/O4nCluTjk8pIUH4NbhHTIrvYvJwbfMB+lZqlLwCR+52MEMp4rnkwwLoNUr4SSiqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlVLklTuazlO1MpZrhcjX3fy2ptFUZm1Fg1bSBNC8vA=;
 b=IUtoNFdPwltXvhtLxLH8Xx2FYF1i9ATEblP1dU8PoGUShxrCKnQssva14cB7TMngmPUTxjwQ54U9A3ms6zxfbOqZd+V8dclyFtPuXr/iz6O5CR4AsATXv9tDQuX9LCBPPImTgFeI8Nh3wZLDw1EDgHsu6EWDIVytxzwIt0QR0Zdr7XKTz1/HnBn8ZGNdOBXmjV6cXSd0j25gtNexqNigha9MJA8DwDzIB18PzwgvTYv/QRJT1OUaR4hjgg9pOoFisf4FK6X3HpYFCe2VbLuH0lbNfFitgXujZsalkrqXGV6oOG/ssfBuDy4KHrHlNPsn9lcKsyIhZXTebijP+BRtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DUZPR04MB9728.eurprd04.prod.outlook.com (2603:10a6:10:4e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 12:51:06 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 12:51:06 +0000
Message-ID: <760cf4b4-6405-4243-89f1-aeb0047ac299@cherry.de>
Date: Wed, 12 Aug 2026 14:51:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rockchip: rk3506: Use FIELD_PREP_WM16 macro
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260803190946.2259514-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0085.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::18) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DUZPR04MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b4f39b-c8ac-48e4-e477-08def8705f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: UzMGVRJSy/4n1saLXxb/Ej8xaeGJwGWVIr2EHsNjXtQPuZWjk8vArwCmRQlzuViXuPUs3XUx3BkiS0tVZLT3ahqbApp2IPh3qNd6r3dxuxlbrA7hk00pAqE9gnATN5XZEhabq1ewY6GJvrCPHC9O0BatII0kAhujs/2YFwmMgAA+a7OJioTvsmK3X+QGPvVPu7OXKOEqLGly8hs/r1cM/JrcUzTffdwZuS0uhRN+QxKLPhExhiHz9Qag6kE8oWuduQEOv6oNICExhhW4w88tyD05D9ADXaj59juN8wBLmBJBnkBqsG/4ZxJgFmgQ7cU22z56Vdp4ebRe/48IJRRAB/7jFehCIoxa3WqFcfzDlqn6YwDVuORDrHidZ5zGKAoX4EQqWc0006mC+0BcAVWCRJ0x8MoJHT2Tvqo40BkN7rrBWJ6yuboTbukACSzFQD382vcF2QLX3lku6k0sbPFG5ZrDM7oJaUGaiz64J1j7ce3qOVMO3X9o8PK0Nd5kQgLSGd97+W/WhAUm2itDGevq2YDTcowxR6jOh9841xqgdra47Z2gIT76/vOTGFE0BBICvZELZ0Vs9kcCycXlQPUJ3W3/i1uZSXu7boDJgEnFMYAW1m6LiFAFzYLI2HgRJYca9Epk4+vSBRVtXnoHaa+EXDXKxJxKMllOtHr+OQMe6AY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNoNXJMYjlCSE5iNEJPN09QUk9mbEhyOWtjdU4yTWErZ0RWcjZXUyt2c3pB?=
 =?utf-8?B?MTA5eWUzQzR1bkxaUmlPOS9wcnZHenBXbGszSXQ0L1Bwdkd5dXpwNExQSGVy?=
 =?utf-8?B?MWUzRDlHODYvR2dLZFVicE53bGFQT3hJdE5obEdiOFdUaml4Y2t2QmNZeDVw?=
 =?utf-8?B?YjBwRFViUCt0YVFESG1OOTRFaE93WHE1UG11L3ZJekowcHF3MTJXV2JDY2N6?=
 =?utf-8?B?YjRTdFVmMVB0ZTVBY0RRVG9lZW9uWkVOOFJyZ3o4YnBrd29TS0EyZUNiUVN6?=
 =?utf-8?B?VG02dmdKVEcybks2dVZidzN6S2tQWWdxMForRmlUOTBBUHFndXNLbDNoVDE2?=
 =?utf-8?B?VGhRWDVFK2crWnArTmpBaHdQY3lOem8yK1ZZMTBURUhoaVNkZXUyMFlQTDN3?=
 =?utf-8?B?VUVoY2RNZUJrRGR3cEU1SG9MMyt4M2lreFpGK25ucTEySTVzbnlMeVZ6b0sx?=
 =?utf-8?B?YXpCcThXb1dGdEVlZDhIcEFkTm9lMS9pZFBSOU9BeVdDY2NOOXgvekYyNTdS?=
 =?utf-8?B?VXdhOHFVYkNqbG9sckQ4Z0tXczRiUzQzbTVqbUlPOGdzTDI0QXR1ai9iUFpP?=
 =?utf-8?B?RlBvOU82aEJzOTdOREFJR2dlU2RDbDRsZ3V2amdXQUNUb204TnljUWV6NXJ5?=
 =?utf-8?B?Q2p1YWw2WVZCLy9HZDNMU3JzMWxpeTJaRjFVM3VCaWZCTkR1UGhyUXN1U1Fn?=
 =?utf-8?B?emcwTTk4amZ4bSs1YzdZYmdWNnlqSUZ5ZGFVRDBCRWpvTzdpV00vNTk1VWFE?=
 =?utf-8?B?Mmw4V001bFB6YlJoUGtIcENYdFhLb2w1NWpuLzVCcndYcEtTSlJpUDcvYWM5?=
 =?utf-8?B?TXJSdkdsbGZaNnkrWHY0WjVSSktSSncxMXJQU0ZzSlRWK1oxQWtRejFiSTQz?=
 =?utf-8?B?Y3Qvbm1sSDRmYnlJbllNemYyY01jTGhLaHFxcUdLRGhJSlpmRlZ2LzMraFRv?=
 =?utf-8?B?eDkxU3V0UnFDcUgzV3cxdUQzSjIraTVsOTNzRGVXMFJWUTBYK2l5UFdrNjM0?=
 =?utf-8?B?bE0rU0NEMlF4QXVCZTJ0bGJqbzZYMzMrSzEyaVJxZDBreWMweE1BS2Vsb1NU?=
 =?utf-8?B?TkRlVGgzb3lBUHVIb2dteWJtYmRNaG9mL0g1eHI4NHFzbVl4S1I0YkI4ODlP?=
 =?utf-8?B?NUVoRzdGejB4Y3owZHRvMEljaHlwUmpzMW1VRjA3L25DZUQ1bUlKV0JVRU1y?=
 =?utf-8?B?amNhOTAveWNDRXBrUVI1ZUdqSmFQaUtIVlRhQit6SGVndzlrdlpWc0thZnZr?=
 =?utf-8?B?R0NHSTdwKy8zcUxpWDZ1YzEvVit1ZjhUL0Nsb0luZjIvWUxuR25sWVN5Z2Ri?=
 =?utf-8?B?MFBLTEJnbkVtMmcxOXJibUE5L3hnTHg1QlErWnV2dlJ6c0RFR1ZMK2swUjBi?=
 =?utf-8?B?ZE5tWitZSGJmTlExbXhOQWgyV0k2eGd2TE1IVUVnRGhFbThFaVdjZm15Vmxj?=
 =?utf-8?B?K0kzK1E1UGt0MlBhTEtNRzcrYStaa0NwcFEyeWRzUy81U1dhMlFZdGNyS25k?=
 =?utf-8?B?a3dlTjFERElMcTZaVThMZWxzaTg5Y05iYWNXenQwN3BIYWhrek9PNEVjRjkx?=
 =?utf-8?B?YnFsVTB1S24wMHc4K21KQUxGYUlUUkJLeWtVZ05Hb1M2ckdmRmYrbFpma3hx?=
 =?utf-8?B?WVpVTmVCbTBkbW9na1cwbm1DRVY3czIveGR3VVpkTENFNW1NQzV2dGhCWjdu?=
 =?utf-8?B?bHVFQnBFWDNPQWxFSkNWV1ZhbkJVcUR0SEdtd2IyM1VHNnFMclV0bzd5RnVK?=
 =?utf-8?B?Q01tOEloR3FQKzJzMW9xYVUvSHdQbzMrSVpDSkdQOGdPbzEyY2U4MHd6VWR5?=
 =?utf-8?B?Nll3QWZoVHpyN2JFNFE4bmh3VkJuRVdyajlObEFOeTAzTGNMVVFrN1BUNFZN?=
 =?utf-8?B?OWp3VEUvV2w3bTdnV0ZQZGlvdTc1dHN0Q3grNzRkald2d1FBVGpvdSs2ekEz?=
 =?utf-8?B?cnlHMGxqZGxYNThEOUdTVGNOODhtZVFMc3U5YlVGMzhDdHhBNUhFVlpTUGll?=
 =?utf-8?B?a2J3Y0ljdHVtLzNWeXpYeDNFUzJUelN5a0RGREt2Yk5QUUVRbHlBdzZSSEdT?=
 =?utf-8?B?VllmQVNJM3d6bTFEV2dUNlBQRUtwVWM5cVdlakl0emh5a1VWVGlOcGFBbnNz?=
 =?utf-8?B?TjFWbk5IS2R4d0ZsNmExdmxSWkRYRkZrR2pTRmVsTjBvdDdpZzUzMEJKWGpp?=
 =?utf-8?B?MFc5empUS0VtdHBuNGx5S3FRMXo4RHJ4VUptYnVNaGNVSVZFcHJ2MWgxMWtX?=
 =?utf-8?B?WUt0emdsSWo1ZTlVMG9rY2ZPSkd4M1poWjI3cGJvOXZWMmFWRDRZaVIwaEpN?=
 =?utf-8?B?WkxWc1ZMSlE2bG5IYlp6WmZBdEtwTzZMd2JERHhyY3g5NEVpZmtvamJFZi9a?=
 =?utf-8?Q?0MdPNkDd0npH7G+WiqhnKaPxBq97xV3Dt6T+nce1ztEGh?=
X-MS-Exchange-AntiSpam-MessageData-1: hqp6T0vfUJkhXA==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b4f39b-c8ac-48e4-e477-08def8705f93
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:51:05.9711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL9m6M9PtbmgDvhyWMAidrwShl3SrXE4IUZveh4EuW8BIN4SnU/1A3S57dB9ZSvNvzlyp7ylt1aMI4+cQxzRUP5PuhVkwzqUomGg6ZGwEcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9728
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlVLklTuazlO1MpZrhcjX3fy2ptFUZm1Fg1bSBNC8vA=;
 b=AXfG5bjwRZwc4J4+G8UtGkxZXiIvw2X2W5xszbhHuKiOx/K/dpiNFaO7Ud1N3ZN9xoR86hYZIvJRE2DSFTzA4iVW6jHczTAlK0TQuajVYMYWnnFkhx40Epdiq9iV4PD/2cNmIyneLCVnbHtHU5ikTM9Uei+hX2MacyfL353W5v0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=AXfG5bjw
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
> Change to use writel() together with the FIELD_PREP_WM16() macro instead
> of using the rk_clrreg() macro or custom write-enable bit handling.
> 
> No change in behavior is expected due to this code style change.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
