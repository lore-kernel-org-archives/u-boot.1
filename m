Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D31D1A623
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A658432F;
	Fri,  9 Jan 2026 14:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BPaoxWmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66CB84332; Fri,  9 Jan 2026 14:18:12 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azhn150120000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d91c::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A148430F
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 14:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e80y5VtKXE7BgGeoXRS4fUxaCuJyLUxVSB9LURsmpZZOmnjsufWuUpF97eN7ohrDF6b0yaeKc/BN2iizh0LTSsBdCPbmNGxs4LCOpPE9R0xmqrjCrUA3sY8EzlFnO/d/F1fzlluqvxdLJL8iXzzTXDXCVGMBKnpaJz5ku50hjWjnLKi3d3bPZnilTBFRAZ6PfwUk5Sku7mOJRUYho6O+KpHFy1r3ITk2ji2QzZp6aFNSbVW67FwYAtpzfUIcYEolSoyvUnLvxOicntbjDd7zO31baFcVJB4DLoJAW8ayeXdjpLnS/yPmxvnXTqM2zYaRUidReHqoagpLfkklm/CdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzLGWmMCPspfwD+u8wTyAxgQ3JczsWvvJD0sTUX0jTw=;
 b=qWREP4akTLJwOn+7IJMMBzeLr1YiyBNE2JOok8lL5pc/T19/kVNiDymCNAQZx3T/59blbdgvh3b1CX2YNKQ8FWx7ZdT1dvz/VLuUBeaZ0iKAZ7UOfrrhxH94QeryYCg9XQwqCJO7KHaLFB0hjx40iIw7VZBmepfzXVelT7XhBncWqueAGTfk65RKaobXeIe0gewKITEXcTvymbQYBlPiy0d6X+qp2IwIFHfAQdkSLzfMGogegWNzrV9IgL0aERNa5H1V6fq4bAB2C+3beXcg0qMGv98opyk1Y+arYRXRr6If1JUrsmZeCqT0ySJWPY02NEVAXA5IsrXDbqKT1DzDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzLGWmMCPspfwD+u8wTyAxgQ3JczsWvvJD0sTUX0jTw=;
 b=BPaoxWmW8k+d/9pYqIzFkHO795L2NNLPpdNOmdw/li2SLKQ2VBiRQRSGRs+VnKRZQ+4ZsC/nZ6Y0lXV/jPOwkYON14j0z3vjK72v4phV6YAZOytKxjosxOUOL4zeG8m7nkH0+Bhk8sCb/T0tL5EbU1IfU59R0A+KgeHp7DdT8m0=
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 13:18:06 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::46) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Fri, 9
 Jan 2026 13:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Fri, 9 Jan 2026 13:18:05 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 07:18:05 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 07:18:02 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 07:18:02 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609DI2sT095463;
 Fri, 9 Jan 2026 07:18:02 -0600
Date: Fri, 9 Jan 2026 07:18:02 -0600
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
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
Message-ID: <20260109131802.woj2w7sjonntngjp@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
 <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
 <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
 <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
 <20260108143944.c3opoz57n6tyje7b@bryanbrattlof.com>
 <20260108155132.x6fcqc5zahftvcba@bryanbrattlof.com>
 <20260108162703.ovogvs6xcjgewyyh@lcpd911>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108162703.ovogvs6xcjgewyyh@lcpd911>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|BLAPR10MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fd2d2e-f597-4569-9beb-08de4f81868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|7416014|82310400026|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWxlc1RsRVZ2ZVpMOHJwdjMyd1VWYmJ2WkxSdHhIM3A1bGNEa09IcFgzZUlE?=
 =?utf-8?B?WGZpdCtlVmhndlRMNGJMQnFQU3FJQWdEOGlPYzhTZ0kwVHlieGVFNkh2VkxR?=
 =?utf-8?B?OHMvdzQyYXJiNnZ0OXNkNW5UQkpvczF2RC9Ib2Nabk9rUXUvUS8ya3FveVVW?=
 =?utf-8?B?TmIwU3RSZE5NaThDRjVuVkRRTmRmSXdROS9OeXk3ZndieGtLRGVNRFZUL2U3?=
 =?utf-8?B?NVZKYk1Wb0N5bTMyNTFjVjUxcmpjcElDdGJ3enVndWcwaW9VRnhrUDJTdE5B?=
 =?utf-8?B?Z3ZIbEN5K3lYUEdNRUN2RWsrUmxzblNIMWR6THVBVXEycVo0TzI2UXJIZkRs?=
 =?utf-8?B?cHJ5Y2ZLenhpSXF4N3hvamlkKzdCQitRV1A4NGRXdXZxdW84UGxFQ09XdnlI?=
 =?utf-8?B?UTZTaE5XdkZLSTkzc0hQN2RGUUo1b2JLdk1hSUlrTFNNcGV5TS9pdy9Fcmtp?=
 =?utf-8?B?Y000Q3AyQzUvT0paRmNHcEE0QTlxOFNPb1kyY0ZGc0puZnM3TWhOaTBoK051?=
 =?utf-8?B?emRmWlVPYTBaMjBBSnZHbnpJbVJSZWdYOUVCcUpFaUtrUzRSNGR5Qzdpa2J0?=
 =?utf-8?B?MkJlbXBvd1FVVjFTQzllQVVDQzE0dFFhSDlUTnpibEJzMElGZGxCV2tEWlNS?=
 =?utf-8?B?amZuRnZlZHUxdEp0eDJuRVRqTjFZZkxmQ3c0SmcrSmxrRGg3QjFsU0hkNGM3?=
 =?utf-8?B?WmdjRWVjNlA1K04yMnhrVUF0emppOVFndndpVUh3K2Q2T0pJTjZtS3NXRkRs?=
 =?utf-8?B?bDhUc1hSVm5KRDY5aVNXWll4QkJCak1SN1pkT1pOUzdlcXJwVWhPZGdxQmZp?=
 =?utf-8?B?aitKVW9KU3Eyd2cxcTZlSURqaXNxNERJUUJUckkyNzduMm9VemNmNzBIaTlL?=
 =?utf-8?B?dTd5TjdrUWR4UzROdWNTcTgxRCsxZ2xhZGxrT25HOUZ5Y2RBY0RSOFByUDhi?=
 =?utf-8?B?VlRqelFLZVdxSWFRU0sveEZnRjU2UGMrWndmQ2p1ektQb05NRjM1d0YxQXh6?=
 =?utf-8?B?UmhNZjNCVm4xZWltT2JqNy80bTRNZ25FMlhHVmdQQlA3WjE4cUlBWEZTN01W?=
 =?utf-8?B?SGxOL0llWEp0SGoyK1V6ZmlycGpiS0I4eG54Rmp5M0liYUNrSHZhR256cmFU?=
 =?utf-8?B?WjdHRU83bjhBRTBDc0UzY094cWRzdzdOeWhvTTN0blEzWFhDbld1VDlRTURP?=
 =?utf-8?B?dTdLVjE3UEpuZ2p4ZkFrZU8xTXhMZXZVYTk2S1Z2cW53aUdudDV4dXNoMHM3?=
 =?utf-8?B?cm4zQXpqWXdiSHJwMEY0eWQyN0dsb0x2WWJBYjgzVzFTNVcxRGNyV0pBV0pD?=
 =?utf-8?B?YW0veGlSTE5ZV2V4TjdtTkxFOURCMjJNbHgwQldtcm5KdG9DcjJCMTB6aTR6?=
 =?utf-8?B?MGxLYWgyZmF2ZmxMSFJWNjM0aFRYWDZzcFc5dU5BSm42Qnh1NWo0Z3czUTNP?=
 =?utf-8?B?VjJlU3JNcWhFZDFQdTFZUVVXa0paSGUrdnAxYldqRk42RGd6MzV2UW1SZkVN?=
 =?utf-8?B?bklid1g3MmRHR0VTbTNRNDVtdHlQYTk1a3ZIR2N1dW1uRzFNNDlNcCtJWDFz?=
 =?utf-8?B?aHpxeFZFcFdncXVwMi8yZlAwbVJYZFRCeTl3QWdYSWwxMm80U2N6TnVzRk9a?=
 =?utf-8?B?M2FTaEcwR2M3YjVoU2V1aHNSM1JqOUozTWsvc2hOZ1NOMGJpK2VaeVNZNlJI?=
 =?utf-8?B?V2VhSEU1aVlsY1Y5MEtQTXdRNGUwM1gwRGpvdEV2ZStTdjVnVmcxREpmNUNM?=
 =?utf-8?B?RVIwaTVCdnBmREw1bnpSM0xiMDd4QnJNcWROOWNZcmpCcXF1ZEJta01iSTEv?=
 =?utf-8?B?dExWWVlHemVFWVZvMEpjS2grbmwvU0JzOGxQcjRGdWNYSFlLQVZheGxlSTdO?=
 =?utf-8?B?Sk1YemppZUtsRjFROUN2WnB3dDZkRjlKM2hCQmdIM3NPc3Y3L0tleURuZmFN?=
 =?utf-8?B?cWYvTmFUYk00S2JDMUFyUDZMY3psZ0N2cFN1Ti9DV0hsSjdxNWxwdnF0WDJR?=
 =?utf-8?B?NmpBSVVtL2hpdG5MTTdJUzVKZHEzTTBCR2ZaRmhnSVp6WU43TGNWc0RYeXUy?=
 =?utf-8?B?NVg1OGZyV2l3NXR3bC9LcFcvcTFJeG5DYTN4MnJWTlR4WlFLNE5KSGl4ei9o?=
 =?utf-8?Q?r85I=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:18:05.8708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fd2d2e-f597-4569-9beb-08de4f81868c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Mailman-Approved-At: Fri, 09 Jan 2026 14:23:30 +0100
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

On January  8, 2026 thus sayeth Dhruva Gole:
> On Jan 08, 2026 at 09:51:32 -0600, Bryan Brattlof wrote:
> > On January  8, 2026 thus sayeth Bryan Brattlof:
> > > On January  8, 2026 thus sayeth Akashdeep Kaur:
> > > > Hi Andrew,
> > > > 
> > > > On 06/01/26 22:53, Andrew Davis wrote:
> > > > > On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
> > > > > > Add a small helper that uses memory regions referenced by the R5
> > > > > > devicetree node to calculate the LPM meta data address.
> > > > > > 
> > > > > > Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > > > > > ---
> > > > > >   arch/arm/mach-k3/am62xx-lpm-common.c | 45
> > > > > > ++++++++++++++++++++++++++ ++++++++++
> > > > > >   arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
> > > > > >   2 files changed, 46 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > > b/arch/arm/mach-k3/ am62xx-lpm-common.c
> > > > > > index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e
> > > > > > 100644
> > > > > > --- a/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > > +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
> > > > > > @@ -9,6 +9,8 @@
> > > > > >   #include <config.h>
> > > > > >   #include <asm/arch/hardware.h>
> > > > > >   #include <asm/io.h>
> > > > > > +#include <dm/of_access.h>
> > > > > > +#include <dm/ofnode.h>
> > > > > >   #include <linux/soc/ti/ti_sci_protocol.h>
> > > > > >   #include <vsprintf.h>
> > > > > >   #include <wait_bit.h>
> > > > > > @@ -48,6 +50,8 @@
> > > > > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT        0x18318
> > > > > >   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW        0x555555
> > > > > > +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET    0x108000
> > > > > > +
> > > > > 
> > > > > Could this offset into the R5's second reserved memory area change based
> > > > > on the firmware used? Actually this whole thing feels hacky. Why not
> > > > > just add the location to DT explicitly instead of trying to derive it.
> > > > 
> > > > The offset value of LPM Metadata in linker file will always be relative to
> > > > the position of DM's reserved memory region in DDR.
> > > > 
> > > > Reference: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L169
> > > > 
> > > 
> > > Does this work currently? Linux today doesn't have these properties in 
> > > the Wakup R5 node and from these linker files[0][2] they look hard coded 
> > > to addresses we do not have a carveout[1][3] for.
> > > 
> > 
> > I'm sorry I hit send a little to quickly. This is starting to make sense 
> > to me now. 
> > 
> > DDR and DDR_LPM_DATA is covered by wkup_r5fss0_core0_memory_region{}
> > 
> > and DDR_IPC_VRING_LINUX, DDR_IPC_RESOURCE_TABLE_LINUX, 
> > DDR_IPC_TRACE_LINUX is covered by wkup_r5fss0_core0_dma_memory_region{}
> > 
> > Can we use those nodes?
> 
> Yes, and that's kinda what we're doing :)
> 
> *meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
> 
> The meta_data_addr comes from one of the reserved DT nodes.
> 
> r5f-dma-memory@9c900000 + The offset 0x108000 gives us what we want.
> 
> Is this approach acceptable now that the idea of this offset
> is clear, and that it's not some independent address on it's own that
> we're #defining here?
> 

Yeah I don't think I have a better idea. It looks like quite a lot of 
stuff in the MCU+ toolchain is hard coded and incredibly brittle. This 
being so brittle and hacky is an unfortunate side effect.

I wish there was a better way :/

~Bryan
