Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA9CF55450
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 05:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27BB183EB3;
	Thu, 26 Feb 2026 06:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ot10HBdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6B183E83; Thu, 26 Feb 2026 06:48:29 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93FDF83E96
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoyReNvmXI61gLurN5xqkk8gRwx0JZDPoot0ibkmwCSjwiY34wcWIntizX5XIGh9E3oP2uvB/6WaXfRtnOm5LlS1FpeS8PM4VGuTGaNTYL8IFTEdgA34x7MGkA+VnIFaW1R+R8+o5IqfUfhrNYVCtbfIu1gM0Ni3K0KWghOgO2kKcG1TfnCFuthoDsomrdq/28PLIiQY9wjqvG9C3ZIAajYHnzB19uuK+5F3qTpiqehMu9YAyzFtRSINPoAyTCyKwwsrFCRi5yr5dx9VddMMgLNvhSmkG4IChd7Mr1g/eIjdyNEoN8hjK6Lnb/garByDSsa+egkVxvkvWFUtVZU74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpZFIdw2WIyK3tX7DnrXyTgTaSZSNprQ8HDI3J4e34I=;
 b=qkC70A9qvcczXigmNfiVbO6PRH+85WZp6HcFiO/eYp7B32HdSsCO3K8PDFgmYo+wOChja6HExGeSPVRBjN0nBD4zTewrjLN9h0aRH946WeRIkWQ3HMXfpDuP5w8tgFoVZ6Wg25nQvp0GXSNinAec6Sb5M1kD4TLQPoOK4FsGgx6FSlpvgGOVrCGsjSyZNT0H/jwOMp2CQQ/HxCsUckP3coFpW0mcjiQKhEFqfUE+telwxmnP/8bszpgG0P0H4S/SZn0JwvxR01kxqeBC8lNY0ntFKnlG9QoPHHZsU3qCleXHBbW+PgS5IxoHPR1SJud8XxYEBXdPxIk2wKsJxY8yCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpZFIdw2WIyK3tX7DnrXyTgTaSZSNprQ8HDI3J4e34I=;
 b=Ot10HBdblwBDp7cgAs2y5tTsc8RW+56pJflTLtxbnTMv56jtGX4D/xZQ907IAgUiDiQUoOhfstr2T8Mf/dmRxGRoRiZKplakd2eZXzvIzJj/jy44zLjXAJWfZHUYXTZ75sCzCKm9SOBlZwJ6cAoTjfKqD3PjfFkIO6IdTIbodok=
Received: from BL1PR13CA0161.namprd13.prod.outlook.com (2603:10b6:208:2bd::16)
 by DS4PPF66324196D.namprd10.prod.outlook.com (2603:10b6:f:fc00::d22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 26 Feb
 2026 05:48:25 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::2) by BL1PR13CA0161.outlook.office365.com
 (2603:10b6:208:2bd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Thu,
 26 Feb 2026 05:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 05:48:23 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:22 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 23:48:22 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q5mL5Z1805748;
 Wed, 25 Feb 2026 23:48:22 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 26 Feb 2026 11:18:15 +0530
Subject: [PATCH 4/4] misc: k3_fuse: Limit writes to 25bit values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-k3_fuse_fixes-v1-4-86c81c298bc5@ti.com>
References: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
In-Reply-To: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
To: Harsha Vardhan V M <h-vm@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772084893; l=1321;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=IwBXA+D9b2CQCNYIG6yXVpcpga40LxgnEZTXu1rqvYY=;
 b=49JmKneyNw+vRlQFp8IfQTBPuNW6JlxA0EXmBCdIktvNLGcWDNaerdtjOiQui3+yKp6/jlDzK
 F1NcXLqEF2IAWzyL1yElS0hQBmZHlRL2mPe4BesN4KvedU2rHQbTx3k
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS4PPF66324196D:EE_
X-MS-Office365-Filtering-Correlation-Id: edf4ae4a-cb99-49fd-43f2-08de74faa7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: fFqed9fUPSrJu0fvUHsmWwRtKrj32v2nhT7whcEKHkHi27peaLioUuqdL1oi7d4j28V0ZElu07pX+TM7yuEDzRQIe0NWOS8geNjyHhEzTHy/jCu3bbvglVFjG8e5+YH7CvcLPYTzjr4XIZehDAsuC0fKcqV3xr4+jJSFJPUAfJzcGmgOJfsRpPf51rP8ggKI+P8MUHF3Bm4duigAuwzaJTVQ8MFyw19Q++E7Se31QThijoAmCoD3EW7FUHVHLNbXYpwsDj39SPiPGjV09IMEbDighgggzzmBu9qS7bTO7WObev74JHcfKjaZoUN66QmW9oBDSP4mMKx8kfaPTvlyXBuVidbl9zbJV1fAOsghKin6t40wJWXUO/4xdGHWnhtTjHg5oDQQB7aqY/MRjEXFSl9yHv32mk/I7MA30K5+6E8ZYg6hPTL3cPoUrtJlIXLqNuNsoRVJufrxfB6eu4vvOQuhs8WterMGLfZ6ryWA5PC8n9SPXLK70qe142RD2AN6lCTZtkDsDdmr4M3TwnYnBnzY5br315nW+kuPcs7XzqKZwmfOjQZRW+0R890gR8CtkSltmMYJJP/w3ssLAu18spFD1GPtyUM4OjbMsUnUjjwDwxoxrR/StXtdSGRJHhGAhuyy/8U69SK9YDnOgBciSfuArCuSqD/YH0tIPXAR6XXNRd7LlwxzkzAc+lYCswNW0hdC44SojxHEYe5bCQSXhetfbkKyRfc5THuH2Y6YvZ2M6lWkI25SPI9Olx0BOYict800570mKp45Aztt22iEzL06WoOyQWSxQVYRh0ihZ1stHQmotCfsvduVMDfB6FyJrWWPRrBPnrjIfkzoiMO6XA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xWeSkrJYf11XzElzV8JY1sZ604O9YMG1M6XfXBuCRjldzlTE7VG/KLrbdpsT04q0GoK9BXoyS6dNeAWIU19OfD7rczvtc61PjDEpcZWA9TZlu+cVGy+Tmbcqj1MTMmBsw+1ui/C0W9bE94t2z03LfzYj/D3nB/yqIHBXd2JC22hPhojo0x+OcpimyTnJGmOw+oawr9nnjo8f6Qb5OfG5IaAOwxJFQjeNrNbaEU6CT2nYRroEvZ4Di1ozKQs+bBBeQr2wk1qDcGb/6y3Sa5T7R9lAuembHNPLiQwu7y5cTqx5425xjidSupiP08aow/UsmQJAfGOYNRkkpI5FyzfvFYanQNGefC/z7Xb1aup7yQjpErZ4jKNYuV0laggdw/J3LXoYmQrynyiDD7Bo4KKZ1iGk2P+almX81ngMjN4ibmskjR/p+gSMs3nYa7fGVcwg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 05:48:23.6294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf4ae4a-cb99-49fd-43f2-08de74faa7b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF66324196D
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

From: Vignesh Raghavendra <vigneshr@ti.com>

K3 OTP bits can only be programmed 25bits at a time. Limit the value
accordingly using a 25 bit mask.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 drivers/misc/k3_fuse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/k3_fuse.c b/drivers/misc/k3_fuse.c
index d738f75f272..faafaffe07e 100644
--- a/drivers/misc/k3_fuse.c
+++ b/drivers/misc/k3_fuse.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <fuse.h>
 #include <linux/arm-smccc.h>
+#include <linux/bitops.h>
 #include <string.h>
 
 #define K3_SIP_OTP_WRITEBUFF 0xC2000000
@@ -41,7 +42,6 @@ int fuse_sense(u32 bank, u32 word, u32 *val)
 int fuse_prog(u32 bank, u32 word, u32 val)
 {
 	struct arm_smccc_res res;
-	u32 mask = val;
 
 	if (bank != 0U) {
 		printf("Invalid bank argument, ONLY bank 0 is supported\n");
@@ -49,8 +49,8 @@ int fuse_prog(u32 bank, u32 word, u32 val)
 	}
 
 	/* Make SiP SMC call and send the word, val and mask in the parameter register */
-	arm_smccc_smc(K3_SIP_OTP_WRITE, word,
-		      val, mask, 0, 0, 0, 0, &res);
+	arm_smccc_smc(K3_SIP_OTP_WRITE, bank, word,
+		      val, GENMASK(25, 0), 0, 0, 0, &res);
 
 	if (res.a0 != 0) {
 		printf("SMC call failed: Error code %ld\n", res.a0);

-- 
2.52.0

