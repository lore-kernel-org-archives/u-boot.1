Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9271C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445ED88452;
	Thu, 11 Jul 2024 16:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J7FZx6RM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F578852E; Thu, 11 Jul 2024 16:54:14 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3CB88049
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyHBF+zhX3iBLQi/UdIQHSmbHGa/mcNro55TL8XLP2G9XM6PnXdlgO+iwgxuGDBETG9zyA9wdRXn8OCUWOzziIN+o8lIigbYMPMmmlEPIHymmLctswctDEi9/pduLAt8U5e5Qvv7W316IlbwM4Ex4VnGEV13NGORzhh7V/Oo9G9zLAnEntAcFHuKTyiL6ppXDOQYdbyFVfyPX+4BPQYallFOodfSMpWuDW/rHCgWCy29J00QJH0+Kw/4pX+RwXkrHxXO8cYUIBbXnGqYwJfT6ySkL9FeJc6EIiTr+pqAKszh//05xFpCADoe0rUAr3Its2qrYMYvprGBPSVaJlBneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVfvAS6wfQOLM2J4qecDCBV5/fr/PmpLwrtGTsZof0Q=;
 b=A0qIlNf3P47EJtUvDA6lk+kzl0oRNeik7moiOynhgboK0GCS3RII5YuyfOnUb0frkWPU4QkctjWmT6nR7yBKRNA4daRRjn9ty6L7lJjfDCFzHbSVj3WRjDQMg3QL/DJHTxcmwEd0b/MVyOAriEexXrTddj0Pl7ohfjpEdfkdyjtwnDNwaw1tMaTrPmI/oFUa9WW2wuIOCRxxDVlS02PNDSFV+Ad1hYDdUZOfktTV3zSiuIUYONqPjjmkcDSfBztxb+j5gnWZroJw2sRMHB4Ie/enSL3KUr5++1YwL2cKOW1liKvmVywpjiCOvOgtXfZmcRTPSEVR3xCQIoUp46baFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVfvAS6wfQOLM2J4qecDCBV5/fr/PmpLwrtGTsZof0Q=;
 b=J7FZx6RMPyy4Of9KIua+6r2PXfkuHFa4k65GGwN5vFUm2b76bTtYqcZngZJxp08z/B1v+P4QLTGYinpQjjSSJEpFIpuDy2V3o2g69VXB2V+Lw+RPoS0bhoKF/AvYQrrCEjkadrRhGzmAK2LWB7Kvfoovc9nqQgcFTJ7g0h3d0+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 11 Jul
 2024 14:54:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 14:54:04 +0000
Message-ID: <f160ba8d-55f6-4001-bc5e-92a43347b1d6@amd.com>
Date: Thu, 11 Jul 2024 13:33:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config: Enable the config CONFIG_MMC_SPEED_MODE_SET
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20240708091755.5021-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240708091755.5021-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 91465123-c404-42cc-b822-08dca1b94e7f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGQxbWtZUC9yK04ydCtZeklFSjJSeVRLNDN1MGxNWGJGTG0wbGRwYWpDRE9i?=
 =?utf-8?B?UzJGYldrZndOU2V6NExndWlTNWU3ajZRTkNScFU0NWhFaDlJM240SVVXMGJr?=
 =?utf-8?B?WlNsU3c5UnlRbElGVGs2L1ovaE41LzVMZE82ZGcrWlUwVUdwTUdURWVVY1hq?=
 =?utf-8?B?aHVlb3JQQkN2V0NhVTFLendmblk4T0tUcTRuZitFSFZhTWI3Zlozc2NLUlli?=
 =?utf-8?B?cEhHWk1jY1BmMjU3WnlnTnRhT2xKL3NDSkJvWUxuamU3bEtpZG40SXdQWnpS?=
 =?utf-8?B?WG9ROVA0c05TUng4ZWhDNnA4bzJvcmNNU0lUMUZmOUFhRWVmSFY4a3ZBekZJ?=
 =?utf-8?B?N0lWa1E5eVRQSFp6UC9hT1h4Vm9YbzZ2VW5MSlpuQnFXZ3BaMDhzSXdscUNO?=
 =?utf-8?B?L2ZBclVlamZaeFVodGdDL2RXNXcrT04wM1hkNFdRbjZFSU4wU2UzTEhiRG1P?=
 =?utf-8?B?dENONENPeVltN2NYUU9MOUVKdDJoVVA0bGs2VU9ZYm9yV2FQWGxkaHpENUps?=
 =?utf-8?B?MWYzZ3luV1RERCszaDEzNk5zT1V2a29BVFVicXRSN2dqYlh5RHY2ZXdUaHZU?=
 =?utf-8?B?N2hOTm1iYkxUOVROVGdBN1lyZzd0aHpEOURoUFE0d3VDSU9WbVNuclRjNE44?=
 =?utf-8?B?elZHWjE2TFFJTkMzSzI1Znd3S0tzd3BLd0FEUk5wSkdrc0JDakdJODJaWjFU?=
 =?utf-8?B?bWsveFJJTVpXZ0lZM0NrSGRINjhXSWN3WWk2dDlnb1RsMTJiZGdVaTAwcjNE?=
 =?utf-8?B?ek80NUROQVJCL2tIMDQ1Uit1QWtrS0FXTkl3WE5FOSswaFJCZ1YwcFNkZFNX?=
 =?utf-8?B?K1AvR3VXVXVqZzJ4VlBJZE1qMkNPWncxTjBiRWR3eWkvTi9QWVliR2pQNk4v?=
 =?utf-8?B?dVpoSTY3V3R2WDByZ09tQnh4K0VtTVBjWER5SDRjUk9uSnRTb1hxVy8zTHNY?=
 =?utf-8?B?UkRBZ2tXY0ZJOHVPZVFUNWhOZUdWa1F1VkVkSnl2MUYzNlFvUWk0d3hSVVZP?=
 =?utf-8?B?K2pPaXBXbC84YS92UDRiekRRclRSRlFoTmdwZnNPUXAxcDZEQjRoMm9zYUNo?=
 =?utf-8?B?eHpOZXVzK0pUb0ZQWkN2dkROOHZHTDFyVUp0L1JKTHcvS3VWbnFLSzZxeW5H?=
 =?utf-8?B?L3ZOdXNWa2RjZkgvQk8wQU0zdVFHT2d0TldhOXpzalFXM0xHTm5PZEdXditE?=
 =?utf-8?B?UDNDazZGd3BScXpVNTB0M2RHZVNjRzJhZ2tZWDF2SEdVL2R3SjdwT21jWHBh?=
 =?utf-8?B?NHAvZ2pLa0pPaWgwR2tBbTRQcE50ZDk2R0MrMGF3eGF0bEJFeC9CTVNNTlZp?=
 =?utf-8?B?NUNkUGh5WjZDZ2ZTdDhBZkNkeDJvRkkyRnlsbGwyUUIrVm5PT3Z4SnZLVzUz?=
 =?utf-8?B?aWZHQWYrQjFmT3JVcDYxd3FkV0oxc2VDZDFjZmNWTXBzMTVzdTlRNjZkM2lM?=
 =?utf-8?B?OVl1alMwYjFZZ21ZSjc1cjdNKzNYdXA2ZEUrMGFhOFJjZ28rQ0pYYWh2eG94?=
 =?utf-8?B?cGpHWHo2aEFIbi9SYXhvcUVBRUJQaGZwV0U5b1daVGUxTStrcGhTOWdiYk5y?=
 =?utf-8?B?MjNOY2lNdXpqL3ZQWmYvYUExakJTb0RmVkhkdGgxV3ExOUxqWUNNU2dMK3Zk?=
 =?utf-8?B?ZDBCQTBqRUZoem0vajgyREMzNmQ5ckFmSHJVMWoremRVN1QydklKVFRVNmVt?=
 =?utf-8?B?Z3dOWU9FZldEQWRMM2h2WElTK2lxZjNtY3hXZ2xmWEVGcHAvbWpnNGZBQzJz?=
 =?utf-8?B?eFJKeFBWdVorV0VzM254QytDTDZwditWMktxTlhlRDhNb2lVbUthSjExbFVQ?=
 =?utf-8?B?eW5UOVpFYWE3Um1lbkp0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVscHJxaHpVemxaR2JWQnVKVUtsOEFoRHpPNFVRTXlVa2EvWjhtbW9rajM0?=
 =?utf-8?B?T1hiOW1sSkV2dWJ6eXd2ai8xRThaWThKc2tueGlhcHpNc2hNMldQZ3BxQnAx?=
 =?utf-8?B?SEN4SHBQVy96K0JOeW04bFlRaXUyTHdlSjNpb09aeUVxck1uQ0lxMmtGQzE5?=
 =?utf-8?B?YUlMVUdtVnFkUU00aHlpV3dPUFFRTXRpTkl6TlF3bG9MQjRYSk9zRmFGajBs?=
 =?utf-8?B?QWtJeWJPc3loSUMxTFhPWWRwL3RpQVUrM0QvYUNVT2c5TUd6azU5WEE1YnE0?=
 =?utf-8?B?SzJvZlNab1pFL25DWkNlZzE5dGJxQlFlb0kzVEduSC9naG5EL3RMWHU2bXBP?=
 =?utf-8?B?ZUZRVVEyM3dQemF4cTFTbXVwM3BSL2xWdGxJaHRCdUpRNVREWlRXT2RwQUZz?=
 =?utf-8?B?cUZZWEhGVEFDbVJtck5Pc2ZodEw0dWpTclM5RmZaRDkxKzZGeXp0WmtDQ0Mz?=
 =?utf-8?B?RXhmV1JVMi95cUVFT2NmbUd6aGJuVFNTbGxKeUhLTnVrSGZqaDYvSC9xSFdo?=
 =?utf-8?B?MHFDb0I2SW5iK083a1NLSWxMMU9RVWt3bmJES25NQXRmdjhIYVBrekJVS29I?=
 =?utf-8?B?RVoxL0hMUXpNK3ZwczJEbG5tTUF0VndCSXdsTXpIWUxDRUh2ZGlwV0tHYlR5?=
 =?utf-8?B?M09zOXRGSG1uSkNwN3NLK0VOL3BWeng0NC9YRms4YURGVnZlbnoxWi9OU0VK?=
 =?utf-8?B?bU1FeVhRUkE2b0dNMEFjWWREblRMZG5FZHlieDlNUTJuUzVZVThvaWFLWWdX?=
 =?utf-8?B?ZHlvU1h6WW1BcG1zZnJUOEhqSk90WitFeWVtSkNwUURVQ1FLUVkyT0hpMllo?=
 =?utf-8?B?OFdSSDNrVEFVdEI2UlVMYncxbEVPcFdRTUpBYnpoQnB3enliTzJNYnVReVpX?=
 =?utf-8?B?cjZvL3lNY3U3TGVCWWJmVldaWWsvK25DSE9RaTdxQkJSaUgvVHNvR2F3N2tr?=
 =?utf-8?B?TTQ5b2hMQUhUT29Lc3hHNS9KbmpuUTMxUk1hT0JPMFg4UVF0NDFvVlFrSFpl?=
 =?utf-8?B?dG9kQ2tqVkt5VnVrbjR0SXEvVm1acVZVME84bk83bWt2TFZKUWhERUJhQkNo?=
 =?utf-8?B?MytQOGVFT3drSG8yRTlvVlNhZUZYcXNYVVFXZjIzaURWbDVWOGZIM09Qc0gw?=
 =?utf-8?B?TzZVM0VQWE9MYUhXNDRDSEsyRjdibFlFVWxsL0wxbCtMZEdJZjA4dU5LK1kv?=
 =?utf-8?B?RW1xME4yNm1FcXBvVGRJVzBweVRYRjAvVDkxQzh1b3Fmck5QOTVZTENvMC8v?=
 =?utf-8?B?bnFOMGhEUmJTRXBUU2JreTNBTWtmQWRUNHhMQnZkM293dlRnM3JnRjdvcnNF?=
 =?utf-8?B?TFlMUFZyM2dsVktadVRKdFhtdDJ2bXpBcXgzdXAxZ3pya3RPRlN0bTNSYzln?=
 =?utf-8?B?M0g1YTdaYlY0RDQ2UmpoYWlkMTBDdGx4eDhnSXdUWVhxRnBIbVFtM0tFNVgv?=
 =?utf-8?B?eks4bFF0RmdtV1ZkVk1leUc3SzYrTEtUSTY4MXEvb3hndlNlS1JrYkUzUFQ1?=
 =?utf-8?B?SnNOTm4xcFpRZ3ZTanVNVWxRbVNDTmxUS3NmOExDZ2tDKzROaVgvZDMwbmgx?=
 =?utf-8?B?T0h4eXdqQjdiNzU1MnY5b3ozZFY5d3FTMUNnYnRXSjc4VStjRFgyKzdhejVh?=
 =?utf-8?B?VHo2VTlUeCtEbm1BQXJZVE43bzhLVWtzKzJhYnhxdEY4UWhlNEZXUWRGRHZN?=
 =?utf-8?B?SGpGZVh1Z0lRUlZkQnowaTV4dEtsSjJvQkVpTEVMSFprV2tBWVk1M2Y5TVBp?=
 =?utf-8?B?S21oTjVKT0s4WVppSTN2MFR3Yk9EdnNzeGQweTRwejduWmNSamZXT29ZbTF4?=
 =?utf-8?B?dkNvcExCTEVyQTk4YlpnYUV6MkpSckpoeUxRTlNmendyRGJHZHRFOElabGdI?=
 =?utf-8?B?QVA1UnZheGJYVkJnTEw2S29ubjRaNHZESXlWUTV5Qzd1bDFDOVZWa0IyMHFj?=
 =?utf-8?B?NGc1aG9NdDdqazd5M0k4QWhqYzFJTWF1MEZDR3cyY0dNZkVQY0ZDbDZpK2E0?=
 =?utf-8?B?TVhDTXY5ZXZWckNqcDA5ZUJSTC9pTDVtd081OTAwUGtuOW9abk5rMThrMUsw?=
 =?utf-8?B?UE9tNzFBRys4SHhYM1FpWlRFaEw4eDcxVC9mU01BL055QURXOHhhWHVCL0JF?=
 =?utf-8?Q?qrZkBlprgQd7eni/ZJNZHJ9LW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91465123-c404-42cc-b822-08dca1b94e7f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:54:03.9250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN3v3eORgj/DaBF4UDrGKsde3934vBj5x+0qaidrGVPBFAv6Fu+FA2uW+zNpSveg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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



On 7/8/24 11:17, Venkatesh Yadav Abbarapu wrote:
> Enable setting speed mode using mmc dev commands.
> The speed mode is provided as the last argument in these commands
> (ex: mmc dev 0 0 10) and is indicated using the index from enum
> bus_mode in include/mmc.h. A speed mode can be set if it is enabled
> from device tree or from capabilities register
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig       | 1 +
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   configs/xilinx_zynq_virt_defconfig       | 2 +-
>   configs/xilinx_zynqmp_virt_defconfig     | 1 +
>   5 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 2d611f84cd..f8df0b53e5 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -59,6 +59,7 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_CMD_SQUASHFS=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_CMD_UBI=y
> +CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_PARTITION_TYPE_GUID=y
>   CONFIG_OF_BOARD=y
>   CONFIG_DTB_RESELECT=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 53ef81e64d..40a9b16b9c 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -58,6 +58,7 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_CMD_SQUASHFS=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_CMD_UBI=y
> +CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_PARTITION_TYPE_GUID=y
>   CONFIG_OF_BOARD=y
>   CONFIG_DTB_RESELECT=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 915f0b993c..dc1754f6d1 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -59,6 +59,7 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_CMD_SQUASHFS=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_CMD_UBI=y
> +CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_PARTITION_TYPE_GUID=y
>   CONFIG_OF_BOARD=y
>   CONFIG_ENV_IS_NOWHERE=y
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index 9be904fd30..f8b6a3f1aa 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -81,6 +81,7 @@ CONFIG_CMD_MTDPARTS=y
>   CONFIG_CMD_MTDPARTS_SPREAD=y
>   CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
>   CONFIG_CMD_UBI=y
> +CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_OF_BOARD=y
>   CONFIG_OF_LIST="zynq-zc702 zynq-zc706 zynq-zc770-xm010 zynq-zc770-xm011 zynq-zc770-xm011-x16 zynq-zc770-xm012 zynq-zc770-xm013 zynq-cc108 zynq-microzed zynq-minized zynq-picozed zynq-zed zynq-zturn zynq-zturn-v5 zynq-zybo zynq-zybo-z7 zynq-dlc20-rev1.0"
>   CONFIG_ENV_IS_NOWHERE=y
> @@ -155,4 +156,3 @@ CONFIG_SYS_TIMER_COUNTS_DOWN=y
>   CONFIG_SPL_GZIP=y
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> -CONFIG_TOOLS_MKEFICAPSULE=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index fa912ae3bb..1133134e3f 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -101,6 +101,7 @@ CONFIG_CMD_MTDPARTS=y
>   CONFIG_CMD_MTDPARTS_SPREAD=y
>   CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
>   CONFIG_CMD_UBI=y
> +CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_PARTITION_TYPE_GUID=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_BOARD=y

Applied.
M
