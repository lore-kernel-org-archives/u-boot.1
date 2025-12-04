Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73860D1D89F
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 09:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF6F83C51;
	Thu,  4 Dec 2025 10:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oYtXB+Nt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26CA83CD2; Thu,  4 Dec 2025 10:35:57 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08E883C40
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 10:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOpKWndsKP1tL49awGgvwuHA5jKrJLvAYiid2MS9WOmzgu8f+H+ZObrz+GlniykfHP0g5GrZQspv3IzrKJKgjZL0nbAekDBFcfjd/KYKN0KmPLxkXaKyQAO1e2K9TIQX7+TINc5vOirzzh0eUXIRb8xJ+aj9Bwn6q79rXpM+146GtBnGNHpd99stW8Ztavy+p/rvAE0xkudCLqdGZOabtPRYParNIpla5YoCuASqfXGlZa+x+xZqvbqVuIlW2QR3eCB3mVnokUXRtqoXm/Gy93BuANv8dBFTNQuQoKX1IA1AzM28yA1c8azoBna1SUNkOjuVdNi+gB+jQIk++S7f2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXpt68UbYohCBqYSpoHheSn4LmAFfKIKRYg+VAt6YmM=;
 b=Uq7Bdhm0CTJz+9Wzf6YSjyItfMuheYV2dkgb2b7nflQ4FjOWbGHyR441esXzdxGFE9yUo0MT1MHicUcqPbo6JQxZeXKU57W44fPzFJD6/Inf2iFm0ni0sM9QT/harHrlvBDXasj8xrtfvcBO5Foc55gFARWQXWPC0OkpEuhj2u8lmBF5cgdNirxxXjMU6Gq9ra0gW+Uj+tGG8jl+GJe1wOGrpKDirTlGD4ATxNaIKreIgyrcaXbqJj47zsrJtR7DNG+A3oAtsb5TRAc2dGkwFNudZjusDW5lmwcsj+N6cXeAi7cBwP68LnlBQstLrS0A2kN7dwubxV/fIBJ8+NOCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXpt68UbYohCBqYSpoHheSn4LmAFfKIKRYg+VAt6YmM=;
 b=oYtXB+NtvYJX9VXEnhcT1GEaVxZtd8MpdCIGLrEws7+be7ipPx8aChI6gwfWSCLchjTOirQAl2Yx6r4j+CPwuD0U6+XdoJIS8te9RfQHmq6OxbmSsfEACruhkpvX9hIiGxpii3BR4Nq0lv97M5/soE0IE1V6zvFuYy6mSdSmpik=
Received: from PH8PR21CA0018.namprd21.prod.outlook.com (2603:10b6:510:2ce::8)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 09:35:46 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::56) by PH8PR21CA0018.outlook.office365.com
 (2603:10b6:510:2ce::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.1 via Frontend Transport; Thu, 4
 Dec 2025 09:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 09:35:44 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 03:35:42 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 03:35:42 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 03:35:42 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B49ZfCA1340801;
 Thu, 4 Dec 2025 03:35:41 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 4 Dec 2025 15:05:40 +0530
Message-ID: <DEPBWFGM21LL.1YE7UZ0TNKVQ1@ti.com>
CC: Tom Rini <trini@konsulko.com>, Judith Mendez <jm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>, "Christoph
 Niedermaier" <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH v2] configs: am65x_usbdfu: add
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251105-am65_dfu_fix-v2-1-ccada89d966d@ti.com>
 <31b4e016-379d-4637-8a02-896a897fc371@ti.com>
In-Reply-To: <31b4e016-379d-4637-8a02-896a897fc371@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH0PR10MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: b29981d0-f0b0-406e-68c4-08de33187fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmJtWlBTellxVHNQS3dlSWppR0VzRmgxenpMSWVzZHA3SWI3bFlzRS9ZK3Z1?=
 =?utf-8?B?QTFHTG10cG0xTGFtMmJjVU1tczcrTXJnQmZnRVZTdTVjdWo0MmJHNW50b1lR?=
 =?utf-8?B?SUVMTDhCZWdEaXgvVzNPcWxHYlBESWFhWm9BSjkvVFR6YUh2RnV5ZXBjUFJl?=
 =?utf-8?B?MjcrK094NUhtRDZ2VjlrNXRPMzA2MzJZZ00rQlZzcHFkRVRaTmQ1OUlnUlA1?=
 =?utf-8?B?blBEdEFtV002RmdyY000KzkwRDcycDhncFBDZlMyd3RpV3ovRHA0VlVZRUMw?=
 =?utf-8?B?Z2VRaXdQS3czNXVRQ1gySS83V0F4dFRxdkdtMHVaa3MwYWhOTHlVMWRLVXpy?=
 =?utf-8?B?TE01QmgwZkZNNXlpSVBNRUlCNitmUjRIb3R3dGVmOGhSRkF2d1ovVmxROEhx?=
 =?utf-8?B?SjNLcUd4Y2wzQXVsVnBNRnpPTU12Zzg5ZCtFempCbU01OTBIZWRQOWs5SjV6?=
 =?utf-8?B?ckIvcDZQUlFHNkM3NTNlWkVIZnh4ZUJNaWZkZFNnaGVIVFcvSkJvUmNSVG5l?=
 =?utf-8?B?TzM2Y1hIMmZ0YWdzSTVuV0g4UHVsb2VhL1IvUkpQbldUQk5Ka3NkNmxMUDBq?=
 =?utf-8?B?VmR3bHpIKzVPRUoraENoRWx4bHJhd0ZZb0Y2anN6M2kwc0FRNnY1c3MvRWYr?=
 =?utf-8?B?RjdJZXJiRUN1bWZtWTFMcEpRZnJKL2M3YjBlVU9LaWJ0Y08yWFVVNFNCQVh4?=
 =?utf-8?B?SXVFY214MStCUmtqUDdsSndHa3JzNzNrSUxpdnJmOE81Y0d5am1abG5hUW4v?=
 =?utf-8?B?Qno0bDcvTVoyWlJ1T0plaWxjenMvWHRST3JXRWlWdXIvRFdqNElSTGlmTjg1?=
 =?utf-8?B?b0UzMU5WK0pKZjRJQWNqd0diTVR4bHVjR2tVMmxlYmtmT2xESWh2ZGMrbE5p?=
 =?utf-8?B?ek44MFJvZnVvMXc4OUhPNDh1enBScVBvMTRwcE9veThsbUU4SDFxWnc1aDQ5?=
 =?utf-8?B?UThtNSs3TitZTmtTVlgzVGVPNGg2bzJROGlKUGZyVTVMRjc2Yk5uL3RTaldP?=
 =?utf-8?B?dVRKbGJJQVlNbXlxdFhyTE4xaFZzNVdPWGptSk8wQzdWcDREZ3ZVdEY1cFFn?=
 =?utf-8?B?VDRpelYyVHRsSTNLOWd2VFhUUkFjUkQxRW1JSy9wcDNJSjMzMnVYZENRNE1h?=
 =?utf-8?B?eVc4VHZJZXZPUmMvbmtjcmdzU1JhYzNhVXB3eldQcStFQ1BkcFN2a1laTTJQ?=
 =?utf-8?B?Y3F2a0tyR2IvanhnL1Mvc3pWdnR5L0tCNWtkaU80UVRweGs0bVMzRlpMVHNE?=
 =?utf-8?B?dTl3SVNpMzY2Qno4YWVLRUlNWVFEMVJ2dHJveDcvTWtUek1neWxTODBaeDF3?=
 =?utf-8?B?NldyU1FhNFJxOVAvRUNhMDdaNzBPblh4ZjVteG9pQmYxdWoxc0xueE5pcHJh?=
 =?utf-8?B?UzV3c1JFcnMxY0Q0WVhFZkpsTjJLcTNFREc3cnlSN2g2aUZab21jdlNocVRE?=
 =?utf-8?B?dnhYZUU2eVpEdmhQdStqNWFFWFNhNE5tRnhpZWw1amJVYVM2eDEzcEZlNXh2?=
 =?utf-8?B?ckdWUURKWmRIampTTHNCOWxtNjdyKzVzYllMNjlzVVc2ZFJsYkxsQndlaXVr?=
 =?utf-8?B?WUNMeUxGa2hmQnVRdzNNUXU1RE9tZDRKTmpOdWJsWmNoUVhPS0xnZjhJVG4r?=
 =?utf-8?B?YmhwU3l0SDNydlBwNGdjcFBYZ3ZuQkpRWFBGdnljdUFaakVWTGRoZUJZL1RV?=
 =?utf-8?B?QzAyWUtJbTdTQU55MkxEQk45VFZiaTZTQjhENldjRElLUWJLUklFc2F3amF2?=
 =?utf-8?B?dTlBVVUwMkVkTCtTNFNLaWVGbVhMY1RXdzFsOHFTdG5RbWQrSEwxVHBYZjdS?=
 =?utf-8?B?QWlyWmVxMzlCQ1FBcjVVU2Rkb3hSelFZa2gvbUdVWFFXOFVBNC9nMGF1MlNk?=
 =?utf-8?B?L0ZWNjRIRXkvSDhLRmhRRWVyWWVEY3E3OFlIZ0RaMUlYVVM0L2F0VG93aG9H?=
 =?utf-8?B?bWQxdWRlRzBLS3dtV0xGNVpVUm1jVEsrUitBN3hFOHRzZC9Kd0JMTVdUNFhX?=
 =?utf-8?B?SDh0ODd2TEJQZjlMbHFYd1ZoSmRqTUIzWWRDQmNBeUxvRWN0ZGNERGIrb2Jp?=
 =?utf-8?B?Ymc1eGMvcVIrekpCQ3BTRDJPL3VkQ0ZzTmRFK280MURzS29uN3V2WjhGR2tS?=
 =?utf-8?Q?RfbU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:35:44.8313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29981d0-f0b0-406e-68c4-08de33187fc5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
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

On Wed Nov 5, 2025 at 11:39 PM IST, Andrew Davis wrote:
> On 11/5/25 10:21 AM, Anshul Dalal wrote:
>> Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
>> with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
>> made mandatory in order to use %p which would earlier have defaulted to
>> a 'long' print.
>>=20
>> Without this config symbol, k3_sysfw_dfu_download fails to set the
>> correct value for the DFU string with:
>>=20
>>   sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
>>     CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);
>>=20
>> The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.
>>=20
>> Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for the
>> usbdfu defconfig.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>> Not sure if a 'Fixes' tag is appropriate here since the commit
>> 1e24e84db41a ("tiny-printf: Handle formatting of %p with an extra
>> Kconfig") did cause a regression though I think the problem existed with
>> the usage of "%p" with TINY_PRINTF set to begin with.
>
> So I do think this fix is valid, but it would be nice to not have to fix
> this in each defconfig that might fall into this trap. Instead is there
> some way to bake this into the Kconfig logic so that when K3, DFU, and
> USE_TINY_PRINTF are set, the SPL_USE_TINY_PRINTF_POINTER_SUPPORT symbol
> is also set automatically?
>
> Or better yet, since this looks to be specific to k3_sysfw_dfu_download()
> using 0x%p in a place where USE_TINY might be enabled we could just switc=
h
> to using 0x%x with a cast there.
>
> Although the best solution IMHO would be to fix 1e24e84db41a which
> doesn't seem right to me. We used to have it so TINY_PRINTF would
> simply fall though with %p and use the %x handling. The commit
> does point out that %pa / %pap would be wrong but it doesn't actually
> fix those anyway, just removes the ability for %p to work without
> that new flag..
>

I think handling it in the Kconfig might be the best way forwards
although I'm not opposed to fixing 1e24e84db41a to begin with.

SPL_USE_TINY_PRINTF_POINTER_SUPPORT only adds ~100 bytes to our SPL
size, if that's an acceptable increase we can enable it by default for
K3.

> Andrew
>
>> ---
>> Changes in v2:
>> - Remove unrelated changes
>> - Link to v1: https://lore.kernel.org/r/20251105-am65_dfu_fix-v1-1-acc29=
111dccf@ti.com
>> ---
>>   configs/am65x_evm_r5_usbdfu_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>> diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r=
5_usbdfu_defconfig
>> index f9161f1fe111ff97f7aa79f10b21c3b0ab1dad32..add03dce002b2abd913770cd=
836d2cd8c852ed5e 100644
>> --- a/configs/am65x_evm_r5_usbdfu_defconfig
>> +++ b/configs/am65x_evm_r5_usbdfu_defconfig
>> @@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x57000
>>   CONFIG_SPL_GPIO=3Dy
>>   CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>>   CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>> +CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=3Dy
>>   CONFIG_SOC_K3_AM654=3Dy
>>   CONFIG_K3_EARLY_CONS=3Dy
>>   CONFIG_TARGET_AM654_R5_EVM=3Dy
>>=20
>> ---
>> base-commit: 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2
>> change-id: 20251105-am65_dfu_fix-1144eec06b19
>>=20
>> Best regards,

