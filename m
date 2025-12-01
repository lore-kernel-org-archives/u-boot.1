Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5797CD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D8683D52;
	Mon,  1 Dec 2025 19:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oN0eN83s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0242683D52; Mon,  1 Dec 2025 19:56:58 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6196483D4A
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0yOqpL4WPSiockGb92pcYYRBGXyHr95Jmv0U9KEmbXT3IsiznDnsPLaNL5oQS2rNxSr8ETtGVP0/xwzDcYMoo71Gr+7XMyxAWOjFjux4OMczMQOOReUC+cWJu7HkYjQfOinRa1W8KfQ637LH5di1joRMb1LI47BvaalCC9AGwokAPG0NiUHx8dZ3bCEJz8maBgJFkHxskGCdZKHzZqCrujRLq3zzQWt/QUD9tuF6hvE62cGZnTf3DvoZMpoxmSwSYZiLHRK50akv3YVzK1Sfyq/7lKApxnM2psFFcO4jJGLrUuveqIl3kC4qfbPFdw8CN5yrAEipL+AkpuuVdzGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIvJCtjt4nwmkFFzP6XS0hPt1Ys1J6ywAZxmDIsxZYY=;
 b=F6VaMp/qbmKGDwXqi11Tg3I9EIu+n0sFw2Mfe568w0gJv8nUPNxBbzFZVhDZK1nOXVDEnzorGz0pOoiYN7ssN0xmaqHZFkGMONrWuptYaQnItJU3GMUkSp8vfw2x1/grMTnqqcobVJaqPOyOy1Rb6AuiyHUgSnCH4k/jRb3nFqz5MUqhhXxYfyuOzUjJwwFebCAFGMbMMCDn1JEshT8SdH+65LZJUAMUGdr6glx7BWAgb1YSl1PX9BmI+1IzwVpbCXM9NzMVUF3xIksRA4SH2bQffXKgK5D0Ftf9mv9TfKBASiIouGhL3gimZvB+fFBxKtb1+zVMzzP88FVZ3O7+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIvJCtjt4nwmkFFzP6XS0hPt1Ys1J6ywAZxmDIsxZYY=;
 b=oN0eN83sFc4RWuhHxEuZVNO8lw7nfwBVfntoVZB+CaZ7h6XAtIV4avaaCaiiLWIowTr3RkLDWI26NWlQXu6LlTxcZKndP25dDupG4E2KsmJ7cWkOMQVd6jCpPSfenm5m2SCKyC+W5EhEO5/OI0KTNV4cnGMoACC7mXC4WFG1VbU=
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:56:51 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::1b) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 18:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 18:56:48 +0000
Received: from DFLE100.ent.ti.com (10.64.6.21) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Mon, 1 Dec
 2025 12:56:47 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Dec 2025 12:56:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 12:56:47 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1Iulic930659;
 Mon, 1 Dec 2025 12:56:47 -0600
Message-ID: <18753087-67c2-416f-904a-12788991a0e1@ti.com>
Date: Mon, 1 Dec 2025 12:56:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am335x_hs_evm_spi_defconfig: Remove duplicate
 symbols
To: Tom Rini <trini@konsulko.com>, Markus Schneider-Pargmann <msp@baylibre.com>
CC: <u-boot@lists.denx.de>
References: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
 <20251126202925.GU2125796@bill-the-cat>
 <DEJR900FXLVU.1GCOQ4964FVP4@baylibre.com>
 <20251128140627.GY2125796@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251128140627.GY2125796@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5dc29b-adbb-491b-7670-08de310b6196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzBmTWZ5aGNvMGxQa2NvMDZtdHFXVWFOV1dyRUh1MUpkL0JEZjRvSE5qOFRO?=
 =?utf-8?B?UVFYa0dQd1NXUS9wTWpCWDY5aEUxTzEwdHBSZ2dJTGNHRUFYTFM4cnBjcVlr?=
 =?utf-8?B?eFI2eVNEcjZLUGQrUTRTVloyS1FHbWRuMWNqMW1Lc1dxbDlWb3V6SkkvYmtX?=
 =?utf-8?B?dDEvbXlIMUx5bFdIbWw4OGF2VWwybW9icmtvd0k2dithNzdLQWNwR2lqZUpR?=
 =?utf-8?B?S1VjeU54UldmbzhPcXBOdlBPMmlCelZEaWVkMUVVVHdnNzlXdm1uNmx5ekU1?=
 =?utf-8?B?VnZmOUN6UXE0SWVBN3RLN2VVczJyUHlOMmJFUktrVm9yU2RZS05zaEUxSnk1?=
 =?utf-8?B?TkNSZDMvOCtJNnhSLzVQRG1PVStQb3VKNm9Uc0FqU2F2U1YwNmN4SjRNak9s?=
 =?utf-8?B?UHA2YkQ0cnlTVjhEZTNvd2wyWThhWjZUQnZFMmZSWVB0WVJPZmJ3VFk4dlBU?=
 =?utf-8?B?SXZNaUFDclBoZjFIejVTRXA1Z1VMQ2R0L1VFNTVIbWt1c1VRdStndTR0bWFa?=
 =?utf-8?B?UHJQcFhuQ2NsZXNWNzZ0SGhNeVlWd1dQN1FGMHdsWWQ2MmJZSHBjeG96Y2Ri?=
 =?utf-8?B?VW1OeUtSNlFPQW1qVVYvV0xWUVpVaTFaOXdOTURVVEw2ZjRqNEsyckVzaUw3?=
 =?utf-8?B?WmlqaVpPOU5jd2xwNTZYZ1R2elh3VUNxY2FUNU04M25BRitmWUxuWFhMNjZm?=
 =?utf-8?B?YXhjdlhwRXBLOWxPZE9ob1lIWjF5d281NUdNci9nOVduQ1lOdHJTbytvWlFt?=
 =?utf-8?B?eWRmeFd5RGtiaks3ZFJUT3FPUDgvR0tvelZtOUd4TXZGVUNxdnA2dWUxclQ2?=
 =?utf-8?B?TUJHRUhYWjZFVmorN1dReE44cGNxdEk2bXkybVpXSlRsNW5XWlVydjM3WHk3?=
 =?utf-8?B?MEhYSURhWVQyeG9PbDFWOVNCOEQzaDRBN3UvMkVuajlLb1FvdWVqUTVZbVNx?=
 =?utf-8?B?N0VhL0Z6NTA0b1FyakdRRVJreTF0L1JBTy9XUk93RnQxNVgvTjh0Ny9KWk9H?=
 =?utf-8?B?QytLd3BRWTE0elJQTWo2cHRJNGhaaE9WSE4zUk0zZFpMQjZDV0poaW10RXFC?=
 =?utf-8?B?WDFtVDRVUE5mUnVtRFN3MmVpUmVlb0xHVExEMFB4cVhYbGlvR1pWejdmbm5S?=
 =?utf-8?B?endDQWc2SGxWWW5NYkpoOGNKT3pRNDZnV08rbXY1ZWxMM3RXc0hIWVJ2TnZN?=
 =?utf-8?B?U0IyMkdzT1JhVDRLb3lMWnNWSTRNRmNYSzFTK1ZBdzJTQ0s0NDFCbG5lY1p2?=
 =?utf-8?B?anc2anh0RG1mazQ0U0gyWk1mTEk3ZGZGTXRzcUdUaGRtVmtnQ1V3amxBOWFh?=
 =?utf-8?B?SVJzbzVDK0Zkclk3aUFzTmtTRE5lWDM3elhSR2w1aEFFNFhiemJmWmFZVzVJ?=
 =?utf-8?B?R1U4WDVGVVhoSGNUenpCTFNkMGluWWUwM0JUd2tYdjBJbHpGM3Rmc25LVk9L?=
 =?utf-8?B?Q3RxN0RPL2h6cnlXalhkQjdtRkdOMFhaM0wrV2tGNmE1a1JQWXBNNlc5YVRR?=
 =?utf-8?B?OTUxRmg4aTA3NlMyTHBURGtISTB5OGtSTHlZYW03YlNpZVJBSWZpT3o2N2xU?=
 =?utf-8?B?dUtTZk9Od21mUDh1ZnU5V091SDl6Z3pDS1BCbWhqRGxzYlRPVVc3ZUxTVUhz?=
 =?utf-8?B?MXN3Q0ExWktSdDJWTE43SDBsd0tyU1E4WGdQcVNraWlLRXh2MDNtYURlT3dM?=
 =?utf-8?B?cFk1bUhCRkdTU1dHQjZONkJBT1hZMGh2K1pFOGVtSExBTDllWnFraDNnbDh2?=
 =?utf-8?B?RDhTYXk0ZEQwL25aMzdFQjl1VlZpMklKQmFqVnQ0cWZGMEwzc05DQis4VEpG?=
 =?utf-8?B?U2l0dDlDY0dVQU0zR1J2ODZIQUpFL2VJeGJjQ0VJUEpkUEM0Z0Q3d281Ly9h?=
 =?utf-8?B?ZkVYeEYzNWRJQW80MG1EcEpuTWEvUmhIbnNxY0p2VUpyVVlnaWl3bFkwdFEz?=
 =?utf-8?B?enlpbG1FbWlYWHROa29HMWZwRHRCSGhQeDJYRUgyU3poRFVSZzV3Yzl3dTBr?=
 =?utf-8?B?cytwSVRpemxXTTJjektGa0V5aG5pQUFvVFJDSlJJZEJNSWZHY1huOEt4K1lk?=
 =?utf-8?B?Z0tGOWoxY214VnVTVEpyTTBaajk5dk1GOGtIT2FPYzYvTmxUTmwzejdlRTA4?=
 =?utf-8?Q?43ng=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:56:48.3899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5dc29b-adbb-491b-7670-08de310b6196
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
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

On 11/28/25 8:06 AM, Tom Rini wrote:
> On Thu, Nov 27, 2025 at 09:21:22PM +0100, Markus Schneider-Pargmann wrote:
>> Hi Tom,
>>
>> On Wed Nov 26, 2025 at 9:29 PM CET, Tom Rini wrote:
>>> On Wed, Nov 26, 2025 at 09:25:56PM +0100, Markus Schneider-Pargmann (TI.com) wrote:
>>>> Remove symbols already present in the included file.
>>>>
>>>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>>>> ---
>>>>   configs/am335x_hs_evm_spi_defconfig | 3 ---
>>>>   1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/configs/am335x_hs_evm_spi_defconfig b/configs/am335x_hs_evm_spi_defconfig
>>>> index df009844defad13109adf2523580181b6ed6b5ca..ad1777f2bcb45bd2c8424011adc231f0e7d4ceee 100644
>>>> --- a/configs/am335x_hs_evm_spi_defconfig
>>>> +++ b/configs/am335x_hs_evm_spi_defconfig
>>>> @@ -1,8 +1,5 @@
>>>>   #include <configs/am335x_hs_evm_defconfig>
>>>>   
>>>> -CONFIG_ARM=y
>>>> -CONFIG_ARCH_OMAP2PLUS=y
>>>> -
>>>>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>>>   CONFIG_SPL_SPI_SUPPORT=y
>>>
>>> Did you confirm that buildman still works? That's usually the reason we
>>> have this kind of duplication, thanks.
>>
>> Thanks for the hint. I wasn't aware of buildman, but it looks good.
>>
>> I checked if buildman still works for it just now with this command:
>>
>>    tools/buildman/buildman am335x_hs_evm_spi
>>
>> This worked. I am currently not sure if this is everything that can
>> break with buildman?
> 
> Well hunh. We have, historically, needed some slight amount of
> duplication in defconfigs that use #include in order to make sure it was
> still parsed right by buildman, but it seems that's no longer true.
> Thanks for checking.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

Interesting, looks like the fix was

6bf74a2e0b3a ("buildman: Support #include files in defconfigs")

So now we can go clean this up in all the other defconfigs.

Andrew
