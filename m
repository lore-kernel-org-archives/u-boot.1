Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7ACC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412708718A;
	Thu, 11 Jan 2024 09:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3lmrOpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03B286758; Thu, 11 Jan 2024 09:10:50 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9045D86758
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcnkfBKLNI7+46xBdcyNU7S3NC4yN+ecgLtropnC5TvYyTUa34QYvaAv1ehKA5GtrizlTPOwstvnbz11q884Jx6HOw9L9rVZgdhp5oMUisSeiI3L7E0t97WNqwf/EXktd+smic3tpTTBGn0n9l2GvUKXYjWq2FmBZnq7yg6R4Xlk2gEgA9PEfQSgAxMgElgV/TSUPrmrFdpED1gzwS9i155I38KQ+1L+wW3eW4h5nwKrLBHjGMv0gnssoxP47qh33C5TCCu/jjKFnOAb5tG8S/ZpHuJwmK+TL5eTAWcxdmooJTwlURR0+OWmYZmdaECbGaaIde4bB2UXlUbkBozRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6UnE8OlvBxo9nqMYVw6wJ1LFDdU4UzCvheTflvhm6Q=;
 b=SFiFRWvceWJX4uRHf9JZ1Ac+N/IUIS19ZVaOn5mqfedF91F8tiI8PnSd9g8hFmelkpZk/KW7ePu95Z6as54ROux6bciO9MPr4LUyuzAHIpignh1b19OxdAi1CU/BZ0EEVnZ3Nw6VuGDEH/KSLfLSLFLlwl8ao/oEADmVhxxgDJnqv+JEhXvJQcCFCwpqLMezCgyv4XrNaEaswR9G30zJLdKp8RK8gMhGqLYuGM6mMw+FAJM/X7MpMpnYyCzLjnKIcZfDhznTcHGBZnrvhXHhL3gD3DLipqZhCBFvMnJG/Bmead9l+w1DefD7zFeh0+x0107L/i1f+kcspU6CYewlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6UnE8OlvBxo9nqMYVw6wJ1LFDdU4UzCvheTflvhm6Q=;
 b=i3lmrOpp8PcyvAgt4zLNia04RIhUXlTnKucsOaH3XF6FGpjCOIegyA0ZwJdYlYNYgK6VZBBWOiQgYr5jSd8TzNdNfkz8YkbxtMTv3uSJ5rgVD6Fv6oKYvq/2e5SaeLDZtapxMWa8YUXzkXi8MzT26vL4C8EITToenethz8JC1lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 08:10:45 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 08:10:45 +0000
Message-ID: <606065db-7fb4-4e82-9c08-1829ee81900b@amd.com>
Date: Thu, 11 Jan 2024 09:10:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Move address/size-cells to proper locations
Content-Language: en-US
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
 <d07c9f9d-8106-4bc4-8630-cb36176cdb70@amd.com>
 <ceb80f6a-dd09-49e5-8b4a-e4f6c1e2d0c4@linaro.org>
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
In-Reply-To: <ceb80f6a-dd09-49e5-8b4a-e4f6c1e2d0c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0056.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::45) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fca6026-4730-4d21-8e41-08dc127ccff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjkgkF+Fh1H2YOeVoqKW6F+4G19m1lhEEzUndJ0FLgDo33x0VS4iQqOP5vXTWvuqlwGgIGZP7geub+5M2+2XaqWyETsyq2OMXiScevY/yrGDdDfv/XR4iWXQg2utapQQkkRFJhnS4EiJt/PTVgrdEFg4fDkhPMzmcYOcKj9Eo8uNmS293wM9cVXlr5crbQshhzhtP/+ojg6i4cF5WbQY61Yl7AxkjfyvXymLVYHsw/cwzIMDOpqvq1rkjZf2RAVDI4TGxIYmvaquNSWrX61bzkBC4w3qbHGtSFljDIeNv1405D+ONaYLTdkRjhZ1daDULlLeQ6HCLKLqVa1ab3N124eZhQ6Ko4ABUH+Dy7CvKjfqaoWe7Qwd1XZeCeJN7Dy8QzUXMyhD7nofutD0Kw64lYup5tbEEoZfxWHbUDJA5ejQ71CM3lu9wlFEY3ZkRycGFwXVVxFVbCGKHDwattz+4tC9sbcyYVAXK8siM8WOiaCzkuLAXjG3Dhou3/XBAE98wjzF61Pc3eVZS9nwfqrMeIindDfZfXZT9SVDbVwo6eteyWVwDbmE2/b8jXrvYbd9b2NWVTncmeiJ0uJSsLhDUmibcXeze7NOMOhzgrdxfXYv9v7dEFY4I4LftDqj6TkNFbHqmgvkaUbTY6SjqjqY18r79otjR7+Qb8RQYvCbRCfDmRnmWtur+lseJvQl3ToZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(26005)(6512007)(83380400001)(31696002)(86362001)(36756003)(38100700002)(5660300002)(44832011)(4326008)(6666004)(53546011)(6506007)(2616005)(316002)(8676002)(66476007)(8936002)(66556008)(54906003)(41300700001)(2906002)(6486002)(478600001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpRaHJ2VjloMmlIOUh3RnNOTVdSaytyZ1BMRmppUGhBaytVQ3E0WFd5UzYy?=
 =?utf-8?B?WkRJVW50M3dGSEZUNmViMzdoWUhSSGlkcGp5SXg0WXJ6U1hnNGhSa0lXS1ZM?=
 =?utf-8?B?RFM3TzlicWZnYjVVTnkydU5IYmdIb0dROFNXV1Q2UE9Bbm9aQndwSTFIMnl1?=
 =?utf-8?B?NkV1R1BaMW9sWmlMTlk0T1E0a1gycENZbjdWb3kzUjc5KzliUUJDU2NvZ29X?=
 =?utf-8?B?RnFZNUpyUUpGc3owNlAxMmZNV3BoY3dEbDVmc0hUbytyOTBoMWNOeWdudUox?=
 =?utf-8?B?YVJyVVp2czE5WllCcDk5UVA1YnlXVTRPUUVYZEhzRHJ4aUZjaHdydVJwR3ZP?=
 =?utf-8?B?VTY4R1kvR2xZRlVNdVU2VEo4alpQUy9qM29tYnBjYkEzbFNZTUdmR3NqY3pp?=
 =?utf-8?B?Rk9qdld0N1dXOHE3YWViRVVSVG5OTCt3azd5VW1IbEVYUFdxVFkwYzRvRUx1?=
 =?utf-8?B?UW1BYzJlRi9FUXFsMWp2dEU4RDd4V21pWTBCdWlBMDN3N1oyT1ZSbFNWdGFo?=
 =?utf-8?B?RXoxSkNrWG56ZzRjd2tTdXJ5OHYxVFJ6anovY1A4Q3BlVEh3SHQxeDNaVThN?=
 =?utf-8?B?YmpJWGRsVktGRVgrc0o4RXZaZzVKOGV3cS9EZWNvOFRjZEtvYng0bUJZUnJX?=
 =?utf-8?B?Y2o1QnFvaS9OUDVJRkVWTGpBVk1SNUxnWEwrTDhDNm5SQWJiWm9ncGVSMkEx?=
 =?utf-8?B?VXZPdTlDV0doUUtNZVVIQXpIMTh3TEIyUTNQQUJEZk9wZFdNRytFSHFSUmhZ?=
 =?utf-8?B?WTMycVhBVWdoRGI0ZXNTQWc3c3Nvbm1qU1JHMzJnK2k2L1FkaGxvcTQ3Wmhv?=
 =?utf-8?B?cElLVUJDM0hwTzF6UTJMYlZOVndWWU5BOXIxSzZjYlVwdDFIbFFEVTkwYkpr?=
 =?utf-8?B?Z2YwL25ISEFXaWkzNVJsOVlQZFVKV2JWR1FOWnpDa04yYXd1RUpZeHJnWVFv?=
 =?utf-8?B?cm41ZVIzYmt4a0NraHRLaHk3TWJjTzZYNnVaako2YmVaTDBpT2JHeTJIZ0Rw?=
 =?utf-8?B?eWhBcmV0amtGNjBhVnRaRVk1U1A5QTUrN3RJbFhQZ0YwUWduQkoyMVJRWTZh?=
 =?utf-8?B?TEdERXVGZlVRSzJkWEQwMVRTZ1NVNDFnVE9YVndqYk11MVFSMjhRN3FZU0tl?=
 =?utf-8?B?Mmw5cTZscDFuVFY1blZtNGhjZ1BSUHdidUNtQmlSdmhlQXFsME1NSjlvV0I2?=
 =?utf-8?B?eEtsWmZ1aE1oMWhkWjhHdk9wQjhuQ2JOMGpyd1BuTkdhclNsLzhobkdualNQ?=
 =?utf-8?B?dlZXcEhDZDAxYWZoeFRRU3dDNWJLeDBaSzQyVkZGZlFyWmNPV3NzNm1PUHdo?=
 =?utf-8?B?d0M0Zk9jNjVXTlRDbWdsc2Z1bFoydHRJYmF0S05ySE8yNDNQVUloVXFxRjlr?=
 =?utf-8?B?VWxnQ0lwUjVNS21mcGJhZFAvMlVic0xSZjVIL0xDQWs5MzhkT25mV3dDQlR3?=
 =?utf-8?B?TzNmNDA4c0taSUtMVW8vejFJVmdDZ2V0bXRvQlhGdm85cHRuYkVrOFQ2TXBv?=
 =?utf-8?B?VEt4OEhGTmFhZzBOaE9CUVptQ0FUK1JaL2xOb1BGamFYbGFkMFFHWlBSU1l1?=
 =?utf-8?B?cmc5YmQ4aENIeWVPTFhlWEUrS1pkOHd4S0dsMWt4QVdOVFgrYlgyVXBtQ0d1?=
 =?utf-8?B?VmpuT3FaYWgySi9qeHM0TjNMdW1iL2VMK1NKS1kyRjQ1T1B3UURmckNxOFA4?=
 =?utf-8?B?MnRuV2R5Q0wxTVh2WUdEend1QlVIWWJUZDVGTG4ySWUwSUZSSks1TldodUR2?=
 =?utf-8?B?RTdJaUFUbVBueStLM3VHOHNjQ294dHZSNENoUy9mSFA3bHhLSjZGK3RZRzBz?=
 =?utf-8?B?bGFvd3FwbzNLcllSNElMRy9ieWdoTGg4bE9YbTdENzZIODBsZkNCc0M3SVY3?=
 =?utf-8?B?MHNnTDB5SWs4cURYWmo0b3E4OHphQ3V3Q01SV3lWOFMwdUtwcmxYQU0zdEx5?=
 =?utf-8?B?c2Jueit2NUsxTTZ1Q0Y5anVoVGdOQlg3NUsyTXRxazRSbDZFSVhVUDBZQVhu?=
 =?utf-8?B?Ti96V0VGMXBzL0czTldiVXhvREo5bmpuOXhlNGE1Q0RkVEVyK1lKcXBOM0JK?=
 =?utf-8?B?MXZJVkgwbUNJbzg2NXgwNTh1Z1hXQ09NenJRU25JRWRhY21CUEhmVnMvYTZK?=
 =?utf-8?Q?GaulVWmmCwz76dUgH62nt/Rz3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fca6026-4730-4d21-8e41-08dc127ccff8
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:10:45.6404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFlNW4iBUFp2YcUVuo0iy3+yw1xEfSYJnmzqOzPvDYTI3rJa6/C8XPDDh7yC6hqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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



On 1/11/24 08:56, Krzysztof Kozlowski wrote:
> On 11/01/2024 08:09, Michal Simek wrote:
>>
>>
>> On 1/10/24 22:27, Krzysztof Kozlowski wrote:
>>> On 10/01/2024 14:35, Michal Simek wrote:
>>>> Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
>>>> related to qspi, spi, nand, i2c and ethernet nodes.
>>>>
>>>> All errors are generated when dtbs are compiled with W=1.
>>>>
>>>
>>> I don't see any errors on some other platforms, like Samsung. Isn't the
>>> actual problem that you do not disable the nodes (I2C, SPI etc) in DTSI?
>>
>> On i2c node. Bus is present on the board but it can end in a connector or device
>> which we don't have OS/bootloader drivers for. But we have drivers using i2c
>> tools or u-boot i2c probe. It means that transition should happen.
>> On i2c interesting is that W=1 is not able to report issues when you have i2c
>> mux described like this
>>
>>                   i2c@0 {
>>                           #address-cells = <1>;
>>                           #size-cells = <0>;
>>                           reg = <0>;
>>                           /* HPC0_IIC */
> 
> I understand and it is quite common, but it does not explain the case.
> Your bus should still be disabled in DTSI and enabled in DTS for these
> cases.
> 
> And how exactly do you solve the warning for above case?

I had address/size-cells in dtsi (entire SoC) and then just enabled the whole 
i2c bus(for above reason) in board dts file without any childs there.
Then W=1 reported that there are address/size-cells without child.

Another way how to solve it would be to simply delete address/size cells in 
these cases.

Thanks,
Michal
