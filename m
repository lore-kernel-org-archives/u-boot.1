Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C81CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB9484664;
	Mon, 18 May 2026 12:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T6dv6Tkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6BCB8466F; Mon, 18 May 2026 12:09:04 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A1183FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP3y5jxgwQ2sMokpg2LohctVHSPANMAH+1ac2Ej1R0a33GEKIo9EXz6vy1H5ucJ3Ys92Y5Euc7SMgHuveJ+e8TjjVt/5ikccjFajBoinKX8FVrIj1SgAt+IQQ12C5fxWJWelZgOsfHI9rJ5bAIqGNVu8Cy02Jpi3M4pqgzI859p0orGJfquaYXppGS7HmxbU629ySb+bAzzODXgyervFEcANf4dTEEKXWHvAM5Imk86Jingl49Qdc+xIhChaqfU2uVSyzXg5e+agFV8T0/svvNJ0+qxGcILFt51UmSUg+QFSp+EAvxdR2Ej+uSg6nusUW4ocxfxwNKcEjQMF8FPb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X2Wjsje6cyb1tL+0j258sWAjMe5zuybHcJ9zWXItoY=;
 b=LSsrQ+OswOmEU7cEh2DohcJgDsbt+gH6HkX8hpuuW0wdrAfn0sZS2GPI+oVuIyMm8ABq+nLJHQxxPlSe+9xyPmrXeh6f3GkfRfF7jxPZ8vZ/r6HG+eRecPVrf/sHXLatRRbL7ePZJfsTid1ufhbG0XB5KomP8vEe2vzGQ0oxEQXLiERHcvtiOVYr44Hk59Ta+TPj/Wm2tFyuPVR1h2lAW3lEu+Xhb7YzocYlSvga19wikv5iczFOhOXFNsyCscbbaHV35J0QNLop4YUlIf8852kaaDsbzecQ01M+Xlv0TAJ1Xkm7B+6VQNHhNX29xWS2b0DpHxXR7bOyWmStGFgJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X2Wjsje6cyb1tL+0j258sWAjMe5zuybHcJ9zWXItoY=;
 b=T6dv6TknJhaJug6jrhio/+AAQlqOoQ2jP7z8Os+8u0PRy7wmytbwAJq9wdgFK3DivZuCXSuhUshnPaoiCOSIqMf180Z2jMKre2IAM1HHhbbjh+baj7UyRu74Mu21vjvDx/th1pdYDGD2XHNHCQMfH8EVhFCw1DdlyR+DslvDICo=
Received: from MN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:208:530::31)
 by IA1PR10MB5921.namprd10.prod.outlook.com (2603:10b6:208:3d7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 10:08:57 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:530:cafe::76) by MN0PR02CA0020.outlook.office365.com
 (2603:10b6:208:530::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 10:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 10:08:57 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 05:08:56 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 05:08:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 05:08:55 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64IA8soN1655309;
 Mon, 18 May 2026 05:08:55 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 May 2026 15:38:54 +0530
Message-ID: <DILPXRDLFPM0.1YN1BKZR69L95@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Dhruva Gole
 <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan Vankar
 <c-vankar@ti.com>
Subject: Re: [PATCH master] mach-k3: enable mmu after reserved memory is
 unmapped
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
 <CAC_iWjJHnzfgMThnUnzd=s_21wndWX57pinNMoq9As+e_TSOOQ@mail.gmail.com>
 <DILOQEO4WE9D.AVK6J4D35NY4@ti.com>
 <CAC_iWjJ9qhN8an2Z=J6+7-N+wPQ31gPAimBSEdHGLkiU5BR_NQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJ9qhN8an2Z=J6+7-N+wPQ31gPAimBSEdHGLkiU5BR_NQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|IA1PR10MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2784a6-82f8-4f29-78d9-08deb4c57982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|4143699003|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: 2xdjk32Jc0LS5OJHvFgGYN4gpBTlk/CGOgg22VKWvqBeQ/0APRanVfi5x2qK3Q+NwsddUEm+IsgdnL6Xie/gE7X2cDm07imBLpAlOg2hnFQ3aFf6isEPDHNj/9U2MkZGKTrxD/aojUmbo1tuRw5d4PDFSJPE36dujxegRkbfy1gX1jXtThVE7gclSPtbQf/CYAErvj99PnYJE7qQ5Vr9mG0nU1qb0i5szy+I/SwWJtj/K49gbdJBRrsKbOeg31XO4hyU06NPH9U2eJBGgnm/ZcZt6t6uLrl+4suDHQ4a0wkOR4p/vtbzdxJ2jhGwcdJrFFfPMWfT0cF1JUfKZso/uh3HlqYAkGpeVNofvoIRSLww5x19GOzH89VIKuboAh8J6dDowzkq+rI3RM7/vDzQgaHIEUdIE8KrxFH28hZb1bQ1+GmORcqnKERU4eEferrawBMWxYEvdhRoa8mPmOJdG0fO6Q8cmzIf5sdc/CRrNbOvQiZHqU05eQnpP0reEFOtAKqGkUCaFDAWtnxPJ9LGgvkVuj8WCCGrvUrqMHzcH96Plg6IqGZbePEpk9MZp6iaYsQQUBQBNNQqd17maUM6w/nbIQOCH87+UxKYZ7xhBY9ogf64ymtmkMcxWEj2exM+7xqhgp334RqH60u/bdEy4ZTnb2Ky9iKHrA8zdMTglmjL4DoKgy14harFdfxdDlSttBDCgxrym7/ByWvBgb1Rh5gM+701lAXXNdJAk3jitac=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(4143699003)(56012099003)(22082099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6G1OzRx8LxIGO31cjWfytJAXYnQ82HTEJR0vtMN6YwOm26uH+A3GlnmZSGscoMoNG6a6T2EsGZKelKJMNQ8Pe++2GdLb/FfLGyJO/edjx1dI7h12g3p8sZS12jp5CgtoMvXCh79UKykKeLwNfkEkxdeKv1lRvXGOPI/7I1c2ofsoZ7bhArm215HW8glzTjJKAKQW1T8EkXywbgEvWFilMBys3VPd2cyslyxxTTLkt9lPzsBA3L8u7Lm7pT7M/pX1vemZ+BgikrH/NQguhlYbK+CamjvCLPUa0gc/6aCls+kNrMqCqCbA8EGrDPwcXHD1wOhhFtNLR9HTQgFmF1PJEq1Liu2UluZVgSHW0hzsSlrG3rirqpmL5etJXw8h1UZXm6nEg9ZkkOXFiU7iV78U5J3qhMjdXr0ASrc8lbBUIPJP6ZX1dV9M5qI7R7Z/84CX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:08:57.2197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2784a6-82f8-4f29-78d9-08deb4c57982
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5921
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

On Mon May 18, 2026 at 3:18 PM IST, Ilias Apalodimas wrote:
> On Mon, 18 May 2026 at 12:12, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> On Mon May 18, 2026 at 1:34 PM IST, Ilias Apalodimas wrote:
>> > Hi Anshul
>> >
>> > On Tue, 12 May 2026 at 14:03, Anshul Dalal <anshuld@ti.com> wrote:
>> >>
>> >> Currently the sequence to enable caches for the A53/A72 core on K3
>> >> devices looks as follows:
>> >>
>> >>  1. Map entire DDR banks
>> >>  2. Setup page tables and enable MMU (done by mmu_setup)
>> >>  3. Unmap reserved-memory regions
>> >>  4. Enable caches
>> >>
>> >> However there is a brief period of execution between #2 and #3 where =
the
>> >> core can issue speculative accesses to the entire DDR space (includin=
g
>> >> the reserved-memory regions) despite the caches being disabled.
>> >
>> > This is indeed a problem and the fix looks correct.
>> > What worries me though is that the mmu is common across v8 boards. Is
>> > there a way to generalize this instead of adding per board variants?
>> >
>>
>> I think the issue here is that mmu_setup does two things, first it sets
>> up the page tables and then it enables the MMU right after that.
>>
>> We could modify mmu_setup so that it only does the former as follows:
>>
>>         --- a/arch/arm/cpu/armv8/cache_v8.c
>>         +++ b/arch/arm/cpu/armv8/cache_v8.c
>>         @@ -801,20 +801,20 @@ static void setup_all_pgtables(void)
>>          /* to activate the MMU we need to set up virtual memory */
>>          __weak void mmu_setup(void)
>>          {
>>                 int el;
>>
>>         +       /* disable the mmu */
>>         +       set_sctlr(get_sctlr() & ~CR_M);
>>         +
>>                 /* Set up page tables only once */
>>                 if (!gd->arch.tlb_fillptr)
>>                         setup_all_pgtables();
>>
>>                 el =3D current_el();
>>                 set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, N=
ULL),
>>                                   MEMORY_ATTRIBUTES);
>>         -
>>         -       /* enable the mmu */
>>         -       set_sctlr(get_sctlr() | CR_M);
>>          }
>>
>> Then we can have an `mmu_enable` to explicitly enable the MMU:
>>
>>         void mmu_enable(void) {
>>                 /* enable the mmu */
>>                 set_sctlr(get_sctlr() | CR_M);
>>         }
>
> Ok that sounds reasonable. I greped for mmu_setup() and
> dcache_enable(), but I can't estimate how intrusive this is going to
> be to include all v8 boards.
>

From what I can see, mach-k3 is the only user that explicitly calls
default mmu_setup whereas others just override the weak definition.

I'll test the next revision on several K3 boards and post the fix.

Thanks!

>> >
>> >>
>> >> A firewall exception is triggered whenever such speculative access is
>> >> made to secure DDR region of TFA or OP-TEE. This patch fixes the issu=
e
>> >> by re-ordering the sequence as follows:
>> >>
>> >>  1. Map entire DDR banks
>> >>  2. Setup page tables
>> >>  3. Unmap reserved-memory regions
>> >>  4. Enable MMU
>> >>  5. Enable caches
>> >>
>> >> Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_=
banks")
>> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> >> ---
>>
>> [snip]

