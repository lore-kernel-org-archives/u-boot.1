Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764DECD3424
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 05:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD77184807;
	Wed,  6 May 2026 07:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZoTdf74r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B14E8480B; Wed,  6 May 2026 07:19:53 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDC0847FD
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 07:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OflZOSisblbzWnkxDOq8TK29NbHRQXdW/8YGZ1+WX+fx4YTU9tVLuZaE9FE8qJN6z8Ve8oXSh7wPdVaXtAvIl2xWRkF8ak5EYSxfWVXT1PgwF0I9KJ0pP05LDNPmBb4oRBUy/TogCUmT/P5xZKVI7gAPbI6YJhjqqzqtAtuMsmphrqjmMPK8/w7/alO9UmZTqojBzdplc3IMkTNVgfaG7JKrh33j3Ybcwoy0fupFKBLti5D97uwj3aktUkh1DMnOqPo41sob+ZnVzuGkCKXE4bOyi4H72M/+7XW8uHOLu44zlTomV7+v0QG98OQEGbr6WU9xbreaA4oxlcU1bWM/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Yp131PTdBRveeosq1u90fsSX5xRCQ9ipdJsoHZWRqA=;
 b=y5HNarT8Fjm87fEmBBpa9QYM/R0BbQlicqJphABuBd5FRlOThxehrp+j+NSse5IVctSGPhlNAsblayYPxGVXYxjwre9WE50KYGDUpAfRzFFWC+eGah31zn5FWVEwWS5Vzs4NkSK1g6iXJYdsCODKJl7jtfUOd5g3AxjIbWERPo7ODWGmQxeZgUjSZ0CTnOvmfjSy8vBgLKKkHodfvTMXUtoFRG5mIn1HUAf//OhdtMqN37j913hCbPZhWQi9N2UZjUkF8IdnvR+U5sQDB1YHZuguL53uylbMBzIZiJ6FD+BdvzhpfL08rFGXy+iNInn6w+8OVHuS3AstQzlkQbaG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Yp131PTdBRveeosq1u90fsSX5xRCQ9ipdJsoHZWRqA=;
 b=ZoTdf74rDR6p9bTmI20lE6asEzzuJ+rLfWjZvHv8VCxGOrtlMdVxzVW/11LCZZ5PSdK42ov/xphCGT7xHcxO2/XzUGbAtfuw3sc19VvncNpiH3GPi8lTP9hT7ljKv1DXYC8vZ7NWjbtQsnCvx7Ed1k+lSsezeUyO6RPtimszGeOSsEsK/C48zzu4GPPOJ5W3dBEFzAUPxy/NplovaPZKQPk2ote+OdC31MRsDyEIlJk22x5hSxPuZ44XTzvdDIX7fV1P4UUJK+cul6FMLbn1qnj0wez7Z0Ova6Fr4b6Uvdrh8WlV3++oNUeV5eCH8UQRPlof7PSRI8vRYcnCmm92Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by PH0PR03MB989174.namprd03.prod.outlook.com (2603:10b6:510:3b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 05:19:47 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 05:19:47 +0000
Message-ID: <7f81aed4-16e9-429d-a1ce-5ef60da00b01@altera.com>
Date: Wed, 6 May 2026 13:19:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
 <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|PH0PR03MB989174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcc2511-5afc-428f-3314-08deab2f16cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info: f02BqYukb3K9i71azkkPt2x2F8gPQQGw1uD3GEtJ1y93BYqrOIOgiPjOKpR94Tca/jolBOuBLWvVrOwVGMrHuIXA2B3DxT2fH+8dGV6YdmmDp+NGO6m6SXbynjoKgO9Vx2ka/NICyivuZncxgicJuFiKElMPYnI4CfGyO+msvpqIvvGZvCLI/y+Di7V9EFcCLqezxaYPn8cJVB5iVF68c6WYz+3Ql0CHFLqRER0FM8d+CcJFz1A7C+54KXatvsSo26qWuG4FWHNgSZUzwSNZ/KgfgF1NuQepUj9ijRK0lqd1Q99H3Yu4S+H+xl5UVFSRLpzdzab49FrmXvAM1LZVOyqil88aggstjZEv/xgfuSN5XSgybXvtQia0S5JgG+zuK4tXehzAwXXkVeS4kflBflro9ctn9vj3Vg+Q2JOAzoKuz0toZo7XTEqnRh616QFlw+xpL0ncR241SRoqiJV/BSAh7IokJcCDhbgMYS9GHoXYDgVxli/0Ko5VfXouV+9zccWo8KcsKYwOkBspdJbAlKRe4OtNPcN/CFYbWmcUBHJutziakJYPjDDzhPMFG9WSYbyS6IYccw2lvETfQ2/yS0OT3pP9s837TNjR4mgipvK6AOilrpndrc47q7Rq0nJOAx/1wqt1Jfjobw/bb/53Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUV0YnZmWjNWR2tKQ0V0dzJodkdNcTJ1Z2VqTHdFWklCUnliMWE0enlucXNW?=
 =?utf-8?B?LzYxMWJnQm9xMi9kWklZTzJhZkNpTHBnUjhTLy8zWjJNdTdJdTBjNnRkMG1I?=
 =?utf-8?B?Y3pJWVhNd2NVbkNHNHl2S0wvUTdyZHBPWWk0NUZzZGZkVmJwUEwydkZETzdO?=
 =?utf-8?B?UTJwYXRJYjJBb0lyQU1PTEgyS0t2VmQxVXFHc3gxOURmN0ttU291bHA3NHNs?=
 =?utf-8?B?c25XWUIvNHBvcVMrZG4wakJoQkw4dFAySjdiL2gwbWZ0U0VuRGJaUll2SjJa?=
 =?utf-8?B?YVJkWmZxQUtaYmlJTDZHdnZSNkZVdE55cWRsQnJnRXZubnk5cS9MUkZBUWk0?=
 =?utf-8?B?WUp6TE9UL1FLRFpvTVp0S0NBUElabDBXZHp4L2tZMDB3MlFZQnVxL1BVK1hB?=
 =?utf-8?B?alhOY0tJVExkYW1KMk03aTM5aXRZaExOWGw3R1RpT3NiT1FjZWQ4Vjg5RnJN?=
 =?utf-8?B?Z0dPUGJQbitGZ3FzQ2E1YWJWeTJkRWpad2xFZTloeDNFblFGYjF1QUpzUGMx?=
 =?utf-8?B?RUIzQmwwSlpxVWZRcTBRbmR1U2FLS1VmVlpjeUhINVNuc1BaMnkwM3BRVXVu?=
 =?utf-8?B?VFRuOFBVMi9HQVo5S2JWeU12UVpBbFNjMzhSWU5jK2ZhRFhKc29LWTZUaTdJ?=
 =?utf-8?B?YVBsYjJoeWNJeEQweUJ2K3dtVko1d2Q1bDRWdVRRYURTTDhUeWpFUnliTnY3?=
 =?utf-8?B?RWREY2xUdFlzRlJObUFHSnJnQy9xWjFDUTJRcEZOS1E2d0VPeVlqR1NUUUQ2?=
 =?utf-8?B?WC81bFVNdnYwZW5QaUFDS20xbWd4UlNOa21YN1pkL0poQlUyV2dZSm4yUUts?=
 =?utf-8?B?K3lSN2ppUzlzejRFRlkybGN5elUyV1VtVlh0WldFOGxqbkRsQnE0bjY5NFpP?=
 =?utf-8?B?aXRWWFFKenJiUksrYmNUR2FrTGVFb3dxRXJPOVBQaFYvdlJUQlJoZU8weWNO?=
 =?utf-8?B?cUpPMHVKWmIwZVNoM1VZeHdoM3lFRzlnTDRtMmVlUGx3WU9tVkoxL3JqVkRC?=
 =?utf-8?B?K1h4T05nTTFpV294QkFaazB4bURzSVY5U25rZktScVppbEdaQjRIbnBwVGMr?=
 =?utf-8?B?MHZWWWx3d2ZybW9YNDhtVlo0YWxUZGp0R0U1aC9hQ081MHhGaXZ6OWhpd29z?=
 =?utf-8?B?bC8wWXovOHgzZ296TWhlYkRqSzdaNHhzTjZDaEZmQlhXMTkvQndLQ0dTdEVI?=
 =?utf-8?B?bEsyYnBMZHgyVWl0cHVDUkswR21ManZuUTNZbmRHdlBxcXlWalhpamRCVGk3?=
 =?utf-8?B?ajZuQyswdjJGcDY4UFhSY0pCUGRYc2VNVlBrdHRDVG1mWWVDeXZuell4Snlm?=
 =?utf-8?B?dThNZW5rbTBkd3FJZW9Ea2xRS09TalVDOG16SzVjdzJzb1B0U0RrYVFZUGNF?=
 =?utf-8?B?YU5xdjhGcjcxUUhLV1VYQ2N3OWQyU1ZWakM1UnQ1NFZMNnU4QWNzdW0rNHhl?=
 =?utf-8?B?YUtBZzBCVGQ0ZWJZazFsTXlVMW1JTVhabHB4Q3ptaUhINW5jczVUYndrektq?=
 =?utf-8?B?c05WZTFGY29uZGhsTzlDOHVzdDE0YnZDaFVtS1NQMXNZUm16WE1JT3lkVzVa?=
 =?utf-8?B?bUhVVHd6d2dZTy9Bc0xva3ppZmxNMFlkc2llMEFsREpzbWZvNVJqQml5bFdk?=
 =?utf-8?B?bjBSaXdtS0F1SGQ5NUpoM1Z1OXFhclgvQVJpVGlFTzFrdVpDdXJMTUcwQUJO?=
 =?utf-8?B?OTBNT1hoamljeGNDaXg4V2Vad3EwVFRIODZjWkorbldVNUNqMDVtbmQ1OGZJ?=
 =?utf-8?B?bFdoQkRIczRlaVNpbGNpUnZkT2M4Mkw1Vzhpa1phMnVYekFoZE9QUGdIQ2FE?=
 =?utf-8?B?R3QyM2U1TXczbmtSSkpFaU9ROXpSSE52WmUrYjVyQUN0T09PZjdhWW5uaVRK?=
 =?utf-8?B?QmtGbkVqMDBSYWlRMmdnVnZTWnUxWUlsSkIxUFp3MWFpbGR0bjB1T1RhdnM2?=
 =?utf-8?B?UjhvaW9HRVpMTnZLbGtUTzFOQWNoT0Yvam9HbzRjaFBnV3lwbi9UazdLUHhv?=
 =?utf-8?B?eVRuNDhJYjJaUlB5THRneC9CR1FWdlI4RDYxSjAwWXVoSUJnMmYrUHNQdzNj?=
 =?utf-8?B?aFZPczR6VXIza3FrU1d0K1BiSGQrMk9oQW9sY25XSWMzREhZVzFHT0g3UmxM?=
 =?utf-8?B?eVN2RXE3YURoWis5RER3ZTlKSDdtTFp3TDZ3RmE4bkp4MXd5QnBVMjVOUnM5?=
 =?utf-8?B?dkJ4TlVFVnVIa0I1Q29jbG1Hd0VZa1hWN2srb1BQMVI4a3Z5RDFUU0NPUkhv?=
 =?utf-8?B?MUpRaUZoUEpVODRlc0E3ZXZEMXJIaUZ2STg1S3pNRzlvdmY2K1ZWMjZlY3hk?=
 =?utf-8?B?K3hGUnZ3MXFMTGV5YnZMZXczS3l1dHZ5U1NwOHZ3R042K0pRQ2hIL1NhTGhw?=
 =?utf-8?Q?GK6DDvJAxpY/Gk64mvKchCbN7UCebCrg/ylev?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcc2511-5afc-428f-3314-08deab2f16cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:19:47.2062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cFKJV5IKGkO4ELi8Fw+zGtEs7OdDbZ032plN3e3T+SwEiHmuV0u29aRslDNcQ2TFLqnVFXRwyoLuiSGnw2Fnc8yryEVNpC6afE0J/u5/DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989174
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

Hi Tien Fong,

On 5/5/2026 2:54 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
>> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
>> case.
>>
>> This implementation turns the caches on temporarily, then overwrites the
>> whole RAM with zeroes, flushes the caches and turns them off again.
>> This provides satisfactory performance.
>>
>> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
>> Preparation for Gen5 uses the same memory initialization function as
>> Arria10.
>>
>> New Kconfig is introduced to enable this implementation only on the 
>> default
>> Arria10 and CycloneV boards as this will increase the SPL size which
>> will exceed some Gen5 devices' SPL size limit.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   arch/arm/mach-socfpga/Kconfig      | 13 ++++-
>>   arch/arm/mach-socfpga/spl_a10.c    |  4 ++
>>   arch/arm/mach-socfpga/spl_gen5.c   | 17 ++++++
>>   drivers/ddr/altera/Makefile        |  4 +-
>>   drivers/ddr/altera/sdram_arria10.c | 34 +++++-------
>>   drivers/ddr/altera/sdram_gen5.c    | 41 ++++++++++++--
>>   drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
>>   drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
>>   8 files changed, 187 insertions(+), 26 deletions(-)
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>>
>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/ 
>> Kconfig
>> index 830585a72cc..dd71691b724 100644
>> --- a/arch/arm/mach-socfpga/Kconfig
>> +++ b/arch/arm/mach-socfpga/Kconfig
>> @@ -6,6 +6,13 @@ config ERR_PTR_OFFSET
>>   config NR_DRAM_BANKS
>>       default 1
>> +config SOCFPGA_ECC_SUPPORT
>> +    bool "Enable ECC support for DRAM"
>> +    help
>> +     Adds CPU-based ECC support for DRAM at boot. This will initialize
>> +     all DRAM ECC metadata to zero, preventing false ECC errors and
>> +     improving reliability.
>> +
>>   config SOCFPGA_DRAM_SIZE_CHECK
>>       bool "Enable DRAM size checking for safety"
>>       help
>> @@ -105,6 +112,7 @@ config ARCH_SOCFPGA_ARRIA10
>>       select ETH_DESIGNWARE_SOCFPGA
>>       imply FPGA_SOCFPGA
>>       imply SPL_USE_TINY_PRINTF
>> +    select SOCFPGA_ECC_SUPPORT
>>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>       bool "Always reprogram Arria 10 FPGA"
>> @@ -117,6 +125,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>   config ARCH_SOCFPGA_CYCLONE5
>>       bool
>>       select ARCH_SOCFPGA_GEN5
>> +    select SOCFPGA_ECC_SUPPORT if \
>> +      !TARGET_SOCFPGA_TERASIC_SOCKIT && !TARGET_SOCFPGA_EBV_SOCRATES \
>> +      && !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>>       select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
>>         && !TARGET_SOCFPGA_EBV_SOCRATES && \
>>         !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>> @@ -124,7 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
>>   config ARCH_SOCFPGA_GEN5
>>       bool
>>       select SPL_ALTERA_SDRAM
>> -    select SPL_CACHE if SPL
>> +    select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
>>       imply FPGA_SOCFPGA
>>       imply SPL_SIZE_LIMIT_SUBTRACT_GD
>>       imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
>> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/ 
>> spl_a10.c
>> index c20376f7f8e..4d0696bbaf6 100644
>> --- a/arch/arm/mach-socfpga/spl_a10.c
>> +++ b/arch/arm/mach-socfpga/spl_a10.c
>> @@ -25,6 +25,7 @@
>>   #include <asm/sections.h>
>>   #include <fdtdec.h>
>>   #include <watchdog.h>
>> +#include <wdt.h>
>>   #include <asm/arch/pinmux.h>
>>   #include <asm/arch/fpga_manager.h>
>>   #include <mmc.h>
>> @@ -265,6 +266,9 @@ void board_init_f(ulong dummy)
>>       /* Configure the clock based on handoff */
>>       cm_basic_init(gd->fdt_blob);
>> +    if (CONFIG_IS_ENABLED(WDT))
>> +        initr_watchdog();
>> +
>>   #ifdef CONFIG_HW_WATCHDOG
>>       /* release osc1 watchdog timer 0 from reset */
>>       socfpga_reset_deassert_osc1wd0();
> 
> 
> Why not remove this?
> 
> 
Thanks for pointing this out. I must have missed this out for Arria10.
I will remove this in v3.

>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/ 
>> spl_gen5.c
>> index 08b756db2ca..530863b1564 100644
>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>> @@ -6,6 +6,7 @@
>>   #include <hang.h>
>>   #include <init.h>
>>   #include <log.h>
>> +#include <asm/global_data.h>
>>   #include <asm/io.h>
>>   #include <asm/utils.h>
>>   #include <image.h>
>> @@ -21,9 +22,17 @@
>>   #include <debug_uart.h>
>>   #include <fdtdec.h>
>>   #include <watchdog.h>
>> +#include <wdt.h>
>>   #include <dm/uclass.h>
>>   #include <linux/bitops.h>
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +static struct bd_info bdata __attribute__ ((section(".data")));
>> +#endif
>> +
>>   u32 spl_boot_device(void)
>>   {
>>       const u32 bsel = readl(socfpga_get_sysmgr_addr() +
>> @@ -106,6 +115,9 @@ void board_init_f(ulong dummy)
>>       if (cm_basic_init(cm_default_cfg))
>>           hang();
>> +    if (CONFIG_IS_ENABLED(WDT))
>> +        initr_watchdog();
>> +
>>       /* Enable bootrom to configure IOs. */
>>       sysmgr_config_warmrstcfgio(1);
>> @@ -143,6 +155,11 @@ void board_init_f(ulong dummy)
>>       /* enable console uart printing */
>>       preloader_console_init();
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +    gd->bd = &bdata;
>> +#endif
>> +
>>       ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>       if (ret) {
>>           debug("DRAM init failed: %d\n", ret);
>> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
>> index 8259ab04a7e..ece6a131897 100644
>> --- a/drivers/ddr/altera/Makefile
>> +++ b/drivers/ddr/altera/Makefile
>> @@ -7,8 +7,8 @@
>>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
>> -obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
>> -obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
>> +obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o 
>> sequencer.o
>> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
>> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/ 
>> sdram_arria10.c
>> index c281f711fdf..09d3526603e 100644
>> --- a/drivers/ddr/altera/sdram_arria10.c
>> +++ b/drivers/ddr/altera/sdram_arria10.c
>> @@ -22,9 +22,13 @@
>>   #include <linux/bitops.h>
>>   #include <linux/delay.h>
>>   #include <linux/kernel.h>
>> +#include <linux/sizes.h>
>> +#include "sdram_soc32.h"
>>   DECLARE_GLOBAL_DATA_PTR;
>> +#define PGTABLE_OFF    0x4000
> 
> 
> Dead code, remove PGTABLE_OFF, only sdram_soc32.c uses it
> 
> 
Sure, I will clean this up in v3.

>> +
>>   static void sdram_mmr_init(void);
>>   static u64 sdram_size_calc(void);
>> @@ -193,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
>>             ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>>   }
>> -/* Initialize SDRAM ECC bits to avoid false DBE */
>> -static void sdram_init_ecc_bits(u32 size)
>> -{
>> -    icache_enable();
>> -
>> -    memset(0, 0, 0x8000);
>> -    gd->arch.tlb_addr = 0x4000;
>> -    gd->arch.tlb_size = PGTABLE_SIZE;
>> -
>> -    dcache_enable();
>> -
>> -    printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
>> -    memset((void *)0x8000, 0, size - 0x8000);
>> -    flush_dcache_all();
>> -    printf("DDRCAL: Scrubbing ECC RAM done.\n");
>> -    dcache_disable();
>> -}
>> -
>>   /* Function to startup the SDRAM*/
>>   static int sdram_startup(void)
>>   {
>> @@ -735,8 +721,16 @@ int ddr_calibration_sequence(void)
>>       if (of_sdram_firewall_setup(gd->fdt_blob))
>>           puts("FW: Error Configuring Firewall\n");
>> -    if (sdram_is_ecc_enabled())
>> -        sdram_init_ecc_bits(gd->ram_size);
>> +    if (sdram_is_ecc_enabled()) {
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +        sdram_init_ecc_bits();
>> +    }
>> +#else
>> +        puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
>> +        puts("ECC is enabled.\n");
>> +        hang();
>> +    }
>> +#endif
> 
> 
>   confusing pattern, moves the } outside the preprocessor block entirely 
> to here
> 
> 
Thanks for the suggestion, I will implement this in v3.

>>       sdram_size_check();
>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/ 
>> sdram_gen5.c
>> index 1c3c70ea8ae..76effb264e2 100644
>> --- a/drivers/ddr/altera/sdram_gen5.c
>> +++ b/drivers/ddr/altera/sdram_gen5.c
>> @@ -2,6 +2,7 @@
>>   /*
>>    * Copyright Altera Corporation (C) 2014-2015
>>    */
>> +#include <cpu_func.h>
>>   #include <dm.h>
>>   #include <errno.h>
>>   #include <div64.h>
>> @@ -19,8 +20,11 @@
>>   #include <asm/global_data.h>
>>   #include <asm/io.h>
>>   #include <dm/device_compat.h>
>> -
>> +#include <linux/sizes.h>
>>   #include "sequencer.h"
>> +#include "sdram_soc32.h"
>> +
>> +#define PGTABLE_OFF    0x4000
> 
> 
> Dead code, remove PGTABLE_OFF, only sdram_soc32.c uses it
> 
> 
I will clean this up in v3.

>>   #ifdef CONFIG_XPL_BUILD
>> @@ -566,6 +570,19 @@ static unsigned long sdram_calculate_size(struct 
>> socfpga_sdr_ctrl *sdr_ctrl)
>>       return temp;
>>   }
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>> +{
>> +    return !!(readl(&sdr_ctrl->ctrl_cfg) &
>> +          SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
>> +}
>> +#else
>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>> +{
>> +    return 0;
> 
> 
> 4 spaces (WRONG, should be \t)
> 
> ERROR: code indent should use tabs where possible from checkpatch
> 
> 
I must have missed this checkpatch error. Thanks for pointing this out. 
I will clean this up in v3.

>> +}
>> +#endif
>> +
>>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>>   {
>>       struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
>> @@ -608,10 +625,13 @@ static int altera_gen5_sdram_probe(struct 
>> udevice *dev)
>>       sdram_size = sdram_calculate_size(sdr_ctrl);
>>       debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>       /* setup the dram info within bd */
>>       dram_init_banksize();
>> +#endif
>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>>       if (sdram_size != gd->bd->bi_dram[0].size) {
>>           printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
>>                  (ulong)(gd->bd->bi_dram[0].size >> 20));
>> @@ -626,8 +646,23 @@ static int altera_gen5_sdram_probe(struct udevice 
>> *dev)
>>       }
>>   #endif
>> +    if (sdram_is_ecc_enabled(sdr_ctrl)) {
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +        /* Must set USEECCASDATA to 0 if ECC is enabled */
>> +        clrbits_le32(&sdr_ctrl->static_cfg,
>> +                 SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
>> +        sdram_init_ecc_bits();
>> +#else
>> +        puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
>> +        puts("ECC is enabled.\n");
>> +        puts("DDR: Without scrub, false ECC errors may occur.\n");
>> +        hang();
>> +#endif
>> +}
> 
> 
> WRONG, should be \t
> 
> 
I wil clean this up in v3.

>> +
>>       /* Sanity check ensure correct SDRAM size specified */
>> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
>> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>>       if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>>           gd->bd->bi_dram[0].size) {
>>   #else
>> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/ 
>> sdram_soc32.c
>> new file mode 100644
>> index 00000000000..7556d4933f4
>> --- /dev/null
>> +++ b/drivers/ddr/altera/sdram_soc32.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>> + */
>> +
>> +#include "sdram_soc32.h"
>> +#include <string.h>
>> +#include <hang.h>
>> +#include <linux/sizes.h>
>> +#include <cpu_func.h>
>> +#include <watchdog.h>
>> +#include <wait_bit.h>
> 
> 
> Unused header
> 
> 
This header file is needed for get_timer() function declaration. 
Removing this header will cause compilation failure.

>> +#include <asm/global_data.h>
>> +#include <asm/system.h>
> 
> 
> Unused header, please check!
> 
> 
This header file is needed to define PGTABLE_SIZE.
Removing this header will cause compilation failure.

>> +#if !defined(CONFIG_HW_WATCHDOG)
> 
> 
> #if !IS_ENABLED(CONFIG_WATCHDOG)
> 
> 
>> +#include <asm/arch/reset_manager.h>
>> +#endif
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define PGTABLE_OFF    0x4000
>> +#define PGTABLE_RESERVE (PGTABLE_OFF + PGTABLE_SIZE)
>> +
>> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>> +static void socfpga_prepare_watchdog_for_long_op(void)
>> +{
>> +#if !IS_ENABLED(CONFIG_WATCHDOG)
> 
> 
> #if IS_ENABLED(CONFIG_WATCHDOG) || IS_ENABLED(CONFIG_WDT)
> 
> 
Shouldn't it be "#if !IS_ENABLED(CONFIG_WATCHDOG) || 
!IS_ENABLED(CONFIG_WDT)" instead? This is for no DM watchdog enabled 
scenario.

>> +    /*
>> +     * No DM watchdog support enabled. Previous boot stage may have left
>> +     * L4WD0 running, so stop it once before long DDR scrub operation.
>> +     */
>> +    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>> +    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>> +#endif
>> +}
>> +
>> +/* Initialize SDRAM ECC bits to avoid false DBE */
>> +void sdram_init_ecc_bits(void)
>> +{
>> +    u32 start;
>> +    phys_addr_t start_addr;
>> +    phys_size_t size, size_init;
>> +
>> +    start = get_timer(0);
>> +
>> +    start_addr = gd->bd->bi_dram[0].start;
>> +    size = gd->bd->bi_dram[0].size;
>> +
>> +    printf("DDRCAL: Scrubbing ECC RAM (%lu MiB).\n",
>> +           (ulong)(size >> 20));
>> +
>> +    if (size <= PGTABLE_RESERVE) {
>> +        printf("DDRCAL: Error: DRAM size %#llx smaller than scrub 
>> reserve %#x\n",
>> +               (unsigned long long)size, PGTABLE_RESERVE);
>> +        hang();
>> +    }
>> +
>> +    memset((void *)start_addr, 0, PGTABLE_RESERVE);
>> +    gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
>> +    gd->arch.tlb_size = PGTABLE_SIZE;
>> +    start_addr += PGTABLE_RESERVE;
>> +    size -= PGTABLE_RESERVE;
>> +
>> +    dcache_enable();
>> +
>> +    socfpga_prepare_watchdog_for_long_op();
>> +
>> +    while (size > 0) {
>> +        size_init = min_t(phys_size_t, (phys_size_t)SZ_1G, size);
>> +        memset((void *)start_addr, 0, size_init);
>> +        size -= size_init;
>> +        start_addr += size_init;
>> +
>> +#if IS_ENABLED(CONFIG_WATCHDOG)
> 
> 
> Can remove the guard,  just call schedule() unconditionally, it is a no- 
> op when nothing is pending
> 
> 
> Best regards,
> 
> Tien Fong
> 
Noted, I will implement this in v3.

Thanks,
Alif

