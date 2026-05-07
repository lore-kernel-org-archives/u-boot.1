Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCBBCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 11:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C832D84A81;
	Thu,  7 May 2026 13:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdmZrUGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F03C84AA4; Thu,  7 May 2026 13:35:04 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A37C84A4D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 13:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv1RnXUdgJDNraPf+yE50zvmXhAhgY86txvIA4keKIlMN3wg9W1B1/5lgsqpDlyy0vGt4g21s/rZnXUoTZkrADh3gCJ2GT/jktySbWlPOpTSLT+WyY9pundrt6g9SRgAhFvJFS+uM58rLCwLUxSn/+VCwbMYx/fQ+GnFR4ylAziXdnz+tFRDgUL0RMqwnwGgzN1xt9cf3UnKGU7MOJZmmV5jKvtbSd1kwmC3IwwbzGeDcfEWe2Nj+0yF+UM+yZzKrsuXa4V6PiU2AJSGBIvsdvN9ye9S818XL/DMc5Nad2Er/LQAe/shoLEKW7RnYnANwcuPWIf1wlp20ETemLMMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up6SOKAkm5a2pPLK+ivH4mcaMwK9j379ikRFaH4dqhQ=;
 b=iqLc85IN2YlVP3V3Dh5rMf0E6LjPMrb1jKNkE8uZEhtaA++1SqVnLU8NQTiU5uYrpjqpfSGwtD2WAgczbzS/KxUOY88rBVpWHnJimAT1CtTxgsr/3wklanTPVj++ZQsoMRYylXFHVMYnB4ggqIAIErPSTtf+GkJQBvgvAG00H8oqxfqE6CFwh5i+h8JlWKeYPSVHSjLGijcLR+c+DNFcDLRgub86PacY65tPUy4H6Izjonio3D3aTZD+jbL+UA6gQJnPaDGKPrh427JY2GOKyqwG8YEZ2ip8Pc6VIE0shsXPOPsTF08qVsKGIm6Nj/AE79n0Igpu5AYqBYqJG7G31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up6SOKAkm5a2pPLK+ivH4mcaMwK9j379ikRFaH4dqhQ=;
 b=WdmZrUGUBkY+BDlvHj33qkAXDD7+fHU+C42IAYSn3Y7IQl2ex9fNqdYl7A74MMJzvp7FL3JHMvho6VztMjN9jyPrZa3r8t05J1vQnv89FjF+IZFG13x4FMQ6/OpyU68FeH11VuC6zaC+ec/MkdJSEJ7dXv3oVtlAoj1WxRdjbko=
Received: from CH0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:610:77::34)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:34:52 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::b1) by CH0PR04CA0059.outlook.office365.com
 (2603:10b6:610:77::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 11:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 11:34:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 7 May
 2026 06:34:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 May
 2026 06:34:49 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 06:34:47 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <Padmarao.Begari@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>
Subject: [PATCH] fpga: versalpl: Fix unaligned buffer handling
Date: Thu, 7 May 2026 17:03:59 +0530
Message-ID: <20260507113359.3665220-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 143b47fb-4c1c-441f-e56d-08deac2ca730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: FJR2Hf++dTi1OmAemAREY9zxf0l7UN2uBtRdyoEFRN5cXIwuOlZNQTIu9fcyNwWOnsWiFafwyzpS6byb6ho9En6nP3BsHgum/dlBQNdj9tP7SXy0rwrpePcB/GYQ3TtgZEt8fn1NwAAKyZU3EwIdiz1n/8FpH2S0SEHxgdo1+5/sTY1i28XGIrDyeTNTT6y3E90Acwbj7Bnkmia/2OptWsZFeFgY9KaarW0SArL2bxyH4uBchVxSvWYLlX8fbRru2rcXOQnOW+NWDc1h5XqPBBZrr/8wfcYqiYpHPCmEntDMaDlq3J7RHp2E2tdHaImiHmTqXIK/uVMqHIkfE8TYFTBwgLGuLSHsYawsmzmz7Rf9IjCFF1S0zY6Dv9Y8g4lwpIb9ONSRSXhSanarn3VWbPIoudPwUrM9m6GoLHI/VYHPC1g7z5knaTcAViWeGQd/VI780gH1zW5Ow84DA1lM99Tu3tMy8PLAQnCZNpVZvg+sDPYo7j4tVakQztqK8QJ4HMpfSKho8CKCLyt3UlJUKWGRtnI/UZiq65OFmibRUJn/RKnJsF7QAOZW+FVA9STYX0UnRqWQzR3HvmFB59UgjYVGIaaro2nCPuNQGsyNAjPeoi+D8B2IvCryOsRbSea9Dx8PIwi6WddVsibS7FyadlbYqhhhe9YCgkfzcs/pLcgCamrPk43lZb+Ou1FULFvYcA1leFvYTsZ01zgiXY0p4vIkKoOVjY5mru08sVzWEOE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8LBX2XVktxKziDPAtNVLB6VbGYb5f293WPk/PI60Mtg51YFEOZIPnvlvZtXnwk4UJcP9JpdpVNx4K0wJeVqYEGA4zofvDGRI12UL+NtfAGcli909vV/YJ8FyndPp9FiUIZkBAmr3pPcSD/cgZRJCNgepKx4G05Zkv6k63SxU98B2FZ+fqr1CY4W5UlYWz2FpSG2ZVmggLCCafv7ERukhM9/jjswwzb3XZD3uKrt4jNEHX2C+P9QH3SnsOCNena29aOJKFgfl630hHEZ9a8IQ0ET8MU3FT9IkvJn4C13C2+iu0CTznYm7jBy3bYbuCT/0XqZEuLDeIOyWOJavzwPfv3vG1NcFPkfWGPvW7g7xAoDq1wepnJXrI0ZnzzsIFCm2Bs0dEEiQGrIDYDl+00ICRIM+im1Sqnaw/A2+CEm/IzBQuAYfE7XFHFs0uUF5Ma9e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:34:51.6446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143b47fb-4c1c-441f-e56d-08deac2ca730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497
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

When fpga load is called with a misaligned buffer address, the
versal_align_dma_buffer() function shifts the pointer forward to the
next aligned boundary and uses memcpy() to copy the data. Since the
destination is ahead of the source and the regions overlap, memcpy()
produces undefined behavior; in practice U-Boot's generic memcpy()
copies forward, repeating the first ARCH_DMA_MINALIGN-aligned chunk
throughout the buffer.

Replace memcpy() with memmove() which correctly handles overlapping
regions by copying backwards when the destination is ahead of the
source.

Fixes: 26e054c943a7 ("arm64: versal: fpga: Add PL bit stream load support")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/fpga/versalpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index 630d1ecfea3..3cb56cc0dc9 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -17,7 +17,7 @@ static ulong versal_align_dma_buffer(ulong *buf, u32 len)
 
 	if ((ulong)buf != ALIGN((ulong)buf, ARCH_DMA_MINALIGN)) {
 		new_buf = (ulong *)ALIGN((ulong)buf, ARCH_DMA_MINALIGN);
-		memcpy(new_buf, buf, len);
+		memmove(new_buf, buf, len);
 		buf = new_buf;
 	}
 
-- 
2.34.1

