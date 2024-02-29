Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9868C54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E2D8810E;
	Thu, 29 Feb 2024 15:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="jwRuvGwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971D88809A; Thu, 29 Feb 2024 15:21:29 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0FA8809C
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TEGl6Y018534; Thu, 29 Feb 2024 14:21:11 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wjuj380gr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS1IdJBdRZrFXiUmtMUnwPi+RKul9ZkawHYPNMfMjOFGah25q3aqXjsXYlIXUdJ3YB0X6IO0coHVD/10CcFfp2Q2pUaDzccIfsp7NSlISsGKQV9NOaSYEpbXSSTSC3fkmMNC+yqy+affI5Ere3CkG6E0WrWBE3lhpoGa5VxJGl0XO8TFp+jPAnkOSMhSprnL8ETWAT/ppvJTUIfmr02Vi4UF7Qi1KGCFIrq6Qq/yFjZgCScNURUEb0ZOvCTr4wNEWr9Ouf1wqEFrLtWLCSWsYLbj58G6s7MHjHOdrhiMJEG02jHQYesLv+HbhJIWv2w95U3EAWcT8e3pjKkMi60yqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsVe5p2p1kHDDQAx6ykvzbsLvhhI9PgHXOLxEx60fz0=;
 b=KhFCm+WiKHeP2Ta3NWZkjulQ2hCJ/4piBtq/eTlZYVpZDWgrvcTkxJ4BMo8LKKhW8G8+0+uIp1TuiBXsUpT5tVYlgePJ/ijLJXrfBTluyLlrtGySS41bFk8s70xxXsh9Gz1xmAI7g+tGnQY4LSHjCtnbwgGQjHOIRUpKjIyBfbpKLbITSAyw9O/8LiR+6aDRjOwSmxo1wLO5nRIIkrT6VBCiOCUkIwF7HnH3ZXjmrxYTqTDy1m4jPRPSKmhiapt9R44XzvVQH3vSENryvyap4AytrhmkfdboiEJK8NUvqIODsCgAsp6hwdYB3MTMba3CD67OmWsXOw0YJa3952zZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsVe5p2p1kHDDQAx6ykvzbsLvhhI9PgHXOLxEx60fz0=;
 b=jwRuvGwtftccUI/7mHSh9NpSQyUgF7QtgHAbECJ/hCq1mo0fWlvyvReZMPhPp5ClqJ2jIhgI+XJzUfmNHjbqaBRo/CrXZbj0jmZuXxbKUdg0UpKGo/gb7MUHsGE60Jv0uebitlfKbUafP1KSEEg4yKQPiZ3KxRm0Nl+NHts6aYPDHRimFxACaniJb7lSbvEJoJiDaUS83P5lpBxRFtD1Dx1QEDoYsLSy7IVgDGsoCq97wp0hpPVhZBk66P2dOUHsFg2DsWPE4/GGBkS6HPT0DDqefkTnx7KRd8rKFrZ1umbiQdEvrf1VEvpY8BJq36R0nGsCdXv7G4PgCyCOJuvjqg==
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com (2603:10a6:10:516::14)
 by AS8PR03MB7735.eurprd03.prod.outlook.com (2603:10a6:20b:405::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 14:21:06 +0000
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c]) by DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:21:06 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Elmar Psilog <epsi@gmx.de>, Joe Hershberger
 <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Ley
 Foon Tan <leyfoon.tan@starfivetech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Neil
 Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Topic: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Index: AQHaaxqISgHy6uye4kSlwIGnnVXBNQ==
Date: Thu, 29 Feb 2024 14:21:06 +0000
Message-ID: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: 50edb14b-54cf-428c-d1cc-08dc3931aac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oEyC6QnaHViMqQk+TUhQfM69ThW3MKrSlOy9YUYhLYZHNYCbmiG9bgm/vtJqATTFVVh/ydq8m6MsjKFnOgfmHFcK53InTQRU5RQ5dfvzCd0L/kRAiZS6NcxHsjyxrQ4gzaAJ92fgWTM3rJNnNrvseBmsQJUe5O1ZjPrw4tgLdPXbagkg19w6tdCT2cc4RuIbWTw78bV0MU1xlCSknIU9ZfdYrj0IYz++wteuOLOdqdLJsGJYFduxYzVQzR9efqoV95hKNxnk5yUtV2QiBsCyFXeuvRe43icJyxC5XAYIZD/dJ+6ZRBCPUrN4awkqYoljrhPwHIItMc94bOfwV+jRpskKvKbTNfg+fzdWaSBudhgE7a5KFzw5ldfPFhk4ecPUCjnw4vxGG0t4CNtfnDT+XDI/LRRk7MOzRWJMFvk5D8CIwifONgacVViKfLIpmdolAbKxHqg+udipcA35m+3y5p6UArcz5+AXDp8EhREFbMPji8tJftFk6buaQOf0wJHWlg4W29Djghy8v0DQxupvSBnac7Fdbc7DLIybgRaQ83S0kaomkjKs6cV/iIGnlY5M5i9OOba4j1JkIi87xJvOkV+BcmmxDwsxOM7HpleWO41AQ/CJOT+mVKreyK3VrwsDF3JMcvx3nb92lBhfBA9Le06fMDn8/r1GhMN3L2pG58grDgQk6+dkD/VfK2kYx/yg9C5CKPPmbCbrDpiWgncQ9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k1OIaV7k2JR/cSX8dVLmbcZsn2RWXOL2yF0yhf5a0LK8s5WB5SffWMGYFW?=
 =?iso-8859-1?Q?ppiqGv1BPZ3EZMLcdyTCJz6kx6I2BQ+mZq+9UYtc53/Kwhe7RW1vrlePPP?=
 =?iso-8859-1?Q?JERylEuWfbZMG73PuMRXo0jAZjP2q+0jBdnkx3Bs2ulJXb06EdngjyHrZg?=
 =?iso-8859-1?Q?mmJWzeAg6BPmltUKcA6OgdiSV2DmFeBkX6QINIRpLDFwsdBNoVJjyfXe3A?=
 =?iso-8859-1?Q?7icJCMk8KlzB+jUYdAfHb5PhsycHM+sTB5nXDIK8/Cs9K09nsZ6stdM+ga?=
 =?iso-8859-1?Q?h1orMfNzntM9IroH5BxaWyZu+k85ivKlup93+DHrOQdzq8ZPz8Dxa/tkY9?=
 =?iso-8859-1?Q?HBOkldOlI54oNcoUrTgsTcF+lL4Vu/lf62XshXHxv30fBtGHPO8lEKVHxI?=
 =?iso-8859-1?Q?c8zHDMQra10rxlwVHrSNuPDgiywlH51xW0M9RbWvGkummqH4zDGcTJBPxf?=
 =?iso-8859-1?Q?YxgjTdtUbUlOnBLDuTE199qYyj0U/88lih9rn3dIAETYCs84N8F7BE0an8?=
 =?iso-8859-1?Q?Vav9rleO/5di8MZbLxXe0XLkWRO6i8uJnzIwUCehqyxChNDD5vPGt5ci90?=
 =?iso-8859-1?Q?aaiYOrP/C0Q5qT/U7jjaotxEfcAuBSfcoinAMsTv29vay7hLzUIO++YG7L?=
 =?iso-8859-1?Q?NUpxDahpoDCFFPISVjhzyEHIKSSm+EoNIhYRQEnKto4rRPZ3aR7cjzeJEl?=
 =?iso-8859-1?Q?OaCFKBmpmkBxBTPlrO9wUd0i+jToIEEXTOqcjuxfIfO1lL0K+5IEFBKYWX?=
 =?iso-8859-1?Q?oCgFqDquuudOBGBkCKnnD56dh2WzU2S7j6T0VHtMd20jX9Mnz1oyHp01Kq?=
 =?iso-8859-1?Q?n0yvUJma8CxBZtr9caGkRpzGudrmyxB5ntTk1MDnDgi3RFn1dxesR31nR7?=
 =?iso-8859-1?Q?E22JeVNJthYj7Bodn+PpRiHWUGn6o3WIo9bKqEwfW0ODJl5AJPtWIctClH?=
 =?iso-8859-1?Q?PfvAJJ86WM1hjQXmD3V1jxB4yyHACgeunXizRaj3xOPu9IYYf/WlCwWJWm?=
 =?iso-8859-1?Q?pmjr0x4S7BkYTvoz6ntJMFCAmXWcNSX702tEph51+w99RanSM6TZgS0QuC?=
 =?iso-8859-1?Q?e6rUVZVF0dV1Omg+7zBL9/pZL9RRgzDvNkVyeCEteeSXrzkuMlLlmVAwnw?=
 =?iso-8859-1?Q?x8Wyff1vpqzAX9JQF2paXlFrKexAiOu7PvXM3ERhKieK0cEAcX3DCD7f8R?=
 =?iso-8859-1?Q?B8dwVlrkcy8z6lq4RNDGpQWPEDaVOwi+5t2LqY/CiO9FcRBQLaM7vK6yf9?=
 =?iso-8859-1?Q?D5aR3JvsPINNd7hL0hd3wS9WrA704g/YdAQGV0iBeSF0FG0IdGxxKWV9EC?=
 =?iso-8859-1?Q?YgIz9SI6y5u7OkuOceIJpONzKPyWvZYigmmtrX3OEwnU+tX7q5pWUaW1vq?=
 =?iso-8859-1?Q?pzUg2xqAmnlgCs/zKL74Ap342WzBkOEEV2tIVr/52A1ORyilnBJgagbnUv?=
 =?iso-8859-1?Q?kDUcfwurNG6mA/i0qW/XsPesblvpPfBIj67SDjPXEFG96/MsIBPcmZhMeQ?=
 =?iso-8859-1?Q?iRPIJJkdDqBHCFI4slXSXVQtfYuXbHbAkbJrB25m4eXdQyIIiK0OwZ3BQc?=
 =?iso-8859-1?Q?7QRS51L85rEVlYn0mivehkMhtpb+WRnirTjw3ifys2G6Dl9rrBVHZUpIpz?=
 =?iso-8859-1?Q?CvotjLBdy6ilb1fNTQX5omaX6rs24ihZd/Klu+tbcSIHy21zE6JRPjOA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50edb14b-54cf-428c-d1cc-08dc3931aac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:06.0763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdaUF7KBPKbdgFUReWnateBwVRxmtPxH7uZIlX/SF4RKqD13Q1ab+DLG+IrBZxdH9H1UcngbFCYSal541U69RDFiwVtCHJBluIFlQcQlQWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: 3uVPrADCiLy0hqwrb3UbaO19twMyLp6m
X-Proofpoint-ORIG-GUID: 3uVPrADCiLy0hqwrb3UbaO19twMyLp6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
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


This patch series adds support for Qualcomm SA8155-ADP development
board. Main motivation for this series is to allow running
virtualization software on this board and U-Boot is a good way to
break Qualcomm's boot chain at EL2 with more convenient ways for
uploading and running the code. With this patches applied it is
possible to upload and run Xen on this board. KVM probably should work
too.

I added myself as a maintainer for this board, but my abilities to
maintain it are quite limited as I have no access to Qualcomm
documentation. I used mostly Linux drivers as the source for
device-specific information, like register addresses and offsets.
If anyone wants to maintain this, I will gladly agree.


Volodymyr Babchuk (8):
  clk: qcom: clear div mask before assigning new divider
  dts: qcom: import device trees and bindings for SA8155P-ADP
  net: dw_eth_qos: add support for Qualcomm SM8150 SoC
  clk: qcom: add support for power domains uclass
  clk: qcom: add driver for SM8150 SoC
  pinctr: qcom: pass pin number to get_function_mux callback
  pinctrl: qcom: add driver for SM8150 SoC
  board: add support for Qualcomm SA8155P-ADP board

 arch/arm/dts/pmm8155au_1.dtsi                 |  135 +
 arch/arm/dts/pmm8155au_2.dtsi                 |  108 +
 arch/arm/dts/sa8155p-adp-u-boot.dtsi          |   30 +
 arch/arm/dts/sa8155p-adp.dts                  |  606 ++
 arch/arm/dts/sa8155p.dtsi                     |   40 +
 arch/arm/dts/sm8150.dtsi                      | 5293 +++++++++++++++++
 arch/arm/mach-snapdragon/Kconfig              |   14 +
 arch/arm/mach-snapdragon/Makefile             |    2 +
 arch/arm/mach-snapdragon/init_sa8155p.c       |   30 +
 arch/arm/mach-snapdragon/sysmap-sm8150.c      |   31 +
 board/qualcomm/sa8155p-adp/Kconfig            |   12 +
 board/qualcomm/sa8155p-adp/MAINTAINERS        |    6 +
 configs/sa8155p_adp_defconfig                 |   33 +
 doc/board/qualcomm/index.rst                  |    1 +
 doc/board/qualcomm/sa8155p-adp.rst            |   94 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clock-qcom.c                 |   96 +-
 drivers/clk/qcom/clock-qcom.h                 |    7 +
 drivers/clk/qcom/clock-sm8150.c               |  234 +
 drivers/net/dwc_eth_qos.c                     |    4 +
 drivers/net/dwc_eth_qos.h                     |    2 +
 drivers/net/dwc_eth_qos_qcom.c                |   47 +-
 drivers/pinctrl/qcom/Kconfig                  |    7 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-apq8016.c        |    3 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c        |    3 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c        |    3 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c           |    4 +-
 drivers/pinctrl/qcom/pinctrl-qcom.h           |    3 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c         |    3 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c         |    3 +-
 drivers/pinctrl/qcom/pinctrl-sm8150.c         |  589 ++
 include/configs/sa8155p_adp.h                 |   25 +
 .../dt-bindings/clock/qcom,dispcc-sm8150.h    |   76 +
 include/dt-bindings/clock/qcom,gcc-sm8150.h   |  252 +
 include/dt-bindings/clock/qcom,gpucc-sm8150.h |   33 +
 include/dt-bindings/clock/qcom,rpmh.h         |   37 +
 include/dt-bindings/dma/qcom-gpi.h            |   11 +
 include/dt-bindings/firmware/qcom,scm.h       |   39 +
 include/dt-bindings/iio/qcom,spmi-vadc.h      |  303 +
 .../dt-bindings/interconnect/qcom,osm-l3.h    |   15 +
 .../dt-bindings/interconnect/qcom,sm8150.h    |  159 +
 include/dt-bindings/phy/phy-qcom-qmp.h        |   20 +
 include/dt-bindings/power/qcom-rpmpd.h        |  412 ++
 .../regulator/qcom,rpmh-regulator.h           |   36 +
 include/dt-bindings/soc/qcom,rpmh-rsc.h       |   14 +
 47 files changed, 8866 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/dts/pmm8155au_1.dtsi
 create mode 100644 arch/arm/dts/pmm8155au_2.dtsi
 create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
 create mode 100644 arch/arm/dts/sa8155p-adp.dts
 create mode 100644 arch/arm/dts/sa8155p.dtsi
 create mode 100644 arch/arm/dts/sm8150.dtsi
 create mode 100644 arch/arm/mach-snapdragon/init_sa8155p.c
 create mode 100644 arch/arm/mach-snapdragon/sysmap-sm8150.c
 create mode 100644 board/qualcomm/sa8155p-adp/Kconfig
 create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
 create mode 100644 configs/sa8155p_adp_defconfig
 create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
 create mode 100644 drivers/clk/qcom/clock-sm8150.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c
 create mode 100644 include/configs/sa8155p_adp.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,rpmh.h
 create mode 100644 include/dt-bindings/dma/qcom-gpi.h
 create mode 100644 include/dt-bindings/firmware/qcom,scm.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-vadc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
 create mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h

--=20
2.43.0
