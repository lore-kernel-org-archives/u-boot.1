Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2641EC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5027D87CDB;
	Mon, 24 Jun 2024 10:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EJ13PRPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F83387CDB; Mon, 24 Jun 2024 10:24:10 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B0B8332E
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqbpS+oDwEuB6VsRqeHhsAT7m92Ca8Zv8kIDsqKF7zV+aZv/Us35HtsTyryx90lJoWPGOyEuzVUME3KtAdXaHliM+CPAs362Fl2aeqpFXxUZcYcTiRhVGV793Ej6HyOOvfu8b9t3eR4ZNG9s/9defxRzMDR7s6b8KS7fRrLqJUZ2Ujbbam0TB8wI3EKJ9L+isfmeRZ3Bf92X9i1cNAGkVBd1y5nyxqHlYyJ9R9kk078qGlEIDBslv/urRcOILX8WEFCBDPZk7ie5RgZkVZzcUrsrqtgTHa+ApofwY6BO0J093X4UQ6BVT4ICo/6ZhNr2VT/IkSQjmviaji9icqwZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEEMRpzo10XffpVT1icM7NPxCaBk2PcIzLqa0tbxHAE=;
 b=obHfpbXBW3rFaVTDrUrCdFKuMEmRF/93A6e1Lm/mTFw20p1pWGZsAKkSotyIGQHumjQ4xa/y6EkRVIl0RAFol41uN6eP6CyBmzHWhyfOFfA/yjdGh1Q7ZyNiRzzqHa/gn3RiThOjHAy8hNDrmgupzsln1wYS2odXzdLONyoLsEm7xW908EwurSMZG06mjAWwvOU/eLt1CMzU0ueWJ/cDmhDpaYN7aTqkEz/QlYncv08WbjXLD4r96qlx6O7Qpu5GVRWLn8C5B9Ez03jTyiWaXrA/fqXbuuiL+PgxlG3aPNyfqVY/aKZFkL4uBr+7HFqW0FDqhEXj4WkdT1sElWgdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEEMRpzo10XffpVT1icM7NPxCaBk2PcIzLqa0tbxHAE=;
 b=EJ13PRPJr0uNoJjQVqbH5KjgRg55+D55cElcIdowwP2J1ad0+fZRLiiwQSErT/RzMPHpcjb9YQHIE6SqKTI3irVz7Vb7Od16pr4BcgndAGiJJgKncWcAsklS7THHVX+xAVVci5h3iGwYMxarT/4GXxlVEJhQAImU89gZVxlGTYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB9577.eurprd04.prod.outlook.com (2603:10a6:10:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:24:04 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:24:04 +0000
Message-ID: <dc4f2532-4039-425f-8309-f62f73b5feaf@cherry.de>
Date: Mon, 24 Jun 2024 10:24:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 huang lin <hl@rock-chips.com>
References: <20240623175302.1463973-1-sjg@chromium.org>
 <20240623175302.1463973-15-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240623175302.1463973-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c9a67c-d85a-40e9-254f-08dc94270268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUVkbnhUcEh1ZGthem9lbld4NUdLMlYzdDk5aldRcEpvWlErUjJBZGZUU2xy?=
 =?utf-8?B?YTR5bTkwbTFPbGxXVVMrM2NqU2Ztc2FFK205Qm1Na0I0K05nRTRJaUZsbmtx?=
 =?utf-8?B?MUQ4YnNpcFV5MmV1VHNYT0lqelVReVF2NXY3Sm9kOWVXZ01EclpUV2xHdUxp?=
 =?utf-8?B?c2ViMnRvUTR0cWoyN3VxN1Y3ZFJsWTdFM3JmY3Z0bXB5VTNKSjBBck82blRi?=
 =?utf-8?B?UzIvWFdPOVFPSDh5enREMHF4STdSNzdjUFNnekV5SjJwb250cGRyLzAvcWR4?=
 =?utf-8?B?aEtzK1VQOUpIQWZtWVQzRVZVREU0a0Z6NTJRdkVPRzlNVkxkNUdDdzVnb1VY?=
 =?utf-8?B?T1hCamNVbDVvbGwrY0JRbVljeGZ2a0loZG5ETk5OQndUTDYzalgwMmtSUEtJ?=
 =?utf-8?B?MjdjbnZ2cE8zbStQNWJBMW9JaWc2UVlCaStoQndSZjVnRXVBcHo1SG01dnVR?=
 =?utf-8?B?Vi9IU01jY3RpMHh5UWowci9Rc0trOUw0TDNKY25tNGVMTUdidUFuM05leXJk?=
 =?utf-8?B?c2owVmx5ZXdFVzd2RWx3bndQQVZJb3JuWE1pS2R1TFdHaTRGZFUrSzJTdlA3?=
 =?utf-8?B?NjhXWDUvOFVpaXNwNlJLbHJxeEQ4Y090Y2tSN3pZd1RXVWlZbUNOejlJOEQz?=
 =?utf-8?B?amZoTlNjd2Jyc1lJYUtpRGVVazNsc0ROUHkrbUdBV2lpTFozNVRSTmxMczZC?=
 =?utf-8?B?dzdtYy9nRFJkZitEZStPdE1vLzBPbFpaWitVTmx5QXMzbzVhZXVqeFYrbXNH?=
 =?utf-8?B?UnlGSXRTQzhaRm1wMzdST2ZxcHVoN3FtbnAyTXQrSDA3M20xWndRMXAzVUlT?=
 =?utf-8?B?Z2FYVU5nd3k2Nkw5K3czQU5kbkhocGpQVGFua2orNTdQZjg4VXJDbmlJTnky?=
 =?utf-8?B?SWFTZWxRTURVWmtHWnBKSDVLWlBBNWN1cEk5MDRGUW8xanI4R2Q3SEV0R3lh?=
 =?utf-8?B?aXhxWFkyeFhhdURTRnBzNTlQMVVrWitzQmt1VkNXTWZ5Qit5VTBpNXZwaXFN?=
 =?utf-8?B?NHQwYVRvTzRDVDJwNXlPSWVXQjFqM0dKQ2hZeE81SERXeXpSQkpTN1ZVa2Ux?=
 =?utf-8?B?WnhYaDRTVFVMMU1DU2sycXNJdVltd1Y0VnY2Y0xXNXMzUHNXbTVUalB0eEV2?=
 =?utf-8?B?RnN5NHJlZkV2VERSeDRGdjRGL3hsaVBiSkFCb3BKZEVvblNEOVd3emUySHcv?=
 =?utf-8?B?QTBneFB6VWx4d0xSMDBObHkvVXNSZ2ZXdkZ5Z09yalJ1ZXY3VjY0a3FLSHRD?=
 =?utf-8?B?ZDMyM3hlSW1uR09keWU5Q3gzM0JNWnFQaEw4bm13ekpoQkpuSERsL3VCeDY3?=
 =?utf-8?B?dkJJUmh4MDF0MytvU3o5T3NiRkl3cWlndGN4V2cxS0ZZeEtqL3JMeklxRGdo?=
 =?utf-8?B?TWYrMTMyQ0hPTlVSK0p2alF6ZUpsakFEN0NZYWVLZVVWSFJYcnR5bDMyVEM0?=
 =?utf-8?B?NUtKdUlHbkh1U1VzRmovM3RmclhJWGs5UzZIMFFGaXV5bkx0M0hHYXFBM2dN?=
 =?utf-8?B?RHJPMDNNSkI4RmUweXJ4eWwyaGQvRk9FVWFFRENVdzBxQzZQSWJaVHNHRVpw?=
 =?utf-8?B?SnI2YkFwdkJhZnd3bTJvVTZ0MXhYODM1WG9WZnpYSUI3R2NabFBHSE5yNVVM?=
 =?utf-8?B?WUQ4OGRNS1JLVnh4YkpHOVJzai80SmExZ1hEbU1KQjU1NGRBTWdvV2g5cmhQ?=
 =?utf-8?B?UEFkRUROQmRSekVhL1l2T2QycUZ5eDVHRjVuYXBGcVRSdEJKT2VMM0h2UVR6?=
 =?utf-8?Q?/4Ds/27VzH1+K5EuxcoN4kwmMnEjjGyuqatcER3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1o3UzRuZFJ6THE0K1JjSzliZGFLYXVjb01IOVFFdFVuZ1F0VzYyb1dnbENh?=
 =?utf-8?B?bk5BWTZ5bnlkM05OV3A1V1djYk1hZzc5ZGVUNGZuUDFzUHlrWDkza3dRbExa?=
 =?utf-8?B?VU9qRmpvQ1dudW9ETVJNVy93WFdmbXhSNDA1TnNOakh4Z3pCQi9oQmdXTGp2?=
 =?utf-8?B?d295S1lMTFpjVlEwTjArSlp3c01XUnpBdlhJUEhNR05rejZubzNueTAwMGQ1?=
 =?utf-8?B?NDF0VDROWmZtRjcrUTZTd1FmN0NEVXFhU1JoeXpnRXk4STRjUWM0VnVYSk5h?=
 =?utf-8?B?cC9UT2g4R1YvbGEwL2twVUdpWW5RK1VmMkR6dFNhNmlEcExrdWNhYXNGOGM5?=
 =?utf-8?B?ZndDbTZtQkZDTG8weWdSZks0eTRSM3FpU2w4b1JSQ0IzVjI1VDQwMTlYbng4?=
 =?utf-8?B?V2FYblJLd0hmd09wMU9ZajRHTjYzQTJ6bnFGOTVSRHlxWjN1ZmRRYldGWjdY?=
 =?utf-8?B?SmJ3dVY3d3RGejI5TlJUMGVsZ0dPSmNBdHdIYTYvak5ZYXlHeTZRZGN2eUVU?=
 =?utf-8?B?ZWhhUytVZk1ISERXMlIwd0o4L3NXUVZPV3pNN2M3d0U1cWE4UW41ZHFHa2ZZ?=
 =?utf-8?B?Mk1xNlpKT05CcHlqT2VnTm1ReklyU3ZBNE94T1M0a2dTc0orVmtHUHAvT3Rl?=
 =?utf-8?B?NmJSL1ZzMUdmbnlQZDY3WWVodkVIakd0a3VzeTlna20xcWRtRGdFRU1GZGRY?=
 =?utf-8?B?cmxCNzk3cjEvcTJxcmhReXI0QW5kMFlvNFlpVDJmTGJLR3BmdzhmOFYvT1hV?=
 =?utf-8?B?WHVDT3Z5WVRELzFURU9zcjhISUJ5UExtQXBwaEhvQ0Y5OSt5UDduTE5tSGVD?=
 =?utf-8?B?VUMxU2xSeDliMmd0WWhMQVQ2NnZOSTg1aHZHamZZdDZwKzI2elhERFVpZUR2?=
 =?utf-8?B?MWZhY1BMbzd0d1J1VmkyaGdVV2t4QTdmYWZJZFFyWk9zVXQzVUxpRkZqQWkx?=
 =?utf-8?B?enA3QlVVOWQ2WW1MQ2FLSldPVmhod2FvMUplYllFNGNlMEFhTnhDNnd5RVRU?=
 =?utf-8?B?ZXRpSitobWJ4U0xWcUt4WWF5S2MxajAvVG1yVUlXcmdscUNzTGUvZ0FQUHFv?=
 =?utf-8?B?dVVIQW1YdU1Xdm1CUHBuZkZIVUdneU8xL05HUnBXeE9Yb3NBQUhYSFYrY1Zo?=
 =?utf-8?B?V0x1L2tHYU9MR0lUWVRnaE1RZ2xCeVFhd0R3SjF3Mk9xWkRDRVJ6eXg1ZzFu?=
 =?utf-8?B?WmlCZ1B6NlNEYTJJeUlLdU82dVVBWGhTRmtjelBHNUpXZmFDYVJoSEJqUWFQ?=
 =?utf-8?B?eEkydDF6RGN3NWYxRUU5ZXQ4NDVyY2xSWXJaUCsrWGxaV0xMa3VkZ3FDeXd2?=
 =?utf-8?B?bGVFSTlEbmJXdStIdWowakNuSDY4Mm9wZ2N5NWl2TXBxdlBnOFBSaU4vc1U0?=
 =?utf-8?B?RURXenBlSUFlY1VvSjBoREgwREpVbnZwTVJhKzhRdjMvUGppVXc4Ty85QnZz?=
 =?utf-8?B?dHVxc2x2Ym1ObmJXZFg2OWxza1NOTlBLM1JYRElrR3pHcDJHS3diNXFHVFdU?=
 =?utf-8?B?U2tYRUYyN3FuTC9qTkRVOGF4bFhmQ3JoRExxTlpQRW5ncjNSUjVrN1FxcGo2?=
 =?utf-8?B?c3NhTUdMZnJ5RGhtV2s1V1hZR1VKZlNqdnZqREdZSy9GeHdySmczUkVkVnNQ?=
 =?utf-8?B?RjkvMUZhc2JqUkcyTGNzdkZWREcwWmx5c2VsMmVac1hmRDE2UGs0UCttSHFX?=
 =?utf-8?B?aVBjbWttcjJuSEl4ZFMxOUN0U201TkJqVHFxYVNEbkFwd0YrRmc1QVRreGJL?=
 =?utf-8?B?SEQ2T3ZLSHR6TEcrS2NnT1g2MnY2YzlhcUxyVHpQcjNlbURQNCsweUJyM0Y1?=
 =?utf-8?B?T3BMS2o5REVLWlZiOCtCN1FPSzZWK3FIVENERDE2Zjc2d2U4SDNGNi9FTlNT?=
 =?utf-8?B?bzlmYVB6TEE4MmtsTllPMzI5TTJtRzhNMC9ZQm1tT0tPU1dZdTA1L3JMZkkz?=
 =?utf-8?B?UWIvcjdqNDYyaFlpcDRkYU1rRS96czZ0UUh2WWtYc1lwRFJEV2Y3VVZQUVFo?=
 =?utf-8?B?ak9rWU1rRXNoSnllZXZ0Zno2Nk5FRUVCUHljaDFIb0J4ZFljY3U0a2VmQWZ3?=
 =?utf-8?B?VytrbDBMei9rOEFOKzFhRCtDVDdCMzhzUVZHV2NXK2NTZVdCK3FmU21za0dJ?=
 =?utf-8?B?dHlHMmFYVzdGdmtrUlVhNDh4ZEIyTVd0QUtsUkg5M1dwRytRMFIvRDNoVVhj?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c9a67c-d85a-40e9-254f-08dc94270268
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:24:04.5667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A6G9hctD/K4g5s5P07V8c7SXydl5F1S8r2hUpkMz4wg6um4R8vxu7zH24fdDUXOtlw7cTb7F0Yz5NwwvzCsKTa4RVn3TROlve94pg9KHK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9577
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

Hi Simon,

On 6/23/24 7:53 PM, Simon Glass wrote:
> The code here is confusing due to large blocks which are #ifdefed out.
> Add a function phase_sdram_init() which returns whether SDRAM init
> should happen in the current phase, using that as needed to control the
> code flow.
> 
> This increases code size by about 500 bytes in SPL when the cache is on,
> since it must call the rather large rockchip_sdram_size() function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Drop the non-dcache optimisation, since the cache should normally be on
> 
> Changes in v3:
> - Split out the refactoring into a separate patch
> 
>   drivers/ram/rockchip/sdram_rk3399.c | 42 +++++++++++++++--------------
>   1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 3c4e20f4e80..949a082d00c 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -13,6 +13,7 @@
>   #include <log.h>
>   #include <ram.h>
>   #include <regmap.h>
> +#include <spl.h>
>   #include <syscon.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/cru.h>
> @@ -63,8 +64,6 @@ struct chan_info {
>   };
>   
>   struct dram_info {
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>   	u32 pwrup_srefresh_exit[2];
>   	struct chan_info chan[2];
>   	struct clk ddr_clk;
> @@ -75,7 +74,6 @@ struct dram_info {
>   	struct rk3399_pmusgrf_regs *pmusgrf;
>   	struct rk3399_ddr_cic_regs *cic;
>   	const struct sdram_rk3399_ops *ops;
> -#endif
>   	struct ram_info info;
>   	struct rk3399_pmugrf_regs *pmugrf;
>   };
> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
>   					struct rk3399_sdram_params *params);
>   };
>   
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> -
>   struct rockchip_dmc_plat {
>   #if CONFIG_IS_ENABLED(OF_PLATDATA)
>   	struct dtd_rockchip_rk3399_dmc dtplat;
> @@ -191,6 +186,17 @@ struct io_setting {
>   	},
>   };
>   
> +/**
> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> + *
> + * Returns: true to do SDRAM init in this phase, false to not
> + */
> +static bool phase_sdram_init(void)
> +{
> +	return spl_phase() == PHASE_TPL ||
> +	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
> +}
> +
>   static struct io_setting *
>   lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>   {
> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>   	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>   	int ret;
>   
> -	if (!CONFIG_IS_ENABLED(OF_REAL))
> +	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>   		return 0;
>   
>   	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
> @@ -3138,22 +3144,21 @@ static int rk3399_dmc_init(struct udevice *dev)
>   
>   	return 0;
>   }
> -#endif
>   
>   static int rk3399_dmc_probe(struct udevice *dev)
>   {
>   	struct dram_info *priv = dev_get_priv(dev);
>   
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> -	if (rk3399_dmc_init(dev))
> -		return 0;
> -#endif
> -	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> -	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> +	if (phase_sdram_init()) {
> +		if (rk3399_dmc_init(dev))
> +			return 0;
> +	} else {
> +		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> +		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> +	}
> +

I'm not sure we need to put the debug message into an else as this 
pmugrf is also used when dmc_init passes.

Additionally, we could also just set priv->pmugrf before the if 
condition and remove it from dmc_init if we really wanted to.

>   	priv->info.base = CFG_SYS_SDRAM_BASE;
> -	priv->info.size =
> -		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> +	priv->info.size = rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
>   

Can you please say a few words about this change in the commit log? Why 
phys_addr_t->ulong here?

Otherwise looks ok to me,
Cheers,
Quentin
