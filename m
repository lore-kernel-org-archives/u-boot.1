Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05B5CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 05:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C55A80F0E;
	Thu, 14 May 2026 07:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="X9X7yWuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D275B838BB; Thu, 14 May 2026 07:43:29 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B9E8056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 07:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+hwkxr+EP/vzIKioIY8bCMloBCdyWpis+HrED5SSWwUbNazlNwUoSQgTqIfy9y45q2a2icp650KkLbFY4eS6WToKGUlRznFthYypgp9AwfMTqEV7PoquGmCxx0Gj1ZQKDZQdHgDxpOLBJWTdX59Ewf5CVQLxdGCKxrLYWzmvwxDjFKG6tH65XuPskxx9QM56tW7Tz3SMBAPNvBu7ce3SNHfWS5qb/b/jrHUy1gp1CZkiIcvQOdMAvXI9VXTPbDXoqrk5WhbNoZk0bCywertqGqpf/NBn+JsJXXJp7ceyKzJl/a2oWnbobyJc6ZC7C/DfCQg2x1bZneTUP9f+LCM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVnHbF8vVlahUX6h++5bkH4TCPbFjymhAdvSjtdD1Ow=;
 b=dk/XJ4UpuXvvVgDt2x2Wo4xbs1c+3/b+r0rE7yMvBcAqLRv67zuzndYCYuPmvFDUDB66hwOYxnQFmhYMhRkgqG7aHd74deYljx9QXW/CxTUfD9MVW1P5fBsL87VYi2yrlOy51u5509PPye1e6CygbyrIgmjUiT5u5EvBpijDVEceJ7TcWYGCcqWDXa8oT+5BG1a2rZLqjusmL5D2SiiHzuSk7qbZxNW06DCjqBlmjqisWnMbbKWstgOFFSlQoVHxWIZ439Pkyhx/UARXK197Ab6liWeAZPP/0ZoGABJyelM81l4zBW27N3VY1SSOCvddSFCXSewzu2NqKqpfBFRLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVnHbF8vVlahUX6h++5bkH4TCPbFjymhAdvSjtdD1Ow=;
 b=X9X7yWuoh8wZmdL+tn962LVHAPDwDuV87HhZ/YHvfDYkMBoZEly8lQV/7QAn33O5scrNY97Erzn4dCDdaGHvkTjDpI3I0Q4vk2BN0EihiumzOZb2bER0LVAisIH5rAdn7HvRCjb+2hq7eOAOKN/RDWAnD2GSA1BG9aXpw4UkM04jFjsbzCI2C5Lh+w5zDRKrEBxx/jROAuPUVobQxHuc9wNhkv3o+fjcEdJsJKHSuYPSN5+XB/Imvo1bXLFJk0s/O7LCb5ZV3bisNptPsU27NGyAApImk/o9S02cc1pMTt0KFvkDTjNsPzsvV1W4Vc6HHWGWde6t0zuzgzQUDeBZzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DS2PR03MB8465.namprd03.prod.outlook.com (2603:10b6:8:32b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:43:24 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:43:24 +0000
Message-ID: <fd344893-b87f-4e68-b9e2-2519bf482ddf@altera.com>
Date: Thu, 14 May 2026 13:43:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] arm: socfpga: s10: Enable system manager driver
 for Stratix10
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-6-alif.zakuan.yuslaimi@altera.com>
 <3f9e5302-2a58-4840-b304-41ee43926b34@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <3f9e5302-2a58-4840-b304-41ee43926b34@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DS2PR03MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1d2dc8-ba48-460d-8f82-08deb17bb715
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|55112099003|4143699003|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dZWaztsE6BivN4iuWFxDDLa4ScnOlRc+YEq3gQ3pel04xnpQQbpsFg7rmC+2NmGUW3CK4xPJr/uynRWjaIUjovLIxciIoXV/Heaj1/FeMYw1MpwmbetTKjEx1m2JFCQ9UJzZCmt/e6afG+l+c2AQeVetA5FYwjRqAtM4o/Hj35xPqJDSJHyNI4xKdQURZchjv5kM5OIhjVf/2TZURyZLhuwMHXbasIWu+/a3x54m7AUn6oH5rBMMGvxEvM9VhZMF5ZAfn65f6Yv0njNQfYceIf0uDw8MGQpRoAORs/jJsVouEhwzJUqbVTHgRHDdHAOUgxu8iFGPcYLTHbJdUDYsEtAND9Alqj5W3qA+GXQL2/HzF2Io9WZH33xFpwBfX3xAom6XR1yam4F4q50gCUj9ct/3TCCIxzkvvbYe1PBzYyic3Mkh7IkdLsDJJ6tlAMl8Us3+7fd+2E653Ux+9oI8Fw2gNRy2pN1Nu6lHgffbyI68Jv+hrZ0f8dtpCX00sGVaZoCkvjrfcRr23i+iTLHY3ldOhlHPytCVUmEk0dhIYesKN9BEATvXLvYtfasSXfVeUg+DAOWmbohX3azIQHhSJdQW+tOsbg7M+tqb3qj4OGPExavQsWgJBRqv+J6d7J5tg6OaWQ6ajOpYOh0t0cdH1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(55112099003)(4143699003)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdNSjNxclh4bVhtVWhzbXJDRXVqb3VtME14NlFDSVQ1RDBzU0FkZkhrc1N5?=
 =?utf-8?B?bjNsSTIzUGtSaGQ3NHVadGZSZ0RCVTl6VDJ6QnlMZFU0S3BNYXZ0d1pGT3pz?=
 =?utf-8?B?TVM2SUs4bWlybkRRUjlaQWpHYjQxQld5V0dOTGRWSExMaUo5eTd6QzlaU1N0?=
 =?utf-8?B?NFpuVWlXTjFDSml5SHRuTWhZMkdPckdHWmtFSkV6TlI0cDk5Q1ZiQXRFQ1p3?=
 =?utf-8?B?VkdweGFVTDNTL1JQbnlYc1BXczdWaS96SFpaWGo1Y09oMjRXR0VSNVBWSW00?=
 =?utf-8?B?MzFCSTZYWVAycFh2SjRTMjd5S1gxTktuUi9QaXNKRDVBUFBRZm9lL2JkQjh6?=
 =?utf-8?B?dFo2Mld1bUJ2bWFEOEtITmk4ZjNFRHVpcTN6VEN6c3pCSnFMMm54azhVTXFy?=
 =?utf-8?B?VG00NUpMRXI3UjdGNUlITUxIQlhFTUI1eEJsRzZhM0RZNlh2a2tBWktMVi9B?=
 =?utf-8?B?cGczYTVpSWRveFlzYnFmd2dRaWk2M1dNTG9QaDRSd1JXeExjb2FpQ0xPbERL?=
 =?utf-8?B?VDVVcjdweUhtRzdCMlV4b2JlblVKcEdCNW5CVTgra2k5QVFROTNpWGJoT1B2?=
 =?utf-8?B?MVpRL3p6QUNLbktKVGFXY05NdWZwR0o0NUJka3VudkoyRDNpbTEybzNjcFc4?=
 =?utf-8?B?MlNQL1E1V3F2am96WUxVZG5rMndGa2xua2Uvd1ZabnNKcWRkb0RWR01IRzc2?=
 =?utf-8?B?ZHVXdjBpSWIraUxGQ2VmTWhaOU11dUhPQjhzSmxOZ21ibGJvSWRxYXhYdWVa?=
 =?utf-8?B?ZzdNRHNSVFNvem0wZWhJK3htUjNLUXFWWklQK3pxSzVTMlpKRkJMbkliVi9I?=
 =?utf-8?B?eUlKTzMrQmZRVkc3cGYzNGF0OWo3aEljdUNaaXdib3lHNEtHK3NBR0szZTJP?=
 =?utf-8?B?ZlIyVEZ5YmJuZm1BMkVlUWlSblk3RkZDSVZUSnE3bi9MQkV4TnBWWVZjUzJF?=
 =?utf-8?B?MDZxTDAvZFR0a0hTTzdwSUI4Q1pKZm1WQmhIUHFHbnpwc1RLOG14aGtNaE1p?=
 =?utf-8?B?bS90ZUpaRVVSNmFudy92bG1DWHpCbTJxdHBFanU4UTZZZDRoekpMTllmc0FE?=
 =?utf-8?B?Q0w4WHpPYlM5S0ZwM25JUmZnU2pnK1hFTGJyT1BVU29TbXlLK1NkMHM1RWZx?=
 =?utf-8?B?OVZrRjJyNVlXcW1CMnQzM2Zveldxajd2a3VER1JjOW5VM3lTTU96RkVNSHU5?=
 =?utf-8?B?QmwvWjgyTU5HMDJyb3prZDN0cDI2NzRHbDk4N2thdzA2WTFBNnZITU9Mam9Q?=
 =?utf-8?B?ZXRuT2RPb3NQdldCc25YR1R6OG1RRHlXM240OHpad2NCSlhxdmJ3dHZiTVlM?=
 =?utf-8?B?bHVBVjJlU3RXWlJyRjl1TXBvWkVzUzhDUFdXS2xlV2JuQml5dDVGSVBHU2xD?=
 =?utf-8?B?OCtNS2NZQndpU2NQUXVDVmlUSWdDS3VsZzVrbDdUSUVlR1lOaldRMUJSZDUy?=
 =?utf-8?B?NVE2ME04ckVYTzJsSWErTDV2KzhjQ3pWeUFjaEN3WXJON1duQ1dSRDVWR1Y1?=
 =?utf-8?B?TGp1Q1FtZUhUaCsybkZJTHNISmZWQWlvNzFoUnVNMEF6QVVaTjRwUXI5UUdn?=
 =?utf-8?B?WTZDNUxFdk1xeDlPZHN5bWc3bUhleWRvdW1IZGFvbWVZdG1CZ3hDTVJmdXpM?=
 =?utf-8?B?bFhjRUZqN0VLT2dZM1QyaHdJSkpFOTdMQm5FSTc5aTd1Z1FGOUg4blF6WHM1?=
 =?utf-8?B?K1NJVFNoZXNzcUNkVW1jdmJUS3JpTWk1Zy9MUTJDNTZheDlTN1ZjSGpvTGtR?=
 =?utf-8?B?b3JYYXpyckdkVW9Sb0VHWTRQbWN4cVhoWStxa2hhN29tRkJvaGRNUDg4Z2tL?=
 =?utf-8?B?dlk1MndRcDZUZzczSEI2U3BpeVpMSVpESktmRWhyS3psc1JMRkR1L2JOVzBk?=
 =?utf-8?B?ZmZtdk5OM1FDbk12YUJqTVlsNnVQVWMyZXJSUjN3UzlOai84TnNwYXc1Nkk1?=
 =?utf-8?B?amd0SGNnRVBoTjNadnpNQStVYkZkblVjVnpzYkZIVVFjaUtpaVhwZ0hPcStS?=
 =?utf-8?B?NDNkUWdPaHZTRjNHR01aR2htOURPTnRtYTJFZzN4NlNrL1pocTBSdG9Pd0Zp?=
 =?utf-8?B?d0VPRWJKTkptcjBaNXh5ZklUZHE4dUUvVWxxUTJkOWNmU2F6VytJYkgxb0Na?=
 =?utf-8?B?N0k5cmtWbEV5Mjlscnp3WjBhcUJRSEdnMnFZbUU2enBsRzFZRXYrMzhKZ3F2?=
 =?utf-8?B?Vm5jQTgxbkErb3RmMW5vWEg5dDEwZi9YNUQzSnRrWGVhaDNMWG54ck0ySFJz?=
 =?utf-8?B?cXh4Wi9KendZaWRwVUZkalJOTnZaNHFlYU5DeVVDdGRITXMzQXhwWVhXSDZr?=
 =?utf-8?B?a3ZkTitGMmtGRDNtTUJrL2hqU2pvYjllRUNTSmV5VHJ6MEl0NG5YcitTbkxr?=
 =?utf-8?Q?xvBVjqa8f1VFBlQAVExx+tkUG5EX6E+yJFD8r?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1d2dc8-ba48-460d-8f82-08deb17bb715
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:43:24.6840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyfVjzybDsEA/R4Rh8tvRcQq3ua9K682ycbd7Xa4drdL1z4luZjWEgDJVh+k9ayIk8KOSRqZBmww5qGCni155RYw3AtGLPsFnx9UkYfvDbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8465
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

On 8/5/2026 12:18 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> The base address of system manager can be retrieved
>> using DT framework through the system manager driver.
>>
>> Enable system manager support for Stratix10 by probing the
>> system manager driver to initialize during SPL boot up.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   MAINTAINERS                                |  1 +
>>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi |  6 ++++++
>>   arch/arm/mach-socfpga/Makefile             |  1 +
>>   arch/arm/mach-socfpga/misc.c               |  3 ++-
>>   arch/arm/mach-socfpga/spl_s10.c            |  1 +
>>   board/altera/stratix10-socdk/Makefile      |  7 +++++++
>>   board/altera/stratix10-socdk/socfpga.c     | 12 ++++++++++++
>>   configs/socfpga_stratix10_defconfig        |  1 +
>>   8 files changed, 31 insertions(+), 1 deletion(-)
>>   create mode 100644 board/altera/stratix10-socdk/Makefile
>>   create mode 100644 board/altera/stratix10-socdk/socfpga.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 056902f6ef2..d1173126fc6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -156,6 +156,7 @@ S:    Maintained
>>   T:    git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
>>   F:    arch/arm/dts/socfpga_*
>>   F:    arch/arm/mach-socfpga/
>> +F:    board/altera/stratix10-socdk/
>>   F:    board/intel/agilex-socdk/
>>   F:    configs/socfpga_*
>>   F:    drivers/ddr/altera/
>> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/ 
>> dts/socfpga_stratix10-u-boot.dtsi
>> index ad4b383f704..89fa0e829f6 100644
>> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
>> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
>> @@ -13,6 +13,7 @@
>>       aliases {
>>           spi0 = &qspi;
>>           i2c0 = &i2c1;
>> +        sysmgr = &sysmgr;
>>           freeze_br0 = &freeze_controller;
>>       };
>> @@ -283,6 +284,11 @@
>>       };
>>   };
>> +&sysmgr {
>> +    compatible = "altr,sys-mgr", "syscon";
>> +    bootph-all;
>> +};
>> +
>>   &uart0 {
>>       bootph-all;
>>       clock-frequency = <100000000>;
>> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/ 
>> Makefile
>> index b6f35ddacc4..962dce67c64 100644
>> --- a/arch/arm/mach-socfpga/Makefile
>> +++ b/arch/arm/mach-socfpga/Makefile
>> @@ -39,6 +39,7 @@ obj-y    += system_manager_soc64.o
>>   obj-y    += timer_s10.o
>>   obj-y    += wrap_handoff_soc64.o
>>   obj-y    += wrap_pll_config_soc64.o
>> +obj-y    += altera-sysmgr.o
>>   endif
>>   ifdef CONFIG_ARCH_SOCFPGA_AGILEX
>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
>> index 1eef7893e54..418d7dfb572 100644
>> --- a/arch/arm/mach-socfpga/misc.c
>> +++ b/arch/arm/mach-socfpga/misc.c
>> @@ -263,7 +263,8 @@ void socfpga_get_managers_addr(void)
>>       if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
>>           !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
>> -        !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)) {
>> +        !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) &&
>> +        !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
>>           ret = socfpga_get_base_addr("altr,sys-mgr",
>>                           &socfpga_sysmgr_base);
>>           if (ret)
>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/ 
>> spl_s10.c
>> index ce1d5d4c8ff..b05bec2cbc1 100644
>> --- a/arch/arm/mach-socfpga/spl_s10.c
>> +++ b/arch/arm/mach-socfpga/spl_s10.c
>> @@ -48,6 +48,7 @@ void board_init_f(ulong dummy)
>>       if (ret)
>>           hang();
>> +    socfpga_get_sys_mgr_addr();
>>       socfpga_get_managers_addr();
>>       /* Ensure watchdog is paused when debugging is happening */
>> diff --git a/board/altera/stratix10-socdk/Makefile b/board/altera/ 
>> stratix10-socdk/Makefile
>> new file mode 100644
>> index 00000000000..416c121406a
>> --- /dev/null
>> +++ b/board/altera/stratix10-socdk/Makefile
>> @@ -0,0 +1,7 @@
>> +#
>> +# Copyright (C) 2026 Altera Corporation <www.altera.com>
>> +#
>> +# SPDX-License-Identifier:    GPL-2.0
> 
> 
> SPDX-License-Identifier appears on line 4, not line 1
> 
> 
> Best regards,
> 
> Tien Fong
> 
Noted, I will correct this for v3 submission.

Thanks,
Alif


