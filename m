Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9B0C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7898088CAA;
	Wed, 24 Apr 2024 14:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/qodUgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE2888CB2; Wed, 24 Apr 2024 14:18:24 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B9088BDB
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 14:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzKQVw4EOPnxl1ls6bhMdvdXdUMSLKvRegWYPlCDINqKCGpq7GB1r6gaxTiGv99w+FpN5qS7qOEVPQeMlUmpcMbEDr/XQXZ5knB8v6ZaiPiD2LQkag2fnSuzJRL/nHUGoy6SnEfWPWac/ES59mXiqakScWIFsTiShC2rrC092bGcxCp2EYN0jFDlCmHKJSSmMF0AuQt84aSAdy1vEIsGcdzoXWK1s6Z9V0pEFL0Ycx8yMrvR76TFP9TlKJjotPqH6Mbjz63wxG84F0dB0MWG3xV3jES4uaqHCM0u4gmy/Q4W/bXAtVhvs7zTbqEo10/GGi9auDhC9Bi+l+9MMr3SrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djR9Nd5jqvroPisUhoVKqSMdVutW7fPTWw+hGY2hKaE=;
 b=fPm6FIAkiLlyLBhgM+Lf/qrDt26qxD9MzbMgGWP1X90iqhKuCqxwAlpkJlRXM81cFIy0osh4Yd/uc1xQ6H4kE8uea3UIecgUqNzKA/3Fmqnf6ivQW9eRSzneZDgepEOfkhSSdVUxYqPef1HGl4ojZdUUSdMFNXGi96CroaWlHUG6K7i7g5JFLmKjJaMPSkRZ7Vdiig+5BNsSvnjFMpoo8pLo1RYLKLA9BPvyOmGE92QJzJ1ZH43BNz0i3lGwTAceBh8qn0vhmUxt4nj0nIe49QVlNHrrAdSdzKiniHP9glXtiyxNj3/Uh0mx4G08guchB0mw4dKaYF/CpxqOLlNn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djR9Nd5jqvroPisUhoVKqSMdVutW7fPTWw+hGY2hKaE=;
 b=O/qodUgrBPpqKbGUdQeaX6ScnqKoCcuI/kh0T7RsgnKNgKcHmyZYqqbPPw9nBZpsBzooUkmCQt3K5EnPnf++Lt335wGA4jwv1xh7xSZagcm4ydcafpyHefo6JMKJfqS13ruCqRK3k7X0waQFfIFvaXRA0G4tnWD/WUli8yN/DHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 12:18:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 12:18:18 +0000
Message-ID: <3e0c69ee-21bb-4bb8-9952-d0e8e91e091f@amd.com>
Date: Wed, 24 Apr 2024 14:18:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] FWU: Add support for FWU metadata version 2
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
Content-Language: en-US
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
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6acec7-22fd-45fc-d0b3-08dc64589fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWMrak0wbUNMTzdEMjhHa1g1eGd3QldUQ3VJR25PQXhtQ2JhVEpLRk5MT2pW?=
 =?utf-8?B?ZWJvcG43aTUxYVNQbHhudXVubGhPVmFSaFlDTk80elAxRGY0NS9DYytGU1Ex?=
 =?utf-8?B?ME9GOXV1blZudjNVR1lJdzlQNU9HcE1aTVQxUFErZWdBV2drYzFMVU1WUXZM?=
 =?utf-8?B?QnlkS1pUdzFERXkrK1JiMW9mVGJIMEJ1eGxVQjBOK0RjRW9yL1VqMjdTd2pJ?=
 =?utf-8?B?Wit5SWNtYWxnbVVna1BPdTl4cjhlOC9YNHNnNU5McUxQc2V2cDdES0tkZWRx?=
 =?utf-8?B?OW8rLzl5bWozR3BJZjROQWRZVFcvRk9BaWN2SzBxQWQ4NXFVK1lqQlNNa05Y?=
 =?utf-8?B?YXl2OUo3aVNQU2JrUVkreGY3T2NJQ252aU1raVJrWEhLbGUvbGtoYm9EOVB1?=
 =?utf-8?B?M0VNak1pYmFsMlNXenJ5ZURlTGlEbVl5WVNpQ3RCZGliVGJ3OFVqOWE1eElC?=
 =?utf-8?B?U1lRVEJaeTNOUnJZam5raXFkcEtkcVVSWlZDbVR1ZldGSDFFaHU2bmhLSC8r?=
 =?utf-8?B?VDBYZmFwZ0lnMGxoVnRNdUF5YjdMMzMrUE1yNkovQU96R3lkM2dlRUI2b21R?=
 =?utf-8?B?aVBYVHBOdWNYY3lXc1ZBa0ZHUDJ1NjIzZVhPcmw3SlZodnA5Zmc1U2RyajF3?=
 =?utf-8?B?NkRLVUN3KzV5eG9BMmxUNno3MjNTNFRvMGtTL2hTLzNJRHVVdjAyTHNoOXI1?=
 =?utf-8?B?cFdJaURWOEN2MGwvUXpQOFJ2Y2lTQ0FkZTFxQ2djTm1aM0FIL1QwUllvRHRn?=
 =?utf-8?B?anN5eHRxcDBhbUY3L0FvWkdVOUE0LzAzVksvTE5mU0JJbjdNbTJERk5SZ1lE?=
 =?utf-8?B?QkJJRURFTE5VdjRsK0szWXZOTFBLNlRvUDBZMk50L0hzMGZoSVhKQzBncHg5?=
 =?utf-8?B?UDlaMm9USmx2MkY5ZWwzY2d2V1dHRHFKb09KQXRRNE5ZKzZtVXp1ZTYvMnRS?=
 =?utf-8?B?Z2hUY3E0VFhpWE5OVGhCdExBSW0rYXN5anA5WU80VlNXdHM2L0hDT3h0dytC?=
 =?utf-8?B?WmZjMERjUjROcUxxTUZsQzQ0aVBwbjNGUGtOcmlDd2lqMlpXYmNJekhtMlp1?=
 =?utf-8?B?cUZKeUdVTUhyRmNqZzZqa0VkNXhJU2d1OURBNjV3UVd1WkRQVkZZYlcvMDdZ?=
 =?utf-8?B?NWg0cUJOMzYyK2NrMlpjdGVSUWlJb09neWUxUHgwdGs1ZStTSDlTTlZFWjU3?=
 =?utf-8?B?dkxTUGVGZFg0MG1hUnZpbEpOT0tEN0NlYXZhcnJ4U1FiK1lEVWhnNHNyVFZx?=
 =?utf-8?B?ZFY2Q0NISEdibWdBMjdJK0FWTjdDeXJYeXA4SFg2eUtzak9nNGFueWxIamhE?=
 =?utf-8?B?eXZpMFZyUVNZTGV0UG8wckxFdzVpcEdqSzNmQ2g4WWV5c0xUTll3NzBuUGVR?=
 =?utf-8?B?MlczVEt3VFQ4QTJuYzJXNzJNWGNZQ0N2TWdwNTJIWGl5ZnB0aElzU0k5UnR6?=
 =?utf-8?B?eWdiNXNWTFRWVkoyRzRIa0NGL1BYYkdnUERGeERzaTd0Z2NkM2UzQUMwaHRq?=
 =?utf-8?B?WGJnTzN0ekFobDZzNGZqUUFGTGhtdWovZlRVREVUTTVwT0pocm96LzZTbWs0?=
 =?utf-8?B?Q1lSenJSUVU1YjNiL0JzK1lTRVhLQjM1MWNZeTFJTnhIL0ZRTXJ2SktsSkZ5?=
 =?utf-8?Q?Y1YpxfbtMHpLWjk9kR3wArPfGTIus0dkjMzrf7PFuGbg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjk4Sko5dlAwbVRsb1c3YnBGUnREdmptbGZKSzRROU1mRE4wWTJKejM1MkRR?=
 =?utf-8?B?QUlmU3ljOWFKUFpNUlRVSGJqbSt4MUVCWHFFb0JGSUdaTENTRlhvTzZNSU95?=
 =?utf-8?B?SzB6M1NZeC9KcHNOUkJ3UFVudDZ3Vll1SlRaWE52UElvaDdHZXN3ajdMeEYy?=
 =?utf-8?B?cFhBUTVOaHk1OTFMZ1JER0lvOUxka0djYXdhOEE5NUdXdGw1Vjh2SFBtMTZK?=
 =?utf-8?B?UTlKdkV2Rm1GVlVTYUlLVGpnWnYxdHN2cHV1K2tkY2VRUGVTbmlJd2g5LzVj?=
 =?utf-8?B?Y2E5bGdCMWwvN3pTWjRDMS9rUnJkU3FPaVh3R0liVExmbVl4UTNPOWtVZlpu?=
 =?utf-8?B?akFaMTJ6ZGVqcjIwMzY5NkFDSzBMSFlyRHhnZWM3bkpKNk5WWkxSODNEN0J6?=
 =?utf-8?B?MVdrWDJTcWpoRWZWWGFjNkVDYWJDYnRIOEI1SFBtQTFlTTR4QmRJdEhIYXZn?=
 =?utf-8?B?WklmWUk2bUgxRFAxclduSTh1RzZscGpoMnNRY3dNdnJaSUk0ZytPMkpsa2hZ?=
 =?utf-8?B?RjNDN2xva0VVSTNxa0lHdEdaejM2R2FnTVg4MjY3ZWZDcC8vai8wZjdvYmR4?=
 =?utf-8?B?VmdHMXAyUGlnUUdWeG1yUllJUWY4MmRWVjhkVlZ2QnVJRmZmM2JnbXN2UDhP?=
 =?utf-8?B?RDVvL3hXZDIybWhMM3pvK2ptSmREYVEzMjYxQ2RNTjBiZHg4MnlxY2R4Nmsy?=
 =?utf-8?B?QmowUTh3dlNDejROQzZzNFk4MDAzSGZBcDlRTHk5SERHditpMDhwL24wNGhz?=
 =?utf-8?B?VzIzNUpXVVdtR3Y5bnJoU3N4T1hhWlNFT3VzT01TWVp0NG1abWNVK0FSUTlv?=
 =?utf-8?B?eUYweXB0bVo4MVkxd1BGVlRJR20rdlh1cVNZN0xLUmNjak5xcy9kQko1SUh1?=
 =?utf-8?B?eUdseW1zVVZXOTEvTjhEc1MyTk5kelNjRGlaeU1CVTV6NkVmNmxMekRWOGRn?=
 =?utf-8?B?bnp0WG9kK1E3OVhidFR5YUlkTzdwWUNhS2lHZ2ZmR1N0aVpjOHZIbUhGeUxm?=
 =?utf-8?B?T0tiY09VbUh3QW51Q1FRUEduV3VTSWM5OUdXRDZZSG9DMGl4OGVjR3dqejlz?=
 =?utf-8?B?a2RWaFhaSUQxSm5xdG15SmVVZytOdGFCMW1CTU9GRGdubThITm1lRHRWUUhv?=
 =?utf-8?B?U2VvOWRLTjhnMFYxQ1hYTXhPMUh6TitjZ2FZQVE3K1RBWjZIeW9UQ0hOMGZN?=
 =?utf-8?B?cGh5aHFRaEo1ME5zQkFoeGZLeW1iRWQ3SlY5MkpYUmp2RXQzVVhHRE1Takds?=
 =?utf-8?B?UmMzSWltbWVjTzdqYjZBd0tDc3o1UGc3UE5VQUluaFQrZkN5Vkw0dGZvYkJZ?=
 =?utf-8?B?eHVOWW5aSUZ2NnAzdEY3MFg1ZEU1anJteCtLQ0lBd2NFSitXalpTNUhGSE1U?=
 =?utf-8?B?L002Vkl0dUhyYURDK2cvSnU5Z1ZNQ2R0VWZvTlB0dSsvTnNncE82SWZlVTh3?=
 =?utf-8?B?RlNYcFd1bDVLS01PRExkY2d5cjZxN1ZjcGx5QmxGUTNSRndTOW84K2JsblBR?=
 =?utf-8?B?SGt5M0kyL3hPdjJ2Smk5TXJlcUxCYWxJMmVoT090Zk1iUUh3SS9FSy80Z1FD?=
 =?utf-8?B?c3JBakpyS1dMOHBRSDB5L3BFZWJlRzZQMlh3d3BJRmpzb29jZXZkV3orY1R6?=
 =?utf-8?B?VUJCNDhTRTY4RXFtVk9wS1hEYk91eE1uNWRkVnhXQWRycXhDcjdQQ2hIWUZv?=
 =?utf-8?B?cEkvYXYvbjFFelRwVVB3cktkbzV1aDZ5Nlh1Kzh4MFpyRU5NdUEvc3N6aVJr?=
 =?utf-8?B?ZXpPb3VvTHpVanNnajZLczZCYjRaS0hFRnJzaVRFdVBGSDl3SG1FemVzQlZB?=
 =?utf-8?B?ZXVoRGJKQzV1VmwrVERQeTNOVzFZV2tCTVhxNVJ2WFpmTy83Q0w2ZTJLWExk?=
 =?utf-8?B?U0J4ZkNGKzlzTmZYRW1lemY1NzE0eVJaVTM4eVRpMWU3MSs3MnZJNDRaTWJX?=
 =?utf-8?B?MHl0RlZpdFVGNDlWOVRzYTFRcjkwNjgwVjdMVUxvNDcxQ3A4b1YwL3lUZktU?=
 =?utf-8?B?TE13c1BNN1dialJROWFiZXh5dVg2Y3gyUk1BSE9zU0lhVXlhc0FDZlYzWFFl?=
 =?utf-8?B?L1N6RXVLMWhUS2hwdmU0d3ZPT0FiaEx5azdkSXp1cWRQb202aDByalo2OEV4?=
 =?utf-8?Q?t7LbfOUyCp7rTxopq9FxR+aXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6acec7-22fd-45fc-d0b3-08dc64589fe7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 12:18:18.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYYy/BSqXH5wEZD0IpRW9IggldxgqjQwz/ADTZt2m6FlEeVDBoFVvuNUJEsEjpJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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



On 3/22/24 11:57, Sughosh Ganu wrote:
> 
> 
> The following patch series adds support for version 2 of the FWU
> metadata. The version 2 metadata structure is defined in the latest
> revision of the FWU specification [1].
> 
> The earlier versions of these patches were migrating to a version 2
> only support in U-Boot, similar to TF-A. However, based on feedback
> from ST [2], this series has been updated to support both versions. A
> platform would still be needed to enable one of the two versions of
> metadata through a config symbol.
> 
> TF-A has code which reads the FWU metadata and boots the platform from
> the active partition. TF-A has decided to migrate the FWU code to a
> version 2 only support. These changes have been merged in upstream
> TF-A.
> 
> These changes have been tested on the ST DK2 board, which uses the GPT
> based partitioning scheme. Both V1 and V2 metadata versions have been
> tested on the DK2 board.
> 
> These changes need to be tested on platforms with MTD partitioned
> storage devices.
> 
> @Michal and @Kojima-san, please help in this testing.
> 
> Note: The CI is breaking on some sandbox py tests, but the errors look
> unrelated. I will look into those issues, but the code review can
> proceed.
> 
> [1] - https://developer.arm.com/documentation/den0118/latest/
> [2] - https://lists.denx.de/pipermail/u-boot/2024-February/546277.html
> 
> Changes since V2:
> * New patch which retains support for V1 of metadata
> * Earlier patch was catering to v2 only support. These changes support
>    both versions of metadata.
> * Earlier patch was migrating to v2 only support. These changes
>    support both versions.
> * Support both metadata versions instead of only v2.
> * Added documentation changes.
> * Make changes to have the test work with v1 metadata.
> * Make changes to have the test work with updated logic in fwu code.
> * Changes to indicate support for both v1 and v2 instead of only v2.
> * Add config symbol for selecting either of the two metadata versions.
> 
> 
> Sughosh Ganu (20):
>    configs: fwu: remove FWU configs for metadata V2 support
>    tools: mkfwumdata: fix the size parameter to the fwrite call
>    drivers: fwu: add the size parameter to the metadata access API's
>    drivers: fwu: mtd: allocate buffer for image info dynamically
>    fwu: metadata: add support for version 2 of the structure
>    fwu: metadata: add a version agnostic structure
>    fwu: metadata: add functions for handling version specific metadata
>      fields
>    fwu: make changes to access version agnostic structure fields
>    capsule: fwu: transition the platform state on a successful update
>    fwu: add config symbols for enabling FWU metadata versions
>    fwu: mtd: remove unused argument from function call
>    fwu: mtd: get MTD partition specific info from driver
>    fwu: mtd: obtain image information from version agnostic structure
>    cmd: fwu: make changes for supporting FWU metadata version 2
>    tools: mkfwumdata: add support for metadata version 2
>    tools: mkfwumdata: add logic to append vendor data to the FWU metadata
>    test: fwu: make changes to the FWU metadata access test
>    doc: fwu: make changes to reflect support for FWU metadata v2
>    MAINTAINERS: add entry for FWU multi bank update feature
>    configs: fwu: re-enable FWU configs
> 
>   MAINTAINERS                              |   8 +
>   cmd/fwu_mdata.c                          |  39 ++--
>   configs/corstone1000_defconfig           |   1 +
>   configs/sandbox64_defconfig              |   1 +
>   configs/synquacer_developerbox_defconfig |   2 +-
>   doc/board/socionext/developerbox.rst     |   7 +-
>   doc/develop/uefi/fwu_updates.rst         |  20 +-
>   doc/mkfwumdata.1                         |  16 +-
>   drivers/fwu-mdata/fwu-mdata-uclass.c     |  10 +-
>   drivers/fwu-mdata/gpt_blk.c              |  23 +-
>   drivers/fwu-mdata/raw_mtd.c              |  78 ++++---
>   include/fwu.h                            | 147 ++++++++++++-
>   include/fwu_mdata.h                      |  71 ++++++-
>   lib/efi_loader/efi_capsule.c             |  14 +-
>   lib/fwu_updates/Kconfig                  |  14 ++
>   lib/fwu_updates/Makefile                 |   2 +
>   lib/fwu_updates/fwu.c                    | 204 ++++++++++++------
>   lib/fwu_updates/fwu_mtd.c                |  34 +--
>   lib/fwu_updates/fwu_v1.c                 | 167 +++++++++++++++
>   lib/fwu_updates/fwu_v2.c                 | 260 +++++++++++++++++++++++
>   test/dm/fwu_mdata.c                      |  16 +-
>   tools/mkfwumdata.c                       | 235 ++++++++++++++++----
>   22 files changed, 1153 insertions(+), 216 deletions(-)
>   create mode 100644 lib/fwu_updates/fwu_v1.c
>   create mode 100644 lib/fwu_updates/fwu_v2.c
> 

FYI: We are working on changes in early firmware (img selector) to test this 
code on Kria platforms.

Thanks,
Michal
