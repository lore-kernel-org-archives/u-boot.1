Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40160FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97896848DE;
	Tue,  5 May 2026 14:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="J9m/AZeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F19C8848FD; Tue,  5 May 2026 14:39:33 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01639848CE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld+T9BPPIgs9HHqgbeDzwweMzD2EAVSxxbk+0FIX0HDz6fvnS8MpZC0HHs8SxOx9GAAE7P+3OSsCwVv4KiBQRfGabUgZHY4kB4VbzMDP8gYrs+xEXedJU7Wc5FEhEz+REja0aTBKJc7yDM6z8xHUt+0iG8WewbjIOhLPBzh12tCnKWFaWV3gHrJ1vQcmPzEiXufjBO4C9+znD8QnjiGZdExf3691lTsd+f27KkpfySg0Se1bdYRVKPXG3IZRl/a0DhsHEuvOin1wqYuHEngY/8G3wtYJW2zAhih9FiBvwI5Di+EbHRiYtsCCiUXLG2xrQKOA+la79wAw658mmpNQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcttUpGMGGAA7vrxXPiSn90BdwzEV7maHYmlDsJExac=;
 b=uQRVG3C0McSuCfkotssBLpzLe7xgDN4KO+Zk//GZtgR31Ossru6VfY2EeSp2C+bdzo/hBzOA5cZqCSkj3+RH+wo0/e7fmyNtQ4e8Jg9nV0hFvuG0BMxw6pxQKgZi3mYzT7PZMCWe2n6KxWEhcAGge+7eUNoc3vWSCQxVOXg8C5EmErm4e1MqOtrhsbkxUIbmSemknVuvGeZ3/gjbAZK6uUJySC8PF/rl5VppaQ3xClZU771D8EtDhUQm3qkGkp3gDri4cijg96SV5GnaI83antDXMOE/rwq4dlbv5rIG5EPxQ7w46znGPH49LMvhu5rrtOhu4EJE7/BKkcCmie1KlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcttUpGMGGAA7vrxXPiSn90BdwzEV7maHYmlDsJExac=;
 b=J9m/AZegfzq2em2o4tWqGxyMZU4shrRAcDxucpA29d/w/YeCp3tPqkOf54rgJ7DAGIzIa6OGFNrVnAuQyNDBQlPJxGC5bAkseSPq2tUa/qNQuNNAcJ+S/wj2k+w0zWrHf5ffgEiGsh2ZjJmZGVCuL1pUWDdJWibmzCQl1Lgyhhb0sZESJGAJTTad5sQLYWN5de72LzvTG6jZPmSpyMbyMAv/ehKKZsAjTv/HV/VgzNfJh+xN4webOOv91q+YYTRivbqgiYLfvu8kBGmAodUQt+F37NgNUuTkUO0L7hQ2hbVqoGlt9Ku/xBzOVecEPdz2xkIHETVFx9nkVaqwt5DxAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by GV2PR10MB6408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:39:28 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:39:28 +0000
Message-ID: <1e673395-f30b-4e14-b9e4-3bccb8f60d3c@siemens.com>
Date: Tue, 5 May 2026 14:35:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] qemu: overlay signature nodes
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
 <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|GV2PR10MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: e9eb94f8-3a75-4b91-27ff-08deaaa35926
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VG/Z8a6VIZovzCcx9DKnEQbgpsIixefNllP/P+c1xLlUCdQUZD8aizL/3SRJnDauQBEoOHCo9XuemXQzcen7Rrhta9IAAoMbDM2DfvUOHXupGK3eN5Juw/7JiTdhrdNKrKTNofWxICwcXAUCcuT3QuKyEcWWvAoys6h4szqtIIHVLGanxFrpyuF/BKqQ5t1kZ0IXB83O4Rg/AhkAtvaItc3ByNLukaeyBE2GQDOBhQs2DzHrRYFQJzqpQmsNkoStU6Od3p8n7Cqgx83HRDN33an+HAdvtZoNw7bSYAKGtQSCfVG74AMuW9hOIG/uirTAniMpBvp3csI69mgJyaU2tGupNA+ppQaZ58ofQdrMSQor9dx4Ij2VItf5yITEV78v0gAzaMzNuZLAFgcWwugBI8N15NPZ9+t3gaiA4Uznw7Y1+fXeFkfURlGFr9hvffTezI/uHdx55uoqWuHzE98usafAxIUjQumXQC4oC9mnoPLcnpehYegPk0kpMViAnHpiazt3PMnjxhtH9cGKQjJI+ROGZqwiI1KdrBZYIGxjAu4F4CUPAsSKobZtBntqe0sHfZR5jgRO85hh1DBRFkMKm2aYjbjId/dWzkiiTD49YpSteHPrT97m2Wcn9H4+CIOjYXn3QVKYuvA26jNTdle1CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9yRG1YY3RWZlR0dTVCTk5KdnlMZWpGSEFBNlZPY1AzdjB0Y1UvUmUrWHhC?=
 =?utf-8?B?d0ZYV25EbnJVeldPeEx4ZE94M3JSRjg2dEFBZ1lieEZka1lRNG5qenRCQncw?=
 =?utf-8?B?V083QzUxNDhCUy9KUi9LSGdURi94YktndUZ2MU12QmdGUzhpZHJ5c3ZDMy9O?=
 =?utf-8?B?NXVNSmNJcjkzWHhERUkvaklsbnUwSVBXZzcvTGZGZlFrN0JEWDJWcGx5aVR4?=
 =?utf-8?B?UWNmQ1lJWmYrMm1LL0Evc1RsT2daZzNVaWRRenlGZmZIME5oWGh4VGFrc09w?=
 =?utf-8?B?WHRmSy8yZzRpWGxMSkh6ZWEzMEU3Ry9vb3Z4U0lUaXo1VlFReCtLcXhUR0pG?=
 =?utf-8?B?cTZmbkYzQyttQUZtS1BvQVhpR3k2ajhGVXMydVprU3IvMCt4WDNXb3VWdmdw?=
 =?utf-8?B?ODN6KzRwcnpIK2ZTNXh5QWxlVjhOM3I0bDlCN0t6VGpiOG1wSzlHcmFNbGJO?=
 =?utf-8?B?bHRtdDk5VjM4QWpvdlNvY0JUQmFWaDdndVNOaVRRRUtocVcyNTUwdWlDam5X?=
 =?utf-8?B?ZjBtMjdsV0RSd01adU92RlRUMCsva3ZmM2JGcVN5bGMxWGNPZEsvV1g3bVVV?=
 =?utf-8?B?eVpPY2JtdGl6VGJSWUM3RWJrZ0tSZGNaVXh3WGMyL0s5NEFHWkJHRDRySm9y?=
 =?utf-8?B?TFM3ZnV4U3FRLzhPMXNPMFBCanorYlRrenI2eUtpQkkzZExveEQvVHozdGwy?=
 =?utf-8?B?RU9yTUlJYWU2WDZzVEowNUhyTlZkT2NkZEgxei8zMmVTWWZra2pyd1pWM0lI?=
 =?utf-8?B?Mmh3ZG5MZFI3eTJJemFMTlRyRnhEdmhOWHlMdm83R3h3c0dkYzVCcnlJSGJq?=
 =?utf-8?B?UzY4UHlTQkJ6aDV0UnU1N0EvYlJMWld1cTlLb043U0JBZi95K1VTanZ1c0Vi?=
 =?utf-8?B?STl6UjlnenFmRXk0SXJxekZVU2FDV2ZjZzAvUFIxNFp1YUtOd3ZISFhNSFQw?=
 =?utf-8?B?K1dVaVc3WTZBM3RaUEdnWjZFUWVST2IyeDMyZWdEc3JiUVNVUGkrRUxLZHl4?=
 =?utf-8?B?NnNkZkRHbExjVUo3RFAvYnJuY2UwQWxKNWJtQW00V29UVzB5VFp5M0laREE3?=
 =?utf-8?B?TmVIZUdQWHBuV29GMDhtaTdlaXNlMElTaHJ6ejV4SFBqcE82cWx3Z3FYMVdU?=
 =?utf-8?B?Y3pteXFpemtxSEJhYjBDOFZ0TlA4ZmI3eHBGU3kzWWdvWDZESi9yS1ZPZGVW?=
 =?utf-8?B?eldmanRxVnNLdEJCSTBSMnNwUWVMYjdKb25KRVV5NGlLRGZvNFN0b2NTS0pT?=
 =?utf-8?B?VzBUTmdNRzc4Wk5nZWdWMmZRYzI1YWdoUzJVanVJOElaWjNGQ1BvZ2ZGZkVH?=
 =?utf-8?B?cGVYdHUxQmtVYXUvY05mWDlTQXYwMmoycjVFNWszcWZpMDh6dFdOaXo5Yk1P?=
 =?utf-8?B?SnR4d1hLL1dsVGQ2bkpnODVycVNNdHRXSkJpNUhSOHhDamtaVDY3dnFUWWlD?=
 =?utf-8?B?WkdGQVhrNWZMY0ZWeTNPSmlrd3pQN2pUaEk1VGlvM29XOXpNOEduYm01S3lp?=
 =?utf-8?B?Y0pOeHJMd1RxTHVGM0l5aWdub3NRd3FFaFlxa1lFUHdCQmF4MjhlUThxZU1U?=
 =?utf-8?B?Si80VmRtcmp2RzJwT2YzNHFKYjVuT2dpZmRWME9HVHBOd1NiclkyMmx1UWMy?=
 =?utf-8?B?T2ZlaHp5T2t6Q3FaQXU1MXdBM2FUWURXUVRMWnVRUDdNUmxwd01kbFJPZHNU?=
 =?utf-8?B?QjdIaXlzK05ucUcwRFFDcW1DYmtseU9xV3ExUDlYWEV5eGNSRzl5cERJOVpz?=
 =?utf-8?B?NVZVTWJOQ00zNlFpa0lxMWhNcXFuQnRWaDUvblJ3N25TWHgyWEFsTCtvMTM4?=
 =?utf-8?B?WEZ3VEkyTnp1MVRNK0E5R0tYSVErODdaeVN5eE1RYWoxU0JBbHdqWDQzRXVU?=
 =?utf-8?B?ZWZUZWRhT3l5VWlrNGRmTzBuRlRkNkJnbmtOZ1pvcnFURW8xR3I0Y0hCNXZl?=
 =?utf-8?B?WWJjeExlNDgrRThBemE5clVNeHV4cUhjMEZSVlJvSWtOY091VzNDd3h2VnpU?=
 =?utf-8?B?OTdjaSs0YWFHZGJIOGEvZmFrU3d3U0pOajQ5eW1uYnY0WWgzYXVGNEM1Mjdh?=
 =?utf-8?B?MllLd2F1RUhtdzljZHlTSEc4NlRjQzN4U2QwcUNYdWhEUkhlUisxaFAydTY0?=
 =?utf-8?B?UzBLMGRlL3JNU3h0cDNId0h0eURLRnVsOXpuSlkwVlAyV2l6TUZXc05HeDMw?=
 =?utf-8?B?WWd5MExWTjRLSCszUVp2eGd3NllZbExaTnpBSlBTbVIzYTVBOEFlcE8wU0NY?=
 =?utf-8?B?M05KeDY3MldaNjFqcnFjVFBOU2FtNHg3eDkydlZVa3dEWWl6QTJkRTRaVWJ2?=
 =?utf-8?B?bXpDOEdHd0NwbUY3ajh3bDVJeFoySnpVc1FUYTNEZ3NYSEhpUW9kdFRJT3dK?=
 =?utf-8?Q?9VmjDmCoHRqmCb+o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eb94f8-3a75-4b91-27ff-08deaaa35926
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:39:28.7186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsGgKTscA0HjYHRIlIuooN8l14WruOAaWDRQ+/g9bM9A1ymQZs/YuJkFBUHX3+4aZ1n3L28+jrrBiZ7Y+SayJkjC6lAgK5tCiL6kZM8l9+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6408
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

On 5/4/26 14:26, Simon Glass wrote:
> On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>> qemu: overlay signature nodes
>>
>> The keys trusted for FIT signature verification are supposed to be
>> embedded in the device tree built into u-boot. When running in Qemu it's
>> convenient to use the device tree provided by the VM which doesn't know
>> about signatures though. So merge the signature nodes at run time.
>>
>> Needs
>>    CONFIG_OF_OMIT_DTB=n
>>    CONFIG_OF_LIBFDT_OVERLAY=y
>>
>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>>
>> board/emulation/qemu-arm/qemu-arm.c | 33 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
>> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
>>   int board_fdt_blob_setup(void **fdtp)
>>   {
>>        /* QEMU loads a generated DTB for us at the start of RAM. */
>> -     *fdtp = (void *)CFG_SYS_SDRAM_BASE;
>> +     void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
>> +     int ret;
>> +
>> +     if (!*fdtp)
>> +             goto out;
> 
> This runs the opposite direction to qemu-sbsa, which uses the U-Boot
> DT as the base and overlays the QEMU DT onto it (see
> fdtdec_board_setup() in board/emulation/qemu-sbsa/qemu-sbsa.c). Done
> this way, any node in U-Boot's built-in DT that shares a name with a
> QEMU node (/cpus, /memory, /chosen, ...) will have its properties
> merged into QEMU's, potentially clobbering the hardware description.
> If this is correct, please explain in the commit message why the merge
> runs in this direction.

Unfortunately I didn't take notes why I went with this direction in the 
end. I remember trying both. Might have been issues with relocation. Too 
many lose ends :-) Have to check again.

qemu-sbsa also does some fixups to the qemu device tree. I wonder 
whether that also makes sense here. If so, the code could maybe just be 
reused.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
