Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743BACCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8BE842C3;
	Fri, 10 Oct 2025 14:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="5qz7OjPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78578842F4; Fri, 10 Oct 2025 14:04:45 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36EB83E92
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9tADWe/9oHDNBHDDttmMsWfBo/c8mGre51Ek7p59VKCY5wStil5MlYF53VItILrvcUeNK50o8LY5JlHaCEf1rtrVVbnPRsTxi2p7aedVoKzPBqB1olDi+eFXwAWNkY7vxhW50/HTOc4HEuVKLH9vij7TctXkUoUb98IZ/X2lwvdrfdHNweqk9CZNei2wjL1g4P0m8fqM1Hsh4ohgrw/5IoIHTfIxB8XLzJYcj485ckxospdP7Wqs+wVtpQ+80i8en2JqFjt/wZn8tfJObjiID2s3PT1B2mrhV+H8WtWlEwpZG4voGydXuJlL89MpQ1OvUnhjexouyWL+1orEGaFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI3asHmYoF5yA3FabErNdYfJ5nB8vaABHxZxm2F0zeA=;
 b=fGUVUyDFLn98YYTFtsQqtqb7uKMPUaRxXPMZZzsVvZ2rSps/fRObgoNKeYJRTQopV510hT8gSlwVRZajAqFjahMydcBGm9OwTwP7lnIHdR/mFxPTIhjXBIueGD8H7dUQ6IHtlltX1x9lKK7nvXcXIyHtPusg4Q8Oa7g3wqJJtwko+AdXVlDBoH/wceBoPWiLiKeFw4dZLOBa/NyUoIFkn8obBMKJIiYKQKRXmOQ1/nSD9rh6b99pRD7vpjIW/qadSkJYuIC6ZZH3BIBdqWDusuRMK6G/CmNleEze5X7ct5x6dYfDPqi2i9Vvbdht8swBdbPmWmW4INFVeDVESqDTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI3asHmYoF5yA3FabErNdYfJ5nB8vaABHxZxm2F0zeA=;
 b=5qz7OjPi/CztWO6UDJ72aXSLWON6dZEmY0GPuF4OruYVYkp3GBDgzf4WRmqKqTDe4wHfjqaZiQlazg4p6sfOmKGl8pZPTUi1oJ9POn0HuyAIA8tR7909BTwhlX5T9vDWKIvMa1YQMqQAMsjuPBaMTKmYZF4AZa7mWpJXbIlE7HwmkEWbOdnxTC5isSGCNsNPRcQxH+M/r2yDE3/5Nat7VgvFyq/86iMGFFylUdHxHRLRA0qafTRe0+yAHSBaO5RBRBXsW32UUTPn2a8GDgfsLA12T3AeRNe4Dx5rZQ7WaII/Dv6YzTlBQJIZrpjOY4DMBRkfIXvfsJcTf2jJJviF3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:04:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:04:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 3/5] cmd: mtd: add nand_read_test command support
Date: Fri, 10 Oct 2025 15:04:26 +0300
Message-ID: <20251010120429.1532370-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: b106a69a-53a0-4ad9-0b7c-08de07f530b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n4nM28PRwnjXWW3JIYsKjmlMUPNJDd0qNgeiZtZYhgfDUeOZ7BjU/EUePePv?=
 =?us-ascii?Q?R6yWp6NSg0j9BrRhQVvLMu4WNXrlp5C9hJPCJyfoyP9SSjcv2mKgfprWGul9?=
 =?us-ascii?Q?++PVHN+3o2dWbdqEwVm+jl/hjBJkdtnW9Q2xyJlnGYeXfWjBGqTyGbHCtFrP?=
 =?us-ascii?Q?we8xdp7nFD+y2pokAF0aDIMqc379q+1eBhtp/Eiw7TNGFIzu3jYNm5jUh1OU?=
 =?us-ascii?Q?sRZDn3tS3Qss+p0KiJ0+Izsspgt9huBAOgThKlUIlmkbm6lnhWH6SsdQh1FZ?=
 =?us-ascii?Q?j07HofY3MFuLV7g0+5YJXuXK0We+Tql4A7EFm7prBc19ZT8gYYfCxSZ2NXBv?=
 =?us-ascii?Q?B6HlquBm8sz02XOQ/TwUuByFFnoy3/iGrR6i8Ry0dbDlvQxlnQSFn1V1dSVn?=
 =?us-ascii?Q?x7NluJJ1ed28JMAlTm6TJz0zXG2JllU8TBS1p55DdVD1E+CMSMYqo5eShAw0?=
 =?us-ascii?Q?Fkfw7bQQbbkhjG7Ls2fPx+Pn7zRV41HNv8CG/A+xivs1+Z09rNBNutOuH4Bu?=
 =?us-ascii?Q?XSdDrepQCTGnYW34ChcB2+Ryv6LoP437vRnNYYn5edghYluzK89i2e4jwm0M?=
 =?us-ascii?Q?Pb2cCXEh8BkOwTUVjN8EfPZlrz+rwFXa2Q+D85OzdsVLJhxLUQhbil6a8DBw?=
 =?us-ascii?Q?6Yb5Vua4BG5WVb2Luz5lHktTrguvmzXNX3br+XDZXEmLT8XJjYceGwW673ET?=
 =?us-ascii?Q?ppd1QFS86ESl2h5RXdZzq1BwG6mvekhmvaZD7fPtHdCPzJ8hItZQbjukiDWu?=
 =?us-ascii?Q?PaC5JSWgqU6+kEpUAQcVvlmkACdHwmue2nazpFGVjzbKlJkoJrCVNcFxvWIr?=
 =?us-ascii?Q?pCE53yv0ohNldu8FmOL9q9HJHSxqVaCFgJSB425D8J7AuF8xH2LFr/2HsLnI?=
 =?us-ascii?Q?BDEYMS3e8BAcweiyO/dMJwYNrptFOe9gsa5SxcVL8U4705puW5B7kJfo60UD?=
 =?us-ascii?Q?wr/5LeJ9U8b9kxIYPPoOsSYsNMk21WU/cc1fquboWIkI7cu0makt5UM/3SfX?=
 =?us-ascii?Q?8uuhLRq3zd6R2r1J/a5+/LvjkydIKq54hdhrt740Fugiyn92YtOIbVV1oPD5?=
 =?us-ascii?Q?9idcIMr3SC1XkExrWUpIF+8uhPCIC3ci1HIdQkpPDAjgPVfaVKvHNJVdp5k/?=
 =?us-ascii?Q?VC7ZfLkJjTNOoh3BdkKNhpKvZ/9HK4CID3qcdOgzzN94TjuMVlX9pI2Qq5Ne?=
 =?us-ascii?Q?UWaela33buLqv8iQogMq6fwAotCCEgf4qWVzx3+LgcNP7OykZf++YnTfXMLJ?=
 =?us-ascii?Q?s2AY5sHMDen/gBdHHWRegQMTdzsQ6NlFD0ypB2oc1YkSd6jksVASZmKfRqxC?=
 =?us-ascii?Q?xUE1/4PYZFnSILlhtYGLXLC8dKdFxl3j7iWR27RepAmBtn1VwVEdYPriYW0G?=
 =?us-ascii?Q?W1IJXNIvJQp1bAwKWxTaA9FHa5DNZ/cpwB8y7/NGwF5u7hGQTvho7RtHxi7h?=
 =?us-ascii?Q?sB3XJaoo+BfRgsR7ZfyUmrauU6gs8iJlPRbq9ClMhPeYskcDnHMkdVvgz12Y?=
 =?us-ascii?Q?+/Io9JlkQQv6zo+dtSKuYZMMUd9/EVS+68UEB381DvKa5Q97OoKIacdSVg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ssj9kUfw92N3aQG7bOn6n5TXvpM6fzVlS3Uj99GTLh4g+RQZylMEsiD5REm?=
 =?us-ascii?Q?MYvlev7g8ZrFWeK68b7Tfgn8I32Gayx9CWkTniOinc+A53q+kKdJIa9TlD7v?=
 =?us-ascii?Q?4p77geD4tV8MAipXLSKTOBGzYAgPMylJ/0Pxxd8VwSx31CnTW20vTd0+cEDH?=
 =?us-ascii?Q?UTdz3OfuEXn6o+170dYnE2+VXH02jkgprr7xEM74nrPA8YygDNuildsJ6KTP?=
 =?us-ascii?Q?i1rBW6k5tYiAdd2SRcbk3NLH4dvn/8bXaW47rQ2AduTbS6r9ebzFaN/+mCxI?=
 =?us-ascii?Q?Iw5EewjOq+6+J0cE5IYKu/P/EIqO0RKdrDB9/SWZyrNeeNg4OZWcHfrwc3as?=
 =?us-ascii?Q?KEIBQ9S71piDzg0fLq7emX99w3utrKZkqeiYJHQzFDVf0BFdif7sEMqtO3tC?=
 =?us-ascii?Q?rHfPT5gRTbu90JSMpoT/iHUyd0/K711PPsTkgaakpOfh3i9N42bKddnfXkxy?=
 =?us-ascii?Q?sen8mJpjYZKKEyaiRVx7Sdc6RKgYbYCMrdWFC+cw5Y6EHnRW9UKxnge3z2EF?=
 =?us-ascii?Q?e9JL0YUu1Ivb84oRBV8MrP52u/esLPorOptrb2dVlvsZCYXi4cvx39LzX/ia?=
 =?us-ascii?Q?JLcSA/SUODIHNZ9KuOyu4thgdl5omAQe1QP44YZ4QagGS07nTEi+2MUXLu06?=
 =?us-ascii?Q?/tJIbPwPTKy8uym/0aLOYtkYAOoAsTOJ5cZE6/N2d9bn8nwk1nfFQs40Forx?=
 =?us-ascii?Q?ezTGVDSNOsvzcogNYsCWc1nZiUIANZX+MyYW9TpCQKnlCDq5Ui0yvsurnbSi?=
 =?us-ascii?Q?otlHfzuKvjUIAT7YRjinnIKemeoLIXnm2oqGnAw67aJDPx8w150P+fzpafLk?=
 =?us-ascii?Q?FYeA+Js5fnhYp99n8de4YvnzaVfBOumokSOW02cA7/mjhpd/01f6lUqt0WrF?=
 =?us-ascii?Q?wA4ViMm5IxblqH3VGfmAhnAWomYPn1t9nvvTFYO4T3b5ek628RieDG6nd0FQ?=
 =?us-ascii?Q?ZYS5b3FLgrhghg0gy8HtIxPOp5S25X/sAtNZbZkRCcPrpEnJIEro9zH2YVc5?=
 =?us-ascii?Q?TXosdkSdGb3eRYRmUZjk3ms994lw9TEbi0vwwAkb4rkaMxEqa8O4uX/g3Q4k?=
 =?us-ascii?Q?BISEnvcIpoq7gp9B4KK83vfs6J4qY1cLn0WFqJMkSS5Wg8WqvbXhliEtIMNH?=
 =?us-ascii?Q?UB+Si8r/ScSTUoEU8DSNBiQAwjShsu4jGNcf74/FzV3LsSKlBVO3xRa1TKRA?=
 =?us-ascii?Q?sYFK+Cs99S0E0HXxox6SiddGNVvUr9yVNd71581OHen9sFqVz2HO6U1oLpXo?=
 =?us-ascii?Q?xyh4ZKzXzheFqIKE3Nq9ILJyAAXuVuwXg2gld3ukuW6SDWD9ztNLjXUfA1sa?=
 =?us-ascii?Q?hSBu/94D3rWvjy4qi2IZeh27KIHwBYEKS+IBDCDSjHIaDfq8xvrzpicNKfQS?=
 =?us-ascii?Q?j/pUv7Dk870LgmWDjeY8snWM6i0Qgkww/tyTSaAMEvGGVKjDsqedFWb7x9sN?=
 =?us-ascii?Q?w1l4jsgfmeHhCGJoL5edr8UEqFTFlReMoIlGeD83Cl0UGXmHGzwBTVXRey1o?=
 =?us-ascii?Q?QNuxgGLlACcBePsLkKgxSAlOzE0EOpkEw6Mq5G/h++dChIPPGdYrC+y8sRg1?=
 =?us-ascii?Q?st2vGE4TYCqPMJsOD9jaVKYyl/hwGpH6sGl3gAIcr2rj/VVA83Eu5Mu3mYE5?=
 =?us-ascii?Q?WXTc2PZ/u0j0PRiCIHIgzyY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b106a69a-53a0-4ad9-0b7c-08de07f530b4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:04:40.1275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOrnsK1pl4JpBGf5mdmancyxoZpD56LrBBHtPZZoZLMpIIpijsHDpu3lfhIJtXk7lH86UO++mFNGbvawC4YUCbNbqGo+CaJ/WE2D5533CEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6650
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

This patch implements read-only test of nand flash devices.

Test reads blocks of NAND flash in normal and raw modes and compares
results. The following statuses can be returned for a block:
 * non-ecc reading failed,
 * ecc reading failed,
 * block is bad,
 * bitflips is above maximum,
 * actual number of biflips above reported one,
 * bitflips reached it maximum value,
 * bitflips above threshold,
 * block is ok.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  16 +++++
 cmd/mtd.c   | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 809da34e963..dcf63f423fd 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1535,6 +1535,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
 	  WARNING: This test will destroy any data on blocks being tested.
 
+config CMD_MTD_NAND_READ_TEST
+	bool "mtd nand_read_test"
+	depends on CMD_MTD
+	help
+	  MTD nand_read_test command support.
+
+	  Reads blocks of NAND flash in normal and raw modes and compares results.
+	  The following statuses can be returned for a block:
+	    * non-ecc reading failed,
+	    * ecc reading failed,
+	    * block is bad,
+	    * bitflips is above maximum,
+	    * actual number of biflips above reported one,
+	    * bitflips reached it maximum value,
+	    * block is ok.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 4d69c7b4915..689d8d11655 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -951,6 +951,200 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
+enum nand_read_status {
+	NAND_READ_STATUS_UNKNOWN = 0,
+	NAND_READ_STATUS_NONECC_READ_FAIL,
+	NAND_READ_STATUS_ECC_READ_FAIL,
+	NAND_READ_STATUS_BAD_BLOCK,
+	NAND_READ_STATUS_BITFLIP_ABOVE_MAX,
+	NAND_READ_STATUS_BITFLIP_MISMATCH,
+	NAND_READ_STATUS_BITFLIP_MAX,
+	NAND_READ_STATUS_UNRELIABLE,
+	NAND_READ_STATUS_OK,
+};
+
+/* test_buf MUST be not smaller than 2 * blocksize bytes */
+static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
+						   loff_t off,
+						   size_t blocksize,
+						   u_char *test_buf)
+{
+	struct mtd_oob_ops ops = {
+		.mode   = MTD_OPS_RAW,
+		.len    = blocksize,
+		.datbuf = test_buf,
+	};
+	int i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at 0x%llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NAND_READ_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ops.datbuf = test_buf + blocksize;
+
+	ret = mtd->_read_oob(mtd, off, &ops);
+	if (ret == -EBADMSG) {
+		printf("\r  block at 0x%llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		printf("\r  block at 0x%llx: ecc reading error %d\n", off, ret);
+		return NAND_READ_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0)
+		return NAND_READ_STATUS_OK;
+
+	if (ret > mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NAND_READ_STATUS_BITFLIP_ABOVE_MAX;
+	}
+
+	max = 0;
+	pos = 0;
+	len = blocksize;
+	while (len > 0) {
+		cnt = 0;
+		for (i = 0; i < mtd->ecc_step_size; i++) {
+			d = test_buf[pos + i] ^ test_buf[blocksize + pos + i];
+			if (d == 0)
+				continue;
+
+			while (d > 0) {
+				d &= (d - 1);
+				cnt++;
+			}
+		}
+		if (cnt > max)
+			max = cnt;
+
+		len -= mtd->ecc_step_size;
+		pos += mtd->ecc_step_size;
+	}
+
+	if (max > ret) {
+		printf("\r  block at 0x%llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NAND_READ_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_BITFLIP_MAX;
+	}
+
+	if (ret >= mtd->bitflip_threshold) {
+		printf("\r  block at 0x%llx: bitflip threshold reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_UNRELIABLE;
+	}
+
+	return NAND_READ_STATUS_OK;
+}
+
+static int do_mtd_nand_read_test(struct cmd_tbl *cmdtp, int flag, int argc,
+				 char *const argv[])
+{
+	struct mtd_info		*mtd;
+	u64			off, blocks;
+	int			stat[NAND_READ_STATUS_OK + 1];
+	enum nand_read_status	ret;
+	u_char			*buf;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be checked\n");
+		goto test_error;
+	}
+
+	if (!mtd->_read_oob) {
+		printf("RAW reading is not supported\n");
+		goto test_error;
+	}
+
+	buf = malloc_cache_aligned(2 * mtd->erasesize);
+	if (!buf) {
+		printf("Can't allocate memory for the test\n");
+		goto test_error;
+	}
+
+	blocks = mtd->size;
+	do_div(blocks, mtd->erasesize);
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC theshold:     %d\n",   mtd->bitflip_threshold);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %lld\n", blocks);
+
+	printf("\nworking...\n");
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize, buf);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+		case NAND_READ_STATUS_UNRELIABLE:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NAND_READ_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	free(buf);
+
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BITFLIP_MAX] +
+						 stat[NAND_READ_STATUS_UNRELIABLE]);
+	printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NONECC_READ_FAIL] +
+						 stat[NAND_READ_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NAND_READ_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+
+test_error:
+	put_mtd_device(mtd);
+	return CMD_RET_FAILURE;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1039,6 +1233,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1081,6 +1278,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
 					     do_nand_write_test,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
+					     do_mtd_nand_read_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0

