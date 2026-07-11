Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900FFC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 06:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CD78407E;
	Sat, 11 Jul 2026 08:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e/1IRiP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC0A84119; Sat, 11 Jul 2026 08:36:34 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3425F8341A
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 08:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxwUeaB5AGUVnxU+FOJdSExl46RTAEj8BczoJhPzpaD9EyVPdyhRyCaWtSLQ3cNJqEO2im19die6UJer/08YgMJ3bK0VIAHQ3mraIrpOUdoGeKhfqS6NfSjVDrC3bTPMQuElh3OhK3WUMECBCcBTjRXCml4IUhPV3wBfvARI0M3ROf/nAo9N/WwslIRPGEF4BOOViNp8pFFHFUl/mlJ8V4pCzdd1qaIrWG5Dq7gD+OKno/H6z3pcdbqIRBdqct9+Ps7s2UdX5bz2UC9+8IoYlYSvxpg4H1IOBRruaJS8vVDyO1sy8TR8m6QWuW+Cpn0SwZMiJ3jhBkzURLaSslafzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7zfudiBwuMNcJoLW/RF9HcSiyKk/doxUQ58Pi2Q+Hg=;
 b=Jx6PWCO5S86pucl89iLAzR3wbQsa0NabpnERLBVv0yv+HBr6bwHsBaImsFL3DO3TYoqw0MhfT4qDekJGFCBZnLaioqhFW0NbgYHWeCuDDcs69K2dLEFVB6AbkmSsmtNMCwQPNK1lDz5w/cbGWE7umhpS6alPiebraw1zc1pd4+dPDBa4FX8ZpEvJOygrVrke3rC2BQ6/uG3wlQaQAw8RtrYcFFC9YxZmmGrRf82qKq8kDJqdEIVR7Iv8XpsyFe+ON+G2Cjmuv8WsnF9NcO2J1Htqw8ldJvex4U3cdFPbSk0jc1fawUHxUm304e3BdRn4Jw1rjQ6y6FLXBCZezQdLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7zfudiBwuMNcJoLW/RF9HcSiyKk/doxUQ58Pi2Q+Hg=;
 b=e/1IRiP8U/ljt6hmX4nQ7DST8ovqLyRt6olTPKPmNC+uUoja8pMkvagLDNh6HXwfAw0WubzOfwmqP8XSJVa3pGUi/Wy52UKxMTaS6A8teGaF6WeTMLGfIM2PbH1Y6MpKwgM7IaexUYtM63f+LjiH5DNF7m5LmGvzx0uabp+87uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sat, 11 Jul
 2026 06:36:28 +0000
Received: from PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1]) by PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1%6]) with mapi id 15.21.0181.009; Sat, 11 Jul 2026
 06:36:27 +0000
Message-ID: <6a9f0530-ea41-491b-b4f4-f7d03ee2fd3a@amd.com>
Date: Sat, 11 Jul 2026 12:06:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mtd: rawnand: zynq: Fixes and software ECC support
To: Michal Simek <michal.simek@amd.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
 <af5b229e-0466-45cf-9562-434dc0fa383f@amd.com>
Content-Language: en-US
From: "Kumar, Love" <love.kumar@amd.com>
In-Reply-To: <af5b229e-0466-45cf-9562-434dc0fa383f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:260::16) To PH7PR12MB7380.namprd12.prod.outlook.com
 (2603:10b6:510:20f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7380:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: f3830fcd-5ee1-4ea3-635c-08dedf16bc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: gT2WDdrP5k2FyXD3UlJrUg2kC5Nsq74U7ZVrxecAdwIIRWEp/JemnAMu7Gf5Nac0JCDRey42cGm37hLHFWQxKV5xfTNFcacmrKW6hLh/HzzN/ORBOigqeZw16p+wt/4p7gCbMFQTKedWD3OIJAJ64RPgx3zWK/HwjMZsd5ppaPGgLpRU+9T3DfbfNC5c3ugXqAHLZ5yVz18T51t7tCDhOaUPA2t99ghcoi8VS2nuIZfNoWi/yBrQtzRX01goczbjQKNW/Aaz89EDhV3RzgVQ6iltJqArKjYU9svZ70pXW/O4g9fuc4MkGw+rYAgYLjjvg8FTCaxIdCjHkCR0ahViaGtpDcN1Fg+phwSvB41puRn05SC4wtH2VIaUxYVh4z0EmoTRbPfk9xYrkTQl8poD9QHPODkpMRrgM9oAfaOvr2zyQFXZhzQzXFL+r/YOzewm580McWIEDI3q6kLzZL3aJf3beOTviRzRMDg74tPOH0R/IOitu1w4ZueDgXtmElUdoZpeYPOt3ug3qkZrehB+rMguG4wXDFelErOkySJPAKz4xKq1DzKDc9d6RBwlNWS8DoepRKXoWuWEhUOuGGyscow8UmAgsmp0LO6NK1DbCd3wt1rnI05ATQ6TY4P1Awkmf89+wxP9Q0p6Z1Jj3n3L27ppKFDNthPrkHdOnlIhYuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7380.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZsWEtKRXl2a2J5ajFBMm90bTFvcEFNSGYvV3NWUTl6Vm5nZDVtN0I2Nm5I?=
 =?utf-8?B?dTVqNVp4WjZLbzJqaC9HQlJvNUxZSUx0bGtVU0h4L0FiL0FvWmJrZVFzOXU0?=
 =?utf-8?B?K1pEb21NbisxYmNXenBqYkthUHdCZytBZFVVREkzemFCcmRsbC9sZXB2QUdM?=
 =?utf-8?B?aVh5WUVzNmFudCtGRFBvczBwczRFRGJoR1krMVR0TkN4RURGSC9DdTMxdTl1?=
 =?utf-8?B?aFg0WlcxYjBXNXp3MXArUVBEdGhVblg5VlpnVHB1NjRtQkhnNStabEc0UHh4?=
 =?utf-8?B?MHhVd0NVQm5PR21VRWNqOFhvd1hDbTB5bUJjU3FyOXVsbkNoNUpEbmVLd0E0?=
 =?utf-8?B?TlVyWHA0Qy9PVlJXRm9Dc0xseVpSTWhTVHhIdkwzZXpyUHVRdWVzcW1sOE1S?=
 =?utf-8?B?Yy8xQnBJRmlXVzJ2Ty9DS0M0WDEyMTIwQncxeWxMdEZCT2JLL1pYdEVwbXZQ?=
 =?utf-8?B?eTM1Vzg5TURFc0ZWL3JjUVdWaDl5TmNweTlTMlhaYXFxMmN4b3VicUovVDIv?=
 =?utf-8?B?dFB3QytnZG5WQ0NqbUozRVVpQ29haG12VkI4K3JXRHZsK0FIYTNsdW0xNHRz?=
 =?utf-8?B?QXZQQzlYc3lhUHpESUVCRTF0QlhaWkY1MTdXR2R1OWt6NEFLNjBTdDgyU1VU?=
 =?utf-8?B?ZXdnY0dleUJQcWRENDdzNi91cDFkUlZiN0tSYWRCL3lJNWdibldkYlZkZ21P?=
 =?utf-8?B?alk4SUVwNVJmYUo0eWk5T1k3U0RKeDJxNmZzcHlOM2xzMGk5WWVOaStnblJL?=
 =?utf-8?B?UEt1MFlsa2dwdTNmQ3BkemIrR2VaRHVTWitYODFvTEl2T2xsL3RxUHVYSVRW?=
 =?utf-8?B?aHZ1b2N5OHFsWVd1V21Eb2dXZzVLR1EwL3NBT3BERFZaRkRMdmkrRU5ZdEFT?=
 =?utf-8?B?bTYzaXNCQVFaUHJFaytQUExIRXpsSWs0RzdqUVV0ZkpoL1BiWGFNYU9wUmtZ?=
 =?utf-8?B?NE9DRlJtSkF3eWgycForaURzaENuL1dTNU9yOWlqY0tNRHUwYkMvcTBwVFgv?=
 =?utf-8?B?K2NVaHlEQ1IxcnB4RURrMi9BVlpEb0RMU21TZVM3NW5ZUytlcGM4blhNK3ZG?=
 =?utf-8?B?WHJVWFMwc1ZBMXZBMTVmSVhXRnZTVWhEbCt3R0ZtcFJHWU0zNnJ0c0hSWjVP?=
 =?utf-8?B?MUNQNk1KcHV5VlUvR1l5VHI5ZGE1My8rNE13bGp4bERwRDY0UDl6L2dOb2dQ?=
 =?utf-8?B?NlFpV2ZjYUFkQ0ppUjU3aHJwbWx5b2xQeEF3MExmRDZBL1MwRzF6Q0dLOGly?=
 =?utf-8?B?Zm9meHVJY2pxdnI0TThOY0RQT0MzOWk2NmI2MGc1Y0pxSlZleWt3dzgrdVpF?=
 =?utf-8?B?QWltQWtveUtoR0tnMkpzcUlZNGh4aHhpVEVMVkhYTHZsZXRFY0Z0WDRLcjFW?=
 =?utf-8?B?eFFiaHVudGZjT3VSanBXb0licHhZNDBycUl6V0x6UEpoVlpXeFFiM2tLMmx0?=
 =?utf-8?B?aGNIZVl5VW1aR3BYaVpsdWNLQ1Z4SHo3WW1CaTVSbjdzM2NCbG5rZjZzMUl0?=
 =?utf-8?B?VWpvRFZvVDBPTHFnNy8rV0x4RnVabWVidElzbEduNXNwdnJrYjdMY05NM1dC?=
 =?utf-8?B?dGwyMGdIelFHVVhWUEFHK2JWUEpyNkJnMmhFQ1o3V3JLZTZOR0tZaHlGb1lv?=
 =?utf-8?B?bFR2cWRDRlE1L0JPckVneU56UThKMEluaGNEVGVGSGhZR1hJK0xhc2hROVhz?=
 =?utf-8?B?VWV0TjRuWFhmdVgvbnVOMVI4cDFMUGJNVTRIcjdoQlNxY1orSnA1R2dNa3Vm?=
 =?utf-8?B?SzRKNFBMeHp6Um1oVTdtYlFkZHlXYW9ZQUNLL2hWWm1QYks3RFNYcVRsYlJL?=
 =?utf-8?B?bEtwVEQ2SU5BTFhHUFFVUTlGeUF2U0RXQWY4ZjNSRkN2WHB4NS9yZmd4SVVR?=
 =?utf-8?B?UThxUTZuQlRIQk80TzF3SnQzWCtjMWI4RWpTOEZzSkVvWWhkOFR2ZWdFS2xo?=
 =?utf-8?B?c0l5Q29va3pneFpMN2tRNVpxTitOckF6YzlpNk5DT3dvY2JNWVpGOFhBNHd6?=
 =?utf-8?B?bVNQbU1PWjV3ZTNuMGQ4RVB0RDB6aTNtakIzV3lCTFkzVHBvYUJoT2xFWkp0?=
 =?utf-8?B?TVNNK1hHZGtxenorRlBZcFpmUmQwME45MmlJTit6Q2lrSVAyUWJ6bkFaOTBI?=
 =?utf-8?B?SHdGYjJEU1BPamhadEl2Z2NvaUdGeXBWMkVoRVQ3WStFTUlsQnZaVjgvNWtB?=
 =?utf-8?B?RGpSYTdmbUViQ0V6bjYyQWtTTVp5YmllaUpzUDZueHcxK3pxTy9aQjM3N05s?=
 =?utf-8?B?VG85S21qaThmQ3VuTE9yemFzSjZESTE1MTZPd1lFVk5PYTJyZWFSTGZoc2c1?=
 =?utf-8?Q?zUhFkLcrbTLxjXKk3O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3830fcd-5ee1-4ea3-635c-08dedf16bc2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 06:36:27.4814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npIe0gnTWzkEhq+SGxG7JSUcrTVPfZd+2Gef/3Cbu3gmrN3s/W/wbhoQP+Or59cM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
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

Hi Michal,

On 7/9/2026 11:23 AM, Michal Simek wrote:
> Hi Love,
> 
> On 7/2/26 15:08, Bastien Curutchet wrote:
>> This driver is deeply broken in many ways. Miquèl has cleaned it up by:
>> - flagging the most hideous parts (where Micron on-die ECC support is
>>    hardcoded)
>> - enabling DT support, eg. for reading the ECC configuration
>> - fixing software ECC support
>> - aligning the software ECC OOB layout to the rest of the world and
>>    allow a working interoperability in Linux.
>>
>> I then added a patch to fix writes when soft ECC is on.
>>
>> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
>> Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
>> ---
>> Changes in v3:
>> - Add patch 6 to fix write issues in soft ECC.
>> - Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com
>>
>> Changes in v2:
>> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
>> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
>>
>> ---
>> Bastien Curutchet (DAVE.eu) (1):
>>        mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC
>>
>> Miquel Raynal (DAVE.eu) (5):
>>        mtd: rawnand: zynq: Align the layout structures with the driver namespace
>>        mtd: rawnand: zynq: Add comments about very bad practices
>>        mtd: rawnand: zynq: Make sure an of node is attached
>>        mtd: rawnand: zynq: Do not fail the probe for no reason
>>        mtd: rawnand: zynq: Fix Software ECC engine support
>>
>>   drivers/mtd/nand/raw/nand_base.c |   6 +-
>>   drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>>   2 files changed, 32 insertions(+), 89 deletions(-)
>> ---
>> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
>> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
>>
>> Best regards,
> 
> Please test this series.

We are again seeing the NAND write issue with zynq-zc770-xm011 board.

Below is the log snippet:

Zynq> nand write 0x80000 0x0 0x126f80
nand write 0x80000 0x0 0x126f80
NAND write: device 0 offset 0x0, size 0x126f80
NAND write to offset 0 failed -5 

Regards,
Love Kumar

> 
> Thanks,
> Michal

