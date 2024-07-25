Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66D9C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 06:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70BB88A01;
	Thu, 25 Jul 2024 08:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GlQsQMrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823D988A02; Thu, 25 Jul 2024 08:14:08 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52847889ED
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOqZrs/ScTonYdx5m5GOtFSaMyNuEjMnZWGkyxxO3cCpArHgGgzsv3J981bL0/PdWT1c5K0ckFwvLJLM0HOmKvyKHZVJcj+eiznwjeoIGcGRqMiPShput3eDFF9Fijvp2LhB5ldsv0NIxtyHHAjBCyISTYngZVgdYM0uS9wzD/c2hg5vm0GlPYn77+gtEMY7SzR94qKUBskwTD/L5y1PmT/WniCS0AzHPP1EEBp8+mfUqQzg2uN1iSKwzRhBwz1EkNIYRw4ZO+FAiymQ9wK8ZvqqZ7LYjX2Ldy9jIEaaT7XMZlH/qQkkPA2BgtZtua6CI1ugF1rK5VMLy35rM+Yikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU4S4Z6xrfewkAjgGmaSSVa2GJWLjCKxs4LMMl/xjyc=;
 b=CS+kEGDHJ5PvY+Fc5y8DREwZP7gr6xl6HnSQVVtGDTaQWGulBO1oWFvi/ZUOCnOCV/0FYSIDyxPVduW4M2mHWhAXJgh5u9UkT3xn9mpcnGrPXEbpj/pJ/6F4ZRehRusattT11NEgahZXkOnAYD3YDlJCfQYWoeWX25K1jHUDo57msT4rIjGSt4qOZm86sCDhB8EBqFu2ihbNFJTgB/0ZBFekRUKFG4Z1Ov2gHN356DJWRMpCHfDjcq7J6d3ZXu4kUSNBPtogGYw+Soe343rP1ZBL22wGUcn9y3Im1OGrKvWAOUQUXWbUWTDaVOtsy7Dlxv0q+XkayKgVXqUmcSMhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU4S4Z6xrfewkAjgGmaSSVa2GJWLjCKxs4LMMl/xjyc=;
 b=GlQsQMrjpHk7Ijju60++NKCh2Qkz560qEZCLZE3UDmOAyUl6YeD285kVvBK+AFUfQViVIUfh3kotq8JASrGjVD9axAqky074uxnG5WBClLwHWJ/aKUkVmbnFp7S+WEjoZhSqtUQsXQSVnSFmYQY3UZ404yEt6pyhvxey/pxavk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 06:14:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 06:13:55 +0000
Message-ID: <b81b9431-4681-432b-ba24-3e24e7e1cb85@amd.com>
Date: Thu, 25 Jul 2024 08:13:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
In-Reply-To: <20240724205418.GM989285@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0274.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 34edbb71-6c36-453c-d22d-08dcac70f678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnRpUmQvV2lWRFdvd2RZSWk2Z21keTJ1bThPcHprelQwck5QT0kwQWJ2UFR2?=
 =?utf-8?B?UlVKVlh2cHc1K0h3aWQrdEZCcTlod3F5MWR3ZTJCMHp3V2VUQXdMT1c2YUZG?=
 =?utf-8?B?M2hBcGNDWTlYM09xTEVBM0hueFlDV2FzaEJpQ2ZKYnYvdlBFbmJwUEZFU25q?=
 =?utf-8?B?WUJwaUdoWlRjWDNXWXFhNEppMDdyb0VLM0dFVUl2VFFNcEtidDU2U0gwYVBT?=
 =?utf-8?B?YWtib1g2VFNOL1hkdGowZ1RXUW9XRVhNaTA4WXcyKy9aQ3M5ejlKMVpoWGw3?=
 =?utf-8?B?ZlJJU1NuMTNIL0VubUhSZ2JuZWt4Wmt5WmpmL2YwN25NTHY4UzJ3OWY5Q0NU?=
 =?utf-8?B?citudFU4M2xIM09uTllWQVdTamppMGIrM3Y3UHpCQWduZnBiQldlRlVMaTVK?=
 =?utf-8?B?MWV4V1JmV2l0TXY0VU9KS2VsNmthbEZlZFprb2NERWE1ZXlWc1EvUW01T1Br?=
 =?utf-8?B?L3NHcG1lS0pZVjE3WjV0Uk5SVndpTmkvMG9SYzJaVTVFOWlCQjFmS3hvejd4?=
 =?utf-8?B?T0swT21WaWhnbFVUQXVPRFpERzVlZXU1K3JJQ0M2OWRDTGJwWElXRFhXT2Ry?=
 =?utf-8?B?U2xXdEJMV0hBbFErQ0o3Y01ERmVibzFWQUlzQ2tzSmJCV2FGTGtpNkw3Q203?=
 =?utf-8?B?czB0VkQ2RnhuWDhncE9tYisreldmZitSaDVqenR5SERQRytMTG1BWCtYbnlF?=
 =?utf-8?B?UnRYWk9JanBRN01TNjJFUFpZZGNYWWY1SDZZNndSalUxUlVnTmpLUXpFRnlm?=
 =?utf-8?B?UVdEY2FVWURPdlY2cG4zUXFPOEtuSDNkbHlKcDhxK21JZnp1YnlXNjVzb2hs?=
 =?utf-8?B?cXQzcDh1TExyaXRtU3AyYlVPaUR2MkZNU3dXZDlEcnY2UEdsTXl2NjhUbWVI?=
 =?utf-8?B?WHNJaCtkOWlJN3pWRnArWHA4eG43VGpvcTM4QUkrbVdNUTNoYXZuNHBPdEpx?=
 =?utf-8?B?TjczZG90TjZNMUg0MzU5czRpTW83MDRKY0RWQklhSysrUFpnT21iVVBZaElh?=
 =?utf-8?B?cTY5NzBkcWtpbGZLbWJxVDUwV1NCTXlXa21lblJxTmRabUw4akowR0RobG5l?=
 =?utf-8?B?QmRXeXMxcFJxbCtwOHUyMFJMbnFSMUd3ZmxEN0hzT3JvWEcyeTRnT1RoM0hV?=
 =?utf-8?B?RyswMmY4OUpCcXE5Ri80dXdiU3BGdEJyZW9ubnJqME10TFJCVGpob0l5VEZx?=
 =?utf-8?B?dkdiOEtpQkNaWHowWVdhbGlXVGI4V01BS05EZU9XNWxPejZQcnFEQVltQ2Uw?=
 =?utf-8?B?VmkrUEJPZThsK2l3bHJtUnRvY1l3VWJ1SGQ5ZHBJWkVRVTJ4STgzOUd5Vjg4?=
 =?utf-8?B?T2ZmQ3QxUXRNNUZ1RDErL0RvNU1Da0pma2xzajlYVWNpY2Z1WnBRSGxibnA3?=
 =?utf-8?B?b28xUnJNMDVzT3V6L0d3RUdybExldFJjUTRSNnkxR3ROS2ZWUDZTQ1owS0tG?=
 =?utf-8?B?eDRkaDlrUkZ6UlhiaEoxalZGVUNEaEl3NkdoTXdYeS9STHRrNnJZOUoxRm04?=
 =?utf-8?B?eXdtMVo2ZUNKMXBhZHhXSjNQNzI3ZStyek5xcEQ2VmhPUzdRNHBKbnQ3NWx3?=
 =?utf-8?B?VEpZbVhUSkZEM0RYS012L2lFc1FYbW12Vi9zMGhNOGxpL0w5UXU3QktLeUsx?=
 =?utf-8?B?dk9NUlJIdGFMTysyUjFlZDBkTGxpM0M4dWh6VWFoUzZnSFZDbkVRU29RVzJw?=
 =?utf-8?B?NVNUY0tvd0tPZ1JMMDJsdEE3TXRyL3hUSklQeGRiczRpSE1WR1VqOFNwZDNG?=
 =?utf-8?B?dThabHlYSVZMd2N2OUFUY2dhc2NaY2R0WG44WXJjY2lRZ0RsangzTTZJQUEy?=
 =?utf-8?B?VCtTZGtUdUZvWndIRDhPQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmx4dnFhNFpXWmRsQ2Mvb080cUNjMUxjdUNpemdSRTg2MWVoaVd5bzVOSGhx?=
 =?utf-8?B?ZEtrczVqcFFZRnJIOEc3QVJXR3hZNXNJdmJMV3Q1YUJLbjFsU1E0bFhYS2xK?=
 =?utf-8?B?U1lGUFJVQ2Y0clJ2cWE3K1k5bXYvNnZRYjU2WnZIOWJiQ3lyZW1HT0ROc01P?=
 =?utf-8?B?cmswdml0S2p0MmFaN042MmhyYmZLVlZWcXlPT2tjQXRKejJkQjdFS3BHTS9P?=
 =?utf-8?B?Rm5IRnVMSVJ6eG52bUZjcWpEcmhsVmgyZzFWeFpjZ2JtSTRMSXhLZG5Hc2lu?=
 =?utf-8?B?d3VTR3c2UC9EZmNMWElvWk1yQzlsekJGVTVCZEtKQUV0RjlEMG9DOVVlbkFx?=
 =?utf-8?B?bkhkYUpOVlhCR2RkUGE3MUxGdHc0K0dWSGRXTXk5Z2QxVUNMaEtvVGk4RWo0?=
 =?utf-8?B?RGllUVNvZW5OaVJRNktld21LOTV3bmE3bDF4YkJtVE81bERuaExHZDNVSmFP?=
 =?utf-8?B?QklUS3dKV016bzZrbEc5U3NZaStxQ3gvOTNacVJ2U3FtUUZvVWVvOHZEWnZE?=
 =?utf-8?B?aTdoRGZLNzBKTFpoLy9JYThaOFQwVHZGSDZza2hJYm9hZTJvQkJPLzZXUE5u?=
 =?utf-8?B?SjZYVGFCazFWMmtVMGN1c0pNeUVnRVZBalRNWDFzUStVUVRuNnFGWTlIaW5J?=
 =?utf-8?B?S2NKdUNNSzNMV1NKVVRIWWk5aUtRTzA3TndxcUVOOWtIdlFSUWQySTZCbjRi?=
 =?utf-8?B?VVBBSExpd3B5aHl5bkMzc2ZmV2NjZ1NEenFHZDRGTXJIN0xvRS9RKzhiZnZ1?=
 =?utf-8?B?UFBDcHR3R1hnVDJ0Z29TaHZJOFpmenJVZExmSjQrMEhuMXRJeFpub3lDZlMx?=
 =?utf-8?B?K1hxbzlxazJHRE1USEFqdFpJUVAxdDdjMTFocTBXTmVjc0RNNXk3OFJPNGt4?=
 =?utf-8?B?bk9HVWhkeTNvZHZka3BKVTVuMXB0aWpsZWE0enBuck5wYXIwTWRRZ3RKQ204?=
 =?utf-8?B?VnNGbGJ1TW5XZmxvdVhJYUlZWkVrK2s2cXBvZkVnQm8wTmhjNE45SCtSd1pl?=
 =?utf-8?B?MFV0SHpKSkM4L2puZkFQOHprMW42SlFSK0pubVhEVlE1T2tVRXI2RTFrSXE2?=
 =?utf-8?B?NDlHS3VtbUh6RVVpMnRHdlRON0lDRDFhUnJiblFyN1JOcDhPTVFMeWdQcHp4?=
 =?utf-8?B?a1dtcDVBK0NMaGVJV09CVVhQSEFibWVUK3FyYy9zWDVFb3RLQzV6SENWUTZl?=
 =?utf-8?B?ZDZRaW1ROGJNVVNjanJxNm9HTGYxOU5YVXEzVjVlNURuV3dTek00VjJmMkF2?=
 =?utf-8?B?WlBGR1pYMVV1aEUyRWJRSHBhRGlySUtyemF6T3NsSmRIbHZWYUhOVXlGUEc0?=
 =?utf-8?B?b1BVLzJaYmFRR3drYTRhMU9GeU94bGR6TXY1U0NiQVdhRjVydmt0elUrUG9h?=
 =?utf-8?B?YTU3ZmZuY0o1bm9tTmRmWXIwN0JmTlNGUzhQRWRucHMzdkg4dXlhdWQ3QmRD?=
 =?utf-8?B?TFNrNFZVN2J2SXhybWhidmE0VFZhNGpvUHBQZFRaTnJ2bENpa1J1MVhKZ0gw?=
 =?utf-8?B?T3BLSmQxZ0RJTlgwT3J2UHhoWjhKb1NzeEJsU0I2a1l1TDYrc2ovczIwbXMr?=
 =?utf-8?B?VG01NWpWMkhiazR4L1dXRmdBb3dqcUh5TEhZN0dFdTdTbnc0SXUrVllnS3Ba?=
 =?utf-8?B?RmU5VHQvZldUWXVVMk1sUnU3WDVFeFNNcDBDV2R2RjhhZnRaRkFzMkFOUXcy?=
 =?utf-8?B?enhBOUtEd29SVTlYSVhFaDFJTGprb2V1UFd0TmswUFdBbjQxVmNVY2xYZFBt?=
 =?utf-8?B?UXhNOFM0SWdLWTZwbGY4dVNYTEVsRTRXQmhNV2JnVUNwM0ZQWllyWjd3UjAw?=
 =?utf-8?B?N0t2bE15NmdSVWQ2WU9CQkt4clUvZTQwajBMZHI0N1R4bEZDZFZGYm4vL0N6?=
 =?utf-8?B?Mm9obFhORzBONXdTakVaZGVTaERKQ2RNTzR4VXVMeXBCd1RWMS9qUUFNeXYr?=
 =?utf-8?B?eHhNZkxveEhPeGtuRHdYZFg4NldSRFl6bTJPc2ZBM0FReG9RMVlxVUc3cG1U?=
 =?utf-8?B?VlVXOE1kanVEdzhXTTlwSFA5NEY4bk42ZGhwRXlDNjAyV2hNM0hpUU1aN3dh?=
 =?utf-8?B?UERVUDRUQ2RFVlRTcnQrZlg2aDhCZnhlZU5DLzAveFh3aVRHWXBBb3BSbEZO?=
 =?utf-8?Q?dN57DrjjlpxPCTtfjFhoCeh6Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34edbb71-6c36-453c-d22d-08dcac70f678
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 06:13:55.4191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQwkeXeocpy+ZDRVRbPo8Pp9Hmgwwdo6EEeFfAPP04e9b9rQbA0OkqIjiQqmqXlC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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



On 7/24/24 22:54, Tom Rini wrote:
> On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> 
>> From: Simon Glass <sjg@chromium.org>
>>
>> Use this new data structure in the utility function.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> ---
>>   lib/strto.c | 35 +++++++++++++++++++----------------
>>   1 file changed, 19 insertions(+), 16 deletions(-)
> 
> This is rather big growth when we didn't already have realloc:
> 05: lib: Convert str_to_list() to use alist
>     aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
>              xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
>                 u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
>                   function                                   old     new   delta
>                   realloc                                      -    1120   +1120
>                   alist_ensure_ptr                             -     140    +140
>                   alist_expand_to                              -     136    +136
>                   alist_init                                   -     108    +108
>                   alist_uninit_move_ptr                        -      76     +76
>                   alist_add_ptr                                -      72     +72
>                   alist_uninit                                 -      48     +48
>                   str_to_list                                204     232     +28
> 

this is definitely not acceptable. This mini configuration is running out of OCM 
and we are already pretty close to limit.

What's the reason for this change? I can't see any explanation in commit message.

Thanks,
Michal

