Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8994CC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC3287752;
	Fri, 12 Jan 2024 09:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELpobVwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984188785F; Fri, 12 Jan 2024 09:28:47 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC67987142
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYlZfUKx2UUl2ipaqUiTHetfxPOPfQs1GHAKO05K+3Pubjb7BH9YCxxzS3wPcm8+zuKxk6+yWZT7XOGnSWzeNacIU8A4H2PgtrokdoxtSSWbHVRW5/q+fv4pdA9YZDRusYjfotmE8lNt5eN9ywm3rPPGEq4d0LaITiD/RbqBgLRrl1bHAVmP/cvLy+q4Deya1H8rcZPq9YuwA17TeocCzI72IuONBf5L9ItHVcnZJWe0WYi2AKsISVhulHrAN9SFEIpdr6lkk15q61AMkgEOrfDoyEk2SaAC7MyFycm9CNgpsHbodWHIUwUWExLqj64/WxxxFrX3rfHMaxRiA3v7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux5yFavOgl50+FxmrUsMtgvoZJwu2f5CMsg/1eUFVv0=;
 b=NFvSdAbWDA03IfJDjHGJerRhPXdmnPMBmQ9cZKkrx8qwhj2VbqDhQn/2wSm+jbCZ5l4BpnufDfjP/0kjJtTWB5jDIFohDXgoKjY9xzf0vQ22tdDZOCljmHm7UVfPOsQOMKtVcZxB98puRlCkHF1B4cupnB22GvkUqOdbWWmqmErUIsSOskcEBfyliWtpjA4tgc6m1GaeOZ+y917smGaeePtXq9Rkf5Mh+sJGuiINkrDnjPTVSEO0FAE5BSt/xtb47qJUSF+W8sGfN3fbja/jYFo4etj6WbLTWaaxOwAT+bA99/aT6wizeV6uTVQKSvCFbJ7qaOupLWEGAkJv3EkjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux5yFavOgl50+FxmrUsMtgvoZJwu2f5CMsg/1eUFVv0=;
 b=ELpobVwVlqgoHRHz+m00zklxZKVCJSxLxosadCJb+q3KYo8UACnZwh5cQG8VanQxvVOM2tYpen7wb/RTipGHx2UAoSVyROA+P27fDRoYTAI3w5LeD4G++O9dT3kIWULAoOOHUILidsTB53YtNnU9Lt5Mpw6zx8iBuAXaylaeZak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 08:28:40 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 08:28:40 +0000
Message-ID: <ca7aec83-4844-44e1-9322-d07f696e3a4d@amd.com>
Date: Fri, 12 Jan 2024 09:28:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: r5: Include the sys_r5_proto.h header for
 future use
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240111030029.2565827-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20240111030029.2565827-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::29) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BN9PR12MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce06866-c24a-449c-432d-08dc13487b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3lHTwsf9IvivKZGqLzbmZCJkuKqq8k0Zy5dKrMplQBVASXS1WjM0BUTpooIzyW+RtKoVizkjQg5Q9TxuuGn3AeU55qVDwpLjvE1ipDJdEcBpztEpEB1C0VAEKDoFfTwcjAXS9ebNJ9VWwws5T8eQAotmIlNRFn7pMp+To0Q9AdXPJN1prQttNyjOuGi3sEZkHciG+WoLK2jEjnGqaS7to0LVhLBHVWO5D5ma7xER4GEdWNvysJfiNRNL3EQarfLDmXGD72/3uGzdgOkBNa3kf7U3Xu/uA29HqDiW7is8rK6zBNuC5T9EDpToFwbbWtO+5mSMGZpufNtFYj64GRBjq7gLz3B8BGgi7oOn0JaBcLQIGDTrlub2ifX/tX9EJMVfYs+uxtrdaZQ7nYONkvDJEIH8vwRZ2zq4aSzIpnRXzXRSbQFzBz3Bcs+h9bGmg+jslJ9JIx8YynaSYt75mM5LICCGsztTQQU2CyhrBxnpHI3PgModRnbMTk6KWwtjdH1tsOyMXiexFyk/aCQq0ThBYo20i50BLv/43McoymUq7Kf15V3/SYH4HDp+GgNHRy2hs2JvpNYIYr/4/5y3zMvJcR6XG2xalnFHpP5ICMBWB4/7C5NMWEnwA1CExudI/Cn2hf6AssJbh7//d1NSjCf9ApfrBYPIfGK1no1TDbos1A1lco2f/dsFWYI+XGNwMXM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(36756003)(5660300002)(2906002)(41300700001)(53546011)(6506007)(31696002)(478600001)(6512007)(6486002)(26005)(2616005)(8936002)(83380400001)(44832011)(8676002)(4326008)(86362001)(66946007)(66556008)(66476007)(38100700002)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJ2RnQ3eWVVeEF2OTlZeGpCeVNRMG1hMWZad2J4VUlONmZzYnBVZ1cyUDVJ?=
 =?utf-8?B?UW9RWVRXdXMrZUpmRmJDZTh3aUpjSHhROER4UllabGhhUTZvNStQaXRKaFZa?=
 =?utf-8?B?ZkYwNFJneFFKNThwZmwwd1J5RW9nWE1tMlJPN0tzM3VTVW5tM29yc3ZYbm5s?=
 =?utf-8?B?NzVLQmFGcUgxTEprQlVuazlzZ0dqSnBtRyt6cmU1UkNYUytDOGZwZGI5R2Zu?=
 =?utf-8?B?T0xCYlM5WnBXVC8rZFUrd3RzN2lUc0ZGNUJVeFNEQ3VnOWlEa1JzWjd4MHFG?=
 =?utf-8?B?QkQvUkJGQmRpQzBET0VxODFPMVdsSlY2ZWl3MnhycjRKcitmcklmLzVsOWJh?=
 =?utf-8?B?dkE0QVF6LzEwL2JKNnNVTmVBZ3JsUWVaZ05ON3RlK3FhUmZWWWw0UjlRQVFt?=
 =?utf-8?B?aFFWQ3JDUjVTYy9ycEV5b3IyK002OHV0UnZqNlVtMjgyWHp3VktYRGVtTzRR?=
 =?utf-8?B?SlFuUzJIU3c5b3FOZWVwSEhHNjNiRzV2QkxkclNwWU8wWnorWEtvZ1FrY2tZ?=
 =?utf-8?B?U0NjU2pCV3RjQTVhQ21YQldFckpGalB3SzgzcTFPTm9CaTdSMnE3azRyaEVB?=
 =?utf-8?B?TlZETlJWS241QnpKTzUzb3BrVkhyRlphQUJmRDdXTXJNcm5pK0dGMHhkMUFn?=
 =?utf-8?B?ZEdUdkthL3UrN1Q1Uko2QldwNUFLN3BmUG9Edlh4NWNQZFI4VzQvQ2pQWkVK?=
 =?utf-8?B?ZnBMcm5Ib2ZCcmxCeXJLQThqM3pwQ1ZzL052N0RMWWN3bzhPRy9xK2RFYXdG?=
 =?utf-8?B?L0F5ZWV2RzFvcFhuSTVqREZiQTVIaVpLb1dzSzE0NHRWYmhVUUh6MVduMGJr?=
 =?utf-8?B?UW9vVVNORStBQVdlMWs2S3RLc2c4Smoxb3MyYThyZFhvMjVTWktEbUdRUjAx?=
 =?utf-8?B?SHZhR2lqS1YxVkROWU9PTUZzaWdmWVh1UGF1OWphQUhlQU51U3ovcTNpcm5C?=
 =?utf-8?B?cjB6YXV0ZEF5N29idldzamZMaCtGUkFVZUl5S2ZrVWJiRlB3MWJBRmphMVpH?=
 =?utf-8?B?SEROZ1JKMVJDdkJoVGJNQTQ1bldpZnJCZEpSQWcwWG83QnZONFUvQjRZR0Uz?=
 =?utf-8?B?bHZ6OUdtRUMwbzY3c2xmemgxY2ZCSk1hd2piNVdvcVVZTmczSXlhMzJrYzlK?=
 =?utf-8?B?REVTNjZkbjRwQjRYcHFpbmd3MnN6RjNoQmRMRWxqYTNZcEdYYzVYUnNJa2d0?=
 =?utf-8?B?U3ozWndDbFZsazhKT3BqeHN2Tnh6enJLMmd5VVpncGhLN2F5c3VDVEdYd0VD?=
 =?utf-8?B?UVliZUo1MFRTVFQ1aysvWk95NmFZWmZWczc4Q0hubmxxQXo4cW80anIyby9Z?=
 =?utf-8?B?K1RBR0RIZjZ5MmRDNUNBTjI0MHpvcmtkMk1ud01HYlpiT2ZVQ3pDTytmbjJa?=
 =?utf-8?B?NVppV2VaSUtCcyswZVgrdmNFd2ZCYUY3SnprV3JBYlMrdWs3WHR2R1RqaEdw?=
 =?utf-8?B?YVhIQy9EbGhtVDdzZERkblZsUVFnRDlQbGM0L0dGUVp5RE8xcU12RCtaN1p4?=
 =?utf-8?B?OVZhdlBwRWN1cG1aU3VNQnNtWVgxL2hCcHNhR0szRno4a3loeXNSZU04eXo2?=
 =?utf-8?B?NklaQXVkNVdjNUpSVEhLbWE1anFvdkphZXREZ29Yc0ROdGJsTUxKSDZtNTlZ?=
 =?utf-8?B?QjNSVSszbmFUaysybG5sejJkcUhHcUdKd1pOcFIvWTZJakMrN1F1YnVhWGI0?=
 =?utf-8?B?cTBhRy9hdHMwRk5EcjFNM0l3OVU5ZjZwcndUR2l6K21Md2FpcDBPMFJkWmRT?=
 =?utf-8?B?L1VCVmtsN0taVkFlbndybkRINnJyTkdDZjcvaG82R05VaUx3clZEcUZ6NTZv?=
 =?utf-8?B?U1BuaUYwZ2NGTGxDKzEveWV1M05UUWlDbVVYSHM3M0lZa1dNcTV3THpPMVZQ?=
 =?utf-8?B?bllBdzBGRXhlNXpUMVF0WE5NYVJRQXZCemNCK2VHYU9uZDM5bjljbkFrcGt2?=
 =?utf-8?B?UG5HYjBqc3E2QkIzMGRUYTdZcktPMjJ5Ti9BaVd3bS96dnVwMFkvdUt5VGlt?=
 =?utf-8?B?M2hFekY4cjdjMmtjT1p6QWNVKzYvNDM3eUlRWHB2RXAwcUN6T0lUS3EraXlr?=
 =?utf-8?B?SnhCWEVmZnlKdU9rZ21yS3FMNTJvNGdpemNDWVdQMlh0V0JRRFhGRW16VHZ4?=
 =?utf-8?Q?Lxz+E0zuLA9ZJbqqafvB2DUIV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce06866-c24a-449c-432d-08dc13487b15
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 08:28:40.5529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2N4tVRsJ8v13l2mEgESlL3VNBfIgSCrzEg2QqBtxMU7OBaDpKIDIKgcr3bCpuP5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
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



On 1/11/24 04:00, Venkatesh Yadav Abbarapu wrote:
> Currently when using "W=1" with xilinx_zynqmp_r5_defconfig, getting
> below warnings.
> cc1.real: warning: ./arch/arm/mach-zynqmp-r5/include:
> 		No such file or directory [-Wmissing-include-dirs]
> Fix W=1 missing-include-dirs warnings by including the headers and
> sys_r5_proto.h file which can be used.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Fixed the copyright and other minor syntax issues.
> ---
>   arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h | 5 +++++
>   1 file changed, 5 insertions(+)
>   create mode 100644 arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
> 
> diff --git a/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
> new file mode 100644
> index 0000000000..0f7a47bf24
> --- /dev/null
> +++ b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *  Michal Simek <michal.simek@amd.com>
> + */

Applied.
M
