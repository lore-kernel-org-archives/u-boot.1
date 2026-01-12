Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F952D277C9
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6B683B5E;
	Mon, 12 Jan 2026 11:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ENR5vdkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8F7800B6; Mon, 12 Jan 2026 11:11:20 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F8F83B5E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB4PS2dHUfRCn2JhrzD+ocPPYVGgo7ApHUok18HoW7zXiSm+smADUexsPpQS9sFHC5/GpYYU1JGxaTEB1nuT0rRbhNeuHwfSfGUc0BoM8XkTiFIFl88HqoBZ9xnIW59iSu/FaCJiNG8IbcmLFHolOjS5LhjwJ9YfKyi2zhirSDgf86b5lP9LJAfxN9GYRO7mhoRtlyXGytJtPkLcsqmjB4Lj64rr1HEKqWidGzKv2P4AT69tOpMXN63cPxsFu0tT6I1KuqggY1euyGu58JILN1+evyrpg1QIumNZKay+7Yy2Dhh6lYsS2EB1ZwIDVkx5X5ZmGODjm/Tw3JhhNNvAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SA/4EjDGinCu4MB1rnwBRM8mv2OJLFxIIKm3S9gnU0=;
 b=rVh29oq0uTu3UFl1MzHCwrzZ3m//3eykUFZ/br6iG9Fy/Og/JOppDRxVKbxuAUxSJOZWl3Xqeoh9yAvI0AzD7UdJR5EG4+zpPg7B3UDsPr1SThuHXX/fflLQZRbMnU6VY3JWKYAHoWhPYojPy9C8SQ3N/fKcgxqpmVsLAH++sV0g4DLAGW8c6qYNIVaue/jFiRJCr8iKmx3M2OxyEvwqqtZTNgvom66DfqGTZlAxiwbMRw4HcSxrI5drRiM9cbgX+ehyOFyKBARnItRgjN1h6MYh8SbOhgRKOuKMaOBZYWHkfkGGabZxdcQsxBiOdf7JxJNCT3RoB/4SX3mTv2lNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SA/4EjDGinCu4MB1rnwBRM8mv2OJLFxIIKm3S9gnU0=;
 b=ENR5vdkXaoBK+Y8bdmrlnsuNPWK6q01jnQ9W48ssTsnpgtzGroYKHCYgsTRHF6RW45FH77T9AsxYoW02+dGMA5/7M/vgr1S+l0gphl+XALRacbHloSIo4dSFPDHSGx1flT2ashUlP+c3L5q0WiJKCDvFAfHFpLePLfayBSFM0XI=
Received: from SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::10)
 by SA1PR10MB5757.namprd10.prod.outlook.com (2603:10b6:806:23e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:11:15 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::5f) by SA1P222CA0128.outlook.office365.com
 (2603:10b6:806:3c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:11:13 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:11:13 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:11:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 04:11:12 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60CAB2fu322683;
 Mon, 12 Jan 2026 04:11:08 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
Date: Mon, 12 Jan 2026 15:41:01 +0530
Message-ID: <20260112101102.1417970-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112101102.1417970-1-b-padhi@ti.com>
References: <20260112101102.1417970-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA1PR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 44308caf-461a-4573-c012-08de51c2ea91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8zDjK570n35nA9oGFZy1RLUN05rN83L9OtMKVAV3Pz2qkrmF5YXa/9BIQt0V?=
 =?us-ascii?Q?FOtQyzxXYmCiWoL90e2/c0sIaFjfaN+V8g5GMfm7j0AesAPHA8FWhWhusoeM?=
 =?us-ascii?Q?nxii99vj8auMP3//qwiHfshbmO1/97XXWjPUJ/pEAKnbHIofmu7HzLBpXiYd?=
 =?us-ascii?Q?tGlzTsbNaiBF0tTuQHUZqHai9Z3GRcZV+KI1YHipEwEdowtPGXMb7rF9PMTL?=
 =?us-ascii?Q?mCC71lW8itmD4NLpf8Z1JBeyUR2DHBYcDePjdkuvHmtGDnMEi/FMxDwIu2MU?=
 =?us-ascii?Q?6lTgtcESbjUEouaI5YMVbJuLdyCeixqwuU0G7/vuCjWZIOV+J3FzFUp7DRcZ?=
 =?us-ascii?Q?MRWhrdpqn3UQuxjWG/Zx4o38J8qde9gH31tVeBvELu8WYyynCKArAxkwTk++?=
 =?us-ascii?Q?8m7f+xi2jdyuCH6szrxpk3jKsDE9bkNCxKYdi2ubXHzbFJbHlkwEqW8Nd2ym?=
 =?us-ascii?Q?PNgbbQ1VpBMS3J9f7C750seNDYoeL/ucD70N1QpnUEbBpDJV44X1NVMtFCX0?=
 =?us-ascii?Q?MmWLgu1x1H8dj7cZc6cNAVRpJyJIpbxwpH4m1qnv4qZ0EDUYX1zt9NxEVlNF?=
 =?us-ascii?Q?PAW0l5ilSQB8wxfhmagj9zjUWJrlFv1f7j+Qns7pTWD70tbM7F/B4KJq//Ug?=
 =?us-ascii?Q?zAj78zKBWpMFGPolyjcZKKQSlmEZt1c71hW+o3JTqVb00rwWYz+mOi4M4OSU?=
 =?us-ascii?Q?3ZD8sk+Bp+HGrT1P2jKDFc07t+Q/6Rh+uQAnvbKjD/FPJCU7043E6yEyhSnT?=
 =?us-ascii?Q?nRBEjOh/M/PTZlu90+VKL2zux1CEJLcc1frSkyfPoPlV3uYxlgDveRWQ3WGi?=
 =?us-ascii?Q?BZo+ZStXgWUFQwnavqJjVFpjMMjNCJwwKzfCDD6ehSVtKZFj8lyrVtecQE1Y?=
 =?us-ascii?Q?KES6ur6E04zua9rJEagwfGoU58b8399LV3YoCilUUv0F3HSWo6XSygi9qxHT?=
 =?us-ascii?Q?ZYz9dF9MFcNV66UbA/Ohb/e9z5YhOLGvvbImD8I10HfMm7IaidAItarO4OXf?=
 =?us-ascii?Q?8SOiHMWaXQ1IHrKKn05gs6m/FASHP9al6VumpkUhuu/omcUhyojjBbftgSa2?=
 =?us-ascii?Q?s7m20OtaIzKbMAFDWmHeWITkrSufXGjiHVDHaiIb6OHzWS8K6Cfwa0xqyDgF?=
 =?us-ascii?Q?Va6q2px4dIvsBsN6Z71bt01zlBYVwcN4qNrGfr79gKbbzEm+axHLcU3ENb9A?=
 =?us-ascii?Q?icPMbthjYZ1vfN1G77vqPpg0njF6tbNuVkaawt0g4hlhZlUwC3+DB0MwHnv0?=
 =?us-ascii?Q?YLZ7fJjkSVdpffTuice6UEoz6IBBGZlwKw9l7os3GEoDfw42ASaaoJGvOyyV?=
 =?us-ascii?Q?VrthVotDysusbXNH5u4yA6nWFN2kCrsLHJpKCAhez2PXUrDmrkEXEXpuUmRJ?=
 =?us-ascii?Q?6EzbtmkMc7sALGQpgZgHAsy00IqhDxjc0gjLWv+iWkcBiNdxdzSrTEcznLrt?=
 =?us-ascii?Q?LBM0Fiu9RvQ0OlR4aKji/N3pYN41v4Eok9z+8Q4E61+uTNiXbtR/+Yiw31Je?=
 =?us-ascii?Q?rSw0lbkPLV/KyUXoCrSqBeYq3Yz+5noHhrW4e91kGcuXKgESFbgnyTeIrco+?=
 =?us-ascii?Q?IS9oC0sFY5K7wy4SvkYC14c3OBjTNbefgFbn9Z3G?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:11:13.3441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44308caf-461a-4573-c012-08de51c2ea91
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5757
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

Reported-by: Anshul Dalal <anshuld@ti.com>
Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
---
v2: Changelog:
1. Carry R/B, Reported-by, Closes and Fixes tag.

Link to v1:
https://lore.kernel.org/all/20260109190026.58464-2-b-padhi@ti.com/

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

