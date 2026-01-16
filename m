Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595EFC982EE
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF37683935;
	Fri, 16 Jan 2026 19:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cV28T1hU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3FD838A5; Fri, 16 Jan 2026 19:13:59 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazhn150120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC1E8309A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc8AB+InO0l/EgmwZcuWTbX8AxC8Byf3ieOyrVsMhiy3g9lrsqz+El7hhYsgMbDY5f6yN4cTaN/U6xgb7dlYIplDlT5ImvOrnd1XG1lswtJmY5TxIbtrJA/Nv6NZLvvprZDJ4wa+5S4H5CdCfSM12y5yxfrbaDw8new1bop1rxnSCqtQR+2UEe/L4KngPIr/XQzf3BK2KjB7e+rCoKDiOp0hHh1qWs7Gg7Q1SmxPVp7xx0FRClukR/HF6weMblJpR8eUCXlBYfxTJQbxuhAcJcvshVa7hOMmmUvLhWFxALkmJDv9KfxE4bTXyU9vlBUuwDRAb++asz/mjMJhVdHMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3KKlpMs+p5KPsPHmby+cFD1fFic45Jjn2S2SONpXWM=;
 b=lSPYN9TSh8IgNkf4jEeeGSN1ccXtFGsFwSK7XtocGkY1zIq7agYy6/2j0ARkh0FrKBzwICb1SedSX+6LAIMP3vq1B4LxXjztl90Y02sFSurP5WHkuQVBWd2AZiJcrpGhVt9KWzr1GqNHRzPZKoPlqlXJEMwSPbw4fw9zuDMW9hTsy0PNFeGNU2g/FcrGW3UghNvkSxD9w+oITNwUy/YcucIS7eGegriuwJJ0g+BbeP/Q744237zuIPWYRjFQoyobkEkC2X05q96VJOCjPaUg7+AuiBwW8gDSnpOdgFKZVeIZGL1tw5r2yhJB+o9NweNwl9eij1njLUy3JZ4TX931Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3KKlpMs+p5KPsPHmby+cFD1fFic45Jjn2S2SONpXWM=;
 b=cV28T1hU46w2Ir5n/inYWZIOZftV/R4KZ8KiYsUdvUuYGMV0Wpn6GSRcrQ0RZbOXFjN2nLP1lkIXl3MEbQReywI6MtZW8ApT4pYCyuCvQaI8l9GVy+i4juqCUuGlh9WaJtCUPABXTfEwMHjnxA5+KzykBm2BVKdOqwP0RiswJCY=
Received: from CH5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610:1f0::29)
 by CH0PR10MB7534.namprd10.prod.outlook.com (2603:10b6:610:190::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 18:13:52 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::91) by CH5PR05CA0024.outlook.office365.com
 (2603:10b6:610:1f0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.5 via Frontend Transport; Fri,
 16 Jan 2026 18:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 18:13:51 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 12:13:49 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 12:13:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 12:13:49 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GIDnGE3550699;
 Fri, 16 Jan 2026 12:13:49 -0600
Date: Fri, 16 Jan 2026 12:13:48 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, "Markus
 Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman
 <khilman@baylibre.com>, Sebin Francis <sebin.francis@ti.com>, Kendall Willis
 <k-willis@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>,
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?utf-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v9 07/13] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
Message-ID: <20260116181348.53ypmzwvmszxmlsd@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
 <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
 <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
 <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
 <20260108143944.c3opoz57n6tyje7b@bryanbrattlof.com>
 <20260108155132.x6fcqc5zahftvcba@bryanbrattlof.com>
 <20260108162703.ovogvs6xcjgewyyh@lcpd911>
 <20260109131802.woj2w7sjonntngjp@bryanbrattlof.com>
 <814c211f-a9eb-4311-bb84-165b1a69755f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <814c211f-a9eb-4311-bb84-165b1a69755f@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CH0PR10MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 940b414d-a729-4ecc-5393-08de552b0078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|34020700016|82310400026|7416014|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUZuOWVoUDlCQXAvZnhzZE9JRElsa1E3ZUN0bWswUVp2Mkt4NjJUMzJCZzVt?=
 =?utf-8?B?VFlwZWlFbmxPRVYxZk5xYUlJZlhodUE2eHdFQjA1d3pPUFlIS3I0NjM0MFBs?=
 =?utf-8?B?V1FIZG5UWWo4c0MvRFJwNjBTM3BsOEFRQlU2VWpVYVVxUVl5YURQdm1qaGtl?=
 =?utf-8?B?VCtVeXRNaG1zZmViOCtBZ2l1bWNvdmkxN05QcWozSkVoWWYvWkNHTkNtaUlD?=
 =?utf-8?B?aGw0ZzdwVmI4emkza0MwNDdCL2l3eHJDd0s4dnVIS2VkYStXNTdOcWRHRnVE?=
 =?utf-8?B?NVprVTQ2clA2dUFlamxEQjVnWlExRWtUdVU4L3VHR2dEUHJ6RjUxSEs0eEZp?=
 =?utf-8?B?cTdiWjZaYVZseEFUZkd0WmdxWWlKQS9YU05SVGZsa0xiVlEyZE1rY3dXeHR1?=
 =?utf-8?B?aTJSdCtBTEZPMVNMeGtlOFBrdmpJQko3QWluR2cxazlCSnFtMTRoWHRHSzlu?=
 =?utf-8?B?MkdGakJRV2loc3gxZ2l1U0MvWXVjMzNlVWZFbEszekxsZVZiQ3ZjY01WWkJx?=
 =?utf-8?B?Z0F4eFZ4dzl5MDNaQVA1L0oxTm5iZHZFS0JKRkFabCs2endXZEQrTlVpdk5C?=
 =?utf-8?B?NE9rZ1BKK1FWcFNIaC8rdnpFd1g0MFdCQTB1cFlta3ZiUzZkc3BYdzMza0M4?=
 =?utf-8?B?L2JMNVFhZUs0L3Fwb2NONzl6VGMwbjMvTWxndHFETC9Na2xObGtSdDdrNVY2?=
 =?utf-8?B?RWpnNGl4UVg4dVRBRnNWWmhueFBMOHpmSG9tcUN1MktiTzJkcFkxTmcvUHZB?=
 =?utf-8?B?dWNqUlZVNWxVb0Uxc2Nsa0ZOMHljTzJHZ2h0R2V2UTJlaXh6VTVMMEtyNU9E?=
 =?utf-8?B?VGxjcUdQWHdEU0NtaGZMRnVKUDJ3TlRLRVZDRmhDN3VUYWc4QVROWjE3dmtF?=
 =?utf-8?B?WmFGa3dMVWRvWEUvRHNnQUIwYjEyd2FXMFNwZGo2WXZhTkRNRUdqNTMvcXR1?=
 =?utf-8?B?elpDaUpWS1hCMU9pblk0S3lKbnNBWi9mV0IzUXN6TjJyUUhIR3ZtUTM5Nklz?=
 =?utf-8?B?TVlZVG9kNFE5OWUrMFFmNHpFbGg1Sjd1VVBzTVZ1a3BJT3o4aklJNllWL3J0?=
 =?utf-8?B?eU5TekNDM0tIM01ZZC8zOWR1bGE0SUlKNTFEQWhxa1hFREpDQ2pYclhMeTVh?=
 =?utf-8?B?RVZiaTd0cUpLNS8yVGZhamZidWJFSHVndm9OZlJWdUpzNGM2dnZmQjNqQ0pv?=
 =?utf-8?B?NnBieUFkWEYzNnBsT1hYYkNVY0tCR1h4UVZxMy8rRThXOU4xOEEwUURQT1Z5?=
 =?utf-8?B?Znpic3dRdFduaE9XTDBka3MwbEN2N3hZbWRyVmFsR3VSOWJ6cFp3cDYyMlFs?=
 =?utf-8?B?V3pJc09OREdzdzNVbHE3M0xOZ3BvV3VwNHIzTUNoaVZkcjF1NjllZVhGaVY2?=
 =?utf-8?B?R1poWDhKQjlOK3JZZ2FWaWxSc2t5RXVwMysxNHJrWERzakNLeUpmeFZhTFVs?=
 =?utf-8?B?b0JESVNpcmUrd3hXbDluUTJBYzJlcDRGYkh4RCtWc0VFQkx5ZEd4b29FSVQ2?=
 =?utf-8?B?MGFlNHN5UFFwOVZxNXlhRUtLNjhZTWQyTFFnTGdKUFJxb05vUkc0NCsrRVF0?=
 =?utf-8?B?ZGF2NHBXY1l5emRRc3NCZkZFTFlSTy9QdDhXbW5LVnFKWXc1MW53ZkVTNHUx?=
 =?utf-8?B?YkpHTHZkU3J3amxBYmlCd3JhL2hiMG0vRW81dVNVSnB1U2ZFUGVncFIvcHVS?=
 =?utf-8?B?alBXd0FOOWtsdTJTdjBYOWNBZnRReitlbUdSV0FtYTRaYVN1b01pUXJKRStu?=
 =?utf-8?B?RWhnOEpLRURhaUtHWGM1bk9PS094anhxUlc2akRYRnlQYkFEei93TGJBZEhw?=
 =?utf-8?B?d1RFY3ljQTZYanYydURTSld3dEpCMXNxWFlQekdDWjFYaG5POExxdHVzalYr?=
 =?utf-8?B?Ym5lOUN0V0UxT0RmOU8yQ21vQVdjVlJxbk5TUld3eDQzblp3VTRwQysvdTBI?=
 =?utf-8?B?ZCtQZnFyTHZRc0NpT2ViRGozNlBjbXM2c1FWeWcreFA4QlZNcUEwVFFlVldD?=
 =?utf-8?B?amhWRVNZZXZLenM0VTl3NTY2NTFqQVlNa3NHWHR5QU5lVE84ZTRzVnVQMHpS?=
 =?utf-8?B?RloxbU1Lank4NDJkUGppWHJDSzR5TGlXTXdGZFNwSGJFYXU3d0c5Y2FFVzBQ?=
 =?utf-8?B?b1pOeXBMdDNlc0tCTnNaT2E1bFdhVXU0emVGZktHQ1c5dlI3a2g4bDhmdnB4?=
 =?utf-8?B?TGI0Sys2ampzdmZLOEpCN0xxMUdrTVM1WFIrOWR5N3pKSzdOa1M0UHdKMW12?=
 =?utf-8?B?WVNLZXU3U0R1bUwrOUFDL2gzQnlBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(34020700016)(82310400026)(7416014)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:13:51.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940b414d-a729-4ecc-5393-08de552b0078
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7534
X-Mailman-Approved-At: Fri, 16 Jan 2026 19:24:33 +0100
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

On January  9, 2026 thus sayeth Andrew Davis:
> On 1/9/26 7:18 AM, Bryan Brattlof wrote:
> > On January  8, 2026 thus sayeth Dhruva Gole:
> > > On Jan 08, 2026 at 09:51:32 -0600, Bryan Brattlof wrote:
> > > > On January  8, 2026 thus sayeth Bryan Brattlof:
> > > > > On January  8, 2026 thus sayeth Akashdeep Kaur:
> > > > > > Hi Andrew,
> > > > > > 
> > > > > > On 06/01/26 22:53, Andrew Davis wrote:
> > > > > > > On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
> > > > > > > > Add a small helper that uses memory regions referenced by the R5
> > > > > > > > devicetree node to calculate the LPM meta data address.
> > > > > > > > 
> > > > > > > > Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > > > > > > > ---
> > > > > > > >    arch/arm/mach-k3/am62xx-lpm-common.c | 45
> > > > > > > > ++++++++++++++++++++++++++ ++++++++++
> > > > > > > >    arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
> > > > > > > >    2 files changed, 46 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > > > > b/arch/arm/mach-k3/ am62xx-lpm-common.c
> > > > > > > > index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e
> > > > > > > > 100644
> > > > > > > > --- a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > > > > +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > > > > @@ -9,6 +9,8 @@
> > > > > > > >    #include <config.h>
> > > > > > > >    #include <asm/arch/hardware.h>
> > > > > > > >    #include <asm/io.h>
> > > > > > > > +#include <dm/of_access.h>
> > > > > > > > +#include <dm/ofnode.h>
> > > > > > > >    #include <linux/soc/ti/ti_sci_protocol.h>
> > > > > > > >    #include <vsprintf.h>
> > > > > > > >    #include <wait_bit.h>
> > > > > > > > @@ -48,6 +50,8 @@
> > > > > > > >    #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT        0x18318
> > > > > > > >    #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW        0x555555
> > > > > > > > +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET    0x108000
> > > > > > > > +
> > > > > > > 
> > > > > > > Could this offset into the R5's second reserved memory area change based
> > > > > > > on the firmware used? Actually this whole thing feels hacky. Why not
> > > > > > > just add the location to DT explicitly instead of trying to derive it.
> > > > > > 
> > > > > > The offset value of LPM Metadata in linker file will always be relative to
> > > > > > the position of DM's reserved memory region in DDR.
> > > > > > 
> > > > > > Reference: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L169
> > > > > > 
> > > > > 
> > > > > Does this work currently? Linux today doesn't have these properties in
> > > > > the Wakup R5 node and from these linker files[0][2] they look hard coded
> > > > > to addresses we do not have a carveout[1][3] for.
> > > > > 
> > > > 
> > > > I'm sorry I hit send a little to quickly. This is starting to make sense
> > > > to me now.
> > > > 
> > > > DDR and DDR_LPM_DATA is covered by wkup_r5fss0_core0_memory_region{}
> > > > 
> > > > and DDR_IPC_VRING_LINUX, DDR_IPC_RESOURCE_TABLE_LINUX,
> > > > DDR_IPC_TRACE_LINUX is covered by wkup_r5fss0_core0_dma_memory_region{}
> > > > 
> > > > Can we use those nodes?
> > > 
> > > Yes, and that's kinda what we're doing :)
> > > 
> > > *meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
> > > 
> > > The meta_data_addr comes from one of the reserved DT nodes.
> > > 
> > > r5f-dma-memory@9c900000 + The offset 0x108000 gives us what we want.
> > > 
> > > Is this approach acceptable now that the idea of this offset
> > > is clear, and that it's not some independent address on it's own that
> > > we're #defining here?
> > > 
> 
> Who is "we" here? The MCU+ team making the current example DM firmware
> are part of TI too, let's not act like they are some outside force we
> just have to live with their decision to hard-code this..
> 
> Nothing is stopping us from telling the DM firmware (at runtime even)
> where to put the LPM saved data, or we can have some mechanism to find
> it from the DM firmware itself.
> 
> > 
> > Yeah I don't think I have a better idea. It looks like quite a lot of
> > stuff in the MCU+ toolchain is hard coded and incredibly brittle. This
> > being so brittle and hacky is an unfortunate side effect.
> > 
> > I wish there was a better way :/
> 
> Zephyr :)
> 
> It isn't ready yet, but Zephyr based DM firmware isn't an impossibility.
> And many of these limitations will no longer apply. All I want to do is
> make sure we do not bake-in the brittleness and random hard-coded offsets
> into U-Boot, especially when it may not even apply to future firmware.
> 
> So to solve the problem today I'd suggest, instead of assuming
> r5f-dma-memory@9c900000 + offset 0x108000, make a new DT node specifically
> for storing the LPM. The address of the node can be the same as firmware
> hard-codes it today, here you just read the node address directly. Then
> should that node disappear someday, U-Boot can go down a different path.
> This gives us a way to identify that future situation, while also just
> being less hacky IMHO than using hard-coded offsets.
> 

This is a good approach. We already inject space for other boot critical 
firmware and the IPC space they use for Linux during bootup. And we can 
reclaim the space if someone chooses to disable this feature.

~Bryan


