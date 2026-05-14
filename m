Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E60CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 06:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2893D80F0E;
	Thu, 14 May 2026 08:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qzTj20oO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0D280F0E; Thu, 14 May 2026 08:45:24 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967558056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 08:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYrJo7eay6G+4yQn1dHVArAeSE4lypPg20BACXFJZ/hc89U3draSyZJSis6Bpyz9oZ9W2ek5am+2Dh52hI/Kwu6ZvatQsypN9SlAQkpHhyMWqwx0zDWmtY+fKrXhOuRLHJARiAdrJhCSgQahiYce8M6c0EF1XVA3FGrvFnbOQ8FyUyzz8xMfJwiqUAoOgbl1BSNCbQbLs9IDH0wNdBs8L6I6sE74LVHJA9Pk+k3TZPCEjFpjNM9z+Novsy95ocO53z+N9b8eIKaVl0DiyaAJyxMjKzTr/WXxUKVQMUbuIUZwgXMD6Bwm8n8IHjBN8hm+oNClZ+1t2aZfdQD1b87YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgR6cw0Zn6dwv5DEzrLOjH+RH3wFU3lxYLjkc3oCrj4=;
 b=AlQh/7f1Z17u99l+rgeWY7Q1CEPRjEM9sRT8Z9KZZ7kbEAAVcq/vhfVfjtM4PShNnhb+pLy5Ylmo4FumvZlHlo+IU0CfTLpaX1LCrDXFQOWVJ+MA7SCSm71Z3LaqXspyJJwq/wQMjMJbMS2JAzuqCSa2UZpbl2g5tA+aVhJAnKa4xiC6TdvTgvulztMStJzmX+MEapaCXh2I2PXoVRbRCJLmgDbhZg7Ot69d3lcYWjKBvDbO1/+yfI1i0LoakbnCV26h/UeiXV4RJ2bV7R8e3aAuN9T3qETwCQfLtERwddtJyhwoXSoduHvAb7u4rm0SZzzRc9aG8BW4Sjv3K4/EuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgR6cw0Zn6dwv5DEzrLOjH+RH3wFU3lxYLjkc3oCrj4=;
 b=qzTj20oOFwWkpfpk/PxuE09k7BzGN3CATiQHOa1cHKJrH/0I9SY6CPaLv/flIXJzEXu6MKw7q2580r2wc0e+addeeWnxc+UFdPWOmN14MDwNMCL4EVnL7A8XaRPikkCVQ0iUhWEb5npItE8rv7xumvupLiYQBBTDnzj92YENeGbOJK1YeMMrRTQZL7Kf2GfW3UHeH8Xa/MGQVlVmqQqDCSl8JJc54rHC2G7NkMbszfGc/0YsCzayrPRDYgRWVIyhwG+/eqmDRn2L2kENzz9CHbAkU/9muNWbsPYX0s01APJvDTpB8jZVDkd+P7C2T4olSkQws0OWHVZrePgRGp7q8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7186.namprd03.prod.outlook.com (2603:10b6:806:2f5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Thu, 14 May
 2026 06:45:17 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 06:45:17 +0000
Message-ID: <1a913c20-3523-4e41-b07b-3b59ad94fe71@altera.com>
Date: Thu, 14 May 2026 14:45:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-2-alif.zakuan.yuslaimi@altera.com>
 <cde9444b-1f01-4932-be46-d751e347379c@altera.com>
 <5ea9a521-a27e-49c1-8963-d4e3ff9d8dca@altera.com>
Content-Language: en-US
In-Reply-To: <5ea9a521-a27e-49c1-8963-d4e3ff9d8dca@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a56e41-447e-49db-5337-08deb1845bbd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799003|13003099007|55112099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 3uv+7+2VE1kSlfMC3R4OhRYU5btX8WqHXMwhdntUW0l0wl0JFsmrTboysC/SmwYlYG/KvPlT73z+8n5x6f2BKBZqt/YK02Rtd6kwYlTCXtztwRcXM8Kd5HGCFQK22/083nisYe4A/k6uXRh6V4Sx/nq+/TYw8Ipajyo/WL3cNVlHbF/HTyOK3besIkMuzxF8pm+GSc3gHc1X5ZZV9iuoWPWaj0ecNcXjGfqT9LtRZc4RN/T5JaCMPo92VCtKOjfU5XT9SdJVMcB6nzfWY5Gkv+C6uGFYJinw5Qwiv9MFQQryIZhdCFprz0MSL06+i8UnFCDCaOB2rH8DrAeG21Acj8TwqrY9EEFNd9kOWPOxPWz+9ieMhq/q8zX/0+qDw94TRkMzYNt3UBJ2GeJVGysIbZ4Z5Dx1OdAWSdbXkWcVS6VefJVTYan3oGUBth5KCYBexkWXyKNFomBN38cbQF2qLQ1d3tpFnJaN5FNOBlTTGBRAXvU1d4xkUGTP4YToswPyohD5ObXtke1nsW9P4+x7ZKZ/fTe6qtW1dvPdHEoPhMy8MspVRwkbngO4natkc/jb0Lcl9DnTKELyZyQcfAQWhv+RWslrRs1cx2bfexCLZQsNrcMV/ofufchTEJFyuw0h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799003)(13003099007)(55112099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNZYlFsWlpXQ3lPald3RkZicnRpNmJCeVI4ZlJHY253YlFRRlVYNkNaUU83?=
 =?utf-8?B?UGNpclljeVZoYUJtazVmTGN6Q0lvMkRnS1pmOGhUTU9xcEJ0RGVTVmdDdWZ2?=
 =?utf-8?B?ZE9LQWpVcS80UkxiMDFlY1VrcTFsNUlOSVFtS0NQeHcrN05TZUlBNHFCMWFM?=
 =?utf-8?B?WFVzSU5NMU5uTkFFZ25iYWhuVFBwY2RLSEVNYSswdm1XV2tWS1ZMMFVzdm1B?=
 =?utf-8?B?MkNLK3dIeWh1V0l6YS9BUTJ4YjlmVkVBWVE3VllQYmdpREpHSjI0c3MrTnRo?=
 =?utf-8?B?T3RIendFV2Zad1VDVDFtdVVwMFhSL2NwK2YzTDJyMGpzcHlhcmJGM3RSbWJS?=
 =?utf-8?B?eDdzUHFZcE13MlN6VTFXbGFzMTlMemd6aHZaSFFlRm42cVgxREdHbzdVZitC?=
 =?utf-8?B?MDNHSDR1WmtJNW1XMDNzc2dIaDlSMGFQbnh6bHlpUEM2NE5FNWJwRGJ2bVQz?=
 =?utf-8?B?MUk4WnRRbzR6dFgyQytQM3Z4VnA0MlRzTnYrMmhlQUUyNDFoOUx3VUpsbURl?=
 =?utf-8?B?bTVpa0YzZTFiMS8xejdSQ1AzcUprbVE3SlRYVUt2Z1NGRFBpWThnNG8wM0tF?=
 =?utf-8?B?ZHd2dXY4cyt2Z0xTUmNETGJ1MEI4Y2cxdlQzYmRJWlZkNy9rM2xNeFBvU21j?=
 =?utf-8?B?TyszRFBUNXo1WWtIWlpuNGpDVTZYcWtVT2U5ek5mMHBPZHkwQzMrYmF6NHNo?=
 =?utf-8?B?TGVMekVRRG5XRkVuY0RlVkNKY21pY2lrWmc5aHMwaUZWcmZvVU1rZzZNL29D?=
 =?utf-8?B?NzdOT28rT2VrSmRoM2RGbHhKVjFvSW50ZVdtdE45aUgzZ3dHNS9IQ3FEdzJQ?=
 =?utf-8?B?bmhhS3lyQnBhdnlmR1BYa2laNXo1ajZ4Tnl1WWMzR0FjdGpzSVBYWlNZMHZ3?=
 =?utf-8?B?SUNLOHBoZXdkek1tMm1vSEFjRHlDOFRPZFZrNi8zcUJTWWxxS3RtYkF3VkZq?=
 =?utf-8?B?RXRrdmRTbEdvSE9oSXFmOUEwOW96NEdlTmw0b09WK2RMbUlCZjdQQlR2WG5o?=
 =?utf-8?B?VTR3cjBBVlhHUTVZaXN2VC9IRTNOVVgrTFA3ZlVhTi9kWUNGWkRWaTAwbXdE?=
 =?utf-8?B?djhRdExDL2c2Mmg0YmIxUlBrajgwcVVLVG16MENnTmtJQmV4cUo3bkt6S0xC?=
 =?utf-8?B?UkJKeUgxOWpGUndjNjJxdWVITVY4Vk1PdFc1S2xOY3RkOUhRQ2lsUSswd0ZT?=
 =?utf-8?B?bTJMTlBXZnpHVlhabTBwZmFtZFZQMmIzUW1UejFDWVZqOWpyNjNoRWNWdHpJ?=
 =?utf-8?B?MmcwVE1mWkxPME0yd0x2WXJpS1oyMFRpTzdHbHV6dVhNUkZtNWNLV1l0VllI?=
 =?utf-8?B?cWpIL202emhnUjczcEFiRlNsbUYvYnBhTW9ZMCtXQlJYMHhvajk2RUI2YlNV?=
 =?utf-8?B?OEo1QjN1MmNoNzJtazZLVWZDazQ4WEpYR1RBRTd5NVVEZFdaRWlvWlRBZzdQ?=
 =?utf-8?B?cHdGb2FlOStyYXFBNlh3eEhleFptcVJibGhoSyt6cW91aHNZS0pvRndsZ3I1?=
 =?utf-8?B?U2ZGSDRiZE9RTjFneWVBQW1PcTkrVkRTK2VxOGt3TEwxWWR4VFkwWGZOZU9Q?=
 =?utf-8?B?aVplcEdqTnV2dHpVYUE1L1IxcVhjQjllZ3RBOEVJWE5MdEE5Ris4eFh4K2Y0?=
 =?utf-8?B?N2trbWF3WldGR0xLOFYyQThFQ1l0VCtlNmdpWlVwOUowdzBVUE9WVUR2QjdM?=
 =?utf-8?B?SUsxR3lqeVNXWGlmRXFCOVhOUGpCK2ZWdlpsWjNlaTVJaURHUjZIVUFMQ3Fz?=
 =?utf-8?B?RlRiTGVteVJFRkZXa3VOb0xHU1NVS2pJeWZPbVFzMUdVVS9sRnZTT01iaTQx?=
 =?utf-8?B?c1kybDhNYmVaY3lIa1FmVXU0M2ozVVF2Y3g1WUlFVXVoVlZ3R2Z3elVrSzli?=
 =?utf-8?B?RHN0UlRxNFdvVzd5N1BqYjhST21SM0duOTk0cTk0VE8vUG9WQ3VxelFqbmw5?=
 =?utf-8?B?R2ovY2F5SVVPV1k0L1R3aGZiT1BnTVVZc2E4M2dhUGJpUGRWTTNHR2xoYjlj?=
 =?utf-8?B?UnhMdzN6L0NETmRVeElWQlhzOUVzNks0dDNYY0RTZkVwOEc3VUcxdWpOL1BN?=
 =?utf-8?B?dUhBTlJHLzkwRDZVRHMwQUlla0VSNU1BOFN0cldxK2t3VnpEZ3lueDFrK1Bx?=
 =?utf-8?B?Q1lrWEwzbE81QTFCaXRENFdNVU1CRGc0UFVrTjdZcVNyWnMzTS9waS9WcEhy?=
 =?utf-8?B?eWdkMlp2QzBaRTM2ZkVNRFkwbW5DTldoLzJXUXo4VE45MEV3UEVhcHlzWXBI?=
 =?utf-8?B?aSszbTVzMDJIYzFIbHVpS0ZuTUw0VmVMaXZwTGJLQWdUaUUxb2NGenZ4NTEy?=
 =?utf-8?B?dEY0TXJ5aW1JaHhlYzh2NmV5VmV6QTVZOTlDQmlBTmliL1FhWkdWTFgvL3Ry?=
 =?utf-8?Q?CulfCQKzlIyqpDLUAqXw9Mx4b78awdSZlXm7T?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a56e41-447e-49db-5337-08deb1845bbd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:45:17.0247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/eXncsr177W1ENT+QPqlnaQ2gtz/NVYA2nP9yxPzqmuqqD0w+AhN/iqOZGUNoPifVQSmmBYJDGLGzeSe6lY9ThikEnELsH6juqXmlK/eUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7186
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



On 14/5/2026 1:35 pm, Yuslaimi, Alif Zakuan wrote:
> Hi Tien Fong,
> 
> On 7/5/2026 4:37 pm, Chee, Tien Fong wrote:
>> Hi Alif,
>>
>>
>> On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> Migrate the legacy Stratix10 platform to use the upstream Linux 
>>> device tree
>>> configuration. This helps reduce maintenance overhead and aligns U-Boot
>>> with the Linux kernel's DTS hierarchy and naming conventions.
>>>
>>> This change improves consistency between U-Boot and Linux by removing
>>> custom/legacy DTS handling and instead relying on the standardized
>>> definitions provided by the upstream Linux DTS.
>>>
>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>> ---
>>
>>
>> Please add the change log for each version.
>>
>>
> Noted, I will add change log for related patches in v3.
> 
>>>   arch/arm/dts/Makefile                         |   3 +-
>>>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 158 +++++++
>>>   arch/arm/dts/socfpga_stratix10.dtsi           | 430 ------------------
>>>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 143 +++++-
>>>   arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 ------
>>>   configs/socfpga_stratix10_defconfig           |   3 +-
>>>   6 files changed, 286 insertions(+), 594 deletions(-)
>>>   delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
>>>   delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
>>>
>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>> index bff341d6118..2832123218f 100644
>>> --- a/arch/arm/dts/Makefile
>>> +++ b/arch/arm/dts/Makefile
>>> @@ -460,8 +460,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=                \
>>>       socfpga_cyclone5_vining_fpga.dtb        \
>>>       socfpga_cyclone5_ac501soc.dtb            \
>>>       socfpga_cyclone5_ac550soc.dtb            \
>>> -    socfpga_n5x_socdk.dtb                \
>>> -    socfpga_stratix10_socdk.dtb
>>> +    socfpga_n5x_socdk.dtb
>>>   dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb    \
>>>       dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
>>> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/ 
>>> dts/socfpga_stratix10-u-boot.dtsi
>>> index 3e3a3780469..a3b4c0564f9 100644
>>> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
>>> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
>>> @@ -3,6 +3,164 @@
>>>    * U-Boot additions
>>>    *
>>>    * Copyright (C) 2020 Intel Corporation <www.intel.com>
>>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>>>    */
>>>   #include "socfpga_soc64_fit-u-boot.dtsi"
>>> +
>>> +/{
>>> +    aliases {
>>> +        spi0 = &qspi;
>>> +        i2c0 = &i2c1;
>>> +        freeze_br0 = &freeze_controller;
>>> +    };
>>> +
>>> +    memory@0 {
>>> +        device_type = "memory";
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>
>>
>> make dtbs_check (Linux dt-validate) will flag it as a schema violation 
>> since memory nodes must not define #address-cells / #size-cells 
>> because no child node according to the dt spec.
>>
>> Remove both properties from the memory@0
>>
>> [...]
>>
>>
> Removing these properties will result in boot failure in SPL during DDR 
> init.
> 
> fdtdec_decode_ram_size() in lib/fdtdec.c applied #cells to the wrong DT 
> node, triggering libfdt’s default #size-cells = 1, which misparses reg 
> encoded for #size-cells = <2> which is the way to describe 64-bit 
> physical addresses and sizes ≥ 4 GiB for Stratix10.
> 
> Refer commit - 90c08fa038451d6d7b7d8711bfd829b61d64c490
> 
>>> diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/ 
>>> arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
>>> index ef0df769762..da19943ec3b 100644
>>> --- a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
>>> +++ b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
>>> @@ -3,47 +3,154 @@
>>>    * U-Boot additions
>>>    *
>>>    * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
>>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>>>    */
>>>   #include "socfpga_stratix10-u-boot.dtsi"
>>>   /{
>>> -    aliases {
>>> -        spi0 = &qspi;
>>> -        freeze_br0 = &freeze_controller;
>>> +    chosen {
>>> +        stdout-path = "serial0:115200n8";
>>> +        u-boot,spl-boot-order = &mmc,&flash0,&nand;
>>>       };
>>> -    soc {
>>> -        freeze_controller: freeze_controller@f9000450 {
>>> -            compatible = "altr,freeze-bridge-controller";
>>> -            reg = <0xf9000450 0x00000010>;
>>> -            status = "disabled";
>>> +    memory@0 {
>>> +        /* 4GB */
>>> +        reg = <0 0x00000000 0 0x80000000>,
>>> +              <1 0x80000000 0 0x80000000>;
>>> +    };
>>> +};
>>> +
>>> +&qspi {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&gmac0 {
>>> +    mdio0 {
>>> +        ethernet_phy0: ethernet-phy@0 {
>>> +            reg = <4>;
>>> +            txd0-skew-ps = <0>; /* -420ps */
>>> +            txd1-skew-ps = <0>; /* -420ps */
>>> +            txd2-skew-ps = <0>; /* -420ps */
>>> +            txd3-skew-ps = <0>; /* -420ps */
>>> +            rxd0-skew-ps = <420>; /* 0ps */
>>> +            rxd1-skew-ps = <420>; /* 0ps */
>>> +            rxd2-skew-ps = <420>; /* 0ps */
>>> +            rxd3-skew-ps = <420>; /* 0ps */
>>> +            txen-skew-ps = <0>; /* -420ps */
>>> +            txc-skew-ps = <900>; /* 0ps */
>>> +            rxdv-skew-ps = <420>; /* 0ps */
>>> +            rxc-skew-ps = <1680>; /* 780ps */
>>>           };
>>>       };
>>>   };
>>> -&clkmgr {
>>> +&mmc {
>>> +    drvsel = <3>;
>>> +    smplsel = <2>;
>>>       bootph-all;
>>>   };
>>>   &qspi {
>>> -    status = "okay";
>>> -    bootph-all;
>>> +    /delete-property/ clocks;
>>>   };
>>>   &flash0 {
>>> -    compatible = "jedec,spi-nor";
>>> -    spi-max-frequency = <100000000>;
>>> +    reg = <0>;
>>>       spi-tx-bus-width = <4>;
>>>       spi-rx-bus-width = <4>;
>>>       bootph-all;
>>> +
>>> +    m25p,fast-read;
>>> +    cdns,page-size = <256>;
>>> +    cdns,block-size = <16>;
>>> +    cdns,tshsl-ns = <50>;
>>> +    cdns,tsd2d-ns = <50>;
>>> +    cdns,tchsh-ns = <4>;
>>> +    cdns,tslch-ns = <4>;
>>> +    /delete-property/ cdns,read-delay;
>>> +
>>> +    partitions {
>>> +        compatible = "fixed-partitions";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        qspi_boot: partition@0 {
>>> +            label = "u-boot";
>>> +            reg = <0x0 0x04200000>;
>>> +        };
>>> +
>>> +        root: partition@4200000 {
>>> +            label = "root";
>>> +            reg = <0x04200000 0x0BE00000>;
>>> +        };
>>> +    };
>>>   };
>>> -&sysmgr {
>>> -    bootph-all;
>>> +&fdt_0_blob {
>>> +    filename = "dts/upstream/src/arm64/altera/ 
>>> socfpga_stratix10_socdk.dtb";
>>>   };
>>> -&watchdog0 {
>>> -    status = "okay";
>>> -    bootph-all;
>>> +&images {
>>> +    fdt-1 {
>>> +        description = "socfpga_socdk_nand";
>>> +        type = "flat_dt";
>>> +        compression = "none";
>>> +        fdt_1_blob: blob-ext {
>>> +            filename = "dts/upstream/src/arm64/altera/ 
>>> socfpga_stratix10_socdk_nand.dtb";
>>> +        };
>>> +        hash {
>>> +            algo = "crc32";
>>> +        };
>>> +    };
>>> +
>>> +    fdt-2 {
>>> +        description = "socfpga_socdk_emmc";
>>> +        type = "flat_dt";
>>> +        compression = "none";
>>> +        fdt_2_blob: blob-ext {
>>> +            filename = "dts/upstream/src/arm64/altera/ 
>>> socfpga_stratix10_socdk_emmc.dtb";
>>
>>
>> This file is absent. Binman references dts/upstream/src/arm64/altera/ 
>> socfpga_stratix10_socdk_emmc.dtb.
>>
>> If those source DTS files do not exist in the upstream tree, binman 
>> fails with a file-not-found error at image build time
>>

I will remove this in v3 while waiting for 
socfpga_stratix10_socdk_emmc.dts upstream on Linux side. I will 
introduce a new patch to enable eMMC on Stratix10 once this file is 
available

>>
>> Best regards,
>>
>> Tien Fong
>>
> 

