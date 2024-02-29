Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EC2C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752A388104;
	Thu, 29 Feb 2024 15:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="dvG21Tq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6789C8809A; Thu, 29 Feb 2024 15:21:28 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49789880DC
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TArea3026283; Thu, 29 Feb 2024 14:21:15 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wj8a9be8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7KfxwBodQ2U2egVaz0knhKJcf0tfp68b/N4T0/byYw1wiQYlCJDqp/dVMkEaR9Plabu1CPbm8OSct56HAe/RjhNLetUo9ODhoLMBlc8mBsV12pA0SbBp7NbP95lQrXfr9mJ5UYPhdC4SMmhCX5wqgEAJrO2Vd+DUdOXONLQurWHSPi7mmOrWqi5dx7RUYvKqj2G+IHIey/xaojaIBgQwVHbaNw9nrrbqLrVGGWicsJoNiz8ERhzcEMS9pYewg+OmodayeGIaQSz7yw9crJVMUgDjR9qs+sRUtYb8L6nOGpgFCb3FOyqCsUM7AfRclCs3GbZAFuqMD+WUj9FSgvWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FdVXyYkkGF1dl3xrH2Bz7g5a+GcbkEQ8CekFGoEMXY=;
 b=Cy2dNy3PA5wMeDtIMxB5jElN+DQfJh6xQby718nJhzSC9I0BTvEZPMiIa8SUOyHd3IazunIZsG34X4+hyeyxFY1K9XY4tat5gn78ZLgdeDkMgLd0PahorhA3YDCZc7WooQWBYo9/pcGWYw6+DQiPfqMpUWQ99jGZUlsgySDpgLfBcl20Z4ZvpRJXss7m25gv0YtAAYq5xQzr5QD31nORyJlgM+FMoBAZxDerDnQTZFfWST0P/s/w1TvIYTGNnuVvTSSg+WA7Ytesx2flJ58avDje6CHu4OIyiRLx4aKW2RDPbr5iBqfQ3T0AXCuhKZgsKfok/2YAuaX2N3NTN02ftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FdVXyYkkGF1dl3xrH2Bz7g5a+GcbkEQ8CekFGoEMXY=;
 b=dvG21Tq9CajRxv0Pk1B+HyHXnOO5S+6epK4MXTOCuZHURcK0YLkAbnATjxeyWMWc6vbB4VraysqSv9vlOCq+SrX0KapHFT4B3aWjJs9Cl9jNTheYnnBxLZJFOsRyxEJpQqm5dOHUgGu8V/wEWHhTnJkEro77fBBeiRhm1HOAeYZ9/mn5WiGXwnt0SA+Iarf02hilMnAv+zefapcu9Nt/ahz7eT5rMrcc/HqVtFaSJu0Az/LRalmKWp3HTjW9Zjo8DK9JluoOIOHL0xj5UVMUx0WNdLsn3VW6iDNsHRYavCkuvwjFCJ3KLzL77bFix3UxAYnCQrAAhQ1HTzQdy7GhcA==
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
Subject: [PATCH 4/8] clk: qcom: add support for power domains uclass
Thread-Topic: [PATCH 4/8] clk: qcom: add support for power domains uclass
Thread-Index: AQHaaxqJQNJbQOrm0kezIElcfBe1JA==
Date: Thu, 29 Feb 2024 14:21:08 +0000
Message-ID: <20240229142043.1263690-5-volodymyr_babchuk@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: 6cf28961-76e0-4fe2-8f4d-08dc3931ac03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3y9t6NXL7fARFBjUZwkhla7AtP69SD290ZYtcGpyxb/5qZ8J70WaA0Xn6zW/z5zBXa68MXXAAjzF1J5zyyzzkOia8LPBRmn0pszXOpr8LACW6C2EQjjtxy1yFDYPdvkcRf4iEa5fVLcoxMh1RWSxCTbsa9kGwwJ+wF0nE1POXjPhCtX150J+Nd01BKv1WxybTkkXDe26r0YUCqI45BV/4Xsd6U5LoFMgnjX27tBcGLp7WPFQYVwQECGPbHQue8cm1d9SGeJdQPeoJ7P+OlZ77UbuFmSPNldPC4H+WzEBCWTjTPRqGeJvtQPoB0vN7zS7pytvmeE1L0aV7wP3Wd2yViwho7oixVni7Y+Ahf2dVPK6R0CiSpi/sLNqUT52fmIS2RbSX6lO/QboG5M6hYw0P/NSAvumSOAj6m1+OLNV5r3PRWxDyEfpgYL0HHw3Kp+eaHDIXEXQKpfhgvDHQjH8Xr4+7BJgBPOq7MZ/BnpznIvxDxJvzPgla3P5YEI2n4OM1retSDTAcJ795bb+7igkUPVW4Ag5G9IaEjSGXL6Go424dMmH9C3NBmqgrVmcsedsTLDeFDtKv+1JfAXGlza1miFfoTi3s5lhxkD0RU3ARbuenjHD4x1rShmklQ6WHPXqF00SYQ04g1a30KbZx1ABwCts6t9zsCWuMaST6SpubvUgh47zCXFzgFfXAWU6cZTabwDdR2Yv48fdKQ4iYLc+dV5ac1akgcGFYdUbW79bsE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LNG/ucesiI2tgEwXDEWlgMHbEcLNIEHGdaJfeCQg/TyZonvQar/au1T2Ye?=
 =?iso-8859-1?Q?Z/Oe1m2+64aONb9pJod74C71k2Ij8FeA9e8SAnAuU24YPQ9QlnHF6VSH4d?=
 =?iso-8859-1?Q?dp8cxaklj7ibAv3VofHQe3cJuG7pAg3AlsTLq56ggoTlv1ClYDKP4jVW2G?=
 =?iso-8859-1?Q?CUqJ4qX/dHIfjgYAksAduhB/f6i9juULhOin8hs3XbXGQhqH7GWAs0O374?=
 =?iso-8859-1?Q?uehPP5G7Nwu3Dh8KE4ALFyJEQGiBCiZWjlBxium0nrMn/m3c/hTeYOKfSh?=
 =?iso-8859-1?Q?uyWy1/dIHsRgthkIjfWIxmMg5/nv0pts3o1bOvMSwsYaIPgPrD3wKwtHL1?=
 =?iso-8859-1?Q?UG4SA/eQhoeTSGw4fTr/9AOapkzxq147Gck2qfExd3JZc5CtItQGzhv6nQ?=
 =?iso-8859-1?Q?+TXaKPUoZYRV7z2uOGTl8LE/5JlU+AAdjhPJAP6LXjRG6Pxi8h+IDOXFdZ?=
 =?iso-8859-1?Q?3oS7BLE1IV5MvYrNi1wkdM/NqlZsx0gWbCYIVYCpakf8ELduSSXatY0M+h?=
 =?iso-8859-1?Q?BRqaf8SNTkEbxT/UvdsiN9Vq1e4G+OPc1sSPKq2IKz6pW84owXXpxmlcVs?=
 =?iso-8859-1?Q?ZEuX1aFR6mMrSUNyk4mWqsM9tX51jUpqsqHlhtTK7uH9W7xJTigVM+TQEP?=
 =?iso-8859-1?Q?a2cwZ8rPwCrc+gtXE/dqfKOX/yLZXN72rxYF8GWKHzZ6letXwVtijiUukc?=
 =?iso-8859-1?Q?Bzowjhml3b0Z27ZdoEr1u5QZIbgwKLO6GWluTm06nUIGiGF5z6gRH4Y1hn?=
 =?iso-8859-1?Q?pz1Ja6ZixKIpjn4tqgu0HJk6JVIn7Te29GPwHdybAmRdU7wd75x6sC/pLy?=
 =?iso-8859-1?Q?Tu1JiBElIOKSpDE+gc4RfDEjPEZF0kO+krcSySI2dHqzPq7aJvpDrv24Hb?=
 =?iso-8859-1?Q?DSSBoyjrdRkbc2wRna7X9X5bwegCDModYaHiSCbii3ElXpRA+MRLMa9BwN?=
 =?iso-8859-1?Q?lb+41Z4poCrEPW3Sb9jL0bOrsSOo4ash1OIC/yAVIk2B/+LbIFoPxsRMMN?=
 =?iso-8859-1?Q?mJ2eFREte+ILPycscq8O4azUFIO4dD53gfgkWX6j19N3tpevzgGmaRLJPw?=
 =?iso-8859-1?Q?Bv4pNw6osNtn3Lyso0wM9/lYRxruNxSeum2LrXzLmPEaoIBEgCWp6GNxd4?=
 =?iso-8859-1?Q?wGisNVVliE0scDfIVsRHjA4mTH4bqTVqNCljNnA+XMi0S1bxMt7qwJ8Aeq?=
 =?iso-8859-1?Q?MG5mxSMbn+zDy9c+qmO4RDZzBe9tyaZ9XJbdYZY0pujZigMMamz7y8laYd?=
 =?iso-8859-1?Q?W1S+3xEVX2nPqIA2twntwE+T328+ynAA0FmHQwbbnxL+bTmHCSfKUkVlZR?=
 =?iso-8859-1?Q?rf4nJsKDoGKHdUh1YP8TXgHgndrXx/9rS0OIF2n5ip8EPVRVWsoRgVRn6X?=
 =?iso-8859-1?Q?3skZQASaeESlBLo8BnXKLY+R9lLSm9hQJQ+xC5e9npHZDoLiKi4+IhtMGJ?=
 =?iso-8859-1?Q?TO2gs5tGOocmvOCcbrOFBYX4GW0WBtgSCENYFrZPcGnZHp0N5zNM9jEXzz?=
 =?iso-8859-1?Q?0ymtCIYnbqeVDyfVGrY8+ppFCSVZlO8BtRDxqsD52CyUEoYi3HYXG8GT8i?=
 =?iso-8859-1?Q?t9DpG5J4IQZ+RY2PHRksWyQo/6/ud83Y831uaVpk5cJve64NTxFtjq+si4?=
 =?iso-8859-1?Q?4iUAYHwqfD9ZhURoLP/Y4p1s4zewOAr0E9WIYprcj5vlbJlAeAR9agag?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf28961-76e0-4fe2-8f4d-08dc3931ac03
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:08.1518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAodwIZaCjauVQmPPIXhJTMl8QJyx11qgIWX04ehWiCE3ATM9isjqc7AURtt6ho9Pv+ZhCKF5k/0enAo/zaP+P2oj2VWJ0ruGpd2Zbwlvq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: 4ZLoQ0_e_ultNRkX08vUt81VSSDq8bq5
X-Proofpoint-ORIG-GUID: 4ZLoQ0_e_ultNRkX08vUt81VSSDq8bq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=812 phishscore=0 clxscore=1015 mlxscore=0
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

Now sub-drivers for particular SoCs can register them as power domain
drivers. This is needed for upcoming SM8150 support, because it needs
to power up the Ethernet module.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/clk/qcom/clock-qcom.c | 93 ++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/clock-qcom.h |  6 +++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 729d190c54..986b8e4da4 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <reset-uclass.h>
+#include <power-domain-uclass.h>
=20
 #include "clock-qcom.h"
=20
@@ -30,6 +31,11 @@
 #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
 #define CBCR_BRANCH_OFF_BIT     BIT(31)
=20
+#define GDSC_POWER_UP_COMPLETE		BIT(16)
+#define GDSC_POWER_DOWN_COMPLETE	BIT(15)
+#define CFG_GDSCR_OFFSET		0x4
+#define PWR_ON_MASK			BIT(31)
+
 /* Enable clock controlled by CBC soft macro */
 void clk_enable_cbc(phys_addr_t cbcr)
 {
@@ -223,7 +229,7 @@ U_BOOT_DRIVER(qcom_clk) =3D {
 int qcom_cc_bind(struct udevice *parent)
 {
 	struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_driver_data(=
parent);
-	struct udevice *clkdev, *rstdev;
+	struct udevice *clkdev, *rstdev, *pwrdev;
 	struct driver *drv;
 	int ret;
=20
@@ -253,6 +259,20 @@ int qcom_cc_bind(struct udevice *parent)
 	if (ret)
 		device_unbind(clkdev);
=20
+	if (!data->power_domains)
+		return ret;
+
+	/* Get a handle to the common power domain handler */
+	drv =3D lists_driver_lookup_name("qcom_power");
+	if (!drv)
+		return -ENOENT;
+
+	/* Register the power domain controller */
+	ret =3D device_bind_with_driver_data(parent, drv, "qcom_power", (ulong)da=
ta,
+					   dev_ofnode(parent), &pwrdev);
+	if (ret)
+		device_unbind(pwrdev);
+
 	return ret;
 }
=20
@@ -306,3 +326,74 @@ U_BOOT_DRIVER(qcom_reset) =3D {
 	.ops =3D &qcom_reset_ops,
 	.probe =3D qcom_reset_probe,
 };
+
+static int qcom_power_set(struct power_domain *pwr, bool on)
+{
+	struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_driver_data(=
pwr->dev);
+	void __iomem *base =3D dev_get_priv(pwr->dev);
+	const struct qcom_power_map *map;
+	u32 value;
+
+	if (pwr->id >=3D data->num_power_domains)
+		return -ENODEV;
+
+	map =3D &data->power_domains[pwr->id];
+
+	if (!map->reg)
+		return -ENODEV;
+
+	value =3D readl(base + map->reg);
+
+	if (on)
+		value &=3D ~BIT(0);
+	else
+		value |=3D BIT(0);
+
+	writel(value, base + map->reg);
+
+	/* Wait for power on */
+	while (true) {
+		value =3D readl(base + map->reg + CFG_GDSCR_OFFSET);
+		if (on) {
+			if ((value & GDSC_POWER_UP_COMPLETE) ||
+			    (value & PWR_ON_MASK))
+				return 0;
+		} else {
+			if (value & GDSC_POWER_DOWN_COMPLETE ||
+			    !(value & PWR_ON_MASK))
+				return 0;
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_power_on(struct power_domain *pwr)
+{
+	return qcom_power_set(pwr, true);
+}
+
+static int qcom_power_off(struct power_domain *pwr)
+{
+	return qcom_power_set(pwr, false);
+}
+
+static const struct power_domain_ops qcom_power_ops =3D {
+	.on =3D qcom_power_on,
+	.off =3D qcom_power_off,
+};
+
+static int qcom_power_probe(struct udevice *dev)
+{
+	/* Set our priv pointer to the base address */
+	dev_set_priv(dev, (void *)dev_read_addr(dev));
+
+	return 0;
+}
+
+U_BOOT_DRIVER(qcom_power) =3D {
+	.name =3D "qcom_power",
+	.id =3D UCLASS_POWER_DOMAIN,
+	.ops =3D &qcom_power_ops,
+	.probe =3D qcom_power_probe,
+};
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 01088c1901..12a1eaec2b 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -59,9 +59,15 @@ struct qcom_reset_map {
 	u8 bit;
 };
=20
+struct qcom_power_map {
+	unsigned int reg;
+};
+
 struct clk;
=20
 struct msm_clk_data {
+	const struct qcom_power_map	*power_domains;
+	unsigned long			num_power_domains;
 	const struct qcom_reset_map	*resets;
 	unsigned long			num_resets;
 	const struct gate_clk		*clks;
--=20
2.43.0
