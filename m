Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C3FCAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 11:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA12833E9;
	Mon, 22 Sep 2025 13:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SpYqz6Yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD7F83211; Mon, 22 Sep 2025 13:12:28 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDDA8340C
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 13:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y24gynkK9wTeKJV8WS9Gtd5Md5bDNeeAUa5djahi7r6zBEXXxlYyrYeP2TxuY9s1n7j8B/QAC4RxjBFAvEYbyu9yUdeOOEf3ldAMtQNJr3/nKLcg4mJBVshwGmajYf1cUlt6CvyeCM0md9bNaq+VCNVukaEQn5gLv91bMJWzyd2mY56N/fMhgymBdUwhfqaOhypVsd6MPgpr2XfydqfJmpsgtt2P/upfCjiXDG24UUcaJppM6rNNZoa6CDEvzvhwRNayt4LfdHnUbziz2x5tZ3NBq1VVbWIT4HEadzR8807ntqD4VOe2/yROg6aJz6XxNIOXg/7bKqW4dPsRRCmBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXkqK8iFJBqu7GByiJ5QwzFoscIf5oElusMovs5/piQ=;
 b=IWUAFt84cIULcZDabtAtjIALdgPh0AkbVoB2BbfYSvB/PZhJ4zNhXVArHW+sRVF7e+Aq9SPCCYAmhGMEPvifm7JJfmQVcLWe+5WQTn/B+1P+NQg1j2xEF7yp4b70nvw9fCCoByq89lH9Xj3dTvfz1RB+dyKeF5QNlvjWokpYVPx5nExWM1TlvH42EfxG3jh+2p5sRu7OdpatSLOB4zwG2ej42yNsRNZqY3EQ5kxoHyp8IK6dyG/N8WghkmzqiepZ+DkLGgwGrONFghXa+EDTRnL7a2eKVeVlCBcC/39aUliZlVSu3VbmKHj/ocJvAQ0KZDpFP1FpLYDyQ+N+o7ev0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXkqK8iFJBqu7GByiJ5QwzFoscIf5oElusMovs5/piQ=;
 b=SpYqz6YburTqLdlcsLlAnuGm+GqpoLQgIaf5huYNqwMXcmOcdsZY3ZrfflbIkwtwMQNGCDBMIJ3GloZvgRcID29zXQVlPgwsfqdc86frSRmpHlHwOZLdWV5wkmMGqgCYPbKn9/0qZvrCcndUSiYISRf1zvezdsIAnlplE5HkePGuOvEpR8SfbdL+kBg/6LRTpqmCKwI6UWgyIKU0lT5DdZWXRS25n5FzY9n9ZRTI2myYGjgx8/kcuQRnLmfqn00osvVvi3GVkLhEGBEttv7N1PcBNDDIJtMWjdwkrN93jx4tQcgaQjgBgX94vARqawNKuNqqmecmIzsS25OQAvzvWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI0PR04MB10735.eurprd04.prod.outlook.com (2603:10a6:800:269::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 11:12:24 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 11:12:24 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 4/4] spi: nxp_fspi: Support i.MX8ULP flexspi
Date: Mon, 22 Sep 2025 19:11:43 +0800
Message-Id: <20250922111143.1204915-4-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922111143.1204915-1-ye.li@nxp.com>
References: <20250922111143.1204915-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI0PR04MB10735:EE_
X-MS-Office365-Filtering-Correlation-Id: a93eb9bf-af8b-4e15-a610-08ddf9c8e860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S/mtuCVa8AJdBg81zT08DmdoU6GyPpkNiTSg4RPGVIxt2GmtJyLXg6/JmQOZ?=
 =?us-ascii?Q?Z1W0Abplg1Ft0iYbuiCjf63+9JFVZzL1W5NS1h5kdZ+fwsfqScqY7+FgSqcB?=
 =?us-ascii?Q?CZd2dyBnVc+10ni24pPU/q0E5mMwD7GwfloK85LlDEvgL5XoxBKN2HoDEFcW?=
 =?us-ascii?Q?rgdAXSiGB3+VWHyXN4GE7R501vjiNj70t1CelluWZEjYmgVrqzsitGeWvIiO?=
 =?us-ascii?Q?HzKECqYrLbhjPXUXqqSno7jcHPCT4UVRUYkbYdTRWwHTvVPBv5qQvKzmbjyq?=
 =?us-ascii?Q?cC2RDQKLkneM6immxiXVFkt2IVoKmxGvjikmEkzGuHN/luwg7Nupm5tWQTE2?=
 =?us-ascii?Q?EdIILoEy9w+z8xwSd0JpAQgYDjahWeJARZApm1qLC/H3/LlYvw0jnTLzkxPD?=
 =?us-ascii?Q?jULegMtjxWJrZQ74vrhypZ6B3m+q3hYMiNvc+18+qYAxcQfm2wKUeuh31Hjt?=
 =?us-ascii?Q?XiWA+ylKeJK7vo0xJrdLMvZXoS2HgZLFVj6mb5VyeYA6oZFGA3Pm7RTiGJwp?=
 =?us-ascii?Q?hTEDZ5lJahuohqT4IG83YpUuCU79Tdy7tJsUbmQfIlHWYILlcnZ8W3U7mJAO?=
 =?us-ascii?Q?VlKoLzfaPwAlucfPLhkPvhal+HmZd7lFto0xYiRh9KYJQTNLe3Yd7Fcr3Pna?=
 =?us-ascii?Q?wque0ZoOifipa1u3c+1Q5+zFRa3IsfsIJ/zhRvVzeL6S3QpnaqBpMQc6dTtm?=
 =?us-ascii?Q?sRKxZDp2l0IGzoXRz/kwsh4UYMCq5XA9uIMtpvod/VhxXfcCiCoA4fOSe+of?=
 =?us-ascii?Q?5ZKT+8vtGvoVL3cfVsCQZd2WtuZ05cPNIOjs7YlQmPX3+zyYFbU5vd2o/HwQ?=
 =?us-ascii?Q?QLNgLfuhC8LHk1WvvuxpGqaH83j3Tg7WxqCSh+NvIbOVNqGrdh3JS1mGMBec?=
 =?us-ascii?Q?tTiOK49oxxKRY4C3FuLXDWy36iyR/RzJlA8QWFz8rdMPt867j+Wpydzt0So0?=
 =?us-ascii?Q?Hv7VSJNB3+odeH+DJvq1dfS3onwB6DNZzSC4EkFEjzyT7OHp8cjWHuuuKtE8?=
 =?us-ascii?Q?MayHGspLJBUGp1J3nxkrEZgzEMuZW08NgrkBPOIovxIPWXm+/BamLhW/e3VG?=
 =?us-ascii?Q?Y+Z0idiY+8ucUdHgGDI79rlalx8SSlLRjbmSFnIZXyr3Rajpq8gXr0KZOhpF?=
 =?us-ascii?Q?/QRUep3I+bb8z40B0YFH6R7EZykArSV0sXVS4t2onT+LDOFV/+oh1rYxlU6F?=
 =?us-ascii?Q?JyEn9W9ZPoYqRrbBmG769upCGyxyKXGB5st77vEJlTmtk+/a8K68oTKdLzle?=
 =?us-ascii?Q?LZIPPJxY75te9yU4HwDDi0i53D4DNv8dYQkfdu4gLAc48GvAXTJO21XZb7F/?=
 =?us-ascii?Q?rF+w0KBYzCUjn31DIfCOf1RNbRmD00hZ7vJ2uTE6nOJXDdOIDjqgwgJ+FUs/?=
 =?us-ascii?Q?95LTz1QU+dAwb84poFtFSO2yAi4Mhvwn3XTnVbMmAP8OlT1vuwXmYq7k1/zR?=
 =?us-ascii?Q?7Kp0sHbeSDAB77kRijCTq1VmzoIemllz3A4/Lbz8dbUdf0i4nuM2IQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9nWO9Z2vzM7X8dTWdV8yVIDhR/ohCeIe5Nf1wIDoQTzyUTfp5PUsQk9JSq5u?=
 =?us-ascii?Q?1SxZgIhyOnFATWtWvRxN7U1qO4qBP7w3BfQ82rdHhzXieKZFt6NkfD6k1sgy?=
 =?us-ascii?Q?3fi4uj79tAm0dx0UxmdTzsbGurwhIpmvGwB186gqs1rWJPLyKURaw96yEHWA?=
 =?us-ascii?Q?LWRl3DRQVSu4t+Mo6aJB9uwlv+pvD6CEoJeoA8q1FaIEXmocr956HHh3anXM?=
 =?us-ascii?Q?PbLsvACPhnR3QINQyyp1xcPXs1lgU06f6zZK6Zjs55r2ZW3AhlSlsMqUPj/T?=
 =?us-ascii?Q?nEt9tSlNy0VILnKA6sfUDkfbYH8FNWjjdgkrVp17DA+7muK4gz6QvcBuM32/?=
 =?us-ascii?Q?vYmTRvD1+ovSqzWTdSezGMC6cetntikMDnX4uD329x6eiYbEfl1qF0TYemit?=
 =?us-ascii?Q?Cz/VeeFYNb4V3x6Qda4VmOB6bcHY5fMINoksRXU+SX5092Xxu54cG1EJeYg9?=
 =?us-ascii?Q?WLnqbWYvcwBv9OoVyyTUUlSn71GeqPkWJzovuTsh2s7m4pBh2LrKMVhGtC+1?=
 =?us-ascii?Q?qfFJQV8TK9cFZI9Pd+9T1sYjF9iaufdXPF9as/LUg8VD8iMjukqn81VIaEon?=
 =?us-ascii?Q?G2uDFacMXcSz2eE2n3OU9ajjulavP0h1QLTBUmZzH2i91pCj7P5hqfLTSs1L?=
 =?us-ascii?Q?RBth7Hw9RPdQ3XYb1Q1ylnjlPdMIBnEqOe5t7mH+SF1Mc8HOXxZf/cK/DGnd?=
 =?us-ascii?Q?msSTow2Y4Uhf2+pqPNUDe6HuHticcDLHQNMbcz5yJV1xFCWRTH/w4KdKcN36?=
 =?us-ascii?Q?V+vkcfcRpIbmtrnGU9m4F8dA16aOlNZh3WZuzcJyEtdtRmGIOTQGgEzb42Jb?=
 =?us-ascii?Q?qxajspXG9KN62PlGZrAubI+Swa3kUILIEnet4DWDuTeeN7caWkv+4M1hjqw/?=
 =?us-ascii?Q?j37EgU76pIvdrQ+xlUR4P1/Q4dWoEurhZnwQX3SdsXxItcKOOgmxISYmArzu?=
 =?us-ascii?Q?uNcggcuwplJ/8kaNqx9AB1UOd7ZEG+8aGLIwBaG/A8O7oQZV5+medp3vmNoq?=
 =?us-ascii?Q?ZdjtzXiwP+hJ6+0ifcDbAmRmtbaxi7ppKJz9BMIMZFby+jZ5+rXe/psNFTg3?=
 =?us-ascii?Q?MB2TnNFFhLhHlneAfHMn5ffXfsRH/DNJI14zWrYl17E7HNVkP6PVnYYfP3o5?=
 =?us-ascii?Q?Iv+QzYPnmNEjscay4iLOHtTKQsBzx7DuNcCCYA8BJrcPCn314X1KaKre959N?=
 =?us-ascii?Q?CquMrJNbMBg75Ja1reGYcxr9oXHJzDuWbBZn/JMstt7zmZ7QECMAQdoxjhFR?=
 =?us-ascii?Q?aSPet77/ro5iInHIGF2a9c28fSMZY6vklzQcdrclmWwvP6KY5Tvcud/Uq+Sn?=
 =?us-ascii?Q?HNT2Nb+PvVD3FSASbApFcZbWQpoyyEDdNkifcBiEWMndOtIaQLS6NELrWD6m?=
 =?us-ascii?Q?bwfzA0IBC+PFu609bHKvt9KB7UsZrz1Z/sLVRD5G4X3Ce3IPRJb+LTCLKDJG?=
 =?us-ascii?Q?z0CkWgtsHaWARWp2NHQVockwqlKFGgcxbjPUY6/OTu5Y/j1ASO7G0pD/R/0O?=
 =?us-ascii?Q?D1beketEdENtQqNtAXDW3p6jVQIxSWpwwxUjgIBq+O8PIK/BpnO2nco1Hari?=
 =?us-ascii?Q?K2ZXNKM+VUKzZF03Ye4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93eb9bf-af8b-4e15-a610-08ddf9c8e860
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:12:24.6636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1x2y+6fJiC0oUNSxzF76+cGNO4DUOO1xB20bg4UFNjhUxzbWi2mG1fkW0SAx87O8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10735
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

Add i.MX8ULP flexspi compatible string and driver data.
The flexspi on i.MX8ULP only has 16 LUT sequences and uses 1KB RX FIFO.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/spi/nxp_fspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 97751fac025b..ef53bf2ea891 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -355,6 +355,15 @@ static const struct nxp_fspi_devtype_data imx8dxl_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static const struct nxp_fspi_devtype_data imx8ulp_data = {
+	.rxfifo = SZ_1K,       /* (128  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 16,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -1101,6 +1110,7 @@ static const struct udevice_id nxp_fspi_ids[] = {
 	{ .compatible = "nxp,imx8mp-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (ulong)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (ulong)&imx8dxl_data, },
+	{ .compatible = "nxp,imx8ulp-fspi", .data = (ulong)&imx8ulp_data, },
 	{ .compatible = "nxp,imxrt1170-fspi", .data = (ulong)&imxrt1170_data, },
 	{ }
 };
-- 
2.7.4

