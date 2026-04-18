Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CB5F99C7C
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 11:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26D584214;
	Sat, 18 Apr 2026 13:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t+Hk4Kbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DFD842C2; Sat, 18 Apr 2026 13:21:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC8D8405A
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 13:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPYurvtoMplePXT6pY52e0UDemXDP2dQVuMDpgIik+HQ2H8RCYMJrwndLlTji65fDQ64Zyfef7K+k84F2po8lOXqtqIgIVBV8/wycozXNSPK1tmYVWeC75WHKnz3qvPy1OX40RXwGGPKvfNLSYadgq7Y5xpmePnokogkeuI28orQqdZmphKXfUfY99JePzc+06t6rtXkKO+377MLjP9UsdztwpC1IMknnzOsCNExaKX075Ub4eqcB5YVl96v1dO7kj2zG/GBQjmdSOUBq2RLhw3vf1SXeiwsGNv7A9TyvKULjgKuBRI36iMCJj0DMj/9DSCsAybTOy4E8zPS6h8jQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDziDMJIHLrLkO9bJX2+0jbWgndM4UPxcXl585Z7LS0=;
 b=FETHtWQQvCymzIdVgVpO/ENQVK85Aoaxf/YLEVson+WFWekRrXWatpz8zq2Y+XXHVCLb2j0Dev5sJDd3G0C/CYzG0xKeu665weM5CyQ+dIn1DO+81zFApjKSm3yq9q+BCxadcgxEJ1okvTWr/OiKtbveEkwKhqTFtdN4M7bC7fVVteJmd9ogiapXgMxfDqRSv2t6BbOpke5QWyBpge3gm7TDBqezP1S6zGPAlz4+QYNvL5ZnOg37iddwWyrG3mUwNQgMEDBUQA7FszvepJPkRi519YqL0VnCTr5UJ40FSm2ARny17McIkcLJC9Sd1aIWqSC9WjXEFHcFTNEf3ujljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDziDMJIHLrLkO9bJX2+0jbWgndM4UPxcXl585Z7LS0=;
 b=t+Hk4KbjkTxlxbIIbo4i2gishz3uwE+N2E5zcEYyDJmcWpSoAQJoqvLDfaPeEjCJ6j8R9liKNPbYCtnKC720s/Au2IhGL7bnSaDN9otjcYPCXNspeDYen4KSjWbnozg4cSrpWXrtkMvk9RCUlZ/Jmq4+NcePqz7fUw+0V2crBTIfGziIAgDaGiJ6WdRSG6ahOmwv2THA8bNvaXTeRbIf0n95jrs5TCFGQKhlxxAw6KYiTrNMuo0v0zpfgeRKOXwfRcB5FkipUmmneoU2F9qWPyh8pxO1J7e0FNi9RpooPkJ1THxZf9gCJsJ3danGl9oxCDXXSdA5W8uER7tz6/WTyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Sat, 18 Apr
 2026 11:21:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.023; Sat, 18 Apr 2026
 11:21:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 18 Apr 2026 20:37:33 +0800
Subject: [PATCH 2/4] power: regulator: pfuze100: support high output
 voltage mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-pfuze100-v1-2-80d2a96dd927@nxp.com>
References: <20260418-pfuze100-v1-0-80d2a96dd927@nxp.com>
In-Reply-To: <20260418-pfuze100-v1-0-80d2a96dd927@nxp.com>
To: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df1b00a-6ca9-4be3-ff6b-08de9d3c994f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LmUywq7mWrFfwEfM8NtfVvMyZMhF4a33PvZ21ie1xUvE1FocuE/oGtCpn5EQwYbYk7K6UYr0e/lEriarpGq/t9ZguC8IRFfztMfazju/csJSBV4seljw5/kQtbtAH/s5sUev6d/V3WLEfeFN+sTnQ3Ps0hV/0zLD2x2VuYphLAykZvZWVylpCJbWIv9iHPnG8J9hzMP3fgwaAa7DDT3O4OqIObkCpqYZXsUNhF0XDlvpw3LEdCbR4mgvUC7bB7RZJkw5f03sJ0Hp1hf+gHYNpZTtDCqO70yy9dOI3zE4lOvHJtw5Zwd+EvMj5TaxUNZ4Bh75XZepQfbFeUqu88IPNCSkcI6E05qlqMP0gICMPoEnWt4dUOsLYKe6U4aAEVc4ZaMQgpjneJ7aPVIV3gi1Nw3Yb6Y9C90dg4D2ZtREoLC1bdOe5iIOvSTaQFYBtBsIfFJPw/RRWRg7f3ha2zrmaFlorxBemWYEqzo4yvgxrXb3OrtepXCVus70aKoVlywIx0fQxFIz41f+NQn+sHzvCAD7BmfBio5slRKnQAadTc3ja3CCqQLJCeSVs8mTYNDC51bpG8vLvd54MkDzoQ3e75lp4tq0KChPJoYnNhG4CrTGuS3l7BeIb+rn++y3st/7fTKhmGL0nAanmjZ4m0mRWOthsGV6dOptvBwYhQTfLYKicIqKEfMlejs58l9nN9v8OUBD0YV2Rz5RIxMa0IersYpNY7EYOriPF2fV/o6mG0AB5eWGcbgK35lU9iAqaNZeRfw4xjOUNZMEFEkNVevgKJNOOp8wFiFjj6LRZ2W8p0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M28wVUlDM1lmbVlkaHArbUVzaGs0QUR5VGlKZlVzcmwwd1dCeXRkY0lSVUtH?=
 =?utf-8?B?RzNSQ0lKNGlBTUJnZld3eHRJQzF5QmY1Y296dVVwWU5XNUowN0VoV1A5ZnZL?=
 =?utf-8?B?ZDJqMlhJRnc0bkVWSHRUS3c2by9OY0RQNzQ3cVRqSVhxZ2tPYXl0RmhRRnpz?=
 =?utf-8?B?L2R2ZU1GRXY3ZEJOMm04K0c2RHNDNURQeGc3Z1I2MEJaSTYxamozK3ZQU05C?=
 =?utf-8?B?WEpxOFZrVTY2WWVDSW16Q29YWUN2V3pFQW9vWlB1L3ZnSTFUbys1cDlaRldY?=
 =?utf-8?B?akhkZGtvMWNpeUlkK3JwRVo2MU83eEJTajF2ekdKL201eXdGdFdsRnZGS3dL?=
 =?utf-8?B?WUxwa2g3ZDFiRStrbmVqV0RRQ1VnTlFyNG5NVFBzS2xNWTNwQzg2Y2FBTmVp?=
 =?utf-8?B?WE9jL0xpMTdTNTRvRE4wejBEOUFCTWdVc0E5cUdrYVNJS3drbmtsT28wb1M2?=
 =?utf-8?B?UHdSYkQyendDK1dLWHNqZklhY21xNk5CU3lUbFpsS29RMk9pVmlka3VEbFdU?=
 =?utf-8?B?M2JjeVByUGJXcERUeUpmOFpPNGU5cEdNWVBjNUhZM0RGRHIxMnE2aUV4cUpZ?=
 =?utf-8?B?bnpHa0VyNUFpQzljQ3pLRmY1SEY2eWlmTk5DSFhiUzNmWUJWQzhzcTJDUkl6?=
 =?utf-8?B?ZDdITklzaEY0S3VyaFRhemtsc0RWRUxkNW9reGRXdEl0RWNJb2pnZ3RPL1c5?=
 =?utf-8?B?VFRhcFZWc00xd0NmNXJ3ZVJhSDFWaWhrZkg2L2ZtUC9aaFBraUswY3czdjBE?=
 =?utf-8?B?MS95U2thUHdEcHdaMWxSamhJMXNpZE9ldnlyZGU0S2tKSE5tc1YxNGtsMDBN?=
 =?utf-8?B?OE1GQWZ5cFZkaVhCZVFrUDU3S3hqUmFaVGh1WWJpV29aVHJ3M3lHc3N3akhD?=
 =?utf-8?B?TmprbjJtZm5FNnBscFdGeEZIeWh3WHZTRU9jUHFIdStZM3UyTVovWVlLRDNO?=
 =?utf-8?B?OVd4cUJac1l4K1ZGdHl1cVlYc1d6ZHBCWVB1MExTUXJJMDRIUGUwNjg4WUtZ?=
 =?utf-8?B?MmdTQ3BFTjFUMWxkZWZuZDRwUlVsWDBVOW9iR0IyeWJGbjllMjVzMjBWSTlP?=
 =?utf-8?B?YTlISmlJRlZpR1lyS3dRbWVINjVWaUxKK0lxUUpQaGIyaEJRaURyZ3hYVnM3?=
 =?utf-8?B?dFhCZWlRbnU3ZzUvLzRPYVg3NFBnQmp4Z1hTYkNqeXhHc2pUS3NnRDcwS1Fo?=
 =?utf-8?B?SnpaNEZnbFlhZzV2Yy91ZjVUSUFUNERXNm9PeEswckh4bVBOejRYR0JkUGFR?=
 =?utf-8?B?djlIVnZDMXlDQkZXNDFEYlRCb0hnaVk2SkxFRmtvVWdnUmUrdzRwK1JLbUxK?=
 =?utf-8?B?dUJOdjhKWnRQWWFFejdyY000OHZlMXhGV2p1MWJDYUtKamZpNFVSUGIxZTBC?=
 =?utf-8?B?d2Rwb3A2NFhvaDdhc0xQajh1b1VoQ284TGhlOHZ6aWF2WU0yNlNWM0g5L2JV?=
 =?utf-8?B?dGkzc1JEM2NHeW1qcUNaK3c1WCt3dEZtWHBJcVN0a0NPT2dJRDBsSWdpVTVI?=
 =?utf-8?B?dVpuQzdHZXFnN1d5VDlsRXVYWEorLy9teG9Ib1c4QjZYWXdiTW5Rb2NtQk94?=
 =?utf-8?B?THBXaEFBWVpFQk9VVGFCNlNnWm1XZkNtZHpsbGZzTUpSYnp1aTdDWFdacTZ5?=
 =?utf-8?B?bFJ4bzdldmRVbkVGZHRNbUtCdGdtZUZEM25BUXJsNlNWRnRUUmxJYWl5Sk1m?=
 =?utf-8?B?WG9wVUxXeWRKYm9oMHVWVS9pOWhlcTdQcHpTRCsydjA2MVFIbkFLVmY3WlBm?=
 =?utf-8?B?UENzQzFYL0NxbDYrWkxTQndnc3UwREtWMnJSODNTUWNxUEpkTXE4OW5scllE?=
 =?utf-8?B?Qm9NN1p6OHhjWnpRYldDajhWMzAwSmI1NUN4eWlOY2lkNnRBdjArcGpGRXhU?=
 =?utf-8?B?TjlvTTJ1Y04zK3JRV21KeENEU0dXTWVKb0RYOUZoVzVOeW1RTWxrdGFUMDJH?=
 =?utf-8?B?WS9kdDFYcXFXTFNlTmRrVC95UzVyWGFQNU8xNzVGTHZ5dXA1M3ZIYlBGc2pD?=
 =?utf-8?B?YzlFd1NPUXBTOERxZ1dnbXRaR1R4SVZoN2ttTkNCQVRLcnFnZldOVG1FSjBR?=
 =?utf-8?B?anBoY0NHYkQ3emFYVm1UTGtlTmVVOUk1MlNCR0tCR0pBWXFRM0hGaVlXem51?=
 =?utf-8?B?cld5YkczOCtDdTBaZVo0TEk4dCtteXZJdkJldmNPMWVQcTU5WkttUkxEa21G?=
 =?utf-8?B?NzhFQ1lNU202V0wvcUllTkdrTm4wbjVEVDVkd09KVVpSaDMzaElTSUJqSFVW?=
 =?utf-8?B?YUQvSkgxM2RHa2M1M2lQU1BBRGgxdFFvNkZJNXMyd1poVlg3QUVpb252cHhr?=
 =?utf-8?B?WUtibGZBNGpYTnBQT2YyOU1sbk5iaU1PMXFab2VTdkk3NFVTNEoyQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df1b00a-6ca9-4be3-ff6b-08de9d3c994f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 11:21:13.0097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jljK/fCIJ0xI/Prm+Red9Dj9s816V3HR8mogz3RgAyLtPCbb2oD/OxqPCitA6ykd4V7sVIjR+j47auJNt0jNuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10756
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

Some PFUZE regulators can operate in either low or high output voltage mode,
with different minimum voltages and voltage step sizes selected by a hardware
control bit. However, the current PFUZE100 regulator driver assumes low output
voltage mode only, resulting in incorrect voltage calculation and programming
when high voltage mode is enabled.

Extend the regulator descriptor to describe high output voltage mode by adding
a mask to detect the mode and a dedicated voltage description (min_uV and
step size). Update voltage get/set handling to dynamically select the correct
voltage parameters based on the high voltage mode bit.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/pfuze100.c | 62 ++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index f055c610ad1..ed69e6e14c3 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -13,6 +13,11 @@
 #include <power/regulator.h>
 #include <power/pfuze100_pmic.h>
 
+struct pfuze100_high_volt_desc {
+	unsigned int uV_step;
+	unsigned int min_uV;
+};
+
 /**
  * struct pfuze100_regulator_desc - regulator descriptor
  *
@@ -26,6 +31,8 @@
  * @stby_mask: Mask bit for setting regulator voltage for standby.
  * @volt_table: Voltage mapping table (if table based mapping).
  * @voltage: Current voltage for REGULATOR_TYPE_FIXED type regulator.
+ * @high_volt_mask: Low or High Output voltage mode mask
+ * @high_volt_desc: High Output voltage description
  */
 struct pfuze100_regulator_desc {
 	char *name;
@@ -38,6 +45,8 @@ struct pfuze100_regulator_desc {
 	unsigned int stby_mask;
 	unsigned int *volt_table;
 	unsigned int voltage;
+	unsigned int high_volt_mask;
+	struct pfuze100_high_volt_desc *high_volt_desc;
 };
 
 /**
@@ -56,7 +65,7 @@ struct pfuze100_regulator_plat {
 		.voltage	=	(vol),				\
 	}
 
-#define PFUZE100_SW_REG(_name, base, step, min)				\
+#define PFUZE100_SW_REG(_name, base, step, min, desc, mask)		\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
@@ -66,6 +75,8 @@ struct pfuze100_regulator_plat {
 		.vsel_mask	=	0x3F,				\
 		.stby_reg	=	(base) + PFUZE100_STBY_OFFSET,	\
 		.stby_mask	=	0x3F,				\
+		.high_volt_desc	=	(desc),				\
+		.high_volt_mask	=	(mask),				\
 	}
 
 #define PFUZE100_SWB_REG(_name, base, mask, step, voltages)		\
@@ -162,14 +173,19 @@ static unsigned int pfuze3000_sw2lo[] = {
 	1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000
 };
 
+static struct pfuze100_high_volt_desc high_desc = {
+	.min_uV = 800000,
+	.uV_step = 50000,
+};
+
 /* PFUZE100 */
 static struct pfuze100_regulator_desc pfuze100_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, 300000),
-	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000, 300000),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000),
-	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000, 400000),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, 300000, NULL, 0),
+	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000, 300000, NULL, 0),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000, &high_desc, BIT(6)),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000, &high_desc, BIT(6)),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000, &high_desc, BIT(6)),
+	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000, 400000, &high_desc, BIT(6)),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
@@ -183,10 +199,10 @@ static struct pfuze100_regulator_desc pfuze100_regulators[] = {
 
 /* PFUZE200 */
 static struct pfuze100_regulator_desc pfuze200_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, 300000),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, 300000, NULL, 0),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000, &high_desc, BIT(6)),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000, &high_desc, BIT(6)),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000, &high_desc, BIT(6)),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
@@ -443,7 +459,7 @@ static int pfuze100_regulator_enable(struct udevice *dev, int op, bool *enable)
 static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 {
 	int i;
-	int val, min_uV;
+	int val, min_uV, uV_step;
 	struct pfuze100_regulator_plat *plat = dev_get_plat(dev);
 	struct pfuze100_regulator_desc *desc = plat->desc;
 	struct dm_regulator_uclass_plat *uc_pdata =
@@ -467,9 +483,15 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 			val = pmic_reg_read(dev->parent, desc->vsel_reg);
 			if (val < 0)
 				return val;
+			if (desc->high_volt_mask && (val & desc->high_volt_mask)) {
+				min_uV = desc->high_volt_desc->min_uV;
+				uV_step = desc->high_volt_desc->uV_step;
+			} else {
+				min_uV = desc->min_uV ?: uc_pdata->min_uV;
+				uV_step = desc->uV_step;
+			}
 			val &= desc->vsel_mask;
-			min_uV = desc->min_uV ?: uc_pdata->min_uV;
-			*uV = min_uV + (int)val * desc->uV_step;
+			*uV = min_uV + (int)val * uV_step;
 		}
 
 		return 0;
@@ -495,10 +517,18 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 			debug("Need to provide min_uV in dts.\n");
 			return -EINVAL;
 		}
-		min_uV = desc->min_uV ?: uc_pdata->min_uV;
+		val = pmic_reg_read(dev->parent, desc->vsel_reg);
+		if (desc->high_volt_mask && (val & desc->high_volt_mask)) {
+			min_uV = desc->high_volt_desc->min_uV;
+			uV_step = desc->high_volt_desc->uV_step;
+		} else {
+			min_uV = desc->min_uV ?: uc_pdata->min_uV;
+			uV_step = desc->uV_step;
+		}
+
 		return pmic_clrsetbits(dev->parent, desc->vsel_reg,
 				       desc->vsel_mask,
-				       (*uV - min_uV) / desc->uV_step);
+				       (*uV - min_uV) / uV_step);
 	}
 
 	return 0;

-- 
2.51.0

