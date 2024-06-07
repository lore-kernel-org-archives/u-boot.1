Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E26C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 07:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E960E8824C;
	Fri,  7 Jun 2024 09:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1yPJNOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C99D8823D; Fri,  7 Jun 2024 09:53:04 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0138A88444
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 09:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek3w2XtNPV0NzBiyA39LKC1oWaauQmLgterIKehoMUDbnODN3DablbCchJSMXGS1SCr6qsj2XT7dCwP7j5kwBhsB6mv0pj+PIIda5zqrzFl6AmTXKdYF1/n15ijuSMu/bgGOZDEVlB/WSao63p6/y+SRYRAbwkw9YOUlou20iKlMUBBeclXpBhJEMM4q9GQpOTuYbowdBWtNYXeFXmSUDTnvLWnJKhXEFUGEKAUHeuIaGktJUkteVndkrUaune4qkgUFDL5Ti5+7dH3KXL8IrZ19e98ClqxbjxJUtrSCukLl9gk4Eh3phVBLOhnWBkctrsLw6tw9T/TRCzNxt+B9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJa/La8sARKAIhC3hnu52RJbCjyf5IF/BlUnnDef+b8=;
 b=IGPax0kFp3AQ7vfDHgTOx7tJgxmge8MgfrpK7Z2fChAwRhD2xraKOo2LPQfBcKtSiZByJpj+QAI6wch8q8vuUFHQrreBCke9hmcZXWD91vUVZF3ODOysw+s/Py4GJ8CMuxH+mybXIWqx0+60S8PIN7+Wrg6BD81T4U6zQ2QpS1O+IZGKXKsRADGYUj3VYR2zMYj0S1y75ty6yj5mEZvP9UTK8Zy128+W18df3yH6o+vOLsNyUAyzjaRZJKrHuZ+YRepmpV2WGkU7ahCwWA8ujPHh9NBVMOuMJyKA1qzkVR+DMJGGGfG7qEcsV1F88TElvS68Wr0J8uaY4rTAe4gSNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJa/La8sARKAIhC3hnu52RJbCjyf5IF/BlUnnDef+b8=;
 b=b1yPJNOhDd6mwp/Jz/fA98aUgRFH41Qq0w+hBVmT+Rak8LBjjzeWLJ0AN6qfVHcde0Yw18RmEqPGjT0eSbfiATQSP/PDzeoAuAeLOaCJJjVldknlcbBZaHTDxwSvvKAWnsKRbXJXfFbRrljF/s7KmqmYJdz0uxbIH/TWOZgP38E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:52:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Fri, 7 Jun 2024
 07:52:58 +0000
Message-ID: <948f56e7-c0fc-491a-8364-0c1da24133ea@amd.com>
Date: Fri, 7 Jun 2024 09:52:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xilinx: Enable SMBIOS command
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1714138688.git.michal.simek@amd.com>
 <8fc5eb2301e6d1f1851bbf5d175ad5770d7ece6f.1714138688.git.michal.simek@amd.com>
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
In-Reply-To: <8fc5eb2301e6d1f1851bbf5d175ad5770d7ece6f.1714138688.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: e97a3bea-6bd8-4073-fd8c-08dc86c6d919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUY5OFlTQUVuSVpoSWZZeTJSak1VVjdVZW5lQnpXZnErQzJETjVvQUlJejdZ?=
 =?utf-8?B?SEJjQmphVTVUODBRcHRqUEtoWFVrRUplWkhEUjVuYlZhLytmOTVQTHkwM1JW?=
 =?utf-8?B?ZSs1VFJiZWpjQnppNU5WM1NmRmtNQjlSRFRHUlAxKzV1d0RabG0vYXRRdjI1?=
 =?utf-8?B?cE1aWmhhR1hhYzZpaldNWitUQm51czJLbnVwN1l5Skl6VWdURzRRMkh2Um9X?=
 =?utf-8?B?Rkd6bzZ1ZUgzS2l4eC9RVENlWXIwRHVPTlk5TkJYN1E1Yk1UNlFrYzlRYUhl?=
 =?utf-8?B?cVA3WXYyUjBjaytHTERGY1VlaFRiV2M2eEZ4ZnkvTWJjNk5IRVhOWEhiK0pE?=
 =?utf-8?B?QnNFdmQrWjRtSHlVL1p1MklCRldyd2djNHlKSWxtR1lMNktITXQ3VFNzSTZN?=
 =?utf-8?B?aGtYSFNOaklIbURoT3g0VGJ4RUpRbnAzamM5SllIbUVBRFlhdGc5U2lpMkFw?=
 =?utf-8?B?dEVFRStUUitCME9zMHJmTlA1ZUxhUzlDWkJBRmpUMmdFNzZEaVVORFFSN1ha?=
 =?utf-8?B?eHZtNFFlQU5IWUhTQzczamJ3VGNvbzRGNm0wdmtZVDg5dzZPUlN1K1B6ZEJt?=
 =?utf-8?B?b1JRejg5UVRFQzVtN28zMGU5eS8rWWpDODFrUTdHaTE0aFFhR1Iwa3NQUmhu?=
 =?utf-8?B?L3ozLy91RHlVTnFyOTl2dVp2aExVeGVWNHNGaCtlN2p0amJubzdqTTZnOW5W?=
 =?utf-8?B?ZmxJeEZqRXpGQXQ0WmFHQW16REVoMTRkb09DZUxBK1QzSTNmekZlMlY4Y1JH?=
 =?utf-8?B?QWtiVmpVMHhyaDB5NmpYYUgySHpzQk1pSm0wTXRpVUZBL05mRUhDMi9Hek5a?=
 =?utf-8?B?cDYwWlVFd1VvOWdYOVFWT2FPb1hjN09aa21IdzVNbjc3ZFpVcklySEdxbUVa?=
 =?utf-8?B?VkpDNUUzbU1aWVB0eW8zUjdIVTRIbHUrcDBHQ0tIcWExRlRzOFhFdzgzMGV2?=
 =?utf-8?B?TDBuK3Y3NmJWS1hpb0MxeWVibGNPZ2JJRkIvSXZKTkhsbmxFdzVTVFhxUjRT?=
 =?utf-8?B?Y3N2cFROMlpka25PZFp4L3FaM0tSZkJXR3Eyc1lmVnY1ZVpkKytkbEdmWVBK?=
 =?utf-8?B?M1RHem9KTzNYSElueEhqQWcvYWhmU0pQK051bUJ2eVd2b1dxbkZtME5UT3hU?=
 =?utf-8?B?eUYrRFJhYTBwWkxobFkrcU00SmljWG1LRWxPRVB5TkNkbjM2ZkNEUGcrWUFi?=
 =?utf-8?B?akM0UGZVTkxGbVpQb2loZHVPVjBQVFU3cThzL1BEY0JtaFRhYkNib3RoOEt5?=
 =?utf-8?B?V3hvT2ViMEExVmM4L3JkSStuZFdlaXRwQXZhL2N1UWtxWVJNbW0vR0dlQS9N?=
 =?utf-8?B?emZwbUN5L3hFS3RPWVl0cWQ2ZEVUSFZKSlBnalNQSFo0bEhmRll6eW0wd2RV?=
 =?utf-8?B?aExmdWM3SUxnWXJqWnlXd2VWVXRKUDNCNmpISmVsV0ZaMkpnWGFtcktjS3Bp?=
 =?utf-8?B?RjNCenNmQmFEN2drNWxnNDVDajRqSXBFYzB5dTdFNzRESFJRUWhvdTFPNUk2?=
 =?utf-8?B?SENFSGdIeEVVVU1GdmxxcDFMdDhudmxtQ3NidnFGUDZhaHpRNGp6UlJVbHVv?=
 =?utf-8?B?SWlPUDRzNFpMRnpXdjM0NnM5bW9LVWlOdEszbjIzNUZtM1I2aEI5WjFSVi9U?=
 =?utf-8?B?QktyOFMwODhXK2ZkTnVFQkwveGo3eTZLTFFpZWg1dFYrSFFQeWVjcjI1cjlO?=
 =?utf-8?B?ZXRQQ0tIeUNkaTg1aEg1TUdPdjRzNVpjdUFOYnAxd0k1UFdJc2hEVUszelhG?=
 =?utf-8?Q?dkZRewT77/VV2aSQsQhHBpUIeU8gSpNvhKy7CYM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S09QNktBdEhyNWlWSm85Z1MzWldJU0Y4amxpaDNWTXptakh1eDhQQm9kejFZ?=
 =?utf-8?B?V1VDemNNZEhMUnpZVmEwaEdMWWsrb2xkRXlIaEc2U3BFZWg4aGJUUlBRQVNH?=
 =?utf-8?B?L2RSbXJGWlFxVWFNUUhhZXd4dWdYOUdLbHQxd1IyOUZwSWNPMzJXMng5ajBV?=
 =?utf-8?B?cUE2VGdpZkplTE5zSlY5Y2Z3YWcwQjMzZ3RwYndtUG95blVCcFhGWnhONGN5?=
 =?utf-8?B?WUZBQ2pieDVQR2d1dGNIWWEwamZ0NmJQUDZBSDhFK3grTUtxTGF4ajhWeHJu?=
 =?utf-8?B?YXVXWG9jV1FCRnY4NitDWmVNQUFjbFJES1BVQVg1VjU3VG96YmtUUCthSnpB?=
 =?utf-8?B?UlVpSFAwUGtvd0RaR0tieUVqL2dUb3JQYS9Ob2tWMVF2cTVNSnViOXM0L0pS?=
 =?utf-8?B?MFJITWphVytGM2tCbkJhT2hyVkJ0MXFXYnVpOUpvbFNLZnpaTXNKZGZGcUVG?=
 =?utf-8?B?VmVRY3ZuMzZHTEZnc1J0dFU1UWtsRFNiTjVOc1BhYlI5dWdiR2N4NVBDUS9l?=
 =?utf-8?B?MkNzKy9xVGNGM2Exd2tKckdETWNlc3VzY1BycHo0NU5sQU9XNWt5Ynlya0l4?=
 =?utf-8?B?SEtNVUI2YU9qeWlWanoyWFRUWFR1V1FJU0pDNE8xQjJmYU9QbDkxVWJETWxa?=
 =?utf-8?B?OHdXT0RvUi9sRDg2MEpLckd4Y25pYm8rR0JETzJodmF4Y3VsNnN5bUx0UWlx?=
 =?utf-8?B?ZUtVUktqL0FYRzR2WHFxV0FQRGhwYlJRZ2hDWGhKRVEvamRJc2RhdnpYaitB?=
 =?utf-8?B?cG1kK1FEMFVWakNDQlBLUFhTbkdQT2VxdXRoT1hybXdtZ0RzY1hFVUhuaDFv?=
 =?utf-8?B?bE5weEg1L3dDTzk2eGUxMVV6OFRDNGs1cDZoR1g2a0wyT0k3SzBVT1duT01o?=
 =?utf-8?B?enhrTEdtdG1lSnMyczJaRXNRNEtQK2NDVWxPS3I0T0srdXljQnFGZXdXNjRh?=
 =?utf-8?B?NXZzZ1REQlFDWkFWNUxtNHJtcjMxa2FvdjVTOW00Um1jTXVLMlpTRjdrOEEw?=
 =?utf-8?B?TGl5SEJCWWswMVhYc00wUXpkcnN6ZVlONU9UdVhxU1pRZnNjVmx6WlY0NUMr?=
 =?utf-8?B?clNFbUQwNUxqMEVUU3FzeWhzVXMzeS9MMmRSazRhQmpxaEFqcXdhUnQyZHFm?=
 =?utf-8?B?bDg0ZnQvVUtJVjNRUGZxZ0RSL1hST005WlAxSHFlZmpJWE5oSHlNTkUwSlVX?=
 =?utf-8?B?K2w3WEFQMFF5Rk95bGViTTNDWFFwOVlQREJMd293VmdGWkExdkxnQ0EvSFAw?=
 =?utf-8?B?SVdaTWZ2d0lXMlRCUWtOL0g1RUM0U3dQTXR4aDNIdzVmYzhQL0JBN3A4NDVD?=
 =?utf-8?B?dVZGNTZlM0pxK3l6TnQwKy9adXdzUXViU0Q2L2RSbVFMMW4xWG1qOGhVWXBz?=
 =?utf-8?B?cjNxNzRWTEJSRVdBMENpM3ZldGRUSFBOMkg5b1lYTWFBYWZUS3R0MDVWT3Fh?=
 =?utf-8?B?UlFqSWQvaDVUa05zYldkTkRLejVyZEJUL1hWT2s5am0xY1ZsR3ArNGZMWjJO?=
 =?utf-8?B?bWx2aG5YKzRxT0d0ekRWRDR3R2tEQUhZMHZmNlFJK0xKNVBPR3AyblhPUklw?=
 =?utf-8?B?T1ovUFRCUmhYdFFXUkZCQzRla2NFcXIwb2F6T1BacW80cU5uQ3Juang4L281?=
 =?utf-8?B?L0toWG9LUGo0VCtITklFbU8vdzU0WVkrenlPTmNGdzNjbEh2RTRKWVNqSFFQ?=
 =?utf-8?B?K3RkZmcvUGpJL2t5UHBXZHJMeTBVTEMvckRrd1ZRUHoyZzBleEtxazV4WVJj?=
 =?utf-8?B?ZUtnamVkWmViamZRUmFycHE5MG5aUlY0UnRWanBMRXJkY05Zby9VVURxN2hZ?=
 =?utf-8?B?aTczRzdRYWx3M0kyVFkwb0wxaHZybkdUNWVleFF1N2FvVWx5UzdtNUFKUC9X?=
 =?utf-8?B?TnNrUlNVczlMeXAvNEU0U09WVkNJS3QzYmd6eWFMam1odTJ0SGdpd1hrN25G?=
 =?utf-8?B?eG5NV0draFdvNnFjS0k4YWY1WFo1ZWNSNldtQkxmYVVKRnBEaS8xbVdjUHl3?=
 =?utf-8?B?MHlCV1NPK2RNcVlRT0ZzZ1Voa28yQ2lDOVd5MTErSXV1Mjk0SmttdHNKZEIx?=
 =?utf-8?B?UzI3SzhGQXZ5WFBEck9WcWhiRzFLUWtGczV1b0pwckJHV05rK0xjSGJOYTdR?=
 =?utf-8?Q?WYBGXNZY6uTJjP2a8NIgxlxkT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97a3bea-6bd8-4073-fd8c-08dc86c6d919
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:52:58.6399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0rSA8Hgxkauvj6X3B7ECg91qp2WDqCR25gY/9w4R4fAAkryugkX03RfPH6uQSLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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



On 4/26/24 15:38, Michal Simek wrote:
> It is good to be aware what information is shared via smbios interface
> that's why enable it by default.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   configs/xilinx_zynqmp_kria_defconfig     | 1 +
>   configs/xilinx_zynqmp_virt_defconfig     | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index d9e2e050ceb6..3c7e37d7c81d 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -26,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
>   CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_CLOCKS=y
>   CONFIG_SYS_PROMPT="Versal NET> "
> +CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 95a671db363e..b7c3a4f96416 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -28,6 +28,7 @@ CONFIG_SYS_PBSIZE=2073
>   CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_CLOCKS=y
>   CONFIG_SYS_PROMPT="Versal> "
> +CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 7af8b27be931..41798ace6bc9 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -54,6 +54,7 @@ CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 296adf066b10..772209dd6b1e 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -52,6 +52,7 @@ CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_THOR_DOWNLOAD=y
>   CONFIG_THOR_RESET_OFF=y

This patch is independent of the series that's why I applied only this patch.

Thanks,
Michal
