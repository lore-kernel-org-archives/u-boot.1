Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B744C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDF687F62;
	Tue, 20 Feb 2024 19:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rgImDoH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD7287FD8; Tue, 20 Feb 2024 19:24:43 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C4E487ED8
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/ezMRQ0NDArBvXIzWAHbRgBjMejG0x1BsQPq9aOZ5K7M0SnzeQ4fY+2HMacfEx85C2ZykWDgRWpT9VU/amINN1jYY4tNJ6Gl+mKO5AcueYt5HX2nCviRLYY7juCwezuopvteW0vHPY4dwBbqU5Herq2GHAXWEHwksIXCKdYZOr4OaSbwIWR0w8X6x1O79161ohwbJAQgyK2sl2SzdM/n3G+/ka1czYRe11VOM6zMiSvaj7JVsteS3HagdqTpKx+ND3UD1X4ODaNX+Hnad8TkmSBQandbQ10xYvbU4EAz0AO4bERT3rBu6X6BFIC99cS2Byi6ZjMp1KENRKmA6V8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHazRwtJsUK2ISOTn+P2WeyMtcEaHvgp5faG1y/P/kw=;
 b=BNNEqEIbG8E6tLgWxNOFmNJ8RpVyfSSsoANb6HbeZnw8Pyb2VKncdJyh/M7ggrWYyVfXMrL+jlWKFPqURe1A61egl96P1lKQ3T/D5XFkASPvm06Yv+9M36mlNCK/Ze6YaczJoD9mTlR46KDbZhBZHy2jrq4KnETEX4VHZ0xl3AYba+cXbscY05MCHQDAEIbmwgFM28/hYA8mdwKQTehSXb2Mz318aPwAMcF27wnEgp4h+XxQeHx+fyde6vXC7NXYcrQU6uafVHMbH4QCBKiUorXeiuFksGhg2ZdctTOv+eLyhsVRrSS4MUoH7r27NxkZw+tbmvHK8aPJQ5GI6Mp88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHazRwtJsUK2ISOTn+P2WeyMtcEaHvgp5faG1y/P/kw=;
 b=rgImDoH2/wTFLkICz9GS9HfznHPPEIq7alJ1siSmLMI2g8WZIi2z7gHSJNr4kt/wjhqQuqJ5ztBpJbg3rLVyXwDsKvxrqx2bX+xkBUau+UxxFa9tCw2Tzi6CiVxJuSm+l3qMNYtHDkgI59Ikvll/sTPVWZ4tJV+141b5IHXRmxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 18:24:30 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 18:24:29 +0000
Message-ID: <5816ffd1-4105-49b9-8026-026a4195fa00@amd.com>
Date: Tue, 20 Feb 2024 19:24:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
 <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
 <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
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
In-Reply-To: <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::41) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 593ce474-51a2-4c5c-ca92-08dc32412d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW8Yyfb7FFVDkE8pbCEYRYBrKMKHcASifT1JAJ5mdXMfeB0Wys/E81xZQ4GrMRKsLjnsiR8nvCZ3UEtl5teLz1pvX3SuG/4vZuEQyUVpmWw/cxTNFfQ+JMZ6qHaqVdiKFw5+RikDtfFgWIWeevS6CugAlDO6aeKN1itvlXUDH5f9dCZSW4k4sSOq8qmBtgF9DePZqGCa8dP7xxuwQjYFPNhVgpDjxy+KlECl7HY0V62p27ANY4LPE+cRVkTGMP0Cncd7vWZNYNfli3FBgHMS+PsKdVd16mqZ2B7atjg8mZIJHKDohVQp8cg9pgU5hYASIvXGWOVsp8a6cArwi35gSOgZFx1CkYXOOsJJCgJTleoyAefSo+4E5/1gzc0zP4ZiTZD/z4hZnzBYJRQTK14G+8ouOoKGM5V6I+d7cITuGhI1zxTlhOy6IvdUUOVcJ5X1kK21OJ/stnXNfgM0jVQEmTJtQNtuSfueguISx1iv9EDhnJXO6lcsa6IJ/T23QbQ1bcZklGTyxkRtRCwuGjvzpMgUtjE0Jvi1C8Z3TJYgRY87s0Ausqi6vj0Kyz+KT+6J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEtTWm1vNkw2RlJPd2t2TGhUdzBTSmtackE3WjlISEtTSUxvRTdXU1FkWStB?=
 =?utf-8?B?aXduc2E1WU5IcXpzOE13UC9YaGE4Um95dzFJY2VhNURFamYvZmFLRGtIV3l1?=
 =?utf-8?B?c1B0djZtKzhrakpGTndJUjJGc1RSRThWODZGS21pVHZRZGpYSmUwT1dleCtq?=
 =?utf-8?B?emo3eUJnTjdGL3l4UFU0bEZ2ZjZia2hlRjFFUU9PMVNxSDRGalpSNHIxS0ow?=
 =?utf-8?B?Y1dLcmk5WmhLUjg2aGhCalMxZE5tMlhhWVgzaDNCYldseTlrK09UQVlYRE9K?=
 =?utf-8?B?Y1ozNlZiRCtpR3hhN1NoWWZvYzl2a21adHoxRVVFODU2QnU5MmJtOVUwK2Zh?=
 =?utf-8?B?WlJtcGhRT3BtVzNCQXVhbnRudCtTL0U3bzBud1dqbVhGOVJTak13S3gvY0Fr?=
 =?utf-8?B?cXRUclJJT3Y4Zis0MENyNno4S3VKMmMwRGFJTjRIeTJwNHgyT2FWMytGNFQ5?=
 =?utf-8?B?Y1A5WkozL0dWSjZycWhLRjlCZnRyVVZuRVNJVFlsKzk2RXo5djBCS3JUWWpP?=
 =?utf-8?B?cVRzQ05ZTGZBQnRHZklrS3pESEZ5dzh0RWxoaUpNTWZEZURvSVZjeUhhRUdU?=
 =?utf-8?B?d0RBTHNPOW16akV6cElpaTFWV0J5R0dkQVZOY2pYNm9Ba1YrckJBUEdhd0JZ?=
 =?utf-8?B?ZlI0c01PTVhXQU40andxU2VDc1p0ay9LSnJiM0pSeFN4Y08wTXNsSjI2RWN0?=
 =?utf-8?B?ZXVuTjNaekwvaC9uK3BncmM4UTJSQzVWcW93cUtKN0lERzNyMjM0cStxRm1m?=
 =?utf-8?B?b0dtTExKZjBJOHFhTmI5RVA2eDEwNnk2ciswdEhuTzJldmlFYWQ1S1lzd2JP?=
 =?utf-8?B?cWNZcGpqcGoxR1AyZnpXV1UvUDJZUDEyK2YxZll6N2R5aDh3SEtUdzlsSGhM?=
 =?utf-8?B?M0xlS3FyNFBwcXdBZE9Eek9XMkI4VWUzeCtEbldvcFZ1RXViajRNRDhRTS96?=
 =?utf-8?B?dUhpbG1JVmxaTE1EUUVSbUxYWnhnNTdOS2l3Sk9FSHVsWGgzRGtwbHJkTzhK?=
 =?utf-8?B?WkpPYWFCSlU0R1lRREVCWlNJWHRpd0RxMmpXWjJqNFhrYmllVGxuZ3pqVVU0?=
 =?utf-8?B?U0VJMDY4UmNJODI0R3VFMzRsVzB6ekRtMlB6TDU2ajFFU3MvOE51bnl1VitF?=
 =?utf-8?B?OUhXME1WNTY2bFR0YUhoSlpsWnJXOGt5dkJDNkIxNFdydzd6eVIwWWRFN3Nw?=
 =?utf-8?B?dHcveEMwN1FOcEpjVUVHRDBOYWhXU0QvLzVQd3BHVTBiclZlSUhuV0R4aDRx?=
 =?utf-8?B?UjUyQ21zR3o2Z2NMeDU0ZXcrKzVmQllYRExoOG5sODNPMVdYZVdxNDNxdXd0?=
 =?utf-8?B?UktqRW9xMnpaVnBrRno3TG45cWxadTJZTENlWHlEb3RiNEIzQXl4b2JVVU9y?=
 =?utf-8?B?M2UwbVdHZjNTSDV4eHNCeE05VGtnWGlyTzRHVU9ibjB6bkdVMTYvUlFHWHZG?=
 =?utf-8?B?aWYzTktFT1hibUQyTlFJQmppb2trRDZJcUpQaUx2U3YvS25OU2kxbFhIV3Ru?=
 =?utf-8?B?dUZBb3RwckJrK29VRzlFUzR0NlZ6dVgzb1FqdDhBYmtGMG55dW54NDlvZEFQ?=
 =?utf-8?B?eE9BdWlhb2h4TE9OeWJWU2xLR0F0WnVYUTJEVi81S2VxdHNKTGhGTVVkTThw?=
 =?utf-8?B?MFVvcEUzdDZLOUZLRGpuR3FRWUxrWnE3V21ITUZvTjFtTE43blp5RWZXc1RI?=
 =?utf-8?B?NHJZNVNTRU5sYUdIb2RkQ3V0d1VPUWdDb2lYbW9POUJ4RkppeGhoeVhIc1B4?=
 =?utf-8?B?MVUzekVzQUZ3c2l1QzZiQTlYczRYYkxyUXhLcjVjeGNBcmVNb0lRWVc1Vmls?=
 =?utf-8?B?Y290OGdMTGdkU09yN0VWaEVmcUpDUGk3c0Mrc3dFdnd0cERlc3hlMjZ6SndC?=
 =?utf-8?B?WThCR1NqL1puQVMwcGFPT0F0WnB3Rm9WYkNCK1JoYTBETFFYSDdIcU9LQTZp?=
 =?utf-8?B?MUdtd0FYOGZXZGNIaC9DYVhZdTZzYlNxREpDUE5ycnNJeHFTc0NENEU5dG0z?=
 =?utf-8?B?VDIzT01JQlJUQUxSZVQvejhSd2JYNGxPL2RLVnE0akdoWXI3MUFPN0pxUHBY?=
 =?utf-8?B?dFFxR1d2a2RSSVFWZ3RuT2hBM1hHSlFqRURQRFVVQllLRSsvV09jeC9TTE9T?=
 =?utf-8?Q?O4ThdKvSD53Z6q1t5C+or8pxT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593ce474-51a2-4c5c-ca92-08dc32412d83
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:24:29.8712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKKdolF3jlRAqLn6G34kPJPfoy3N7hqdP3M9jdArCLDJ3hGsZ3o176dIJ2f1r+9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
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



On 2/16/24 17:09, Sean Anderson wrote:
> On 2/16/24 11:03, Sean Anderson wrote:
>> On 2/16/24 10:06, Michal Simek wrote:
>>>
>>>
>>> On 2/16/24 14:48, Michal Simek wrote:
>>>>
>>>>
>>>> On 2/15/24 20:31, Sean Anderson wrote:
>>>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>>>>>> However, this is a bit tricky to time, since the debugger has to wait
>>>>>>> for SPL to initialize RAM before it can load U-Boot. This can result in
>>>>>>> long waits, since occasionally initializing RAM (and other things in
>>>>>>> psu_init) takes a long time to complete and the debugger must wait for
>>>>>>> this worst case.
>>>>>>>
>>>>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>>>>> debugger when we are ready for the image. This means we don't have to
>>>>>>> wait any more than necessary. We don't change the default config to
>>>>>>> ensure we don't break compatibility with existing debuggers that don't
>>>>>>> expect us to hit semihosting breakpoints.
>>>>>>>
>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>>> ---
>>>>>>>
>>>>>>>     arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>     #include <image.h>
>>>>>>>     #include <init.h>
>>>>>>>     #include <log.h>
>>>>>>> +#include <semihosting.h>
>>>>>>>     #include <spl.h>
>>>>>>>     #include <linux/delay.h>
>>>>>>>
>>>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>>>     }
>>>>>>>     #endif
>>>>>>>
>>>>>>> +static u32 jtag_boot_device(void)
>>>>>>> +{
>>>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
>>>>>>> +}
>>>>>>> +
>>>>>>>     void board_boot_order(u32 *spl_boot_list)
>>>>>>>     {
>>>>>>>            spl_boot_list[0] = spl_boot_device();
>>>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>>>            if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>>>>>>>                    spl_boot_list[1] = BOOT_DEVICE_MMC1;
>>>>>>>
>>>>>>> -       spl_boot_list[2] = BOOT_DEVICE_RAM;
>>>>>>> +       spl_boot_list[2] = jtag_boot_device();
>>>>>>>     }
>>>>>>>
>>>>>>>     u32 spl_boot_device(void)
>>>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>>>
>>>>>>>            switch (bootmode) {
>>>>>>>            case JTAG_MODE:
>>>>>>> -               return BOOT_DEVICE_RAM;
>>>>>>> +               return jtag_boot_device();
>>>>>>>     #ifdef CONFIG_SPL_MMC
>>>>>>>            case SD_MODE1:
>>>>>>>            case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>>>>
>>>>>> Good timing. Can you please tell me how to test this? What's the setup?
>>>>>> Which debugger are you using?
>>>>>
>>>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2freview.openocd.org%2fc%2fopenocd%2f%2b%2f8133&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f832185958363d84f990a08
>>>>>
>>>>
>>>> I am trying it on the top of the latest git but getting issue with event block and no idea how to fix it.
>>>>
>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
>>>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:22)
>>>> Licensed under GNU GPL v2
>>>> For bug reports, read
>>>>       https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=http%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>> Info : auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
>>>> wrong # args: should be "-event <event-name> <event-body>"
>>>>
>>>>
>>>> Do you know how to fix it?
>>>
>>>
>>> I actually bisect it and found that it is caused by
>>> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
>>> ea2e26f7d521f5755b4bfda7bf12d99650277421
>>
>> Interesting. I have been testing with 0.12.
>>
>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
>>
>> FWIW after installing the udev rules I do not need sudo
>>
>>> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:38)
>>> Licensed under GNU GPL v2
>>> For bug reports, read
>>>      https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=http%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>> none separate
>>> Info : auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
>>> Info : Hardware thread awareness created
>>> boot_apu
>>> Info : Listening on port 6666 for tcl connections
>>> Info : Listening on port 4444 for telnet connections
>>> Warn : An adapter speed is not selected in the init scripts. OpenOCD will try to run the adapter at very low speed (100 kHz).
>>> Warn : To remove this warnings and achieve reasonable communication speed with the target, set "adapter speed" or "jtag_rclk" in the init scripts.
>>> Info : clock speed 100 kHz
>>> Info : TAP uscale.tap does not have valid IDCODE (idcode=0x48e70126)
>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), part: 0x4738, ver: 0x2)
>>> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (ARM Ltd), part: 0xba00, ver: 0x5)
>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), part: 0x4738, ver: 0x2)
>>> Error: JTAG-DP STICKY ERROR
>>> Error: [uscale.a53.0] Examination failed
>>> Warn : target uscale.a53.0 examination failed
>>> Info : [uscale.axi] Examination succeed
>>> Info : starting gdb server for uscale.a53.0 on 3333
>>> Info : Listening on port 3333 for gdb connections
>>> Info : gdb port disabled
>>>
>>> but with zcu102 I am still not able to connect because error above.
>>> The same behavior with recording SOM IDs I see on kv260 (via hs3 cable).
>>> It looks like that not everything is working for zynqmp.
>>
>> Is this with the boot mode set to JTAG? If so, you will not be able to
>> examine any of the CPUs until you have released them from reset. So you
>> should be able to run
>>
>>          targets uscale.axi
>>          boot_pmu /path/to/pmu-firmware.bin
>>          boot_apu /path/to/u-boot-spl.bin
>>
>> to boot a CPU. If you want to silence the above error, you can add
>>
>>          uscale.a53.0 configure -defer-examine
>>
>> to your config. So the full command would be
>>
>> $ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
>>          -f target/xilinx_zynqmp.cfg \
>>          -c 'uscale.a53.o configure -defer-examine' \
>>          -c init -c 'targets uscale.axi' \
>>          -c 'boot_pmu /path/to/pmu-firmware.bin' \
>>          -c 'boot_apu /path/to/boot.bin'
>>
>> Let me know if that works for you.
> 
> Oh, and I forgot to mention, but if you are testing semihosting then you will need to add
> 
> -c 'uscale.a53.0 arm semihosting enable'
> 
> to the end of that. I also find setting the semihosting base directory with
> 
> -c 'uscale.a53.0 arm semihosting_basedir $IMAGEDIR'
> 
> to be helpful.
> 
> As you can imagine this is a long command line, so I have a config which looks like
> 
> source [find interface/ftdi/digilent_jtag_smt2_nc.cfg]
> adapter speed 25000
> source [find target/xilinx_zynqmp.cfg]
> uscale.a53.0 configure -defer-examine
> 
> proc boot {imagedir machine} {
>          targets uscale.axi
>          boot_pmu "${imagedir}/pmu-firmware-${machine}.bin"
>          boot_apu "${imagedir}/u-boot-spl.bin"
>          uscale.a53.0 arm semihosting enable
>          uscale.a53.0 arm semihosting_basedir $imagedir
> }
> 
> which I invoke like
> 
> $ openocd -f my_config.cfg -c init -c 'boot /path/to/images my-machine'


ok. 0.12.0 version is working better. I am able to load firmware to APU but I 
was not able to load pmufw. It was saying timeout like this.

 > boot_pmu /mnt/disk/som/pmu_obj.bin
/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg:173: Error: 
Timed out waiting for PMU firmware
in procedure 'boot_pmu'
in procedure 'resume_pmu' called at file 
"/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg", line 232
at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg", line 173
 >

Then I looked at pmu and use below snipset which I use on xsdb to make it 
visible for debugger and also small waiting time.


@@ -141,6 +146,13 @@ add_help_text halt_pmu "Halt the PMU in preparation for 
loading new firmware.\
         This should be matched with a call to resume_pmu."
  proc halt_pmu {} {
         set axi $::_CHIPNAME.axi
+
+       puts "Enable PMU target"
+       set val [$axi read_memory 0xFFCA0038 32 1]
+       $axi write_memory 0xFFCA0038 32 [expr {$val | 0x1C0}]
+       sleep 5
+       puts "PMU target should be enabled"
+
         set val [$axi read_memory $::IPI_PMU_0_IER 32 1]
         $axi write_memory $::IPI_PMU_0_IER 32 [expr {$val | $::IPI_PMU_0}]

With that I am able to test your patch but it is kind of slow.
Max freq I am able to use on zcu102 is 2MHz which is far from 15MHz used by xsdb.

After some time I am seeing

Error: Invalid ACK (4) in DAP response
Polling target uscale.a53.0 failed, trying to reexamine
Error: Invalid ACK (0) in DAP response
Error: Could not initialize the APB-AP
Examination failed, GDB will be halted. Polling again in 100ms
Error: Invalid ACK (0) in DAP response
Polling target uscale.a53.0 failed, trying to reexamine
Error: Invalid ACK (0) in DAP response
Error: Could not initialize the APB-AP
Examination failed, GDB will be halted. Polling again in 300ms
Error: Invalid ACK (0) in DAP response
Polling target uscale.a53.0 failed, trying to reexamine
Error: Invalid ACK (0) in DAP response
Error: Could not initialize the APB-AP
Examination failed, GDB will be halted. Polling again in 700ms
Error: Invalid ACK (0) in DAP response

OpenOCD is far from stable but it does something.

Thanks,
Michal






