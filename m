Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C4C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 18:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF8A3606CE;
	Fri, 31 Jul 2026 18:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WUxpGAw5N9hu; Fri, 31 Jul 2026 18:13:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4223C60680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785521633;
	bh=T9gW9UANAeobSvBjPbUpPeLud1HRc73P46WJZY0Q30I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBnug7MoWCykrZ2XUG6v2/sOc3gHPd2r5QssBU6jdKVRMp75YiQvu0l1+KSsJ5i96
	 M/0deoiOJHXTtlBWyUYCkN8Z7i5EiA6PjlTmmRUMzgflSY0sxwy2fsoyJuKlVAY03f
	 trWVobZOXLaHZNeLvcdAm7r/e32Oy1gHOfWRoypx620xPG5o+Ip8aO5C/gWw0avTbV
	 ERH1T/GnPnVdOv1VOWTFxNZnYPNuJwC+JPQvOi5jS38wMAmBTh/flF+9GzJFIFV8IL
	 4R3NCORonVVfLAKpNEYz42z3ARxsolGKVNSgdtB5j6m4XZCbL5B4UTe7kbjNOp44m1
	 vyGmWo+WT2Kqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4223C60680;
	Fri, 31 Jul 2026 18:13:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 72C1936E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64B17400E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2L0zARP_lRNW for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:11:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=smtong@axiado.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2570140025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2570140025
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2570140025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D67484A29; Fri, 31 Jul 2026 20:11:08 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F08184A0F
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 20:11:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3GEiCA1UM4Y+9zGk3skG8Ry/3DThK8K0pgD1u+7vSoa4ph8dJ1kdVaLMnSnWlLXxfxrj46uyO6LWdkrRZS0FVK2A2BBGX00GtclXk9gs9AIQGkRfvP3jsBIa/b8mRakZ1KRazGB+ighLdqfee2Kcxh7FqMWbMXdNsuZp5lWn6G0d8auewLjVIJrLMU64uBWepFuqjFmgdNChw+60KnJKZOUaZaEgAmNerYtHtL2VKQFDRWhMIqtA6RwsCyGojp2Dmmo4vNSGZXucc9Rhhi9ajrEY6E0ofLx9w2SZcaGykIu2TDezbInE2kMJQK9qbD58uoEol4ZJXqn7voi9Vjc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9gW9UANAeobSvBjPbUpPeLud1HRc73P46WJZY0Q30I=;
 b=QFnuO9YbmOGittAgwVeBl2aH4OPr+kp8uKvU+uaiDhcXEWT8Q9e6S2eWSiN/tUxDlJdR0vXNemweYst0f5YIj5tsGdT/HUZGbJh9dqJp2utAHIa3r37Tr3b7PrF4rDFuVFtLhW2hDcXbLQIYOP9wOcE5gTKr7KeENmTP1OnuJ5u055fJwIyFweYQJsZxF8DzRf09ftRDauyzcuwLV3CmgUjWcDLDiuVa+Fa+bkjKuBDQPbqqA7LW4Flnc4TymkToZmdzO82BuxjP4RCCGBdmxmv/RULzHi4seMOlV+XC4NBFC0aDfm4LAX4KK9kFRTGYG7OcIXorBnWg0A1IULdefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
Received: from BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::19)
 by BY1PR18MB5840.namprd18.prod.outlook.com (2603:10b6:a03:4b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:10:57 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::70) by BLAP220CA0014.outlook.office365.com
 (2603:10b6:208:32c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 18:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.0
 via Frontend Transport; Fri, 31 Jul 2026 18:10:56 +0000
Received: from [127.0.1.1] (unknown [10.4.1.117])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D43AA4186B59;
 Fri, 31 Jul 2026 11:10:55 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Date: Fri, 31 Jul 2026 11:10:50 -0700
Subject: [PATCH 2/4] mmc: Add Axiado SDHCI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-dev-scm3005-v1-2-30bea90ac5f7@axiado.com>
References: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
In-Reply-To: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Siu Ming Tong <smtong@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10245; i=smtong@axiado.com;
 h=from:subject:message-id; bh=GshA79rTv+R3N0vjAxHbLSc4oqnG0OKL2wIGnGVRMEA=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqbOUuDb+hcYhfyp0OlISP69cer/ngfrz+QB/g7
 8mA+ooPhiyJAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCamzlLgAKCRB8HKhyFELz
 jlw8DACOWoZ5IK/Vym6nfux/NJxSGDp2mRcQ0nDNbM1dQYJOE5dBmHjz3vcManj7PoW21jdfWjU
 PRp5gy/xxA4pxVWwnW1Db2lRl+kUfYSqK5xxvazElaWPUYP2CjrN9V6Vix/T1ba95GXxY/OAA+o
 o4hajgYwbyAxId2st2stK1HmCCvAN9ftvbf2C9CCJVg9IfIqPMxJMETYknvJZTb9ZoRDbRklmVj
 N6/yTZrRz75Eob4hiOy/ZMdVSzslVCoidTymxt9o9ezHLAy1r50wUAWj8AP0Zr80aeLKMLWBfBs
 /Zo3fS3IMoMKbFQZ4vvaZGxQJDPxFJ60rzmw264OEKzqnoi/S4fVark4DAoEZgef2wop80+qc1X
 //dN28A1XpAE5TX8usHcj/cmi9KIdUN7WGNNPKTabCC7lnTsv3Woh/7cE5frrGsUNKLk8xzpj+n
 jcCnLpiPdOPOgfY655etJWnZz5grG4ZyzDpsE5+iMm8TWwcosiJXktUwBIHh9gbFHH6G4=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|BY1PR18MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f18c25a-b6bf-4be4-eef4-08deef2f1165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IF4jLhbKgE/wg1pX4jKiT3Uo1YFE85SiQ85Rh8UFM81apWTjeTEBQqe0K4upYFV0ymWSmFml7HVzdjawxeNMv6SR2xHWpmUcoYCVuHKq8goFjn6HgaSZ/MtzzcsROnlkxeSeoPOoOrkzM6PDvUcSUxmd/peMfSlXdU1q7CGTaTrokq+00S/aaVTHwg5EonSdbiNGsnEeI4JVWa8Kh3upnTo9VysXGZJrZX4tZB6HiSPk0FItx/TI3tFH1sOkF+zRIc+6AA1Tlwyejvhq6QQ2LfiTjKSJj5qNRFrFIofsfACnm4Lc5b8PPYThbCxnYEiVJu6tYDrlIt+IpHmz/7I6j2n+H2y+efmeZQdsBheJub9o5jMVbwnfVbVsp4UsdC5J0mUO6ha1sDxvaaNh/CrklzizRz/II3AxiP7PrrNvFYaQMEntMxQazUUy6pfGjScjAPz3ypJYV6515S7ia9Nq9uC339H7drjKlT4a0XUTE1FiWQFhf7IJEsBQhV+sSaYDH+yCDF/arEy9Tmhx/0RUYf2JB+4xpXz2Dd2JXQea/hsLlGmgonmoGNKKKvvLGzcXP0hJlgNENnbaWmRWmWpTvNQnoTh+tZxW0y71+78KPeuCwN0mUibG08+RbouZwzx2QXlLxJsUNj8vVNm2zLp0Mg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 10Aec7o2oj6BRYGXammXI3GwpyCfLP4Fd2PQTYNHkACnphAAHsDXy4vxgQoPTpI7clgzFX+ZEsG/63r0Xev5RhGk1hssP4S7ELGb4z7durTk9V8zf3X5WxyP+0O4PC2aTmTkBGe4nIVKG90oD0ERhLHn5hjN08z5aJSF0h8oiCq/r5OsCtnEn33z3xsuLhBANuHnJZ7oyTXyhV+HTujB8XbT7EPSe6Wc/3bShCOh8Hhiwp6u4teCMqBOmC+eIM/gcU2cR5WYAYdj3BOlcEQklofCIMC0HUCtG5iz2kilZ8VimWRuhwPgoGMoNB5kmVjE8DGtH6n+1CAm2jsRTC5c63btQlHf4TSzaUwoUeCjKbyQwun4Vek+8I1oIn+m2yVmZ/ETJHTnmEjv6TT9z1BLLJIPGcL8xM+ZfNc98lxwWcf7hDRIfB9Q2+ijj0/dlQzq
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:10:56.5825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f18c25a-b6bf-4be4-eef4-08deef2f1165
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5840
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 18:13:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axiado.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9gW9UANAeobSvBjPbUpPeLud1HRc73P46WJZY0Q30I=;
 b=HEG+MgqE/Dlqx0UGvw8R9DRf1C1aXQntpgLtGsjX/sHVSeiH7wXso5KjjKxJtfpWkYFyO5Ps5B9Zygr2jeaCpIm9kVfXk2Kz0hdviH+LK9dFlpmMuW3Og2S3qa6FOrzT0TFcACZzq+xdslTGtKnn8m4C85nAC7VRCistwJ5fxZ5SFG66Ry1ratrU1OJ6qFHuTfgtxaVwckBqgw8tbxXfbc0BUSpZsoi5uy1zKAbOqWX3QKsSeXwNcb55fJEf8xo0qOLvHZsXXNkotRqIDFOz2ZPcATvnIkruMZe79YvKH/WSw+SX+GZyGFtTQ0KhMDdAA4/us/11HojkXbXWJCUKPg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256
 header.s=selector1 header.b=HEG+MgqE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=smtong@axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=axiado.com header.i=@axiado.com header.b="HEG+MgqE"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add an SDHCI host controller driver (MMC_SDHCI_AXIADO) for the Arasan
SDHCI controller found on the Axiado AX3005 SoC. The driver builds on
the generic SDHCI framework and adds SoC-specific handling for signal
voltage switching, HS200 tuning and eMMC PHY power sequencing through
the generic PHY API.

Signed-off-by: Siu Ming Tong <smtong@axiado.com>
---
 MAINTAINERS                |   1 +
 drivers/mmc/Kconfig        |   7 +
 drivers/mmc/Makefile       |   1 +
 drivers/mmc/axiado_sdhci.c | 311 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 320 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eece4e5ebd0..02a0c171840 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -232,6 +232,7 @@ F:	arch/arm/dts/ax3005*
 F:	arch/arm/mach-axiado/
 F:	board/axiado/scm3005/
 F:	configs/ax3005_scm3005_defconfig
+F:	drivers/mmc/axiado_sdhci.c
 F:	drivers/phy/phy-axiado-emmc.c
 F:	include/configs/ax3005-scm3005.h
 
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f9f7aa5cf97..4ee56465c0f 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -114,6 +114,13 @@ config MMC_QUIRKS
 	  are enabled by default, other may require additional flags or are
 	  enabled by the host driver.
 
+config MMC_SDHCI_AXIADO
+	bool "Axiado eMMC sdhci driver support"
+	depends on MMC
+	help
+	  Enable this to support the Axiado eMMC sdhci found in the Ax3005 SoC.
+	  This sdhci provides functionality for interface with sdhci driver.
+
 config SYS_MMC_MAX_BLK_COUNT
 	int "Block count limit"
 	default 65535
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index a23336d7d8d..f4a40ee10d5 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_NEXELL_DWMMC) += nexell_dw_mmc.o
 obj-$(CONFIG_MMC_SDHCI)			+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_ASPEED)		+= aspeed_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_ATMEL)		+= atmel_sdhci.o
+obj-$(CONFIG_MMC_SDHCI_AXIADO)         += axiado_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= bcm2835_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCMSTB)		+= bcmstb_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
diff --git a/drivers/mmc/axiado_sdhci.c b/drivers/mmc/axiado_sdhci.c
new file mode 100644
index 00000000000..a1cf22ad4f5
--- /dev/null
+++ b/drivers/mmc/axiado_sdhci.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021-26 Axiado Corporation (or its affiliates).
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include "mmc_private.h"
+#include <dm/device.h>
+#include <linux/err.h>
+#include <linux/libfdt.h>
+#include <malloc.h>
+#include <sdhci.h>
+#include <generic-phy.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+
+#define SDHCI_HOST_CTRL2 0x3E
+#define SDHCI_CTRL_VDD_180 0x0008
+#define SDHCI_CTRL_EXEC_TUNING 0x0040
+#define SDHCI_TUNING_LOOP_COUNT 40
+#define EMMC_MIN_FREQ 400000
+#define EMMC_MAX_FREQ 200000000
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct axiado_sdhci_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+	unsigned int f_max;
+	struct phy phy;
+	bool phy_is_on;
+};
+
+struct axiado_sdhci_priv {
+	struct sdhci_host *host;
+};
+
+static void axiado_sdhci_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = (struct mmc *)host->mmc;
+	u32 reg;
+
+	switch (mmc->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		reg = sdhci_readw(host, SDHCI_HOST_CTRL2);
+		reg |= SDHCI_CTRL_VDD_180; /* Set 1.8V mode */
+		sdhci_writew(host, reg, SDHCI_HOST_CTRL2);
+		break;
+
+	case MMC_SIGNAL_VOLTAGE_330:
+		reg = sdhci_readw(host, SDHCI_HOST_CTRL2);
+		reg &= ~SDHCI_CTRL_VDD_180; /* Clear 1.8V mode (3.3V) */
+		sdhci_writew(host, reg, SDHCI_HOST_CTRL2);
+		break;
+
+	default:
+		debug("axiado_sdhci: Unsupported voltage: %d\n",
+		      mmc->signal_voltage);
+		break;
+	}
+
+	sdhci_set_uhs_timing(host);
+}
+
+static int axiado_sdhci_set_ios_post(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct axiado_sdhci_plat *plat = dev_get_plat(dev);
+	unsigned int speed = host->mmc->clock;
+	u16 clk;
+
+	/* Reset SD Clock Enable */
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Power off PHY */
+	if (plat->phy_is_on) {
+		debug("Powering off eMMC PHY\n");
+		generic_phy_power_off(&plat->phy);
+		plat->phy_is_on = false;
+	}
+
+	/* Restart SD Clock */
+	sdhci_set_clock(host->mmc, speed);
+
+	/* Power on PHY if required */
+	if (speed > EMMC_MIN_FREQ) {
+		debug("Speed is high enough, powering on PHY...\n");
+		generic_phy_power_on(&plat->phy);
+		plat->phy_is_on = true;
+	}
+
+	return 0;
+}
+
+static int axiado_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct mmc_cmd cmd;
+	struct mmc_data data;
+	u32 ctrl;
+	struct sdhci_host *host;
+	char tuning_loop_counter = SDHCI_TUNING_LOOP_COUNT;
+
+	host = mmc->priv;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CTRL2);
+	ctrl |= SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CTRL2);
+
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
+
+	do {
+		cmd.cmdidx = opcode;
+		cmd.resp_type = MMC_RSP_R1;
+		cmd.cmdarg = 0;
+
+		data.blocksize = 64;
+		data.blocks = 1;
+		data.flags = MMC_DATA_READ;
+
+		if (tuning_loop_counter-- == 0)
+			break;
+
+		if (cmd.cmdidx == MMC_CMD_SEND_TUNING_BLOCK_HS200 &&
+		    mmc->bus_width == 8)
+			data.blocksize = 128;
+
+		sdhci_writew(host,
+			     SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, data.blocksize),
+			     SDHCI_BLOCK_SIZE);
+		sdhci_writew(host, data.blocks, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
+
+		mmc_send_cmd(mmc, &cmd, NULL);
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CTRL2);
+
+		if (cmd.cmdidx == MMC_CMD_SEND_TUNING_BLOCK)
+			udelay(1);
+
+	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
+
+	if (tuning_loop_counter < 0) {
+		ctrl &= ~SDHCI_CTRL_TUNED_CLK;
+		sdhci_writew(host, ctrl, SDHCI_HOST_CTRL2);
+	}
+
+	if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
+		printf("%s: Tuning failed\n", __func__);
+		return -1;
+	}
+
+	/* Enable only interrupts served by the SD controller */
+	sdhci_writel(host, SDHCI_INT_DATA_MASK | SDHCI_INT_CMD_MASK,
+		     SDHCI_INT_ENABLE);
+	/* Mask all sdhci interrupt sources */
+	sdhci_writel(host, 0x0, SDHCI_SIGNAL_ENABLE);
+
+	return 0;
+}
+
+static struct sdhci_ops axiado_ops = {
+	.set_ios_post = &axiado_sdhci_set_ios_post,
+	.platform_execute_tuning = &axiado_sdhci_execute_tuning,
+	.set_control_reg = &axiado_sdhci_set_control_reg,
+};
+
+static int axiado_sdhci_probe(struct udevice *dev)
+{
+	struct axiado_sdhci_plat *plat = dev_get_plat(dev);
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
+	struct axiado_sdhci_priv *priv = dev_get_priv(dev);
+	struct sdhci_host *host;
+	unsigned long clock = 0;
+	int ret;
+	struct clk clk;
+
+	host = priv->host;
+	/* Get clock frequency */
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to get clock\n");
+		return ret;
+	}
+
+	clock = clk_get_rate(&clk);
+	if (IS_ERR_VALUE(clock)) {
+		dev_err(dev, "failed to get rate\n");
+		return clock;
+	}
+
+	ret = clk_enable(&clk);
+	/* U-Boot commonly uses ENOSYS for "function not implemented" */
+	if (ret && ret != -ENOSYS) {
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	if (device_is_compatible(dev, "axiado,ax3005-sdhci")) {
+		/* Get and init phy */
+		ret = generic_phy_get_by_name(dev, "phy_arasan", &plat->phy);
+		if (ret) {
+			dev_err(dev, "can't get phy from DT\n");
+			return ret;
+		}
+
+		ret = generic_phy_init(&plat->phy);
+		if (ret) {
+			dev_err(dev, "couldn't initialize MMC PHY\n");
+			return ret;
+		}
+
+		plat->phy_is_on = false;
+	}
+
+	host->ops = &axiado_ops;
+	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD;
+
+	host->max_clk = clock;
+	host->bus_width = dev_read_u32_default(dev, "bus-width", 4);
+
+	if (host->bus_width == 8)
+		host->host_caps |= MMC_MODE_8BIT;
+	else if (host->bus_width == 4)
+		host->host_caps |= MMC_MODE_4BIT;
+
+	host->mmc = &plat->mmc;
+	host->mmc->dev = dev;
+	host->mmc->priv = host;
+
+	ret = sdhci_setup_cfg(&plat->cfg, host, plat->f_max, EMMC_MIN_FREQ);
+	if (ret)
+		goto err;
+	upriv->mmc = host->mmc;
+
+	ret = sdhci_probe(dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	clk_disable(&clk);
+	return ret;
+}
+
+static int axiado_sdhci_ofdata_to_platdata(struct udevice *dev)
+{
+	struct axiado_sdhci_plat *plat = dev_get_plat(dev);
+	struct axiado_sdhci_priv *priv = dev_get_priv(dev);
+
+	priv->host = calloc(1, sizeof(struct sdhci_host));
+	if (!priv->host) {
+		dev_err(dev, "sdhci_host malloc failed\n");
+		return -ENOMEM;
+	}
+
+	priv->host->name = dev->name;
+
+	priv->host->ioaddr = dev_read_addr_ptr(dev);
+	if (!priv->host->ioaddr) {
+		dev_err(dev, "failed to get I/O address\n");
+		return -EINVAL;
+	}
+
+	plat->f_max = dev_read_u32_default(dev, "mmc-clk", EMMC_MAX_FREQ);
+
+	return 0;
+}
+
+static int axiado_sdhci_bind(struct udevice *dev)
+{
+	struct axiado_sdhci_plat *plat = dev_get_plat(dev);
+
+	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
+}
+
+static const struct udevice_id axiado_sdhci_ids[] = {
+	{ .compatible = "axiado,ax3005-sdhci" },
+	{}
+};
+
+static int axiado_sdhci_remove(struct udevice *dev)
+{
+	struct axiado_sdhci_plat *plat = dev_get_plat(dev);
+
+	if (device_is_compatible(dev, "axiado,ax3005-sdhci")) {
+		if (plat->phy_is_on)
+			generic_phy_power_off(&plat->phy);
+		generic_phy_exit(&plat->phy);
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(axiado_sdhci_drv) = {
+	.name = "axiado_sdhci",
+	.id = UCLASS_MMC,
+	.of_match = axiado_sdhci_ids,
+	.of_to_plat = axiado_sdhci_ofdata_to_platdata,
+	.ops = &sdhci_ops,
+	.bind = axiado_sdhci_bind,
+	.probe = axiado_sdhci_probe,
+	.remove = axiado_sdhci_remove,
+	.priv_auto = sizeof(struct axiado_sdhci_priv),
+	.plat_auto = sizeof(struct axiado_sdhci_plat),
+};

-- 
2.34.1

