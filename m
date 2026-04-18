Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6779F99C79
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 11:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2930F842BF;
	Sat, 18 Apr 2026 13:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ud4Y4aoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 002CB8405A; Sat, 18 Apr 2026 13:21:23 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF7584258
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 13:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUqcrD+EUhd6nnTl/GcsPTYpFTFnhuZmTyi6jfMXO61AkdYunk480pgUsR39szVzCD+4jAckoBKwYn6gaLwP+gJsOu91jBj+9+XPzSB1+wct3NQA9v7AR2lQEez07d7oQAdlG7tNOezByzP8OXH0yF6MXFHMmvmdcJ4Bafpv1AsSqdv99XxSFB4GzStabbO1Lq9Cstb7e1FoLtF+wKNVzQpBdoyVGjzJ5nHnp3pDm1tJGKHCgZM22VNr5ktusKHeTRRCtdpwCkoAXu7miea0F+M1r1h2PIlv1zNjLP0EPqzfuOM3e1p4xhe/TfFDnx2HECPHmNm7BFItLUkder6pDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gkdujsEgUnJkEyJl2ki2cBukDScRa72vmjNU2uMOAo=;
 b=ovdHnojYK19+JcMjQTRJfgfUBUiRfNCA8yxzjBP+kEk47d/s+3t/T3dUD4Xz8lS5a2mvVBW65Yxcw3rwXUL83qqB/qPYerLmLOIqq6f67crBiiXAO/fz64MPtA3FF9vUd6g+QCCOUzXY1zBX/q17qxC3g1VUcPbxzxeyAvYUGQXlNFy9mfq78OFqx5umZOnsnYzAAaga/9GqDsfRRP5V4xRmCfGwmf9JYU6u2eA5UVUr2V4rown1SoDTpf8V5oxIJ8ChIqSoVuq7MeEJzqFrUzudUqjk4qUku7h1WaSRHoBx2//Jy4R6rp66IrnwTK7+BtPDmBwY0rCK4EuiSIxEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gkdujsEgUnJkEyJl2ki2cBukDScRa72vmjNU2uMOAo=;
 b=Ud4Y4aoJfmCT2Mo/j0ca90raTttPN6FV0ebzCuSeeJwVQF2C1TxAc0IyjoEQVLjdjymmOxBUuxLyyset7T2KKbyb5kYZwv+He+AnQURrbmIRTX4MGHhRGhu/XFUb6H4oGr7R2zYrFw7YwMz9An4TnNrzthbROmiJpsZ3m02SMTn5uNhIJBWBEyzMCP8OoD6zMrct7V679oqSu1+eUxvULiac+BaQ5WRqgbRB4IaLXQlw//VRDPo3o3LuieRUzpbUK8ki6q28UDExsjC4KS8gJ3IaSBAw3Fazcg5Br+Qf0cEKAwayaX8lvqtAf+zaP1hifG3h4a1RdWcGB9fDTIjS9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Sat, 18 Apr
 2026 11:21:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.023; Sat, 18 Apr 2026
 11:21:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 18 Apr 2026 20:37:35 +0800
Subject: [PATCH 4/4] power: regulator: Correct Kconfig for PFUZE100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-pfuze100-v1-4-80d2a96dd927@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4751b963-f027-413e-13d7-08de9d3c9be3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zSSFb0P6Ko53BYoUAxBnYtucE3ANeJljNIBm2TWQ5sXfeN1PDHvqJCfcxcabPibfKpBclztkxJBaldLz22FjHjqfU7Sh/jALPuMDHpbluB/C6lTv0zIzAUkZnJiU5gc9r88MT7o1hNLG1myhtM9I5+qd/VYRjwyF/omWOHqOYQU48V+OPMYhyEcVA29Mqp1NfQz+jdMzH9HhENQkSab60rq3PMQPB/LPM2yBOiDK/TS+N3qNp/MXadbyh6EMTDTvhBJgZgtst/C1uY74dS4EdF9ge3yM4bUjXHO0Xye81whKefe3b1LedI/zUq9oJlqBuw0DC59RtawkSyzMGAeOos6bxJ42NtdtJykwv5q2+NMZB+KGdwyAFcbCZGBnAsDdh1tTTuZlWys+G+aLxPTLzInct304Q/SNoc5dmH/Al8BJFI0whY4YI1hx++gShWvGfGjdQUbNmHi/yMNs2wSja9X5392T2KapjdNRNq2XY2d8Re4+XczcUMOExq1HvuTtH6+mPxFN/eJeCM3sdLsamVLlO6gJ1wa4AQRwZ6EThGXTlhzI7jh9hRZ+6ffsWIVIUfyi4ft+63C8FaEXlBr5IkDRTldlQLV2V6n/rWM6qoYgTlLxmYwOFKFvdMoe0gai9KiT6ad81hL10T28hIetpLkOXNIp1sjlKro72jsq9vk5ZWXuS4pg9QjR7YFO4aX8qFM2YJNp4MK3u8BbYzXGMSGemBKaU40+jAYqDgrXiWQKhKHiHzKrvgOodXq9CuLs5km8E9toop4iyt+YTzEoJEBuNu2dc0fbOtzbLvceZ28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhHMDQ1WlNlS2VSOTVpYUM2TXpaTEJYYm4ySWJJb3E4NVZVbGFrSktjWm5u?=
 =?utf-8?B?V0dqc2RiNitrKzFYSDRQaU5yWWE3Q0FibGp4Y3R6cUg5Y29jZ285YW44Vld4?=
 =?utf-8?B?RUQrZkZCcVZvb0ZmczQ2Q3kxUFIzV2dwbzlNOWhaSXUwWVRiaWF3VFJrbDQz?=
 =?utf-8?B?dTN6b0M1YWszOTEvUncxTlRZbkJIWUZDdWt6TEg3TlloNFo5aTVTN3dMdUpu?=
 =?utf-8?B?cXVVZ3NOak11dGtmQllJL2kvMHQ3djNzZjdacGc1Unc3VEdReTdKKzZzeEZH?=
 =?utf-8?B?cUIwZDgwOEpzdFpHUVBYbUlMUVBhdGNTVlIxc0pZRWo3WDg1L0plTXJhbjBF?=
 =?utf-8?B?Wi9lYklRb2JJbm15YTVJUlY3OFg1SEl2Vkc0WFdxT09OcnRsYjkva1Rpa011?=
 =?utf-8?B?YWpZODhRdXlWVzNMalhtS3RSaFlqM1RSOUFnMk9RekhTNXVyTXdNZGYzbklB?=
 =?utf-8?B?TE0xN3NMZlVaT1d6N3NuM2pWZUlEOTZUeGRlT2d6YW1DamQ5dzF5N1BJNVJM?=
 =?utf-8?B?SjNxVFBoWlBCRVpVNHk0bzY3T09Pd3JodFczOFgvV2ZDNWNldXl4RHJZOHpt?=
 =?utf-8?B?SlU2M0dwVDJhaWlzZCtjNVFPYk9DR1RJTmFGcGVNTWx1L0ZiYXhoOXpNUkV1?=
 =?utf-8?B?cUN5bmZUd1Bna2Z1QU5WRFNPMk9RUGNCSmxQbFFuUjBQT0MxS0tHNXlNL3RP?=
 =?utf-8?B?UEl2VlBkdWJWTGlxRysreUZrYlVrMGwxSDRXVW50ZG9NcHhyRGVhbnA3ZEJp?=
 =?utf-8?B?aVVsc3dBQmJadVA0SWFiamJJQVFnZ3VodGFOajdiOTFEVlhvYUkwQTk1MEhj?=
 =?utf-8?B?cXV6cU1tbzVLOVhCUTdOSGdQazZydVZCdTFFQjFubU50WEU2eUFkMWtBcloz?=
 =?utf-8?B?MnNrdER2MTN6SW4vaEJKZEVxbkQvYmQ0VXZkVVIzQ1pvRmdxN01TZitjVHNK?=
 =?utf-8?B?STd3ZFJRUElGT2hQQ01hdDVoRGxOc3ErZC8veGxUbjQ0amhGcFVQc2JycnZV?=
 =?utf-8?B?YWg4RGJPSmNpNlo0bnBkZm5LeXFwZ3U4N00xS1lVL0dQcExXejFOY01ac2VR?=
 =?utf-8?B?Znh5WlVGci9kbm1oNktTUVphMXR3VDRUbFlGaWQyZE8rem53bSs4ZDB4TUgx?=
 =?utf-8?B?OXdOS3N2ekhNcHJVSllJSUdsT0xkcnI3SXhtTDV5WUF2OUxmUmpXN0hzcGho?=
 =?utf-8?B?MHk3alZJRTdQTHEreWVEaG5IVSt1bm5WRTJrM2JNVExtZ0ViRDdzZWJENDRx?=
 =?utf-8?B?SEJMS1VJQmhNZitlZkdtOEczc2JobmZRcHp0UWRiRVcxM1RzbitpMlhTTjlQ?=
 =?utf-8?B?V0VoUmUzb3NBZzEzS1ZMN2NBOTVJZGtOT0Q0TkdIQ1VsVzVLNThYb3lUMkN5?=
 =?utf-8?B?YndtTDFXbXdYU21FalkwdUlNWEwvVWhVdDJBc3k0UnQxck9VQXZUdmZuY2FT?=
 =?utf-8?B?WnFKSy9UOEViMHZMZWJ0N1N4bWxXTkZjeTNya2MvWnJlT0h0dlNDVCtaYktt?=
 =?utf-8?B?ZGVreTFoQ0Vybm5lU1RaR1dyY1RlNHZkOUZIQnpYT1Vuay9PQjN4S0tYTll0?=
 =?utf-8?B?OEdyK2xXNjNCMFBiYTExakNPcmRQL2lqa1FmeG1NSFcwbTRZRmI0bDdrR01k?=
 =?utf-8?B?SnRtUEVLVzRUdHZ2UGtrR3dLMDB3T0RtSnhnRnhBSWxqd3NJNHdFV0hNQXoy?=
 =?utf-8?B?T1JMRVRNZjhNWWl5c3hSMkVxRFFrMGhPWWhHY1ZxZzIycmJOaURIWDg0N044?=
 =?utf-8?B?UzNvcktwdjJZVFp1OGltc2FkQnVuZHJwZlFsU2xKYlV2aE1WbXZkN0dLdnFQ?=
 =?utf-8?B?SXZNTjFVSElOQWtUQ3RFcEZNL2FBbUhDV2tNaVZMQTFxRFR3dCs0bERxa2FJ?=
 =?utf-8?B?bFhIVnNvK0NLM01NdTUzZWJrZlptdHVkdnl2OTZvV3h4N1ptaFhYeVNldDhT?=
 =?utf-8?B?NVJSMzVmeWk2ZHVqS3hTMUkxWlJWT0lIZ09kZUhzZzNyeE5zaldZU2hSbjJE?=
 =?utf-8?B?d24rbUIwOTdobUtpd0NRTVA2NFJLOTJZNmxISDdVUENpK3ZjbEpCYnlKT3la?=
 =?utf-8?B?Vys4d1FkbU5aS2ZuRFBrYXVRRmtIcGhmVFk4cmRzR1FJaDZ4T2Npd001Z1lJ?=
 =?utf-8?B?WFBiMXlPQUwzbGZCZzM1alBlSVNpZnEwVHJ1bXVKYkFEd3JyR3dMbTVTVmVx?=
 =?utf-8?B?dW02Uy83UGlaN2I3R0pPNnd6MzJtV0lZaHNCY2xwb2dlc3RXQS9aV2o4OTFI?=
 =?utf-8?B?TGdiVkN1dUhSREduWTI1bHJFTXNNMlNRWEgyRkkzMnJBZjkzR1hYRTlPaENo?=
 =?utf-8?B?bS9LcEdZUEJDQWNNYkRrNm82aFBGL2RQMGwvclphUk44TXAwWnZqZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4751b963-f027-413e-13d7-08de9d3c9be3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 11:21:17.3503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kmd5qYddKETPEWbIpshSTzA9gItC0VubdLvXvzcuw7ZH7hqXTJLKZfbAjKTcMnY60ALedIXGXbjzfVhYPNK9VA==
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

Use CONFIG_$(PHASE_)DM_REGULATOR_PFUZE100 as the build condition for
pfuze100 regulator driver.
Add Kconfig option for SPL_DM_REGULATOR_PFUZE100.
To avoid break current platforms, set the Kconfig default value same
as PMIC_PFUZE100.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/Kconfig  | 10 ++++++++++
 drivers/power/regulator/Makefile |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index a4ee5f1335a..ca5de5b8726 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -126,6 +126,16 @@ config SPL_DM_REGULATOR_DA9063
 config DM_REGULATOR_PFUZE100
 	bool "Enable Driver Model for REGULATOR PFUZE100"
 	depends on DM_REGULATOR && DM_PMIC_PFUZE100
+	default DM_PMIC_PFUZE100
+	---help---
+	This config enables implementation of driver-model regulator uclass
+	features for REGULATOR PFUZE100. The driver implements get/set api for:
+	value, enable and mode.
+
+config SPL_DM_REGULATOR_PFUZE100
+	bool "Enable Driver Model for REGULATOR PFUZE100 in SPL"
+	depends on SPL_DM_REGULATOR && SPL_DM_PMIC_PFUZE100
+	default SPL_DM_PMIC_PFUZE100
 	---help---
 	This config enables implementation of driver-model regulator uclass
 	features for REGULATOR PFUZE100. The driver implements get/set api for:
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 9e303d4f7f8..36a84e7cd71 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX77663) += max77663_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX8907) += max8907_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
-obj-$(CONFIG_$(PHASE_)DM_PMIC_PFUZE100) += pfuze100.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_BD71837) += bd71837.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PCA9450) += pca9450.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_PWM) += pwm_regulator.o

-- 
2.51.0

