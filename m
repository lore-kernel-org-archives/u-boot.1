Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0838AD64074
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 18:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C65890CE;
	Fri,  8 Nov 2024 19:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="R539fps9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC4589080; Fri,  8 Nov 2024 19:19:48 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B60588E0A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 19:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAiy0rwBkq/DnxnNPdxSBhlD67b/f8XEFhrepMfzHWbqlMIphxeMbMmHnX7CevbzeGd6zAmMEWgUNEICXtxFpswq5O/ErJZkFiTxWvdapPwAb31AaFPjdm6gIBfX6st3teNqCvdMM03kU7sULLqy2DD1/XkUdt/juN2Cj5QkbJ5o3D1+n0xpx73QAJSrsA9llNKhQE6jZV4PPySbHnUlKwsx7fMqR4RsP33ZD6QwvXnaM0Rs0CcARJSzyesoCeOs99A6i4OBwnP86Pu+zS6u+2EM90Wf/wMj+se5Jx8rBtCz6zlpc3WxbQlWJa41h212UUk8NamTfemF79L4qeosdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLtcUx812MXyMw5gcaXkBL/CfN71yTtS+NknY4Z2ixc=;
 b=CCNLklOppxpcqkMkgmx2g8kQcnfpXfzndaCzvujjRiBQ4S1nOoz+Jy+6f3zSHIWT6CGfBKvFuq6qivA2BOYg/ssR0GjK3W/VN0jWi3mjlfJTerp9W1ghltSCQc0QgkB7umigLzCfS0WC4fapUE26UQwSrBAA4MdBXSwRHpWzEee6t+g+8n8VrGkYFluv5pPApDH10x7X4lxkUiodi3uGW6SIzYKUDxVMLZpuAb9QtZphixFQZvBUaXhnwC0TAHFiEweXa8rYkUKYmuLjvxtxZ3R87ynSWuim6AwILudKTqHcKzJLygc1Et4hccVF37OodOSy8DA4wryGeAOhwZAfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLtcUx812MXyMw5gcaXkBL/CfN71yTtS+NknY4Z2ixc=;
 b=R539fps9hANfOzmTTIvLvMLEjnqx0svUpY4x18oINsqlBQaavT7GTobFTVg/bXL5BPqY1qZ+rCNL015SZX00cd6xF/L+x74IcfIoueupHeHjmIFh4lzrPyQ37YBFJergRBtm0aAYYIoZGvq3H7Wb5RTlEs+S6X1TZu+doqHu+tI=
Received: from DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) by AM9P195MB1079.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 18:19:42 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::d8) by DUZPR01CA0045.outlook.office365.com
 (2603:10a6:10:468::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 18:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 18:19:40 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 19:19:40 +0100
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 19:19:38 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 1/2] board: phytec: common: Add product information to FTD
Date: Fri, 8 Nov 2024 10:19:13 -0800
Message-ID: <20241108181914.3358114-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|AM9P195MB1079:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dbcb9c-d12a-4b44-9700-08dd0021e95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a3Uz0DixrNGb+GhjXHofTch3KpCy3WSdX1DebKX5YYEhS1zxPL5uQ0S6YEjB?=
 =?us-ascii?Q?tc8Sxq8AQY6IM5gF/H28tLlt+oKkbVfmUAym5gXGSjGEjFEeQlsFw6V8egWd?=
 =?us-ascii?Q?EYuJ/jEMHxlJk34dP/5RLvLmb7RqfGad96ChPEkUbPTMzRQ7GM7eLEncDdQJ?=
 =?us-ascii?Q?erAblU8pf+yOmxEm+nyoSx2l/F3GlzKZNb7oWFACNvrtrzo977gOEWEaerly?=
 =?us-ascii?Q?qAf6hOF8XJTYemg2QAbN6vnLaSetKmDE4/0cgk3ScYtJCtIiveQvXe5XxL3O?=
 =?us-ascii?Q?GgN3b4AKVrKABuP29Z6HoUvfZHKAA1n5i6E60LMf5ZQiDSiOG/pzqRxnAvlH?=
 =?us-ascii?Q?m+ickIAdF94VBRZiPb+rXPOnD9g+gceJwY7aNOz7lHIAAcLJcn8C9HWcAsUW?=
 =?us-ascii?Q?fCfk2ipLTNYsKT9ezEFzRGMNNq84bGyHmf8QOytv46auWVcZneofBLjG2H8z?=
 =?us-ascii?Q?+7K+ogVZUHXARaRbOhPQp86qZt3o090obkhSbYHuJ4m0NbmQiAW4xWvg0/tn?=
 =?us-ascii?Q?1JpG3HzrEtEIO+2ncY+xvskalaHJcA9aypAquQbeQP0hgG8XzH3T44qRRgMY?=
 =?us-ascii?Q?1zCaTYI8cY8+nS50DgLYEkVGzVazdwVl7uZyGlu2QW+9LU03OZKZxV/Pwnvr?=
 =?us-ascii?Q?ibypNIytJ/dVvW6fVa26QLgSofdD8j/4w61jakdUYlbeFH4XtnB2n3PtejJ4?=
 =?us-ascii?Q?HO3BrDLjl0hlGBe9VBdQNhBatNGzcrHaVOcRNxz6eWSFJ78QGEx+f5JazS0o?=
 =?us-ascii?Q?2OPawvkQvXEQwwYCBZNSZ8mzDp6vQinw8pZEufEINhmGW8OGepNNh9Oxas78?=
 =?us-ascii?Q?sfqM6MRtsLfEzvwJnlUQtrBBlmrcMrelSJNbY4ng1dK3N6BJ1qqJO4yPZypz?=
 =?us-ascii?Q?p/QT4I7PDIlp7bEsDraZTNVNUSANM5jcsHUR701+mPUY3smy00Too52L3NWQ?=
 =?us-ascii?Q?cjLv+ieZdOaBFoaYFK4yaHjjmgAqUfU7C0bX6F623D3V4NEFSRjT2zX2+0r5?=
 =?us-ascii?Q?qdCOW0b1a/Lf2ZTuLPpWAdy5qTRQW+ms4lY8kfyXjCKYp2grIuX4LAGIhS1Y?=
 =?us-ascii?Q?nR1Sgnl/uWTHEVSwkICEDhRpfShpfX+PYyDiRPckCqXsa72eUKBDgGGNCjTM?=
 =?us-ascii?Q?md8pd0clY8V7Q6rXksZfAsxuxa0Onm6JPJhQH+3/fQBBLY8kAb8gFPkvcWZY?=
 =?us-ascii?Q?awc5bS2O1Y06ewJ6nBCB4/rkMet2CH5cfBGZ6LlJBhgyal+hGzi2zTFdAThK?=
 =?us-ascii?Q?95q4ONcE/fwqJyaWbpCY1M3gNYyTTrhXW+6h7pdu7uxnV7L1MvtC5zKG9Vp3?=
 =?us-ascii?Q?1m8xqmnnmomoqZRdK9BqC0ClQlUubrhxciVpOoG67tcdPKRqw8t7iL0SW1tV?=
 =?us-ascii?Q?EBNPTmRkACzOoefu36BdbV8Mp2nR0dr2bReu82WkTM1pCVFO8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 18:19:40.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dbcb9c-d12a-4b44-9700-08dd0021e95e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1079
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
 board/phytec/common/phytec_som_detection.c | 204 ++++++++++++++++-----
 board/phytec/common/phytec_som_detection.h |   7 +
 2 files changed, 168 insertions(+), 43 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 166c3eae565..ea439be5163 100644
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
@@ -379,6 +458,38 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 	return data->payload.data.data_api2.som_type;
 }
 
+#if IS_ENABLED(CONFIG_OF_LIBFDT)
+int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob,
+			  struct bd_info *bd)
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
@@ -458,6 +569,13 @@ inline struct phytec_api3_element * __maybe_unused
 	return NULL;
 }
 
+#if IS_ENABLED(CONFIG_OF_LIBFDT)
+inline int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob,
+				 struct bd_info *bd)
+{
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
 #if IS_ENABLED(CONFIG_CMD_EXTENSION)
 inline struct extension *phytec_add_extension(const char *name,
 					      const char *overlay,
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 5e35a13cb21..db232cdec48 100644
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
+int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob, struct bd_info *bd);
+#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
 
 #if IS_ENABLED(CONFIG_CMD_EXTENSION)
 struct extension *phytec_add_extension(const char *name, const char *overlay,
-- 
2.25.1

