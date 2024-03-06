Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FCCC54798
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7950088003;
	Wed,  6 Mar 2024 02:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="jkb6yjy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 146A187E63; Wed,  6 Mar 2024 01:53:17 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028E987E6C
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425FtP8u019808; Wed, 6 Mar 2024 00:53:11 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wp390jh44-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbWOsI6/sjDmaUGaq1qqIUXdjx8FonrO8o1ZBvPUrMWV/TG6GshAW0tx5IVg3xI8q6e4sAnZ5J2OzvNWQCNa9/xyKToGvD+MtdZ9oYvk9iDHsygYtLm9r9N0/ItLZ0S7pvEwE5LcvqGFYW44TbjnBBH+OpZFDG5unjUuoOYlfyHmvQo0+9Uylr4XBYZawMWKxs/mMyyzMlL6aw6Ggm7LSMkDpZjDZd0aiqKQFlH4oir3wYw0EqCAdeZMKQP4SvgFh/YrUHQ6DX141KHyY8WzITOLqMNe57vvxlaafE9/Iipdjx8ftZpnhwhG3Wb9nh2ycBhwIBAVZW0XLmkkJzxUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao1qTtV+ki5UUFE4BPACYCCD1LGXpOPZZ9AkJrx1noU=;
 b=ixAys8an4ogLs2oeERNe/Qnn8j+g31OX57gnbO7g3MMXpB+F4EGgNTrRi8x0wRjgz90nXawJjD8UP3KrbeS6pzMs7SXffmtI2mz7xMo5TdxNJeagUOHosJRoKVVwuXw5UgZY4mDpBRYWrbVunL/WDUu5VZa1bGeUW+hPkHViSq+UidcmPLLY2zsb4wEpipZhbgrYrOz1Ny7cu2xZqOuI5V0PaA+cRuSAtU+AgOlhWnVpVJ0TxbA6P2uZX4mAiSrl9D9+o5vdl/UoJep3aTHCFmlTYEGvRVtYmgpL5V8kEZhZjn/jsfWJHXS/w+C3ZycAevRxE9FK1Yt8U4HuPdCjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao1qTtV+ki5UUFE4BPACYCCD1LGXpOPZZ9AkJrx1noU=;
 b=jkb6yjy6lyAz7IuT3BGtvFw6acwL57lHmuWIgj7Uf9ncFB9hk8gx9qAIQffZkmE/D+557v3/gy9GBRRtUvldSnCMT21KYkhXQXkXctRudGsv5of/ZoZm8IeEmhya0TwmJJ2wHUlY/qoVHkaqsAm0HWKWoelkpMvX7500LfPZ3nlootsKxRyT/mw+7gVr0TTt2owta6Jn7G++ChyG3qlNijvhJCIsJQHlxjiZKu/zJitDcYtlDU/zGdzOZV2ZgiTfsVq2WYK9AZ8i/zf/GbE/ofCcdMbemyLDjfOvYB4lFLv/pCB5+7tYqqKiSwRmZaWP9cXauA8Qz2yNvXJKhTyhkw==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9801.eurprd03.prod.outlook.com
 (2603:10a6:10:44b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 00:53:06 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:53:05 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHab2CjKZvPgmo3NEWX73nxw+EzJA==
Date: Wed, 6 Mar 2024 00:53:01 +0000
Message-ID: <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: 99c70959-80b8-448b-4d64-08dc3d77c8ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dc5cgeFnErtJxrvlF/Qo5Fl58W+q17JYEbT9tNIjU9QzMnezvR99OYwyZWdTThGd2bhwuax0IUwX0D/3g/A/fNZNTX1RqHr8XpIPc5ufICvaIwoYIqore7/PrOqV0s4sYJK1tZj8Z+aRTm0YrjEEIqsYxTYVi4oGxrpg8jCerSyWDUClqiH2x+auEedgKhzHVbLhKw5XtrGWm+wU8rTSDNfGK0S4YHDG5czZv7aevmWxB6S+E/pA1GzuOrs6xrFM71+t6UiXQ6g1Ms8GEWaWHA+y92zv5W/qOizzSLnRCa98mI13F6QFMfeWFhhb3yfP1W85j1utKTYym9Z+gSi56Rou22DpgkOlmwGl5zIsVVAZawKeheHM/VsHpPSk07PIR4eyDoohU/Z85Eu2OGxWw4o649cf4ThgBakilqduegeL/L0ZgYT469oj1U7W42JBXU84m3vxJgYYlwCyf2PYGQ9JTqw9aurS5oxCZJ+2nZCqrnjFaWXwiAYmXKFWfiAO3OJKT/pXrBGGpS4zNC/BYoPAjGAA8bxPPYTwZStS2ACZLnzhVE2oNy2p9QknMlga3NKsTyrL+8IDhs6gR835Zg2tqeNGSjH0HKwhldXoucK4nA+sXm4hrtQwm34dMlSM82MYaAdMC193kPZWDh+OBjQSpOndqQO/6Wfqwvy4GFs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l4iurjZiNmxib3AYH8SUIQM3I0VMwiYEjCuIf7JwW+ciTh6cB4XduRZH0O?=
 =?iso-8859-1?Q?cu2uWo2DdqHYUDfzlVY3hbyl8y8IT/RyRi3RRaD9gB2dSrBayn8UDA/70d?=
 =?iso-8859-1?Q?izy6naXAyyAZ9fSKQGhT/HOhH1XwRxE5whc5c42aTDeBWmzV04Lu8Rznes?=
 =?iso-8859-1?Q?qLtvzHjC2rd8OAZJ1zE8nQJeMJI1m5wQq+o4CzyBEd5i/oJegSzna9RZHf?=
 =?iso-8859-1?Q?LIpqfMl9gHbOwg4ueJFPGk1tleg4AsWa7jmK4ppQV6/Wmbb2rallX955cv?=
 =?iso-8859-1?Q?T2kDWeXssDNAgxPoOBV2mL5PTQgTujO7b06CQaJlYJUNHMJEiljWrdVpAo?=
 =?iso-8859-1?Q?RpxVYYXyva3qIPvi+Ot2guscR6fNS0LNWInIMIBhb28vFS254TFp4gNZyl?=
 =?iso-8859-1?Q?me7SoACuY+KMr3WzI8b5/Y/huPudjul79aJkd9pcjli/O8kXtd0b4NZVxg?=
 =?iso-8859-1?Q?IepohKnT4dfjzXxF1LkuFwEcmkIpgkBgnOSlt42U2qwT338x6aPW/ompi/?=
 =?iso-8859-1?Q?AqA/YgTB6yxtNLftggPtTRHWMtX8iyyCZ6sEXQtkBKvgEFavo4uAE6e5AY?=
 =?iso-8859-1?Q?WKT6OmiUqApdwBnD8cpZ3HrZSRKGQ4c8mTqyn1qJxPepuGPnw5tq9bq3+b?=
 =?iso-8859-1?Q?OtA0ITsj83Iw5aW7uvjpJ9K0LX3J9C4uk7OKL9Lv63Ga5ZdJQPi3hfuJSn?=
 =?iso-8859-1?Q?vRGfKZUrN6EJhFbRwrwg+YxvDyWcoA1lhieYjUrJw50hLkuZyNoln2tWH0?=
 =?iso-8859-1?Q?zsLKaG5NXebnqTtF2RZZKDnws2EYpDr138mvXJbw5UrPGJyp5Q+HJ6EBgt?=
 =?iso-8859-1?Q?GlWIX9xB0nrvJyVN85pJM3bRtbg36HOKfHBEc6vjhFDnvJe0YGZ2/nB98C?=
 =?iso-8859-1?Q?0c8g9bzngUiyzL3jILTmFNPWplPHez+mm22l+vH3OttqIDFewK6Es+k+lq?=
 =?iso-8859-1?Q?S4yeBnwlqn9spHqpudxog/VrnTJKpG1ZBAWpRuNd7GhrkjPpo+wk59JH4x?=
 =?iso-8859-1?Q?CIDGi/RHd3nhdEE6UbLIyafYP+9up1Rl1v6HP1t8ou1+D25DSn2Z653JNI?=
 =?iso-8859-1?Q?UhpqoJyJdnY6LjI+IfUnOS4dmVYpRAwJ+nyN69fcnevsL79RMBvI9NKHnY?=
 =?iso-8859-1?Q?NS6yOVSqwkVH1i7b83fX6XwcoTkAIuEoIUHaebW6mFHAgT0LkX2erAbbpY?=
 =?iso-8859-1?Q?CqqqhzbFkaBcJQejDFzcfupmujeZ+zFDrOX1Ka2wVZIKJ9fF826L3nwyQN?=
 =?iso-8859-1?Q?+F9juvTrxvUqPW4omTx/ARZLAn1KyXgphXGWgpNqq3u/mmVcorZpiPQcWc?=
 =?iso-8859-1?Q?Fz+tVkXZH/GFuiiGi1aCu8FgU4NAvIWJtB9KylB/6hkJbprMbliTolzQZ2?=
 =?iso-8859-1?Q?Ed1moNOAhrPHBXjZJf0mFrhWY27h6sEAXjjx08qS/vcCx7ytijw4aXsnS5?=
 =?iso-8859-1?Q?x7ZxrPnPK7an0r4MWDIc8PP1u2K17KJinUpx5uyZzTn+xZvNgY+Umw7Blu?=
 =?iso-8859-1?Q?YffAL8b7v3+ryQZiGFj0Q8eSPDOg04y2cFfH5mslh0jGgx+DBA3Q+RtPv5?=
 =?iso-8859-1?Q?Ae87j1Rev4Dcy+IzkBjwX3iwpw1MYoDSDTriZFlikPymOROuViJKJH/NXY?=
 =?iso-8859-1?Q?WRVw5SJov6h5lxDeGm1SKV4xQ2jPno0h0cjcSYbvnPllb9fF8maZ4v4w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c70959-80b8-448b-4d64-08dc3d77c8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:53:01.5010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hey65nUHTDCxhyEOYU784MzKr0uX+LQRfK6Pk8iFLzDLpqlDRwjhcYt255DGK9wAaTtntf4zxsuJ2uC3piNtBJlap07V70bvkHnQaOxB9yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-ORIG-GUID: pVBi_phwjCCnfW3HeF83cD4xUF06gTck
X-Proofpoint-GUID: pVBi_phwjCCnfW3HeF83cD4xUF06gTck
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

SA8155P Automotive Development Platform is Qualcomm SA8155-based board
for developers. The nice thing that it has unlocked loaders with test
keys support, which means that U-Boot for this platform can be
launched at earlier stages.

This patch adds basic board support with only serial port and
networking operation. I am using U-Boot to ease up Xen porting onto
this board, so I am mostly interesting in booting U-Boot in EL2. But
more conventional setup with Android boot image is supported as well.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---

Changes in v2:
 - Rebased onto qcom-next branch
 - Removed unnecessary files thanks to generic qualcomm board support
 - Enabled CONFIG_REMAKE_ELF (this removes one extra step in the
   readme)

 arch/arm/dts/sa8155p-adp-u-boot.dtsi   | 30 +++++++++
 board/qualcomm/sa8155p-adp/MAINTAINERS |  5 ++
 configs/sa8155p_adp_defconfig          | 35 +++++++++++
 doc/board/qualcomm/index.rst           |  1 +
 doc/board/qualcomm/sa8155p-adp.rst     | 87 ++++++++++++++++++++++++++
 5 files changed, 158 insertions(+)
 create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
 create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
 create mode 100644 configs/sa8155p_adp_defconfig
 create mode 100644 doc/board/qualcomm/sa8155p-adp.rst

diff --git a/arch/arm/dts/sa8155p-adp-u-boot.dtsi b/arch/arm/dts/sa8155p-ad=
p-u-boot.dtsi
new file mode 100644
index 0000000000..ffbf0933c7
--- /dev/null
+++ b/arch/arm/dts/sa8155p-adp-u-boot.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Qualcomm SA8155P-ADP device tree fixups for U-BOot
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ */
+
+/ {
+	/* Populate memory node with actual memory configuration */
+	memory@80000000 {
+		reg =3D <0x00 0x80000000 0x00 0x39900000>,
+		<0x02 0x0        0x1  0x7fd00000>,
+		<0x00 0xC0000000 0x1  0x40000000>;
+	};
+};
+
+&ethernet {
+	/* Ethernet driver tries to find reset by name */
+	reset-names =3D "emac";
+};
+
+&tlmm {
+	/* U-Boot pinctrl driver does not understand multiple tiles */
+	reg =3D <0x0 0x03000000 0x0 0x1000000>;
+	/delete-property/ reg-names;
+
+	/* U-Boot ethernet driver wants to drive reset as GPIO */
+	/delete-node/ phy-reset-pins;
+};
diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8155=
p-adp/MAINTAINERS
new file mode 100644
index 0000000000..03fac84f51
--- /dev/null
+++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
@@ -0,0 +1,5 @@
+Qualcomm SA8155P Automotive Development Platform
+M:	Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+S:	Maintained
+F:	board/qualcomm/sa8155p-adp/
+F:	configs/sa8155p-adp_defconfig
diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defconfig
new file mode 100644
index 0000000000..b6969767f8
--- /dev/null
+++ b/configs/sa8155p_adp_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=3Dy
+CONFIG_SKIP_LOWLEVEL_INIT=3Dy
+CONFIG_COUNTER_FREQUENCY=3D19000000
+CONFIG_POSITION_INDEPENDENT=3Dy
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=3Dy
+CONFIG_ARCH_SNAPDRAGON=3Dy
+CONFIG_TEXT_BASE=3D0x85710000
+CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sa8155p-adp"
+CONFIG_IDENT_STRING=3D"\nQualcomm SA8155P-ADP"
+CONFIG_SYS_LOAD_ADDR=3D0x85710000
+CONFIG_REMAKE_ELF=3Dy
+CONFIG_BOOTDELAY=3D3
+CONFIG_SYS_CBSIZE=3D512
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_HUSH_PARSER=3Dy
+CONFIG_OF_UPSTREAM=3Dy
+CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_CLK=3Dy
+CONFIG_CLK_QCOM_SM8150=3Dy
+CONFIG_MSM_GPIO=3Dy
+CONFIG_PHY_MICREL=3Dy
+CONFIG_PHY_MICREL_KSZ90X1=3Dy
+CONFIG_DM_MDIO=3Dy
+CONFIG_DM_ETH_PHY=3Dy
+CONFIG_DWC_ETH_QOS=3Dy
+CONFIG_DWC_ETH_QOS_QCOM=3Dy
+CONFIG_PHY=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_PINCONF=3Dy
+CONFIG_PINCTRL_QCOM_SM8150=3Dy
+CONFIG_POWER_DOMAIN=3Dy
+CONFIG_MSM_GENI_SERIAL=3Dy
+CONFIG_SPMI_MSM=3Dy
+CONFIG_LMB_MAX_REGIONS=3D64
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 4955274a39..268218b05f 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -7,5 +7,6 @@ Qualcomm
    :maxdepth: 2
=20
    dragonboard410c
+   sa8155p-adp
    board
    debugging
diff --git a/doc/board/qualcomm/sa8155p-adp.rst b/doc/board/qualcomm/sa8155=
p-adp.rst
new file mode 100644
index 0000000000..66db512b52
--- /dev/null
+++ b/doc/board/qualcomm/sa8155p-adp.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+.. sectionauthor:: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+
+SA8155P Automotive Development Platform
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+About
+-----
+This document describes the information about SA8155P Automotive
+Development Platform aka SA8155P-ADP.
+
+Currently U-Boot can be booted either as Android boot image, or in EL2
+mode, instead of hypervisor image. In the latter case it is possible
+to use U-Boot to either boot Linux with KVM support or to boot Xen
+Hypervisor on this board.
+
+Supported HW modules
+^^^^^^^^^^^^^^^^^^^^
+Port for this board is in early development state. Right now U-Boot
+supports serial console and networking. No USB/fastboot or UFS support
+yet. So it is not possible to save environment variables as
+well. Nevertheless this is enough for development as user can download
+all required images via TFTP.
+
+Installation
+------------
+Build
+^^^^^
+Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
+
+	$ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
+	$ make sa8155p_adp_defconfig
+	$ make
+
+This will build ``u-boot.bin`` in the configured output directory.
+
+Boot in EL1 mode instead of Android boot image
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Create a dummy ramdisk image:::
+
+	$ echo "This is not a ramdisk" > ramdisk.img
+
+Compress u-boot binary:::
+
+	$ gzip -c u-boot.bin > u-boot.bin.gz
+
+Append DTB again (binary we use already have DTB embedded in, but
+Android boot image format requires another DTB at the end of the
+archive):::
+
+	$ cat u-boot.bin.gz u-boot.dtb > u-boot.bin.gz-dtb
+
+Now we've got everything to build android boot image:::
+
+	$ mkbootimg --kernel u-boot.bin.gz-dtb \
+	--ramdisk ramdisk.img --pagesize 4096 \
+	--base 0x80000000 -o boot.img
+
+Finally you can flash new boot image with fastboot:::
+
+	$ fastboot flash boot boot.img
+
+Or just boot U-Boot without flashing anything:::
+
+	$ fastboot boot boot.img
+
+Boot in EL2 mode instead of Qualcomm's hypervisor stub
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+This approach ensures that U-Boot is booted in EL2 and it is possible
+to run virtualization software (like Xen or KVM) on the board. You
+must understand that this approach breaks Qualcomm's boot chain. You
+will not be able to call all subsequent loaders, so you will not be
+able to use fastboot for example. Use this approach only if you want
+to experiment with virtualization on SA8155P-ADP.
+
+U-Boot ELF file needs to be signed with test keys. `qtestsign
+<https://github.com/msm8916-mainline/qtestsign>`_ tool can be used ::
+
+	$ ../qtestsign/qtestsign.py -v6 hyp u-boot.elf
+
+Resulting ``u-boot-test-signed.mbn`` then can be written to the
+board. Easiest way is to use ``edl`` tool: ::
+
+	$ ../edl/edl w hyp_a u-boot-test-signed.mbn --memory=3Dufs --lun=3D4
+
+Be sure to backup existing hyp_a loader before flashing U-Boot.
--=20
2.43.0
