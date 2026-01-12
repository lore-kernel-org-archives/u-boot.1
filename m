Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F062D2503F
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 07:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA0883B85;
	Mon, 12 Jan 2026 08:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Krr+LtgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A279C83BD2; Mon, 12 Jan 2026 08:52:44 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazhn150130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d918::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B528392C
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3HLXKuHfuQrfYLMh24ocVovkA51Yxe2MoLcxNwbC3u1AOsnpC+Zx7+oIWy0UwkSrinYN7SJefgiPrln3mKVF0H30UWpjkpbPWLEa3wqn7PrzpgjbwBjTd1KBDQmh/IKQEmtADi8zaJzViWWiAZg7kY7U2kf73VJz1Ra9d0phf2JkGzgfxz77QRocrDDwZM+wuu5MNkoRJJ/iXg/XhnAlzuZJ0Vwaqj54aKQSIwbQzd87QAHepKtqlq54BQi7BkHHBH5WEJtLGEY+TJ5J1Zyg3mrUQ2t/MAQcwEUWlFDIbxGcdv9w2cCpcZ/4erI5S/MZlj4Bx+eDzip2k5Qi5lakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o30WygoEqz6sbvAK9SrA88D4y9YCMasqupSGN6M2js=;
 b=jgWP+DkCEUwdFzMSNhLbuz0SN+FFwsnuh/dUuWxACnDtLj4rKu/si96moAon0NXQF0MxajEGn4oyAAa2JfipbQkDyWbf1/sztFW8r5kEgxB0mU1DtZ8JLo8lem8+pNNaKSYuA9U55n1+yIdaE1XFwnvMdN57DqhR5YmJLxuj7IKRBPd4xySlbxNXFu/y0BE4jCWkvQS0LI0pPbHY/AaaUh6hpHNaCP0cV8U74563T9ygQrlZ8O96VOCr3+Zp1ahnUmSh8wmRXQOyikZlRFx7rHoluC0Zs0omVze5MmjW+t4xz3kkN+Gcj193h7LSOG7U0nawa/wizQCJEarWl8K5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o30WygoEqz6sbvAK9SrA88D4y9YCMasqupSGN6M2js=;
 b=Krr+LtgQ5TPGaa5Xy7Xj0uJStT7Rj965wMGdnJO6dNI611Ul+et3zGP/xsrCf5pdjsPLCjrCwPIqy1M0h2AwJDDlLOHksQhCor+Ea39ppexbkJmDnlCO/sDeKvqK9Ri6VgEYNTXCA6fxTvcpKfc1VzRfGT8y3nSoIXykn6kSgwM=
Received: from BY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:a03:1a0::29)
 by SJ0PR10MB6351.namprd10.prod.outlook.com (2603:10b6:a03:479::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:52:31 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::bb) by BY5PR16CA0016.outlook.office365.com
 (2603:10b6:a03:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 07:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 07:52:30 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:51:51 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:51:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 01:51:51 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C7pkqX006213;
 Mon, 12 Jan 2026 01:51:47 -0600
Message-ID: <194e0ec6-e105-4f9e-8a1a-5ec9071730e1@ti.com>
Date: Mon, 12 Jan 2026 13:21:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Anshul Dalal <anshuld@ti.com>, <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>, <afd@ti.com>, 
 <nm@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-2-b-padhi@ti.com> <DFMDO1DJJU1J.76LMCBNAY7I8@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <DFMDO1DJJU1J.76LMCBNAY7I8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ0PR10MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f8f20f-0992-4b12-1154-08de51af8988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|82310400026|36860700013|376014|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEdRV09EcGJyUVJwNUR6REt6RWI2YnI1RUJiUHVxV0E2ell0emVDZ0lsS2xh?=
 =?utf-8?B?Z3E5aFZmaG5DVCs5NW5VV3JLTFJnOVNLUStiNmZEYkpoZ2xhL0tvUlhqVXZs?=
 =?utf-8?B?MHBzcjNPZ3gra21zMzlGTG5IUDBLUUtrci9PQ2hKZERqcG9Cc3pmTWRZR21m?=
 =?utf-8?B?ZDFoUzViZlNKZjdMV2ZYR0xrajVMcmN3UzZpOCtNZGpVMk9jS2t1VHh6YlFz?=
 =?utf-8?B?T3VDeFlTOHRQclVzSEFlL2xoMTZWR2RGWlBtbGFodW0razFHT2t1ZFZQVWF4?=
 =?utf-8?B?Q2Y5eTJraWhkaDdmNVdVU2NaMU9tTGJ2NE1kcDBnMFk0bTlROE5XT3YxeVIw?=
 =?utf-8?B?TnoxSENaek5uV3Rzb2NvdThMWDUyZ3FWUy9aS0xoZXFBSTR4cXkrVDNOb1NV?=
 =?utf-8?B?dXd3MjdNR1N2S0x6eGl6aEZORDF6RWc4cDZla2hLU3pPallyakloaEVJN1Zr?=
 =?utf-8?B?U3k0S1BMODUwRlA1L0VQSzBFNTMxa2x3czI3VHBwRHg4MTIray9Ld01keDNa?=
 =?utf-8?B?a2ZOUWtNM2pxK2tmMjh6R3g5NC9Ea3dTWmVoem1SdHJlYk5IVUdNeGRJZ2tF?=
 =?utf-8?B?dVl2bkxCd1JWbDlWMDVaaE9ldzhpQ3BSdXFMaTUrMXhlNE9BQUxTTVAweHh2?=
 =?utf-8?B?YUkvUzVyNG9JN2U3RHhydHB5VkMyNW0xeFNUKzFuMWdZM24xNTJiQ29IUW1B?=
 =?utf-8?B?ZFRNNER4WnBoWVp4K0Z5NTNnOXkvb1dWc3l1THRCVU5jVy83SHlQRDN3K09N?=
 =?utf-8?B?R0YwSjJRdCtjMzlXdDMwbkVpYmFJOWI5b3dDSzJhSGtPLzhacUs5a2hJVHB4?=
 =?utf-8?B?bW1pNmRaRXVtL3dya1Z4dWhKZGZjZXRjQ0NMUlpqWGIvUE5qbnkwZ2JXa0N6?=
 =?utf-8?B?TFJrWnFVcEYvRmtzbE55dXdKbmhtN0U2dkI2SCt3VEh6aUo0eWZRTWsxb1J1?=
 =?utf-8?B?WjNRWk1GR09WOTFkTXRBL0RVWitBaEZaZDN0NzRvWktBa2tXRzZtek9KVTls?=
 =?utf-8?B?RXFCRlVTa0hhQitudVQ3NGVGc2QwSXNLUXhJaG9OaTBTTkdncTBPWS9GdGVC?=
 =?utf-8?B?U3BUa0I4Z1hJTi9TMkhBVUV4UGQwR2hOMnd0cFNzWHpMSENROGpoRXVvUVR6?=
 =?utf-8?B?cU9TSXI4amlTSGhYY1JyTnQ1eVl1MEh3MmNwVG1jay9vVzFLWWQ5VTRkNmlB?=
 =?utf-8?B?c3FINzhGOWVmUm41ZXlGby9VRXRFYTB5RnhHSEZ3THBGVEQ5Tnhtc1YvWFFx?=
 =?utf-8?B?dVovK0dSd01BZmowakE3eHpPdUg3bUFpRVhiMDVLWkxRN25zTC9aTmVoSTBQ?=
 =?utf-8?B?ZXlJY0tDUDBkaW9XeUplRkFCU0c1QU1kRUhMWVJWWll0SjV0R053ZXl5bks1?=
 =?utf-8?B?aTRrNXU2Mm11WHlJVmJERmlXZnhtbFRJZ002VWNIQjNsT3FHUjBGTDVyYXpJ?=
 =?utf-8?B?MGo5NFh2YnVsSWpzdENwT0UvbTJMMHQxVW5NaDU5bmRPTjFYWjkvdm43Y3lL?=
 =?utf-8?B?aUkzcGVXSFU0c2tnaCtHZHlIWm9FQmFkVHgyeWZVUEk5NTdOSDV2bG9lS3kv?=
 =?utf-8?B?TytnL0lCLzB6dTJLUE0xQ3kvc21GbTdYUDVrYTQ0SCtGN0RmN3VKRUNqWGFn?=
 =?utf-8?B?RC9pNXFJa3JzZkJUMzhtU2pER0Vnb1NPUm4xL3VmYmZ2MFFaQ2hwL2M3ZnBh?=
 =?utf-8?B?SzJoZmxTNU5lZVNCamljTVJkQmxoRzlGWWVneFhOaDY0N05NOHRkcU1sb1Vx?=
 =?utf-8?B?bmR0d0pRcFFkb1ZaSWxSNFg3NzJrUzVwMk9IenZlVVVwdyt4QlV3UHI1L05i?=
 =?utf-8?B?OWJCVG5IVnRKenQ3QmxJLzdLSm8vUnhVZzhKZEllWTZhbUpvbnhCYWsyTGtz?=
 =?utf-8?B?NWU3TllzQUtyamlWWThnSzNZM1ZkOUlNY3hkbDExNHFrT3NKT1ArNExLUnZK?=
 =?utf-8?B?VDZxQVh3UGFOaXJjMU5lOVlFY29mTnpyVUxLcGUvT0JKRDRvZXpFUHRKWHZs?=
 =?utf-8?B?c21LWDRCV2pmVGs0NUhJY2I2RHVETTR0ZnVPallMQVNBdnFHTnpEbVBUb1R4?=
 =?utf-8?B?N0Q4aExHYkkwdGxiKzlZS2M5TnM0b2YwKy9raTZUdU42VjZpNE00ZHRRRWJ0?=
 =?utf-8?Q?LkdM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(82310400026)(36860700013)(376014)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:52:30.0400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f8f20f-0992-4b12-1154-08de51af8988
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6351
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


On 12/01/26 11:26, Anshul Dalal wrote:
> On Sat Jan 10, 2026 at 12:30 AM IST, Beleswar Padhi wrote:
>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>> packed inside the multidtb.fit FIT image. While the individual DTBs
>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>
>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>> setup_multi_dtb_fit() when locating the next available DTB within the
>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>> version v1.7.2-35-g52f07dcca47c")
> Is a fixes tag justified in this case? Technically the commit
> 0535e46d55d7 did cause the regression[1].
>
> [1]: https://lore.kernel.org/u-boot/DFJ9947VLHEL.PCDIJCRU24BS@ti.com/


Originally I didn't consider this a regression because the commit
0535e46d55d7 only enforced the alignment check. The alignment
requirement was part of DT spec since long... But doesn't hurt to
add the fixes tag I guess. Will do in v2.

>
>> Add the -B 0x8 flag to mkimage to enforce 8-byte alignment for all DTB
>> entries within the multidtb FIT image.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>  scripts/Makefile.xpl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
>> index 5e65d7b2498..1183f5180ba 100644
>> --- a/scripts/Makefile.xpl
>> +++ b/scripts/Makefile.xpl
>> @@ -602,7 +602,7 @@ $(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_A
>>  targets += $(SPL_OF_LIST_TARGETS)
>>  
>>  MKIMAGEFLAGS_$(SPL_BIN).multidtb.fit = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
>> -	-n "Multi DTB fit image for $(SPL_BIN)" -E \
>> +	-n "Multi DTB fit image for $(SPL_BIN)" -B 0x8 -E \
> The patch looks alright to me though I wonder if as a next step we
> should put the logic to ensure device-tree alignment directly into
> mkimage since it already knows which blob is the device-tree (the one
> passed with -b option)?
>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
>
>>  	$(patsubst %,-b %,$(SHRUNK_ARCH_DTB))
>>  
>>  $(obj)/$(SPL_BIN).multidtb.fit: /dev/null $(SHRUNK_ARCH_DTB) FORCE
