Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C21CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 09:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98058331C;
	Wed, 13 Aug 2025 11:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hABVEHxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E89832FE; Wed, 13 Aug 2025 11:44:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FAB9832C8
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 11:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i48NfGfUuVLBKefCWYUP6ir2qfSpsI/PvU5PfrcF4rYAjuvA7PuunHiP/wCdQ8h/Hc1HPBn1rQKQ5/AltnYiMKS2MZr9EwA6Az7Rajpk3uQf+M8fRgdiEKjPu8h0NvQuOKyODEx+Na/ntvhbwHGgKemXIBB98icQyeFohTcjGUu2D5x6XP7sskH76Gp5LiuPjHW3pIKKvejn7j4gs7e4St9nGu1EGZio/Wn4pG/RxZcYBDTACubiQb+wTChXvXxvYyfQCDsVCbvpuncZYNpMbfsF/3dI5NtHxXqk6URCsfmAxedKRnaqWgyEFAsYjibCxthIUxa5jcMeaCD0aGkL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1q6ep9WOPTd3TPcqgIVLUoDZ5DveCxXtASKJW/DFKQ=;
 b=bNewG9yJAn/OGckPp60PbVJbB63wXnab6xOuiKkaf/euTAev3iwuYsrw9q8lnjy7aVgbJbg+plIZFba3/dgOw3kbqv4lDOHXhECsnacqJdIJMNrql5KIHzlBOiNc46nS0tzBS+FwNM/SEIykzqRxxnydNAjqV+erAg6MphPKzC5kWPwxhOKRIoK9Cu7aLjlnaZQwPRJqp3oGwWKGeXHhi+hLgGVxsDQlGojREo2IGmIlWt/zO1Y6D9wXFAj5DUqQuXDlJP6pgyxjAbqnDlAeurESbuNI6038/ottqYofei/1HcsxFnt0GxoVASarExdPrBzqqPRju7Z/0OKMpkzGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1q6ep9WOPTd3TPcqgIVLUoDZ5DveCxXtASKJW/DFKQ=;
 b=hABVEHxU4gowE1jNngfAzSYltYCmm11dV9qE5k72rn44+aOOa6gv3M982ApiS5Z4/Rv6c3wwMXJ3xzyX+ecF74oAQFk4bdQkRHeXLJRWQj44Urzmmas0jszJYYQrwE92MScmpPjrp2BaQlt2Q+rTnRfWY5zqEMPFqUaTDagLS5pamuYyaGtQ5pzyhHqbNCyZRLkVmrf0zIol81e68om6MzMWiUDDt7OblhfL7UW/IGsq8Tg33CgcLPuouZKiLOUPvADo/9auVknlYyOyA5mz295tIczCkEKAAWKNYlQAgO6/3KKioOPnaNW3Xtq6hCS+8/25Ci+JygmBnLel+AB3qQ==
Received: from DU2P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::35)
 by DU0P195MB2074.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:410::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:44:06 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::2e) by DU2P250CA0030.outlook.office365.com
 (2603:10a6:10:231::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 09:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:44:06 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 11:44:03 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 11:44:03 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 13 Aug 2025 11:43:32 +0200
Subject: [PATCH 1/2] phytec-imx8m boards: enable OP-TEE for KASLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250813-imx8m-optee-enable-v1-1-bbff23f047e5@phytec.de>
References: <20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de>
In-Reply-To: <20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755078243; l=3404;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=GglVISYWkf03epQswfViOlTE3uy8bJCfNJpKlh5SN/w=;
 b=qR7WAy5R5gfZREvkGqu2lzTzmgW4/v1/k7vUnuvRd+qnZGXLFWeZTo5nCv5qcsFmxonB/4vyw
 +mTNdpQacWKBq2rkI6Wktwg+KBbGovi0iG7dWgBwm9JdicEH+g/0ikc
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|DU0P195MB2074:EE_
X-MS-Office365-Filtering-Correlation-Id: abaf24ee-8cfa-4441-f98b-08ddda4df245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akxJQnVPanJXOXhZQzl4alJLQ29BaVdFVmFlWGtOTDBMbFVocGdPeEVsNkx2?=
 =?utf-8?B?ZGFxNWs1UmlwK0ZWMGJZaDhxZ0tYWEpPTURrV3FpOTZjSnBJTWtFeTROdE5N?=
 =?utf-8?B?S2ozUlRVemJaRTVsQ0VyQjk0MUQ1SldudUxVUDRxMytUam53dk91RTR6RDBJ?=
 =?utf-8?B?WEM5Mkk2QjlQWWd4c1plKzVQWTR5bUlqcURlSk1WbktOaTVBSUNXOHVpKy9s?=
 =?utf-8?B?YmlLVWsyWHJ4MWFlMGE5RUhQaFd6TE16OGNvODUzWnRMRGVRWHNzQVpQdFR3?=
 =?utf-8?B?RWdObzNCZk9kdXZVZGxMOEpPZTgwOUlHOTRYcWY2QmovajBxazB3OTBqa2hG?=
 =?utf-8?B?NC9vSFllVHNsN3gvR3VHV0w4WmRvenpjbHBVV2t6c2NlK0hCdHBZMDBJWWhv?=
 =?utf-8?B?Qm4rYzVaTjMySGhaNk9kWkcrb0dqZmk5TTRSL3U2dG8wUkVyMG1XaTFnRWds?=
 =?utf-8?B?UHcwZCthMHlUU3ZKTjdQMnVVWmlCd2MwZUx5TWpkRStuaWtLY0RyNU9QYnFq?=
 =?utf-8?B?Q09QdXhtWEYwK2dpQUlkcnQ4M2FxNmhxcGRZT2Q3SkNmeEtZNlpJMFdDQ1o5?=
 =?utf-8?B?SHVnSnBISVJrMU81LzlUcW5WdkMrYzRwbzBMeGhEK3Rja1NsODB2dTVDMmtF?=
 =?utf-8?B?eVZNT2MwRzExc3paRksrZkl5cWk1dkIyS2s0WGRjWU9ZVEpmTHRSVDlyU1d3?=
 =?utf-8?B?MSt5TnRJSHFDZUR0M3MxZzd3S0orSTdSS0FWSmlHOHpTYWVObmJ4RUF1K3ln?=
 =?utf-8?B?c3c0WUZDNDBkWjhOOHUzTTRlT1dnRmxkbFZQaVlpazN3d1RVZjBlUWpNOEts?=
 =?utf-8?B?anhoSXFQY04wZlhzbHVRWGFJcEhNVTgzZ0VCS3RPYzJuZTI5ZU5JTHkxaFhX?=
 =?utf-8?B?QlJvd2JXTEIxZUs4aDVMMnJTVjYzNWRYTVpxMFBtM1QxRnFUS2l6bXdIU0Z4?=
 =?utf-8?B?Nm1hL2NubU4zRDhUWHk1YVZqeXdjc2lpcHhYeWdBS2J5enFqN3R1VGRxY2VJ?=
 =?utf-8?B?Mmk0bFlBV2Mrck1OL3IrVDFRU2Ezc1FDSnBRYkhvL3dCMVlNREdvQURPUVdP?=
 =?utf-8?B?QkNualdoYjF2NlJiSVpsV2hFTDcxQ2tjNVVQNkMydHNWemlUcThwWTNDWWRk?=
 =?utf-8?B?UXNJLzg5dGM4LzVkUVJrVXRJOWlOMXJJV2VxdFZ5RzY2TXoxNzNOdDZlLytn?=
 =?utf-8?B?TDFNdHBZT21JcGhVcTVycDAxbXdwUFplRjV2VHMxN3dDNWJCakV1ZGRTb1Rx?=
 =?utf-8?B?cUlETFBqK2plWnlhWnJWUk5kdWVndGFrOVVrb3djaS9LR08wZ0JGSCtzVWlR?=
 =?utf-8?B?eGpxM3JSNVdiOFEvKys0bUcxKzE4aUc1OHQ4M3FwVzFNUjQrOVRRWlp6enRs?=
 =?utf-8?B?WlUyZDFGd0NvM0pjdm96MHgrOUVoRWZQMk1URU9aenNzMWxpRlVEak1jWGIw?=
 =?utf-8?B?TzQzMDNzKzB1VzRlRSs2RCtnNEVubUFmaWc2RzdrdFExcXlEZmo2ODdqZnhJ?=
 =?utf-8?B?d3g4WkU1VVdtSGJHbS8rd2RoUTJ5eTMyM1phM1pvb1lRRHY4QVhUK0l4WWY2?=
 =?utf-8?B?akdVbnE4b0t3VFFibDlYSnJNRmdnNHNNMEJlUGFoQmoyUksweG5lYnZHRFoy?=
 =?utf-8?B?OGhDZ3RjZi8xUnA4VzUzL0hGVlZ4L0VENVZjeWZZekd0QVdkaGk2SFdQekVB?=
 =?utf-8?B?YmE1ZXQwWldnTlo2RGRwTllSUzk5UG10NmdhaDBveGdGWHhZaWkzUDhVejkz?=
 =?utf-8?B?bXRuWW85cFZ4REp1YWorbUdXWmtudkZXK0FFTXBRY1hUZWNwNWZHcnNsZFlG?=
 =?utf-8?B?bnB1MVNKZUhhYVhaN1Jodm51eDVHWERIVlExdzlOcHd2YXViWHhDUnNyc25q?=
 =?utf-8?B?bTQvblp4RzVpK2R2TmRlTWQ2Y3B2azF0cjlXZlVaaEVoYlNZbm5mMXlZWGhE?=
 =?utf-8?B?a2VYeHFXdzlWeXBhVFE4ZFJoODgvaFNMVlhERFZ6STNoMTQzSGlYamNrL2ZK?=
 =?utf-8?B?bzA4dVBtY2swSFNEUmpPcWt2UEh5dTg4a2FYVWVIQmZiT1A2UW55ZUszdUFL?=
 =?utf-8?Q?vr+/qb?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:44:06.7795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abaf24ee-8cfa-4441-f98b-08ddda4df245
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB2074
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

Enable OP-TEE config and RNG by default.
Set OP-TEE load address to end of 1GiB RAM for phycore-imx8mp as the
board is supported in a 1GiB RAM variant.
For the imx8mm boards, only 2GiB versions are supported, so the default
at the end of 2GiB is sufficient.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 5 ++++-
 configs/phycore-imx8mm_defconfig         | 5 ++++-
 configs/phycore-imx8mp_defconfig         | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 7369c0a05ac98315682127f0e96af7d36c4763d2..6dc95d6d3edbc0b4ed25a66d23f1b65435e01697 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -73,9 +73,9 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -97,11 +97,14 @@ CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 4d6bce26f07f7b90e7c3674f4b9ddcac8d775e1d..4cf4d3972567bcf77d9ee7e2fda707070a778c72 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -82,9 +82,9 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -120,6 +120,7 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
@@ -129,5 +130,7 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 6bd8bcf15daa95966aa973d8a493ebc1f05b14e9..c497f0bcd9131abab0b751ec9cc81194405b1f19 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
 CONFIG_TARGET_PHYCORE_IMX8MP=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
@@ -153,6 +154,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_POWER_I2C=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
@@ -162,6 +164,8 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y

-- 
2.43.0

