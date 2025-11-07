Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609DFCCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACA083DCA;
	Fri,  7 Nov 2025 17:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CgM5KEjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C14C83D2E; Fri,  7 Nov 2025 17:24:59 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C464C83D2E
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 17:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exwY7k+zzc1WrPlglVUWAYCxFVK4lBOkuq3tVwhWieSetKZMWpyFjMt3gCbJxs8FtxmBAbQX61RjQNeG4cq1EZLKTTH0m53fZ5YBN/qzn+7BCCQK1fVhtI+ikBIpqrqW9dNpUHUn3LsLjj116oAIGSCzbGKpboOyXbOqYAhOmgxpJY5rvMvd11A3Zac7k+d/lq6uhe9OjWRqgiCQgtJwrtGgC3GiRt/M4/IY/uebh5YDVKpnldlJa4ByYvbIoJeBDk1vrUQ/nmjtk/4DInxZa5lWtOIv0/VkVG0pxxgHrkxmFGaLqQ9EtLW/Kk6mYBL+JLWkDnH3sUKlwOTcoucbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+YJnGaa9CXxGm5CqaRO/HZ/aOf6WxWs93c+j/zZ/gs=;
 b=czszZOHv01pWznoZiUNFGxbf7NsTNDiE/xIyuhP8pYbwiOC6RbAElBRTuXN0OJX/oACIejC6E69BQj36oIUxuy1yi+UkMNhaFgqv9EJ414XsdlwVecxmkzYO6imaCmC1NeN1mFMoc7eD8OoY0irFdHqMPQruUKVrRivfeWYWmkmGOaX8GIHXAXOxzjloVzzWGR77lGPlkMjB97hmgmo5SUEQ936aZy1ENCtBQiQmuuzkrYptQF3INq8/7tIlOm7Ad24D2na73S24oAtopTV6Zv0soTfpAGIzhwCRW2j+8lOQUeQ+6XMhfkR2+LS/b3/uYy6fQQ/RBdT+EZ94wljOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+YJnGaa9CXxGm5CqaRO/HZ/aOf6WxWs93c+j/zZ/gs=;
 b=CgM5KEjmm/e/C1gK96uOhYZec/aNUxKG2e0M6iqTnWkCa9wFHPZxo5KqfUNVW7nEmqPvnm09KM1+250jBKIpI9056aDzQuabYbA5WEF7yGFSRVxvtH88vyB5HRFXLmluwHD0M6qCY+bj8W9mvJO19alE3QqHlVW23rOx7sFVWLE=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 16:24:52 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::99) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Fri, 7
 Nov 2025 16:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 16:24:51 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 10:24:46 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 10:24:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 10:24:46 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A7GOj503271672;
 Fri, 7 Nov 2025 10:24:45 -0600
Message-ID: <ca97c8a6-e5bf-4ae4-aede-133c38510321@ti.com>
Date: Fri, 7 Nov 2025 10:24:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] remoteproc: k3-r5: cast size to size_t
To: Philippe Schenker <dev@pschenker.ch>, <u-boot@lists.denx.de>
CC: <stefan@embear.ch>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Beleswar Padhi" <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>, Hari
 Nagalla <hnagalla@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20251107130216.3084134-1-dev@pschenker.ch>
 <20251107130216.3084134-3-dev@pschenker.ch>
 <57ada562-c774-4ef2-8739-b899e5df416e@ti.com>
 <f429996a374f31d2d9dcdbcb8f143de18b512549.camel@pschenker.ch>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <f429996a374f31d2d9dcdbcb8f143de18b512549.camel@pschenker.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fafad0-8627-4857-05e0-08de1e1a2d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T00vMk5mb3lxUG53UXAyWW5wRFJiZ3hWQWVFWGNGbjdZZklKcGhEQWxIVU9o?=
 =?utf-8?B?dzczRDVudWxaZ1R3c3RTOEhFWGQ3SXZYYWJpckgvaHRFMGlRUWNyQTNvcWcr?=
 =?utf-8?B?akNYRjdoRkg3MzdQampDTVFUTXh6N25qSDhnOWdxSzBvQUZCRjk1bUZDR1ZX?=
 =?utf-8?B?QnNIcVl5SkREay9qRnp6T203OFAwZFdXR2t6SDlBNjZlVUNUR095Nzhib3B6?=
 =?utf-8?B?WENNOUhpVGNtZDJYNWRqUURrOXg2MXZrMGVFWmpObXdpYWpSc3I3TzhiaFh1?=
 =?utf-8?B?TGE4aXFBeE1MdkdjU1VvLzlWUVhmUTljVk9BQ2xER0lldXlsandPT3Ryd1Ez?=
 =?utf-8?B?M2ZrZzFoZTEwSllkUWdpNWg5OWV6S3NXT1VpZXprSjB0VFJneksrMmYyOE1X?=
 =?utf-8?B?c1BkY2N6L0Y4WWIxeDlwVWR1RmYwTDdUaHk4WUFXY05TM0M5YW9FMDJCMWM2?=
 =?utf-8?B?bldRcVFjRVIwaE1DN21nY25heHR6YVVkMUh2S2FWMkQrd2RPOGlNMlBsUExu?=
 =?utf-8?B?NTNwczJFRWJzdHl4MTZzekd4RURvR3RXMi9GTG15Q20xcTg5Q1FISDAvV0tX?=
 =?utf-8?B?KzhzZ0NNZE1jaXNVZmV1VVRyWUZhZjNjTkZlYUx0VS9iTzZjRjZEeWx2alQw?=
 =?utf-8?B?TDlwM3pZQW1sR05Cd1N1QU1JdnNpdm5yc1BmUUNvL0J2OE92UzgwSVN6dkky?=
 =?utf-8?B?SjJIc3BramErckVCRk1CTmorcjJwRkRmRllJb2c0YjNPTmtPTkFUTlZDUVRq?=
 =?utf-8?B?eERGRU1GQXlaNktWRGd1eWNDSTl4NjlJSEFORm9oaWU2dTJidDBMNkU2ZW5N?=
 =?utf-8?B?T1lDMXVvK1NYU2ZPUXE2MlB3bHI0YkYwWHRmTFI3T2puNE13NkR4YVFubHYy?=
 =?utf-8?B?TXQ0Rjg0Y2FvdzMwRGU5em1KYTFTOUhWWi9kdmM1TVhSaWpDYURtTFJCSWF6?=
 =?utf-8?B?NTJ2NU9hbko3U2Q3V2NZSHRybDhGOU5YWlVob3B3NXU3anVYN0lMUWJjazBM?=
 =?utf-8?B?b0NKaCtPZ29yb2Z5UHBYTHhxL2tiR0Z6VXN1UHdhdW15MGlqdEQzTkJxNkhB?=
 =?utf-8?B?TzRHMmNsQnlxc2I4Y01aNllXaytrSGMxeHhCaGhoRWlKbEcxN0JOZWFEZ1Bk?=
 =?utf-8?B?cXJEbzhLbVFERUtCZitCOUFFdU4vZmMyNWUvS1ZpSXROVVVTQ1FnekdvbUpV?=
 =?utf-8?B?TDdZVGZ6NGl5ZUhJYmMvd3FPUzl1S2pUV2xYMUJMeC9WdmdHU2YyaFRhd2Nk?=
 =?utf-8?B?bGpBSWhCb3pMMGhET2ZTR3BLMm5OK1dQYTdhY2ZjZTZBaHp1NSthSjhJWGZp?=
 =?utf-8?B?ODVPM3FyeGEzWVhyM25EcDF3Ykc5czZuUEFRbEQ5dTJ5Rnd4YytnTXV3Q21s?=
 =?utf-8?B?bjVtbUIvcVZXelNmQ3BQendudlFvQ00wdm9Od2FzQ0dqTnJsOUpqaDFJdE9K?=
 =?utf-8?B?cDV4S3lmbVB4dDZuOUd2ZFpUNmowY1h1MEtpV25ZS3BjTHBITlhwWlZYUDM3?=
 =?utf-8?B?VXBzdFZzMlRlT3g3U1lhSFhGT0xCREw3QzhxUlBrVGFVcUR4VGthdzJMWmtJ?=
 =?utf-8?B?WFFVbURGM0FXeE12OHR2Ujd5Wm1YZjQ1MERGNmE1bnZDL3NxL0Q1NkJ0ZDBL?=
 =?utf-8?B?ZlE3TUs4VXA1R2dxenNqZENOMlJHVGdvRXNvWnZZNGNvaEZPSDhGeFIwcnFX?=
 =?utf-8?B?bm8rTzRjMm45UjQ0VlYxRGdoR3VTVzh0cU4yVnNnUld5YW1HeVhMMHJUWU83?=
 =?utf-8?B?TWIxU0RJeURSeTVuZk52WmJNZlJqdFBiSFNaTlU3b3JMV28ydFJCL252SjZp?=
 =?utf-8?B?N0VvQ2FuSDdWekc0aFFyL1YrWUJIK1ZRZ2tJNnR3aG1pZDNKb0t4K09VYkZi?=
 =?utf-8?B?b3FaR0t0YS9DdndkaXFJTS80NURZcGc4ZGJJNzRib2lveUkyQlY4TW11aDRM?=
 =?utf-8?B?L2MxM2tHSGF3TG9JclRDTFhDR3VWRHc3YzI4N2o1dlA2Sk9xV2JBV21TcWZj?=
 =?utf-8?B?TlU4VmNxOXc4V25FdFZWeXhncWtua2hmU2lRQzJqaEk1UTM3d2U1RTNQRlZm?=
 =?utf-8?B?TEpQc2JFWnJQbWxkWVI4b2p0U2EzRlRPeDV5b1h2T20zSDRKNmQrV2tQSGpB?=
 =?utf-8?Q?iAxw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:24:51.4230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fafad0-8627-4857-05e0-08de1e1a2d8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
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

On 11/7/25 10:00 AM, Philippe Schenker wrote:
> 
> 
> On Fri, 2025-11-07 at 09:24 -0600, Andrew Davis wrote:
>> On 11/7/25 7:01 AM, Philippe Schenker wrote:
>>> From: Philippe Schenker <philippe.schenker@impulsing.ch>
>>>
>>> When compiling for R5 core with CONFIG_REMOTEPROC_TI_K3_R5F,
>>> passing 'size' (ulong) to ti_secure_image_post_process() caused
>>> a type mismatch compiler error.
>>>
>>> Cast 'size' to (size_t *) to fix it.
>>
>> If the size of `size_t` and `ulong` are not the same this doesn't
>> really fix the issue, just silence the compiler warning. If ulong
>> is smaller than size_t on some platform we will read data outside
>> the variable address when de-referencing.
>>
>> Might be more correct to assign size to a variable of the correct
>> size first, then pass a pointer to that.
>>
>> Andrew
> 
> Hi Andrew, Thanks for your comment. If I understand it correctly and
> explained in different words: If size_t is larger than ulong unknown
> memory could be accessed.

Correct. And if size_t is smaller then on big-endian systems you
will read the wrong data.

> Isn't it very unlikely that this ever
> happens?
> 

Also correct, I don't think either scenario is likely, it is
just about formal correctness. And I also didn't think any system
would have ulong and size_t be different sizes, but guess you
found a case (not sure why on R5 they are both not 32bits but
if the compiler is complaining then I guess they aren't).

> At least I did interpret your first comment that way.
> 
> Anyway I will send a v3 to really catch all cases.
> 

Thanks :)

Andrew

>>
>>>
>>> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
>>> Acked-by: Andrew Davis <afd@ti.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Added Andrew's Acked-by
>>>
>>>    drivers/remoteproc/ti_k3_r5f_rproc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> b/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> index c738607c1092..e7bd97a9088b 100644
>>> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> @@ -341,7 +341,7 @@ static int k3_r5f_load(struct udevice *dev,
>>> ulong addr, ulong size)
>>>    
>>>     k3_r5f_init_tcm_memories(core, mem_auto_init);
>>>    
>>> - ti_secure_image_post_process(&image_addr, &size);
>>> + ti_secure_image_post_process(&image_addr, (size_t *)&size);
>>>    
>>>     ret = rproc_elf_load_image(dev, addr, size);
>>>     if (ret < 0) {

