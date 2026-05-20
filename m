Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A157FCD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 02:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D0E84874;
	Wed, 20 May 2026 04:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uuu6pvu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDB184877; Wed, 20 May 2026 04:49:17 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF2D84868
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 04:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlngnWjJa8Y0x6ykPdODy8GOkt5iApvoWUBhXt43tFymm2KLEFd0xgqKO76+jWTK5VEfyk86sn/0muWPwgfEoyOSjevDAZCtk8eI9foNxh8fbnfVRM0RZMDX6wWOXpClvJAx6ckaCOt/8pJ94XYyhyeZA4MIDz7wjLHNZX8Nk8c6QOVrJz0+mBZxHFpDEwwPYdDuciBn4L1SCpINdDL2D3XgtqPRNINSFsS+xyKKK9WZEgw7knhRmzmQWABXitSA2bBQ8pyZhvkdo38+Rb5azATRieYrj6aIOk3b2z2PMFQ6qixiuzk1pBXBRUyyTRPUPQvBYerZntcEUmse9LGvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOvGIDa1mn6+YHEbYpzjJ+nKP5aEEVmkE+GdkSQu7mE=;
 b=AQ/hvyB5z3spupHraUJ93JIgDlvGKepesXJq/75P9DcmFqhD2rPZxUTAvS4APIMAncrRAhWoNw25a3eLJ/tiHrjI6r1nSuiE02PQ2b9YHlOUEYssdnSJ6lZ2uABVFCcSQBnd6vUWiCP6KfdAUDU7aVIiHKHMIlcd0RVku8pryvnMhoue62ntLmJLpAlp+lDLWdlHwJKtoFG9rS9OinL+aaTSzC77FUijByN1TIYyE31LwKIq4EUfeiXcmWIBXmeMs7pUDvUrH1y2HqJJiQL0v/p59WiI0Ppj9g7JpbLxnLCBrq8rz6Jj2nazPHbT9kDb1L894C4vlKMVBiSyCq+MzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOvGIDa1mn6+YHEbYpzjJ+nKP5aEEVmkE+GdkSQu7mE=;
 b=uuu6pvu8XFeJZSKaxyNS7EZwLuwU8bFnTbj0Ds3tyhG0mb8OiEa0foyM3A95kWpPmRH1O62Rzw9l6Cfx7LvNH9IzYzVC8DoqrWGybQzPDbT05bDmXrnRT/dSTS7odF/mPlKGNoThhi6GnO58lsgmWFpc9eK80RnoAyD7A1f5W/8=
Received: from SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29)
 by CH3PR10MB7714.namprd10.prod.outlook.com (2603:10b6:610:1ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Wed, 20 May
 2026 02:49:11 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::33) by SJ0PR05CA0024.outlook.office365.com
 (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Wed, 20
 May 2026 02:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:49:10 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:49:05 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:49:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 21:49:04 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K2n3EZ1095638;
 Tue, 19 May 2026 21:49:04 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 May 2026 08:19:03 +0530
Message-ID: <DIN5U2PYT2TT.16DG62YDI67ZB@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Mark Kettenis
 <kettenis@openbsd.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 "Moteen Shah" <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Suhaas Joshi
 <s-joshi@ti.com>
Subject: Re: [PATCH master v2 2/2] mach-k3: enable mmu after reserved memory
 is unmapped
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
 <20260518-am62_firewall_exception_fix-v2-2-bd6e816ec23d@ti.com>
 <CAC_iWjJ6ajFbAC-nppHdwhj66uRsGY5-YAam-3mmzdM+6qhEmg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ6ajFbAC-nppHdwhj66uRsGY5-YAam-3mmzdM+6qhEmg@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CH3PR10MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: d5746950-1a30-4007-8c21-08deb61a5eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: dKI9oGAQvaZJ009yDMvLBP6QYyzr+0fAluUZBabCw/cPlYJw5EEf3HICazzW9oqu9otTWnmJ75E5HLo/oMt807gp6fzDZDLOosvWTllZBl5mki/lrcHQMXIpFSSzGvW7cFnOHMyCa/iULMYw7t8RBTQKMsPRuzNwd37Y9u5XkM6Aeqsu9qaAcL81n8FWwwboBVKYi8zt+iGURJmMgiowtj4UyMdui3oz5vY2Z9sQ03VGoFPAMxRJl3d/eUvyBcHu11YE83pM1Sr0MEjaVljxi8U0+pjgx7FwItdMReEE2wcwAp0I3tvHFoZ1LXYXeH7G3gYJnhZJLQE2Ye6qkC90fx/p8ZUQR1mpKPshv/fc0B136tgkMyHe6Wr+jt0x+0KP0oBxR/rciP/HjFpaFOIbSQlioysUUBVNmpKO83u2wIJ3kUOpxxcm+lcO50YzyT8tMt4o0uwwR8P0B0ZA+jRT1GkvvnNGO5oiogeEgtfSwx1hMUKXCkTz//Tmd5NLJcqiQqG7jeCjA7Tc3yv1akCyylYciewu3BFaEPEXZxwQOnj5ADx+JY//MHD7Rd4irBGIwwzG2LPkqUFCMagqMQ1YE75fPj+aBHDehKHGwcgKONW+SQHmKdmO43OsZpYj2xtD6///X0tQd5t/7Thl8WSg3ZtcZULJG7uQ/fv7WbVkwOoRyA6reeVCa80Leb7aScifs/BQ5+N9wSwbGtCQwuWH+lHwKnV9o50n7EFjmpMs28M=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iQyXmMhqBImuv2GCT2V+SAhmUZxh6/JzWL4Oio9GTBRT5DYvQ6udBXYn8TdS2AYUzj6kj1YOx+kz+lW1tqDi5EegJHqVxmr2cubysfGjYa0z2pLVB2cZ4S+kPiM94sIH9F4o+cCg0JuzVbRxvBKiHWdDe1a6zj7zQJgw5MPvu2ya8moJ3KEhU4+cqkYFQbC9MW0d/4QHPwRHV2uWBBEmBUQull8XQU2udzniLWXWpal0Bgk/tuZRHXZpmW5zSUC32ihM/TiyEe5Ww6TM/q0Z8LVBbHn2YKgnlbDcIKCtOeZ9WOmh2uQaBmvtT0/BeZgaRoidS1PUL9j1Oq01ZK4HFsvgWrNP4sZ21+IfdUCpjElnJyn2oSrweUAHgzRnsOEmAISVTE8BJcQQs0mlxYPKSvRByFTyjhLbmmxr6Pj9rQAlt8jnQ/2afzJCONvrxvQd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:49:10.5740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5746950-1a30-4007-8c21-08deb61a5eae
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7714
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

On Wed May 20, 2026 at 12:16 AM IST, Ilias Apalodimas wrote:
> On Mon, 18 May 2026 at 14:54, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> Currently the sequence to enable caches for the A53/A72 core on K3
>> devices looks as follows:
>>
>>  1. Map entire DDR banks
>>  2. Setup page tables (done by mmu_setup)
>>  3. Enable MMU
>>  4. Unmap reserved-memory regions
>>  5. Enable caches
>>
>> However there is a brief period of execution between #3 and #4 where the
>> core can issue speculative accesses to the entire DDR space (including
>> the reserved-memory regions) despite the caches being disabled.
>>
>> A firewall exception is triggered whenever such speculative access is
>> made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
>> by re-ordering the sequence as follows:
>>
>>  1. Map entire DDR banks
>>  2. Setup page tables
>>  3. Unmap reserved-memory regions
>>  4. Enable MMU
>>  5. Enable caches
>>
>> Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_ban=
ks")
>> Reported-by: Suhaas Joshi <s-joshi@ti.com>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/mach-k3/common.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index 396018b7a7a..9bebc0b1106 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -295,6 +295,7 @@ void enable_caches(void)
>>                                __func__, ret);
>>         }
>>
>> +       mmu_enable();
>
> You added mm_enable() on the previous patch a few lines above. I
> assumed it was to keep the code changes confined to one patch without
> changing the behavior, but you have to remove it now. You can even
> skip it entirely since dcache_enable() will do it, but I don't mind
> having the explicit call.

I indeed meant to remove the mmu_enable call added earlier, will fix in
the next revision.

Thanks for the review,
Anshul

>
> Cheers
> /Ilias
>
>>         icache_enable();
>>         dcache_enable();
>>  }
>>
>> --
>> 2.53.0
>>

