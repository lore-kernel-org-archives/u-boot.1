Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33AECD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28825881CD;
	Wed,  3 Apr 2024 03:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Tr0ND6Y1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1A76881CD; Wed,  3 Apr 2024 03:22:17 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn20824.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::824])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D1E8811A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMhf0ULjyk31NY/5x8G0nhSBHvHmFnsWtPXG2ymqLEbiG5zn3gmTnHngaALplK1bgiPkClLrhLiDn4sAVC3VR9Z1yC3Bb+E/N7zgc13Q4pevptCRHOalvUDIHanVm2VvcMknut9+p9GvJzvUA3KvIX3PAGtKIpk27T2hFoyJmwHgfDNkjZ576gXzAMlAcaeqLqqK8hcDFClCfjrYpi1JD0+JXBzXoVY9GQOb5oifv/XS8LtKJ255JjKd6mzw8D3bQl6M9+7fdHLC5nMSFgc7Z39qG1b25e1TxHPu5uoYU6wzPDOZ2uVdFAd7+3iyUd+Rk0dQk89lh4x0QJ7skMb7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPkhl5C649n1966KQXjwVRRqPRe1kfJEvQLKqB94plM=;
 b=OQ30Fi1i9+v4WeSqj3YsbMFd7Q7307uNUoHb+1v5fCarxUTjV/epHvasezfhCujkVIC/YuA6EafUeOcKALJ6naJOjDFz5K/8hCPoILLOEFM9UGxVvBIHlibkrD6v5cfF6tRdEKhB8tKe4fOEZ0jBh3Ds3eBrry8AN1fDEmHQ/dHXzZ9heNHPJ83n5MpXwfykKWiCLQIgKgRszw079Tq65FDgPa9EO84zzhhLflIMaOPzT+Ji25/ATp1nb81oiNFfI4n7WLyIcPSP6QF4/GgHeDRFouP6QD5rwwZrgviPyvEKLvsmt3tJuSG9ZoICcY5OrN3fh+rvQ1I9C1K9kNMHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPkhl5C649n1966KQXjwVRRqPRe1kfJEvQLKqB94plM=;
 b=Tr0ND6Y1lt9fKHXVr/DxTC5g1L1qKyw1BUMdqA/mcgoQAYXf493cJOKA5Fix5KeB9/OSK/g0k82scM/3xDPsMjPMou5zEucxr1uixsUMfhiGafGRrnQ+S2iCA4lk//mdboUpwHJcFPkVG/yyBob08h0Y0HYEBG8UQd8/p5Ji28TVIPqds8moUXPBsD/KWSCIVXR34ka25lqphlUTxlncw6SMlitnzv4sjI9wLlB5QCVjk+ylvhK3sAUQTbvnOFE5vSf+UJOSPiWBqncoq8Lhn4VI/doA2XNVFYl4KWZLNo9m3lmoP7/RQCcRntWxWDaFbrbq8mzASGQWIif/Q3nFTA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB6969.apcprd06.prod.outlook.com (2603:1096:405:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 01:22:12 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 01:22:11 +0000
Message-ID: <SEZPR06MB6959CC3A9319816B2DFA8AA7963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 3 Apr 2024 09:22:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: hi6220_dw_mmc: add fifoth_val to private data
 and set it in .probe
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-3-9f09dc1335fd@outlook.com>
 <CGME20240403004345epcas1p3f668ec6887b8e74350e9840682a875c5@epcas1p3.samsung.com>
 <56685eac-34ff-4ad9-9128-1ba83a9a48c6@samsung.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <56685eac-34ff-4ad9-9128-1ba83a9a48c6@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [bHKQoCwE2xrm/jxgOv4FG66p7jZExZ7gsKo53xtqU4n76dlSE75NMva03lVOFyHs]
X-ClientProxiedBy: SG2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:54::22) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <0effe701-b5f0-49a5-b4bc-4b8cf8c5ba62@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9b5aa4-79e4-4aa0-98b9-08dc537c7ccf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVCQbFMc0VQQP0oPqarmNmYwKNHq9/si34jXSStvscPByfuXDDURNL0bFEorF4xy/uG6zgVGkc4AoJpZEJ+ZDK0JQUixZGTg1m1cPxGTlwqqGecEa1GgKntsuJDW2PmRM0+6BbAWwkooIMDmiOfTVSxxSc3qhHHxUoJIYQ73znj7cozOrHjO6ZZZ6xSbNtET20NiCZLL18VWFSVN/SpMrB2hY2JIx/h3GL9ZiOIL3zQ1s9O0pEpkb5cKuzh5mFBSjyU3et5INx2s3dYADtoFLWfCQCFaFq9Tb2Rv5gJHUmZX/pGKD2LAHQXlNxyoNQlOI5I2jPt/u6npbZPqP4q5RT6P+2b9YS2X2dikHdYicM7UWXttE1nkUSk1awLEdO2+oe1LuP1RfEF1OcmmxHxoSW4hRM8s4TdAbsqkkmKIy+6jjeCiiup4OeNswJA7/SKR/uWxGh/KiAUhqOukqXYbtNTOZJDi14krJcF1+SszHvb8VSD/OHavOQDhI8Io7FQ38d7yaReAtUWUTLQ8u8Lyvp8k02XB7eMIbgZFE2EMZY0sapGcrAT5fHA69dNRY4t0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmR1Z01SQTJiaXo4YUtYcEczR1JKTUpDVTlUak5nWFZFQ3BKdzNqeEFnUHlD?=
 =?utf-8?B?RjhCbWJCYWpWdU5lN2wwZW42MkZBam5FRStiMGhIZnJuOHFaRk93SzhGU0Rj?=
 =?utf-8?B?QjdoMVEzRFhuN0Vwdzhvb0V0WGhsQkNNMDBhcjlXNHl6dVlSVVc2YVhTYUVG?=
 =?utf-8?B?MndKMGloUDYrVHFCS2YwV1RobSs5THk4bHJNYUw1aG9GUTVQdU9DTytFVm5k?=
 =?utf-8?B?emoxZDVHNGJGRjRHNHFwK2xzVVFybXR4Y3BDM1dSZnZLU3R4MWpxdGhZaEdZ?=
 =?utf-8?B?QzRHYzAwazlYd3RZSW1KSjVqUEpUcTZrbjJvaFZrOGNFL3hxVVpwVFpPRFpU?=
 =?utf-8?B?dEk2MkNEdm1xL3pWVDNjRm5pQStFd3lqVFlMbTUweDJzd0E4YmV4UXhDaTV4?=
 =?utf-8?B?bkFocll1OEUwWlZrV3dBOFVPRTk5VmRiNitYK05oaGRwWHE0aEV1aFFGYmpV?=
 =?utf-8?B?bEFGbGlobWJGTklTRXcybTNqUlpQc1Yyc0Y3ZDloY2czdXdBYVM4YlZzMkxw?=
 =?utf-8?B?MU44QUV0MVNsQU03bjJaWXk1R3EvQWpqK1Q1TDVhSkJDcUxMNGJqTHMrU2Ro?=
 =?utf-8?B?a0VHb1lTdUZ4STdOQkdKMVlZdDZMNUI0cFZiL0RIbVpWMyt4OXR5Y0JCTFdr?=
 =?utf-8?B?M1FXOFhwbE5BSTlsaW5QdnJhb3UyMkNYaVBzYnNWRUJxSTdmNTBKNkZyRVJv?=
 =?utf-8?B?VXIzaE43NW40L0J4R2VJYXl3RktDVE5wSHU0dm9Pa3Y3TS8zRkpxVVp1QklO?=
 =?utf-8?B?S3BkdjNjbGo2aXV2ZElHcGZPMTF1N2d5Ti9tRHRiMllLNjg2UDRvQ3Z1Vkt2?=
 =?utf-8?B?VHFVSmw5QkN4YVRWM0svbVF2b3VPS3VjZ3BucUwyK2xmcFk1ZkdSUXFmNEFq?=
 =?utf-8?B?S2p0QzU0ZWtWMjdkNlFPc2FLQmpySDdONEJvcXNCUFg3SlVDTUtjbVFUVEYx?=
 =?utf-8?B?TnMyR3BOR1llWE1wc3F1cVdHeVN3djB1S08wZGpyS3pzRFZnRUh2WnRVY2do?=
 =?utf-8?B?ZG1HeTRVZzdWR1JMMWtFN0szbHBsakhxZjl5SEJpb3ZneFhwNDU0NWs2bFp4?=
 =?utf-8?B?eURwbVIya0lKbnd3ZysxOEZsdlJTbHA5L1JmL0tUNjFoZFBnVFh2VXhYdWpI?=
 =?utf-8?B?NGpKVFFXdTZRYnZ3MXZvTkhmRlRMNlFRZTIwSk1oaUxkZ1pRWjQxZlBPbVc1?=
 =?utf-8?B?NnRGRnpnMUR4U09Gd3I3aDZYMzNoSGl4YnUwK1hhRklvMEdmSGVMN2lsNmRw?=
 =?utf-8?B?VWE4Z3lISTNsRWtscG1wNUtqOFBPZW5nbHpLOFE2dmlpcG90RmdlZngvc1Zz?=
 =?utf-8?B?Z1hTbGJFTk5TVERlalJ2RW1oOHhPYUxrTnZBQzFOblZZamdNM05QQzF3UmFj?=
 =?utf-8?B?MUZFUjBqalNzeXhvcGNIYzZaUG94d0hiQ2tRZzJic09pSk5mZ3N3UTgxYkFy?=
 =?utf-8?B?Q1M1RUdLUEMveXVZcjYrQjgzdVU3bXY3NCtqQm5kMVUvMU81ZmJyUU02TENt?=
 =?utf-8?B?bTErdThmaDNTTEU1TmtPdWZGNVdRS2JKUjhtdVI4dEFRanRmRFh3SmRmQnNp?=
 =?utf-8?B?N0JVOUdFbUZrTGFCY2U3QU9LbTA2aXRTeVN3L3FGZG9BUEpZc2ZiRUlIa21B?=
 =?utf-8?B?RGtMeldEUFkxQ2k4S0dwZ3Ara21xTlh3U0UzTGtDYjl3cVBhQVlmTkxGUWln?=
 =?utf-8?B?WmVoMmRndzMzaTFXV0I2T0t6K0JUanJCcHpFZGRXb3hFZnptMHNZRWNwN0k2?=
 =?utf-8?Q?MhtecFVnsBuoGMu/8uPw+cITpnPo5pDaDgdr7JT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9b5aa4-79e4-4aa0-98b9-08dc537c7ccf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 01:22:11.7056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6969
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

On 4/3/2024 8:43 AM, Jaehoon Chung wrote:
> Hi
>
> On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The value defaults to 0 and is ignored by dw_mmc code, so the other
>> users are not affected.
>>
>> Setting this explicitly fixes some weird reading error found on Hi3798MV200.
>>
>> Fixes: 8a5dc8140e62 ("mmc: hi6220_dw_mmc: add compatible for HC2910 support")
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/mmc/hi6220_dw_mmc.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
>> index a4b8072976..dc0210402b 100644
>> --- a/drivers/mmc/hi6220_dw_mmc.c
>> +++ b/drivers/mmc/hi6220_dw_mmc.c
>> @@ -37,6 +37,7 @@ struct hi6220_dwmmc_priv_data {
>>   struct hisi_mmc_data {
>>   	unsigned int clock;
>>   	bool use_fifo;
>> +	u32 fifoth_val;
>>   };
>>   
>>   static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
>> @@ -125,6 +126,7 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
>>   	host->mmc = &plat->mmc;
>>   
>>   	host->fifo_mode = mmc_data->use_fifo;
>> +	host->fifoth_val = mmc_data->fifoth_val;
>>   	host->mmc->priv = &priv->host;
>>   	upriv->mmc = host->mmc;
>>   	host->mmc->dev = dev;
>> @@ -154,13 +156,20 @@ static const struct hisi_mmc_data hi6220_mmc_data = {
>>   	.use_fifo = false,
>>   };
>>   
>> +static const struct hisi_mmc_data hi3798mv2x_mmc_data = {
>> +	.clock = 50000000,
>> +	.use_fifo = false,
>> +	// FIFO depth is 256
> Removed unnecessary comment.


Will do. It seems that this should also apply to hi3798cv200-dw-mshc. 
tests are needed from cv200 users.


>
> Best Regards,
> Jaehoon Chung
>
>> +	.fifoth_val = MSIZE(4) | RX_WMARK(0x7f) | TX_WMARK(0x80),
>> +};
>> +
>>   static const struct udevice_id hi6220_dwmmc_ids[] = {
>>   	{ .compatible = "hisilicon,hi6220-dw-mshc",
>>   	  .data = (ulong)&hi6220_mmc_data },
>>   	{ .compatible = "hisilicon,hi3798cv200-dw-mshc",
>>   	  .data = (ulong)&hi6220_mmc_data },
>>   	{ .compatible = "hisilicon,hi3798mv200-dw-mshc",
>> -	  .data = (ulong)&hi6220_mmc_data },
>> +	  .data = (ulong)&hi3798mv2x_mmc_data },
>>   	{ .compatible = "hisilicon,hi3660-dw-mshc",
>>   	  .data = (ulong)&hi3660_mmc_data },
>>   	{ }


-- 
Regards,
Yang Xiwen

