Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CB2CAC5AC
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 02:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7563580B9B;
	Wed, 24 Sep 2025 04:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="efYmwDdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4350180107; Wed, 24 Sep 2025 04:12:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F1E834D4
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swOzcYLpHUeLjKpGfTLqc0bB+uB6q/HgEMhXNzk6pnkOijPKrMSSKipIGEjlHELGglCGT1O0CoWJ90dCa99YJtAthEFxa08k3lz5JIJj7PwMbtwCUWfIUctXb24FEqphaHo0H/n/0LJwI7HbAGkkb4eSn2yNL9+RxLwsM0Qaqwrw2EJ+WflDzE3juHB7xN2vzLKvyXH5+lYyZ5CnAa39znhSsCBLMN3IrmEVPn9GEt+xlb2NI3I/GzA0IrDw2HroP1fMAm2p/yoODOl86l8ZMxsTwhbnXzKEBZrM8qGtgoDUTqtYqXTUxLH3BRK5Uy/Zqe731KBDYiPkBurT3hhYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlKaEOhzxPNCV8WLsX8srgZcnXRV9LO9DG9Fh1HCgQE=;
 b=QOnhzQ1uo23W/dku6iYS48R4GG28+fn17oYxfs8uMeuLY0RIWxUDvpyhseJW+uHGhbemU2vBdKr8VAj7PjkJJVoSQKPbwHUa+wXljE9e+Nenn7dtUigFKKvPSNnJ3I9DDtuXoJUPodIpgnymt3RBOJFXCVi4Qp7AhAiK3o0bJpaaQ5eIe9aKYLxWw2bFHufgEGTSgcldlbKbQKbUKyHe5lcQRMNOELkzxNcAXYvyhuGh/ZTwkL+XSGVIBmnax7z4DDwAz0NNeUJXqlSnJw5YthoHAAUvdRiKg3OBjoZMOcSHP10xAWSqNnGS/JoydhZED5fqMtjNPp75csv/mYJRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlKaEOhzxPNCV8WLsX8srgZcnXRV9LO9DG9Fh1HCgQE=;
 b=efYmwDdRHIBeEp8MHFh/NFNB9tFm504tykncfqVFfSvVwepwH97YILqTMzMJY9xX5+HI5t2J2iGLJVxtXY9CJNN9WzqbIJGgoE/NlnUf8M/dr6SuMcVpPKQITf3xYLJnk0Hf7GvO21yZnVwNYsnZeD+YgC5uqRdQUc/oGcYrmtqkSWtBuB9tylPCYY6UTGlXTLmkIr3gFEXeQXN4LYJ2ZJ93YQ5/JVctqiBy4DcCbxKUmkhXwFbRWoWmqHMKt4sGSOalldz5ENcBrkGL+FDqKJ7g2U14wZGzEWb2w069WY7kOM3dOtYuPv5Y8m8QAYL6ixa+qmWW7z8V8AiRcMreqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS1PR04MB9632.eurprd04.prod.outlook.com (2603:10a6:20b:477::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Wed, 24 Sep
 2025 02:11:58 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:11:58 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH v2 4/4] spi: nxp_fspi: Support i.MX8ULP flexspi
Date: Wed, 24 Sep 2025 10:11:27 +0800
Message-Id: <20250924021127.2866184-4-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250924021127.2866184-1-ye.li@nxp.com>
References: <20250924021127.2866184-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS1PR04MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a16a322-bc6c-4aff-4206-08ddfb0fbda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|42112799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OBWza+0KYtZ9srs2E2Z0brB6JmquK7YLDV16nY+fNrLvOg/0thw358mGx+er?=
 =?us-ascii?Q?izcX1YNlXe8/7pR/65JoLMvaZkVMhcA1ByIek8dlFK1714mVXikqDQ2R2T1h?=
 =?us-ascii?Q?J9tRMJakzCdUxXnjXAkMQ9lS6FSETd67odkSxVjblOKmUjGMSk2IEuz8s9eh?=
 =?us-ascii?Q?etOvmA5zOgJS9/bcSEKTStPeTZy7+uQrddFdqmPZP7XQI9vtRmOySNe4XSSk?=
 =?us-ascii?Q?YE5gH1JmbzJMnelC7+huq2h+o6R9j1AE9ARSEG4CGAw4w8KYFamjcE1wRbGE?=
 =?us-ascii?Q?GLPhenpsBnBaEokC9iZLjiqMJvg9LzQHPkTelTnI/UQnMtlQApOR1rUtc76f?=
 =?us-ascii?Q?IcR3q7fmy9PGpRuaxZMdi9kexVEbNNwAYLebH1i2CcIYjBFpYmb/t+Ubd8iY?=
 =?us-ascii?Q?vCnvdC98bHoMktr5rkIkTFxphllLOjTEvYw/sAPg+o1hy64GPiL75hKdqsEW?=
 =?us-ascii?Q?2POyCm+GjUaWQz5XG4aWgcXBU38Sa98yAIdeOR2nVjIdPR8ybAchTv0Rc9Hs?=
 =?us-ascii?Q?W2ZirOURrUKLgB/od7JwG7wle6hHSsKB9Kxs/dt13fKYQn3EYrfnzy0745qT?=
 =?us-ascii?Q?izgwTIo8UpWzl1YwgudmLBH26epPP17fBJb6XIRBseyOOf/mvdshesRNqWfN?=
 =?us-ascii?Q?1qB1Aye2urNAWVQtjlSIgg1LCM8dZkWkbtm236494VoRBUAJkBsHYn6i/djY?=
 =?us-ascii?Q?fNDEIhhFgU+DlQAHl9UQbqPCS3PQOqLTAieyxx50uzNNI2qypJwhY79FAD+G?=
 =?us-ascii?Q?XOTboVibphev18rPFanjfuCNyjFRFXwDQXfoKQ/J4Eb5eX/vRIiovCIs8CGh?=
 =?us-ascii?Q?9v5ZkyspUFMC0C5jbGtu0YgCexJDo3L7xBsGhUYu5e92shIwbagN+PzjDcXX?=
 =?us-ascii?Q?HTS+U+Or/aiWHNmhooKf0tuE4oICtlItesrrUaH3R1zD0zRPxZ2OfgZ1nQbi?=
 =?us-ascii?Q?/m0ruHIQqqnCzsRrj4QX4ik7SoI76xlS7TTTKUJSllnCb+fSRQhHbr7NfGol?=
 =?us-ascii?Q?ZfZNQJKpqzF7svsxcHGAMm70sPP7saTd3gNw0DM1s6kSdi5hMWHUHejdJcWG?=
 =?us-ascii?Q?f0XdIleJ7yjK9rV/T0WnTYx9YGeyX+ApHReRyJtTo+P5QdMHWVpOtSd5OAm5?=
 =?us-ascii?Q?1oKaqHeaNo4WpM37LTfBzo/0Mb15rRbS6HYIrM5koxaOiWAFntrXu9HDQ2Hn?=
 =?us-ascii?Q?4lqH/eKCZJekwXqWI16n+ELWp4J4wx9whrJc92WZmDC78QVgUhL1l6+BIlwJ?=
 =?us-ascii?Q?OvVeAFrPGL78wltvOgozXr9eSjLxCODDNQvfCBC/7hRAwg42mBh5/JLCfMUI?=
 =?us-ascii?Q?2q6dAjBMtBFeCwyOv7MhJjZd/QH/k0wdWcnOl3yO/S/EJyORMVsjtIgfaAtp?=
 =?us-ascii?Q?gpdENQabiwnUOGsHliDOBoEWtvqsKL/oTrVhuRUCg58imDB/FPo8fdDSgYQu?=
 =?us-ascii?Q?DfX2vSqjkX+AXc+dKixQBB9OqaOM5mhaonwqHt7nzujDsnU5zeNlhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(42112799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ld12gm4BuV6p2+ClRs5M3Jc0x4lggntOiFxe8mR2bZlOJxsQ9aeRhy4fgWB?=
 =?us-ascii?Q?svhGt/O3DQaQmyaU/BSegEqkyXpCXkyTIJuZl6i+eWgorLHcXRp5NbsjtHyJ?=
 =?us-ascii?Q?0Dbn6HWuvYq3E85atWePTkKNU/1t0PY9L1iV2DFQ+jGH+IxSm64fJbmTqr4n?=
 =?us-ascii?Q?Ep5hiIengrOZ5PuO6W3dlQZiL+dVorkIEPlD9oYrMkG37vWbimgbKE437x/P?=
 =?us-ascii?Q?jTND8I0ahSUkjKjBiKR6e+60dJrqf+lYnjNtt0s9u8NPl0G4ULb4cAt4TftI?=
 =?us-ascii?Q?JqYoT0r/aDcoOzeWd1DhIP8TprHig0zZlD0hKKg2DJLFuv6XQG4N9LbpEfxn?=
 =?us-ascii?Q?8u+31w2kGmA/t7wznZTcAS3Z27ZZMoMr6ffg6qLDPrThgO6aBBl/zQFSEth3?=
 =?us-ascii?Q?4pSMGw7kLEDwVtCPLbzsH83HLGqRH1wS5P+SWnXOnLUilZ/WZ7SJh6antIYM?=
 =?us-ascii?Q?EPP76PDnsGJZ0qAFS4idchTJz8DeZ7dpI0+FF9jhvJiuTFJY3W6ve9mf/W/0?=
 =?us-ascii?Q?rs9KfoinVd5+cI5g4uIJj3uXlo27kT6DWtjtVKM8G19FZLmMijPQchj4nXZD?=
 =?us-ascii?Q?xa6B2y7acPeo0urdB2d9IT06II51BB6eHkK6x97Fbdi5trHwejvWA1wKPbZG?=
 =?us-ascii?Q?a5/A6m0WntsuFRvE1rnRvtA9FMUHNNT2wRjymqdQPj5hCplRAEUWBXvsADsB?=
 =?us-ascii?Q?ZO0xdjBodbwHDAvCgxa80cGi5mcrL967fyooBmIwSxbJXHYK7VdZ/FDL+xqx?=
 =?us-ascii?Q?0itOMEMSmg3cVncxz8jDuKbmEFj7Pixq8T+D19RhvAeeTqB7U8T8jweFKVZm?=
 =?us-ascii?Q?n7xoHtvusT8wxGBZO9yZhMo9uEu/xYcuR30/+CavPYn39ndn3hkQtyQVFunk?=
 =?us-ascii?Q?W94WMFOYlXG4iCrtYG975E0PFFUkSOoWrQj6MYKhUDKjZ2bD8c7K/EMVnm1h?=
 =?us-ascii?Q?HsLpka0XH/5ZXd9F8GSlJoOTPdsk5dAMmE3tAtPb+iERRiaj2XYmLZXJh4Cv?=
 =?us-ascii?Q?cH1GTg6+etRDoQoN3d37WAUZZeQ8jqUzWCAc2NzgjsYnDAF4Sb8PkRsHHxF9?=
 =?us-ascii?Q?66RA3mBkM+MxXQl4oSRmX3ktWdAOuNU2p1vQwnFZg0jXNll/KEv7vXmMLUpi?=
 =?us-ascii?Q?8u1d4SAXV86oadqWiAMxXiER5YQQGMe4zalrYBfWKCqP31gwYjs+Oqk4P0fH?=
 =?us-ascii?Q?/tbkt+gNRE8csV4SIFK3T8pYN8i39JbDcH2FiECFScpR+LRc1YmmjAC7vCqE?=
 =?us-ascii?Q?czqNtCV4p2Q8KNlkhEtYV0UhwrZoPQPyQq00xxWzGKh7hJqSUssZZdWe5sck?=
 =?us-ascii?Q?Z/0aTjYF5rz2V+TF5ZWOETonI6kk2EJO1Kh/vbgUct5VPba+YZFtv+jRUTsb?=
 =?us-ascii?Q?BgISQdQ9jep1eLCmJmJZMy0q+/shP8y+tGd2lZW1a07o27sL1IhM4+6wEOCx?=
 =?us-ascii?Q?U2Xm+0IWy/N1C5EuqqrrtUYHr5u1TcCZOJEduBquiXtxEBT7AVnIyk6303Z3?=
 =?us-ascii?Q?sOOnuYssu2l0SsbegDqNtkEY2VhxRbzVtJ3E2w5TUzESlmuxtTV7LzdxjwTa?=
 =?us-ascii?Q?5PFNsoHkiczENZTMHlmaHgp7CDqsPjqQnXPy7vra?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a16a322-bc6c-4aff-4206-08ddfb0fbda6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 02:11:58.3879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCkTumi8jPwj0c90H/GEWUzbgD9ch3YI2nMmK9URu0Ty3qU0zbeZ4Uj1LwjOHmwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9632
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
index 3dfb54b1968..7086a2a264a 100644
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
2.37.1

