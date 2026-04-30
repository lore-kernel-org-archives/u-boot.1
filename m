Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC4FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE3580433;
	Thu, 30 Apr 2026 14:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G6F9lqnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96903842C7; Thu, 30 Apr 2026 14:04:40 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D564D803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwrFxN6XB52jqudHQ0QgNuu2TGyFqCxWFZbXhufnAbNF/8eitVSIXOgPnIDoYONCAhbk9vJiG8tYu9+daFOvN4Ja0XcvK6LyjW9uxltCMizrgHvktS8Knq8DPIT4Sjj9l8Bye/9ZG5Ced1/JBh1WChoxpt/9Oa8GfYIrvvHH3ZxAG/h1Lf2bAFga6KeAqNx86q1ntLolb5RF9qzfyUVUCAY1oiw5YcMAh4GKVpii6mldaXYHKEQr3OkJya6HrKs4+/Drx0kvi2V7GFTNy1t+LnXNJ+vhzSfBxm6O55Tz049kecN0Cplx17UhFVTztldu+17elgiu5mZdJdngXVVN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVvj6klk68RQ/YDdTyDSE+cMGSEh26sWilHdGwfkU9E=;
 b=s7AhPnLBC4wKqijS9hYEBCv9WVxCmtpuUY2oMQROnqGcMJxtC2KoLC4QXyd0+qdRYQUo3gX546J9FFv7+m2fCaB5XJf4r7DIxUHvfKlLJdc7Z2c0zmOH0ljC5MZ6+0tjCMm6/y5UFjeycVnd03Xr3DB0dbnVQ8wLWfb/h/Fnit+XNpdPQB7B9EEkoj0pEoCDJWfFvluxuloD4/oc7IrN3wlqKe2cXNXTV3ngt98jY1QCULFHr//z78z4NiFU3x7bKBb4NF7megC5qtybzKfa54GNvFgJlzaB3U8paz3c84c21ucYfJp/3KR9PeY2O7uWGy8YbUCgmLULewBa+07elQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVvj6klk68RQ/YDdTyDSE+cMGSEh26sWilHdGwfkU9E=;
 b=G6F9lqnI0pVl9v3rRnFgNnGSvW8WXxVRsOPEbGSOw8yfFyr/xT20Omnb5Ypei2VXTlt4mXYdUshhU2lcYh2ChmmBEi83tR4ZuDNCJuEc/W9Rknj8CTdIegN19yo5ewgJUPxTamerGmxU8apVUWui1VvkBQteIwBGZrrvtLJWlC4=
Received: from CH2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:610:51::37)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:04:33 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::1) by CH2PR15CA0027.outlook.office365.com
 (2603:10b6:610:51::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 12:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 12:04:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:04:26 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:04:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Padmarao Begari
 <padmarao.begari@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH 2/4] xilinx: mbv: Allow compiler to optimize inlining in SPL
Date: Thu, 30 Apr 2026 14:03:45 +0200
Message-ID: <09f2a62099abf561b91b0d3692714f0f29057d31.1777550623.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
References: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1wyX109LUg0FKEkjSJhBff/6KaeFRwxfd7wYdgUUe78=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+drVlWvDw6z8PX97Vk2y+Jhu+FNvmEf8m/tPZQDVl/
 cnOk790dJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEVC8z/FNROTRprYOx0n75
 TxvUTsccPe4TeMHi/8tL55gYAzOvXJnHyLDo8IpTEaIiV2LMZkVkuHuoNn76oisRwG6h58Ts+Gr
 ae04A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: a5369e62-9b39-4008-5ee5-08dea6b0a401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tWL2059W1gLLvB1cZ4jgpoDhjGdvXNIrMACM0ERWd1qDqFm5iSPSVQLDTv4VB3L73OviBn1PvWxwSGG3BWF6oPox8Op969IJBCOp8CtfE4yUsvWkvoZ1oS2SVGcK6hBDKG+rjm3TEch1YSGzA3Y4cO8afDkmjHILCc3tgxeEYwJwmy+dFgeCMEcpop4oW9KIAspA1UyawJN5ekaYvgowrReE9bJx/hUWJj+L69Ch5qUceKoG73VEb3x8uHcCx3cswQNlaPHRtfcK1/LQrone88pV27xkBcWozIHvFEalAV3w+3NjN/qLWdQ52/xzRGLXfz1JaYSyU7dINGRXzafj//rt9JJxUDPHdhQBqdIrF3EGrUT2by+klRkfXtSh+oKlvVx8kmQV8W/46i7ElyHTljnnlQ3OPckm2vBmnog9GwKZuP+wzFyiNzDe8ORgcNiGXoO1NkkUV3X0NACwwhbeni9Tn2hsWM9zaYXwjoIuQqqAUx2hTxEg5aThxUqw3POve2T+FbQN7QgbaWfPUAnU+Q2E0wrSUxaJZPTbCy5FYDK+3tImKcJniDB+M+BBJuPO3WN8T49I286cJyqBiImJpy9FML6RTcpCg8nB40RE6VRVquZ2YqzUJd9eHKiAvvvur5Q+XZ2sWiukzQN43PKfQ1Sh43uOflxf8Ml/d9YIX9ZWUCu1b5OU9Z9Ecx/JJe/EkrY7uUPVzvGcr2OPNslm2NRb0bUj8yoa3jZ8rk5gy0o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3sMEr3Pa5E/2Iu/Z/GP11Kdrs4BxsGfqSm5zbI6ULveMItF5bx9J9mMdpfPF1SfSA4Qmp5tOcAHdNw/KgznTWuWwbRxvxscraNFxBk8NVrE3FybP7LQjjO5RwXXLXFvlblwBIknQD3WitKqeN2TB7gjD1HWXZPIF0vcyr+32oGHYlgCAcy1qaTv34/xf6gVuaSVtjHwjxTcFXk3kdWf7IZHXqAh8Rp8reDXRS8u25KYVGSAP2+Pj7KJ2AOROB7pTyb8foB7vJk3KRASvATGofdFNE8kHciHwrXdDLh+5BGCzprtEEvXfOq86XtcxMxpdXyDvFtwB4AgMvB3ZwkxKWYXVbvBuTtBmHNPtS9z2LQcJewfuFMdKO3Zh0ArsnnwzNn5qYnwHO6RtXlBjDG1n5lk2Gm5NjSL8IH96+YfulIM7k1XueJ0DvNAyGRZqXCJC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:04:32.8621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5369e62-9b39-4008-5ee5-08dea6b0a401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

Enable CONFIG_SPL_OPTIMIZE_INLINING to let the compiler decide which
functions marked 'inline' to actually inline, rather than forcing all of
them. This reduces SPL code size by allowing the compiler to eliminate
unnecessary code duplication.

   spl/u-boot-spl: all -872 text -872

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 4a61c9eb5e3d..9d0111fe8e53 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -19,6 +19,7 @@ CONFIG_TARGET_XILINX_MBV=y
 # CONFIG_RISCV_ISA_F is not set
 # CONFIG_SPL_SMP is not set
 # CONFIG_AVAILABLE_HARTS is not set
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
-- 
2.43.0

base-commit: 6ada697cef076eaed1971c4877c402a91ad5cb48
branch: debian-sent3
