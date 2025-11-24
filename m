Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3AECFD31C
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 08:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A84183D00;
	Mon, 24 Nov 2025 09:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HL/GR1jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC9383D0C; Mon, 24 Nov 2025 09:25:29 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D285B83CDC
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 09:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRTWxtL1AtOLY0XHEg5Zta/JclREjjOoBsJX6ReEMMGHy3ZiucQjvA9cFboBEH7Z5nZn17Fx3aGahIisX7rLTUuqIpFapBFr5EfqvbWsmoDxabxzeWQdQJwTg+PcCSlOtFgR/VXDSfxIx8xa9EtA5IZI773MKbpgJNzEoyu5Y6JPs6F8Q0wl4TG+tzoPYpKn1cv/BbqpI5MoFTHGEkDA3F7MVHDMDS4V/5CRsPpk9Nqc4EVn4dKccjMCl69drsKSqpOVQ14w6C/c80ofe5+C6dK+x3Oqdaq7qqSF/KNodq/ewsxUolR5Wpg8O6j11Noe0WckgBd4AVedCJ0azBH1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ttl/OsayTyiJ/aE1kL9SpbiLj3Vw8kp5ny+JhlyKpug=;
 b=Z03sKDTkrjE6mh91uJ9cEIX8YQAph2VzS2JYvyDt9qr92xV4/TohzqI2+8FGBvSdy+OlkRntmgJ1KwPZFv7+fg5mHHxv5UGe5s6CsthjTg29IpywrJ2g7+yQFn3WDWAICXIpV2CuzvieLHu7ZGOuQJHhV9qSKfu1U2ih52Uw5qXADjffbe6aFiSDDnHwkFctleKGluF4znt6du1Fg2fLM4VGWOdDR59DaeZWH+Gn9hbYe66A/jMn/swJQCRFGnsKORb6gsTy0LzDnp2VTyMjn2vg9W5pS9WYI6MPpBcQ1CH+zDnsSYcguDkri3S47gOr4FwbwMksWU7srIvt5iz8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ttl/OsayTyiJ/aE1kL9SpbiLj3Vw8kp5ny+JhlyKpug=;
 b=HL/GR1joGegzatZv47s+JouitJc0SkjIN+4QRXF/Vnw1E1Ex2vCeU3ahwHf7I1p6kOkYhLp3luuu0d9pYgxAc33RR1/jnkl6MGxkaAR40m0/By9JbsME96wP3oaM+/8pu82b5dN8On64Mxt1+SWIZtpYHN2D3zJ3TzCUoEMqUQ3PUcKzJY4WIw7bnBe6HvW1vYE8uI5Pw7QrjMapUeSVLXdHL7IrKpOQvbBmkFpUv+gJWIFgP1njmrfFC6MlojV5K3V8GtKDl5GzHDW9rRjAwa09m9Wh2JK8No/czjoALN8VJjBaSVeWYar8olBzjkXcO7WFhKusI0toMg5xyb83kA==
Received: from DUZPR01CA0272.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::12) by VI1P195MB0765.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:159::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:25:24 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::d8) by DUZPR01CA0272.outlook.office365.com
 (2603:10a6:10:4b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 08:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 08:25:23 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 24 Nov
 2025 09:25:21 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <primoz.fiser@norik.com>, Daniel Schultz
 <d.schultz@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Dominik Haller
 <d.haller@phytec.de>
Subject: [PATCH v2 2/2] board: phytec: phytec_som_detection: Add support for
 phyFLEX
Date: Mon, 24 Nov 2025 00:25:06 -0800
Message-ID: <20251124082506.3376876-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251124082506.3376876-1-d.schultz@phytec.de>
References: <20251124082506.3376876-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|VI1P195MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d46c85f-1bdb-42e4-8075-08de2b3303d2
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dfekPWBgsjqcxwszwb8vpDgsHMCZSnI8vHiJWNWYhryr1QH1EE6hMRQoeSGT?=
 =?us-ascii?Q?ckwUr9o+l+8ULe6wZwIyf/nXRXefOukUitufRu8Z7XVbtPVcQnXo70IJChQx?=
 =?us-ascii?Q?uprsf6YT7rij+3uhjHcDR5FMQ+8jXjV3L+8hvekOpxfCHN7SQO0pekg7sqh/?=
 =?us-ascii?Q?h3pPMCWydqKKW6vooS6Avx23uhg6EDgkjJkB645NMAGa85Ex//ygKgo2ljMA?=
 =?us-ascii?Q?hq7gCijS2AgkvrSJnOIrkVasdisB2QdlpSEK5OqGzG+n0Ici3uza8qJGe7Ch?=
 =?us-ascii?Q?hi8dZlwN7iyXklZNxVPXfHV/AsEV4jET6L/fVJHNXLdBftKZ9ACY89miE7+9?=
 =?us-ascii?Q?vSAS6PyRGpUU8aK8gaxuYUK8vR+UWODXnyq68PIwRO9DALk1pSmZxyP7vmoJ?=
 =?us-ascii?Q?6Jpv1jq3vVjTG/7uJtpLiB7UCZrltJ25XO3/fRCwXFf7QwdXxBEsx8QRA0k4?=
 =?us-ascii?Q?sPhRRfk4FlBe7zC98kTAFIbERbbytJP/WDiordYzFNUajLRdi+O2Hf6e7kxM?=
 =?us-ascii?Q?klfzoSJ04EYzTTWM/f668w57eoaLaYIaj7u/8odQaXn0Vjaz1UWiyt99Khrb?=
 =?us-ascii?Q?5d3T9492dVJrmJ/S6ondwAgODMW2JGzL9s1tRUnbRL5M2EFvYPFdLjjx3d4w?=
 =?us-ascii?Q?NgPwIDkXf8nmrJqDuwm+M2V9upuQ1ZK5mElFKwmiXrXvqxFH3dqE6j0wqgs1?=
 =?us-ascii?Q?vV37c3H03y6X7NKd74/TIK7ISbZl+eNtFG0zqQkRS9ZRuMFtSr4V0/0+XQ7a?=
 =?us-ascii?Q?woOFvoiucw54DkTcTSa5ynnyAhJSbeCh4BgRsj8iGjMbjHA4kEQWjMMncvOA?=
 =?us-ascii?Q?Ui8ccpHoldROl3dpLZbTLc3IKG7yRIWOVhFZVCCc9NgOFY3N0c47pfLGETbK?=
 =?us-ascii?Q?rcRjymts9ov2tSJUjJmX9qQVQg6IBsGCR0eeaLHcB3MqJFqAQygE9sx0oymf?=
 =?us-ascii?Q?o7UVLQjmLjV3fra7x7ie6auA0oJuMb/w+Il1IIsu3ca2KcYYZKJzYm4VKs+X?=
 =?us-ascii?Q?s9JU739HD2K9liU86NsJ5HYM7DaZ6QlFYoLazgOCs4l22eHrJppsOZT/pBcH?=
 =?us-ascii?Q?CqiwrWaEZWV8OvgCaoueONTRBW2V7P9bNeK+u5l9mDctWclqEswbO04btOBu?=
 =?us-ascii?Q?z2TS8wtp6il5h/4ZVU+RmW0LymDBHDCpiYVGM1whnvmv87JI3nIyN0S1NvEr?=
 =?us-ascii?Q?u9H+fFZLsQdz57JTP4Z1cqw4DCrtrJ9ZyHXBPB4ysCOga/vp03GSPbZuexqP?=
 =?us-ascii?Q?T5MG3hYkOGoOU3j1/SNw7cBEFl79UnV7Tphj1Kj6Y3Ox+T2CjWztWEA87CiE?=
 =?us-ascii?Q?hXrPF+HFucIllMjHoMKdYAZnVPgz1fGIG6OAXwqMSvW7SoMkEPr3pOCk255g?=
 =?us-ascii?Q?T+BgQptuzKRn6OIOm50kC1ctwXUEabpRRKX4wDm1OPkmIJ+RRhRgtrYcj653?=
 =?us-ascii?Q?mKWsIXdJGRn1qfsICkJxYjbKlw2lYtqQ0o6nKEK8Q/YiPQ19KqWfBm9VgMJt?=
 =?us-ascii?Q?6SgO7zM1oS9fGeOJZHOVWgSIScLrNzC3Qk0VRdogzWMoOcr45t52qKEd9TTO?=
 =?us-ascii?Q?jyitaKTYOQ4SWqNM3UU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 08:25:23.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d46c85f-1bdb-42e4-8075-08de2b3303d2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0765
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

Add additional "SOM types" for the phyFLEX modules base on the
FPSC Gamma specification. These modules come in four different
variants; prototypes (PT), standard product (SP), KSP (KP) and
KSM (KM).

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Tested-by: Dominik Haller <d.haller@phytec.de>
---
Changes in v2:
  Fixed three spelling errors.

  "addition" -> "additional"
  "specifiction" -> "specification"
  "differnt" -> "different"

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

