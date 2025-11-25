Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515B3D0EE00
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5688412C;
	Tue, 25 Nov 2025 18:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sW+hnseR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA8C84120; Tue, 25 Nov 2025 18:23:38 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B3D840ED
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr5xFIue34GCsZ70ZWlxoaVNQkVgvShhS08KkDshsiTuBLOd3QhxL1xz7MeOnEAMiQPbzKG++4EiMZVunS6HD7gKD26F96/GN/h0kmN1nooObULynyogFsnI10EM83aevFDjdGbDsmVRvRrSdEUrPmqE9Xr9J1fKPnwEB8PDK7iSRwSzrLV42yHPKSA8GO8Kc9jNGagnl7CzOeVOxcqjSuw/cX2kMP8UwkYxWBHF/t0bSSunJjdoWjCEkk1t0WJbXg4R9NvUBpsq1ldvBx3WVynwiPWXBY0iLSEowKCyDZ9/H0cap/EvLL0nTvAu5kLm1xfCOfJXTB/bVYfa3kHNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+S7Nc1KZeSpFl7hIZoYaNDHMUYBseExYZdzNYxTPqQ=;
 b=L/gu0sKU8ohQQOlHdoMODW5rp/RSAXNUve0IH8CUrdikRy+sVYfSLUpjC25vkJ671j0VFGxod7h/KOGkEjx4TO7tcPCsDN9RShGCbkZ3s23vhBFbUKQhdkiH5GdszVm/o+8Y9UQEJLb+9r/m5Y0dQMiWXqlaxUo1jHj5nylQox7mA//uaqjB2stytbeA42z2vjtJDGEsk7bWVfuCXz/SboAmHxvCdEZjC5VExJbDxNH7UPu2CwmnmtBrd/IesYNGA/xYI84LhPfn7OdD5M6zPPj4cMkZA9ClD0bxqFN4NzXDT9YNQ4kqEqF8DnFBMq/KDTwsxCAwQCtuGoM3mxZo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+S7Nc1KZeSpFl7hIZoYaNDHMUYBseExYZdzNYxTPqQ=;
 b=sW+hnseRAXHVERei4InxbgmauDDrF9v5MpdXFdd5uScreKvDQYQeCPcae63mNlknkAHpVYQPDjXlwnldClGuacTck+bhArBgjCuWmiQi+rk380dv9hRKAlE11Lyho1oF3gABg48crjWTYw7l+/ym1nl+YNT50Qee8YwA3B3drwakAbM2x/yOL6K9NQL3G/8H+lTd5sGhVwwF/5g+ixhGS0nylXx73fPRTeWEU4QnYt4O1K5aNgdcNmXSoWHby8Hu55LdoQv7E+XL5aMWMKj9aZicXFTkrXebgmZ56vVhLv+zCY8/FJGYxNT6z+JzuYFM+0dbjIWAEV2xVRWXhM9F4A==
Received: from DUZPR01CA0173.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::27) by AS4P195MB2010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:587::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 17:23:32 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::c2) by DUZPR01CA0173.outlook.office365.com
 (2603:10a6:10:4b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 17:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:23:32 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 25 Nov
 2025 18:23:29 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 25 Nov 2025 18:23:13 +0100
Subject: [PATCH 4/6] phytec: set bootdevices and bootmeths in devicetree
 for imx8 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251125-wip-bhahn-imx8_cleanup_env-v1-4-414829c01b4b@phytec.de>
References: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
In-Reply-To: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764091408; l=3066;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=RLCFcaFpHwm1ufbo4YwpftaXFfqvIpqy8+2vcdy6uMg=;
 b=wc0nKytbfCLTQXqYLOo4QUKTaD3QwR5GkKa8k1TeD6MV8xVyRAmx2NImCl5jaC6yijXeSDlHh
 jl7PjWoTWGDCVfEF9GyUZOww7zSkm9CW2a+6LOqIAk++R8f0MK5tIGb
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AS4P195MB2010:EE_
X-MS-Office365-Filtering-Correlation-Id: aa074612-c63d-4fdc-9824-08de2c475b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVB6alJaOCtsZFNRZGZoQmVFWU9Ed09yMWY1RnJMK05zOC85YXA5eEhRdGpY?=
 =?utf-8?B?ZnVKWjVqcytpa1ptTmtQR0Q5SDdQVTMwWU1jSHdRQXVQcWhpMFk3MkpEWjM2?=
 =?utf-8?B?a1BRUFJsRVNCSEp4UXl5SldYSlgycjFvSmhuUjNPcWpPRzMvYkNjZnVBeGdJ?=
 =?utf-8?B?UUNqdDBoSWUySk01OWc2SFVWUE90NHhpUzRxaGw3Um9pSFpwWHFjOHFOZVRH?=
 =?utf-8?B?Vyt1U2lJU0E1eXJYTHBkUWxMbnRna21DQlBoYXAzb3hRcXhNMDlFY1dZcWhK?=
 =?utf-8?B?MXFkY0RVNTFOWTdQb3AzV3l6V1RRcjlHZ0lsOW13WlpwRHhQOTN0QldmZGtr?=
 =?utf-8?B?UGhhdDZ2QlRQZmUxTUNDM080eUpXR29EVnNCS3lZd0REQnhPNlZSZjVya2Fl?=
 =?utf-8?B?MVpLNDY3TWhWTGIxc0NLYzhKZmlVMWJhTUJ3ejFiWjZYSzBHckZlQ0l2Nkxu?=
 =?utf-8?B?V3UrSjkxN1dFNXNFZjgwK3ltOTNMUkZoNm1KLzVtbmF1Um55UzdIRWkvME5z?=
 =?utf-8?B?NGdoeklNd05oSnhlc3pEc1FTUVlRcjI2ZkJqRk1NRi9nU0FsRU9iZUI4eWF3?=
 =?utf-8?B?V0pJNlpCdnBlYWk1Tk95S3JIVkl6U2Znc0c5NStmSjBsN3l6Y3dNblBYNEFR?=
 =?utf-8?B?OVJjZTVIem8zQkNjVzdHdUxOTm9CT3krb2NXZDVVcm9iL3VGc2Z6cXh4TWtM?=
 =?utf-8?B?TkFoTzJNdHM3L0w4K1lBUkN3RVJMd2xhWVBDUjdiZ3BWTlljc3pKSm1sRmNp?=
 =?utf-8?B?aW1ndyttYndWZ2pkZ0IrTzdUNVBCNUhla01udjFLL3UyajBobXVkVGVhYzJF?=
 =?utf-8?B?dStFRFpHVHMzdEFMdEhvOWdFZVhXMkx3REdGMDNFaDlXTm12TkdILy8xTmRw?=
 =?utf-8?B?ZEE1Ui9FUHpYN2w3Yitad2g3L3BQc3NySWdNNmJRL2dCMUt1L3B6Umlnd3ky?=
 =?utf-8?B?TUdHQnFLZGtwQmtVZnltTU1OcWFxbWVIYUFVbmwzVDlCaUNkSDRJNzVhVCtV?=
 =?utf-8?B?dkRSZnZ3aFRyU2lWOGVlWHZhWFZYVDQ5UldiKys0UlFleG5ES1pnVmR1VWtz?=
 =?utf-8?B?SFJ6Y3dicmFyNGJ1dXNQemx2Mk1qSFRjRHdvMXhGY3VzOXcxeWtXYWVrMjlN?=
 =?utf-8?B?OGlZOFVlK0hVQmdySklyU1F1ZUdrbXpudGV4NGZtdTZkOXhvSWJFT1lCYXpM?=
 =?utf-8?B?T1JaQVlvTWVkNzlseS9heFJEclBFQ3BkWFJFajBEVUhtdEtETnA0NEd4Zi8z?=
 =?utf-8?B?b2kyeHQvZTRibHFSNm0ydG53bzNOcHMrd2pCcWlEZmtOZU5MMnZVUjdtby9w?=
 =?utf-8?B?UUMveENIbEZyWnJlbjNFUXFWbXZqVi9mVFlmeEhUUExobVYzMHN0eE0wRCt1?=
 =?utf-8?B?NU5KaDh0VjBjUGRGbE5BNHVLVlFReStjdnNobEVXM1NZN3YwMnJJelp2M1JD?=
 =?utf-8?B?YkVJQWVWbVFzaFBuOS9uU1pXSFdNU3RzTlJ3MnBRaStJOFBSRjlLMitDUzZ4?=
 =?utf-8?B?clhwUE91MEg3eCs3UXpFQ1FhWGM3bHk1WEVhMUNDeG9zbnArd0U5aEFKLyt5?=
 =?utf-8?B?WXR2OEIvNUZtaTRTclAvZy9ENGNUQ3JHTGwwVW1ZQ2Vpb3B2bC96Z2Jab0I5?=
 =?utf-8?B?N09KSTZQSm8wNW9KU2dDdGxkL0orVnc2REVOQm1hd0J2WjgyZ3JENUxCamMv?=
 =?utf-8?B?cTVRUXFTN3hRREVpVmJQRW0xNm94d2VXTVNweVQ2dkhGbnp2MnIyVW9mQmV3?=
 =?utf-8?B?VFVYa0xlajFKSmdTWkRNMGdFd2hIYzNwUzY0YmZvZmhraGcySEpWMFhRT3E4?=
 =?utf-8?B?SXRUMHd6bE1yK3psc1E1NGtZN0p5cHFwWGpmLzlPU2RlUk96eXd0VVhJNk5a?=
 =?utf-8?B?d1gzSTQ4SjBiZVhvdVdJR214MDlrQUE0QVUzSGhkcW9tbUxCNjRnU2lOWGNh?=
 =?utf-8?B?SkllU2Q0aGFsaHRuRlArTzlmSVhFSlpSb3AvMjVWcURkQkJJcG15L2l5ZTJk?=
 =?utf-8?B?TklydnFoUXZUSEdYTWFFZHEzWnJ4bVRUczVRU3F6Ky9pbjVoRGtlV3ovRWtj?=
 =?utf-8?B?dnNicWNhUnJhVlYwSHk3SjhGOUtqYzJxUkkyUnhXYUdOdjY0SDQyMGdwaUlL?=
 =?utf-8?Q?aOG0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:23:32.0189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa074612-c63d-4fdc-9824-08de2c475b65
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB2010
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

Standardboot allows setting bootdevices and bootmeths in devicetree.
This is already implemented for imx8mp-libra board.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi  | 16 ++++++++++++++++
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi     | 16 ++++++++++++++++
 arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 20 ++++++++++++++++++++
 board/phytec/phycore_imx8mp/phycore_imx8mp.env      |  6 ------
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
index 512dbc9ee86a..143ce6a6d77c 100644
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
@@ -12,6 +12,22 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc2", "mmc1", "ethernet";
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
 };
 
 &pinctrl_i2c1 {
diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
index f59f119374f7..26361780c01a 100644
--- a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
@@ -11,6 +11,22 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc2", "mmc1", "ethernet";
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
 };
 
 &pinctrl_uart3 {
diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
index b4efff27a70b..4804a204e922 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
@@ -12,6 +12,26 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc2", "mmc1", "ethernet";
+
+		efi {
+			compatible = "u-boot,distro-efi";
+		};
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index cd95a9d21d7e..85e8fb60a910 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,9 +1,3 @@
-#ifdef CONFIG_BOOTMETH_RAUC
-bootmeths=rauc script efi
-#else
-bootmeths=script efi
-#endif
-boot_targets=mmc2 mmc1 usb ethernet
 bootenv_addr_r=0x49100000
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc0,115200

-- 
2.43.0

