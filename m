Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050C4C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 14:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40EF487527;
	Fri, 24 May 2024 16:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AU2JYHQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BBB8785E; Fri, 24 May 2024 16:09:20 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6231B83334
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdXdmDYTG7R1Z9nt99KK3uYDa4CvYA7+l28N6rxrXixEKjF/LygV4LZtOyNXQlujRod3LVbbIQe7/0BjGdLelgMiz3J16JrcTCAzCRE4Hf4rSOtcpiQHNwvX3Ldb+fGT3+XaraQRbUGK2RCXSILBbc+yCH77mzS8tTdPrNskDXeFaiSShCKfa4ZqHBOygVfnZgHXamVVFDBUwnxeLpJH9kulvM3IRxZaAe2k6iyKB97dTqExA08ck5PNo3MsjdzU1rdY1rGfLdGfp6A4rb2kZXx7/a+bC/YuHj/Qf17/F+ucYt0wfFVJQK1zQg0tZ4Hc+QQRLhdhQ4UdCf56QFD1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGOQDLrMjsI5czGL/yrSJSkwnpFT0EeB7jIo4f/QsMs=;
 b=QuuIF8scGRWkR3Ni834ltlD+2q+T/KBMisIhY7JruYH6js9NrzEF/Iobglym7+PM8XK1yxLJm4VwCD7kp5clFeVcoaj3D4EZ2kjKWNgm5xcMdXIkn3z8DRAZu4YuYLwUKL35LTySviIaaA6U4QjP0jYYGgIf4ZhXb028weHgjGyPV1dNa3j5J+4n3i7zN3jNqjJOEBKQryoGRn9PKO14vSH8e7POtmHhtu+BR3X8SIY8I9WTXonsYqdLeFg1mBGY6S0IBAoz+nb8bdW22xVBTtYC70HbfmP5xB3JgOPc/zXp7S9R0wa7wFEBglBpiuoE2hK8w3/YDii+ouyybEqBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGOQDLrMjsI5czGL/yrSJSkwnpFT0EeB7jIo4f/QsMs=;
 b=AU2JYHQie7kMagwZpv9YAMNURNfkxDjPlJv/m58fW0ryBGvuLUQfULPGBAPjd5hVa34tpes8hsfwJ6CwVQFVsf3xWsXTORVa/QqO3iYw6RVzUKaUNUcAvhdab9Gc/6V8Q6A/r3qfVsZFojlqfmXLvFEbCp3j/x/q4Ngc6QMl2Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Fri, 24 May
 2024 14:09:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 14:09:13 +0000
Message-ID: <4250e775-1269-4929-8451-d8056c6f2f23@amd.com>
Date: Fri, 24 May 2024 16:09:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
To: Tom Rini <trini@konsulko.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
 <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20240507154836.GV2568172@bill-the-cat>
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
In-Reply-To: <20240507154836.GV2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: f1da4efb-5db6-4c14-6df7-08dc7bfb172a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KytRVENWTjVtWGNHQW95bFdQWnhkNzljVkhuWHBBUmcwNVU1TWh4cThsRytx?=
 =?utf-8?B?T0FUQ094V0FRTS93b2hZM0k3QkJvdHo5VE1TZnl1L0V0bnVjVVJNTGdMaU1i?=
 =?utf-8?B?a0VEMzI5QzBaektrbVRzejVBMzc3QlIwMnpkcndvWERDbGV2bloyUFlvdUJS?=
 =?utf-8?B?MllyNXJUQ1FmWmtyVlBIeWYzOTdIOG12Z2d0Rmc3cVNFa3VpTUkrQjl5U0N5?=
 =?utf-8?B?cDZqaUhWajVVaFVGRllEc3ZRKzV5bXBuS3lNUkFLeTluOERnVEU1cG8ybnNi?=
 =?utf-8?B?TWxWUFEveUlxbFNhZ3FRQzZ6VDBvSTBTdmRLRC8xbGMveWY3ZVEvVm5WWFpS?=
 =?utf-8?B?bjlreG1HcTdXRHdzWUYyT1Jmc3BmSmErOVhLanBMV1M1dTVCeGVBQWJxVlRE?=
 =?utf-8?B?djVDcXgwU3B3WWpSUGdnOXJpcWd6RFFwc2txYjF6RFYzWnZFM3RmSmFsUjVx?=
 =?utf-8?B?dWc1bE84NTBpNnpyZGJJRS9WQUN4NkE1b0ttbXRkd2ZEVFFQMWcrTDVrM200?=
 =?utf-8?B?Q0QzVWU3QzNDejVyQklyRGcwbGhRTklGeVhjK3c1QkwvVFpSSGRDNmRacHFq?=
 =?utf-8?B?S05rUGpWMEZRcEJYSER2RWdXTElRWDEwdmZkMUFtM1hkZ0RHeGozUXcvVmFo?=
 =?utf-8?B?YXo1T29KUlhvSzI1cndvb0J4UzZhblg0RFN6b0lmRDFER2s2VFJObE1XM1lN?=
 =?utf-8?B?ZStnV1c3VGVud2tQbVlJbGJ1d3RyN2VjK0xVNGRsTTZ4RmVaZGkxcWlFM2Y2?=
 =?utf-8?B?L2hBdUNRUnpFR1V2cWZwMHdlNTFiTklaVkphNjVjc0FLZ01jRFUxdlNaTHBU?=
 =?utf-8?B?eFJieVIvNFpMbjNjZ3RiVHdIMXpwQXl6YWNpVU5sYlJ1S0N3KzNOUnpSelBB?=
 =?utf-8?B?RFcwTFdrWTQ1a1NZczQrZmkzNk4weS9mQXRIbW9nNVArS0JFNXcydjRGYW1r?=
 =?utf-8?B?a1pvNGtlMUQyUWNLb3h5eHBWNTZrVHFxUWtwNXYrVUR2WlRJTTNJZmtpcndt?=
 =?utf-8?B?ek5SU1RZZGpsZVRlOTZQRU0xQXdDT2x5K3pNRDRTcHpaOHBoWk1TZW1sZXF1?=
 =?utf-8?B?R2hlQnlDa2VBUVIxd24yQ0tmU3NYOG5FcmptQy96RDJqVkoydnhmSkpubFJu?=
 =?utf-8?B?M2VQYVkzK1k1NEdqZllNRFlTUng0YXNiQWRPWEFLZUN4LytkOTB4QUpYakF1?=
 =?utf-8?B?bExsU01WOUZiTVczZU9WQy9lcGpjUWVha2QvSDVUaEpacWtYYVhSNEtENkxJ?=
 =?utf-8?B?WFppa2g1M2Z1ZXc2U1VKa1I0dkY0d2xQS3ZHSi9TWTRWeG9MbGxqWFRDTzc2?=
 =?utf-8?B?Ti9CR3BySzNlMTYyb3JqNDA4NzVkMTdoaWJ0S3VJN1k0MFpBeCtJVkJaa1Y3?=
 =?utf-8?B?SmlnMkN5Q1lSSVNJcThXZWtrKzkxTE5tenhwWGlzaDBBcFpuOGZ5Z1dRc1hu?=
 =?utf-8?B?U3hPU3hjVlg4VSs3U3JlOFYxY1F3UnZHVmpUY3lmTlhOZEhJS2diM0RtY1Y3?=
 =?utf-8?B?Z1BPMUVKNUtxYys3YWo4SW5oTTNydWRJdUY4bnlFemJNbGpId1JKb0ZBbUhr?=
 =?utf-8?B?cEdLVUJBbUQxNC9mdXM5NUl1SFlsb0dVTmErRFNYTGxYd25HVkJZZ0tycS9p?=
 =?utf-8?B?OXZ2THJISXBlQUdnZFF3SDh5eVR0aTU0ck1xdEtGaGQxemt2NTRIWHdqWG5K?=
 =?utf-8?B?MTJFNkhOaUxpYmRNaXgwTml3Y0FtclVZMm90ZDYxemtPY0w5RENRUS9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtMcmRNajE5djFTM2RCRXNZa2hXeFR4UUs2Wk9LbVBvU0o3K25NYmZwSWJJ?=
 =?utf-8?B?WUZiWWxUejZObHNHV1ZSeGFSOFQzWDRDMkVIZGxJcjZsVzBDdWZyM1p4ZU9i?=
 =?utf-8?B?UXNWckcvUlBQYjdoTXlsVEhxL2xVYUdZQnZGWDhvVC9GNHFPV3hBaHlFak1S?=
 =?utf-8?B?RUJ5R1N0YUpDbTVadjR6bS94bWxBNU1ZNjVDQTIyOUJGVFNENjRnMzFNVk16?=
 =?utf-8?B?WGJaY09GakM4czhXcnR3Zm8rcGViSXJpSFJaYTNyRnB5Ky9rVUFmV01KVSsz?=
 =?utf-8?B?VjhaZVpWWkIrckNLM1FPWHVhQlBrSVJQVE43Q3pYcjFBdi84ck9TNFpzcEw0?=
 =?utf-8?B?YndWYVhsOCtyQVJlM1Z4WkcwQStON0ZjR1cvMEhXYm1ncjVhdGxrV2QrazEw?=
 =?utf-8?B?RUVWaUNMaWViSGc1S2xBN3FObFVtOWExbDBhV0dybHVwdFB0cG42SkdNVXJO?=
 =?utf-8?B?YkF0QzJabXlGbWJYSzZ2WW03RkxOVmlNVmQ1eWIrYUtXNkJTb1AydG8zZzN4?=
 =?utf-8?B?V2YrRlBCaU9iZWt1WUl1VzZraXErQUV4c0lEN3ZIVnhVRmNNM2FWVVA0K2pC?=
 =?utf-8?B?UXZRVWNXVEhKK1dFa3hxWUNoOVp3QkQrbXpFN0x4dWZzbHREcXVGd3ZsVmgw?=
 =?utf-8?B?OWRvYm93V29vaVRFZXh1NU9KbzdxdGpyNnZHYjBwOGNNUFZ5MWoyVmEzT0U1?=
 =?utf-8?B?VFlscGluUjJoVm04aEsxOEVtcW16aUVJOURCMWVwcUljWFpCRnFpN0xRcW1F?=
 =?utf-8?B?ZU5DYWQ5MUltaFp4bUF0QkdNd05rN3E5aGZNQzkvREZsdUpzcDh2WlJUb3Ir?=
 =?utf-8?B?OTZjKzhFc1plNS9GeldrbmJrSEVJTnVKZVpHVkVqZC92eDUzaXVFZndVWkZy?=
 =?utf-8?B?dVkvc2xPS29DUzg0MDhPbmdlOVdXSHErMm83K1JldG1UMkZZbmZyZkduTlNW?=
 =?utf-8?B?NExsSHFTZVVPYzVEdmtYd0IxdzhWZE1NRGFnVXhlakllL0hFSm5leGQ5eFpC?=
 =?utf-8?B?RmF0dUF2UXh5VjZLaGxhZnpSZENoZ2lPSU9oYi9CSnhVVTcwamlSc2hyVGNt?=
 =?utf-8?B?ci96cEpRanBuUlNNRVFkekNiTWtXMlNSN280bGNqVVFxbzFMb2NZM05QYjZU?=
 =?utf-8?B?VHA4NVB6aDZMTFpZQ1YvNjVMSUNidDlvZC9mMnBQT1lLZzAwZFVraUJaRy9r?=
 =?utf-8?B?NnZQMXFrM0JOK3BOSEszRWRuaG5mMmNJK2diVDM2Tm5UVE85TmhTcmI1azdx?=
 =?utf-8?B?dFFWZzZOcW1MQjRCbGRmTkw3WkZMOFNaNU5Ea0kwN3RiVkQvQnRMUXpWclRQ?=
 =?utf-8?B?OERURGxGK05OZWsxNGxWNGF6ZXpSSkhlR2w5RWZ3bzBZem9BbDBBcEY1QTVJ?=
 =?utf-8?B?UWR2Sm94UjFkbjRoSVI2MlNIbjI2SGxXaGlPVGZic1VidTNUMFNUZ3h4OTdj?=
 =?utf-8?B?MFpqTDRzdHAwME9nTkdRd3dvRllmbDlha3BZK3JUNjhWM3V2UjE2RmlHMTl1?=
 =?utf-8?B?QUlRbk5lMHFDUzNJWkxFT3lXczRUZWpOYU1GY0h6d0JXQmMwSE5sbWtYNStk?=
 =?utf-8?B?dG1NWHJBUU5DNGM4UGUySjJrMml2SFVPeU12UXYxUXV6NlY1bjUzbEtlSEY1?=
 =?utf-8?B?RGVNd2FJa0NwUnJ2bHhjak9wYVJjeHdBZmsxTjNrWUFwdFl2ZGZDQmdGWk1w?=
 =?utf-8?B?aXN5cjNyUGgxM0o0cFkxWFNZK2JCQnQzZ3hzeXRscmJXckZaYXlZUHQ1MS9v?=
 =?utf-8?B?bmFYS3FTT1dpSHBzL1lpQkpUcVpjcnVoL3c1aE1rTWxNR1FDUEVRRi81b3lp?=
 =?utf-8?B?RzZpM0ZuV1ZUZW90M1JyRXZZSHdwNWRUblVyR2cydmF1ZDYwQTlXclRtTUNq?=
 =?utf-8?B?cHpjWmllS0F4NnVKK2duZXpmSU1WVW1oRVdyQlh4Rkc4Vzc0VDE4eFNaemcy?=
 =?utf-8?B?dzc4S29PdUs2YUJMN2U2RUU3c0Z0Tmh1c04wQTRIRVBxMHJjdGpobUticWU2?=
 =?utf-8?B?QUs2MG8vVWdvSFEyTytyY2RJUXNOUm9YTkticis3dDgvT01vcTFnWlRTOFMz?=
 =?utf-8?B?L3UvMktzbU83blZFZFZPaUNkRFpKTURwbEZtY1Z0VjZQQlNaZnJ4MFpsY0NI?=
 =?utf-8?Q?+re0VjJzSzQ8+qnAwL6Hgn2kU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1da4efb-5db6-4c14-6df7-08dc7bfb172a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 14:09:13.8810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f30fCOp/ImL9aJ1TkpXYBYK4twEARRg9QxAZGFeHDSteqnK+/Bn6X3nl5tFx6JxF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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



On 5/7/24 17:48, Tom Rini wrote:
> On Tue, May 07, 2024 at 04:15:14AM +0000, Abbarapu, Venkatesh wrote:
> 
>> + Tom Rini
>>
>> Do you have any comments for this series?
> 
> Seems likely fine. Jagan, do you have time to put this in a PR for
> -next? Thanks.

No reaction for quite a long time. Can you take it directly to next branch?
Or do you want me to send you pull request to get this to regression and see if 
this breaks someone else?

Thanks,
Michal
