Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D344D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 15:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D2984261;
	Thu,  8 Jan 2026 16:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lrsfBPga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9299C84144; Thu,  8 Jan 2026 16:51:44 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazhn150130000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d911::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1967884121
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 16:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv5r0yrps0vTuwk2LB5cvxL4evFtUYF4AoNLA3gpQUm3FPxuK0ZgViP76xnJ2B2KCbJeZKTOBs+K6B4b2eGfyT8O/1Qjrx7aKIE/zpMGgUdU++H2sZDD4k3SAm3AP5m8UYBJVEqymoG8AuBEtte5UtnLXfIFn+GhGia5nTMPm2jged0j1DlJfLn82T0CRNSTnloaBVw0voR7sJvehX29gzsV+XRH3Z1WFSKPbVKy+EtClhM2xJ/bcYJLYiyonoKfXccSVd4l+J8lNOg8+Jhy4VpHJxUKEUH+QkpfmU/soTfx8rUv9ePcorAcJhHjmQykz0RC3GD3FkWrHWHX0KACBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NCOFPd0hdctxl23J2dY34maWOg7q1vXKWKj9mI8UrM=;
 b=Urp8C2gTT5n58lDiGWfrULG0LedFW4yjOjg6zyFHEAxlJIPk7Vx6/CPiPNbwMLm8tJMY2t7cFY4PtXP2VQ1x+FXCDQfd/F9SSo9PD1wo+5yUhLiIfg1BvJUXjyCuIlw9BoSIFEjFMZXonsS7j4F3OrAEceYeBYOlLatOxtk3QWjfuwOlZnSXuZOAWjH/sJLhwwhy3OQK9JhaL4Z4dgjFMUMmtfiqnCzfqSkzDRTaj4nSV0vKmF+vk6YL5tXsqO7fcjFhHQzyrSzNH1CWh/ktkB6RnywebpmvTI+qo9QsHqbYJL+r22NkNncWb6KmuzpJdNNKFecz5wjtRz4J1CgbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NCOFPd0hdctxl23J2dY34maWOg7q1vXKWKj9mI8UrM=;
 b=lrsfBPga7FUW1LpWz9mGSdNDT6eVpc3x4zZFcO3Gug2yMGLUmPKEV1RcjWlzDJEz37WhlL78eHzor7TmTxzh+ECyvoxWcDg0bpPYCt4keEPhmjX/3b6aObNG6lRyPMpmn+rsd8UySjrSBINpwHXhkQSXK/D9h1dZtOQUwuNVcVw=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by SA2PR10MB4443.namprd10.prod.outlook.com (2603:10b6:806:11b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 15:51:37 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::cb) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 15:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 15:51:37 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 09:51:34 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 09:51:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 09:51:32 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608FpWSE2723914;
 Thu, 8 Jan 2026 09:51:32 -0600
Date: Thu, 8 Jan 2026 09:51:32 -0600
From: Bryan Brattlof <bb@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: Andrew Davis <afd@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Vishal
 Mahaveer" <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole
 <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, Kendall Willis
 <k-willis@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>,
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 "Udit Kumar" <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 "E Shattow" <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v9 07/13] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
Message-ID: <20260108155132.x6fcqc5zahftvcba@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
 <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
 <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
 <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
 <20260108143944.c3opoz57n6tyje7b@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108143944.c3opoz57n6tyje7b@bryanbrattlof.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA2PR10MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a764db6-2945-4fb7-f8e8-08de4ecdce77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|34020700016|82310400026|36860700013|34070700014|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q24zelcwcndLbnh1ZHUvNUhFaHh5WVMwTkNOT3ZPaGxRV0YyZ1F5TGdoaWps?=
 =?utf-8?B?c1Y5QnU0aThad2ZDYkN2dmduV1h2NWhYdUJaSCtYK3A3N0NCSGhNbldiYTZu?=
 =?utf-8?B?TTd5L3dJY2lEU3p6dlVSMGpuTlFsOVJuSHRwQllGOFhRSG5uWkljR2NEd0dh?=
 =?utf-8?B?M1FOMzhpdElIcE1tSGtjNUpoanpQWDlBMlgzTElpbXpVNDRjek52ZSsvZVZl?=
 =?utf-8?B?T3p6WGltZ0Z5MVY0bVdJREY5ZDN1NkhtY1F2L0xZbVY1a0ZsZGovM3Z6R1Q5?=
 =?utf-8?B?bmpTZjdmcnV3aUdOdjg1M0N5Tm4vL054UGppbk1jVjA0dlU5aHF5dTJEZHhz?=
 =?utf-8?B?eWYxRGo2WDAvak1ON3g2eFNjTUZoMXNWaDN1YWxRWTdlNCttTXFhVlZ6ODZo?=
 =?utf-8?B?NVYraWtPWW9xV2JTTlV1RmxqakJ4QmI0MDl0WUtMaVc1eW9GTmg2RzJoMjZT?=
 =?utf-8?B?TkZ3OHR6SjRHTU9Ha3dkYy84R0RaaGlRNzFWS29vNWxpOGMvQW5icTFrS3lJ?=
 =?utf-8?B?Zll3TXd6WmdFZDhJU1RYNTZIcFZCeEdSNWxPLzNYTllvdzhmNk4yMzBmQzQ1?=
 =?utf-8?B?bWlUOEtSUFloLy9oR2xBQ0I1OXdUNnFiai9CdFlHNzlyN3lFSjNrOHpYTlh1?=
 =?utf-8?B?NzZrMXQxOFRvQmFGcEppVjVqaHZoVGZGZHJEYmhkTjBRN3NPaUQxWTczS3BG?=
 =?utf-8?B?azhkMnN1VURQcUp0R3J1Um9GZkpOQnRJOUtGNkhGNmpPWndIUXFVZVB4UkJy?=
 =?utf-8?B?QkxPQlR5QzN4ZmtLcng5UGJtNm02czRIenVqc2JKZTlCQjZ1TDlkNlpuZUQx?=
 =?utf-8?B?a1loM2UyN1JEWHh6dHp6S3FPaE5Nc1FvZXVuQWRJNXFONFpSbXpWdWkyc0o1?=
 =?utf-8?B?S3p1enlIWUhTdWwxdnE4QnpOQWM2c1NJVlVKdDBxaUlnOFMvaU1RS0ZaTHVZ?=
 =?utf-8?B?WE1SQW51aVdEaHZ3UU83U09RaE1XQjZKQ0l1QlR1elFKckMxQTlKNnh0SWJR?=
 =?utf-8?B?K2w2UmNsbi9vRjNyTmx5Zm83SFJEYzROR1VMOU80K3BkcVhXSGJmZjZFU2oy?=
 =?utf-8?B?Sk5vd3dRY01VL3JOclFHRHBmbElkbTZRa25nQ0crZlhGWTZTaUFSMVp1b2xY?=
 =?utf-8?B?NWsxN1huZEtsUFJMVFNNdTJlUUNOKzZOTm91TXhYTU5yVXlNT2pOdWNoU2xn?=
 =?utf-8?B?N09mZGUzTTd3L0tFR3hXUjMwYjN6blp3bUxUeHp6WkhwVEZXQS8zOFhKSGNR?=
 =?utf-8?B?ejBFUjhoL3NNQ3BDajlvanhETjN1bkdnYyswTkZ3WWZRWmt0cTNuZnRvWHdN?=
 =?utf-8?B?MVVsUVJpUXhRSDBRS3dIMzZ1SmIwV3BtWlozMGYrNmM3eFBBcXE4RVo4c0Rk?=
 =?utf-8?B?ekpLZEYyMThzakJVR29WNEpEUmJBY1M4NnE2QktPc2ljajczMzJtMVV0dlhL?=
 =?utf-8?B?aU9mbVBhdlowTjkxY3l6OWN1dGtMdzJXOU5zQStxVzlKSWtyMk1qd3ZlWUd5?=
 =?utf-8?B?N2NFUGFKN0tlZ3krQmRXTkFNcWtHTi9ORWEwWEdVLzZ3TElxR0F0RGZSOURT?=
 =?utf-8?B?LzI0NjNST1ZFVkhGbDBseVRSL0hMQzhTVGZBeXdzaTBGQXFnaGRGazZ2dVU2?=
 =?utf-8?B?bTljM3hqNk1YUWNiTXJCSHNWS2g4RjdrVHFJeklrWU9VbE8zUm9CUDVlWUVV?=
 =?utf-8?B?TmNzY0tsUXVYWkpVR2NQN1dabCtBeTJObWdhVzdkaXF4UjREd0F5UlhTYkJM?=
 =?utf-8?B?c1B4Q1JnaUJZdk5MZnlDWTRtSW9ZTXMxbG5URjk3TlFBMnNsZGJ1RktjMHFa?=
 =?utf-8?B?RVFtTUZJakpsVk9hSWRUMXBvK0JEQStWRkpsLzJzOWVldWhETGtMQ29ybmxq?=
 =?utf-8?B?RnczTjN6VjdHQldqUVFqQUhlRC9USWdJMGcvQUxxOEhGbVpiUFdJMUhWYVl0?=
 =?utf-8?B?SkZlVE5pYTJXVjZ2NHZUeDErL3pHQTEvVjAyaVNOVDJSYmttRU0yQ3ZnRG1X?=
 =?utf-8?B?RnMwR3BvYVRacTlyWVBEWWNUUjVZQUZTbjVpUWxJckk4WjRCWTBJL3NoaUtv?=
 =?utf-8?B?S3lqNCtUcWFtN0lmMXNjS0hOMURaR0UrTWVkQ21kMWdMMTZMWkJJUHZqY1J5?=
 =?utf-8?Q?mMxGSRmUA5pthGMVh9d5P8Dcd?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(34020700016)(82310400026)(36860700013)(34070700014)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:51:37.1168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a764db6-2945-4fb7-f8e8-08de4ecdce77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4443
X-Mailman-Approved-At: Thu, 08 Jan 2026 16:58:06 +0100
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

On January  8, 2026 thus sayeth Bryan Brattlof:
> On January  8, 2026 thus sayeth Akashdeep Kaur:
> > Hi Andrew,
> > 
> > On 06/01/26 22:53, Andrew Davis wrote:
> > > On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
> > > > Add a small helper that uses memory regions referenced by the R5
> > > > devicetree node to calculate the LPM meta data address.
> > > > 
> > > > Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > > > ---
> > > >   arch/arm/mach-k3/am62xx-lpm-common.c | 45
> > > > ++++++++++++++++++++++++++ ++++++++++
> > > >   arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
> > > >   2 files changed, 46 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > b/arch/arm/mach-k3/ am62xx-lpm-common.c
> > > > index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e
> > > > 100644
> > > > --- a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > @@ -9,6 +9,8 @@
> > > >   #include <config.h>
> > > >   #include <asm/arch/hardware.h>
> > > >   #include <asm/io.h>
> > > > +#include <dm/of_access.h>
> > > > +#include <dm/ofnode.h>
> > > >   #include <linux/soc/ti/ti_sci_protocol.h>
> > > >   #include <vsprintf.h>
> > > >   #include <wait_bit.h>
> > > > @@ -48,6 +50,8 @@
> > > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT        0x18318
> > > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW        0x555555
> > > > +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET    0x108000
> > > > +
> > > 
> > > Could this offset into the R5's second reserved memory area change based
> > > on the firmware used? Actually this whole thing feels hacky. Why not
> > > just add the location to DT explicitly instead of trying to derive it.
> > 
> > The offset value of LPM Metadata in linker file will always be relative to
> > the position of DM's reserved memory region in DDR.
> > 
> > Reference: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L169
> > 
> 
> Does this work currently? Linux today doesn't have these properties in 
> the Wakup R5 node and from these linker files[0][2] they look hard coded 
> to addresses we do not have a carveout[1][3] for.
> 

I'm sorry I hit send a little to quickly. This is starting to make sense 
to me now. 

DDR and DDR_LPM_DATA is covered by wkup_r5fss0_core0_memory_region{}

and DDR_IPC_VRING_LINUX, DDR_IPC_RESOURCE_TABLE_LINUX, 
DDR_IPC_TRACE_LINUX is covered by wkup_r5fss0_core0_dma_memory_region{}

Can we use those nodes?

> If we haven't started on the Linux side it appears an easier path is 
> to put the carveout directly in the reserved-memory{} nodes or to put 
> the information into the board files and let U-Boot reserve the memory 
> during bootup.
> 
> Or at least some way to make this more flexible than this. This feels 
> very brittle.
> 
> [0] https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd#L173
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts#n47
> [2] https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L172
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> 
> > > 
> > > Actually, don't we pick this address as part of the
> > > TISCI_MSG_PREPARE_SLEEP?
> > 
> > This is not done as a part of PREPARE SLEEP message. As DM is the one
> > reserving static memory for LPM, it is already aware of the address where
> > context needs to be saved.
> 
> > 
> > > Or does DM do it now, either way there must be some better way to
> > > coordinate
> > > between DM and R5 SPL than hardcoded offsets..
> 
> +1 with the number of carveouts for DSP, VPAC, MCU firmware we have on 
> these SoCs juggling all the careouts for the different use cases and DDR 
> densities is going to become a problem.
> 
> ~Bryan
