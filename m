Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B12C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 10:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7B7811C1;
	Mon, 10 Mar 2025 11:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="updPzu7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1B7811DF; Mon, 10 Mar 2025 11:56:04 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F0480107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 11:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VartFsWZCI4YkdP/BW0cli17RNnjor+dYq0giI4uATdxHHeblgWWidsZ9OtzZmOeFwMK7E6qwuGPjIiiaEfsgkBnIZthL8Z+9uERJ5piw49Syq6ibnuqawQQF8izyYAaS9bTQVC+ZeW+qmKbwe/hrY4avEOg5TTWtITqtRjkC+hotxkiIydfcO6nNVRRbLZksSNzkDIcWqeYbxgMAwzEVk/9TH79lgvEo22mFVgXa23/oRfdS4QoJLAm0mWzJ+DTDDOKsd/N0yGOdfrycz34QRhTkBFUg3F8YBCWO6YY3d545ezpDfLdEDig3CiURgTA4UZvmxfBi/mMxGTEdiMs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbPfDU5L1gI2GNyyxEGpfCn/7g7ACMjMQ4GD4fL8/QI=;
 b=dznlxW1lL6MVjNtKy+qo/lyMpXKy95DOolTRS67zudqGIYUnFREtgVuS/tlKPIo5N/hiECw1sMbDnmuZu66nBFI65Amjt6PJ1KE/z6egiL4+ZBdoVdUCG+gc6hAkgJiqWbusuUpeBv963PeRFRLDMb51ufADR7/1NDN4bIzHWrMOCth3pcNQfEcF084EEFCEJxpf64Ziz+P1/XSOThAqqRlTLhnvM4otJ8vstBnJESbak8wP7dknlLOOUt8JdNj3/c6HwBRxd2vvxROS7ljVA8PVlfsCSQFTstpuu2LLSDd/HNqoRAOSx2f4s3/qDXwMvvd2FaNx7EpDysvhNcWZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbPfDU5L1gI2GNyyxEGpfCn/7g7ACMjMQ4GD4fL8/QI=;
 b=updPzu7INfQM8nWwTjeG3fb8I+rlHNHlTHh63344MQirk1W4DNPTzuOCcih0N1AhwVLU9uE9VTOsymaXzsTEFQCMuCAUWOB5Xza/zx+oMPgS4nOlPwfXYETo4v7shqN0nDLVkk2nrf8dXO4gzFEhy2kmA/GuQ0RRm4aPHGhw29I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 10:55:57 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:55:53 +0000
Message-ID: <c74f9ee9-ca6f-41bd-8023-275fd24e8247@amd.com>
Date: Mon, 10 Mar 2025 11:55:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_ospi: Add device reset via OSPI controller
From: Michal Simek <michal.simek@amd.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com,
 marex@denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com,
 git@amd.com
References: <20250220141941.1509674-1-venkatesh.abbarapu@amd.com>
 <5afce6e7-db75-4899-96e7-454f95b9583d@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5afce6e7-db75-4899-96e7-454f95b9583d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0056.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::45) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6f818b-7af2-45de-c709-08dd5fc220ac
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzVwVGNTYlBYdCtubk9Ld29wQW5DU3kvbGJwTGtoZU5Ib0EwanZIRHA2OFNV?=
 =?utf-8?B?VDUzODR1NDZrRy9Wb2hudjBPTGVDMi9vbFUrY0FSdDRLODVyT3cxd21ienQ0?=
 =?utf-8?B?SEdoVmdaZzVldWhZUitibWZsakZqdS93U1dXbHBsTHM4dTNmUVhXU011SWxM?=
 =?utf-8?B?enNHQjZ6K2IwVStkU2JmN1JIeUtCeTNlaG9JejZWNWViT3BlSHlNOVJhcmhH?=
 =?utf-8?B?ejdhOEpKWjZ6OTFiYk1RdzRiV25ja3oxRkNmdDVSbXNRVzlCVmJQVWdRSU1a?=
 =?utf-8?B?Rm1uMTNyS2pWSnRlTmRNeDdVb05od0t5RnNaT0Z4WUpCcUQ2czMwVmxobWZp?=
 =?utf-8?B?Z3hSWEV4ZTR6Ri9xekpJMmxzSnRJMFE4ZE5DMjJSLzJvY1o4a1dYbFVYN1Fi?=
 =?utf-8?B?ZmRMZVByYlVVKzZpNHJNZWdBc0RpeFFhSStLM3Q3d0NpaE8vR1BIeGduLzQw?=
 =?utf-8?B?cVJTNTRmQlIyeHozeU5ZT0k3QVpFVkdmYnFFaHhzMHlxOE44blRLVkhFMGlr?=
 =?utf-8?B?Mk11WE14U3JWcnMvY0d4MkpnVGVVdUFmQit2Y1dyMWZ1c2VvYWpoUTBOS01U?=
 =?utf-8?B?OEl5ZXhRSlhVNDVJZFlXOWVOcG5nUVdvZHE5VVR0NWxTdUtyODRtOVlFaTN5?=
 =?utf-8?B?Y3ZpMHhVRW51NlhONXFPR0ZyTm91L3ZHOVFhc2VheUpoSE1HVGNXeThoQmIy?=
 =?utf-8?B?eDhuMnlXVnZkdXVsY1lUclNpZVZBYTNKVG5DdUF3a3dpME8rRW5wd1dRazFt?=
 =?utf-8?B?VmZHOXIwM3BqeUFHTlcvRktobGloTnQ5MWxLMHNpZTFud3hzcENRUm10RXky?=
 =?utf-8?B?RjZNVW9IM3FRcjlzMHdSMzBoU2VrV203K3VjTG1XMlliMmJWckpnVHNGTzBD?=
 =?utf-8?B?QXpaZEdGSlpIYmdNZVlMQWhScDZjWk1OWVNTMGJsWnpOWXl3ZU0yTjk3aVor?=
 =?utf-8?B?bnVvRTZMRG1EKzBJQUJlV2pUMlhKbkVmNTVSYkJ5OEJMUk9nay9OR1RXK3dZ?=
 =?utf-8?B?N2xraUJCMnZ3c0tvdjlLQzRoWUVDYjkzRnFKdUZPUWllbXl1eldOSzNkVzRR?=
 =?utf-8?B?aHNLc1VDY1BjblFhNVk3NFJHbWZ4Q3I1WkJIdzZzd1BadTZtS0hVc20ydGRK?=
 =?utf-8?B?L2hibXZHYkRVMVlSWEkydUpmelFabWxxUUJyWGlwSFZvdmI2K05sci9TY1Fs?=
 =?utf-8?B?dFJGaEl6VDNQV2JFWHNMOEZON3ppd2JxcUc0UlgvRDNJK09FY3FxY24wdHFH?=
 =?utf-8?B?M20rRjl5Nzh2T0NzU1VvN3hSbnZFUUVzN0lnNnZaSkk2cGlrUStjNSt0Z2dF?=
 =?utf-8?B?b3FMUVd1Y1VpaFhBZ0N4OWxONFByUzlucmZLQkFhZWg3VVU5ZWFnb0xuSi9x?=
 =?utf-8?B?eTNBOEZFTXlDcnNsaGtqLytPQjlEbWNwZDNhYndiWVdIeWNVWFVPc3lCTjJN?=
 =?utf-8?B?L0VzTGphY1YxL1FORkpBSzNOcEJHRnJueWFOaFRGalVZVmtReHVYTytLWFB6?=
 =?utf-8?B?aG5zUXJReHhaamJ5YmFMMWdPNkFPYnZNV0VIeG5HQXdWWXBpWE1paEJZR3FC?=
 =?utf-8?B?WUxOVXFBaGpnWlVkSDV4R2I2TEhEcVhQRE9IQUhOY1IybHU5TlBsbkFldVdW?=
 =?utf-8?B?cHA1UmNvSXJIdkZyaVd6cEtLSWxFeWFXS2V2V1Z4ejNsZy9vVDgrdzQ1RktS?=
 =?utf-8?B?Q3cxaTZ1RitIamowelpHVzYybzlieE5KZEQyNWt2bm9PTXA1ZHpSUU5WanJS?=
 =?utf-8?B?UEFHajc5SzcrRTBMNXBHTnRuNGhNSVcrQXRBcE8wMVhHdHJJeGh5d1FsZEtj?=
 =?utf-8?B?QkI0ZTE3dVRpc21YTmswdTRMYXgzVTZTQ25aQVI5MXd1SkNuK1JuSUlLOHRD?=
 =?utf-8?Q?+Ld0U4NXpzUiI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTB3NExqOTd1a0dKUWMyN3d6R2RubUg3Z0g0Kytrbk1HbDYwT2NlUGlVcFl0?=
 =?utf-8?B?MS9WSG1kc3NzZ09hdDF5bWpLOXJCMzZEWlpQSC94MjVSODg5a0Z1WjZNbkUz?=
 =?utf-8?B?Nm40UldHMGtIaWdoUzVpN2N1bUxQSG9ja1NTSVpoNVVITndxTUJlOFIxN0FY?=
 =?utf-8?B?elFlTDRsTW5VMituNDRvd0pzU3FHSURQMkxvWEM0ZTR4OVZYZkdxZUVCQUs3?=
 =?utf-8?B?TVVpZG1EalhXeTVJMVRyYWlzOS9GUEVyeDVZSWlFT2REMGpHcVU1Zk1pb0R2?=
 =?utf-8?B?NGo3eG9wU0VvUHpPSlNlc2dXYVVvZkRoM3hDbk44eFpRL0RVbDBXVWprSXVy?=
 =?utf-8?B?UDlXUXE4VHBabmVjbS93OW1WczdQb0VobURRNGl3OHpJbjhwUkgyaGZrNmVV?=
 =?utf-8?B?Z00zb2lEeUhFaXNmbUgzMVlzTjZhVC9ndE5wL1BxcGtrSkpuZCtxenNSRXQy?=
 =?utf-8?B?MXhNQXd4N2hZb2dYMnZrTWkxMElCVVBhSXAyVW5lZlhPbThwSzBYS3N3ODA1?=
 =?utf-8?B?UnZpUHhxMVU1Z3RodVBwZ0d1cGtENWZJT0FvdGY4cGpnOVJ6RFNlRUZsSE81?=
 =?utf-8?B?RzJHZU05ZWgvdHo1WDhqTkg0WDJLSlpHVUk2N3QxRWJIbnppL1Z4dm9DVHl5?=
 =?utf-8?B?Smd5aUF2STd6RmZQWEh5VzU2Z25oVU1zUEdyZVc1QUR2M2FvOXRWL1dxeThZ?=
 =?utf-8?B?OXVUMG5YdGZxQ0JtZGVtVVZheTl5Nm03L3lqdDJxYXcyTlNHRElDRGdRcVlH?=
 =?utf-8?B?Z0djdzR6NlU4M3kzZUNFSG5ySXdEck10UTBPazNDZ3JxQVZnblpuYlBQVEw4?=
 =?utf-8?B?ZDRNK3dXcFB5SHc1TzhlODZ1bEhnY3E3bkcxMnRRTkJlTHM0YktZSG9LTUlR?=
 =?utf-8?B?cllpeUdMZTdDOEhkMVF4YVVPR1VBV1pid09jNE1QRFdMbXlmYnBqWmsyYXFE?=
 =?utf-8?B?TEVmR3NTdG91SlN3RTJnc2kvdkZHYTIxcVJIN0NPVjZzdUN5eW9haE1kSWVR?=
 =?utf-8?B?L2N5M2JlVmxuNzd5Q3ZYeTQzT0tjdFd6QnJlbHVoUlFxZnpabTYrYWhBc3R6?=
 =?utf-8?B?TEFqY25EZDcrZTR4ZE9KK1czM1ErbTlDUTBUWnBRVWEwQVQvWHJZN1FMbjZE?=
 =?utf-8?B?aXplVnZ6Z2tzSlNIeGpKcS9FREtYZUNyU0h5aTRrRmN6NnlxcmFqTHhwV3JF?=
 =?utf-8?B?MFFJRjdNQWVEVDdJdWQ4aUMxTmxDejVnc0xqamwzZW9kdmFGVTNRajY0VFNn?=
 =?utf-8?B?cER6NUdIZXZhQTZBL1NrOFFkSUlvVTFOVmxORmhMcVN5U1FFUGx5YmYveGMx?=
 =?utf-8?B?UGI4M3NrWkFLQVg3M0dhc0VMK1ZNQ2JiRHY3ZERIL1ZSeDJSRHpNZS9iWVFF?=
 =?utf-8?B?eEVFK1dsd1hkSXJPNW1taTlZZVhOWjlQUlMyenFYcWc1aXQxYlJFQktra3Zq?=
 =?utf-8?B?SEJocTFmSExYZ3ErTzJSTE53UlNLbzRXSGZoWmZ1a3FNUVkwaXlWZVNHSmdR?=
 =?utf-8?B?TUJqcVpxNXROVFVNdFZFNmpQK2s1bHNGdjFHQUNjVW1ZM2FQbGl3WGZDUGdB?=
 =?utf-8?B?VHM1dkpMSmZmMVBRK2dzZlFrSDd2cEt2MG56VlBveGQ3eUMrY09zOUVINzhq?=
 =?utf-8?B?eGVYaVViOXBURVZxNTMwVkxGdmJaaWtRQXYrZk9CTjEwUWZRSEJFSjdycVAr?=
 =?utf-8?B?QTREYjZzc1Yvb0JJWGFpcE5CSVVqUjFHM3VPSFdyK2t1Uk9VK0M4Ulo3UDNV?=
 =?utf-8?B?Ky9SN2J1NnIvZ1Jrc2x6cUJib3RKYnJLUmxGVndnWWoxYlhlN0M3M0Z3dkIw?=
 =?utf-8?B?RGY5YVhjYjNSL3czQkUrUHdzQ1Q3UGp2NEM4OXNyZ2E4TFMxTm8yWlV6U3Iz?=
 =?utf-8?B?NFJFY0dEa3MvTVR3RXpKM29Hakd6UTFQY05rbTExL0RrUmg5em5YOTVVV0lK?=
 =?utf-8?B?d2RLUit1Rnk4N3V0Z2o0dk5oTnM0YkNTVzhHVS9RTG1KS1h6MW82ZFNLYlJ5?=
 =?utf-8?B?Vm81NGRvcGk4UHNzbEZpcUZUby95aVdnLy92dXRXMWhxaHhuNFpNT0M4eExR?=
 =?utf-8?B?WFdBeVVndHEvQzF0OHVRSXo0b2wxTWhMbWpuay9MeDFxU21Hd2F2S3hERWND?=
 =?utf-8?Q?QWybb8al1wxpoEgCuW1T44nL8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f818b-7af2-45de-c709-08dd5fc220ac
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:55:53.5339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5hEeG0v7768/ZZpcbVvKyH0pQ8Ec4P8MEhulsV1i5MIIOaWXBfHZdAe/ntWMtKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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



On 3/10/25 09:03, Michal Simek wrote:
> 
> 
> On 2/20/25 15:19, Venkatesh Yadav Abbarapu wrote:
>> Add support for flash device reset via OSPI controller
>> instead of using GPIO, as OSPI IP has device reset
>> feature on Versal Gen2 platform. Also add compatible
>> string for Versal Gen2 platform.
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   drivers/spi/cadence_ospi_versal.c | 19 +++++++++++++++++++
>>   drivers/spi/cadence_qspi.c        |  4 ++++
>>   drivers/spi/cadence_qspi.h        |  4 +++-
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/ 
>> cadence_ospi_versal.c
>> index 816916de16d..fbeb0c6a85c 100644
>> --- a/drivers/spi/cadence_ospi_versal.c
>> +++ b/drivers/spi/cadence_ospi_versal.c
>> @@ -204,3 +204,22 @@ void cadence_qspi_apb_enable_linear_mode(bool enable)
>>                      ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
>>       }
>>   }
>> +
>> +int cadence_device_reset(struct udevice *bus)
>> +{
>> +    struct cadence_spi_priv *priv = dev_get_priv(bus);
>> +    u32 reg;
>> +
>> +    reg = readl(priv->regbase + CQSPI_REG_CONFIG);
>> +    reg |= CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK;
>> +    writel(reg, priv->regbase + CQSPI_REG_CONFIG);
>> +
>> +    writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + 
>> CQSPI_REG_CONFIG);
>> +    udelay(5);
>> +    writel(reg | CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + 
>> CQSPI_REG_CONFIG);
>> +    udelay(150);
>> +    writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + 
>> CQSPI_REG_CONFIG);
>> +    udelay(1200);
>> +
>> +    return 0;
>> +}
>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>> index 623904ecdad..05356ad2e03 100644
>> --- a/drivers/spi/cadence_qspi.c
>> +++ b/drivers/spi/cadence_qspi.c
>> @@ -251,6 +251,9 @@ static int cadence_spi_probe(struct udevice *bus)
>>       priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
>> +    if (device_is_compatible(bus, "amd,versal2-ospi"))
>> +        return cadence_device_reset(bus);
>> +
>>       /* Reset ospi flash device */
>>       return cadence_qspi_flash_reset(bus);
>> @@ -452,6 +455,7 @@ static const struct dm_spi_ops cadence_spi_ops = {
>>   static const struct udevice_id cadence_spi_ids[] = {
>>       { .compatible = "cdns,qspi-nor" },
>>       { .compatible = "ti,am654-ospi" },
>> +    { .compatible = "amd,versal2-ospi" },
>>       { }
>>   };
>> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
>> index 1f9125cd239..d7db37c1463 100644
>> --- a/drivers/spi/cadence_qspi.h
>> +++ b/drivers/spi/cadence_qspi.h
>> @@ -45,6 +45,8 @@
>>   #define CQSPI_REG_CONFIG_CLK_POL                BIT(1)
>>   #define CQSPI_REG_CONFIG_CLK_PHA                BIT(2)
>>   #define CQSPI_REG_CONFIG_PHY_ENABLE_MASK        BIT(3)
>> +#define CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK    BIT(5)
>> +#define CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK    BIT(6)
>>   #define CQSPI_REG_CONFIG_DIRECT                 BIT(7)
>>   #define CQSPI_REG_CONFIG_DECODE                 BIT(9)
>>   #define CQSPI_REG_CONFIG_ENBL_DMA               BIT(15)
>> @@ -310,5 +312,5 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, 
>> unsigned int reg);
>>   int cadence_qspi_flash_reset(struct udevice *dev);
>>   ofnode cadence_qspi_get_subnode(struct udevice *dev);
>>   void cadence_qspi_apb_enable_linear_mode(bool enable);
>> -
>> +int cadence_device_reset(struct udevice *dev);
> 
> This newline is nice. Anyway I have patched it.
> 
>>   #endif /* __CADENCE_QSPI_H__ */
> 
> Applied with small change in commit message to spell Versal Gen 2 properly.

CI found build issue for.

phycore_am62ax_a53_defconfig

That's why dropping this patch from my queue and please send v2 of this also 
with above changes.

Thanks,
Michal

