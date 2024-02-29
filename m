Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF2CC48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7250880FE;
	Thu, 29 Feb 2024 15:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="dP7lkYNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E851B880CC; Thu, 29 Feb 2024 15:21:27 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7468A8809A
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TEGl6a018534; Thu, 29 Feb 2024 14:21:13 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wjuj380gr-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE6AGGMQ5BGV9KIcKcHKOGL/9eMA7BE0jTZWdhYmIyfYmvYkSgL3T/+/5NJbviddcdiwryESg6rqcoMFZ1w+Rnig3pdROOQkgR3m1gkE0NOq+aIdTnLjaxH54DIMxkbBPILCyqyZ9W2Bfv/bOar/c+ipC7Plub7EMJBWfkiCVaBrcNFZoYP/B+Lnc+EWQ6vIai3810RzDmuAphHWFnY5OE9iPzBtQMe2ZtMurDKt56quMjWCS16OLDQlwo2+8rHktFEo/jkYIvHey1F/f66kU0lQOxzyJYR0ZrXVaB/7wP60zBLG20eGg4R8FEgF+NnfeWONpQhF/hA5CjdnVAomaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9yKzr2a5noil90hSsLJ5R0rlhYfWg1JCKyCPHVI5Ds=;
 b=Fv+UDDFndkMBk+c8dS8QICKfX3dAXcX3f6IAMph0kC3y2bQV2pHoqVDwXJbPF28OibMHwVeOZt8Q9Dxh6Smn8/iS6GSXJYhRaupS64qk+QBIZKQnT3AWWMkpAyXvI5lHOl4u63RCp078THrtsB2sULKvRdUP6+80aJ77mfwKJJ+DdQLL/3FTttmdIeV6U99AmC3x9K3knrjNn50u59iGVEfKuVk5HerhBXHr3uWbPE0YToTbDSfcGeg879vVnbGjQKdE5z3yd0xlTgUr6FTmi+zrhn4WDEDH3TD8JPze6D12dA2L5csIlPX9Tm7tN/CsRmi+zKCNS9YjOi0KOZ2CDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9yKzr2a5noil90hSsLJ5R0rlhYfWg1JCKyCPHVI5Ds=;
 b=dP7lkYNKGjZJSo9RTwpjnxzL4ToTiOTJYxCXI1izAl3UDfvGpNBbHtUk/o53XEg5qU/+Xu6w/Va7yodVDn3YPcq5Fykoc5GYHamRtXhIWeKRcCJckeP16uE4No2A7STRLMfh7+/IwM5FnKS5325Ho9KGyO1l01Vgbmz67piTijXFPTIHmWzv+ta6qehaybGsH1pH4YubzA8G9EnmGHPHGdw0ZCI/uBvpqXdo5Jv/RTegtERs5N5uHE1xSbe6paAPyz2OsOz1SceIjS7LTr4BORD5PV649p6YWVvIW0RPnASAHa8W9FYRQN3HgriOF1120wXvcHsAg2AaQuRdqYbW9Q==
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com (2603:10a6:10:516::14)
 by AS8PR03MB7735.eurprd03.prod.outlook.com (2603:10a6:20b:405::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 14:21:07 +0000
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c]) by DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:21:07 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/8] dts: qcom: import device trees and bindings for
 SA8155P-ADP
Thread-Topic: [PATCH 2/8] dts: qcom: import device trees and bindings for
 SA8155P-ADP
Thread-Index: AQHaaxqJCSoM3WQ8K0Cg2sYh115jhQ==
Date: Thu, 29 Feb 2024 14:21:07 +0000
Message-ID: <20240229142043.1263690-3-volodymyr_babchuk@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: f1ddde69-9ab9-44ae-726f-08dc3931ab87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AK7F4HO0mvk9UeuYJkOO2tgxgyzYs8tI3Z7R1uSfAv62WmNu7dHzhqPO/GI3NOVoK0/YcW5M0atwuYaYdQqTziUuOUwcpE7sFuclRMUqSBPeBdQMogM50d9BtIUjgFhyvyU4ArYqt13bRM9sUXpYTRh0ud1GZErKupBIVyRhfd9vEcbr485LsAGAQu4cNUl92EN2TopDrjPG1siYbMC1jmADf/oIqGrDWocOuTN8yHbNAkX/vglV7Ditg2YRoVGFSGexZl1QnGH25o6ujaBWcVQD0yVg1AVoSjNkfwED7l4bkRj+CBM3hhOmwt1KjUUWirvRyx7AqyQ5j8cMOjuQPKpEBAKBM3ovoH6EQYUpjLWqgUaykTeA1nPutFdIDa/M0vRgsOzx1jDvzOCyPLZ3eOKLLhBo/5CfkpwMBxjUFqp8YS2ffhIaQOVJXzILu4N9y7JOFKCbVlqJ/zlpRDSgcPCVwXxuGT2FT+5zOxU9hIxO6yjQtePVlebtRCDLMv6RSHF3ziKrQV5Bi1mmJ4w04m7a3W0IZFoJwrR9eqahOI+OFRG+rC+OdxhA/LSWFiH/Or7D7KIfth7c8u9IeuHBsHB8iKS/3SeXH9lww7Z+vTkH4D+ltayEGBh44Nv4DmfjJX9EDF2PaJDwpzrdvVtnsdCY8ElhFnYVOW0tSW6VwR5+T09DZ8jRJUmRi+fDVtvkbfzD+FCQZo3iS4mUStvNYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F0MEeVFwi0eQl5gBn5cA+CIW2Rq7obREE8w8D91cYxAt8C64U8qA2NPJ3Z?=
 =?iso-8859-1?Q?SnguNsoVGSQgStUDBTH0/gFkEBrGVO6nKHB0y2/SQw4jwRF+wx49r3XRja?=
 =?iso-8859-1?Q?L2nXLmjIifeXjqMifNKAF5QRyP9sue4rSG4IUMiu/ykP2V9scTIneOZIUh?=
 =?iso-8859-1?Q?uKXbbI8EjEJ/RLesAb/k8b9N+0aPzMo+KrKC7MwQ6WE27c40jMonwymoTX?=
 =?iso-8859-1?Q?OqxDT8kafWJyo1iuPnIC3/lIaOUnlhKzcdnzj/R3cfR6GGQgFoKTJ4vh6Y?=
 =?iso-8859-1?Q?ShowGS1NBeOhcxu/A81nhbGv2/r+x8bLEPMnFIaAbpLM1YZlFCEVtA/1+v?=
 =?iso-8859-1?Q?hXWPmup6N57579TraBoFtqBS0Tgcy7tPrwBY6BOm2+skB8O7Zr5Ybj01mq?=
 =?iso-8859-1?Q?cwKy0Xb+O7QhMaw7kcooi8cPi+3dbBTADbf0l6tbl0hEm9H3d11Kha1AZT?=
 =?iso-8859-1?Q?J4Qvnk14snoiGlguyi8dCZyW7Y8RgkH5tMrfFpOrsfteFkwjoHP5lb35Xj?=
 =?iso-8859-1?Q?WSdQAFUWUUL3gyiYDjW+y35DOSY0FRwjv2U6eIF4sR5nxPAjKc97HGnIGf?=
 =?iso-8859-1?Q?l/KvUwWfc3Kdy0X1009aUgpi8fKRaz6dXzV5cpIPUYOJ5vdVi2YuOFP+am?=
 =?iso-8859-1?Q?HbCshYgSHGcfayON4Mh76egrAGnOuFpLbX1IEJwEvHgeRnTZYovuC7Q7Ma?=
 =?iso-8859-1?Q?9jzW2FzFEx2TTkxH/MU8RpJ9idH3ZO9jN9J5AbOjrBHzOFeNVzcpFC7uEC?=
 =?iso-8859-1?Q?/KL1yOmchDBeHR4eV2gUgIqMfi9oV9UcyLRdbWuDWpLpThGgr8wLwQ1i+x?=
 =?iso-8859-1?Q?XY+kYYRPZD45bDi4QT+VjHef/Y0UYg6VA7mK6KPhh7EnsCThB8lpKhIr3L?=
 =?iso-8859-1?Q?oMfowhsXP9Aelwa5bYYcn4uoHx4ce2G9mBL8AFqRIAdKEE+LpFgY88tTE9?=
 =?iso-8859-1?Q?oWfCVVw8T4kNOLk1nBtqQYXbCpGE+lc2adFO5d+KNpUzMOKMYvlUoR9Exr?=
 =?iso-8859-1?Q?wFsi7iLQGJKhgSaujF5uiKHSN6ZdfjsCJ3+0pIKhURuY4s0BMGm7dhPrGE?=
 =?iso-8859-1?Q?xUfoo0x1CIsujZ1cmxgqDx67XrY6gnW5v4oey3VXfjtyTXMCE43Nb5YA31?=
 =?iso-8859-1?Q?eE4gnaTP6T2K8IrNMNAORccjjXbwnD1XwnjDWHFr1USIPcEfvWKMV9KHGt?=
 =?iso-8859-1?Q?WqaSWuvVzK+XVGVrqed/35Lj2zwjYgy/eG4GI3lhG/n4cmzWmHtAcURARF?=
 =?iso-8859-1?Q?+oFjEnwSNf0HLEwTfZo/XR01zWMQGVa9CE93B/jb8FLy0A3Z2I4D5xf6To?=
 =?iso-8859-1?Q?1oJWG9FCOompDuzKQpYgRZRj5RNl9nivQ6V4162iwQPFvxPRCp2W3NlzVF?=
 =?iso-8859-1?Q?3zYA7p/GAZeIoxQv6sF6Qn4O5BTD68BjZ3OLAW4mfQC1hKtPB6YfodaNDY?=
 =?iso-8859-1?Q?yNEKKuKeBnF1N2c55lnTGYR7YsvN9aLzzq/+/1fZ3NxNTJgbhdRnBTIcq3?=
 =?iso-8859-1?Q?AX62upM9weXBj/CCK+2oSyLufVm+6vwNhn7ZSXT4iGbKDraUISHIxhPDt+?=
 =?iso-8859-1?Q?ExuA8TyXmYQqovUzBRlMgn7ftpFeM7vOkGOVQWS0TMn1LGE+h5pHFLRmYM?=
 =?iso-8859-1?Q?MyArl2XHeIZwviFLPo9GCixV3uPa7ecy+rB3aiGjidOTbzaTY9/oK5tw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ddde69-9ab9-44ae-726f-08dc3931ab87
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:07.3648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGhZ7IfvTtqbeAFI+2/jWue0Y/qFpwU7ojd+88I7fflhi3wKE8EPJ4uCq3IEGcMVwsNKN8F1sdkwL26tbMr+xtSC1BQLKemYIe4vlEXz9Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: hj0Uj9O3LXan9uavoiCwvnfnK2c2OaCv
X-Proofpoint-ORIG-GUID: hj0Uj9O3LXan9uavoiCwvnfnK2c2OaCv
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

Add device tree bindings and actual device trees for SM8150 SoC and
SA8155P-ADP board. Those files were imported from Linux kernel 6.8-rc5
as is. In this configuration they will not work with U-Boot for couple
reasons:

 - memory@ node is incomplete, as Linux expects that bootloader at the
 previous stage would populate the node with the actual memory
 configuration

 - pinctrl node uses multi-tile register mapping which is not
 supported by the U-Boot driver

Next patches will address this issues. We are importing the existing
files as is in this separate patch to ease up tracking changes from
Linux.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 arch/arm/dts/pmm8155au_1.dtsi                 |  135 +
 arch/arm/dts/pmm8155au_2.dtsi                 |  108 +
 arch/arm/dts/sa8155p-adp.dts                  |  606 ++
 arch/arm/dts/sa8155p.dtsi                     |   40 +
 arch/arm/dts/sm8150.dtsi                      | 5293 +++++++++++++++++
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
 18 files changed, 7589 insertions(+)
 create mode 100644 arch/arm/dts/pmm8155au_1.dtsi
 create mode 100644 arch/arm/dts/pmm8155au_2.dtsi
 create mode 100644 arch/arm/dts/sa8155p-adp.dts
 create mode 100644 arch/arm/dts/sa8155p.dtsi
 create mode 100644 arch/arm/dts/sm8150.dtsi
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

diff --git a/arch/arm/dts/pmm8155au_1.dtsi b/arch/arm/dts/pmm8155au_1.dtsi
new file mode 100644
index 0000000000..7072e5a2e7
--- /dev/null
+++ b/arch/arm/dts/pmm8155au_1.dtsi
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
+/ {
+	thermal-zones {
+		pmm8155au-1-thermal {
+			polling-delay-passive =3D <100>;
+			polling-delay =3D <0>;
+
+			thermal-sensors =3D <&pmm8155au_1_temp>;
+
+			trips {
+				trip0 {
+					temperature =3D <95000>;
+					hysteresis =3D <0>;
+					type =3D "passive";
+				};
+
+				trip1 {
+					temperature =3D <115000>;
+					hysteresis =3D <0>;
+					type =3D "hot";
+				};
+
+				trip2 {
+					temperature =3D <145000>;
+					hysteresis =3D <0>;
+					type =3D "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmic@0 {
+		compatible =3D "qcom,pmm8155au", "qcom,spmi-pmic";
+		reg =3D <0x0 SPMI_USID>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		pon: power-on@800 {
+			compatible =3D "qcom,pm8916-pon";
+			reg =3D <0x0800>;
+			pwrkey {
+				compatible =3D "qcom,pm8941-pwrkey";
+				interrupts =3D <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
+				debounce =3D <15625>;
+				bias-pull-up;
+				linux,code =3D <KEY_POWER>;
+
+				status =3D "disabled";
+			};
+		};
+
+		pmm8155au_1_temp: temp-alarm@2400 {
+			compatible =3D "qcom,spmi-temp-alarm";
+			reg =3D <0x2400>;
+			interrupts =3D <0x0 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels =3D <&pmm8155au_1_adc ADC5_DIE_TEMP>;
+			io-channel-names =3D "thermal";
+			#thermal-sensor-cells =3D <0>;
+		};
+
+		pmm8155au_1_adc: adc@3100 {
+			compatible =3D "qcom,spmi-adc5";
+			reg =3D <0x3100>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			#io-channel-cells =3D <1>;
+			interrupts =3D <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg =3D <ADC5_REF_GND>;
+				qcom,pre-scaling =3D <1 1>;
+				label =3D "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg =3D <ADC5_1P25VREF>;
+				qcom,pre-scaling =3D <1 1>;
+				label =3D "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg =3D <ADC5_DIE_TEMP>;
+				qcom,pre-scaling =3D <1 1>;
+				label =3D "die_temp";
+			};
+		};
+
+		pmm8155au_1_adc_tm: adc-tm@3500 {
+			compatible =3D "qcom,spmi-adc-tm5";
+			reg =3D <0x3500>;
+			interrupts =3D <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells =3D <1>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		pmm8155au_1_rtc: rtc@6000 {
+			compatible =3D "qcom,pm8941-rtc";
+			reg =3D <0x6000>;
+			reg-names =3D "rtc", "alarm";
+			interrupts =3D <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+
+			status =3D "disabled";
+		};
+
+		pmm8155au_1_gpios: gpio@c000 {
+			compatible =3D "qcom,pmm8155au-gpio";
+			reg =3D <0xc000>;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+			gpio-ranges =3D <&pmm8155au_1_gpios 0 0 10>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible =3D "qcom,pmm8155au", "qcom,spmi-pmic";
+		reg =3D <0x1 SPMI_USID>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+	};
+};
diff --git a/arch/arm/dts/pmm8155au_2.dtsi b/arch/arm/dts/pmm8155au_2.dtsi
new file mode 100644
index 0000000000..72075964fb
--- /dev/null
+++ b/arch/arm/dts/pmm8155au_2.dtsi
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pmm8155au-2-thermal {
+			polling-delay-passive =3D <100>;
+			polling-delay =3D <0>;
+
+			thermal-sensors =3D <&pmm8155au_2_temp>;
+
+			trips {
+				trip0 {
+					temperature =3D <95000>;
+					hysteresis =3D <0>;
+					type =3D "passive";
+				};
+
+				trip1 {
+					temperature =3D <115000>;
+					hysteresis =3D <0>;
+					type =3D "hot";
+				};
+
+				trip2 {
+					temperature =3D <145000>;
+					hysteresis =3D <0>;
+					type =3D "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmic@4 {
+		compatible =3D "qcom,pmm8155au", "qcom,spmi-pmic";
+		reg =3D <0x4 SPMI_USID>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		power-on@800 {
+			compatible =3D "qcom,pm8916-pon";
+			reg =3D <0x0800>;
+
+			status =3D "disabled";
+		};
+
+		pmm8155au_2_temp: temp-alarm@2400 {
+			compatible =3D "qcom,spmi-temp-alarm";
+			reg =3D <0x2400>;
+			interrupts =3D <0x4 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels =3D <&pmm8155au_2_adc ADC5_DIE_TEMP>;
+			io-channel-names =3D "thermal";
+			#thermal-sensor-cells =3D <0>;
+		};
+
+		pmm8155au_2_adc: adc@3100 {
+			compatible =3D "qcom,spmi-adc5";
+			reg =3D <0x3100>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			#io-channel-cells =3D <1>;
+			interrupts =3D <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg =3D <ADC5_REF_GND>;
+				qcom,pre-scaling =3D <1 1>;
+				label =3D "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg =3D <ADC5_1P25VREF>;
+				qcom,pre-scaling =3D <1 1>;
+				label =3D "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg =3D <ADC5_DIE_TEMP>;
+				qcom,pre-scaling =3D <1 1>;
+				label =3D "die_temp";
+			};
+		};
+
+		pmm8155au_2_gpios: gpio@c000 {
+			compatible =3D "qcom,pmm8155au-gpio";
+			reg =3D <0xc000>;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+			gpio-ranges =3D <&pmm8155au_2_gpios 0 0 10>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+	};
+
+	pmic@5 {
+		compatible =3D "qcom,pmm8155au", "qcom,spmi-pmic";
+		reg =3D <0x5 SPMI_USID>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+	};
+};
diff --git a/arch/arm/dts/sa8155p-adp.dts b/arch/arm/dts/sa8155p-adp.dts
new file mode 100644
index 0000000000..5e4287f8c8
--- /dev/null
+++ b/arch/arm/dts/sa8155p-adp.dts
@@ -0,0 +1,606 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "sa8155p.dtsi"
+#include "pmm8155au_1.dtsi"
+#include "pmm8155au_2.dtsi"
+
+/ {
+	model =3D "Qualcomm Technologies, Inc. SA8155P ADP";
+	compatible =3D "qcom,sa8155p-adp", "qcom,sa8155p";
+
+	aliases {
+		serial0 =3D &uart2;
+		serial1 =3D &uart9;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	vreg_3p3: vreg-3p3-regulator {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vreg_3p3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+
+	/*
+	 * S4A is always on and not controllable through RPMh.
+	 * So model it as a fixed regulator.
+	 */
+	vreg_s4a_1p8: smps4 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vreg_s4a_1p8";
+
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply =3D <&vreg_3p3>;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible =3D "qcom,pmm8155au-rpmh-regulators";
+		qcom,pmic-id =3D "a";
+
+		vdd-s1-supply =3D <&vreg_3p3>;
+		vdd-s2-supply =3D <&vreg_3p3>;
+		vdd-s3-supply =3D <&vreg_3p3>;
+		vdd-s4-supply =3D <&vreg_3p3>;
+		vdd-s5-supply =3D <&vreg_3p3>;
+		vdd-s6-supply =3D <&vreg_3p3>;
+		vdd-s7-supply =3D <&vreg_3p3>;
+		vdd-s8-supply =3D <&vreg_3p3>;
+		vdd-s9-supply =3D <&vreg_3p3>;
+		vdd-s10-supply =3D <&vreg_3p3>;
+
+		vdd-l1-l8-l11-supply =3D <&vreg_s6a_0p92>;
+		vdd-l2-l10-supply =3D <&vreg_3p3>;
+		vdd-l3-l4-l5-l18-supply =3D <&vreg_s6a_0p92>;
+		vdd-l6-l9-supply =3D <&vreg_s6a_0p92>;
+		vdd-l7-l12-l14-l15-supply =3D <&vreg_s5a_2p04>;
+		vdd-l13-l16-l17-supply =3D <&vreg_3p3>;
+
+		vreg_s5a_2p04: smps5 {
+			regulator-name =3D "vreg_s5a_2p04";
+			regulator-min-microvolt =3D <1904000>;
+			regulator-max-microvolt =3D <2000000>;
+		};
+
+		vreg_s6a_0p92: smps6 {
+			regulator-name =3D "vreg_s6a_0p92";
+			regulator-min-microvolt =3D <920000>;
+			regulator-max-microvolt =3D <1128000>;
+		};
+
+		vreg_l1a_0p752: ldo1 {
+			regulator-name =3D "vreg_l1a_0p752";
+			regulator-min-microvolt =3D <752000>;
+			regulator-max-microvolt =3D <752000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_usb_hs_3p1:
+		vreg_l2a_3p072: ldo2 {
+			regulator-name =3D "vreg_l2a_3p072";
+			regulator-min-microvolt =3D <3072000>;
+			regulator-max-microvolt =3D <3072000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-name =3D "vreg_l3a_0p8";
+			regulator-min-microvolt =3D <800000>;
+			regulator-max-microvolt =3D <800000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_usb_hs_core:
+		vdda_usb_ss_dp_core_1:
+		vreg_l5a_0p88: ldo5 {
+			regulator-name =3D "vreg_l5a_0p88";
+			regulator-min-microvolt =3D <880000>;
+			regulator-max-microvolt =3D <880000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-name =3D "vreg_l7a_1p8";
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1800000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_2p96: ldo10 {
+			regulator-name =3D "vreg_l10a_2p96";
+			regulator-min-microvolt =3D <2504000>;
+			regulator-max-microvolt =3D <2960000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-name =3D "vreg_l11a_0p8";
+			regulator-min-microvolt =3D <800000>;
+			regulator-max-microvolt =3D <800000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_usb_hs_1p8:
+		vreg_l12a_1p8: ldo12 {
+			regulator-name =3D "vreg_l12a_1p8";
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1800000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p7: ldo13 {
+			regulator-name =3D "vreg_l13a_2p7";
+			regulator-min-microvolt =3D <2704000>;
+			regulator-max-microvolt =3D <2704000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-name =3D "vreg_l15a_1p7";
+			regulator-min-microvolt =3D <1704000>;
+			regulator-max-microvolt =3D <1704000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-name =3D "vreg_l16a_2p7";
+			regulator-min-microvolt =3D <2704000>;
+			regulator-max-microvolt =3D <2960000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_2p96: ldo17 {
+			regulator-name =3D "vreg_l17a_2p96";
+			regulator-min-microvolt =3D <2504000>;
+			regulator-max-microvolt =3D <2960000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible =3D "qcom,pmm8155au-rpmh-regulators";
+		qcom,pmic-id =3D "c";
+
+		vdd-s1-supply =3D <&vreg_3p3>;
+		vdd-s2-supply =3D <&vreg_3p3>;
+		vdd-s3-supply =3D <&vreg_3p3>;
+		vdd-s4-supply =3D <&vreg_3p3>;
+		vdd-s5-supply =3D <&vreg_3p3>;
+		vdd-s6-supply =3D <&vreg_3p3>;
+		vdd-s7-supply =3D <&vreg_3p3>;
+		vdd-s8-supply =3D <&vreg_3p3>;
+		vdd-s9-supply =3D <&vreg_3p3>;
+		vdd-s10-supply =3D <&vreg_3p3>;
+
+		vdd-l1-l8-l11-supply =3D <&vreg_s4c_1p352>;
+		vdd-l2-l10-supply =3D <&vreg_3p3>;
+		vdd-l3-l4-l5-l18-supply =3D <&vreg_s4c_1p352>;
+		vdd-l6-l9-supply =3D <&vreg_s6c_1p128>;
+		vdd-l7-l12-l14-l15-supply =3D <&vreg_s5c_2p04>;
+		vdd-l13-l16-l17-supply =3D <&vreg_3p3>;
+
+		vreg_s4c_1p352: smps4 {
+			regulator-name =3D "vreg_s4c_1p352";
+			regulator-min-microvolt =3D <1352000>;
+			regulator-max-microvolt =3D <1352000>;
+		};
+
+		vreg_s5c_2p04: smps5 {
+			regulator-name =3D "vreg_s5c_2p04";
+			regulator-min-microvolt =3D <1904000>;
+			regulator-max-microvolt =3D <2000000>;
+		};
+
+		vreg_s6c_1p128: smps6 {
+			regulator-name =3D "vreg_s6c_1p128";
+			regulator-min-microvolt =3D <1128000>;
+			regulator-max-microvolt =3D <1128000>;
+		};
+
+		vreg_l1c_1p304: ldo1 {
+			regulator-name =3D "vreg_l1c_1p304";
+			regulator-min-microvolt =3D <1304000>;
+			regulator-max-microvolt =3D <1304000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_1p808: ldo2 {
+			regulator-name =3D "vreg_l2c_1p808";
+			regulator-min-microvolt =3D <1704000>;
+			regulator-max-microvolt =3D <2928000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5c_1p2: ldo5 {
+			regulator-name =3D "vreg_l5c_1p2";
+			regulator-min-microvolt =3D <1200000>;
+			regulator-max-microvolt =3D <1200000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_1p8: ldo7 {
+			regulator-name =3D "vreg_l7c_1p8";
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1800000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p2: ldo8 {
+			regulator-name =3D "vreg_l8c_1p2";
+			regulator-min-microvolt =3D <1200000>;
+			regulator-max-microvolt =3D <1200000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-name =3D "vreg_l10c_3p3";
+			regulator-min-microvolt =3D <3000000>;
+			regulator-max-microvolt =3D <3312000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_0p8: ldo11 {
+			regulator-name =3D "vreg_l11c_0p8";
+			regulator-min-microvolt =3D <800000>;
+			regulator-max-microvolt =3D <800000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12c_1p808: ldo12 {
+			regulator-name =3D "vreg_l12c_1p808";
+			regulator-min-microvolt =3D <1704000>;
+			regulator-max-microvolt =3D <2928000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13c_2p96: ldo13 {
+			regulator-name =3D "vreg_l13c_2p96";
+			regulator-min-microvolt =3D <2504000>;
+			regulator-max-microvolt =3D <2960000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15c_1p9: ldo15 {
+			regulator-name =3D "vreg_l15c_1p9";
+			regulator-min-microvolt =3D <1704000>;
+			regulator-max-microvolt =3D <2928000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16c_3p008: ldo16 {
+			regulator-name =3D "vreg_l16c_3p008";
+			regulator-min-microvolt =3D <3008000>;
+			regulator-max-microvolt =3D <3008000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18c_0p88: ldo18 {
+			regulator-name =3D "vreg_l18c_0p88";
+			regulator-min-microvolt =3D <880000>;
+			regulator-max-microvolt =3D <880000>;
+			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&ethernet {
+	status =3D "okay";
+
+	snps,reset-gpio =3D <&tlmm 79 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us =3D <0 11000 70000>;
+
+	snps,mtl-rx-config =3D <&mtl_rx_setup>;
+	snps,mtl-tx-config =3D <&mtl_tx_setup>;
+
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&ethernet_defaults>;
+
+	phy-handle =3D <&rgmii_phy>;
+	phy-mode =3D "rgmii";
+	max-speed =3D <1000>;
+
+	mdio {
+		compatible =3D "snps,dwmac-mdio";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		/* Micrel KSZ9031RNZ PHY */
+		rgmii_phy: phy@7 {
+			compatible =3D "ethernet-phy-ieee802.3-c22";
+			reg =3D <0x7>;
+
+			interrupts-extended =3D <&tlmm 124 IRQ_TYPE_EDGE_FALLING>;
+			device_type =3D "ethernet-phy";
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use =3D <1>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel =3D <0x0>;
+			snps,route-up;
+			snps,priority =3D <0x1>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use =3D <1>;
+		snps,tx-sched-wrr;
+
+		queue0 {
+			snps,weight =3D <0x10>;
+			snps,dcb-algorithm;
+			snps,priority =3D <0x0>;
+		};
+	};
+};
+
+&qupv3_id_1 {
+	status =3D "okay";
+};
+
+&remoteproc_adsp {
+	status =3D "okay";
+	firmware-name =3D "qcom/sa8155p/adsp.mdt";
+};
+
+&remoteproc_cdsp {
+	status =3D "okay";
+	firmware-name =3D "qcom/sa8155p/cdsp.mdt";
+};
+
+&sdhc_2 {
+	status =3D "okay";
+
+	cd-gpios =3D <&tlmm 4 GPIO_ACTIVE_LOW>;
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&sdc2_on>;
+	pinctrl-1 =3D <&sdc2_off>;
+	vqmmc-supply =3D <&vreg_l13c_2p96>; /* IO line power */
+	vmmc-supply =3D <&vreg_l17a_2p96>;  /* Card power line */
+	bus-width =3D <4>;
+	no-sdio;
+	no-mmc;
+};
+
+&uart2 {
+	status =3D "okay";
+};
+
+&uart9 {
+	status =3D "okay";
+};
+
+&ufs_mem_hc {
+	status =3D "okay";
+
+	reset-gpios =3D <&tlmm 175 GPIO_ACTIVE_LOW>;
+
+	vcc-supply =3D <&vreg_l10a_2p96>;
+	vcc-max-microamp =3D <750000>;
+	vccq-supply =3D <&vreg_l5c_1p2>;
+	vccq-max-microamp =3D <700000>;
+	vccq2-supply =3D <&vreg_s4a_1p8>;
+	vccq2-max-microamp =3D <750000>;
+};
+
+&ufs_mem_phy {
+	status =3D "okay";
+
+	vdda-phy-supply =3D <&vreg_l8c_1p2>;
+	vdda-pll-supply =3D <&vreg_l5a_0p88>;
+};
+
+&usb_1 {
+	status =3D "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode =3D "host";
+
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&usb2phy_ac_en1_default>;
+};
+
+&usb_1_hsphy {
+	status =3D "okay";
+	vdda-pll-supply =3D <&vdd_usb_hs_core>;
+	vdda33-supply =3D <&vdda_usb_hs_3p1>;
+	vdda18-supply =3D <&vdda_usb_hs_1p8>;
+};
+
+&usb_1_qmpphy {
+	status =3D "disabled";
+};
+
+&usb_2 {
+	status =3D "okay";
+};
+
+&usb_2_dwc3 {
+	dr_mode =3D "host";
+
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&usb2phy_ac_en2_default>;
+};
+
+&usb_2_hsphy {
+	status =3D "okay";
+	vdda-pll-supply =3D <&vdd_usb_hs_core>;
+	vdda33-supply =3D <&vdda_usb_hs_3p1>;
+	vdda18-supply =3D <&vdda_usb_hs_1p8>;
+};
+
+&usb_2_qmpphy {
+	status =3D "okay";
+	vdda-phy-supply =3D <&vreg_l8c_1p2>;
+	vdda-pll-supply =3D <&vdda_usb_ss_dp_core_1>;
+};
+
+&pcie0 {
+	status =3D "okay";
+};
+
+&pcie0_phy {
+	status =3D "okay";
+	vdda-phy-supply =3D <&vreg_l18c_0p88>;
+	vdda-pll-supply =3D <&vreg_l8c_1p2>;
+};
+
+&pcie1_phy {
+	vdda-phy-supply =3D <&vreg_l18c_0p88>;
+	vdda-pll-supply =3D <&vreg_l8c_1p2>;
+};
+
+&tlmm {
+	gpio-reserved-ranges =3D <0 4>;
+
+	sdc2_on: sdc2-on-state {
+		clk-pins {
+			pins =3D "sdc2_clk";
+			bias-disable;		/* No pull */
+			drive-strength =3D <16>;	/* 16 MA */
+		};
+
+		cmd-pins {
+			pins =3D "sdc2_cmd";
+			bias-pull-up;		/* pull up */
+			drive-strength =3D <16>;	/* 16 MA */
+		};
+
+		data-pins {
+			pins =3D "sdc2_data";
+			bias-pull-up;		/* pull up */
+			drive-strength =3D <16>;	/* 16 MA */
+		};
+
+		sd-cd-pins {
+			pins =3D "gpio96";
+			function =3D "gpio";
+			bias-pull-up;		/* pull up */
+			drive-strength =3D <2>;	/* 2 MA */
+		};
+	};
+
+	sdc2_off: sdc2-off-state {
+		clk-pins {
+			pins =3D "sdc2_clk";
+			bias-disable;		/* No pull */
+			drive-strength =3D <2>;	/* 2 MA */
+		};
+
+		cmd-pins {
+			pins =3D "sdc2_cmd";
+			bias-pull-up;		/* pull up */
+			drive-strength =3D <2>;	/* 2 MA */
+		};
+
+		data-pins {
+			pins =3D "sdc2_data";
+			bias-pull-up;		/* pull up */
+			drive-strength =3D <2>;	/* 2 MA */
+		};
+
+		sd-cd-pins {
+			pins =3D "gpio96";
+			function =3D "gpio";
+			bias-pull-up;		/* pull up */
+			drive-strength =3D <2>;	/* 2 MA */
+		};
+	};
+
+	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
+		pins =3D "gpio113";
+		function =3D "usb2phy_ac";
+		bias-disable;
+		drive-strength =3D <2>;
+	};
+
+	usb2phy_ac_en2_default: usb2phy-ac-en2-default-state {
+		pins =3D "gpio123";
+		function =3D "usb2phy_ac";
+		bias-disable;
+		drive-strength =3D <2>;
+	};
+
+	ethernet_defaults: ethernet-defaults-state {
+		mdc-pins {
+			pins =3D "gpio7";
+			function =3D "rgmii";
+			bias-pull-up;
+		};
+
+		mdio-pins {
+			pins =3D "gpio59";
+			function =3D "rgmii";
+			bias-pull-up;
+		};
+
+		rgmii-rx-pins {
+			pins =3D "gpio117", "gpio118", "gpio119", "gpio120", "gpio115", "gpio11=
6";
+			function =3D "rgmii";
+			bias-disable;
+			drive-strength =3D <2>;
+		};
+
+		rgmii-tx-pins {
+			pins =3D "gpio122", "gpio4", "gpio5", "gpio6", "gpio114", "gpio121";
+			function =3D "rgmii";
+			bias-pull-up;
+			drive-strength =3D <16>;
+		};
+
+		phy-intr-pins {
+			pins =3D "gpio124";
+			function =3D "emac_phy";
+			bias-disable;
+			drive-strength =3D <8>;
+		};
+
+		pps-pins {
+			pins =3D "gpio81";
+			function =3D "emac_pps";
+			bias-disable;
+			drive-strength =3D <8>;
+		};
+
+		phy-reset-pins {
+			pins =3D "gpio79";
+			function =3D "gpio";
+			bias-pull-up;
+			drive-strength =3D <16>;
+		};
+	};
+};
diff --git a/arch/arm/dts/sa8155p.dtsi b/arch/arm/dts/sa8155p.dtsi
new file mode 100644
index 0000000000..ffb7ab6952
--- /dev/null
+++ b/arch/arm/dts/sa8155p.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ *
+ * SA8155P is an automotive variant of SM8150, with some minor changes.
+ * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone=
,
+ * though the cmd-db doesn't reflect that and access attemps result in a b=
ite.
+ */
+
+#include "sm8150.dtsi"
+
+&dispcc {
+	power-domains =3D <&rpmhpd SA8155P_CX>;
+};
+
+&mdss_dsi0 {
+	power-domains =3D <&rpmhpd SA8155P_CX>;
+};
+
+&mdss_dsi1 {
+	power-domains =3D <&rpmhpd SA8155P_CX>;
+};
+
+&mdss_mdp {
+	power-domains =3D <&rpmhpd SA8155P_CX>;
+};
+
+&remoteproc_slpi {
+	power-domains =3D <&rpmhpd SA8155P_CX>,
+			<&rpmhpd SA8155P_MX>;
+};
+
+&rpmhpd {
+	/*
+	 * The bindings were crafted such that SA8155P PDs match their
+	 * SM8150 counterparts to make it more maintainable and only
+	 * necessitate adjusting entries that actually differ
+	 */
+	compatible =3D "qcom,sa8155p-rpmhpd";
+};
diff --git a/arch/arm/dts/sm8150.dtsi b/arch/arm/dts/sm8150.dtsi
new file mode 100644
index 0000000000..761a6757dc
--- /dev/null
+++ b/arch/arm/dts/sm8150.dtsi
@@ -0,0 +1,5293 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019, Linaro Limited
+ */
+
+#include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,dispcc-sm8150.h>
+#include <dt-bindings/clock/qcom,gcc-sm8150.h>
+#include <dt-bindings/clock/qcom,gpucc-sm8150.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
+#include <dt-bindings/interconnect/qcom,sm8150.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	interrupt-parent =3D <&intc>;
+
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	chosen { };
+
+	clocks {
+		xo_board: xo-board {
+			compatible =3D "fixed-clock";
+			#clock-cells =3D <0>;
+			clock-frequency =3D <38400000>;
+			clock-output-names =3D "xo_board";
+		};
+
+		sleep_clk: sleep-clk {
+			compatible =3D "fixed-clock";
+			#clock-cells =3D <0>;
+			clock-frequency =3D <32764>;
+			clock-output-names =3D "sleep_clk";
+		};
+	};
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		CPU0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x0>;
+			clocks =3D <&cpufreq_hw 0>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <488>;
+			dynamic-power-coefficient =3D <232>;
+			next-level-cache =3D <&L2_0>;
+			qcom,freq-domain =3D <&cpufreq_hw 0>;
+			operating-points-v2 =3D <&cpu0_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD0>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_0: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+				L3_0: l3-cache {
+					compatible =3D "cache";
+					cache-level =3D <3>;
+					cache-unified;
+				};
+			};
+		};
+
+		CPU1: cpu@100 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x100>;
+			clocks =3D <&cpufreq_hw 0>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <488>;
+			dynamic-power-coefficient =3D <232>;
+			next-level-cache =3D <&L2_100>;
+			qcom,freq-domain =3D <&cpufreq_hw 0>;
+			operating-points-v2 =3D <&cpu0_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD1>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_100: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+			};
+		};
+
+		CPU2: cpu@200 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x200>;
+			clocks =3D <&cpufreq_hw 0>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <488>;
+			dynamic-power-coefficient =3D <232>;
+			next-level-cache =3D <&L2_200>;
+			qcom,freq-domain =3D <&cpufreq_hw 0>;
+			operating-points-v2 =3D <&cpu0_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD2>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_200: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+			};
+		};
+
+		CPU3: cpu@300 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x300>;
+			clocks =3D <&cpufreq_hw 0>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <488>;
+			dynamic-power-coefficient =3D <232>;
+			next-level-cache =3D <&L2_300>;
+			qcom,freq-domain =3D <&cpufreq_hw 0>;
+			operating-points-v2 =3D <&cpu0_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD3>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_300: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+			};
+		};
+
+		CPU4: cpu@400 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x400>;
+			clocks =3D <&cpufreq_hw 1>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <1024>;
+			dynamic-power-coefficient =3D <369>;
+			next-level-cache =3D <&L2_400>;
+			qcom,freq-domain =3D <&cpufreq_hw 1>;
+			operating-points-v2 =3D <&cpu4_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD4>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_400: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+			};
+		};
+
+		CPU5: cpu@500 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x500>;
+			clocks =3D <&cpufreq_hw 1>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <1024>;
+			dynamic-power-coefficient =3D <369>;
+			next-level-cache =3D <&L2_500>;
+			qcom,freq-domain =3D <&cpufreq_hw 1>;
+			operating-points-v2 =3D <&cpu4_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD5>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_500: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+			};
+		};
+
+		CPU6: cpu@600 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x600>;
+			clocks =3D <&cpufreq_hw 1>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <1024>;
+			dynamic-power-coefficient =3D <369>;
+			next-level-cache =3D <&L2_600>;
+			qcom,freq-domain =3D <&cpufreq_hw 1>;
+			operating-points-v2 =3D <&cpu4_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD6>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_600: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+			};
+		};
+
+		CPU7: cpu@700 {
+			device_type =3D "cpu";
+			compatible =3D "qcom,kryo485";
+			reg =3D <0x0 0x700>;
+			clocks =3D <&cpufreq_hw 2>;
+			enable-method =3D "psci";
+			capacity-dmips-mhz =3D <1024>;
+			dynamic-power-coefficient =3D <421>;
+			next-level-cache =3D <&L2_700>;
+			qcom,freq-domain =3D <&cpufreq_hw 2>;
+			operating-points-v2 =3D <&cpu7_opp_table>;
+			interconnects =3D <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>=
,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains =3D <&CPU_PD7>;
+			power-domain-names =3D "psci";
+			#cooling-cells =3D <2>;
+			L2_700: l2-cache {
+				compatible =3D "cache";
+				cache-level =3D <2>;
+				cache-unified;
+				next-level-cache =3D <&L3_0>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu =3D <&CPU0>;
+				};
+
+				core1 {
+					cpu =3D <&CPU1>;
+				};
+
+				core2 {
+					cpu =3D <&CPU2>;
+				};
+
+				core3 {
+					cpu =3D <&CPU3>;
+				};
+
+				core4 {
+					cpu =3D <&CPU4>;
+				};
+
+				core5 {
+					cpu =3D <&CPU5>;
+				};
+
+				core6 {
+					cpu =3D <&CPU6>;
+				};
+
+				core7 {
+					cpu =3D <&CPU7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method =3D "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible =3D "arm,idle-state";
+				idle-state-name =3D "little-rail-power-collapse";
+				arm,psci-suspend-param =3D <0x40000004>;
+				entry-latency-us =3D <355>;
+				exit-latency-us =3D <909>;
+				min-residency-us =3D <3934>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible =3D "arm,idle-state";
+				idle-state-name =3D "big-rail-power-collapse";
+				arm,psci-suspend-param =3D <0x40000004>;
+				entry-latency-us =3D <241>;
+				exit-latency-us =3D <1461>;
+				min-residency-us =3D <4488>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible =3D "domain-idle-state";
+				arm,psci-suspend-param =3D <0x4100c244>;
+				entry-latency-us =3D <3263>;
+				exit-latency-us =3D <6562>;
+				min-residency-us =3D <9987>;
+			};
+		};
+	};
+
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp1: opp-300000000 {
+			opp-hz =3D /bits/ 64 <300000000>;
+			opp-peak-kBps =3D <800000 9600000>;
+		};
+
+		cpu0_opp2: opp-403200000 {
+			opp-hz =3D /bits/ 64 <403200000>;
+			opp-peak-kBps =3D <800000 9600000>;
+		};
+
+		cpu0_opp3: opp-499200000 {
+			opp-hz =3D /bits/ 64 <499200000>;
+			opp-peak-kBps =3D <800000 12902400>;
+		};
+
+		cpu0_opp4: opp-576000000 {
+			opp-hz =3D /bits/ 64 <576000000>;
+			opp-peak-kBps =3D <800000 12902400>;
+		};
+
+		cpu0_opp5: opp-672000000 {
+			opp-hz =3D /bits/ 64 <672000000>;
+			opp-peak-kBps =3D <800000 15974400>;
+		};
+
+		cpu0_opp6: opp-768000000 {
+			opp-hz =3D /bits/ 64 <768000000>;
+			opp-peak-kBps =3D <1804000 19660800>;
+		};
+
+		cpu0_opp7: opp-844800000 {
+			opp-hz =3D /bits/ 64 <844800000>;
+			opp-peak-kBps =3D <1804000 19660800>;
+		};
+
+		cpu0_opp8: opp-940800000 {
+			opp-hz =3D /bits/ 64 <940800000>;
+			opp-peak-kBps =3D <1804000 22732800>;
+		};
+
+		cpu0_opp9: opp-1036800000 {
+			opp-hz =3D /bits/ 64 <1036800000>;
+			opp-peak-kBps =3D <1804000 22732800>;
+		};
+
+		cpu0_opp10: opp-1113600000 {
+			opp-hz =3D /bits/ 64 <1113600000>;
+			opp-peak-kBps =3D <2188000 25804800>;
+		};
+
+		cpu0_opp11: opp-1209600000 {
+			opp-hz =3D /bits/ 64 <1209600000>;
+			opp-peak-kBps =3D <2188000 31948800>;
+		};
+
+		cpu0_opp12: opp-1305600000 {
+			opp-hz =3D /bits/ 64 <1305600000>;
+			opp-peak-kBps =3D <3072000 31948800>;
+		};
+
+		cpu0_opp13: opp-1382400000 {
+			opp-hz =3D /bits/ 64 <1382400000>;
+			opp-peak-kBps =3D <3072000 31948800>;
+		};
+
+		cpu0_opp14: opp-1478400000 {
+			opp-hz =3D /bits/ 64 <1478400000>;
+			opp-peak-kBps =3D <3072000 31948800>;
+		};
+
+		cpu0_opp15: opp-1555200000 {
+			opp-hz =3D /bits/ 64 <1555200000>;
+			opp-peak-kBps =3D <3072000 40550400>;
+		};
+
+		cpu0_opp16: opp-1632000000 {
+			opp-hz =3D /bits/ 64 <1632000000>;
+			opp-peak-kBps =3D <3072000 40550400>;
+		};
+
+		cpu0_opp17: opp-1708800000 {
+			opp-hz =3D /bits/ 64 <1708800000>;
+			opp-peak-kBps =3D <3072000 43008000>;
+		};
+
+		cpu0_opp18: opp-1785600000 {
+			opp-hz =3D /bits/ 64 <1785600000>;
+			opp-peak-kBps =3D <3072000 43008000>;
+		};
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp1: opp-710400000 {
+			opp-hz =3D /bits/ 64 <710400000>;
+			opp-peak-kBps =3D <1804000 15974400>;
+		};
+
+		cpu4_opp2: opp-825600000 {
+			opp-hz =3D /bits/ 64 <825600000>;
+			opp-peak-kBps =3D <2188000 19660800>;
+		};
+
+		cpu4_opp3: opp-940800000 {
+			opp-hz =3D /bits/ 64 <940800000>;
+			opp-peak-kBps =3D <2188000 22732800>;
+		};
+
+		cpu4_opp4: opp-1056000000 {
+			opp-hz =3D /bits/ 64 <1056000000>;
+			opp-peak-kBps =3D <3072000 25804800>;
+		};
+
+		cpu4_opp5: opp-1171200000 {
+			opp-hz =3D /bits/ 64 <1171200000>;
+			opp-peak-kBps =3D <3072000 31948800>;
+		};
+
+		cpu4_opp6: opp-1286400000 {
+			opp-hz =3D /bits/ 64 <1286400000>;
+			opp-peak-kBps =3D <4068000 31948800>;
+		};
+
+		cpu4_opp7: opp-1401600000 {
+			opp-hz =3D /bits/ 64 <1401600000>;
+			opp-peak-kBps =3D <4068000 31948800>;
+		};
+
+		cpu4_opp8: opp-1497600000 {
+			opp-hz =3D /bits/ 64 <1497600000>;
+			opp-peak-kBps =3D <4068000 40550400>;
+		};
+
+		cpu4_opp9: opp-1612800000 {
+			opp-hz =3D /bits/ 64 <1612800000>;
+			opp-peak-kBps =3D <4068000 40550400>;
+		};
+
+		cpu4_opp10: opp-1708800000 {
+			opp-hz =3D /bits/ 64 <1708800000>;
+			opp-peak-kBps =3D <4068000 43008000>;
+		};
+
+		cpu4_opp11: opp-1804800000 {
+			opp-hz =3D /bits/ 64 <1804800000>;
+			opp-peak-kBps =3D <6220000 43008000>;
+		};
+
+		cpu4_opp12: opp-1920000000 {
+			opp-hz =3D /bits/ 64 <1920000000>;
+			opp-peak-kBps =3D <6220000 49152000>;
+		};
+
+		cpu4_opp13: opp-2016000000 {
+			opp-hz =3D /bits/ 64 <2016000000>;
+			opp-peak-kBps =3D <7216000 49152000>;
+		};
+
+		cpu4_opp14: opp-2131200000 {
+			opp-hz =3D /bits/ 64 <2131200000>;
+			opp-peak-kBps =3D <8368000 49152000>;
+		};
+
+		cpu4_opp15: opp-2227200000 {
+			opp-hz =3D /bits/ 64 <2227200000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu4_opp16: opp-2323200000 {
+			opp-hz =3D /bits/ 64 <2323200000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu4_opp17: opp-2419200000 {
+			opp-hz =3D /bits/ 64 <2419200000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+	};
+
+	cpu7_opp_table: opp-table-cpu7 {
+		compatible =3D "operating-points-v2";
+		opp-shared;
+
+		cpu7_opp1: opp-825600000 {
+			opp-hz =3D /bits/ 64 <825600000>;
+			opp-peak-kBps =3D <2188000 19660800>;
+		};
+
+		cpu7_opp2: opp-940800000 {
+			opp-hz =3D /bits/ 64 <940800000>;
+			opp-peak-kBps =3D <2188000 22732800>;
+		};
+
+		cpu7_opp3: opp-1056000000 {
+			opp-hz =3D /bits/ 64 <1056000000>;
+			opp-peak-kBps =3D <3072000 25804800>;
+		};
+
+		cpu7_opp4: opp-1171200000 {
+			opp-hz =3D /bits/ 64 <1171200000>;
+			opp-peak-kBps =3D <3072000 31948800>;
+		};
+
+		cpu7_opp5: opp-1286400000 {
+			opp-hz =3D /bits/ 64 <1286400000>;
+			opp-peak-kBps =3D <4068000 31948800>;
+		};
+
+		cpu7_opp6: opp-1401600000 {
+			opp-hz =3D /bits/ 64 <1401600000>;
+			opp-peak-kBps =3D <4068000 31948800>;
+		};
+
+		cpu7_opp7: opp-1497600000 {
+			opp-hz =3D /bits/ 64 <1497600000>;
+			opp-peak-kBps =3D <4068000 40550400>;
+		};
+
+		cpu7_opp8: opp-1612800000 {
+			opp-hz =3D /bits/ 64 <1612800000>;
+			opp-peak-kBps =3D <4068000 40550400>;
+		};
+
+		cpu7_opp9: opp-1708800000 {
+			opp-hz =3D /bits/ 64 <1708800000>;
+			opp-peak-kBps =3D <4068000 43008000>;
+		};
+
+		cpu7_opp10: opp-1804800000 {
+			opp-hz =3D /bits/ 64 <1804800000>;
+			opp-peak-kBps =3D <6220000 43008000>;
+		};
+
+		cpu7_opp11: opp-1920000000 {
+			opp-hz =3D /bits/ 64 <1920000000>;
+			opp-peak-kBps =3D <6220000 49152000>;
+		};
+
+		cpu7_opp12: opp-2016000000 {
+			opp-hz =3D /bits/ 64 <2016000000>;
+			opp-peak-kBps =3D <7216000 49152000>;
+		};
+
+		cpu7_opp13: opp-2131200000 {
+			opp-hz =3D /bits/ 64 <2131200000>;
+			opp-peak-kBps =3D <8368000 49152000>;
+		};
+
+		cpu7_opp14: opp-2227200000 {
+			opp-hz =3D /bits/ 64 <2227200000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu7_opp15: opp-2323200000 {
+			opp-hz =3D /bits/ 64 <2323200000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu7_opp16: opp-2419200000 {
+			opp-hz =3D /bits/ 64 <2419200000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu7_opp17: opp-2534400000 {
+			opp-hz =3D /bits/ 64 <2534400000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu7_opp18: opp-2649600000 {
+			opp-hz =3D /bits/ 64 <2649600000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu7_opp19: opp-2745600000 {
+			opp-hz =3D /bits/ 64 <2745600000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+
+		cpu7_opp20: opp-2841600000 {
+			opp-hz =3D /bits/ 64 <2841600000>;
+			opp-peak-kBps =3D <8368000 51609600>;
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible =3D "qcom,scm-sm8150", "qcom,scm";
+			#reset-cells =3D <1>;
+		};
+	};
+
+	memory@80000000 {
+		device_type =3D "memory";
+		/* We expect the bootloader to fill in the size */
+		reg =3D <0x0 0x80000000 0x0 0x0>;
+	};
+
+	pmu {
+		compatible =3D "arm,armv8-pmuv3";
+		interrupts =3D <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0";
+		method =3D "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: power-domain-cpu4 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: power-domain-cpu5 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: power-domain-cpu6 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: power-domain-cpu7 {
+			#power-domain-cells =3D <0>;
+			power-domains =3D <&CLUSTER_PD>;
+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: power-domain-cpu-cluster0 {
+			#power-domain-cells =3D <0>;
+			domain-idle-states =3D <&CLUSTER_SLEEP_0>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		hyp_mem: memory@85700000 {
+			reg =3D <0x0 0x85700000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85d00000 {
+			reg =3D <0x0 0x85d00000 0x0 0x140000>;
+			no-map;
+		};
+
+		aop_mem: memory@85f00000 {
+			reg =3D <0x0 0x85f00000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_cmd_db: memory@85f20000 {
+			compatible =3D "qcom,cmd-db";
+			reg =3D <0x0 0x85f20000 0x0 0x20000>;
+			no-map;
+		};
+
+		smem_mem: memory@86000000 {
+			reg =3D <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+		};
+
+		tz_mem: memory@86200000 {
+			reg =3D <0x0 0x86200000 0x0 0x3900000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@89b00000 {
+			compatible =3D "qcom,rmtfs-mem";
+			reg =3D <0x0 0x89b00000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id =3D <1>;
+			qcom,vmid =3D <QCOM_SCM_VMID_MSS_MSA>;
+		};
+
+		camera_mem: memory@8b700000 {
+			reg =3D <0x0 0x8b700000 0x0 0x500000>;
+			no-map;
+		};
+
+		wlan_mem: memory@8bc00000 {
+			reg =3D <0x0 0x8bc00000 0x0 0x180000>;
+			no-map;
+		};
+
+		npu_mem: memory@8bd80000 {
+			reg =3D <0x0 0x8bd80000 0x0 0x80000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8be00000 {
+			reg =3D <0x0 0x8be00000 0x0 0x1a00000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8d800000 {
+			reg =3D <0x0 0x8d800000 0x0 0x9600000>;
+			no-map;
+		};
+
+		venus_mem: memory@96e00000 {
+			reg =3D <0x0 0x96e00000 0x0 0x500000>;
+			no-map;
+		};
+
+		slpi_mem: memory@97300000 {
+			reg =3D <0x0 0x97300000 0x0 0x1400000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@98700000 {
+			reg =3D <0x0 0x98700000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@98710000 {
+			reg =3D <0x0 0x98710000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@98715000 {
+			reg =3D <0x0 0x98715000 0x0 0x2000>;
+			no-map;
+		};
+
+		spss_mem: memory@98800000 {
+			reg =3D <0x0 0x98800000 0x0 0x100000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@98900000 {
+			reg =3D <0x0 0x98900000 0x0 0x1400000>;
+			no-map;
+		};
+
+		qseecom_mem: memory@9e400000 {
+			reg =3D <0x0 0x9e400000 0x0 0x1400000>;
+			no-map;
+		};
+	};
+
+	smem {
+		compatible =3D "qcom,smem";
+		memory-region =3D <&smem_mem>;
+		hwlocks =3D <&tcsr_mutex 3>;
+	};
+
+	smp2p-cdsp {
+		compatible =3D "qcom,smp2p";
+		qcom,smem =3D <94>, <432>;
+
+		interrupts =3D <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes =3D <&apss_shared 6>;
+
+		qcom,local-pid =3D <0>;
+		qcom,remote-pid =3D <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name =3D "master-kernel";
+			#qcom,smem-state-cells =3D <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name =3D "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+	};
+
+	smp2p-lpass {
+		compatible =3D "qcom,smp2p";
+		qcom,smem =3D <443>, <429>;
+
+		interrupts =3D <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes =3D <&apss_shared 10>;
+
+		qcom,local-pid =3D <0>;
+		qcom,remote-pid =3D <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name =3D "master-kernel";
+			#qcom,smem-state-cells =3D <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name =3D "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible =3D "qcom,smp2p";
+		qcom,smem =3D <435>, <428>;
+
+		interrupts =3D <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes =3D <&apss_shared 14>;
+
+		qcom,local-pid =3D <0>;
+		qcom,remote-pid =3D <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name =3D "master-kernel";
+			#qcom,smem-state-cells =3D <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name =3D "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible =3D "qcom,smp2p";
+		qcom,smem =3D <481>, <430>;
+
+		interrupts =3D <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes =3D <&apss_shared 26>;
+
+		qcom,local-pid =3D <0>;
+		qcom,remote-pid =3D <3>;
+
+		slpi_smp2p_out: master-kernel {
+			qcom,entry-name =3D "master-kernel";
+			#qcom,smem-state-cells =3D <1>;
+		};
+
+		slpi_smp2p_in: slave-kernel {
+			qcom,entry-name =3D "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+	};
+
+	soc: soc@0 {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges =3D <0 0 0 0 0x10 0>;
+		dma-ranges =3D <0 0 0 0 0x10 0>;
+		compatible =3D "simple-bus";
+
+		gcc: clock-controller@100000 {
+			compatible =3D "qcom,gcc-sm8150";
+			reg =3D <0x0 0x00100000 0x0 0x1f0000>;
+			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
+			#power-domain-cells =3D <1>;
+			clock-names =3D "bi_tcxo",
+				      "sleep_clk";
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>;
+		};
+
+		gpi_dma0: dma-controller@800000 {
+			compatible =3D "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
+			reg =3D <0 0x00800000 0 0x60000>;
+			interrupts =3D <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels =3D <13>;
+			dma-channel-mask =3D <0xfa>;
+			iommus =3D <&apps_smmu 0x00d6 0x0>;
+			#dma-cells =3D <3>;
+			status =3D "disabled";
+		};
+
+		ethernet: ethernet@20000 {
+			compatible =3D "qcom,sm8150-ethqos";
+			reg =3D <0x0 0x00020000 0x0 0x10000>,
+			      <0x0 0x00036000 0x0 0x100>;
+			reg-names =3D "stmmaceth", "rgmii";
+			clock-names =3D "stmmaceth", "pclk", "ptp_ref", "rgmii";
+			clocks =3D <&gcc GCC_EMAC_AXI_CLK>,
+				<&gcc GCC_EMAC_SLV_AHB_CLK>,
+				<&gcc GCC_EMAC_PTP_CLK>,
+				<&gcc GCC_EMAC_RGMII_CLK>;
+			interrupts =3D <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "macirq", "eth_lpi";
+
+			power-domains =3D <&gcc EMAC_GDSC>;
+			resets =3D <&gcc GCC_EMAC_BCR>;
+
+			iommus =3D <&apps_smmu 0x3c0 0x0>;
+
+			snps,tso;
+			rx-fifo-depth =3D <4096>;
+			tx-fifo-depth =3D <4096>;
+
+			status =3D "disabled";
+		};
+
+		qfprom: efuse@784000 {
+			compatible =3D "qcom,sm8150-qfprom", "qcom,qfprom";
+			reg =3D <0 0x00784000 0 0x8ff>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+
+			gpu_speed_bin: gpu_speed_bin@133 {
+				reg =3D <0x133 0x1>;
+				bits =3D <5 3>;
+			};
+		};
+
+		qupv3_id_0: geniqup@8c0000 {
+			compatible =3D "qcom,geni-se-qup";
+			reg =3D <0x0 0x008c0000 0x0 0x6000>;
+			clock-names =3D "m-ahb", "s-ahb";
+			clocks =3D <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			iommus =3D <&apps_smmu 0xc3 0x0>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+			status =3D "disabled";
+
+			i2c0: i2c@880000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00880000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				dmas =3D <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c0_default>;
+				interrupts =3D <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi0: spi@880000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00880000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				dmas =3D <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi0_default>;
+				interrupts =3D <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c1: i2c@884000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00884000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				dmas =3D <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c1_default>;
+				interrupts =3D <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi1: spi@884000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00884000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				dmas =3D <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi1_default>;
+				interrupts =3D <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c2: i2c@888000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00888000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				dmas =3D <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c2_default>;
+				interrupts =3D <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi2: spi@888000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00888000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				dmas =3D <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi2_default>;
+				interrupts =3D <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c3: i2c@88c000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x0088c000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				dmas =3D <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c3_default>;
+				interrupts =3D <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi3: spi@88c000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x0088c000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				dmas =3D <&gpi_dma0 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi3_default>;
+				interrupts =3D <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c4: i2c@890000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00890000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				dmas =3D <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c4_default>;
+				interrupts =3D <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi4: spi@890000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00890000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				dmas =3D <&gpi_dma0 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi4_default>;
+				interrupts =3D <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c5: i2c@894000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00894000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				dmas =3D <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c5_default>;
+				interrupts =3D <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi5: spi@894000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00894000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				dmas =3D <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi5_default>;
+				interrupts =3D <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c6: i2c@898000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00898000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				dmas =3D <&gpi_dma0 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c6_default>;
+				interrupts =3D <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi6: spi@898000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00898000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				dmas =3D <&gpi_dma0 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi6_default>;
+				interrupts =3D <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c7: i2c@89c000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x0089c000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				dmas =3D <&gpi_dma0 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c7_default>;
+				interrupts =3D <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi7: spi@89c000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x0089c000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				dmas =3D <&gpi_dma0 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi7_default>;
+				interrupts =3D <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+		};
+
+		gpi_dma1: dma-controller@a00000 {
+			compatible =3D "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
+			reg =3D <0 0x00a00000 0 0x60000>;
+			interrupts =3D <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels =3D <13>;
+			dma-channel-mask =3D <0xfa>;
+			iommus =3D <&apps_smmu 0x0616 0x0>;
+			#dma-cells =3D <3>;
+			status =3D "disabled";
+		};
+
+		qupv3_id_1: geniqup@ac0000 {
+			compatible =3D "qcom,geni-se-qup";
+			reg =3D <0x0 0x00ac0000 0x0 0x6000>;
+			clock-names =3D "m-ahb", "s-ahb";
+			clocks =3D <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			iommus =3D <&apps_smmu 0x603 0x0>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+			status =3D "disabled";
+
+			i2c8: i2c@a80000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00a80000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				dmas =3D <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c8_default>;
+				interrupts =3D <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi8: spi@a80000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00a80000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				dmas =3D <&gpi_dma1 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi8_default>;
+				interrupts =3D <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c9: i2c@a84000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00a84000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				dmas =3D <&gpi_dma1 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c9_default>;
+				interrupts =3D <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi9: spi@a84000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00a84000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				dmas =3D <&gpi_dma1 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi9_default>;
+				interrupts =3D <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			uart9: serial@a84000 {
+				compatible =3D "qcom,geni-uart";
+				reg =3D <0x0 0x00a84000 0x0 0x4000>;
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				clock-names =3D "se";
+				pinctrl-0 =3D <&qup_uart9_default>;
+				pinctrl-names =3D "default";
+				interrupts =3D <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
+			i2c10: i2c@a88000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00a88000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				dmas =3D <&gpi_dma1 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c10_default>;
+				interrupts =3D <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi10: spi@a88000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00a88000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				dmas =3D <&gpi_dma1 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi10_default>;
+				interrupts =3D <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c11: i2c@a8c000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00a8c000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				dmas =3D <&gpi_dma1 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c11_default>;
+				interrupts =3D <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi11: spi@a8c000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00a8c000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				dmas =3D <&gpi_dma1 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi11_default>;
+				interrupts =3D <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			uart2: serial@a90000 {
+				compatible =3D "qcom,geni-debug-uart";
+				reg =3D <0x0 0x00a90000 0x0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				interrupts =3D <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
+			i2c12: i2c@a90000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00a90000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				dmas =3D <&gpi_dma1 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c12_default>;
+				interrupts =3D <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi12: spi@a90000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00a90000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				dmas =3D <&gpi_dma1 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi12_default>;
+				interrupts =3D <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c16: i2c@94000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00094000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				dmas =3D <&gpi_dma2 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 5 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c16_default>;
+				interrupts =3D <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi16: spi@a94000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00a94000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				dmas =3D <&gpi_dma2 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi16_default>;
+				interrupts =3D <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+		};
+
+		gpi_dma2: dma-controller@c00000 {
+			compatible =3D "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
+			reg =3D <0 0x00c00000 0 0x60000>;
+			interrupts =3D <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 600 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels =3D <13>;
+			dma-channel-mask =3D <0xfa>;
+			iommus =3D <&apps_smmu 0x07b6 0x0>;
+			#dma-cells =3D <3>;
+			status =3D "disabled";
+		};
+
+		qupv3_id_2: geniqup@cc0000 {
+			compatible =3D "qcom,geni-se-qup";
+			reg =3D <0x0 0x00cc0000 0x0 0x6000>;
+
+			clock-names =3D "m-ahb", "s-ahb";
+			clocks =3D <&gcc GCC_QUPV3_WRAP_2_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_2_S_AHB_CLK>;
+			iommus =3D <&apps_smmu 0x7a3 0x0>;
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+			status =3D "disabled";
+
+			i2c17: i2c@c80000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00c80000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				dmas =3D <&gpi_dma2 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 0 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c17_default>;
+				interrupts =3D <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi17: spi@c80000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00c80000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				dmas =3D <&gpi_dma2 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 0 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi17_default>;
+				interrupts =3D <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c18: i2c@c84000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00c84000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				dmas =3D <&gpi_dma2 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 1 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c18_default>;
+				interrupts =3D <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi18: spi@c84000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00c84000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				dmas =3D <&gpi_dma2 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 1 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi18_default>;
+				interrupts =3D <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c19: i2c@c88000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00c88000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				dmas =3D <&gpi_dma2 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 2 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c19_default>;
+				interrupts =3D <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi19: spi@c88000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00c88000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				dmas =3D <&gpi_dma2 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 2 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi19_default>;
+				interrupts =3D <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c13: i2c@c8c000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00c8c000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				dmas =3D <&gpi_dma2 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 3 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c13_default>;
+				interrupts =3D <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi13: spi@c8c000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00c8c000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				dmas =3D <&gpi_dma2 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 3 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi13_default>;
+				interrupts =3D <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c14: i2c@c90000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00c90000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				dmas =3D <&gpi_dma2 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 4 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c14_default>;
+				interrupts =3D <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi14: spi@c90000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00c90000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				dmas =3D <&gpi_dma2 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 4 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi14_default>;
+				interrupts =3D <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			i2c15: i2c@c94000 {
+				compatible =3D "qcom,geni-i2c";
+				reg =3D <0 0x00c94000 0 0x4000>;
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				dmas =3D <&gpi_dma2 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma2 1 5 QCOM_GPI_I2C>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_i2c15_default>;
+				interrupts =3D <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			spi15: spi@c94000 {
+				compatible =3D "qcom,geni-spi";
+				reg =3D <0 0x00c94000 0 0x4000>;
+				reg-names =3D "se";
+				clock-names =3D "se";
+				clocks =3D <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				dmas =3D <&gpi_dma2 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
+				dma-names =3D "tx", "rx";
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&qup_spi15_default>;
+				interrupts =3D <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				spi-max-frequency =3D <50000000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				status =3D "disabled";
+			};
+		};
+
+		config_noc: interconnect@1500000 {
+			compatible =3D "qcom,sm8150-config-noc";
+			reg =3D <0 0x01500000 0 0x7400>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible =3D "qcom,sm8150-system-noc";
+			reg =3D <0 0x01620000 0 0x19400>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		mc_virt: interconnect@163a000 {
+			compatible =3D "qcom,sm8150-mc-virt";
+			reg =3D <0 0x0163a000 0 0x1000>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible =3D "qcom,sm8150-aggre1-noc";
+			reg =3D <0 0x016e0000 0 0xd080>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible =3D "qcom,sm8150-aggre2-noc";
+			reg =3D <0 0x01700000 0 0x20000>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		compute_noc: interconnect@1720000 {
+			compatible =3D "qcom,sm8150-compute-noc";
+			reg =3D <0 0x01720000 0 0x7000>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible =3D "qcom,sm8150-mmss-noc";
+			reg =3D <0 0x01740000 0 0x1c100>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		system-cache-controller@9200000 {
+			compatible =3D "qcom,sm8150-llcc";
+			reg =3D <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
+			reg-names =3D "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
+			interrupts =3D <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		dma@10a2000 {
+			compatible =3D "qcom,sm8150-dcc", "qcom,dcc";
+			reg =3D <0x0 0x010a2000 0x0 0x1000>,
+			      <0x0 0x010ad000 0x0 0x3000>;
+		};
+
+		pcie0: pcie@1c00000 {
+			compatible =3D "qcom,pcie-sm8150";
+			reg =3D <0 0x01c00000 0 0x3000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60001000 0 0x1000>,
+			      <0 0x60100000 0 0x100000>;
+			reg-names =3D "parf", "dbi", "elbi", "atu", "config";
+			device_type =3D "pci";
+			linux,pci-domain =3D <0>;
+			bus-range =3D <0x00 0xff>;
+			num-lanes =3D <1>;
+
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+
+			ranges =3D <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
+
+			interrupts =3D <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "msi";
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 0x7>;
+			interrupt-map =3D <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a *=
/
+					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks =3D <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names =3D "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu";
+
+			iommu-map =3D <0x0   &apps_smmu 0x1d80 0x1>,
+				    <0x100 &apps_smmu 0x1d81 0x1>;
+
+			resets =3D <&gcc GCC_PCIE_0_BCR>;
+			reset-names =3D "pci";
+
+			power-domains =3D <&gcc PCIE_0_GDSC>;
+
+			phys =3D <&pcie0_phy>;
+			phy-names =3D "pciephy";
+
+			perst-gpios =3D <&tlmm 35 GPIO_ACTIVE_HIGH>;
+			enable-gpio =3D <&tlmm 37 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pcie0_default_state>;
+
+			status =3D "disabled";
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible =3D "qcom,sm8150-qmp-gen3x1-pcie-phy";
+			reg =3D <0 0x01c06000 0 0x1000>;
+			clocks =3D <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
+				 <&gcc GCC_PCIE0_PHY_REFGEN_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK>;
+			clock-names =3D "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "refgen",
+				      "pipe";
+
+			clock-output-names =3D "pcie_0_pipe_clk";
+			#clock-cells =3D <0>;
+
+			#phy-cells =3D <0>;
+
+			resets =3D <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names =3D "phy";
+
+			assigned-clocks =3D <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
+			assigned-clock-rates =3D <100000000>;
+
+			status =3D "disabled";
+		};
+
+		pcie1: pcie@1c08000 {
+			compatible =3D "qcom,pcie-sm8150";
+			reg =3D <0 0x01c08000 0 0x3000>,
+			      <0 0x40000000 0 0xf1d>,
+			      <0 0x40000f20 0 0xa8>,
+			      <0 0x40001000 0 0x1000>,
+			      <0 0x40100000 0 0x100000>;
+			reg-names =3D "parf", "dbi", "elbi", "atu", "config";
+			device_type =3D "pci";
+			linux,pci-domain =3D <1>;
+			bus-range =3D <0x00 0xff>;
+			num-lanes =3D <2>;
+
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+
+			ranges =3D <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+
+			interrupts =3D <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "msi";
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 0x7>;
+			interrupt-map =3D <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a *=
/
+					<0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks =3D <&gcc GCC_PCIE_1_PIPE_CLK>,
+				 <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names =3D "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu";
+
+			assigned-clocks =3D <&gcc GCC_PCIE_1_AUX_CLK>;
+			assigned-clock-rates =3D <19200000>;
+
+			iommu-map =3D <0x0   &apps_smmu 0x1e00 0x1>,
+				    <0x100 &apps_smmu 0x1e01 0x1>;
+
+			resets =3D <&gcc GCC_PCIE_1_BCR>;
+			reset-names =3D "pci";
+
+			power-domains =3D <&gcc PCIE_1_GDSC>;
+
+			phys =3D <&pcie1_phy>;
+			phy-names =3D "pciephy";
+
+			perst-gpios =3D <&tlmm 102 GPIO_ACTIVE_HIGH>;
+			enable-gpio =3D <&tlmm 104 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pcie1_default_state>;
+
+			status =3D "disabled";
+		};
+
+		pcie1_phy: phy@1c0e000 {
+			compatible =3D "qcom,sm8150-qmp-gen3x2-pcie-phy";
+			reg =3D <0 0x01c0e000 0 0x1000>;
+			clocks =3D <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_CLKREF_CLK>,
+				 <&gcc GCC_PCIE1_PHY_REFGEN_CLK>,
+				 <&gcc GCC_PCIE_1_PIPE_CLK>;
+			clock-names =3D "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "refgen",
+				      "pipe";
+
+			clock-output-names =3D "pcie_1_pipe_clk";
+			#clock-cells =3D <0>;
+
+			#phy-cells =3D <0>;
+
+			resets =3D <&gcc GCC_PCIE_1_PHY_BCR>;
+			reset-names =3D "phy";
+
+			assigned-clocks =3D <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
+			assigned-clock-rates =3D <100000000>;
+
+			status =3D "disabled";
+		};
+
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible =3D "qcom,sm8150-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg =3D <0 0x01d84000 0 0x2500>,
+			      <0 0x01d90000 0 0x8000>;
+			reg-names =3D "std", "ice";
+			interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys =3D <&ufs_mem_phy>;
+			phy-names =3D "ufsphy";
+			lanes-per-direction =3D <2>;
+			#reset-cells =3D <1>;
+			resets =3D <&gcc GCC_UFS_PHY_BCR>;
+			reset-names =3D "rst";
+
+			iommus =3D <&apps_smmu 0x300 0>;
+
+			clock-names =3D
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk",
+				"ice_core_clk";
+			clocks =3D
+				<&gcc GCC_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_UFS_PHY_AHB_CLK>,
+				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				<&rpmhcc RPMH_CXO_CLK>,
+				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
+				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+			freq-table-hz =3D
+				<37500000 300000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 300000000>;
+
+			status =3D "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible =3D "qcom,sm8150-qmp-ufs-phy";
+			reg =3D <0 0x01d87000 0 0x1000>;
+
+			clock-names =3D "ref",
+				      "ref_aux";
+			clocks =3D <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+
+			power-domains =3D <&gcc UFS_PHY_GDSC>;
+
+			resets =3D <&ufs_mem_hc 0>;
+			reset-names =3D "ufsphy";
+
+			#phy-cells =3D <0>;
+
+			status =3D "disabled";
+		};
+
+		cryptobam: dma-controller@1dc4000 {
+			compatible =3D "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg =3D <0 0x01dc4000 0 0x24000>;
+			interrupts =3D <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells =3D <1>;
+			qcom,ee =3D <0>;
+			qcom,controlled-remotely;
+			num-channels =3D <8>;
+			qcom,num-ees =3D <2>;
+			iommus =3D <&apps_smmu 0x502 0x0641>,
+				 <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x508 0x0011>,
+				 <&apps_smmu 0x512 0x0000>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible =3D "qcom,sm8150-qce", "qcom,qce";
+			reg =3D <0 0x01dfa000 0 0x6000>;
+			dmas =3D <&cryptobam 4>, <&cryptobam 5>;
+			dma-names =3D "rx", "tx";
+			iommus =3D <&apps_smmu 0x502 0x0641>,
+				 <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x508 0x0011>,
+				 <&apps_smmu 0x512 0x0000>;
+			interconnects =3D <&aggre2_noc MASTER_CRYPTO_CORE_0 0 &mc_virt SLAVE_EB=
I_CH0 0>;
+			interconnect-names =3D "memory";
+		};
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible =3D "qcom,tcsr-mutex";
+			reg =3D <0x0 0x01f40000 0x0 0x20000>;
+			#hwlock-cells =3D <1>;
+		};
+
+		tcsr_regs_1: syscon@1f60000 {
+			compatible =3D "qcom,sm8150-tcsr", "syscon";
+			reg =3D <0x0 0x01f60000 0x0 0x20000>;
+		};
+
+		remoteproc_slpi: remoteproc@2400000 {
+			compatible =3D "qcom,sm8150-slpi-pas";
+			reg =3D <0x0 0x02400000 0x0 0x4040>;
+
+			interrupts-extended =3D <&intc GIC_SPI 494 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
+			clock-names =3D "xo";
+
+			power-domains =3D <&rpmhpd SM8150_LCX>,
+					<&rpmhpd SM8150_LMX>;
+			power-domain-names =3D "lcx", "lmx";
+
+			memory-region =3D <&slpi_mem>;
+
+			qcom,qmp =3D <&aoss_qmp>;
+
+			qcom,smem-states =3D <&slpi_smp2p_out 0>;
+			qcom,smem-state-names =3D "stop";
+
+			status =3D "disabled";
+
+			glink-edge {
+				interrupts =3D <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>;
+				label =3D "dsps";
+				qcom,remote-pid =3D <3>;
+				mboxes =3D <&apss_shared 24>;
+
+				fastrpc {
+					compatible =3D "qcom,fastrpc";
+					qcom,glink-channels =3D "fastrpcglink-apps-dsp";
+					label =3D "sdsp";
+					qcom,non-secure-domain;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					compute-cb@1 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <1>;
+						iommus =3D <&apps_smmu 0x05a1 0x0>;
+					};
+
+					compute-cb@2 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <2>;
+						iommus =3D <&apps_smmu 0x05a2 0x0>;
+					};
+
+					compute-cb@3 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <3>;
+						iommus =3D <&apps_smmu 0x05a3 0x0>;
+						/* note: shared-cb =3D <4> in downstream */
+					};
+				};
+			};
+		};
+
+		gpu: gpu@2c00000 {
+			compatible =3D "qcom,adreno-640.1", "qcom,adreno";
+			reg =3D <0 0x02c00000 0 0x40000>;
+			reg-names =3D "kgsl_3d0_reg_memory";
+
+			interrupts =3D <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus =3D <&adreno_smmu 0 0x401>;
+
+			operating-points-v2 =3D <&gpu_opp_table>;
+
+			qcom,gmu =3D <&gmu>;
+
+			nvmem-cells =3D <&gpu_speed_bin>;
+			nvmem-cell-names =3D "speed_bin";
+
+			status =3D "disabled";
+
+			zap-shader {
+				memory-region =3D <&gpu_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible =3D "operating-points-v2";
+
+				opp-675000000 {
+					opp-hz =3D /bits/ 64 <675000000>;
+					opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-supported-hw =3D <0x2>;
+				};
+
+				opp-585000000 {
+					opp-hz =3D /bits/ 64 <585000000>;
+					opp-level =3D <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-supported-hw =3D <0x3>;
+				};
+
+				opp-499200000 {
+					opp-hz =3D /bits/ 64 <499200000>;
+					opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-supported-hw =3D <0x3>;
+				};
+
+				opp-427000000 {
+					opp-hz =3D /bits/ 64 <427000000>;
+					opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-supported-hw =3D <0x3>;
+				};
+
+				opp-345000000 {
+					opp-hz =3D /bits/ 64 <345000000>;
+					opp-level =3D <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-supported-hw =3D <0x3>;
+				};
+
+				opp-257000000 {
+					opp-hz =3D /bits/ 64 <257000000>;
+					opp-level =3D <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-supported-hw =3D <0x3>;
+				};
+			};
+		};
+
+		gmu: gmu@2c6a000 {
+			compatible =3D "qcom,adreno-gmu-640.1", "qcom,adreno-gmu";
+
+			reg =3D <0 0x02c6a000 0 0x30000>,
+			      <0 0x0b290000 0 0x10000>,
+			      <0 0x0b490000 0 0x10000>;
+			reg-names =3D "gmu", "gmu_pdc", "gmu_pdc_seq";
+
+			interrupts =3D <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "hfi", "gmu";
+
+			clocks =3D <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names =3D "ahb", "gmu", "cxo", "axi", "memnoc";
+
+			power-domains =3D <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names =3D "cx", "gx";
+
+			iommus =3D <&adreno_smmu 5 0x400>;
+
+			operating-points-v2 =3D <&gmu_opp_table>;
+
+			status =3D "disabled";
+
+			gmu_opp_table: opp-table {
+				compatible =3D "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz =3D /bits/ 64 <200000000>;
+					opp-level =3D <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
+		gpucc: clock-controller@2c90000 {
+			compatible =3D "qcom,sm8150-gpucc";
+			reg =3D <0 0x02c90000 0 0x9000>;
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names =3D "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
+			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
+			#power-domain-cells =3D <1>;
+		};
+
+		adreno_smmu: iommu@2ca0000 {
+			compatible =3D "qcom,sm8150-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg =3D <0 0x02ca0000 0 0x10000>;
+			#iommu-cells =3D <2>;
+			#global-interrupts =3D <1>;
+			interrupts =3D <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+			clock-names =3D "ahb", "bus", "iface";
+
+			power-domains =3D <&gpucc GPU_CX_GDSC>;
+		};
+
+		tlmm: pinctrl@3100000 {
+			compatible =3D "qcom,sm8150-pinctrl";
+			reg =3D <0x0 0x03100000 0x0 0x300000>,
+			      <0x0 0x03500000 0x0 0x300000>,
+			      <0x0 0x03900000 0x0 0x300000>,
+			      <0x0 0x03D00000 0x0 0x300000>;
+			reg-names =3D "west", "east", "north", "south";
+			interrupts =3D <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges =3D <&tlmm 0 0 176>;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+			wakeup-parent =3D <&pdc>;
+
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins =3D "gpio0", "gpio1";
+				function =3D "qup0";
+				drive-strength =3D <0x02>;
+				bias-disable;
+			};
+
+			qup_spi0_default: qup-spi0-default-state {
+				pins =3D "gpio0", "gpio1", "gpio2", "gpio3";
+				function =3D "qup0";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins =3D "gpio114", "gpio115";
+				function =3D "qup1";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi1_default: qup-spi1-default-state {
+				pins =3D "gpio114", "gpio115", "gpio116", "gpio117";
+				function =3D "qup1";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins =3D "gpio126", "gpio127";
+				function =3D "qup2";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi2_default: qup-spi2-default-state {
+				pins =3D "gpio126", "gpio127", "gpio128", "gpio129";
+				function =3D "qup2";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins =3D "gpio144", "gpio145";
+				function =3D "qup3";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi3_default: qup-spi3-default-state {
+				pins =3D "gpio144", "gpio145", "gpio146", "gpio147";
+				function =3D "qup3";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins =3D "gpio51", "gpio52";
+				function =3D "qup4";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi4_default: qup-spi4-default-state {
+				pins =3D "gpio51", "gpio52", "gpio53", "gpio54";
+				function =3D "qup4";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins =3D "gpio121", "gpio122";
+				function =3D "qup5";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi5_default: qup-spi5-default-state {
+				pins =3D "gpio119", "gpio120", "gpio121", "gpio122";
+				function =3D "qup5";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c6_default: qup-i2c6-default-state {
+				pins =3D "gpio6", "gpio7";
+				function =3D "qup6";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi6_default: qup-spi6_default-state {
+				pins =3D "gpio4", "gpio5", "gpio6", "gpio7";
+				function =3D "qup6";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins =3D "gpio98", "gpio99";
+				function =3D "qup7";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi7_default: qup-spi7_default-state {
+				pins =3D "gpio98", "gpio99", "gpio100", "gpio101";
+				function =3D "qup7";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c8_default: qup-i2c8-default-state {
+				pins =3D "gpio88", "gpio89";
+				function =3D "qup8";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi8_default: qup-spi8-default-state {
+				pins =3D "gpio88", "gpio89", "gpio90", "gpio91";
+				function =3D "qup8";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c9_default: qup-i2c9-default-state {
+				pins =3D "gpio39", "gpio40";
+				function =3D "qup9";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi9_default: qup-spi9-default-state {
+				pins =3D "gpio39", "gpio40", "gpio41", "gpio42";
+				function =3D "qup9";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_uart9_default: qup-uart9-default-state {
+				pins =3D "gpio41", "gpio42";
+				function =3D "qup9";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_i2c10_default: qup-i2c10-default-state {
+				pins =3D "gpio9", "gpio10";
+				function =3D "qup10";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi10_default: qup-spi10-default-state {
+				pins =3D "gpio9", "gpio10", "gpio11", "gpio12";
+				function =3D "qup10";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c11_default: qup-i2c11-default-state {
+				pins =3D "gpio94", "gpio95";
+				function =3D "qup11";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi11_default: qup-spi11-default-state {
+				pins =3D "gpio92", "gpio93", "gpio94", "gpio95";
+				function =3D "qup11";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c12_default: qup-i2c12-default-state {
+				pins =3D "gpio83", "gpio84";
+				function =3D "qup12";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi12_default: qup-spi12-default-state {
+				pins =3D "gpio83", "gpio84", "gpio85", "gpio86";
+				function =3D "qup12";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c13_default: qup-i2c13-default-state {
+				pins =3D "gpio43", "gpio44";
+				function =3D "qup13";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi13_default: qup-spi13-default-state {
+				pins =3D "gpio43", "gpio44", "gpio45", "gpio46";
+				function =3D "qup13";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c14_default: qup-i2c14-default-state {
+				pins =3D "gpio47", "gpio48";
+				function =3D "qup14";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi14_default: qup-spi14-default-state {
+				pins =3D "gpio47", "gpio48", "gpio49", "gpio50";
+				function =3D "qup14";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c15_default: qup-i2c15-default-state {
+				pins =3D "gpio27", "gpio28";
+				function =3D "qup15";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi15_default: qup-spi15-default-state {
+				pins =3D "gpio27", "gpio28", "gpio29", "gpio30";
+				function =3D "qup15";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c16_default: qup-i2c16-default-state {
+				pins =3D "gpio86", "gpio85";
+				function =3D "qup16";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi16_default: qup-spi16-default-state {
+				pins =3D "gpio83", "gpio84", "gpio85", "gpio86";
+				function =3D "qup16";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c17_default: qup-i2c17-default-state {
+				pins =3D "gpio55", "gpio56";
+				function =3D "qup17";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi17_default: qup-spi17-default-state {
+				pins =3D "gpio55", "gpio56", "gpio57", "gpio58";
+				function =3D "qup17";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c18_default: qup-i2c18-default-state {
+				pins =3D "gpio23", "gpio24";
+				function =3D "qup18";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi18_default: qup-spi18-default-state {
+				pins =3D "gpio23", "gpio24", "gpio25", "gpio26";
+				function =3D "qup18";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			qup_i2c19_default: qup-i2c19-default-state {
+				pins =3D "gpio57", "gpio58";
+				function =3D "qup19";
+				drive-strength =3D <2>;
+				bias-disable;
+			};
+
+			qup_spi19_default: qup-spi19-default-state {
+				pins =3D "gpio55", "gpio56", "gpio57", "gpio58";
+				function =3D "qup19";
+				drive-strength =3D <6>;
+				bias-disable;
+			};
+
+			pcie0_default_state: pcie0-default-state {
+				perst-pins {
+					pins =3D "gpio35";
+					function =3D "gpio";
+					drive-strength =3D <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins =3D "gpio36";
+					function =3D "pci_e0";
+					drive-strength =3D <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins =3D "gpio37";
+					function =3D "gpio";
+					drive-strength =3D <2>;
+					bias-pull-up;
+				};
+			};
+
+			pcie1_default_state: pcie1-default-state {
+				perst-pins {
+					pins =3D "gpio102";
+					function =3D "gpio";
+					drive-strength =3D <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins =3D "gpio103";
+					function =3D "pci_e1";
+					drive-strength =3D <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins =3D "gpio104";
+					function =3D "gpio";
+					drive-strength =3D <2>;
+					bias-pull-up;
+				};
+			};
+		};
+
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible =3D "qcom,sm8150-mpss-pas";
+			reg =3D <0x0 0x04080000 0x0 0x4040>;
+
+			interrupts-extended =3D <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
+			clock-names =3D "xo";
+
+			power-domains =3D <&rpmhpd SM8150_CX>,
+					<&rpmhpd SM8150_MSS>;
+			power-domain-names =3D "cx", "mss";
+
+			memory-region =3D <&mpss_mem>;
+
+			qcom,qmp =3D <&aoss_qmp>;
+
+			qcom,smem-states =3D <&modem_smp2p_out 0>;
+			qcom,smem-state-names =3D "stop";
+
+			status =3D "disabled";
+
+			glink-edge {
+				interrupts =3D <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label =3D "modem";
+				qcom,remote-pid =3D <1>;
+				mboxes =3D <&apss_shared 12>;
+			};
+		};
+
+		stm@6002000 {
+			compatible =3D "arm,coresight-stm", "arm,primecell";
+			reg =3D <0 0x06002000 0 0x1000>,
+			      <0 0x16280000 0 0x180000>;
+			reg-names =3D "stm-base", "stm-stimulus-base";
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =3D <&funnel0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@6041000 {
+			compatible =3D "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg =3D <0 0x06041000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =3D <&merge_funnel_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@7 {
+					reg =3D <7>;
+					funnel0_in7: endpoint {
+						remote-endpoint =3D <&stm_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6042000 {
+			compatible =3D "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg =3D <0 0x06042000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					funnel1_out: endpoint {
+						remote-endpoint =3D <&merge_funnel_in1>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@4 {
+					reg =3D <4>;
+					funnel1_in4: endpoint {
+						remote-endpoint =3D <&swao_replicator_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6043000 {
+			compatible =3D "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg =3D <0 0x06043000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					funnel2_out: endpoint {
+						remote-endpoint =3D <&merge_funnel_in2>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@2 {
+					reg =3D <2>;
+					funnel2_in2: endpoint {
+						remote-endpoint =3D <&apss_merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6045000 {
+			compatible =3D "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg =3D <0 0x06045000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint =3D <&etf_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint =3D <&funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg =3D <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint =3D <&funnel1_out>;
+					};
+				};
+
+				port@2 {
+					reg =3D <2>;
+					merge_funnel_in2: endpoint {
+						remote-endpoint =3D <&funnel2_out>;
+					};
+				};
+			};
+		};
+
+		replicator@6046000 {
+			compatible =3D "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg =3D <0 0x06046000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					replicator_out0: endpoint {
+						remote-endpoint =3D <&etr_in>;
+					};
+				};
+
+				port@1 {
+					reg =3D <1>;
+					replicator_out1: endpoint {
+						remote-endpoint =3D <&replicator1_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_in0: endpoint {
+						remote-endpoint =3D <&etf_out>;
+					};
+				};
+			};
+		};
+
+		etf@6047000 {
+			compatible =3D "arm,coresight-tmc", "arm,primecell";
+			reg =3D <0 0x06047000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =3D <&replicator_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint =3D <&merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		etr@6048000 {
+			compatible =3D "arm,coresight-tmc", "arm,primecell";
+			reg =3D <0 0x06048000 0 0x1000>;
+			iommus =3D <&apps_smmu 0x05e0 0x0>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =3D <&replicator_out0>;
+					};
+				};
+			};
+		};
+
+		replicator@604a000 {
+			compatible =3D "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg =3D <0 0x0604a000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@1 {
+					reg =3D <1>;
+					replicator1_out: endpoint {
+						remote-endpoint =3D <&swao_funnel_in>;
+					};
+				};
+			};
+
+			in-ports {
+
+				port {
+					replicator1_in: endpoint {
+						remote-endpoint =3D <&replicator_out1>;
+					};
+				};
+			};
+		};
+
+		funnel@6b08000 {
+			compatible =3D "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg =3D <0 0x06b08000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					swao_funnel_out: endpoint {
+						remote-endpoint =3D <&swao_etf_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@6 {
+					reg =3D <6>;
+					swao_funnel_in: endpoint {
+						remote-endpoint =3D <&replicator1_out>;
+					};
+				};
+			};
+		};
+
+		etf@6b09000 {
+			compatible =3D "arm,coresight-tmc", "arm,primecell";
+			reg =3D <0 0x06b09000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					swao_etf_out: endpoint {
+						remote-endpoint =3D <&swao_replicator_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					swao_etf_in: endpoint {
+						remote-endpoint =3D <&swao_funnel_out>;
+					};
+				};
+			};
+		};
+
+		replicator@6b0a000 {
+			compatible =3D "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg =3D <0 0x06b0a000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			qcom,replicator-loses-context;
+
+			out-ports {
+				port {
+					swao_replicator_out: endpoint {
+						remote-endpoint =3D <&funnel1_in4>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					swao_replicator_in: endpoint {
+						remote-endpoint =3D <&swao_etf_out>;
+					};
+				};
+			};
+		};
+
+		etm@7040000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07040000 0 0x1000>;
+
+			cpu =3D <&CPU0>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		etm@7140000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07140000 0 0x1000>;
+
+			cpu =3D <&CPU1>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		etm@7240000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07240000 0 0x1000>;
+
+			cpu =3D <&CPU2>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@7340000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07340000 0 0x1000>;
+
+			cpu =3D <&CPU3>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		etm@7440000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07440000 0 0x1000>;
+
+			cpu =3D <&CPU4>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in4>;
+					};
+				};
+			};
+		};
+
+		etm@7540000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07540000 0 0x1000>;
+
+			cpu =3D <&CPU5>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in5>;
+					};
+				};
+			};
+		};
+
+		etm@7640000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07640000 0 0x1000>;
+
+			cpu =3D <&CPU6>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in6>;
+					};
+				};
+			};
+		};
+
+		etm@7740000 {
+			compatible =3D "arm,coresight-etm4x", "arm,primecell";
+			reg =3D <0 0x07740000 0 0x1000>;
+
+			cpu =3D <&CPU7>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =3D <&apss_funnel_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@7800000 { /* APSS Funnel */
+			compatible =3D "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg =3D <0 0x07800000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					apss_funnel_out: endpoint {
+						remote-endpoint =3D <&apss_merge_funnel_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					apss_funnel_in0: endpoint {
+						remote-endpoint =3D <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg =3D <1>;
+					apss_funnel_in1: endpoint {
+						remote-endpoint =3D <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg =3D <2>;
+					apss_funnel_in2: endpoint {
+						remote-endpoint =3D <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg =3D <3>;
+					apss_funnel_in3: endpoint {
+						remote-endpoint =3D <&etm3_out>;
+					};
+				};
+
+				port@4 {
+					reg =3D <4>;
+					apss_funnel_in4: endpoint {
+						remote-endpoint =3D <&etm4_out>;
+					};
+				};
+
+				port@5 {
+					reg =3D <5>;
+					apss_funnel_in5: endpoint {
+						remote-endpoint =3D <&etm5_out>;
+					};
+				};
+
+				port@6 {
+					reg =3D <6>;
+					apss_funnel_in6: endpoint {
+						remote-endpoint =3D <&etm6_out>;
+					};
+				};
+
+				port@7 {
+					reg =3D <7>;
+					apss_funnel_in7: endpoint {
+						remote-endpoint =3D <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		funnel@7810000 {
+			compatible =3D "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg =3D <0 0x07810000 0 0x1000>;
+
+			clocks =3D <&aoss_qmp>;
+			clock-names =3D "apb_pclk";
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =3D <&funnel2_in2>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					apss_merge_funnel_in: endpoint {
+						remote-endpoint =3D <&apss_funnel_out>;
+					};
+				};
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@8300000 {
+			compatible =3D "qcom,sm8150-cdsp-pas";
+			reg =3D <0x0 0x08300000 0x0 0x4040>;
+
+			interrupts-extended =3D <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
+			clock-names =3D "xo";
+
+			power-domains =3D <&rpmhpd SM8150_CX>;
+
+			memory-region =3D <&cdsp_mem>;
+
+			qcom,qmp =3D <&aoss_qmp>;
+
+			qcom,smem-states =3D <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names =3D "stop";
+
+			status =3D "disabled";
+
+			glink-edge {
+				interrupts =3D <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>;
+				label =3D "cdsp";
+				qcom,remote-pid =3D <5>;
+				mboxes =3D <&apss_shared 4>;
+
+				fastrpc {
+					compatible =3D "qcom,fastrpc";
+					qcom,glink-channels =3D "fastrpcglink-apps-dsp";
+					label =3D "cdsp";
+					qcom,non-secure-domain;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					compute-cb@1 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <1>;
+						iommus =3D <&apps_smmu 0x1001 0x0460>;
+					};
+
+					compute-cb@2 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <2>;
+						iommus =3D <&apps_smmu 0x1002 0x0460>;
+					};
+
+					compute-cb@3 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <3>;
+						iommus =3D <&apps_smmu 0x1003 0x0460>;
+					};
+
+					compute-cb@4 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <4>;
+						iommus =3D <&apps_smmu 0x1004 0x0460>;
+					};
+
+					compute-cb@5 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <5>;
+						iommus =3D <&apps_smmu 0x1005 0x0460>;
+					};
+
+					compute-cb@6 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <6>;
+						iommus =3D <&apps_smmu 0x1006 0x0460>;
+					};
+
+					compute-cb@7 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <7>;
+						iommus =3D <&apps_smmu 0x1007 0x0460>;
+					};
+
+					compute-cb@8 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <8>;
+						iommus =3D <&apps_smmu 0x1008 0x0460>;
+					};
+
+					/* note: secure cb9 in downstream */
+				};
+			};
+		};
+
+		usb_1_hsphy: phy@88e2000 {
+			compatible =3D "qcom,sm8150-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
+			reg =3D <0 0x088e2000 0 0x400>;
+			status =3D "disabled";
+			#phy-cells =3D <0>;
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
+			clock-names =3D "ref";
+
+			resets =3D <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+		};
+
+		usb_2_hsphy: phy@88e3000 {
+			compatible =3D "qcom,sm8150-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
+			reg =3D <0 0x088e3000 0 0x400>;
+			status =3D "disabled";
+			#phy-cells =3D <0>;
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
+			clock-names =3D "ref";
+
+			resets =3D <&gcc GCC_QUSB2PHY_SEC_BCR>;
+		};
+
+		usb_1_qmpphy: phy@88e8000 {
+			compatible =3D "qcom,sm8150-qmp-usb3-dp-phy";
+			reg =3D <0 0x088e8000 0 0x3000>;
+
+			clocks =3D <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names =3D "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe";
+
+			resets =3D <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			reset-names =3D "phy", "common";
+
+			#clock-cells =3D <1>;
+			#phy-cells =3D <1>;
+
+			status =3D "disabled";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+
+					usb_1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg =3D <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint {
+					};
+				};
+
+				port@2 {
+					reg =3D <2>;
+
+					usb_1_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
+		};
+
+		usb_2_qmpphy: phy@88eb000 {
+			compatible =3D "qcom,sm8150-qmp-usb3-uni-phy";
+			reg =3D <0 0x088eb000 0 0x1000>;
+
+			clocks =3D <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+			clock-names =3D "aux",
+				      "ref",
+				      "com_aux",
+				      "pipe";
+			clock-output-names =3D "usb3_uni_phy_pipe_clk_src";
+			#clock-cells =3D <0>;
+			#phy-cells =3D <0>;
+
+			resets =3D <&gcc GCC_USB3_PHY_SEC_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_SEC_BCR>;
+			reset-names =3D "phy",
+				      "phy_phy";
+
+			status =3D "disabled";
+		};
+
+		sdhc_2: mmc@8804000 {
+			compatible =3D "qcom,sm8150-sdhci", "qcom,sdhci-msm-v5";
+			reg =3D <0 0x08804000 0 0x1000>;
+
+			interrupts =3D <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "hc_irq", "pwr_irq";
+
+			clocks =3D <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names =3D "iface", "core", "xo";
+			iommus =3D <&apps_smmu 0x6a0 0x0>;
+			qcom,dll-config =3D <0x0007642c>;
+			qcom,ddr-config =3D <0x80040868>;
+			power-domains =3D <&rpmhpd 0>;
+			operating-points-v2 =3D <&sdhc2_opp_table>;
+
+			status =3D "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible =3D "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz =3D /bits/ 64 <19200000>;
+					required-opps =3D <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-50000000 {
+					opp-hz =3D /bits/ 64 <50000000>;
+					required-opps =3D <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-100000000 {
+					opp-hz =3D /bits/ 64 <100000000>;
+					required-opps =3D <&rpmhpd_opp_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz =3D /bits/ 64 <202000000>;
+					required-opps =3D <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
+		dc_noc: interconnect@9160000 {
+			compatible =3D "qcom,sm8150-dc-noc";
+			reg =3D <0 0x09160000 0 0x3200>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9680000 {
+			compatible =3D "qcom,sm8150-gem-noc";
+			reg =3D <0 0x09680000 0 0x3e200>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible =3D "qcom,sm8150-dwc3", "qcom,dwc3";
+			reg =3D <0 0x0a6f8800 0 0x400>;
+			status =3D "disabled";
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+			dma-ranges;
+
+			clocks =3D <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
+			clock-names =3D "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
+
+			assigned-clocks =3D <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates =3D <19200000>, <200000000>;
+
+			interrupts-extended =3D <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names =3D "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains =3D <&gcc USB30_PRIM_GDSC>;
+
+			resets =3D <&gcc GCC_USB30_PRIM_BCR>;
+
+			interconnects =3D <&aggre1_noc MASTER_USB3 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
+			interconnect-names =3D "usb-ddr", "apps-usb";
+
+			usb_1_dwc3: usb@a600000 {
+				compatible =3D "snps,dwc3";
+				reg =3D <0 0x0a600000 0 0xcd00>;
+				interrupts =3D <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus =3D <&apps_smmu 0x140 0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys =3D <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
+				phy-names =3D "usb2-phy", "usb3-phy";
+
+				ports {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					port@0 {
+						reg =3D <0>;
+
+						usb_1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg =3D <1>;
+
+						usb_1_dwc3_ss: endpoint {
+						};
+					};
+				};
+			};
+		};
+
+		usb_2: usb@a8f8800 {
+			compatible =3D "qcom,sm8150-dwc3", "qcom,dwc3";
+			reg =3D <0 0x0a8f8800 0 0x400>;
+			status =3D "disabled";
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+			dma-ranges;
+
+			clocks =3D <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
+			clock-names =3D "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
+
+			assigned-clocks =3D <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
+			assigned-clock-rates =3D <19200000>, <200000000>;
+
+			interrupts-extended =3D <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 7 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names =3D "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains =3D <&gcc USB30_SEC_GDSC>;
+
+			resets =3D <&gcc GCC_USB30_SEC_BCR>;
+
+			interconnects =3D <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI_CH0 0=
>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3_1 0>;
+			interconnect-names =3D "usb-ddr", "apps-usb";
+
+			usb_2_dwc3: usb@a800000 {
+				compatible =3D "snps,dwc3";
+				reg =3D <0 0x0a800000 0 0xcd00>;
+				interrupts =3D <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				iommus =3D <&apps_smmu 0x160 0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys =3D <&usb_2_hsphy>, <&usb_2_qmpphy>;
+				phy-names =3D "usb2-phy", "usb3-phy";
+			};
+		};
+
+		camnoc_virt: interconnect@ac00000 {
+			compatible =3D "qcom,sm8150-camnoc-virt";
+			reg =3D <0 0x0ac00000 0 0x1000>;
+			#interconnect-cells =3D <2>;
+			qcom,bcm-voters =3D <&apps_bcm_voter>;
+		};
+
+		mdss: display-subsystem@ae00000 {
+			compatible =3D "qcom,sm8150-mdss";
+			reg =3D <0 0x0ae00000 0 0x1000>;
+			reg-names =3D "mdss";
+
+			interconnects =3D <&mmss_noc MASTER_MDP_PORT0 0 &mc_virt SLAVE_EBI_CH0 =
0>,
+					<&mmss_noc MASTER_MDP_PORT1 0 &mc_virt SLAVE_EBI_CH0 0>;
+			interconnect-names =3D "mdp0-mem", "mdp1-mem";
+
+			power-domains =3D <&dispcc MDSS_GDSC>;
+
+			clocks =3D <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+			clock-names =3D "iface", "bus", "nrt_bus", "core";
+
+			interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells =3D <1>;
+
+			iommus =3D <&apps_smmu 0x800 0x420>;
+
+			status =3D "disabled";
+
+			#address-cells =3D <2>;
+			#size-cells =3D <2>;
+			ranges;
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible =3D "qcom,sm8150-dpu";
+				reg =3D <0 0x0ae01000 0 0x8f000>,
+				      <0 0x0aeb0000 0 0x2008>;
+				reg-names =3D "mdp", "vbif";
+
+				clocks =3D <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names =3D "iface", "bus", "core", "vsync";
+
+				assigned-clocks =3D <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates =3D <19200000>;
+
+				operating-points-v2 =3D <&mdp_opp_table>;
+				power-domains =3D <&rpmhpd SM8150_MMCX>;
+
+				interrupt-parent =3D <&mdss>;
+				interrupts =3D <0>;
+
+				ports {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					port@0 {
+						reg =3D <0>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint =3D <&mdss_dsi0_in>;
+						};
+					};
+
+					port@1 {
+						reg =3D <1>;
+						dpu_intf2_out: endpoint {
+							remote-endpoint =3D <&mdss_dsi1_in>;
+						};
+					};
+
+					port@2 {
+						reg =3D <2>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint =3D <&mdss_dp_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible =3D "operating-points-v2";
+
+					opp-171428571 {
+						opp-hz =3D /bits/ 64 <171428571>;
+						required-opps =3D <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz =3D /bits/ 64 <300000000>;
+						required-opps =3D <&rpmhpd_opp_svs>;
+					};
+
+					opp-345000000 {
+						opp-hz =3D /bits/ 64 <345000000>;
+						required-opps =3D <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-460000000 {
+						opp-hz =3D /bits/ 64 <460000000>;
+						required-opps =3D <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss_dp: displayport-controller@ae90000 {
+				compatible =3D "qcom,sm8150-dp", "qcom,sm8350-dp";
+				reg =3D <0 0xae90000 0 0x200>,
+				      <0 0xae90200 0 0x200>,
+				      <0 0xae90400 0 0x600>,
+				      <0 0x0ae90a00 0 0x600>,
+				      <0 0x0ae91000 0 0x600>;
+
+				interrupt-parent =3D <&mdss>;
+				interrupts =3D <12>;
+				clocks =3D <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+				clock-names =3D "core_iface",
+					      "core_aux",
+					      "ctrl_link",
+					      "ctrl_link_iface",
+					      "stream_pixel";
+
+				assigned-clocks =3D <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+				assigned-clock-parents =3D <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				phys =3D <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
+				phy-names =3D "dp";
+
+				#sound-dai-cells =3D <0>;
+
+				operating-points-v2 =3D <&dp_opp_table>;
+				power-domains =3D <&rpmhpd SM8250_MMCX>;
+
+				status =3D "disabled";
+
+				ports {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					port@0 {
+						reg =3D <0>;
+						mdss_dp_in: endpoint {
+							remote-endpoint =3D <&dpu_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg =3D <1>;
+
+						mdss_dp_out: endpoint {
+						};
+					};
+				};
+
+				dp_opp_table: opp-table {
+					compatible =3D "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz =3D /bits/ 64 <160000000>;
+						required-opps =3D <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz =3D /bits/ 64 <270000000>;
+						required-opps =3D <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz =3D /bits/ 64 <540000000>;
+						required-opps =3D <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz =3D /bits/ 64 <810000000>;
+						required-opps =3D <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@ae94000 {
+				compatible =3D "qcom,sm8150-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg =3D <0 0x0ae94000 0 0x400>;
+				reg-names =3D "dsi_ctrl";
+
+				interrupt-parent =3D <&mdss>;
+				interrupts =3D <4>;
+
+				clocks =3D <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>;
+				clock-names =3D "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				assigned-clocks =3D <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents =3D <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
+
+				operating-points-v2 =3D <&dsi_opp_table>;
+				power-domains =3D <&rpmhpd SM8150_MMCX>;
+
+				phys =3D <&mdss_dsi0_phy>;
+
+				status =3D "disabled";
+
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				ports {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					port@0 {
+						reg =3D <0>;
+						mdss_dsi0_in: endpoint {
+							remote-endpoint =3D <&dpu_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg =3D <1>;
+						mdss_dsi0_out: endpoint {
+						};
+					};
+				};
+
+				dsi_opp_table: opp-table {
+					compatible =3D "operating-points-v2";
+
+					opp-187500000 {
+						opp-hz =3D /bits/ 64 <187500000>;
+						required-opps =3D <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz =3D /bits/ 64 <300000000>;
+						required-opps =3D <&rpmhpd_opp_svs>;
+					};
+
+					opp-358000000 {
+						opp-hz =3D /bits/ 64 <358000000>;
+						required-opps =3D <&rpmhpd_opp_svs_l1>;
+					};
+				};
+			};
+
+			mdss_dsi0_phy: phy@ae94400 {
+				compatible =3D "qcom,dsi-phy-7nm-8150";
+				reg =3D <0 0x0ae94400 0 0x200>,
+				      <0 0x0ae94600 0 0x280>,
+				      <0 0x0ae94900 0 0x260>;
+				reg-names =3D "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells =3D <1>;
+				#phy-cells =3D <0>;
+
+				clocks =3D <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names =3D "iface", "ref";
+
+				status =3D "disabled";
+			};
+
+			mdss_dsi1: dsi@ae96000 {
+				compatible =3D "qcom,sm8150-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg =3D <0 0x0ae96000 0 0x400>;
+				reg-names =3D "dsi_ctrl";
+
+				interrupt-parent =3D <&mdss>;
+				interrupts =3D <5>;
+
+				clocks =3D <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK1_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC1_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>;
+				clock-names =3D "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				assigned-clocks =3D <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
+				assigned-clock-parents =3D <&mdss_dsi1_phy 0>,
+							 <&mdss_dsi1_phy 1>;
+
+				operating-points-v2 =3D <&dsi_opp_table>;
+				power-domains =3D <&rpmhpd SM8150_MMCX>;
+
+				phys =3D <&mdss_dsi1_phy>;
+
+				status =3D "disabled";
+
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				ports {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					port@0 {
+						reg =3D <0>;
+						mdss_dsi1_in: endpoint {
+							remote-endpoint =3D <&dpu_intf2_out>;
+						};
+					};
+
+					port@1 {
+						reg =3D <1>;
+						mdss_dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi1_phy: phy@ae96400 {
+				compatible =3D "qcom,dsi-phy-7nm-8150";
+				reg =3D <0 0x0ae96400 0 0x200>,
+				      <0 0x0ae96600 0 0x280>,
+				      <0 0x0ae96900 0 0x260>;
+				reg-names =3D "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells =3D <1>;
+				#phy-cells =3D <0>;
+
+				clocks =3D <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names =3D "iface", "ref";
+
+				status =3D "disabled";
+			};
+		};
+
+		dispcc: clock-controller@af00000 {
+			compatible =3D "qcom,sm8150-dispcc";
+			reg =3D <0 0x0af00000 0 0x10000>;
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi1_phy 0>,
+				 <&mdss_dsi1_phy 1>,
+				 <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+			clock-names =3D "bi_tcxo",
+				      "dsi0_phy_pll_out_byteclk",
+				      "dsi0_phy_pll_out_dsiclk",
+				      "dsi1_phy_pll_out_byteclk",
+				      "dsi1_phy_pll_out_dsiclk",
+				      "dp_phy_pll_link_clk",
+				      "dp_phy_pll_vco_div_clk";
+			power-domains =3D <&rpmhpd SM8150_MMCX>;
+			required-opps =3D <&rpmhpd_opp_low_svs>;
+			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
+			#power-domain-cells =3D <1>;
+		};
+
+		pdc: interrupt-controller@b220000 {
+			compatible =3D "qcom,sm8150-pdc", "qcom,pdc";
+			reg =3D <0 0x0b220000 0 0x30000>;
+			qcom,pdc-ranges =3D <0 480 94>, <94 609 31>,
+					  <125 63 1>;
+			#interrupt-cells =3D <2>;
+			interrupt-parent =3D <&intc>;
+			interrupt-controller;
+		};
+
+		aoss_qmp: power-management@c300000 {
+			compatible =3D "qcom,sm8150-aoss-qmp", "qcom,aoss-qmp";
+			reg =3D <0x0 0x0c300000 0x0 0x400>;
+			interrupts =3D <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes =3D <&apss_shared 0>;
+
+			#clock-cells =3D <0>;
+		};
+
+		sram@c3f0000 {
+			compatible =3D "qcom,rpmh-stats";
+			reg =3D <0 0x0c3f0000 0 0x400>;
+		};
+
+		tsens0: thermal-sensor@c263000 {
+			compatible =3D "qcom,sm8150-tsens", "qcom,tsens-v2";
+			reg =3D <0 0x0c263000 0 0x1ff>, /* TM */
+			      <0 0x0c222000 0 0x1ff>; /* SROT */
+			#qcom,sensors =3D <16>;
+			interrupts =3D <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "uplow", "critical";
+			#thermal-sensor-cells =3D <1>;
+		};
+
+		tsens1: thermal-sensor@c265000 {
+			compatible =3D "qcom,sm8150-tsens", "qcom,tsens-v2";
+			reg =3D <0 0x0c265000 0 0x1ff>, /* TM */
+			      <0 0x0c223000 0 0x1ff>; /* SROT */
+			#qcom,sensors =3D <8>;
+			interrupts =3D <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "uplow", "critical";
+			#thermal-sensor-cells =3D <1>;
+		};
+
+		spmi_bus: spmi@c440000 {
+			compatible =3D "qcom,spmi-pmic-arb";
+			reg =3D <0x0 0x0c440000 0x0 0x0001100>,
+			      <0x0 0x0c600000 0x0 0x2000000>,
+			      <0x0 0x0e600000 0x0 0x0100000>,
+			      <0x0 0x0e700000 0x0 0x00a0000>,
+			      <0x0 0x0c40a000 0x0 0x0026000>;
+			reg-names =3D "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names =3D "periph_irq";
+			interrupts =3D <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee =3D <0>;
+			qcom,channel =3D <0>;
+			#address-cells =3D <2>;
+			#size-cells =3D <0>;
+			interrupt-controller;
+			#interrupt-cells =3D <4>;
+		};
+
+		apps_smmu: iommu@15000000 {
+			compatible =3D "qcom,sm8150-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			reg =3D <0 0x15000000 0 0x100000>;
+			#iommu-cells =3D <2>;
+			#global-interrupts =3D <1>;
+			interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		remoteproc_adsp: remoteproc@17300000 {
+			compatible =3D "qcom,sm8150-adsp-pas";
+			reg =3D <0x0 0x17300000 0x0 0x4040>;
+
+			interrupts-extended =3D <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
+			clock-names =3D "xo";
+
+			power-domains =3D <&rpmhpd SM8150_CX>;
+
+			memory-region =3D <&adsp_mem>;
+
+			qcom,qmp =3D <&aoss_qmp>;
+
+			qcom,smem-states =3D <&adsp_smp2p_out 0>;
+			qcom,smem-state-names =3D "stop";
+
+			status =3D "disabled";
+
+			glink-edge {
+				interrupts =3D <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+				label =3D "lpass";
+				qcom,remote-pid =3D <2>;
+				mboxes =3D <&apss_shared 8>;
+
+				fastrpc {
+					compatible =3D "qcom,fastrpc";
+					qcom,glink-channels =3D "fastrpcglink-apps-dsp";
+					label =3D "adsp";
+					qcom,non-secure-domain;
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					compute-cb@3 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <3>;
+						iommus =3D <&apps_smmu 0x1b23 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <4>;
+						iommus =3D <&apps_smmu 0x1b24 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible =3D "qcom,fastrpc-compute-cb";
+						reg =3D <5>;
+						iommus =3D <&apps_smmu 0x1b25 0x0>;
+					};
+				};
+			};
+		};
+
+		intc: interrupt-controller@17a00000 {
+			compatible =3D "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells =3D <3>;
+			reg =3D <0x0 0x17a00000 0x0 0x10000>,	/* GICD */
+			      <0x0 0x17a60000 0x0 0x100000>;	/* GICR * 8 */
+			interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		apss_shared: mailbox@17c00000 {
+			compatible =3D "qcom,sm8150-apss-shared",
+				     "qcom,sdm845-apss-shared";
+			reg =3D <0x0 0x17c00000 0x0 0x1000>;
+			#mbox-cells =3D <1>;
+		};
+
+		watchdog@17c10000 {
+			compatible =3D "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
+			reg =3D <0 0x17c10000 0 0x1000>;
+			clocks =3D <&sleep_clk>;
+			interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		timer@17c20000 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0 0 0 0x20000000>;
+			compatible =3D "arm,armv7-timer-mem";
+			reg =3D <0x0 0x17c20000 0x0 0x1000>;
+			clock-frequency =3D <19200000>;
+
+			frame@17c21000 {
+				frame-number =3D <0>;
+				interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				reg =3D <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
+			};
+
+			frame@17c23000 {
+				frame-number =3D <1>;
+				interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg =3D <0x17c23000 0x1000>;
+				status =3D "disabled";
+			};
+
+			frame@17c25000 {
+				frame-number =3D <2>;
+				interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg =3D <0x17c25000 0x1000>;
+				status =3D "disabled";
+			};
+
+			frame@17c27000 {
+				frame-number =3D <3>;
+				interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg =3D <0x17c26000 0x1000>;
+				status =3D "disabled";
+			};
+
+			frame@17c29000 {
+				frame-number =3D <4>;
+				interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg =3D <0x17c29000 0x1000>;
+				status =3D "disabled";
+			};
+
+			frame@17c2b000 {
+				frame-number =3D <5>;
+				interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg =3D <0x17c2b000 0x1000>;
+				status =3D "disabled";
+			};
+
+			frame@17c2d000 {
+				frame-number =3D <6>;
+				interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg =3D <0x17c2d000 0x1000>;
+				status =3D "disabled";
+			};
+		};
+
+		apps_rsc: rsc@18200000 {
+			label =3D "apps_rsc";
+			compatible =3D "qcom,rpmh-rsc";
+			reg =3D <0x0 0x18200000 0x0 0x10000>,
+			      <0x0 0x18210000 0x0 0x10000>,
+			      <0x0 0x18220000 0x0 0x10000>;
+			reg-names =3D "drv-0", "drv-1", "drv-2";
+			interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset =3D <0xd00>;
+			qcom,drv-id =3D <2>;
+			qcom,tcs-config =3D <ACTIVE_TCS  2>,
+					  <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <CONTROL_TCS 1>;
+			power-domains =3D <&CLUSTER_PD>;
+
+			rpmhcc: clock-controller {
+				compatible =3D "qcom,sm8150-rpmh-clk";
+				#clock-cells =3D <1>;
+				clock-names =3D "xo";
+				clocks =3D <&xo_board>;
+			};
+
+			rpmhpd: power-controller {
+				compatible =3D "qcom,sm8150-rpmhpd";
+				#power-domain-cells =3D <1>;
+				operating-points-v2 =3D <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible =3D "operating-points-v2";
+
+					rpmhpd_opp_ret: opp1 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp2 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp3 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp4 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp5 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_svs_l2: opp6 {
+						opp-level =3D <224>;
+					};
+
+					rpmhpd_opp_nom: opp7 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp8 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp9 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp10 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp11 {
+						opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+
+			apps_bcm_voter: bcm-voter {
+				compatible =3D "qcom,bcm-voter";
+			};
+		};
+
+		osm_l3: interconnect@18321000 {
+			compatible =3D "qcom,sm8150-osm-l3", "qcom,osm-l3";
+			reg =3D <0 0x18321000 0 0x1400>;
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names =3D "xo", "alternate";
+
+			#interconnect-cells =3D <1>;
+		};
+
+		cpufreq_hw: cpufreq@18323000 {
+			compatible =3D "qcom,sm8150-cpufreq-hw", "qcom,cpufreq-hw";
+			reg =3D <0 0x18323000 0 0x1400>, <0 0x18325800 0 0x1400>,
+			      <0 0x18327800 0 0x1400>;
+			reg-names =3D "freq-domain0", "freq-domain1",
+				    "freq-domain2";
+
+			clocks =3D <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names =3D "xo", "alternate";
+
+			#freq-domain-cells =3D <1>;
+			#clock-cells =3D <1>;
+		};
+
+		lmh_cluster1: lmh@18350800 {
+			compatible =3D "qcom,sm8150-lmh";
+			reg =3D <0 0x18350800 0 0x400>;
+			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			cpus =3D <&CPU4>;
+			qcom,lmh-temp-arm-millicelsius =3D <60000>;
+			qcom,lmh-temp-low-millicelsius =3D <84500>;
+			qcom,lmh-temp-high-millicelsius =3D <85000>;
+			interrupt-controller;
+			#interrupt-cells =3D <1>;
+		};
+
+		lmh_cluster0: lmh@18358800 {
+			compatible =3D "qcom,sm8150-lmh";
+			reg =3D <0 0x18358800 0 0x400>;
+			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			cpus =3D <&CPU0>;
+			qcom,lmh-temp-arm-millicelsius =3D <60000>;
+			qcom,lmh-temp-low-millicelsius =3D <84500>;
+			qcom,lmh-temp-high-millicelsius =3D <85000>;
+			interrupt-controller;
+			#interrupt-cells =3D <1>;
+		};
+
+		wifi: wifi@18800000 {
+			compatible =3D "qcom,wcn3990-wifi";
+			reg =3D <0 0x18800000 0 0x800000>;
+			reg-names =3D "membase";
+			memory-region =3D <&wlan_mem>;
+			clock-names =3D "cxo_ref_clk_pin", "qdss";
+			clocks =3D <&rpmhcc RPMH_RF_CLK2>, <&aoss_qmp>;
+			interrupts =3D <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			iommus =3D <&apps_smmu 0x0640 0x1>;
+			status =3D "disabled";
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 1>;
+
+			trips {
+				cpu0_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu0_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu0_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu0_alert0>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu0_alert1>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 2>;
+
+			trips {
+				cpu1_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu1_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu1_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu1_alert0>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu1_alert1>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 3>;
+
+			trips {
+				cpu2_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu2_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu2_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu2_alert0>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu2_alert1>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 4>;
+
+			trips {
+				cpu3_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu3_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu3_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu3_alert0>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu3_alert1>;
+					cooling-device =3D <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4-top-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 7>;
+
+			trips {
+				cpu4_top_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu4_top_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu4_top_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu4_top_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu4_top_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu5-top-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 8>;
+
+			trips {
+				cpu5_top_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu5_top_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu5_top_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu5_top_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu5_top_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu6-top-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 9>;
+
+			trips {
+				cpu6_top_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu6_top_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu6_top_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu6_top_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu6_top_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu7-top-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 10>;
+
+			trips {
+				cpu7_top_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu7_top_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu7_top_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu7_top_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu7_top_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4-bottom-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 11>;
+
+			trips {
+				cpu4_bottom_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu4_bottom_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu4_bottom_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu4_bottom_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu4_bottom_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu5-bottom-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 12>;
+
+			trips {
+				cpu5_bottom_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu5_bottom_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu5_bottom_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu5_bottom_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu5_bottom_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu6-bottom-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 13>;
+
+			trips {
+				cpu6_bottom_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu6_bottom_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu6_bottom_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu6_bottom_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu6_bottom_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu7-bottom-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 14>;
+
+			trips {
+				cpu7_bottom_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu7_bottom_alert1: trip-point1 {
+					temperature =3D <95000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu7_bottom_crit: cpu-crit {
+					temperature =3D <110000>;
+					hysteresis =3D <1000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu7_bottom_alert0>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip =3D <&cpu7_bottom_alert1>;
+					cooling-device =3D <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		aoss0-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 0>;
+
+			trips {
+				aoss0_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 5>;
+
+			trips {
+				cluster0_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+				cluster0_crit: cluster0_crit {
+					temperature =3D <110000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 6>;
+
+			trips {
+				cluster1_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+				cluster1_crit: cluster1_crit {
+					temperature =3D <110000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		gpu-top-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens0 15>;
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		aoss1-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 0>;
+
+			trips {
+				aoss1_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 1>;
+
+			trips {
+				wlan_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		video-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 2>;
+
+			trips {
+				video_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 3>;
+
+			trips {
+				mem_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		q6-hvx-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 4>;
+
+			trips {
+				q6_hvx_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		camera-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 5>;
+
+			trips {
+				camera_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		compute-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 6>;
+
+			trips {
+				compute_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		modem-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 7>;
+
+			trips {
+				modem_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		npu-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 8>;
+
+			trips {
+				npu_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		modem-vec-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 9>;
+
+			trips {
+				modem_vec_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		modem-scl-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 10>;
+
+			trips {
+				modem_scl_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+
+		gpu-bottom-thermal {
+			polling-delay-passive =3D <250>;
+			polling-delay =3D <1000>;
+
+			thermal-sensors =3D <&tsens1 11>;
+
+			trips {
+				gpu2_alert0: trip-point0 {
+					temperature =3D <90000>;
+					hysteresis =3D <2000>;
+					type =3D "hot";
+				};
+			};
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/qcom,dispcc-sm8150.h b/include/dt-bi=
ndings/clock/qcom,dispcc-sm8150.h
new file mode 100644
index 0000000000..767fdb27e5
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sm8150.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM8250_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM8250_H
+
+/* DISP_CC clock registers */
+#define DISP_CC_MDSS_AHB_CLK			0
+#define DISP_CC_MDSS_AHB_CLK_SRC		1
+#define DISP_CC_MDSS_BYTE0_CLK			2
+#define DISP_CC_MDSS_BYTE0_CLK_SRC		3
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC		4
+#define DISP_CC_MDSS_BYTE0_INTF_CLK		5
+#define DISP_CC_MDSS_BYTE1_CLK			6
+#define DISP_CC_MDSS_BYTE1_CLK_SRC		7
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC		8
+#define DISP_CC_MDSS_BYTE1_INTF_CLK		9
+#define DISP_CC_MDSS_DP_AUX1_CLK		10
+#define DISP_CC_MDSS_DP_AUX1_CLK_SRC		11
+#define DISP_CC_MDSS_DP_AUX_CLK			12
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC		13
+#define DISP_CC_MDSS_DP_LINK1_CLK		14
+#define DISP_CC_MDSS_DP_LINK1_CLK_SRC		15
+#define DISP_CC_MDSS_DP_LINK1_DIV_CLK_SRC	16
+#define DISP_CC_MDSS_DP_LINK1_INTF_CLK		17
+#define DISP_CC_MDSS_DP_LINK_CLK		18
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC		19
+#define DISP_CC_MDSS_DP_LINK_DIV_CLK_SRC	20
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK		21
+#define DISP_CC_MDSS_DP_PIXEL1_CLK		22
+#define DISP_CC_MDSS_DP_PIXEL1_CLK_SRC		23
+#define DISP_CC_MDSS_DP_PIXEL2_CLK		24
+#define DISP_CC_MDSS_DP_PIXEL2_CLK_SRC		25
+#define DISP_CC_MDSS_DP_PIXEL_CLK		26
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC		27
+#define DISP_CC_MDSS_ESC0_CLK			28
+#define DISP_CC_MDSS_ESC0_CLK_SRC		29
+#define DISP_CC_MDSS_ESC1_CLK			30
+#define DISP_CC_MDSS_ESC1_CLK_SRC		31
+#define DISP_CC_MDSS_MDP_CLK			32
+#define DISP_CC_MDSS_MDP_CLK_SRC		33
+#define DISP_CC_MDSS_MDP_LUT_CLK		34
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK		35
+#define DISP_CC_MDSS_PCLK0_CLK			36
+#define DISP_CC_MDSS_PCLK0_CLK_SRC		37
+#define DISP_CC_MDSS_PCLK1_CLK			38
+#define DISP_CC_MDSS_PCLK1_CLK_SRC		39
+#define DISP_CC_MDSS_ROT_CLK			40
+#define DISP_CC_MDSS_ROT_CLK_SRC		41
+#define DISP_CC_MDSS_RSCC_AHB_CLK		42
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK		43
+#define DISP_CC_MDSS_VSYNC_CLK			44
+#define DISP_CC_MDSS_VSYNC_CLK_SRC		45
+#define DISP_CC_PLL0				46
+#define DISP_CC_PLL1				47
+#define DISP_CC_MDSS_EDP_AUX_CLK		48
+#define DISP_CC_MDSS_EDP_AUX_CLK_SRC		49
+#define DISP_CC_MDSS_EDP_GTC_CLK		50
+#define DISP_CC_MDSS_EDP_GTC_CLK_SRC		51
+#define DISP_CC_MDSS_EDP_LINK_CLK		52
+#define DISP_CC_MDSS_EDP_LINK_CLK_SRC		53
+#define DISP_CC_MDSS_EDP_LINK_INTF_CLK		54
+#define DISP_CC_MDSS_EDP_PIXEL_CLK		55
+#define DISP_CC_MDSS_EDP_PIXEL_CLK_SRC		56
+#define DISP_CC_MDSS_EDP_LINK_DIV_CLK_SRC	57
+
+/* DISP_CC Reset */
+#define DISP_CC_MDSS_CORE_BCR			0
+#define DISP_CC_MDSS_RSCC_BCR			1
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC				0
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindi=
ngs/clock/qcom,gcc-sm8150.h
new file mode 100644
index 0000000000..dfefd5e8bf
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
@@ -0,0 +1,252 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM8150_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM8150_H
+
+/* GCC clocks */
+#define GCC_AGGRE_NOC_PCIE_TBU_CLK				0
+#define GCC_AGGRE_UFS_CARD_AXI_CLK				1
+#define GCC_AGGRE_UFS_CARD_AXI_HW_CTL_CLK			2
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				3
+#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK			4
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				5
+#define GCC_AGGRE_USB3_SEC_AXI_CLK				6
+#define GCC_BOOT_ROM_AHB_CLK					7
+#define GCC_CAMERA_AHB_CLK					8
+#define GCC_CAMERA_HF_AXI_CLK					9
+#define GCC_CAMERA_SF_AXI_CLK					10
+#define GCC_CAMERA_XO_CLK					11
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				12
+#define GCC_CFG_NOC_USB3_SEC_AXI_CLK				13
+#define GCC_CPUSS_AHB_CLK					14
+#define GCC_CPUSS_AHB_CLK_SRC					15
+#define GCC_CPUSS_DVM_BUS_CLK					16
+#define GCC_CPUSS_GNOC_CLK					17
+#define GCC_CPUSS_RBCPR_CLK					18
+#define GCC_DDRSS_GPU_AXI_CLK					19
+#define GCC_DISP_AHB_CLK					20
+#define GCC_DISP_HF_AXI_CLK					21
+#define GCC_DISP_SF_AXI_CLK					22
+#define GCC_DISP_XO_CLK						23
+#define GCC_EMAC_AXI_CLK					24
+#define GCC_EMAC_PTP_CLK					25
+#define GCC_EMAC_PTP_CLK_SRC					26
+#define GCC_EMAC_RGMII_CLK					27
+#define GCC_EMAC_RGMII_CLK_SRC					28
+#define GCC_EMAC_SLV_AHB_CLK					29
+#define GCC_GP1_CLK						30
+#define GCC_GP1_CLK_SRC						31
+#define GCC_GP2_CLK						32
+#define GCC_GP2_CLK_SRC						33
+#define GCC_GP3_CLK						34
+#define GCC_GP3_CLK_SRC						35
+#define GCC_GPU_CFG_AHB_CLK					36
+#define GCC_GPU_GPLL0_CLK_SRC					37
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				38
+#define GCC_GPU_IREF_CLK					39
+#define GCC_GPU_MEMNOC_GFX_CLK					40
+#define GCC_GPU_SNOC_DVM_GFX_CLK				41
+#define GCC_NPU_AT_CLK						42
+#define GCC_NPU_AXI_CLK						43
+#define GCC_NPU_CFG_AHB_CLK					44
+#define GCC_NPU_GPLL0_CLK_SRC					45
+#define GCC_NPU_GPLL0_DIV_CLK_SRC				46
+#define GCC_NPU_TRIG_CLK					47
+#define GCC_PCIE0_PHY_REFGEN_CLK				48
+#define GCC_PCIE1_PHY_REFGEN_CLK				49
+#define GCC_PCIE_0_AUX_CLK					50
+#define GCC_PCIE_0_AUX_CLK_SRC					51
+#define GCC_PCIE_0_CFG_AHB_CLK					52
+#define GCC_PCIE_0_CLKREF_CLK					53
+#define GCC_PCIE_0_MSTR_AXI_CLK					54
+#define GCC_PCIE_0_PIPE_CLK					55
+#define GCC_PCIE_0_SLV_AXI_CLK					56
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				57
+#define GCC_PCIE_1_AUX_CLK					58
+#define GCC_PCIE_1_AUX_CLK_SRC					59
+#define GCC_PCIE_1_CFG_AHB_CLK					60
+#define GCC_PCIE_1_CLKREF_CLK					61
+#define GCC_PCIE_1_MSTR_AXI_CLK					62
+#define GCC_PCIE_1_PIPE_CLK					63
+#define GCC_PCIE_1_SLV_AXI_CLK					64
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				65
+#define GCC_PCIE_PHY_AUX_CLK					66
+#define GCC_PCIE_PHY_REFGEN_CLK_SRC				67
+#define GCC_PDM2_CLK						68
+#define GCC_PDM2_CLK_SRC					69
+#define GCC_PDM_AHB_CLK						70
+#define GCC_PDM_XO4_CLK						71
+#define GCC_PRNG_AHB_CLK					72
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				73
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				74
+#define GCC_QMIP_DISP_AHB_CLK					75
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				76
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				77
+#define GCC_QSPI_CNOC_PERIPH_AHB_CLK				78
+#define GCC_QSPI_CORE_CLK					79
+#define GCC_QSPI_CORE_CLK_SRC					80
+#define GCC_QUPV3_WRAP0_S0_CLK					81
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				82
+#define GCC_QUPV3_WRAP0_S1_CLK					83
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				84
+#define GCC_QUPV3_WRAP0_S2_CLK					85
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				86
+#define GCC_QUPV3_WRAP0_S3_CLK					87
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				88
+#define GCC_QUPV3_WRAP0_S4_CLK					89
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				90
+#define GCC_QUPV3_WRAP0_S5_CLK					91
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				92
+#define GCC_QUPV3_WRAP0_S6_CLK					93
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC				94
+#define GCC_QUPV3_WRAP0_S7_CLK					95
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC				96
+#define GCC_QUPV3_WRAP1_S0_CLK					97
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				98
+#define GCC_QUPV3_WRAP1_S1_CLK					99
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				100
+#define GCC_QUPV3_WRAP1_S2_CLK					101
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				102
+#define GCC_QUPV3_WRAP1_S3_CLK					103
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				104
+#define GCC_QUPV3_WRAP1_S4_CLK					105
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				106
+#define GCC_QUPV3_WRAP1_S5_CLK					107
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				108
+#define GCC_QUPV3_WRAP2_S0_CLK					109
+#define GCC_QUPV3_WRAP2_S0_CLK_SRC				110
+#define GCC_QUPV3_WRAP2_S1_CLK					111
+#define GCC_QUPV3_WRAP2_S1_CLK_SRC				112
+#define GCC_QUPV3_WRAP2_S2_CLK					113
+#define GCC_QUPV3_WRAP2_S2_CLK_SRC				114
+#define GCC_QUPV3_WRAP2_S3_CLK					115
+#define GCC_QUPV3_WRAP2_S3_CLK_SRC				116
+#define GCC_QUPV3_WRAP2_S4_CLK					117
+#define GCC_QUPV3_WRAP2_S4_CLK_SRC				118
+#define GCC_QUPV3_WRAP2_S5_CLK					119
+#define GCC_QUPV3_WRAP2_S5_CLK_SRC				120
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				121
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				122
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				123
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				124
+#define GCC_QUPV3_WRAP_2_M_AHB_CLK				125
+#define GCC_QUPV3_WRAP_2_S_AHB_CLK				126
+#define GCC_SDCC2_AHB_CLK					127
+#define GCC_SDCC2_APPS_CLK					128
+#define GCC_SDCC2_APPS_CLK_SRC					129
+#define GCC_SDCC4_AHB_CLK					130
+#define GCC_SDCC4_APPS_CLK					131
+#define GCC_SDCC4_APPS_CLK_SRC					132
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				133
+#define GCC_TSIF_AHB_CLK					134
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK				135
+#define GCC_TSIF_REF_CLK					136
+#define GCC_TSIF_REF_CLK_SRC					137
+#define GCC_UFS_CARD_AHB_CLK					138
+#define GCC_UFS_CARD_AXI_CLK					139
+#define GCC_UFS_CARD_AXI_CLK_SRC				140
+#define GCC_UFS_CARD_AXI_HW_CTL_CLK				141
+#define GCC_UFS_CARD_CLKREF_CLK					142
+#define GCC_UFS_CARD_ICE_CORE_CLK				143
+#define GCC_UFS_CARD_ICE_CORE_CLK_SRC				144
+#define GCC_UFS_CARD_ICE_CORE_HW_CTL_CLK			145
+#define GCC_UFS_CARD_PHY_AUX_CLK				146
+#define GCC_UFS_CARD_PHY_AUX_CLK_SRC				147
+#define GCC_UFS_CARD_PHY_AUX_HW_CTL_CLK				148
+#define GCC_UFS_CARD_RX_SYMBOL_0_CLK				149
+#define GCC_UFS_CARD_RX_SYMBOL_1_CLK				150
+#define GCC_UFS_CARD_TX_SYMBOL_0_CLK				151
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK				152
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC			153
+#define GCC_UFS_CARD_UNIPRO_CORE_HW_CTL_CLK			154
+#define GCC_UFS_MEM_CLKREF_CLK					155
+#define GCC_UFS_PHY_AHB_CLK					156
+#define GCC_UFS_PHY_AXI_CLK					157
+#define GCC_UFS_PHY_AXI_CLK_SRC					158
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK				159
+#define GCC_UFS_PHY_ICE_CORE_CLK				160
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				161
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK				162
+#define GCC_UFS_PHY_PHY_AUX_CLK					163
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				164
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				165
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				166
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				167
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				168
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				169
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				170
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			171
+#define GCC_USB30_PRIM_MASTER_CLK				172
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				173
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				174
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			175
+#define GCC_USB30_PRIM_SLEEP_CLK				176
+#define GCC_USB30_SEC_MASTER_CLK				177
+#define GCC_USB30_SEC_MASTER_CLK_SRC				178
+#define GCC_USB30_SEC_MOCK_UTMI_CLK				179
+#define GCC_USB30_SEC_MOCK_UTMI_CLK_SRC				180
+#define GCC_USB30_SEC_SLEEP_CLK					181
+#define GCC_USB3_PRIM_CLKREF_CLK				182
+#define GCC_USB3_PRIM_PHY_AUX_CLK				183
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				184
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				185
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				186
+#define GCC_USB3_SEC_CLKREF_CLK					187
+#define GCC_USB3_SEC_PHY_AUX_CLK				188
+#define GCC_USB3_SEC_PHY_AUX_CLK_SRC				189
+#define GCC_USB3_SEC_PHY_COM_AUX_CLK				190
+#define GCC_USB3_SEC_PHY_PIPE_CLK				191
+#define GCC_VIDEO_AHB_CLK					192
+#define GCC_VIDEO_AXI0_CLK					193
+#define GCC_VIDEO_AXI1_CLK					194
+#define GCC_VIDEO_AXIC_CLK					195
+#define GCC_VIDEO_XO_CLK					196
+#define GPLL0							197
+#define GPLL0_OUT_EVEN						198
+#define GPLL7							199
+#define GPLL9							200
+
+/* Reset clocks */
+#define GCC_EMAC_BCR						0
+#define GCC_GPU_BCR						1
+#define GCC_MMSS_BCR						2
+#define GCC_NPU_BCR						3
+#define GCC_PCIE_0_BCR						4
+#define GCC_PCIE_0_PHY_BCR					5
+#define GCC_PCIE_1_BCR						6
+#define GCC_PCIE_1_PHY_BCR					7
+#define GCC_PCIE_PHY_BCR					8
+#define GCC_PDM_BCR						9
+#define GCC_PRNG_BCR						10
+#define GCC_QSPI_BCR						11
+#define GCC_QUPV3_WRAPPER_0_BCR					12
+#define GCC_QUPV3_WRAPPER_1_BCR					13
+#define GCC_QUPV3_WRAPPER_2_BCR					14
+#define GCC_QUSB2PHY_PRIM_BCR					15
+#define GCC_QUSB2PHY_SEC_BCR					16
+#define GCC_USB3_PHY_PRIM_BCR					17
+#define GCC_USB3_DP_PHY_PRIM_BCR				18
+#define GCC_USB3_PHY_SEC_BCR					19
+#define GCC_USB3PHY_PHY_SEC_BCR					20
+#define GCC_SDCC2_BCR						21
+#define GCC_SDCC4_BCR						22
+#define GCC_TSIF_BCR						23
+#define GCC_UFS_CARD_BCR					24
+#define GCC_UFS_PHY_BCR						25
+#define GCC_USB30_PRIM_BCR					26
+#define GCC_USB30_SEC_BCR					27
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				28
+
+/* GCC GDSCRs */
+#define PCIE_0_GDSC						0
+#define PCIE_1_GDSC						1
+#define UFS_CARD_GDSC						2
+#define UFS_PHY_GDSC						3
+#define USB30_PRIM_GDSC                     4
+#define USB30_SEC_GDSC						5
+#define EMAC_GDSC						6
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8150.h b/include/dt-bin=
dings/clock/qcom,gpucc-sm8150.h
new file mode 100644
index 0000000000..c5b70aad77
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm8150.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8150_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8150_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_AHB_CLK				0
+#define GPU_CC_CRC_AHB_CLK			1
+#define GPU_CC_CX_APB_CLK			2
+#define GPU_CC_CX_GMU_CLK			3
+#define GPU_CC_CX_SNOC_DVM_CLK			4
+#define GPU_CC_CXO_AON_CLK			5
+#define GPU_CC_CXO_CLK				6
+#define GPU_CC_GMU_CLK_SRC			7
+#define GPU_CC_GX_GMU_CLK			8
+#define GPU_CC_PLL1				9
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_CX_BCR			0
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		1
+#define GPUCC_GPU_CC_GMU_BCR			2
+#define GPUCC_GPU_CC_GX_BCR			3
+#define GPUCC_GPU_CC_SPDM_BCR			4
+#define GPUCC_GPU_CC_XO_BCR			5
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/cl=
ock/qcom,rpmh.h
new file mode 100644
index 0000000000..0a7d1be0d1
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved. */
+
+
+#ifndef _DT_BINDINGS_CLK_MSM_RPMH_H
+#define _DT_BINDINGS_CLK_MSM_RPMH_H
+
+/* RPMh controlled clocks */
+#define RPMH_CXO_CLK				0
+#define RPMH_CXO_CLK_A				1
+#define RPMH_LN_BB_CLK2				2
+#define RPMH_LN_BB_CLK2_A			3
+#define RPMH_LN_BB_CLK3				4
+#define RPMH_LN_BB_CLK3_A			5
+#define RPMH_RF_CLK1				6
+#define RPMH_RF_CLK1_A				7
+#define RPMH_RF_CLK2				8
+#define RPMH_RF_CLK2_A				9
+#define RPMH_RF_CLK3				10
+#define RPMH_RF_CLK3_A				11
+#define RPMH_IPA_CLK				12
+#define RPMH_LN_BB_CLK1				13
+#define RPMH_LN_BB_CLK1_A			14
+#define RPMH_CE_CLK				15
+#define RPMH_QPIC_CLK				16
+#define RPMH_DIV_CLK1				17
+#define RPMH_DIV_CLK1_A				18
+#define RPMH_RF_CLK4				19
+#define RPMH_RF_CLK4_A				20
+#define RPMH_RF_CLK5				21
+#define RPMH_RF_CLK5_A				22
+#define RPMH_PKA_CLK				23
+#define RPMH_HWKM_CLK				24
+#define RPMH_QLINK_CLK				25
+#define RPMH_QLINK_CLK_A			26
+
+#endif
diff --git a/include/dt-bindings/dma/qcom-gpi.h b/include/dt-bindings/dma/q=
com-gpi.h
new file mode 100644
index 0000000000..ebda2a37f5
--- /dev/null
+++ b/include/dt-bindings/dma/qcom-gpi.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright (c) 2020, Linaro Ltd.  */
+
+#ifndef __DT_BINDINGS_DMA_QCOM_GPI_H__
+#define __DT_BINDINGS_DMA_QCOM_GPI_H__
+
+#define QCOM_GPI_SPI		1
+#define QCOM_GPI_UART		2
+#define QCOM_GPI_I2C		3
+
+#endif /* __DT_BINDINGS_DMA_QCOM_GPI_H__ */
diff --git a/include/dt-bindings/firmware/qcom,scm.h b/include/dt-bindings/=
firmware/qcom,scm.h
new file mode 100644
index 0000000000..6de8b08e1e
--- /dev/null
+++ b/include/dt-bindings/firmware/qcom,scm.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights res=
erved.
+ * Copyright (C) 2015 Linaro Ltd.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved=
.
+ */
+
+#ifndef _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+#define _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+
+#define QCOM_SCM_VMID_TZ		0x1
+#define QCOM_SCM_VMID_HLOS		0x3
+#define QCOM_SCM_VMID_SSC_Q6		0x5
+#define QCOM_SCM_VMID_ADSP_Q6		0x6
+#define QCOM_SCM_VMID_CP_TOUCH		0x8
+#define QCOM_SCM_VMID_CP_BITSTREAM	0x9
+#define QCOM_SCM_VMID_CP_PIXEL		0xA
+#define QCOM_SCM_VMID_CP_NON_PIXEL	0xB
+#define QCOM_SCM_VMID_CP_CAMERA		0xD
+#define QCOM_SCM_VMID_HLOS_FREE		0xE
+#define QCOM_SCM_VMID_MSS_MSA		0xF
+#define QCOM_SCM_VMID_MSS_NONMSA	0x10
+#define QCOM_SCM_VMID_CP_SEC_DISPLAY	0x11
+#define QCOM_SCM_VMID_CP_APP		0x12
+#define QCOM_SCM_VMID_LPASS		0x16
+#define QCOM_SCM_VMID_WLAN		0x18
+#define QCOM_SCM_VMID_WLAN_CE		0x19
+#define QCOM_SCM_VMID_CP_SPSS_SP	0x1A
+#define QCOM_SCM_VMID_CP_CAMERA_PREVIEW 0x1D
+#define QCOM_SCM_VMID_CDSP		0x1E
+#define QCOM_SCM_VMID_CP_SPSS_SP_SHARED 0x22
+#define QCOM_SCM_VMID_CP_SPSS_HLOS_SHARED 0x24
+#define QCOM_SCM_VMID_ADSP_HEAP		0x25
+#define QCOM_SCM_VMID_CP_CDSP		0x2A
+#define QCOM_SCM_VMID_NAV		0x2B
+#define QCOM_SCM_VMID_TVM		0x2D
+#define QCOM_SCM_VMID_OEMVM		0x31
+
+#endif
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings=
/iio/qcom,spmi-vadc.h
new file mode 100644
index 0000000000..ef07ecd4d5
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights rese=
rved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_H
+
+/* Voltage ADC channels */
+#define VADC_USBIN				0x00
+#define VADC_DCIN				0x01
+#define VADC_VCHG_SNS				0x02
+#define VADC_SPARE1_03				0x03
+#define VADC_USB_ID_MV				0x04
+#define VADC_VCOIN				0x05
+#define VADC_VBAT_SNS				0x06
+#define VADC_VSYS				0x07
+#define VADC_DIE_TEMP				0x08
+#define VADC_REF_625MV				0x09
+#define VADC_REF_1250MV				0x0a
+#define VADC_CHG_TEMP				0x0b
+#define VADC_SPARE1				0x0c
+#define VADC_SPARE2				0x0d
+#define VADC_GND_REF				0x0e
+#define VADC_VDD_VADC				0x0f
+
+#define VADC_P_MUX1_1_1				0x10
+#define VADC_P_MUX2_1_1				0x11
+#define VADC_P_MUX3_1_1				0x12
+#define VADC_P_MUX4_1_1				0x13
+#define VADC_P_MUX5_1_1				0x14
+#define VADC_P_MUX6_1_1				0x15
+#define VADC_P_MUX7_1_1				0x16
+#define VADC_P_MUX8_1_1				0x17
+#define VADC_P_MUX9_1_1				0x18
+#define VADC_P_MUX10_1_1			0x19
+#define VADC_P_MUX11_1_1			0x1a
+#define VADC_P_MUX12_1_1			0x1b
+#define VADC_P_MUX13_1_1			0x1c
+#define VADC_P_MUX14_1_1			0x1d
+#define VADC_P_MUX15_1_1			0x1e
+#define VADC_P_MUX16_1_1			0x1f
+
+#define VADC_P_MUX1_1_3				0x20
+#define VADC_P_MUX2_1_3				0x21
+#define VADC_P_MUX3_1_3				0x22
+#define VADC_P_MUX4_1_3				0x23
+#define VADC_P_MUX5_1_3				0x24
+#define VADC_P_MUX6_1_3				0x25
+#define VADC_P_MUX7_1_3				0x26
+#define VADC_P_MUX8_1_3				0x27
+#define VADC_P_MUX9_1_3				0x28
+#define VADC_P_MUX10_1_3			0x29
+#define VADC_P_MUX11_1_3			0x2a
+#define VADC_P_MUX12_1_3			0x2b
+#define VADC_P_MUX13_1_3			0x2c
+#define VADC_P_MUX14_1_3			0x2d
+#define VADC_P_MUX15_1_3			0x2e
+#define VADC_P_MUX16_1_3			0x2f
+
+#define VADC_LR_MUX1_BAT_THERM			0x30
+#define VADC_LR_MUX2_BAT_ID			0x31
+#define VADC_LR_MUX3_XO_THERM			0x32
+#define VADC_LR_MUX4_AMUX_THM1			0x33
+#define VADC_LR_MUX5_AMUX_THM2			0x34
+#define VADC_LR_MUX6_AMUX_THM3			0x35
+#define VADC_LR_MUX7_HW_ID			0x36
+#define VADC_LR_MUX8_AMUX_THM4			0x37
+#define VADC_LR_MUX9_AMUX_THM5			0x38
+#define VADC_LR_MUX10_USB_ID			0x39
+#define VADC_AMUX_PU1				0x3a
+#define VADC_AMUX_PU2				0x3b
+#define VADC_LR_MUX3_BUF_XO_THERM		0x3c
+
+#define VADC_LR_MUX1_PU1_BAT_THERM		0x70
+#define VADC_LR_MUX2_PU1_BAT_ID			0x71
+#define VADC_LR_MUX3_PU1_XO_THERM		0x72
+#define VADC_LR_MUX4_PU1_AMUX_THM1		0x73
+#define VADC_LR_MUX5_PU1_AMUX_THM2		0x74
+#define VADC_LR_MUX6_PU1_AMUX_THM3		0x75
+#define VADC_LR_MUX7_PU1_AMUX_HW_ID		0x76
+#define VADC_LR_MUX8_PU1_AMUX_THM4		0x77
+#define VADC_LR_MUX9_PU1_AMUX_THM5		0x78
+#define VADC_LR_MUX10_PU1_AMUX_USB_ID		0x79
+#define VADC_LR_MUX3_BUF_PU1_XO_THERM		0x7c
+
+#define VADC_LR_MUX1_PU2_BAT_THERM		0xb0
+#define VADC_LR_MUX2_PU2_BAT_ID			0xb1
+#define VADC_LR_MUX3_PU2_XO_THERM		0xb2
+#define VADC_LR_MUX4_PU2_AMUX_THM1		0xb3
+#define VADC_LR_MUX5_PU2_AMUX_THM2		0xb4
+#define VADC_LR_MUX6_PU2_AMUX_THM3		0xb5
+#define VADC_LR_MUX7_PU2_AMUX_HW_ID		0xb6
+#define VADC_LR_MUX8_PU2_AMUX_THM4		0xb7
+#define VADC_LR_MUX9_PU2_AMUX_THM5		0xb8
+#define VADC_LR_MUX10_PU2_AMUX_USB_ID		0xb9
+#define VADC_LR_MUX3_BUF_PU2_XO_THERM		0xbc
+
+#define VADC_LR_MUX1_PU1_PU2_BAT_THERM		0xf0
+#define VADC_LR_MUX2_PU1_PU2_BAT_ID		0xf1
+#define VADC_LR_MUX3_PU1_PU2_XO_THERM		0xf2
+#define VADC_LR_MUX4_PU1_PU2_AMUX_THM1		0xf3
+#define VADC_LR_MUX5_PU1_PU2_AMUX_THM2		0xf4
+#define VADC_LR_MUX6_PU1_PU2_AMUX_THM3		0xf5
+#define VADC_LR_MUX7_PU1_PU2_AMUX_HW_ID		0xf6
+#define VADC_LR_MUX8_PU1_PU2_AMUX_THM4		0xf7
+#define VADC_LR_MUX9_PU1_PU2_AMUX_THM5		0xf8
+#define VADC_LR_MUX10_PU1_PU2_AMUX_USB_ID	0xf9
+#define VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM	0xfc
+
+/* ADC channels for SPMI PMIC5 */
+
+#define ADC5_REF_GND				0x00
+#define ADC5_1P25VREF				0x01
+#define ADC5_VREF_VADC				0x02
+#define ADC5_VREF_VADC5_DIV_3			0x82
+#define ADC5_VPH_PWR				0x83
+#define ADC5_VBAT_SNS				0x84
+#define ADC5_VCOIN				0x85
+#define ADC5_DIE_TEMP				0x06
+#define ADC5_USB_IN_I				0x07
+#define ADC5_USB_IN_V_16			0x08
+#define ADC5_CHG_TEMP				0x09
+#define ADC5_BAT_THERM				0x0a
+#define ADC5_BAT_ID				0x0b
+#define ADC5_XO_THERM				0x0c
+#define ADC5_AMUX_THM1				0x0d
+#define ADC5_AMUX_THM2				0x0e
+#define ADC5_AMUX_THM3				0x0f
+#define ADC5_AMUX_THM4				0x10
+#define ADC5_AMUX_THM5				0x11
+#define ADC5_GPIO1				0x12
+#define ADC5_GPIO2				0x13
+#define ADC5_GPIO3				0x14
+#define ADC5_GPIO4				0x15
+#define ADC5_GPIO5				0x16
+#define ADC5_GPIO6				0x17
+#define ADC5_GPIO7				0x18
+#define ADC5_SBUx				0x99
+#define ADC5_MID_CHG_DIV6			0x1e
+#define ADC5_OFF				0xff
+
+/* 30k pull-up1 */
+#define ADC5_BAT_THERM_30K_PU			0x2a
+#define ADC5_BAT_ID_30K_PU			0x2b
+#define ADC5_XO_THERM_30K_PU			0x2c
+#define ADC5_AMUX_THM1_30K_PU			0x2d
+#define ADC5_AMUX_THM2_30K_PU			0x2e
+#define ADC5_AMUX_THM3_30K_PU			0x2f
+#define ADC5_AMUX_THM4_30K_PU			0x30
+#define ADC5_AMUX_THM5_30K_PU			0x31
+#define ADC5_GPIO1_30K_PU			0x32
+#define ADC5_GPIO2_30K_PU			0x33
+#define ADC5_GPIO3_30K_PU			0x34
+#define ADC5_GPIO4_30K_PU			0x35
+#define ADC5_GPIO5_30K_PU			0x36
+#define ADC5_GPIO6_30K_PU			0x37
+#define ADC5_GPIO7_30K_PU			0x38
+#define ADC5_SBUx_30K_PU			0x39
+
+/* 100k pull-up2 */
+#define ADC5_BAT_THERM_100K_PU			0x4a
+#define ADC5_BAT_ID_100K_PU			0x4b
+#define ADC5_XO_THERM_100K_PU			0x4c
+#define ADC5_AMUX_THM1_100K_PU			0x4d
+#define ADC5_AMUX_THM2_100K_PU			0x4e
+#define ADC5_AMUX_THM3_100K_PU			0x4f
+#define ADC5_AMUX_THM4_100K_PU			0x50
+#define ADC5_AMUX_THM5_100K_PU			0x51
+#define ADC5_GPIO1_100K_PU			0x52
+#define ADC5_GPIO2_100K_PU			0x53
+#define ADC5_GPIO3_100K_PU			0x54
+#define ADC5_GPIO4_100K_PU			0x55
+#define ADC5_GPIO5_100K_PU			0x56
+#define ADC5_GPIO6_100K_PU			0x57
+#define ADC5_GPIO7_100K_PU			0x58
+#define ADC5_SBUx_100K_PU			0x59
+
+/* 400k pull-up3 */
+#define ADC5_BAT_THERM_400K_PU			0x6a
+#define ADC5_BAT_ID_400K_PU			0x6b
+#define ADC5_XO_THERM_400K_PU			0x6c
+#define ADC5_AMUX_THM1_400K_PU			0x6d
+#define ADC5_AMUX_THM2_400K_PU			0x6e
+#define ADC5_AMUX_THM3_400K_PU			0x6f
+#define ADC5_AMUX_THM4_400K_PU			0x70
+#define ADC5_AMUX_THM5_400K_PU			0x71
+#define ADC5_GPIO1_400K_PU			0x72
+#define ADC5_GPIO2_400K_PU			0x73
+#define ADC5_GPIO3_400K_PU			0x74
+#define ADC5_GPIO4_400K_PU			0x75
+#define ADC5_GPIO5_400K_PU			0x76
+#define ADC5_GPIO6_400K_PU			0x77
+#define ADC5_GPIO7_400K_PU			0x78
+#define ADC5_SBUx_400K_PU			0x79
+
+/* 1/3 Divider */
+#define ADC5_GPIO1_DIV3				0x92
+#define ADC5_GPIO2_DIV3				0x93
+#define ADC5_GPIO3_DIV3				0x94
+#define ADC5_GPIO4_DIV3				0x95
+#define ADC5_GPIO5_DIV3				0x96
+#define ADC5_GPIO6_DIV3				0x97
+#define ADC5_GPIO7_DIV3				0x98
+#define ADC5_SBUx_DIV3				0x99
+
+/* Current and combined current/voltage channels */
+#define ADC5_INT_EXT_ISENSE			0xa1
+#define ADC5_PARALLEL_ISENSE			0xa5
+#define ADC5_CUR_REPLICA_VDS			0xa7
+#define ADC5_CUR_SENS_BATFET_VDS_OFFSET		0xa9
+#define ADC5_CUR_SENS_REPLICA_VDS_OFFSET	0xab
+#define ADC5_EXT_SENS_OFFSET			0xad
+
+#define ADC5_INT_EXT_ISENSE_VBAT_VDATA		0xb0
+#define ADC5_INT_EXT_ISENSE_VBAT_IDATA		0xb1
+#define ADC5_EXT_ISENSE_VBAT_VDATA		0xb2
+#define ADC5_EXT_ISENSE_VBAT_IDATA		0xb3
+#define ADC5_PARALLEL_ISENSE_VBAT_VDATA		0xb4
+#define ADC5_PARALLEL_ISENSE_VBAT_IDATA		0xb5
+
+#define ADC5_MAX_CHANNEL			0xc0
+
+/* ADC channels for ADC for PMIC7 */
+
+#define ADC7_REF_GND				0x00
+#define ADC7_1P25VREF				0x01
+#define ADC7_VREF_VADC				0x02
+#define ADC7_DIE_TEMP				0x03
+
+#define ADC7_AMUX_THM1				0x04
+#define ADC7_AMUX_THM2				0x05
+#define ADC7_AMUX_THM3				0x06
+#define ADC7_AMUX_THM4				0x07
+#define ADC7_AMUX_THM5				0x08
+#define ADC7_AMUX_THM6				0x09
+#define ADC7_GPIO1				0x0a
+#define ADC7_GPIO2				0x0b
+#define ADC7_GPIO3				0x0c
+#define ADC7_GPIO4				0x0d
+
+#define ADC7_SMB_TEMP				0x06
+#define ADC7_CHG_TEMP				0x10
+#define ADC7_USB_IN_V_16			0x11
+#define ADC7_VDC_16				0x12
+#define ADC7_CC1_ID				0x13
+#define ADC7_VREF_BAT_THERM			0x15
+#define ADC7_IIN_FB				0x17
+#define ADC7_ICHG_SMB				0x18
+#define ADC7_IIN_SMB				0x19
+
+/* 30k pull-up1 */
+#define ADC7_AMUX_THM1_30K_PU			0x24
+#define ADC7_AMUX_THM2_30K_PU			0x25
+#define ADC7_AMUX_THM3_30K_PU			0x26
+#define ADC7_AMUX_THM4_30K_PU			0x27
+#define ADC7_AMUX_THM5_30K_PU			0x28
+#define ADC7_AMUX_THM6_30K_PU			0x29
+#define ADC7_GPIO1_30K_PU			0x2a
+#define ADC7_GPIO2_30K_PU			0x2b
+#define ADC7_GPIO3_30K_PU			0x2c
+#define ADC7_GPIO4_30K_PU			0x2d
+#define ADC7_CC1_ID_30K_PU			0x33
+
+/* 100k pull-up2 */
+#define ADC7_AMUX_THM1_100K_PU			0x44
+#define ADC7_AMUX_THM2_100K_PU			0x45
+#define ADC7_AMUX_THM3_100K_PU			0x46
+#define ADC7_AMUX_THM4_100K_PU			0x47
+#define ADC7_AMUX_THM5_100K_PU			0x48
+#define ADC7_AMUX_THM6_100K_PU			0x49
+#define ADC7_GPIO1_100K_PU			0x4a
+#define ADC7_GPIO2_100K_PU			0x4b
+#define ADC7_GPIO3_100K_PU			0x4c
+#define ADC7_GPIO4_100K_PU			0x4d
+#define ADC7_CC1_ID_100K_PU			0x53
+
+/* 400k pull-up3 */
+#define ADC7_AMUX_THM1_400K_PU			0x64
+#define ADC7_AMUX_THM2_400K_PU			0x65
+#define ADC7_AMUX_THM3_400K_PU			0x66
+#define ADC7_AMUX_THM4_400K_PU			0x67
+#define ADC7_AMUX_THM5_400K_PU			0x68
+#define ADC7_AMUX_THM6_400K_PU			0x69
+#define ADC7_GPIO1_400K_PU			0x6a
+#define ADC7_GPIO2_400K_PU			0x6b
+#define ADC7_GPIO3_400K_PU			0x6c
+#define ADC7_GPIO4_400K_PU			0x6d
+#define ADC7_CC1_ID_400K_PU			0x73
+
+/* 1/3 Divider */
+#define ADC7_GPIO1_DIV3				0x8a
+#define ADC7_GPIO2_DIV3				0x8b
+#define ADC7_GPIO3_DIV3				0x8c
+#define ADC7_GPIO4_DIV3				0x8d
+
+#define ADC7_VPH_PWR				0x8e
+#define ADC7_VBAT_SNS				0x8f
+
+#define ADC7_SBUx				0x94
+#define ADC7_VBAT_2S_MID			0x96
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h b/include/dt-bi=
ndings/interconnect/qcom,osm-l3.h
new file mode 100644
index 0000000000..61ef649ae5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
+
+#define MASTER_OSM_L3_APPS	0
+#define SLAVE_OSM_L3		1
+
+#define MASTER_EPSS_L3_APPS	0
+#define SLAVE_EPSS_L3_SHARED	1
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,sm8150.h b/include/dt-bi=
ndings/interconnect/qcom,sm8150.h
new file mode 100644
index 0000000000..ef292791f5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8150.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SM8150 interconnect IDs
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8150_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8150_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_QUP_0			1
+#define MASTER_EMAC			2
+#define MASTER_UFS_MEM			3
+#define MASTER_USB3			4
+#define MASTER_USB3_1			5
+#define A1NOC_SNOC_SLV			6
+#define SLAVE_SERVICE_A1NOC		7
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QSPI			2
+#define MASTER_QUP_1			3
+#define MASTER_QUP_2			4
+#define MASTER_SENSORS_AHB		5
+#define MASTER_TSIF			6
+#define MASTER_CNOC_A2NOC		7
+#define MASTER_CRYPTO_CORE_0		8
+#define MASTER_IPA			9
+#define MASTER_PCIE			10
+#define MASTER_PCIE_1			11
+#define MASTER_QDSS_ETR			12
+#define MASTER_SDCC_2			13
+#define MASTER_SDCC_4			14
+#define A2NOC_SNOC_SLV			15
+#define SLAVE_ANOC_PCIE_GEM_NOC		16
+#define SLAVE_SERVICE_A2NOC		17
+
+#define MASTER_CAMNOC_HF0_UNCOMP	0
+#define MASTER_CAMNOC_HF1_UNCOMP	1
+#define MASTER_CAMNOC_SF_UNCOMP		2
+#define SLAVE_CAMNOC_UNCOMP		3
+
+#define MASTER_NPU			0
+#define SLAVE_CDSP_MEM_NOC		1
+
+#define MASTER_SPDM			0
+#define SNOC_CNOC_MAS			1
+#define MASTER_QDSS_DAP			2
+#define SLAVE_A1NOC_CFG			3
+#define SLAVE_A2NOC_CFG			4
+#define SLAVE_AHB2PHY_SOUTH		5
+#define SLAVE_AOP			6
+#define SLAVE_AOSS			7
+#define SLAVE_CAMERA_CFG		8
+#define SLAVE_CLK_CTL			9
+#define SLAVE_CDSP_CFG			10
+#define SLAVE_RBCPR_CX_CFG		11
+#define SLAVE_RBCPR_MMCX_CFG		12
+#define SLAVE_RBCPR_MX_CFG		13
+#define SLAVE_CRYPTO_0_CFG		14
+#define SLAVE_CNOC_DDRSS		15
+#define SLAVE_DISPLAY_CFG		16
+#define SLAVE_EMAC_CFG			17
+#define SLAVE_GLM			18
+#define SLAVE_GRAPHICS_3D_CFG		19
+#define SLAVE_IMEM_CFG			20
+#define SLAVE_IPA_CFG			21
+#define SLAVE_CNOC_MNOC_CFG		22
+#define SLAVE_NPU_CFG			23
+#define SLAVE_PCIE_0_CFG		24
+#define SLAVE_PCIE_1_CFG		25
+#define SLAVE_NORTH_PHY_CFG		26
+#define SLAVE_PIMEM_CFG			27
+#define SLAVE_PRNG			28
+#define SLAVE_QDSS_CFG			29
+#define SLAVE_QSPI			30
+#define SLAVE_QUP_2			31
+#define SLAVE_QUP_1			32
+#define SLAVE_QUP_0			33
+#define SLAVE_SDCC_2			34
+#define SLAVE_SDCC_4			35
+#define SLAVE_SNOC_CFG			36
+#define SLAVE_SPDM_WRAPPER		37
+#define SLAVE_SPSS_CFG			38
+#define SLAVE_SSC_CFG			39
+#define SLAVE_TCSR			40
+#define SLAVE_TLMM_EAST			41
+#define SLAVE_TLMM_NORTH		42
+#define SLAVE_TLMM_SOUTH		43
+#define SLAVE_TLMM_WEST			44
+#define SLAVE_TSIF			45
+#define SLAVE_UFS_CARD_CFG		46
+#define SLAVE_UFS_MEM_CFG		47
+#define SLAVE_USB3			48
+#define SLAVE_USB3_1			49
+#define SLAVE_VENUS_CFG			50
+#define SLAVE_VSENSE_CTRL_CFG		51
+#define SLAVE_CNOC_A2NOC		52
+#define SLAVE_SERVICE_CNOC		53
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_GEM_NOC_CFG		2
+
+#define MASTER_AMPSS_M0			0
+#define MASTER_GPU_TCU			1
+#define MASTER_SYS_TCU			2
+#define MASTER_GEM_NOC_CFG		3
+#define MASTER_COMPUTE_NOC		4
+#define MASTER_GRAPHICS_3D		5
+#define MASTER_MNOC_HF_MEM_NOC		6
+#define MASTER_MNOC_SF_MEM_NOC		7
+#define MASTER_GEM_NOC_PCIE_SNOC	8
+#define MASTER_SNOC_GC_MEM_NOC		9
+#define MASTER_SNOC_SF_MEM_NOC		10
+#define MASTER_ECC			11
+#define SLAVE_MSS_PROC_MS_MPU_CFG	12
+#define SLAVE_ECC			13
+#define SLAVE_GEM_NOC_SNOC		14
+#define SLAVE_LLCC			15
+#define SLAVE_SERVICE_GEM_NOC		16
+
+#define MASTER_LLCC			0
+#define SLAVE_EBI_CH0			1
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_HF0		1
+#define MASTER_CAMNOC_HF1		2
+#define MASTER_CAMNOC_SF		3
+#define MASTER_MDP_PORT0		4
+#define MASTER_MDP_PORT1		5
+#define MASTER_ROTATOR			6
+#define MASTER_VIDEO_P0			7
+#define MASTER_VIDEO_P1			8
+#define MASTER_VIDEO_PROC		9
+#define SLAVE_MNOC_SF_MEM_NOC		10
+#define SLAVE_MNOC_HF_MEM_NOC		11
+#define SLAVE_SERVICE_MNOC		12
+
+#define MASTER_SNOC_CFG			0
+#define A1NOC_SNOC_MAS			1
+#define A2NOC_SNOC_MAS			2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_PIMEM			4
+#define MASTER_GIC			5
+#define SLAVE_APPSS			6
+#define SNOC_CNOC_SLV			7
+#define SLAVE_SNOC_GEM_NOC_GC		8
+#define SLAVE_SNOC_GEM_NOC_SF		9
+#define SLAVE_OCIMEM			10
+#define SLAVE_PIMEM			11
+#define SLAVE_SERVICE_SNOC		12
+#define SLAVE_PCIE_0			13
+#define SLAVE_PCIE_1			14
+#define SLAVE_QDSS_STM			15
+#define SLAVE_TCU			16
+
+#endif
diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/p=
hy/phy-qcom-qmp.h
new file mode 100644
index 0000000000..4edec4c5b2
--- /dev/null
+++ b/include/dt-bindings/phy/phy-qcom-qmp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Qualcomm QMP PHY constants
+ *
+ * Copyright (C) 2022 Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_PHY_QMP
+#define _DT_BINDINGS_PHY_QMP
+
+/* QMP USB4-USB3-DP clocks */
+#define QMP_USB43DP_USB3_PIPE_CLK	0
+#define QMP_USB43DP_DP_LINK_CLK		1
+#define QMP_USB43DP_DP_VCO_DIV_CLK	2
+
+/* QMP USB4-USB3-DP PHYs */
+#define QMP_USB43DP_USB3_PHY		0
+#define QMP_USB43DP_DP_PHY		1
+
+#endif /* _DT_BINDINGS_PHY_QMP */
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/p=
ower/qcom-rpmpd.h
new file mode 100644
index 0000000000..7f4e2983a4
--- /dev/null
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -0,0 +1,412 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
+#define _DT_BINDINGS_POWER_QCOM_RPMPD_H
+
+/* SA8775P Power Domain Indexes */
+#define SA8775P_CX	0
+#define SA8775P_CX_AO	1
+#define SA8775P_DDR	2
+#define SA8775P_EBI	3
+#define SA8775P_GFX	4
+#define SA8775P_LCX	5
+#define SA8775P_LMX	6
+#define SA8775P_MMCX	7
+#define SA8775P_MMCX_AO	8
+#define SA8775P_MSS	9
+#define SA8775P_MX	10
+#define SA8775P_MX_AO	11
+#define SA8775P_MXC	12
+#define SA8775P_MXC_AO	13
+#define SA8775P_NSP0	14
+#define SA8775P_NSP1	15
+#define SA8775P_XO	16
+
+/* SDM670 Power Domain Indexes */
+#define SDM670_MX	0
+#define SDM670_MX_AO	1
+#define SDM670_CX	2
+#define SDM670_CX_AO	3
+#define SDM670_LMX	4
+#define SDM670_LCX	5
+#define SDM670_GFX	6
+#define SDM670_MSS	7
+
+/* SDM845 Power Domain Indexes */
+#define SDM845_EBI	0
+#define SDM845_MX	1
+#define SDM845_MX_AO	2
+#define SDM845_CX	3
+#define SDM845_CX_AO	4
+#define SDM845_LMX	5
+#define SDM845_LCX	6
+#define SDM845_GFX	7
+#define SDM845_MSS	8
+
+/* SDX55 Power Domain Indexes */
+#define SDX55_MSS	0
+#define SDX55_MX	1
+#define SDX55_CX	2
+
+/* SDX65 Power Domain Indexes */
+#define SDX65_MSS	0
+#define SDX65_MX	1
+#define SDX65_MX_AO	2
+#define SDX65_CX	3
+#define SDX65_CX_AO	4
+#define SDX65_MXC	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6350_CX	0
+#define SM6350_GFX	1
+#define SM6350_LCX	2
+#define SM6350_LMX	3
+#define SM6350_MSS	4
+#define SM6350_MX	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6375_VDDCX		0
+#define SM6375_VDDCX_AO	1
+#define SM6375_VDDCX_VFL	2
+#define SM6375_VDDMX		3
+#define SM6375_VDDMX_AO	4
+#define SM6375_VDDMX_VFL	5
+#define SM6375_VDDGX		6
+#define SM6375_VDDGX_AO	7
+#define SM6375_VDD_LPI_CX	8
+#define SM6375_VDD_LPI_MX	9
+
+/* SM8150 Power Domain Indexes */
+#define SM8150_MSS	0
+#define SM8150_EBI	1
+#define SM8150_LMX	2
+#define SM8150_LCX	3
+#define SM8150_GFX	4
+#define SM8150_MX	5
+#define SM8150_MX_AO	6
+#define SM8150_CX	7
+#define SM8150_CX_AO	8
+#define SM8150_MMCX	9
+#define SM8150_MMCX_AO	10
+
+/* SA8155P is a special case, kept for backwards compatibility */
+#define SA8155P_CX	SM8150_CX
+#define SA8155P_CX_AO	SM8150_CX_AO
+#define SA8155P_EBI	SM8150_EBI
+#define SA8155P_GFX	SM8150_GFX
+#define SA8155P_MSS	SM8150_MSS
+#define SA8155P_MX	SM8150_MX
+#define SA8155P_MX_AO	SM8150_MX_AO
+
+/* SM8250 Power Domain Indexes */
+#define SM8250_CX	0
+#define SM8250_CX_AO	1
+#define SM8250_EBI	2
+#define SM8250_GFX	3
+#define SM8250_LCX	4
+#define SM8250_LMX	5
+#define SM8250_MMCX	6
+#define SM8250_MMCX_AO	7
+#define SM8250_MX	8
+#define SM8250_MX_AO	9
+
+/* SM8350 Power Domain Indexes */
+#define SM8350_CX	0
+#define SM8350_CX_AO	1
+#define SM8350_EBI	2
+#define SM8350_GFX	3
+#define SM8350_LCX	4
+#define SM8350_LMX	5
+#define SM8350_MMCX	6
+#define SM8350_MMCX_AO	7
+#define SM8350_MX	8
+#define SM8350_MX_AO	9
+#define SM8350_MXC	10
+#define SM8350_MXC_AO	11
+#define SM8350_MSS	12
+
+/* SM8450 Power Domain Indexes */
+#define SM8450_CX	0
+#define SM8450_CX_AO	1
+#define SM8450_EBI	2
+#define SM8450_GFX	3
+#define SM8450_LCX	4
+#define SM8450_LMX	5
+#define SM8450_MMCX	6
+#define SM8450_MMCX_AO	7
+#define SM8450_MX	8
+#define SM8450_MX_AO	9
+#define SM8450_MXC	10
+#define SM8450_MXC_AO	11
+#define SM8450_MSS	12
+
+/* SM8550 Power Domain Indexes */
+#define SM8550_CX	0
+#define SM8550_CX_AO	1
+#define SM8550_EBI	2
+#define SM8550_GFX	3
+#define SM8550_LCX	4
+#define SM8550_LMX	5
+#define SM8550_MMCX	6
+#define SM8550_MMCX_AO	7
+#define SM8550_MX	8
+#define SM8550_MX_AO	9
+#define SM8550_MXC	10
+#define SM8550_MXC_AO	11
+#define SM8550_MSS	12
+#define SM8550_NSP	13
+
+/* QDU1000/QRU1000 Power Domain Indexes */
+#define QDU1000_EBI	0
+#define QDU1000_MSS	1
+#define QDU1000_CX	2
+#define QDU1000_MX	3
+
+/* SC7180 Power Domain Indexes */
+#define SC7180_CX	0
+#define SC7180_CX_AO	1
+#define SC7180_GFX	2
+#define SC7180_MX	3
+#define SC7180_MX_AO	4
+#define SC7180_LMX	5
+#define SC7180_LCX	6
+#define SC7180_MSS	7
+
+/* SC7280 Power Domain Indexes */
+#define SC7280_CX	0
+#define SC7280_CX_AO	1
+#define SC7280_EBI	2
+#define SC7280_GFX	3
+#define SC7280_MX	4
+#define SC7280_MX_AO	5
+#define SC7280_LMX	6
+#define SC7280_LCX	7
+#define SC7280_MSS	8
+
+/* SC8180X Power Domain Indexes */
+#define SC8180X_CX	0
+#define SC8180X_CX_AO	1
+#define SC8180X_EBI	2
+#define SC8180X_GFX	3
+#define SC8180X_LCX	4
+#define SC8180X_LMX	5
+#define SC8180X_MMCX	6
+#define SC8180X_MMCX_AO	7
+#define SC8180X_MSS	8
+#define SC8180X_MX	9
+#define SC8180X_MX_AO	10
+
+/* SC8280XP Power Domain Indexes */
+#define SC8280XP_CX		0
+#define SC8280XP_CX_AO		1
+#define SC8280XP_DDR		2
+#define SC8280XP_EBI		3
+#define SC8280XP_GFX		4
+#define SC8280XP_LCX		5
+#define SC8280XP_LMX		6
+#define SC8280XP_MMCX		7
+#define SC8280XP_MMCX_AO	8
+#define SC8280XP_MSS		9
+#define SC8280XP_MX		10
+#define SC8280XP_MXC		12
+#define SC8280XP_MX_AO		11
+#define SC8280XP_NSP		13
+#define SC8280XP_QPHY		14
+#define SC8280XP_XO		15
+
+/* SDM845 Power Domain performance levels */
+#define RPMH_REGULATOR_LEVEL_RETENTION		16
+#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
+#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
+#define RPMH_REGULATOR_LEVEL_SVS		128
+#define RPMH_REGULATOR_LEVEL_SVS_L0		144
+#define RPMH_REGULATOR_LEVEL_SVS_L1		192
+#define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_NOM		256
+#define RPMH_REGULATOR_LEVEL_NOM_L0		288
+#define RPMH_REGULATOR_LEVEL_NOM_L1		320
+#define RPMH_REGULATOR_LEVEL_NOM_L2		336
+#define RPMH_REGULATOR_LEVEL_TURBO		384
+#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
+#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
+#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
+
+/* MDM9607 Power Domains */
+#define MDM9607_VDDCX		0
+#define MDM9607_VDDCX_AO	1
+#define MDM9607_VDDCX_VFL	2
+#define MDM9607_VDDMX		3
+#define MDM9607_VDDMX_AO	4
+#define MDM9607_VDDMX_VFL	5
+
+/* MSM8226 Power Domain Indexes */
+#define MSM8226_VDDCX		0
+#define MSM8226_VDDCX_AO	1
+#define MSM8226_VDDCX_VFC	2
+
+/* MSM8939 Power Domains */
+#define MSM8939_VDDMDCX		0
+#define MSM8939_VDDMDCX_AO	1
+#define MSM8939_VDDMDCX_VFC	2
+#define MSM8939_VDDCX		3
+#define MSM8939_VDDCX_AO	4
+#define MSM8939_VDDCX_VFC	5
+#define MSM8939_VDDMX		6
+#define MSM8939_VDDMX_AO	7
+
+/* MSM8916 Power Domain Indexes */
+#define MSM8916_VDDCX		0
+#define MSM8916_VDDCX_AO	1
+#define MSM8916_VDDCX_VFC	2
+#define MSM8916_VDDMX		3
+#define MSM8916_VDDMX_AO	4
+
+/* MSM8909 Power Domain Indexes */
+#define MSM8909_VDDCX		MSM8916_VDDCX
+#define MSM8909_VDDCX_AO	MSM8916_VDDCX_AO
+#define MSM8909_VDDCX_VFC	MSM8916_VDDCX_VFC
+#define MSM8909_VDDMX		MSM8916_VDDMX
+#define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
+
+/* MSM8917 Power Domain Indexes */
+#define MSM8917_VDDCX		0
+#define MSM8917_VDDCX_AO	1
+#define MSM8917_VDDCX_VFL	2
+#define MSM8917_VDDMX		3
+#define MSM8917_VDDMX_AO	4
+
+/* MSM8937 Power Domain Indexes */
+#define MSM8937_VDDCX		MSM8917_VDDCX
+#define MSM8937_VDDCX_AO	MSM8917_VDDCX_AO
+#define MSM8937_VDDCX_VFL	MSM8917_VDDCX_VFL
+#define MSM8937_VDDMX		MSM8917_VDDMX
+#define MSM8937_VDDMX_AO	MSM8917_VDDMX_AO
+
+/* QM215 Power Domain Indexes */
+#define QM215_VDDCX		MSM8917_VDDCX
+#define QM215_VDDCX_AO		MSM8917_VDDCX_AO
+#define QM215_VDDCX_VFL		MSM8917_VDDCX_VFL
+#define QM215_VDDMX		MSM8917_VDDMX
+#define QM215_VDDMX_AO		MSM8917_VDDMX_AO
+
+/* MSM8953 Power Domain Indexes */
+#define MSM8953_VDDMD		0
+#define MSM8953_VDDMD_AO	1
+#define MSM8953_VDDCX		2
+#define MSM8953_VDDCX_AO	3
+#define MSM8953_VDDCX_VFL	4
+#define MSM8953_VDDMX		5
+#define MSM8953_VDDMX_AO	6
+
+/* MSM8976 Power Domain Indexes */
+#define MSM8976_VDDCX		0
+#define MSM8976_VDDCX_AO	1
+#define MSM8976_VDDCX_VFL	2
+#define MSM8976_VDDMX		3
+#define MSM8976_VDDMX_AO	4
+#define MSM8976_VDDMX_VFL	5
+
+/* MSM8994 Power Domain Indexes */
+#define MSM8994_VDDCX		0
+#define MSM8994_VDDCX_AO	1
+#define MSM8994_VDDCX_VFC	2
+#define MSM8994_VDDMX		3
+#define MSM8994_VDDMX_AO	4
+#define MSM8994_VDDGFX		5
+#define MSM8994_VDDGFX_VFC	6
+
+/* MSM8996 Power Domain Indexes */
+#define MSM8996_VDDCX		0
+#define MSM8996_VDDCX_AO	1
+#define MSM8996_VDDCX_VFC	2
+#define MSM8996_VDDMX		3
+#define MSM8996_VDDMX_AO	4
+#define MSM8996_VDDSSCX		5
+#define MSM8996_VDDSSCX_VFC	6
+
+/* MSM8998 Power Domain Indexes */
+#define MSM8998_VDDCX		0
+#define MSM8998_VDDCX_AO	1
+#define MSM8998_VDDCX_VFL	2
+#define MSM8998_VDDMX		3
+#define MSM8998_VDDMX_AO	4
+#define MSM8998_VDDMX_VFL	5
+#define MSM8998_SSCCX		6
+#define MSM8998_SSCCX_VFL	7
+#define MSM8998_SSCMX		8
+#define MSM8998_SSCMX_VFL	9
+
+/* QCS404 Power Domains */
+#define QCS404_VDDMX		0
+#define QCS404_VDDMX_AO		1
+#define QCS404_VDDMX_VFL	2
+#define QCS404_LPICX		3
+#define QCS404_LPICX_VFL	4
+#define QCS404_LPIMX		5
+#define QCS404_LPIMX_VFL	6
+
+/* SDM660 Power Domains */
+#define SDM660_VDDCX		0
+#define SDM660_VDDCX_AO		1
+#define SDM660_VDDCX_VFL	2
+#define SDM660_VDDMX		3
+#define SDM660_VDDMX_AO		4
+#define SDM660_VDDMX_VFL	5
+#define SDM660_SSCCX		6
+#define SDM660_SSCCX_VFL	7
+#define SDM660_SSCMX		8
+#define SDM660_SSCMX_VFL	9
+
+/* SM6115 Power Domains */
+#define SM6115_VDDCX		0
+#define SM6115_VDDCX_AO		1
+#define SM6115_VDDCX_VFL	2
+#define SM6115_VDDMX		3
+#define SM6115_VDDMX_AO		4
+#define SM6115_VDDMX_VFL	5
+#define SM6115_VDD_LPI_CX	6
+#define SM6115_VDD_LPI_MX	7
+
+/* SM6125 Power Domains */
+#define SM6125_VDDCX		0
+#define SM6125_VDDCX_AO		1
+#define SM6125_VDDCX_VFL	2
+#define SM6125_VDDMX		3
+#define SM6125_VDDMX_AO		4
+#define SM6125_VDDMX_VFL	5
+
+/* QCM2290 Power Domains */
+#define QCM2290_VDDCX		0
+#define QCM2290_VDDCX_AO	1
+#define QCM2290_VDDCX_VFL	2
+#define QCM2290_VDDMX		3
+#define QCM2290_VDDMX_AO	4
+#define QCM2290_VDDMX_VFL	5
+#define QCM2290_VDD_LPI_CX	6
+#define QCM2290_VDD_LPI_MX	7
+
+/* RPM SMD Power Domain performance levels */
+#define RPM_SMD_LEVEL_RETENTION       16
+#define RPM_SMD_LEVEL_RETENTION_PLUS  32
+#define RPM_SMD_LEVEL_MIN_SVS         48
+#define RPM_SMD_LEVEL_LOW_SVS         64
+#define RPM_SMD_LEVEL_SVS             128
+#define RPM_SMD_LEVEL_SVS_PLUS        192
+#define RPM_SMD_LEVEL_NOM             256
+#define RPM_SMD_LEVEL_NOM_PLUS        320
+#define RPM_SMD_LEVEL_TURBO           384
+#define RPM_SMD_LEVEL_TURBO_NO_CPR    416
+#define RPM_SMD_LEVEL_TURBO_HIGH      448
+#define RPM_SMD_LEVEL_BINNING         512
+
+#endif
diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/=
dt-bindings/regulator/qcom,rpmh-regulator.h
new file mode 100644
index 0000000000..86713dcf9e
--- /dev/null
+++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_RPMH_REGULATOR_H
+#define __QCOM_RPMH_REGULATOR_H
+
+/*
+ * These mode constants may be used to specify modes for various RPMh regu=
lator
+ * device tree properties (e.g. regulator-initial-mode).  Each type of reg=
ulator
+ * supports a subset of the possible modes.
+ *
+ * %RPMH_REGULATOR_MODE_RET:	Retention mode in which only an extremely sma=
ll
+ *				load current is allowed.  This mode is supported
+ *				by LDO and SMPS type regulators.
+ * %RPMH_REGULATOR_MODE_LPM:	Low power mode in which a small load current =
is
+ *				allowed.  This mode corresponds to PFM for SMPS
+ *				and BOB type regulators.  This mode is supported
+ *				by LDO, HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_AUTO:	Auto mode in which the regulator hardware
+ *				automatically switches between LPM and HPM based
+ *				upon the real-time load current.  This mode is
+ *				supported by HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_HPM:	High power mode in which the full rated curre=
nt
+ *				of the regulator is allowed.  This mode
+ *				corresponds to PWM for SMPS and BOB type
+ *				regulators.  This mode is supported by all types
+ *				of regulators.
+ */
+#define RPMH_REGULATOR_MODE_RET		0
+#define RPMH_REGULATOR_MODE_LPM		1
+#define RPMH_REGULATOR_MODE_AUTO	2
+#define RPMH_REGULATOR_MODE_HPM		3
+
+#endif
diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/=
soc/qcom,rpmh-rsc.h
new file mode 100644
index 0000000000..868f998ea9
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_QCOM_RPMH_RSC_H__
+#define __DT_QCOM_RPMH_RSC_H__
+
+#define SLEEP_TCS	0
+#define WAKE_TCS	1
+#define ACTIVE_TCS	2
+#define CONTROL_TCS	3
+
+#endif /* __DT_QCOM_RPMH_RSC_H__ */
--=20
2.43.0
