Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23928FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 04:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFAB842EF;
	Tue, 28 Apr 2026 06:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hXXU+DGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEC7842EF; Tue, 28 Apr 2026 05:37:06 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EDE84150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0m+aiuA2zej3K71nnQHP9r8pkD4jhTl5SrJz/QoqsXDPLgwCGAcQlIk1/P1n5fWqChqrt1jE1evd8YHmFegRnHQt87enO8luwyfIsrvVdUi4RcqzTEhBDdn3rbGwaNIFyO6/8gHrPPd3Vf6WNAk3bQ2G6OaE1l9kfjRcAd6cqzemmaHM+9/65hvcTTQq6wtgtbYuol6rzkgxp94FC3kghE2GCHj05XyKX24Z3Vr2VPzLXTtdDrcDcxcN1wBYPZSAv0Xw2M7RJ0pnP1ziqwyBZABFLuV/adz+9P2TISOPkwmTHtg/iV9M8W579l7xloiN1/c1rX4tjmXoqA656RxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok8IUTpWUnoOmJgLptp3XEjWybPd7GaU81S6i2rFP2I=;
 b=nW0ukF9a6WBlllwjpYrJpl2aWQICN0DXdGD7/n5wZrvWcsjF9PZ1A4fPRlQN4wqUnivqlJluWCybDnxw82i1t18xBAk9zBeF/psvQWZtLtomxWaS3rJW6WkYL3kPWcR8hNxH9J5w18Gyby2Mj4PKZulj0hP+vP44tf/ZTibBxz0oSiRyR3ByxJ0l2rfwt2g5dajN9k74lMP6AVLuwJxFNciGQmTHkcCdfkGw0vfeRgkuYDK3yTgsLzjxU80F3utDrC5JPOmc1axZDtOgE6gC+vlhcNgeX8aFkgNy6xgaUTUDIEnI09glim5bkAf2u3jCUqIveZIGcn4Y7U/QRT4W1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok8IUTpWUnoOmJgLptp3XEjWybPd7GaU81S6i2rFP2I=;
 b=hXXU+DGICQll5vJJDab8xdT5r3gW4MijdM6ht+tRkiOYwSrzNvWbzImcMSZu45OVm+Z7auT29Vazssjhv1ZJ6lVPoE5wVwF3wOj5krPDQGyEKeG/IUm8zy4w8FPg3Ti8mQOoeweVtLugw8RHpx4VtR7S8AMIKpe9OJVzvbXKM432ooVIY6rUW+jK3nRwMi39XLbiznwKXUk8bHm1kW+Me2CnrODdMm6mAUHOjQIrSeib9tjhTgMC4kkSoB1Z2Lx0jK1SN/iIVZ6J6RKP5nTAaL6PVIeokDd+S+B3FYDbymve1t4lU/vKaV/BsQIsZR90127sFnjLE3ZSJI9th1OjSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by IA1PR03MB8263.namprd03.prod.outlook.com (2603:10b6:208:5af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:37:01 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 03:37:01 +0000
Message-ID: <7ad7e158-d474-4df4-80c3-c616952ed2eb@altera.com>
Date: Tue, 28 Apr 2026 11:36:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] arch: arm: dts: n5x : Switch to using upstream
 Linux DT config
Content-Language: en-US
References: <16f2943c-7337-4a77-9ae3-f9d2dbbed686@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, chen.huei.lok@altera.com
From: "Lok, Chen Huei" <chen.huei.lok@altera.com>
In-Reply-To: <16f2943c-7337-4a77-9ae3-f9d2dbbed686@altera.com>
X-Forwarded-Message-Id: <16f2943c-7337-4a77-9ae3-f9d2dbbed686@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|IA1PR03MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 52da166f-2976-4aed-6118-08dea4d76848
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: o0h81U1qnAZA0Iqb5QEg26bRr8ScxYZb+O+ZMBz3cqM9rU2Mu1yEmskKJePfWmqJMCL9dy+0T5UjTCkky3KTbChDZtfmL3DW8ht0Ge0ismnuM9ldsbJ5mz34Ji9FWaLvwN01G1DyBTuu/NpYGQBnArPXIi53EynhAlqa8nsJQf5GkcZJlQp77BDTHtN9SRD29PxfDVup1uFyFLwhQ79Lj3VkdKzRve40D0Gdqig2bUFgY8d6Z5Dp07VC/VjJAV8Flx8COKoCtEr9ZIkOkVdpCYt2MLMi8ccTunFswRLn6CwLLlkeLke6ZAKNTvabSpC7ccqlg8Ki/+P3Bm0oBrXian2fAR47NThZvQ3GqnwveEBspAVSngNAmY3gmXFn5MLXHPVTScEVZuPWmRiw+3+oeQr/06VRluNcOXuS0sAb2G5lrgZaUf470EpiqaoWWRie0vxzGSw/05sFedcBMxKRXuh4qasWKKNbqWGPIxeeOoq5Q7jcl/T4M4fppqxPeQm1VQaxsZ8JGLZDFIyY4xEV8syz528FCwJcz9lprAJVAvn70oMBOHobfawhUhNkFcnSQ0gLFJLCZa8ovaF+nkDkcKzcq9G7l/GtWDg/Z5dz4ARXZF2VCL+ZTOyspNlqrhTHw9h9xwiQthXDvp6+9OT3GIEJSExe0CfujeNp68iAHAb4AqEulN85QLm1tVt47+884QzGuZg2+wPIJJDB396DSWeTEsIf0ZWSfoURyImM1N8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpJR2JGcTk3aUVxbTdHWU5NZlFtZitjQjdCcXVFbmt1ZDRRN1lXL2UrcWZa?=
 =?utf-8?B?UlBFUDBjSlFSTXBacG03aGZDSG53L25sN0I4T2ZjaldVSjAzazhSc2dwdGt3?=
 =?utf-8?B?VW02VXNkcmM5dk02M29pVklwdXV5MFEvMGpDb2VaWFQzVjEwcGxjdG4yMlpt?=
 =?utf-8?B?bktxTFVVaGJ4My9vdGhTdGpPSEV4N2tIR3ZOTkJ6Qi92dnpmZTdGVGhjWHBl?=
 =?utf-8?B?aGtVVkRwaHQwZUFlcmxjVmNycHpqbThhRnI0ejRqamFYSXFGRFVQTitmTllT?=
 =?utf-8?B?Qi9ROXNGMkg3MUovalBLNmJQeHpIZWdHUGp2aDVWQm9Yd2ljSWNUcTlYVjU0?=
 =?utf-8?B?dTZRWnFTUTFlTkRNTHdtOFBPZjAxOUpCZmhMZHpzQmRJNXQvcjNQaXJzTldH?=
 =?utf-8?B?aDdaS3FJZ1E5cHdTOVFnSVE1OHg5VFlOS29vZWY3THd6UGNLK2MwTmRPakFW?=
 =?utf-8?B?R3VPNFNnL29wR0FzOHdBSmtXa2hUaGt3ZTV6NWQ3YkVFcW9KSzNQNEJvY1dD?=
 =?utf-8?B?ZHNJWE9wVWpJc3B6TUJ4bGpVeG5mUTdHVFl3NjJHVUN6YlRuR1kxZVZLRmtl?=
 =?utf-8?B?ZlFUSnlxU2tmei9wa0ljTndNTE9OZjZoZWduYzBvMm4zOEprRjBQNTdNWW53?=
 =?utf-8?B?L3RVUi9zUnk1b1pQajUzd0FzaVkvRjVTaldkWE1DRVNTeklQdThqWkwyWE1B?=
 =?utf-8?B?YmoyTm9yZWlHOS9CMmtLYUsyTjcybDVXOExLNm9OcWY2bzJqSk1vbHpGOWl5?=
 =?utf-8?B?SHpCQWVYdzJnQld0MFJ0UjVxdlk3eXR0UU5Qd2ZSOTdKNVB0YW1tUS83N0Q4?=
 =?utf-8?B?YVliMHdsUkY5cEd2TGtFQlRKcGU1R1RiNzcxbzNtZ3lHYXJ2QSt3N0NCQ3Bx?=
 =?utf-8?B?ZVIyWjNRVG5hWmIySG55Q1VHSjQ0MHk4TVgyamFvUk52ZVhWOXF0dnBjRHNR?=
 =?utf-8?B?TlRnMUIzRURiZ2JJMHRyK09xK3Z4a2xEMFFGMGxvbGU4ZHppVGxtMzhCcDlS?=
 =?utf-8?B?TERvU01KR0JyeEh1alZ1bFdxYVk0TjBlWjcwbFl4ZnlkSm5raXlyR29yWGdD?=
 =?utf-8?B?UWwvUnpLWW5qOVArSmd6bnFkZGJkSzVZc1NLYVpDeCsxUm9DV3pMY0c1VjJE?=
 =?utf-8?B?dkQxbW8yUlN4RFN6RElMbjRDQXA0a0habFgvYWtjUE5ydWZ3RXk0bTBOS1hH?=
 =?utf-8?B?ZmFoUXUra0ZZNnM1Z1JGUDcwZCs0TjZZVXpoWVBwTk1vaStQS1VSdCtwQzRq?=
 =?utf-8?B?V1J5VER1S0l3bDBna055M3B4dzlkWCtEb3dNYXhtSEpacWtJZ3lxdkQrWDJJ?=
 =?utf-8?B?cmQrMWdreUlJc3RLRmEzd0pmN1ZWYTJ6dnA0Y1VsUDQySFdJWnVZTm5KdTRM?=
 =?utf-8?B?d05YQmdrUks5OFVaWmJUVEdhMVFYajVlUHlBYkYrMFYvS08wYUt3bnhBbE9M?=
 =?utf-8?B?MDRyUGJIcHU1M2VPRnc1R3VBVFRZQzdISjJUMUZRaWVPMGdrZWlKZGdWdGl2?=
 =?utf-8?B?b2hXRG9KekZvOVVqTGgrU3hqRlNUM0ZzMVVxc1p0MmMyUG5oZHJhVHJZVEJa?=
 =?utf-8?B?dUtyV05JY3FvMVlKbHhQZ082WE16SjdpVVpMbHpMdUtMWGFkNFd6eS9yQkUx?=
 =?utf-8?B?RENUd1dxM1dHRlRlbnFzUFVBZjVvZ3JFSHJFVTJ3NEZjQlArMlR6WjgzWVlr?=
 =?utf-8?B?S3F2a2RlUE9HSWhmbmpPRGVDY2pxdWdTcStDMHFqcm5MMHR0QzJReGxwZm9v?=
 =?utf-8?B?a2JKVDJONlo3dzRtb3FpZ1lxK1dRUGNvWUZoc3dxc00vRlIzOEswZ3pCYVRT?=
 =?utf-8?B?RnFMVnY3b2VYM1pDZGFaVHJhK0dFUlBNTnYvbjJhRE4vUEV4cUlLYTE1WUJs?=
 =?utf-8?B?TUZSN3NZNkRvTGRoNU1JYmVuZU14RFdwSTBUazVMWXMxZ2dSa3FwSXZYSVNY?=
 =?utf-8?B?MWp2aDliTnRPOExHOUFnN0JQSCtkTXlGYkJCYkhHVHBsQVF3aWVTU1FYcFg0?=
 =?utf-8?B?Z2UyYlBjNlQxaStwc1VqZW9hRCtJaFBHc2tHY2ROU2tuanM2ZEYwdmp6TERv?=
 =?utf-8?B?UDQ5ZmdjdjZQMFcrR1RoS1JhKzhINFJWNjhYUnc1aG5HVGtNU1R1YXpVQTdu?=
 =?utf-8?B?UUVnZ1BGVXQ5T1RocHRMbnlMK29pUTZ6c0kxa3RVVVY2YlltYjIwUTdMM1gx?=
 =?utf-8?B?SnVoV3NZTjNHWkRyWFp1NjBZZmdrTE45dFBTUDRRWnlSMGNuenJRVTFzN3k4?=
 =?utf-8?B?T1JCOCs4Z0o2d0IxNkNCcVB1eWhVcmR2a29pd1FvNmRTZG9IT3lPdDM0Tml5?=
 =?utf-8?B?WldrOEE2NXF3Mld6QmdrZCs5bVlEM2xTeVl0cHdKWU9Tbks1V1JaU1RjQ2x5?=
 =?utf-8?Q?eXBCD9elNO7TdIPU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52da166f-2976-4aed-6118-08dea4d76848
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:37:01.1628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MONVqlpHR7WI2gBC72aRFpXAzV2O2uYH0+XW4Ur6MiN26ovkjDyzCcCG91yqv0gePOhFD1G30tUtAKw1FO1HzUvSSWqMacFWI51haBjNe3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8263
X-Mailman-Approved-At: Tue, 28 Apr 2026 06:27:12 +0200
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

>> +
>> +&flash0 {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	compatible = "jedec,spi-nor";
>
>
> upstream DTS has this compatible defined, so the overrides is redundant.
>
>
I will drop the redundant "compatible" override for
&flash0 in v2.
>> diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
>> index bc2fb91dfb5..f013ed49cd3 100644
>> --- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
>> +++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
>> @@ -8,12 +8,11 @@
>>   #include "socfpga_n5x-u-boot.dtsi"
>>
>>   /{
>> -	aliases {
>> -		spi0 = &qspi;
>> -		i2c0 = &i2c1;
>> +	chosen {
>> +		u-boot,spl-boot-order = &mmc;
>>   	};
>>
>> -	memory {
>> +	memory@0 {
>>   		/*
>>   		 * Memory type: DDR4 (non-interleaving mode)
>>   		 * 16GB
>> @@ -38,10 +37,21 @@
>>   };
>>
>>   &flash0 {
>> -	compatible = "jedec,spi-nor";
>> +	reg = <0>;
>>   	spi-tx-bus-width = <4>;
>>   	spi-rx-bus-width = <4>;
>> +	spi-max-frequency = <100000000>;
>>   	bootph-all;
>> +
>> +	m25p,fast-read;
>> +	cdns,page-size = <256>;
>> +	cdns,block-size = <16>;
>> +	cdns,read-delay = <1>;
>> +	cdns,tshsl-ns = <50>;
>> +	cdns,tsd2d-ns = <50>;
>> +	cdns,tchsh-ns = <4>;
>> +	cdns,tslch-ns = <4>;
>> +	/delete-property/ cdns,read-delay;
>
>
> This is contradictory. Setting a property and then deleting it in the 
> same board overlay is nonsensical.
>
> The intent is unclear, if read-delay should not be set, don't add it; 
> if it should be set, don't delete it.
>
>
Agreed. I will remove the unnecessary addition of "cdns,read-delay = 
<1>;" and
keep the node consistent in v2.


Best regards,

Lok
