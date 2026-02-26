Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9FFC5915
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77F083E88;
	Thu, 26 Feb 2026 13:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Eq57QrLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C77983642; Thu, 26 Feb 2026 13:08:42 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A2D383E81
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOgJ95maXFGRwO2En0xI/RPfPyXAiUO46cADGHvGRRR92ieEvPdxiTdOPhrKAUyltXUlFvNnrU/sJhkpS/ZoPcJ7Z9qX068VRNt4ZArPLnOc0I+QpyE9zjWgIjdiNF4q29DO/UvrR7e97arZ49g3UZrUvUokKr0aPCCKfwhMPhrSv2P5Ns63EMtQ5DLHdj5s2jZ2/oZU9CvBwwt1Hs+kCO5N/rAg+XlyNL4oI/PEP3z/okwDrDkJS5VXH3SWk4+/1veQh3OH7g4XN2dJsn3TUaj3zuv9vp/CsqY24l7KxK3FsA9WG0xyPQQSvxh7I8CwWauH8ks0qPY8DtKeieXZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JykcYFaMEueKP6rMj1HoyR5qUxfU+Ei9m2Rw2EBrzvc=;
 b=Ck8dVyzW9hDsSx7ltVAHPKSpCu7Zm4T47/yhIaaAqqHpLVp4fk07QhZlX5ICpvZlwmGAn6idoDU6mIHPGFQZbkupJg5d7MEICpQNpqeE1wS91EHyZbJY5hr217rKBGZgAjlmJ6/003067c2UpBR/2IIS8e+jVXkr/uUY66wksE8RDUCO0w7c0b98921fTo8E5Q6x5pFtToFhTFaZ8xurf0kqBSWkMf3rvmKkFKdpmC1guj+i69SFIyhDdJiSPJ9WtmAmeC5CJUhlOiEEN/5x2djGM8AZEy4xOPg2Be6j+iF5OGjLBCiPrAQb4XBtjptgLTEpqg94KPeZxO196z2mmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JykcYFaMEueKP6rMj1HoyR5qUxfU+Ei9m2Rw2EBrzvc=;
 b=Eq57QrLA1NdV6N2GYWAgR8wTd8jVrzGopMmRdoc31XKMwtL5g4BCU4JwbGtNpJYywOhL/LPWWk3g8ZGC/FEOxK1Q3gBD/yzoQASRUBSZ2AjCfmFv5XUtM2E3mnm7OSYj0oSeFCzldbbMKxVnEf1gTmKV6rr06fIpFIsa0ewvQJs=
Received: from CH0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:610:b3::26)
 by CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 12:08:36 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::c3) by CH0PR03CA0051.outlook.office365.com
 (2603:10b6:610:b3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 12:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 12:08:36 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:08:36 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:08:35 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 06:08:35 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QC8RJw2328866;
 Thu, 26 Feb 2026 06:08:33 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>, <n-francis@ti.com>
Subject: [PATCH 2/2] doc: board: ti: Add support for config fragment builds
Date: Thu, 26 Feb 2026 17:38:27 +0530
Message-ID: <20260226120827.2258728-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226120827.2258728-1-n-francis@ti.com>
References: <20260226120827.2258728-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CY8PR10MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce83e97-8bb8-453c-ad5d-08de752fc545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: 9wLhcd+UBbmDA0Yui2H5253by3LXioldd8YRg9ShgxwzOMJHlhQXFwLQg6fiZ53BlCjsKHvBTjOYM1MBaVaFIxzIBO4F4ASMOhu0hAsR60SpJ7udY0qCNksMpeTGN/FU7IdmHGM4pP65T/e+f1V2DqbDVxjo8hbTvWit6r+7TGLmE/I41+6DmopKE3fsquAbdDLuED3LdUzn5yW8Vce0jkmDFt7CqfwU8EluZP88LjKiGxZwJKwj7C3qp7tReS84YdUYuGN72Z7hZDeB731Co5Qby74Gdn4vlSFawzATNQk+vktAI5iV5zShacmBZm1LvmBUYIlcvCdx6uoncVwNxtwpb5gYcIp+oIQZJIalfdAHCVJz6hRIVTDhpVoHcmMl0Fd3UZSGSqtduq3D6bEBomNUDHn4TeapTUAjHgivspOfvZp6sLwzLu0xqAjDVcAebjdQTzI+MFx8+RRaCXd0YMJJ3lwsSveOKmJAerDh8atUP1x5mQze2ut+S0yCjKDGgS15pDXVwpnd4dbObxOSz90TPOHOYfissTEYxl0aseo98BXjEQwTUzJeNtDbiDAfJueKdOz+IigOAKgz6K56BmHrg3uyk+You+pprI+tKogtlSpvY9JVP+E5iI0gNMohvMyuXHEKzqeqHMSiyJVxNzpRne6UU2NgolQVqkaUrXbEm1E5UJqR+MBF2858YiqUxTrqZroy2MaL2eYb0ra15QMfkh6p4nbemc6GJz/ekXfyr/q8yS0WJjrA8NuQFpiRcSI9PKKPBvH7UKt8y4wilkQ7+cu1HieP90z2ZwGEJqdCkJ7fZrA+6mK0sZoqCKjqwK09jSmX1XbSlUiTDUjLKA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: juaeA7WAETyBMig7XC0OJ9pDMnw+IShVwyXTf9HSSO5ckY616/IXgDU0hg3LTGy9I3u1FSuPGHLY0gWBz9wYekYyX0PvL6XXHxBRSIu4aNzTK6+UEQ0EdCqo/0WHBvbz0ZX1OtwTam3NbuksJMxi+rpDP1jMP9OG+hV9o3+3YUkt3PyS3vTFJ9qiOc4k6FInk7xzCBmCoCBuOj9MHiQ7X8sDK6IMkUuyMLidjx/Y7qgX0ydY3Rz0Hmt8gw/VxFmf81kTS/aSbDWKcNQrT5BDSsD4N0ooEkshCQUBqsjA4yLfPEVR9d4oBCtRq+N6ZykYtTqdVSjC/0eTHMXqSoEbMkXgJDMYHHD3L1fNyG9QUMdtPDvHYjmQF1BEJN5+cXjBxACA/Pqxkq3uB4HdeqZ83lQ8voCapt6UMpaB8g9I+bcL0e8Ks5TKrmOmKf3h0BpU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:08:36.5783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce83e97-8bb8-453c-ad5d-08de752fc545
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7243
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

Add sections dedicated to explaining how BIST and inline ECC can be
enabled via the config fragments.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
New patch since v1

 doc/board/ti/k3.rst | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index ed04a57c167..4dae5b4733d 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -678,6 +678,61 @@ filesystem and then imported
   fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
   env import -t ${loadaddr} ${filesize}
 
+Built-in Self-Test (BIST)
+--------------------------
+
+Built-in Self-test (BIST) is a feature that allows self testing of the memory
+areas and logic circuitry in an Integrated Circuit (IC) without any external
+test equipment. In an embedded system, these tests are typically used during
+boot time or shutdown of the system to check the health of an SoC. PBIST is used
+to test the memory regions in the SoC and provides detection for permanent
+faults. The primary use case for PBIST is when it is invoked at start-up
+providing valuable information on any stuck-at bits in the memory. LBIST is used
+to test the logic circuitry in an SoC associated with the CPU cores. There are
+multiple LBIST instances in the SoC, and each has a different processor core
+associated with it. There are LBIST tests that can be software-initiated.
+
+Current implementation triggers the BIST tests on the MAIN_R5_2_x cores and is
+supported only on J784S4-EVM.
+
+LBIST/PBIST checks of the WKUP_DMSC0 and MCU_R5FSS0 cores and memories are run
+in the WKUP/MCU domain; this check is part of HW POST. HW POST runs in hardware,
+before the ROM code starts and can be selected by MCU_BOOTMODE[09:08] pins.
+
+Enable BIST in (:ref:`A72 SPL build <k3_rst_include_start_build_steps_uboot>`)
+by including its config fragment.
+
+.. prompt:: bash $
+
+  make $UBOOT_CFG_CORTEXA k3_bist.config
+
+K3 DDR Subsystem (DDRSS) with Inline ECC
+----------------------------------------
+
+For SDRAM data integrity, the DDRSS bridge supports inline ECC on the data
+written to or read from the SDRAM. ECC is stored together with the data so that
+a dedicated SDRAM device for ECC is not required. The 8-bit single error
+correction double error detection (SECDED) ECC data is calculated over 64-bit
+data quanta. For every 256-byte data block 32 bytes of ECC is stored inline.
+Thus, 1/9th of the total SDRAM space is used for ECC storage and the remaining
+8/9th of the SDRAM data space are seen as consecutive byte addresses. Even if
+there are non-ECC protected regions the previously described 1/9th-8/9th rule
+still applies and consecutive byte addresses are seen from system point of view.
+J784S4 supports up to 3 ECC protected non-overlapping memory ranges. The current
+U-Boot release supports a single region covering the entire SDRAM space.
+
+ECC is calculated for all accesses that are within the address ranges protected
+by it. 1-bit error is correctable by ECC, but multi-bit and multiple 1-bit
+errors are not correctable and will be treated as an uncorrectable error. Any
+uncorrectable error will cause a bus abort.
+
+Enable inline ECC in (:ref:`R5 SPL build <k3_rst_include_start_build_steps_spl_r5>`)
+by including its config fragment:
+
+.. prompt:: bash $
+
+  make $UBOOT_CFG_CORTEXR k3_inline_ecc.config
+
 .. _k3_rst_refer_openocd:
 
 Common Debugging environment - OpenOCD
-- 
2.34.1

