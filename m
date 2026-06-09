Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4496FCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 18:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF3A84911;
	Tue,  9 Jun 2026 20:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pLM8Za3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D131484951; Tue,  9 Jun 2026 20:11:00 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E81884910
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtT/YyfFCdf4Mfnnrw9kQeonUQBt/DJe/aWpIFXe8W/na/d7MMNjQvu52WiGL6llVBVwzCZ7kZd/br7mCcOdH8s87X4ktJJpxctYc9spHat5aWqmXZXUSs4WrYQAn9M7xgWHW/aTRhCAy83J6PP75amMleP4lNEH5Ou6rZLNosbAxHPjgdn0/nwl7qj68DdKAZte+GvxZVXE470sIhDODjqtTK4QEm3l//8POy7sgNhPQwwx9tY+836kqC/3uG1vDm+sKYaZMksvwBhVR0kLfCHivyv0OGXr/RwrMLXY+gYv4Cvi7BV1+K9zoWRKLx3zJDpckCjATNn+wKO5jBYPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnF/vQCK4jSTuuo7ZkGPYSIhGlkt2IjiQF13BJugCcM=;
 b=Iqn8tE60LX+Ytp9l39DlXRjkE2DTLHHMC8xko6tP/g57jjko5M1grVoFt0XLxT+KSlWVnxGbGjdJp3FPBZbssO6DNDZjEytU/c6IVkSCYZUcDQyRPp77LNIJR43kpZpxELYugmDU+/ORLIyCGOdEabuwE1iQ2CGyYXdFD0WordPtXcmdj9m9H4h2MoNN1V/KhSvo1SIjOQVY6pP02bmqhx52N1iWkQj7TC8Efcdz76U1+gN88TvkGCHkQkC1C/ioTojr0sDhMnCWlr0Ago6K3tnIfqMXcFJjX2OUeHoy3VRQrSN4z1yl3Kcb//R3HM9nauf488203H05J1pEMo2ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnF/vQCK4jSTuuo7ZkGPYSIhGlkt2IjiQF13BJugCcM=;
 b=pLM8Za3FBGVuhaVGhOq17nO8AbwR5mYYO7xrLKupzgNuf643ltUFy+O0rQ7/0PoJlnuGHdwJuEQzY4qVZ72UTpbv5x8CqpnZLTDSUJJwZmgMipR0qkGb5ot6bbdsXWPaDmHdyUpNv+Nei6TqU4UGf/mW4cD/3Jb7EPvouoR7zso=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by DS0PR10MB6993.namprd10.prod.outlook.com (2603:10b6:8:153::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 18:10:53 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::6b) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Tue, 9
 Jun 2026 18:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 18:10:50 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:12 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 9 Jun 2026 13:10:12 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 659IABVZ1612316;
 Tue, 9 Jun 2026 13:10:12 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [PATCH 0/4] arm: mach-k3: Add DM firmware memory fixup
Date: Tue, 9 Jun 2026 23:40:02 +0530
Message-ID: <20260609181006.460401-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS0PR10MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc8686a-6a45-4669-893d-08dec6527026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8+mQd+0v5QQKLBp8hpdOIt5Z7SNT+NpYbGRzJNbgjMVALlrT3qCt1iLpFWeMZrJuVaONVTUKidV3UqmhTQoGqlSfYBBVRhSdxQjB79Lp3XC09OagCocGXEr00h8XIKVpx2mr5UExIBBEPyO7u938T5bDzY4Ldgvck5OPrI1ZhXyeam6Z68MC0ApG1dWCQp05U5kF+AuWzlo3QiYBsy5YgkDygyyJWliI0T8gbnxHjlLCRZBdOTAdCSzuB7LcfCZJUfQ9aOMliK1qoH7vOgimcEb74MopsXUjARd2bh8fKZ7RMA2gGJfFh1dik96vO0lRyOcFR18cwcCDt68+PmPReG55aYyuzA/Cgo0tOZK4grpRxbeUBFouETKnXDnjyhKLFD/ns7Cu9pMPxO0aZ7yJpYs79vKWQY+USGAweIJyh0tp2s8AzyxYmEniUygBP9QfFuR+DANfjt7/GN9BJscPMJaVrPBVunmh4ypN0ljcX0Ay9WJ2HWKJyMPiQfdqOFTCvWrEqJ+jg0GxMWOckeCs2afs8WrzRmWGSXEOwq5YyEaqQI7bTFswF52swHPeLQ0AtHRgaAAiG7XFKmuBwpasWtwdothudTjlefVLnEaSFKiUhjKD9iaER8cAAFCEXz8Uz8x+bSxQ5nhldan6H4nPsSSjhRwAWqf9IaUr4r45Ph+k5j+9nJRin/NklrwYmRX7v9J2tKmamPbqYtBGsgneseosdOZWfrwT+Cjz6H8zPHU=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TFBXRCqdJOVQQjbZAIv/5QGlAh3EF9dI1zkNKh5XmnF6LTBCyAcybAtihcD+9Cs68QNulnNoOPkgBE4glpgs2dOuffDV9kdjLY5zfQ6Yw1hMPHiZ2HnsiLTAGUc4Fo+4kejAIA7SsAj24wNVR2Klc39ObR+0oPdODuhZnIihW0ZI6oWjdkt/nq9nYgrmZ8Vv9mnrU5lcV2TrouHZeLot5FpyzOTHD6u2cumBQEBSZPsYqRaJ5BbrJmSgiApmUI+KJ7gv6VndOMkrdhvIfgNHMv7EGA7MKOGgLRFFjP4YM0sFoMrA8Q5siWGDvkA28+dPi7OXr/n6YrFsSDtGwwmnXP59/IZf21DHIczpi/Z8MbYyNgZZEbaMzu5rIv50SLDoI9Hi3ri7dUQ8uevQdFYz4FCKgAcxUffbLRvVHq9n7u2WKfflUi6HdUOYy/qjQBPk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:10:50.3063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc8686a-6a45-4669-893d-08dec6527026
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6993
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

This patch series addresses DM firmware reserved memory fixup for AM62a
and AM62d:

1. AM62D is missing OF_SYSTEM_SETUP config, required for FDT fixups to
   be applied before passing dtb to kernel.

2. DM firmware reserved memory region is insufficient to accommodate the
   binary. Analysis of the DM firmware binary using objdump reveals that
   the resource_table section and .stack section occupies memory from
   0x9c900000 to 0x9e608000. So increase the reserved region size from
   0xf00000 to 0x1f00000 via fdt fixup. Add new configs in Kconfig.

3. The existing fdt_fixup_reserved_memory() used a delete/recreate
   approach which corrupted phandle references to DM node, causing DM
   initialization failures. Fixed it by updating nodes in-place using
   fdt_setprop() to preserve original phandles.

This patch will need the dts to be updated for both AM62a and AM62d i.e.
rename wkup_r5fss0_core0_memory_region node from "memory@9c900000" to
"dm@9c900000".

Boot logs
https://gist.github.com/paresh-bhagat/e64523fe5134a02754fdbdaff864fcd1
https://gist.github.com/paresh-bhagat/b578d602010db09d62d2be3b2709fc5a

Paresh Bhagat (4):
  arm: mach-k3: Fix phandle corruption in fdt fixup
  arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
  arm: mack-k3: Kconfig: Add DM firmware reserved memory configs
  arm: mach-k3: Add DM reserved memory fixup

 arch/arm/mach-k3/Kconfig        | 16 ++++++++++++++++
 arch/arm/mach-k3/am62ax/Kconfig |  1 +
 arch/arm/mach-k3/common_fdt.c   | 34 +++++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.34.1

