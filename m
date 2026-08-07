Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4DBC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 270F740ACF;
	Fri,  7 Aug 2026 13:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNrQubVhGZt6; Fri,  7 Aug 2026 13:25:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B99540AC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786109100;
	bh=ksB/g+btfZjBAcubC9HkuMcyN1OzgXhMdH5g67C1XiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KLvnjumt4XuqdiyJirlnZPOkl24xEKIRAmwo1WOHS2RqW+BsRbmTg9iLsSLnSkXbg
	 skDzFGmKeOodYoDpFnsM6iPK0f3dmOzn+iabkZlAfq+715pRmYCe5YDNc1YBT+oV8o
	 Eazud1Cu38QE2rZiNHJHKgour3lrptowmWiRHdKtvc29NygzLfQlDQWavPM3gh9V6k
	 Na/DN7RWHcizAS6riN/lETabW7giHL86Z/CRP7C5JRujXP9k1Shqz7bVpo9L2Llcaw
	 7xBsWShSduEt0RYCB48+eRaC7QgDQftQrDCNn7qlnF2MVuoY6P2iWT4aIGA03mGCnX
	 B09Is7mn/yBcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B99540AC2;
	Fri,  7 Aug 2026 13:25:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9FBAD3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBC1340207
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tW0hZFYI5N7W for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:24:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BADCE40074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BADCE40074
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BADCE40074
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVmYCpS7v8uBWTFTAHksxiL4zEMZN72sxPdDsfHJc2bzfIBkhVoH7yi/f0Jd1Ap6hgv2OkeAQArI2+BbqZcvN7Mj9WKj0d4ZEEA0sP0M+vXRw0TGt7320fajjioC35WbIlc7u1AK/KpYu9nFwqdmVRh98GBzw8aOGbDUCoObg3jdIyiRomuOqT261Nwt2Pbk2RmMdJ9ZArFvErkVlCT2lFtVimSGQychVl5OC0ir6bnqJT8RmTVr0Kq3z7ohfXuZAEfI9nXl/+XrfLpP0OtxEKAHihotq30AILEaQyK46mv1XuxwF24pLFvaNBsOA1yFLMniGRgfDDz+sI/HjfL/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksB/g+btfZjBAcubC9HkuMcyN1OzgXhMdH5g67C1XiI=;
 b=YioRVzCRwHBOKM3TDHlp3FNaC/smOkog/tMW2x0Lod98aPV2AK1nMhbaDau3KYi8Z5woBLJfkurFN1JJZhRYQ0SD+OOBSw+1Kh5v1xgn+sV+eCyhus0uTGNQX8Vl8axi12FwpCdW8LKP27h7GpPy4F19MfKiUOdzKqz3N2zHxs6ZX1ESgoT3cXFMH0FP66CkpgF230AaPjsvQp5dFfwXq7BKQMMllFXsMQh0aHh7SAnxdY94sXwCXvv4Fwi3BhTunb6vKkaMMiHHEIn2FJUUuA0gNaWYvMerB1m68mplDUxhxCYpWu+NfOKyGuizLdAhDdleGxbHaxLxJQ/i6V1Z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 13:24:51 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 13:24:51 +0000
Message-ID: <e4e89e23-6df8-41ba-b6ee-bebefb37b13b@cherry.de>
Date: Fri, 7 Aug 2026 15:24:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] clk: rockchip: pll: Always write the dsmpd flag
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0099.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::28) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU0PR04MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fd487e-e54c-4ea5-f6a3-08def48742c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|23010399003|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: IakjsecMh3Gc7Izhn3F+UzKkOVnNxVqzDZqshCghCSqhy3LBMpSkPfqG3ZaSeSajD2MlNOGu4WkREIakYavd6RaJtYXD4tgj4u1uq8HEp+k93rWZ5HA4iQsDV4tm9cYDcE5s4wnywzFm/hP2L4ytFCMY3S0cAJ07sLKsMbohXDpHaZUoyCp+b820WFGBEABJwP0LRtXh/D7JtLsg7HK49mWgqe+gY59GX2GupoTzc0BbXfyh04ymEVjTMHtp2Dz0px5xth0/pn4ZENgBRdUIx+esOZV7umJDvqYwSfATS1fFRGRtXtdXMmEjgUKx3IRPUWk0HmdFuTTqhZWzOSw7j2xlg5KnDwMH8ONFmg/V8FOA7JgbomvWUWCxdV/1yytBDzcUCTvmWKbsKYfG/vEtaX7iG79ckrThdFBIMJEINdVjl4gmUt8/0kzQwvIxfKaWaky9jqkwKLt303NPcdwjEKTb8/uPzeu+Th0WUihBkgdJzLZvItZJw6b23E7XVNt64nZ99Pi+A0ss+OCkA3TN43qhrbVwsWolG2k5WyqAuh0x3hK+QuqgJL32WBwSJgNsqwxtJfXKVwfVt/o/HYPMoGc27CpZbVnXiKQ+Z9T6L75WAcZVHRYcPscBQUK53bfPntFWtrbGLxTALNUR8S7hCjTaPEGjk/+T7buewiCT55E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rll4d285RkErUXh4TmdHVDVyNkZRZUdqTDg5V3lURFpwMSt2bGYxMHNoV2dz?=
 =?utf-8?B?Y3lxNGZOR1ZZZndtQWcrdW9BSGxhbzRDa2RYbDgvZ3oyczRmMmkwZEZLNm9u?=
 =?utf-8?B?eEtVU0dPSW5QTUFObE5hTDZTNjdaclhLWFBUdk0wL0xXdjBHK1N0dXhoZC92?=
 =?utf-8?B?KzlyMnZvaHl2YmRwK25LQzN0MFhOOEdDbzFrMExYdVFMZE1xSEl6d2piNXpo?=
 =?utf-8?B?REN2a1JWZTlCNTMyMkl5KytHUlNMaVgwUTdwbGlSUVhUdzY2alQ0U0ptM2pB?=
 =?utf-8?B?TTV6VEdvZFBvdVhMVEppRXMyeDhOY0JYNlo5YU1rbmdVYWhvRlNOTkFIZUow?=
 =?utf-8?B?aXBIZkcvTVlHdmlKY2oxalAvRFdVL3BkT2xBS0JSMG15aU9PdHBOajR1Z3gr?=
 =?utf-8?B?Y0RTckFPeUF0RGd5OS9VbUI4NmFDZTdma3NPQmJQY1dpZjFJd3BDUWVvQzB6?=
 =?utf-8?B?ZVJyelBPMitSbTlJTVhKbXhvSTFpbDdOV0NvVnI4a0t4cmFQNzRlZTFHaDlj?=
 =?utf-8?B?Rm9MTFYrMkV3cmkyUk5YNXBKYWY5Y3Fsc29GeTczT1hmTVdEdlc0VU9QcTNK?=
 =?utf-8?B?MU9YazhRVFhwbDg1WmlyWGs5UTh3RUczVW1Cako2c2F4N1ZzVDVuazdqc05U?=
 =?utf-8?B?clNERW92VGphOTNudnRBOTNZbDc0ekV2alNnSVdHajhQZG9HR3lOZXRtS3Zz?=
 =?utf-8?B?TWVpRmphZjJPd1V0VnlTTWZwNWEvcDFYbTFpbVNRU3BpTTgyTDN0Vm5udzB4?=
 =?utf-8?B?YzhXekMzcjdkbDR6UmpXcFVUZDJFU3hTTG9hMHdZcjlCRkxxRzdQVFI4YUk4?=
 =?utf-8?B?b2o4UXZjb08rRVVtMFhnQjFmemQ1b2hpaUNlRjBxWnVjVFBXUXBUYjIvNE5n?=
 =?utf-8?B?eVdpMzZ4azlVREF0dmljanZqMDZxUkwyZFB0d21KeUIreXhNOU9IQkE3ZTdB?=
 =?utf-8?B?elJLMTBpZ1gvNmtCN1VvbW0yb1owMUtWNzlsbjdrNlYvYTVnYTNDNU83VHlF?=
 =?utf-8?B?NDduL01YNWtwT2V0UWdncXI1ZkM5NCtyVTllcWpuY3Q1RnZjVUU0dzJ1cWI3?=
 =?utf-8?B?cGsxRDFvWjI2NWhJQ1FHSy82ZE5BMkVGSW1CZ0d5WVE5NGxOMXFwRFdoQk1V?=
 =?utf-8?B?YUgyeFphbWVlL091a0FjNGQvZTZ2RzZlTElqRVV6Q0hUWUxIUC94Y0ZrK2VI?=
 =?utf-8?B?dFYwdG1tQkJUand3RDM0c1J0R3Nsb1lBeFJPT0lhbzdrR0Q1NGtpajFaUmNv?=
 =?utf-8?B?Ulg4RytpQlhjdDJtNVhIdkhGeGJLOHFoMXVLS3ZkbUhRTEZMTlhwK0U1dVcz?=
 =?utf-8?B?dDdjS1RzRE1FVjhYaDBoRmRLY3FSTWlRdkR6eDVXNDc5Z0loeWJCL2hDZHhP?=
 =?utf-8?B?aVQ1L0VnU2lMOFRONnJBRU5TSFlyUDZFdFpXOURaZkxhUUxENnRQN0JzWjZq?=
 =?utf-8?B?Uk05YjFOakdDRVY0MnlhWEg1KzNCNzJHUkxVRVUxdVdVMktqeGlnL1pNc0tK?=
 =?utf-8?B?UFBVOVVtbU9Wb0tLT2ltb3lGdlVZeGFTWEZrbnpJRUZUSFZoOStMajVFREll?=
 =?utf-8?B?c1NJNXZMRVdYVVp1aU5xOC9BWVNBaGRLZldlMTBaS3pMbXlYMGM0anNFcEFu?=
 =?utf-8?B?cU82dTRRcDNZdWxKWVN2azA1N3I5Vm5KQ2ladjFOVHJGdHZ2TXBHWmpZY1FQ?=
 =?utf-8?B?UXlWcnFmYzMrbEIrTmF3NmxCL0JaTnJFbW9qT3FtUk1BQXh3dTFsOTFBeTZ4?=
 =?utf-8?B?L2Q2K0pHcCtLNDBQWlRybmIzOXh3QVFxVVZmRlhybzRUS2poUUNxSVJwc0Ur?=
 =?utf-8?B?YTFNU2dnUW5aaHgxSEJweWtUQXBMeVpqUWtLNUNJVUxVT2N3bU84bHdtejcx?=
 =?utf-8?B?K2ZucXNUR2RUUHZmKytRK2xMZHhwZkQySU9ISUt1NnM4bjZKdER5NHBiSjFW?=
 =?utf-8?B?ZWRIaUJGSTVuTjRRajd0RFVtV1JEeFdXc1FrOVQ0cDRQdzQ5UjBsM1ZQRjdV?=
 =?utf-8?B?ZXo3dTF2ekxTVWJGUk96YzZMNDV0d3l4Q3pieGtlZnNjMFJnWWFrWlNYTmNU?=
 =?utf-8?B?b2dsUDdWT21iSjBmUTBsMUhidktyMVBZalpBb1RtZ1EwYjQxQjl4cm9XRFpI?=
 =?utf-8?B?dStLckVwc2JrUHYrK1g1YksyemIvWGtDT2FIa0Zndmc5ZGdNSUMvbzVWUEJU?=
 =?utf-8?B?L084YXpXc2VocjNyVXU3QmhTZytZNEl5TnljdlhwWkQ0OXc0M3VwTkJhSTZj?=
 =?utf-8?B?ZGR2WWVlbkY0UFZ4TzB2V1Y2RHBNWGp5T21kQTRqWmtoSmJlb0tKUE1hbkJv?=
 =?utf-8?B?VkNudkJUL2ZweGpZMGUzK3JTVUE0MHpxZUNPL0VuMit3N3hnUkExQ2tJUXFj?=
 =?utf-8?Q?xRNie6hpYvJvCnrOQcrTTmitNeV1B59YAMAdndNLIcZpz?=
X-MS-Exchange-AntiSpam-MessageData-1: BRQeDyl+nt/ROQ==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fd487e-e54c-4ea5-f6a3-08def48742c3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:24:51.3116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd3YA64tJdBU9jphsqaihRfNw9enhIR7CpQRpRtQYV+mSdP6iZHDNzX44LCqwA0n6jC1YVKKv9w/9hTmu7NTMRn6WcTYPcN51qhxdl/wLtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksB/g+btfZjBAcubC9HkuMcyN1OzgXhMdH5g67C1XiI=;
 b=k6TOJ7gLVey2btGFFuq6Dhq6yurHcKkOfryItFBiFsCs8jbiqGSiZ28k3Asy90X2CDq4mHMlSOtctJgJCDHmjihF5uyFNZeDhxQc+wIaTqQEYuEaMk/ys4qnD8RwplNdC5NngNhPNxUeRILhMmX3l1aYYB5G5l3nAjqCV/TmKYA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=k6TOJ7gL
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

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The dsmpd flag determines when a rk3036_pll fracpll should enable or
> bypass use of fractal mode.
> 
> Change to always write the value of the dsmpd flag to reg to allow
> fractal re-configuration and closer match how Linux behaves.
> 

nitpick: fractional, not fractal :) (don't resend for this)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
