Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BECECCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE77C83F9A;
	Tue, 11 Nov 2025 14:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WLZJndjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B675A83B48; Tue, 11 Nov 2025 10:35:49 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D555839D6
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9qLPWbFT+U3ao0wISrXaDneBQVjkWeVFb8+ry3MtY/6KrL2rmRZTM10+G4s4hN4Numb6adlKrilqr99gopSY4zBU0Y66cif90c2EqRJhIrQMOyAqugUX1ex8vPSREQ+YRVnG2ktjOLHlNfMaCWygFjX2daC/n+fBZXRKgJlGtZub45h6HUjR+BFgRSDZfSHNtldBvsoo1XHeccPhth0ny0DjJ10Xa5Nf09hQ8TeZ5Bo5syrN3+iSHMqTwfxp3cW7nJbm4V+MWLVLZe7c0K56Pe9BhN/FBOwPX9bbjjk2KuJSjErDMOUssviYL8GYjA44gQjw5jwY9syNx1fgWRmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LewcD11ilJOSJUmOZ1yHZtcKWvnlSt71PtHvcTpkTGs=;
 b=oLRN9CmXMPhjew342dbBoJPWvvKH4dabf1yOUSs5HTDhNalLjAQd8Y7DW0gnEvFuQrLqD7zYM7pPVr2RpHI3Cw4e8nd+uEyquvHc6ywgh0FEbib75nfYeYlEFZqGNoSDL1U7dSGFCbwL79qOYt6pCR2NTE/I3wLI+9+mQFRyqYmqwgPN/KzwwCpD5kNskvQDDICsZhgHZM7OkxsbIxYOpeWaP2qdvBiFkjThWZxJvdqdysYichmHxewvVS7cj3gWFzMnV/oNIA4IxNSPYdyvMn/DgaoDdJM3MRmuxXm7uGfTHIkpZiGDRJ1I9EMhm5zIYLqOlsAU2Bes01PxuVJt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LewcD11ilJOSJUmOZ1yHZtcKWvnlSt71PtHvcTpkTGs=;
 b=WLZJndjPmCBJyjeeg2CHQ1s7cQZZLCkroxg34omWZQOMdA2I1KuDxw5zOEt4NrOnNjv2QQx3rI6H1PjaBwHjjyWn4V7bhAeGsXo2YcV6GYxw3UtTE0stSKr93wOrX/wEUgtvjPbokpcD1LylS+zxs9hhNSTm1zTQ7kYM3rraqlc=
Received: from CH0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:610:e4::21)
 by BN0PR10MB4917.namprd10.prod.outlook.com (2603:10b6:408:116::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.14; Tue, 11 Nov
 2025 09:35:44 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::36) by CH0PR03CA0196.outlook.office365.com
 (2603:10b6:610:e4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 09:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 09:35:41 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:35:30 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:35:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 03:35:22 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB9ZLO1702396;
 Tue, 11 Nov 2025 03:35:22 -0600
Date: Tue, 11 Nov 2025 15:05:21 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
CC: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vishal Mahaveer
 <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Sebin Francis
 <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>,
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?utf-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 02/13] arm: mach-k3: Kconfig: Add symbols for IO+DDR
 Low Power Mode
Message-ID: <20251111093521.t7akjlekm7ouff4u@lcpd911>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
 <20251110-topic-am62-ioddr-v2025-04-rc1-v5-2-980ee0036c26@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-2-980ee0036c26@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BN0PR10MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 7911fea9-9707-45f5-eee8-08de2105ae57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9rBq1Zls9SiyIVUc9zkhwdEuCnL6n2LChANa1nUgjtqT/NF1eoE+9CUXarms?=
 =?us-ascii?Q?ovSWCAtwICVswL7cC/ihGu3uoeaaUdiiwh7x8mvkJQ5/jcK+3B2Zz7qSPdvV?=
 =?us-ascii?Q?y2iSLqH1sEMz+/ytzi5EIXVNayXYjfxPFHNjO0k0H9oHPR7wgvIeZp39YrJ1?=
 =?us-ascii?Q?yN+Ep6VhR9MhuVR10rHxTqoyfcdccNQKbRS+DViIYWJk0occYTqjoXZ6r37q?=
 =?us-ascii?Q?K0jUIO7VdBWYWiSnjaSwhSsJ+jHdvlWoBiMDoaMgvVVHT+vm7r4hc98vptEL?=
 =?us-ascii?Q?torInw+3pasYjiuDpT3j1wv3UH58a2VI464o3l7X0VbNWNcoYEuz0GqxRPUy?=
 =?us-ascii?Q?yj3rmNjXRezgHToNkaJ1eIg9culJnYzV4cwq6nZetTU1tQs/Xj2tH+9+1DYa?=
 =?us-ascii?Q?Cxbsg9GAFR2Ifx88CO6E+ndM7g1DSB8S1nQxFZJJ/j68fEfgJxVYR6AmTCjy?=
 =?us-ascii?Q?rVG5xNwS7Hv52kFVPrZPPbZyNdF1mZwyBlJjxy/MxE0pAIy/y5G3RP320Pb/?=
 =?us-ascii?Q?gCJ52gVbRtM2bgMHmE97s8ydFYWZdndMSC9qNC72dylSfltD86X8p5eKsuSL?=
 =?us-ascii?Q?sYpkwcnCY8h3cIUQ8UvHRvXMaEFupj3+1MlT4ATLvYO2iIEXZdLE6Ix9R5f5?=
 =?us-ascii?Q?nB3bdYWdX1symb9sSnCG49N2RLiISxobIxKIlPR/liHuGSfnEZc35J92HHWo?=
 =?us-ascii?Q?PsWv9YOC8eQnvohjBUUAJ1X6cojbax7BWvH+933FWuyRJU1NV3lPTK/QmNn1?=
 =?us-ascii?Q?ui9RvXo53ENRerUc8V+GVmzKhQFvVchCnREjmHdmUy/ncTZuPWQfQx24ZbQ/?=
 =?us-ascii?Q?PUo7ifyxbuKVtIlodoLcupT/53Jcl8GW0Fuvebs1poHUNT5EJf+TjZ6uuShq?=
 =?us-ascii?Q?551AZcmDFWerKvh2xNS6DyhEGfyr4eMcfemDmCn//9I/9dolp3ZO+0p4/+Gm?=
 =?us-ascii?Q?6kUOnM6nV4NJz7Wwxd3B12WzXBXuD2u8VFuTZ9lMlycJk4QSjp3zuG4vPlDQ?=
 =?us-ascii?Q?SOhU4zUah1ppF3sQZd0HcMvfIb12PhBEwVV7jCsHoJO5ctjba48/rtAeLywu?=
 =?us-ascii?Q?YIZ8af9QluIlLaPsSNJvR2xk6n4/q8Pw8qfA0kaBEY2+VzmlhCwP3vQLp717?=
 =?us-ascii?Q?dNln7Dy0sYrKUy13JMfqB2+DxStjQIl3j1vEpe5xJFBCXq1GScs0os/HG6Pr?=
 =?us-ascii?Q?uotGsrOxbPT282kj/u9T8A8Ge72vzpZ7cbg83gvDmq6TV0tn4d74fncLMfDG?=
 =?us-ascii?Q?JA7bHSEtbHF7Pzf8mGLiRL0AYnQxDTQ8+jUYWHfFVC5z3s5UmoWKzkk53VCd?=
 =?us-ascii?Q?DnNPWrURI0l3UjPGLRxKrkln0wvsggl72osT3rUsc9YKq07fejtW2dVwlbLl?=
 =?us-ascii?Q?XBoq8HBoNuitIe8gB35GVB7n51XmcCwIP0+VSboDUhIQPHq3jQD80lmviX2G?=
 =?us-ascii?Q?w/VD3AlrZfGT1MPMopvz2Is2/7267rV1Z1/NVkvv3fUrxrq7i8tCrMsWlpx2?=
 =?us-ascii?Q?T936n6lVT+3++BVZxNbiSWSmbHgmlQGu3cGNdi+KgPkB3ezEZ3b/zmYLSWCg?=
 =?us-ascii?Q?214P0cFwiqbkS1jGOVs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:35:41.5702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7911fea9-9707-45f5-eee8-08de2105ae57
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4917
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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

On Nov 10, 2025 at 21:10:26 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> There is one new symbol to enable support to resume from IO+DDR where
> the SoC is turned off and DDR is in self-refresh.
> 
> The other symbol is the address of a memory region to be used to store
> meta data. This has to be the same address as is used by the firmware.

$title and here as well, sorry but I am just a bit confused, what/where is the
other symbol?

> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  arch/arm/mach-k3/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 1b8c0b1eb968f0414107c0bf3142f744ce8364c8..4b7cef64935c7b403051c080eba7bdb48f727bf1 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -148,6 +148,14 @@ config K3_DM_FW
>  	  bootloader, it makes RM and PM services not being available
>  	  during R5 SPL execution time.
>  
> +config K3_IODDR

I see only 1 symbol - ie. this K3_IODDR throughout?

> +	bool "Enable IO+DDR Low Power Mode support"
> +	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
> +	help
> +	  Enable support for IO+DDR Low Power Mode. If this is enabled and a
> +	  resume from IO+DDR is detected, metadata in the DDR is used to
> +	  restore TIFS and resume DM.
> +
>  config K3_X509_SWRV
>  	int "SWRV for X509 certificate used for boot images"
>  	default 1
> 
> -- 
> 2.51.0
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
