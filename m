Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67730CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC48838BF;
	Tue, 28 Oct 2025 17:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nYS4BfVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C567283710; Tue, 28 Oct 2025 17:28:42 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 713B783771
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRxBhW9RFNY8hBk/zpPSbNgiHcu/i/jvXbE1FlafW5EC3qTr3KoeARsK1rqhSwVuOwagl7NfsfiM+IPMadtMurPDe1AcXv/m6JiwC8g7C0OVwKuwzXvWdpy3UjCBq9VJRJUrvv7PF/9EXBRkNiu8xPyS4FQLMdt5CZfs/Gc2JbXC0UvB4DWGc8N0FI6oEseOlx0kLsBkvM7ODejG84wcGy/OcCFgN0SVZJK1OnTbOW+L7BnWdG3bpz7WHI2APq5nxZ+gQ68HSd3uERqwIrWKIwlzEfUZLthU6ojXJkGUPCoNl2ydek5TxeNGdVIRpyvw6/D6aIMmU8QZrptVWdOEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4TaO6Y0nOGG2gkgYTexz7YHRB0wke2zhKv75GUH8zs=;
 b=JUG1eYE28E1aSAIJQo+Ls+fYHwLpsEb11SZbEz9S0fQ39kyPGJH5nRHFoxhYAPCrh9JncJC1quz7XckedWUNUQv2Vwg0LKLhehf64c1uDeGFA19RXqII2RLxrEs9sK2sh3k+VLVXqr/QM/gjP3idPgK39QP9ZvUOi8gKoxbevHplcFX62u9Gv0ihpv4Nyt4wiiadCXpHoBhDBTteI7iwqv2Nm+Jk0Pr3tcRYZVtLIp5GipDQkSeJAK67+iox8/LqaiqMPto4BbpAmcb3ucogfMkZGtwZZFBVMYI4gjDJliBUv5GH7BpNehM/vs/63vjkeXdgC+kmFKWDZTrMQBrnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4TaO6Y0nOGG2gkgYTexz7YHRB0wke2zhKv75GUH8zs=;
 b=nYS4BfVDI/l/aVP2pUhFM/VZea6PHGQ08RctBMXWcip6YIXLHjXpxsgIc4akaRxusWIqzuftQTsM0S3Irogoy+mxQrbJZftwOT33melVWzGgNoc/lKFVwu0YqsRNmDUCUm+KN/0uXBvkZscMKYAnp0LIKeX1+zJisUtIarVQkgmxsrIZ1xnV2kFwSXVdNU5qXlO+SvmbSK1N3l05Ed8P1iXIDc6CE8jHI/CS5iem1cKW9+tYzOMfkHpnjPoKC8SODjjRkOlLblsdN4Q+rFRBGWMrBczwcy595KpSkaQIx1K1/bLCOURGxEMeLDt3LkhzSJ18RsY67gQV3IuJL6kMZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 03/11] spi: airoha: add dma support
Date: Tue, 28 Oct 2025 19:28:17 +0300
Message-ID: <20251028162825.3353166-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|MRWPR08MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: 702eeef9-3b97-475a-997f-08de163f0c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rUe/rhVoPX/siavtcpB4p05Keds2MdTHGkur6OsZc3K3JFaxS9pplv9O/D2S?=
 =?us-ascii?Q?2AbifZvxLInyycv5KWbcgjRtpDDAyAfbQMTeEWFpuo+D1UvsqQ2qU3YyKfEW?=
 =?us-ascii?Q?MHXCSEUp0LM8HMu9Iac5HlCECiIGZRMDtAP230TPWUyVUzOETHkyPJ5xdsDc?=
 =?us-ascii?Q?uAUX8iq6QTqIHbPPUA2VYCfZNd6MHN+BoB9kCWTZqE6uv2O9tUpbxZG3dHb5?=
 =?us-ascii?Q?HFIEf0VWRCrGcofdAXWbxj6aQgJa59p0NjoXaDNCjA0HwKse6vUhruwM+l3J?=
 =?us-ascii?Q?CtQQPf3lXqyDhHiDlEKjoe/NrHiOU3VmEEsmLWoGpuEiwe48kcwnchATBh9R?=
 =?us-ascii?Q?Aom9H/RkFSALHGkfH/+WlsjIKu0ASwzzX61Ct2fK4E2NOBciN+NTSob8I/vc?=
 =?us-ascii?Q?XnJaIPMASf3tgWW/ArTruBaDmeEMJN4MDvaTDJT7y3m1buu2LiyRrRy2mxNg?=
 =?us-ascii?Q?4w2GpEgh/4oqMgWpj6rEeQ4HeMpjKz2Mml5odeI+rLLWDa9CahLjwP8c6mr7?=
 =?us-ascii?Q?YPt9Kt0LeNKJo0q+0pU9teeC81od6kPKGHwZmYcyjVEbwax647QCouY2BedT?=
 =?us-ascii?Q?vATAiRaRY5kyXmx05Kg/sU8tpZeabC/EEvqi1HYPYme3v0rSskg3Pk91ctcA?=
 =?us-ascii?Q?nrZvOqY6TxFkmhkiNtk58cxhglFY8yfyloqc7r7E7J2mAoBUL9WngM3gdpZ8?=
 =?us-ascii?Q?GHaQhvkGaf4l5Vo55vdaGdHByvSjSKX8Oh0c8QNeMv+Sn1XALEShWiw+ZQhS?=
 =?us-ascii?Q?YgRn1Fs2uEqSQDjD4oUo9A0Elqx7k/uVlh4aZhN6aoU/mLQIH/mXa42CKarL?=
 =?us-ascii?Q?jM/v0XdpT0q7FBtONCUkklAG0DTI+tu2empKxEN9QVAS+t8wqooHrAo5zRLg?=
 =?us-ascii?Q?8Anadbu3yIurus8NcUDF9iOWdyIi+vUgPLY3WWUiLoHgANUEGHShJylB5Zdz?=
 =?us-ascii?Q?USREZc1fPJ9aidhHqgiO9brbDSC2Hb6nrGJRGaXYykihpN+um+vCVVExW/QX?=
 =?us-ascii?Q?/tVoAFvL0vA5qN5BzxG8YfroQiUbLsBa0MnqbHdle4Q8m8Lc8jej/FPEthc/?=
 =?us-ascii?Q?spQyvOyvcZJn7TV2MC+ur7zcV3+Yi7O3gFHL+9nM6JxFUd3ROGNaDls/oGqn?=
 =?us-ascii?Q?1hio4zY/Nt1Nc49C0xpO9VpzG4FkRulc2Y7KxNrGDIM2ejrwTiqLcpqkHlmq?=
 =?us-ascii?Q?S/Gv5Ml13RWXc3ue1irThU9kYAYxOr5lzT9CY6Ba0+ZryeHCwxtgS8iZfjYU?=
 =?us-ascii?Q?Ly3alsbEj6rD9EXiFZZ1hVeJZCEqoFEC8gSg2B2OiYVHAiRTEIvPh6LnCXLr?=
 =?us-ascii?Q?bIfUQibXVTlFabA9jMLxaWbv4N7BlgDWNIn+dyH5vO9dXZmWxZZsbmHCLCuK?=
 =?us-ascii?Q?v0cFupPXhDGuQlLYZSeRJlLG1/FSFNdG/ZZxtcwfeD0GWBqtFv37SlA4ETv6?=
 =?us-ascii?Q?HtaVSxlwUik1xriHFRhakPu8VfYoj0zAh4WcqkGSEn7tKQpC0hVwJ8JmPDHV?=
 =?us-ascii?Q?puqIGD1nBYNYHDdjutADnLEKIK8uGZLjmYDr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JuNjZF+xsn7eReVEy2ofbQcsCnvE8zIiDc36+mpTUik5/NMbxiPB9Yv+j/S?=
 =?us-ascii?Q?5s+dDEoc/6K1hUBzZSpwNbCmz6ASfe5EYDq2gGbV/eFq+rS9RuO9QscLNFOb?=
 =?us-ascii?Q?m9gA893Oet1Ht76dwgKRsBc8EBaJtz9ThyBXzD0DqZrampBdG9FnudEav4mP?=
 =?us-ascii?Q?Ro6eoLyTTYOClSgphWAY6Q99uXHmRcq263ao0HODueINONhy12JHm68oDg6F?=
 =?us-ascii?Q?3aj/9kxn8uGp/osKYRI77PlU8pau25ahyTjV1w6KoCGio0rmKLWE2LURWySh?=
 =?us-ascii?Q?lBCqntSXbHM8ufVLlOLvX9PdfIycK8xf9dgyE3u2TXqlWiiuSTXQtx+1ZzQn?=
 =?us-ascii?Q?wqbvKVUBgkflw86XpAOP5nbbS0cz4bxXZWbGvOlAuFR90+3pGItxuuqwIAg9?=
 =?us-ascii?Q?Px8maLdQu370Ceq+ATwOw6d68iBtO8jbKqFwTKlH23cqULLIaTQWRfGznITm?=
 =?us-ascii?Q?M4nU5wYtNNWL02bqx/sRAS+PzcnfLBNKszsAY+PvuojX80lytfDqeUa3Y8Qm?=
 =?us-ascii?Q?1f69niHrqrbET/4CDq12RfUc4uN5aw+MSF04tsQlUwllD5p36Vli4pkZN6zt?=
 =?us-ascii?Q?iQFPbHCkfrYF97hM1q95fMjxv5Zi2sUt9ypIX1NIFudCGXkegO4gS8+d7bgB?=
 =?us-ascii?Q?01UkfGFCKZhfW4lVWz4hjPxAJpM2LtP4gOdKvKm+W5OdJTyvLOYm0MOJAUGc?=
 =?us-ascii?Q?S4GYz4QC9q8JkfMVP63TaUw2pekMMENYeTk5JZLrLuzEhO9GRIGYm/zEKLVq?=
 =?us-ascii?Q?n+H2TXB+TeOhcjwg1qwkB9uR/L2PZBSXcXAOyiVUW5UpctLI0weRiIxzI4gO?=
 =?us-ascii?Q?Dzj0auodPmJfJbv4Yd5yngqI+CyDfvg/XVhQPoteRW2QytZIIC+ux3gcBNte?=
 =?us-ascii?Q?A7kK9xHeH5ULtyicppm3bjfht8yoTzg3ignrwPkeD8zKhAOyz8hvYgT91s+Q?=
 =?us-ascii?Q?CR1u+tXigtOPmtuL29jDgdQqi7F47i6+4PXTPlxjDvm4atH+SvuFdv7sIZsC?=
 =?us-ascii?Q?oo1KHmEQPl4MEftxoj0I7AK6qLkDbu+440y+DEOFKMuoEEFNx/VUv80L5nlp?=
 =?us-ascii?Q?IMfI3lNLk9J2kVVJHmYNb/iCJnpED1xNlqVZqziWyMs8b65hTOkdWv+Fx/W+?=
 =?us-ascii?Q?sk+zKiyL2/hKW1arplaeJdSeGOHUKUGD+/Hw8P5GXMt3Njx56WyBL+0T3JyZ?=
 =?us-ascii?Q?DTH8KDCAbiOWfyjRpdNzsERaXeaQN1h9EcbXr0upj5yvLizWlwZ+vIWnRNs2?=
 =?us-ascii?Q?HB1HVMw8o/B1RIComRXpALwrkhiSbh992V03Wd5iUGSMJV0CqiUOWHmWRKdc?=
 =?us-ascii?Q?hh7OtKgf14ag1U69VE9ZrtnM4Wd8FzhlNY5sP4U+7l3/iRQ6w6jyD2OjZXF9?=
 =?us-ascii?Q?0T1kLPfOpC3Ca9LdOp0bgP81IBT9HHsOuc+7em0fN8C885xckq8fDBi9m1CM?=
 =?us-ascii?Q?ofeZ+C/+/kHRp+ZyCg7YG7awOUyAF2vxXbkjIpkKrrdulDrlT4+YaPEC8xUR?=
 =?us-ascii?Q?53EC4+bKvdZIPTJcHjfXosjp/ww8KOYVALLnDdmPyvWKS2ox7vUPcF34lYXv?=
 =?us-ascii?Q?mPElLPKlqpuCx7abzAsShesV12VGb6nMgoWILCScPDBd/IhKuR7jkeFCLd6b?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 702eeef9-3b97-475a-997f-08de163f0c55
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:38.1587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2STC9NrdYo9SIdWmIbErkAw/DFuztIcx28kgdDKtdY0ZL81zIpu5oVv7drPf1ftnkFPzWP+UsgQfyUIHvUq+dmXgMPUSMsDS1mPVFaO4xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11233
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

This patch speed up cache reading/writing/updating opearions.
It was tested on en7523/an7581 and some other Airoha chips.

It will speed up
 * page reading/writing without oob
 * page reading/writing with oob
 * oob reading/writing (significant for UBI scanning)

The only know issue appears in a very specific conditions for en7523 family
chips only.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 309 ++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 7cd409ba44a..f72d11f5b19 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -141,12 +141,14 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
 #define SPI_NFI_PG_LOAD_CMD			GENMASK(15, 8)
 
 #define REG_SPI_NFI_PG_CTL2			0x0528
+
 #define REG_SPI_NFI_NOR_PROG_ADDR		0x052c
 #define REG_SPI_NFI_NOR_RD_ADDR			0x0534
 
@@ -219,6 +221,8 @@ struct airoha_snand_priv {
 		u8 sec_num;
 		u8 spare_size;
 	} nfi_cfg;
+
+	u8 *txrx_buf;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
@@ -614,6 +618,302 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 	       (!op->data.nbytes || op->data.buswidth == 1);
 }
 
+static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct spi_slave *slave = desc->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv = dev_get_priv(bus);
+
+	if (!priv->txrx_buf)
+		return -EINVAL;
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -EINVAL;
+
+	if (!airoha_snand_supports_op(desc->slave, &desc->info.op_tmpl))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
+					u64 offs, size_t len, void *buf)
+{
+	struct spi_mem_op *op = &desc->info.op_tmpl;
+	struct spi_slave *slave = desc->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv = dev_get_priv(bus);
+	u8 *txrx_buf = priv->txrx_buf;
+	dma_addr_t dma_addr;
+	u32 val, rd_mode;
+	int err;
+
+	switch (op->cmd.opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+		rd_mode = 1;
+		break;
+	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+		rd_mode = 2;
+		break;
+	default:
+		rd_mode = 0;
+		break;
+	}
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
+	if (err < 0)
+		return err;
+
+	err = airoha_snand_nfi_config(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	dma_addr = dma_map_single(txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_FROM_DEVICE);
+
+	/* set dma addr */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR,
+			   dma_addr);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set cust sec size */
+	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
+	err = regmap_update_bits(priv->regmap_nfi,
+				 REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set read command */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL2,
+			   op->cmd.opcode);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set read mode */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, rd_mode));
+	if (err)
+		goto error_dma_unmap;
+
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set nfi read */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_OPMODE,
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
+	if (err)
+		goto error_dma_unmap;
+
+	/* trigger dma reading */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_RD_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_RD_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi,
+				       REG_SPI_NFI_SNF_STA_CTL1, val,
+				       (val & SPI_NFI_READ_FROM_CACHE_DONE),
+				       0, 1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	/*
+	 * SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end
+	 * of dirmap_read operation even if it is already set.
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				 SPI_NFI_READ_FROM_CACHE_DONE,
+				 SPI_NFI_READ_FROM_CACHE_DONE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi, REG_SPI_NFI_INTR,
+				       val, (val & SPI_NFI_AHB_DONE), 0,
+				       1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	/* DMA read need delay for data ready from controller to DRAM */
+	udelay(1);
+
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	if (err < 0)
+		return err;
+
+	memcpy(buf, txrx_buf + offs, len);
+
+	return len;
+
+error_dma_unmap:
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	return err;
+}
+
+static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
+					 u64 offs, size_t len, const void *buf)
+{
+	struct spi_slave *slave = desc->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv = dev_get_priv(bus);
+	u8 *txrx_buf = priv->txrx_buf;
+	dma_addr_t dma_addr;
+	u32 wr_mode, val, opcode;
+	int err;
+
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		wr_mode = 0;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		wr_mode = 2;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
+	memcpy(txrx_buf + offs, buf, len);
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
+	if (err < 0)
+		return err;
+
+	err = airoha_snand_nfi_config(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	dma_addr = dma_map_single(txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+
+	/* set dma addr */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR,
+			   dma_addr);
+	if (err)
+		goto error_dma_unmap;
+
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
+			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
+	err = regmap_update_bits(priv->regmap_nfi,
+				 REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set write command */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL1,
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
+	if (err)
+		goto error_dma_unmap;
+
+	/* set write mode */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
+	if (err)
+		goto error_dma_unmap;
+
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				SPI_NFI_READ_MODE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_OPMODE,
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+			      SPI_NFI_DMA_MODE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
+	if (err)
+		goto error_dma_unmap;
+
+	/* trigger dma writing */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_WR_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_WR_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi, REG_SPI_NFI_INTR,
+				       val, (val & SPI_NFI_AHB_DONE), 0,
+				       1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi,
+				       REG_SPI_NFI_SNF_STA_CTL1, val,
+				       (val & SPI_NFI_LOAD_TO_CACHE_DONE),
+				       0, 1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	/*
+	 * SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the end
+	 * of dirmap_write operation even if it is already set.
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				 SPI_NFI_LOAD_TO_CACHE_DONE,
+				 SPI_NFI_LOAD_TO_CACHE_DONE);
+	if (err)
+		goto error_dma_unmap;
+
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	if (err < 0)
+		return err;
+
+	return len;
+
+error_dma_unmap:
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	return err;
+}
+
 static int airoha_snand_exec_op(struct spi_slave *slave,
 				const struct spi_mem_op *op)
 {
@@ -696,6 +996,12 @@ static int airoha_snand_probe(struct udevice *dev)
 	struct airoha_snand_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	priv->txrx_buf = memalign(ARCH_DMA_MINALIGN, SPI_NAND_CACHE_SIZE);
+	if (!priv->txrx_buf) {
+		dev_err(dev, "failed to alloacate memory for dirmap\n");
+		return -ENOMEM;
+	}
+
 	ret = regmap_init_mem_index(dev_ofnode(dev), &priv->regmap_ctrl, 0);
 	if (ret) {
 		dev_err(dev, "failed to init spi ctrl regmap\n");
@@ -769,6 +1075,9 @@ static int airoha_snand_nfi_setup(struct spi_slave *slave,
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
+	.dirmap_create = airoha_snand_dirmap_create,
+	.dirmap_read = airoha_snand_dirmap_read,
+	.dirmap_write = airoha_snand_dirmap_write,
 };
 
 static const struct dm_spi_ops airoha_snfi_spi_ops = {
-- 
2.51.0

