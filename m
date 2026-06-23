Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE73BCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D547849BB;
	Tue, 23 Jun 2026 10:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UAJggWR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 110F2849E5; Tue, 23 Jun 2026 10:10:39 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7EDF800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCrI1TzAiMcXrY+Aun1g9dpBPaSXAUGSvXrY0vIKJ0x1RpZrjR3/UCtEKT7qxjo2E7Cf7jf5C1d3I7A/qN1qmAK5TD33F6b+UrSFaaEzv+kG1IbPKXAMLm12V+aWCcDTWgfkYijIBYGPwka5HKCmbRuWa9K8tXVMRJ8R4+jux51rASKxGefvIPnCk6E2pInTMmJ0uCvNQnMkDT+dZNy+YExHEmsfx3n9kEWG5bKpCQUWZK7HfafMLiYR2Vivy6S5FznBFuJG/S195N2hAhnyD3KWThkPKU7mf09VSc/S0DAxCJdTRSAzB31MvCIyvyWwtvFGcUbmD4UwcB3LYRo5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aP7ZvmwEmhURNJECesyl9S9KklPXGAa4FApmEtT658=;
 b=b+EZLZ5He+YC49yX84K3aeQue0PYtzig38ocKRbVvrdAud9RAnuWVyMj4b6uf/UkOv+4MP85PsRAdYkGPy1Y+x763eWD5i9/1HZBAvXsrrOLdcoNPmkX+Tk9/uuhKEBQPs10VZ0z28SMBfK14OkUpAGJ2ZAy1rkM9CTwsov12lB95X17VJ47MFgzHUn5j5Ij+S1YF0NcRN0DbL0FS9cMz6k+AUGHD5vKWtLNZblNFmmGpfURysJOzh36Q4TdmJK9Anz/n9GZ8+NUOqK7r6EeDYeulqPY/1Fs2SEoKdkZbEYy6KatI5SHuXzE8prmQI/ENe02pdHZIsEq2vGrGwaYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aP7ZvmwEmhURNJECesyl9S9KklPXGAa4FApmEtT658=;
 b=UAJggWR4nexv8z0j4FBsWZ56qwHBKyuaLWYmfbM1mv+e73zkbF+jK1a2GuiB6bn8jUwWwmr0tMuPVLVaWUX2gGsfPJZ2LTDw1bvkFZfhzqLdxkUfHJb2g9PaFhyMXaaqvrzMtiyOlOiPVIYxdGEnaqt3nLEwHGS7x22vGy3JbzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:10:32 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:10:32 +0000
Message-ID: <712ff28e-d4fb-4cb0-b1d6-6bfca100aef0@amd.com>
Date: Tue, 23 Jun 2026 10:10:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: amd-versal2: Fix missing .priv_auto in driver
 registration
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, padmarao.begari@amd.com, akshay.belsare@amd.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20260623035411.2088224-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260623035411.2088224-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0052.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 092cdba2-c774-48a6-2c07-08ded0fee51f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jKVLY9exV9RiXoBK+LqKDxJSFDQ4wFph/HgB3sRqN/J9YlbvALhNo7ebJex7DZDL2N5MLJxGUP2NFWwpWGj1HymHDXYlPGcfK9iD1ks1aMpHGNmoD7vAfKv7ykB8PCKdJL+U18Fmg2GAKoEFnPmyXBwDznSo3kjCIe026/X8lD4GgsVBCtGo8Hx1Iyi1t9D0XuQ/b+jkM5ss9p3haQMdviUHO6wnlt3SXUSfME5VPmosZNAiWLYatQN0AGjwm1Xqih9oQLR7gnq6295yoWfPihNnahC0XCfmNEnC/Vfl3upX6Uwf//zXhCO9Q9IcEkJgZveukm7dXOfl9NZv1bQ9dVW25itRTmHD8bTuwTqrNpcA3ack2AFXy3qq4SJwLsu2JPS0xM1VYaG7efXQq7FcDlgP+8Bf2KD8fL8Z5nYWWKrQT0xgA4dDfBxZZvnMNtVi2galbHl0qHAACuUTlwPKqojOQO//YAy8P7gnNXgyXg5GtCEgaYxyRE3yfu9HetJyMSjikp0pHVj9OEMlbK0+CaciMNzZmxEcpewFA9Wq1Cu/PdVjH3cVfn3psybuOkCtPa6P6iO0l9rKBTpzQ/CVW6mJMIU7Nzouz9o5dgZkta9etZI3mJ0VvbUG11gtvhUuqNRXRNPhuJolj+fpPDoZUl1TGSi6FNx4xpfDUvzdo44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGwvVnZPQ1l0RERGalExVU9PZG1TWGRRQWl6bGh1eFVhM3c2Mnh4bUEwUnhG?=
 =?utf-8?B?c2k2a0ttUHpmRGRVc1hpZDZCdnpmNXROSFpqMzNwd0Z5bVFXL2Z3YnQzRWpM?=
 =?utf-8?B?ZTRtaWp5WmIyYit0SGF0RDJtaWsrV1d0MWNYdXNXekgySi95dXZOZDVnb3JE?=
 =?utf-8?B?N2ZpOHhiTHZIRkNaRWc3V3MzdU83bjZvS3dkYkpxU2E3SER1c3FhbHByZ3RP?=
 =?utf-8?B?d2dmaUl1NGxsQ0xJeWJzYldFYnQxaGkrN1lJZmpUTngrOCtaQUxRcVVwNUNO?=
 =?utf-8?B?UWxmeGVMdUZxMEFISVVoV1lPOHQybThWUkxWNUovZWQ4SXU5dnBISFJMVzZG?=
 =?utf-8?B?cGRpV3dyM3hUditHczNUMmdwSDdLdG0xMlNEekVDUjBJTnBOVG1wU2s5QmdC?=
 =?utf-8?B?cktPUXl3OVMvT3U0Ykh1aHhzSlNXVDJNY2ZZVmZTYUdwUUNTbVdOM1NYL1c2?=
 =?utf-8?B?NFRqNFUxeldXZG56YzlUU2ZBM243S0VkczJMOG1PQmxzaEIyV21FUEJzbDNt?=
 =?utf-8?B?MVVrS2ZmOGZYMkRYbGFnVG9ibHpqaUNzMENjbzhmdkJKeVRkbkNzblR0dnQ2?=
 =?utf-8?B?K0VjUzhWSEkyNkw0SHBTWk5NbWtrYktUWlBBZmh2UnJYeFVXVDN6aFk2cmY2?=
 =?utf-8?B?ZE9yamhBN1NFT1pRdlhSTXZ5S0FxYlQyNkY4aGgwQWd2ZlZXZ2pwbVVaRWdu?=
 =?utf-8?B?RjByU3N6RWpSSERGSi9KNFpVRHZBYTdTS2pISGMwTEMreGtDNUJQVWdjQWZ3?=
 =?utf-8?B?OHZRUTY1eHpmb3p2K3BZbnVJdlVaVFNPOVFpT0hzVjd4R0VrcVU1MTExWHFx?=
 =?utf-8?B?cThpTnBtc2xBVkFVLzNoK2xHbHc3Z3MrdWVDVVRwdWFucCtDVGRVVTN6WW5Y?=
 =?utf-8?B?SnNkcEJYb2pXMTNXdUJWME5nMUkrcTY0Z1locFBTeFg2SlFXeHFBZjY5SlRR?=
 =?utf-8?B?dmJHOVNuM3hhWFMyUzhReDNyckZTRGJnZ3ZESk5JK1NDQ1JlbWJXN2w3L1N4?=
 =?utf-8?B?R1NMaGJpZHRMdGp3dDBqeEx4Q0pQMml1d2FDc1E3ak50MWwwdW9nMUVONTE1?=
 =?utf-8?B?NFcwK0kwclhQQW5OT0ppMWk2ekU0OFVMMXJnUzVuSWxxVDlzemsxdmJrM2ow?=
 =?utf-8?B?QlBUVEY1bzFUbTQ1V3M2ZnNXWjJpdnNWWWoySFM2amsvam1rek5TZlhPamtU?=
 =?utf-8?B?czlSQi9qWHhpY1g3MjlRTlFQZmsvMWViZkdYVWl0L1FWalJ0b0NIbk5KOUtD?=
 =?utf-8?B?SkFEMTNkd0FHVng3UjJiZ1FIUzZJTUhLSXFIS2kxMElzT3N6d0t2RUp5cDZ5?=
 =?utf-8?B?N0lHRGltTGErTzN2ak0rM1Zxa2lHaGloQjB5NG0rc01BZE9nTitzQ2VEczli?=
 =?utf-8?B?MkNFZHhWMFRPVXZuekZIRWNUS0s2TG83TEV4T1Yzek5YYW5zd2g2NEVpYnNk?=
 =?utf-8?B?VldxNW45N0tvdWU2a0tOWW1wdXNTOVNRY0gzQnVYVG5mUnN1UzlHdStmOVhz?=
 =?utf-8?B?c0EwRC9QcVJ3RlZBa2tQNFdsa3A1c3NDL1JWOGZ5azRUQTJEYmxtYThrQkFm?=
 =?utf-8?B?KzltSHNaVDdxbnNhL0lCRHV6bDl5UWhIdjVMRnV2ckRnVUtVYlJ6SU1HcWVn?=
 =?utf-8?B?RFpLQkZPak1RczU3NW92SHRLSUI2TlV2bTBuRWhVejJzandtejBFaE4wdVhE?=
 =?utf-8?B?U2M4TDdVQ3plcmRaRTdTbVlaNG9zdlFBSkFwZGNNQm9Ga2hSemp6MmFLczVL?=
 =?utf-8?B?ajlyRzBDVzZlbG9MRjA4K1QrVUJtbk9xbTVaeU1jcWFJT0FGM2crU3E3Q2p4?=
 =?utf-8?B?SDVGT01PZVZzVzlYd3lFVk9lYW1QNUpkV2Y2MzA1ZDdIMUpQL3oyS1dmMElF?=
 =?utf-8?B?SkxwcHRSUlM1SXdlSkNLTWFDZ05ZeDVCU3RiTzJNazJTTFNFbzZxNDhPOE5S?=
 =?utf-8?B?dDRNaCt0T2dpb2tlWWI1NFU3QmxGMnFLZnFuc05YZjNVRXpXSDRwNXF1T2E1?=
 =?utf-8?B?eXhWQlJObmZCRlFKRDk4bEVRL0trbDgvUE5PU2s2UWxFTzAvelk1QzdIVExt?=
 =?utf-8?B?WUtETWxZSkl2TEVEUGVPY256Ykw4ektrYjAwVHVhY0c2SjMxVU1WTnFTWVZC?=
 =?utf-8?B?N2dZem1tNkJ0UjI1U09rY3plZ0oxVnk3QU9yZ3BvMFlnTVcvNDdnSENET09j?=
 =?utf-8?B?ZUpmbzZDMUFKanhmZk1qanVRQXRDU1lpQlkrcDcvVGp4NDFQNjFGb0NZYXMx?=
 =?utf-8?B?S1pwRTNWQThCTVgrT0tLWTY0RmUzVWQyNUhSaGlEVENlZ3ZQK2pjUGN3NU5X?=
 =?utf-8?B?d3dpV3RTbWg0RWxNZU1YVUhudWxDVG43UlBYLzVvMGZCeUljUi81dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092cdba2-c774-48a6-2c07-08ded0fee51f
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:10:31.9129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmk73VIjF+FygsTuAv8z56GuZn6UZ9nAHFx2dQtuJMFJ4QT0yizg5By9tfO2GQht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833
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



On 6/23/26 05:53, Pranav Tilak wrote:
> Add missing .priv_auto field to the driver. Without it,
> struct ufs_versal2_priv is never properly allocated and dev_get_priv()
> returns NULL, leading to DDR corruption at low DDR addresses.
> 
> Fixes: b5ac5f030720 ("ufs: ufs-amd-versal2: Add support for AMD UFS controller")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   drivers/ufs/ufs-amd-versal2.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index 6c949b2ca76..3369d32d924 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -563,4 +563,5 @@ U_BOOT_DRIVER(ufs_versal2_pltfm) = {
>   	.id		= UCLASS_UFS,
>   	.of_match	= ufs_versal2_ids,
>   	.probe		= ufs_versal2_probe,
> +	.priv_auto	= sizeof(struct ufs_versal2_priv),
>   };

Applied.
M
