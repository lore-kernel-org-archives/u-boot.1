Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71E6C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C486875EC;
	Tue, 21 Nov 2023 15:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2otAC+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4897387572; Tue, 21 Nov 2023 15:29:42 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE1C0875FD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfyAZpgR9f+YCHEA9AncF6Hou2Bf5kgq/SBMDUBs9AMPDBcvVh7KXg4VbVTzCU7lYovVLwGG9WwnjXoIMwjyn0iCIiD97yIl7sQFd6ZL85Yg5r4RHMgkZzYWZUsKVKLGh32T8qVKwkVi8l2C1DRt2Nj9KvBtsuUVpeFPM/TjUK6cg8u9zcZBe2ucP6PXppDeSbaaOO/w6K/0RNlMYmPqevzpw2BoB9DDGJtzy9bgkQZ9j/rv3eootx7Kzvvt1y/J9s2c37r5it7EfpeIaZ+u4/wOmUvRxcriTOFUfLI9LFtUK7W3KcEq7WxCT99cZoB/XC3+YSiYCxog4PumKAcxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqoRy0iIZdPBJ5qQoEq8aARpT0heXcX5bRH0gUlgpJ0=;
 b=N1lrk+JXA/CQ+BpIuGox/qXckaQzpGgMn63b50h9CBF8HE2vl/MD7+CW+3pm9Qi/Uovl4pce0eeLBw6IR0F47Yvq/tymE/eQmr6MBqPnJHHMS6gZqrRTNMaeUDYIUUSiQiky8w0cFzjjvGiRNoSe+EKvVolyL1kHMP+dpt+sAF1mPnfgFtrsgvmtHCH48J9qCDw2qeh/wEaSiUIwRijA/1v8EZL2x5wG6OdYWAey7yy3Q0x85U0ZndQOj3D643GWb1zttXCLz+PGuu/qBXv+ovGP5HUGM4m8LJtYCXM3ljM1bjjK+7SugiwgY6JYf1CLe/tD6XEfxU5fzeqFm2Q89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqoRy0iIZdPBJ5qQoEq8aARpT0heXcX5bRH0gUlgpJ0=;
 b=t2otAC+8aBSPs8CjYr7K5S+d4hpPj1YdsQ4xWovQIU7wrosr+t6qiZQT3qjUa32Sfy9kZPabgueSZ9P4o8to8T+ekrCaVxZFnIf3+7VfIwyD/HgC3bvOrJFhL8YIvDXYIWvL2UMA8zyHegld258Dmc38XLMyUmdouD2ov60Nx2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 14:29:36 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 14:29:36 +0000
Message-ID: <5cb70327-1a2d-4a5f-9a16-0276d330876d@amd.com>
Date: Tue, 21 Nov 2023 15:29:32 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2] net: axi_emac: Use reg property for DMA registers
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231116164024.139934-1-mchitale@ventanamicro.com>
Content-Language: en-US
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
In-Reply-To: <20231116164024.139934-1-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::38) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f25d2e-ef54-4f63-59e4-08dbea9e4991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/Cp6xu599ir/Jb8Nfp+UmmgRPeuToDq8wEik6wTZs//DU0MLUWQcJDj8g7zThQ5ka/SzoerV9YIoNPB0p1uwi8fPJo6ADJylCVwzGWWSLZjdwBYCXZIZ/p/zy0/3O7X/d9zu9gWzCNXAHb9Q/CAdK53Th2h7bQT0Za7323fm7z/AbBNt5pKlXjjH8224+AYMIBtEJWxVEurHw7UcN6BZGJSClmXoUs/Imv+8Cr3cXDYzmMy0CKfk0ZU5CGQKezHUV4NQ7s0RoF9cLkGunp9vKmlNdlio7thYbc+hIL0vx6n4ZQ3vY5zRhSVMsZGNBaYFuMr20zvoioCL4IaFUoByC5ZG7U4uSflfI3tnpwK5l1A5k3XDkntdluQZ6NnmdOvEhupBGBGbjVN4SSYsTzWU+S2ZMzt1W+KVGs8reZgWIABqiNRQPGct7yiIVKbKZrpc5YEGbkhLS9PhG3wD7LINLcZGw9Zq3lsqV/acdH5lCRSj3ulzsKibIt4xxsSsUPafPfo6P0B82gBgXbm6sZk/nLq8+WtjD84mIIei8mXonJAYJlB1/c9wpLOO/RfrD/6fTQt0DsxA3Ome8MiWd7yjMQpMG65FWc0UL1XYtfUcL6hQ1yyQEu9mIDgaIW2lh7XqAWScK2EPMG3d/kL6xEjww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(31696002)(31686004)(110136005)(6666004)(6486002)(6506007)(66476007)(66556008)(66946007)(316002)(54906003)(36756003)(6512007)(53546011)(26005)(83380400001)(2906002)(44832011)(478600001)(41300700001)(5660300002)(8936002)(38100700002)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJDUGJrL3V0SzJGOTNzb2cwYzNmS0Fpa2JGdWlsMW5iMm5rL0VDcmw1a0lS?=
 =?utf-8?B?bWZ3WDBVV01OS0FZNk5JVWdrSDlSZ3ZrRjdwRUxmR2hzalZ1NE5xQi9YWHRP?=
 =?utf-8?B?STlWbWM5NDFUd25hRm9UUkdKdlUvZXZjaVZheWxUN2tvYncxWG15RTBTZGZx?=
 =?utf-8?B?U1RiV0NJQkZOakpuM1FYWmRrbk5jbGdJdWduMXV3Y2RFaTZCOGV0bDdTdFV0?=
 =?utf-8?B?UEZoR2h2WE0yaWsyTjNjYXFSNmZhYWVDTWdBYUZnQ0dCZTNSUWcyaWJYT1hs?=
 =?utf-8?B?Q3Y0bGhkOEowMWs1bjllMXFiSWZZN1MyR0ZVeFJOTy9rRWExT205OEtNMXZQ?=
 =?utf-8?B?WitVRVRySG1HSGtzdU93cnpQaU9NVlllQWJ4Ukd0TUliK0orTWFyWGN3S0h2?=
 =?utf-8?B?NVhnRkNweXZSWWpNbTRHa3FCcDVkMllxeEhLK211SmlsMzhkcElhKzE0OWp6?=
 =?utf-8?B?UmtnbjZmZ0Y1dlpYMFR4a3hKelBna2xzZThGK3ltcGdWc2lvV1IwU1I5azU0?=
 =?utf-8?B?N0piaC91cjZyc3crSjJDOXZSaVNrR1hTTk5hcUxXb2lFR3Z2TEJtWnFIUzBQ?=
 =?utf-8?B?Mlk0cFFNckwvaGd6YVl5eDhlUjhLbk5VdEhkRUtZRVhwdGpseXN0dW90cklY?=
 =?utf-8?B?QUtvMWdSS0hrWHdWdm9XejVCYUp6ZExjUHZ0aitRc2JtajljWGt2THdYYlQr?=
 =?utf-8?B?NzI1SFhNdWttcGloY3pZdURONWkxOHVKcEF0eCs2bXVYeWlwVVMvcnB5SFZZ?=
 =?utf-8?B?dXVYcFZiUUY0b2Vib2FXakprMFBnY3VPc0JjK2JZSVgwK1NQcSt3ZHcwZ1hI?=
 =?utf-8?B?amJmVmRtWnRyWTJnV1Y1aGpCM3FoNHRXZ1pUTUtnamFlOVhlY3ZGc0dHd0sy?=
 =?utf-8?B?UjdxMnpiUHUySUpoamZyaUpYaDNwVWJ0MVBCRUluK29aUVBmUjN5eXlZQ3Jv?=
 =?utf-8?B?ZXdZZ2dmc1R3WmkrUFAraFFPMFJvdGg1MmpRQ1MrSUpwMDNoYmxFNGtYOTd6?=
 =?utf-8?B?ZlllZGJjUHJBK0hlTVR6OGF4U3hhaGJsMVREM0Z2SDBUcGJkWHlPTDVybE5M?=
 =?utf-8?B?YXVIeGRvYUJQbXU5c00rR0NnRWdia2R6NjhyUnhDb2E3bXNGM3ErSXdHMS8v?=
 =?utf-8?B?bzFpVEt3ZnVxZU94dE44UlptVmJlaDhCeXhPM3NyZjBIZ25TN2JhT1RWQTdD?=
 =?utf-8?B?alNacTlVQ1pzTWFSSzhKbkFUbGJTUVJqc3JQVHVjemNmRHBIWlkvVXNSNkZz?=
 =?utf-8?B?WU0yZ2J0eHY4aVhEMDBISU16bzFLNzZwMG9jNitRd2hsWjlwa2xsY0ZZQk5E?=
 =?utf-8?B?akhsMDdEb3ZwY0FkM08rUG9PazhRWFhIeDllQk1qU2FGU1p3Q3g1Y2FkOEM0?=
 =?utf-8?B?MGZ4b244QjVOTnp5K3BGNit0UTI0YnhpQUN3eEM1cm5KUzUvRnFiZk93Sy90?=
 =?utf-8?B?Tk9qc3ArZldOOXJkUzRjUGhjYUpaMVR6YVZOdXIxQnBVbXJ6YUtzWnIzZkhm?=
 =?utf-8?B?Tmp3UFNSc2NXMERFTE9qTVRUSDJjVW9FTUkyeWN4Wit0VUU4dk4rM25hMW13?=
 =?utf-8?B?SFhWQnZUMHlvM3gwcEdoT213NjI5MU9VZHU3ckYzazBtdjJtMEZ6WWM3WUFu?=
 =?utf-8?B?TW15V0xIMDFCVnZrUTRQSEcrQjhsMFdzU2FYaGRMTUdUNlMyeXRySVd6YmN0?=
 =?utf-8?B?NnNYRnJZN2oyK3pFbnRrNitEckJ6eVNiYmYvSUJkcDVvdXhLZ2tWUnV1VDdY?=
 =?utf-8?B?VTNnVE1OMUc2MEl0Z2FrZG1wczdGMmZ6enNjd3Y5S0U1QWVSdnBXNlFOOW9o?=
 =?utf-8?B?SGtKQTNSa2lhd3l3djdoVEJmSlBZcDdkaUNCNE9kc0U0RUFCaGNZeXVodHJt?=
 =?utf-8?B?YWlLYVRPUU5JVlFnbGlkRS9EUUlNNEZhdm4wd21kS2YxQy9DcUp0ZnJwK24v?=
 =?utf-8?B?Z0F6OHgxOUx2cFJraU5GeEVVQ0pYMnYyM1ZQY1JqcE9OTk1iMGVreWZYbVA3?=
 =?utf-8?B?WUZ0ck0vWEZSRVJqUXVIbmhranRiV1dZZDg5d1BkbXkzOXE5QkN5cVZ5ZFBu?=
 =?utf-8?B?MWNJZUQ1NHZyU0hJTTZRTnZHZmpuTUVEYzVnTmdyS1ZoTUd6NTJ3YTVJNm5B?=
 =?utf-8?Q?XjodboqOxneJ/tqpzNP8J/AXu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f25d2e-ef54-4f63-59e4-08dbea9e4991
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 14:29:36.6822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYBdsvr20tg5x+dI9bF1Cg9QwZsYLJIdzfQK5GvWKyB8FckRKz5BB5V4FRy09B8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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



On 11/16/23 17:40, Mayuresh Chitale wrote:
> As per the xlnx,axi-ethernet-1.00.a DT documentation in linux, the AXI
> DMA registers can be obtained via the reg property or via a separate
> node for the axistream DMA controller. Currently only the latter is
> supported, so add support to fetch the DMA controller registers from the
> "reg" property.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> ---
> Changes in v2:
> ====
> Add Reviewed-by Tag.
> 
>   drivers/net/xilinx_axi_emac.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index 54f2232768..ef151ee51b 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -903,12 +903,11 @@ static int axi_emac_of_to_plat(struct udevice *dev)
>   
>   	ret = dev_read_phandle_with_args(dev, "axistream-connected", NULL, 0, 0,
>   					 &axistream_node);
> -	if (ret) {
> -		printf("%s: axistream is not found\n", __func__);
> -		return -EINVAL;
> -	}
> +	if (!ret)
> +		plat->dmatx = (struct axidma_reg *)ofnode_get_addr(axistream_node.node);
> +	else
> +		plat->dmatx = (struct axidma_reg *)dev_read_addr_index(dev, 1);
>   
> -	plat->dmatx = (struct axidma_reg *)ofnode_get_addr(axistream_node.node);
>   	if (!plat->dmatx) {
>   		printf("%s: axi_dma register space not found\n", __func__);
>   		return -EINVAL;

Applied.
M

