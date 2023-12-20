Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4DCC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 233FB8750C;
	Wed, 20 Dec 2023 11:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5mLutxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C401487509; Wed, 20 Dec 2023 11:57:21 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED148750C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSCBvD9bfCbreUceqo8wO3nMHqvd1mYBpEf5Nz2014rRsjicchA2czfdb4n7cghnm2CUJWmGOnkTT72T5yU6pqxU9hPRFJMCaEEvYZ6qCp2tCsVfE8Z/vGNGeDSNUymawrGp6rRiK7obj7nA2nstnR2KLkwgsCkhuOcj4oDDU2g68DnQLaMgA+s6jyEJ/cPvHWathZFgv+BhhvwTtERW38sAGIaA9ILzDCsa+vN4o23o91rhw5HiH9mweFoWuVBokuIQd5Py6BgD0DlYu9svlG6G/nCr4jXQtJQwuCP3LXlwwIMMpJCzTPl4VYKPif6vuTZgsqA7iKeRnS8MMINUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1LhD+r//e3gkIVmRpO62n+BwwYPLXNVhga9XO9glfk=;
 b=a/jcoXCK7oHDt3QKSjAl3p7Z5zMLG39pBmjnQCUKPlKmSJG8J4KM5RvQ4SPYOMcUEJEhRazI/euzAi6YRVQff9hikFZBJzL7wdVdpUzplSaV1acWVWr66TOc13hJ4NwFUhyRIJpIF0abFlTyDqlw4zh2mVmjzhsXx/x3lqukiu+mBhX2uO3A7Rt/mxTNn26MjYQjNW4g+4trEJnI0m98SwQBEy7PUo+0fCuPI842ZSPmoq98w/Awn3jVvR5oYxXJ3Gu2LVIwBuxxxI+YxQcfM1OlRz61d7Mbj6vAn4LTUCsYmaZ6OG6iMQ/WRXcEHbej80Di3gaeCzTWj4wkN8q9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1LhD+r//e3gkIVmRpO62n+BwwYPLXNVhga9XO9glfk=;
 b=T5mLutxjFM5J610Ee04u8qg1y+D1jQXnfUz9z/s/Y077jeOaMmyKwWIUab/fZ0jrDUxarTmjRtJCu0RttpQMOxEYHF3qF7Y6yl5hhb6HrF1iMFi1/nI5RN/XRs7Z4zkV3ZVTDTo3C17m7duMaBx6vfWo8WQW2R6VQ7BsJN5ITe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:57:17 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 10:57:17 +0000
Message-ID: <f2221d44-cbb7-4355-b9a1-ecea47af62c5@amd.com>
Date: Wed, 20 Dec 2023 11:57:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] bloblist: Load the bloblist from the previous loader
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng
 <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-4-raymond.mao@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20231219211114.393193-4-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 40026147-9d79-4bdf-dbe0-08dc014a6e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqiuIlUThftvEE9oJeQLfxsPH4iZBOm/ZLTFc6JTipjXfbIS7zi0TYJr8YevtJysRZnKE8XH8eXb6tYNIprgta2qoot+9D9kH0A2vT18TH2l/dAYuFLiV6sefdOmyzeIIabRi3UOid1+jHCsQtyujW8CjvFxRfy432xCGEds9s2s9+MjjBu1aFtyYdGpmnJTAJk8g4sdrLLATJ9G/nski97xg1xM93lhTjo9BuQHa8S9ppBZ/l4QKwVS/g4idMAJWu44OrqGauDncs4h/eekXjZhAFnvT9gj3T6+C+rNc8be5PR/BsnolyZ+NqBIyUVoxO+9kQ9SkvXmTeulEr09xd3PppEs1H5iH3L8jBh94tAxFk4xS80inB4E+6yuceN1pWNKOKnOfIXNodvjp7sx/huX3TRBGStPjB/OaYNGO+0Gye6BEFRNjG5xPz9jZydbp7dJq88g/r/1ZnSZKspfoSNRVd/DKvDzzHsWS7s9pg40mQ4CWKyxp63ySheOa1YzjPEclc0qsgjBpTdc+5MXPQ8drKp0GoY2e3Kgyq7P5JgLWS77Dry4ueKSAUCp/ZAFPKM5szAbr0kP53vUC44F77b2Fc4o5nQ+xCZm7Dgej9WqNhDGrlJzBmhPu/Hy16r0b3ytd3FfJJxP/gFo6KPNpC4TwMgIDRZFJqmkEJ1G/6mZz1dtmNvJRN23TLkHKr7/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(31686004)(86362001)(31696002)(36756003)(66476007)(6512007)(6506007)(53546011)(66946007)(6486002)(66556008)(6666004)(5660300002)(38100700002)(316002)(2616005)(8936002)(83380400001)(41300700001)(8676002)(478600001)(54906003)(2906002)(7416002)(44832011)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEw4cWREMmpQQkw5RzZvdUVJSlhTRnB5SGdCRmZxU0orcmU0UzB1ckFlQVMx?=
 =?utf-8?B?U05vZnhkdmQrUHErRzZpYVNSdG55dXN6ZHZnMDBjaWRQY0xBVks5emwyTFoz?=
 =?utf-8?B?N0lldWtmUzNmYTYxM2NHOHBZV0RTZS9xblRIMWpyMTVTZkxmZDAzMW9LOFgv?=
 =?utf-8?B?bDBYMmpaN2N0Y3d1K2I0ODlzZDBjSFhKdnBzOU82bW85M1Y4bUpEU0x0Z1JK?=
 =?utf-8?B?V01za1Rjdm1mOE1ZY0Z6WjR1NDlUb1N4T2VFK3NmQVVYZnJFeGdzRHFUTzJ0?=
 =?utf-8?B?SWoyZXA4VW5WNytFN2F0OW5LMjVTbG15VlAzYWhBNXBpWjJlRkFrOFNUbENE?=
 =?utf-8?B?ZW1ENkc1R2VPWDBEV1R2N29aVTJ2WHUwZFY3dnpJdS9mNnM2Wk9QUjZXaGpW?=
 =?utf-8?B?LzNVeXE1K2lubXVaRk5tekRtUFVqV2xrNjB0T002Umo0OXZGRnhJM2hqZ1Rx?=
 =?utf-8?B?UytVbytxeUpMeklYbFhjV29hV2dYU0Nud1BrRENGTUk0bnppbW9iM2pvT0tL?=
 =?utf-8?B?bUhzQWg2d1BlT1hXbVJZTExRNkluR2ZOeU5pQ09ncGxLYm5haDJpcmVUQ21C?=
 =?utf-8?B?TGVIRytxbmNDUkRZRHM2dmU2NVFQTkJkeStoeDdwcWVTaUJwQjQzM242SWM3?=
 =?utf-8?B?azRQb2p3TEw4Wi81b3c0SlNUbHRKRmtiS1RSUlVyakhWb09LbGRhMHIyclBB?=
 =?utf-8?B?T0l1Rmw2Mlg0M0RGblpta3diSU5ocE1QcXRaMkhRUHduUHpXbWpIVzRQREsw?=
 =?utf-8?B?QzJENzZrQnIraDVNdEY2cUVOaVJBR05DcDRBeGhsa3pqMjhzY3EyZnpqOENW?=
 =?utf-8?B?bkpLajJMZUM2RThQWXNYR1ZuR1gwUTFGNjVFNGNKMGpaYXhsOEVkSktYOW13?=
 =?utf-8?B?aGkwdms1MHNwNWF4V0RlY1UyeHhaeTgyZTZId1JsTVdNLzVhSlVKMmRpZ3Js?=
 =?utf-8?B?RERtaVRoYnluTlhvY3Bpd3VlSHJFTEV4Q3AxNituK3h5ZlhQVlJ2d21wS0h2?=
 =?utf-8?B?a2I5ZHNNalI4WGFoT3pSSUJuZEs4eEwyV1daYk9LRlNRQ1R1Q1lNK2k4RHZ4?=
 =?utf-8?B?QUNiR0l1aXlIckg3MWg3djJidTVWd1VzU1V2VmJpbGN2L2g0NmIwWlkyQjdo?=
 =?utf-8?B?UnlMMWZ4bHdqalE1ZHZ4T2ZyUmFFeFFQbXpMVFlwczhFbjgzREc4YzRKNXNh?=
 =?utf-8?B?Qk5MblJaWkovcW4zZEE5ZFRyN1ZrNDdZZk1hV0JEYUtQbG9Zajl6cFdTWjUv?=
 =?utf-8?B?UjRnUExOd0R4ZjBBL0ZOUFlubC9xbWgwNlZQaGFnalJnc3ZXV3Rhc2gzVEJt?=
 =?utf-8?B?clRkR3NEemswcWxhMHIzcDVrdzR1ZXNZYnJaV0JGbm1PQzNxcnVHZEpTNFR4?=
 =?utf-8?B?ZW10MnhJNTBxY2FqWklsbFJNSy94OXczT01LemNRRzBHbjJJdTZxcDZBQ1NF?=
 =?utf-8?B?ZUphRVc3UnUxbnBycDJ6QVZ1TFRIZCs5YWlhaHNIVWtFcFpPSGoxSHlmYUQ0?=
 =?utf-8?B?M25VMFBrb0diVit1SCtjUXdlYmdlanJXM0p4VFNaSlRlWHZzTk1JdmFCVUZN?=
 =?utf-8?B?T1RVclhORHN2SHIrcWdxcDlNV0RwMmMrN2o5elAyM3hpSGEvcyt3WHNQWFJo?=
 =?utf-8?B?UEM1T2RkMnQvRjBPNkNUSkZXQ1NSZDhHN21mRE4wVkhpWnhwQUFVb2FFMkRK?=
 =?utf-8?B?KzJ5SlVkTXVyZGZGd1RyZkNpaldieDRmSnlkN01uNHlWb1ZyRlVxZVppdHZE?=
 =?utf-8?B?eituY2tuSU83dVhhdE0zOUxmMWt5QVZ4bHk1L21ER0VYcit1Rm5EeG85TXNL?=
 =?utf-8?B?VHRxMWlGU1RBaXl5T1JmWnRZMC83eE5WRlZHMjFFR3J4c29LVSszZWN6aC9j?=
 =?utf-8?B?Ryt6am9vbG9ESXJYWlpVOUJEVzhyNUhwZzhaR3FrQWNkWW15MmY2bzFjVUZC?=
 =?utf-8?B?Tk1iS0ZDTVQvVVlhVXQwaURQTG1GWXRQSi9Nb1g0TDJSSlRlendyZEg3Y2pN?=
 =?utf-8?B?VDZqRStuT2xEelFoRW9DWjdIMDAzZXBzTWYrcFlGUy9Ja0xmN2dwWGVwdnUr?=
 =?utf-8?B?QUdiZlA5UGlUTUpPa2dscTlneDNsTmsyRzVKZWMyUDlNRGxTQlFKM3kvNUtp?=
 =?utf-8?Q?Iqm4auLr1OosO0rPk98X0FHPO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40026147-9d79-4bdf-dbe0-08dc014a6e2d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:57:16.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkCRUTcQtbL4+O+vjPiNSvfoo1F6uKaLi9Hi7y+uqdMDaQXt/y9pqcE0nFAs+8IZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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



On 12/19/23 22:11, Raymond Mao wrote:
> During bloblist initialization, when CONFIG_OF_BOARD is defined,
> invoke the platform custom function to load the bloblist via boot
> arguments from the previous loader.
> If the bloblist exists, copy it into the fixed bloblist memory region.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   common/bloblist.c  | 47 ++++++++++++++++++++++++++++------------------
>   include/bloblist.h | 16 ++++++++++++++++
>   2 files changed, 45 insertions(+), 18 deletions(-)
> 
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 232ca4c6ce..c89f7a1554 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -486,31 +486,38 @@ int bloblist_init(void)
>   	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>   	int ret = -ENOENT;
>   	ulong addr, size;
> -	bool expected;
> -
> -	/**
> -	 * We don't expect to find an existing bloblist in the first phase of
> -	 * U-Boot that runs. Also we have no way to receive the address of an
> -	 * allocated bloblist from a previous stage, so it must be at a fixed
> +	/*
> +	 * If U-Boot is not in the first phase, an existing bloblist must be
> +	 * at a fixed address.
> +	 */
> +	bool from_addr = fixed && !u_boot_first_phase();
> +	/*
> +	 * If U-Boot is in the first phase that a board specific routine should
> +	 * install the bloblist passed from previous loader to this fixed
>   	 * address.
>   	 */
> -	expected = fixed && !u_boot_first_phase();
> +	bool from_board = fixed && IS_ENABLED(CONFIG_OF_BOARD) &&
> +			  u_boot_first_phase();
> +
>   	if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> -		expected = false;
> +		from_addr = false;
>   	if (fixed)
>   		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>   				      CONFIG_BLOBLIST_ADDR);
>   	size = CONFIG_BLOBLIST_SIZE;
> -	if (expected) {
> +
> +	if (from_board)
> +		ret = board_bloblist_from_boot_arg(addr, size);
> +	else if (from_addr)
>   		ret = bloblist_check(addr, size);
> -		if (ret) {
> -			log_warning("Expected bloblist at %lx not found (err=%d)\n",
> -				    addr, ret);
> -		} else {
> -			/* Get the real size, if it is not what we expected */
> -			size = gd->bloblist->total_size;
> -		}
> -	}
> +
> +	if (ret)
> +		log_warning("Bloblist at %lx not found (err=%d)\n",
> +			    addr, ret);
> +	else
> +		/* Get the real size */
> +		size = gd->bloblist->total_size;
> +
>   	if (ret) {
>   		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
>   			void *ptr = memalign(BLOBLIST_ALIGN, size);
> @@ -519,7 +526,8 @@ int bloblist_init(void)
>   				return log_msg_ret("alloc", -ENOMEM);
>   			addr = map_to_sysmem(ptr);
>   		} else if (!fixed) {
> -			return log_msg_ret("!fixed", ret);
> +			return log_msg_ret("BLOBLIST_FIXED is not enabled",
> +					   ret);
>   		}
>   		log_debug("Creating new bloblist size %lx at %lx\n", size,
>   			  addr);
> @@ -532,6 +540,9 @@ int bloblist_init(void)
>   		return log_msg_ret("ini", ret);
>   	gd->flags |= GD_FLG_BLOBLIST_READY;
>   
> +	bloblist_show_stats();
> +	bloblist_show_list();
> +
>   	return 0;
>   }
>   
> diff --git a/include/bloblist.h b/include/bloblist.h
> index b5d0f147f6..f5c623133d 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -445,6 +445,22 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
>    */
>   int bloblist_init(void);
>   
> +#if (IS_ENABLED(CONFIG_ARCH_QEMU) && IS_ENABLED(CONFIG_ARM))

How do you think that others start to use it?
Adding that platforms here? I don't think it is scalable.

Thanks,
Michal
