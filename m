Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D060D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAC389095;
	Mon, 28 Oct 2024 03:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9131D88FE8; Mon, 28 Oct 2024 02:59:33 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A721A89026
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSwmSc9vcvqwZzEqMKZAadk9WrfPc1sMo17bHgZfWH/0cZ/CeX2+ryTZjyNtJNw/38iqvXJ18hST2gRqf6S0YigN1ugB3MhMhRECEHdYN3VdR57nYm/W7FSOsyE9y1is7B4qGeLATXCEPGTiRRMjvzblJstR6PTr4uGP1kkqxEn3QqjodvSrB0i9duFej3it07FIp9GDYsI8WjiRMnx1L+IcE6XRUVPMcwvSrvrk5GVQBPrXsdWZos9puO6xsoK+QaSKiyIzvof+bib9+mEIUBdkAMeE6zg0mH79f0KjcifW3qki2w+4WDPNJKH6f2Q3blbMYMi/166ei5I2X82yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFlcd+hyIJlpDIlEkh2epQo7aiXnsr6btqlk6UCbk3k=;
 b=dY4BzGOCtnLRtJHSk2UnYVjeVxdW4I29A8sWnMvjMOqu/xlR7Nq6sAOXBDxUWP3EwsGFIQ/q5NheEpBslwPcsNgjiDfvoOSX1l7iqKGLq6lhoNUfv+dnY0XLTQJ9CelhFqMigtViiY4SgOd5Rpb80d0sV6yh2SgP6o5LmXPW3aQVmjtG9m0Miz5ymXgEjarACAE4hXFz28TWu+HrgH9GBc/4TqkAc4wZ8jNJYCjf+3u079L3KD/Smx2KnDGRjlGGiC7JQ2qvpHe5lCkhTGPYP0KIAnchGCly3R3Pf+XAQ1Hxgy+OjCchBRJeZLS79Yin5TKlAdHWG/vnspxwWAvKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:19 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:19 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 14/14] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Date: Mon, 28 Oct 2024 09:58:47 +0800
Message-ID: <20241028015847.42344-15-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1d4070-1fb3-4646-03be-08dcf6f422c0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: pHNTNbx50wZAYDMrFs+Z4HfV4aHP2c8s8fia/ionlduLerJJq10AI3otUwk35cbVjsdWAWpHJJJBEXh9X4kYsZmp2vbXMhJcuIN8ti8KHMI0TFoExQLd9LEtr9qJGfR6ixgx2E2WdNHGhxS/039BHv2h1u6vl+qVi1Cjla/qHJHWqDy4ZIFk+SPTuIaITcNL5d1bSLFJOcM3dNQTak+5wcPVr4jCWszWZ0kLwkkwNuC7sW85kPEMvK/S0XsqJ8Ecm/gAde+X+zVWG6GR6g/CBqQKcMibDcCiCIpHftWsIgOlTWODG0/nty6kM66IRWGe7liX1AzrE5y9/QmwWUjr13jSJEpKwtjPoidReHrBlRk7T6qmwGIrVVDTylvyEVZLOFXGYJz/s4U2hsyJ+rJ9u/ezNPzBlrrWGFlS0/1RifKXdFQzMiDkConEYmCnh/7/D+71t9V7RM2bYQD7vcgQZxOIP6X9dlNfeJ8vet2H0yFJBHtEVmCgNoKjUGTFUHBd3FBC//1pYF5nF8Ol20wr/ptTgZGxlkWvrwxc5TRG5nnaX4+g4K/oGUF+nwUAYU6EWhgNDEJha8VA3AvkZYZx1yMdZ/C4rGgVL0D1RVefglZPU4Siq8bLObKfVO81rb4y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cv9WF9yYr9qG3Z/55IWe4Bcs5I06AS8x4YjpNT+NAl8w6TxdmEUzUqb7VED6?=
 =?us-ascii?Q?tBymGyw0c7aqtysvge52Kz232NIM5CZ83Y0wRQHJYxYR5JVWMD5OYPkieRd4?=
 =?us-ascii?Q?Mec6+RKIbJ3ffXyXjY3sVUTnixUJntvtEbFFtem3jbGJLI7Lh15+bVdq5T0c?=
 =?us-ascii?Q?yncXnfqo7UXeHttMQW/PDxaCr7miWnBmKW1vtpr7bXdElVCBhcIXjJFoOdiR?=
 =?us-ascii?Q?EW/MGl0cHmQW6PTFAIyC+thMvddQPL/SEaDYUOCxj286VMAp/o3Wta9aoSYk?=
 =?us-ascii?Q?CkO0JGkZ0nhUCk05P2tH9bIfqoiOe1IizRtrT+XvHMYUOih4pbGLRgscVhpc?=
 =?us-ascii?Q?gpG7ttJdjTIv1oWBBCtxkraFIj5QVzjHhOQpowRjORwbi0wNSAWuDWRYVmQg?=
 =?us-ascii?Q?ny0MNIA/6iqTleWEYeRfNa64kxBom/hA4H8mrQijzT90hvDwsW5ig8/QB0mW?=
 =?us-ascii?Q?WNshK1gQBSTf/lmrIsYKs0TC35a96EmjTU/mW5BIisngWoFyp1OhynV8BojT?=
 =?us-ascii?Q?gzb0Bv6GI8h5pky4rQErsbFYmPSyZj/mZWMM/V2Any8NQEV/dv/Rl/MspPIw?=
 =?us-ascii?Q?13pS9+Qlg2Z8h+4f/WDgTiaeXVtF7B4QXMfLO9pN87sFUCP+Eu3LIXWJsdIu?=
 =?us-ascii?Q?CS5xhc9IhJhL7dygeLfCxRbOIj9jdzki2u81/5KyaOr9XfhmPHVKs+4r1PRT?=
 =?us-ascii?Q?CCzffUBSyvSaRmAOm9RwHLt5/UWXDFds93RCN/0MeweDgK9SPtnIksDGdb0N?=
 =?us-ascii?Q?eZoWuVkDg22iofvQONflBvKuDeYnLtpF8qC3DEB6aQD1Xj2ZRV+GkhctQqCE?=
 =?us-ascii?Q?4dL7iRSstDzkC/BikwUK91IKAD+Qn0k+4PC8dL8n/BFf5CDlNqLrs/pYvct0?=
 =?us-ascii?Q?dM5yj7e//PP7Ezi3NhotKc+nGPKk8WUf/4TFvwuMOQ5hn9l1lcSjBwij20lG?=
 =?us-ascii?Q?CU60Jvumk9Qzk8W3Sb7WMHGzQbEVIskZHtXulO02b7ydLC6hBjfweShrbqeD?=
 =?us-ascii?Q?QHXxG3vX3rG0Ypn7p2fvZOr7lpMotCEGH8KXUanZsNawdB51J8fi7TyYVqk3?=
 =?us-ascii?Q?IzDTKexOrvD6O1wFpHbffmfnNU7vxrE/NVxhicZjnbO1yxRToIr/Oo3VHYgN?=
 =?us-ascii?Q?er/jGpAUu66AOPL+x0ta2x6kRbkheNiBySXW//2p4pzhNNq/LCqBPrYAWRZ6?=
 =?us-ascii?Q?gznqLbAlK+Ce1a5NZm9oPPlOpFH3rk64ft/uzuUOAKLey0miYJBLpNun59cv?=
 =?us-ascii?Q?TaCcmbZPfZW8tDLodNJsbEx/uPIW0rQ7pVCEaDSQ5WfdDJOKoh4u70/PQqYc?=
 =?us-ascii?Q?b2B0KZpR+HkthxWnduvrBKu9jB/VSd7tMg/ZlRfbJNZrgEQVhKd1A/gOBaDf?=
 =?us-ascii?Q?r9OnqwDMysHglVjqqdn9YFQy0TLC7zl0lN/rKHpPLZx9QVWjep0D6noTqC+3?=
 =?us-ascii?Q?EWbtQrDSWB6a/730K46E78zc8Ymj5eFjZkrlEr4loDO1MO2RKif/+ydr9dmC?=
 =?us-ascii?Q?ty2jnoXBD5ZfJgUvR1SkAEUqXN4pVaBZ1FGisBY3HabPj9l5CoKbmxijE17A?=
 =?us-ascii?Q?/AlV2VbjHmZssYyWIScPGM2ftIrREL0fhPn1Z5bpwUVbOua7AvSz4j7tAaOb?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1d4070-1fb3-4646-03be-08dcf6f422c0
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:19.6528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywXBOo8ZTelcoO/BsXfyKUhtjZt5DpBFFR9yAjlW2abGGsk8oa2N1sADq7z+nlgqD68I5YocaQBNgodXdN1V8aljns6MEHvbm1iNZdzMQbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

Use the EEPROM information to select the correct DTB.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index cf7f39d5c5..7f57f80de3 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -113,7 +113,28 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	/* boot using first FIT config */
-	return 0;
+	const char *product_id;
+	u8 version;
+
+	product_id = get_product_id_from_eeprom();
+	version = get_pcb_revision_from_eeprom();
+
+	if (!strncmp(product_id, "VF7110", 6)) {
+		if ((version == 'b' || version == 'B') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
+			return 0;
+
+		if ((version == 'a' || version == 'A') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
+			return 0;
+	} else if (!strncmp(product_id, "MARS", 4) &&
+		   !strcmp(name, "jh7110-milkv-mars")) {
+		return 0;
+	}  else if (!strncmp(product_id, "STAR64", 6) &&
+		    !strcmp(name, "jh7110-pine64-star64")) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 #endif
-- 
2.43.2

