Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A40D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 12:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADACF82FC7;
	Tue,  9 Dec 2025 13:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sMYVW6/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CA183849; Tue,  9 Dec 2025 13:18:57 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC60380325
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 13:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3VlCwhgUI/aRp4oxSYfxIO85znGXc+mKy5WT2EEGZJvLG1A2yfduUlL7wUNA5vfaUbgmcJl9bxnH9wmvbLyLKFsO6/hRygcaiJ1eBPhi+KO1SCe8fh16Sq/OAwbz5/cMB/89whHDnzZpZHuS8hh87VoeVld9s7OizYcHHG6oUB8F5+sAMLV3335M9Ou8qxH1b5n6AD0ofKZBVApbXrpD3GbC3nzHMzIIIkfGO8dtkfrlL0/hNLkq4r+k5HdXTINcYadkRI6U65dSbWnxRZmNToNxVFQf6M8zF3WvvJgSlZyw3qQTQpF7llPiM2areGkeo9MsDSYp3Gni/UQycGVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbz4wDwEwwT+1WwbLUYTyPPxrGu9vBv+VjqsXKO08cU=;
 b=xd8LGONGkx4MC8/33fYEC1mkpzZw7Kw874GrXbByzXe5QKATrc7aDA2AGSVGzQ93kN1XqBWfboKnDJbXNXY/fo27czYTSVr6ezh5iWLsf7Kmm4N5ys0H/jHITR0EfSANcxI9mACAwG63m1p8WakOYQwF8SCRRUGTo3ySvQbACjwb0Ks3H34V9JHNZW/ygPoqJZhw6sFykHGuZ8UCxZP7ew29fn5JluS8cD/2S9E6Q2sKRDV9QTVlofDQqsMC2661YaLmHBOxHgxZFLsQhkYscr71r+009bzlTUlmMyznDHqq/LbkCWUR73Yuk3ulXUle8QNOAW5NkFfM/7BS/gyO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbz4wDwEwwT+1WwbLUYTyPPxrGu9vBv+VjqsXKO08cU=;
 b=sMYVW6/oik3bp09rAqoSSRpW/rrGzB48hC00OQ0ZhYWMWIPreGx8unesOX+fo+CKnN2t5e+7lnxHHRwh023eGhaUwayP2H0aDlK8eEbPWpKH/5eK1rgFwNJm3ebxeZRDuR3VlB9ZW/DqAip9M36a4Co8QMRXvoSS/2G/JTPltSU=
Received: from PH7PR10CA0003.namprd10.prod.outlook.com (2603:10b6:510:23d::24)
 by CH4PR10MB8003.namprd10.prod.outlook.com (2603:10b6:610:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 12:18:50 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::e9) by PH7PR10CA0003.outlook.office365.com
 (2603:10b6:510:23d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 12:18:49 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:18:46 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:18:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 06:18:46 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B9CIkjB1162312;
 Tue, 9 Dec 2025 06:18:46 -0600
Date: Tue, 9 Dec 2025 06:18:46 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] doc: board: ti: k3: Fix a couple small typos
Message-ID: <20251209121846.4kmfpkkzv4puzhs6@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251208191623.2246534-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251208191623.2246534-1-afd@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH4PR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 04010c04-dadf-42a7-646d-08de371d1bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDkwcXJmODRYa2Z1YVRLVDVVRXJqTXFOKyt0NWpRYzhvZ1FkTEtqTTllcDRJ?=
 =?utf-8?B?TzdtTlp5b21lZWVYMXA3WWdiTHZvKzBjTzl0VUFYYkgxU2wrQnNaM2xxSHRD?=
 =?utf-8?B?OVRsQzlRNHBXQUNjTGsxN0tCZnBmeEZkakM1TlRNVjk2cUpvTFc3SGphVVFX?=
 =?utf-8?B?YzIzVFIraWtSZVlzVjBESU1EaEU1UUNtS28ySWFwaXc1NHROWkdPNStyQi9w?=
 =?utf-8?B?MGhPcDJrcFdVU21WSHhMeCtIWldjUGFMUTkvZGZzcndqSCtCUzJUbVVKZVRI?=
 =?utf-8?B?K1BxNFAzZEhLVEhqaU1ZUFBrQmlVWjU2eXZNaVBPSUNFUEhkZmdFVUN2WmRB?=
 =?utf-8?B?aUtUeVp1NmVuZUhBL05xMDVWbk92YzVJQk5tWUJxWkFOR1YrWEI5YjZoWWdh?=
 =?utf-8?B?bERPNG9nb1prMC9DaHdHNjJhYUlWT2RDcXJiTEJ0OWNJVXdLL1BUVDZjZ1RD?=
 =?utf-8?B?eXJUVXF4d0loY0dWS2hjQkw3T1N1QzFqMkRDdEF4RWpEWXFvN2w5OEZ6anRu?=
 =?utf-8?B?T0tDRjhKODJsUkR6Lzlma3o5Vi96Zzc3NGlkQ25sbEJ3WHV0aEZSWVNUSlV0?=
 =?utf-8?B?YmdtODhaNDZyVkVYdFdXL0wvY2k5dzlhUG5adXByNU92SnRKZDJ1WWdTNXcv?=
 =?utf-8?B?azZDRGdka0FLdVJveUdyM2tPbzVlRDNiQzNrSC9BZFQzUFVlaVBLRCtLbEo3?=
 =?utf-8?B?dVovSlAwL3pLUjkrTGtHbEJHcUhLODdiRU9uOGFLcnp4NHNKZjV4VGlwbkRS?=
 =?utf-8?B?SkZTZmJMb3pHUE0yNEIxSDk3Szd5WDRVeGpINWNwQ2I4WDVqUHVPWDRUQVVm?=
 =?utf-8?B?aDllM0lIZmVlQS9rYlFITUVFSlJtb2xkOUI0WGdLVFNMQ1JucXRldGZySjZl?=
 =?utf-8?B?WjBYNkl1eURDZHFWK3cxbWxvTzBPZDlHZ2ZrREw4YnRkcnEyb1lucm12SGZl?=
 =?utf-8?B?bkJ4Wnp5VGZOR044SWduL3NPcnQrR3NONFNxOUUwU0RyWGYraEdnMmR4c3Y1?=
 =?utf-8?B?N0dWRm1tS0ppRFBTdEllbmdva25RS2dlL3kwR1NEeHVub3dUUFU3L2ExcWZS?=
 =?utf-8?B?UDJkQzNZOXh6L2F1QkRjWE4zZlZtMG41emt1cDl1dzBKc21XOGU4MUdFTm1m?=
 =?utf-8?B?RVQ2amV6dzY0L0V0dWd1YVN3MXhxT2U3cVMzNEczbkp6WjJhZk5FWUszUHFJ?=
 =?utf-8?B?UWVNblpFUzVhNUxXMzE5QklielRkUkZOZnNWbE1qcWZMS1NpYk1ZT1ZrWkV2?=
 =?utf-8?B?bUNKQnJ5Z3BSVU4wT1RmUGlhcWFvc21UOTlJLzhOclczeVZhZCs5ZWxoSjdu?=
 =?utf-8?B?OEc3Y3JIcHdDMWtoSE9WTnU5T2JrWTZoQlpsZUs1RS9wTXY2VnVjb3F3ZlFu?=
 =?utf-8?B?ZWRsYnVjLzdIbVNpcnZjQis4VWY2a2szUnhiVTZYMTJ6YlQ3UEhjb0d0Sm03?=
 =?utf-8?B?KzNmOG5OVnNkUUpJWTNTYi81eG0yeUJZT1EwUXhuSXcxeUhxcVppNXY3cEpu?=
 =?utf-8?B?eUJXUEZSaWtIN0NTalNtZzdQVmlDYnFqbHBRRVFhNHU4VEo4MlBYMGx4WmRF?=
 =?utf-8?B?RllSWmlBR1B1NFpOblZXYmdzVWl3SW1zLzNXek9nc2NvZjJ0TmNobHI3SHFM?=
 =?utf-8?B?aTFvbEZBc0NZQUo0Zlg2MFdHanVCVXFEWXBPeHVVREt2aS9RL0J0QVZoT011?=
 =?utf-8?B?RUovenRZaXRWLzlCVkE1QVVIUk93MjczUmpwUU9IVG9EMmlZN3dHUENtT2xr?=
 =?utf-8?B?eENwSy9xTjB6TWxDTG5SenhaVzhkTVVWZ242cjZUMGl2eHk5a2pROGJYWU9C?=
 =?utf-8?B?MDdSVVpnVnR2eThJZk04aTNSaXdEN1htZXU3L2xxMCs5QnFvWGJLMUg3Qjdq?=
 =?utf-8?B?QmtESEZ0WHJ4S29PeVhJaExNczJIbEJWUEw4ZVJCS3p5RzFTUnFZYmVBc1JL?=
 =?utf-8?B?bVdTSG5qMDBrOVVldnZtWEZxUnpZSkJMUG5XYW5mNDAzcy9vS3Ewb0ZNK3Y3?=
 =?utf-8?B?ODFBaDl3ZmlQbnVDMnZRbUtXUGdidjd5Yk14a3Q2NDkva2YxWERubW04SXBs?=
 =?utf-8?B?MlhyUXVZV0VZOVoxSGJjQjFIcWlLVDB6M0lEb2tXYllUYzRWWjgyZ1lFOFVa?=
 =?utf-8?Q?kut8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:18:49.3055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04010c04-dadf-42a7-646d-08de371d1bce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8003
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

On December  8, 2025 thus sayeth Andrew Davis:
> s/Uenv.txt/uEnv.txt
> s/then/than
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  doc/board/ti/k3.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 37a66b3c69d..913cdd7d09e 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -653,9 +653,9 @@ Refer (:ref:`U-boot ARMV8 build <k3_rst_include_start_build_steps_uboot>`)
>  Saving environment
>  ------------------
>  
> -SAVEENV is disabled by default and for the new flow uses Uenv.txt as the default
> -way for saving the environments. This has been done as Uenv.txt is more granular
> -then the saveenv command and can be used across various bootmodes too.
> +SAVEENV is disabled by default and for the new flow uses uEnv.txt as the default
> +way for saving the environments. This has been done as uEnv.txt is more granular
> +than the saveenv command and can be used across various bootmodes too.

Nice!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
