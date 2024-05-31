Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691D4C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908B1874D4;
	Fri, 31 May 2024 08:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLKc/1/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDDE88765; Fri, 31 May 2024 08:47:03 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8FAC831A1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbFoKPj/Wg0t7I/qSLq9WvwcLVl2qycEO9L7MEPmTxcEeDKJevK7UCx1HU7gfbDR9J+LDU25zFe6MnbHHYWgHhbRpLgM1LJO2gIfwU3pIRMIZ274lW3ZcGvQoOdRX9HR6ZjQYvF4OlHikOjS/tY/jlO+F3NNvKz0fOAep6GiyEtlxIxR6rqKWvBV2ld61CXPgEh60W5idRxCHLPb8nM3Zsb7hC3rEx3VErsH6HUVrvRDSjbFlm2k3fXOWTanZ03goMcuOd1V6SzNd+6c11+XBw8vLgM69d2hwvxnWQUGZKHrnTryu7uMghJPBo+MU3JBEWdWyUDurTphAzJvxeGrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+4CwKe6Cyv72SRabfIj6NvbhdDgnWyEWcuUKFF2wGE=;
 b=RP4WenoidMrz4PiXRLEpTBt7EGM165P8bZMoZYrcXV0tq5FB0GHZWY2mXf/I7JOLM85pUGEsxg4ZrG6SDJjihSO2XL6hje5/4i3Ai2+zVA6vCQNBwi8q02Utm/FxOTGOtW+jL+4DmWEdTMMaDZsNKDYcxHk9oXYRGWfG5Mo9R6YXW7tSc4WHVissXQ6ow8KRp/5r6SvuFzrNCgjopxOLSEw0FRxHU1sP0GOR69qn6W5BK4fmQfDWdkymqK3gtHnu+/OBicweg80/RVii16Bf2ZLxCYZuNs3PIq/AKB6uF816O7VpoWzIpHMWIXztyeVxbm6jonTFpelTrk/CcwKw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+4CwKe6Cyv72SRabfIj6NvbhdDgnWyEWcuUKFF2wGE=;
 b=xLKc/1/fB/33kmtg0SlYZr2Akx7zpbI+edtEhOkpB1/b4Yfjd7otrF2Wl1UmoKTCTj0dpRB7x0lInn0gU11dwDMzdv8+RYA6KxvyvbdFjwVfV587zCRblEbac9O5MurvtLgXuaPiiO/ZzyUTQaBv13tVFSMB0qRwr5pUAtIUlJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 31 May
 2024 06:46:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Fri, 31 May 2024
 06:46:51 +0000
Message-ID: <88754743-665a-4aa3-95cf-f4a497edf576@amd.com>
Date: Fri, 31 May 2024 08:46:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/25] md5: Remove md5 non-watchdog API
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-6-raymond.mao@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240528140955.1960172-6-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5339f0-4080-4374-6a4b-08dc813d73db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0xxc01LbS9ta1k4MjYwdTN2WVFhNWdWckNoNDZJSGp1dWNYTmFUZHJlWWg4?=
 =?utf-8?B?c1Z6dTl5VU90UVJSaG9kZ1RHV2Y5RjlONWtxNlZEMWt2N2F6eHZLMHBsQ0Z2?=
 =?utf-8?B?TWhZZThsRXpsSzNkRE1nUXhwZktoeWVxdXY0VS8yQ0R4ZmNZZ2FJV0UyV0Zt?=
 =?utf-8?B?ZEJENEo0L091bU10VXloV0JUdjlRYnFNdzA3Nmx4K0ZGYllCWmthbGFjLzhD?=
 =?utf-8?B?b3ZEZEd0VDRVNWl6TlptaEtxTEVDckZlYVlBREVnb0ZkVlAyMmJCSEFYc3BP?=
 =?utf-8?B?TjlxeFFiOG1xZEdlK1Z0eEpYNEJvanBRL0MwTmhPZ1UxdmJnenVnd05hYno1?=
 =?utf-8?B?M0s0elRjS3JVS2d1Z3ZnTUxFVmVFQU5mblU3ZWdiZm1WaTVMYkFVQkJPd0N6?=
 =?utf-8?B?czJ3TE1KSW15WHdLbkE3aWYrMnNmYzR4RjhsWDZyUkNHTkhodUhJZmk1MTNS?=
 =?utf-8?B?SEEwUlJjbENrQkgvUjVOVWoxNEZDNFI1QnIyeTJ6WUMxU2VwckpSRytLMkc2?=
 =?utf-8?B?WlpBdEhSTGNFdkthT21VZU9KczZDeE1hQUZxYitEQUJWWGZrNGVXMHJ5VGVJ?=
 =?utf-8?B?VWdDU0w1M3gyT2o0ajZVMXlPMXM5RWZuaEVYS3UyTGFJNEwwbC9DdkZNTUNp?=
 =?utf-8?B?bFZuaytoWnl5QjRaWkY3MEgwOG5tLzdlTFF0VFdjMGNMZC9OMVJ4YXg2dUtx?=
 =?utf-8?B?N0tTSDhFUU93Q3F3M1pWMUY0MDYrUnp1Y3R5emNuZmJEWDUxWU9Xd29sTjE4?=
 =?utf-8?B?NG9NQjMzOXl2eU40VmZNSS9Fd1F5SXZpMzUxZzk0ZElqdmI5U0hTMm9YMmx2?=
 =?utf-8?B?eWN3aVlXeFRLeWlTVVRUZzEvTDVYSWJVSGVVNkJDYU81eGtaRU1oMUJ0UHA3?=
 =?utf-8?B?aHlDckkzSzB3M0RseE4ycE5nbmpjWWhLNG9VSW1LMVhFa2ZkSGxORWNoL3ZJ?=
 =?utf-8?B?Q1ZFTzdneTE2S1FkL2l3RXRNM3l0THU5YXBxVE0xYi90ZzhPRk5KWVU2NHlN?=
 =?utf-8?B?RnA2R29GODdPdnR2Q3ZadG9VS0Z0b0kxR3hPTDM4NGNkQWE3V0NoZHFxTXFS?=
 =?utf-8?B?N0xIMXJWVE0wamVYakVFczF5UUtkOWl3dVBXbEQ1NFR6OVVZV3BYTGtGTFl6?=
 =?utf-8?B?YXE0U1gvQ014SFpZYVpmaDF4ZDdqZ3NFdlpLWHlwWmFncGE1YlFHeEtsc0Zv?=
 =?utf-8?B?Vkd6cnFmVVNYTFd6VVkwVENMWit4Wm9sVGdVVXdUZXZoVDVXYnd6dXk5R1lv?=
 =?utf-8?B?dHdVK3hRVWxxTndVMWVMUjRFQ0xBZDdWVnlFbXhxVG5xa3ZvUXFZUDBzMWls?=
 =?utf-8?B?ejdjbG8va04yc3ZueWRDUW54bWlNWnZuRElWNWt4RVpJUEx5VjBqVTVHSVZn?=
 =?utf-8?B?aEVXQ2tKSGQ3OGtJdE81dXdNazVUdkt2VWkrNzU1QnRqUm9ScTNkaVgzR293?=
 =?utf-8?B?MWx6NUpQdHZTOW9PSS9xcDQ5YjVGT3FiN1BoUCt0Y2dlMjdMVjd5VTNsTEk4?=
 =?utf-8?B?d0tZVFFta202OUI5eVovSFlrREdKWDJPUjdCSXlBVEJrdkFnUEYvZE50MUVt?=
 =?utf-8?B?OUZQK1Mxb1dLMFZOZ01YLzRFRWt5T3ZSQktXNDFKdy84UlFxNTEzRFZDcXZY?=
 =?utf-8?B?cHFFSkg1QS9QTDNKMFBMVzBZb2dMaDQ4TWNlUG9qN3YzY1I5R3NpMDgxZzhB?=
 =?utf-8?B?Y2FVb1JENUhrUFNWbHlmMmdIdGhWeHJhallPSzlWY0VxMHhYWTJTZlRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(7416005)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE4zbkZLSmw2YUxvMHE4bXNUMmxiY3luZ1E0WmZiTmxsUFVmTmh0eGdiZjJw?=
 =?utf-8?B?VFVMTUVER1VadTlReGZjcHZxbUxEQzZHZ2xMVXJIMmFxY2tZNlJRSEFQc2VY?=
 =?utf-8?B?L1V0djZXUWdPV3RwYmNUenk3dmhWZ2t6bGpieDd5VFNIaWU1YXZLVkIrOHRq?=
 =?utf-8?B?K0ZvMFlzend6dTNPUVUyRGcwOCtnS21icUErcWlDVm44a0VvT1NYRGZtTy94?=
 =?utf-8?B?OUFSNDQwZmlzUERHYXlMd09qanZmKzZNL1MrLys0T3FIeWloTlNUa2tlSUM3?=
 =?utf-8?B?c0F6ejAwdUp5OTU5VTVvTEhBbWg3b0NPMC9uMUs2MWgySXg3aUNJekJoK0N5?=
 =?utf-8?B?cVNNQ3FrOVhMU0N1S0dkQ1NYSm13ZnN1aDRSWGlxMW1WNE1RMC9OUXViVFVt?=
 =?utf-8?B?TW9jSjJ6eWNjZEZ3azNXODZkRTlDa0IwL0w1SXovQWl2REpqd0tPM05WM1oz?=
 =?utf-8?B?cUdhZWE5SFpXMWN6UUtLS3d2aWx5ajExL1V0Mi84SnpDRE90ZS92Ri8zeHlC?=
 =?utf-8?B?ZElEelE2eEk1eDZjU2xtOVE0NkFVQ01mZmtBZ2RScFpRS281NytiUnJSWUdH?=
 =?utf-8?B?eXhLQzJBaDR6NUdUcmQ4eTRiSWEvbkJ0Q2h1b25MZHpZYzEvbU9rMlFBaWh4?=
 =?utf-8?B?OThCN1BMRGU2T1RIcDhlQTNZVEFWV1haSkQ5K2luSW0xQ25MR1lVZENqbVNr?=
 =?utf-8?B?WkUveWt2cFNmcTFRLy9Uc3l2UGErd0VTYzlyRjNPSVFNMGwvdTA5QWZjRGJx?=
 =?utf-8?B?MVlPWG56REVRb3VQcUdhVW9qbGsxVDdoczRISHhRR25rdzV4S3JUWWVKbnJ5?=
 =?utf-8?B?c1dYSXMwMlpVaWFWS01rL0M5SUVxaE5CLytzQ1BMWUZNWlRKWEhpOVVubVRi?=
 =?utf-8?B?QzNUdjB6cWNXSXN6cmY5cDNQbmFtS2VsK3FrT0wyZTcxWWNHcHVwbkNmQUVM?=
 =?utf-8?B?Z0d4Y2Q3VS9UbENHWlkwZmxxd0tianh5anpqczhiV1Q2MVZoU0VqMy9Dbkxk?=
 =?utf-8?B?bTRicmh2V1pCNktTczFsbGRPT2lqelhCcUliM2IrN0VMWmprYU1ac2xDYzFS?=
 =?utf-8?B?RTVDeGxLZGY3eGMrSEEwL0hQUWlrQkhVb3BpTlJtN1pxUzhzenppdkFTZTVX?=
 =?utf-8?B?MW4vUlk2enhRa3A0eVJCTVZNNk9pb1puMk1NOUE4WGtySC9NbDM4NUVIZWFr?=
 =?utf-8?B?b0ViTFp2UWpFL1QzcnhXQVkvQWxLUGpkWll5YVkxOG4rYmkxWjgzV3dva01p?=
 =?utf-8?B?UWJ1MjZpV1I3RlcwZU4xT3g0NlVVNjVoVk9IbjZ0VklIZFk3a2h0TkIzNzR4?=
 =?utf-8?B?emdOM1FGWjRVR2VYUDU1RVowTlpUa1pKRi9zT1NNVXFYM3BpMVA2SjA0c0Jl?=
 =?utf-8?B?aWhsdFZnbC83a3dLbXliMUFjUUNlRFY5Uml6M214bUNISzJZaEROdktzNlg3?=
 =?utf-8?B?NHZsSGhkK1k3THlsaWQvMkdlUTZEUzBuRGQ1SnZvRS9yNzMwVXJpRnRiMzZW?=
 =?utf-8?B?eFI5ZmRXVmFNMlM3Mis4N1ZnN3laa0pMeUF0b2ZGUXl5YnpEc0x4WVFRdkU4?=
 =?utf-8?B?WEh5WjlRTnEwRVA4WnhjZDlxazc0YXo3bUdRejlsNWs4RktINVUvaUljQ3hx?=
 =?utf-8?B?M2xlUzZqalowTGRtcndTOFo5TzRYbmxLZ2JlTVlGaFpPc1ZVeDdoRDZkazNB?=
 =?utf-8?B?eHltSGZQbzh1TDRNd3FqNzZkTG5MakFzbUY1SWMxV1lTK2lDMDFoWWprNlIx?=
 =?utf-8?B?SUFpVno2Sm9qOVdvZUFFL1RteHk2SEZ3dFhVeW9NRFhiYy9tVVZFVjRXdHlD?=
 =?utf-8?B?VmF0UnhENTFHY1Fkb0g5REZTNDQ1RTBzcndrTFZGRFljaU5pd2JUTXdKblNB?=
 =?utf-8?B?emdlR1BnSWVLbFpaekI2Y1ZDT3hYTm1ZNXRNc1ZBWHhrbjBUZVJPbzBMNjRT?=
 =?utf-8?B?L3EzcXNqdTNac1ZmczRucE16QVA1VkhmclNFQXNpMDBJaTJTZ3VwYVlTQUFL?=
 =?utf-8?B?NmxYbU9aZnpOUktSaXVNc3c0T0J5RW0vNEpWMHdwS3gzc2QzenNnYVRxNWFi?=
 =?utf-8?B?ajJrQVNnM08xRmlmZG1XZmlwdVBqV2tGR3F0ajUweU1ZTmtpWk9YeDRhcHNz?=
 =?utf-8?Q?LZ5JEyYse258/xEvu/qWjjXfa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5339f0-4080-4374-6a4b-08dc813d73db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:46:51.8788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63/3o5HTFNUjQ4bvmv8WFxD+qWXsajdepxzXbnjRjmnV9TUD5N/H3p5ASJV0qTTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
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



On 5/28/24 16:09, Raymond Mao wrote:
> We don't need an API specially for non-watchdog since md5_wd supports
> it by enabling CONFIG_HW_WATCHDOG or CONFIG_WATCHDOG.
> Set 0x10000 as default chunk size for MD5.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v3
> - Initial patch.
> 
>   board/friendlyarm/nanopi2/board.c |  3 ++-
>   board/intel/edison/edison.c       |  3 ++-
>   board/xilinx/zynq/bootimg.c       |  2 +-
>   include/u-boot/md5.h              |  7 +------
>   lib/md5.c                         | 15 ---------------
>   5 files changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
> index 393c5a447d6..f203499f544 100644
> --- a/board/friendlyarm/nanopi2/board.c
> +++ b/board/friendlyarm/nanopi2/board.c
> @@ -264,7 +264,8 @@ static void make_ether_addr(u8 *addr)
>   	hash[6] = readl(PHY_BASEADDR_ECID + 0x08);
>   	hash[7] = readl(PHY_BASEADDR_ECID + 0x0c);
>   
> -	md5((unsigned char *)&hash[4], 64, (unsigned char *)hash);
> +	md5_wd((unsigned char *)&hash[4], 64, (unsigned char *)hash,
> +	       MD5_DEF_CHUNK_SZ);
>   
>   	hash[0] ^= hash[2];
>   	hash[1] ^= hash[3];
> diff --git a/board/intel/edison/edison.c b/board/intel/edison/edison.c
> index 11e7f74e47c..1583d11c74d 100644
> --- a/board/intel/edison/edison.c
> +++ b/board/intel/edison/edison.c
> @@ -33,7 +33,8 @@ static void assign_serial(void)
>   	if (!mmc)
>   		return;
>   
> -	md5((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn);
> +	md5_wd((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn,
> +	       MD5_DEF_CHUNK_SZ);
>   
>   	snprintf(usb0addr, sizeof(usb0addr), "02:00:86:%02x:%02x:%02x",
>   		 ssn[13], ssn[14], ssn[15]);
> diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
> index 2f55078dd76..4b2245c0618 100644
> --- a/board/xilinx/zynq/bootimg.c
> +++ b/board/xilinx/zynq/bootimg.c
> @@ -136,7 +136,7 @@ int zynq_validate_partition(u32 start_addr, u32 len, u32 chksum_off)
>   
>   	memcpy(&checksum[0], (u32 *)chksum_off, MD5_CHECKSUM_SIZE);
>   
> -	md5_wd((u8 *)start_addr, len, &calchecksum[0], 0x10000);
> +	md5_wd((u8 *)start_addr, len, &calchecksum[0], MD5_DEF_CHUNK_SZ);
>   
>   	if (!memcmp(checksum, calchecksum, MD5_CHECKSUM_SIZE))
>   		return 0;

Reviewed-by: Michal Simek <michal.simek@amd.com> # zynq

M

