Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6CAD2F031
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5234284027;
	Tue, 27 Jan 2026 14:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d7VjSDfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF0A083F9D; Tue, 27 Jan 2026 09:17:35 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CD883F9D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV274kq4ljql2hySk4eQLhyDaeXnopIYrem0IKzbtpJGHuJuUjPMXF7TiapU30wGI2qZX6ANvDUQIAlhFy0GLu3U/tsQPXnYMufSdt4BO+Gjb9Xxdh8jvKJ2RTYxkU7nhBzHiAs1IB0aTHNNFv8hTO0yZi3aR1vINYeKGYteG0qLmpMeQujx3IjBFW6/oGDk3RIWP1hikuu3noh+yTYuSCBDyLH2ALVIFAHY5+Y+wpywEf3dvK6w2HtTXwAhJwvgWrahrGJebrQxwUA8JR3HDutXo84c0fQLh1iWJXdMRzBAp5wGlalLJb32qedg+DQou4J2WLI7hZ7fnUasNSupFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+vTWH+faT97g3AAgplC3bTOL5VwEthX+ghV+LP8eP4=;
 b=K3C/KlXWY3VuDI0ULP7z7aO38NV1u4J0rnZ71uPqOZ5y2xVRS+tGNh8nnG051Occ6T+eEuCFYcE29fZ06aKUx7eNE99ZGh5DsJFxjSW4PFhivZelQgUk9oA96HnsGVeGFcTp/jJMeV93BbspKiPR1jtffb8k4/BM7yiaWm35ayIkaeNuMwjCxNaxgYGDZrs/+fgviRXZoVwa9JPNQ/ura7p49exGNCpagpLaD/qT5h8bwyWZ8CorDKNKs8UlqFnucuIEfG6zwp5m9ycbEfxWGHEKThZwiOGWxLDqoVpp8mZjRxBlC47Ybzs+l90sN6qz4P9oXEbMD8ftnC6jeoN4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+vTWH+faT97g3AAgplC3bTOL5VwEthX+ghV+LP8eP4=;
 b=d7VjSDfQSDuA72XW4aNRtArhvJdKPDDfrFB9Yfk6IBiNFndT2zWmk18mTPxsIOW5jMappc6rhhrAHytvzPtO8OsSqe1EOy3wySX8y9tYv51EgKKhPpKE7AMnNO7al/J50B0XIzr2Ks/j1EAyg+Pqapkpsz5Q+ZMalkosr7dMFsQ=
Received: from BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16)
 by BL3PR10MB6091.namprd10.prod.outlook.com (2603:10b6:208:3b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:17:30 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::38) by BLAPR03CA0071.outlook.office365.com
 (2603:10b6:208:329::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 27 Jan 2026 08:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:27 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:27 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:27 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HQvF185179;
 Tue, 27 Jan 2026 02:17:26 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 00/10] Firewall ATF and OP-TEE memory regions in Sitara
Date: Tue, 27 Jan 2026 13:46:42 +0530
Message-ID: <20260127081652.506357-1-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|BL3PR10MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 84814fb6-c926-4684-36e5-08de5d7c828e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+cpPy2+epvCv43MbyAT7jgj4B1wqz6T5kPZEFg5cbQh9a3emKA9b8O8abWXm?=
 =?us-ascii?Q?YfbX1mrSCGxy2chBLegrGAfaBXXkwrL5a3FDJexnq5SOxAGKSyKm0ZQUy69I?=
 =?us-ascii?Q?htM0OUjtZ3UQ2g8Mm7K0sGpJu9I/7bHRlVItBF2/SXoZ//hbasgHJq2Ah4d2?=
 =?us-ascii?Q?Q1PLCZ7GzDIMqA5yUTuabSoG5lP5v/4EQRq2I6mO+Ws2sfnjBXnhIkshvQYS?=
 =?us-ascii?Q?fKKL0953gJvTxxDY7TCaU6ZoholtnDEd27uZghuqQ+JI+rKW13vIVhpriURi?=
 =?us-ascii?Q?qeVIfbh9dlBs8bm6fBWspGEQoaMpy+GBLIrPndp6vGLIgZIE1tOdcAGDyfew?=
 =?us-ascii?Q?s+V8j/ute/H2WzO6zzWeu2w7d32QWDrsFoytiIUbNAFWcoyLKJyvXb+AXepf?=
 =?us-ascii?Q?hgnJYF+7IiYsTdzMcMGPdFfnFmEiIcDYjD9Irw1cEWKBNpFiCem+KvMXSPiv?=
 =?us-ascii?Q?qbZ9Wc27ncdf3qg+/xTfOechYiXfQsobXY8vhR1bbdHRTmuk/g1f0Cp6NbgZ?=
 =?us-ascii?Q?8qvFTN9uqm52UDjoJAEvTipy1APtRkBisFOo7+6emS0YXsKStSxY4LCt85Tg?=
 =?us-ascii?Q?GwfNZuVo7sEvldu9sQBvEnNdFKaYbE1WpR6x4nMJvpWTuU0hyjiPsYa0SGjk?=
 =?us-ascii?Q?/cNNZUha0Q2ZczmMsGZ5eg3oPx4Qu/QpZqPa6Z3d8y3F2CZkXUrGkRnJj44N?=
 =?us-ascii?Q?0Z7ZsLynaXi8IcpfituMfKt25KUGBxEt9Q4wcVK8e5fkxj1+1j9kC48VS2UB?=
 =?us-ascii?Q?5lbkkRltdui3nKkbrmS6Uxo4TwfvpezdBn1aYVUPI7l05p7lRMn8chsahCg+?=
 =?us-ascii?Q?4QXnI+4ACip5UI47g+5zY+c7Z8lf0Sj8dRvcJd2WjS+ndiF1C/bxMLBqoiYx?=
 =?us-ascii?Q?f6lEicN13NJTWgR1sAtYmOnDpmxmR+5bHGdhoTybILVzS/aWiSQBCL0YvmaD?=
 =?us-ascii?Q?IAZczvbN7Zkar5yU6W32B22tm8dnUJHlyKjbZFeowpOyR8bp4Arfm9n/Luk+?=
 =?us-ascii?Q?+sBENI4AwHvv0yL2lE8S8ahY/edhg8Acvfj7mnSqTNlKSw9V8Z4rW4nUWzQh?=
 =?us-ascii?Q?ljxYa7PQNbVOvggMeZPI/ZSeP9woO0x2nhGR7uIGWmFUEdRATzFzxG3b3RFj?=
 =?us-ascii?Q?pIyp2qeVsZ+og69sefl6UzJWMDuISKOg3EIV9MkFDu3o+Mw4rInxucqPnX+g?=
 =?us-ascii?Q?IcA0aI4GbjmRNFahyeLa2pgzZREut27loF53HSS6nbA/P5tvpIeDYHGtI77S?=
 =?us-ascii?Q?qJaUrmEV2aPyUXxs4Yu5S57Ytt0zx4rhET9MBp7lZbW86rkcWDDG2/Tvih0Q?=
 =?us-ascii?Q?n/fkM6cTH+57upV1w0zTbdw6yAGhf4rIQ03qUiMfPvHrll5596UOT3sKyf+D?=
 =?us-ascii?Q?DECF1QdwlEOQlIhlzdAllMYpf+shHUtpUCeAc3Junbgh30WHIKXJPf3li+6Y?=
 =?us-ascii?Q?c+HxOfsgAkGE20bkh61+QVMDxbq8vTRVaK8k1E17wcRVukmMWZoRyHuXqSXr?=
 =?us-ascii?Q?neBVak9Lo07NJRVKKUmdC/lwMh+yIMj2zff8CSeOE0LXNzRQ8XCPzJsLheOp?=
 =?us-ascii?Q?vBSuPTJ6JX9f3grcHWgaol+EdouZa/RcoqdE+4zaf6dcuvWZm6JAeqzBpWMi?=
 =?us-ascii?Q?jjMcLDptvRvhiZRl15O8Z7iCM5VeqmNJ7C2YpdNMPfBcuxxl02ohjvFVTN+m?=
 =?us-ascii?Q?GWLbWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:27.9650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84814fb6-c926-4684-36e5-08de5d7c828e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6091
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

This series starts by replacing hard-coded addresses in firewall templates that are defined in
k3-binman.dtsi, by Kconfigs. Using Kconfigs makes it easier for someone to move ATF and OP-TEE to
another location, since they wouldn't have to fiddle with the firewall configurations in dtsi files.

The rest of the commits in this series add firewall configs to each device's dtsi files.

I have only tested this patch series with TI boards. For non-TI Sitara boards, respective board
maintainers are requested to test the relevant patch and confirm whether it works.

To test this, I used `k3conf <read|write> <address> [<value>]`. Both of these operations were
disallowed, as expected.

Changes v2 -> v3
    * Added configs in non-TI Sitara-based boards' dtsi files, as per Francesco's review.
    * Link to v2: https://lore.kernel.org/u-boot/20260121054712.176939-1-s-joshi@ti.com/
Changes v1 -> v2
    * Removed un-required empty lines in accordance with Neha's review.
    * Link to v1: https://lore.kernel.org/u-boot/20260112093643.885903-1-s-joshi@ti.com/

Suhaas Joshi (10):
  arm: dts: k3-binman: Use configs for ATF/OPTEE addresses
  arm: dts: k3-am625-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am625-phycore-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am625-verdin-binman: Configure Firewall for ATF/OPTEE
  arm: dts: k3-am62p-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am62p5-verdin-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am62a-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am62a-phycore-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am64x-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am642-phycore-binman: Configure firewall for ATF/OPTEE

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 30 +++++++++++++++++
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 29 +++++++++++++++++
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 30 +++++++++++++++++
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 30 +++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 30 +++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          | 32 +++++++++++++++++++
 .../dts/k3-am62p5-verdin-wifi-dev-binman.dtsi | 32 +++++++++++++++++++
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 31 ++++++++++++++++++
 arch/arm/dts/k3-am64x-binman.dtsi             | 31 ++++++++++++++++++
 arch/arm/dts/k3-binman.dtsi                   |  8 ++---
 10 files changed, 279 insertions(+), 4 deletions(-)

-- 
2.34.1

