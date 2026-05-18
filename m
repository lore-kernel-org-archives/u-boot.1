Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D07BCD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF9284676;
	Mon, 18 May 2026 11:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tvhlgNRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78ADB84683; Mon, 18 May 2026 11:12:27 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB8DF845E3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpQyZ0m5MXs+P1Nc5OkAFzixHWP6sF3iRHhsbjLhyvro7HgUP4dTCEHlfYiC196VZ9cqgdyXH+1IFiB4gEAhXbXtiwHlM5XgXD6NNJ0Oz3uGMT+KcJ/b7aSQVqvldXoxxaXzye/Lk2hUyLeEVSqevpEnGAeRPc2nYxMPa71BHi/hAIXoX/GQPH2Qiow9EPy+I+4dTB6r1VJeI+cBtx6ceSS25aiO/1vmNidBz381Q6k9ehvygpnInE4TNmWFY+IoStX0WbN03j7lbuowop4ghi/JyzTOeV6LmY0FZUvltj8YpWLkLI9sBAgkkyCr+ddNYayBDCExcIQf7R2BUwUzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vl7uO8tiS9QSWeNgR94utFYulnnHtvXKG0ntzmnO0o=;
 b=ixcl3kRZvzAn/ZgDz4E4JBsq3oeTwB+btxFn+mMCMZnRagEjc+5TV5S21GtcUC58Vvrd3eVaGvMkZRAe6BaWwz+t+1vwJHWuE7dFM//Iv60Nu7yXIRYwQU7UvYl6/+QxlgnoGRnsGlYRTouRDhNC/8MYf1bhAi+c8kVGusghrUqRK0p/yQlL1sKb3l1n3dXabIHDxK8ZB6qLHsCH4y8F/ZTulVn/Rgoi4SrHiUa3XvTOxx2Ba/HO2Y29C7CEcca5ADTilAtDlwwGm9gZYzgx6YhZ/KOjojymRsPrv86w4l/0r680ulcarVgUvVFD5UBwncmUDmbPFIlNpkwdR9qDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vl7uO8tiS9QSWeNgR94utFYulnnHtvXKG0ntzmnO0o=;
 b=tvhlgNRmT0zFe4dYhezKCqHD5NZpB8uiwpOuRVKS57l7c+w0ME1u6b+GOJRIFrOwRcpUJvEKdhi215ixMApwZO3MR/os6C4uyH4y2i3ymHXtmqrRw7af2SwSA5PtLMXQVaX5KMtIXARmg9wql6XNE38c4h22AhsrwLWeiGQDGk4=
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by IA0PR10MB7382.namprd10.prod.outlook.com (2603:10b6:208:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 09:12:19 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::54) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 09:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:12:19 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 04:12:18 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 04:12:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 04:12:18 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64I9CHwA1023534;
 Mon, 18 May 2026 04:12:18 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 May 2026 14:42:17 +0530
Message-ID: <DILOQEO4WE9D.AVK6J4D35NY4@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Dhruva Gole
 <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan Vankar
 <c-vankar@ti.com>
Subject: Re: [PATCH master] mach-k3: enable mmu after reserved memory is
 unmapped
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
 <CAC_iWjJHnzfgMThnUnzd=s_21wndWX57pinNMoq9As+e_TSOOQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJHnzfgMThnUnzd=s_21wndWX57pinNMoq9As+e_TSOOQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a0e277-b96f-491b-4145-08deb4bd9021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mtiNJobblT9XcKl23hMnKq21RZ9lHEHRaOlPGYg+aQPfpWgNo5bxR9rEVCGzMu0DJfiVthYwyRBbvK7NL2FUy55yrnHtNb4+sIlF1xLA+7wOArC11EfzX+PYjpMIcJ4/+gfQqvg2oSPg2kzZy/x0DXH73rsOgZXp8wtUFA6JE+hayBM0r5DfhRvvuj/4gEDLrQ2Lo9UgL+l7RNQR1FpszZEb4c2/zwBdGBVqNrZpPHZYBkP332KJxwweR7CkwtJLriwq2ckmmh5BYTWoq2znvrs8w6hXNjfdHHs8jm+laTmQEaVdyZRf3AfGG1GwhrA7ZoeOk+qUTju7mUexd6TFuOHSI+gtG4gU892DUNDDlrRs6GxzeWwxldrNuFXjFuWleT1oCpEM0hT6XzE+ucmQ1M+2RRXXyR4VEacOI4NsKJWWy/WA9F+ppcYCBt2ORO2QD6+6JLW8NBTDOk4syMY9F9GrtyGJM5fCZ51kTLv8IUgc1xur2koBB+QPMaJOttfhmaUywGGGvFybuA656nfVZORCTesNaojuAzC5IiniHOWq502U6OzpwF28OkwYlgTLmmDGREBD/7J+5Rz/wsKJ4uqnPx2gLPNZDbFUTIzs5S7+X1EsBMFv/oFQ16H1tS794p1Ooay1KqJnwdAoYUp2L/1ZAi9+Qj44SUmn/kaLPP/LBT9kiZv2/6b/5/vIk2WHNNLmaW5k/pz6iXpKPED8OcCK2UBg1csb+m1lbOSJ71k=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bFm84cnEyZHSyMqB+a1EzGbf3uOrXZaaz+YEsdH17ETgpaL+cdzwhTUbBfBOtx3VYI0LuUIVk3B9qAmvD+qzhgmaDgkZ3lNL7Q7fCvhjtsZoh0Rv0gDSJ7M4M4wCl/FRcfaozTvQFKUzQ7UALaHlM9mTLyp5oVG0f//D3DLrWzshYWB++96BIn23+nJHMYTZQWnVnn0cal/1eDzg596j8Wu0FQFh9l7dn2Nqv7uFlPXGXBNP2LIQt+DS3qd1XSBqhAodJcL8bUmEzbm39uw2DgGIh7nLY2icHS9D3tQEiILcSxc/0yIp9OBxg/gyk8U0Yh0i/m3i3QjnhIH0m3XhFkqED/JohRSUPdAjS6XanW0/9HLxfo4c1a+uK1XHQczHytrf2OSD+Fzli8VW7CSC7T48s6T9h91PdrnnJX0TcuwR/DrCHOkhWmfbk3XtQBKw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:12:19.2050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a0e277-b96f-491b-4145-08deb4bd9021
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7382
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

On Mon May 18, 2026 at 1:34 PM IST, Ilias Apalodimas wrote:
> Hi Anshul
>
> On Tue, 12 May 2026 at 14:03, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> Currently the sequence to enable caches for the A53/A72 core on K3
>> devices looks as follows:
>>
>>  1. Map entire DDR banks
>>  2. Setup page tables and enable MMU (done by mmu_setup)
>>  3. Unmap reserved-memory regions
>>  4. Enable caches
>>
>> However there is a brief period of execution between #2 and #3 where the
>> core can issue speculative accesses to the entire DDR space (including
>> the reserved-memory regions) despite the caches being disabled.
>
> This is indeed a problem and the fix looks correct.
> What worries me though is that the mmu is common across v8 boards. Is
> there a way to generalize this instead of adding per board variants?
>

I think the issue here is that mmu_setup does two things, first it sets
up the page tables and then it enables the MMU right after that.

We could modify mmu_setup so that it only does the former as follows:

	--- a/arch/arm/cpu/armv8/cache_v8.c
	+++ b/arch/arm/cpu/armv8/cache_v8.c
	@@ -801,20 +801,20 @@ static void setup_all_pgtables(void)
	 /* to activate the MMU we need to set up virtual memory */
	 __weak void mmu_setup(void)
	 {
		int el;

	+       /* disable the mmu */
	+       set_sctlr(get_sctlr() & ~CR_M);
	+
		/* Set up page tables only once */
		if (!gd->arch.tlb_fillptr)
			setup_all_pgtables();

		el =3D current_el();
		set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, NULL),
				  MEMORY_ATTRIBUTES);
	-
	-       /* enable the mmu */
	-       set_sctlr(get_sctlr() | CR_M);
	 }

Then we can have an `mmu_enable` to explicitly enable the MMU:

	void mmu_enable(void) {
		/* enable the mmu */
		set_sctlr(get_sctlr() | CR_M);
	}

Regards,
Anshul

>
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
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---

[snip]
