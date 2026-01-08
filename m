Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C721D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 15:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F61841B1;
	Thu,  8 Jan 2026 16:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bkOcmV5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BADE984221; Thu,  8 Jan 2026 15:39:59 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazhn150130000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d911::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3596B841C2
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQlM3ykC4kYPK9ulmUCOb/iLiT61XoSZVv7TM3BY/AsWuYcReiu2RbXKWNJci4P0l3d6RuGwffdHZhuP8Ew4RQO8QHQ9ugGpTg7AwXg/ZS6jUTNywFXUH7iZ/2o0hIS+gb9kvIgL5TuUYYmNAoqWfUAqL74WYdgn1gdbL6VmZs4j3oLErDUA9CFMt0/u6v0lRgJLGxVYGiI7xHH54mWbRk1JCK9Scn2UbMzgGY5nGliAZKm6BxSx9LyLr5XS82nE//rDbD6PhKo3oDuYDOs/ElhZknGkHlQEgm5MsPRdKbkN79BmlWw6gqCy4ffFNfQQ5Q+B7Ok5QhfyARq6mlk3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y39NXV2SHOXUH5HIDKc8e2Zeuq9yMsdwBPshJqnetU=;
 b=JkpgusQjYCDpHq1keIKYb7gQE6KTV9UevO1KiXogt27AXyu1uR7+TIQeZytde2UO6W/Nm6Rhs52jHlBoX8CgpJOtm9sSD9M/EFeg1OoFP2NizwOMfCNrFcEr/AWIgs8bShFZWm7ocG0HAT5TnWSYLMN7IXTJI8g4aetrDcodGW7+WCoGOVRqMc+dolPYqtpDNjxGxsIDV4lvHMJ2V1O3JFv++A32Tj40N/Hb0UN8auG8a2bWwsXFivrpD0mKG4Wvf8uBmsyK4ohgQ6LJMDdvxYHyVj8x9dRU20T8vE9ymqsGgZYtJuqVRaeZUKB9U/Yel4Xkrto7hOJK8U+c2spEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y39NXV2SHOXUH5HIDKc8e2Zeuq9yMsdwBPshJqnetU=;
 b=bkOcmV5ztWK7AAkUr8eDRAg4iRJg38lQodzR0cwrmFOkOnFSYYHDjIrzW9h17XEOu/8Jy4XaqSHvgdZl5epUPrla2ZmvYA69ZtwFXSaWMyxXUOKI9DRJqBC33apM3gn9rZ1IJF/OKSVwwT4bNOHjQ7/oAf4nfjcsN7B8jWlTmIA=
Received: from MN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:52d::22)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:39:52 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::e0) by MN0PR04CA0008.outlook.office365.com
 (2603:10b6:208:52d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:39:51 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:39:46 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 08:39:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 08:39:44 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608Edi9n2634567;
 Thu, 8 Jan 2026 08:39:44 -0600
Date: Thu, 8 Jan 2026 08:39:44 -0600
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
Message-ID: <20260108143944.c3opoz57n6tyje7b@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
 <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
 <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
 <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a5acba-541c-4b1f-e766-08de4ec3c849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|34020700016|34070700014|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OExBVkZHdGtvUE5lMkpWd21UVkI4eGtCTUdDbkt5YXI3VXh6VDU2WXd1cThE?=
 =?utf-8?B?S21vbWkvcUd6V2dONXN2U3Z6c3hZMCtua0EwUDZacjdycjBzL2JVWmp6LzhB?=
 =?utf-8?B?U1c0OFRwWGZUNFRWMVREYzJUcHNnOXNmSmx6UHEzVTZZMEtOc0hWVWR2dVYr?=
 =?utf-8?B?Z3JqR1NYRk45ckJJc1RPdVRPcDBkU1FCMHlXVU1HOW9Qb3ZKZEgyeS84YzhG?=
 =?utf-8?B?WTYxMjEzYmVkaVUvdGlMcGJ4czhTYjQrTnJ3NHZNdm9aa05LbVBQMnJvejgr?=
 =?utf-8?B?WWE5L29zc25NYnJtYTFsNUR2cFBxbTdWTlV1UEVVcXlMbThnZUFnM2t0bVNq?=
 =?utf-8?B?SWUwYjVtdEF2QzA0QTlsUXJYKzd4QXpLT0Y4K0VaNWU4ZDVIVFgvSmNScy9j?=
 =?utf-8?B?V0ZyekdKSVF2cUpSVkdiUjhndHplUzlWSlhteVlONHpVQXkrblNFQkovVTQz?=
 =?utf-8?B?Mk9YSmZIWHAzSXJVWmQ4dld3MXV4TGRDekQyZmZzWFJxN0hOMVdXL2lQeHB0?=
 =?utf-8?B?eFIyRTFaQnJLQVhxbERnYlJnNkU5eXZaRkxjN2hTb2VlOGVqYXVCOHEzNlRL?=
 =?utf-8?B?UjJxdFhEUVdwOGgrNXAxWkhrazJsZlI4Sys0Mk1pZEJONnZuQ3VseXBUQWhB?=
 =?utf-8?B?ZDhYbkUzL1hWeStVRCtFSWlNUFZhTWJrRjlGc2tHeEt5OXhETWVZWWQxSGQ4?=
 =?utf-8?B?Z3VNb3VoaDRLQUdKK2d2d1FReDRsMm12UGZPNEhmdXJQZk5WOXAreWR6N0dN?=
 =?utf-8?B?S0V2WS9DZjZzcWRRZWtWVWNOOFBDUGl4TTBoVHVFNjdjbjVqWi9BWVE1KzMx?=
 =?utf-8?B?WW5nNXdmUEdQVDBHUFU3b3VkSHhBYTNGVUhHWFowMDVaVVM4ZktQQk5zOHc0?=
 =?utf-8?B?NStlZW5EV3JNYVRndjdoREg1a0lSVkR2a1IrbEMxUzRETlpYaDVIY0NEVGxs?=
 =?utf-8?B?ZmM0VTNpWEN2cCtab2RqOWRzU1hBMW1tbThkbHJreVMzZjBhaXR4R245ejA5?=
 =?utf-8?B?Um1hTEppWUZYZVFVMzl1MmZadm9XM3lxanRubm9QTTRkREFZY2tZM0loVFo1?=
 =?utf-8?B?OHRDUTEwZ0tyK1BuWXpza1NEcEprRHhlRDZFZitQTWZ5Y0t3N01XQzV5MEln?=
 =?utf-8?B?cE5VQ1lEZ2lyRkpJd2JkKzY0a2hxYTBnbVYxM3Q3TXExQ055L0pBQlR1aHlB?=
 =?utf-8?B?dHQ1bW9odmVoK2hTcE1FMkgyeXh0NElQaG5qdHJvOGJEd2RoVU9MU2pNd2t0?=
 =?utf-8?B?RFpSUXJxMG1adVRObTRVL0Y0YjNTN2tLM0V1OXQzakoxcE50QXVxNStrSWVG?=
 =?utf-8?B?M2YrZ0FMZFhaM1ZsWUd1WVAvVjhLblFidFNBMkNVSUxxeGl2bnAwcE4zL1hN?=
 =?utf-8?B?ZDNKMEpoQ1NrellMK0tFbU9NMG5iSDVNTXBranBjUVByRnZqc0I1UDhuWFA2?=
 =?utf-8?B?TGhmTDJGTmNFTlJaN3puNlROWndURTg3RU9NVVhHU0E0Wk9Sd2w4UGI1NjRO?=
 =?utf-8?B?RGtTT3hDcE84czZOcXFzYmlUTDZyVU9pTFlqamVIKzRBLzVaYUhJNjMwazZ4?=
 =?utf-8?B?R2NFWUMwU09RSjRIOHFzN0ZpSmVhN0JLZytVOXhkNzRsWEJOTUlzc2NRdHNC?=
 =?utf-8?B?cnRlTFlOVkZuMlhQclMvdGZyTHlkUWE2QWNkTmNWcmMxQ0htK0xtdCsycGlS?=
 =?utf-8?B?OExxbTRCa3JsWXRGb1EvVGZLUmRvSlg1Ylh1MTkxZDJXVFphdDk4K2syNER1?=
 =?utf-8?B?R0IvMXBpbjJoSThDbnZ0QVh0VjJkNno1VDBEYXRMZlN1N1hCMnIxcmlKcTJP?=
 =?utf-8?B?YWJBaUtnaHZ2S1M0VjE0SFN0RS9GSGhjYVMwaHBNOHlDNUpaMmdNdTN0YmZz?=
 =?utf-8?B?R1J3L042d1pURTViWXdLL2UySXRLWU1wNEZUd2lrcDhleVF1K3U5dzJXVDJa?=
 =?utf-8?B?YWw5a1NjaTBXUUt3TS9UYkdvNUpUelYzRU1lK20vam5McVZpMkVpZWVVcTFl?=
 =?utf-8?B?bXNCcTViaytqZDhEM0lNWnVOc3NPRDBGeVI5MTlPTWdqdTJwM3Jkb3haVFhq?=
 =?utf-8?B?UDIrd0VpTjBsQUs3bVlMVjRTUCtDaGlZVUJscVQ0MHJXVFBDY2VLVHpoV1hT?=
 =?utf-8?Q?Ll1MrIgQ5wVMk/mpIxWWUMqZ4?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(34020700016)(34070700014)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:39:51.8329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a5acba-541c-4b1f-e766-08de4ec3c849
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
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

On January  8, 2026 thus sayeth Akashdeep Kaur:
> Hi Andrew,
> 
> On 06/01/26 22:53, Andrew Davis wrote:
> > On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
> > > Add a small helper that uses memory regions referenced by the R5
> > > devicetree node to calculate the LPM meta data address.
> > > 
> > > Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > > ---
> > >   arch/arm/mach-k3/am62xx-lpm-common.c | 45
> > > ++++++++++++++++++++++++++ ++++++++++
> > >   arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
> > >   2 files changed, 46 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > b/arch/arm/mach-k3/ am62xx-lpm-common.c
> > > index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e
> > > 100644
> > > --- a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
> > > @@ -9,6 +9,8 @@
> > >   #include <config.h>
> > >   #include <asm/arch/hardware.h>
> > >   #include <asm/io.h>
> > > +#include <dm/of_access.h>
> > > +#include <dm/ofnode.h>
> > >   #include <linux/soc/ti/ti_sci_protocol.h>
> > >   #include <vsprintf.h>
> > >   #include <wait_bit.h>
> > > @@ -48,6 +50,8 @@
> > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT        0x18318
> > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW        0x555555
> > > +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET    0x108000
> > > +
> > 
> > Could this offset into the R5's second reserved memory area change based
> > on the firmware used? Actually this whole thing feels hacky. Why not
> > just add the location to DT explicitly instead of trying to derive it.
> 
> The offset value of LPM Metadata in linker file will always be relative to
> the position of DM's reserved memory region in DDR.
> 
> Reference: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L169
> 

Does this work currently? Linux today doesn't have these properties in 
the Wakup R5 node and from these linker files[0][2] they look hard coded 
to addresses we do not have a carveout[1][3] for.

If we haven't started on the Linux side it appears an easier path is to 
put the carveout directly in the reserved-memory{} nodes or to put the 
information into the board files and let U-Boot reserve the memory 
during bootup.

Or at least some way to make this more flexible than this. This feels 
very brittle.

[0] https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd#L173
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts#n47
[2] https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L172
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi

> > 
> > Actually, don't we pick this address as part of the
> > TISCI_MSG_PREPARE_SLEEP?
> 
> This is not done as a part of PREPARE SLEEP message. As DM is the one
> reserving static memory for LPM, it is already aware of the address where
> context needs to be saved.

> 
> > Or does DM do it now, either way there must be some better way to
> > coordinate
> > between DM and R5 SPL than hardcoded offsets..

+1 with the number of carveouts for DSP, VPAC, MCU firmware we have on 
these SoCs juggling all the careouts for the different use cases and DDR 
densities is going to become a problem.

~Bryan
