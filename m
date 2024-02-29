Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFEAC54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF85B880F3;
	Thu, 29 Feb 2024 15:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="dFonggm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA8587C61; Thu, 29 Feb 2024 15:21:28 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA43D880D7
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TArea4026283; Thu, 29 Feb 2024 14:21:16 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wj8a9be8a-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4zY4Q0cOIn4scgZ5WXjEkGkdZpo4BVKfpUQHXSe+vrTzDPc1+Sl8G3t/J1QtEdPubuwWEpbZAa+VnguGeLwaLMsZy/UwtMWHnPtetsTZImxs//33oL/ysBuuuKhYK4FJTgJ+fqlc4X4fOVt6roHT1pccp1uF8PiAM40Zy0WxVPcWeTyOogk6arz0ix1zrW4sX91NLvHJZqBQGNawzo3S9azTzJs/2aG/pp+eyHNOt97tljLHAuK4Yz6vHgaFqrNzLYcg9EH0BJsgQmP99aYerXTt4PllumDliSmoLWrTf/mntUJKLB2g+0u0Rk23JVdfla4nYxXC8a7YZEGAjLPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuUrVXU6oVSqoUdowH9waV/EZ1KS6/BJwjsl9xxmyiE=;
 b=m/0ZoJepjca4cM4cAZigpkYpj/Lmk5OGxXp5G/wewQpEQM8oernwc+ZgWQR0CWGrQvZ2O73qURcdvHrSznuiRDihwmT06pSTiX+oFIiD3A3HVs53g6pF1p155pjJPL2mmUi7qHsV72FcnHeJCnNUYYbX5VRFepYkBykmev8eMbn1+PmDbTnx40cjtdsFDX4gN/X0B3R/gaa53lWzbQa9E9eI964HqZAv7Ddl1Otk81MMX5NVppkYH6Ak/LARMs8/clGgURUbX6OReryLi9OjvrUNHwAz+cL4ACWN1QkZjP0k7aGikgTtkx9htnBdYdRHtuO4SNgAm5ecsW27TInylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuUrVXU6oVSqoUdowH9waV/EZ1KS6/BJwjsl9xxmyiE=;
 b=dFonggm4RtZPhPyn+DStj4Lp0XYX833HE9frn9v04L0RGtVrGJJHmvrnR1+y6LTIkgtvS0wZV61BvKoKksO1CMknGzRPnmy/URNThzWKeVr9hst4hCN1P1APZneGfyFNOPVw3MJs+3S+r5Ot0Dp1ULiYZTSrOG8uwmLkMnuMo7IikM0hW83O+9yIXT0tT0VAr4c2nQBbZfNkuezZNqUtksIZI38Kf4pbyPK5b/bZj+3mMm0ExoV0oTDwq6bHPlaOLzrTUKGh5B/ByIhgEPFqmmCWKEOWGCpEYm9gaj8Y2zR0hrWLznRFmEP6SuEwkqYiu0JYQGTHNip7UQjgFBSKSQ==
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com (2603:10a6:10:516::14)
 by AS8PR03MB7735.eurprd03.prod.outlook.com (2603:10a6:20b:405::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 14:21:09 +0000
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c]) by DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:21:09 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Topic: [PATCH 8/8] board: add support for Qualcomm SA8155P-ADP board
Thread-Index: AQHaaxqK+jMULOxtT0+c/deQ37vtVA==
Date: Thu, 29 Feb 2024 14:21:09 +0000
Message-ID: <20240229142043.1263690-9-volodymyr_babchuk@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: 9c3b03a0-d559-4d5d-4fc3-08dc3931ad01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgKGfYrPTSOLvn/Q901Zc4Y4HZs/xF8/GG3/UeBskTGGM/IIaxFOk3I1Ew55B8YHCJ++otdehu7mDdtpbQtS0WKqydeqhFyCzGEWxk7H/LSI8Hi3mu2RkpkCCsiqFcdVtNeMtqDBFQGuqQBAgvk2Pyi8OiZ444NrcvsYJbLmUgxnwjXCFASCpYarxs8oP4gxdWqFP40w25zWP3PXMuW83CotqGK3AnBgX8EVdqNCEr9x88o5L/boUb1XtwF7RR0/3SMsNIYeyeWqvM0VoWYogTv35xOTnHkQKyekg2zrWSzpE5lvHJbTZMFuUwBVhgLgxuO7DtwF27DIEahS7WnDWhVIwRWu0NigVk6Jnpg646PaSS2kXAOYyojBxkAYMSaRmjqe+a6eOVSfROHK/JWCPXAwlkY1x3Yzb1YmC9DS7338SktZYcPU5nzOzJ81KbX6kx6afxVYJbbINmZ8mdkZFGcwGLKqrfuaSsxZi5beyhFxKoAn+ljPIfseUYprOaZ2xdvfWSg2h45lnjlzcgdxP97r0dyLAc89va2kqxq+YotkARFtDlhwa9zsLvYm0eO8M8dZf1b4jKHGdtpF8p4gLcXISKfj9E70nefCNljVR86FYGLe6eK78pigluhLwFf90OcLeJVy5CanuLG/TVUzQ/dxXoe81sBy8Tf+E5y2C+I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jR2r5lXQwvxY2H4hFuKRyDHwsuIVmfcL9AkeK2RnXBzOzr9qWIhTPE1vpu?=
 =?iso-8859-1?Q?8+RUhTBto+QBUaa/m6MCjeF+fIV1Ez5cQstppgEwxXvFNovh1MsCbQh56i?=
 =?iso-8859-1?Q?KB0Mtj5mCm0xR8SJzyvIi7ptN8n9zUYA23i2wcHcEYk/DQDrFiRk/8ojUd?=
 =?iso-8859-1?Q?TGdD+XhAkeahakRO53nyXkqOXdJbaTep4TyBTdaBDyz6aoYXIei0NNxVyF?=
 =?iso-8859-1?Q?FhguhRQb4DkpvswvMWxnpTrjgRDTqus7UHnDGtw+hbM59or6whCT5ymVXw?=
 =?iso-8859-1?Q?mtlsaxM7awmn/PbsImW5jDLa+Z2vme1kNxLDNFYmVPn+PtYr/eVLT+2y0w?=
 =?iso-8859-1?Q?axpuuBcjcuK8n9UdpCfcUG9vD8VvWSFRqv4qR2p8E8i+ELC4k80aXeB4dy?=
 =?iso-8859-1?Q?VAlsmlD5sCWWR4bGz6yvc49IGh5m5jIrPVBAq/Qac9k7kneH/XoWmuzUrc?=
 =?iso-8859-1?Q?BoIeh0WKc8ZYJvaRnstpH5zvHoRGxkVaTjVxFOek7nxOXWv2RqAnAckFzf?=
 =?iso-8859-1?Q?ASp7txey3XX1AP7GcPSkcJT5GAUhFoHDw6UtO+yNcIfSFiixi7innuxtYk?=
 =?iso-8859-1?Q?cWJ4Kx4hAajDyeGlBffXb92U8ANnWJ4ufcwXQ4B/fzaOidUFwUffMk0TQv?=
 =?iso-8859-1?Q?JpPRgTbhZW2MurQAFrF2YQ2ePNdvqpCxiQttdtT2P3zVrG4ODH9BfvWr9k?=
 =?iso-8859-1?Q?6PwMAzr4ax9smzgD6w/YY9h4L9iHxuJYM6IC5UqN7JGqsDCiDpGyoR1QNC?=
 =?iso-8859-1?Q?6cWG6tzCgnnoMEvsZu88SxcIn6o5UV5078FNWeFGF0hxQnJfWd4E7XdIKW?=
 =?iso-8859-1?Q?w6wFI0pOZYlho3iUruQsmJYA24TY+hcGdB3HTwnq6D2bxG9LAnARNOfyY9?=
 =?iso-8859-1?Q?4exMu7Fasx8WeMuUVe205HYYM6P78REYNoUT7KSbJfZpYbN275BEra9Js6?=
 =?iso-8859-1?Q?IkzMeazT9XEJcjVLZtOMXnBgCCcS9EoTVrSvX5zxZMtJ5QxneydoPmsvum?=
 =?iso-8859-1?Q?gjr/IiL4EBT1K/H2eY6TUF0R8xjtByqkmecig+RRjP+9rqfVJucEQ4m6BZ?=
 =?iso-8859-1?Q?pMRMExG8uPFtta60UaKjjXau7xfXB28opZGZ0morIKz6CZbi1z+pi6nDkA?=
 =?iso-8859-1?Q?VQTP7oJZjX2pT/tYlFu6oLH0zntAZutnmGjnPW5VI2QQDWFyVkbgp4g+Vj?=
 =?iso-8859-1?Q?wo9+TRDTyBUL51VxwWwFr06Q5Pj3KTt7RidUJ/FiKobj8/UHaC6LO1Kq7e?=
 =?iso-8859-1?Q?G2oEsif+Fhi9zXbGQ2l8GjqlMbS4hhvkkZ3UrjrIMcTnoM1F8pKevRytLz?=
 =?iso-8859-1?Q?2f2713DwTjt7OmKVPj9MJPGpCsYBMabAPoVrqgfbFvsYYz6oJ2Xy/4uIdc?=
 =?iso-8859-1?Q?T/uuBUeppVZ+hjoC1CvMLyOni5Hv7smYrrY3kwh3iYWTAtl0YrKCahCgrH?=
 =?iso-8859-1?Q?4LOM/Iuz8R4h7KEs9KWLmGCguyHcCfOKtFi/vcyKEDKGbJF0Adff6Mfl15?=
 =?iso-8859-1?Q?W0Se/pDO4kfeN3jXKEgpb7anM+HBzNibCXeMUh7YX5z7OWGrcQxeYu8vce?=
 =?iso-8859-1?Q?RxwuDCvU8moyCzk8Fq+IFO5Q9uQoEOMoyPZTpSBEUj3D8HyriUiz+lfIvI?=
 =?iso-8859-1?Q?Dtq3ZlS5+nioQVt26R0bH9mYE2mu8Ilg16OMIvnuEO3dYWZamcv/l32w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3b03a0-d559-4d5d-4fc3-08dc3931ad01
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:09.8081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jro+qE4mcOC8ZNXX72cnUHSQP/a9TcAJo+G2OfvXvbWDX9kPbN147PmTnY9cQpk1zMf+obIFBqX+YLlClp87Bktuun09NMR5npOsd8vw+So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: Vw0VfKeFL49jkGwKIv4jd13tmiHFQqaV
X-Proofpoint-ORIG-GUID: Vw0VfKeFL49jkGwKIv4jd13tmiHFQqaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

 arch/arm/dts/sa8155p-adp-u-boot.dtsi     | 30 ++++++++
 arch/arm/mach-snapdragon/Kconfig         | 14 ++++
 arch/arm/mach-snapdragon/Makefile        |  2 +
 arch/arm/mach-snapdragon/init_sa8155p.c  | 30 ++++++++
 arch/arm/mach-snapdragon/sysmap-sm8150.c | 31 ++++++++
 board/qualcomm/sa8155p-adp/Kconfig       | 12 +++
 board/qualcomm/sa8155p-adp/MAINTAINERS   |  6 ++
 configs/sa8155p_adp_defconfig            | 33 +++++++++
 doc/board/qualcomm/index.rst             |  1 +
 doc/board/qualcomm/sa8155p-adp.rst       | 94 ++++++++++++++++++++++++
 include/configs/sa8155p_adp.h            | 25 +++++++
 11 files changed, 278 insertions(+)
 create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/init_sa8155p.c
 create mode 100644 arch/arm/mach-snapdragon/sysmap-sm8150.c
 create mode 100644 board/qualcomm/sa8155p-adp/Kconfig
 create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
 create mode 100644 configs/sa8155p_adp_defconfig
 create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
 create mode 100644 include/configs/sa8155p_adp.h

diff --git a/arch/arm/dts/sa8155p-adp-u-boot.dtsi b/arch/arm/dts/sa8155p-ad=
p-u-boot.dtsi
new file mode 100644
index 0000000000..4484ea2734
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
+		reg =3D <0x00 0x80000000 0x00 0x39900000> ,
+		      <0x02 0x0        0x1  0x7fd00000>,
+		      <0x00 0xC0000000 0x1  0x40000000>;
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
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kc=
onfig
index ad66710819..6431b6eca0 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -19,6 +19,12 @@ config SDM845
 	imply PINCTRL_QCOM_SDM845
 	imply BUTTON_QCOM_PMIC
=20
+config SM8150
+	bool "Qualcomm Snapdragon 855 SoC"
+	select LINUX_KERNEL_IMAGE_HEADER
+	imply CLK_QCOM_SM8150
+	imply PINCTRL_QCOM_SDM8150
+
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
=20
@@ -90,6 +96,13 @@ config TARGET_QCS404EVB
 	  - 1GiB RAM
 	  - 8GiB eMMC, uSD slot
=20
+config TARGET_SA8155P_ADP
+	bool "SA8155 Automotive Development Platform"
+	help
+	  Support for Lantronix/Qualcomm SA8155P Automotive Development Platform
+	  based on Snapdragon SA8155P
+	select SM8150
+
 endchoice
=20
 source "board/qualcomm/dragonboard410c/Kconfig"
@@ -97,5 +110,6 @@ source "board/qualcomm/dragonboard820c/Kconfig"
 source "board/qualcomm/dragonboard845c/Kconfig"
 source "board/samsung/starqltechn/Kconfig"
 source "board/qualcomm/qcs404-evb/Kconfig"
+source "board/qualcomm/sa8155p-adp/Kconfig"
=20
 endif
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/M=
akefile
index 3a3a297c17..ff2887e384 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -4,8 +4,10 @@
=20
 obj-$(CONFIG_SDM845) +=3D sysmap-sdm845.o
 obj-$(CONFIG_SDM845) +=3D init_sdm845.o
+obj-$(CONFIG_SM8150) +=3D sysmap-sm8150.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) +=3D sysmap-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) +=3D sysmap-apq8016.o
 obj-y +=3D misc.o
 obj-y +=3D dram.o
 obj-$(CONFIG_TARGET_QCS404EVB) +=3D sysmap-qcs404.o
+obj-$(CONFIG_TARGET_SA8155P_ADP) +=3D init_sa8155p.o
diff --git a/arch/arm/mach-snapdragon/init_sa8155p.c b/arch/arm/mach-snapdr=
agon/init_sa8155p.c
new file mode 100644
index 0000000000..64dd07ae92
--- /dev/null
+++ b/arch/arm/mach-snapdragon/init_sa8155p.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Qualcomm SM8150 initialization procedures
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ */
+
+#include <init.h>
+#include <env.h>
+#include <asm/system.h>
+#include <dm.h>
+#include <asm/arch/misc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+void reset_cpu(void)
+{
+	psci_system_reset();
+}
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/arch/arm/mach-snapdragon/sysmap-sm8150.c b/arch/arm/mach-snapd=
ragon/sysmap-sm8150.c
new file mode 100644
index 0000000000..7250f5b398
--- /dev/null
+++ b/arch/arm/mach-snapdragon/sysmap-sm8150.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Qualcomm SM8150 memory map
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ */
+
+#include <asm/armv8/mmu.h>
+
+static struct mm_region sm8150_mem_map[] =3D {
+	{
+		.virt =3D 0x0UL, /* Peripheral block */
+		.phys =3D 0x0UL, /* Peripheral block */
+		.size =3D 0x10000000UL,
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt =3D 0x80000000UL, /* DDR */
+		.phys =3D 0x80000000UL, /* DDR */
+		.size =3D 0x200000000UL, /* 8GiB - maximum allowed memory */
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map =3D sm8150_mem_map;
diff --git a/board/qualcomm/sa8155p-adp/Kconfig b/board/qualcomm/sa8155p-ad=
p/Kconfig
new file mode 100644
index 0000000000..420d594e35
--- /dev/null
+++ b/board/qualcomm/sa8155p-adp/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_SA8155P_ADP
+
+config SYS_BOARD
+	default "sa8155p_adp"
+
+config SYS_CONFIG_NAME
+	default "sa8155p_adp"
+
+config SYS_VENDOR
+	default "qualcomm"
+
+endif
diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8155=
p-adp/MAINTAINERS
new file mode 100644
index 0000000000..28edd643da
--- /dev/null
+++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
@@ -0,0 +1,6 @@
+Qualcomm Robotics RB3 Development Platform (dragonboard845c)
+M:	Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+S:	Maintained
+F:	board/qualcomm/sa8155p-adp/
+F:	include/configs/sa8155p-adp.h
+F:	configs/sa8155p-adp_defconfig
diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defconfig
new file mode 100644
index 0000000000..40f275b2cb
--- /dev/null
+++ b/configs/sa8155p_adp_defconfig
@@ -0,0 +1,33 @@
+CONFIG_ARM=3Dy
+CONFIG_SKIP_LOWLEVEL_INIT=3Dy
+CONFIG_COUNTER_FREQUENCY=3D19000000
+CONFIG_POSITION_INDEPENDENT=3Dy
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=3Dy
+CONFIG_ARCH_SNAPDRAGON=3Dy
+CONFIG_TEXT_BASE=3D0x85710000
+CONFIG_DEFAULT_DEVICE_TREE=3D"sa8155p-adp"
+CONFIG_TARGET_SA8155P_ADP=3Dy
+CONFIG_IDENT_STRING=3D"\nQualcomm SA8155P-ADP"
+CONFIG_SYS_LOAD_ADDR=3D0x85710000
+CONFIG_BOOTDELAY=3D3
+CONFIG_SYS_CBSIZE=3D512
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_HUSH_PARSER=3Dy
+CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_CLK=3Dy
+CONFIG_MSM_GPIO=3Dy
+CONFIG_QCOM_PMIC_GPIO=3Dy
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
index 0f9c429956..05195de905 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -9,3 +9,4 @@ Qualcomm
    dragonboard410c
    sdm845
    qcs404
+   sa8155p-adp
diff --git a/doc/board/qualcomm/sa8155p-adp.rst b/doc/board/qualcomm/sa8155=
p-adp.rst
new file mode 100644
index 0000000000..cff68cd55f
--- /dev/null
+++ b/doc/board/qualcomm/sa8155p-adp.rst
@@ -0,0 +1,94 @@
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
+We need to create ELF file from the u-boot binary. We can't use
+existing U-Boot ELF, because it does not include appended DTB
+file. Easiest way to do this is to use ``create_elf.py`` from the
+following repository: `qtestsign(lorc)
+<https://github.com/lorc/qtestsign/tree/create_elf>`_: ::
+
+	$ python ../qtestsign/create_elf.py u-boot.bin 0x85710000 u-boot.mbn
+
+Next, this new binary should be signed with test keys: ::
+
+	$ ../qtestsign/qtestsign.py -v6 hyp u-boot.mbn
+
+Resulting ``u-boot-test-signed.mbn`` then can be written to the
+board. Easiest way is to use ``edl`` tool: ::
+
+	$ ../edl/edl w hyp_a u-boot-test-signed.mbn --memory=3Dufs --lun=3D4
+
+Be sure to backup existing hyp_a loader before flashing U-Boot
diff --git a/include/configs/sa8155p_adp.h b/include/configs/sa8155p_adp.h
new file mode 100644
index 0000000000..e986646334
--- /dev/null
+++ b/include/configs/sa8155p_adp.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Configuration file for SA8155P Automotive development platform,
+ * based on Qualcomm SA8155P chip
+ *
+ * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
+ * Copyright (c) 2024 EPAM Systems.
+ */
+
+#ifndef __CONFIGS_SA8155P_ADP_H
+#define __CONFIGS_SA8155P_ADP_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"bootm_size=3D0x10000000\0"	\
+	"bootm_low=3D0xA0000000\0"	\
+	"bootm_mapsize=3D0x39900000\0" \
+	"kernel_comp_add_r=3D0xB0000000\0" \
+	"kernel_comp_size=3D0x01000000\0" \
+	"" \
+
+#endif
--=20
2.43.0
