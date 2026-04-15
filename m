Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AC4F9D0CE
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 02:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E6F839D5;
	Wed, 15 Apr 2026 04:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uCjSIrHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E6D83B99; Wed, 15 Apr 2026 04:52:29 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60D180086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 04:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNz6kbkLVWNBdsIiR7a2aDQPAlDr3Fwemca1nCXcMfvcvZiRRh0S79I5k6lwtkCVz/r43MvFLoYaJjFdcA3271qKmrWDshyfTKdL+3fLpG4idnBJBZpej2uoDRLonNyIxOdvjGoa/zOLYGRBJWPVhEa7QbwNCZNf2YoEVYk+6Aa6KCmLW8oknERwoINsvF7DyPS2pjbFvjI2grEcoVDLV9rEOo5sffjCi2d6SX+l9VkGa7v7BtcQE6lWMXRnRWW2Gcr1R3BKtGEAhWmihJueoPGwVQsGofhPNXAhp1fnSQR3EiFo4YK0RO/4OeGFFgRL2sVMPOL5h+QlaNkJUkiPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DycvgdbabPjm5XDV3yg54OfYLBc6Ka44b6HMc3ZXbeE=;
 b=qC2uKTbk5vfo/b1Puf4/3GvgwZurmy55NqQuZGuTzMnE9gBTfBbvwBNbAJnAL+H6jX1cC9zWuGP7f+iQhyaDj+JWR1IpzoRlY1F9IYs4JnXIGmzxCMha5WLKYorviLw7gqTuY97GT3r/nzEicOiyovUPuxtF+vtU+RZ5CBq7zuJ85NtJmVRVx0ePqxUx4nukenz/MBrYfnY8fLgMiWOKVuIg+Q4O42Gz85Ck3ImVJ4fpa+xcIR72F9en5qBo2PHsuIyDB1rfuJ+KACgbAJ9ElBydRoEdXShaMFh2k725YxzjADFdrHlON3SEhiPDr6evXFS7FOLLTJXMnVkV1qv9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DycvgdbabPjm5XDV3yg54OfYLBc6Ka44b6HMc3ZXbeE=;
 b=uCjSIrHtSxPsMuXqPaTzsrAKnTstsSMJMUEl42l/RDlbTt/oySc3Rae9vVSFiqHYmUsjCF/C90zVtW3/pxEe0y3ADYyXgydGqvOcnGBZT5Vn5s0GWU2DR5s81OiuD2gtgiH6qjn/wV/POg5WZGgtVXswV38hyFkE35/mNkwKUTgfhezBPWXFWK5/RpnvkyOStnttKsqzD1GUtCu5g8D2zffAbAlLyNFTQ6GPyyWnFNst8OSuxAhqBM0rB+1gpsqqSwUC2UYky5pz1euAwnFR8V14cQGMB6ZWaTRmZi/IHXPUy6Q7U53tj3yEXlq2XvKLw38EXJXB0vhhfPbvJAbepA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB4949.namprd03.prod.outlook.com (2603:10b6:a03:1e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 02:52:24 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 02:52:24 +0000
Message-ID: <72ed82d6-45cc-4518-8e14-fd4718997f18@altera.com>
Date: Wed, 15 Apr 2026 10:52:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: clk: altera: arria10: Fix wrong API used for
 memory free
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
References: <20260225050110.14290-1-dinesh.maniyam@altera.com>
 <LV8PR03MB813786F6FD0FD268C1D9B6C2A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <LV8PR03MB813786F6FD0FD268C1D9B6C2A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: f4875fbf-81ba-4c34-2f52-08de9a9a0560
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sUp3QRiwE8F9vYq8TsEuRaIh1u16oQP48V0LdjrjRiQRF7mXHA+O0uIbILdDgffSKOy1ToO3r6kg7QdSCXyrbTK+XR4XU/mnArCfM903hw041Qea09mZg7Zfbbq4A/yyakaNH1oCAvWbQy4fVvAnrgJ3/20x5VB23ekTu3CV7YSlgXJtfhglflMEA+C7IpQE+1Z1fmF368hANlCfR5bVendDQs/5zytHlhoKNNNyth9EAJdxwm3+6GVmYiYeFLhdx/DfnIkCYLqO5r0Ih+5PC4deX3HPmO3XVGBOmbZXVx30WMWBqVXe7NMObw+peUGIT/cK41KmW0iMSuSLcrc+WVVJTspLsXpoo2NiLMSFl61+zfCsD+AACjBfc3fpgycN+1T5Sg/NA3VQNw/UPt+gCpZDSrF83VvNkOrJ3K8U0DZmkZYR0drnYaGX80Vo9kD4XglsWVOqoc0kVxsYEux4UNDnya/d/NAgkfRQaep96kIjH/jUckvlv7bSOHL2NVCVGmJa60J0qISszpfkTjd1DG6eKaRTrC7RyptMWL/aqjQb2RD8FOry/wcCPSxLs3usG4VxV8KINmeKSXowreKTKSA4ScM4/ssXVIRAbFCeHk6kdE4FoqlxO11xxLh/ut2sFnj9Yo1rgaAH+l1kViCEnhb6aJZnWm5WMc6i8+jZrvQlbzd9je2nlmwFLfJdQhxwIBnlXQ/+SSm30cZDjQ61owJjiWIxl1tFCkKHdw7Ia0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9yMWtaZzNHK1pObC9QZ1IrRDZOeDZWeThrYTVEa2tTNE0weWxKM05LY3do?=
 =?utf-8?B?TTFCU0hYaHkwZU9IOWx0SzlrcFdyZW9TOE43NFFLc3I3OWFrWnd3Q3FaN0JX?=
 =?utf-8?B?ZlFma3NWcDhtMXNkSDFaM3JoNkxUNG5iQ1lWM2VKUDhqWWN1L1N5bktsMEpk?=
 =?utf-8?B?OStZUDJiM2FIOXlMb3JNVjZHN1MzRXkwcGdHOTRBejdzbWlTcDFMeDY3WXVF?=
 =?utf-8?B?TUNiMzg3TmJDeDZqRzBnRTB2NGZuTC9JbjdGR1ZlMXRYL2pZOWgzRlYxQURk?=
 =?utf-8?B?MVZ1WnpQQUlzVEFJbEhFRnlnRGNTRy82b3dhSjNhc0NOS2hFeHd0QlpER1NI?=
 =?utf-8?B?NW9NNFpvMlRiTE5QUmJTQWtNU3Fpc24zZVRRR0czL21tWnZCOEJDQzZ1eXB3?=
 =?utf-8?B?YXBPZkEwWnFnVVdjZ2dNWVNyM3RDVDVNVHl4bDMzaGdvcE9leXRYazVpdUVi?=
 =?utf-8?B?U3pETXM0SVo1UDN5L2N6OXNBR3loakVNTTF5MTlHQ1VtTDJaUk5kSU9PTnRv?=
 =?utf-8?B?eFR4alFrU1NTaVplb2Vubm5NTmFicjdnaGkwbGVsRTJHWjdkOTJJaFRMN3RJ?=
 =?utf-8?B?am51UjRtVGlHVjFSajk0YUJxTjhuTUI1RjlpZGExV2cyQkE5U2lFcUY4cHBj?=
 =?utf-8?B?WTZCd3hFbWQzcmZWRWpRYllvYjZxSUo0YzljdnNjUUxCdGFHei9ZMXJBQTFF?=
 =?utf-8?B?azJESFIwNk9sYWFoU01CZldOc2c3VlVpMml0M2E1TUpjZEZmWnZFdldITEtR?=
 =?utf-8?B?Tjl0eG1FV3g3SGZBNVQ0bUJCNnlzTFQ4MjVTalBERUhHVkNSV3BXa0g5V1M4?=
 =?utf-8?B?a2J2a1h3WG5KWjVNWWdjdjNrNEFUS0pONFYvNzRvaGM4ZmF0bFA1OUMrcWJX?=
 =?utf-8?B?TENCVmxtZmhUd3BpblRvOUIxYnI2VTJvYTFtRHhNekRkZHJXM1dIeEg3bk9N?=
 =?utf-8?B?TERhc3VOVEdVbXJ0aWhHb2hSZ1F2eFFLUFlrVkNwcS9YeDVKK0U5Z1N2Z05D?=
 =?utf-8?B?MSsrTWFrQjMrV3orVFhqZWhkL1hLNzBOeHQwS1BDeVNmMEpVMFIxNFkzalcz?=
 =?utf-8?B?UW42WHdKQ1o5Skh6cFFRSmhxbklpcm5jRGdJTThvYmtvSDlEclhpZWNtVEM5?=
 =?utf-8?B?UVpTdXpIZDc0dk8rejA2Y25ISVhJVDRRWWR3U29YUnpJTWwwaWtQTmplODVH?=
 =?utf-8?B?WGZoeko0WWlPQ1Fxb0VqMmlQck1ZZm9IajJZbWI5Qi9HYWN6SVNMeCtVM2I4?=
 =?utf-8?B?cHF5Z3E5Z3NHaTFXZzhxK1IrWG1CMGxzZC9yZVJmSUI3YmNObXhvSEZxQ1g0?=
 =?utf-8?B?N2NhcEtaTldDN3h0ckYwSzZ4MWNVQnR1U29GWldqYWlQU2tubG1IQUp1MTly?=
 =?utf-8?B?ZzVvR2YrMzJKWGpLeGVRdHFrUC82YmpERzZ2b1RlY3JHREs1eWw3LzZXYXds?=
 =?utf-8?B?ZDlNdElINU1vSUd4bXp1WXJyWnRnZmNHWlVuMEFzSTBrRG8zQlZ2VTVRUTg0?=
 =?utf-8?B?Mk9RdjlZQTUwL01kK1lMVE91c1laN1V0eXhkYmlQc2Z6QlRCSGpuTThuaVli?=
 =?utf-8?B?Sys5R0FpdzJhVkw2ak1VUWpldnpuOS9nNnhFSXNPUjhkbzRUM0dyeTVEL09y?=
 =?utf-8?B?V01qd0RQR05wdEs2V1Jyb2Z4RWNHUVJjeWYyaDJzWFZtREZhcXUwcU9YR0VN?=
 =?utf-8?B?cllDbDFBU0M4VUJLc2ZiSHdJZWw1VU16ZER4OW1uOUovRTR6WDF4VGtIWklz?=
 =?utf-8?B?dGpPSThlMHM1cUVNNjg2ZWMrbG1mZVp5U1RWa3QybmJUMXVyenZaUCtaSEpT?=
 =?utf-8?B?b1lsM1VlRyszSDRCNnRJd2p5Ujcvd2pwVFBsd3drYmVTMWdLTEljb2tTbHQz?=
 =?utf-8?B?R3Q4ZUdCS1NjNTFTTDlQRTdWMDdxblBtZVduZHZ5NFB1WWc2M002bjVpYjlT?=
 =?utf-8?B?Nzc4MFptQkRKb1hiS0hzUTRHMndzYjREVjkwUG5Kamc0S1JQVHZLWGdodHRK?=
 =?utf-8?B?cnZ0YndZRHFZeVF0aWhrYU1wODFlSG9OcWdDa2hKZ0FhQzFnOCtZU2NIVFN3?=
 =?utf-8?B?ei94NU5nMzdLemRLVWFjRldJa0c0V2krRTV0cEVuekhiUjJwdmRYV0h6WWRY?=
 =?utf-8?B?TllVbno5M2krQzBTMk05UzhleW5adDU0a2QvZkMzeWNlSU9EYkQySUE4VlB6?=
 =?utf-8?B?Ky9CZklDRmp1c29QTWs4ZVB2b3BpUDNvaVFOM0ZwOEFsY3l2Vi9QMVoyWjZ6?=
 =?utf-8?B?MGlNQUlUUHhDN2xEYXJBelREdEwvRkJmazdkYk54QzNoWHlkMVc1azVxMG5h?=
 =?utf-8?B?VUVjWUVLY2E5eVNLZTlrTVBIdzNrVk1qbHBHNnJNRjdtT1lOTjdrYWcrcnNH?=
 =?utf-8?Q?ybZLcLbYBejNeSaE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4875fbf-81ba-4c34-2f52-08de9a9a0560
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 02:52:24.2326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51aEyXf1bZk4tcAZ9xCN7G/RV6GTxG8LRsugbhyZta1JQdiRCcsyR3UE6I+G55OBpTbpNoO5GWcfglaLHbAqdenHLDQfR08K+seg8olCV7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4949
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

Hi TF,

On 13/4/2026 6:13 pm, Chee, Tien Fong wrote:
> Hi Dinesh,
>
>> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
>> Sent: Wednesday, February 25, 2026 1:01 PM
>> To: u-boot@lists.denx.de <u-boot@lists.denx.de>
>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Lukasz
>> Majewski <lukma@denx.de>; Chee, Tien Fong <tien.fong.chee@altera.com>; Hea,
>> Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
>> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
>> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
>> Subject: [PATCH] drivers: clk: altera: arria10: Fix wrong API used for memory
>> free
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> Fix the wrong API used for memory free.
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   drivers/clk/altera/clk-arria10.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/clk/altera/clk-arria10.c
>> b/drivers/clk/altera/clk-arria10.c
>> index 1840f73beee..e56e94adae0 100644
>> --- a/drivers/clk/altera/clk-arria10.c
>> +++ b/drivers/clk/altera/clk-arria10.c
>> @@ -223,7 +223,7 @@ static void socfpga_a10_handoff_workaround(struct udevice
>> *dev)
>>           ret = clk_request(dev, &bulk->clks[0]);
>>           if (ret)
>> -               free(bulk->clks);
>> +               devm_kfree(dev, bulk->clks);
> you must still reset bulk->clks = NULL and bulk->count = 0 so nothing reads the old shape, treating pointer/count reset as part of “secure cleanup”
>      bulk->clks = NULL;
>      bulk->count = 0;
>
>
>>   }
>>   static int socfpga_a10_clk_bind(struct udevice *dev)
>> --
>> 2.43.7
> Best regards,
> Tien Fong
>
> Agreed. Changes will be done on v2.
>
> Dinesh
