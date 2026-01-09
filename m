Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E24AD26D94
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433CA843C3;
	Fri,  9 Jan 2026 20:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OHABmrzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74A3843AD; Fri,  9 Jan 2026 20:00:52 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazhn150110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d90e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C924184371
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJEfem+1yHbQ8AhQv3kyZJT0HA4uvyvJvPmu8jACJDp3w2FtGpbN3kTp0lcp1cF+nZrYP9tYBO0MFN1JPLe1crIEk0pmerIqkRpbJNcx+Lol/H8JIhYd4ub5KzLNF3utL7UeT6LR1yDooxknHuo8oEMZUSfM580GS9qaxswmDUooyTv6QmUI9NrpnE6p11WLyoxRe1eN4pt+Yhqa7oGfgQHzblbVSVR6gd58Z0FDOBQKlsBX9cBAt3w/6yspD7MTolCVqwa8JVuFDFKPzCWQwC+E1Fe8MYPhvE8Zmvec958lt1VCE7WjMPIiZfkK3leoTGwi/fXDDLbO+14jDMmWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nls2D6r+eW5U6BYet1CxtRO7SUwMf0OerdzfZ2O3DKU=;
 b=YWfGY9ATqb0Vd4/bQcoyxPFLxVCbMrbEUnAmhpQJMMawGPxUBlPBhPQiQh0pRObLxH/VAbNF3j+9CQYIDqOPFHMq3oIncTdc04L70qkODyo+Tul1H21wXs70v4wjSjUqhC9QVzyUZxLijOv9dAZUY6MePoAeksKL10mIicGGIjQn6EMhHEaByCArNAJDWmOj6TDbVfTbkqgb1vhTAKf2RYa3VLaV8hbwYW58G79AfmU/auPUTixsAx3fFpRkO2/g5DPVZIKNINzf9kYL+6skFRrmLKje7ZdLF0VdvVDAyQq32D/wiY5pOflb+zEsgSGnuQyShsEnHjbqeFV8jblRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nls2D6r+eW5U6BYet1CxtRO7SUwMf0OerdzfZ2O3DKU=;
 b=OHABmrztJRCcCD0t+j/G9A12TkkpEUb04j2RIImeEkl28hgP4eB5Xd95aAIUzqKdt66Vb/wqKUOdE1iZcRvgcBnlV09aiEpluO0m21XJCwuiYeqIFH8qMrXwM6ar/zre04162MuP/e4OqhM7JY+knOSlgI9yRuqY66ZDdoeb/y4=
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 19:00:40 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::87) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 19:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 19:00:40 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:00:36 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:00:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 13:00:36 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609J0QpC518987;
 Fri, 9 Jan 2026 13:00:32 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte within
 multidtb.fit
Date: Sat, 10 Jan 2026 00:30:25 +0530
Message-ID: <20260109190026.58464-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109190026.58464-1-b-padhi@ti.com>
References: <20260109190026.58464-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN2PR10MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc7b62e-13e6-4adc-0565-08de4fb161c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r7wnIsrRYKA+3C6eN0joNTprEiz8RdjNLGJz5SfeNZj01vkQ7K6hE7JkZuZT?=
 =?us-ascii?Q?2Gyr+cmawk/TumQakFdZquAD3bSZu+H8GBNl8BehnvHFlc8psb5loLuS3OQ2?=
 =?us-ascii?Q?MuaFqmIe6DjoNjVGCfXFJ+KIdEPiJE9ef0u5V5cw7/CXrewFV4zgSbTX8n0g?=
 =?us-ascii?Q?8bMz6enX6DO582OwEX4N+SjTmWfjSKa51m86jhrU0ZNMlRH+M3/3BflvLCO2?=
 =?us-ascii?Q?2z2tkI+KE7018OeEdLU5t+3eJ1Fxlejv3YmtiLsQotnP6s7x5nRa/0dqHc6C?=
 =?us-ascii?Q?thpqzzxNE5uYSqFKk+jlY9Ob2D6o7QeE4ePLWc39EiLcyaWdS37N64JyVMnW?=
 =?us-ascii?Q?Jl6+/oHwM9r5Ryq96e4J+W8k8xCWtK9vJ7dNGzAxz1Z3KrdYlft0wriX6PK6?=
 =?us-ascii?Q?fZmxVSiCP0SPnW7on6l4um/GRy5VGxhYobv0nIizXqZdAGO1svdkJibOgMT9?=
 =?us-ascii?Q?G1tNW1timImTTGgyl2Aq1YyFLfDSLjusNLz/ABfb/f1s2zvTLLHHVaLR2d8k?=
 =?us-ascii?Q?38oEM8W5XRU4Ic65Iks5UxEU9ZsKM+6l6nJ6g8BbMhCUVWZHgYoKB8rRRP/M?=
 =?us-ascii?Q?tcEYBF2/gjML58fJv5GAIL9EwMCWRi1rBvAbeX0di+09mad/A/nLLAOsioBJ?=
 =?us-ascii?Q?LqenbGWHOtcsKb189nQW15gK5WhBficL/IMHSFA73KTpobEEB83ZOeebkHzb?=
 =?us-ascii?Q?xF5muV5Uo6SP/BV0iOzv2USfLUUrT3f95PYGR5zZz5FY1Mocm2u9Db89C5Hy?=
 =?us-ascii?Q?Vts//dCP3HmVYu4b1/q/0MDHEkjA2cNST0+kJAIUlQcUy+XXuYQ4jY3y81UU?=
 =?us-ascii?Q?JHqcXxboTL+9TiHXu3uOcUUDz1hClJz8hBeo/EGmVygEK3NWUspFc6D6A7bP?=
 =?us-ascii?Q?faVudPYXnexmP4/zfYkBHwgbOECHGtp5P5t1PSyS5Q72dpgvMDFln6iV1lqZ?=
 =?us-ascii?Q?feh7umwlR5PpOl85RJeiri6Z6DFPLf4MV8T762WXG2yX8l4CqiaYm53rwsci?=
 =?us-ascii?Q?VpwQo12kaZGxasJKIUtWKryg/NIaXKxSrEsKJRZrp2SuyJnpKuikZoObXp5r?=
 =?us-ascii?Q?E/qAbKAIjd1Ty7k83De9TtykcA9ShgnSGPyU0FprCB0cKlMbGivWuUef10w1?=
 =?us-ascii?Q?XASylE5iUa6yHhZWVrGfMegmgiyjJx7fnW50da5CLRGNe5LSDhXd9zS0rcgR?=
 =?us-ascii?Q?Bb5T33nrPBtRM6rRp1rAiWiEiOCQASf1t88OVbc5p5/bIGxdgpCHnER1pBTJ?=
 =?us-ascii?Q?5EvZw2OvpAqsrZ5htHn6W08Y8kkRXB8CW05r1fcrlgYb410ouapbuRlIZEQ+?=
 =?us-ascii?Q?vYBvEHWAZqpstl0muAs59A462CwFtDVofZvK7YknBGxkCuhiBrzNudQFwr4m?=
 =?us-ascii?Q?Xuhj+ycom47o3kq2I0AUQw8CvpIgvoeKpUE2gUcVoQpGaS1sZzQ6IbFzTyV7?=
 =?us-ascii?Q?UD0k09DzxZ/aQXLTusitYQIe3t3VPblZEdrvzPG66A6fKapa/7Buz5kEVx2z?=
 =?us-ascii?Q?AsFt6AZOaykq6dt3L6TNRABbLHlRVD+GwCRqbIycP61QEWHWf1LIF/NaufPD?=
 =?us-ascii?Q?e137WfqOolKi46Q7lxk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(34020700016)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:00:40.0123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc7b62e-13e6-4adc-0565-08de4fb161c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
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

When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
packed inside the multidtb.fit FIT image. While the individual DTBs
and the FIT image start address are 8-byte aligned, the DTBs embedded
within the FIT image are not guaranteed to maintain 8-byte alignment.

This misalignment causes -FDT_ERR_ALIGNMENT failure in
setup_multi_dtb_fit() when locating the next available DTB within the
FIT blob and setting gd->fdt_blob, because of the recent libfdt
hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
version v1.7.2-35-g52f07dcca47c")

Add the -B 0x8 flag to mkimage to enforce 8-byte alignment for all DTB
entries within the multidtb FIT image.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 scripts/Makefile.xpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 5e65d7b2498..1183f5180ba 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -602,7 +602,7 @@ $(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_A
 targets += $(SPL_OF_LIST_TARGETS)
 
 MKIMAGEFLAGS_$(SPL_BIN).multidtb.fit = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
-	-n "Multi DTB fit image for $(SPL_BIN)" -E \
+	-n "Multi DTB fit image for $(SPL_BIN)" -B 0x8 -E \
 	$(patsubst %,-b %,$(SHRUNK_ARCH_DTB))
 
 $(obj)/$(SPL_BIN).multidtb.fit: /dev/null $(SHRUNK_ARCH_DTB) FORCE
-- 
2.34.1

