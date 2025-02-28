Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4C6C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85BEF809A5;
	Fri, 28 Feb 2025 15:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CjUJN6nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37818810ED; Fri, 28 Feb 2025 15:42:12 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48325807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8pRP/RFMr6WXgbWWQPSZtI9MZb19/XvWDc/VWpPm0l4D6uq2hso0Qrexk/5wq9PxO+m+KCPlfVby574AuYcQO5280pjWJtljZNdQpaYHjq3SPXZ3xXiLtvihy5Bqpj3rRs0rhJ1ypujxRteuSXGblvqC7gVQuMZaP9UZhTNNhoE2tjj3HTmJyj2rUai/OYgqIiiYZQExcoRzuh7cZ8GGf1vEG/WOmYC+uJONPVuGUlHXrJS9hYcvU5bTR25e2xbNSZaMWL6OGlpSTGJFZ+vLZ9gBtRaEMhXa9efryVNtGxKGEDvio/Ryv6HT9Y15hHE4Dtc6cxt8gk0OgXY1ZACnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgMTj2my1A9XhHkwUvsDJXvQWy7YZ0fitdQKnH7FTI0=;
 b=yPFoJXmdWs4mOtQZG9cQC3su/UYFGuZLRqDXbnHa+vOVFKk6gyQooABY661a84KQDfTW8HuqvcjyfGqb5qOvmEWmHiTpLeYEhZNamDfkaxyEtbWJIFTTq/55dR2Awq+M7uL3PH5hnBJNyd5tiGen46e43w+tgw5U6+8QpcmYnHKixQyRxuIw79pVXF5nLyKiKZpNCojalY9UnxtdHTDnpzb+V1m6aBlToGVGimxIcqxxxLssOJ2C9RzmcgdvYtmJ/Rro7NFKc5/AqAMM3Itw2GdHDVSovckM9im5rpLgZJUz4JyXagRqnqTXrgkRoXrpLlPcxxW2/yFxPCku2BLGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgMTj2my1A9XhHkwUvsDJXvQWy7YZ0fitdQKnH7FTI0=;
 b=CjUJN6nQXrpx19uIyxEdBkDuUle6jCuSebYa3crPiipggdaYCiFwaW7QrwFGkDpf7SQKZlPtCO8STYDPn/BpEZUMHWay9ETqtpQAZ1kD4e6mkkYbAqIqFNqxKh+/YkZAtZeFkrPA5xg3ecofYYOMwIeXjgRus1PAvAyVHglG+/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 14:42:04 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 14:42:04 +0000
Message-ID: <d4d04e4b-e87a-4c89-a68d-944b180fba12@amd.com>
Date: Fri, 28 Feb 2025 15:42:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "Kummari, Prasad" <Prasad.Kummari@amd.com>
References: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
 <61343d7f-d372-495e-b5b3-0bbe14d05a4b@amd.com>
 <51079568-f45b-4d79-b427-0b3d66ad8739@canonical.com>
 <56ed3099-ac7d-4224-a2e6-a38d31f0b29f@amd.com>
 <CAFLszTjxxYTxWhva9T8ER2_pNeLLoEpWCy467BvsB_eVQXnkoQ@mail.gmail.com>
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
In-Reply-To: <CAFLszTjxxYTxWhva9T8ER2_pNeLLoEpWCy467BvsB_eVQXnkoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:510:33d::33) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e323a6b-542d-47e4-c905-08dd58061172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|220923002;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDAvd2lZYmNxNzUxbEZaQXJ3ejl3amNwNE1QejIvR3F6YVc0NXdFVG5kT2lz?=
 =?utf-8?B?SkkrWWJoTkljLzdPZGxZRmVJd2xraVV6Q3JIZzRYbHBYYlAxYldrMUxMcjJp?=
 =?utf-8?B?QnNSZUV1WEkvZVNGTVJ6RGVjd2t2ZldtZHNiQkVycndYTHo3Z3hPY0E1eUhy?=
 =?utf-8?B?UzZIQmptY3kxY0NmU0Ztc3R6UHZmc2ZsK0JER0E5UzZiZWdQbHU0UjRwSFZ0?=
 =?utf-8?B?a1p0YkcrM3RYZGxhN21EZEluL1dVZk1GQWhlTEFPWXp5amV2OWFIUEdaNE5S?=
 =?utf-8?B?OTZKRjN4TDltQnMxUzVGQXRtUFpKKzVpNDNkR2t4RTdSemdDUnZ5RUlLVzR4?=
 =?utf-8?B?UVU4Tmdqc0hjaEFQNUVQRkJuR29oVVdtaEduZmVJa2h2bUcrVkdtZ0c2WERu?=
 =?utf-8?B?ZWdaS1dtQ0VsRFVlQWZhN0xDT0p5b0VSSmVjWHBPcEJURHBIbW1WSkk1ZUxu?=
 =?utf-8?B?UmJHdVRRc1lTMFZhTHVKa2FBMm5DbFpqcjNKNWJETkl3YXlSZGViSks0Wnpm?=
 =?utf-8?B?RUxXQm93dmg0WVdtZmdBbUFlMEZxcUp6UXJJSklHSVFoU0x0aHFjVFVURG55?=
 =?utf-8?B?R005eXkyN3RHNjU4MjBDR3A2WDgrdndicDgrSFFTR3FSR3RkZjBvK2RLYXZZ?=
 =?utf-8?B?Um5SekY5RFZYNmRXKzVIcmJVRFlpRTFIVDlxLzEyYVZuRTBWc24wRzdWRXdK?=
 =?utf-8?B?TStsVThGQUhwa3JEMGpyTmhJODdLdmhWZTJLMlltWEhtYTdXcjBSTy9JUkU0?=
 =?utf-8?B?YW5WNEZOV21WRktGaTIvclAzdk92a255ajhTSUxFbGhrWis3U1ZmQWZZYk9Q?=
 =?utf-8?B?amIyRDh5TTlVRWtQcXMvQ2VqdVU5OGk3S3dFdCthU3ZZaEZLZy9UejNRNXlJ?=
 =?utf-8?B?OXNIMlkzSFpFM2E2QWljQ1VaVUhNdnE5M2lXY0laNEgxU1NGT1h4N2FaU21r?=
 =?utf-8?B?S2dMR1dvdFVxeVN1QWo3WTFuMEs5Y0VIWXRwUzNPSTZqMGR4MFhZYUh6aHU4?=
 =?utf-8?B?OVlCcVF4UkxsRThoRndhTzZoWS9TaTRHdCtTeFNHTTFzcTlibFZBbDFMVDJt?=
 =?utf-8?B?TWNBSXhrSTh1UWYzVStjckxWOXZRakdxYmFCcTk5ei9OUU5FcEdLSVEzVlB1?=
 =?utf-8?B?SG53Zmx6dmRDa0RzRUphdXl2V2F0N3g3Q0R5S0d3UDg5WE5uYU5oNTZYbkQ2?=
 =?utf-8?B?b29FYkcxdVpLc0NwSnJHZkswOGFOVmh3UTRsak9peGd4QjZGbjQ0VGxtVkcy?=
 =?utf-8?B?a0FWRGplWXlKdmpCVmljQmhEZ0tUWDcxNHNUOUlPb3g3U2VJcWZsVU5MRXRV?=
 =?utf-8?B?MmkxYk5LMGZzODg1L3lOeHFtempSUHFNeXpRczVtdk53WXhUUDg4dzJNSnlx?=
 =?utf-8?B?SVZKaElXQ1BsZzBYQlVUcVhITGxHWG5ZeGRnbzcvN1RuNDFNQmFWbjYzZ0dh?=
 =?utf-8?B?SDgySnN6dElsRlM3UkJOT1pmUjZHNUx2bElUeWdhOXk0eVhFOXZxSng5c0cw?=
 =?utf-8?B?bjJ6K2ZQOThQRGg3T0dvL0ZIclVKSjBFTkZTRVc0cEh5VlNlVGtwdm5hUTgz?=
 =?utf-8?B?ZGprdFdjWU1MU1FKOGhBWVNZQUcyeXhxa3Z4Rk5tY3VhWDU0MG5hYlYrb2g4?=
 =?utf-8?B?MEVVRFJXSlVYaXZXRUpsT2xPMitsUTkvTTl0SFZQczhnWjlCVG1hWU9iazU4?=
 =?utf-8?B?MHBtVkplVFhSZkFPblFXZ2lrcVZMWTlGV1RYZk0vWmUwMXpaV0tvVEpZYXd6?=
 =?utf-8?B?NTNUbmhXUWZoTUpsbGg3Ulh6andhRDhTZmVCeG92bVlmeVZwN3c1V0NUMHJJ?=
 =?utf-8?B?ejBGeHhxL04xcmNSdGJVMnNwN3YrTzV2eW1lUW80UEVFVXZheFlUSURMSm9W?=
 =?utf-8?B?R1p1ZFFxWHNKLzQyMWpnVkNIMkw3TDJ0eUJiYy9HZXRoTHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(220923002); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDI4dWQwVXBMVndTeWdEMkJEWlorbEVsaTJMQUpZUUo4eTlWNlM0MUJVSHJK?=
 =?utf-8?B?RWc0TDhkNGpyVlFFOFpzNDFSNEdlQ0FFUGk0MHp2d3drNTIwMzM0QzlERGh5?=
 =?utf-8?B?K3I4ZVNmQTBmN2EzWjc5dEMwMnNNRTk4OVFyY3laVVJqM2x5RFhtMHA5V0hF?=
 =?utf-8?B?SktzZmVkTGZRVjNYMmFiNUJXQk9RZlZkUC9yRjRaUStkT1ZHTXBQMzRZSzFv?=
 =?utf-8?B?a2E5NGZWOTZrZUJXUE50cTdLREV1Q0JOMlc3RktrRzdHWjdSMXc1eExWRzYz?=
 =?utf-8?B?UGpheG42VWt3QVZpYy8zSXFBTGY5S1VpVUloMmtzbDkyeW95WEJYdHlmQ2VG?=
 =?utf-8?B?QTVIWlhWVzRxdkwva2ZlQ24vNDdZUEVRdEJ2UHRlSUx1eDRPc3hCVnpYOVQ1?=
 =?utf-8?B?QjZaNDFmWXF6K3JHVXZubFNHZjBWaFcwVHQ4Rm13WVp2OWxXSUNINlBwejRm?=
 =?utf-8?B?NTdOVnZISU9KTWNKckZiMXhMN0FVdUZyTnlkK2RwNElibWJlTE93UXlFRTlS?=
 =?utf-8?B?Ym5tMlg1aDExK3JGeDVtTFFBREJkaU85MnpLRlQwWno5UG5rTENTdTdzZHBp?=
 =?utf-8?B?TDlhY0dmSHlnckNjNjN0aFVVYnlhclp1bTA1TmpDZENxbFBET2xST0h0cUha?=
 =?utf-8?B?ZUxBbnNLRjZBMEZSU3FJVEZjTVRlOStlWGR2MjZhVEFPR3VreE53Um1JZEwz?=
 =?utf-8?B?T0p2K1pZZXYzYkZJenloUzZ2dXQxOHowdjU1Z0JaMVlKOXQ2Sit6eG9MNzVk?=
 =?utf-8?B?ZzR1VEt5cE5mKzQraWt2akNDQ2NHWnVyeHk1NXBKbCtwYkNiRGRrQmRRSmlN?=
 =?utf-8?B?RFB2TUxhNXpScXdrSFRPSjA4b3B0YUg1WmkybjZnMFNzZjZOMDhjcXNUYlZo?=
 =?utf-8?B?eTRVbU50SWFLYllwZVBONEllY0dMVHZYSlFyamdJblBYSzRrS1dJcXVlQzFk?=
 =?utf-8?B?NG8xOGVhRmdzZEVid3JabWpoYTJ5ZDdwOGdHVVlJd1Nya1JpZUlPSHZiejNK?=
 =?utf-8?B?OW5ubCs3MnUwY1U3ajVCUHF0Skk4K2UxWlpBbDBDejZmNWI3d0t2clc3VG92?=
 =?utf-8?B?eEtlYmlKTG5rb3lCN3VHR1N4U2U4ZXl4RUhyNWUzZ1pnVDJRZ1RlNW9SYjhF?=
 =?utf-8?B?dFZlOGRkSGVoYUNEYVVvZVphcGJCNkNYNXdjYWNkL2NycEsyNFppTnN3VFNQ?=
 =?utf-8?B?SFowZ1VVeXIwR25mWHRBYVpKbW1odGxkTFlVdVgwd3R6ZXpwd1hvNEpCTVJ5?=
 =?utf-8?B?Qlc5UlB3UHBQQjJIb282UXFvTkRrVHUvMWNlYUhzekxrZVoxV0xtVWw1anA3?=
 =?utf-8?B?L293cSt2TW45dEp2bkFXdVRGMGExQU5XUmI4WjU2SHYyTzlvOFVXZlg1ZmQ2?=
 =?utf-8?B?bWNxMEEvMW9sRk1mQ3BmKzZyejViZ1VYRTFTTTI4TUN0MlhCcEFBL1V0U2R0?=
 =?utf-8?B?Y1pxZ0hHVFd2Z2E1dUwwdHlPK3Vhcm9JdEgvRExEb0tHbXB5VWxEcjcvMWVR?=
 =?utf-8?B?V3BuREtNN3owbkZ0R2s1ZzFBK3IzQ1dxcC9TcTFpY3FNNkJUZHd5VTBlYVpm?=
 =?utf-8?B?bTFzWGs2K1dpS0gzd1RTbEQ0dXdaRXdBV0lQYVR6UlJrdUh1ak45YnZXZExm?=
 =?utf-8?B?Rk9hMjMzdnp0eGFFMS9McWgxRXI4NERqdjB2ZGlUWGpuMDIvWk40SUdlNWU2?=
 =?utf-8?B?N0lhM1hHV1diWGJDbmhYcFlBdXRzUVI3d2JzZGZLUDZjQU1IeTlEYXhwMUxF?=
 =?utf-8?B?cVREaVFKcEFKWTNJYXBsVHUxbVVST0U2ZEp6QmhPcFlHZ2Y0d2lSdVpyT3FV?=
 =?utf-8?B?S0xZNlhGUG1QeTViaUs5MUo0UVk5Y3FZdVdrVmx3Ly9pdHFPc2xUZ2hOU0RN?=
 =?utf-8?B?L1VFRnZpS0dJd0hGWXdHVHIxM0crbDJ3UC9wR3Z5TW1oWXRDZ2xmeVh3Nlhp?=
 =?utf-8?B?YjhkcGV1ZUhRVXk1dUFSekt1SysrT1dpOHBWSGhhVXhwajd3Umo3NXQwSWZn?=
 =?utf-8?B?SmRSOS9RMlpMZjFjVk55dTIyc2xhWmhIZHJwY1diaVdJVDdQYTVWTXpJaTJJ?=
 =?utf-8?B?SlZUWDNDSDZQYmZhUGk2bDRyZXF5LzBnK1lKZWRUTGluRmYvaEVRQktBc04x?=
 =?utf-8?Q?nItUQBouSypqV2K73Zm/gKzEu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e323a6b-542d-47e4-c905-08dd58061172
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:42:04.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNkcZ3ub/CwogV2urZqzLQPEAdXGb9t+9BfKQWb6lfcdcNN6NtmSlYu4ib8/XONs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
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

Hi Simon,

On 2/27/25 17:25, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 26 Feb 2025 at 02:04, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 2/26/25 09:59, Heinrich Schuchardt wrote:
>>> On 2/26/25 09:28, Michal Simek wrote:
>>>>
>>>>
>>>> On 2/26/25 09:23, Heinrich Schuchardt wrote:
>>>>> On 2/26/25 07:48, Kummari, Prasad wrote:
>>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>>
>>>>>>
>>>>>> Hi Heinrich,
>>>>>>
>>>>>> Regarding below commit.
>>>>>>
>>>>>> commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
>>>>>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>> AuthorDate: Tue Jun 14 08:02:03 2022 +0200
>>>>>> Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>> CommitDate: Sun Jun 19 15:53:09 2022 +0200
>>>>>>
>>>>>>       efi_loader: initialize console size late
>>>>>>
>>>>>>       If CONFIG_VIDEO_DM=n we query the display size from the serial console.
>>>>>>       Especially when using a remote console the response can be so late that
>>>>>>       it interferes with autoboot.
>>>>>>
>>>>>> *    Only query the console size when running an EFI binary.*
>>>>>>
>>>>>> https://lore.kernel.org/u-boot/20220614060203.33600-1-
>>>>>> heinrich.schuchardt@canonical.com/ <https://lore.kernel.org/u-
>>>>>> boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/>
>>>>>>
>>>>>> Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system to query
>>>>>> the console size only when running an EFI binary. However, when
>>>>>> CONFIG_EFI_CAPSULE_ON_DISK is enabled, the console is still being invoked,
>>>>>> which shouldn't happen. This results in issues on our terminal, which cannot
>>>>>> handle the resulting characters, leading to incorrect display and halting
>>>>>> the auto-boot process in the U-Boot shell.
>>>>>>
>>>>>> *Log Output:*
>>>>>>
>>>>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - ee:df:0a:38:a8:c4
>>>>>>
>>>>>> eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, eth3:
>>>>>> mrmac@a40f2000, eth4: mrmac@a40f3000
>>>>>>
>>>>>> Cannot persist EFI variables without system partition
>>>>>>
>>>>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>>>>>
>>>>>> Missing RNG device for EFI_RNG_PROTOCOL
>>>>>>
>>>>>> Hit any key to stop autoboot:  0
>>>>>>
>>>>>> *Versal> [42;173R*
>>>>>>
>>>>>> *Unknown command '[42' - try 'help'*
>>>>>
>>>>> Hello Prasad,
>>>>>
>>>>> The terminal emulation seems to be sending a valid reply indicating 42 rows
>>>>> and 173 columns.
>>>>>
>>>>> It could be that in your setup you are hitting the time out in term_get_char().
>>>>>
>>>>> Could you, please, check what happens if you apply
>>>>>
>>>>> --- a/lib/efi_loader/efi_console.c
>>>>> +++ b/lib/efi_loader/efi_console.c
>>>>> @@ -92,8 +92,7 @@ static int term_get_char(s32 *c)
>>>>>           timeout = timer_get_us() + 100000;
>>>>>
>>>>>           while (!tstc())
>>>>> -               if (timer_get_us() > timeout)
>>>>> -                       return 1;
>>>>> +               ;
>>>>>
>>>>>           *c = getchar();
>>>>>           return 0;
>>>>>
>>>>> If the failure disappears, next you would have to analyze why the timeout is
>>>>> occurring (e.g. timer_get_us() running too fast).
>>>>>
>>>>> If you still get failures, please, add debug output term_read_reply() to
>>>>> understand what is happening.
>>>>
>>>> But why is this send at this stage? Why capsule update needs to be aware about
>>>> size of terminal? I understand that you need to know it for efi application
>>>> but what's the reason to know it capsule update?
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>>
>>>
>>> Hello Michal,
>>>
>>> There are two separate questions to answer:
>>>
>>> * Why does determining the console not work?
>>>
>>> The problem can only occur EFI enabled systems. If determining the console size
>>> fails here, we can expect it to fail when running EFI applications, too.
>>
>> yes but you don't know if users are going to boot over EFI or via legacy way.
>> You can still use capsule update part only and using bootm/booti for booting.
>>
>>>
>>> * Why is the EFI console initialized here?
>>>
>>> We have currently only one entry-point for initializing the whole of the EFI
>>> sub-system. We are using the console before running any EFI application, e.g. in
>>> the eficonfig command.
>>>
>>> This could be redesigned with some effort.
>>
>> And I think it should. Because there is no reason to do initialization of
>> anything what it is not going to be used. At the end of day it is just delaying
>> boot.
> 
> Agreed. My attempt to resolve this for a similar situation just
> resulted in my case being a bad example[1]. But this is just bad
> design.

Glad to see your patches.
Not sure if implementation is fitting our needs but it is showing exactly the 
problem.
I pretty much think that nothing should be done unless you explicitly asks for 
it. And I can't see any variable/Kconfig option which is enabled to start to 
call these chars.

I am considering this as bug which should be fixed in this release because it is 
unintentionally breaking boot. I also expect that this is pretty much nice to 
have feature to use bigger screen instead of basic 80x25.

Thanks,
Michal


> 
> Regards,
> SImon
> 
> [1] https://lore.kernel.org/u-boot/20240926215950.1265143-9-sjg@chromium.org/

