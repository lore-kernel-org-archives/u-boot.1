Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0ABC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 23:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A1A82CFA;
	Fri, 20 Jun 2025 01:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="K25NYs4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9639682C55; Fri, 20 Jun 2025 01:55:04 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D7182C55
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaBgj1Qrwmbmk5+UZelThBsRuBkgL1djIyHAt0MqC8mQ4wx+rHivK/8hPwjRxTyEkLicjzehd3nheSgsFokEOaf9bmZrt9gN5AGVnRsULxLaQd/wD6yVEwfXg7BPDG5Z3pjudxW4wT6GcC1aG0/ukrn7vO3yjKgJ+lc7PlBO0eML+pWMnEzdKEydGiW1a96C25EaiZIP83olYrTd6wB4OFgx+QhRhr4cD1ZzVS3vbCBGwamEqi8wxldsKNt3N/MGkeU6aREhPIvSRoMOwtXi8fP0qcxecSa3RJfYail469P9S9DzmqXLJZ50E3pRCkXwJzKbFshOOePOO99VEL//Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8JDlKgZ/a6Yqafi1X6ygPRFV6IM8tsg0D4s51REeFg=;
 b=mS/Rn9DYR8ws7ckYy+uVaofHOu6hHQZq7LweFGM5F0uXtL8fKQOxyNHDWpxOC6j/Wu5fGW62W8tku8mSCuBEs6EMhzS6AQ4py/CZW9HTyIRV02HKylKK7msIXQ5dptgTMNpWiH6YooXMLh7I1eVypZ2VuNIpPHpGr+7Zd3cW6eDlMfY9O5zuZ6i8YMjsnJUOG6bvgc5yX5+Ykj2gREYnEQCZ00Rff+eD3xDwKFHzi/IgnYIEI6huUTNJVg1dYFAZEP2zs8St1YYhq5ue7TRSsblfpc9DW6WCEz1E+tjumMWemA6KLrI6C56H/w9aaNbcbtAA02q+xse2NBdlmS1XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8JDlKgZ/a6Yqafi1X6ygPRFV6IM8tsg0D4s51REeFg=;
 b=K25NYs4LGZuFOCogO1cymJHkMqpKgUFzYm+wqNZv0tZDL2tZy4LGEvn9MuUXnUKY/AdyRJoFEvjEvbT72WUgo/zU7NI2xxq+z6Y1M2jBaJpeczxkf2Eof3VKs1Prd++IAxJ/L+1yCC1eW7vtLr4vSpE92Xw0hwpcAGPOxXoIU/v/i6nZa6nde+kNT0AVOEJ/IuGFhRLVhcBQ77do5mpm872roiDKf6o5/fCVPHMl5G2t2urQJYQTvcxo28No23fCT8pJR9WsQbRArAGHGFt04spY60iTFmkklv1EXfU/4VYe1SP92TH2/92cAOhKJ7jwxOCfkrwHQGySW4in4mDSuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10560.eurprd08.prod.outlook.com (2603:10a6:800:20a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 23:54:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 23:54:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 2/3] drivers/spi/airoha_snfi_spi: add support of dual/quad
 wires spi modes
Date: Fri, 20 Jun 2025 02:54:47 +0300
Message-ID: <20250619235448.2414587-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
 <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: e34ac776-d4e1-4d08-470d-08ddaf8cb292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oRLOee96TNHX04jswFrRd/vaxZFdUOsLjf13w9H1YLxyZ2SuazZ7bonFnLuY?=
 =?us-ascii?Q?AkZI+ELVh6qstwegc7ZcZR7IyTrcRXXfhPq9Mo+qwLl2Nnl42CTfsST0e+rj?=
 =?us-ascii?Q?vg9EZ2matIRsts96FfwfEPzBovuDjmmyUSpzgC10QSWPcqfkvh3JcKdQJIck?=
 =?us-ascii?Q?YB5zkdCvZZyq6GuhdlNSySuVg9TYYQucbi64f2XTsZVKOz/xaF0QAO3OFfH/?=
 =?us-ascii?Q?hpI177gsHvzSGwrXJLtFtukUBT0yKy+rv5MOL/QCQh/mAz6D04Hw86tp6UaO?=
 =?us-ascii?Q?OafZ/mXo73DNAGUEW0iv4Oh9WpsZEV7yerB7bzRYgUT5qoblI/KGI8hRvhA3?=
 =?us-ascii?Q?X7N4fbx8bBG1lOeBLw2iFg4AZVf5L02G+gRkbGIt1Lsb7CukCag3nudn/hx8?=
 =?us-ascii?Q?8uoyDazvMIMjU1FWi9aVwIOBBM78VvN16Zgs9XsKzh0kEcFof/1gWVomY+np?=
 =?us-ascii?Q?Po2vOkP0j/sx2tghVw03IjSfdL/YLBztPElMrKcvE9qb2TcfQbnFQtsPJ7Xu?=
 =?us-ascii?Q?XBfKiujpOJclZ3u6Ovz8407+ov7HS6npznPFNj3D+k9ytzQJjRjFkjVGLmgl?=
 =?us-ascii?Q?MGOchgouGGcj27z77ZJXdPrjuzCanFHeDkwR2gNJaxCi+j2uj6GooYxk/3C0?=
 =?us-ascii?Q?FR5TyCV6ay24TmEUb7zx2ir9tbzfKgjYLY8qD8d4nv59RbyqgiVwMUtlqzRr?=
 =?us-ascii?Q?hZupwIQ2r71b/98go7ThtmeDTmva94I6uOM0u+yAYv38oHjDGnZOxk/suabW?=
 =?us-ascii?Q?kP/oVEDelD1WdrqSQMpiCIP3uvy9SUNeYv8vVrcZmyGQ6OyKfJZyjitb2cj6?=
 =?us-ascii?Q?0HTcyDejgbD8zLJ6COR2UZs0VDc0yhlyVvsRIqkKrQmdyRNq7Tbpg2qlNKnA?=
 =?us-ascii?Q?eL6q9BxFcV6dyKygvTqW7bs5vmpuoyxNmJxXwzwdGSMAYKvs2LGr8bjhfpkh?=
 =?us-ascii?Q?ghsdWEGI8UXepJeYbopJeWJurfhQiO/H4Ww5emrjEkucl6DSQekhpQF01Nn4?=
 =?us-ascii?Q?+ta6q0kkj0dvOnjtIMmy5S1HwSV7BzcyX9zRiQmEFG740lSxvfrM0QbzTaP6?=
 =?us-ascii?Q?iU8pQq+CxDoBq4dnj33hEu5hocJjV+V9DzLP3e470cVLlqKEu5uGae7BPUZ8?=
 =?us-ascii?Q?wAgmiKe1vCvL5PCevXpvl3/cUr638AxhkSytAQCYpBrQVy2CQ8RyY9d6uaIz?=
 =?us-ascii?Q?JNdxecOL0o9qluw8fYsTwrYnLi+vXBSV2kuriTpmWpgPOIHHdSjTwrWNVkuP?=
 =?us-ascii?Q?JiX87vxbNLpU1g/UAz+tH97nVtLIsxeYtMFBH4IbmXgbHciNMjpEbmhI9FDX?=
 =?us-ascii?Q?dWJjOfu/BPfipjNq4FTUoOvv73oTAO+UdTqWxuhcV6cZzJ0mhXrLjxAzmbOA?=
 =?us-ascii?Q?7Xih+FjTcksvII90suaQpAHzJTpCj9fW8p2sHvno/GFY+t5ws2RlEOTvuqak?=
 =?us-ascii?Q?sDaW8AJCiLfEpnZpJTCoW521r/U0j3CuV65NS0NaXysgbWO2gAdjow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4F7mLeJKO04WDDZ4WFz9hbWEpb3CDJweBIPseXYibpsuvKdhhDXLfNxrmx3?=
 =?us-ascii?Q?EQ37RPg4NxTkAFbXYXQJ47XcTemki2KipKLeFVqa0LLURoTjK6a7kLS22IRR?=
 =?us-ascii?Q?fcoOXsUqpG+p4auxeokppt4owHwodsny8d25TlcLDsE61oK5MR/V8hpj/MXv?=
 =?us-ascii?Q?ICCQfvv4GACahYDR40KHYA3V2hHRqFSKUPgmu9cC+O8u95rzeXQaeLARNxrP?=
 =?us-ascii?Q?gMlSJy15OQcHbD291iokZqr4HhyCgRHPuCEnRu8yNf7xdshJ15e1IXvRgubX?=
 =?us-ascii?Q?HMyMDrxAzVPVvOPP18cLo+edp5YJreHWLFLjUF0ecC6YQhD6/T+Qx7L/Z3C4?=
 =?us-ascii?Q?cekELYJquOi9ok2d6ozGXpAH+suKrn22oKy+9A0BZUVfDvt1geKdAf6wVOQd?=
 =?us-ascii?Q?h99LgbdlleIX/P17oplAYbt0p06IdsMbrMTofp28v1U8hjD9g5P/sBa1KVxS?=
 =?us-ascii?Q?YL+dESZMbGVkbcYUXnO2GWW1uzsa5Hz3n8tOGyoCgxmhuu3YzoFHkCYTffZp?=
 =?us-ascii?Q?eNqkZ4TuOqmaD6KcnW1pkkCuPAK/SmuGS/tKPs127SyJnDdJBO6NsBAe9BTG?=
 =?us-ascii?Q?RBtdm497V7eAk9LzVhZMiKgSTDRtCp4ipbSG/8xIcvYhGmLsygckAAm5eUlT?=
 =?us-ascii?Q?jLAjAfPSXx8DoCxWAOT9c46si5cLarJKMRe6JBV6CucCIV6Z0nXZl36oArGI?=
 =?us-ascii?Q?1ysJcLeb6eV4J2yQRSkjvwktZ8w2xkrkphI2DF8Wn6c7kLulUq+t7WDnQXXF?=
 =?us-ascii?Q?GreCWPzSYOowmLowefi2wdcZ3V+0y905GCLOOhXXhnhSgFwiPZOBpxT2NsER?=
 =?us-ascii?Q?AwxF1U1sPHZHAaQPsMJQUtI8LMiCnfIEvt0e/Bt67Kmiz5vVXlS+DXAgqEGa?=
 =?us-ascii?Q?vhh+hcrWdPX/GPVHFBmJ+cfyGJyDyIDkedMzYD2pj2cNZoLgHnaPyfJNYZ++?=
 =?us-ascii?Q?B47FMsHxwraAoEQiq2hGkdqHEaHh2zJZEij4KUTWxhPperupz8mW+CpJmQSe?=
 =?us-ascii?Q?Sc7Wiktg4Ay33mmgCgMBG1vDkPIRUgLhDAX2ATUXvnKihZw9WUgqD+ins/qx?=
 =?us-ascii?Q?gW9IPbuKHRFS2n3F65zgjfV8iR8yrmcFCQU++CCaw59ML/s/4YtKyAbX89D1?=
 =?us-ascii?Q?70KCPF5qa/FZQbJglPWeo80w7WiFAXP+10YCmXHlwDutiQIC805Z3N2TpMNV?=
 =?us-ascii?Q?aFp6Os2uXsrWNVs8RVATmIcOJzn2fQ5+VS/VfTAih553E3iGXTlpONjG9X4A?=
 =?us-ascii?Q?k/wi4cn30w/edvk5uFegkgybBjzHxMUQJcacxc88jjgbjfR41Nv4UxSqvo7y?=
 =?us-ascii?Q?SaKkYfvx2NLluBgyghhdGgI5OCt3A73/JCFrT4wB14R6WVlFoizX1+dGWJpA?=
 =?us-ascii?Q?qE3iSuJv6X5Fs7v0cNQ1MblUPQ0SPM54LnpVNBUxPCEVu18BKMU01fXEIERe?=
 =?us-ascii?Q?aQH0m87sBjl5ej2No6WpnTE+jjQvZAyWtmYK8wYNE6JlNsJb+T8ld00LJnmW?=
 =?us-ascii?Q?vFkyWB9wbSK9UW+/nAemCygbOUQ9dtrDDjc8C9dXF+Vr8KUS1ucRF8HCd3p1?=
 =?us-ascii?Q?ZVWBWM6jhFJcb1430hyuq7ViRLQAPCg6Z/pBXqEca9stiS70G4Ao//DQPghh?=
 =?us-ascii?Q?Tk/UQSmCg3PR6QHfGXYPtqM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e34ac776-d4e1-4d08-470d-08ddaf8cb292
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 23:54:58.4865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kh8tL9n+b/eEGPu4uYE9FS2s787wKKylOtB8dQi7LixaWRZFUPgAodMFXaYt2m4p64KaniYgKFQcvj4B6OuCcaCmh0/td4eFf35MTTk9tL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10560
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

