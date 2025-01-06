Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23A9E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF22801DE;
	Mon,  6 Jan 2025 09:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2ZYPnzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304DC801E8; Mon,  6 Jan 2025 09:26:32 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8318480137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izAbWH58Pga1LoNwdIJ/uWrzxrvbSR2AWeytwqGzVpTTpfZ8O4qlVjjYGb3oDUlWcEZTIS1JishFp/v95/RgiTKWYHh398wwi9lM4Uq8jAkHO/j44urh94dcL766wVOv3WBZgMXo7XafFw9QJK6plXPLjJfA/rBz1y6KdomDgHUR07c9d2o79p5xkrJTKk/JefJ3WYocuSJ7kpS63Nw0edmeVagLPl0EyaQYgTsIEqtmwX4sYkFPmSI5/wf1Z1ywGhbLGoePd07sYfOWaKwtDILWHafCehCEIiiflLFIeZB8zuAFafECL5isvZ3f+BzSmrAtJbEdOhlSXQGOSQbFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1VQVJVQ6rXmZS4cWt8EQUUcs4I3+FBttf7mWJx92O8=;
 b=mk5hEML4K7/8J+WVU8vDotwbHponIvolRUIl9Y2FVMw2InDWua2wU8FvJmXYsH7x5ves2XB10BrvvSf/jueJNc8vmX/nkSeYXFFJhCEyqYj+8nbXUXCCY6/XaliqP2+E82OSx4OpTTPyaPO5I3sku/J3dowmRm6K/kzVGXFUeMj/KDHR4HhYk7emEXukMzxRFyyQJ1XrRcPYxXW6P2/NYyCVH/IplhXpJ8QfFqRKhR5O9FVMgrMZq2sDhVAZfc9rTggpW+K+7YiwnBJIHJi120+ssznRd9h0sMFGBc0HUzHdrC533GkZZUFKC/5Tnpg5bQiW1YJayA7hHrPz/z21Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1VQVJVQ6rXmZS4cWt8EQUUcs4I3+FBttf7mWJx92O8=;
 b=L2ZYPnzAYulS00eHFHDDYgq3aOCzVAVAPTZSFnVPhq5rOxMM0Hl0bapLOxZMG8Ta7CAkaljWQ4p5Bo46O+Oaat9ddEd2DFsKju//eLmjYq29cyatV9dCVrOjgGpG/eqqVt5V9MWD6wWVy3EJSZpmueNDmUKHnRronAfsBiY85fM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 08:26:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 08:26:19 +0000
Message-ID: <515df618-750e-4186-9331-c7af741c9dbb@amd.com>
Date: Mon, 6 Jan 2025 09:26:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] board: zynqmp: zynqmp-sm-k26-revA: release DP from
 reset
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de, git-dev@amd.com
Cc: love.kumar@amd.com, Jayaprakash.Chilakala@amd.com, raghu.udatha@amd.com,
 nava.kishore.manne@amd.com, ibai.erkiaga-elorza@amd.com,
 luca.ceresoli@bootlin.com
References: <20241218130129.687650-1-neal.frager@amd.com>
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
In-Reply-To: <20241218130129.687650-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: d02c16b1-12f1-4f4f-ca73-08dd2e2bcbe5
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHJGSFRqZjBMam9DSEllNDNlYWI0cjNGZi9HQ241Vm9qNDltcWg0eEozNWk5?=
 =?utf-8?B?aC9rVDBzZ3c1YzFhTVEyTUZsYTBDNzhqdmd3ZTEwa0FQNDY1VXV5OFQvajYw?=
 =?utf-8?B?Q3NTL1FuVGh5NHlVb0xwbHBxRDB2Z0w0R3BlK2xRWE9rdDR5N1NhTC9PRzM2?=
 =?utf-8?B?QS9yMVFpdFg0dzBoY05PMzZPVkxzUERBdVNzSVBLKzBHWGR2TEJoQjFXZTBB?=
 =?utf-8?B?N2RNcWs5QXVIUWZRUDI0UWhYTWRkVjF1R2YxelpFR1cvd0xjaCtRSmxJbnhK?=
 =?utf-8?B?SU5qdjd4eEdnZEFRdVRQd0crN0Zvd0p6Qjk0aDFySjVOQ1BzZktiY1N1WjRw?=
 =?utf-8?B?RkdsQ1NoUSsybVhGdzBFdXZwNDFzTWpyQWFVbHJYeEhJRjE4RGVHRGl3U3BE?=
 =?utf-8?B?WGhaTSsvbDkxNEtYcXhzbElCWHZFdTRBMmFLQm5hSitmbThPemIzbDdEUG5Z?=
 =?utf-8?B?NGpWOVVhQnJZVktNZEwrYWdqSnZNZmpUTWNuWUFac1hHM2ZqOWZFbXpMdmlR?=
 =?utf-8?B?a1ZHYi9Hb0pjSElrc1AyL2xUYjkvN1BjeDhwM1BvZ3JYVTdlRWJPaHh2bE9E?=
 =?utf-8?B?U2p3UTZGbTZJSzJFMjZtVDIwdkZOaWNUN0VGam05ZkkzdGlzdy9pT3UxSDRy?=
 =?utf-8?B?ZmVBRGo1WWN1QmJVOVJSWnVjVmVXT0ZFL1B4K1RJdGJrZmVPNTRmUWVMMDBM?=
 =?utf-8?B?K29MYm1oOWl5WWgvZzg5ZWpQalc4eUR1eTNYRjI1V2lHTkFjY3NlMVRNNG9r?=
 =?utf-8?B?TFVHMFdQL01NaVIrN2taMHBuRU1leWViODZ6T2RRTVhFU0JpRUpEOHBzdjFP?=
 =?utf-8?B?eHpRTnh1STJ2N05wR0xNMU1jQzRKNXBpc1FnM2FqSTAyeXFKYk8wNzdjQzhP?=
 =?utf-8?B?ajdxTGZLb0doRC9oOThHWkVzVmRObklJb2dlQ0czOU8zdFRjYkhkeWR2TElV?=
 =?utf-8?B?YVk3WU9kOWRCdGdkLzlpQklkRTRzenZQakszd25aOG1YQnU4Q09GbUw2RjFp?=
 =?utf-8?B?b0xXNTllS3pJN1orQzJRWVdyRVVNQ1hIVUxEN2FmaUZUV1JzNlFTdkk4eGFt?=
 =?utf-8?B?R0hCajFycXdueHRQQk9UcktadWl6MWFBblBaVy81NDMxNjVqOGU3cjJKWkhE?=
 =?utf-8?B?LzBOekhXTElTemNzRUJpaGJRVXNzVGp5eFhZS3JlYlVYcTdxbEk2QnMrUXI4?=
 =?utf-8?B?cHhwN3JoVTZUU0RET2VmR0h1NmpqWitqaTZNdjFTblRaYTBKRkN4YXJONnBZ?=
 =?utf-8?B?UnVXSlYvSityekxIVUFsRUJEaVREY0daanRBbmFVMi96KzFCMWJsU1VGSHpr?=
 =?utf-8?B?RFZwRCtxSTVVYnNKRkh6K1JmNVdDM3NnRGU0Kzh6UWpESHRWUUdCbEZZWUlI?=
 =?utf-8?B?dG04MTFmcEN2a25yZG5xKzYxNU9DN2FGSVoycUVheDMzY09WWWIzRjNZQVcw?=
 =?utf-8?B?RzVLWXpROUlWWWJsZE1nQ1JNaGRFQmpHYlpxTzVCNklrNGdLMkNTMVlqaWJk?=
 =?utf-8?B?YXc4UFNFWTFFdm1ibDVVcDJ4MXBydCtZa05XRVcxL1NaT096UkJ2QkZJZWIz?=
 =?utf-8?B?MkQ1R0d3ZUFmNEl4a2lTbG5lemlMbDN3TS93cTBsOFdrU25UQzViTnJYVDVR?=
 =?utf-8?B?RE9sVk5pLzdGbHRhVUx4OUw0bUJOMlZOSzhmTW1xUmNmOGpjRDhoUWZIR1VH?=
 =?utf-8?B?QUdSMWk3MFVKOCsxRThVZXk2SGRDVmVhd0ZXMW1keU5hRHRpeWZWbjBDeXJ3?=
 =?utf-8?B?QWJNazhEdjB1YnRFYUtRWU5Yb1ZVSHdiTW8vbnMyOE1qTDBNT0Z1YkFwRWRZ?=
 =?utf-8?B?eER3ZTRYKzFhMG8zUmtuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFREY2F0RFFucjZxb2I2OUdRNnZtdGJQYmp4UE5xNmhMaVVnSFVwS3Q4eWRY?=
 =?utf-8?B?aEI3YkNGNGhKY1VwdDhocElGY3NHcmNTZHJKenAxdlRQVldLdUM2TXVmWThQ?=
 =?utf-8?B?Q1lIcTE5Nktpa21XcXV1Q05oR2x2eWw3UzZVWFVqajFwTHIzZTlVQ05nNU00?=
 =?utf-8?B?cWhtazR1bWlyTko5OUdtbGhlVWFqMG9lUEkvbVpPTGlMUTBGdE1OMmhGeSsy?=
 =?utf-8?B?MmVQVmxiS0lkcjJCVTh3Nk9ZQmpNcTk3RVE4Z0tHbTdRejZITlBQSjJXVHN1?=
 =?utf-8?B?TXA4MHNTS2FEbEo1WUJrWUJaQ0lXZkRtQzQrWUJJWjkxaHF3akgvOFQ2andU?=
 =?utf-8?B?OHlacE5yT0s0K01zeTZqMHhvUVUvSCtBNVUvU0hSM0VQUnJRR1RobGxCY0tU?=
 =?utf-8?B?K1VkWGJNNm9jb2RJeTlNNmlQSzMySUVRbFVkUkxkU0NEKy8xbUVyVHlwbEhr?=
 =?utf-8?B?aWw3L0lCVWFraTBoeUt0bW1zNmVqTTFLYlFTQ0lFa0VEK1dPbFdycjR6WFVz?=
 =?utf-8?B?L3IyOURVUkYzdUNmWG9iM09wVXA1SG5rMVkvazBMYWF6Wm8rcGx2bDlRR1Fj?=
 =?utf-8?B?NW1UVTM4Yi96UTA3OFpIS0IxQzFkN1pYYXlPZHpKNUs0U0tQWS9kSXcyZU5S?=
 =?utf-8?B?Rzc1N0VmalQySFpFM1NuMlZXcEVpMmdRYUk2VVVad256T0FlWmllVC93VjdG?=
 =?utf-8?B?Rzd6aGRQeXE5YzROMjM1VUNPRXR2TDlUMUdQYjdTeGNrMTRaKyswNDduOTNS?=
 =?utf-8?B?NzkxRjNkSThxSEZLWnBPME15RjRCNHRMbFpTaEJCYWl0YUFHeEZKYnBBYWZY?=
 =?utf-8?B?dGVsdkVZelp3dllTOEk2djhGTjYrczZzdVdRbEhGMWRpdmJSK0tkVytyMkZz?=
 =?utf-8?B?K05wbGdmekVURG51RG5pRktNUU5aMzdaRTVXVDIyY28zTXZSTzhZSjYwL1d6?=
 =?utf-8?B?NmlYZFQzZnd0Z3pGMUNzVHlaVXExR0xQdTA3d2pnZitBUk8wYXE4UDhmYlVZ?=
 =?utf-8?B?anVXeFFmKzdESGdOdHFlNGRrTmJpdWpRcGk5bHM5aG5BWnlaTUw3alZlTm1n?=
 =?utf-8?B?cEszWkRYdDRWQTNwdEdtUDRIYXVmYW1JVVF0WHI4RkdaWDVQU2pja0EvK2lo?=
 =?utf-8?B?Zlo4MGNzSWRuUjM2THRabStYSGV5enppamltQ0pScGFrQzFsbmtGK1hVQ0Qx?=
 =?utf-8?B?cGNFamRLUzNMTHRGZDJCT2cvM1A0YTNFVlVia0dpcEY4blE5WWxWa2t4Nll5?=
 =?utf-8?B?dU1naXYxNWwvU2ppVXpic0hXRy82MXBIZ3pPWmdZclFBRkx0UFZtTzhlcFNE?=
 =?utf-8?B?UHJ4M1VmN3NaWmRpMFhuSW1pTllhT0NkcEhEZ1dmVnkzRVhxRmxINkRZQ3dj?=
 =?utf-8?B?KzRPNkRBcFY1VStJcnhSZzd2U2x6SmtERUdhaS9EcTA5M1JjQ2NPVFprbi90?=
 =?utf-8?B?UXA0RWdHS2xoeExHWHNaU2p4Y2RMK0pSZkVqUnhSNTNOcjcvRjFxNE5WaTRM?=
 =?utf-8?B?QmZPZlZYZldNQTRDeFVPVVBhK2FGcG1ncUhVYzFvb205ejVhVllVTlZyY0Zz?=
 =?utf-8?B?NkkwZG85ZDgxZTdlNmNLL3FnNmQyZWpoOHkzVnd6Rmd6TEo3OG9MeDBmMlF2?=
 =?utf-8?B?STJtSzRzU1hZSk5Rem1OUDNwVmx0YU55U09yUEExb1ZWZy95MHdnWld6VGJN?=
 =?utf-8?B?VDE3ZmFBb0k2eXk5M0tadDFybTJVeS9tSG11UUY3Q0xuVFN2MjdOU1lsOEtk?=
 =?utf-8?B?TWZaSk1kZ2YyV1oyVkVPQ3NJbWgvMjFUM2NYZkpvM1FGSG5LYTUyT21sTkNz?=
 =?utf-8?B?a0crZ0Z0cGpFL3ZkSDhQeGRHZUcrTlRkNHZ0SzV0MXIycjZFU3ZQdVp5Tnll?=
 =?utf-8?B?bUNJSkMycWxTZnpPd1pFcWhYSk5XYjYrcWFYWVpRdmdCSW9uNG5WR1g1ZzRK?=
 =?utf-8?B?WkRtZlh6YzBNd3pOYkZ3VytWWXhGNVlHNHV0N3dGS1ZPM0RSV3gxMGJ4ZnZy?=
 =?utf-8?B?aVpBaWFZQkx4VXMvOHNZRUZrU0RrTEJZYzhnMTI5eFp4YzFGSUN5OURTZW1w?=
 =?utf-8?B?d1p5ZG5VWGpBNUxvOFMzejFOa1lJZXAyWGNrZ2o0VExOTW9aMDREUVBjOFEy?=
 =?utf-8?Q?EDOQ7i2lP54Zoq6XRYgOjSGGG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02c16b1-12f1-4f4f-ca73-08dd2e2bcbe5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 08:26:19.8426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj6l9r4C/6+1YAxTELlJYL/TIaQ3BhK4PdbA3Xhyhd/DkhToFJ+JkRQ+v83aERvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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



On 12/18/24 14:01, Neal Frager wrote:
> This releases the DP configuration from reset early on during the boot process
> for K26 SOM.  It will also avoid the boot hang situation should any attempt be
> made to configure the DP registers while it is still in reset.
> 
> Fixes the same issue as described by this commit:
> https://github.com/u-boot/u-boot/commit/8b81010a2fe385524b58bea9116f1b6954c3d2bd

Applied but fixed commit message to directly point to sha1 instead of link
8b81010a2fe3 ("video: zynqmp: Add support for reset")

M
