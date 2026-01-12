Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A23D2502F
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 04:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB4C839AC;
	Mon, 12 Jan 2026 05:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="awQ0OdM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119DE83A1E; Mon, 12 Jan 2026 05:50:55 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8A08399B
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVo6wyt+b3DIGOKKtRar3EWLt+dSUQXiI/KwQ/6EcgONQmOmxSwawu/y5XIv0b81sHXc7Mc9krWU45r8p96Lpzx2Vi53y4ozi60pmWisPCgsebI/4QCeLLu4w1Tjt8bLGKCpGCevwloYi4qZSTKkevugydsrV2pOrQj1mFaSGqPvkQRn3lPykGbJZplwmrDeMryQBVXr3Zj6S80ikeSiUuf+W+iurlZu4ARxxEzW1TC/as4ZdHEKgjGgxqHExAhmFgWZ4WZBgNTv6NuuCB6d/+ShXTKyAzSzveqrxjSi3CrWV1/nk8Af+52Fqu1uuOS/BVGCd6rzm4oiNFNpGreIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jndv1YSmAJ3KrPHVmOBh4VoKK+MLUtTTeeZGyhblVs8=;
 b=Aut3c9o5T/KgsEpiCwKLCiddU+SbTumFrJToEaRlXUFVKpxsjOqJK0q00zg3URl8cqqbcwDQpuIw07Q+0Z3MlPe6A955/xv7UJ5d83PUNBwVoNNdp5WlQXUwnwuByC+X5pYgrrKhmF9Q+EGNEoiziiYxTrPk0ZYRv+e/8YWubK0KNYOtFswhe4FDdoB3Uqo2l7/Nzf2p8JXL64bz7EvYBzgHh5+FRQAXqtf3UkUgdMdAVGgosc4Y9WECdf3tluPWSfYm+c8l7+FyZ+xF57HkoITbo2samK9RNVZz6nNrxggn+CGIBUwtCPHmiakqEoReOJfAUw5oh4s+2lf2wCC1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jndv1YSmAJ3KrPHVmOBh4VoKK+MLUtTTeeZGyhblVs8=;
 b=awQ0OdM7p+Q0nJ9Omsf+zNmWc9A2+nbKhnOg05O+yIRgFY6JjXbY+nr1oy3Hy/QK8DGjChojH9z0DLALa+N54FhLpwLtBQpQ988GX/VKc/c8uzzxqJmGjwjgTcs6j/5XkjkYh5CQxdVBO7PfLQrTvLMkBVynlWE2mrEBqow2bBc=
Received: from BL1PR13CA0365.namprd13.prod.outlook.com (2603:10b6:208:2c0::10)
 by DM3PPF0900B6F69.namprd10.prod.outlook.com (2603:10b6:f:fc00::c07)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 04:50:47 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::75) by BL1PR13CA0365.outlook.office365.com
 (2603:10b6:208:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 04:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 04:50:46 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 22:32:28 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 22:32:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 22:32:28 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C4WRgv3934053;
 Sun, 11 Jan 2026 22:32:28 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jan 2026 10:02:27 +0530
Message-ID: <DFMBVIC7MI1V.2FQICY0TGLT2L@ti.com>
To: Mark Kettenis <kettenis@openbsd.org>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <anshuld@ti.com>,
 <d-gole@ti.com>, <casey.connolly@linaro.org>
Subject: Re: [PATCH] arm: armv8: Flush TLB before enabling MMU
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260110195610.42068-1-kettenis@openbsd.org>
In-Reply-To: <20260110195610.42068-1-kettenis@openbsd.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DM3PPF0900B6F69:EE_
X-MS-Office365-Filtering-Correlation-Id: 209d1d17-fa47-43d0-6705-08de51962654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34020700016|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2c0T3hENHdSRUFOMVBzMGxnVy9udUovakVxaUV1VWc5Nk5jckN3ODIzeER0?=
 =?utf-8?B?d01lc1A2Q242eTNkSytTN3kvbk5BMVErU2MvNlV3aWtkMVo3L0ZsRENTaFhV?=
 =?utf-8?B?T2V5aXhOSXdhWDhhcmIwcm9JQ3A5Sm5IS3JEdGJDeXpxWlo1MGQ3eWZaeUdS?=
 =?utf-8?B?VmlLR3NUY2QrU0F2RkM4N3cxR3dLSDVabFMwR1JFdnJzd255ZmdrWk9lSDl6?=
 =?utf-8?B?YzZ6QmR4UXFFekt1dnF0L2FnWU9nL2x2TWdwZ3BFalVDc3U5MWdpc2Q4NURO?=
 =?utf-8?B?SzNrdXRxVHR4cy9zZjJYZDM2cnBCNm04YnRTUHhBbVlhT2tOQ0kyZUg4SE96?=
 =?utf-8?B?QUxEVThxT0dVOGN0THVoT0d0aVVuTFNzNG9zQjBVZTBPVEF0RnErT1hvNW1y?=
 =?utf-8?B?TGRiNkd3MStEakJjVHRDSUJQejdnWDlNSGVWWHZrY2ExY3crWUY1dVd6ZmFo?=
 =?utf-8?B?czI5VkVtbzlrcFNXQ1ROZGxwTHVSUk00UFdUZ0FsclJRSCtsVE5YVGM0SkNE?=
 =?utf-8?B?ZE9XWUxwdUlnT3hwYnUwazFCQll2SVlUMDN4WWlDYTVFMlhPZkVjQnNHUWtu?=
 =?utf-8?B?Si9mREZobEN1dFhDTWk1dWRZOWZ4OWtDb3h1cDBRSCtLb2kzNDVJc0FBSCtw?=
 =?utf-8?B?MVc4TTQwcklCQzkxdGxvc25UMldrTlkwVUtNRnd0SWcvWGtqRUdTdGkrVTlo?=
 =?utf-8?B?ZlZRTlVJQ2RhRkhNRXZSaTJuejN0VGZYblRPT29kNjUwS3lGVUJ0Vy9LU3Bz?=
 =?utf-8?B?d203S2FsWU93bzF2V1hHVGtjamh3bGxITEFoUjcwbTR6eEtIazJsRXFidlVJ?=
 =?utf-8?B?VzZLNXZxd2pnUVNkbmpZMk5sc3hHWXU0dDc2TnNRWkJXMURNWTdFUU9QQW5m?=
 =?utf-8?B?L0p2ZzNzTGRoUm9vbEI3UWJKemIzR1ZQQVMwNWRITFh3VHJqWHAzYXA5UC9j?=
 =?utf-8?B?eXI3MXlBQjl4RHVGNU52U0VkZUd4VEs2R1QxdkVIRm8zT1RqMlFrMGJ6RTRK?=
 =?utf-8?B?TERWTVcwUWJRemJHWFRqc2ZmRlB1aFIwSGtBRWlKYmIzZVlZVlU3RDVSSldM?=
 =?utf-8?B?eFI0ZEozR1I1TmR1MDdWa2dLcGF4aEFWdzg1bmVLeTUxQTM1dERua08xZStX?=
 =?utf-8?B?dzFsWVhZV0VOTHRtaDJNekRoMXByOHVpOEpBRGVIbDRjb3NuR3ExckJFRmpQ?=
 =?utf-8?B?VGk5Sm9UMEVsUjJQUGRUOWNaczlGSmpGd0JWb2xHTXYvRzJja1ZZYWRqeDIr?=
 =?utf-8?B?RmRXN2Yyc0dUNUlZNGwxNU5xNzY1ZERBYW1mcUduYjNHM0VJbHJPZFVWcjFa?=
 =?utf-8?B?WXZjR2VoamVZaGs4cU1URWE5UExTYVBlcit4SGNiYWlPYzk2ZVRLUjhyNUcx?=
 =?utf-8?B?T21vUnE5SmUraVdzRWh4REZOWXV0WkozL2RUYUV0NnBFd20reTUzYm9LUzQy?=
 =?utf-8?B?QkJBMzRBU2JlblR0SFpOUS9Ic2NWRHJTZHFoeFpOem5lRyttTGdpUHcxb1lC?=
 =?utf-8?B?czZDaS9mMEErc2F0amdpVExZZFRxYTRYRW8vM0c1ZWtXVURxYVoycWF2Y3B3?=
 =?utf-8?B?d0VJQlVyVjJHRUFpemlVUHhxdXFaZEJpQm00dEZ4UFd6d1VZTDJ0bEZIUk5M?=
 =?utf-8?B?WjVEVnA3RTNoeC9rSFJyNWtOd1NNOTNLdURSVEM2UWNKR21jaEg1S012NWQ0?=
 =?utf-8?B?ejdIME44VHpNbVR5d3RSQmdhRU1DOHl1dUR1dStBZ2E2N2p4UFNDVi9DSFdx?=
 =?utf-8?B?VExwTnNRMDV0WUhlOUZGRDBNZGUxcW5wcldYWWFyZkdyMUcxeittMWlNYVd2?=
 =?utf-8?B?R2Nod243a0lnNkFVTG0wNmFrK3BPdUh5SVBLR0NjSFNBeHBkeVgrdURVWTZv?=
 =?utf-8?B?YmY5R1A0Z3BDRFNCTDFDaUtJMzRxenh1aHowSTdkUExnVjdIRmhsY1hTSlcr?=
 =?utf-8?B?YlJlUjI1U0hUbFI3aDd0Y3EvK3JFSzBsQ1ZDTGlmVjZjbURFVG1NbXkxRk9a?=
 =?utf-8?B?cUkzSGlXVHhMMXhrREU0djlIVy83VDRuQm1reDc1NFFlU2RPQWdZb1lxaTFL?=
 =?utf-8?B?eWxYazZKYXRuanMvUGtVWUhhbzVsbWVpTlc5K05HSVhqaUNpNlBVd3hGS2sv?=
 =?utf-8?Q?S1j8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34020700016)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 04:50:46.1991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209d1d17-fa47-43d0-6705-08de51962654
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0900B6F69
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

On Sun Jan 11, 2026 at 1:26 AM IST, Mark Kettenis wrote:
> Commit 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on
> dcache_enable") broke Apple Silicon machines in certain scenarios.
> If the MMU is currently not enabled we need to flush the TLB
> before we enable it to prevent stale TLB entries from becoming
> active again.  So move the __asm_invalidate_tlb_all() back
> immediately before the mmu_setup() call.
>
> Fixes: 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on dcache_ena=
ble")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.=
c
> index 0309da6d397..39479df7b21 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -878,15 +878,16 @@ void flush_dcache_range(unsigned long start, unsign=
ed long stop)
>  void dcache_enable(void)
>  {
>  	/* The data cache is not active unless the mmu is enabled */
> -	if (!mmu_status())
> +	if (!mmu_status()) {
> +		__asm_invalidate_tlb_all();
>  		mmu_setup();

So, if I understand correctly the problem is that the TLB is enabled by
mmu_setup which happened before we invalidated the existing TLB entries?

> +	}
> =20
>  	/* Set up page tables only once (it is done also by mmu_setup()) */
>  	if (!gd->arch.tlb_fillptr)
>  		setup_all_pgtables();
> =20
>  	invalidate_dcache_all();
> -	__asm_invalidate_tlb_all();
>  	set_sctlr(get_sctlr() | CR_C);
>  }
> =20

