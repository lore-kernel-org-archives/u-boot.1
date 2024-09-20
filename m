Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC27EC7883B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABB389205;
	Fri, 20 Sep 2024 15:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5cKgncBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7DD8919A; Fri, 20 Sep 2024 15:00:39 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D6C89205
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNCoHVav0lnR9HoRCKIOiFPgnQkvXkY4FKSnyjPhIXqud81JTBvx9fPSQadoVId0CdKWr/9HE7tassqYfM2zGN8tY7Qy3rK5aJfzWnQY43hWct6JEbbUcWFNns9RIeJ5g7Z9Ng/RjKD2u3DDh5uGiUWGB3In968H5uorQzqMyXbOCFMxmeQqzYZIRpNyU2YnjJPu83zlQa2XiCpGBTJ9VuAYjFnow3MqJBEIgvuCsomy3DhbE1oJzsg0cgJye8QYDH2/XnxTtqsBOWvjFvsJ0yrms7MkS3/xnpH5oJEDzItBHXpm7oETRXGYhKjN9sfTp4/iUL8Fpc+xe+fAzB6hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HvOY/vsGrDWdRfxRmOWXU+5K1i1XE/xtdrDZXpamds=;
 b=ifz4/iRjkNxrvA8wxksUcZM2cuqCVkijM3nXY9tgd6qAfyFaZHpyyhJu5BeE88ednuZyj+8hrTljpKzCuWnfIwdN5oHr2EIUMBTQNbYMLFIHDAHdvk0JjhkrIgi3Qq5UCoyp/ey80cFbGRZcHLi6K5CCX/YRRxsbL8yBr8mmRc5hESZ9FtW3p7G7J7HxO76h0MfJ+wh4uQUXVlia51rvJcgbCZZesuLun+VQWZUkxCcz/oB1RdFrqMfxmy9hLYi9J52atNnQIUEx8E4m0wZTTsTNVSYd+kuoJT2nnCiSZjfDImabv4/6bM/XdSTHUNZ4xlNiroKpjZNC3cB3QXYsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HvOY/vsGrDWdRfxRmOWXU+5K1i1XE/xtdrDZXpamds=;
 b=5cKgncBjI86S2hSNPKPHxslvnsuqcX652R8752345ZD5n9whZWmZr/iKkTpZinP+Je9oo+Pk6WcZuEFEIafr6vLVX9LlTBI0muNKV+rY8QEZapXaejMsrjq33rfQStcBHbIYc3lqxLu0tzVh3N8iCigA1s2U/s14efrFptpGUDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 13:00:33 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:00:33 +0000
Message-ID: <f75d8393-3009-4ad5-b573-6413aea3615f@amd.com>
Date: Fri, 20 Sep 2024 15:00:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add missing vc7_xin fixed clock to
 sc-vpk180-revA
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <4904f5e0aab8a0b0c2fcc1912be493d4185e6173.1725881047.git.michal.simek@amd.com>
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
In-Reply-To: <4904f5e0aab8a0b0c2fcc1912be493d4185e6173.1725881047.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0034.eurprd09.prod.outlook.com
 (2603:10a6:802:1::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3dea39-d351-46d9-8b12-08dcd97436ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWhBWSszcVZWYklOVlp6RWZGY1EvV2lCang1MFRQZHd2ZStKYTVHTmt2Wjdo?=
 =?utf-8?B?K0JzQmhUQzNiWWhKd0FmdjlLUnR3TEJ2ZjJ3SDVlakNJUXVtS25rQWprRDRp?=
 =?utf-8?B?V2Jvc09qaFoveGhtbDJHTDJjbWVsaFh2WU0zcFptNTlKK3ZyVmVFQlRCVXdy?=
 =?utf-8?B?WXhNcDY3eUJhcjdYeFZPc2JWbFdUejE0eU0xT3JEQlp2YVh2ZGZ3YW05ekd6?=
 =?utf-8?B?dklpNjJHUU1GSnN4bXYzaWx4eXM3MVIwS1V3S0hpQTNTT1Q0YmdMZEE4R2Zq?=
 =?utf-8?B?OWZrSUhQcXFVNkw1SlIxQUVhbnpKWDlJd3hkTkprK24rbGxGdEEzekNtRTAr?=
 =?utf-8?B?ZHI3N3BzQnV6SDExV0g1NUEwWXNWYTg5a1ZrRVN3N3hnVkYxTHphcGhEQkVm?=
 =?utf-8?B?cGFxblZGUVpWNUh6TENhdmRsWWtRRVFHMXl0eG9zL1R5Nk5jSXI3OUVkbmxn?=
 =?utf-8?B?TkQ5WFVwUWk5MURlOUJ3VGVPWHhnL2laU1ltN1FDaGRHc20zbFFIdXBWOWZN?=
 =?utf-8?B?NUNQd2Y5REJ1UW1WOEZHZndZZExPV0t3dTJTa0JOc05BOFFzYWJhYnZ0VEoz?=
 =?utf-8?B?ZjVXWXVPME1teUg0U0lnNzBUTW5lRjM1WjZtTXk4ZWZQYlZVS3NVMy9OdkZL?=
 =?utf-8?B?SzV3MzlvL2xkK1BkUWxlQU80dnlKV0pwajVDTlZPZ1ZGNXlEM1BaZERZUHE4?=
 =?utf-8?B?d3k4Z0dldnNmT09nSmZiM2R5V2syVFVUZDFqNGMybndEZ3hjYnp1Y09BYkxB?=
 =?utf-8?B?cHdGeG5ldWFUTGYvSTdscThvbWtucFMxOUtrVHlmaUlIbjU1by9EaU5QYzlm?=
 =?utf-8?B?ZUtxWVhXN0thRFpqeXlaT21hZnlZc0JMcTVEZEJZWStvSUhWc0VLbkV3SUJo?=
 =?utf-8?B?NVBVMVE1R2Nwc01oZHpka2xHdHNVdFE0NUMxZjBqcVNGczBhK0pLSHUvNGll?=
 =?utf-8?B?a3d6eDc1RFNrRVRpTSsvNDc5bjEwRTVTekZ1N09na3hyeEwvdDVUaUNsTHRZ?=
 =?utf-8?B?QmlaUElGSko0U09oYTcxdC9ob3ZEbSsxYlcvT1g2UDFTdlRFaTNocWNvb09i?=
 =?utf-8?B?eXVMR3FQMmJBdktmWTE1TGhaRzhEY0hYYXNoQ2JhKzhWRzloZlFTK255TGM4?=
 =?utf-8?B?cHRVNEZEa1JpSXZYNGZiWnNlTlNWRG00MmVuVzRnZGk5WEVUUmVhVWlXWHRO?=
 =?utf-8?B?RlI4K1ZJT21sb2htK0JQSnVvSjZzU3JZcTR0QW82cERtd0hTZkNGZzdnR3J6?=
 =?utf-8?B?NnJYa3ZNdEJkaGsrKzh4UVVpMVc1cTVWYWFDUVhySmZFbVordjByKzlyY2lZ?=
 =?utf-8?B?MzNkcTNZRFN5UzdqbE1TQXlLcjZOWVpIeWdIUXBGZkltZE9SdjJEUUxIU1kx?=
 =?utf-8?B?bU56bExkbGRuTWJPdVE4UUZYS1NMRk0rSHVUZEovdnZNYVd0SXhmY25QYStE?=
 =?utf-8?B?WHg3aXNOSTFzdVJjak5FQzZyaEZlY3JZZlFZVnVmK3ZtUFhCdXN6elFrK0NK?=
 =?utf-8?B?MXZjMnJwOU1yYjBmWU44ZFpKZGtSTXpXSk5CaFBDVzYwaEg1ZEUyUk5yK0Iv?=
 =?utf-8?B?ejdrZkhhem5wcjhVK0pyYkVWaXJDYXJNNStIdU51ZXoyWTBrSytYcTNOSW4r?=
 =?utf-8?B?UlE4UnNLZXozZWJLZHRkaWVSRExxUTN6NTkwY3NjbzA0SmR5TkpxVUxXTG9K?=
 =?utf-8?B?VWZndlVWYmxyeUJnOVhHb2RqczdRVElCQXIwZkdHdGZuTlpoT1V5VWNzaW9h?=
 =?utf-8?B?VW9FL3Ntb3d1UWtoMGVOa1JYTGRzUEJRWXV4VnlpNldkVHR1SVdIT1B6NHZK?=
 =?utf-8?B?MGR1OHpQYXJsVHJjK1JoZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVFpOStjRGlvaDQ1TGczVHViYmZZRmJhNFI1emxFZE4reWxzQVRYSmpEeDRE?=
 =?utf-8?B?RUVKdmkzamM1aWI0Z2VVUFB6NmVZcmI2c00xNmpOTEovQjRoR0tLR0lyTVNV?=
 =?utf-8?B?dGRRejFoazlCbUJpVDhMQmZUVHFwY3NaamxqQ1lFNWwyS1pUeXgvUVpnSWdR?=
 =?utf-8?B?WUluSG5mRzB0MHFFVWpUVU1UbE44UW9uSTZLaUhGYk1ocWhCdzZlYW5wbHBH?=
 =?utf-8?B?QkZ4UXBMM1RtNXdpMTh4cUx2UTlqaEJQSnVYZHpKTHRESmdua2hUTlYrSWFO?=
 =?utf-8?B?eTFCaGJUdlBIVm4wbWtPc1RkMHpDMkRXalFYTld3TzdFUGRmRnN1UUNGblZH?=
 =?utf-8?B?SFVWMDJhMzlsd01ZMlc5eEw4MkZtdzRxbDBhd3hoenRZNzBBd3IrUDFTSWFs?=
 =?utf-8?B?Si9YWW9HWlZ4SGFUd3lGVEhiTmNNb2p0WEdaa2dZa2p3Z2NWMmErK3ozOU5F?=
 =?utf-8?B?RDZJSUZ5S001OEhvU0xNbDViQzhVQmN2WWpKMEp6S3E5TG9DbFZKeTZjSHhB?=
 =?utf-8?B?VG1sdHZvS0ltd25vVXpCVkJIY2lUTEw5UFUycTA3OEZUY0tOWVhTdVdQK3da?=
 =?utf-8?B?bnc2UjZDa0pjOTVPRVNJWERVQ1RndUI0N3lHRjRERUFYb2REdEVEYVpUOW9k?=
 =?utf-8?B?QnNFaExCNXNIYjRmZWpMVWxFVnhmOHJPKzYwT29WTnlRREpxMXdYTEthTTNC?=
 =?utf-8?B?eHBDWXZvcy9yWlpMdTREeE9neVovOWpMTXJFZGlQbWlsT2pQbmUwVWpTc2t0?=
 =?utf-8?B?VlZLYkg2S0FkeFh0THo3YUY0YXVraHpRMEdyTjNoSWhDRytYYkpXa241SHZj?=
 =?utf-8?B?UmJDMS82c1pzaHNYNGhyS3p4MHA5REpnSVllRjVIdWxDMmhBR21yTTNUVmJD?=
 =?utf-8?B?UnFOWEg3NzdlUjA1MjFTTG9lNjkxVi9kNGkwaGVvNWFEYmhQbS9MK2g2MWVu?=
 =?utf-8?B?VldDeEhUcStWekdKeUtXZTZ3M3F2bC96dVB3bElZQzh6SFI4Yi9xU3NnNHk3?=
 =?utf-8?B?UW85a2wxNU1lakJuS3ZicU1YY0dFOXJEd2JZR0dPSzZHd3E3YjNkdUZsUjdv?=
 =?utf-8?B?MCtzK1M4L0gzQUxTN3BSOFlQMVRtSWNLY3ZTRVU5NGJlVnVIbVlvMTdMTUlV?=
 =?utf-8?B?d3RLR0ZNRmdoNlRBYkRTZXpJeXNTalhDNG1vL1UvdEVGSXZ5WnYyQWpUOHZr?=
 =?utf-8?B?SjRnUmlRejJuekJkazhLdGpqcGFoNVovZjd2NFFYOEtINlprbCs5cEtXOFdy?=
 =?utf-8?B?YkxSd3prR3NtNFUrc0ZKZGNTdXlScko0elhxZlR6bXV4UUNUUi9SeU5pUFo4?=
 =?utf-8?B?VmNORGsvR2R3MERqT3FZY2krbk82N1l3S0cvOUxhRkNkOTQ4dU1zR2FkOUp1?=
 =?utf-8?B?MUtUbVdyZGxBNktjc25GeEVBWm5JSE9NT2lrMnY2VXNIN0tJYkVBeG8rcTRq?=
 =?utf-8?B?WDZYT0tJRjlFdHc4THcwZWd2ZHJoOW5pREdCNmF1elNlT0tYSmNHYVNTM1JJ?=
 =?utf-8?B?S0pNd2crV1N5SC80c3RIME5GQVdMZGsyaUplVFpETm5XeFZsUWZCNWFPRndi?=
 =?utf-8?B?TU9YWkV3WnFSVVJJT3NRNUZ6TjFhaThQSXdKNHBHamlwZksrSG51VVdGZ1FT?=
 =?utf-8?B?V2lCbk9DUjM3aS9xQkNGOCtPaDlPTzh1NVhab0d2UDYxYThLRHJOVTRnRDdV?=
 =?utf-8?B?N3hCZjBoanBuZTNnNFJVZlVQcGhvZUFWNS84ODBDdlpoeXM2VXQxVFEycVlh?=
 =?utf-8?B?U2d5a084RkZQQ0tBOEpOMHlqUHphNkNIZnJoQndWM3o5UVRxT3lDQTVPaTg4?=
 =?utf-8?B?dG15U25MaXBmUDdhbng1cXJMSCtNQWFTN2JBSzYwL3lKTmd6aWt4QzZKR05t?=
 =?utf-8?B?aDNqTnB6VC9sRVAyNWNFYW1OaEFmeWhCUTNDREIyQnpRMVdpSlIzTFdiTTdQ?=
 =?utf-8?B?YjRnSWNzQ0dZM3NaMWRnY2dqT0VXMUF3UHhBcnhjcHd4WDN0aVpIY3FQNmF1?=
 =?utf-8?B?RktTSDhGSFFSdHlhNzlQN3oyUlBOYkhUNjkrc3VWa2VFMnhSZVBlcUlEcnBY?=
 =?utf-8?B?RTFHdkxXcU12dE03VlhmbTFKcUpsSHV0b2huZFhjc1VKYkg0MVFPS2RXeTNH?=
 =?utf-8?Q?cvUtS7MRUjcJQaHwn7ne3GgsK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3dea39-d351-46d9-8b12-08dcd97436ad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:00:33.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4SYr05hG0VXHzNDKbGKrBpqIkabuW4nHVAZDdCZcXwfwXvajGbvDxrYEa22Rsah
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
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



On 9/9/24 13:24, Michal Simek wrote:
> Add missing vc7_xin fixed clock as clock input for some clock generators.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sc-vpk180-revA.dtso | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
> index 18625933ad3d..ba5484573c99 100644
> --- a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
> @@ -16,6 +16,12 @@
>   &{/} {
>   	compatible = "xlnx,zynqmp-sc-vpk180-revA", "xlnx,zynqmp-vpk180-revA",
>   		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
> +
> +	vc7_xin: vc7-xin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0x0>;
> +		clock-frequency = <50000000>;
> +	};
>   };
>   
>   &i2c0 {

Applied.
M
