Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0294DCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068BD838E5;
	Tue, 28 Oct 2025 17:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4x2N+Tua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA9B838AB; Tue, 28 Oct 2025 17:28:44 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9D3836D3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM8H7tG6+fy4JsZvRo8ynTm1mjPEVinZIvtq9sz9XqnYgGOPkc2jYa2TOfoPKDxwAcZt0Ahs6bZLIUi2ATqniOPNAqRCNKyn9cyFfuxHOmuHR3umzUtyJpgG4HFdpbzbCWz+F2CCkuc2L5ZcuHMW3kupdIlQGMbQNxR+9RJ7wXBNUj1NzZD7QoH4HCa2ymBPSpL+S+l58G+5Q+a5Id1QSxb568ImRU9N8yGxAyXKmEntmnrfcpE2S8uoJWi7I1f2Xdf1rW9pyJ5Mv42yH6cgN8OZA6xUCn0bltpcouchG8SxaiHaEyghX8oHWrr5LSSV8lkCM/yfzSjHIHHB46+STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXpBKClHu6MWG3nKBtnuSuJLaI4okXDTfFsCbsTIUCk=;
 b=iS++6HMIa3OmqqZP8zRJbYXNUSmxKcMV9zP0UFV2LBD3Usg6vkP21kAjk3ZsTNBoxs+imcnit+1d+Dyq3nwsowYOaCCmj3iGGTzhDZxSVMr8S6gSIymXBN/tWc6bxCqJ9mIMGRJ3whFNduXNJivea+c+bc+Xl1PwEhgDsR1a3PIyW7wYkA5RcgLjNG8XWnpFTCoPxNilRww/JDv7dnWlIPWyXXcPvxMUx1D47YrIxvo9S8aA6iusWmjXP8AOkVJwwU3FvnkbJZplvWnv0CBy2qehRyI9nYKUNlSplu123RM0RmNBCpP7xuI1TOn8E6avCG48O1NS5EynRo8IhpXqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXpBKClHu6MWG3nKBtnuSuJLaI4okXDTfFsCbsTIUCk=;
 b=4x2N+Tuad46XxOJFCfVYR+g8u6qEZeJ8289/GaxZOrBgXSLbrqHyCImsno8FLEfSOA2mp1Kp02D0wghwLTn+U2jRnDVqkBnbOiJRxjmBPRKhvG7R5hQvfuT5pfzww1MSpEWdKdjRhxZIwMeiovo41EFI/uE80iGxJIA+1PKt/WtFMm3wKcuzXskm6w1Bu0u0ovdSOc0J8EBqkR9yfqYoaQqJWYPJzTRMy+N9VeNKKrPPDCovJVv1GlNPZxgp94xC0wKHLnyO9i4vKkrxq0C+90/8ryg6X3XggiDNbTEB8uJNJxV3MER8SnJZrhtsJcGTRB0iW8s2K+w8m+9EPSl7Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 05/11] spi: airoha: support of dualio/quadio flash reading
 commands
Date: Tue, 28 Oct 2025 19:28:19 +0300
Message-ID: <20251028162825.3353166-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 5d28fceb-19ab-4485-c807-08de163f0dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XDrm/5k7pEcXHcWJmiUu0AeiS/IazLF4/bFOWm9NUFseyP+XIoZEiuidfb64?=
 =?us-ascii?Q?HL4F6iTDefzgyjJvlHM/8h8hPnCu1Z7mF1rtjn41xBYtKtPkqB/lLHEL8LMA?=
 =?us-ascii?Q?UekGl+JUPTqmr/ZaCThE+orsIbP2F19pbkNZAj3y9h3gN7NagM+Syg56/jPt?=
 =?us-ascii?Q?q4EoMR63CubS2M0U2TsY6dcnvlgAYRU0mDvKTqHQTcCaQFjkyn1aur9jUhH6?=
 =?us-ascii?Q?Bg/pMOVjlzXIf+3GeSF5bfH1s9mpbTwREbgSxF11tVtdgFOZVtP6uGAMEf0e?=
 =?us-ascii?Q?wUhGdTMwww9N2nov8YcPKUWCs5aRysG75P1J65Djiol3Z057thQmgzdNn++o?=
 =?us-ascii?Q?eki9Qo/lfHgNxQLwCwztxSEzIoTHQGdLLCBFqNu4WHzqrYViGj9qVa0bBCdz?=
 =?us-ascii?Q?TpX//w1VRgbEhrw/MX8Ra9gjIUJsJNE2iVd7MoDjN92WI/DEk2SpUCjmuWgU?=
 =?us-ascii?Q?U+o+3N+u8ERq+kD7EYEIgFXKul9TGuzxNdkDg9ShBcg2OninvJwKccWVfhrD?=
 =?us-ascii?Q?T5bLPAXopP/USbm6Iz7VKJTdDPq8z1NradQmZ/1IJ0q23mliRlSHT14R2Vww?=
 =?us-ascii?Q?SkzWN2ZBN93IiRYapyiCRHFr5Y0FWZ5T/Aqo7VtA0AgLb8VVPnEH4vUyLnj6?=
 =?us-ascii?Q?8EHK1u+MpZ2SN5HArdclLfblmQ8vxXckBmcaLppywB+6Y/cUFIMCcgdlAVPV?=
 =?us-ascii?Q?rWzDfmDbpCkBx4w6/aQscn31uiC3G/PP+iRTw4O4O5AsXghpk2lelikr/OCt?=
 =?us-ascii?Q?wo6D8VpcltSCkZINW33Ya9kZTnUE2N4AzktZgTZIS07ro8bZYXvcq2Qx+u1j?=
 =?us-ascii?Q?OwalbBow6V5x9I5CMZ/6iQtu32i+ND2IkP92tUIB3347EJhemIK/Au3eg5Fa?=
 =?us-ascii?Q?vEhpFewekN425yriFdOdUlbpvh45OLlbZquHPb3OTXXYrRxvtz5gViyPwCH5?=
 =?us-ascii?Q?gUl/iTb9ssQlVvZUHKLG556O17AWgGb/8brqpIEtiVkRFo4hFwq0Q+HS7qKH?=
 =?us-ascii?Q?0rIR20CJnq1DRxo9aZcD35zLXqxa0x6k7AGUGjro7/uqYkwXIhmQXtNLZJnd?=
 =?us-ascii?Q?ao+r6mLP8n8nJmtUm77x50YUkhMHrqw94p0kLSKJLAXwx3pB/CMzi2yCPTPx?=
 =?us-ascii?Q?pBPib7zkO1wwigvgDOpHYbcw/5gybRfv6411PmyeQ1B2s6/pzYayi9TjjuV+?=
 =?us-ascii?Q?6+XU1A+aRuYhBZF4KR5NsjsyPQIrjmAWLPNCk1rpgroYMvVH7E9fjEiKkkiS?=
 =?us-ascii?Q?Ckd5MSFhmsV4SN7uSBkY0tDmvMppIN7DVRyJMmcGTsWbw10Yvo/MCyfe9cvV?=
 =?us-ascii?Q?zT7Z7ylzjM9fxLKUrt2t5xfLiNkv3oK9KTnCiQpuMEoxCUJV8Xd3CkaMkMNS?=
 =?us-ascii?Q?roV6JRnT9sYUMOzFNOQTPU7hy/70inp5dW25a33WMM20v+eTRzJCjMnL6Iny?=
 =?us-ascii?Q?NPoawC2YUS0081Wqn5VEqmoXYenf0ycV4CwwvjRkb5x06emcdxnyC+Wm0uZ0?=
 =?us-ascii?Q?AdbScUTclPs/koke6QTFMQ/iANcOjtKrhT8O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DdJR6XJSfDB+7YkiKtewR+Jy26WDz2ihVaB3IYPF5DD8vrd00A6Z9Qs1Lrb1?=
 =?us-ascii?Q?d2M3baqGWpcwqW6oXbtgZg92w4ffzQRJDmIpWwZVgJehPS89/cX/9JzEHooY?=
 =?us-ascii?Q?jCMLIilLkvWoxcdZuUSk2zFrxqhfOYG5+EUXgyyh6H6fErjKAVn1o9zputpB?=
 =?us-ascii?Q?zvd4Yx5MX5Bv2/l+d0IbxT4O5lmYQpdrKis2EUbMd0zAj7TR0qcoLXkVGmF2?=
 =?us-ascii?Q?KD/Qh9ZN8B/XMgfeMP3roNUwksiuiniLOIbO/nacNDmyR90DZRusFEi/joGe?=
 =?us-ascii?Q?VDUQZf3J2xGo8JjqV1FtuJ7gv9nWAlLqiC1zYOehzzSO3em29CIxhkJzlHH/?=
 =?us-ascii?Q?1R3YnWFiN3OmNffoVA0IkSOpSgOi4TEM2l5O8M64Np4N31qQnmxcEE2tki3n?=
 =?us-ascii?Q?XuV8BDJJ30vHIQY2YLpg2tYmThhR0J5i4feU6CmIRyVPEDMyV79XYamy2EzR?=
 =?us-ascii?Q?pTzSbCje0RXFLgW5ovOI6yN58JF9zkw/vKAXMjv2m91rEyfFng/kmWaZMscc?=
 =?us-ascii?Q?MUuDYSgaapttOaLkb84ac6vNKlf0VSoreBRB37li3v4gSONHQ9drblITWYdC?=
 =?us-ascii?Q?H0MYAdgzjx7+qTachfEgYNXPEaAaswHapwLQmyVBj0yg5DTnDQ0y0T9FX3GQ?=
 =?us-ascii?Q?AzgsdrAFAkvlRo27HOjF480l92ul58EqPg24SUUQ59fEqYzPDp56HAQl8l7Z?=
 =?us-ascii?Q?RJ/yp/sgSvcytpozykck9zyc8mkiaEMOkVyll6d7a8P39yrT0TZGKgTUnyrq?=
 =?us-ascii?Q?lIdBhl37v6xpKXesKRu9OkD7WjIaJUi+ty7tpIRYjxfNYF6/HA0DiCa6ICz/?=
 =?us-ascii?Q?i4uT2fcNh9e+R5CPXw1KETecT+ID5gokucQyhwhOnRDhD8LuMo8XkH4Nzy9W?=
 =?us-ascii?Q?AlTW9jwBXS9oRDwYsdms3vdBpJ8RhEtcsV5Cly5vbt9KGOUKmkATyK90ziBO?=
 =?us-ascii?Q?QUkPWVjHyPf9eyx91Wl+abuwL7VSKL4YNxP7YQDaF8p4Xh+nqIVokOmIWnmj?=
 =?us-ascii?Q?0cWu3Bg9DqPF/M8v9A4dKbS9bTiRgbUYotAZHsgarYVgno6wln7fRQh8Nct1?=
 =?us-ascii?Q?5+hV2Z7iKgdJd0kth8upcd25iEeBNsz3VOHajOwO6GYREZV+CJX5AJWxqiMl?=
 =?us-ascii?Q?EA0UPjO9JoEKpZ6CZYQ2joAA4neN7tmKdbZ+8C4gynbZSZyBWQuYkmdiOBsH?=
 =?us-ascii?Q?kRNoNXWSffKf9q9R1yfKOfQ+4jOjwjLhzfe12vnMuS6Qb9xkW5mriUVJ1wyF?=
 =?us-ascii?Q?bbSmaSbRpQoo5J7MMrTt/zhT08Pbx9v0vnfbSqI/XDUVAX05dFgYUyTIRH7f?=
 =?us-ascii?Q?idB68q1XcudmlCxTdaZZAEKlo0iFM75jvVK0j91FW66dku0MUwwC0lFU4U7u?=
 =?us-ascii?Q?URzdqe8hcO6D68S3mYUwkuiqXQjeFzH14yZEBLJvqPHGkxmWTST2ucbrISya?=
 =?us-ascii?Q?jPVNHz2zgojrHAsc6J8dCz3NLn3Htrpaw1wle3N6jwcCKaIPZy7FMaRKa8hd?=
 =?us-ascii?Q?QvZ7TIdXiEdtd/3wzVC2ih1gV88A3QZ47TUQAe7p1cDFvHzeyIjszBPYnSDx?=
 =?us-ascii?Q?ejcL+5QQi4v9tGA7ci86IaM9ljQ9vum6z5ZSuExDplCm9sLgnNX1/Jwayk60?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d28fceb-19ab-4485-c807-08de163f0dfa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:40.8344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xVzIoTaqRDbK5fyVsL22S6rDIBf4kUjV2tvQui76n3R13qZfFHuAM8dLk80kOx4NfhXz28P9JcXISck63aZOXQ8UAkbCZ94/0WygHTz9x4=
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

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index bec4ec0bf00..65381060407 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -141,6 +141,7 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
 
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
@@ -175,7 +176,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -643,25 +646,37 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_slave *slave = desc->slave;
 	struct udevice *bus = slave->dev->parent;
 	struct airoha_snand_priv *priv = dev_get_priv(bus);
 	u8 *txrx_buf = priv->txrx_buf;
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
@@ -692,7 +707,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0

