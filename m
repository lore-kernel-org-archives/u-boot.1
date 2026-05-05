Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6CACD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 04:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6721F84669;
	Tue,  5 May 2026 06:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qy6w8jwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457428466E; Tue,  5 May 2026 06:28:15 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8426684664
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 06:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6v25l7yIV2kuttnk4vZ0VdjgoeFcHhPQgVUvJ6wlpVhojYIi8lsqpH7MZg7fA19o1VUuZxs7Nt4ezbJXnt9YKmPs4kyyBy1TVYmco031gyu9WMtmHSwGV4XjDlSVgA470iZ9HouL+zIGC27D6s2/D72cwPZ5YefzTpCOz8nMbJ3EyuY+UjldZ/E4kpUm2zPS9wCM47jEd8UZ84I4Q8seBG2rHFmUd95J3E5HdTwJnTHZXMqGvPbLtIexOncgJzrwE1hH25dJ0cL6wnYED3oN6yrUUfr8b3iYLccRxfUKzhOmWnC5PRIizjYdvQepTx59NRHIjubgu7QusISx6RecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW7OVMOJxa1bxk4aqOmLHqEFARotDrCk1xkPmNAcdPc=;
 b=lHX71XIQI4bhFrMdLPx3mFSszmxkWmvIq8e9rYtP0SyqxOS1+k0Wx0IaD545qoURt+LuMmfvxGBqf+tFy66A/aseD7dK6VWek1n1Pnz7/NjAbQco6SKjjGXGfQACdVxRX8365yzcfmurnXKlevR15P9iSaoc6c9pasaAlFmu+nr1RRAI8BVxkqzeeVWbk2+mlB/xvw+xE6GZ+oT2nzTt7lNXmjbbcboBaMt1lYekpE2p0O6pzHxMdO2jopXb2iNqX9UDtF/J5haRfTl2DpUKHowIhOyEQoHcGSnDybj9CYWaWsNcsNpSSozYepOWEzDgvEMIKy5OFLDnMfVUwk0SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW7OVMOJxa1bxk4aqOmLHqEFARotDrCk1xkPmNAcdPc=;
 b=Qy6w8jwYexrmxTR0laYujsteqgw1Bz8xFJ+LshBPnxF00h3jnvEQw15uvk2h3He4gezYqkq0rkGzklL8bp+RUCA77Z5mCz40MJnyu0qAwM0RGZL2UTzdcxt2WMQb71wARE4NXi9dLWfnOppmsuyD8bh1wlwV3oM2EeV0BL6/wiI=
Received: from DS2PEPF0000455A.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::513) by SA1PR10MB5824.namprd10.prod.outlook.com
 (2603:10b6:806:236::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 04:28:09 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1001:0:5) by DS2PEPF0000455A.outlook.office365.com
 (2603:10b6:f:fc00::513) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.6 via Frontend Transport; Tue, 5
 May 2026 04:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 04:28:08 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 23:28:08 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 23:28:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 23:28:08 -0500
Received: from [10.249.134.231] ([10.249.134.231])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6454S4pJ2179005;
 Mon, 4 May 2026 23:28:05 -0500
Message-ID: <ff9fe5bf-2564-4165-b5a8-7056806a3b99@ti.com>
Date: Tue, 5 May 2026 09:58:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: renesas: Add Cortex-M33 build option to R-Car
 Gen5
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube
 <mr.bossman075@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, "Paul
 Barker" <paul.barker.ct@bp.renesas.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tien Fong Chee <tien.fong.chee@altera.com>, "Tom
 Rini" <trini@konsulko.com>, <u-kumar1@ti.com>
References: <20260427011113.259065-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260427011113.259065-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d2cf40-32e5-426e-1bfb-08deaa5eb5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7u9cZosiybkwt1bOPylcIiyL9iJNbaNIH1inZ9A+uANhXqvmsevs5UI6nZo60gcFno2fMqpInal6RfLlzrjlSlGPFxeud8siU9ZnJ0yHGK8lQsqXdzP85bDwyG4TNugRyCPNL7bRDQn8bj/cBWhHEKkhjk29NBmL/jW9qDKLAnZuZfMG64eSI/XIvM8HVMKky8OSZhOV7LzT4zd4CbEHSbJMDpn53t1JSMw7KPjHNw5C2fgePq2Z+sPo88y8ntDLVlXfay2kGMvBH/mUp9dsOuZo4bzw/u5qgA6pwpJo+28GcphfVoZUcq1WHjgTJLZ0Fqu+eoJ++STeDGXj857HY7FkjRusMO2OG53wgFPli7Dmt0RYKZkhuGIKlu2mxcJO2bDUG3A84LKUoLcCL+sIw8eBU0rn4pT0VseUTQloSyIHXaTYeCcYOw6aY82lvtMMirtqg9GuL+WUuXQ7GTIopA2+v1uamzFnNgo1MPFIJL6uJyL9MkRyN1UqbBUCcX0SCf/XmrSmE1Knn77zwDO5rhGpK2uPCa+lohukhz8VpPCiDZHXsFzpoh43Z0weGifKudu4EhrD+F5dIU5Ypw1JU0O5eXHUigNleJ1qSf6R92bfre8oTcHPNYCmRkKzlTPDreVTZ3SxSelphiMgr4sM7B/g0qGz5wXmUDCvL/NQk1xTMiDvwtKV05op+rETrhXdcz1MEQoMHT2ek0tGAvLkiBEN1PaH/qynXZEjIIYGXZs=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ri/ghddYe89Px5Mox5Fxp1Rojuqe5rhIET2NCxXyajS2s/Mctv3a4ORX1sFt8wnEB2/s6Y1ca4/h1NMbE8twebomBwH4fwEdJLnptAnZx2KFPoRnCNp9ihxc3g+q0vWXTQmACKOTTPDi70ojI5ZHGebalgbqQa7OKr3Vt8zz2Tuf2IXrLDzze+6SIli3yxvA5qxNVcG8xlXVxMytBIgP5O7suWArtLxiW9G4B6r3faVei9/+1953cK+wt3wBvujcO1zi1y2e1xjH0fCUYimJT7XePibU6m0a5RJrDRh7HI228/VVAjIIm1E0IKjziPgJj+T8StrJLszRe6ZdoCNW5ahxEqODWaakooMVzDnkePlArgb62YxLbFv2+P7WlJF14M8puGhbb1Qv07W0V5t/mkGcI6cXiKEOtve/OfhfCq85qRmjm6t8NsfrKNV/MEvt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 04:28:08.7672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d2cf40-32e5-426e-1bfb-08deaa5eb5e7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
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



On 4/27/2026 6:40 AM, Marek Vasut wrote:
> The R-Car Gen5 SoCs contains Cortex-M33, Cortex-R52 and Cortex-A720AE
> cores. Add U-Boot build options for the Cortex-M33 core.
> 
> Since the Cortex-M33 core is a 32bit core, select V8M and ARM64 for
> RCAR64 accordingly. Select TMU timer on the 32bit core, where it is
> used instead of the ARMv8 timer. Adjust TMU timer base address to match
> the address map of the Cortex-M33 core. Disable unused OF_BOARD_SETUP
> as well as unavailable POSITION_INDEPENDENT configuration options.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Udit Kumar <u-kumar1@ti.com>
> Cc: u-boot@lists.denx.de
> ---

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> V2: - Move Kconfig defaults from common to Kconfig.rcar5
>     - Rename RCAR_64_CM to RCAR_64_RSIP
>     - Select TMU_TIMER in RCAR_64_RSIP
>     - Add R-Car Gen5 into RCAR_64 code comment
> V3: - Update RCAR_64 code comment
>     - Select TMU in RCAR_64_RSIP
> ---
>  arch/arm/mach-renesas/Kconfig                       | 12 ++++++++----
>  arch/arm/mach-renesas/Kconfig.rcar5                 | 11 +++++++++++
>  arch/arm/mach-renesas/include/mach/rcar-gen5-base.h |  6 ++++++
>  include/configs/rcar-gen5-common.h                  |  6 ++++++
>  4 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
> index fa4e312a4dd..f86acc31039 100644
> --- a/arch/arm/mach-renesas/Kconfig
> +++ b/arch/arm/mach-renesas/Kconfig
> @@ -1,15 +1,19 @@
>  if ARCH_RENESAS
> [..]
