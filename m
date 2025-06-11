Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6D2C678DC
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A632F82C30;
	Wed, 11 Jun 2025 17:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="p6cY1wzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5536D82CA0; Wed, 11 Jun 2025 17:11:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9975F82C03
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 17:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZsxVXnfr0LnvE2ekW8TeEGvVkrGeITVMl+opPMfDT2oTHoIV08I2xCSmSYABQ1l1F408odXvHYFTERWh+cRgT79yCuIZkM4rmB8IHiS4CaVBJG44qOwrcVra44EhT0lLDU6NsktmR89GawZZ/xDS6JvQx46aOkjqjRlH9MGZNFXcSfaryRu8INFFT3ysz2On9K1A8SwXpPZT+LhRqsDP5iha0hfiDiZxfr3Kf9MKtpF4X84tVNL6WXeTLPTnR7DpEFaiI5p1XJC9J55QaHO9JVSTZURJFCvg39jY6hGis+4qx1KfbZGQDEK/9UJAR8q77Ch7InPGcwuoLB9DeCdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8JDlKgZ/a6Yqafi1X6ygPRFV6IM8tsg0D4s51REeFg=;
 b=mV/gYQzNoUk5sOlzxDlV5TNJJM2L1TmDh6FkYmTkCSx/0xXyPA4rp5RCQji/pMsbfXRRq8XIbI/dLg03If7mvnr0L7cxfDmdbu64Mr0w0oa3/e7VnkutPRbWTBnpEuAq1ttA1XdsH7xgydN/JxtYB/Qju85H8ItTpK+4sPGpbmAJa6eWui3qDNNRkzAXKhIQ/cNvQozMK0hsRFkPkgYEVq3H3O7iF6+Szxe7mtpvfSnx+t4BIrfRo2Mlj4YvkAbdTzjLHly1xdkKsCntlXkXAHuy3+aH1z1FbBHgrxKixd7JSELIjaRGlLrtJWzDl1ggkXKMPdoLymRFIA5++TSobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8JDlKgZ/a6Yqafi1X6ygPRFV6IM8tsg0D4s51REeFg=;
 b=p6cY1wzZ2uieAlWcXdU/57311Llbr4fTzbAZIxJD1/EPXgkcq4E1NpxPyFAFDd/T+dHFNNTZVl5m2NI3rG38+GrCDa0kvOlJN1B6sIboXgwFCZP2IxhupTRLDPtkrTPPQ/JI7mxSh13KTxUEc5N7sUWFyLIUIqMZRAaMOSS5qRI2VWX7Z9jPW1vYO6WuO1gFVya2noNUPB8bxgxJGthVTWoE0cBKDbp1ixxRU9dEYQFpVrB9yQGnJFcneoMK9t7FkOByEuWzllDJsJMn7EwYvHfJBKbK+ivrBlKQwc8JiwRgSjYuJNuPTDNwBqgrWoP97GtCLIcjDr3be8Fhfb7i4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8089.eurprd08.prod.outlook.com (2603:10a6:10:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Wed, 11 Jun
 2025 15:10:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 15:10:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/3] drivers/spi/airoha_snfi_spi: add support of dual/quad
 wires spi modes
Date: Wed, 11 Jun 2025 18:10:42 +0300
Message-ID: <20250611151043.1259441-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
 <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: d3354dee-f2a0-4b5b-82f2-08dda8fa2917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ujy16x6NUVppy9eRh8a9XSsoVZVfv26UNXEhMBWbetN9sFDpu5ygEOwr1YBI?=
 =?us-ascii?Q?MXsy9uNNpadFrreELsCgWH+4aMZsPTnfSXUYAqKcXXcKYcyJjUeFVSC2avcq?=
 =?us-ascii?Q?ITSwUreaFbZbgdgtwPWJZn8c7STw4/7IpGuP14KkEMV/yxRMwcxMU0ix+FUT?=
 =?us-ascii?Q?S7gOY8ZY+FWVhjZpvElfR3aLLrTPupUd2ArWsNpWy2O4rLClN22sS52n6+q+?=
 =?us-ascii?Q?hp906xctQuUirqvRuxHf+98L6rXTCncffCT04FPdIXel7Ix1L4JUHsLsTv+M?=
 =?us-ascii?Q?aFZq+92/o4DYjGqIunQjg/y0nAaekuP0la5OXvRRyaPP/mu8H8an70HTR00c?=
 =?us-ascii?Q?YvNooqF6AUD1AD9fh2k5kHr8qmyJxuJAj9mnbtYNEt0CT4O+k0b9eoWKIOJr?=
 =?us-ascii?Q?KeLxn/DcQNhA2fye7lodunB3TiGHBALJXzVoUpAbVPMQ5X1Lg7knmsJznxU2?=
 =?us-ascii?Q?un6XCglLqFTH1R6aC2GLNTtlhn6YdeK5FCav1jpUu2AF+ZGJ234NLTcoTuNo?=
 =?us-ascii?Q?MohPSvQGib5NRjvfuY1oXxzLJySoM0kA4RpXdm9qh1/tTf5BZZmXEM5SkmDm?=
 =?us-ascii?Q?ZtT8LbulQgjX2uehvFA4lPJUJspxmG2j2qRcMwDFl0aob84NCaAGdx5pLtpi?=
 =?us-ascii?Q?0aNoX2CKlUixqW3jV5s97JEtOOwirnHq7Rkl50P3TCZviNbYcw3di4x2kvAJ?=
 =?us-ascii?Q?piH0tqJgCJeKxeBoopATy3fQqEsrWrmZw/Xwk5zTrdgNdeQoOAZNnAHAsNsY?=
 =?us-ascii?Q?o4FjUIND3yms35hgIcpCUlHRExSnNdMLl0Hx3VijyH1Nrrv93DyFG9D7NbyB?=
 =?us-ascii?Q?H2jB+TggEkQsU6SgUiSAUSkQ4vJWayoKmnI/N7jlTw/SbVmIB7FzVK9sKclj?=
 =?us-ascii?Q?6M8OkbuX9sD5cUDtFWZ0GYIU2vlh3LbXQdaVwkFfQx8BDlPkOAlGZkcPXUoV?=
 =?us-ascii?Q?2NZwywiB+QDbw9IkUxZE146u3TnJvfDwONoQGjGC9J8VE8r/iACeFpT3YFC6?=
 =?us-ascii?Q?ZLTRzkaF/9rE4XcZQIrPzXw6Fn30DmRuVbiG4aAjN0Sf97/3+S4+0K4mCHgv?=
 =?us-ascii?Q?nyzGUPW4je1UA3LJX7/nwz+j9AFkX/Baw/d3M54MH7SxpkpgJ55D2R0fX0sn?=
 =?us-ascii?Q?f5R5ZF1/NgO9ZTOmbGgirzqMJdof/EL94XRenInnHS+V8GsZmWpZ+RbXF9ps?=
 =?us-ascii?Q?JhjpoD02iiOB6nrnL7sG4gDUhqOhrKnVQLP2Pj+n/6YAtFWKzF1/oPQ/Hdn/?=
 =?us-ascii?Q?Wbg93NZ3ws7mM9G0F2iLJRyJOzxbjz9mzz9PUMrL3SqEJiOR5R5jLqDuzWEu?=
 =?us-ascii?Q?eUKGXdKnr3PbidBNxo6nSkEzAZxcHE/AVFXVS+taCPYAZ3EJMT1eeG76gSo0?=
 =?us-ascii?Q?UuTzNA2kJ37K0TCeMfUi28bLMqccFuMQRBUb95YZ/SIm88Xxr3QBdruQIT6g?=
 =?us-ascii?Q?RHG374LPXqz4ql0pjgTMfzf1NTIWl7jDU3roTpYI2iO9wbVBZO/lIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kc4rvSkGIgN+g3XF/jGBlOCE+K60anYOptY5CYp2yej6MV/s8WtpY9bWxrdX?=
 =?us-ascii?Q?2KtIt/76EmQiFC5pdjZFkYDy6pGYMc5yXMmPVl7qyADkAzsVZx/BcDAYxNry?=
 =?us-ascii?Q?NlYYoToemrpHASD6YJzlZ4qxw+f/wXkaJHVoYUr8KoF0sqxdtFnDp2cU2REc?=
 =?us-ascii?Q?7NBiaYK2a/UJiYFgs266dgDyG1NOajgEOzfUcJtA/4l40s5DDPkaj4aEqJfd?=
 =?us-ascii?Q?nWsUg2wn+HgI5+PmrI/rPSdkm5JmuEU9a1FRTmyDqhRKDLSzlfQzwOzcWrSw?=
 =?us-ascii?Q?B86TspyDdUHp6L4WXc474MUsiqfosDHFiQ/sDKMH41FbL1YGtXGCCcAdzC8u?=
 =?us-ascii?Q?3xbjf2rxGoETmcSS+/91axXg0CbfNktJRqDD7KWCB4WH8Zr69jurEP95IaYy?=
 =?us-ascii?Q?z7eCvR6JFiO9H6sICUy73P+DPzlsTloGxzCdDUnwqowEjI/hFrN1r31RTTWF?=
 =?us-ascii?Q?juxCO5v5X5zC7Z4qTGSt0+PdzNojywjRfeG1gaBnvuELkXqHR84hr1LDxkTv?=
 =?us-ascii?Q?bA1/aAp+udScbAvWCMwNNX7FlSeHg7AVT0w1jEhOK8B3C3YvKk8d9Vjb1hog?=
 =?us-ascii?Q?b51ebo8KsziWtoSk/kzj+g9Lh/AQtKmYGZA1rFVGDGcUeKNq5qj0Nu/Oba2Y?=
 =?us-ascii?Q?YH9R4ZUZVbg/NYKbn74EPVxB5iM76MEgPhSwoxE+/+HUtoJ4BqsoSd4Vvwsw?=
 =?us-ascii?Q?qT6yS5oCpzjIjXBfMYfRGZLJTOvFDPJ2VhgJb8xbAZDDlFC2ICQ/SQhfZX7R?=
 =?us-ascii?Q?r3ZJSUu87P92WJ2lq8PDn1aXso7erK0m6sUUgXYhKtzjZiv085Cl2Zh2vQUN?=
 =?us-ascii?Q?doDpsmdXFSPt4WHvHXrF8nO87ucayXh2PtE7uU82ALp/kzZZhZsDmh1h9yD/?=
 =?us-ascii?Q?NfQ5XEJ1rQP18cgg9CKfC0uDqjw/khXxWXrQAsOcwaWOzYUEECVf2lSBm9IF?=
 =?us-ascii?Q?AcszIL4y2mYKfkwwYOiPKdOoGVmotIio945IPkm25Fri1BstmzXrHoOQXueB?=
 =?us-ascii?Q?lzktqzH1hJEDONj6ifCkXxcSYkLp1RNTp7THBozO/aiU+V2C4KTOxghRK3GQ?=
 =?us-ascii?Q?FDDd+Yf7PznPTjXOKgu1xLL0vunDzOlvAx8kqkXFHS6ng9OaoTYXJCuBLaIB?=
 =?us-ascii?Q?0SIgEGpXE3UXyoJJuEhuBus8c5qQcBlWOUuBo8g/lqqro4dbxHZBciq0FS22?=
 =?us-ascii?Q?X8Wu4adHID/FEGpgyhnCq/oFtlXLwqzV/QoGVx2JjQub0ipYumRZsF8ecBzh?=
 =?us-ascii?Q?GKjk+chsqaItx2WWaF5Qwa91wn9xRCZvQ+pOI3mqH5Pq8ZKG4qr5ftUwAzvF?=
 =?us-ascii?Q?vLEtzqTlbHAEtxAymJzoBeKDSwl3DmIFO/sDlEdxoO59SwIlKSqvB4kKeaE/?=
 =?us-ascii?Q?/jECRJXOJvBbtrXzjqGJu4OKflYHNqH6SBm8ZFOj8JAh+gnjDexHL82spWS+?=
 =?us-ascii?Q?2UkhSrL/J9gIIjssQWi+M0/ZB4bMWBv3HtLO0wnHYkFuhbZpP0S74TdjE/vx?=
 =?us-ascii?Q?3TyjekIupLUCM881F6BszpjF86pmDmDrRuJnLj7Pu1h4zCvaG/2yUvjE5sz/?=
 =?us-ascii?Q?ms/jqPA3v6kfqYtT9Es++Nshiw0bKcJLzEXftmBuOWcrehENPQ9noT5BgCby?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d3354dee-f2a0-4b5b-82f2-08dda8fa2917
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:10:54.6858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Scy73CjBvCDzDNLOwwUmQVQzGpIL8uJmPGodkmFLFmywumJH+j46CsxfoPbZP64qm2PS6xUAf5DnTZowWtbVxZy5AZb90X9AtNB3Vefik7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8089
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

This patch adds support of dual and quad wires spi modes. It will
speed up flash operations on the hardware with corresponding hardware
support.

The patch was tested on en7523 and an7581 both.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 115 +++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 4eb01038404..363590231e2 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -200,6 +200,18 @@ enum airoha_snand_cs {
 	SPI_CHIP_SEL_LOW,
 };
 
+enum airoha_snand_tx_buswidth {
+	SPI_TX_BUSWIDTH_SINGLE = 0x08,
+	SPI_TX_BUSWIDTH_DUAL   = 0x09,
+	SPI_TX_BUSWIDTH_QUAD   = 0x0a,
+};
+
+enum airoha_snand_rx_buswidth {
+	SPI_RX_BUSWIDTH_SINGLE = 0x0c,
+	SPI_RX_BUSWIDTH_DUAL   = 0x0e,
+	SPI_RX_BUSWIDTH_QUAD   = 0x0f,
+};
+
 struct airoha_snand_priv {
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
@@ -380,10 +392,25 @@ static int airoha_snand_set_mode(struct airoha_snand_priv *priv,
 	return regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_priv *priv,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	enum airoha_snand_tx_buswidth cmd;
+
+	switch (buswidth) {
+	case 1:
+		cmd = SPI_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SPI_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SPI_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -402,16 +429,31 @@ static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_priv *priv, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_priv *priv,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	enum airoha_snand_rx_buswidth cmd;
+
+	switch (buswidth) {
+	case 1:
+		cmd = SPI_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SPI_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SPI_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(priv, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(priv, cmd, data_len);
 		if (err)
 			return err;
 
@@ -534,21 +576,34 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 	if (op->cmd.buswidth != 1)
 		return false;
 
-	return (!op->addr.nbytes || op->addr.buswidth == 1) &&
-	       (!op->dummy.nbytes || op->dummy.buswidth == 1) &&
-	       (!op->data.nbytes || op->data.buswidth == 1);
+	return true;
 }
 
 static int airoha_snand_exec_op(struct spi_slave *slave,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct udevice *bus = slave->dev->parent;
 	struct airoha_snand_priv *priv;
-	int i, err;
+	char buf[20], *data;
+	int i, err, op_len, addr_len, dummy_len;
 
 	priv = dev_get_priv(bus);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -559,40 +614,40 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(priv, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(priv, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(priv, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(priv, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(priv, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(priv, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(priv, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(priv, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(priv, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(priv, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.47.2

