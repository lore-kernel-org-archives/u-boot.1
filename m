Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E46C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 15:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F1834085E;
	Tue, 18 Aug 2026 15:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcegbcozrdef; Tue, 18 Aug 2026 15:12:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68A8140644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787065924;
	bh=F8jfCm/rN8cMWtbNW3uM1qCkiVaMYl+Erq9AvftDT/E=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oz8xnsg50hQnswPBVHYWj71kJe2sNssfYmAVNbaZnHisjxplJACTCQt9RhT51Ef61
	 UDWjKMEHuvutxbKeNNU8lNDZt1t5pOZMauQpkY5zoB8Rk2BkOQjSuNadRwy3BwaHoi
	 Qal4MagKNBppGS6onrO/o4m5Nf1BoW6iZd9sk6+4SBRBlrEA4khLHP//jB38Yzfqce
	 Vtptt+xSXKYlu/ySM61tS6Fghqj2pOv7f3javGxHcdtZ6h5DAPuwuEYhiiGATX+Cad
	 AegeHE5MvZ+D9faQrfJDDUwKKl3SAPdIHxbpFP6N3KgUSDdMsbufEHi78mMhiXyamz
	 kUm+vqgJLoOZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68A8140644;
	Tue, 18 Aug 2026 15:12:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CBC8282
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12DA380CA7
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7y3AEXpp4HxH for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 15:12:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D44DC80C66
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D44DC80C66
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=FKXN4lbO
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D44DC80C66
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD4D2EEK7bVDH+hVnzMDwOaJBfQp9BmKgsqMXUZ24abrirVAhYL4A7b/AMZ3sGLZOoa5SDudm4jsrSP5wsoQhxz889sKC9zAioP4Rw6E31pneIDy5O/3TCsy8nMNqJMe0Px1DPzAN6a1LQoq18kumfCkYJ33icOcyh/LU3+N521ZCNXwu8D8n6CxWChMgYH4lq11vE581oJr6fH92jalE4NVTMtRBMtYr6F29VeFLkCzNt8L2MJ4FmBWLn+YwGUsheFOJwBDK6k8umTyI+9GGfu5X6D3XeNk+ROPXnvBEj1tXJVwG1o3n9DyIJsXtx+ME20rkEi36Y9uAfsOzs7OnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8jfCm/rN8cMWtbNW3uM1qCkiVaMYl+Erq9AvftDT/E=;
 b=w46ZrgG7AvQdZ8p0wlEU8GGYKYYJ+jNQ4H9wMe9oPYjbpX1twULDlwWIfLULviycCaEdr8DM5t5YUIo8GOJ6odPqZyzJZNrkX0morWheETT7D78sFil9KlHITW1n9H4cNKGbIaN1tXTjkEzO69uACyLxlXGrlcoxAOSCL4kHsDy1Rc7WCRYAsMwpkLLww6DscLUSVuU29UqPwYZusLy5n5Y1SgS++WosRwEDjUiTkCGDbOxpBlfWNn+lRUCIwGTfXYaVh5sAvKxe1Aj7R/koV82J43OZ6y1fblSpADnSM6EdzE2rGdxRZQuIDHOf3td9SjQQLxkB9JSb3upsArqLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8jfCm/rN8cMWtbNW3uM1qCkiVaMYl+Erq9AvftDT/E=;
 b=FKXN4lbOAhRCCgk5PZ+THzanfSmdTMlg3fm+qgqwQ05BvXTZC4x3/plT4uTmGSVkel9UdXbrdYsER2FImPS0RtovQW/9Y70He8ZCVWBq/o1nVtu/Br5QNLzW6jEalpn+djC6Rp72LF0lPHahgNxdaAtMwS1URtmqHuGvmzZnLzHzIL8qjgDFFO2KfcU8XofY9I4agvVbIl7258YMzp7m6E6uewifV8LFrDzpoUQm7cI348yPcvqxd25fFUYI0xhwvufDt3QcRGPKWDgU0VMUNCiNyQX24qda/I9C5Iqnp8us0UisV9reD/RTd1H7Ej4imugKpz6kK3JE8ZOYXOSVlA==
Received: from AS4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::20)
 by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 15:11:55 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::52) by AS4P190CA0010.outlook.office365.com
 (2603:10a6:20b:5de::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 15:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 15:11:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 17:17:28 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 17:11:54 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 18 Aug 2026 17:11:52 +0200
Subject: [PATCH 2/2] board: st: Fix compilation issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-2-611201a282ce@foss.st.com>
References: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
In-Reply-To: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|VI1PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2014e21b-e6cd-4d70-48d9-08defd3b0a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FodjSOrymGxHU8byIiREI5T+V2ZASFtyWtLId0YPhM2UNAaWH8M/oXNijJIu91Stc3zaZf8gySCsVLZ5PrXVFUHTNbyhKYG1PySlGyL0aim4t4agmgcf80iBkjtF3Cs37HxPSiApF0MQ0tDxq/Itzk+ZjIxPEFoLqPXKTFFeTaRiW+XmHt5IPdDBrL/QIJan9055hkK3LrGKVOE439z1me4PZ5dYcQ3sz7QRcOZSwn7Lzd9mpmO68V4JlG3e1vF3CUteGGu+fkUhkRG4fV2dXD5Xgu8D6TB81Co2Qjjc28PUx1uULtZhKFfbmcwHJLw9nlhcWd8igCic59ndP4vDXvJXaqJwoM3CJSDCcHfz9SwpjbUNWZNCVcuXTY8+vgCJylyTXp3X5RvSGeB/4Kq89xvfm6xkoSUD0XmxorJ01B0miO+uGXCMeilc08AUlkzA5yijYxlxeWQ71Wp4kOXMEhhB+xMR2pJdNbR6Sr/wGUAW3q8xfvOKIfK5fuh2p6xtnhsPUZatPgkdA5dbpuS8MI6pGvh20B6rG6+BhX3FIecwOpxT44tnNQ5bGnih/DVLOW3bcb63sTadx1wPA1Wt45ttPE91ZGasKdHMvwkOCuZ53SpaVkptXLL3Cj86Kie1tsIf8LqoiTG/en7OCrB3J2JI2fBMd8y0SsH3Xq6b1mfNiBvkQ21O4X3gs6+P8W4aehh8VkEHfnvjSUAvtz+0Iw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xSEAwwcWlxfUswSQOsV+qK4hUSrCIFSV4JEVh2Wg9ZUxduZ+lJgGu93UlohYiAgfl/+dftAvCrqaaJ/8RJ3CtBJaeiTf/ILrUsxdE+zcnIRGam7naLLyYHJyNH/K84efxd0nLahM+BhbzBGHZwr26ZECtQH23lXy2apFqCZIbtmDTPUqOORZlQUdFil3ZepLPqsQMJdg7NlV7b1l2eC2/HI6S4L9qb+p7qGGGAuWgpHFbNr/I13Xk/vykcDSY5UEHOD1G1mrFw8bacAGvuZDPIEGpvUecPJj676HfHvFPjXy8UUQUbuRuF1sjj0ap8L6aWJ9DSnN67711MXnXSnKnGmZcnZVs8gsIQk49d3OH121ELqFw9JbbHWf86TpHWVdYVvgROcdja82U2lDpn9uBazRkpLKEbtJa5T4GqZAq4uslEyiLTm3qDrxBZ+uQ52H
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:11:55.2111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2014e21b-e6cd-4d70-48d9-08defd3b0a6c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7810
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This patch solves a STM32MP2 compilation issue in
board/st/common/stm32mp_fwu.c when CONFIG_FWU_MULTI_BANK_UPDATE
is activated :
    - error: ‘TAMP_FWU_BOOT_INFO_REG’ undeclared
    - error: ‘TAMP_FWU_BOOT_IDX_OFFSET’ undeclared
    - error: ‘TAMP_FWU_BOOT_IDX_MASK’ undeclared
    - error: implicit declaration of function ‘env_set’

Fixes: 4369c6a05035 ("board: st: factorize STM32MP FWU multi-bank support")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 board/st/common/stm32mp_fwu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/st/common/stm32mp_fwu.c b/board/st/common/stm32mp_fwu.c
index ac7ca6bdca2..cff020a99bb 100644
--- a/board/st/common/stm32mp_fwu.c
+++ b/board/st/common/stm32mp_fwu.c
@@ -3,9 +3,11 @@
  * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
  */
 
+#include <env.h>
 #include <fwu.h>
 #include <part_efi.h>
 #include <asm/io.h>
+#include <asm/arch/stm32.h>
 /**
  * fwu_plat_get_bootidx() - Get the value of the boot index
  * @boot_idx: Boot index value

-- 
2.43.0

