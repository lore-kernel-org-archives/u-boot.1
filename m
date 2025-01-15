Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBBFC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385E280040;
	Wed, 15 Jan 2025 11:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MNNqARCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CFF806DD; Wed, 15 Jan 2025 11:35:30 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C245B80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfCsFJ2Mrsen6VWwdS7QkBjcBZLuzHxWv2oJpv8RZfck40oEsG83qaLaysQfjAPr/VjhqinQwirEMIzhdw6newtLzfJMmty6nr4ilnhYnATSCqaYGqMT/e7UxlG+fXAbUV1S9WHZsS7Y2es7qD5OHt+ebHdf/63haY4aQdtks4xWEoc0fYRTHiuAUIYgiR11RAa8HyP5/ZY0XtsOYAowMqxmQR+nVIod0aJkFSPdkYwXw/pPG5nUE07NfQV4ZFQBgnXfBQG6gRem2yZbmn/+DQlfo0JqX+PMnFlADHOcK+yEwTTb0I+msZOmvTVanpgttuQkf/psJ3Ihu7gp8Xa0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7dFsk1NX9kv5i048lF8nwTWgFtNcesLdAdmnGiKHIs=;
 b=qmo+cVwc0+xNq5H2gf6ssE6uCNDGOS+iaPNmKTX1/YXe79OT2FNCXvroDfLr9FM+3w6Vg0E+aduqOP7JIb6ctSgEar3AUsMbS88w8hN9Gp7pSNHXANmc5Z1seL6qYp8TGF3lowYKbWU/4ojYKwxn18uQBAp3v+jLQVwPR/vtvLOnl1HrcjpTDL+U89Zvbi/vpKv2Hlg1xfBhQy3GS2oRj30Lv6ve92w+wIWIaCXgEV3hkES69hXzYkxBmqV6MxMSBHyTf/Ft3d+8yrv3nStDBwVSLXXi1p/BDD8hLmAl6ZwQcDSEq12vDV+iMErdm7Bj0/D5PcjfrblhRI8XqhM1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7dFsk1NX9kv5i048lF8nwTWgFtNcesLdAdmnGiKHIs=;
 b=MNNqARCl/hUTLzL9011e9gKN/wEoBgMjGBkgon3YG66WQ8cteszlMC8A/5FYHYtpC8OvR0+JVbsjmUqy3PHSEfv5y0BlkMEz2uiGFaEok1ENpHLM+GuukhqAYOF39Nhy7UZz5jTxgXw+umBXD5AVip4VmOD51mxFzAcMd6MdjP+n2J/4oZypxEW9YYvuQh29L+QW34P8J/0uGGPdm8h8Nu6r/UDYWOX2d+4zv6Lne9yKZqLI/j86vXMlnzIQVc7vJ/FpktVA4UNfBC6MKPQA9tyZB+ba4Q1Yn5Swe+jfqstcvFTn37cAN5UQQjdQTUnoZ5aBuSLUc8C0f7v7k3iBMQ==
Received: from DUZPR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::8) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 10:35:25 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::e0) by DUZPR01CA0123.outlook.office365.com
 (2603:10a6:10:4bc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 10:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 10:35:25 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 11:35:24 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 11:35:23 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH v2 1/2] board: phytec: common: Add product information to FTD
Date: Wed, 15 Jan 2025 02:35:01 -0800
Message-ID: <20250115103502.844304-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|DB9P195MB1444:EE_
X-MS-Office365-Filtering-Correlation-Id: c8010bba-453b-4443-1290-08dd35505281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HA3+B52ObOOXX5WuRbmUOuS3EeSucfDIhQI1wSQHPzTobqrr6QaE8Mb0JlW5?=
 =?us-ascii?Q?fptzDHByb3sR9QxooisMnlrgTUTn+ekYem7HRVM+p/nDd4agkVKbSzc8Xji7?=
 =?us-ascii?Q?9DRQ5xZr1NgpFjjQY/ZwIBaY2mTheDiAZsl+4QFNUtlLJ1bLXslIveiDefpf?=
 =?us-ascii?Q?Sxtn76PZVENiNwPWHxkbvQRxYi4d9cmgqGzboh1WUuRyru8NruKeZO0OF6yk?=
 =?us-ascii?Q?ULb8eBh+hFNhDlkjxpl5LNFRKVk6mWvMEHB5K7y45frWndj0NgKVNG5QIlIf?=
 =?us-ascii?Q?0vhBGGtoLxxEvRv3uYV+8vOSCChhofpnt9uwaBU2+IgqfQqHPCpu5ZmilsSX?=
 =?us-ascii?Q?JbFsp+wEewFfYTPXEWgTML/1iOMRVlhC2Q+AJTQewQ+tz+fMXQvgge+ifyrd?=
 =?us-ascii?Q?KcboEvBmUA5NSk+buTovle7g49PPUHmVDL89B5CVjS/vyUR8Fey0kwHySRaY?=
 =?us-ascii?Q?oDVTv4lB3b3j9x1j/HxGIoDpcM4ytssbvzdc9RI8/zY6Woxhiv2fUT/2YUYk?=
 =?us-ascii?Q?eBt1oNlbVXvjWWZ9tqU7zu0f9Gzaav/9ScNfWOm6bIV0WcLSZ3O61I6WvOq0?=
 =?us-ascii?Q?Tr+i1NdadGR9bRYq504590A6lCfnplmvipMIr/pf+GahF1Eae7VQg0oDguFg?=
 =?us-ascii?Q?RThaCSZoOg0f+aZftCn2kIk9rqg+6aS06aRJfRxHDW8nD/g+4OoSFdIKD4Qd?=
 =?us-ascii?Q?M+J9uMzuMQLxMLnrprmDP87OSIvIAk6SMWK3tFcaFmJLZ33FZZ49ErrBLH91?=
 =?us-ascii?Q?h8+rutYNbjiHhjjxI4qayr050N0ll1vDqU6U9mb/PoFqsj2B9Kc34ykNRWwk?=
 =?us-ascii?Q?fQAyN2HjCyYXcptHuU2lrPCrRtJeDG0cGD7PzZbWn16R5wPbApNP24gz9pMA?=
 =?us-ascii?Q?4vbi+eI9Dcjd2dd3g5CphBMcGUIpVV1DnfChhkVlJ4gV853wrFtrfxgXKz7H?=
 =?us-ascii?Q?sxACfcNgOcE6IQtXSSnLx5PzUJ48O+mDJrMUFZKOQGWJvnLVDh4pSDb/GHIz?=
 =?us-ascii?Q?tmHUbROKPWrEF2bMlNAJQ1kMMnNzotTBn1nOhPd4fj9sO4hW5wNBY2gmYL8c?=
 =?us-ascii?Q?pn+ZEZXbXzE+jmzCG3u3yTGo2GBiZXKvlEJYYkBwCMCL3zWY6hcn1m5Dn70l?=
 =?us-ascii?Q?D8+UzUiqI6cZyloQbURFuvn3b57bbhJzffNsqWIFe6MQBQOZE5ErTW4j1pIC?=
 =?us-ascii?Q?aCCcIa6p5FXw7iFh3QPoT9XymULwTyy5QRkZ5RIjOx0KOu15oN7vCJYE0FIa?=
 =?us-ascii?Q?PMck/G6GsqaPcuVwMpVhQhOujPU7hcaOLX4q7FT49nkkLFsHJN+K4SzU69Ah?=
 =?us-ascii?Q?jrvHiEvJlmbTnKoUqoKUrhJyhG5QHSzt+Bns5VlAD8M0PQkVw30Wn+QbGVju?=
 =?us-ascii?Q?4NT2+Q3RuxJxWGEc8K6oOV/CpCVqXNH0+rp7m9mDtXeMjeaL4WaL7y4Nqk8j?=
 =?us-ascii?Q?MSniMgCDoz+/a1VWZ+NZHagq0Cry2PNryQkjQVACpc2DcY5WvakJQ3kNeROn?=
 =?us-ascii?Q?izJLT7SK/vJAyM0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:35:25.3543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8010bba-453b-4443-1290-08dd35505281
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1444
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

ft_board_setup inside the board code allows to alter
device-tree during the boot process.

Introduce a new function for the PHYTEC SOM detection
to read the product name and part number from the EEPROM
content and include both into the device-tree as
* phytec,som-part-number
* phytec,som-product-name

This function can be called from the board code when those
values should be exposed to Linux.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---

Changes in v2:
  * Removed 'struct bd_info' as argument in function phytec_ft_board_fixup

 board/phytec/common/phytec_som_detection.c | 202 ++++++++++++++++-----
 board/phytec/common/phytec_som_detection.h |   7 +
 2 files changed, 166 insertions(+), 43 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 166c3eae565..a4a1d20e0ec 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -271,11 +271,126 @@ err:
 	return ret;
 }
 
+static int phytec_get_product_name(struct phytec_eeprom_data *data,
+				   char *product)
+{
+	struct phytec_api2_data *api2;
+	unsigned int ksp_no, som_type;
+	int len;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return -EINVAL;
+
+	api2 = &data->payload.data.data_api2;
+
+	if (api2->som_type > 1 && api2->som_type <= 3) {
+		ksp_no = (api2->ksp_no << 8) | api2->som_no;
+		len = snprintf(product, PHYTEC_PRODUCT_NAME_LEN, "%s-%04u",
+			       phytec_som_type_str[api2->som_type], ksp_no);
+		if (len != 8)
+			return -1;
+		return 0;
+	}
+
+	switch (api2->som_type) {
+	case 0:
+		som_type = api2->som_type;
+		break;
+	case 4:
+		som_type = 0;
+		break;
+	case 5:
+		som_type = 0;
+		break;
+	case 6:
+		som_type = 1;
+		break;
+	case 7:
+		som_type = 1;
+		break;
+	default:
+		pr_err("%s: Invalid SOM type: %i", __func__, api2->som_type);
+		return -EINVAL;
+	};
+
+	len = snprintf(product, PHYTEC_PRODUCT_NAME_LEN, "%s-%03u",
+		       phytec_som_type_str[som_type], api2->som_no);
+	if (len != 7)
+		return -1;
+	return 0;
+}
+
+static int phytec_get_part_number(struct phytec_eeprom_data *data,
+				  char  *part)
+{
+	char product_name[PHYTEC_PRODUCT_NAME_LEN] = {'\0'};
+	struct phytec_api2_data *api2;
+	unsigned int ksp_type;
+	int res, len;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return -EINVAL;
+
+	api2 = &data->payload.data.data_api2;
+
+	res = phytec_get_product_name(data, product_name);
+	if (res)
+		return res;
+
+	if (api2->som_type <= 1) {
+		len = snprintf(part, PHYTEC_PART_NUMBER_LEN, "%s-%s.%s",
+			       product_name, api2->opt, api2->bom_rev);
+		if (len < 11)
+			return -1;
+		return 0;
+	}
+	if (api2->som_type <= 3) {
+		snprintf(part, PHYTEC_PART_NUMBER_LEN, "%s.%s", product_name,
+			 api2->bom_rev);
+		if (len != 11)
+			return -1;
+		return 0;
+	}
+
+	switch (api2->som_type) {
+	case 4:
+		ksp_type = 3;
+		break;
+	case 5:
+		ksp_type = 2;
+		break;
+	case 6:
+		ksp_type = 3;
+		break;
+	case 7:
+		ksp_type = 2;
+		break;
+	default:
+		pr_err("%s: Invalid SOM type: %i", __func__, api2->som_type);
+		return -EINVAL;
+	};
+
+	len = snprintf(part, PHYTEC_PART_NUMBER_LEN, "%s-%s%02u.%s",
+		       product_name, phytec_som_type_str[ksp_type],
+		       api2->ksp_no, api2->bom_rev);
+	if (len < 16)
+		return -1;
+
+	return 0;
+}
+
 void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
 {
+	char part_number[PHYTEC_PART_NUMBER_LEN] = {'\0'};
 	struct phytec_api2_data *api2;
 	char pcb_sub_rev;
-	unsigned int ksp_no, sub_som_type1, sub_som_type2;
+	int res;
 
 	if (!data)
 		data = &eeprom_data;
@@ -289,50 +404,14 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
 	pcb_sub_rev = api2->pcb_sub_opt_rev & 0x0f;
 	pcb_sub_rev = pcb_sub_rev ? ((pcb_sub_rev - 1) + 'a') : ' ';
 
-	/* print standard product string */
-	if (api2->som_type <= 1) {
-		printf("SoM: %s-%03u-%s.%s PCB rev: %u%c\n",
-		       phytec_som_type_str[api2->som_type], api2->som_no,
-		       api2->opt, api2->bom_rev, api2->pcb_rev, pcb_sub_rev);
+	res = phytec_get_part_number(data, part_number);
+	if (res)
 		return;
-	}
-	/* print KSP/KSM string */
-	if (api2->som_type <= 3) {
-		ksp_no = (api2->ksp_no << 8) | api2->som_no;
-		printf("SoM: %s-%u ",
-		       phytec_som_type_str[api2->som_type], ksp_no);
-	/* print standard product based KSP/KSM strings */
-	} else {
-		switch (api2->som_type) {
-		case 4:
-			sub_som_type1 = 0;
-			sub_som_type2 = 3;
-			break;
-		case 5:
-			sub_som_type1 = 0;
-			sub_som_type2 = 2;
-			break;
-		case 6:
-			sub_som_type1 = 1;
-			sub_som_type2 = 3;
-			break;
-		case 7:
-			sub_som_type1 = 1;
-			sub_som_type2 = 2;
-			break;
-		default:
-			pr_err("%s: Invalid SoM type: %i", __func__, api2->som_type);
-			return;
-		};
-
-		printf("SoM: %s-%03u-%s-%03u ",
-		       phytec_som_type_str[sub_som_type1],
-		       api2->som_no, phytec_som_type_str[sub_som_type2],
-		       api2->ksp_no);
-	}
 
-	printf("Option: %s BOM rev: %s PCB rev: %u%c\n", api2->opt,
-	       api2->bom_rev, api2->pcb_rev, pcb_sub_rev);
+	printf("SOM: %s\n", part_number);
+	printf("PCB Rev.: %u%c\n", api2->pcb_rev, pcb_sub_rev);
+	if (api2->som_type > 1)
+		printf("Options: %s\n", api2->opt);
 }
 
 char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
@@ -379,6 +458,37 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 	return data->payload.data.data_api2.som_type;
 }
 
+#if IS_ENABLED(CONFIG_OF_LIBFDT)
+int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob)
+{
+	char product_name[PHYTEC_PRODUCT_NAME_LEN] = {'\0'};
+	char part_number[PHYTEC_PART_NUMBER_LEN] = {'\0'};
+	int res;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return -EINVAL;
+
+	res = phytec_get_product_name(data, product_name);
+	if (res)
+		return res;
+
+	fdt_setprop(blob, 0, "phytec,som-product-name", product_name,
+		    strlen(product_name) + 1);
+
+	res = phytec_get_part_number(data, part_number);
+	if (res)
+		return res;
+
+	fdt_setprop(blob, 0, "phytec,som-part-number", part_number,
+		    strlen(part_number) + 1);
+
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
+
 #if IS_ENABLED(CONFIG_CMD_EXTENSION)
 struct extension *phytec_add_extension(const char *name, const char *overlay,
 				       const char *other)
@@ -458,6 +568,12 @@ inline struct phytec_api3_element * __maybe_unused
 	return NULL;
 }
 
+#if IS_ENABLED(CONFIG_OF_LIBFDT)
+inline int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob)
+{
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
 #if IS_ENABLED(CONFIG_CMD_EXTENSION)
 inline struct extension *phytec_add_extension(const char *name,
 					      const char *overlay,
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 5e35a13cb21..5b0ff9b0c89 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -8,6 +8,7 @@
 #define _PHYTEC_SOM_DETECTION_H
 
 #include "phytec_som_detection_blocks.h"
+#include <fdtdec.h>
 
 #define PHYTEC_MAX_OPTIONS	17
 #define PHYTEC_EEPROM_INVAL	0xff
@@ -17,6 +18,9 @@
 #define PHYTEC_GET_OPTION(option) \
 	(((option) > '9') ? (option) - 'A' + 10 : (option) - '0')
 
+#define PHYTEC_PRODUCT_NAME_LEN		8 + 1
+#define PHYTEC_PART_NUMBER_LEN		PHYTEC_PRODUCT_NAME_LEN + 14 + 1
+
 enum {
 	PHYTEC_API_REV0 = 0,
 	PHYTEC_API_REV1,
@@ -86,6 +90,9 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
 char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data);
+#if IS_ENABLED(CONFIG_OF_LIBFDT)
+int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob);
+#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
 
 #if IS_ENABLED(CONFIG_CMD_EXTENSION)
 struct extension *phytec_add_extension(const char *name, const char *overlay,
-- 
2.25.1

