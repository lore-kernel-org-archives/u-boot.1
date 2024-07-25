Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C46C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 15:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE7E87919;
	Thu, 25 Jul 2024 17:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kyc9qBuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06A787919; Thu, 25 Jul 2024 17:33:33 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9339E87919
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3WjQAdsSMDQOAz9xNdWWFcxvCnl7nwOgNNT6l+4zUNtmATDi1pVBCoMmqKq1jsJfBSiJX1d0LYAY9cF4j0W+aVI+/TN4P6i9AhZCfbFO9/+/XJCKr46eYaZvUboG2v/TogQ35b84nNnu23DMwAuPuHip8CEves+irMaMn7HENat3zBBxBZG7fF5+U0qV2DU+2lNBO8iVX1FAdu2qQOGz56BfmSfXwThy/L6q+FXKoAnsQ4dou0BlMimr2pvul0Y13GsVpHw0TZPXtqgl+atX1V4V+5lwyl8yQANSg4aTKkFFZ3izsGPPz7DvqjxyvtRQwO40wc6VH2oWDJPdqiJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb7XoEiqSjLLof0wCDgr3AXQX+CvFq2MfWuh3cdssWQ=;
 b=W7r8RALJ/CiVY7gG9RzpK3KJUnyftqObceG4rfZyZ10B1qNc1QjOBUj0c1d+ISiRuGEVr7U57LgAAEgTjlAN8V4yPaHoHKIykrFtz7ZqUrF7fO+dZCGDHWvkXsDf194wOnHJx4AiTXGb4ouPIENiQ6DMRFGQ3S4ltUPGtWwITqRKE99DMHkuLMiIg5cBzzqe6dIr9TIQ6mZF7/mc28Tlmw0D9+UuueGsMOwRR3TXdbUkN0Rj5owBFKtWug9w/JTZLoqX4XVPFBf0Ctc9g2L8CZ6sCK1tKaKeDw4AbgPwXUn5S80DUm54nBQERz0bvnXc5jzZtTnnok7xlv7DK8DiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb7XoEiqSjLLof0wCDgr3AXQX+CvFq2MfWuh3cdssWQ=;
 b=Kyc9qBuva5KdOZ/TzUVrz0RMgR4DrzRdFrMELhnPW3ARB6JffzgQ7pxx0e3Wi0IjA2KtjGbHxmH4Sjn0tNkqlTyIK9Gi/IxmGJRTGNayQEHqTxOOH232qwlZsvowxNleKae8bf+ImyruQHRHDoMqe10dZRyRvt50IOQdJ8AA3jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:33:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 15:33:27 +0000
Message-ID: <4121b642-5eac-4c0e-a1f0-af1b6b89e6c9@amd.com>
Date: Thu, 25 Jul 2024 17:33:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello
 <angelo@kernel-space.org>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Thomas Chou <thomas@wytron.com.tw>,
 Rick Chen <rick@andestech.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <b81b9431-4681-432b-ba24-3e24e7e1cb85@amd.com>
 <20240725144948.GU989285@bill-the-cat>
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
In-Reply-To: <20240725144948.GU989285@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0185.eurprd09.prod.outlook.com
 (2603:10a6:800:120::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 449719bd-7a0c-4ec6-3113-08dcacbf2101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dS80YnE2Qy9OZkFwQXA2Y2tYOUVQcjZqNE1OK2UyOTJvOFdIdmppZ3IrbFBo?=
 =?utf-8?B?R0JoL2dwUjFtYVpXaSsrSkp6V3VkZjBESEw2UnQ5bTVFSXJXTkRIVDc2b0dE?=
 =?utf-8?B?MkN4aGhYRjkxTFE5aGlNWEZNMjZBa244ODZOZDU3SjNYWkxReXdkbXZvQ2pw?=
 =?utf-8?B?bVZMcWtpU0plWlVWWjRhbVJ2WUVGaHlMUjFocW84Z1gyQXl4QzdiR3NhQ004?=
 =?utf-8?B?S1E0SXlNQjRJRk5NTWdJL0I2Ym5VbEVMS1NiRExQa0lHaWxBTDhZeW42WmZl?=
 =?utf-8?B?elAzbG1ZYUdWKzdMa2NzMXFXS1RrVnpxcWN6a0daZmhvVVhsV0V1eWhYSndR?=
 =?utf-8?B?RWV3aXZEUlZBVlFCcW1mOE8rNUs4ZmN3Tldza05waGpQOUgwMElhK016WTRO?=
 =?utf-8?B?M1NhNENNOGEwZ09HTHRpY1dYd0t0Y1pncFgxWnFiOUJuelVzNm9PcFpadzkr?=
 =?utf-8?B?WEc5bGlaa3pZNlM1SzhvaFdOTUdZWWk0M0xkZStzVUEwRGhaY1UveVY1NTlU?=
 =?utf-8?B?ZXB5dXFNK1oxUDZLM0JwMGxnZ3ZoR1QxLy9SMlJRa0lCeUVwVlBkVVVGTW1V?=
 =?utf-8?B?TWpRRndtWCtHM1pGSkNSWUwvU2hhYS9iOFgrYWJ5R2ZIRmV1djBRVnpsT2kz?=
 =?utf-8?B?dnl5ZXdCU0U3NFdPYXVYYnJvZytGZXJGaSt3YTY3cmhPT2RpMERTWWtkRmNY?=
 =?utf-8?B?NVJ6aGthRVUyUDFBeDFSbnM3ODcyc1puYWovMU9xUDZiVTFuVENSZG9MUnRj?=
 =?utf-8?B?TXJiRzhvVzFPL0FTUXQyRjhBNHVXamFEU0V0YmV6cFpHQStsK1RXTXpoc0JE?=
 =?utf-8?B?OG1kV3VMNUMyM0dWdnJheVpXUmlTWXBQZndmVHVueXFJN1BZM2hpVHFZK0Y3?=
 =?utf-8?B?NmRlMEN0ZmJESW5qZTY3TGVXVXNrUEF0U3JqSWdpbFRnOGJVVWMrZFlFOUhB?=
 =?utf-8?B?dTNBZGg5RytMMWJJa0hVa0FnNTVnU0tDdFE2azJWamV3K1ZaOTZVdzNRakRG?=
 =?utf-8?B?NHcrTFgvTmVUVTRrNDgwc2d2MmdNN21CY1JyMzhYdVhaRHdWUzZKTnQ1Smt4?=
 =?utf-8?B?bVoxbGNvNkFjVGpTTmdNR3hUdFFKVHZsblc0QXJjdGVCYkJWU2haN0gwMG9m?=
 =?utf-8?B?a3FoYkNLY0x2K1MrQVNFT29HN0JwQ01BbzUraG1iOHFIVHpIUGNuK3d6djEy?=
 =?utf-8?B?dWxOZ2Q4K0c3Rmw2alMrRkNQZmJDaTVZWGIwTUJJNUZ3a2pTcEZtRGZ0WVNy?=
 =?utf-8?B?K25sMHJ1dm13WWgwbUZzL0JCK01RWHNicWFpOWkxSXM3N3NBU1BBQk9FemNQ?=
 =?utf-8?B?dlZNNkFMN1ZpdC9oTlBOOHpUSzJoZGNUaFBmVnliUnBPVGdScTVIUDhRTVFh?=
 =?utf-8?B?ZTdoZmVaK0xkcVlFRHkrNXBxZEhXZmk0Wkdua0tpanQ1dldUZ1BlTVFzMDNS?=
 =?utf-8?B?dzdWenZ2RU92MG0xSzA3UWpJbzlSWXBzc2wrM1NKV3V2eDRHb3dIYkpyOGls?=
 =?utf-8?B?SFA2UkJaWURBT0RuLzVKd1FBK0dKT2N5di9ySG1xZWc5MnpKUHdHMEJjV0s0?=
 =?utf-8?B?aEVYSzZKQmE4QmJsL01hbDNaUkNUZDUwVm5HdkZLQzBMV0tQbkU3c055SlNo?=
 =?utf-8?B?MGlkZ0JhNFdhcENvNjVwbkl5QUgxSkl3Y0cxbHNwaHJlSzhaVTZ6cmJkUUZS?=
 =?utf-8?B?THVGVFl6akZuMTdkRVRab1Rtem9Ia2JVTGtHcWlpZStZckkwNG02bDY2QlFB?=
 =?utf-8?B?Zk1JcWFJS1BvanZPVEFVNW9xczZJQXgyMmFvUzVYdURuQys5WkVWa1gxckxL?=
 =?utf-8?B?RmdlcngwS1ZjWWxJVGdSUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3J5a2FHVW5IQkxSUEJpQXNtVFFCdldFLzlsNTQycFdEa0ppRDIrTC9rNFFn?=
 =?utf-8?B?cjhLaFhudzU0aVpxUWNNUzR2RlhsWVRGclo4YWx4elp5ZXJ3UUkzTHFwNmVx?=
 =?utf-8?B?alY2Q0U5S0prNXpUQzRiWU1KeWVJZDNFeG94VS9peFNYdGc0V3BUYnR0aDF2?=
 =?utf-8?B?Tm5PZ3E0Y1hCYWpNQ050Y2ZpU054b2ZHUXJzdzRySkNPbGNNZUlkaXpVdjh4?=
 =?utf-8?B?Ti9zZXM5NzlkZlNqanhsZUdLNjJPeVJQYVVVRTlyL0pNZDRZRUJqVk45ZDdp?=
 =?utf-8?B?dFE5anppWFhqMmtkbTJMRVdGOWduK3AwZmVIR0NrMW5sZTc1YUFRUEQzK2RN?=
 =?utf-8?B?SjluZ1RzTnA5eHgvTHJMdU5hRm5TM0dOcGxIZG1LNmN0UHBLMkNHUWpQQ2NE?=
 =?utf-8?B?WkgxdXNXK200RDFVWGlBTXNIY0JqcUZiMm5XUG5oQ3JNWHF2UGUxcFVERk81?=
 =?utf-8?B?citlUDU4ZVFxM1Vxc09aeGYxcXlIVUQvVWRDSlRxNVBLVWVlWDFpV2ZsSis3?=
 =?utf-8?B?U3ZxZG4wN0E4ZzRiMVNKQ21xRXBnRU11dWQyRzNYMm1rZ1l2anQwclpEL2s0?=
 =?utf-8?B?V045ZmlzWDREa1ZtRjV3MGw5SlNXeEtOYkZhZGdiWGNPSE1wbXNtV1FQbGtR?=
 =?utf-8?B?SERpTlZueHM1TjdMVEY2Q3NzRFhZOFVRQUU0anhCZmpnWjRCbURlNkQvZkJy?=
 =?utf-8?B?RTBzODNqSEt2VU1GRnVrUkw3MEpNSXBBOW5NdTYyS1l1SmdOQzJzeDR5VkRs?=
 =?utf-8?B?d0dvMkxHb2FBcDY5NjNGL3kwSmRxaGduVHFOTnhweEFjMTJGdjRnWURCcmUy?=
 =?utf-8?B?cjJBc3ZHK1pFOGlmM3dnbVZ4cHMza0U3czllR3VKZFNtYjBmL0VIR2Nwbk9M?=
 =?utf-8?B?cVV0ZVc1UmRpb09LTXZwYkI3MFBBRFIySGdMa0hjU1RWOE1ENlQ5bzVIWlJw?=
 =?utf-8?B?OERTdlJ1MDJpMjEvbHp3Z2tJSVRYVnJTU1pwd3VVM1dQckMyWlVSemdsRTJP?=
 =?utf-8?B?d1NEQytUVUNlSUtWaGZDR25QbGhwbjR4SXFHZVArc0kwc3VESENYMWkvSHht?=
 =?utf-8?B?TE9yWTdDVW5LSmQvbjMrd05YdS9sRk9DT3NDdGs0MnQwQlVrZmtCSmpTeTc4?=
 =?utf-8?B?K2tFRnEyQkMwQXRVeWtSMWE2U28yZTVxV0tNdklObHM0RUFvTkcydVUzOXZ0?=
 =?utf-8?B?Q3Y4MGRJTHFBS1ovejNWL2huWGhaamVWeHpxbGRXWFYzdHkxSHZoSTNFaGM2?=
 =?utf-8?B?RUlPUlZuSENKZnlaY0FNRXcrYUJZMUtVMXoxaWszdmRUYlhrNFFSem9BS0lw?=
 =?utf-8?B?QllzNGZYZ1Y0cmhzRUJRQlozbnhNSHBxY0NLSTU0dHhaSkNwck95dXpOdkor?=
 =?utf-8?B?UzFpN1lwQ1dnd2dqYTI3eHBqT01DckZPc2VFVjVZL1IzNkgwL2ZsUE8zVDZU?=
 =?utf-8?B?NG81VFg3RnU2bWF0RDBnaXVyYXFlWnk2QWZ1aHpUS01FbWhHOWtVZkxCeG55?=
 =?utf-8?B?dnQrSTU1MURValU3YTIxbUpuRmdNeE9jMlhQZmdmRG8zc05TbGVXb2JmTHh4?=
 =?utf-8?B?a0VBSHhWM2N4bmpJcGFzWmc2QU9LVUpLQlY0MjErTVptN1h2VUtoK1k0NnBt?=
 =?utf-8?B?ZWlZUkJWcnkzWFhEZ0wzTkkxeTl5T2liYTNVS1pRdW1mbStEd1NpRU1MeUIr?=
 =?utf-8?B?a1JGaWx3ejQ0K25od0E0OW5pazFINldsOGpjQ0IzaHl1cnhURGljZWZFMjB3?=
 =?utf-8?B?RFJVYmx4ek9aK1hjSlVrUXNFYkpqMVZGK052OVUrZTZTdk9VcFE2Sm83cnVY?=
 =?utf-8?B?NTN3cktzaVdsMnFPK0JyQlZQS1Bwb3RrS0tSSGdsY2VvRlRpbDJUZ1FsZ0NY?=
 =?utf-8?B?MnNoNERwbm5SSk1pUnpHaVJWT0dScVJlRlFFRnI4UWlIY1pKRHFvTXlhdXNa?=
 =?utf-8?B?bWZuejdIRUo0MnBpOWpOaXBSTG5QYmZxK1FBV29hazZWYzIrZ3RmTit2R2pQ?=
 =?utf-8?B?WUUxWHk3N0RtOWhMejZkMWpQRTJQSVVESVlPZS9PeERQbWhEUzZ1YVE1cjYx?=
 =?utf-8?B?VE02N21qM20wb21IelhMbTh4LzdOdlpzUG1pQ0RkVU1LM0l5SVJCR0dwS3p0?=
 =?utf-8?Q?LLNzvepnBYPzPBesiour4UbR7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449719bd-7a0c-4ec6-3113-08dcacbf2101
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:33:27.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrZXx64GJKKYbPPBnssTLP6YtESD6i9XqwRjXCZmf667tQ9IdYvXV0vOWf8ukKKl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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



On 7/25/24 16:49, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 08:13:38AM +0200, Michal Simek wrote:
>>
>>
>> On 7/24/24 22:54, Tom Rini wrote:
>>> On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
>>>
>>>> From: Simon Glass <sjg@chromium.org>
>>>>
>>>> Use this new data structure in the utility function.
>>>>
>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>>> ---
>>>>    lib/strto.c | 35 +++++++++++++++++++----------------
>>>>    1 file changed, 19 insertions(+), 16 deletions(-)
>>>
>>> This is rather big growth when we didn't already have realloc:
>>> 05: lib: Convert str_to_list() to use alist
>>>      aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
>>>               xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
>>>                  u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
>>>                    function                                   old     new   delta
>>>                    realloc                                      -    1120   +1120
>>>                    alist_ensure_ptr                             -     140    +140
>>>                    alist_expand_to                              -     136    +136
>>>                    alist_init                                   -     108    +108
>>>                    alist_uninit_move_ptr                        -      76     +76
>>>                    alist_add_ptr                                -      72     +72
>>>                    alist_uninit                                 -      48     +48
>>>                    str_to_list                                204     232     +28
>>>
>>
>> this is definitely not acceptable. This mini configuration is running out of
>> OCM and we are already pretty close to limit.
>>
>> What's the reason for this change? I can't see any explanation in commit message.
> 
> It was more clearly explained in the cover thread for when Simon posted
> alist. This conversion was an example, so dropping it from the lmb
> rework series is fine.

Perfect. We will also extend our configurations to have limit setup.

Thanks,
Michal

