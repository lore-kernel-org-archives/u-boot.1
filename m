Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D3FCD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2AD884688;
	Mon, 18 May 2026 10:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="I6R/6edv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B0584150; Mon, 18 May 2026 10:23:28 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B791283EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3qQdEQa5bqw2GSRmW8HNYOedoKS/eMu4zGUj6BjNxwrqQisdEPU6Rk4x/ov4SaSLGHexK/mEHVc5P8rxi0Y3DpzB04HKsVNt+hFuiZIZ1ad0HeGrgUY+LYlXZ3DbWmz+LYhsX8WXh9RopeU9bxKysMOZeQnrhYQqXs0rHAg3EnBAze6sPU+nCZPqQVqDbPFftRH4PjCI82s1fnsd03+2Eqvk7qETOhGSilDyHoiAShXLZdCMlwDXyNcXk7nbw7246SGWagIgbEIPlH4WnhgyKMenFcPOdxP9cemjSmP4/++Zz9SeiLBdygE4/BO4NABhYt3yh5QBD8BpFx99vT/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3yEJcRbHUBsNU0H022S0i9Zu1sZhbKgwxr2IJ0Eits=;
 b=AZE6yh5ucycoc1smzD39UBrrcfCVL2s4BLKt1HA5qzxz6uHPPUeTpaknCkve+RFm4fVgzPAF6Rlt3EDknm6jJwBrDopfwBnXiHDdVt2qTd8gZjoULuC9c90iKEwQe1/uLcbEEYOGOLz+/7fw7LVayGycz4daAp9hqQQwtvHVW3bYP0tyI50xg/EzbrdsJ6wR95ld/WiDocFzTxYmo+u+H3N2sebT3hrUB+s84gD7ika9JmCqHwtG14jyupKRKADTEMBR9ycg5e5fEUyaoPnirlae5Q6EyG2vNFIKG5LO4Izoz088+vFCpjF3nM3CFPS57JwbwwZolUaokIZi4u1log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3yEJcRbHUBsNU0H022S0i9Zu1sZhbKgwxr2IJ0Eits=;
 b=I6R/6edvkGOh8Lm0su98lZsOIkg9qMmiYDFeBE4FyyTH1wZ4cnrWNAaBD6zZD/2r+N20ZEHY+BJDONJ4h41j+bcB/BJgrR51bXCrxLOjYeyCuq8oV9Frzmk203pJmV/dKTmwp+Fs0YE82G9RQ7GfhT0SaC7FrLz9/dPzehjjc0U=
Received: from PH8P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::33)
 by SJ2PR10MB7058.namprd10.prod.outlook.com (2603:10b6:a03:4c5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:23:21 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::9a) by PH8P222CA0022.outlook.office365.com
 (2603:10b6:510:2d7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 08:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:23:19 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 03:22:59 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 03:22:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 03:22:58 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64I8MvNf1478892;
 Mon, 18 May 2026 03:22:58 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Mon, 18 May 2026 13:52:52 +0530
Subject: [PATCH 1/2] env: ti: k3_dfu: load only the next stage binary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260518-env_to_kconfig_migration-v1-1-24c8fba75ad3@ti.com>
References: <20260518-env_to_kconfig_migration-v1-0-24c8fba75ad3@ti.com>
In-Reply-To: <20260518-env_to_kconfig_migration-v1-0-24c8fba75ad3@ti.com>
To: <u-boot@lists.denx.de>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779092575; l=1545;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=A063Wlue/IPDKyrEP4oLj17lZUxkGdj0y/QI59i+DDs=;
 b=G2vxMKP25wcLmy9adTEY7+WYA2L1+QNaeV5CW4aGZ+W9LFzPfpqo3BqOjADD8rTbzDUlofILh
 sqJqBPZ7VtwCHa6t4NHtJCV35Rc5FAYBElHgbdcvzWgsTchC/6GZvF2
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SJ2PR10MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: f68673d1-14e9-4bd6-6c62-08deb4b6b7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /FI9uxh6lSCstizqP4Ko9W1VaJMQWQ9vacSKXXfDPFT7XfTFZakg1yfAwa9xOdpk/kL3hP+HRS9pkBliBDEHTUFBorr0IpVJFdAHFcrJGrHFLCUtYCp2EGWzBcfjt3fFRGi7MqZ3K5Au0I95lOlNBwvBRYf29mN/dL8vxak5HB0HF17GwMuxZOytp8GmOM6kr0RM7pffcw42RJKbwXQrurRKxefrpWWaR271pUs24PmFjbEnPWu7OtbzruZAJT4+248X9md16i5tQj+G10dWrgfhD57PF/ckpNlaZL+eIEke9td2qD4i2cSMOo8evPRJGUcjcDkX6FksxMSR7FI1AmOFtQ2PnyZWTFSvaOTB5/ira/yMGNrQMZ772tFaSXUeZWaSEdg4aL2uRwlWOwsa/afD+DaOQUSWl+aOg/S3I7AcxC61iwZGsmFSI1mrQOaKh7NEBZHwgpbo6Xbw5nUmYtGn45tsVRGw5zyXdALpO47i2EDgjlAciMWSBMVN7qJ8mPmAbXnQVkrEXPT4uLSym3v9R9lpplHxgpp2869MyvpMaQSqkWLHqP8zhPU+53zae/KeKkO8+U1Y/R8fURbJetzIPH25eM94gUXf28sqO3aaW05hylMS8XOX+6f4WS0iwLZ+D4I1dY5AfGpQVml8sQ1LwYUa2GZuKbrFTCFRVW168PVJUEcTb7k0VeHXd/13SQUc/RCJa2y680Dm3Xo3zFq5F5NFU1+nSXySCrgFbIM=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: See2mY8E85OLfOw+gsA1OPur6ag4AJZBAw+8ClfL0i97gU95AYmy1mu8ldyYs7cmDEjyKHJh6/OlUGun3MF60mVjOyKMvtdkH51RG4Jk4AXlaCs1uCduOx36sznSRbiUC/SmqxB/V2Ok/0+JgNo/3T9FzV0Ja99dO7dFsxpHtWDJ1auWW2o/keZZkEQKByisKhJ4jO76s5ohFMy/LfXNvpvFifCXlVadJtioCfIy7Vdmhc5fo5g+zsP1vW1B0XwaUlEf30EIZix+xzq10KCQYDe8lsAcmJf6HFk2DMyIOkFSuuOb6fOC1Z717Ric+EHh8FQlqQAd1wtOYCfvYJQ+vU6TpRjLsNWKKJgQ0cYc02Y8U/FkYarIr1QLmuSqpsVa5QAgyLhoh/7NduQ71YoKMYjxdgBARx/D/XbV8ARFQIXaU+utpP0Px5mzA0UFApjj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:19.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f68673d1-14e9-4bd6-6c62-08deb4b6b7f6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7058
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

In the TI's K3 bootflow of tiboot3.bin -> tispl.bin -> u-boot.img:
                             (R5 SPL)      (A53 SPL)

We currently provide a common dfu_alt_info_ram for both R5 SPL and A53
SPL which is not intuitive in a regular bootflow where each binary
should only request it's immediate next stage.

This patch updates dfu_alt_info_ram such that the R5 SPL would only
request for tispl.bin and A53 SPL would only request u-boot.img.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/am62x/am6254atl.env | 5 ++++-
 include/env/ti/k3_dfu.env    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/board/ti/am62x/am6254atl.env b/board/ti/am62x/am6254atl.env
index ea5a33d8cc3..dabc77245d4 100644
--- a/board/ti/am62x/am6254atl.env
+++ b/board/ti/am62x/am6254atl.env
@@ -28,8 +28,11 @@ splashpos=m,m
 splashsource=sf
 
 dfu_alt_info_ram=
-	tispl.bin ram 0x82000000 0x200000;
+#if CONFIG_ARM64
 	u-boot.img ram 0x82f80000 0x400000
+#else
+	tispl.bin ram 0x82000000 0x200000
+#endif
 
 #if CONFIG_BOOTMETH_ANDROID
 #include <env/ti/android.env>
diff --git a/include/env/ti/k3_dfu.env b/include/env/ti/k3_dfu.env
index b42cf21d986..0f82a8afb42 100644
--- a/include/env/ti/k3_dfu.env
+++ b/include/env/ti/k3_dfu.env
@@ -25,6 +25,9 @@ dfu_alt_info_ospi=
 	rootfs raw 0x800000 0x3800000
 
 dfu_alt_info_ram=
-	tispl.bin ram 0x80080000 0x200000;
+#if CONFIG_ARM64
 	u-boot.img ram 0x81000000 0x400000
+#else
+	tispl.bin ram 0x80080000 0x200000
+#endif
 

-- 
2.53.0

