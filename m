Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1C3C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731FF80711;
	Thu, 23 Jan 2025 15:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="czAJcy7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3B1807C4; Thu, 23 Jan 2025 15:44:12 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33C7801B0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHBDj9Ms3phl7H5RAaU5bPUQyrGsRxziVK4hSOAGjlcAcVf9wkvf7j2mXI5fPhnNwlcrgddKbWyu3DLMZ8zv3L2+6LhLaeTD+A8ENQqaez/KSyLANfJq7O57MtAhMPU2VcNXGTfMIRGO0K7YL5fZx/HYrZWD9jUZsYNanHnejXi8zOdsRqxdAtONZrsOPqyVfa70UfHUI7lEWlapzVlo8Yt1jJPYCcJzoGqb0QDIpG0fSerl/z92IGUO2tTOFNZNiRDpRnVgZtHY/xhXJOQaUzQLUzbjBODkNDImbOP7FRnwtPXWP5rU5ZprCXonjR0t715IKo1Cv/BqVklsPxx6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kFPRpcOyt6P3Hey4I8VpRVk+RmQ9XOXcc+8x/9SIhI=;
 b=MAEdENIQPSEkVI9gv/3rnGJbx7wOuboxUg8y5bJ8BU/iOtwnZHGsqseJtyPBGiFGRDTgqp1PlAr6tYV/KNA71KhURudrauOd3tuJ98IN+I2UTUFt9jdZxz4b4GjdcHpxfMZpA8YKlI9ZHglUeJ0fu9yIMj24J2TWDTJG3fh/USPAk2y0DARJEMKz1YHYZSs6fErRnLVhyiMKnb9mBi2cUjgNKt3QijIjW4r8Ky0QT3IXCrqlgrd+VU+VEoYVxC5UTuF3xPT2Zr5HtAgqyDONZB8H2PEGpjYtKoF0siM4g3C3Pt16EKF75+NQPp8wndgTUsR8PLBhYseU4CUw+NHg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kFPRpcOyt6P3Hey4I8VpRVk+RmQ9XOXcc+8x/9SIhI=;
 b=czAJcy7WH7F1gkSd6+8+w/VTWPEVZq2VVf/GCcY8mZsCHe6DHD1NUYKxAeb7tVqh4g6jh1tRVjc2g/1eTOngw8i2UrUzDlqvKs1R77sjobAAM4qZCR/ceeAhUo5HG+eQRJ7BVNygByMRMzX/ZbCOpuWe2taIdmddi+0F/LdMOKIEeAupFuMoSU5FHy2eBkqHReVGoW3kvl29ZBD/zimSJQQ9/W+YGJcpWImYegnoQ1FfKCAyPneBVhedpWXuJ9sMzO97sFeNXiWbbDuybILqAl6rVSt7V+sskqUcYupsC0FEp7o1UZr9dx7CuSoh/b10/idabPWKArosLlL+THwtag==
Received: from DU2PR04CA0184.eurprd04.prod.outlook.com (2603:10a6:10:28d::9)
 by PR3P195MB1104.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 14:44:06 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com (2603:10a6:10:28d::4)
 by DU2PR04CA0184.outlook.office365.com (2603:10a6:10:28d::9) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18
 via Frontend Transport; Thu, 23 Jan 2025 14:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 14:44:05 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 23 Jan
 2025 15:44:05 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 23 Jan
 2025 15:44:03 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>, <y.moog@phytec.de>, "Daniel
 Schultz" <d.schultz@phytec.de>
Subject: [PATCH v3 1/2] board: phytec: common: Add product information to FTD
Date: Thu, 23 Jan 2025 06:43:49 -0800
Message-ID: <20250123144350.846527-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|PR3P195MB1104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a033d17-356e-4b39-6791-08dd3bbc6320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TaD6dg7o35VQQWeAcnBowfDostyZP2ShKO/zd6y8T6NEKFpfoSAfRaDpJ0N9?=
 =?us-ascii?Q?55jh53DBE9p8iX27H7Et0VU5PDIdy3+bdFxF+NDkPrpErV1fd+mCZmqlNu/j?=
 =?us-ascii?Q?K8j+u/TIQPwCfORebJVNePX3yMtN8ab32gKONK50QzqOglsCPL41p2qSz7Ot?=
 =?us-ascii?Q?EKN6MKzdckUVohO1NwZX3MdQvKMDeBbp0qrau3v6o/2VZyDr+PmzyYJl/tC+?=
 =?us-ascii?Q?9wUPlLfrJ5aaUFoPlm0s/JwzLqxZrYx4xYs+z6ieWAwxlyXPiD2VcUJ7BF/T?=
 =?us-ascii?Q?fyQNHJdc3zNptGqoyecOGM105zfvQipw7lfyuNdXsJ8I4nOru34ql74GtLq4?=
 =?us-ascii?Q?PmFFk4vKlvPQrRhaLVLy1WVgXbFGwuH93uEWBj740GxEKjLHNXmcDqjtmedl?=
 =?us-ascii?Q?sJWOzvny1d39hwTmCh/iTMTsZ7PE480+Sc0dhIiANvO2g2bosM2p2g9psATk?=
 =?us-ascii?Q?S499fEX5z/dSuOARwjClOIiKQeK0zdBGznSI3OKjNe2D9M77APZdRj6sSbPr?=
 =?us-ascii?Q?O1qg/RHeVdwaotkhf1rpemAEhrRg6GSxtUaueGn5iWCB7hYi1M4WpYtmkPVk?=
 =?us-ascii?Q?RQLsXijBg/cfa6pPP5YrLqeyocCVba2TLRVFDyRxZ5COt5NO8CpIKW+elORF?=
 =?us-ascii?Q?Z0eNeeqmqkiw02WX15ngGfMG/1QczMcW8SeqysGYpdSKvgUUCiRyehi5ZVf+?=
 =?us-ascii?Q?dHiMB9lAvSpl60n2GNZVcXhXcJkhI75wK0vx/wcEyyWnj/n9PLKncY7d7uWn?=
 =?us-ascii?Q?DYBsvClb4W4CFaiY0EAVI+G5Z6S9mMBHqMJda5MsmAA1PhAOXF3kWvgt2sxS?=
 =?us-ascii?Q?MwX1XUaZxnIIsi+NVTPjPQWMn+njn9hwxtkHdNuHRaZb5UuEoxRPYgxk07Q2?=
 =?us-ascii?Q?iBzHM57dzz9BQZ/6x3FHeKeLIsjEqJdo+ABF1tw4xH0gXC5/JT2JxhnoY1T+?=
 =?us-ascii?Q?6K1NfTXkHYQ8vVMLxgll+cQHzgt1hp4fHc3UDu9ljk7HDfYfcdWO1Llj5W3F?=
 =?us-ascii?Q?+HxD9QpluS6I1lZwad5Nh/S5kjn2SB3x888tk9SsJqFDKpzbxkJkdvU8q5lg?=
 =?us-ascii?Q?lF0+oiIpQnuxA7UpQTzyNG5oZcaZ+9YMrBjZUdfhfrBzF9y0GsSQKesFdmGM?=
 =?us-ascii?Q?q6g3yR6VQxwQLgTAp9fuSBd9pyt0M2Y0JzZ3zZbyRMBelxSLkLv6J0SN9i2D?=
 =?us-ascii?Q?dfTVz1/tqIrujQfals7H0aJMYTtnpzIXfB99N1TmS0qxBwVzAw3qfdbEqmpq?=
 =?us-ascii?Q?jQBKr6ZklBk64oNLAIqi3Nklo9YUXfHK2Xer+94XsVoELxzyjRil/chCzVch?=
 =?us-ascii?Q?pcd50BOfYXV+MvDZzLV70kgBbq4CxMnENPMfz1fx9CrgxvI60kgW5KfqlrLO?=
 =?us-ascii?Q?u/8ETDIy3nN8dYNXrdWI2dta8G1hW6UXx8P/MEJF7De1Plxwoo/3HkYOTs8j?=
 =?us-ascii?Q?y73Fog35QyNZO1jhbkgy2ySVPtKvs2wT9MZqnLNoNc4t8nqb4guibUIefWZi?=
 =?us-ascii?Q?8trx9h6WdOBUOzE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:44:05.8811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a033d17-356e-4b39-6791-08dd3bbc6320
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1104
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

This patch also updates the phytec_print_som_info
function and changes the output.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---

Changes in v2:
  * Removed 'struct bd_info' as argument in function phytec_ft_board_fixup

Changes in v3:
  * Removed not required check if variable data is valid in new functions.
  * Moved '+1' from string length definitions to snprintf calls.
  * Define more string lenghts to check snprintf result.
  * Return -EINVAL instead of -1.

 board/phytec/common/phytec_som_detection.c | 198 ++++++++++++++++-----
 board/phytec/common/phytec_som_detection.h |  12 ++
 2 files changed, 167 insertions(+), 43 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 166c3eae565..1f2213902ed 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -271,11 +271,122 @@ err:
 	return ret;
 }
 
+static int phytec_get_product_name(struct phytec_eeprom_data *data,
+				   char *product)
+{
+	struct phytec_api2_data *api2;
+	unsigned int ksp_no, som_type;
+	int len;
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return -EINVAL;
+
+	api2 = &data->payload.data.data_api2;
+
+	if (api2->som_type > 1 && api2->som_type <= 3) {
+		ksp_no = (api2->ksp_no << 8) | api2->som_no;
+		len = snprintf(product, PHYTEC_PRODUCT_NAME_MAX_LEN + 1,
+			       "%s-%04u", phytec_som_type_str[api2->som_type],
+			       ksp_no);
+		if (len != PHYTEC_PRODUCT_NAME_KSP_LEN)
+			return -EINVAL;
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
+	len = snprintf(product, PHYTEC_PRODUCT_NAME_MAX_LEN + 1, "%s-%03u",
+		       phytec_som_type_str[som_type], api2->som_no);
+	if (len != PHYTEC_PRODUCT_NAME_STD_LEN)
+		return -EINVAL;
+	return 0;
+}
+
+static int phytec_get_part_number(struct phytec_eeprom_data *data,
+				  char *part)
+{
+	char product_name[PHYTEC_PRODUCT_NAME_MAX_LEN + 1] = {'\0'};
+	struct phytec_api2_data *api2;
+	unsigned int ksp_type;
+	int res, len;
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
+		len = snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1,
+			       "%s-%s.%s", product_name, api2->opt,
+			       api2->bom_rev);
+		if (len < PHYTEC_PART_NUMBER_STD_LEN)
+			return -EINVAL;
+		return 0;
+	}
+	if (api2->som_type <= 3) {
+		snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1, "%s.%s",
+			 product_name, api2->bom_rev);
+		if (len != PHYTEC_PART_NUMBER_KSP_LEN)
+			return -EINVAL;
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
+	len = snprintf(part, PHYTEC_PART_NUMBER_MAX_LEN + 1, "%s-%s%02u.%s",
+		       product_name, phytec_som_type_str[ksp_type],
+		       api2->ksp_no, api2->bom_rev);
+	if (len < PHYTEC_PART_NUMBER_STD_KSP_LEN)
+		return -EINVAL;
+
+	return 0;
+}
+
 void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
 {
+	char part_number[PHYTEC_PART_NUMBER_MAX_LEN + 1] = {'\0'};
 	struct phytec_api2_data *api2;
 	char pcb_sub_rev;
-	unsigned int ksp_no, sub_som_type1, sub_som_type2;
+	int res;
 
 	if (!data)
 		data = &eeprom_data;
@@ -289,50 +400,14 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
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
@@ -379,6 +454,37 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 	return data->payload.data.data_api2.som_type;
 }
 
+#if IS_ENABLED(CONFIG_OF_LIBFDT)
+int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob)
+{
+	char product_name[PHYTEC_PRODUCT_NAME_MAX_LEN + 1] = {'\0'};
+	char part_number[PHYTEC_PART_NUMBER_MAX_LEN + 1] = {'\0'};
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
@@ -458,6 +564,12 @@ inline struct phytec_api3_element * __maybe_unused
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
index 5e35a13cb21..187424a2b44 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -8,6 +8,7 @@
 #define _PHYTEC_SOM_DETECTION_H
 
 #include "phytec_som_detection_blocks.h"
+#include <fdtdec.h>
 
 #define PHYTEC_MAX_OPTIONS	17
 #define PHYTEC_EEPROM_INVAL	0xff
@@ -17,6 +18,14 @@
 #define PHYTEC_GET_OPTION(option) \
 	(((option) > '9') ? (option) - 'A' + 10 : (option) - '0')
 
+#define PHYTEC_PRODUCT_NAME_STD_LEN	7	// PCx-000
+#define PHYTEC_PRODUCT_NAME_KSP_LEN	8	// KSP-0000
+#define PHYTEC_PRODUCT_NAME_MAX_LEN	PHYTEC_PRODUCT_NAME_KSP_LEN
+#define PHYTEC_PART_NUMBER_STD_LEN	11	// PCx-000-\w{1,17}.Ax
+#define PHYTEC_PART_NUMBER_KSP_LEN	11	// KSP-0000.Ax
+#define PHYTEC_PART_NUMBER_STD_KSP_LEN	16	// PCx-000-KSx00.Ax
+#define PHYTEC_PART_NUMBER_MAX_LEN	PHYTEC_PRODUCT_NAME_MAX_LEN + 21
+
 enum {
 	PHYTEC_API_REV0 = 0,
 	PHYTEC_API_REV1,
@@ -86,6 +95,9 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
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

