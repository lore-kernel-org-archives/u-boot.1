Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6179C54E49
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6B187FEE;
	Wed,  6 Mar 2024 02:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="bbj6Q42M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB32787E92; Wed,  6 Mar 2024 01:53:18 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2231987D29
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425GnAXC024399; Wed, 6 Mar 2024 00:53:09 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wp05yb9x0-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqFa5nyY7Qxc0cDl69kQErnju4hTX1jgev7ARQD0Kbqt1nx94iCT8XPt7t0DlRub2T4j6uJfnCLsk1cwtL2SlDy+Ejg91/WQmOIcamcy52Hr+oZ9s+betODrMcmI7XSiT5RxeEW++dzW767olMsqtAe2G5UNV2X81evT9X3hjgBX5jy9SEI+N2Dx2x3hQ/lKT7UfVz3Z69HjhLrGrKxI5SEnVekwrTkeFHQojEEWB6MV8O9k32JA+Ygovmr0/FhqvYgcOe+JajNZouqvFgylKqTfBhC6IXxkbvm/3ouombjcLH9Op84FXYf/+csg0R16PT+DN/zldQ5Sq8+SeKirkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5NOYU+Um7P7PWBd7hzzROrwXfw8Dg7hqCFRsqGHskM=;
 b=nZIuXnZGKCnB6bkGxDqOiIz0uH9IGvXMZ3JrhhCzc9arHcNC8Zus41biQsujP5qPma0qkhP4DuzUTvFBidAw5SqbiFdycAHly6GR3FIBKIqtzq8Zpedkc4uhkU37edOPRwyY8wFbKOI9CKCiSROtgNemQWxvGxnRcKAKowobXUicy6dRJdsnUuvmerREkgLGd5sRWiFS2H7VP8GNyLI0KHugMNe6/a4a9swz0ti+PK70+6Q99Mh/Wg4/RW5B71SBK7FG3RMfHqrU95V41KUuuZa/Me7BU/yUyhaOu10lXuQiCpLyfnmjpSuNQRsRexm3DsuwiKqrr2tj/3X10uv4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5NOYU+Um7P7PWBd7hzzROrwXfw8Dg7hqCFRsqGHskM=;
 b=bbj6Q42MsbLPKM//ndvpbe3YSrAbCA0TNUrrF49EHNdp06DVKlZUHv04++na3DErQNQoUcZiepkVjuJtTsCrGiQ7mGaUg8gGUblboL+iWRyuOvEMGT3INYwO4+7kTVvUDIYtl7xxRUN+b0Uq/AKLjjPtFozNyUrLmZ1CgZL39z8HqcVeVGfa10iAyXl1W/dmx7Tl8vRUoAey4g6OdgEDdkx81MZjyTFAT8cQjVg5JDOpwtNnDpedk5HtwKAuaAkP+fOQ3+JPlKj31PP1I9zkPhv4mYhY3hKzBJ2XO7owTMeEFv68bUfhdePQ8hZea+zxdxsJAogom3OTzxlIHgdEEg==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9801.eurprd03.prod.outlook.com
 (2603:10a6:10:44b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 00:53:01 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:53:01 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 5/8] clk: qcom: add driver for SM8150 SoC
Thread-Topic: [PATCH v2 5/8] clk: qcom: add driver for SM8150 SoC
Thread-Index: AQHab2Cjqbpk4F/j1EKqNYeZ5wXFdg==
Date: Wed, 6 Mar 2024 00:53:00 +0000
Message-ID: <20240306005230.2638972-6-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: 3283cf8f-63e5-4ea5-d45e-08dc3d77c620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: besuyZHKqbihU3WEIHosIL00Y902cnGWXTDCu+ZGAE89S5/5rzhdVuIdpInUBZwTtFWRQZQJqEqGUTeKVKxPUSwN5NNPgX8xUTLoROHJ7udDVCIKUKaMpiEqdtPT5nzKPh9aNGfc8JeB710mIfzymYg2/i+4kq8t51/pSIazkYGBjtNDWRlsy71R1KvdsWhUDvqGLmq+Jg+u2Q8IFCXbG8S78/vhA1998WJmxWS9HOBZsY0PvdmxJEtNfS2gK38Y4EH/FkBrbWJnrKwGjO86VzsRclgbdiL7u/F0u9K/lUZD8ROjG9YasAgJu9pKpW8DlsyHYlG8EdAsfFdYBPn761tLHtKlHDrRrDUyWCW0wRgP7ORTNcWIdPVcENrPkYUKp4VN33rY5jRDmkKAyMOKmin9buNxE9HQpKxhiprkYTNOLN8SYGEoeGN8v8gykG3RSBfXeNNrL2oCmRwELCiZPeqRmMQOUXhC4qQMQul/9nsd69rZ7jTdHhFpIcDiDuMu6IVuTObDVTKis1uUENa3cgkaeoRJ51T1v/5jfRofahC6hEhQ5JgBS4V115YBYjgcNHGNBWhPD+roq4x69YcHVIFLynesxWYAtiuWVtGPq+gtDWAYHKIWwgdFr4EmuogD9VfE2cJvy+Z+mQCcQXNlt+Rcoiqv8gkE70974uznmdEe/VHN+1noN9C5AKhVxOcjrxguv8WS16jVOAqf8IvZdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I1phGR2A6iLN3vDQQuu2E2YcLZ16LEyEmfXECw5KbfEYkY0s+cc5YDbyyt?=
 =?iso-8859-1?Q?6La8WsrxWpEXPM2U377leAUDN9l/69Sne/fw8JWISbBTzUOMwW2K8j/+tQ?=
 =?iso-8859-1?Q?JGivGmFGt1za9/4H/DufXkH47IfuvszlttAcNEOeRGXnbu2tzIE8c04gDy?=
 =?iso-8859-1?Q?kpgWrv/sRNGKYm6KGnRTQa+oabZ74IrJeA9RVaPMhxX6koLQ2/PRkP8yfc?=
 =?iso-8859-1?Q?9mn2q52YlsF3DrAjx05Kb0ymG6rCp7DIOKvQiyKsypZPeZbxKzSn9qvddi?=
 =?iso-8859-1?Q?Xr8Fjk82BX2jdELyNL8cJYvsF9QtVkG5+fjBnrL5iUkBbU6wUAYasCkxR6?=
 =?iso-8859-1?Q?PDhxT1X0SSiuopIVpMkMEtqhSuDMhX74G0z1xaDdIKL/9hqLxIY8miQLDX?=
 =?iso-8859-1?Q?+IrNtmv4EwZBWCJZO6iprOSAwRneddikSZi68HTE0aVgtXFoB5q1+PIUTU?=
 =?iso-8859-1?Q?2HHqnHKgAaJVmahDILYBN1ldHiZ3Y3ePzPPymPDEBnU79kANtc2joqWzPN?=
 =?iso-8859-1?Q?kdifKGB5xyinuno7bbf5IePac+Z/8mXhkpnUu/8PBkT1QBiQIDhWYmNluP?=
 =?iso-8859-1?Q?iuT6TmvUd88OHB1A+cLSihBoUWv8Mr62v3gjEhw69iVpE7zK/1PZf6ACAZ?=
 =?iso-8859-1?Q?FlhFI+8HqSXKR1UFMkP7Wbv1JHMfR1GgOv0PtB3rhPVcG1Rww1l25bjzP0?=
 =?iso-8859-1?Q?/v42ykV6/rAA4gUWV6GJr1xbBdvIKb1hzP6GsZA5BTRgGJP/WipZm9fVI8?=
 =?iso-8859-1?Q?eZVJcuHngWMNTjnLx626z4txsmkUcO1198mLXsnDeJ4Gx5pxOrX0KpFF6X?=
 =?iso-8859-1?Q?fB8nynu644krcn0/LrYROXJ9JJiqY92MXp1rl47KPiI7yhOqRiWzhXuX4v?=
 =?iso-8859-1?Q?odUZvaKFBtDAGP+cgSaHXye7DOmWppQcHQGRcZXZ3EnF5JgWMPhz/JldeZ?=
 =?iso-8859-1?Q?HWFVIbieUyqUgMMF6LahEUqkOPI+kDJbiuET+Tx5YWH001AhIK+RyE4+r2?=
 =?iso-8859-1?Q?JTiTWXMvrmCHQKthpjHhZyRDk4nufOkhvNxtjtx0mXuT08G8lHs8zO3bvs?=
 =?iso-8859-1?Q?YZtRU4xe2d8oitERYWuu7Ekva6x+UMgv++5FlHk6RgdrlGfUrwEb9gM8cW?=
 =?iso-8859-1?Q?MFy+VE/bGCU7dJFJAvcmGx4N7939EdecDhkSHuKWO+3kqiMa4BP+G0DH8G?=
 =?iso-8859-1?Q?TKv2icLqJquqLUaqq/kZJq35Z+LXlvk85EBKThgqhNX09Wi6FZhAywsZjI?=
 =?iso-8859-1?Q?H2iK2p08d8kxf7eo8bcq2haJCoq66xOEY/CBo5oAyrUZlhpF3Q6D9W/Psw?=
 =?iso-8859-1?Q?gc0Ht3FFDe2dY5QDkTUFtmn98pC2KIrVD73aDm/0jVVunmV3k9gYlov3Yx?=
 =?iso-8859-1?Q?mavit8w6MeMxdeGrjIsXlbeu9MT1U2yQ52llTlYWTFbGeUNm6aFw3Tu6vI?=
 =?iso-8859-1?Q?zBAxUuuWHQZ10s2qxMAKuLA9Wp6/Bjau/lg2BxQgUu9a8NqTbnLVGSeWIO?=
 =?iso-8859-1?Q?lR1WE23T5F1hFHk94BSlTyobiPlrElpaQkbFiIFRPnmxdy+CY0EpqErl1x?=
 =?iso-8859-1?Q?xh1R7nq0ecJ1QiB68nFMK/pzRXVqRrplbZ5cv74YcF5nP6vWMsL6zm6Ba7?=
 =?iso-8859-1?Q?bGEp02OTFQlCB1r9K8pGYcUp5BYiOMiTv1IxY5+q+QKdBi5LN+2VyuBw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3283cf8f-63e5-4ea5-d45e-08dc3d77c620
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:53:00.4762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +itlPy5BpJsm4TCgrjxKhxbc1WTnKb9dBTiC8Gv94PX9LG2IwiSbYAotzkJ1XvA53Cdx+f1r2lp9TDpgvJT5t81UcSBS/KRCpIMIcwM1miU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-GUID: 46kBgShGxfd_bzocKpZ4CRtkLiPYYZql
X-Proofpoint-ORIG-GUID: 46kBgShGxfd_bzocKpZ4CRtkLiPYYZql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060005
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

Add clock, reset and power domain driver for SM8150. Driver code is
based on the similar U-Boot drivers. All constants are taken from the
corresponding Linux driver.

This driver supports clock rate setting only for the debug UART and
RGMII/Ethernet modules, because this is all I can test right now.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---

Changes in v2:
 - Renamed GPLL7_MAIN to just GPLL7 (while I like idea to use Linux
   naming convention, such rework needs to be done in a separate
   commit)
 - Removed unnecessary include
 - Fixed GDSCR register values for couple of devices
 - Enable GPLL7 only when RGMII clock is enabled

 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-qcom.h   |   1 +
 drivers/clk/qcom/clock-sm8150.c | 237 ++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
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
index 12a1eaec2b..dd40487e94 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -9,6 +9,7 @@
=20
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
+#define CFG_CLK_SRC_GPLL7 (3 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
=20
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm815=
0.c
new file mode 100644
index 0000000000..2592eef29b
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm8150.c
@@ -0,0 +1,237 @@
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
+	F(125000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	F(250000000, CFG_CLK_SRC_GPLL7, 2, 0, 0),
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
+		return -EINVAL;
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
+	switch (clk->id) {
+	case GCC_EMAC_RGMII_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+	};
+
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
+	[UFS_PHY_GDSC] =3D { 0x77004 },
+	[USB30_PRIM_GDSC] =3D { 0xf004 },
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
