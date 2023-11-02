Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 09:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D68B786CEC;
	Thu,  2 Nov 2023 10:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RFwYI1bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D541E8771C; Thu,  2 Nov 2023 10:05:50 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6801082BC1
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 10:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtvgEPi2qqI4FZIzOi9zVOPpoq38s3LWEnJjjmAZwPWIfwxDP1bxIB4U51kj/U/wdmCBxU2JQeP9lA6b59CD3sQLrD3q8UUqsAX3Mjuz8LlRteJlzA7n96bvHZUWoqyRgVXtXC7iDxH2VsH7VYrhoiX2WfUiw19AjZWYb2dPGKUsF3Zc0OxgyOTQknwKCpRjCbpAaWxDzQzqaQ49CNogQfLMFQpK16UHxkGYFWzJ1T36xoUZI6GHwGlp8F9MVLy+fxNh8PuvN6bYH2o9fEb0EnILHgR9s6x0gr0W5Gers15fKVX1hRvFCv/WDSfWH/dDVhe3dnW3+2Qc6oS1CIAzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmuGjeDbgngOOjAXibS5NSQR/5T8X8vXV9snluRT6lc=;
 b=V7OirFYlAht1M7sayJ4s85FdVA8dfm6q1fsLO3lkX01Qef+F0MInEqqmQS1ySOh9zbVlxghbMUxFBwGXoq+P4GBLzjes40McSQVYuz7fFjCM+34qgOBNPq0yDnkF+z8m7jKJv8Nui3GDPazW2+ytjQi0rcKsd5KQuNPY8pRlYN8D+Vst5+cmVZTveeJCj29TmN28kfP7yMMMwJCERVylkAv28JhnFR9iitfK2Wou8yUKipybyCtw159YgEGW1SO7gkdlLHN0GHo2EP53OnXEVm74f3FRksRPjxPnfczYK0snDo7sOlvBhn0kv6zKPAv9uAfb28wS2bHte8diIoEV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmuGjeDbgngOOjAXibS5NSQR/5T8X8vXV9snluRT6lc=;
 b=RFwYI1bkOkVa0lglcBeE5L0Qnn03fl5uIWNluUSjuefKeeXfC9Qp61zVRyGIsAAAFjZH8K1vdIQmJdw3Qxi5WMM5eNKlxefQoycxJs9DnNWXeIBcHDzJyMh/szvgl7SID2WK1y7ElvzGRU4kcpFloXeqAKcadmtpk7w5Eq5/Bcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:05:42 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff%6]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 09:05:42 +0000
Message-ID: <17a0048c-bdaa-4c82-8b51-b193bf14abf5@amd.com>
Date: Thu, 2 Nov 2023 10:05:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: pcie_xilinx: Fix "reg" not found error
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Alexander Dahl <ada@thorsis.com>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
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
In-Reply-To: <20231102082303.354944-1-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: a329ba7c-4a00-49e0-9aa0-08dbdb82e3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e55OaaautOlHwip3TY7qlEE8b00V6AzRGMUD1ROOSpTzdLouL4QMfWECy3wM9ox8Za03q9fhhbYvfdQTHfdHpxqqsKDlkMol5SYp5ERFC8jGNe6LaTgSgVnAG/fHZ8NUVZwUDVFLuQIR7s8Wu9ZjPSGWhrF2bAIesuJSyS3adLezO3dLYEifIPNW5swXSOq4+bxDK1i0GdPr86E1+VNGuH23CHvraoaByugfNoqGzFmyA368K0Xz1fd+gFO5RySE2v7QM1x6j1DZGg+FO8XOkZ/y1bsJUbpDZz7fvsSoMERmYLRIuEdJiRBIlHuKliV3qf1x5im67EK+dn5hyjp6buaz4DmxucHqiC8/A3ZRCfRGhyxS4DVWEU5BHqC+si8k/ik0B+rN9Zgy1fHIwmmDjvSq8+TxHBI56ZZwVklvkcaWEisur2XR6gWV8Bz3JhcOlaTs4F0XDQa3A79O3zo6BwHtoXS+VuA7nAH7/7xYs8SPk9AbWgmmCWTkcVLVV8x+asNV/nVTsY2vvDS+bODokLa832PQ5n44wsKrmc5uzdyeudO6GDLEMU94fFp4L+BQK0CPdi71mUBXzjjGsshuPzEYOizI5HeTziKHFpvu04gT1Um4APmE+3cKrQ+L0JRu+U8ertkC8VsLyzE9BZHWmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6512007)(26005)(2616005)(53546011)(38100700002)(31696002)(36756003)(86362001)(2906002)(5660300002)(83380400001)(7416002)(478600001)(6506007)(6666004)(8676002)(4326008)(54906003)(8936002)(44832011)(66556008)(316002)(66946007)(6486002)(110136005)(41300700001)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNQMlVDRUNKZk9qY3lid0FLUjhMWXI3U3dpSWhvak5IWk04SFhLU0tOdWtl?=
 =?utf-8?B?ZWhqVTJRem9adXpmdHRwU25aOGZodEM2bi9mWHBXbHpkakk4ekNPL0ZsWC9F?=
 =?utf-8?B?ZDJoSmZsb3luRXdkdGQxaGtGbWd3OFJ6VHpPNldKUDhyWk5leXVJdTV6YkYw?=
 =?utf-8?B?Q0x4UllkU0dXaURkRC9Bakpmak1kaFNwekRlSnhQa1JYQ013UUEvNm5Rd0xH?=
 =?utf-8?B?ckgzSlZCQ2s4eWdpRXQzazdmMnVKMUxFRmp6SlpsVkFwcHNsb2xrMkdFeDlF?=
 =?utf-8?B?ZzFzaStZSEV0Vjh3a3BadlNrVVVvWmhtR2Z5UUkvZzBUYk9jMk9qRlp1TjhG?=
 =?utf-8?B?cXB4RVZuOGpFME9STHJSLytWNEZxVXJpTjJabXB5cnpvVC9yc2FjOWNCRkM0?=
 =?utf-8?B?NzdIcERDdEwrb1grZ1RxL3Z0c2VUVS8xNWRjcGpDK1Z3RmVqUjFyamprOVV5?=
 =?utf-8?B?UWlTeCs3SFpVd3kwbWpoSlVoUjI0Nm1jSERTQ2VWMEtab1RvWURMRjQ3MmhG?=
 =?utf-8?B?aDRHQUNPT01UTmpYWms2TjEyUWYrUHJpUjRBblNhNEpOUDlQTFlCSlJvcjBj?=
 =?utf-8?B?QW5ncHUzaGUxUHh5RmFvN1MzOGp5eTFLR0NQVVZwNlFvb0M5ajdFSmZPNHBa?=
 =?utf-8?B?Tmx5L1hCaGVQZ1NnbUh5c05RQ1RIUW1VbEEyWVEwYjZKTDh0YW1YbmE1UHdh?=
 =?utf-8?B?eW5CaUk2QkRXM3NaQWIvM0lvS1RLenVOZkJNRGtVYlRad3RhbDg4aWRVUnBR?=
 =?utf-8?B?ZnpVMGZCZTEvcUgrMVJRWDFLUlgwcmhHSFVSL0FXVk4xRXllQVVUbjdYWjlh?=
 =?utf-8?B?TyswTXFyWHp4SVhnTG5GdEVoMUFOd3ZLeWpEVFFrOWNGdnpoOTNVZExkbzVZ?=
 =?utf-8?B?Z0dPeU90SHpIclJtWUVOd1ZSWFA1ZXQ3MXpwbjVBbXlIM29UZTcyUzJkbmgv?=
 =?utf-8?B?TTY5VXJSY3NHbG1KUlA1Mnp0dG5INkxodUF2Q01YVVVLUzRuMDJkeEJpbkVk?=
 =?utf-8?B?TEthQ1R6akNoWFdEMzNQUGdDSHJZOThmc25JR0RYT1ZOOTBQTlR5cDEvTGMz?=
 =?utf-8?B?aTB2cDQ2Sm5paVVPZ2ZwZjQ1R1o1Qnk5S2UzVU9uMlp1d0xDZnd2ZkRVK2Jv?=
 =?utf-8?B?bEkzNEdmNG9JcmNvVXBrVmJQM3NsaUlsbHlNTCtNYUE0MFFrR2lBRFJVY3pj?=
 =?utf-8?B?QUhKZFBpOEMxWUpVVWtGQnpJaVh1Y3oyZkhHZ0hzdmg1UEFwUHZlME5ydyt4?=
 =?utf-8?B?amFkeVQ0WW9ENFVrNlM3U2lOZ1F0YXNKekFpSDcxV29memRQRlFjczBobU9a?=
 =?utf-8?B?Z3JnK0hlcWVIVjZzT0xYR2VEN1ZWc2JpYnJVblA3NEg4alc2UEFVWGNzQTVw?=
 =?utf-8?B?aDZkYStmTzN5S2QzVldFS1JTQ0U3N2lTZENDbnpzUHZlWDRGMkRFT25CREtW?=
 =?utf-8?B?SEdNTnJoVHBUUGRhQUhPNUtJdGVUdkNWSnpKdnhlZDhYbUdsWTQ2YjROSWEy?=
 =?utf-8?B?RmdHc0c5cXdnRDU0QWxSQncyUm4za3Fpc3dtcC9waTBacnpmKzNyYzcxcS9S?=
 =?utf-8?B?UGM2S3lRNDBhL1NjV1NoUy9BcytNOXN0aDBnWHdMZ0d3Q2xZM21ER29PZFhv?=
 =?utf-8?B?U0hzUFRRbytNM1lpRmZnZzcyaDhxQzZvZTdPWmtibWtzTlRlRkQ5aWxuWGlN?=
 =?utf-8?B?em1ONC9uUTFPcGJ3ZCtwV2U5c0E0bkE5aEFhTm40cEZubHdsYUpIVFZnclRW?=
 =?utf-8?B?OTJVc0c4NUhKWGdrZzhSUS9VTUV3ODRtYmN3RW13ODVMbnlZcGp2anBoS2Vz?=
 =?utf-8?B?T3doRFlXZlI4SWFmZk8vNGg5WGxpNHF0ejd0Vi9Vc3M0YWNnY1kzK1N2NUov?=
 =?utf-8?B?OHZLKzh4MStPSGpSbHVPOXZraWJldFFPbm9LdjVUUno1M1JyTHoyRDlodXlY?=
 =?utf-8?B?SVE1ZWs5NUpxeUt4RjZIQUttZ0lOUU5EYnVVa1V4ckdaR2RhZmtweDN5TzlZ?=
 =?utf-8?B?VjRLWUVMcEJFQWJBYmRkaWQwU0R0cnF1aStpeDBLQ0lqZ24xdmVtSmZidnNq?=
 =?utf-8?B?SWJ6eW1aSVNoeUdEN200M3hUR3Y0bmxZVVkzZEdLQlJ0YzEyS1l3Y010Vkxq?=
 =?utf-8?Q?R+QE+LU0Pa/s1xRvK222d01Dm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a329ba7c-4a00-49e0-9aa0-08dbdb82e3fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:05:42.3023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2VVglEw7+3YDYN4MQ3pBcZz9t+CVx8CN28/YYLSl7j96g3hKvExJhXT+2ZvOwrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
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



On 11/2/23 09:23, Mayuresh Chitale wrote:
> Fix the driver to use the dev_read_addr_size API to fetch the reg
> property from the DT.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   drivers/pci/pcie_xilinx.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
> index 53fd121e90..20b630027f 100644
> --- a/drivers/pci/pcie_xilinx.c
> +++ b/drivers/pci/pcie_xilinx.c
> @@ -140,20 +140,14 @@ static int pcie_xilinx_write_config(struct udevice *bus, pci_dev_t bdf,
>   static int pcie_xilinx_of_to_plat(struct udevice *dev)
>   {
>   	struct xilinx_pcie *pcie = dev_get_priv(dev);
> -	struct fdt_resource reg_res;
> -	DECLARE_GLOBAL_DATA_PTR;
> -	int err;
> -
> -	err = fdt_get_resource(gd->fdt_blob, dev_of_offset(dev), "reg",

I don't have HW to test this but here you are removing reference to GD that's 
why I think you should also remove

#include <asm/global_data.h>




> -			       0, &reg_res);
> -	if (err < 0) {
> -		pr_err("\"reg\" resource not found\n");
> -		return err;
> -	}
> -
> -	pcie->cfg_base = map_physmem(reg_res.start,
> -				     fdt_resource_size(&reg_res),
> -				     MAP_NOCACHE);
> +	fdt_addr_t addr;
> +	fdt_size_t size;
> +
> +	addr = dev_read_addr_size(dev, &size);
> +	if (addr == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	pcie->cfg_base = map_physmem(addr, size, MAP_NOCACHE);

Definitely it is better then what was there before.

But can't use use devm_ioremap() instead?

Thanks,
Michal
