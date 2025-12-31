Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F655EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 12:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58CD384035;
	Wed, 31 Dec 2025 13:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="WT02qE61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D65D83F6D; Wed, 31 Dec 2025 13:33:36 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn190110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57EB84027
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 13:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIoIIOpPWGf+1uvM9za9o2Z7SjsMxDde8QAOIb8sc5iBI3jaVLRQMj9ovB1jeJ0SE5+fbMo+oLBniCf58IB8aXbOu9tGWFTpysUb43dMS4+MSUnLkFKkOJ7HR2/eMukUUsGTvij3d6+AApQIyrrlTcltscLVpzWyxS7OTNeBCaqh1FsDRqFhVaw77uVndGSohDl2VZ6+ApNOmXR5A2zDNZv3n3fBjncCRviEbf1a1/HFNTXAsREVgLM9wioKt/xNW0ECXqX4udzZtgXJ9b35C611rpfEmg5FiSOlxmaO3GkB5w2Ylx8bVYDomtjbBLSX9ZkmZ9ASenFKg+HnA+1tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vukzwjW6rpcbXGdYOA2x9lw3n1ljaE6Tz6AJSDCXiI=;
 b=Gd/wauHStHprHS0MBd+xhUKBMiA6XUfOdcK+uT9je8od4EGUp0xqAMt8Qczlm5Mrm2W7VNu/0TAMw9cgumTEDHlFTBpRZgoMlm3Ho1lug5OraqsnFAw6+1kJEQHvvuSDZOvz2Gz1DT37JaUWfJNSOi+5vMUv9bG2yt3DDi28XJF495yNtFD+O5KdCo7NwOSIVWCQKmKUUjdmUdMvsUtm1XlKdaidXOvPI9X2wNf6c88js5LVldvr+mg+GOowIWZKH8gYUrQ8fEgvCHfIMyjQ/jlzv65vYV1q09uVY3pTNWwHAjXw3QsAT8/2G4RjdJTd06vvfw12k/e2gli/0OG68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vukzwjW6rpcbXGdYOA2x9lw3n1ljaE6Tz6AJSDCXiI=;
 b=WT02qE61WGa9dKjyYF+bQwwggaEv2CKjR/hI8iPnOV9SyWiYncppOLuNYFko3TvEL1XBznCUz2Ij/duGsEWccV5Swt9ZN7o7+/ty/xzt6WSjCWor1FeOHgOIia0Xq7Iv+ZLd2yCdX5SkV/NvHCcdyiwFNishVDzxmeMCBW1gD2BiXD51DW7K44AnNnBw2ZlWjYcNeR1pxsV0Kwyme1O7jPcszAEfzNUNvSZ6OhzaDE58wWU+3jMUigM/DdWbthOKbXtuMpU/05zpzfxpRoykhqCohO1kK2yRjUf86lBp/RJ17FSs1Ff2rjpySplfkTisFSGrGHZrX1eiQlakjBdthA==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by OSAPR01MB7303.jpnprd01.prod.outlook.com
 (2603:1096:604:140::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 12:33:28 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 12:33:28 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/2] mtd: spi: simplify the conditional compilation of
 quad_enable feature
Date: Wed, 31 Dec 2025 20:32:32 +0800
Message-ID: <OS7PR01MB13834E7A59ADC3EE1E21C41B4BCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <OS7PR01MB13834542EA65B2EEC830EE37CBCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
References: <OS7PR01MB13834542EA65B2EEC830EE37CBCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251231123234.1323171-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|OSAPR01MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: c959211d-d0b7-4ba7-acf6-08de4868cc83
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|15080799012|51005399006|461199028|41001999006|23021999003|19110799012|5072599009|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pklFd/+3qUGTigTzIFwVRkt1gf7Epr5ZIUXEHc/d312qTn5d9h8B1tqfaX+L?=
 =?us-ascii?Q?eumcQKM3eD6yaSwjyLHRN8U5ZZYqjd35eP2JcIPIcoAv+BsqmoMN+EbLT8NX?=
 =?us-ascii?Q?RzVNaTJSUkNKp7cO5eyEN0498z18enE4hc3ASdbfsESfRoNEpvljm0RK7v3p?=
 =?us-ascii?Q?AuBWEjETCZz+H3C4yq7Rmfvk0axbeySKYwFIe5u+uulJoxk8P+lB2G30fE7/?=
 =?us-ascii?Q?cK81Z19IQG4xjmJR2abnMAHGIBfgQlLSez2nOeseKsdugB+HehIDBCWFuZaj?=
 =?us-ascii?Q?Vm4BltiGz3aQU+0WkkACW6g0BgLbV+/+RNygMiMJOt0A0zh2H3Dtl2diPYKH?=
 =?us-ascii?Q?5S3zE48UN/Y2mAnEOkbNhHlIYs+a0HrT3K9YIvllWjVe/Ccs711y3vhBzUXL?=
 =?us-ascii?Q?aiD1BJd3v6C3E/om/1OLN4TZqZ0/7T5h4ijyBBX7DIGURjaElB4CW5QJ91/h?=
 =?us-ascii?Q?4IPWIpsQAm22XzFHg679YJbOiFg3U0PxUDXtuFgQpLfj1w4arpYamH3lzdhx?=
 =?us-ascii?Q?regGHJhChB5M1QYKMRA33sp9sU/e6fusRypZmrwNquk6RLjDq6J/Ky2MWGaF?=
 =?us-ascii?Q?1bmMprjkDz+zZo/DCcFNIBn89CV+erSrhyk6x4DJc2nByOroAN1S1FTZa72F?=
 =?us-ascii?Q?VqvsE6B5Sn5oVeOehVWNbcnaUcgf2Xif1cGfHx5N+SVYCl+aLrTOyOjQv1fS?=
 =?us-ascii?Q?sPaHUpabv+C+YWvR5N8dOvv6vVplgC3R+r7XaUoM6xyKndsMkD1IFCTe+gje?=
 =?us-ascii?Q?ZEk+pd5cGOzlvT7F/LqmMCfyqY59k2D4nMX7TGeCcBYXaa6aBMsgHMRW00VZ?=
 =?us-ascii?Q?b5eLIK4cQmVUfu4HE57sh7jHgv/QLUMFqYk/o8ybgY3ccGs9KC5n+/LcP2GA?=
 =?us-ascii?Q?BozXUpqsBZWp/ooP5t4eCsytDs7FX+MJiijwuMp68c/rkHuNfBi3RCOrnsJD?=
 =?us-ascii?Q?s/Wxv1IU21QKyrf2mogBQNHmTeNAZVc824LI2iVBK4ZvLzMpvdL0kG14AffQ?=
 =?us-ascii?Q?c1sYnfgYWJnPDVEjsI8G9ksJo3tVjR273/jH3ivae/7h3mHou9DD56tgkMbx?=
 =?us-ascii?Q?s2nhobNl3DB5tlJgJ58irNbiKYJyxt3BwDzM63gyajegRw7Mts80gwLwucYM?=
 =?us-ascii?Q?Xm70a0BlONYsrGqQjlP+Rl7cB08/50QqEzMH9CnbR2T69Gdo1sRDhVH76L1n?=
 =?us-ascii?Q?dliFuqQsP4NksTHSebggj0bUWDg6DkRkyUvvTUCm7nL9NwfqSqDucfVhjrA?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JSyU//FujQfyyHlYubLc7c1UgteTG5gfTHK8PGr0sfwnYkmyY1dIdV3R0YJ2?=
 =?us-ascii?Q?FVNQeL+U4ke+Z/Uw2k9bJx1KfMJVj+vgjeqSLu0S04+6f9zRDz9WFGihFoxQ?=
 =?us-ascii?Q?o80yVJk2qmltT4nN6WyJo9ml7gYD+95ExEmkfnnTYWNQz8iOJbaNkKiAxWk6?=
 =?us-ascii?Q?X86kZ0vIvOnmAAL950h6BoZ+kw+aJhfn91Fu+jEv8rslTzSPP0JfqTe01gIy?=
 =?us-ascii?Q?8fFdh5lpOJ33p8gVs07nydwVR9HlXtvDKpgCV1gxuODgOQlvDGRFO3v6GjpJ?=
 =?us-ascii?Q?2fVu9L5LogYZRDyC0Mdk5Rf5Q2aAOFXdh/DN3xOAnmG6CU2zha1zrwiRrNOT?=
 =?us-ascii?Q?vDpBxu/bIKIh3L+K1vlmRI2E1bOgWUiFgMPKsXyM6JoRfv6zqHlkGlA1AsAY?=
 =?us-ascii?Q?tsMVmV+hqIc5BlNMStAX0O+O9su402uV6g1mUGGL3Xd60JDsTiA2juXwtjcf?=
 =?us-ascii?Q?7mpWjeAss8MAoZFQ+xfn9aKBXJXHgO0WlsgJQarSXQjFvZWI/GcEdF86ll6G?=
 =?us-ascii?Q?KjPSQfcPTPekrM+sE7MK6yHwss2POMS7gr1RtAZjoXCqET/svSW9ogdk64nB?=
 =?us-ascii?Q?Eqki939QvduIucJcp0Zp6lJigH5vBpW546i3z59nGceenDcUT405MWAvN//M?=
 =?us-ascii?Q?hddVJxq/fEJCIBpuyuRpT4i/1nVWJ0JNq0nAhqjD078+rizoL2KJIPzIAU8/?=
 =?us-ascii?Q?aY24skL7AVIF9VnFwhHfp7Fh+EZNPdDzkOQFo1+2HcsWnqqfrU+f0XYGkp8A?=
 =?us-ascii?Q?5sqnoFgIeLqLVjfOBpQyn0+kZQf8y4CzE+/G0thp/0SKZUWub1dkDKx+p7Mc?=
 =?us-ascii?Q?B2SG0CisjM5+ESI5TDVG6SEmEgWP/RJ1/NOevj7fWwUPdnDwCBvB98dVTRi3?=
 =?us-ascii?Q?dJS27rssvkOBFOZPV+epfTe2oWKXQSh1Hzpt3QxZMjHaYsRpD5Lu2X6tVpgq?=
 =?us-ascii?Q?/YdWfqcillbhYp/j5Lg91N5JQAUidndo9v6QuTNJ1kz9nMOHt+vEiwhktieq?=
 =?us-ascii?Q?uUTfrqSuUiBC60E8JKku6B1rmvfWcgxCcUZVUYtPmawTV32G5n3iwK+a1UqR?=
 =?us-ascii?Q?N51XO4/Rs2BsiNsatAbXonYlc8gQ8y9Ox+sYFXD9OpFIQFKKY6T/y0YCmypy?=
 =?us-ascii?Q?DgidrU+kGWh1qkufX96W05grAVudmo9cqJF2bWd2/7iNIlgMRVfeTO9Lgt59?=
 =?us-ascii?Q?UyRx//9r/B7bjyvug8qESD8ZQlDVnwnn5Tw9gOUJFICRFpe7nMQoDMGQy0yd?=
 =?us-ascii?Q?YMsSidwWasRqtpFkDICjTMbagp8nkYpvX7wzr4lj2FkO9tfcd8JmP99co84h?=
 =?us-ascii?Q?nmvzfzpv7Yl3Fucxad6Jnm7yDZRb+P24zdi/hoGCArLFt2BM2cpGGNHi15MR?=
 =?us-ascii?Q?RC8hTVokBtEbYEH0Ndm9VCxM+WbT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c959211d-d0b7-4ba7-acf6-08de4868cc83
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 12:33:28.2520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7303
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

Introduce new SNOR_SR1_BIT6_QUAD_ENABLE and SNOR_SR2_BIT1_QUAD_ENABLE
macro definitions to guard the quad_enable codes. This can make the
review easier. It's also a preparation for introducing the new Flash
vendor BoyaMicro.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/mtd/spi/spi-nor-core.c | 28 +++++++++++++++++++---------
 drivers/mtd/spi/spi-nor-tiny.c | 27 +++++++++++++++++----------
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 76c33b24368..5fa7ba27ae5 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -188,6 +188,16 @@ struct sfdp_header {
 /* Status, Control and Configuration Register Map(SCCR) */
 #define SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE      BIT(31)
 
+#if IS_ENABLED(CONFIG_SPI_FLASH_ISSI) || \
+    IS_ENABLED(CONFIG_SPI_FLASH_MACRONIX)
+#define SNOR_SR1_BIT6_QUAD_ENABLE
+#endif
+
+#if IS_ENABLED(CONFIG_SPI_FLASH_SPANSION) || \
+    IS_ENABLED(CONFIG_SPI_FLASH_WINBOND)
+#define SNOR_SR2_BIT1_QUAD_ENABLE
+#endif
+
 struct sfdp_bfpt {
 	u32	dwords[BFPT_DWORD_MAX];
 };
@@ -578,7 +588,7 @@ static int read_fsr(struct spi_nor *nor)
  * location. Return the configuration register value.
  * Returns negative if error occurred.
  */
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 static int read_cr(struct spi_nor *nor)
 {
 	int ret;
@@ -2110,7 +2120,7 @@ write_err:
 	return ret;
 }
 
-#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
+#ifdef SNOR_SR1_BIT6_QUAD_ENABLE
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -2204,7 +2214,7 @@ static int spansion_quad_enable_volatile(struct spi_nor *nor, u32 addr_base,
 }
 #endif
 
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 /*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
@@ -2319,7 +2329,7 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
 }
 
 #endif /* CONFIG_SPI_FLASH_SFDP_SUPPORT */
-#endif /* CONFIG_SPI_FLASH_SPANSION */
+#endif /* SNOR_SR2_BIT1_QUAD_ENABLE */
 
 static void
 spi_nor_set_read_settings(struct spi_nor_read_command *read,
@@ -2710,18 +2720,18 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	case BFPT_DWORD15_QER_NONE:
 		params->quad_enable = NULL;
 		break;
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
 	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
 		params->quad_enable = spansion_no_read_cr_quad_enable;
 		break;
 #endif
-#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
+#ifdef SNOR_SR1_BIT6_QUAD_ENABLE
 	case BFPT_DWORD15_QER_SR1_BIT6:
 		params->quad_enable = macronix_quad_enable;
 		break;
 #endif
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 	case BFPT_DWORD15_QER_SR2_BIT1:
 		params->quad_enable = spansion_read_cr_quad_enable;
 		break;
@@ -3155,7 +3165,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	if (params->hwcaps.mask & (SNOR_HWCAPS_READ_QUAD |
 				   SNOR_HWCAPS_PP_QUAD)) {
 		switch (JEDEC_MFR(info)) {
-#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
+#ifdef SNOR_SR1_BIT6_QUAD_ENABLE
 		case SNOR_MFR_MACRONIX:
 		case SNOR_MFR_ISSI:
 			params->quad_enable = macronix_quad_enable;
@@ -3166,7 +3176,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			break;
 
 		default:
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 			/* Kept only for backward compatibility purpose. */
 			params->quad_enable = spansion_read_cr_quad_enable;
 #endif
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index 23de64a1520..dde290ca6a4 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -36,6 +36,15 @@
 
 #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
 
+#if IS_ENABLED(CONFIG_SPI_FLASH_MACRONIX)
+#define SNOR_SR1_BIT6_QUAD_ENABLE
+#endif
+
+#if IS_ENABLED(CONFIG_SPI_FLASH_SPANSION) || \
+    IS_ENABLED(CONFIG_SPI_FLASH_WINBOND)
+#define SNOR_SR2_BIT1_QUAD_ENABLE
+#endif
+
 static int spi_nor_read_write_reg(struct spi_nor *nor, struct spi_mem_op
 		*op, void *buf)
 {
@@ -120,7 +129,7 @@ static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 	return len;
 }
 
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 /*
  * Read configuration register, returning its value in the
  * location. Return the configuration register value.
@@ -253,9 +262,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 	}
 }
 
-#if defined(CONFIG_SPI_FLASH_SPANSION) ||	\
-	defined(CONFIG_SPI_FLASH_WINBOND) ||	\
-	defined(CONFIG_SPI_FLASH_MACRONIX)
+#if defined(SNOR_SR1_BIT6_QUAD_ENABLE) || defined(SNOR_SR2_BIT1_QUAD_ENABLE)
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -356,7 +363,7 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor)
 	return spi_nor_wait_till_ready_with_timeout(nor,
 						    DEFAULT_READY_WAIT_JIFFIES);
 }
-#endif /* CONFIG_SPI_FLASH_SPANSION */
+#endif
 
 /*
  * Erase an address range on the nor chip.  The address range may extend
@@ -433,7 +440,7 @@ static int spi_nor_write_tiny(struct mtd_info *mtd, loff_t to, size_t len,
 	return -ENOTSUPP;
 }
 
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#ifdef SNOR_SR1_BIT6_QUAD_ENABLE
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -472,7 +479,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
 }
 #endif
 
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 /*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
@@ -554,7 +561,7 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
 
 	return 0;
 }
-#endif /* CONFIG_SPI_FLASH_SPANSION */
+#endif /* SNOR_SR2_BIT1_QUAD_ENABLE */
 
 static void
 spi_nor_set_read_settings(struct spi_nor_read_command *read,
@@ -662,7 +669,7 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	/* Enable Quad I/O if needed. */
 	if (spi_nor_get_protocol_width(nor->read_proto) == 4) {
 		switch (JEDEC_MFR(info)) {
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#ifdef SNOR_SR1_BIT6_QUAD_ENABLE
 		case SNOR_MFR_MACRONIX:
 			err = macronix_quad_enable(nor);
 			break;
@@ -672,7 +679,7 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 			break;
 
 		default:
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#ifdef SNOR_SR2_BIT1_QUAD_ENABLE
 			/* Kept only for backward compatibility purpose. */
 			err = spansion_read_cr_quad_enable(nor);
 #endif
-- 
2.51.0

