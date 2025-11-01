Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECECACCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B6483C51;
	Sat,  1 Nov 2025 01:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WUtIKtFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E974183B4F; Sat,  1 Nov 2025 01:45:37 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B088183C04
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGLwJujishdPpGloQtpE4ZHHFGcnc7Ezwe4Hd0zJ9ttPcEB9eStYNwyrbDzoher7aQcURoghIoHIrGgDxF2PAxf8j4XlLKN0l1qCJvkNVUV7toCARwB6KN0X5hBmRAOKHBCyA9NoyCMBXGVSXbdEZrG8OfYKumaRf+uaUtqZHekvJpsYzsLmrElxFtl29910JCTyoXbGu6A0hBkkoIZ5FDs2Y/WIRodt8+nFEIvkA/s6Af0aEwcn4xoK4rr/Ku5xcsAuEymYpv9glVCQ5SZ5c/r/Zos6UWqTb3gI4yqbpGVHVqoAhUKcDrS0GV73ip4Fpr3YBsWi+IRfBY8pIyN7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvbc4Lna1ORCayuwf+oBRWShFwTf0qNPCz/r5wanc64=;
 b=u/r6khn8bhs+peYYKw/Mq3Dv606e3wFxJSftUCQwy7gt8KBIOmlhX7MO0eAjajPwja0K3k1B9Q0CYTyjtG1Xm2QPbJwYLw2MhDBnZFT3SP6/FkrDxchsnLbPCRwSBHdCdrfU1u1zQwMuS519mNLryhGvqePnnIPW3xkmkn5BufiuktKNiSZiJ4U5iVTdknjasdQm6U+YFtWZGPcsxgI1j0aIPfzqMleHrf8WjGt3+tG4IJ14R6P8BwJDdxrx0w9TCYpcHw6O5f4SgyaUCwzRNkdE13F5WCor71tStAYRuXNXtBJkkys2Od4J2hrwVsx7Q24fuqXKSKAI6o31s3FA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvbc4Lna1ORCayuwf+oBRWShFwTf0qNPCz/r5wanc64=;
 b=WUtIKtFfFs6U0rvcSpVGKwWO4VvM1JdQR4PFQwG/33F5yxlIcqAQykfKaaNFT0srOFRcSz92y+T03PZZa6FlI3bjJY08YqPliV9nnvkSW3tVmf3p+hlocLfxMYaVEMiMU8VeFNYbgVz0Q+AAagZpQeeg3QAhhCkx2cgi81GxW9+aoK5G2s5J2wFDB/nTGHSbClTNvVaDzPlH45YDwKHLY5kqvXyMyS61AlgPlVDYLRHrpn/Q6bTrSzoW+KNlTy153aqXX+rQlu1jSNclt3NCGalPpyXoKSQP5wAh//vyE8EBifiBcCeYeKCYTDWyEgMQV5068EQzbRIze4qEMkDJoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 18/19] dts: airoha: en7523: add spinand flash support
Date: Sat,  1 Nov 2025 03:45:02 +0300
Message-ID: <20251101004503.2379529-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: a89bda74-17c3-44bd-a7e5-08de18dff606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b6UoRZ7sCLjwnOW1pW0TRJYUvCry3ZyPKeoXCf7pBF2SUZsOOTNBW8qcCirw?=
 =?us-ascii?Q?ZaghuHLF2nSDzeKVGfbhutUfpi5FJZK46XU5x0/Rg5Hf3+MGrcuu1K27CuPn?=
 =?us-ascii?Q?6Jrv+63C/YfIp6JUqaHdupivmxS5e7dq9axkj3QBHTte/bskCh7+osLzq4Jg?=
 =?us-ascii?Q?REQTCHxx98k8+4wkwtC6b2X/cRiom/DnIMRqXChtdyoA6YnkY792j+u1ADGW?=
 =?us-ascii?Q?5qxYZnQ+2fwbKpnHWKeGFPC99mm2kPX/3yTogtwDHeNC+2tChOCeSZ5IpP5A?=
 =?us-ascii?Q?3pz68eSoUAvP9GHhrMZhhGS3rPbZlwuJPNBAq+6feteQMo+HEg9J2tijdEVU?=
 =?us-ascii?Q?xR7RY7o93/Y2OEl/9XYvxCIrne2eHxcCzbWf3ORXPIx7q/aSU4OJb7znkA8s?=
 =?us-ascii?Q?/Zz9II+awkHVSy5SNq19X9AgNq08gIRp2Du/MslpJ++bOXav4hGhZh7MkaAr?=
 =?us-ascii?Q?R2x1nnhb/NqvIG8reBhZGWNsroe60xJcHaMfvFeCV78uhCgoDMQSj68RfPVh?=
 =?us-ascii?Q?vURH3HF+OV7ndG5GtXXCkuQxUVqqQPGiVBsmTPcjrYm1T6M9Oa7XiqJ3Rjn2?=
 =?us-ascii?Q?XW6/T74eqN7SbrDPTPIcosEb5JayLm5RLVr3bpGK9GpJbQ+C2KDxTfZYBcGa?=
 =?us-ascii?Q?jx/8955C3Q6nJOBqrQBW4Ip6L5yQXMbXzq6RBoTt2PWW/TearQvg/P7RTsrb?=
 =?us-ascii?Q?LtsXXEio3DRbvAsgWfNtZyRw6/oVudkS4/Ho7mUKcgNCocHx7p6Gnd8zwAnK?=
 =?us-ascii?Q?G6rz1KoADnSKofQm8Xv5+iRovzuC5YjcNwAc9Cve66YIVGqphr2k7zk0rnat?=
 =?us-ascii?Q?Ka3SoJiQNJVIJTU9e7Yc9TiS8kVrCATLFJ7zYSD02htZN6WN14xYFYD8wgxh?=
 =?us-ascii?Q?TyagzHhyC3xaMx5Vz5tANJVbw8ULzixYRyZiKIYQJilmTCm7Igm/9ZeFab6s?=
 =?us-ascii?Q?eiF31RjjTSF/nhpGEtZJ++0BogjNIUGCNqZGrjSY/FfVfReHznVfPY7NalCb?=
 =?us-ascii?Q?MFEIVctmCBDNmjHd2WCo/PTO5l96x6SlyuS2fn0siRLt6qDWXr4WudW8Z/0D?=
 =?us-ascii?Q?pgqvCz1+5hM/a3siY49dWZjEPNIc2ExoVZfmIDhnYpHl1O5GESfEtEhR6wuY?=
 =?us-ascii?Q?JlSfTQ/0Li7RksjNO0eyZ5eAxYBGwPgZxhGaHoUm/oWV6+H/IHYwTZZ/hjk1?=
 =?us-ascii?Q?Pjx+Krsla6H2AaUkLEn5yrOg19Ihlu9IOHEqsVrMqL5kTcBwVTZmk6KIW0ax?=
 =?us-ascii?Q?pVquvYRuALAfnH/44BCulizV3Al22nhD7bVwKod/Rdr0yxsuLb9AkOAvk80K?=
 =?us-ascii?Q?/xF0L0YpICmKijnfUz4ZnZiS9Z4drp9fezKBA8gWqHxfuNk89Ng7cYMz5s3p?=
 =?us-ascii?Q?Y7vetEpBqx3Ncx7Ju3nz+x95tBz8sJaGiBjTuGAFV35QcUCKTQDFKh55Y0jc?=
 =?us-ascii?Q?Rm5VZ3Mt1DrYbFxtCaGyXdOxLi03bZ8cRQ17uP7EmIG5T/cj6chSgLJBHoGj?=
 =?us-ascii?Q?+E8/1XmPw9XPPiMFpPkfjE+Xv/ZkTplMyqVu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?53ULeXKcxWBlzVaqkTMbRpUBBd91Y0KP3bwdrh+8irVPXCHJY19HNhlBvA6z?=
 =?us-ascii?Q?IaAsdsTl8KSMRchkzezwOVqqbd79zzAaV9hMdeAX3AA1nIJ/cJJVoTxhH9nP?=
 =?us-ascii?Q?uE3PCcuXQILawT2f9Ylhr4r594W4FC1v8GpjJf+P70Pt2xgVoUjlqWmRktS3?=
 =?us-ascii?Q?58zaWkupyNrRYj8LYJxtH42oiUoOfQjWoa7c9t3MlPSWWqh3J+ssjgIXx3fN?=
 =?us-ascii?Q?UQJbNsaaGh6KfSYZPwFdWxhd0fJ5IzPMPUZgQAEgZdDS0csoJKgWRXoFocWf?=
 =?us-ascii?Q?SLIEhP1KUW9ZIGMt/FEa0Q7xElCUg0f/z1fy48Im/PDSk6+CsA1NsGYHqZZ0?=
 =?us-ascii?Q?I+R5Z4wVnbaMhle+dXkcUOHgKg9uBQ1NsGAow+YwI/7PoQEmkpyvRacnV+/l?=
 =?us-ascii?Q?ljIUqYot8on1O2+7/x7w50o1EHjyfSOAevpAFmetH9DcvnixBDkk/xJ9fTq+?=
 =?us-ascii?Q?HhdZpvJuTwfupOU3T4vEFGjwY60ZwCVPKsr83qB9ELe1Lm8BT8kFrO5ecCr+?=
 =?us-ascii?Q?yecjewzNxUDbDWmZj7CdgWipn/ZntSs5bQ7O70pt7K+U7wCQz7W45rU+KQjW?=
 =?us-ascii?Q?J8zhrqmdDvPe6icqmoODlidpMKs634Vyy1k8NsYjTWxeMUXY503ydOonTT1S?=
 =?us-ascii?Q?ZuRynYeRA481W6ff/taE5J2GLUowKz5rUF0ZtSxSE4svio4dhHdJSDedTfwV?=
 =?us-ascii?Q?XWDQmBjpRrEZEkpWEJIOQQlSqR8HIMDmmzuIkmMZnthU4XcLrq6/6vIAImbH?=
 =?us-ascii?Q?rxpSvEulZZ6EICCEbt3GvXRGFvRMXXm2pe/PzceryMscLvS4un0Vuf+YRABt?=
 =?us-ascii?Q?C5oX5irImvbUwCkADPygeJP8WHiKtbYZnHBLfnFxwZWkX9OWVrJnuaXElY4t?=
 =?us-ascii?Q?FEmMnz00RmiuZ1Dihx6I82qJtt5z6uUl9ivEjLmCTy6AJ09XPYcM5OACJ73u?=
 =?us-ascii?Q?rcgY72/0ztnGF8RleHankjA2JPNxKsf7ZqYVbRs/nx2ZW/DoCAx6lAtC2U7g?=
 =?us-ascii?Q?uxfWb9t1fyM0nNrCJY0p+mV4X0dE0MxZ2bo6I0Pib4wtsF67OYt+/7c4PfIc?=
 =?us-ascii?Q?7PCAYdX7k7l8BHFD5gQC5i+xyN0sCLO2UGCA8tzGaHssPZgGq08mMm3SDYgc?=
 =?us-ascii?Q?3jM0OpKBLpOv6JHLBjQWbs3vgsgz6UFle9CEoTm1COCz3J0Ef2Lj576Yz6+y?=
 =?us-ascii?Q?qRs5iZDEjce0omEeEnCEhF7GBIspCFhxMbA/J3ephCGD988InkQvmbCsvkPl?=
 =?us-ascii?Q?v8itk62KV1psPgz/GJZAhel0pfH9kxVX3nqvdxrb0mv11PVrLLqYdfFrXlnM?=
 =?us-ascii?Q?3XdFlFNjCDlgNKX40xgFgDwzOrIRXt7Mp9sSywHeMB5PnrnF2FwN5iqsaneS?=
 =?us-ascii?Q?KvUSFlC35fZDAWwTDULtsFnjOoMPJ5ilSA6M+A18n5ConbMAonf8kEo6WAQJ?=
 =?us-ascii?Q?GRVZKPMD7Y/MGDwMyq8+UuPIOF6HaGUO10HI2XtirAOi1A9ojLlDTpiem9HU?=
 =?us-ascii?Q?2eN8oic/d8YFnGVtN2LoRj5LQ6/AS2s0e6SzPYSgYSKjwdp3YwOOMjaimZ8P?=
 =?us-ascii?Q?L745NCA3YXKAKwmeWcMxoVvq30LAmWwfPBm/1um+bj5I52GRGJiOwbZfSq0b?=
 =?us-ascii?Q?jdyMrrWJ9+jsVaViS2FIQt4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a89bda74-17c3-44bd-a7e5-08de18dff606
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:32.0465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epPdFkGPPuQlHFuaIPjs0VM1fq6a9oNJcx192eHCx/xdNLx96xZ6zgkFy0s/HPlUTTvpjCSqw8p/BLvQHRdKZZVzYZWyxBwtFrbadVDWlOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
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

This patch adds spinand flashes support to en7523 dts

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index e22938ac5d7..90838c00a85 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -43,6 +43,26 @@
 		compatible = "airoha,en7523-switch";
 		reg = <0x1fb58000 0x8000>;
 	};
+
+	snfi: spi@1fa10000 {
+		compatible = "airoha,en7523-snand", "airoha,en7581-snand";
+		reg = <0x1fa10000 0x140>,
+		      <0x1fa11000 0x600>;
+
+		clocks = <&scu EN7523_CLK_SPI>;
+		clock-names = "spi";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		spi_nand: nand@0 {
+			compatible = "spi-nand";
+			reg = <0>;
+			spi-max-frequency = <50000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.51.0

