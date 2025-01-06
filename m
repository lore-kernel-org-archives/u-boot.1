Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F267CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 800B4801DE;
	Mon,  6 Jan 2025 09:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Di+wKxpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B2E801E8; Mon,  6 Jan 2025 09:31:29 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEFA80137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3INKJ2hK+ostg07rMz0W/GJVkfp1y+37ZZ6oB8L1FUAtaca0AnRfNIdD5CQLMvx65Uv2VsSWBQtI/LmQc+pt1yURzDmQW5o1xbMYe3isSesOGZpWkJ84KtyBhyzLPG/WLiyJD5mYe4/vFc/onf0xsYlowfPct+NpDGnaLcyMGwyur/3hrWrwMHon8KKObUODtH9x8+HP8bwvRTk2hWA/gQbWNBEDZJV8BjgxJieWHqTbqKxAUKMV0mTuW6ZKgcAWnteFLbNESayggA+QofxsxtU4epEi0ja8ihgG8nKVVSB8+oOSRF2x56EwAJkzA21R/3yospdPPjOtSn34Aoa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beDwF++wtWHo5b/4yw341Pv09TBxiGTTLPyYGNyG4ps=;
 b=C9vGZtfC9V6KOYA6HIuliD5mqKGlrSObunO+jp0OWtIf7ThBF61h/8yRLB1KpFtW592FIlYWBJWwIB2WtfhRenpfmxqDz9uGtQf95NDOBpXUzpgY+5FBmPpohIpoICNAR0YBr/vGQqcZ0oAB3q30eajr5U67+5GF78K55T5+RlH1JE7RvaAkDItwPUXMA7vxXp2G4815LxkU0AHaQY10PF1zv+wNLuJvrP74F/ci6rp+9OoIuHotHclyLqQpeh91/TOk2VLqNwygNxe+8IhVjadx9P8pwxMXhO0rM6+LBiry8kTSHfS9ogdrvllmVAqDdRkS4hzMQqVgRm/ImFSBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beDwF++wtWHo5b/4yw341Pv09TBxiGTTLPyYGNyG4ps=;
 b=Di+wKxpBJJq/Uo0vWYK/Vz4V78i0TqJx4Ii0E8bnaGuK7XA+RL4GbaF8N++LvjKOrW7dnmAlyR5Lm8OoEOwBIS+/ZRMipS7EfWAS3IePiD8kaeoh5ZOue4WP0U6YKtn4H61uOsBycYRA8VVWCZA/gOPnjBk5CHR3qLF5X/nbR70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 08:31:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 08:31:18 +0000
Message-ID: <b7b39c45-da13-406e-ad5c-e6bdba0d8bb1@amd.com>
Date: Mon, 6 Jan 2025 09:31:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Add missing prototype for set_dfu_alt_info
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250102045026.3427121-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20250102045026.3427121-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0250.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 7233a6c5-1a39-42d6-c51f-08dd2e2c7ded
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVRSWXJEQlgzaGNpWUoxQXJGazNOaVRHUzBRM2RRVGJRR0x6clpQZEt4Smwy?=
 =?utf-8?B?elI2Rk5oTjNTdzBzK2VJaGNYRDdKZ21reWM5ZUNKV0EvRFRrY3p1OFZ6NCtF?=
 =?utf-8?B?czZmUklnT0E5Nm9MUDcrbjc3WXZQTWxmSlZLaHVnNXNCUFVBMDRnaTRXd0JK?=
 =?utf-8?B?ZEcxQWlmbXR0MGU5ZzRUblNicTlxc1FwTjBzb1Z1Szg4Ymg4dENKY3dMdXpa?=
 =?utf-8?B?bWZhWjdJRG1adDMza1FzeCtwTTRKbE9OQ0s3SG1ZMDVOMjRwVFZQWGtjdVNV?=
 =?utf-8?B?QytVZUIzQ2NERi9MeHJFTWQ3blVYTWM1T21HMTRPUjhsUzlJSS8zdUUxWEMv?=
 =?utf-8?B?dnRFOGJKb1BqSGxMWW5KbjE0YmM0YlZqazJLMlFVcHcrV1dhVXZ3MnBGdU9F?=
 =?utf-8?B?TGhlRERjVmRCLzRkN1Z6c3ZJaTk1MEh0alE5V005R0Z3K1ZmSkxHMFRMbGZn?=
 =?utf-8?B?aWhqaVNqckFXMTJaVFFGbGNLWGtOek1FZGRaVVdGS2o0dzkwVklLZkIydUUv?=
 =?utf-8?B?YVUydGl1TXpDM1VkTHBwRlhPVmpsKytJRnZMMmJBcWdzRThzbm1lczNrSDF1?=
 =?utf-8?B?aklBVnZqYVhWRS9HSkJUVDVicWRPd05YdmJxUlE3Y2MrU1pxWWQrVHREd1N2?=
 =?utf-8?B?a3FxS0xnaWJ2S1VDSDVJWHJqK0c3RWFZcmwzT0h3NUNLNG52QVErZU9QZzIw?=
 =?utf-8?B?eTV4Zm9kMGdENGh4YUs0VEhzb2I0SkRuUG5XRG9Vb3lNb3Vrd28xRXBoUEN5?=
 =?utf-8?B?ZXp5MFVtWHVHczQ0R1RKKzNaNktxNlpEcHBsaENWQVBTZ3kxbGpNVndNLzhp?=
 =?utf-8?B?d1l2SUF6OHZ4WkVPOUVjdHBLbnZxbHlBSnZmdThtSEJDUmRSSXRnZGtMREdt?=
 =?utf-8?B?REhKQjhsWnNGdDQ5dW10SHJJam1VWUZtZVFOcnVlR2hRS2RjZzR0L1lYVzQy?=
 =?utf-8?B?ajBNSlZEcHpkQnRPeVd2em1xaWxkM3NIMStNMXpSRnFOSDkzWmdtcjVlRXgw?=
 =?utf-8?B?N0dFb1kwaUdRbWZSNWNTQ1ZPclEyUlp3azVzeHJUaE54RFFkTnBySlNqcHgw?=
 =?utf-8?B?QlNHaHRRcmVuVmxqNTFuRmhNcjNPeXhnY3NoeEkrUDMxY29PclBha0dHb1Ux?=
 =?utf-8?B?U3JBTUZkT1RndnpzcDJGelVwSnJTRTdYd08xeEV5bk05Q1RBOVdkOGdNVXBn?=
 =?utf-8?B?WWZSUlpZMU5nVGhMYmQ0MTkwZTVrOEx6bk0ySXBOMXJaSnRpWUVXemw3YjVK?=
 =?utf-8?B?ckdBNE5MdFJzaFVvY2hZYWtxeFRIa3NuYVBlM2xUMlB6aytCRDJMNFd1d0gx?=
 =?utf-8?B?T2tsTFZ5cVJyRjhST0pSMmxlVmJQRnJhSlVMeC9vb0NKKytsODRYcXRHMWg3?=
 =?utf-8?B?czExaEg2VytnSUpHamFKMUMwTkZ0QUFJUG5tSk9HTWRUTzBmWmxaaSs2OG1h?=
 =?utf-8?B?T00zTTVkRWVZZmgxaXY0bm4yblNpVGFWMTNoREZrZHRTdzU4Q0Y5aDFYM2tn?=
 =?utf-8?B?ZGRyUXBsanJxcTBUNG1wTlIxR3pyaDNCdzFDeXRhM1JORmFsc1VGOXFHZmZ4?=
 =?utf-8?B?NlZRMjZ2RkIxc2o0OFhNNEZoaHIyR3Vsc0pSZno1dWJDenpqTWUzNGFhQkJV?=
 =?utf-8?B?RFJBaDZ0MTVIMmxKUUIvUXJMVldvemwvNXRDYnI2M1drVXFKM1VrYmhzY3VG?=
 =?utf-8?B?dmhxTU1NajRRMTFKR1d1TUt3czJFSm9EVW96TWZyWFYrcm4vMys3Y3ZZY1dr?=
 =?utf-8?B?Z0ZzS1Y0MXBOZVpyS2xwM0VLSU5wU3NvUVJHSjl2Nm16dndpd0JqVXJpTlBz?=
 =?utf-8?B?c1NVTXpIMjJkR1YvZWlRdHJ0bVpqMGtHL0VrSGNtcVpIMHVDdXVST3cxSGw5?=
 =?utf-8?Q?rM4EUobedrN6v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHNtREpIaTZtN2RVT3BLZy9wTkJOaDNYZDRRbkE0eGFBU2VFWFBjL0JFVFor?=
 =?utf-8?B?Y3IyZlRPNDFSR294NkQ3ZWcrYlFNOTVhaGVncy9MejUvdjF5Nm9mdHVUYzVp?=
 =?utf-8?B?MkpPYmwycVY1L3cvTXJwcFU0MkNmWkZLd0xoTXA4bVVqdWtMQXRaRzcwZzRj?=
 =?utf-8?B?TWVva3JJZG5vQm9aeUxXdlZwamU1dmUvWTlzdkpMbThhQjJZdHlUZGZPbFJv?=
 =?utf-8?B?OWsxQWRUNjM1blJsL0NSKzRoajBWQ0Q5WmhuSllsVzRxbWYwNUE1RUtTbndC?=
 =?utf-8?B?bnFTejN3VlAwWmZaR2xTcHRDbUlia1lsNERCWlFkN1E4ZTh0R2lqWjBNcGhM?=
 =?utf-8?B?TU92bmlhbUE2UXE1Z2NtVnJZNm8vZ2NaaEFmb3R0U3RCc3B2NUpCLzdPMTVs?=
 =?utf-8?B?a3IyT3R2OHVqNDAvQzhDcXFzZE9OeG1FdGx0WmlCalVha3dHby9IL2luTWxD?=
 =?utf-8?B?UndNVk43WmVYa2NNY2FJM2tRdklqaVF6OHVhWVRxZnhCMXdoblVrVFV5c0Fm?=
 =?utf-8?B?YWVFVmJBU2RxMUxVTmZyNGtPTERsU3lIU1pPSnhDRUN6d2VXdnZPRW5xaXdD?=
 =?utf-8?B?UjJTRkFaUEFTTWJ0M2VNeFNqL0F3b29jblQrbGNPd1BxZDJkK0dlcUhhWHNS?=
 =?utf-8?B?dW5sQk0zS1U5L2pOUUV0VjBzTG9ZM3pqbVVaS0ExUUNjVWJYdXNHZ1VtdHht?=
 =?utf-8?B?dXk4cEs5RmlMNHlDT1lHT0xoWGlOVHQ5R1VhSjhab0ZSWDNPOVhYcTA0azYx?=
 =?utf-8?B?NHUzUU8zNklqWWhEblNtVDV0TVc4OHJmMm9SMktKSUNtdE9CWjFHME83WWxI?=
 =?utf-8?B?VC91Y09OelJQMThUV1ZWNzZ0cjhHT1NraGVKcnJwc2FBOHNMQjllTCtEWGVu?=
 =?utf-8?B?RzAxZVVXTjdDOVVCVmduNjNSaTBDL0U4T3QwSkpXSDV1NTRmUVZTZEtqU1ls?=
 =?utf-8?B?STZwb2RJSlNHMlJzK04rZmE2ZkUrL2paS2x1dHhyMjRERlBmNDIxSXp4bUg2?=
 =?utf-8?B?V1Nlci92VHlMRjd5R0FMM25ieXBOSlFZSUVxanlVeEJ1K0k3alplZm1xUmVx?=
 =?utf-8?B?eEVLUkVPdUgxbUxjUlE1OXowTy9iTUk1Z3NzbVllV0owTHYxYUZPZ2Yva3p3?=
 =?utf-8?B?SE44Nlg3d1dkeFdPejZRakRqWVZZTjJMNFBDL1VxMTlYWTd1YkNibllyUW04?=
 =?utf-8?B?ejZhbWg0K2FVOVI1eitWc1VUYTMrNG1FVFlJRkdUZHNVU2IzN2Q0UkJpeXR2?=
 =?utf-8?B?bU8xS1lDZ1V4WVRmUEZHc0ZXL0loQWRwbTNRR01va2lBYVBHSXFJZ0dzL3N5?=
 =?utf-8?B?ZUZnZnJ2enhIVUdVYlFhdTU1WWtrNG4rT0lWTTJQVk1pSU8zQjlwRXlRMXRP?=
 =?utf-8?B?dVNBMFNHRDAycm5XemU0REwxa2dqMmdydnphdFZDTFYyK0NVbktsck9mdjFw?=
 =?utf-8?B?aUwxVkpyMFU0Z2I1QmVDdEdsL1hLZ2Jacy8rN2dhWGhrQTloY2JUWnJjYjl5?=
 =?utf-8?B?emFvdGpsRVRzMGJQbk9QL0d0NzJUdGFPc2E5OGFuOHRaWGtmVVZPZldlNlV4?=
 =?utf-8?B?VUpJNVM3WkF3NUdGSVhkNnJGcDRSQUx2dkdsTDJzclBjMGJJdjFnVktreDhx?=
 =?utf-8?B?dGtwWlZvUEMrOVd4N293ZkNWZU9NcnY2bHBhVTVoVkIrZEErVWlBNXF5d3lR?=
 =?utf-8?B?bUtmd1E2dWNTeG9FWXJ0SXpQcXNTeUExNXNUdWlYdHhPT3E2NWRHY1V3eEt1?=
 =?utf-8?B?SjgvM2p0Um56TEJGN3A0MVJNM1VLSEJCQmhGTzFoTC8zZWtxS3JlcFc4OWxo?=
 =?utf-8?B?YUdRMThYdXJMZHBXc3ZwTHVrL0Z4RzhNV0h5cTJmOVNTVDFVU3VPNFRKcTdQ?=
 =?utf-8?B?ZXRWYkdjSnh0WVdwMExXS3RQdWd4SnRmNkdxcVRxVHYwWmZ3K1JyME5PTXgy?=
 =?utf-8?B?NzFSUlAyeWk5WXNUNDhtOGxWZEFDZFVBeDhlRVUwd29BbmEvYVpyaDJyWEJC?=
 =?utf-8?B?SWYzbVJRNmNZbzNDR05aUnpCR3ZLdUtOMERIR08zbVBYTTU2elRhRVZFem96?=
 =?utf-8?B?aUU3aXBVZEhSMEh4SXZkNE1iN3RlL1ZTNFFjVTdJVlEyY0RPeTdNenJNRDVh?=
 =?utf-8?Q?DOJt3+z1+mHBZXLyCSvrtxbPn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7233a6c5-1a39-42d6-c51f-08dd2e2c7ded
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 08:31:18.5211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxGK5aa+uz7mSN2uxtDOz6D9iWloLkt98xQ/kkgHO5Yo0kPUuF3HmI60SGukUYMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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



On 1/2/25 05:50, Venkatesh Yadav Abbarapu wrote:
> Add missing prototype to fix the sparse warning,
> warning: no previous prototype for 'set_dfu_alt_info'
> [-Wmissing-prototypes].
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/xilinx/common/board.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
> index 64d657673e..ff8f9b9596 100644
> --- a/board/xilinx/common/board.h
> +++ b/board/xilinx/common/board.h
> @@ -18,4 +18,6 @@ bool board_detection(void);
>   char *soc_name_decode(void);
>   
>   bool soc_detection(void);
> +
> +void set_dfu_alt_info(char *interface, char *devstr);
>   #endif /* BOARD_XILINX_COMMON_BOARD_H */

You should include <dfu.h> instead.

M
