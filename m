Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99556C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 047328818C;
	Mon, 15 Apr 2024 13:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WAkLhoTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B27488190; Mon, 15 Apr 2024 13:35:43 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136E68814B
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDXoiSFtEd5muXyJ35nrVIiivXt8SjTw1+Tzi8AgbmfyXGuM8IWe1I71zV0qO2Y9WjFZXrhjMsqsyrBgVkzXCw3LJ1eqa4ZEZufLjAjk3j67fviWekzIOZi5HOeLA61MbBhrzJU9cUZlMbyIeEjVzM+uUGQS8wGgLn7oP8ZbK2HgLm8pQtwBqgMTW0WLbZoG2qQMpOGqFRHaoEXB9u/2KIXPd+6oO92Ocox7qjWQrO29bb/Dir4AR3fEI1OC/Z2g32ppDOAQq6OwKIqkl2yfSLwrx87BAYnkPO9RomkxOHZeKvgB5t1oOEjPms5E3neGEroLE4GN8D0OX/nyHF0PMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9Su/Kzcuil6pkkVAi3X8U1XVly4U51WzjZpzSzr8iw=;
 b=bfBohsrNxt8T2xtg4ZVh/WPQbQW9+a27tjjT3pNlQ0iIUlVPgSdfQf53AZarvoxLYd9KyrSwSdLMKXtCupYFZQnLw0Z+GQQGfdKAvP6IDD3quEyXc3sj0RRVxoM3Brp8xNBmUgy5xgdVxfjwcchpBh2CNNmqw5p4kAaer5CWyKelS4qxWG0DpjSp9QLIKSo+oWplwhZhBk5PJ2Z8r7Ti6JcfiKSRNZzKyC22sPFJKQgiQcTXe4zX61M/XLT9s4EUA3XGjWsNjO5Ez0Uhp1qDVCxncXN8g0Or6pWQ6B50Kwz38N1/EVm24rKfuxF5sD1/+SQnJjTnuFTVdCN1KRqh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9Su/Kzcuil6pkkVAi3X8U1XVly4U51WzjZpzSzr8iw=;
 b=WAkLhoTF0h9mp92KCrY86d1UJLkArJf4xePZ8rSciglV5c4d0+5tqEu+PECuForwLgfI0NjKy9CuLpcpCJHBRU7jsUeJ6y1e6z7ndPGMmZ9ahIhUkalw/svrhwwaxeGgKLWvHziKWpV8oS4iRtUwW47zGtgvmTZ+p3Jlbc60aLk=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Mon, 15 Apr
 2024 11:35:35 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::83) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Mon, 15 Apr 2024 11:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 11:35:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 06:35:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] Kconfig: Add missing quotes around default string value
Date: Mon, 15 Apr 2024 13:35:09 +0200
Message-ID: <b8bee323b100ef1f5958e2f64e14e9776ff2bc06.1713180904.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713180904.git.michal.simek@amd.com>
References: <cover.1713180904.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AIbuhTASqXBbFRrHyQaq82vs8RKVSbmypBs2n8+1mC4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjRZga9L8vRWXu5lnjpx5REtnxkfrV8rFhs1JCldfmKSt
 fOSZemcjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRN2cY5um2HbD1uC30/mjW
 MstLf65IcvO65DLMdwp69+mv1r9zcRs8pK7dfuMnem7zAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: ab67519d-e685-4c1c-757d-08dc5d402aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNaCisgJss8i8md6Jcr+E+s5H+lnusAmGtaWplCOqVOTQ69GhClv2qlgTv08FfZuTwxW5oeOpn9zO6RIU45q2SW00NXSDc/nbr8Yo99VF6GedYQ97ZdgJlpUrN/7l0rZltcz8f7+dem6bv9rRWvB8xMk9k16nxX2Y40q6rxU3W+rDaVos4yV/nk7bNHpBXDow5tb+9yM2YRvXBD97IDdd9CqahHVMGECDqqWAa1d7/cntBzpDSRGBq3FVc/Dk+Kkjz80EkaiP2JS2iXs5oNozBJirdJ+tjDglpHDkquMzlaxXPlX4F0VW3/Pbb3n2TQVe30hxsMk6/Ntf1UhHVBS8ZNsuwKuuSdqRtBagnwS30ec6UswwF0OdWfDbWwmlnRbWLpm3hknaRWaj4fuVIvEoNhzva1HJAMLFTjaVfT9JTfDGanXn8jZ3ByGaJ89ZLSNAvZ3pZxo3NXzi7uncDSDEntdVVCBw6X7uk/VfaJ7nL+4ULCKb7mAQbEu0mrGD3L8wsuQF5MW5j8p3SYiiZ8gMisS4nJjctiubuxDMmMZyVX0u3EotyWpFFYwJVasFRADrGlf+vgkMwUH1skXTLNrKjGgOLsA81I/2xOGEY+wgbdxoVjTMXFDg1KDY1RJVpjzAjjZmQp0XvOk+KbW47d+D+gxmSOPr77KIRNdrKr0GQHbo+Hv/oWE8VoetsY4MO34yLaOCzX8Dhss+UeE8o2VWHdFc5CZv/AECVq6QOBkOUGdzGFn05iXZgAsAkWWYCaV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 11:35:35.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab67519d-e685-4c1c-757d-08dc5d402aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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

All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
Error look like this:
warning: style: quotes recommended around default value for string symbol
EFI_VAR_SEED_FILE (defined at lib/efi_loader/Kconfig:130)

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/efi_loader/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index e13a6f9f4c3a..a5ab7d1b262f 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -129,7 +129,7 @@ if EFI_VARIABLES_PRESEED
 
 config EFI_VAR_SEED_FILE
 	string "File with initial values of non-volatile UEFI variables"
-	default ubootefi.var
+	default "ubootefi.var"
 	help
 	  File with initial values of non-volatile UEFI variables. The file must
 	  be in the same format as the storage in the EFI system partition. The
-- 
2.44.0

