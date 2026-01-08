Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A0CD1D480
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A808415D;
	Thu,  8 Jan 2026 17:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QiVBb01k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D859C84181; Thu,  8 Jan 2026 17:27:23 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazhn150110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d90e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB3484150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQfr7SJhroeVpnL8i0rsagkyWZtn14MVV54JlCRnDAYa8MoPUligjjSMzujUDadI5bUcK6V693f8p+NcJ+trv8nCK85t4oxnltpB28AK707RvMhU2ImdZ9yPHp1QQHbr9PMpxpUKlvtbUAWciVRuZCjtrgohACNjtvSW8LWydp82bv7uAroEjQyBXQToeWAINOC2WxnlzTZC2tDEnAfcyq4VrH7Z6HVZZNCbdEsXCjO7lR2IXF7d3VIN7cc90EjFgQ6lpU/Hym8m2S1+E5g44Mnq8Zl4p0zTcca03Qo/3Emhq6xDfmuMHFpd0zsdV5rXLI28O6LUggs5NlMK2m2dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+PjXmp+fhZfS2Zv4MUK2Q076ftSUEk4rS+hMRp30Os=;
 b=rIjRl0zqwvbr7+IkikeRWS69Vj3FI0WvyoruioafAW6m/LmHPW4CqB1+++aLbZAAF4p0Jqdaenk8mQRnGLGjN+Oa9qCKHB/PsDtZ8QGiCzjpTyBhdH8KO3dg5c3JYehb7NSjAdE/3BhALPlao5IlftSLfSMxkf7ER9OZEN7PqIB/dSQvblvL4sSeBSHA68O4+CSTsd9qh2AzrMmiJmxvm8RWWWP7PuEezOlQzdp2K4o1Py9l45jkwF3FPRZP5DS7CsOeV1HAbV65E8z+8nwmOzA9UcOUiC8f8oF0OTxEOu57915VJ9QamjMu0TPLEyavQdXXgO91D6aa1N8pbvcGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+PjXmp+fhZfS2Zv4MUK2Q076ftSUEk4rS+hMRp30Os=;
 b=QiVBb01kff3jUmsawzuonLRwbQU5uLEPzyrI4+Lf7UxzUGZjlVQVlVyUOF59nyE+IUOz9CMH57drNqb3ClMWDFW6wl5Hb6Xo0wop0EfVuaJYS01K0Ue7Lknvwwf9tVPSIKJuY9y/iy/HevxWwFXBEBV3G+AnL/X/KhYurrhabIE=
Received: from SN7PR04CA0171.namprd04.prod.outlook.com (2603:10b6:806:125::26)
 by SA3PR10MB7023.namprd10.prod.outlook.com (2603:10b6:806:313::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:27:12 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::2) by SN7PR04CA0171.outlook.office365.com
 (2603:10b6:806:125::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 16:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 16:27:11 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 10:27:07 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 10:27:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 10:27:04 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608GR3QO2657861;
 Thu, 8 Jan 2026 10:27:04 -0600
Date: Thu, 8 Jan 2026 21:57:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Akashdeep Kaur <a-kaur@ti.com>, Andrew Davis <afd@ti.com>, "Markus
 Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman
 <khilman@baylibre.com>, Sebin Francis <sebin.francis@ti.com>, Kendall Willis
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
Message-ID: <20260108162703.ovogvs6xcjgewyyh@lcpd911>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
 <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
 <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
 <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
 <20260108143944.c3opoz57n6tyje7b@bryanbrattlof.com>
 <20260108155132.x6fcqc5zahftvcba@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108155132.x6fcqc5zahftvcba@bryanbrattlof.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SA3PR10MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6d4bf3-46d3-4083-63de-08de4ed2c68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|34070700014|7416014|376014|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?L3iw77hAj3KbFBczs1dmthDlIYEVVc8hDa4Vuj4OQxtTILLXMMig3izwLj?=
 =?iso-8859-1?Q?YA2c0IWkfIymZ247NctwY+zSknKyR+0Q6WMadhJTEKn8ZdnHGGxlZ1ZRzs?=
 =?iso-8859-1?Q?PfcEc6bVzdb1zTlY+IS1SKN5Y4IF/FhFqmqCQKxbXAbTKumQqWX6/4bkgn?=
 =?iso-8859-1?Q?/rhoxuJxQNx0G365jfU0Oth8N8zV/l2x2CBImMOndVgfZODIMk1LPI2Y7l?=
 =?iso-8859-1?Q?ejUGie2S17oBWPRqqyFNQvyx+FIx+wnEK8wnnrM8Bq59aQSmeJGYiOVG+M?=
 =?iso-8859-1?Q?irQmpeb1TnEGbzSjH5erC7wdfJtuJ+zsth54Offu81J0rboB7NRtgO9K41?=
 =?iso-8859-1?Q?cfKhX2ZcMwQGvkuCO8xIm7afSla7fq7UIjlbL+ltM/KuLdvvfa4iq3ERB5?=
 =?iso-8859-1?Q?c8sQgvckfJ2ywiWi0tmfRpx9QsCU5fgXqu+A1U0i7w9fqygHzYOCVW12YB?=
 =?iso-8859-1?Q?e+F/AXPGDdutXHrrpbAba68wgAms1BKJ40ivVzp18pdC/Dk2FjQJ9qCZX4?=
 =?iso-8859-1?Q?7P6rXh7rryUWNt2OC1U8I3xXoWwugjdEcZrDjZg6APRKJbC9Z8QtB13wKp?=
 =?iso-8859-1?Q?VY8pxX3WXm7jrR9r2KQTqmJxnStK1oKj1yLRPNqemxL2+elOu3/MyoE1oR?=
 =?iso-8859-1?Q?0PVX61rEGPqh/pkshxxTPJQyalz6lX3V0tWBj4lqlDaMh/BfU266Q5uPFN?=
 =?iso-8859-1?Q?R6rDklTnVAynOqCEhnzgNSWdtZrghFUeUYgCS2cGPvmVd38BTKi24PJ3ae?=
 =?iso-8859-1?Q?o3fGVKfROwpEEAD7o8cvp3SM8K7anuVcgKJMjtiVNU5jQqkmymIPq3NOeS?=
 =?iso-8859-1?Q?7kEyrv1Kevyda3MPrIVhNyECeCgF0UV2BFJxuqx+ntYzSSBPTDagn7xbEa?=
 =?iso-8859-1?Q?5z+ZTGuKT27eWhAvZxoB3yKmahBYzPDipYe0c0zb63xztIYOuULfWXMoAr?=
 =?iso-8859-1?Q?crAtXprVu0iLyOQntpdNgDYd1lA2IiWrQFnzfsScmLvj/6KqByyzyb9VvW?=
 =?iso-8859-1?Q?fS+eWImQQ9CYLXprtG82sIRR6YrcYla/U18daT9gTFsbjIaCA1lVrm01bt?=
 =?iso-8859-1?Q?qKDPt9d5qR8lJJk94HI5+GUVRTBF6wvggo378wMBYEFTxVUmpE3rN3CrIV?=
 =?iso-8859-1?Q?j0nVQ4OngCyGr5HLTkm3C8K89NVoKhuTwxjfpVDGYmietF/GeRNKSWc8jX?=
 =?iso-8859-1?Q?8rJPJpR6HlN5sXGYF0VCx6DmvbfJC34YrA8G7QFwrZWEygqnhahAIrVmw7?=
 =?iso-8859-1?Q?be0iF2abdRY2oz8cdButYsuBM4yDPJaAtdIqXAlBLX/pZckch0k/v5MNgp?=
 =?iso-8859-1?Q?efC9FJ0BPaP0coZMfajxLLPk23anXg1tfSIepIALcJ+gsvpmkueZ6/GpTQ?=
 =?iso-8859-1?Q?EaipySSq+jPIpoVZtY/RL6AfZEvywVJOAF5V3XBEoP9Gq0wWSMGRH9QbTU?=
 =?iso-8859-1?Q?D3IFpO5oAm4XObHMjYtrpiP0Gi/yJ1DiV5SKUh6bEyyRWrLoYpXPTupGo9?=
 =?iso-8859-1?Q?L2X3wqjdvXxKf1Fd6hYGKd3FOjFmh+Jz3pk/99wq2bUDHFFBjNMXEbmiCa?=
 =?iso-8859-1?Q?W8Y+EZpX/llbBGjc0wG76fV7snk2ih/ge2OkUnPYuURW7ZzIiq5p2VFNdI?=
 =?iso-8859-1?Q?Cx8MCAT/veFEVAKl5llSWx+Mnda9hS6wHY?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(34070700014)(7416014)(376014)(36860700013)(34020700016)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:27:11.3600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6d4bf3-46d3-4083-63de-08de4ed2c68b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7023
X-Mailman-Approved-At: Thu, 08 Jan 2026 17:31:50 +0100
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

On Jan 08, 2026 at 09:51:32 -0600, Bryan Brattlof wrote:
> On January  8, 2026 thus sayeth Bryan Brattlof:
> > On January  8, 2026 thus sayeth Akashdeep Kaur:
> > > Hi Andrew,
> > > 
> > > On 06/01/26 22:53, Andrew Davis wrote:
> > > > On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
> > > > > Add a small helper that uses memory regions referenced by the R5
> > > > > devicetree node to calculate the LPM meta data address.
> > > > > 
> > > > > Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > > > > ---
> > > > >   arch/arm/mach-k3/am62xx-lpm-common.c | 45
> > > > > ++++++++++++++++++++++++++ ++++++++++
> > > > >   arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
> > > > >   2 files changed, 46 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > b/arch/arm/mach-k3/ am62xx-lpm-common.c
> > > > > index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e
> > > > > 100644
> > > > > --- a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > @@ -9,6 +9,8 @@
> > > > >   #include <config.h>
> > > > >   #include <asm/arch/hardware.h>
> > > > >   #include <asm/io.h>
> > > > > +#include <dm/of_access.h>
> > > > > +#include <dm/ofnode.h>
> > > > >   #include <linux/soc/ti/ti_sci_protocol.h>
> > > > >   #include <vsprintf.h>
> > > > >   #include <wait_bit.h>
> > > > > @@ -48,6 +50,8 @@
> > > > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT        0x18318
> > > > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW        0x555555
> > > > > +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET    0x108000
> > > > > +
> > > > 
> > > > Could this offset into the R5's second reserved memory area change based
> > > > on the firmware used? Actually this whole thing feels hacky. Why not
> > > > just add the location to DT explicitly instead of trying to derive it.
> > > 
> > > The offset value of LPM Metadata in linker file will always be relative to
> > > the position of DM's reserved memory region in DDR.
> > > 
> > > Reference: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L169
> > > 
> > 
> > Does this work currently? Linux today doesn't have these properties in 
> > the Wakup R5 node and from these linker files[0][2] they look hard coded 
> > to addresses we do not have a carveout[1][3] for.
> > 
> 
> I'm sorry I hit send a little to quickly. This is starting to make sense 
> to me now. 
> 
> DDR and DDR_LPM_DATA is covered by wkup_r5fss0_core0_memory_region{}
> 
> and DDR_IPC_VRING_LINUX, DDR_IPC_RESOURCE_TABLE_LINUX, 
> DDR_IPC_TRACE_LINUX is covered by wkup_r5fss0_core0_dma_memory_region{}
> 
> Can we use those nodes?

Yes, and that's kinda what we're doing :)

*meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;

The meta_data_addr comes from one of the reserved DT nodes.

r5f-dma-memory@9c900000 + The offset 0x108000 gives us what we want.

Is this approach acceptable now that the idea of this offset
is clear, and that it's not some independent address on it's own that
we're #defining here?

> 
> > If we haven't started on the Linux side it appears an easier path is 
> > to put the carveout directly in the reserved-memory{} nodes or to put 
> > the information into the board files and let U-Boot reserve the memory 
> > during bootup.
> > 
> > Or at least some way to make this more flexible than this. This feels 
> > very brittle.
> > 
> > [0] https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd#L173
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts#n47
> > [2] https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L172
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
> > 
> > > > 
> > > > Actually, don't we pick this address as part of the
> > > > TISCI_MSG_PREPARE_SLEEP?
> > > 
> > > This is not done as a part of PREPARE SLEEP message. As DM is the one
> > > reserving static memory for LPM, it is already aware of the address where
> > > context needs to be saved.
> > 
> > > 
> > > > Or does DM do it now, either way there must be some better way to
> > > > coordinate
> > > > between DM and R5 SPL than hardcoded offsets..
> > 
> > +1 with the number of carveouts for DSP, VPAC, MCU firmware we have on 
> > these SoCs juggling all the careouts for the different use cases and DDR 
> > densities is going to become a problem.
> > 
> > ~Bryan

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
