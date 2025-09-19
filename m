Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB9DCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 06:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6838832AD;
	Fri, 19 Sep 2025 08:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KhQkLS5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEB2832AD; Fri, 19 Sep 2025 08:40:02 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0848781E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCQ1gez1NbG9xVQgzAAA7FLfCIhngwjVD7GgRUNNvcm4VrGWJAh/AaNHn9cHY58hu8lekFAbaOtuub4gvYrLEJXwMFpP3vJqRu+mA3JmRWUfFCmEYtJ2BiWwIIkFFEX4N6Gwsepr4wBg8wDpo4dCpkVYsLVbb8XgptuSukjdW1j5CVO1YKwtEEIQqYTmbCG8DbKDxw8GTfW/TKTskdJc3vqoHXTBFn0fo74On7S45DlyYNVTybtxkPRsfHAQiZQig7RHSgucK1zTHe9J57ZZqqLjMigW3AFuiliAfrJ3LMuVJWXyEtSCB4HItIJyc/iB6J7mEtqVMzMJVI8OjLRe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx9CjxJUaQ+DIrCxedcU4acbjAsuv6F131HSUwoyKtM=;
 b=HPTv+ywOoRzGTxV6JF0ENcSoZ4HxadmNQLHT3Lmxm4esYe352DyTDwoz/xIlSV41MiB4ujOXJkMX6kaLtn/m6UpaU9umWiOTghSa8Kfw7b5v/VXo0svorh3xLGBPTHRDVxGXwyygF/QaendIgnWA41CjdUcHJJxxaTQXYJq8Hen91cyq3E0QigksGKLOUOUnDusVnC0GODOs7pMi5M+L0ht6Tytdlk+U/fHIiHtIOf41AlP8o6x7eN2Zi+b4vyFp1e8QCjcQOgRY+BjcDCWm18a/w6wnSIRCnD/gONcOV2CeF1Rr2B86J0wvIZeW4P3l/O2Lf4XAb8WUEHcQvkPdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx9CjxJUaQ+DIrCxedcU4acbjAsuv6F131HSUwoyKtM=;
 b=KhQkLS5EoFulyMM4dhsorpLlXQ2guUqXoTjEYGcWx9vjm+3ur0z6YSV/r7bszo8SPJPHEo4KnftCby+5/Bz71CDvdeMkmid7+ih06/lT2Y3vGjE7T6KOzkRNPweSHrz5fXOhxWk91KXk7bLYQuT+ucCl9rzgYbKVRPzQgMTPbAAzpr8HRm/W+ZEq/SFOvnLFBwHiySi5VZhakY1vHa4oFKJ5xgFLTHtx23/+mXX4D+lZa6Pvr2R1c+lEF+jPrgfkdG9dmY/OptUU3KyGHEn1ZI0BI2sj5rUef2yB9REcPD9cZyD0pKp61gqqsH6i8EVQWKjRp6Vsco8WWnl0q8KjkQ==
Received: from AM6PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:20b:92::34)
 by DU0P195MB2774.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:5a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 06:39:58 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:92:cafe::d2) by AM6PR04CA0021.outlook.office365.com
 (2603:10a6:20b:92::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 06:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9160.0 via Frontend Transport; Fri, 19 Sep 2025 06:39:58 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 19 Sep
 2025 08:39:57 +0200
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 19 Sep
 2025 08:39:56 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <bb@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/2] board: phytec: common: Fix missing newline in error
 message
Date: Fri, 19 Sep 2025 08:39:48 +0200
Message-ID: <20250919063948.3093358-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250919063948.3093358-1-w.egorov@phytec.de>
References: <20250919063948.3093358-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|DU0P195MB2774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9a2a70-25ab-4d1f-2f2a-08ddf7475a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?acvOxe59WBwnPPQSgfYurK/kyE9Q0Q+I7e2Q2uNDCPFTCHyvC/HJO04RwHeq?=
 =?us-ascii?Q?P7Ycw5qYceXqLuw+NiJKrYQ7keaCFWbKt3OLVJXhPaxX6gI27rhu+oAeWeww?=
 =?us-ascii?Q?7d3TlR7bZe/rYx2WSCiAaTZW7FymA6aMOXTHu1cxHAfEHLfi7klqmwRf2z3t?=
 =?us-ascii?Q?RHVKOM05ZF6qoR3tO2LZ3fnUKPQ8D0huuK+vwy3ljfFXwIVpZADegCFJ+Ppm?=
 =?us-ascii?Q?/vaz/NwnvR67nn4m8zrMhA+FBCWM/9wTUB7SQcDDpJgV4WMnNVBF0mysuZQY?=
 =?us-ascii?Q?uVhzdXZZjLg1E7NG2qqsAuhwxJSpkgjjfh2uSc6lkyeqngkjXrCLwYvp6+zM?=
 =?us-ascii?Q?QZsavXHZohjjUEEJUP9mrMRbOI2oXiQry2OpufJaVPPOpt1YBZFzpiKH47jQ?=
 =?us-ascii?Q?PjLj5W48pXkl1lw/XtCeixUY52s1rG1MEnZOwZxEgchpsWFK3ihiqZG7XSKr?=
 =?us-ascii?Q?T6m9R7IobNw1jGpbqvq2KmADzXHvEkSaAnkqE1z8/rAExFZua49K96dMBn+C?=
 =?us-ascii?Q?jqPq+xsNCNejHspxWNCuMmZLYZBnHOZPp3z1He5Q1F73FrLeFfWJbTCqxJPn?=
 =?us-ascii?Q?3g51ZiZHI2fl58t5xJMNLA6h/QlsfBW1iVvLoKbhWMWyVNNXmTQpG/gQHqOe?=
 =?us-ascii?Q?QWEt69v7mZmvdMNrfz/jW/fXbBZ9LSEzg83z9p6BXU7D4Bw4wDmOxSef1Sw8?=
 =?us-ascii?Q?11QvbtLYlbzkvHX4H3WMotz5J6QvngWzHeE6xglLwKNGr0cAZkciCxir+QOf?=
 =?us-ascii?Q?Xd6aSDXHX1LmPkq5wVFMtROTfDDFl+HB6odiKYdqXw8CTP1YrEmLC1s5jtUE?=
 =?us-ascii?Q?tQlL1FUXLBRFPdn/5HpW1H+OgPIOEbZTZGjuzGKTKCw3Lpr4JtcMq9mpImL5?=
 =?us-ascii?Q?oXxoWL+2KXmnrU66EtMUQTZWRb88RG2uWffMvvcCXhT7g0wkCT2ooWm/pG3C?=
 =?us-ascii?Q?fbXn9vpF0z9eRBnXVAFj2GWvkaNl44DgE+5QQ0yiMXWa6i/2aTSuqDJLLH2s?=
 =?us-ascii?Q?0g68rXFOcWQdcSpWfVtQUwqtf282kccVtKhQhEHd6LtwiYPQKuLybR+oCDQu?=
 =?us-ascii?Q?DhceltU0TYCMFQzoAP6zMcM17Eyd37/3lsX4CE9cgzXScpVWzzFZ9X1qJW+5?=
 =?us-ascii?Q?ez04rIu0e4puI2cStUk7Qo/E7q2m9OApEfTwgsAKbWkKF220bwHLcwEtT5if?=
 =?us-ascii?Q?hg1wWDSBRiSathY3bbDhcCpjjOafCETiB6qWph+hBkYa3s06eFy84HgPd1RA?=
 =?us-ascii?Q?cXsMCtqGayNM7+rTG+iHknVeUYuvMt/PDB/f5/9uj5JjSdg4RRznFGYWGp79?=
 =?us-ascii?Q?HXlQ3t20LveGiTJ24EC/JpxIc/kQGFPPgbI0GjZrSMloCCGi4QFpmJUyy62f?=
 =?us-ascii?Q?k9mw+UEthvoDiGMq0I9Sq7dt9ITNaff75hXEmSFKONcxFS3h8VcBEgvpjB4S?=
 =?us-ascii?Q?qqOe44NK+cum5vFhq3DBOuES1r80nP3Kl49PL08s0pWuR42mfU5Xy31jFV7u?=
 =?us-ascii?Q?m8Fv16Yr248TZ8iiMPU/OUggSXq4PdV30p/H?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:39:58.4584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9a2a70-25ab-4d1f-2f2a-08ddf7475a3b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB2774
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

The error message in phytec_get_product_name() was missing a newline,
causing log output to be concatenated with subsequent messages. Add
the newline to improve readability.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 4d7c9b9f80f..136f4486eb0 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -309,7 +309,7 @@ static int phytec_get_product_name(struct phytec_eeprom_data *data,
 		som_type = 1;
 		break;
 	default:
-		pr_err("%s: Invalid SOM type: %i", __func__, api2->som_type);
+		pr_err("%s: Invalid SOM type: %i\n", __func__, api2->som_type);
 		return -EINVAL;
 	};
 
-- 
2.48.1

