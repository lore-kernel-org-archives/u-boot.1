Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322D8C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 10:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D81388512;
	Tue, 23 Apr 2024 12:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="QK/LxVJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA6388518; Tue, 23 Apr 2024 12:09:23 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0716.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C304D8850B
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 12:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTjySDUm76W63OD5LR2YSVb5VH1hubFkD7oh5qw83mFwJ0GuFkOjU49RhCX67iyx7c4qLJBCZD1PI+M94kzyYdEulRSadvDbh/wJtE4cC11jfdx9VAyhLHiHfwXPnhOfXW99WV5RT6xRZGPDFLAUdgz43pK0FejD97tsrTRNqwxIMIi5yujdIsouH+fAJbgR06nAQV/i6GPpdKSTVuzAY2mdXh6t+FzZSGJufNKJ9UnFcoosglcs4AHw5uTRzVectrI+IX4txHKAuguVt768YILdzXJIqHO3a1s4OPSR9SAByyOKCpH5b7y5bYrqFIy7YgjGgn6STWXGenfQr+5+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2reoVU/1qO/h97QO2yEZmcTUNTrREkeyRMdov6YVi8=;
 b=Zm3jPuj7utoVfmjC1b3MwVZVOuKE7V9n3L7EclW+tyT8x+wS4OzCOWXDLI/FkK0O03uJ+AeaJSy+NxgBLSLYpc+XLL3BcGl9/KE2yEfeNDZ0zsQs8o0zco13MgFSaSCDdExyqv+lI9lsKfnlT+lJbN8w58L0nHwtuIukFRAgaCj2NBJ60HUAmjAqgzDaT/UBOTiuhYD7vf2JXOcL9Joh7W6rAcJ2ZaXhU96h/sxb/g5aV/OaGeraBIhtHvgLyRWDLewdchqUZ2i52hw498tIcEggzqXSRNeEyqKJCCmd3taRw3mhETNmRI95ZrlbQlmn147r5wr8icJkfMIi5+0Kjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2reoVU/1qO/h97QO2yEZmcTUNTrREkeyRMdov6YVi8=;
 b=QK/LxVJ+p9c0VSC+i1RURx6CNtuWFrRO5c4ss50g2pPnjmbtTov7eMOiYPAeudDFEXN4S0v8INN5MLqSaW3X+6d2SjkgDLAITPunnLPSMm0DJiOuU8yXY8w42kb9yRqNdPbfH41n1+ppwOVhlcxwbXZ5XTk2QppfYm7MtpkoSSiScle7cN0xljv6y1e56wo2y1UiJX+kChTFsqw94FwDXsGBdYmmPQbW9exFwlayJmPqVl/m4MI+7vwA199pQTvtm8A0f8htz6vgSXJpw4TAO34rdjbYt1n2XpVhBH1/U3nIxvrVKaODXIhNsc2++/d9th3JY7uzutVh2vMr88s0yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:09:18 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:09:18 +0000
Message-ID: <10a09cc2-6364-404c-a9ae-b78b3b5dd713@theobroma-systems.com>
Date: Tue, 23 Apr 2024 12:09:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
 <20240422-tiger-v1-2-8816b070d748@theobroma-systems.com>
 <550c0a29-c8ce-49ab-a7eb-f1127c37c786@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <550c0a29-c8ce-49ab-a7eb-f1127c37c786@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::28)
 To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbe7dd0-6be4-41f9-99d1-08dc637d7055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGhOZWE4dnhSbmZMTGZyYTFYTDY1Qkc4TWxsVUhQMVhHaHdPVlg5dHNyWlM1?=
 =?utf-8?B?R3JEQ3JzeUlEWS85dldWcXY5QWI3dGtrOHMxc3FwVzdjaUpPOFlWSkRVYVF6?=
 =?utf-8?B?YTkwK21NaTNvWXk4SjdwZUt1M2FhMlQxM0hSZXQxY1lkbEQwWXd6MFppTVA0?=
 =?utf-8?B?VEhQbVZBYU5OZEtiNk5UMys2Wm41VzJ3M2dTWThESERXd2lnU0YzUzlvZDMy?=
 =?utf-8?B?WWxIbjdwd2RWczJOUS96cUxuM3kyVTE2a21XOHM1KzhkWEIvcUZOOGFQcURm?=
 =?utf-8?B?U0V6Ynk1dVRPdGM1dklvQncwOXZvKzRteTYwZGo0WXpnN2haM0JzcFRJQVpU?=
 =?utf-8?B?SUV2ZUVhS1VsNmZ5c3BhZFQ4SnVKUWhtY0twaG1pQTNVRExOc3NZN3dYWCt3?=
 =?utf-8?B?OGF4Q1QyRUt5Zm56Z1E5WFBiOW5lVGtNVGFyd3Fzamo1aFZzRGpvekRLaXlV?=
 =?utf-8?B?YTlGb2xEcFBBbWdpSXYvc1JNdjdTazhDVlpaYzhuRHc4SUtoRlhFbUptWXI0?=
 =?utf-8?B?akRtRDBBRmthdC8vTW43SnppWHdNRGRkVzZtRmdlK3lqZ085YW91TkJlWGtI?=
 =?utf-8?B?ZGpYZDRoWEFXUFlzY0RDWnE1M1B2dUZNTklXcU1oZWZPc2hmK2toQ2VnY1hN?=
 =?utf-8?B?ZkZ2bEVMajB3Y2J4alpwQ2RlOGdLNGJUVTk0elZ3MUd2dy9wVjVzbGhvVlVN?=
 =?utf-8?B?c2ZyWDYyQi9iOGVKUmpzWnl3WnM4dHh3NldxSWZhRWdTaXM5cjRrMW82MWVP?=
 =?utf-8?B?SU5aR1JMVXlhL05ybG1KVUNvYUdRV3hUbXErTjdqWFhad2tmUlhsekUxdVgr?=
 =?utf-8?B?ejY1eHhSemtVdG5EK3h3Z2lIdFhJYmU4c21rcis3VkMxYmpVUCtDRDhQOE9r?=
 =?utf-8?B?L1l0TG43cUh1Q3AwTkxuWkREVGxtelhHN1k3L0lZWlZjQzZBWjI4RjZXZXhN?=
 =?utf-8?B?K3lVLzdONzlqUExXOG81aVMwaDh6Rm5BL0FNaW1FL3pXaWVqQktWdkZ5MTNz?=
 =?utf-8?B?UktrY1lBMUVXRHBwZTU4Yzg1dk9zNG5uQjBvMzlBbGFhTmxGYkkrS0QyZllS?=
 =?utf-8?B?RGhSbExBUlNteUxzWTlDdGJXWG1EenFmU0J4cFp2dWJITzAyc0lSQ1V1SUIz?=
 =?utf-8?B?VjRKcWNGVFF6YlpOV2hseXJaZ1owMnJBdExoSkRyNnNZM1EreCtDYnFiRE5O?=
 =?utf-8?B?U0x1T2YzTStWdFRUOW5WVDVkSmtWRlpIUTF3N3dINmlHTzk2a0RaTW5oMWdD?=
 =?utf-8?B?cHJObUUvZkNQL0wwdFU1MFhGNDFWUC9mRzloMzdwZk1wcXN2UWlKcHpQM0pX?=
 =?utf-8?B?eUsrNi83aDVYdU5pdGxzS3huK2hIYUVJOGwxc0d2cGNTUG4rN3pEWEduZmdo?=
 =?utf-8?B?dllabVNGWjlBSU5Jb0ovMTJ6QzI4MmZtMEtObHpVanUrMEE2UjVpSEtFcEJX?=
 =?utf-8?B?cFZYVURGSm9uRTFMTGRWeVJuYldMSWVPMTNCTG9sam9mNGlwWHF6UnRMSSsr?=
 =?utf-8?B?UVJjamRaOGRXODRzU3JXMU5KbHZQUnhGM1UrenRob1pjQXhPcWZQMUpoakly?=
 =?utf-8?B?UzFUWGpVTWkrZWM5RDZoR0xNZlphYlpTSEN4QVhUQkpzYUpTZVUrUWZFcGxF?=
 =?utf-8?B?N1dVN1dLcXk4SithL0N1QlM5Tm9YKzFuZ1ZXdGhJZTIwcXlMMGdCOFdtVm5I?=
 =?utf-8?B?SlZZOFBIOTBXZTRDbEtyZGZQQTZjTm5CVGVnYWJQVEhnUUlMWTFyNlpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4833.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2J2bkV2UmlWczlpbkFGMDg1cWxPMHhXcUluOWJ0aURZTW9tSldOY3Y5bFN2?=
 =?utf-8?B?U2sxL1FwZjF0TGZ1TXI1L0VxSW5wMml6T090M2dzc2hzT012cnl1VWNsWWFn?=
 =?utf-8?B?RHkxNXlSVXpmQmx5YkJqbnNyN0piY29neFhROHdiZ1NMQ3AwQ0poK1F4N09O?=
 =?utf-8?B?YzVUZ0hrKzR2T3FjQkdWT2M0RlJYRU5qT1F2bFd5Z1hKM0x3Z1E0ZGxHeHRo?=
 =?utf-8?B?QjB6dmxhSEpmQ0RZRUZjcXRvTGtIZVVJSUxiSzk0Szl2WWQ4MkU5UzVuQmRP?=
 =?utf-8?B?M0lMT0RyVDgyY2dLeFVLWEEyUXU2OVNkYStPdVJTOFgweWtMc1RMZFdVS3hX?=
 =?utf-8?B?SWQvNVNoTG9US2t6U3psRGZXRTdFWUMrYVg0RWNhdHdaU1d1UVk4LzFYVXNj?=
 =?utf-8?B?YlFYcEIydVd5c3llRFF0a0lQMndOYmNiME4rKzJWUTFUamJtclB5QjNPKzdq?=
 =?utf-8?B?d0RHQzNkMGpVMzBqdW5SbnFoVlZhNTAwanMzdUF3Tmhma0hpQXFrWEVHaGpR?=
 =?utf-8?B?MDhwaDNZaUhoMTl1RTNEWVlXSkc2bG1jNi9ZN1o1bW9xaEVDRmhlYlVOc2I1?=
 =?utf-8?B?VEZHMjZvVnZpdytqZjRsNnEvVjZYdld6S1I1d3UrckFOVHhSOVVEeUxlcHhD?=
 =?utf-8?B?b1pYSVVJd2tRKy92OHRmWS9Sc2xYazdzSEhEd2JOeEp1MTViS2svaG9HcEhK?=
 =?utf-8?B?MHVaZW5iREoyVmczSzFCQkdiM051eUtUWENQcVE5T1p5L1FJbG5FbmlHNklt?=
 =?utf-8?B?UVlFdU45OUhHN3Z5MEdIUmJ6bFFSb1ZtYVMrVnhFNS9Qd0NHVDNSMmgvWE4w?=
 =?utf-8?B?aUJhMElQYVJlZmMvc1pEOVpXS1V0amZoR2dpYlhMVkxscWI5VG45VWV1akFn?=
 =?utf-8?B?UTdvSWJDdXF0d3lFd3gxR2l3U2FKWHlJdmFRUVNPMWlHMkNOWVh2OUZIQlk0?=
 =?utf-8?B?VGRmUExCcm82R1U3N3pQQm91RkFQd1VDcXJIVTNlOWp2SmpaZ2NKcnBMOGFC?=
 =?utf-8?B?a1IzTGpZNVdTZ0FJbWtNNmFmNURlUmdwSkdoMWNXZ0pwQWtIdFplNUVISE5l?=
 =?utf-8?B?aEJ3MUlwUHBCUVV2LzBxM3lDNmxPMktlYmJVakFBbzRTbHlpb3dRQm1JckRY?=
 =?utf-8?B?eVhUUEd6eTBpeXJGb1ZEQTBFelNhZEJOeTQwRklpa1JwV2laUHR4T3JMQ0lS?=
 =?utf-8?B?WHJrS1NLZkFDaVpNY3ZuQUZLTUtrVE5uK2tyajh1eUptclF4MXlRRzM0clBL?=
 =?utf-8?B?SDdSOFZ4MjRoNW9XTkx3VU04S3RISzYxRHlGNlVtdHhCSGZ0ZGtVNkwrc0Jz?=
 =?utf-8?B?R0Q0ZVY1d1hNYjlZYkxzYW5lcHZ3WW9mT2dYbnBWNkFFNmRXZzN3ZEdmTWlk?=
 =?utf-8?B?NkF4Z1RhUnVZcGFsamNNWGdpRlQ3RWE1VExRZXljaU51ZjNkbWs3bGE1NzFC?=
 =?utf-8?B?SVNGaUtnYzRadHdQb0tyc0xobU1yZVY1SjNjcUhmWUdKd2R1WHpVYklXcjhk?=
 =?utf-8?B?eUwyeGEyK3NFUzBpeCtzdHJTM1o3QU9nTlZlSDIvYlJET0VIcDJDeE9KMUJ5?=
 =?utf-8?B?cDVNU0NqODdsQUVxUktoTzB0STNrYS8waUhQVFZZU0RDVkluNHpjMVZZRm9P?=
 =?utf-8?B?UUxpZ1VycTdZYTFIbm5nUHJDUS91d2srMW1KNVBOVTVZM2t3Zy8wci9SZklr?=
 =?utf-8?B?NEZEazZyYnpmQURJZjRkMFcrY2NhVDduQldubXlaMkNoM1VOU21mTXVKeE41?=
 =?utf-8?B?TEJDNlp4TFdUZUFNM1B0MHB4Rm1tald1MGU0a3NCWDB2STFJN2NFY0llQ1RK?=
 =?utf-8?B?b1FXYjlYTlo3ZlB6OFlxdldTTzZsditnejRWMXVRTUV5ME5mZ2NpRDNhNGRU?=
 =?utf-8?B?Y1ZqYjNXNFJMNGNFSDd4UGFCKzBxZ3JNTTk4SzJ1UVB0b2dVOG1WNFVnbjFj?=
 =?utf-8?B?Yk1YcTNTVWlxc1pEQ1ZlbEsrVVd1dDhKdXI3WkpnUGJ1ckdzaEk2cWdHeUZ6?=
 =?utf-8?B?SHBMOE1ObXJKL1NOcFJYa0JRZnBUVzFwWlorei8vWXIxWTM2TDB6WkFhV3Zi?=
 =?utf-8?B?N3hob0dyMktvV3EzbFRuMysxdWN0Q0FubkZYdkt6aU1yYzM1MlFwUU5Iejdy?=
 =?utf-8?B?bzNXTElualFNZCt0Z2xqRTUwRzZJcyt3ekZDUVFySFhVSWFRaTY1ZkVPRXBP?=
 =?utf-8?Q?o4DawaQUOOFq74jTbRurqq8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbe7dd0-6be4-41f9-99d1-08dc637d7055
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:09:18.8325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJFLimtCLwmhQJyPHqmOr67zoDiAoCGBM/Kb5x+dgMyEbnYIBpznZ4C5L5cy080OC8kzcpHchwymPGa2StpvSRvs/+R93Yf2ZESQX2yhKxHg+WdnfG8JFHvNedIiLalR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

Hi Jonas,

On 4/22/24 19:54, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-22 18:41, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
[...]
>> diff --git a/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..4259399193a
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
[...]
> 
> Following should be added to possible fix uart2 pinctrl in SPL:
> 
>    &uart2m2_xfer {
> 	bootph-all;
>    };
> 

Would only be useful once we get rid of DDR bin, but will do it now 
because I have a feeling I would forget otherwise :)

Thanks for catching this though.

[...]

> [snip]
> 
>> diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
>> new file mode 100644
>> index 00000000000..6545445bba1
>> --- /dev/null
>> +++ b/configs/tiger-rk3588_defconfig
[...]
>> +CONFIG_USB_XHCI_DWC3=y
> 
> Please use USB_DWC3_GENERIC instead of USB_XHCI_DWC3.
> 

Dang, I thought I was using "the correct one".

It's very difficult to know which one to pick right now, would it be 
possible to update the help message to guide the users a bit more in 
their choice? I don't really have a clue why one is "better" than the 
other so wouldn't be able to suggest something.

Cheers,
Quentin
