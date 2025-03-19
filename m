Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0CC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D424D81E8C;
	Wed, 19 Mar 2025 16:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G1bOyxKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7281181ECD; Wed, 19 Mar 2025 16:32:30 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536A28141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPQF1bxPSmZ2mu33jobu4qNs4pPi+g3NLNJSqgwM7kqUINiJ83ht01j4CC1rATYwLpxtDxeH7GIr5LzE8M/kVscBf6MTAfziWl1GIt1WLclHNvyPmWKhdOxe6ingCM1XTvxV0DBaFRfleJ6GfvaTunLIxpY7Eqlk8+VYAEc6dU6Z5O1bSfKS8IRH56PQ4kEBJhutxFmgc9hiM2r/bfJ1VhdHT2Tu+FDmQxYPVmHK73TTbHD0oNHYPFBKJphM86XTH2hlp2Ba0y6fEJBooqYb4aUFYyDgp4yU7sRfPDp9OAXB/84fdxhNZvpGgVXCUqdi6fSorItmFp8+w2ZbSch86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmAc4vLH9HoS4QsBOs2d8CRbTR0OD3D+9pYhzs0751g=;
 b=sBhtNiFv5l5j8Gcb6Sq/iNgDhxST1H1L1gUjj5jxaq+Ujugx870++iyEy4MbSVMbtEf2WVuoIri4A8fJqPa2Vc6izcPXeLm+I6Fj9qqrExgJfgDNLGHEmrjurOwq2zItylIn3z2scpqsDdTiGdOyRAAcmkwy4tSF6IBlAu5k6Qod9jB/4p34ZnxjPUf/6WWbCIVL5W/MOGHkCCXStsn6hYE9SBkBdR+macjEX5N2569h1wONtGAhgzA+kQDVnx2g6h9fYHn0yFa6AkidX2dH1hVnGmoU+oc5Q52pONZCdLaifINWodTmUHhq3tRszvDqPjr3VIATUIiqFMw2lzTMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmAc4vLH9HoS4QsBOs2d8CRbTR0OD3D+9pYhzs0751g=;
 b=G1bOyxKUFXb+kzujJiFHnXBeubFI+AtvIsrm+3y2rlHiJvKivswG+fHHpO5BrjISWmptDM9aIaoZ0mQlTYcT4h50dkWhmZb3jznLDYjH89vy8WkqABUAA3Ua9EiyxUNlFBn0KrUk3VOpMcOd+raDby1negfBw5hy/wAOyyn5y/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 15:32:22 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 15:32:21 +0000
Message-ID: <3aa92032-bdfb-41bd-a598-51ae0d6d4ba6@amd.com>
Date: Wed, 19 Mar 2025 16:32:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xilinx: Allow alternative boot strategies in
 zynq-common.h
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.956edb5d-5d6c-4991-9875-8dc26491146e@emailsignatures365.codetwo.com>
 <20250312153741.24007-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250312153741.24007-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:208:32f::25) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8296a74f-5314-426c-7538-08dd66fb3da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amRPakkxcnQvdGdUNTErTThGa0N2SGNnMWFIdEtGT0tpZWwyRjZBZWEwTDNZ?=
 =?utf-8?B?NUhuQVpZNzA5dFZ3T1Z6cjlXeU5zMUpCdXkwM1FEdWlmeG44c0QrMm9OcUpT?=
 =?utf-8?B?WUJYczBwbWV5TkJ3d2VCRFJqYW51d2dwVDBIN3lZR2pITUFNdEFSSnRlZU44?=
 =?utf-8?B?blo5YWhiQU1UeGhtMWlRUW9JNkVhR3p3aVFQTTZUTm5hSEdSQ0lwemI5QytO?=
 =?utf-8?B?RURlSnhrWWI4d1c5NHdSUXR0NjVaVDVoZnBPanlvOXhoSnBDczdldkJnZWsy?=
 =?utf-8?B?RFA3OUZ5dXBMcC9KMFhtN1ZQdG9keDlBUEw3YkF0TUNieGl4VWFvZjIzRDZR?=
 =?utf-8?B?eVY0cjlRTXNWSjM5SVNUakZWM3h1cWxvTXFMWFpQVXJ3eURsQ0N1Z240SFRL?=
 =?utf-8?B?azhsYlFRNGkxUTYyaXhoOHliV3FGNTlMcHlKMVNBM1QrdVNheUhJQXhpTml0?=
 =?utf-8?B?bUo1cExCTjh0QXZ6bjQrSWZ5bXVhbGZMa2g4YnlUd0xuWGJYT3l3bld6eW02?=
 =?utf-8?B?WEo4OVJBc3Z4KzJLVk5QZEhIRkVpTGlLN0pQQnhUbWU0T2s5NGJ4cFZjK0ZP?=
 =?utf-8?B?TGhuM3U0N2tPa0xqN0VLa3dBV3dHdlJaUXVic2lVb2FTc3l1akZyOENIcVls?=
 =?utf-8?B?OC92ZG9rdW83cHRXdEpqTjkrZ3BYcGlSRk9mQzJIVDdPVURRT0x2UkhBdk1n?=
 =?utf-8?B?MCtpcEE4bTdYNVFGTUVlV0RzMlBQVnpnYnBKSzZJUXRtUTlLMk5lWEZheUFq?=
 =?utf-8?B?Y2dTRUZ4RlNBK25DOFVrb1dabWRteENJWm56VFRNd1VQZFdXRkpaOHQxbG5J?=
 =?utf-8?B?MDUyZkVCZURRVm5GUHA2VW9yelhaYi93SnJ5THJmRTFySVl3TDVVMkl6Y1dp?=
 =?utf-8?B?Q1VYWGdyeFRUSGJiVk1MZVJsUmk1NG1nNldpeDBPQVJjYTYwR1hXbGo4SjV2?=
 =?utf-8?B?NTMyb2poVnVaMThpVkl3UHhQcFRjdmN3UTFJK2x3SE9GRTByYjM3OEdvZVRC?=
 =?utf-8?B?Y3lFTS9sZGVDODhyRnNUK0cwUkFkamJUdlg1WDVlejFoVFByS091TEw2S0V2?=
 =?utf-8?B?dGttOW1rL2lrQmo0Z3JxNzBnc0hIWEZRYUMrS1dKbEFvV3BRbFBHUWhkTXdU?=
 =?utf-8?B?Nk4vclFUZmswdGhHcmtlTkJQVnNEd0c0cTY2VGlZRjBYakZtM3NmQnhnZnFN?=
 =?utf-8?B?WWxoZ09iNVM1eUdVTDZYN1lpQ1IzQzR1eW14Y3hrdzVqd2JnYllBMXp1V0U3?=
 =?utf-8?B?L0txemI0MVVOTUlvMXc2UTZlWFZPTi83Si9KV1gwTFFSMVIzbzVXanM0aFJw?=
 =?utf-8?B?d05SSjZBU2NJY0pRUUpBTWJWMUhtWUM3Zng3NXdwWnBKT0Q2VG95WjZhZkFM?=
 =?utf-8?B?VnY0OGJnaVk3angyRUpkZlMycU1xa3NLZitaTGRFMFJHdmk0cHBkM3kxd2RN?=
 =?utf-8?B?QzNwa3h3ZXUwcE4rbHlMYlJEUmpPYzdkZGhUcElMY2t5RFlJa2pQM0tHRDAv?=
 =?utf-8?B?ck03bk1Sd1I1bFJPZWR5aks5SmMweG1vSlJqRWNWMEFhWFZmQXVQWC85cWJ4?=
 =?utf-8?B?eVRDbml3M3c2cEtXQjYzeTBsZmovRnJDUjduT0hoMHV0dDg5NDBwb2xOZS9t?=
 =?utf-8?B?aHJVblh6SzFGeXoySGRCbVE3Y2UvZUhQQXFuSVAzTk0vZjZnUnBsMjFDc0h5?=
 =?utf-8?B?MnZ0MGVKZFpFQVIwMGd3QkFMMUpkN3I1T3VNVU5TQW01VmJLYksyWW4vc2RN?=
 =?utf-8?B?RzlyeUtWbjJ0L0VLeURaMW1DNmlNYko4bVUzSERlM3hicFYzRk0wdWVWNU1U?=
 =?utf-8?B?MWQ1andkNUtjZ2ZPZkFoMGkyOURTN3EwSnNhaTZqRmh2S2w5STRMZ1A0RnhG?=
 =?utf-8?Q?96jrsZbqCCCwo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lOV3kxOEhGNGVKKzFPd3Jwck1MdWcrNWJxUkhJakRXcTRRczMzTzBBT3JB?=
 =?utf-8?B?NFpyNTYyNi94aFJLWXArMGxPRFBUbDBRbmlxc1dUQWkrM3BNSDdsMjJtWHd5?=
 =?utf-8?B?ekEwVUlMUmhRSEY2djliZk1vYUl4eVN3eDNGWDAzVDdldEZKa1NNWFBpZzlp?=
 =?utf-8?B?Vkt3SzV6K29iRkNTbVZvMWtiYkNyNlJsM3VSVEwyc0N1WFNGL1NRQ2xzWXIw?=
 =?utf-8?B?dStyS2pnaHc1SWlpZHlCbkFnd0NrVkt3eWhXdEV5bW9YR2VWLzkrYS8vTE9n?=
 =?utf-8?B?dGpMS0dYd0doeSthQTU3T2lRSzZTSUo3RnRBTVdDRmpHeTgwTWJzS3lmSWhx?=
 =?utf-8?B?alVpUTB4d2M5QlBrUWxZUHVRMlNvUjBFQXM5ZmF5enFrM2ZCVHlWalFMUmtU?=
 =?utf-8?B?S1VtTmI4NGQzYW4rNTBTOWlzYWFULzlMZmxzLzZha0JoNndKNXVlWjNmaklj?=
 =?utf-8?B?azc3SlREekI1Zno1cllraTlFU0JsOGVJN2V5cm50RnhxVk5HRm1KS3BhTmxq?=
 =?utf-8?B?cGtsckU1MnR6L3B0MHplcEl5TTdOWnlxVFEyOUdyb2VaNi9aMlhZdVpObnEz?=
 =?utf-8?B?Y1hHdnJDMnVVUFF6djVOZlJVYjlpWjJXMmxsUk5QMUQvU2w1N2ZxTUhvVFR3?=
 =?utf-8?B?Q0pWVlhvQjFnYzc2OXpiQUVTdUJ3Vm56YXNHL0cxUkM0Y3NrVWFpbzExMndz?=
 =?utf-8?B?ZkNNMS9YV2F3cmN5V1pjMUsxNlpURnlBQnZyQWlHS3YyaHMyTmdUQzZ1TFh4?=
 =?utf-8?B?cFRxYXp4WEFqODZFTndycVBmQ2R2c2NycTZuSm14eFBOa3FkNWM5QVdzNEl6?=
 =?utf-8?B?T1BlQzB2ZHRxRkZmM0xEQThqbUxaOEg1TktBSS90SHZRTFFLc09CUDZxMkdU?=
 =?utf-8?B?eE9GRGZoZE1HdjZwYmovK3R4MGJlNnJvN1cwTTQyeE5xZlFsYUlBRkJwWFR6?=
 =?utf-8?B?YmorQkNQckkwUmJuZlJHTzNXb3p3M3VEZWpiOE5aS3ViTldnYW4zRmxKcEdM?=
 =?utf-8?B?aVR6d3Vza3BWTEtOSFZQMGZoOW94a0w1bDhieTkwbzZMQnZnWURiVFIwK05B?=
 =?utf-8?B?NC8zdmJFU3JicGkrOVozNGJnLzFOWjQrMkwwUDR4QlVJMWRYTTFVYlJsczU3?=
 =?utf-8?B?VHl5L2ZjbVVKVWRENmtNcTlmVW9YVzdvWlhPSVJEb3Y3TnVUWm50aDcxamVh?=
 =?utf-8?B?UG90NkNkc2dWZzZFd0tta3ZsckhkbHdYMFRZcXhGZVVCUFFGaGdLVlRZQlZN?=
 =?utf-8?B?M05RUFpKV3pwZ1ZPdjRyUFZCOUV4WWtIa3grZHNsaHpGNTJPWVlZdDV5K2R4?=
 =?utf-8?B?TjVSeHN6My9wbVo0cktQU056eHBTNUdTS2p4RmNlYmFHWHR1YjlpUHdJeEZ5?=
 =?utf-8?B?TkgzajBkcFFQTVk4NUhHNkFMM2pHUVlXUHBOSkcyNDlNWTZNSEFjYlNmYi8y?=
 =?utf-8?B?Wno2Q2E0QVAzdW0zSVA5RUlsdWgyc2Erd2dsb2NsenRkYjB0VWFvT3JoVHRo?=
 =?utf-8?B?Z3lCdzFQTXQvcm16NUpHS3JFeGV5QXpIdlFCMCt0Y2JzeUozRVVZSGRDUy91?=
 =?utf-8?B?eXRQVUh5SmMvemI5WGttclRsaXFYdnlvUzk5UzhkaVVaZEJad01HTDArdFhI?=
 =?utf-8?B?b1BWUXZkUEc3ZnY1SFBXNEdLb2l6N05CSmJUUS9NaHRiNTRwRTJSODQrTEcy?=
 =?utf-8?B?b3dmdkticmhHYU1qb0UwS2w3UXJNWFJHN09CVEErV3RMTVBNeEREVWFNc01i?=
 =?utf-8?B?K09VZjFWMGRxOW96NVRiYnBSbzNMbVgvU2ZLdG1zV1RBN2MydUI4U2oxRlJF?=
 =?utf-8?B?S2ROQXhmN2w4cjRhQWlsdFFxRGxsZDg1Skp1Y0RzeEd1bGlQcHUxU0ZTdmpi?=
 =?utf-8?B?cFJRTGV2SkUwY1RPdVJnMHVYMXhiYThhbEE3MkR0UWZCME1vZnFUTVc4eXlL?=
 =?utf-8?B?SE1TdzVheTR4TERheDY2ZjdJazhBOUgvR1BLcXQ0TmUrc0g4TjBCTDNUbndn?=
 =?utf-8?B?LzJxOUVsMzdRTmNxcDdIQVgwV3hOUXBtRWZqYnFzQmo3RnZBcWdSMFYveHE1?=
 =?utf-8?B?Zi9JOEhrZkF6cUxFTFZnVGxPNkVxVnF3TWI3Z2h2ZXptMXhRazNUL1VONFcz?=
 =?utf-8?Q?/KOtOLeFTog2NHMDFE3l7keHN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8296a74f-5314-426c-7538-08dd66fb3da6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 15:32:21.5157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8ZYjgahgpxjAhrX2VyQMpxWsZAzDuNkK+9VGURZZRodKuYGmnyH8xm/yYm0JcfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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



On 3/12/25 16:36, Mike Looijmans wrote:
> Allow config headers that include zynq-common.h to provide their own
> (distro) boot strategies. This is implemented by skipping the section
> when BOOT_ENV has already been defined.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v2:
> Avoid #ifdef nesting (as suggested by MS)
> 
>   include/configs/zynq-common.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
> index 37c77aa1611..7bf58d3b2f7 100644
> --- a/include/configs/zynq-common.h
> +++ b/include/configs/zynq-common.h
> @@ -46,7 +46,10 @@
>   
>   #ifdef CONFIG_XPL_BUILD
>   #define BOOTENV
> -#else
> +#endif
> +
> +/* Only use this section if no BOOTENV has been configured yet */
> +#ifndef BOOTENV
>   
>   #ifdef CONFIG_CMD_MMC
>   #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
> @@ -167,7 +170,8 @@
>   	BOOT_TARGET_DEVICES_DHCP(func)
>   
>   #include <config_distro_bootcmd.h>
> -#endif /* CONFIG_XPL_BUILD */
> +
> +#endif /* BOOTENV */
>   
>   /* Default environment */
>   #ifndef CFG_EXTRA_ENV_SETTINGS

Applied.
M
