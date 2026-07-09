Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95F6C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E407F84AD3;
	Thu,  9 Jul 2026 11:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KSp4dGaz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CA084ADD; Thu,  9 Jul 2026 11:19:04 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073CB84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtseuIg49hphxDPZJWUxyA7ntYjdWfFd4gZzz4XbNJXAttUyOKtllqeYRC/KGu43mVWAfgrMwUSzwI6Xrc1H9te4cdPlV/g39uOmY3mLJmfQxCa5E45CMbBNnEIB+u0ISspCuDNrADd5cJsSH9THDTRvKCSE5418IlGBIy06EmYgqOxnkHIWmw7FcuASclkXDM0xKR/xkmlrZPlhg/h3Mebs7jogMbP8aUA+Bz1gq2zUifMnuhKa8oLQiP9Udwb8TlCoPDnlpf849EyRwf3E8EL2qfWQXBCzpah1jA8ktADY2mlKhyFK1HYcT+q2u1LfHPWhIjJiSwtzSJjFM+/oLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajLIVAbZhU01Sz1MU1n8wBuxvhud493Sa99oNdke0oQ=;
 b=wo7BGVgGRKJMa/wmm0arCx2GYvTl+zrWTzEGsjmWsV6aMCxPjblJUIfUUrfS47O7+sgvw+lSSfhDXCPJNfo9Cy9vdbfPik/y8FZVeUxVBxHJ4oTRelLcW3askSdoX7XPSk4wmR1V+XRTRsLWnT1Mh5LwG0DeawpGT1cAy+Q07h0UTpW8l6YoT/qqgPpm3E0PZQkipwfG1PhBHPYAnY5LrXGc6C3fiTTM8ZQE0IFhY4L+KuorxOPkNbVKXfrVkxXwxHdWUpPFlsbwxP2vYaMf1MeBEFu7q59e061LW3WvXwoO1E2lg8Yxepbj2ZIOxJXNhPONliz01LAKi3BMY4xjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajLIVAbZhU01Sz1MU1n8wBuxvhud493Sa99oNdke0oQ=;
 b=KSp4dGazpQ61iieLoOZ8rTT7rDakV07JasH3UlRc2ukmnu6Pd0w/6lShrB545KsOJnoU9/gUQNCUnR38jzEZ75U9YkjN40hQr258ieNVXqkfrxUxiLVWryDB7B1l8MtI3N7Lg9QnBlxbORkSJ+nUU0gVEh4PSJBU8nqBIH7Sqzg=
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:18:56 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::6f) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 09:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:18:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:18:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:18:54 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 04:18:53 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] configs: versal2: enable I3C support
Date: Thu, 9 Jul 2026 14:42:54 +0530
Message-ID: <20260709091357.1860417-4-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cf04a8-4809-4f06-6161-08dedd9b1a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0V2OlEhTJRRGlw+OTtfpCqSCG3arcPK129LsJiw00ddFNkEhgFHSY7IvVMUydR1g1/e3Iw5+t0sGMiGl2S2g8HNXsVj8DJkRghoVR+8VfqxT28EpJ2PFZZAdQlfkN5P6Qv8+tltGwH0y47th2u4WMxcD3O8Sqsebjs9XBWFjinBMznFOlwHbXgC3KY2NHxq3H2l4rbdWx+8z66yaD9ylo4QTFuE17L5ZBlvQ4tcZ9cNz4dmg62T8XPBT9fwvurdVCKY2juWtpCNvaR1PuKcCq0cd/6JWNrUnh439iniRoGYB3LXy+dm/mMi5bQZ6pQtM37YBx5etqHqaM0WHtvvLMHqntT791x/K5ZYkA2Nqm2qL99XkOTvWsNeqK3rNQXQd/IFqyt1zhcxnGH1Kj2ZZVUHlXlvRTQ2jhTtdgtYXXEnJcjuwcjDdJnSRS5IKQ836q6Kx3hjrM5FynI1oGCyLgy+E9upyWhr+7YaJgDRRNBRGo5IBFf9OfBhHQPvHtzbV/n1c61fgke2cb3nwmaNBEF6lll8Gs9WokMPIqyEBKyEfBFP5nlgIKkqq2Izrz7/UD3+s/AZQJZ+VXdA6zL43W90Po3U/uLkD1Q0BJCQpEtGjI1YJB2FrCaX6AogQ3YQEuDK0PuWng8NVR3nTZHWGypPdKXP9kBHK4VuJvPD9NvfD7bdHXCGyj4EQ7CSxE/k7nOUPcvmUuTZf6JIgCIR4mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6/XQcD5ftVhzBIoTNmYGm250j1dAOrBNyhJjk5QmM8j/D7AO4B0PudkKFefuxM33SAJz4aFaqbzzocrQW0mf89eJOD1DMIkvcxjkBf/T9bjs/4OXwMoS1yd3Rz0xDI3PMW2oDIf/nINKqHgh9WrckK/nm+gKdF1fOrfu6pfGVw0wcDaWPEmGXPEU5DZhwWGz5a4Of+1ZSgA6eW+JCCPWD7S0YsDnG2fpIZV19nET2JdLQYrE0KsqACtKawFu6t94i66p6njp4lF2CObCEp3KhVgtGpq9TwOjMvTI1C/GZyEZE3F0xUmG2iM+LO3kTOyFIU9zDlhg9RiWYHzmDYweQ3CeDN/W1G5qHJA1eAiIYoNa63PXolYPqqqMwVmd3rGhnCtlQzQ4DLXWmiLvgreVilRK9oqb6V5KxmDtYYcqBkUmiQEMf3UhIQN5b78fVpSq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:18:56.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cf04a8-4809-4f06-6161-08dedd9b1a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
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

Enable I3C controller driver and command support for Versal Gen 2 by
adding CONFIG_CMD_I3C, CONFIG_I3C and CONFIG_DW_I3C_MASTER.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 configs/amd_versal2_virt_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 00ccc81a83b..ea02b0c011b 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -46,6 +46,7 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
@@ -103,6 +104,8 @@ CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_DM_MAILBOX=y
 CONFIG_ZYNQMP_IPI=y
 CONFIG_MISC=y
-- 
2.34.1

