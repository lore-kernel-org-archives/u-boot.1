Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845DECD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA04D84659;
	Wed, 13 May 2026 09:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rB5L9c5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F2983EEF; Wed, 13 May 2026 09:19:23 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A16845E3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAWLkErs2bWqefwYmfQryZn0D0VY5kkc57WPpxBUDp+3WH6Eaxau2Iy+Qx480/FwnTaxhoFzdmdVgz1i+wcb1+OnCSUxaVoUacu2wChhdy5PpeG5HaACycRt9vqQbNamMJxDFgil0gngGNZqLMhGDQr16J7i30ttS8hM8PpDf8dPV3EJRtI/YF+PWVOEt3OIxA8GWVrhYLCYDxjD4QHa+sMAnP1kZB46NCwOSsbMWT7Mkpz3QGiMH7sD3rJ4LhWeeKaa/9KEFvoqf4jBl0oqpJTnjHK9JPX/BaJpU/2g0fwBfvFyPyIei2eGHcRN8Fy/IP1OBr8+Q22EeS76DxSsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NtBW1EHI5IDi5kO++y4CSr7cKsRb+4X85gRqibQnsA=;
 b=gVUQY6M6BS8VWxZptccP0RO4yIUddBt2BsZJ8j+ebm9aWwuBwXawvgiOmqJtR+UreklmLm0cLo673dMRG9sXVIh0DxGnNdQaIl9f5UcWmvHW3AzonbQ0cqe+6Vx8vLVanUusPRGSY5/KsXv9h3GbwSkmZL0wPQqzm3VVkJ1wXKyeFR5AqAG13pu98PpVwh9TOz2s58d/5HUDW2vhRw1CnYOz7DwKYsw8yLBwGNy3rx20ZJE+8/gmT0E1Qo8g9gG4MklwU/vhlkQoUDEDIvT0/E+N93jzzIYMXfNbgnUUTo6RY4IYZgL/BI6fNaFTUTMUfYpLZBtWdrlNw99LEtX+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NtBW1EHI5IDi5kO++y4CSr7cKsRb+4X85gRqibQnsA=;
 b=rB5L9c5CUFWN9PNp3lBt3Y3/Wk8YBwxceFTpWLTU7cycT37pE5QbognAVdmkm+fJCQ/AHV+hc3hvTM9WJGcr50GykQBBvz4b6N8B3RiIDf41pXGSfTTJJHa2dh1KQv1v98iebAqxWP60sqSkg3F1h4gkWfUgv0hoT2rFol1mVdaAeB5s2WHA3JAAnx6bRKAGNWimdh9DlaUwTy4wyCx1TBcq/PfP3LhGmGDH7rLpyWfiWvBN6nv1jAKTZ/7p/sFj4RzF7H1rz+WpuwWEYhNTds4kCU7WaIOeIuIA5uqvEj2O6UmdszxG2waBhtJXgTtxlnjC2rXgU4DfB4IsUBNyiw==
Received: from AS4P189CA0058.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::20)
 by VI1P195MB2381.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:19:15 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::48) by AS4P189CA0058.outlook.office365.com
 (2603:10a6:20b:659::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 07:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:19:15 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 09:19:14 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.haller@phytec.de>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 4/7] include: env: phytec: Drop legacy RAUC boot logic
Date: Wed, 13 May 2026 09:19:02 +0200
Message-ID: <20260513071905.83522-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513071905.83522-1-w.egorov@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI1P195MB2381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2587ec0f-1598-4036-fbe6-08deb0bff0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: l1uo09rzzWSo4wdu7wpT4UFeVxRDbm3MTNaDo5DmrTL73+s8xoxDJ//UkzQgPp8lzkDsApdw62gW0m9rXL9onTvFyx0XGVSesNfPX83K6pcqOBpM0jxYBTuOt7F6yiXdRbRUrXBUT3UEJK0qwlMlGswgiw3FMvOZqlBm++fKqm0uk4ZU6ug34N7A8T30WwE+Z3pNsyt279aEzNKXrGrqB6ENQRt15i5abIEwGlHmNJiQ4/hpVh9KideFnfB50I5KrGmbayY9752Qld2m73uY5oYAsvgLn7WCZ2bN/eUi3HfrAgd1Iw+Bb5t7PEwm039R2e8J8c5fAkOOoEvmouIteimgQqXEGfy4c0wjBOyWOdYUAUTGwdRmvGA6UqtUdc77nwUqMcg/T1STL6RlJx21MtK5llfCJUTafESF/4qdAT/gFbpOjBA6Oi5UJ59Wwl/5u7OkDNRhSaR/8znLle8RoBQWvWASdMRCvpe9aObFGq2F5jc7J59Ts0YnD9uecg132Nh2MDW8Xf8rxVEC5GldzQ4JUzB8C3MsZzJjPp9ffUHBQxEihiYuD5iW0r2q7UmYN8rocxRI8bA4M+l3xiJfuT7c/lRTUBkphgFloNFrECOtFYsbuIUF3IDXvU14Y6O1Nl3/iBmSxn09pzfi4Ec09Cm8p5wNUHCgC5+2GcEaFctci0kURQXIz6e/KSdk1uNWXEoSKMiE/eAcOLjb/MvFZh4vTpZLfpd0/XeTsMSfLWE=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qSO4xGfHZqFJfj9gVNXzMVNsKT7W7gEShoMiTP0uvwBd5HDH0eZPL723D4Dwyz5ZtD8fwQ6lxSoO3ku46R6ePzprYHdams4CROsVHi/imF2OHlN2bbavVMSX+PhOzqeFtvxGMdsTfb+35aaI5dfsLxeDKzAZzL6zw2VkJRzp/Sd0MZXZq4iS691HTI1WtlTEuVilyAfigJdFjMjaBAmTHrIeByuiWVY0aitS+D6OYOp10W6ufGZQc0if1tdMV7BD3GRQ2cyiulSwN6s5HG73kBVcJpRqxPk0ZwEKMt1Bj5VXOsRlRBKy2ky91BE3qX6A0SMS/N5x6nbjJguRhct2A9c7ZAZUQ2A96ZcavUFgCZipLoOfm5FRFzmyXnDBtaaAxwsdTYiNgqC2Ip25Jg1X96bWFVGTw3EPipOuy3u+fy2k4ZhXt41RaEUIM0yFODEF
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:19:15.7334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2587ec0f-1598-4036-fbe6-08deb0bff0c3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB2381
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

RAUC slot selection is now handled by the RAUC bootmeth, which all
phytec K3 boards use. Remove the unused env-based logic.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 include/env/phytec/k3_mmc.env |  4 +--
 include/env/phytec/rauc.env   | 52 -----------------------------------
 2 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 include/env/phytec/rauc.env

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index 95d0204b6da..8129b35ea5e 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -7,15 +7,13 @@
 /* Logic for TI K3 based SoCs to boot from a MMC device. */
 
 #include <env/phytec/overlays.env>
-#include <env/phytec/rauc.env>
 
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
+	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
 	${optargs}
 mmcloadimage=load mmc ${mmcdev}:${mmcpart} ${kernel_addr_r} Image
 mmcloadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=echo DEPRECATION WARNING: mmcboot will be removed in future versions. Use standard boot instead.;
-	if test ${doraucboot} = 1; then run raucinit; fi;
 	run mmcargs;
 	mmc dev ${mmcdev};
 	mmc rescan;
diff --git a/include/env/phytec/rauc.env b/include/env/phytec/rauc.env
deleted file mode 100644
index 89e17ff70ec..00000000000
--- a/include/env/phytec/rauc.env
+++ /dev/null
@@ -1,52 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-/* Logic to select a boot partition based on environment variables and switch
- * to the other if the boot fails. */
-
-doraucboot=0
-
-raucbootpart0=1
-raucrootpart0=5
-raucbootpart1=2
-raucrootpart1=6
-
-raucinit=
-	echo Booting RAUC A/B system;
-	test -n "${BOOT_ORDER}" || env set BOOT_ORDER "system0 system1";
-	test -n "${BOOT_system0_LEFT}" || env set BOOT_system0_LEFT 3;
-	test -n "${BOOT_system1_LEFT}" || env set BOOT_system1_LEFT 3;
-	env set raucstatus;
-	for BOOT_SLOT in "${BOOT_ORDER}"; do
-		if test "x${raucstatus}" != "x"; then
-			echo Skipping remaing slots!;
-		elif test "x${BOOT_SLOT}" = "xsystem0"; then
-			if test ${BOOT_system0_LEFT} -gt 0; then
-				echo Found valid slot A, ${BOOT_system0_LEFT} attempts remaining;
-				setexpr BOOT_system0_LEFT ${BOOT_system0_LEFT} - 1;
-				env set mmcpart ${raucbootpart0};
-				env set mmcroot ${raucrootpart0};
-				env set raucargs rauc.slot=system0;
-				env set raucstatus success;
-			fi;
-		elif test "x${BOOT_SLOT}" = "xsystem1"; then
-			if test ${BOOT_system1_LEFT} -gt 0; then
-				echo Found valid slot B, ${BOOT_system1_LEFT} attempts remaining;
-				setexpr BOOT_system1_LEFT ${BOOT_system1_LEFT} - 1;
-				env set mmcpart ${raucbootpart1};
-				env set mmcroot ${raucrootpart1};
-				env set raucargs rauc.slot=system1;
-				env set raucstatus success;
-			fi;
-		fi;
-	done;
-	if test -n "${raucstatus}"; then
-		env delete raucstatus;
-		env save;
-	else
-		echo WARN: No valid slot found;
-		env set BOOT_system0_LEFT 3;
-		env set BOOT_system1_LEFT 3;
-		env delete raucstatus;
-		env save;
-		reset;
-	fi;
-- 
2.48.1

