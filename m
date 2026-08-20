Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8F1C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFB8180DB8;
	Thu, 20 Aug 2026 15:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IXZHJ4U-DRLo; Thu, 20 Aug 2026 15:04:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787238294;
	bh=icDSEeoU4JQTzFIHm2Uh7rQmm2JPj0zfRI5GADEnTg8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MSGvai0wYzrYchzxAnrKATWzifiXGGQRWA5JbtBo1UT7cVrZzINszEC8LD8E9y+07
	 M3J9wIn3JVIcQ2iAzmadT8t3ydgHfcCsCy9bxfmvOCCWIgqZKe/+dwobqGnP5JRj5R
	 +nsura0HcYHKIgEtYGCDio0v4SmbqK8D1n324MZS/nYrB45h+lNR8j9YDhlwAw7Zuc
	 DbU4FXaSHW9U+jREETSlO7DV4Pb5fReGW49XCXNbkvX6+FsT9c0kLrtWTDgHJ92t4h
	 5YZajKdzUpRxOlvO/IVeQPRzt5GQRQetW743AKSM974+dhejmdg4hjXRZhT+/8FiH9
	 vvSFwLx9/slKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF76480D8B;
	Thu, 20 Aug 2026 15:04:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C898340B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE9976076A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSW-VgMni_5b for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:04:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VPruRxyF
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA96F607D8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsppr3tMGrcn9cnPJC1gsM1XlaaUZQ5w/qv8Eb4um+h08vX3JfyK2ZwULaWmr0SvHrModtU9ZmOTQ3x5dQsWwxNgrBRsRAFD+PJh2bWgbKovipgt9SPYagUeODKP0AikbjJwTEwbmJunoIpeJgR/rQjasUr5AeoJiqJIkVlxM0zUwTOrBf4A1iXDMsqXYMwZMOnYFPPFgWOw98FlyBuC3TsGDTFrCiClwXX/ZkfT/O5dC2OwuSjhpZeTnmnLUmN3jp9dT4Af4TJYvJWn8iFsw47j7oTejdalLXEUIvooJkRFUmmYdUS7TC/WdMSrqtAoKYk+qH0Yr7XxKlrS2Vycag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icDSEeoU4JQTzFIHm2Uh7rQmm2JPj0zfRI5GADEnTg8=;
 b=ySJtDtCfupsgcnXWHk2V1vEz28U6hZhK7AJvQV9HJoHpLtka7mQRepXVqhiK1ztLWEcEuRS4guzspyp7K7rv7Oe9ZI2NBSmO9pTCpefYTch1XWsvueJcePrKlBDsE+gf3D57hTzdBynbXpjfhqMK2RIj7vFmCSmvTmkLx8P069W+FITsCbcKSyF6UWVSsG2RXyLeNsyVBebYE0rv1N+R/7ziI5ZOh1tB2DiQu4rq9ObfCoBu+fLWY1HQjCGm3eTv7EkzqV3qmJXSHsbypgAmpRSTt/gM1EhK/orTzvxLWKZuaY1pD8ly7oqB7NXbPaVYF7CsP3LxMPYFYN309YWXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icDSEeoU4JQTzFIHm2Uh7rQmm2JPj0zfRI5GADEnTg8=;
 b=VPruRxyFS1qUfx/iotqsq/DF7wg4YaZN9xbt2a0jKhmbb+Ru+XMEsz37R0QicLad7MVp3ZizLlCLC4LZISN6It1LN+a2HowqP+uCjlO8dqha1qcIAT1ylvMqjTYliOp6Bx7ZOdKgRg04bKQ2Lg2EhUQl81vc/TyynQcW53AUvtE=
Received: from DS3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::10) by
 CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Thu, 20 Aug 2026 15:04:47 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:45f:cafe::60) by DS3P220CA0008.outlook.office365.com
 (2603:10b6:8:45f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 15:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 15:04:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:04:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:02:26 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 10:02:25 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>
Subject: [PATCH 0/3] soc/board: decouple SoC identification reads from
 firmware calls
Date: Thu, 20 Aug 2026 20:24:16 +0530
Message-ID: <20260820145459.246717-1-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: acbfc8d4-b616-4312-ffd9-08defecc5fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: MmF6OdOXTz6sOWOUyjLxPxGRv4yNT5KFI+YhXw0+x4nit4Exk6bcdKBeMGs8JBgHfah6vUqn6wZxCcrtYZrJKl21whoINcHbtJhaDashm4dAboMyJu4hSEWfoKYfunWR8fwV7rGAzEnHqd7v4mCybphrDSCgG6AJSnX5CpCFm90B1BT8BK55mhhY7oMK6lkNjj510xl9GXXuXQMz64xtvtfflpaDFCqjfA9sTI2Cje+UVMF6ZUd8OGFZsMJpzVCnsCzttmyotQxdlS9zJulmgAbj+PPnRc5ORYlJ3eaqEIfnIlMjFLwasRXddFq4ZpoWXZiY/NQlBCiAu14sC4qNLdtsUr3eToIA/hb7WyQla2aH72GM0PwqqpxKcASY1ph0Wqur6s+U7Ys8/DCJv/1oY63esxffUo9eFi0+YLshPOfNoW2NxtMO18ricyzXlXUn8o7VB7VLgrNR/jVwTl01nsZpNP388+aruGxHDhfj1zyXY9CldzPloffR20bJLyIZ4BTEIBhFw+IRtF2eCRDZMcYjUMs++1g5ZQkWtv4wMRPxZT+1HkfZU52bzuGSr5LbNB/bbN2B3rOf0vaJGnkTGlp4os8akS6V1ARlj3f8XJBcE2YLLS675pphjZkheRBnZJTDuxBJF3d3IvjnLM/gegGdUgKE5Al0Av8LI+ILpZAO72kjFUlyF5UTRQorYkcN9290r74AmVrw2SX4AppcDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QTMpKgs8Jf0C+zkofCNdPvAUY2C8ZwrSEtZsWspHcWgDcso9ym9dDZIFgkQJ3ehLRHuQyHxy6UONVn1wDnjcDrI+jcBU6NHNBYIBNJYQO6GyCDes9s+xWkPUkXcnDYv7IzGlckgHPzMy7P4DMjPGRryFzePLwROS9yn67Ge5/7bvAXboZYzfe9ogpw7Ka8OLAQquEReqpFalS6luaV35aEmAZeoZ5BsxEn2zrbibwe9Au8bShgYXSZn1VlEs5v2OBnaASEJddXFMYtmYuYoSjHpYyeWqr5i9ROQpSXy7SlMZfAUW6QoLvz3x4tIWpqzBkJxCu3my9QPs/WCUkEJv3rayWaecxHYiXNvrAybWlm5mn04fxcchxaNSV+nsc5bdItZVkgiC5GC1AqXutRV7QizY/5P7zFuRdSr5kdbi3wKyeFUj2S1gjWpEUwKQjVSi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:04:46.4145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acbfc8d4-b616-4312-ffd9-08defecc5fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
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

Chip ID, PMC TAP IDCODE/VERSION/USERCODE, and the PGGS boot index are
currently read either directly through MMIO or via firmware, depending
on the platform and configuration. This series introduces common helper
APIs with weak MMIO-based defaults for each platform and firmware-backed
overrides in firmware-zynqmp.c when CONFIG_ZYNQMP_FIRMWARE is enabled.
 
This removes firmware-specific conditionals from callers, centralizes
the access mechanism, and provides a consistent interface across
ZynqMP, Versal, Versal Net, and Versal Gen 2 platforms.

Akshay Belsare (3):
  soc: xilinx: decouple chip ID retrieval from direct firmware calls
  soc: xilinx: route PMC TAP register access through firmware
  board: xilinx: decouple PGGS boot index read from firmware

 arch/arm/mach-versal-net/cpu.c                | 34 ++++++++++-
 .../mach-versal-net/include/mach/sys_proto.h  |  6 ++
 arch/arm/mach-versal/cpu.c                    | 18 ++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  4 ++
 arch/arm/mach-versal2/cpu.c                   | 39 ++++++++++++-
 .../arm/mach-versal2/include/mach/sys_proto.h |  8 +++
 arch/arm/mach-zynqmp/cpu.c                    |  8 +++
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  2 +
 board/xilinx/common/board.c                   |  6 +-
 drivers/firmware/firmware-zynqmp.c            | 57 +++++++++++++++++++
 drivers/soc/soc_amd_versal2.c                 | 23 +++-----
 drivers/soc/soc_xilinx_versal.c               | 23 +++-----
 drivers/soc/soc_xilinx_versal_net.c           | 23 +++-----
 drivers/soc/soc_xilinx_zynqmp.c               | 21 +++----
 include/zynqmp_firmware.h                     |  5 +-
 15 files changed, 204 insertions(+), 73 deletions(-)

-- 
2.34.1

