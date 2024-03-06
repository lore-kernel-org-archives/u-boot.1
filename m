Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBECC54798
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0A287E1E;
	Wed,  6 Mar 2024 02:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="EfKQr2cQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDE587D35; Wed,  6 Mar 2024 01:53:16 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C765F87D33
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425FtP8t019808; Wed, 6 Mar 2024 00:53:10 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wp390jh44-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fczvLzH/54SVCa9RbSUP5ok94G+aKblKcXA7r3bjAbRaPXNnfGhhIHgFZ7ifjwfqwFW+NetehkcCGHajtVhTIHoeZpYOwcAtLFBdElSvwuysL3hv7GtykAGsJkPeMoHZW285UbdZ1j+TXIPOrmAlvR9sDDnlwVJCtQTfZ0znEkDaQeA5GkA5w9Tzyi73KLbogw2S1pY4/rD2ry/53Mz7QGdulJUeuJXiooJIp2HWyTeS5wA9L2A5q8yeM1f7miwZ4tPh7FPj5xMxyr5zgB4F3iJKKEtOuSexijM3f/wLyqFjz48sIPzTahHCYmdAxQuC2YLD6NK98tdd0TKXy8qATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFm0Gg4Z7t8dpHPr0tXo5cnFyBFbsdAEw0JzvZOiutw=;
 b=SJNDDOYTCRKOWXF3VhTpKnpj3rgg9hBxOECUW1pU5g6T3ePGMpRA922zHBbMCQL8Zeg1pon8LA+L3IVd2cmegT1hz/h993IkoQsJuT4D95YgZLYQKfrDGYXIrCPyD1YWvjTOzkkwM5FRb52t/eqCvKGxIR60o1V/Md0cE/WKaaIJsz96G5Ky9jzwmCwNQiqLj4lFhEo9ErDBLmH8XUawvvBhq/60LZEHHQldFbEJTtuISgr+NCB52mQlei6w9+1pgvTQxkHpUtMB/y0GC+d+Bf7nXLhFv5MLmNiCkkMqJEYr1HSga5dsRCvNhhSDmWC29yb5r4Iuawlntyhd/NYgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFm0Gg4Z7t8dpHPr0tXo5cnFyBFbsdAEw0JzvZOiutw=;
 b=EfKQr2cQNMmT8x2FAB6Q74GvV8X20XUSv4HMdGO6NliTKmTjURG00AV5CRjVwZ++dMBhuii50KN/82CPcUVWIB40hXQq8C++OXito/vPV0RFFSqX32VB9qAA99HAJFlOvet+lF3xsvWDe/w1fZ5eoO5VY07qpN/pkOXxLU+g4u7G9NzAqZwsI3Vf30Q+GWYhgMFn5QGOnjH9bwxAtePb5BD58vfKXpl5qhtth3DFTxWKdIEJydrmH2foPeL79Jyi/REVAyJqFrQwUbKVOIAf5q0YH2olZLZkUEPfW24eI6onFmGu4Up57XuxZsoy41jGctVfxawRtB+fkO0VfwQfgg==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9801.eurprd03.prod.outlook.com
 (2603:10a6:10:44b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 00:53:05 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:53:05 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/8] pinctrl: qcom: add driver for SM8150 SoC
Thread-Topic: [PATCH v2 7/8] pinctrl: qcom: add driver for SM8150 SoC
Thread-Index: AQHab2CjG+br7CNEjkytw3VRFyZVEQ==
Date: Wed, 6 Mar 2024 00:53:01 +0000
Message-ID: <20240306005230.2638972-8-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: 1164b8ee-6fad-4d50-f75b-08dc3d77c869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ym25mxGAdTUn3Ly5D6gfQw+m8hXpiVqzmry4ncaNknBj2cTNKoF0yGLRPe/BzY5grPRblrtgM1WG43+RaaFlBhrnrnlqkRyPucZYsKby9dWyZmDjrWH2X2Bp86lDCais3hZl/b1weeNgUBh6iBZ85cZSbyktnXlz/Co+N/ZUMqUTf1nO7tit3Xxz9804zZUmRqkchs3GMre3RweH2oBHJn3q1loozl4KPFdb0yNJdlNEO1L+hVzxIMnz5JBfR0ZWN25ZNAjoEafvmYEdX6vHNU4W8AH7O8uvZAAmxydnxrczybPYumGHOmIFpqfejUU4cyTSpQWlLcNqyXcuiqF3UxPM5cZUQ9dDAvgxe0zhdL9ErgrFrgtJH5uoR9gXjyziX8b3SM8xu3N8cPRdRWMwnpgCGk35aJvVWE7yv0bl4tXgscgEez37YIKi6i/afQaSacBPuzwXAYVrPFvgU2eOfKILd65CzvwEt2UcwoUyZWXE9BiJX2ymE6PRQA9fw2SDSjNkimo7iEiabNX27ZrH1JSKOPcGACTTp+joVBfoP65EKtwB8P61vUxfM3flXttRdR7sh22VyouL1nZikm7IntsWgPmlH9k5jJtGj5aM8epWSK78chUhsrtf15iPKrfw633CQ2OAhl4qEUhIYO7djv6j1vje4zRZoVgEpuU8612Y2hANBXdmie/2uISUuvxOB5EMXuqr0Jh2eaItOaxuyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NcFmKJREVu+n3B+aYTPbvhaFbCXoi92pJWzFnW5eYgYUdfmFUGvKTPukay?=
 =?iso-8859-1?Q?4+bfuHz/UHTEC+Q1u/irhPCbYbj1SRZcyONT7fgf3DZ0FLREQGT3ox+uos?=
 =?iso-8859-1?Q?l6jQMzmtZdFbmCvGwefqvg8e0CmUpzL/dmW8RxTINAOP7uiXluCZ14ptvD?=
 =?iso-8859-1?Q?6C57OY9htjYZGTCQA2wFWcMvdaf/vKdFRayPIAreaz2RHcEfEl4eXXkFi4?=
 =?iso-8859-1?Q?y39FobCPBTma2QmdnGJsPyifNMR9JqVqyLVC1G4Zav/c/L6NJm8XLlTtyi?=
 =?iso-8859-1?Q?+hjh3l0Xx2IRzN8i/yhKq0+iFH9sV/aKTcwApRSeEVm/cYQrN9LSS12KQC?=
 =?iso-8859-1?Q?Cd9Cv/I4Yus9T13QhCAlfNhm1jC9k4+D1DiNU2ILnFi9VBsOXbk4QRlkDZ?=
 =?iso-8859-1?Q?T3c3lMViHt8tAhMC5U7+l13bMNpX4iRfzn+xJN20f4X4ctbaO7THVMnFap?=
 =?iso-8859-1?Q?rJ8wt3iWqgefKnsoUzzkECiXuvEpq3xSm1s7VFv48B+jsLeSp+7bpOI6bK?=
 =?iso-8859-1?Q?A6bdD0UszDXYz4FD4WeYQ3Cb5BMiF+Yl7CrJcpXTpQ4PSf0p+OnNGy/8UW?=
 =?iso-8859-1?Q?lHb2/UK6I7ewbgwwH3LT1VdFfwCx7rvWdxM5gzopoiNxovNpvWzUHq2G9N?=
 =?iso-8859-1?Q?qqPCCE9ltE1eg4oKViGcDGIDkO7kf3BeHLv2zhSV/6cmowy5l3llQykpeM?=
 =?iso-8859-1?Q?IS3R5pfhpEAEDbjZ2EqEfjFEZYGeZgO6CpPxLsQeMLhiQlXxHPfyvURXiZ?=
 =?iso-8859-1?Q?89XkGMjqe4EAXu6ASvpm/mywCMJ6WZOJmHYsL6L5bsfJ8wgG58Tvygbr6d?=
 =?iso-8859-1?Q?/pZ61+65yJyYMctXb4Q/+DBGUaNlRn4Zr4H+KGwa05Hx0sJ6iK7HvGyB8B?=
 =?iso-8859-1?Q?r4yT4J0KqqGEeWW436IUwzZOYh628WpMbk/mUVN2Lh4WlVZntcHtL2xCS1?=
 =?iso-8859-1?Q?/K6TwTqCZDPaKbGUg/beT44JxjwzlAZ3VdocxNQg6growkYWC2bgFrmyTy?=
 =?iso-8859-1?Q?4cEPzQOBS81Q0xOSIJNEwQF5si0ZUOp8u8e1Oa9+uTOGyVU9AHYuwerT4N?=
 =?iso-8859-1?Q?9cK67eLOkQycoAeLilKf8t4cXIodYGe7/RyU888dChgPjhAv/vLswnDkuN?=
 =?iso-8859-1?Q?Zc/hLGp3Wp1cgiUbbA81y8CzqoWV0Z4lFNKlaU5nxCEEsZM5eMKCx6C6D/?=
 =?iso-8859-1?Q?89p/ScsJIEJ9vT1dwaHudSg45OpKGCb5b3c4IaVLkG11J9Eh7ZVnSAZ1Yy?=
 =?iso-8859-1?Q?8QhUCBig223pWWX4n8izsK3oiMi8D37/+gsJVJfx9tB1PgCMir1/BIqSBY?=
 =?iso-8859-1?Q?BdX+x4w2EGr8FxA1ETqOj8mni1ywBSUfgHZfgBC7BGRcH5XqTJmCY25wDX?=
 =?iso-8859-1?Q?8S0oOZ/HGgiCC6F7LkXdvNBvOSzqtsOnkJWEb9vwRvD1ltfEKT2nVhgg5Q?=
 =?iso-8859-1?Q?gEhbWW30KhI/DkqQad+u0t9nDaMVsgcNslKGtBQfqy9UMeRm+PKP3YgBgM?=
 =?iso-8859-1?Q?2wCN7FnA7uR680dY3XYgSs+jcoWhxQFHWDoAZIboWKtCd+Bk3s7n5BOE3D?=
 =?iso-8859-1?Q?0p/2lbmOlFuze/OqtBGusNzmpYfP23Hijl+bk1eHVvvGwhSbePjivqhhvR?=
 =?iso-8859-1?Q?SirIkamOm04k7eQ0UcKmPgqzZZVx2i48k6MM3ewvCgros4Y/HHd86nQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1164b8ee-6fad-4d50-f75b-08dc3d77c869
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:53:01.1809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GqjvzYveZV49rHqyW75yclbzdli4pdC9uOh2vgYuFPrn0cqGKudvCYhVB0tsc/zkuo5q7JM+HAKqjJmpPxmX0hYKpEPPJE5mZhrg/Di/98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-ORIG-GUID: 41AcGQjRpOtYEpCnBZE3rqbQqGI9IiOX
X-Proofpoint-GUID: 41AcGQjRpOtYEpCnBZE3rqbQqGI9IiOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060005
X-Mailman-Approved-At: Wed, 06 Mar 2024 02:16:00 +0100
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

Add pinctrl and GPIO driver for SM8150. Driver code is based on the
similar U-Boot drivers. All constants are taken from the corresponding
Linux driver. This drivers differs from the similar U-Boot drivers,
because SM8150 SoC have different function IDs for the same functions
on different pins.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

(no changes since v1)

 drivers/pinctrl/qcom/Kconfig          |   7 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sm8150.c | 589 ++++++++++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2fe6398147..290cefca47 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -41,6 +41,13 @@ config PINCTRL_QCOM_SDM845
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
=20
+config PINCTRL_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
+	  as well as the associated GPIO driver.
+
 endmenu
=20
 endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6d9aca6d7b..3c7be4a685 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) +=3D pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) +=3D pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) +=3D pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) +=3D pinctrl-sdm845.o
+obj-$(CONFIG_PINCTRL_QCOM_SM8150) +=3D pinctrl-sm8150.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/p=
inctrl-sm8150.c
new file mode 100644
index 0000000000..a6c14d7254
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Qualcomm SM8150 pinctrl and GPIO driver
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ *
+ * Based on similar U-Boot drivers. Constants were taken from the Linux dr=
iver
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define WEST	0x00100000
+#define EAST	0x00500000
+#define NORTH	0x00900000
+#define SOUTH	0x00D00000
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum sm8150_functions {
+	msm_mux_adsp_ext,
+	msm_mux_agera_pll,
+	msm_mux_aoss_cti,
+	msm_mux_atest_char,
+	msm_mux_atest_char0,
+	msm_mux_atest_char1,
+	msm_mux_atest_char2,
+	msm_mux_atest_char3,
+	msm_mux_atest_usb1,
+	msm_mux_atest_usb2,
+	msm_mux_atest_usb10,
+	msm_mux_atest_usb11,
+	msm_mux_atest_usb12,
+	msm_mux_atest_usb13,
+	msm_mux_atest_usb20,
+	msm_mux_atest_usb21,
+	msm_mux_atest_usb22,
+	msm_mux_atest_usb23,
+	msm_mux_audio_ref,
+	msm_mux_btfm_slimbus,
+	msm_mux_cam_mclk,
+	msm_mux_cci_async,
+	msm_mux_cci_i2c,
+	msm_mux_cci_timer0,
+	msm_mux_cci_timer1,
+	msm_mux_cci_timer2,
+	msm_mux_cci_timer3,
+	msm_mux_cci_timer4,
+	msm_mux_cri_trng,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_dbg_out,
+	msm_mux_ddr_bist,
+	msm_mux_ddr_pxi0,
+	msm_mux_ddr_pxi1,
+	msm_mux_ddr_pxi2,
+	msm_mux_ddr_pxi3,
+	msm_mux_edp_hot,
+	msm_mux_edp_lcd,
+	msm_mux_emac_phy,
+	msm_mux_emac_pps,
+	msm_mux_gcc_gp1,
+	msm_mux_gcc_gp2,
+	msm_mux_gcc_gp3,
+	msm_mux_gpio,
+	msm_mux_jitter_bist,
+	msm_mux_hs1_mi2s,
+	msm_mux_hs2_mi2s,
+	msm_mux_hs3_mi2s,
+	msm_mux_lpass_slimbus,
+	msm_mux_mdp_vsync,
+	msm_mux_mdp_vsync0,
+	msm_mux_mdp_vsync1,
+	msm_mux_mdp_vsync2,
+	msm_mux_mdp_vsync3,
+	msm_mux_mss_lte,
+	msm_mux_m_voc,
+	msm_mux_nav_pps,
+	msm_mux_pa_indicator,
+	msm_mux_pci_e0,
+	msm_mux_pci_e1,
+	msm_mux_phase_flag,
+	msm_mux_pll_bist,
+	msm_mux_pll_bypassnl,
+	msm_mux_pll_reset,
+	msm_mux_pri_mi2s,
+	msm_mux_pri_mi2s_ws,
+	msm_mux_prng_rosc,
+	msm_mux_qdss,
+	msm_mux_qdss_cti,
+	msm_mux_qlink_enable,
+	msm_mux_qlink_request,
+	msm_mux_qspi0,
+	msm_mux_qspi1,
+	msm_mux_qspi2,
+	msm_mux_qspi3,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs,
+	msm_mux_qua_mi2s,
+	msm_mux_qup0,
+	msm_mux_qup1,
+	msm_mux_qup2,
+	msm_mux_qup3,
+	msm_mux_qup4,
+	msm_mux_qup5,
+	msm_mux_qup6,
+	msm_mux_qup7,
+	msm_mux_qup8,
+	msm_mux_qup9,
+	msm_mux_qup10,
+	msm_mux_qup11,
+	msm_mux_qup12,
+	msm_mux_qup13,
+	msm_mux_qup14,
+	msm_mux_qup15,
+	msm_mux_qup16,
+	msm_mux_qup17,
+	msm_mux_qup18,
+	msm_mux_qup19,
+	msm_mux_qup_l4,
+	msm_mux_qup_l5,
+	msm_mux_qup_l6,
+	msm_mux_rgmii,
+	msm_mux_sdc4,
+	msm_mux_sd_write,
+	msm_mux_sec_mi2s,
+	msm_mux_spkr_i2s,
+	msm_mux_sp_cmu,
+	msm_mux_ter_mi2s,
+	msm_mux_tgu_ch0,
+	msm_mux_tgu_ch2,
+	msm_mux_tgu_ch1,
+	msm_mux_tgu_ch3,
+	msm_mux_tsense_pwm1,
+	msm_mux_tsense_pwm2,
+	msm_mux_tsif1,
+	msm_mux_tsif2,
+	msm_mux_uim1,
+	msm_mux_uim2,
+	msm_mux_uim_batt,
+	msm_mux_usb2phy_ac,
+	msm_mux_usb_phy,
+	msm_mux_vfr_1,
+	msm_mux_vsense_trigger,
+	msm_mux_wlan1_adc1,
+	msm_mux_wlan1_adc0,
+	msm_mux_wlan2_adc1,
+	msm_mux_wlan2_adc0,
+	msm_mux_wmss_reset,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] =3D {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] =3D {
+	MSM_PIN_FUNCTION(adsp_ext),
+	MSM_PIN_FUNCTION(agera_pll),
+	MSM_PIN_FUNCTION(aoss_cti),
+	MSM_PIN_FUNCTION(ddr_pxi2),
+	MSM_PIN_FUNCTION(atest_char),
+	MSM_PIN_FUNCTION(atest_char0),
+	MSM_PIN_FUNCTION(atest_char1),
+	MSM_PIN_FUNCTION(atest_char2),
+	MSM_PIN_FUNCTION(atest_char3),
+	MSM_PIN_FUNCTION(audio_ref),
+	MSM_PIN_FUNCTION(atest_usb1),
+	MSM_PIN_FUNCTION(atest_usb2),
+	MSM_PIN_FUNCTION(atest_usb10),
+	MSM_PIN_FUNCTION(atest_usb11),
+	MSM_PIN_FUNCTION(atest_usb12),
+	MSM_PIN_FUNCTION(atest_usb13),
+	MSM_PIN_FUNCTION(atest_usb20),
+	MSM_PIN_FUNCTION(atest_usb21),
+	MSM_PIN_FUNCTION(atest_usb22),
+	MSM_PIN_FUNCTION(atest_usb23),
+	MSM_PIN_FUNCTION(btfm_slimbus),
+	MSM_PIN_FUNCTION(cam_mclk),
+	MSM_PIN_FUNCTION(cci_async),
+	MSM_PIN_FUNCTION(cci_i2c),
+	MSM_PIN_FUNCTION(cci_timer0),
+	MSM_PIN_FUNCTION(cci_timer1),
+	MSM_PIN_FUNCTION(cci_timer2),
+	MSM_PIN_FUNCTION(cci_timer3),
+	MSM_PIN_FUNCTION(cci_timer4),
+	MSM_PIN_FUNCTION(cri_trng),
+	MSM_PIN_FUNCTION(cri_trng0),
+	MSM_PIN_FUNCTION(cri_trng1),
+	MSM_PIN_FUNCTION(dbg_out),
+	MSM_PIN_FUNCTION(ddr_bist),
+	MSM_PIN_FUNCTION(ddr_pxi0),
+	MSM_PIN_FUNCTION(ddr_pxi1),
+	MSM_PIN_FUNCTION(ddr_pxi3),
+	MSM_PIN_FUNCTION(edp_hot),
+	MSM_PIN_FUNCTION(edp_lcd),
+	MSM_PIN_FUNCTION(emac_phy),
+	MSM_PIN_FUNCTION(emac_pps),
+	MSM_PIN_FUNCTION(gcc_gp1),
+	MSM_PIN_FUNCTION(gcc_gp2),
+	MSM_PIN_FUNCTION(gcc_gp3),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(hs1_mi2s),
+	MSM_PIN_FUNCTION(hs2_mi2s),
+	MSM_PIN_FUNCTION(hs3_mi2s),
+	MSM_PIN_FUNCTION(jitter_bist),
+	MSM_PIN_FUNCTION(lpass_slimbus),
+	MSM_PIN_FUNCTION(mdp_vsync),
+	MSM_PIN_FUNCTION(mdp_vsync0),
+	MSM_PIN_FUNCTION(mdp_vsync1),
+	MSM_PIN_FUNCTION(mdp_vsync2),
+	MSM_PIN_FUNCTION(mdp_vsync3),
+	MSM_PIN_FUNCTION(mss_lte),
+	MSM_PIN_FUNCTION(m_voc),
+	MSM_PIN_FUNCTION(nav_pps),
+	MSM_PIN_FUNCTION(pa_indicator),
+	MSM_PIN_FUNCTION(pci_e0),
+	MSM_PIN_FUNCTION(phase_flag),
+	MSM_PIN_FUNCTION(pll_bypassnl),
+	MSM_PIN_FUNCTION(pll_bist),
+	MSM_PIN_FUNCTION(pci_e1),
+	MSM_PIN_FUNCTION(pll_reset),
+	MSM_PIN_FUNCTION(pri_mi2s),
+	MSM_PIN_FUNCTION(pri_mi2s_ws),
+	MSM_PIN_FUNCTION(prng_rosc),
+	MSM_PIN_FUNCTION(qdss),
+	MSM_PIN_FUNCTION(qdss_cti),
+	MSM_PIN_FUNCTION(qlink_request),
+	MSM_PIN_FUNCTION(qlink_enable),
+	MSM_PIN_FUNCTION(qspi0),
+	MSM_PIN_FUNCTION(qspi1),
+	MSM_PIN_FUNCTION(qspi2),
+	MSM_PIN_FUNCTION(qspi3),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs),
+	MSM_PIN_FUNCTION(qua_mi2s),
+	MSM_PIN_FUNCTION(qup0),
+	MSM_PIN_FUNCTION(qup1),
+	MSM_PIN_FUNCTION(qup2),
+	MSM_PIN_FUNCTION(qup3),
+	MSM_PIN_FUNCTION(qup4),
+	MSM_PIN_FUNCTION(qup5),
+	MSM_PIN_FUNCTION(qup6),
+	MSM_PIN_FUNCTION(qup7),
+	MSM_PIN_FUNCTION(qup8),
+	MSM_PIN_FUNCTION(qup9),
+	MSM_PIN_FUNCTION(qup10),
+	MSM_PIN_FUNCTION(qup11),
+	MSM_PIN_FUNCTION(qup12),
+	MSM_PIN_FUNCTION(qup13),
+	MSM_PIN_FUNCTION(qup14),
+	MSM_PIN_FUNCTION(qup15),
+	MSM_PIN_FUNCTION(qup16),
+	MSM_PIN_FUNCTION(qup17),
+	MSM_PIN_FUNCTION(qup18),
+	MSM_PIN_FUNCTION(qup19),
+	MSM_PIN_FUNCTION(qup_l4),
+	MSM_PIN_FUNCTION(qup_l5),
+	MSM_PIN_FUNCTION(qup_l6),
+	MSM_PIN_FUNCTION(rgmii),
+	MSM_PIN_FUNCTION(sdc4),
+	MSM_PIN_FUNCTION(sd_write),
+	MSM_PIN_FUNCTION(sec_mi2s),
+	MSM_PIN_FUNCTION(spkr_i2s),
+	MSM_PIN_FUNCTION(sp_cmu),
+	MSM_PIN_FUNCTION(ter_mi2s),
+	MSM_PIN_FUNCTION(tgu_ch0),
+	MSM_PIN_FUNCTION(tgu_ch1),
+	MSM_PIN_FUNCTION(tgu_ch2),
+	MSM_PIN_FUNCTION(tgu_ch3),
+	MSM_PIN_FUNCTION(tsense_pwm1),
+	MSM_PIN_FUNCTION(tsense_pwm2),
+	MSM_PIN_FUNCTION(tsif1),
+	MSM_PIN_FUNCTION(tsif2),
+	MSM_PIN_FUNCTION(uim1),
+	MSM_PIN_FUNCTION(uim2),
+	MSM_PIN_FUNCTION(uim_batt),
+	MSM_PIN_FUNCTION(usb2phy_ac),
+	MSM_PIN_FUNCTION(usb_phy),
+	MSM_PIN_FUNCTION(vfr_1),
+	MSM_PIN_FUNCTION(vsense_trigger),
+	MSM_PIN_FUNCTION(wlan1_adc0),
+	MSM_PIN_FUNCTION(wlan1_adc1),
+	MSM_PIN_FUNCTION(wlan2_adc0),
+	MSM_PIN_FUNCTION(wlan2_adc1),
+	MSM_PIN_FUNCTION(wmss_reset),
+};
+
+static const unsigned int sm8150_pin_offsets[] =3D {
+	[0]   =3D SOUTH, [1]   =3D SOUTH, [2]   =3D SOUTH, [3]   =3D SOUTH,
+	[4]   =3D SOUTH, [5]   =3D SOUTH, [6]   =3D SOUTH, [7]   =3D SOUTH,
+	[8]   =3D NORTH, [9]   =3D NORTH, [10]  =3D NORTH, [11]  =3D NORTH,
+	[12]  =3D NORTH, [13]  =3D NORTH, [14]  =3D NORTH, [15]  =3D NORTH,
+	[16]  =3D NORTH, [17]  =3D NORTH, [18]  =3D NORTH, [19]  =3D NORTH,
+	[20]  =3D NORTH, [21]  =3D EAST,  [22]  =3D EAST,  [23]  =3D EAST,
+	[24]  =3D EAST,  [25]  =3D EAST,  [26]  =3D EAST,  [27]  =3D EAST,
+	[28]  =3D EAST,  [29]  =3D EAST,  [30]  =3D EAST,  [31]  =3D NORTH,
+	[32]  =3D NORTH, [33]  =3D NORTH, [34]  =3D NORTH, [35]  =3D NORTH,
+	[36]  =3D NORTH, [37]  =3D NORTH, [38]  =3D SOUTH, [39]  =3D NORTH,
+	[40]  =3D NORTH, [41]  =3D NORTH, [42]  =3D NORTH, [43]  =3D EAST,
+	[44]  =3D EAST,  [45]  =3D EAST,  [46]  =3D EAST,  [47]  =3D EAST,
+	[48]  =3D EAST,  [49]  =3D EAST,  [50]  =3D EAST,  [51]  =3D SOUTH,
+	[52]  =3D SOUTH, [53]  =3D SOUTH, [54]  =3D SOUTH, [55]  =3D SOUTH,
+	[56]  =3D SOUTH, [57]  =3D SOUTH, [58]  =3D SOUTH, [59]  =3D SOUTH,
+	[60]  =3D SOUTH, [61]  =3D SOUTH, [62]  =3D SOUTH, [63]  =3D SOUTH,
+	[64]  =3D SOUTH, [65]  =3D SOUTH, [66]  =3D SOUTH, [67]  =3D SOUTH,
+	[68]  =3D SOUTH, [69]  =3D SOUTH, [70]  =3D SOUTH, [71]  =3D SOUTH,
+	[72]  =3D SOUTH, [73]  =3D SOUTH, [74]  =3D SOUTH, [75]  =3D SOUTH,
+	[76]  =3D SOUTH, [77]  =3D SOUTH, [78]  =3D SOUTH, [79]  =3D SOUTH,
+	[80]  =3D SOUTH, [81]  =3D SOUTH, [82]  =3D SOUTH, [83]  =3D NORTH,
+	[84]  =3D NORTH, [85]  =3D NORTH, [86]  =3D NORTH, [87]  =3D EAST,
+	[88]  =3D NORTH, [89]  =3D NORTH, [90]  =3D NORTH, [91]  =3D NORTH,
+	[92]  =3D NORTH, [93]  =3D NORTH, [94]  =3D NORTH, [95]  =3D NORTH,
+	[96]  =3D NORTH, [97]  =3D NORTH, [98]  =3D SOUTH, [99]  =3D SOUTH,
+	[100] =3D SOUTH, [101] =3D SOUTH, [102] =3D NORTH, [103] =3D NORTH,
+	[104] =3D NORTH, [105] =3D WEST,  [106] =3D WEST,  [107] =3D WEST,
+	[108] =3D WEST,  [109] =3D WEST,  [110] =3D WEST,  [111] =3D WEST,
+	[112] =3D WEST,  [113] =3D WEST,  [114] =3D SOUTH, [115] =3D SOUTH,
+	[116] =3D SOUTH, [117] =3D SOUTH, [118] =3D SOUTH, [119] =3D SOUTH,
+	[120] =3D SOUTH, [121] =3D SOUTH, [122] =3D SOUTH, [123] =3D SOUTH,
+	[124] =3D SOUTH, [125] =3D WEST,  [126] =3D SOUTH, [127] =3D SOUTH,
+	[128] =3D SOUTH, [129] =3D SOUTH, [130] =3D SOUTH, [131] =3D SOUTH,
+	[132] =3D SOUTH, [133] =3D SOUTH, [134] =3D SOUTH, [135] =3D SOUTH,
+	[136] =3D SOUTH, [137] =3D SOUTH, [138] =3D SOUTH, [139] =3D SOUTH,
+	[140] =3D SOUTH, [141] =3D SOUTH, [142] =3D SOUTH, [143] =3D SOUTH,
+	[144] =3D SOUTH, [145] =3D SOUTH, [146] =3D SOUTH, [147] =3D SOUTH,
+	[148] =3D SOUTH, [149] =3D SOUTH, [150] =3D SOUTH, [151] =3D SOUTH,
+	[152] =3D SOUTH, [153] =3D SOUTH, [154] =3D SOUTH, [155] =3D WEST,
+	[156] =3D WEST,  [157] =3D WEST,  [158] =3D WEST,  [159] =3D WEST,
+	[160] =3D WEST,  [161] =3D WEST,  [162] =3D WEST,  [163] =3D WEST,
+	[164] =3D WEST,  [165] =3D WEST,  [166] =3D WEST,  [167] =3D WEST,
+	[168] =3D WEST,  [169] =3D NORTH, [170] =3D NORTH, [171] =3D NORTH
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
+	[id] =3D {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9			\
+	}
+
+static const msm_pin_function sm8150_pin_functions[] =3D {
+	PINGROUP(0, qup0,  _, _, _, _, _, _, _, _),
+	PINGROUP(1, qup0, _, _, _, _, _, _, _, _),
+	PINGROUP(2, qup0, _, _, _, _, _, _, _, _),
+	PINGROUP(3, qup0, _, _, _, _, _, _, _, _),
+	PINGROUP(4, qup6, rgmii, _, _, _, _, _, _, _),
+	PINGROUP(5, qup6, rgmii, _, _, _, _, _, _, _),
+	PINGROUP(6, qup6, rgmii, qup_l6, _, _, _, _, _, _),
+	PINGROUP(7, qup6, rgmii, qup_l5, _, _, _, _, _, _),
+	PINGROUP(8, mdp_vsync, _, _, _, _, _, _, _, _),
+	PINGROUP(9, mdp_vsync, edp_lcd, qup10, _, _, _, _, _, _),
+	PINGROUP(10, mdp_vsync, m_voc, edp_hot, qup10, _, _, _, _, _),
+	PINGROUP(11, qup10, _, _, _, _, _, _, _, _),
+	PINGROUP(12, qup10, _, _, _, _, _, _, _, _),
+	PINGROUP(13, cam_mclk, qdss, _, _, _, _, _, _, _),
+	PINGROUP(14, cam_mclk, qdss, _, _, _, _, _, _, _),
+	PINGROUP(15, cam_mclk, qdss, _, _, _, _, _, _, _),
+	PINGROUP(16, cam_mclk, qdss, _, _, _, _, _, _, _),
+	PINGROUP(17, cci_i2c, qdss, _, _, _, _, _, _, _),
+	PINGROUP(18, cci_i2c, phase_flag, _, qdss, _, _, _, _, _),
+	PINGROUP(19, cci_i2c, phase_flag, _, qdss, _, _, _, _, _),
+	PINGROUP(20, cci_i2c, phase_flag, _, qdss, _, _, _, _, _),
+	PINGROUP(21, cci_timer0, gcc_gp2, qdss, _, _, _, _, _, _),
+	PINGROUP(22, cci_timer1, gcc_gp3, qdss, _, _, _, _, _, _),
+	PINGROUP(23, cci_timer2, qup18, qdss, _, _, _, _, _, _),
+	PINGROUP(24, cci_timer3, cci_async, qup18, qdss, _, _, _, _, _),
+	PINGROUP(25, cci_timer4, cci_async, qup18, qdss, _, _, _, _, _),
+	PINGROUP(26, cci_async, qup18, qdss, _, _, _, _, _, _),
+	PINGROUP(27, qup15, _, qdss, _, _, _, _, _, _),
+	PINGROUP(28, qup15, qdss, _, _, _, _, _, _, _),
+	PINGROUP(29, qup15, qdss, _, _, _, _, _, _, _),
+	PINGROUP(30, qup15, qdss, _, _, _, _, _, _, _),
+	PINGROUP(31, cci_i2c, qdss, _, _, _, _, _, _, _),
+	PINGROUP(32, cci_i2c, qdss, _, _, _, _, _, _, _),
+	PINGROUP(33, cci_i2c, qup_l5, qdss, _, _, _, _, _, _),
+	PINGROUP(34, cci_i2c, qup_l6, _, _, _, _, _, _, _),
+	PINGROUP(35, pci_e0, _, _, _, _, _, _, _, _),
+	PINGROUP(36, pci_e0, _, _, _, _, _, _, _, _),
+	PINGROUP(37, qup_l4, agera_pll, _, _, _, _, _, _, _),
+	PINGROUP(38, usb_phy, _, _, _, _, _, _, _, _),
+	PINGROUP(39, qup9, qdss, _, _, _, _, _, _, _),
+	PINGROUP(40, qup9, qdss, _, _, _, _, _, _, _),
+	PINGROUP(41, qup9, qdss, _, _, _, _, _, _, _),
+	PINGROUP(42, qup9, qdss, _, _, _, _, _, _, _),
+	PINGROUP(43, qup13, _, _, _, _, _, _, _, _),
+	PINGROUP(44, qup13, _, _, _, _, _, _, _, _),
+	PINGROUP(45, qup13, qdss_cti, _, _, _, _, _, _, _),
+	PINGROUP(46, qup13, qdss_cti, _, _, _, _, _, _, _),
+	PINGROUP(47, qup14, qdss, _, _, _, _, _, _, _),
+	PINGROUP(48, qup14, qdss, _, _, _, _, _, _, _),
+	PINGROUP(49, qup14, _, qdss_cti, _, _, _, _, _, _),
+	PINGROUP(50, qup14, qdss_cti, _, _, _, _, _, _, _),
+	PINGROUP(51, qup4, _, _, _, _, _, _, _, _),
+	PINGROUP(52, qup4, _, _, _, _, _, _, _, _),
+	PINGROUP(53, qup4, _, _, _, _, _, _, _, _),
+	PINGROUP(54, qup4, _, _, _, _, _, _, _, _),
+	PINGROUP(55, qup17, qup19, phase_flag, _, _, _, _, _, _),
+	PINGROUP(56, qup17, qup19, qdss_cti, phase_flag, _, _, _, _, _),
+	PINGROUP(57, qup17, qup19, qdss_cti, phase_flag, _, _, _, _, _),
+	PINGROUP(58, qup17, qup19, qdss_cti, phase_flag, _, _, _, _, _),
+	PINGROUP(59, rgmii, qup_l4, phase_flag, _, atest_char, _, _, _, _),
+	PINGROUP(60, _, nav_pps, nav_pps, atest_usb2, _, _, _, _, _),
+	PINGROUP(61, qlink_request, _, _, _, _, _, _, _, _),
+	PINGROUP(62, qlink_enable, _, _, _, _, _, _, _, _),
+	PINGROUP(63, wmss_reset, atest_usb23, _, _, _, _, _, _, _),
+	PINGROUP(64, _, phase_flag, _, _, _, _, _, _, _),
+	PINGROUP(65, _, _, _, _, _, _, _, _, _),
+	PINGROUP(66, _, _, _, _, _, _, _, _, _),
+	PINGROUP(67, _, _, _, _, _, _, _, _, _),
+	PINGROUP(68, _, pa_indicator, phase_flag, _, _, _, _, _, _),
+	PINGROUP(69, mss_lte, _, _, _, _, _, _, _, _),
+	PINGROUP(70, mss_lte, _, _, _, _, _, _, _, _),
+	PINGROUP(71, _, _, _, _, _, _, _, _, _),
+	PINGROUP(72, _, _, _, _, _, _, _, _, _),
+	PINGROUP(73, _, _, _, _, _, _, _, _, _),
+	PINGROUP(74, _, _, _, _, _, _, _, _, _),
+	PINGROUP(75, _, _, _, _, _, _, _, _, _),
+	PINGROUP(76, _, _, _, nav_pps, nav_pps, phase_flag, _, _, _),
+	PINGROUP(77, _, _, _, nav_pps, nav_pps, _, _, _, _),
+	PINGROUP(78, _, _, _, _, _, _, _, _, _),
+	PINGROUP(79, _, _, phase_flag, _, _, _, _, _, _),
+	PINGROUP(80, _, _, phase_flag, _, _, _, _, _, _),
+	PINGROUP(81, _, _, _, nav_pps, nav_pps, qup_l4, mdp_vsync, emac_pps, _),
+	PINGROUP(82, _, _, _, nav_pps, nav_pps, qup_l5, mdp_vsync, _, _),
+	PINGROUP(83, qup12, qup16, _, qdss, _, _, _, _, _),
+	PINGROUP(84, qup12, qup16, _, _, _, _, _, _, _),
+	PINGROUP(85, qup12, qup16, _, _, _, _, _, _, _),
+	PINGROUP(86, qup12, qup16, _, _, _, _, _, _, _),
+	PINGROUP(87, _, _, _, _, _, _, _, _, _),
+	PINGROUP(88, tsif1, qup8, qspi_cs, tgu_ch3, _, _, _, _, _),
+	PINGROUP(89, tsif1, qup8, qspi0, mdp_vsync0, mdp_vsync1, mdp_vsync2,
+		 mdp_vsync3, tgu_ch0, _),
+	PINGROUP(90, tsif1, qup8, qspi1, sdc4, phase_flag, tgu_ch1, _, _,
+		 wlan1_adc1),
+	PINGROUP(91, tsif1, qup8, qspi2, sdc4, vfr_1, phase_flag, tgu_ch2,
+		 _, _),
+	PINGROUP(92, tsif2, qup11, qspi_clk, sdc4, phase_flag, _, wlan2_adc1,
+		 _, _),
+	PINGROUP(93, tsif2, qup11, qspi3, sdc4, phase_flag, _, wlan2_adc0,
+		 _, _),
+	PINGROUP(94, tsif2, qup11, qspi_cs, sdc4, phase_flag, _, _, _, _),
+	PINGROUP(95, tsif2, qup11, sdc4, qup_l4, _, _, _, _, _),
+	PINGROUP(96, tsif2, qup_l5, phase_flag, _, _, _, _, _, _),
+	PINGROUP(97, sd_write, tsif1, qup_l6, _, _, _, _, _, _),
+	PINGROUP(98, qup7, ddr_bist, ddr_pxi3, _, _, _, _, _, _),
+	PINGROUP(99, qup7, ddr_bist, atest_usb13, ddr_pxi1, _, _, _, _, _),
+	PINGROUP(100, qup7, pll_bypassnl, atest_usb12, ddr_pxi1, _, _, _, _, _),
+	PINGROUP(101, qup7, pll_reset, ddr_pxi3, _, _, _, _, _, _),
+	PINGROUP(102, pci_e1, _, _, _, _, _, _, _, _),
+	PINGROUP(103, pci_e1, _, _, _, _, _, _, _, _),
+	PINGROUP(104, _, _, _, _, _, _, _, _, _),
+	PINGROUP(105, uim2, _, _, _, _, _, _, _, _),
+	PINGROUP(106, uim2, _, _, _, _, _, _, _, _),
+	PINGROUP(107, uim2, _, _, _, _, _, _, _, _),
+	PINGROUP(108, uim2, _, _, _, _, _, _, _, _),
+	PINGROUP(109, uim1, _, _, _, _, _, _, _, _),
+	PINGROUP(110, uim1, _, _, _, _, _, _, _, _),
+	PINGROUP(111, uim1, _, _, _, _, _, _, _, _),
+	PINGROUP(112, uim1, _, _, _, _, _, _, _, _),
+	PINGROUP(113, uim_batt, usb2phy_ac, aoss_cti, _, _, _, _, _, _),
+	PINGROUP(114, qup1, rgmii, phase_flag, _, _, _, _, _, _),
+	PINGROUP(115, qup1, rgmii, phase_flag, adsp_ext, _, _, _, _, _),
+	PINGROUP(116, qup1, rgmii, phase_flag, _, _, _, _, _, _),
+	PINGROUP(117, qup1, rgmii, phase_flag, _, qdss, _, _, _, _),
+	PINGROUP(118, rgmii, phase_flag, _, qdss, _, _, _, _, _),
+	PINGROUP(119, qup5, rgmii, phase_flag, _, qdss, _, _, _, _),
+	PINGROUP(120, qup5, rgmii, phase_flag, _, qdss, _, _, _, _),
+	PINGROUP(121, qup5, rgmii, phase_flag, _, qdss, _, _, _, _),
+	PINGROUP(122, qup5, rgmii, phase_flag, _, _, _, _, _, _),
+	PINGROUP(123, usb2phy_ac, qup_l6, atest_usb22, _, _, _, _, _, _),
+	PINGROUP(124, emac_phy, _, _, _, _, _, _, _, _),
+	PINGROUP(125, hs3_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(126, sec_mi2s, qup2, phase_flag, _, _, _, _, _, _),
+	PINGROUP(127, sec_mi2s, qup2, phase_flag, _, _, _, _, _, _),
+	PINGROUP(128, sec_mi2s, qup2, phase_flag, _, _, _, _, _, _),
+	PINGROUP(129, sec_mi2s, qup2, jitter_bist, atest_usb21, _, _, _, _, _),
+	PINGROUP(130, sec_mi2s, pll_bist, atest_usb20, atest_char0,
+		 _, _, _, _, _),
+	PINGROUP(131, ter_mi2s, gcc_gp1, _, _, _, _, _, _, _),
+	PINGROUP(132, ter_mi2s, _, qdss, _, _, _, _, _, _),
+	PINGROUP(133, ter_mi2s, qdss, atest_char1, _, _, _, _, _, _),
+	PINGROUP(134, ter_mi2s, qdss, atest_char2, _, _, _, _, _, _),
+	PINGROUP(135, ter_mi2s, atest_char3, _, _, _, _, _, _, _),
+	PINGROUP(136, qua_mi2s, gcc_gp1, _, _, _, _, _, _, _),
+	PINGROUP(137, qua_mi2s, gcc_gp2, _, _, _, _, _, _, _),
+	PINGROUP(138, qua_mi2s, gcc_gp3, _, _, _, _, _, _, _),
+	PINGROUP(139, qua_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(140, qua_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(141, qua_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(142, qua_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(143, pri_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(144, pri_mi2s, qup3, phase_flag, _, ddr_pxi0, _, _, _, _),
+	PINGROUP(145, pri_mi2s_ws, qup3, phase_flag, ddr_bist, _,
+		 vsense_trigger, atest_usb1, ddr_pxi0, _),
+	PINGROUP(146, pri_mi2s, qup3, ddr_bist, atest_usb11, ddr_pxi2,
+		 _, _, _, _),
+	PINGROUP(147, pri_mi2s, qup3, dbg_out, atest_usb10, ddr_pxi2,
+		 _, _, _, _),
+	PINGROUP(148, spkr_i2s, audio_ref, _, _, _, _, _, _, _),
+	PINGROUP(149, lpass_slimbus, spkr_i2s, _, _, _, _, _, _, _),
+	PINGROUP(150, lpass_slimbus, spkr_i2s, tsense_pwm1, tsense_pwm2,
+		 _, _, _, _, _),
+	PINGROUP(151, lpass_slimbus, spkr_i2s, _, _, _, _, _, _, _),
+	PINGROUP(152, lpass_slimbus, spkr_i2s, _, _, _, _, _, _, _),
+	PINGROUP(153, btfm_slimbus, _, _, _, _, _, _, _, _),
+	PINGROUP(154, btfm_slimbus, _, _, _, _, _, _, _, _),
+	PINGROUP(155, hs1_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(156, hs1_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(157, hs1_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(158, hs1_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(159, hs1_mi2s, cri_trng0, _, _, _, _, _, _, _),
+	PINGROUP(160, hs2_mi2s, cri_trng1, _, _, _, _, _, _, _),
+	PINGROUP(161, hs2_mi2s, cri_trng, _, _, _, _, _, _, _),
+	PINGROUP(162, hs2_mi2s, sp_cmu, _, _, _, _, _, _, _),
+	PINGROUP(163, hs2_mi2s, prng_rosc, _, _, _, _, _, _, _),
+	PINGROUP(164, hs2_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(165, hs3_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(166, hs3_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(167, hs3_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(168, hs3_mi2s, _, _, _, _, _, _, _, _),
+	PINGROUP(169, _, _, _, _, _, _, _, _, _),
+	PINGROUP(170, _, _, _, _, _, _, _, _, _),
+	PINGROUP(171, _, _, _, _, _, _, _, _, _),
+	PINGROUP(172, _, _, _, _, _, _, _, _, _),
+	PINGROUP(173, _, _, _, _, _, _, _, _, _),
+	PINGROUP(174, _, _, _, _, _, _, _, _, _),
+};
+
+static const char *sm8150_get_function_name(struct udevice *dev,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *sm8150_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static unsigned int sm8150_get_function_mux(unsigned int pin,
+					    unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func =3D sm8150_pin_functions + pin;
+
+	for (i =3D 0; i < 10; i++)
+		if ((*func)[i] =3D=3D selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u pin\n", pin);
+	return 0;
+}
+
+static struct msm_pinctrl_data sm8150_data =3D {
+	.pin_data =3D {
+		.pin_offsets =3D sm8150_pin_offsets,
+		.pin_count =3D ARRAY_SIZE(sm8150_pin_offsets),
+	},
+	.functions_count =3D ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name =3D sm8150_get_function_name,
+	.get_function_mux =3D sm8150_get_function_mux,
+	.get_pin_name =3D sm8150_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] =3D {
+	{ .compatible =3D "qcom,sm8150-pinctrl", .data =3D (ulong)&sm8150_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sm8150) =3D {
+	.name		=3D "pinctrl_sm8150",
+	.id		=3D UCLASS_NOP,
+	.of_match	=3D msm_pinctrl_ids,
+	.ops		=3D &msm_pinctrl_ops,
+	.bind		=3D msm_pinctrl_bind,
+};
--=20
2.43.0
