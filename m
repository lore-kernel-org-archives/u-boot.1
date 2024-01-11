Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FC1C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 07:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB6187847;
	Thu, 11 Jan 2024 08:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NUX1DSui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D1C87A7F; Thu, 11 Jan 2024 08:09:43 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559D2876EA
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEMPy4xbFpXrIWRThOD+77TsmkxEJVezVzyqvDX/DiPUExAciCvi4ftNErCJ5dsv56z+WVqbxYglrrENHcXCZO347/prUCsmXhNAx/8rdV6IdSC1vnHomRB8PckKZkuE+KxNRDm/N65r8tdQrWVTI4W59UlxAVRDrqbqTfeRqKG9VNWCwxjE3frLgz3dlFQzP+rDawH7BXBL7B5z8G2z4ObQpqCptYh0L3+PYe9vIcrp6t3R8hniH/xSBbM0EZ0woKrnXfEBFr1biZtaCn/icGTuzYHeqrml+lD9zeK9bu4TXaS95W26ygKK+ctavHxJy88rpKs8njp3NAbnp0RCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07uG8MOXzA/kVHBrOWkVN5szPeP8KdCLyvPXYzhi7Jg=;
 b=KmkKCxX+ENRYL6vdrShXqSNfFb3FEdxE0PGxqY7dGvcGw3Vo79d2Aoznk3xPCIzzeB6UYuXZ6WwPgZmneOGymFu+HECuhGf9Z50yQNdXy/wnNDstyHUIAYgFqTjczaierDN0ntLsP+ry2IKNTJfr8dkA++wLWPQk7tJI4hRTIpHHnGPLH/0RWytQDO1tQ1MxJtpWMD42qssOHrOr+eT4IKJ0EvJBKRcl693aafbq+BykDMfnUB44wxdx3OwhyQQj3C4TaraYHEyI0ER2y17r48lVjBKiMAecRelcyv9LSsWhNKtIPx9PIIcFuDG4MLc3WYGcAd4LjXhTrErZRqmaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07uG8MOXzA/kVHBrOWkVN5szPeP8KdCLyvPXYzhi7Jg=;
 b=NUX1DSui1ys9EI1gE3VBNFOcwbJktZ+RI0SWRM3IwK0mUE45y2U9JK+I9tiIG9Im3mJ29Mlz4b8kIVaVAHLHvuYa5g07xk0Gn7GuShU2YeSdrhcZiwENWqTJSdRc38ZWFDaCD8GwmAnyYwuIRFWJZK8ehxCdjVS7wEvBhVYaCDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 07:09:36 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 07:09:36 +0000
Message-ID: <d07c9f9d-8106-4bc4-8630-cb36176cdb70@amd.com>
Date: Thu, 11 Jan 2024 08:09:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Move address/size-cells to proper locations
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Saeed Nowshadi <saeed.nowshadi@amd.com>,
 Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
References: <f2c1cae3b845d4609f8181f2dcb09a55f705667c.1704893723.git.michal.simek@amd.com>
 <2ea988de-43cf-4f06-b8a5-67bac1718d31@linaro.org>
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
In-Reply-To: <2ea988de-43cf-4f06-b8a5-67bac1718d31@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0135.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::19) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH0PR12MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d90838-0c81-4f5b-a9bf-08dc1274451f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mtDURG0NPJZxjjNfvK7itE4txSW2xfanvnWbE/BK559n0OMjfB5RkkxF5wvVlfh3CneAWs1/Y7WtP6MqXCbMYdkdZ5y4XJ1SDx4M9oKOEUxkVZyx5UNVkcIZndOw2SMVROm7FGCDZIVxGy2F6UD+3edpUmBGdTmDnxa1JcUh52h3jLd3PbfHtHNUOQc2GJ/cEhMjyVIuwYlKIWPYNUL+GV0/t3ZCl8u694FF5gnUO2vSG2btH/u+arFU7fqw/J+Id/S9DT0OoX21TGkrxlWGW8fBdIRCivphtmpxsnUIJcM/+2QZYPocCU6dWlE0W5/5CqR+3OG5y5qvsPJTjflMEHe02flxzOgKcGIKAriM0yyNeyG2rVr53ZQ1OaN8VsaYXS85iFwzDYnta8wpiLrzdlUX9vRKXQitvrZiK+98DGZ9LZZ67ay4mQzXNa/63JCh5AyNgYvpQBO2mWTSRQqT4r7WPnBb1Jkn+yTjOZ2dubnBncZ6h9JdCTobcaGzLGQFoS9XI3a4eB9topCv3CKNxKDDIQAbvL6rix7o2l2e14HkTmKPEtPqPtisW4MllxNeLoAldzRj+D+ptSuGeRxXgfO1phftOT1YT6e0RodKsqVcCUeNkIXjJAaiuvfmGRRuAHiuom0eoJAr4w6DaBzhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(53546011)(26005)(6506007)(2616005)(6512007)(83380400001)(41300700001)(86362001)(6486002)(4326008)(316002)(54906003)(8676002)(8936002)(5660300002)(2906002)(44832011)(36756003)(66556008)(66946007)(66476007)(478600001)(6666004)(31696002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBLMXBvdmx1QVpvaExUaVVTTWIxbncyMWswbUNUSFRRZjBqcmVpbFpGVUF3?=
 =?utf-8?B?bk9UVGhFcFBqdS9QWjlWWFF5OHdleW8vSU55Q09qZElhdjZQL1ZHRGxTTUVa?=
 =?utf-8?B?RGtxdVFQQm5mWG9EMThuY0w3eGxFT2xEaUpCU3FFNHZVaFNQWWVpS29ONTY4?=
 =?utf-8?B?NXgyaG1MdzRnbkt6ZXgvRlpQT1JmOHo4R2lVaDVYSEFMZW9qRnRXVSs1SEd6?=
 =?utf-8?B?dU9jMDcvNng0Yy90OTZKbWlIWUdNUjRsMDJyOE5jZzJDckNVYWRZRWJhNVhY?=
 =?utf-8?B?YllpQUg2Z0xvRlAwMmdZbmhWaTIwVlhXR051eGZ1dU5oOUM1aW5JWHdVUEpZ?=
 =?utf-8?B?d0hBRFpXOElTckMyNnhBT244YSszNHc3SFpycFdLQk5SK3phY1didFovTndx?=
 =?utf-8?B?N0FGMEdmalRsRzhidHc2aG1XUWRiWHVXOGZoTExTLzU2L0JYSzhsNkROblJV?=
 =?utf-8?B?SUt2TlNlZUhlVVY4Y2N4R3dWazNadEpsTlBLVDdGYWdJblZ5M2JtaDhaSEtW?=
 =?utf-8?B?VU1VazQxTk5RRGN6MDVZaUNVVWJCUWhMeC8zdStPa0lvRnZmZ0w2MzB5Z1lp?=
 =?utf-8?B?bUF2V1JHaFlCQnFnbkFmT2IvNlJPNTdPTnIvV1ZXZlNaUWNPUGo0VDhYRlV5?=
 =?utf-8?B?UmdZeE5pdGg5TjBCWlVFU1g5MUp4UHhtcG1KL01JZ1ZKdTkzc0RFSE40Zm1O?=
 =?utf-8?B?WHcvc2taQTE3NnRpSExMRlVMZmZRY1czS3lnS0pxME9jTWUvOWZuNWpDN3dC?=
 =?utf-8?B?c1hTZll1bk1ocExQMGRZTHFScXU0WG5EMEtBSFFScnhTdHlNbk9RQkVsUEh1?=
 =?utf-8?B?eitlckg3cDJZZlBscUcya0RmaUhrcUd0R2g4WHgrWDF3cXVtVVQvTUErU3Ux?=
 =?utf-8?B?SEV1bll1Vk8rcVpGcW9TV2orNVJWUjd4eXRVdklBRmppRlNFRmhOTFFsK0xP?=
 =?utf-8?B?YmhrWFZYbFdvU1ZlWi9udXJHcXMrU2lzZzNqeS83NXRiWkFzU2tNSlN4K1pz?=
 =?utf-8?B?WEpsVUsvSUdhVjQydFJTWEswM3NzTXRPRkRJeUF0V2cwRUdXNnQ3N1Q1REkr?=
 =?utf-8?B?SDZuQ21EOXRjUVd4UFVCQkZYY0ZDdnJ0N040eUd4MHNXeDhtYnF1TDBWVTV3?=
 =?utf-8?B?d3FZazgrN0pPVHhOOEhmdFAwU1MvVWNPV3czNWVSNGEzQlZZM1FDejZkT3NO?=
 =?utf-8?B?LysvQTltb3NsN05ZSE0zcG05amNHT3hJTk13WW1RNFlkK3ovR2pzT3ROdTNO?=
 =?utf-8?B?VWdmbEsxZXo2UnFyRnJnWXF5M2lDa2dNRW9TOGMxa0N6RU1VOXRiSStuYUk2?=
 =?utf-8?B?N0RhclIyMEtIV0ZlOVVuTG1CSHRLbUR3ZXZHNkRmKzZqeldkTG91VjdmMnlY?=
 =?utf-8?B?L1NqVWUvT011YzA4QlB0UkEvbFVCWkhYTGZKbDNpbGJpZmkwaDZQdVlVY3VZ?=
 =?utf-8?B?d0VLdmwwY3NKSDJYVUx4U0k3SThJRWVmWmMvdDE5NWQ0QVZyeitPR0dxeC81?=
 =?utf-8?B?cmx2MDdCQUtrY0FybGxjTE9tZFJ3dTd1S3k4OTdtOUpCaUlkb2RZVitkbFp3?=
 =?utf-8?B?TVNtMTYwMUJRMGovalIwcFF0aWJoM0p5V1RYUjhDWkx6R0RFRkNoWVJseWEy?=
 =?utf-8?B?azB2M2dlV2tZQUVUeGdyckFiaEhNeTBENU9kSXRhbkVsNjRKUTAvZEt5QlNr?=
 =?utf-8?B?RzNHeFJHYU53Ni85aVlQbDVJQUMrUmtuKzVSWFpqQ2wrd3haV3laZjZ0blFh?=
 =?utf-8?B?NE8zWmZHOTFubkQ0R1pQRkNQSWJDcng2YlFCeVkvK1lFTlp5eHhPd0Jrd1ZX?=
 =?utf-8?B?Nm5HdHZSWTFWSjhRVEdtSzJzekNtMDRSYXd3UGo2ZFZkdU5vNXNLaVpIZjhl?=
 =?utf-8?B?L1hydlNOeGJkM0NHUUdUeUdtRTNBN2pFcVV5Skd6Z1lxVWxhZDJzeXZqZWMz?=
 =?utf-8?B?L05HNDlxY05MajNEWDlUcjIwQTJ0TjR1UzJqM0M2dXltVFNMSTg0L2hmOUZm?=
 =?utf-8?B?MFJEbTRKY3BoMVlxSWFSWWNwNk9KTmxqREQrQmNvSDRGbitpZ1VCYTJjWCtS?=
 =?utf-8?B?cTkzMk44VkNwUDVpREkvRnJXSXBSNVdXbG03NSt2NFUxdnBGWjA5YU8zdG16?=
 =?utf-8?Q?d3YgRLUS8gSwq8huHWdByR+Dy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d90838-0c81-4f5b-a9bf-08dc1274451f
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 07:09:36.7528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByGxTCn+sSdQ8ma6llQb4QHwQPWapba33ytaByKyNaqWcyc6IDzK4FEy4tnmKR8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
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



On 1/10/24 22:27, Krzysztof Kozlowski wrote:
> On 10/01/2024 14:35, Michal Simek wrote:
>> Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
>> related to qspi, spi, nand, i2c and ethernet nodes.
>>
>> All errors are generated when dtbs are compiled with W=1.
>>
> 
> I don't see any errors on some other platforms, like Samsung. Isn't the
> actual problem that you do not disable the nodes (I2C, SPI etc) in DTSI?

On i2c node. Bus is present on the board but it can end in a connector or device 
which we don't have OS/bootloader drivers for. But we have drivers using i2c 
tools or u-boot i2c probe. It means that transition should happen.
On i2c interesting is that W=1 is not able to report issues when you have i2c 
mux described like this

                 i2c@0 {
                         #address-cells = <1>;
                         #size-cells = <0>;
                         reg = <0>;
                         /* HPC0_IIC */
                 };

and it doesn't report that cells shouldn't be there.

SPI is pretty much the same story with using spidev.

Ethernet with mdio. I have converted all phy description to use mdio node 
because it provides ability to have separate reset for the whole mdio bus and 
then every phy can also have own reset itself that's why using this type of 
description is better from flexibility point of view.

qspi/nand - we have driver for that devices all the time but it doesn't make 
sense to have some nodes follow some rules and others not.

Thanks,
Michal
