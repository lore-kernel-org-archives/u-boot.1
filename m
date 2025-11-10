Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CE8CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C51883A43;
	Mon, 10 Nov 2025 14:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JEclN7jL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F8883A61; Mon, 10 Nov 2025 14:53:00 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86493839D6
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 14:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVAXqLamW81WjA/nuj0gGp71pYrQPOJJsNYjkX+Z1rtNRXL3g9lmXd2aQp5DjzJQltmdzioSpe29EMNQ8NsV5Jo/vgIP2AkfjH4zAJVEI7nCl5oIgbdGLdp8cn9GwrUITeBn+N5z+UQCWGPOjjIyTu3ps5QChgJTSviR1PgHICtJjUPnZyaJXpOb/KWHhnKrHrFxkNUJJu3FE6JXgXPwP6+OflMxSfLoTCP7UaX+xpJArWGSjQR7YIlpWkDvX8ZBWWH/SD+LEIdPzBPsUwN5uYzhqLKgpSAiZ/IE5rAuHOe2DiuQzswL8Qf2HKAEVPsO+EzG1w4oH7npY6AyIuIBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUTyyu58JZKU+AG5QJGMLtTBdS0Wa5pxdAFF8LdW/K8=;
 b=v09eAA/HzUj5lvwPPCnIJKgeiEPPIrPRu/SU3rj1VT8985E32b0Q5QQzar3rsE2W8XJScouaGRaqf1duWujlDbK233GgLhc4o9jpQH7Ypmj6WTAXqRNYhHjQIW1NhDnwk+xFhXidoLd+Cb6ZMX6K/Ak+dFJaVrHpDkWexYo/xQ30lgHEQ80mUdp4hWPaLrNLYDioiqggqzHnumoABaZqKx3foMTa8iJaVYlzB4i3mANbEiFNq0ZUGko2nF3wKXsLCxe8OeD7/HeYSqe4FuKVqW4ePmtxp25ikRBNr4c+iuuOKKwEdIJ3HmoZqKkpEyz+zkUSx9/twjJt7s3yMZ37gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUTyyu58JZKU+AG5QJGMLtTBdS0Wa5pxdAFF8LdW/K8=;
 b=JEclN7jLpB7QaezXZ2JPAXYKCYDumK+Q1Jr06wlD6XakuzByCYszEwB2cgFhX+goyuma9MI1cdDEuJNbcxnFAigOKxTcBvh6EsN2CUXa+XWjd613ICZaZeDk/lLXxr7fU/Si9Yn9mtcqCoC6aI+1XxuH3Bw0dMml0R/PK8PnJG5+NXU3xkadi8H119buE7ue1yrpNxlFznCgNUvKlCUFRWhreDaOrRA/rj4sNerG13Kct6XbOx5jtqQa3yPqY2ZPBEhzlFg0crUzZSGZqQ3eJ7imF7sebEZjg0K4cSK8+nb7IYscyrOM7NlBlaw35DHzlrFsGuoxBSa261nVddWyGA==
Received: from AS4P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::10)
 by GVXP195MB1783.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 13:52:49 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5da:cafe::bc) by AS4P192CA0015.outlook.office365.com
 (2603:10a6:20b:5da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 13:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Mon, 10 Nov 2025 13:52:49 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 10 Nov
 2025 14:52:46 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <primoz.fiser@norik.com>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 2/2] board: phytec: phytec_som_detection: Add support for
 phyFLEX
Date: Mon, 10 Nov 2025 05:52:28 -0800
Message-ID: <20251110135228.1357377-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251110135228.1357377-1-d.schultz@phytec.de>
References: <20251110135228.1357377-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|GVXP195MB1783:EE_
X-MS-Office365-Filtering-Correlation-Id: d6df77e0-6759-4013-89e2-08de20606fb2
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ijoPGzSRbPtZm8HH6trA5zH9RpP5+WYkgGlgs8k25mdJgDBHg4q860lqsfiQ?=
 =?us-ascii?Q?sNESxfDgO8eXS+wm6N+EzG0hMA98x0sVr1IlmFn9cLpfM5gNVjkW5WzZO0iO?=
 =?us-ascii?Q?Umlem34dsrCDk4PQ+1JdLJzFsiBdTHjLt1EE+ZmCyrOBMbDuuRgNLMNOjh+X?=
 =?us-ascii?Q?k7h/WDQim7YcZn58U5g1LJgU9nFhp3kLLwvaXezU+KYkNx5bANo59yOASzmf?=
 =?us-ascii?Q?z3rG2zJ7skRZXaq8rNj59aaj1OnyIhwJfPds6b2eTqKH5xvPWbJHa3D/mEsb?=
 =?us-ascii?Q?WZQFpcwRKFKq4XrqQSBGoIxLMZcBnBLT5CL0fWQJdL2KbmUFvT3mvksVKcmZ?=
 =?us-ascii?Q?lDapYwnguRU1I42jH1OgTC9Ex+sid9mp8sxYQj07fXSG3j7Q2TwnfOBJ4xS5?=
 =?us-ascii?Q?gdEoK1RJnpOyQzK6GMhX2roMDGLfbFsOIHDCL9tHeMZkx6WXAlIJADfxVMPV?=
 =?us-ascii?Q?0yWxfQ8LEIJamlxfpH06W0s60zrIMoaplAp+5KerZVyGlcMOx4Cahz3DAcOV?=
 =?us-ascii?Q?YX92DaBar35EMtbKVWdvcuNVZ8jJj+pucTvNSFtAXyC3+h4ukYok/J60bZsJ?=
 =?us-ascii?Q?T6kZPMNX3OgDDKi1fxVwqXPCj8590Z8FJmhT3da/NbPoK+1xaTXFrZue7/dG?=
 =?us-ascii?Q?3GZNuORER2RQQMbJjBt3nfGDzzVeh48aXGGHA+yaHS7ijLKvQCgnQcx5K3J/?=
 =?us-ascii?Q?plcR5DTuQ0NxNk/mOKoeVaXAhd6NqhwaP+jo1g29ewX9kGgMQ6GLyn85vyZ4?=
 =?us-ascii?Q?Gh0qpJjC2yLAbUnxds6GTOmcOCfS0A9YmWhkYKqO8Fab1RtepgX49huEwjhP?=
 =?us-ascii?Q?5H5q1r8vlP08R1IYxbYRib6RtcJZFHWZ8B9O7Qn6R/y88y5CGFhA3g+hBece?=
 =?us-ascii?Q?HatIRknkrtzDSZQQGvo54TWRHmMk6E54UYTB5u1DKfPnL9Ip0wjGESz1DwxM?=
 =?us-ascii?Q?HQKpblFO219HNDnkXB9kFZQtGMV/2kMY16BB/IcpUpZDvXuF1Chy3FV5Fmwu?=
 =?us-ascii?Q?P5UsuFNDnvyAqeZA574h8BHwBkDjNqQ6wgApyCI2G0xM3rIoV3B2tx8r6OtO?=
 =?us-ascii?Q?ZBI0XuL4MFG8lMjzx7y98lbaYupDKnmy0Bb6IoyCZWWIqpIrVpPL1RcvwVVx?=
 =?us-ascii?Q?NaAFSZu50+hDT0rmni5A1l36/aqPidyw8Nfn9ERHRNiaWlOsQWezNuzqTtC6?=
 =?us-ascii?Q?w72XO6exKsFLuuW322zLaHWA7vovUgf5sDxL8cDs4cm3isYf7amCOTu9ZKqI?=
 =?us-ascii?Q?AbAizQIQTV5GTIpPImOFq0HBeoyzOJDsvl5bYldKGRcgw9MZPOXV0pbRWksu?=
 =?us-ascii?Q?wlE8trtqjFQYc4uRGOYn+JfU7GHmFwJEMkPaI0MYg/ITRt3ww8H+vpTKHWUl?=
 =?us-ascii?Q?r8mpn0PB5T8hxxC6mDSfLysm+6Lr+EGB8KZfW1kKHr+S2a66TzjQOCXQ/zor?=
 =?us-ascii?Q?MjPK1UZfZBXYtFBOcmMkI+dsjcJE1TkEWZBI3fub9ivT6uK01SboKAqt/F5r?=
 =?us-ascii?Q?NR6rS+qgVI//+AqJBJQ/wtvOL5rFirqs5Q7PJJhuiufQzn5qNIc2Twd90U8L?=
 =?us-ascii?Q?dltP+nMIlxZW33WvT1s=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 13:52:49.5659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6df77e0-6759-4013-89e2-08de20606fb2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1783
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

phyFLEX are SoMs based on the FPSC standard.

Add addition "SOM types" for the phyFLEX modules base on the
FPSC Gamma specifiction. These modules come in four differnt
variants; prototypes (PT), standard product (SP), KSP (KP) and
KSM (KM).

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 38 ++++++++++++++++++++--
 board/phytec/common/phytec_som_detection.h |  8 +++--
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index ff1711c24b4..0e30ed9b1bb 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -308,14 +308,24 @@ static int phytec_get_product_name(struct phytec_eeprom_data *data,
 	case 7:
 		som_type = 1;
 		break;
+	case 8:
+	case 9:
+	case 10:
+	case 11:
+		som_type = SOM_TYPE_PFL_G;
+		break;
 	default:
 		pr_err("%s: Invalid SOM type: %i\n", __func__, api2->som_type);
 		return -EINVAL;
 	};
 
-	len = snprintf(product, PHYTEC_PRODUCT_NAME_MAX_LEN + 1, "%s-%03u",
+	const char *fmt = (som_type == SOM_TYPE_PFL_G) ? "%s-%02u" : "%s-%03u";
+
+	len = snprintf(product, PHYTEC_PRODUCT_NAME_MAX_LEN + 1, fmt,
 		       phytec_som_type_str[som_type], api2->som_no);
-	if (len != PHYTEC_PRODUCT_NAME_STD_LEN)
+	if (som_type != SOM_TYPE_PFL_G && len != PHYTEC_PRODUCT_NAME_PCX_LEN)
+		return -EINVAL;
+	if (som_type == SOM_TYPE_PFL_G && len != PHYTEC_PRODUCT_NAME_PFL_LEN)
 		return -EINVAL;
 	return 0;
 }
@@ -327,6 +337,7 @@ static int phytec_get_part_number(struct phytec_eeprom_data *data,
 	struct phytec_api2_data *api2;
 	unsigned int ksp_type;
 	int res, len;
+	char *variant = "SP";
 
 	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return -EINVAL;
@@ -341,7 +352,7 @@ static int phytec_get_part_number(struct phytec_eeprom_data *data,
 		len = snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1,
 			       "%s-%s.%s", product_name, api2->opt,
 			       api2->bom_rev);
-		if (len < PHYTEC_PART_NUMBER_STD_LEN)
+		if (len < PHYTEC_PART_NUMBER_PCX_LEN)
 			return -EINVAL;
 		return 0;
 	}
@@ -353,6 +364,27 @@ static int phytec_get_part_number(struct phytec_eeprom_data *data,
 		return 0;
 	}
 
+	if (api2->som_type >= 8 && api2->som_type <= 11) {
+		switch (api2->som_type) {
+		case 8:
+			variant = "PT";
+			break;
+		case 10:
+			variant = "KP";
+			break;
+		case 11:
+			variant = "KM";
+			break;
+		}
+
+		len = snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1,
+			       "%s-%s%03u.%s", product_name, variant,
+			       api2->ksp_no, api2->bom_rev);
+		if (len != PHYTEC_PART_NUMBER_PFL_LEN)
+			return -EINVAL;
+		return 0;
+	}
+
 	switch (api2->som_type) {
 	case 4:
 		ksp_type = 3;
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 187424a2b44..fdfd3c969ff 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -18,10 +18,12 @@
 #define PHYTEC_GET_OPTION(option) \
 	(((option) > '9') ? (option) - 'A' + 10 : (option) - '0')
 
-#define PHYTEC_PRODUCT_NAME_STD_LEN	7	// PCx-000
+#define PHYTEC_PRODUCT_NAME_PCX_LEN	7	// PCx-000
+#define PHYTEC_PRODUCT_NAME_PFL_LEN	8	// PFL-x-00
 #define PHYTEC_PRODUCT_NAME_KSP_LEN	8	// KSP-0000
 #define PHYTEC_PRODUCT_NAME_MAX_LEN	PHYTEC_PRODUCT_NAME_KSP_LEN
-#define PHYTEC_PART_NUMBER_STD_LEN	11	// PCx-000-\w{1,17}.Ax
+#define PHYTEC_PART_NUMBER_PCX_LEN	11	// PCx-000-\w{1,17}.Ax
+#define PHYTEC_PART_NUMBER_PFL_LEN	17	// PFL-x-00-xx000.Ax
 #define PHYTEC_PART_NUMBER_KSP_LEN	11	// KSP-0000.Ax
 #define PHYTEC_PART_NUMBER_STD_KSP_LEN	16	// PCx-000-KSx00.Ax
 #define PHYTEC_PART_NUMBER_MAX_LEN	PHYTEC_PRODUCT_NAME_MAX_LEN + 21
@@ -38,6 +40,7 @@ enum phytec_som_type_str {
 	SOM_TYPE_PCL,
 	SOM_TYPE_KSM,
 	SOM_TYPE_KSP,
+	SOM_TYPE_PFL_G,
 };
 
 static const char * const phytec_som_type_str[] = {
@@ -45,6 +48,7 @@ static const char * const phytec_som_type_str[] = {
 	"PCL",
 	"KSM",
 	"KSP",
+	"PFL-G",
 };
 
 struct phytec_api0_data {
-- 
2.25.1

