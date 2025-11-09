Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D17FCCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE80783F37;
	Sun,  9 Nov 2025 08:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="eH5mhD9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9318283F42; Sun,  9 Nov 2025 08:07:25 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974A583E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf9woZEl8KGFM/rFij5kvfZcraMqzM88f96AW5bfKrpheHXUml2HCyHLdP1SselCt7rFddQE8Gc22CUX2pq59m+5miw+mvchAwpy/8f4z3mgg3eWCXmiG7ijWTQgDA2IEZ6QjK48zWE7dzFJ5AjiIB+KRBHJVWoUwu9gBHKfVeLeSRzmuybGcdcQNulwoT/SwzFBze/fR+A4dWpkfhxqjMDSO0MFpWKLdY2bFseQ4lrkSuW2xK5UQQoY4MwaGPk3yXHEbcYwoF2TCzCzmT6rvHWh/ndLl8k0MpG9OQxfD8dx1M2Mctd8M9svMNTcWM1PH45H99tvvRW9I8r08XXmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gsFxakqzAEmPdgAzm2C+l7NS0AkR085evJ9olu05cA=;
 b=OhfujkM7QOGD5E6yT5ybqwPKVHSYoW5oX7gS6sw+BlZEVwQP8GeNCUnmkFPgGTfwscgRGu6nIpjexQL/dvt6es7T5uST7g28aP+S44qyByiIHgP0MvyBSfI2otuxAvUNjP6/Fqcw8h0wayo735Yd0wu3SCoJ8OOGfY17BkkylYzxwnl8YramPWftrTYwu3DAr6tVX0/GKH3EcC+x6fX/CaCuzxHEXB2xFFX7giMIDX7I4cnqkpeNKeMr7LKk9ru8IVC8lqj/pt8trSET5dK+dwfXXhu0WGIBm1J4H8n2EUqH1eeFogqwsC2YzKc75jASkzcW6seejtPp02O3qKgtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gsFxakqzAEmPdgAzm2C+l7NS0AkR085evJ9olu05cA=;
 b=eH5mhD9ndBFWkx0h1eKX3j1zMe6GETbLkU1z1CKNaLOqxOJYD6tOGwN0usoDKTroxlq+v2Unch46xpaL6iMaugY7RYfnPy/PYUUCyBv8QMivglqmTi4Y7nWBfC/t8QdOqgRpEJEj8urdT+ANwGLyVweexKxUFHcZZeSjfajQmhRTZhpo+wJGlps0Ic2qlpHoDc448uAdOpR4aQu9MvqLBnRwT6HwOgjYSO27tkpuA7wGid6KMJznTgrfczONYy0knzS0Ee4qKWM8LiM9snerNQtLeC6TnXpbBdN0L4SJmPaTpMPdn6vx3ShVF8f8i77766Me8lDSGX2vmdjcJu4LSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 12/12] spi: airoha: en7523: workaround flash damaging if
 UART_TXD was short to GND
Date: Sun,  9 Nov 2025 10:06:58 +0300
Message-ID: <20251109070659.801344-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a9d91a-b03b-47dc-a801-08de1f5ea10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cBl+h6DeWcFMSxlCUyppLUiw/7GawtQOTazNnKIo37A0zIUWVJVtSS2sPBdq?=
 =?us-ascii?Q?Nh1eoKTslho3hE7HrEeq5UMy8JU2m1d1kvtqHBvpzRSAf9BTp8TQ91zwdrX7?=
 =?us-ascii?Q?8l3Or08YLhTjkzqzesh6QpQgYDEY5E6dHw/qfKCsuBQLshyBNB/EosCKNyvz?=
 =?us-ascii?Q?qnfADRkts30kM6+xYUHT1yVFR9P7QX/lwYY9RIHvroJaR3M23Ro1dwewxBsn?=
 =?us-ascii?Q?K8wAWg8GDTBeb87xMpwNyTHk4oLOLC1b6azVdlnoRX/mGcokKtJ4Fea+27EQ?=
 =?us-ascii?Q?9FToga+2ngui/eCORtWW+4zz8z7dr4mRzM8bRCWLkWOK/2OppIfSPhFHhL6D?=
 =?us-ascii?Q?Dexotdu/TzxZzVxGWrrbLSzlnfYz74FSBazoA8+6DbtPb+f+a5J07ZxTdKkR?=
 =?us-ascii?Q?+jAKM2EGVvkfvnrnEv9CwJU0p2RccvP2ds/dNc9L481jTXM72Y8ONJrhFKtt?=
 =?us-ascii?Q?P/sr3cQN4VGIoeLKdLdejmvrzuEJWmjW2MnDz3cf2PB9th1Z+W3rPtnwpCJs?=
 =?us-ascii?Q?ROLpm4vxT5fM3lM0zene2Hn1OjqgNAaYOof74B7YrfAkS5Ce+R7FO9uO+1HQ?=
 =?us-ascii?Q?aJgfq0hnS/oj+G88aIlKHgq+vecUQ4c/f4crUtfgSFzkFMedEeFlWcjFW96a?=
 =?us-ascii?Q?pj3CPKnYhGzD/r/uvlb8UOrVWj6eHG1S2TCUo3awmk+YxOjh0qg9pB6XWwDA?=
 =?us-ascii?Q?Ivb4KaBWAurwSDn9vTgsZQLWZD0t0ACxxtSPsC6CFdx7GbVfEMtYYdQKN4tY?=
 =?us-ascii?Q?SQZRCu/Wmr0nzNVgv2Qmi4LgWtIic0gY6fy3u830vr6K2pGvQPFrYoQCMCdb?=
 =?us-ascii?Q?9Z3d/uxGA6L+rUCC/maSWoxgVs9xsquL0ZsUd0FqKBeCuoNeYa/VQpyvkCr5?=
 =?us-ascii?Q?WKfXURKyA8ICxhGzx2TEvWM4WIbmUrlqUXPGEW1kNHQAxZCb3Y625hIJ+lNp?=
 =?us-ascii?Q?EdQDpBw41OITIhY3zhouv1MofF3cFyfn/fg606LbAm+iJefScqjuhek/eELD?=
 =?us-ascii?Q?oTUhmbQwhujTBXnVz27td3i2nqLccn9ua7aEJdqzxPqf+Le8WZuPZkRDaTlU?=
 =?us-ascii?Q?tHsFULzx1z80yF4QnimWSVQaWNkKoVz41p6Fkar5u+XsewWjxj23cfih0/+Y?=
 =?us-ascii?Q?sVgcw+NgPe0TDTkSU1j3r+PbRGWWKVWtNHLhOxLxHXveAb/7ttoxyay5qncy?=
 =?us-ascii?Q?UIsfHFHdL70p0QD7Oz3oongQmO7JzJEN2TZIam0KEwZj4Wk0wCQkzktxPPz0?=
 =?us-ascii?Q?WX9qSsaePtfuuNVKwgmuTVjVASqPgXYdjELLHHYqjPlbi1vzz9JK8OUrpr1o?=
 =?us-ascii?Q?JRD1O8zZtDnHG41c+lGcJbXWAOLge0la6TWbTNo//JORVFExPRLt0F61By9e?=
 =?us-ascii?Q?aiATtFvmzOjQGJp9EtTgk7n3AeMGyzopesYOC27HSegtKoQFrLDhG0HC/gF2?=
 =?us-ascii?Q?Y8UsgJZAJUOTrdm4RS59agW1LEUtPJZWHsxfff/O+yECIlmCFOVMZVYaQdU3?=
 =?us-ascii?Q?A/ZryAutarQvNFZap4cFkw8y8P2UdBLLQFtH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tk9BROSoTMkX2oq0aZoYKevmkrMaqOvBxddtTqCjapHpecnwRIptN9xoQy3h?=
 =?us-ascii?Q?wkBcJJcya/E/1orNdnedh/C5KzssgZcsmpcN8CVoRFnuJ0btZ8pYOUrcHOk/?=
 =?us-ascii?Q?nc9qkf/xazioZku8plRwq4liYTDQXYUQjzhO1PmVI6jsTcn1FmIYc97VlVWA?=
 =?us-ascii?Q?p6LQJhw8dqZP2PCwNTxdluX9T4+xecmuJF591f9jG6QQG66Dngzkr+wg+eCM?=
 =?us-ascii?Q?CSwJyvlW7I/nBeo1jqiqtgQly/z6ogcjWz9kq2Igh3Mc4LSV04R4vUOeVnhd?=
 =?us-ascii?Q?0vmwGaD+9ogTyRhypaFpNPblfWGK8P5ep0AJkcMSWVKpON2p074x4kME2ROl?=
 =?us-ascii?Q?1oghvqviy1bRQQ/ZheyxiLGegxC2knyVXwWJ5qkLJ7IuoixsIIDPXetS3qiI?=
 =?us-ascii?Q?p0xD4oUySglkvs8q9UIozx/dy3WNmcijeL/CxKJrx+hOp3BrzwkWsxA9uNuY?=
 =?us-ascii?Q?e1nCweaP/pHrOvghYNYw/AliGXLs8tt/MFT0oDZTHlMpviusRs5SGv45tOJK?=
 =?us-ascii?Q?Q+bWMsPlcpk4ySqTl47GdNPmIP4ThJJSb8plZYGTETZdgcJyVDgsrBa8sRBC?=
 =?us-ascii?Q?AuzCWUl49SvvJEwl2VyqSlzsafP0fsSNzJvbQk2bMybDgtLkIcFPZSUSvikh?=
 =?us-ascii?Q?amX6/KvRToPdsWI1aDbXQG1M1GCbIkh9yz9N/dou2L5CBVJQ8DnhkKQZxkVJ?=
 =?us-ascii?Q?4GAIGNTUhThobld3p28DRWSrcVUTtd/6sM8L3ObioZsCcMVpky8qRXpLnjIY?=
 =?us-ascii?Q?3GyC7Jwf1JZTcuhuGArBe38jFhMM7lex3sSxbzpcfacXc766FkN1aoRwKNV6?=
 =?us-ascii?Q?gUz0DRCdEdWDSuyuMedmCVvJ/JMB3DOz8GYGBIItl8EMYRmxst3bwvgsuaVm?=
 =?us-ascii?Q?TcHSni9p1bPXYva0BQGHuBdtmibKTlVUsWlmK9QF57nfO7yB6ndnB+8afjVj?=
 =?us-ascii?Q?+0BYtZMi0PsXN6QBLE+A2iCOj+EAfCEH+9s7tr21HCDvSS6MqgXYPS3TUDLS?=
 =?us-ascii?Q?HBxXkT2RFnC4lA6qkmSDvHaYeCJ5iCF8mXqGiXyeCwlo+ZmY/WKXrVNVzxrf?=
 =?us-ascii?Q?N2AYUjFzldaS8NcNM50hfmurxmfABJaqLtpZST7w6dTfIfGv41DeIf5z7ZcP?=
 =?us-ascii?Q?1M+RIBjuLwBRKU/U2+xCgjFGjrSxoB0CWt224j9lhGlxq1zHskwRjvOQbmoc?=
 =?us-ascii?Q?pdm+0k7UjY+J+hx20Ed1TLaEYijN8v7cTk9r/O0xjzE2keiQPL6VPgZ5AD7g?=
 =?us-ascii?Q?A/3D4HuB84WwJ22nHH1XHYhFeUGV4xtMdvFTjFGsjX3MR7JY7VLNIAnlmoQ9?=
 =?us-ascii?Q?e5OigHp6rL7vzofeEeiKmE+YPr2W9PecuqaznMfd4KStKzHPL1tBbqZbPvG3?=
 =?us-ascii?Q?NLx5NGQaGBzDq5E0auNeHf15sSHJYEL6dDejSfZ0kj2GEfzGj1uGL/rrZrue?=
 =?us-ascii?Q?XEsyybljuRlDN5x01I7cLny+dPO11/Pno/kwjGuuZ72MPSKOQi7uFZykUKEA?=
 =?us-ascii?Q?7gLQyINeNVhAOvFcoNJhp9omU8NeM8VRyTy4XDYwVSOu5VeT/FlgqkLC4xTy?=
 =?us-ascii?Q?YkdbRcCeqKZrqX1XKvFdreKRtKl5e+ZJRvFwf8JFuECpnzS07wb66KM7FM41?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a9d91a-b03b-47dc-a801-08de1f5ea10a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:22.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 748lGuJEEML7zwMhY9HpFIG3xrUrN+5rgFncVM6WpQYROZNRV1dcBviBmPE2rWLZ6g1SlN5k1EYhn/SniCVhxPwvfWDaCp2G+tzfEC1CgxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. Usage of UBI make things even
worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
becomes impossible.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 7d6af690bfe..769ec956793 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -219,6 +219,7 @@ struct airoha_snand_priv {
 	struct clk *spi_clk;
 
 	u8 *txrx_buf;
+	int dma;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
@@ -562,6 +563,20 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
+	if (!priv->dma) {
+		/* simplified version of spi_mem_no_dirmap_read() */
+		struct spi_mem_op op = desc->info.op_tmpl;
+
+		op.addr.val = desc->info.offset + offs;
+		op.data.buf.in = buf;
+		op.data.nbytes = len;
+		err = spi_mem_exec_op(desc->slave, &op);
+		if (err)
+			return err;
+
+		return op.data.nbytes;
+	}
+
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
@@ -750,6 +765,20 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
+	if (!priv->dma) {
+		/* simplified version of spi_mem_no_dirmap_write() */
+		struct spi_mem_op op = desc->info.op_tmpl;
+
+		op.addr.val = desc->info.offset + offs;
+		op.data.buf.out = buf;
+		op.data.nbytes = len;
+		err = spi_mem_exec_op(desc->slave, &op);
+		if (err)
+			return err;
+
+		return op.data.nbytes;
+	}
+
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
@@ -998,6 +1027,7 @@ static int airoha_snand_probe(struct udevice *dev)
 {
 	struct airoha_snand_priv *priv = dev_get_priv(dev);
 	int ret;
+	u32 sfc_strap;
 
 	priv->txrx_buf = memalign(ARCH_DMA_MINALIGN, SPI_NAND_CACHE_SIZE);
 	if (!priv->txrx_buf) {
@@ -1024,6 +1054,25 @@ static int airoha_snand_probe(struct udevice *dev)
 	}
 	clk_enable(priv->spi_clk);
 
+	priv->dma = 1;
+	if (device_is_compatible(dev, "airoha,en7523-snand")){
+		ret = regmap_read(priv->regmap_ctrl, REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (ret)
+			return ret;
+
+		if (!(sfc_strap & 0x04)) {
+			priv->dma = 0;
+			printf("\n"
+				"=== WARNING ======================================================\n"
+				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
+				"This mode is known for incorrect DMA reading of some flashes.\n"
+				"Usage of DMA for flash operations will be disabled to prevent data\n"
+				"damage. Unplug your serial console and power cycle the board\n"
+				"to boot with full performance.\n"
+				"==================================================================\n\n");
+		}
+	}
+
 	return airoha_snand_nfi_init(priv);
 }
 
-- 
2.51.0

