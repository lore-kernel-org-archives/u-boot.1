Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F6BC54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5032880D7;
	Thu, 29 Feb 2024 15:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="kJAveIUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A961B880D5; Thu, 29 Feb 2024 15:21:23 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A60C4880D7
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TEGl6b018534; Thu, 29 Feb 2024 14:21:14 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wjuj380gr-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGmSi2ZpcCKeiuvQp4BO2vHThDUqxbi1ahEkjlH7nKP+jkBeLvDe3LDztZ/66+mZDL2nzne7BO4KsJ0+HW46ilSLWXkyAsPdI+kHVgzS/qKhXKfJTZsjzXAeMSdnzeCy+CQH08BTjq2ZGiSQsfLJCCobCzw8b69AGsYKna7GgREEuluNwRDjD6x5ZA4KE/FbH5pa88v5X5dwBSYceaUU9mz7EAyw8O65Lx1igznXVxsVxFszeBfXyX4QoAAHEYW5iJquYGnXmUoaC/4e3cgGhTPZ7KK7Iscx3E9l97Aw3mVv/iPmoLcukln2xfmuCLW4T1/DkxTAuWt/Ib3d5U20uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mchtusPVyuxpw0CJz3+M+UJtwWdJWGaRcdbDorKaVI0=;
 b=UnBFI71uXvN1CPKp8QlMID8FHur/kJ80spQWXa58ASMAnWENz+dTsn9u9rs+4bPmpqlD6XL+9EZpl/M/X4HEDKkfPdrsYFCAIiq2JdOtyZsDyijH6+rHKlhBPKtDzB9lv1i8FtBU9uUIl1tiQRIBjXWbrnganWaR9lSl+NUB1biFMU3i1RXH2NHJoKlBIVkEjWtElEbWJudcA4GqiRKK0Ke5lqakzN6aM1FII/YVRYRo6cc48mCxgBKas9XX+ctSF9Y/+0Ho64QwG7PMw1Ruk9R8D+oMVKRzJ5oks7AF3YbXGHJVX/cDV63ybqqG4exWU3uA1eGq+XSCBMaXXmLAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mchtusPVyuxpw0CJz3+M+UJtwWdJWGaRcdbDorKaVI0=;
 b=kJAveIURsnVlAQzr3hJQMVoxKB4SCjla8rCSGTyrRt7mZOfnRsUUobJMED600s2LNLrGBsue7RysU8lPRzLqQzoQVoEy1ugvQmoA6TOTW36hYeoTE2P5v1uE3avry45vPdZvdiqDaMRNQF4x7v7qbO6h+VKMduailRPTKJNoky+WbCvkQKk4B1JyDC9xKyfD1ZY+Cue6+8NxgChwY7MmD2G4lwau3IIR+AiA5iyawe4xsGnzt2rIxmuB7MOhmAbL6v+DhXmV23bK54ZljykcXZSWakKqq9ylTHHrDCHLO4jJfMXWyJ+ketHypFVC6NW9jCmcQMK63Y1rhUkwXHJEcQ==
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com (2603:10a6:10:516::14)
 by AS8PR03MB7735.eurprd03.prod.outlook.com (2603:10a6:20b:405::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 14:21:08 +0000
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c]) by DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:21:08 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 5/8] clk: qcom: add driver for SM8150 SoC
Thread-Topic: [PATCH 5/8] clk: qcom: add driver for SM8150 SoC
Thread-Index: AQHaaxqJOA4ENkIqJ0y0V3cEXU8mPA==
Date: Thu, 29 Feb 2024 14:21:08 +0000
Message-ID: <20240229142043.1263690-6-volodymyr_babchuk@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: 5883a5a8-2ff4-4468-fd3e-08dc3931ac65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xf2Awkdmn0IgVeWfaY7cItiEwElikr13Gq4WFBUfUW2d2i0Ys3HNCn9a/d2u7J7koFFTabb8BW/royYDM4whzTHdQDs798Xcdy5ZEaA7hE29k411ort6hrF0d9N0uMfHLF7K9j36sIWWbpzc9pYtJQ8cHUaHpfNQsEWeH9Qs5Bv4yO+Bq0d/zAvJXgimyNsLpMskdO73MgmRUV+QAn2Z4WOQtKKRh7xE0RFjrIpmJ1vigajCIUS1hnTBxOyixC+5jeNEnvTWsyDEGZnsEZc31KE+hftiStFBRvSw9wvYYLxEo0uevrNPkpu9QiLMPx8D1osEeQyjMA8RxPGGyNGUTA8u9aPLTwDoM0XrAdYZuId8dfymieXjGgfgTIhn5JTNC2mEjB1eem3WqS56VWStujgJ/5R52Et/oqs79GeJR4VUCaysQYjzMDgKjMpmBlz3jg0ORH7xoibQe6zXsuLhIr7C+uxIcvCSDbmFROirAA3Qq+4rbKMbSFSecyhauNf/I8VQPoBokoRNNB4f4Gp/8lYrxKryna57MNvT9yvc1Qo3GpNYlBnKbvaDbYErwHfBMdA2cUQTkR747k5eifWydatH6CvS2luKERz8KrRH7k+3ARwAj+V32KQFLrJ9iSm6ASOl9TcZyC6yQW6gTyCpBKgycK064vuYzfkRJSoD0JLqOJYRoHG6+IcbdHYkadjnGeIVxipsggHjhKAk+ixJqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iVmOvnOPcOANzYDlr96W4NuAo3Nge2MvO/LMY3SnS55KTiFgOi5qoq6n2V?=
 =?iso-8859-1?Q?Jvmy6TH2z81PXDydyso5VgcrvQKHM1rYYJ3DWIw7qNM5X/amJYtPXDXXaP?=
 =?iso-8859-1?Q?0J64zNfGxdnRIyLshdXmR24TXf6NNETmG/F5Uod1sf5A+706tRoIZSqaY6?=
 =?iso-8859-1?Q?HHvxg2X5DiPFp3JLzVgdTfkek4MRWls7nLeFKrgT5oHF5QzbOhwNweMr8k?=
 =?iso-8859-1?Q?eaQublcP0RS9m0F63IGKZKcOcfG+VIcMj1qlMdnOw/ymEOzyfN8uKfFOKk?=
 =?iso-8859-1?Q?Gd2ZlC8SWt25bbjxUiZmexFISTe/bnBnYXkz19mKO9CJFBaDB8JcgwJVH5?=
 =?iso-8859-1?Q?sjJpH55FVD+8QPttqSYIdyHpJOuwXuIJznlVhQv8oZnLvVw57bi7urKlFn?=
 =?iso-8859-1?Q?JwkFWg8Dr/lfY4LdZeT1nTEygM9YBms+2EvtKZuorRK1cxZKI3QOVAWviq?=
 =?iso-8859-1?Q?KYebavphf28qV1pJO28ljDs2WhkCmOhkome7hKsr+gh22XwNBIKvgHkVss?=
 =?iso-8859-1?Q?y8CPmv2nQrqXberae7/U0KtzKzCfN0hcyEYgWLW27h8Jcazcts5cuGtXrq?=
 =?iso-8859-1?Q?FBS6GZO9S4oswT38DGAqXMQI+fQhvtqg0x2XymXFmQI6B8dFXl/zqHF3np?=
 =?iso-8859-1?Q?1HP6HKVzMgxyo8VaumCfTb8Age344iNcxz9xm7DnvbQ9+9NFFKmConiQAF?=
 =?iso-8859-1?Q?lbySh+Z5+r2e/4ocAuuPmJYND0j+abHDICKan+ziIR3gwZZeRkCBv8Fpql?=
 =?iso-8859-1?Q?k6CWY7oExC9LnqO5e0lkNmhnKcyuWMaqYKwaqicBJyg5lPWLjbc6m6shpz?=
 =?iso-8859-1?Q?h7q2KqamHmRBohSDqWRx+WDAbY8/Nvb/ANIoo82pIvl4N/mPrGwiPP/My4?=
 =?iso-8859-1?Q?17QqqcZPVDp/soAwryZfLHc9xpc6Gh5Wg3pWHklSmVCg6d6SXzuOxjHkJz?=
 =?iso-8859-1?Q?oT6LHK9EZ5FkWIv0soc50gt1V/KZMTw5rwO+aTAjShVqiL+B+VRoC1ZcJY?=
 =?iso-8859-1?Q?IgSHZhz1dunLFvG7MRaw92rYina/qJ8ty1zz3Hj8AMThR3ZQ4C1bdZMwtf?=
 =?iso-8859-1?Q?1qnK8Zgm2EPnWX17oGSACFlc39Ji8aS/icKtKzAhFsPvMUS4tKNRFIeYYA?=
 =?iso-8859-1?Q?TyvKP8/d0oCRJjtolKTSLk/1rJ7qPfBlFx/j2GArwLWmCDEo1sbmJjJuXd?=
 =?iso-8859-1?Q?3SOZyUui3nB0cun121koFNfYjqzbH6PXeB4z5V/wVj5e5LIopnCBS2JgAv?=
 =?iso-8859-1?Q?4R+L9X2Ad4PD7gH2Rg0ej7aAClBER9xctNnrocPkJ8fFLbFWs2zBd31vhk?=
 =?iso-8859-1?Q?+Y2Lg1bpHr1PwWDF+c5Gg2yIyCsuxqMdGxKETDeVXijGolKhvroWxmwa7O?=
 =?iso-8859-1?Q?dzn3aSDvQJhxnmm3o5vyLWDRdNWYIegLNeT3Q6HJK/3SELmsAj+/PSQJzO?=
 =?iso-8859-1?Q?6eIQp4ybvA0yIcKXu+lkeuW8NuH71YvbPN61oXFimjdwhEkPdk/wl+uCor?=
 =?iso-8859-1?Q?qoyAAZVSomPy+C+I1spupLxRMws72Ru3VX7D3vbVSbk4qURSjBp9+9Omki?=
 =?iso-8859-1?Q?AyKRxK58QRih6+/zD1ogPv6m1kUIPUA4LTzPsXDNoeCkbAwiQHfmKF67nl?=
 =?iso-8859-1?Q?sYGER0d4nh0GRjCz3vXZmj5qUFuS1kj3A83gTxC2stKlxda1oHdA6wCg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5883a5a8-2ff4-4468-fd3e-08dc3931ac65
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:08.5136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZsGIE+HO0LnYCPXS87orVduYSLVHmMz0HOvkkPC3HLjRB3ZHb7WNpTDqUTvX2+P7O3ihej0ewMw2RdYbe2wzGEzVTtQzxs83xqWtS/u8r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: vsyJvuYnakdWvslwFLh4zhOZKcqvrRvo
X-Proofpoint-ORIG-GUID: vsyJvuYnakdWvslwFLh4zhOZKcqvrRvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290110
X-Mailman-Approved-At: Thu, 29 Feb 2024 15:22:15 +0100
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

Add clock, reset and power domain driver for SM8150. Driver code is
based on the similar U-Boot drivers. All constants are taken from the
corresponding Linux driver.

This driver supports clock rate setting only for the debug UART and
RGMII/Ethernet modules, because this is all I can test right now.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-qcom.h   |   1 +
 drivers/clk/qcom/clock-sm8150.c | 234 ++++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sm8150.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0df0d1881a..18ccf6a45e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_SDM845
 	  on the Snapdragon 845 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
=20
+config CLK_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon 8150 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
=20
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index cb179fdac5..12c09ba19e 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) +=3D clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) +=3D clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) +=3D clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCS404) +=3D clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_SM8150) +=3D clock-sm8150.o
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 12a1eaec2b..41107df216 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -9,6 +9,7 @@
=20
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
+#define CFG_CLK_SRC_GPLL7_MAIN (3 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
=20
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm815=
0.c
new file mode 100644
index 0000000000..e23dbccdd3
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm8150.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm SM8150
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ *
+ * Based on U-Boot driver for SDM845. Constants are taken from the Linux d=
river.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sm8150.h>
+
+#include "clock-qcom.h"
+
+static struct pll_vote_clk gpll7_vote_clk =3D {
+	.status =3D 0x1a000,
+	.status_bit =3D BIT(31),
+	.ena_vote =3D 0x52000,
+	.vote_bit =3D BIT(7),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] =3D {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_EVEN, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_EVEN, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL0, 1, 16, 75),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac_rgmii_clk_src[] =3D {
+	F(2500000, CFG_CLK_SRC_CXO, 1, 25, 192),
+	F(5000000, CFG_CLK_SRC_CXO, 1, 25, 96),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(125000000, CFG_CLK_SRC_GPLL7_MAIN, 4, 0, 0),
+	F(250000000, CFG_CLK_SRC_GPLL7_MAIN, 2, 0, 0),
+	{ }
+};
+
+static const struct bcr_regs uart2_regs =3D {
+	.cfg_rcgr =3D 0x1814C,
+	.cmd_rcgr =3D 0x18148,
+	.M =3D 0x18150,
+	.N =3D 0x18154,
+	.D =3D 0x18158,
+};
+
+static const struct bcr_regs rgmii_regs =3D {
+	.cfg_rcgr =3D 0x6020,
+	.cmd_rcgr =3D 0x601C,
+	.M =3D 0x6024,
+	.N =3D 0x6028,
+	.D =3D 0x602C,
+};
+
+static ulong sm8150_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S4_CLK: /* UART2 aka debug-uart */
+		freq =3D qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_EMAC_RGMII_CLK:
+		freq =3D qcom_find_freq(ftbl_gcc_emac_rgmii_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, &rgmii_regs,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+
+		return freq->freq;
+	default:
+		pr_err("Don't know how to set clk id %ld\n", clk->id);
+		return -ENODEV;
+	}
+}
+
+static const struct gate_clk sm8150_clks[] =3D {
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,		0x5200c, 0x00004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x5200c, 0x00008000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x5200c, 0x00400000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x5200c, 0x00800000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x5200c, 0x02000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x5200c, 0x04000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x5200c, 0x08000000),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x5200c, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x5200c, 0x00000080),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x5200c, 0x00100000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x5200c, 0x00200000),
+	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, 0x00000001),
+	GATE_CLK(GCC_SDCC4_AHB_CLK,			0x16008, 0x00000001),
+	GATE_CLK(GCC_SDCC4_APPS_CLK,			0x16004, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AHB_CLK,			0x75010, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AXI_CLK,			0x7500c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_CLKREF_CLK,		0x8c004, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK,		0x75058, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK,		0x7508c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK,		0x75018, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,		0x750a8, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,		0x75014, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,		0x75054, 0x00000001),
+	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x77018, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770a8, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77014, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77054, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x0f00c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x0f014, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x0f010, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MASTER_CLK,		0x1000c, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK,		0x10014, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK,		0x10010, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,		0x8c008, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x0f04c, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x0f050, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x0f054, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_CLKREF_CLK,		0x8c028, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK,		0x1004c, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK,		0x10054, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK,		0x10050, 0x00000001),
+	GATE_CLK(GCC_EMAC_AXI_CLK,			0x06010, 0x00000001),
+	GATE_CLK(GCC_EMAC_SLV_AHB_CLK,			0x06014, 0x00000001),
+	GATE_CLK(GCC_EMAC_PTP_CLK,			0x06034, 0x00000001),
+	GATE_CLK(GCC_EMAC_RGMII_CLK,			0x06018, 0x00000001),
+};
+
+static int sm8150_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
+
+	clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sm8150_gcc_resets[] =3D {
+	[GCC_EMAC_BCR] =3D { 0x6000 },
+	[GCC_GPU_BCR] =3D { 0x71000 },
+	[GCC_MMSS_BCR] =3D { 0xb000 },
+	[GCC_NPU_BCR] =3D { 0x4d000 },
+	[GCC_PCIE_0_BCR] =3D { 0x6b000 },
+	[GCC_PCIE_0_PHY_BCR] =3D { 0x6c01c },
+	[GCC_PCIE_1_BCR] =3D { 0x8d000 },
+	[GCC_PCIE_1_PHY_BCR] =3D { 0x8e01c },
+	[GCC_PCIE_PHY_BCR] =3D { 0x6f000 },
+	[GCC_PDM_BCR] =3D { 0x33000 },
+	[GCC_PRNG_BCR] =3D { 0x34000 },
+	[GCC_QSPI_BCR] =3D { 0x24008 },
+	[GCC_QUPV3_WRAPPER_0_BCR] =3D { 0x17000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] =3D { 0x18000 },
+	[GCC_QUPV3_WRAPPER_2_BCR] =3D { 0x1e000 },
+	[GCC_QUSB2PHY_PRIM_BCR] =3D { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] =3D { 0x12004 },
+	[GCC_USB3_PHY_PRIM_BCR] =3D { 0x50000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] =3D { 0x50008 },
+	[GCC_USB3_PHY_SEC_BCR] =3D { 0x5000c },
+	[GCC_USB3PHY_PHY_SEC_BCR] =3D { 0x50010 },
+	[GCC_SDCC2_BCR] =3D { 0x14000 },
+	[GCC_SDCC4_BCR] =3D { 0x16000 },
+	[GCC_TSIF_BCR] =3D { 0x36000 },
+	[GCC_UFS_CARD_BCR] =3D { 0x75000 },
+	[GCC_UFS_PHY_BCR] =3D { 0x77000 },
+	[GCC_USB30_PRIM_BCR] =3D { 0xf000 },
+	[GCC_USB30_SEC_BCR] =3D { 0x10000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] =3D { 0x6a000 },
+};
+
+static const struct qcom_power_map sm8150_gcc_power_domains[] =3D {
+	[EMAC_GDSC] =3D { 0x6004 },
+	[PCIE_0_GDSC] =3D { 0x6b004 },
+	[PCIE_1_GDSC] =3D { 0x8d004 },
+	[UFS_CARD_GDSC] =3D { 0x75004 },
+	[UFS_PHY_GDSC] =3D { 0x7704 },
+	[USB30_PRIM_GDSC] =3D { 0x6004 },
+	[USB30_SEC_GDSC] =3D { 0x10004 },
+};
+
+
+static struct msm_clk_data sm8150_clk_data =3D {
+	.resets =3D sm8150_gcc_resets,
+	.num_resets =3D ARRAY_SIZE(sm8150_gcc_resets),
+	.clks =3D sm8150_clks,
+	.num_clks =3D ARRAY_SIZE(sm8150_clks),
+	.power_domains =3D sm8150_gcc_power_domains,
+	.num_power_domains =3D ARRAY_SIZE(sm8150_gcc_power_domains),
+
+	.enable =3D sm8150_clk_enable,
+	.set_rate =3D sm8150_clk_set_rate,
+};
+
+static const struct udevice_id gcc_sm8150_of_match[] =3D {
+	{
+		.compatible =3D "qcom,gcc-sm8150",
+		.data =3D (ulong)&sm8150_clk_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sm8150) =3D {
+	.name		=3D "gcc_sm8150",
+	.id		=3D UCLASS_NOP,
+	.of_match	=3D gcc_sm8150_of_match,
+	.bind		=3D qcom_cc_bind,
+	.flags		=3D DM_FLAG_PRE_RELOC,
+};
--=20
2.43.0
