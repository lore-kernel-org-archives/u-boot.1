Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE37C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 15:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CBF8209C;
	Tue, 15 Apr 2025 17:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="G9jyjzOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7194F826AD; Tue, 15 Apr 2025 17:13:02 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E81F81F54
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 17:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwJXna4oJTcvEGyxa9LkKqDpe2qwD/Pe/BucfTUryF1FSD/Po5PS3GtTkvVZ8gKliUoR0+7c4wgY/2DKVC1v3xvwVmpGCeiQevV/lr4buB9H7ccUZm8v6rY5uiDsYXGk3bHQakOk+IWbaVmpTKvY2HZCt/9/Ge4GLUJODeOd/rDD2pQ/iI5dY6VQk5trXVuIfiucz8CX1ptREjtepCzplKMpR2qnOfQ4wG0d1FkZFX4mbIR3kibBJyWFvA4wnqMMnX2TDD2h76pqIz1wVe5V43miDAERLq8DQ1u66p3xnrEHGZPMin/2GNMXF8SYmS9a8ct5pSuSxBMg7JtRHhIcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMGvTblzmU4dcHt5GYKFNn9WVcEMm1YO8A5mzP3ras8=;
 b=iO8CRYmNJyDJXSIYhH+nWfWG7j89DmRJ2ukLrxN6gzrjHNOkR9u0mXeA3a/mRPCES0w0AJGXDdGqk/8yLV9OHZkM189DlYAmcXAFvvtiWNj2T4zImgYZTSofb8nlJf7iZoNRShswq7SjfE1tT0fsCu6YJKrcZ4Ha+hOja7cf8lX87Jq7jp8spGeRv7ZEqA4+BgWer7YVos1tzhdx+JZB9NpNEkj2fC3iif2pBTR+2fq+Kk0ccPmeo62YeOuPx4oaO7Fol8ahKyIgvBmmeii5eJuPj519n3f+uk6xz1L6VbsA1y/yhFvvSOlCoaVp7RP/fkHn829emBv6PWC5Hjd9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMGvTblzmU4dcHt5GYKFNn9WVcEMm1YO8A5mzP3ras8=;
 b=G9jyjzOHf2Etzo7XxIFJ0G/lAyWrQGC8zlT541DVaRwg9WAlpUpdOkvjNAffZVinTmdlX8QEEcx7CNWVVDSuO1n/2B8oULCNvdusD7GtInGY5v7i8lE30XGYR8EJXWqXfiTylyrFodRJItTl8Zeg9jB4aNtHKsFnzjEGvZW9CgaBf0/obPTR1/q1h8ofZbMpaUIVy5X0bodlO5pRXcvPpeRqv4yB4/PJ0wMDAb3aslpa1S5JBSk56qqw7T30KPs0FKJwFPz1v+tQcCA2U+80T6HPGVDqrgPohm2jEktJVlFHW2GEGqtcqZ1mhpzsZXxFdJukv9XRwlvuwfKASgAR4Q==
Received: from DU2PR04CA0278.eurprd04.prod.outlook.com (2603:10a6:10:28c::13)
 by PAVP195MB2263.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:2f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 15:12:58 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::b5) by DU2PR04CA0278.outlook.office365.com
 (2603:10a6:10:28c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Tue,
 15 Apr 2025 15:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 15:12:58 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 17:12:57 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 17:12:55 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <u-kumar1@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <n-francis@ti.com>, <u-boot@lists.denx.de>
CC: <w.egorov@phytec.de>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH v3] mach-k3: common_fdt: Move carveout struct
Date: Tue, 15 Apr 2025 08:12:41 -0700
Message-ID: <20250415151241.3128391-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|PAVP195MB2263:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c279974-c4df-4e6a-fb41-08dd7c30016f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ml+ZThJdifLqRh/Lkv9WbV6Wc1GHDywBFD9kx7qvllk+AhHDsbJ+jm49SvvJ?=
 =?us-ascii?Q?5Mshet67wzDzQxvS46gsZXEdy1k94VzwNli5BaqXe6s7X/bMiHGKNOKC6UwS?=
 =?us-ascii?Q?37/KmXoVJc7EofTp0PA360dW0pJKYwFi1eqJeHuUvzv5Bz8G9CkA7a4smI24?=
 =?us-ascii?Q?QN+CFituaWy5qpptuwtG7Vr9vin2XG2Yq9grkHUeFpq8sxCv9c84BBDmLGoE?=
 =?us-ascii?Q?3BdhD4Jdzs5QctCmQzcJA/NA18YOp9yzTJISakWYKSVlwwtsgrQ7KLlSjl2W?=
 =?us-ascii?Q?tcD0scp7ymQIiM8Mxu2i+uxBjOhfLrb6m99zkC/nVctMj8vLFicZK9Y8YdgU?=
 =?us-ascii?Q?7IHs9WfR4PRK/FAcvA5zqfiRfWBeIETkxtabiR2W0mwHRC6gT8vagVpqT+Wl?=
 =?us-ascii?Q?olaABCfwBE4oGoBiySxkhljXEG38VT8BZnw0hEBFlC0ioWoNcQGOsHoWk5zo?=
 =?us-ascii?Q?PKJdsI1yuJpLi4zSa4IAoWLiW2T5qjoZADxj3Oo7VYh27aPUlwaAnYRiEOKs?=
 =?us-ascii?Q?bwXqJPMjg0xdwQebYwahokhHyNVIwE72UNIGMTFHhSG0HC6ZriBx3sLVjfji?=
 =?us-ascii?Q?OfPZDxiwKHOdBwo9u/Ev1O+6gurKoxZNDhzo0G+EhOdo4/aMD+C9dB1voBsp?=
 =?us-ascii?Q?51kGlk4tl2tYREwy5y0YgP3tc9N1WXZTfrQYb3CVEvhVILDnByASmzKHEuew?=
 =?us-ascii?Q?xNvhQuaGU4VuiM1hR5N//pRE2IN9JogfNUV8SwZSgIrIO6QQTvgDFf065ERu?=
 =?us-ascii?Q?Orh/LZ7TTp6TB4iYTjtYjlgN77DTIKekwgnSJGqCzFfh45ZjOXaK8/Ayuem6?=
 =?us-ascii?Q?v56dY5eyECEZmyof5bs2kuhwmC9u7nFz16wJmSZ7frocacSDu0sDOwlzQVeg?=
 =?us-ascii?Q?rDAjABQrpuj65J3USUpBdSXsJQm6YeZdbtuPxDzNpxYl4UQnxdKlIcwzq+Au?=
 =?us-ascii?Q?FLeZbCCCq6ihLG5ti3HtEuh7Qzr0gNx//bDhLVcS2GmiBhNHmw2uU1V2JWLH?=
 =?us-ascii?Q?+28M8nv4qRAcXvXyCKxLOWvVLHwv0iqZIpdZooaX0DFAV1Lxzo/MgjLuswe5?=
 =?us-ascii?Q?86CEEtfvt/vYh+LpDelDnLgRE6wC3KQJaYpm/bY6rNTm57T7ZNiHILzvbdZP?=
 =?us-ascii?Q?jP1cc6SstAgDBpIagVbi6Ra8Fl8HgXtMnaaqs84ha6INF/Z6MQ/nZxE2ZFfm?=
 =?us-ascii?Q?wsxqQlTYMXXuEDxiyO90m13WK2hpB84xG4fG6nC1sj400u6WCVqyZyPmI2nc?=
 =?us-ascii?Q?paACPW/i/Ki8CglgOam5X07joHZH/VvYvsU0fy9Bx9PwGoBVD9Y1BMWSO1ER?=
 =?us-ascii?Q?KVi8cdt1QFVu9p5GEn/pub5KSf+2aBjtpaH3rVZOOjGTDzRSQ3kMAolbbAKJ?=
 =?us-ascii?Q?UIBSe5f0jcpzpfY+V9M/D2WEWQIry82ARhJJbHGzZ+sSoaYrYQemGDkzu5nN?=
 =?us-ascii?Q?0sGLhfwIG61sVM/QyAK2zu0itkqwtfDwkJISvkwEkq72U7rRl4mSFOz+ymEM?=
 =?us-ascii?Q?7MKALBpfhJEt9dq/Km1ZWBICFWqmlQTiEkwV?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:12:58.0244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c279974-c4df-4e6a-fb41-08dd7c30016f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2263
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

Labels are not allowed before declarations. Move the carveout struct
at the beginning and only update 'end' at this point.

This will fix following error:

arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
  156 |  struct fdt_memory carveout = {
      |  ^~~~~~
make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
make: *** [Makefile:1919: arch/arm/mach-k3] Error 2

Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
Changes in v2:
  * Moved carveout struct at the beginning instead of adding an dummy statement. 

Changes in v3:
  * Removed .end assignment from carveout definition.


 arch/arm/mach-k3/common_fdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 361b0c0b31b..867ed173142 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -119,6 +119,9 @@ int fdt_fixup_reserved(void *blob, const char *name,
 {
 	int nodeoffset, subnode;
 	int ret;
+	struct fdt_memory carveout = {
+		.start = new_address,
+	};
 
 	/* Find reserved-memory */
 	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
@@ -153,10 +156,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
 	}
 
 add_carveout:
-	struct fdt_memory carveout = {
-		.start = new_address,
-		.end = new_address + new_size - 1,
-	};
+	carveout.end = new_address + new_size - 1;
 	ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
 					 FDTDEC_RESERVED_MEMORY_NO_MAP);
 	if (ret < 0)
-- 
2.25.1

