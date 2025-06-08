Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CD8C5B552
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 11:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8A082958;
	Sun,  8 Jun 2025 13:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gNE3ngj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3746282B0F; Sun,  8 Jun 2025 13:32:58 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A701381F0D
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 13:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP7/qeHr/bl30Lasky8N59GiB2ufPksf3Vat5aj22GPdDChWawWqZJBNO1hIRHuxvPtnVl+C6A/50ewKr/S9kvJzhDFw81WXoUUskAJb5/fvNiYmo0SPyNXjbHbVB0khHbOO4ui3i9tZkmYItDK1SCnIuBac6Xm0nSGgxRT2YlX5GlbEOk+8UJQGKoyMBXk3sIc8YsirWQXg3yDAC+HIq/oJCOep0OxMX1n3O3Q5pq9CjrGIum/5zuON/PPECQLTqzfVhCPAWU8NBKu96fp1xjt7K/fB8eZwIFM770QusMGetEQzMYOloiErJLcoYU0iWRtdLK7V6XLROyNYXqZpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8JDlKgZ/a6Yqafi1X6ygPRFV6IM8tsg0D4s51REeFg=;
 b=vajRkUYP0zxTIHrcG5gC9Yu3kvnjZuLB2ZqQweIkqC8fvzTnKSZUsr2SA5gnOlx0AtccCxpzOi0/x/j4+qabuQTSNPUcBY24D5Fjv3bHmSY58S4ZC/XAZtYaM+RTDcTIyZwS4GaS87hOM6VCSRPkxYDWwmy+YcRCjVqvYIzcU0g1DkOjkGIe6w/I4AoZni6mlzyneBqe0NU+eT7rtN59p+bB14czmMg7BMhIsMqEEGLhtVQeD9y6V4mTNPAfjGfYU1QY72INQP0VcswGIuA2lh2Km0c9P2jxay8DcGl7Zf8iGv7+MiarkicOOKM41/26IuMX/1xbcsm/d1AzuAKHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8JDlKgZ/a6Yqafi1X6ygPRFV6IM8tsg0D4s51REeFg=;
 b=gNE3ngj0PcPZhot7bFh7hWKuBAms8gNKV9tiSW2BHA1wacliL7SsJeFYJanMEx/09MnVTjfQFONlwNyAPMRWdrGwmQG/bkz36o54s1m3Gf8GCvYt8v87ecdoX1ztNt2dmHOUjVxHxnVW4DXmFUtm/zlTg6vfamhE4752wQA1dgLTPoC13/UnxlsGA9A+GO3a9Hio7orSVg8GumpIQBrbLeqFjLxXxuWfjmJInUMSBCdjsHbUP8Yc9iJ1vk8yKWcl9anaK+YOyN2riZ7WF8SWJg9MclferUfaAwOvp7Ho3rwEY5hGx8vYJeFi7GXOL4KJ+Gn7we8yo2OpAZ+xslfWFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6405.eurprd08.prod.outlook.com (2603:10a6:20b:332::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 11:32:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Sun, 8 Jun 2025
 11:32:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/2] drivers/spi/airoha_snfi_spi: add support of dual/quad
 wires spi modes
Date: Sun,  8 Jun 2025 14:32:42 +0300
Message-ID: <20250608113243.810552-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E4A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::1d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d77ef54-5370-451d-c929-08dda680349d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T+EWRZdY1eF3w4vAqdd54DjJoNg9QbA5NPh9HHyoe8Recly4dyRkQ1SORDAT?=
 =?us-ascii?Q?NtxCXHIF+vcTKZJo1mYooqw/QBimnttfMg047ebjyrQROJVQDXyjxT0zZoEX?=
 =?us-ascii?Q?pvy9JDOSEo/Ezsq2NdIFEDMUzpTYIuH0xd2Wn9EXKEhY0IaY8tq6xe04E74h?=
 =?us-ascii?Q?8leSMbVYhHapx8NB+5f77PCirwnkjLZrGb4fjA9Ds9Uhk7ZII/BS7W1x+sss?=
 =?us-ascii?Q?yKkgYfoo4/DpgzaJy/cDY9GqOljwNvdx/szCaCggGAiEZcF0LoXcoQ6tU13r?=
 =?us-ascii?Q?TKTPXzvgH20zRCgSz1ojHo6Zd/T9gNXY/dTebPqrPI2xznHS93SOVSl9ydph?=
 =?us-ascii?Q?5i5mX5ys7QDuRawziP1qLll7ea05UrfFQTxEd47PkGyLQbHkaBbvkvOXXji1?=
 =?us-ascii?Q?D9w3xQ5PGvtqebMYsow3SHy6AZ14JkgKtpWoW9lF+K30I2haHYhLOzGFkxMZ?=
 =?us-ascii?Q?zdacNb/EIroZZ5tLldQN7YnxvgShJrjf8QKmqoZIFXVz1N6WBApa8NwtRJv7?=
 =?us-ascii?Q?VFNVvga8hwNY7V4Ynf+hoMMvslg63m8fOh1Eo2Cev32g+528J0cktoEPD7vJ?=
 =?us-ascii?Q?sMz4jFeBzu3CpLRyUdw8/40s8A9vajv6tovYX8chVfp+1RhNY/Wz31siIT+D?=
 =?us-ascii?Q?gb+sPSpz+Lvhrt5aN+A/H1BODMuKmins8eUKyUE/hOa6EKkcaHRre2HirZMb?=
 =?us-ascii?Q?bdNskSInsEr79RV45+MhB4+hdK454zg3o4zeibYV/aeVG0wjHBXBput1xoBg?=
 =?us-ascii?Q?M7EDBYOSxwP8JL1tyL0SA8hje0UduNdu827pcsx+Rs7KHPy6m11tmathbyE0?=
 =?us-ascii?Q?9eD2ik1uIjPmphXoPUrjsF8LLWpSIoODtt3wIwHdKFoc9oQYGGvHdoJzJtUx?=
 =?us-ascii?Q?QBoQDkEdElwjjpOJIGVD2AGgSrUVGhAE4kATKpBxk8Mtt0WEV7XhCnLoTjhp?=
 =?us-ascii?Q?KfxIrVKdKa79LuQWc0iqpX5bAJhsjKswNti/WWNDuWUhZJ/Gxreymcz0zUCA?=
 =?us-ascii?Q?Wh6lpxU6XVhRwOIGSpyN0TkvTwIRiVAnQ2u3FM2Xv0hCJA65Rxr3VzpP2ZTd?=
 =?us-ascii?Q?fLnLfUzf133xS0E4/tvzjpLxotsZOlG3j+dcsSZyimfbtenhkUh3/5UUvtAY?=
 =?us-ascii?Q?kViCxQtyJNngNfIN1ID0NCxPSymgPHn+FaS44ROLbM6LsXsO3+fZrfU4eLP2?=
 =?us-ascii?Q?QjHX7XUzPrjpcc0o3347fH4XNYMQ6K59HWX7vk7vz3K1ZA66cxZGjRGAJSKC?=
 =?us-ascii?Q?QORu1BBhPQ9HEuYu1LujPQgFkJh5X+PUPL8hB/4FA0HBHr2DHkUMngH+MOmL?=
 =?us-ascii?Q?3cR1FOCrlMpHUUyYYI9HI2Bd3kJXaWNAMxsfJnGqCEBJReEe2+/OJggE0Ohj?=
 =?us-ascii?Q?UMsEhk17GaRwuFfrIVxqCqZZwva/zmHlibWcmLsVGcmWsLZpBYlBktNwJuDm?=
 =?us-ascii?Q?cyKXgPVL53TYvuNYleWHYXNUxrpiLMdvknE+qV+TSzYy4sFdu7DjEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9S7dAWzgFhElFCEzqlJjCU5aQ88xjQKBs2X9dQYAFVVRcCGF6NM8OCdc/Pd5?=
 =?us-ascii?Q?T0umBr8UIfBlAg+vqzRxQUkpaiDA03sqROdvIYOE3YKSE8PRPRDofEetuYkV?=
 =?us-ascii?Q?D01brykKX1p1M2K+b30HjlMZ9yudiZiqBOR434N+i5jui7zoCzhpjl6OESX8?=
 =?us-ascii?Q?KNFSrsXNcwvkJYdtpdWREdQIEjta/wkctKl2SNShKpPPo7Qo82C/tZuBU0Zn?=
 =?us-ascii?Q?TlLbcDFOzuWXWtZIjsEqPlSU/NX84yoEFXK/gKRsvNSt12uSggSAgiDQmO3T?=
 =?us-ascii?Q?0rYAk9hNo2DIqtT6awflBE3+O/lSdokYyFjkZO+xJe9UbrjHQlfwLfNLpJxR?=
 =?us-ascii?Q?5h5MYsOBtPrvmRzCBxwGFTRur0omjI46Iqu/Q/FZRIQ54OpTObQR8v5XAb8D?=
 =?us-ascii?Q?T2FdwGX61CcUvB160aF5OFluDfZ9Kx3JndgecaRG5lNNiaI4CYw3FAAPxt7G?=
 =?us-ascii?Q?nGnd9G5w8Jn9f+zcRmb+ovhNMkvw/EMnzojWbF10hI1u6M/8/ibgFVK7Fuem?=
 =?us-ascii?Q?uSDTAmsa8xOJI+Bm/SCZD+1Rpw2b71+toIphUjNSgoeJEA//BIhwQmQJfZbx?=
 =?us-ascii?Q?kmMvROOp/eBuIOd7ney7MyG1u44IjJehIkEyqkUfTcGhwT5DIuvjm5QFe3UE?=
 =?us-ascii?Q?cbfakZ0j4BxKsaAPkCvD3I9t0YNiCx9YTDEwj0wmHiLfOzYVP3x17M2ituaM?=
 =?us-ascii?Q?JtkS5rGsQjRXveFhXwR7FKnKoK96kvAaV2+bxBoYQFckExyK80gdlU9jj72F?=
 =?us-ascii?Q?aZO4+ahH1sorPb3dzvJV7Kw5jiRNkM96+SlC+BYaA+0aiGLKqDWOGscQ4OdM?=
 =?us-ascii?Q?EbTED7vNLjx8Fon3o7Rf7umc2RmpHTnLXHjMd54C992nwkUek8EfBGiewNDT?=
 =?us-ascii?Q?LY3U9Bx5ilvEnNIR7kLafX+D3zWX7O8UNGcMk1KVb8MN/dy5DNvzz4ndaXg0?=
 =?us-ascii?Q?x+XjHnmimhFYFQKUWbPXw4jiOmVFrN71fSnsd4jv7BfSsFC4qfGqvLbWHxNX?=
 =?us-ascii?Q?WEadeoCOkD9OACSNtbGr7yvUCws4BboAM2RB4h/TV4Tzip1oc9qJ672cFdUG?=
 =?us-ascii?Q?5r2z+jjvagkHNXSmE9Xl/MTHXCILLeGgwaF3KhSnD0teOg67GHq8bjkweDrD?=
 =?us-ascii?Q?p6XgdEI83fWwaMGCQJ2+bFc3sSMXMcvLTtVz1GEDW08AV2XeYHZlze+c5x8r?=
 =?us-ascii?Q?XNTg1iKHRICXo3/yZ53mIOv9MhXRmB4xNJeHO9JlkJMgv+X5TVg2ejZ98edT?=
 =?us-ascii?Q?ICOfsBiCaDd5NSbvWYN+vesyFAkiQLdQy+vdChQYpOIHYbPMxPVTo8hLIeHu?=
 =?us-ascii?Q?QjqFJpaKf8sshsBIs2tE/FxutnpLKEs7e/jbs/LRY4v29ZtAhPDdceT5pLNT?=
 =?us-ascii?Q?PjL+eN7yLoezXTZfFPZ+cPCzVFYJchYfKY9WfY3Dtigv2rU3FnKpMyktNzQv?=
 =?us-ascii?Q?RTQut7BaobYhaOctz22y8sHhu0Kk8xgIYnwHRWPDIZ+w0UcBkYvxAT3EAE5B?=
 =?us-ascii?Q?K5oAQo3LB/S6LVKkTsd6U6vmgl+QKO0HHxutd8brNzm+AxlfIvAKQvv34g4e?=
 =?us-ascii?Q?Wd1WsyCvZrzmGX6FY4hWzRbS8oeaL2TBDc5b0+AUnL2leHlvJzlj+afTIqjs?=
 =?us-ascii?Q?vuTiBDcPHOslUtu8OILD9Co=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d77ef54-5370-451d-c929-08dda680349d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 11:32:52.7114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQAoPo50aSZfGy/LkxnXE6pF4pmtVVtM93pHbgAApJgafIyKqJaEEWf/xwjHcYYP/O++hKzlPeuI7YFs/OKojhQnMs/QMrFSVYFi6EytACs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6405
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

