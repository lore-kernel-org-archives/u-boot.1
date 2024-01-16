Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1FCC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 12:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F46878CA;
	Tue, 16 Jan 2024 13:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8VEpWzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5503C87716; Tue, 16 Jan 2024 13:46:43 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D888487716
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 13:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikg1sevHJLjL3juV8WMKiTLm0Ez5XMhntZF+uC4WoGdxdDZL1/fTJeKk+PCKEBR7e5Ge4ILg222yAFvTfER+KtgIbtTxTEidy3ZiOTsZKrvKU5wJdSkMgYeGxuZX2mavoVAx6Xu0zZG6ndU2kFyTA8jVmxNyBRqgXRYuOzujipcsNRkDFYQnobhh6kEVXywtFzDE04d5sJ7AUUeqfPIISKC+tU3FhXvVM7Lf+eTcjKkYY2Ua1J2719Dz/htqT/UDm3Midb2V6Pq8y7kaAzr3Dvny6Xrd9KCVrzkXOqj9WJjiior0Oa3Cw5PfI8My4vnN1Kq5nztgLFadc4p6HDoyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1D5Kp5tB2G54d+yMmUOaNqeTejfvvStzUC1F4gIf9g=;
 b=Gb7A7V8c8Iblwg9gGBlUjHL4V61+5PfSJAqMS0xGnyWLPN0u1wloEtcTu34jZZDjeWn4F773nQ3dffJdm1ozgkA0z/TTx94r509yOMyy9dkPgp7jberB8V2LrH0dPOnUTFR9QYR5cZk7pnXs9NeXvBZnEsb0yNYS+ZQxoPlPBfj0wL5CIDuuiso8RK5KVbuzB+SthsQoMPyhUfP0Ws1QDeO2zP9CE235t6O2zcax71UrNpBw4Ld6ErPsy9x/FwV2mzKg1KoAv3aQHTiTDKOOXLexd/eI8jEKf1gdoLQwKCDhsaNPf0UlM//JqjnXDf6+bCXvwiaOjZ301Z1oYD4Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1D5Kp5tB2G54d+yMmUOaNqeTejfvvStzUC1F4gIf9g=;
 b=X8VEpWzFGNjrh2C/Lf6dqvaNWk+1aftg4tv7UGwmCWATXMFMJI78KDj8OdIAOpmxW7hh7xxlfgSsVlq+y6f69ENqtSFSsdnoB7n7IiFhNWj/J6/FLvTeNNjcxlSqH/Ef54VRatmWdL7To0wqi8F15/+e8PZw2Ixg21rVqmLuVxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 12:46:36 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 12:46:36 +0000
Message-ID: <ec7eaa9e-1fe2-43a1-810c-2525e9c86ced@amd.com>
Date: Tue, 16 Jan 2024 13:46:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xilinx: board: Update the kaslr-seed property
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240116045023.580837-1-venkatesh.abbarapu@amd.com>
 <20240116045023.580837-2-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20240116045023.580837-2-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0086.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::39) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc65184-1ef8-448b-4aeb-08dc16912cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R53w3VFbFX6t2RoOW3jy9CnBdU0csL96TrAmcibGxMsTPpP4z49PtBs/1rJRPuVnt5yW8jdVn1CypyDGgXGbHbMLG9VADGfFKSFzaUQRGIcUgzcuy1qaJKD8FijN1SztX+cE0Z58HDid0OP9y9c/AIBTFd/5USo/uU0Y/YjKI+IWPvhFbM/4BZ//ERDhuQa20SPrsMr2IdRi3UB7Gv6nnYbfvyEwZ0I2u9WJ/GjxWadU9f2hTLtP/rfAWgo/6NCxdj+uBIOCiajN55aKzaD8OPShIRAE+uH52n6Kxd+hVBaREF6q++5NyQmb21BYndPaUO91gD5LK9IEQ5uDTtbm9a3lww0le+2j7ncEldwGtMbc66qw3rfLrtjQVddJhGp2r6kKUoGFMyLG9Wf+t1BRlZ2Gxe8VtC2Lm8kAbXoqA0jntExeDgM2dmnAKuS5wOqjqhAW2TrLSA88bbuXCfK1joP9r5S42K+CFcPfgrSmlG8GaRM3+Q48Az9OFWv0LUeNNeg5D/qLFSyJEURH937ejdERJMkdQ5srEY2nkhR32oDWWx858DAuNT5xetQV1AhREBzIS0xEfDtciQgki17Za99JIhSF8OCXiasRuoTVM75kFDQO/8X+o39+/7d0Uf0GY5+2oUWDJVMbjYrUDclNqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(2906002)(5660300002)(36756003)(31696002)(86362001)(41300700001)(6512007)(316002)(2616005)(66476007)(66946007)(66556008)(478600001)(6486002)(6666004)(53546011)(6506007)(44832011)(26005)(4326008)(8676002)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTk0TTBDY3NkeWE0blNzTlUwcFZVbnBZUmpxVnZ6RU93RjNxaTdocXcyWFJz?=
 =?utf-8?B?bnNLL2NkTjA0VUxRWG9MZlBrMmtjYXNra01yNGNKRzFDNktXVkdJeHZhL0dh?=
 =?utf-8?B?T3Q2N0ZEL2ZNcGVuQmxTWVRYTjZDTndLeitTTm9lenRWZGFLTUpmS2pua3lZ?=
 =?utf-8?B?SHN6d2FIOGg2elhEeXJNQlBjTW1xSll5YWgzWEo0bTNibHdMOXQzNmtycnFU?=
 =?utf-8?B?bW5Qa1VaMTNhRDQyRXhwU2Y4eFQzMkhwdURDbXJVZkNrbnJ0RWlGR2ExaEFk?=
 =?utf-8?B?RkVuOFNTaWdtYVYyeE9xNU9uS1RKZ0RFazRJR2Ztc1NBNXFmKytzNWV2c1py?=
 =?utf-8?B?OXNsM2V3QnZEVUxpOGt1SGhFVWZtYmlQWDVzS0dDbk1PdmppSEpEcFF3WFdY?=
 =?utf-8?B?SitMa1pIQUFneXAvWDVlbEhxR01CUXdHQmZHZ2lOTlpSN1ZIa2xpaFRsMVBO?=
 =?utf-8?B?WVllc0NzdkxDb3Q0MnJKOE9PYkxncDh6RVBjN1l2TUJINk1WUmN0MlZ6U3BS?=
 =?utf-8?B?NGJ4UkxXMkc1amdTelNsU25BQWNrQW1uQ2gvTklwVENFZkRKSkJpeTYrWW0x?=
 =?utf-8?B?VjAwaHNRaG1pR0kxN1o3SVpBWWpaZmVkYkRFRXR1RFdTbEFsVzlrVXVDT1RX?=
 =?utf-8?B?ZU4relNIQ3NvT3QrdXZZeDVHcHozek9Ed09zN3VFWGRteXBuV1lrSW5aWkd6?=
 =?utf-8?B?Q0JXYnBTdTU0NXBJWlhybFlsOHhOR0k3ejl5YlhacDhoSDc3YmhWMVZ5QUNW?=
 =?utf-8?B?UEl2Vm5hMzVSZWZ5RmY4TEtHMTRVbEIwd3ZVbnQ0V1NJTHhjZ1RtNCsvcjZQ?=
 =?utf-8?B?VjJxa2JQT0g2eXNIS1hKM0VsUjcrL0xGOWlsVXUyNjJqcWxZcVk4LzBHdGVZ?=
 =?utf-8?B?eXJrVjl4enh1VXdzeW94VFU5WnNZWlc4dmNHNWs1SkcrcUI1L21KQUsvQWlh?=
 =?utf-8?B?dEZnNjRMelpBWUZWTWNjcFBwckNBOVY5UyszeTUvMUN5b0gwT0t3RlcycFIw?=
 =?utf-8?B?eDQzNE12QXFzMDNWSGlIMENzWjR1bTc5SFgwbzlOMG9WNkM0TVdSWHdqTmtM?=
 =?utf-8?B?VjBMRXVLaHp2MXphdEJMTmVlNmNwL3VKdmV5ZFlkc2JKNDNTNDNEVjQ3SWJo?=
 =?utf-8?B?VmNWQmFLQlhXRjlwanNBbU1meWFRd2ZEZ2FlN0FkL0JCV0VaUVpjOEZ3V2h1?=
 =?utf-8?B?ODFVL3lVMFQ5TG5zT3gxaHRxMnN3VkRmOXdxU3g3c2hxZnJoTHhSREJpL2Zw?=
 =?utf-8?B?MDVncS85OG9McmUyYXI2YVlCalEwMDJhT3ZuMEQzTjFTZ1ZGT2ZkbXNqbWJ1?=
 =?utf-8?B?clFZelREaDVoMStEZTZDRnd2NHFmVU0xVnhXNWNCN2FhbXVQWmxlS1V5Q1JI?=
 =?utf-8?B?RVdUQzNLVWNiN29CMFBIZ3F0eHYwblhjTUl2QWwvUEc3TGJiYXU1bkh1SFd2?=
 =?utf-8?B?Nkl3ZHptRUxERDZzd1dJZDBYUEZHdHVYRmhQWUdaNFRqc0Jsd0U1cURrODlJ?=
 =?utf-8?B?WklLY0hCMzNJS0hVUW52eG5ncm1wQVBiRkFhSnFLdlB3MCs5TlI1bE5QOGxi?=
 =?utf-8?B?bkNKUm16TXd0cUUybU5TTUp3d29qd1pYajFhVW0zZW1HeC9ZTURNWVhoVmhI?=
 =?utf-8?B?d0lsMmppWitnTGNIQlNuVEYwUWI5anJMSFhqWFdMYmNucnZSZDBWaWNpRVNV?=
 =?utf-8?B?RDJXUElxNzh5cVkzZDFaekJDYzZnRStmN0lpV0JMSmtLQkQwQmN5VEJ3R2wr?=
 =?utf-8?B?NU9NSDBBWUk2L1hOMmo1UDVhaHJ0dDN4aCtTUHlQdUhQcTBaZmw5R2trRWZQ?=
 =?utf-8?B?azlHU0dhM3A5WDVYYVUvSXJ2RXFrWHN1MnRLVEd1SS91eVl6a3hPaU4xd3h5?=
 =?utf-8?B?TjV6amJHNlUrUVlqNFhPcWFRLzRzNktpU1g4RHZJZnJQdVlXc0xDZWx1MWhM?=
 =?utf-8?B?M3FzOUNQNTRxeHVnbG1IRFBtdW1qRGpFVTk2VTkrUG5qNGdUWXFaSmR2eFZh?=
 =?utf-8?B?eXlDbC9PYjQxTWptMjdEcFU5RlE4VTV6OTJ3Vyt2RWFVV2dnRWQ2TkJnWEsw?=
 =?utf-8?B?WERvREtyUUswcWUvMTc1RVRKcW1mb1BGRHFydlJ6b0lWVGFuQ253SitGYW5i?=
 =?utf-8?Q?ht+PkpGuxS3Q9qbG8k7Rd6AK2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc65184-1ef8-448b-4aeb-08dc16912cf7
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 12:46:36.4713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtQjm0LfoBorUt/Nx9Q4Ctmpp4ySNqYc4rES7UMky7inzkuH9nkzwPR3eNnR4APp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397
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



On 1/16/24 05:50, Venkatesh Yadav Abbarapu wrote:
> Create a ft_board_setup() api that gets called as part
> of bootm/booti before jumping to kernel. In this
> ft_board_setup() callback that will inspect the DTB
> and insert the device tree blob with the "kaslr-seed" property.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/xilinx/common/board.c | 50 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 12a877c715..2796d45351 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -25,6 +25,7 @@
>   #include <i2c_eeprom.h>
>   #include <net.h>
>   #include <generated/dt.h>
> +#include <rng.h>
>   #include <slre.h>
>   #include <soc.h>
>   #include <linux/ctype.h>
> @@ -682,3 +683,52 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   	return reg + size;
>   }
>   #endif
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +#define MAX_RAND_SIZE 8
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	size_t n = MAX_RAND_SIZE;
> +	struct udevice *dev;
> +	u8 buf[MAX_RAND_SIZE];
> +	int nodeoffset;
> +	int ret;

put it on the same line.

> +
> +	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> +		debug("No RNG device\n");
> +		return -EINVAL;

Why did you changed it from 0?

Pretty much this change breaks all current SOMs with saved variables because 
most of them doesn't really start TPM.

I would say return 0 here.


> +	}
> +
> +	if (dm_rng_read(dev, buf, n)) {
> +		debug("Reading RNG failed\n");
> +		return -EINVAL;

return 0 here.

> +	}
> +
> +	if (!blob) {
> +		debug("No FDT memory address configured. Please configure\n"
> +		      "the FDT address via \"fdt addr <address>\" command.\n"
> +		      "Aborting!\n");
> +		return -EINVAL;

return 0

> +	}
> +
> +	ret = fdt_check_header(blob);
> +	if (ret < 0) {
> +		debug("fdt_chosen: %s\n", fdt_strerror(ret));
> +		return -EINVAL;

no reason to make own return code

return ret;

> +	}
> +
> +	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
> +	if (nodeoffset < 0) {
> +		debug("Reading chosen node failed\n");
> +		return -EINVAL;

return ret;

> +	}
> +
> +	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> +	if (ret < 0) {
> +		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> +		return -EINVAL;

return ret;

> +	}
> +
> +	return ret;

return 0;

> +}
> +#endif

M
