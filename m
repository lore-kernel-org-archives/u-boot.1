Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62230C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 14:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB6687ECD;
	Mon, 25 Mar 2024 15:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DP2O65/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A482E87ECD; Mon, 25 Mar 2024 15:15:46 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD5D8718A
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 15:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvW5zyE6U/N2wVA6jGWYTco7ykU/bc3HATVvz2KrUesBoYafJVa2OlnEBFP39vMqNw70nWLb6TwRJdEwWBF/OV6cHZ1gD7ZrDQaJ3Tk8zhH0gSdjnM29Y33Qjy6keLhAsJiJ7dOpkxTjUucNwvzT7unRhAHzdxVzVcTEd2gszn+GEplwY0y5gX58P3ZxQGB3AAes2QwUP31+Tz3FJG3tjwtkXdFTW9MCT/pa3+IRx1M6PyhIi5uMsR6P/1cxpTJcMcey8FRwV2I8+eUvdv6WqIrRuCeAkcnKD53Ek+BGPxQHlBFWcW42seVvfcA62aLd4kVqSU+Il1xvhWnrBGNLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+mYHjbaINO+asU8sw3uFEwY7JXYjRB2VKDWcxBu7DM=;
 b=n18dlsG3Bg1RbLcbrwOEBrpHjFGJ1qk+rhYWMLJjGKYZgaLNK0uBzrK0p3yWiSO4Nn0ZjwJns8e/4pJDeV+6pgN/+ejvYTSfRZQuhhI24ZiExcPIi+HyE2hJM/FfZSWK7iRLpcwq0c43mtyU3yvJe00PjySmOuHpXHnfy+5mLqqdB24uZqN+KYmdb7YXUJ+vPeiBy+aGTPejwDdfDKbneTYyudH5wS8rWPM0QDuLLhbJBjnK8P7bdZmFknFXEkyqzFkVERaeLfJ55gA/V6d5WPEITIXi17QGqEirOoCVFGl/WuvClx2G8Lvz/jgBSScTHYvfRsOyyViMfV4TIOLn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+mYHjbaINO+asU8sw3uFEwY7JXYjRB2VKDWcxBu7DM=;
 b=DP2O65/c+e2mEjuSA2bP3MU0BpI9lem5F9DXBNJhP2fYMHFH5EBX4XNe+7FPhQUCwazeOdlTn+oreVTtgz/B00GslwwQMd9LrI/+r6Pv8hn2KO+AeRH7DPqNNPaLp/38alnCHFwwCQTuO6n9ayqr0vh0KFkOr3Z6T88Avky3XZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:15:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:15:41 +0000
Message-ID: <5badfea5-a575-48dc-afcb-0a0b4c6117e4@amd.com>
Date: Mon, 25 Mar 2024 15:15:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Also support JTAG as alternative boot mode
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
References: <ed51a9d51948ab939a53e0b9dc6c2d2546f97a4f.1710933505.git.michal.simek@amd.com>
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
In-Reply-To: <ed51a9d51948ab939a53e0b9dc6c2d2546f97a4f.1710933505.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0206.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bc1fdf-b113-420a-2e61-08dc4cd60d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFVNLbSbavflWrd6BCUJlI+AWK5SiQVb5Fv1J7yqm6mVJnTzFsmneHooqD25ww126u8M00aacjQ9w83lmxKKxyVoQaU5+BXBBCvJA/T9kFuo/a8oP4hFvyESQ2TpEaXqWRlh/K6MuZT/LqlgtN9O5P1Wo1KDgY1Bud0Xe98YNZXAgiJ9Ke8ldTy2+kURr4gxhxP38Ax9d9B75Esg2Zh8Fx3kS0205p5yBCGbKb0qvqfi/ooOh7M0uUBzRt+Dy23ZdgBe7gHHhUlhS2kdBo6qSKc9Z2cqoJ9BFf1PbpSMqujpmwcv1OtMZG6V2vtiCpejBw18qCk2v0PQJRKkw8qGIwlIDG8oVW1aE6Sr5reI5XItV016WikkE8eNCNx6xD40P7eryhL/SpToY6+QSOKz9KYVSq4dTfRKRDRx25FqaaAOIq4Yvu11SEAaPRJ5D9ps4Uqp7eKI24DylToMv+dRwTNKSpjr5V4dFQiHEgzH0Y3Q2zA58jnQs+BOEUYVTfvqybXbDYm43vBGWSGBAtnjLFF90ZXai4gaiOMr/+EzV6y0fmyJP9LKVNpMruOLsBtsHNVxk42mS9Z0xvDLuE0PynxfX1hqvb9WvmekPnLK68kOW0j2lbpX8Hkw9p53yOiBNR5PVTXmHZpXugnv9isf5jGvI+nnSr54YYBnizJAezA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDR5Wm9yN2xQcDdBMk5CbDNLRlVScTd0N0U2TXMxOXJGRlFpVWFHVk5zdll6?=
 =?utf-8?B?ZHdCQWZMM05YeVc3ME5RZ2lPbHV1RHJzSE9PMUpOZW5kQTEvUmNSc0RMRmJV?=
 =?utf-8?B?bzFsMCtjazE1NmtEVGw5NENLZmVkLzdBR3ZLRDY2OEw1Q2pBbTlMckZjbVFX?=
 =?utf-8?B?OTh6Y0hnOTlJN3M0cWd6RWJRQVlnZElleEJ6RWszNUpWaHE0Y0ltNGFTTmJH?=
 =?utf-8?B?WlF4aGN4Wm52VTE0cnFxSTVDSjYxbEQrZm5FbHltcEJGREJsNU9ONzFvV2s4?=
 =?utf-8?B?d2NSUmVnRTBsdkdaWVlwejJLNnlHTnpTUUwyVDBabEYzc0JERzlVUTlBd3Y3?=
 =?utf-8?B?VWltY0krbzVMSEZ4YmVMNGNIVXBOZDgyZEJQdDdSOExrNTgvcC9Ea29WTmM5?=
 =?utf-8?B?OFN1NzJmK0xIMFRvcUU1L2c3VkM0cjBJdGFIUXdqM1l0U1ZWWTFGcWRId2hE?=
 =?utf-8?B?VUVHUk1wRzExMWNqaDE3bjlTL3NUT0dUUnJnaElGMng1TjJSSkVyclF1Mkpl?=
 =?utf-8?B?U3JnU1ZuRERPNmVOZTNBVTNzZEgwOEVTVXZybWtDZWNDdGRHaThwNGt2eVZu?=
 =?utf-8?B?WEhyclZsTlI1NEs0L2UzVEtpVEg1UTJkSjBWNHA1ZEhqWVFGUU42Qm1PdWU5?=
 =?utf-8?B?YitWRFUydkZ4L3FuY2w4RTRlNExnSUhoSkh0Yk8rSXNqdUNEeDNxUmxma0pt?=
 =?utf-8?B?ZUtCbUlkS09CbVAyT09yejlyZXZENTF1YURmNk1ZWGJFOVMvelVZdlNvdVJr?=
 =?utf-8?B?VncyK3Z3bUdTYlVwTzc0OFpHOHBYZ0JUa0MyQ1ZZVVFhRzRlOUZic1lQRXJ0?=
 =?utf-8?B?RkpCZjIvYU4xSjJLUDZrMDhhR1ZwZEpJVGRrdUMzMmgzcWE3bXBIclAweFJ5?=
 =?utf-8?B?QS9TaGIrdXkrS2k3KzNGSkVTTFRRd3JENDRLVWx1NjB2NXpaRE56STNKZ1BW?=
 =?utf-8?B?V2RhY05xdnY4V2l1ZGF5ZlRYTDdzWEtEMm9DV2dBWUd6c0xqOHFpbDFGVldW?=
 =?utf-8?B?MDRFSkdXcnhkU1pjMEFlYkdiVkU1RldYRlRJZjZUeW1scXhZbmE1WGk4czVy?=
 =?utf-8?B?bVBPOFVod0NEVTdJZWY3VjVRd2RQczFlVnJTWFlLREpmSVI2WGt0MlB5MmNF?=
 =?utf-8?B?aTlVa1FQTktJK0hOZGVISXFLbjlwcTFjNW1XYlB3YVlITk8vSFlxL2V5Qk1p?=
 =?utf-8?B?WU1ZSnpkT09IenNMbXR6dnRlaEpqQTgrMWEvVHVYNllwMWxhUzhpUXk0elNj?=
 =?utf-8?B?OGM4aGRTVVJ1L1AwQUsvT0tJU0FsOGU0Ulk2cXpOemw4bTVjZ2lURGdXaXZD?=
 =?utf-8?B?RkdEbVpPZG9JLzRXaWVDcEJ6dWQzMlRpSmNUVnZxdmltSmVtRERJVG52Q1Uw?=
 =?utf-8?B?YWxwR28ycXBPaHVOMWY5UUdlTzhLQm52MkFHcEhCNUNYVnpEZWludVJPeVVH?=
 =?utf-8?B?Ni9tajVrWENBRGNHcm1RaGxLTTN5L1c0V2JMc3p1S1VWNEh5SWJWM2RKc3JX?=
 =?utf-8?B?QzlqYXZjVktyNXNHdG9kQ20vZkFmL0R1dW1sTWo3K1k5UmtsNkRrNHYxRHZ3?=
 =?utf-8?B?ajBYMy9CS3VFRzI5TUYwQStjeit0QVdWUzllQ0ZPeTZiaG1PQXBkVThZVU9q?=
 =?utf-8?B?UWppcHFHZTJJQ3ZGdTAwNlk5RXRpZG8zdFplR1ZYdmhoZFF3UWZITHgveDlH?=
 =?utf-8?B?RXVacE1RZWlnZ3RFeXNtMERjcTlOdzNLT0x6SzZsVHd3ZGJWQWJIMGcvZTFz?=
 =?utf-8?B?WTJ6MnN2WVRBZzhOQThpc0prempsUmZaMGRXSjdNZjZuMDJSZVRvditjQlE1?=
 =?utf-8?B?L2QzOHFNOFF6bUs4TUpsTHhqRy9pVXZQSlJ6ejNodm41OENleHZxVmVQbFl5?=
 =?utf-8?B?Zk0va1FoTEdNUnZTQkkwd3Y1aXAvU0JkRUQ3Snc4dnpJU3ptSlRNVWlrZG4z?=
 =?utf-8?B?Unpua0FMWjdQdWxtL0QxQ2xGZFRPQ2haMEFyNlU3YzM4SXlFYU03aXppaldw?=
 =?utf-8?B?dDBrRkQzRG5kVjlEZEFEM0paSXlZb2I5ZWVMSm5Qc3pwVVFBTFcrU0xPbnY3?=
 =?utf-8?B?aFA3elQzQ1daa3NwT3gyOXQycnhTUlZqaXVEYWFUcC95L2Z3b0k3QVF6VmM0?=
 =?utf-8?Q?qJHOv9CTBOoBI/4DMSE+/Cv0a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bc1fdf-b113-420a-2e61-08dc4cd60d4b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:15:41.2067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqHh93KSqUQM0ObLG+JdLRu6RtIeE2LpbklqjBmqUiDlsYwhk/PjWRhIcDPmWsz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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



On 3/20/24 12:18, Michal Simek wrote:
> if (reg >> BOOT_MODE_ALT_SHIFT) condition rules out alternative jtag boot
> mode which is 0. When 0 was used origin(HW) boot mode was used instead.
> That's why directly fill reg variable with requested boot mode and don't
> let code to read value back. "else" part of code remain unchanged.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-zynqmp/spl.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
> index 5af735aa5cef..979ff3aef6c2 100644
> --- a/arch/arm/mach-zynqmp/spl.c
> +++ b/arch/arm/mach-zynqmp/spl.c
> @@ -91,13 +91,14 @@ u32 spl_boot_device(void)
>   
>   #if defined(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)
>   	/* Change default boot mode at run-time */
> +	reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
>   	writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
>   	       &crlapb_base->boot_mode);
> -#endif
> -
> +#else
>   	reg = readl(&crlapb_base->boot_mode);
>   	if (reg >> BOOT_MODE_ALT_SHIFT)
>   		reg >>= BOOT_MODE_ALT_SHIFT;
> +#endif
>   
>   	bootmode = reg & BOOT_MODES_MASK;
>   

Applied.
M
