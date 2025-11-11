Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10114CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B9D83FAA;
	Tue, 11 Nov 2025 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u5ZkBoXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1428334F; Tue, 11 Nov 2025 11:13:36 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82EF83B5D
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQOovVY5zqxXqZTs9/1XYSTUz/SIgjQ/vnrIA6KROLdnTfI7asMSbnNUgKsrkywipphemNY5QUths1YlbaDG9+Hf0POYt9LuBkt0ypPCcj/fCwoNSEgP0Q8JE3qC3zLfltNxzTcn2NE4RLrj0lwS67/1G5BkVX9VtF/7gx0CfAyXaP27NC9QiNfuZml3sppnUzuYFLrwu9tiZ79I+2A+CH7FEIfEHVqRSiqiiiCIddR+FUThJyfklKRlpFz9xPTpDuZBm2vvba9Ms1Gb0dnVPLZKYFD3Yyj1Mdht1Gg5Qz3cxTW+NJj7qmgJKdV57ZNn6mVF7r1CIhmsQP+v71otKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b44ZPks/pM2/gfv+qELns6JHVxJUqxsmdb3ufNWu4GM=;
 b=qFzrvQEAMzQIVEGZKwD9feHjRpqXSJgCA07qMb0SRMbA6BbSzf047WI/lwSBOXy7UE5uYiBgxmT5t7Ap4Ur4C2I5+//Jv+oyzBid/3FmFAWCEXXEVoVcXulTE/g49HuN+qEK3sVzS820jaCHNbxZ6DYYUJm4PZ8e8O9Ch0RgvjVCyvsqDxIMNknykTYjBUHHMOLOpp1nCgQO1B5aMmTGoBHXUTytigA3GQ8IpF8asGNttSfeMnXZ5/sfgtGVoGz+mBz4PPRebxrFVzv9Y4CAb5aenq6nIAhakUq01FxfuyVf5BXSHC+RxPQ8ddctD9uqfpj/b04UNFGjwboFwF+deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b44ZPks/pM2/gfv+qELns6JHVxJUqxsmdb3ufNWu4GM=;
 b=u5ZkBoXSXHjTR0kcebhuHpO2KB8Bj/rO9SpFDCbjhXIJ10OvVuFKYoFeLoPAri0e0f+T6Y57787w+fi/x+DzarpYJ2w0EN0Juix0LN5bk1H1GOcbQsiMYyzVRMjmmtvUGJDbJnFMLmuBusQRfktZ3J04Cxe7wLcaHin9sv9PFTI=
Received: from BYAPR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:e0::48)
 by DM3PPF2DE5834CD.namprd10.prod.outlook.com (2603:10b6:f:fc00::c14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:13:29 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::6b) by BYAPR05CA0107.outlook.office365.com
 (2603:10b6:a03:e0::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 10:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 10:13:28 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:13:23 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:13:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 04:13:18 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABADH06781407;
 Tue, 11 Nov 2025 04:13:18 -0600
Date: Tue, 11 Nov 2025 15:43:16 +0530
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
Subject: Re: [PATCH v5 04/13] firmware: ti_sci: Add
 TI_SCI_MSG_MIN_CONTEXT_RESTORE
Message-ID: <20251111101316.ubpvihokboro5gni@lcpd911>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
 <20251110-topic-am62-ioddr-v2025-04-rc1-v5-4-980ee0036c26@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-4-980ee0036c26@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DM3PPF2DE5834CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a9b47d-b064-462d-0bfb-08de210af56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5mykEHQzul3YuXyaPunFiLDV+4ue7NU+ovbu1+XsarSOYjeCaalukcTm/rqM?=
 =?us-ascii?Q?qT8Vdzs7lmHBuRFLT3fOKAf4onSPYZvsLgH9ZhCoA1hDvxgWdgtc+gEvUhIt?=
 =?us-ascii?Q?BfvaYZmezjY05rh5xfdGlEjA/zvO1UlmRcs0ANimPeTRB5hlOZdR0gJvWST7?=
 =?us-ascii?Q?6UkuYMXCrJz3/bupm17YCEjDtooMu/ipHDp16D1t5AHQcMXwcxxwnfJgOkrB?=
 =?us-ascii?Q?K4IQezQXrWzw6QOB6+bR8LlPcqpYgTOkWd3aelDlLexnMmcIrPviMvsJmjpb?=
 =?us-ascii?Q?asUoTlbNW/skWoDCH8Ep5KA2rjXYr8nntU0Hs8pF6o8ijvet0bVL6d995Y2B?=
 =?us-ascii?Q?vNwdj0pKfqq6sVwKHWsRP/p70CQquE5VZ6Y2guG6m9BYIg7IvKyVL/fyWzCp?=
 =?us-ascii?Q?1lceq6O4UqMkTZK/1kqiEofsB09AurRB/gL7zSCOG8d9IQGFpYgI2ZC7fW5q?=
 =?us-ascii?Q?x0hrHB/0MAi+8GhaOgI3PUWcBJd/s/uxtQjbZJQKD7ttZH8uZFFgL4DoaMnm?=
 =?us-ascii?Q?CIb5DwQZT48stSw1ygfGnmeLB40e3yHPV8ORXzkE75aNGU17ry1AsqQR33V3?=
 =?us-ascii?Q?zDoU4kwpW1cOi+NMzOt9pwUr3jshUTqxYiCBttaxyxa8rgvl0lqtlLmBYVP4?=
 =?us-ascii?Q?yNUHlkNty1PI5ZjRDKz63+b8ltmss4lPn0cfgpuq1bqenZHxfkawTYhmmEkm?=
 =?us-ascii?Q?Oj117giTVbksm5fwPd6zmJtZNO4lNMEazrOZeSJVpLFfJnAZJ1X34H6ibUsO?=
 =?us-ascii?Q?MtiKuIFUy208YpmfjarSWerHn0c05UWDGaUEs07kWi21xXQoEXogKLRmfx+R?=
 =?us-ascii?Q?d5kyPGbYtLqp1upA2KPNHzXNmERSXRGwqt5R1CMO84DKhuifyN3A5ZKFKoen?=
 =?us-ascii?Q?s0br9vEFCnR3pdH3wZy3WybteVWnQiXE8TfvDromkuqGc4AdIBnicBVPWJip?=
 =?us-ascii?Q?2uucPHXeQ1elJrHRNX/IPsCGFoqJIFKQYXDHwGLqjShPsnOpwHdrQty6t3VD?=
 =?us-ascii?Q?a2IJcvE3VxuB7iKFJJXfsBAVuh9BV3Jvfa21saS0su5uYb6eFWJ1LCQdEguk?=
 =?us-ascii?Q?immad/3/lGDXI4DCGIOsNaJLhXwzRaoBvB4H48WYGXujSDL4bWB+n9TQEyqD?=
 =?us-ascii?Q?Ko2dZJR4lkmfu60hoz8OGUC4Cndu9/109vMPLnSPcJ0TAMPx/ayNurcfniDq?=
 =?us-ascii?Q?I7SY4LwnuvHH9aX7TI0oI/jJ8cM1gOwy98TS8jYD3oqk53LbwOozHjanL2Uf?=
 =?us-ascii?Q?ls/0lcrL46JcmkrtntQd/Hzcib1PNI9EDAR7gkT5rqMsPJlYl5nHXVP/J36N?=
 =?us-ascii?Q?aVS19/YnivPB+JvuANr3kaLyZvUxQSil/fRcP2dCl9koXlxOCeioqIm4V4De?=
 =?us-ascii?Q?lwPEraekUebfUHnJzu23qpdoW6St3Bw5zI9FPqL0yiRX+AcEmcyBx2VhJue7?=
 =?us-ascii?Q?/BwrcRhDYOyRo3DWQl/dsYVnhaBl/IcVkCikMvgYYAnXKMsbm55RUS2J4c0i?=
 =?us-ascii?Q?IqOhu8x86wD3yIoIt1xfb369E6XAb/Zo3oV2V21yh/noYRwZBku1bewx5DsF?=
 =?us-ascii?Q?Js8wMIITNqp6YP70N4w=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:13:28.3237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a9b47d-b064-462d-0bfb-08de210af56a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2DE5834CD
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

On Nov 10, 2025 at 21:10:28 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> This patch adds code to be able to call TI_SCI_MSG_MIN_CONTEXT_RESTORE.
> The context needs to be restored after booting SPL when resuming from
> IO+DDR.
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
>  drivers/firmware/ti_sci.h              | 16 ++++++++++++++
>  include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
>  3 files changed, 63 insertions(+)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
