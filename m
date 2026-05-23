Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0283DCD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 714AF848F5;
	Sat, 23 May 2026 14:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ivwRMRhG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B7F848DF; Sat, 23 May 2026 14:23:25 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910AE84881
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzpfbJ55HuNEJTlg5AYOtIYtHZLKujjfd39siDbL+zvNvkxtgmVAiGb/Vu6kJSaRDQgX3GUlynOM099KsfZpTqITLuhwkOlmD279lWSiLEI2JMVESVrC4ZvFqKKWYF2kqUkMoEQEiza0v5pJgGGLy/6laKbGz6WtivzDbVIEbd0cD6VZ+tYhQ+zgITQO7KPAOXZnKG7d+4nPOOWDcpo8VGH9jFVnp9Y6zA+JRAGrtq/UDsBwWUlfH1e3fTQl2fd0luYmX2Dkj3pLZ3L77RykLmhEVDj4cwz7IP0R/EDdjJJcU2AQPo5AJK4lCwCFXS5senUdJonpXpxGURp3nVve8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u4S677UmCTaSvEEUQ0+KhOwxrfvD62BpCJQp550lV4=;
 b=OChBaK6hl/WUqxmbhfuqMK77V40DkW3MlHTbjmVvRqe0eQqYendpGSp8+lb7TBs5zxadOGe1jcdUMi9nNDcbypETwKl6B8GXv9MM8BUuAcjR/Z8Z0sS+BEtqzbG3YWMJfIlRpH3EJSHuSMRXQezlLEn1myQsfMhmj0HHN3/ZdvMjtSRxFGgba3bCXGSE6J2OTOqpAhSJ5CKwHmKDKwBTsD3QX0jQWNDrbnmO1t/9SkSEE3JhY2CKtf8OApt7mDypJW+jgxp05tMiBzOOotuKhk/0kRJVZ92o09L8E5J3sGBwkECrW/4vEljXD2Mi0dPtuFuaYD9ISmXkS/Rg0pzHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u4S677UmCTaSvEEUQ0+KhOwxrfvD62BpCJQp550lV4=;
 b=ivwRMRhGRA55lITPXEj/1tfmEYuAO0x1SgZ26mkdbaehV1GW2QWryxuUbsY6OX4LAoRrSVlCSp4HkfdjvHyiKprEl7h69EYUfbNb0cVTrMHRNnOEL50FW0UaOK4oARwgwVrxTUU0yCjwlkAjZhRS1VxxZkUbXFJfUDUYiv8uGWcaV9AEj3fVYLAT/IM2wThMUE8Vy9f9NfmyztSMvlVf44kORq1oP7s1QKpQsHS/E0SHt6Z8QAotWPhmvJrRbkgNYbGF8bl9nn6s3xrvPOZX4MwInG9pl1/CwpMsJfgQVIzSja42UP0+CQZXhADantMDBqxNmeY51B8bOZovHQ5xrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:21 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:52 +0800
Subject: [PATCH 09/13] gpio: imx_rgpio2p: Use dev_read_addr_index
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-9-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aed7f96-2a9f-4927-5c24-08deb8c61431
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xod4/zYJy86XppvScUBnIgwK/JXICRn/G8yVqvuVL8SNKgEvnd2+6VjqzYhXV3MLKz9cZ7r9r7JVY/VkNwlGdL3hiSVhRt3yhXxZYFNOZsNFH/eLiqpi32Vv3jepsXnkUeZ1TpC3/Ddwuh6aAl4AsL5FAy59nIacc2ha6SmN3n0BCAub7Jb0wT6n9gmb2EnnVmrd3yx+nkcD1i22lDBHqFTg16HekXmu03CeFQSKt8WKzD3NXNEbwcWQmcMW2HvD1eZSQUuACNmVNqgJ576OG08itzUm0cZ8GilR+WopVPLGsI8EWQ/xQ8QFeKI+OB9AypVpTSO+WGIvX0kIjztVbq2F3iAuHJhFWIiJqM5t/sPeTikuGArGZ68wCWYUyERM3Mg2Zar70wkKB0Zfv1ZCpg2IaDXM1qXolRwvSGo+0kJCU2iBAZy8GUm+pI39eUmlgHlNeIrgkCQcTipjIG0jalbglXu+s5am5XcoyVfGv2KiG5B9h2/9hu6lZbHHUS5pkDnCWc68k+m8sg1NkD7/9CFtTCpF0hEfw1nzVtvH3wa/Fc3CyDEzAqKFs7xWTWxvBpwhBvgA8n8H98NW+Ww2UOOP1CXGSBtLJjokPPNB7z6DucLtoyxPW4MsfatVVxHWj9wZaiu58Nbf4HR/FmfgOMI+VH0Ld126N89QyEqTmaJFX+wUs3JBmf37JJ9gH4aRb4krYLICVwGzpisoWQHGf8GBM63MOHeV2wkSFCGThrS5qWba0ZUhARNRWr//yL1F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVA5T2tyWEFLUTNYWmkxVk0wNEhnU0xVWTlFSkpKc1ArbGZvdE1MYmlmeE9Z?=
 =?utf-8?B?bGdKczRQUXRIK21MWXd2MXpEaDZ0N1Vpbm5qMmF0c0dTMnhSMXB3aU9zVFBi?=
 =?utf-8?B?bCtaYWxuSlJCT0prSEYyN0o1TGRtRlZVUnJaMENsSzFxY0o5bGlhL21EcnVq?=
 =?utf-8?B?VWJMbzY4VGg0TDZldE9xZDZUdm14a3RLQVYzSGhQSW1rQzlIN0ZiSmxtazAy?=
 =?utf-8?B?akY5L3dtaTJYdkFZbHRmYkdUdGplb0piSjhuckxJQW04elgyNkgwaExGSG5u?=
 =?utf-8?B?QjVTOEMwODVpVzZoZWoycWtVR2x6SkFWeVZhWkM1dEllOGZtbzVwZU04cnhD?=
 =?utf-8?B?dTJNQ1FwbFRpQ3FKRHpzVDAvZ1V0WnVHWm1ETkNPbVdmK3FLbDM2bUZVVWdK?=
 =?utf-8?B?eWdMakFGTnVsMXl0UVFCdXJmQnFURHYzMnNvMlpuSlJQTk9EU3h1elkyVWxH?=
 =?utf-8?B?c2FPK2d6UWZMc20rOFcxSjVzcTN0NDZNVERJV1BUUnRmR2drNnplTFNuZ3F3?=
 =?utf-8?B?eEhrOVBJSyt0b0lRQ3Vib0RHUm1oakhsVHBsM2JHb0VQc1lLQTBOK2lPRE9n?=
 =?utf-8?B?U2tWMXpFOHFXcDRIRXF3RGRrdVZ1Ti9nTVhlUGN1eG1VNFMzdGR4ZWNQSWNB?=
 =?utf-8?B?NlA5NnZ4K3VPNHFoT29zRnFVZ2hXMWhCd2tOMy9ZcnlvclMycmxxQWJhZVll?=
 =?utf-8?B?R0l2azhkQThkUVJDTCtNYjhIaTNsQTB0Unorc29BOUxycVo3N3Z1ZzdXbm1Q?=
 =?utf-8?B?VmhCblF0UmNjNEp5YWZ5Z2RWMWRpK2RZeEQ3ak04NU5TVnNuYXluQ1Jmbnk1?=
 =?utf-8?B?VmJpd0RKdnd6OGtrVDA1SUFQb2lkVkdIc3BSNE9ldVR4VHB3QTVDYmJCTHVq?=
 =?utf-8?B?UUl4OEtZVXRyV3Z6MXM2Rkc2TEpnOUNDMmRmWEl1cUZJcDBYenlyZ1M1V2kr?=
 =?utf-8?B?TVhUOHdzVWpKSkw4OVdUc09HN3FLV3p2aHpsSnF0N1FDelU4QnpnUDJOMTd6?=
 =?utf-8?B?NzhYTGU5UStTZldTWFo0RzZXYTN0a1NPaDdoMzdtekVCUW44L0pxNVpRV1NK?=
 =?utf-8?B?VTBpdEEyUEp0cUlJOHAvdzhHYXhmUlBVZDhVK00xWGZVTkd5ckpTbmFMMFdy?=
 =?utf-8?B?QlVUM2NSU3U1eS9JL2ZCOUpaZzVQbGFRMU14cUxQVGhHam8zMXBKSWRyL09k?=
 =?utf-8?B?elFRdTQxa0hrTStSZFo4cUpMUWp4aUVjUFpRZkNiTURGS1hJTHdpbHpyM3dC?=
 =?utf-8?B?RzFRTUlMUXRsRXhHK282QjNUeEJKZ3dIUnEyVnNjOHZPZTF3QStXMlNtUE9G?=
 =?utf-8?B?WnpsRHFLSGtYcE9zeGhDT3BJSHpNT2FsbnNzVHFPNDVhVnVOUGtOaldpbjlO?=
 =?utf-8?B?NUx3czBZaDdwNGpBN3lFMFU0RW1IblNXUUdzeTRaUVdLcFBYN1Rsa0wyQk5E?=
 =?utf-8?B?bngzZm1jWTR0WGJYdHgrZFhyeWZGSkpQZVNBWTFCQTkvMFd0YkRoSjkyU3No?=
 =?utf-8?B?eTFvbWIyMzYxK2lqT3ZoODRvYjd5UWZ0Vk5lYUdsQnJHR1VETUZpRG41U0Zz?=
 =?utf-8?B?dDlycmJuU2w0cG9lT2kwQzRFc2NFZ1N2NmgwbGxHd0tKTVlrUjFCczB0Um9I?=
 =?utf-8?B?KzE0cFVNRHNkTFBCV05HeFRWQUNqeE1Cc1AwUUdKL2lDZWE3dkJ0WjhENWFZ?=
 =?utf-8?B?WDM4QUx5UStqUVV4My9xdFVrS0pHMFU4K0kzejI1TnZUZis4RW5hUGt3azVU?=
 =?utf-8?B?ajlDbUFtV2NEN3BXRHU2S2Jvb0NjbDl6UmQzbEpBQUpBUCtOREFOckVOZW0r?=
 =?utf-8?B?MjNzTUxRbjYwVmdYYzdBZ3dDbkZ5SXZaTytpM3A1WW00R0pCMjRXYWF5WUZx?=
 =?utf-8?B?dmgvZzkzK2JidWxCRy80NkhpODlqQ2JpakcxRGovcmh4aFg2MmMwS29yYVRn?=
 =?utf-8?B?VmhjV0lnK0pDL2tuM2tzdXNGU2FJTnNaaFBESWpQbHBya1RIY1M5TU96cWk1?=
 =?utf-8?B?ckF5Q3F4Wk83OW01VXFuV1VpKzA5Rno5ZytwaU95bFowV0FvbmFtMllKMlE4?=
 =?utf-8?B?aXlKaVNuU1ZJK0wyK21YMHQyQ1RDeVlOd1pSNDZqMHpqbU43eC9MZ3ZnME5U?=
 =?utf-8?B?MDFqc2NBMU53UDBOYzNaR1BZUk9zQTBCSVpGQWxSZ2J4ZWRIbVdJTDM1VDZF?=
 =?utf-8?B?dWhpWkNHTmhxODNnZFBGdm9aQTdPOFNYZHB1M3d0dG9rUE54M3R6UkRSNW5R?=
 =?utf-8?B?c3Bib2FJdDlnWnJldSs2UlpwMW0xcXhDSmo4U1hQY1E1MDdjOGdCTTY5T2Zw?=
 =?utf-8?B?Wm9jYlh6S2hUM1VlY0p6cDdqVkxpc24xa0dFSGd6Rk5uVG0xT2g2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aed7f96-2a9f-4927-5c24-08deb8c61431
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:21.5845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxZY0EbRqP70AcEsXko19CS9etNx+swXjbQHQfOwyGvnlKQl7sKDS9B7F/U7OXdcXQVAmJObM9CcGNCn+KnD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_index which supports livetree API, otherwise driver
will fail to get addr when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/imx_rgpio2p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/imx_rgpio2p.c b/drivers/gpio/imx_rgpio2p.c
index 7cf178f8a48..ba3c5fcf25b 100644
--- a/drivers/gpio/imx_rgpio2p.c
+++ b/drivers/gpio/imx_rgpio2p.c
@@ -194,11 +194,11 @@ static int imx_rgpio2p_bind(struct udevice *dev)
 		dual_base = true;
 
 	if (dual_base) {
-		addr = devfdt_get_addr_index(dev, 1);
+		addr = dev_read_addr_index(dev, 1);
 		if (addr == FDT_ADDR_T_NONE)
 			return -EINVAL;
 	} else {
-		addr = devfdt_get_addr_index(dev, 0);
+		addr = dev_read_addr_index(dev, 0);
 		if (addr == FDT_ADDR_T_NONE)
 			return -EINVAL;
 

-- 
2.51.0

