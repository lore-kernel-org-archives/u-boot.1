Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53DC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2FE87F3F;
	Tue, 12 Mar 2024 16:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xG8sLW9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D8F87F50; Tue, 12 Mar 2024 16:12:44 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C8C87F16
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0jV6vUJ4ulKm/PmEvniYbLYH0t9S360XBqiLKIupUO60FVH4GXmxFOaRgAaB2udWH3D4xEts272WpbUlt3A9zPI8hK7dBqQQTTlqRA7lO/K8HAfb7TosSEU4Ay7M8sJF40P+s3vEhhPxD+QsfShdpH++A9jgtvZUVFD5fAc9rI7C0Adva3xSI1oE0Q1xykp4Be48r/Wkudlyy1kIlxtVmsoyPbJJZTc6ryHrZdrMT/xCDTlXihQPT2u4yFVJMMds4NiAAFsuGJBrU2WZkKCID8JMRDsx8NXay8pzef/UNygpV4ixGb3Ej/Xn7QkbgTSKf8edltYc3dyfUCR8kuOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfaCZhJiL0w132aX0ivShDYcUlxdPmf/h5hwdf/803Q=;
 b=VKyGWXGKQ+ocu3DEivYGnCK7I0vUk7ElFeU5235WMufx+2wjEVAX/LGh69ciB4hjRn9EoCCBJ6IFDERSW6HydIPTnEpet+jNtOwapMTjloe6V5gNpU0/asrHb+d6pm2cuME+3LY2O4cBhvqB2budoULVkHGgljf7CezUJvIQHc1toLH/7bEqRaJrjj3/lH5Jn5hDDCvQZyc0RCsV4JHwP7eXgffc+Sct1du2RICWGTqtZe5VYiEgv4rt82TZs9NTHQLLJSlhf3dh6llEazHcyt/NmC7Mcyf28R59yAAFG2YlLH2XcYKaqg8mojZWkeE+QrMQGhOvcbnIlT4KgRED8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfaCZhJiL0w132aX0ivShDYcUlxdPmf/h5hwdf/803Q=;
 b=xG8sLW9UpedSqF63WkEXef7lh0ayIpuobjOuRLaRtfv0+EA1AMivjll4kZgl8kjSao9s0Qt+W8U1gmtgFjhCgxM+IvCW2T9DBzSZicQ0CXQl79AzkahF4CasOMJv2pbrNI/bN8b9xSg/qjV7pCe9l6IjwfK+/h7FfPUFfn0V1JI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:12:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:12:38 +0000
Message-ID: <76ba6205-5782-483e-9819-0a638870eca7@amd.com>
Date: Tue, 12 Mar 2024 16:12:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix gpio-key DT description
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <a67884f4fad98b94198123eef45ffdad511b0dc6.1709887234.git.michal.simek@amd.com>
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
In-Reply-To: <a67884f4fad98b94198123eef45ffdad511b0dc6.1709887234.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdc1307-3933-4f4c-4530-08dc42a6daec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cf8trYXE7UsxwlHwi6J9aH8y9Mhs6GQLLmVoGSQxXP5tqHyZTv2G+TjYYKh/RwkajgXWgS8YxqcHR8LckJFn+iZJqWkSkupX9QaZ4xROMVkmji733lQExtbwj0L9sJcu6SRyY0Zbl4MaOfTULotyib6gaIlBtVs/fGxj2zfI86q76nFWnH3uswfL9ElmyUhRp5A+ZdvSmn1UShD82UpgO28HIJDkHxkqV6Pw7+B7kTofHx1Ov+jAjQ+ACGlkyc1plCwOSm7D4B/zARTh1parCH64SKRu459JN8RYV1sKcEKnAtGfYhATxnS0jwqWrk6DTFKvBk+VzEDJ0FGKBI0iXAWkjLo4WXx3pbEQeZOAlp6IkcvEbjcBhn0ilaejctpHtWdiiyQy8DAeO1dgpuPz0Xc+NaW4MshluJbmynTFbCkYwxgTWSEZQmSgvx/bMR75cD8W5mtQInDcGnHsR0ZVuzoFRljEGiT2EqQkzINNwS2b5X1NefUrTSnirdDH/3/jKKWFmZu+xK+H9kYmert3Xcg1HwIXt0y+4Eo6Hy+UUXpguh9KPV3PmDyiQpqwcxwJaxWM2M90L9KxEq01dWCtHQAuo7XMloFDx/93QXqMAr1Q+od/Ti9XWWrKH5c5yN9Su1mYANMks217ZYZIryAi0dedOUxcVYGWp2jH5o8cTm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlUMEFrV0Z6TUUvemRUbGdVb0t3bW1neVNZcy9YNFNBZ29lNXR3L2NNWWs2?=
 =?utf-8?B?WnlkN0JjdUNJV1AveWtBSlNHZVdhUmFoR3YwWml0Z255aUhqV0R5R3E1eUR2?=
 =?utf-8?B?alNFWVZqN1poYUZuemNnOVJmc3VSSElNUHZ0WXMzbmFkVFFqZ3ErdVR1ZC83?=
 =?utf-8?B?cC81aEdvNSsrWFhuQ25RMGliYmdxclhNOWs3NzVFcy9BVXBKdExBRWhDMmdn?=
 =?utf-8?B?NWFnU00yWDJkdUszUjNuWjBWZnVFYzF6MUo1Q1ViUldCTnFCOVdPQWJtM3BY?=
 =?utf-8?B?aVIraGdmN1VkdUhtalBuVG0vSTYrem5wdWJ5U1dmTDFZZ0ZZbFU5SWlFaFQz?=
 =?utf-8?B?TjFsRFZ3YWlpbXhPY0pMa2hvOXpUWFFYVlY4ZXgyZm9BbjlJeXR3SjlqYzB2?=
 =?utf-8?B?MG1URGFsQnRWSVIxOXQ3Qm5Va0t6b3Bmc09mQzlseFZsL3QzamF1elNNdWRY?=
 =?utf-8?B?V1V5MWVjWTVnNTRHSnZPK05ZdksyS243YW9RN05pRUJjL3NsVTVReE9GOS9a?=
 =?utf-8?B?bzNxaFpvL0xsTFlHdXROZjBDcitPOHhiZVJLSXZxWUh3QzhlY0NhZUVidnN2?=
 =?utf-8?B?MFVISDQ3VDJ6bGVraWpPSUtUNHIwc1F6Q2tTT0ZYVHo4ejBSZXhQU2lHNlZ5?=
 =?utf-8?B?bWZBek8xL1dIM3RMM1lpQWxpb2wrV0I5WEdHaGRDTVNZUlE2OVlYTXRyd1Fj?=
 =?utf-8?B?Y05hVVJnV0MwRjhCM2Rzb2w1UE5HQTJnTjJCNWNoWTc0YXNxZ1RnaUFxSy9p?=
 =?utf-8?B?dzNUbWlvRStWWWVUdU9wOVBPZE90NTh2ek8wcjJZUnJCMEdoRnFQUUhNWnRn?=
 =?utf-8?B?MWZsT3FJVk5VZ1E5VnBPMTM4cEQ4Zy9QK0NNaWN6NkFjOW52ejNGR09WVkhu?=
 =?utf-8?B?ZE9vZ1RkTjdSRlY2Z1BGYXdyajh1cDRWRFhjVEZRWVFVSTBlOHdFaFkxdkFP?=
 =?utf-8?B?TVdBTEhlVEFyLzZQVVUrYjFTbDNQdjVvRlVVR2pSS3d5TzFRR0plMk1jME9F?=
 =?utf-8?B?elBOcDdYMHdrYTJSKzBhVytvVXAwclFlRXlYcDY1YUdXdDdrdkpPRlhFNThi?=
 =?utf-8?B?SDR1cURJYnVPZVZiMEhuRGl1UW5IRUVwSEpvYzUyTk80VmVOdmsyRXZydSsx?=
 =?utf-8?B?R1lXVFpJYTNvTXVwRHZCS2ZkcUt1TnRvQjdlZFZUZ3JrZXp5bFpqbnMzbHF6?=
 =?utf-8?B?enRvWnNkU3Y0M2JldEJOVkEyNU1FUDRDQU5oZWNQWlBSUlVvNDdHYUpBMXNJ?=
 =?utf-8?B?ZnVDNCtPRFBLUkl5WnBLQ0hKRU5xT3VtRDhwVGcrcVhGZUN5aGNoeWpoZ1dy?=
 =?utf-8?B?QzYrM2tld1J3VHh6S3FudHo2U2ttSTB2UGExdjFZVUhEMWRjbEhmbFVPTHFt?=
 =?utf-8?B?ck5KRm53dW1qMkhrbnVmZm9qS3dxeHpDcnVJUlIxOHVUTSsxNFlleWRWeHNx?=
 =?utf-8?B?V2JxRTgwNmRPL3NqbzMycElGRHF4VjN1anBVMXpzMEdwSHNCbW50eUVDNTUw?=
 =?utf-8?B?TmRFQVphTzVMUjBLcmU0TGxhMTZjbklYTmhDTUFET0RnajEzb3N2SG11Qzlj?=
 =?utf-8?B?bzFFQ1NDTHEwZTF2TU9oenJzUmZ4Yi9hMUxkT3NuQ0xQY2hUTzFnK0g1dFBR?=
 =?utf-8?B?Z2U5RExnRU5FM2VRR3BMZHIvTTM4ZVA1b1VjNVplSnl5RUx1L1M1cEZuMjRV?=
 =?utf-8?B?Q1RQbzF2TjhyR3N6UzNjZElZMFY0ODJtVGFrSlN5aHNsUHdCYkE1dDd5OHk4?=
 =?utf-8?B?RmY5SHMyWmpucEFoTWYzNXBzRm5Zc0RsNkNOc280ckcrUVY3bjJPanNndFdu?=
 =?utf-8?B?QzFSQVcvMG8wakU0S0kyZWJXZFZwQ2JmNHQzYVhpUTM0UHRDSlJZcmxKeXFS?=
 =?utf-8?B?Qml6eWNBRlgzaUFkZE04SVNPRmlxRDdMblA4d3RINUFvTlpwTkpXNDN0djdM?=
 =?utf-8?B?eUsxWVVhOFpyZndBR2FyeEo1NWV3ZWJOaEJMV3IzeFFtWFlFR2NUQ3VGbXov?=
 =?utf-8?B?dnM4dEZKSXh4b1BVV2laRGFnWmYrR2lOaTExMVdPcm1wSDVSdE1tK0RnK1B1?=
 =?utf-8?B?SDZ0Tk9QcVFCWE5mY0R1OGRuZ1JKZm1FeW8wSC9oM3JNQzFkNStwVC9oSVIy?=
 =?utf-8?Q?Gub6D1D3Fqlo6jWUonMjTHU/q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdc1307-3933-4f4c-4530-08dc42a6daec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:12:38.7334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iV5jrcrEqy08bgfKGDGJjo/Xm4J0eMp58LHQrWh5I3lnR9fuhQka41kOFkLA2Dr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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



On 3/8/24 09:40, Michal Simek wrote:
> All gpio-key descriptionos with dt-schema.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sc-revB.dts            | 2 +-
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 2 +-
>   arch/arm/dts/zynqmp-vpk120-revA.dts        | 2 +-
>   arch/arm/dts/zynqmp-zcu208-revA.dts        | 2 +-
>   arch/arm/dts/zynqmp-zcu216-revA.dts        | 2 +-
>   arch/arm/dts/zynqmp-zcu670-revA.dts        | 2 +-
>   arch/arm/dts/zynqmp-zcu670-revB.dts        | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
> index 8517bdad6f47..de2d7842ae28 100644
> --- a/arch/arm/dts/zynqmp-sc-revB.dts
> +++ b/arch/arm/dts/zynqmp-sc-revB.dts
> @@ -49,7 +49,7 @@
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;
> -		fwuen {
> +		key-fwuen {
>   			label = "sw16";
>   			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
>   			linux,code = <BTN_MISC>;
> diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> index 2a3bbe170472..b626d1aacf58 100644
> --- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> @@ -47,7 +47,7 @@
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;
> -		j383 {
> +		key-j383 {
>   			label = "j383";
>   			gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
>   			linux,code = <BTN_MISC>;
> diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
> index e0e4f1b13ada..e0632883e4ec 100644
> --- a/arch/arm/dts/zynqmp-vpk120-revA.dts
> +++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
> @@ -47,7 +47,7 @@
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;
> -		sw16 {
> +		button-16 {
>   			label = "sw16";
>   			gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
>   			linux,code = <BTN_MISC>;
> diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
> index b4e24745a9a6..a113e475082f 100644
> --- a/arch/arm/dts/zynqmp-zcu208-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
> @@ -46,7 +46,7 @@
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;
> -		sw19 {
> +		switch-19 {
>   			label = "sw19";
>   			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>   			linux,code = <KEY_DOWN>;
> diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
> index 6f593e80841f..4d7d5d2e5eff 100644
> --- a/arch/arm/dts/zynqmp-zcu216-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
> @@ -46,7 +46,7 @@
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;
> -		sw19 {
> +		switch-19 {
>   			label = "sw19";
>   			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>   			linux,code = <KEY_DOWN>;
> diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
> index 7f70904f44e7..def3b53cef7f 100644
> --- a/arch/arm/dts/zynqmp-zcu670-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
> @@ -49,7 +49,7 @@
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;
> -		sw1 {
> +		switch-1 {
>   			label = "sw1";
>   			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>   			linux,code = <BTN_MISC>;
> diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
> index 0adb2062aef1..41f9a23d06ad 100644
> --- a/arch/arm/dts/zynqmp-zcu670-revB.dts
> +++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
> @@ -49,7 +49,7 @@
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;
> -		sw1 {
> +		switch-1 {
>   			label = "sw1";
>   			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>   			linux,code = <BTN_MISC>;

Applied.
M
