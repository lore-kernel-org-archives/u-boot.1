Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F391C54798
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE23F87FDD;
	Wed,  6 Mar 2024 02:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="oI+U/XX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657E687E03; Wed,  6 Mar 2024 01:53:18 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E063687933
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425GnAXB024399; Wed, 6 Mar 2024 00:53:08 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wp05yb9x0-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLCUKoyYT2KpDmiiZnBr7UxojctAgHL7dYF7Y0Ey2bm3wmQ+WGo4WvPnC/wP0FGP0+Ye99b0tlKZTF4iPk1esFMnxs75T1bPebN+54YHAaHnO/BWyI9X5V75SIMnHpObxtdaHgQ5qTOh3+Qe2Bp1A3iEqmi2KviQKacWGayDWa0YvzwnWHj4TdmBKSIK9hFDvjajWvYtSnLwQeZlEs/OjeWzLgvRj20pGB2ZtoUHZk2ozHcbnuFqXSzxTiYnEE8RHNN4L+EzWqCRz1ILQEVzl016RH3glNJ1mhUU3sJd0z2/zkoxVKjWp6pUsMTcXb5uDVnt7lwdw1EUtbmWGNNcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA6q4AUgEdtGIK5yXBWoClfWm/zKkLHZ2MwiUKVEUUw=;
 b=h2+OmUGXHDuQB9i9+9kRW4UAFg5uHLjtU0L7KYXNEy1eKhU2fWRD85yxLp2CDC+yeefLDJBsyb8cSXy5Btxf5Nfhbyk8CGHEnqU3LCoEIX7jGI6bGuw3Am9KXwXZAkOfDOFnUTjyrw5B0gJpVMi/cJKhLrUEoY/yXQyCF7eV95DcwyHTQgo3M8AYbsGFF/bX2ay5GNHLL6WecopoifiRKaSqYgHeZ2B6kYwPKBS0xi8JaWYA5+SlEVeZwg1b2zIEN/u9R6EpasIuKimid8JNhiIICPlTCKSrsk+gGRibC9muZsGmzE/VjHCuX4dxx/Y0IDi7+9191ER0BQo2QxAv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA6q4AUgEdtGIK5yXBWoClfWm/zKkLHZ2MwiUKVEUUw=;
 b=oI+U/XX8Qdr8+Xmr6Im5aYBHunv6ZuhbICwQ0WhImQkCN/mt+vIzwbRXzh086Y6Zi8h5do/h2VZkNzrxK89wDz+JFbLQrMb1RKdOrlbgPM9GP90eQL0AahJIWlwiEocaYdiLOTsc9BbUs1dkbyE42kYdLJ5sxfi6swgfZxQ4EYVH11CYKFCCwdM8AtkJk5bL8VitixU18FJfJIRG1EjSSA9Eeir/ax7Rzv5smbamLVUlMS+dV+eouLqo6W5+1Sj27Phe2q15EpJmct8wBwm4+yTSbJ1j2MhCHcSc6UdPn0LR1//AH1hePVDvMXvblWDtl8DP8KHyDWNT+2TTFP+pSg==
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
Subject: [PATCH v2 4/8] clk: qcom: add support for power domains uclass
Thread-Topic: [PATCH v2 4/8] clk: qcom: add support for power domains uclass
Thread-Index: AQHab2CixGOzlsZvHE2pW2MR7EckOA==
Date: Wed, 6 Mar 2024 00:53:00 +0000
Message-ID: <20240306005230.2638972-5-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: 6628ef61-b23c-49b9-98da-08dc3d77c5e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFSbKG7fqB+fkNKQCQ1N57tFfxLwErSUD7eyMP7gmcg1X15mZXV4uOesmavOvQsV059NeLfWJQaxrmUQKWdJU3iKMAoMeoJNqVI+90xxuNnVKNLmwhX2vuZNEBUSkdy5IR/mEBgY4CbZq7TtVRCUyHP5pBPbYX96yTKxMpWbd5Knxbw9o3B/57gkDsmQwFHE7PbjmtvUiewuI7k7J+RKdQoSijqxOTWrcorVcWB3N//PUtaRPmhGT08MipNFXjMEGb+vMNGQDzQGnPHakQSzVH5XoxYg+8RCzYO7nH/8mbUJaGPU9yIkMvl85jlnOhWkPog9IhlhGRDwbOOa+0Q31mcl79Gq+hVhUD1jqK+6Vmt+4eXdV3UfY1wQO6HdxppRCH9Lm+73Ulji0L09scdRRgGzo7+WywWSgmJybL9BJgS6VYXosW067smJyK1MXJl7ai9FdYE5hafjMDb6st5FuGjbMad9ZAB/NaW/xrY+jogORN2+ragHrG3pfMa7CqdDhHL+fvNIaIdWdiVgsPruuT50g3nBL/WAW9IsDwF7F21/L9WoH8ttdzScwsj+Ng/mv/7j/LNy8L/pBVUwejHCRYbbdY0wgdGYOEJj5NJFyooRYU6rAsr6zchlxIXuEwp6GyDsg39Tp8mg/Ew8pjp0W3p7daxMP9VLqXy3oavLUnvbcRObPiifLFZhrpl/liSiWyksj3tgzO9bL/vq6XVT8ljD2ZiFm3GCafRwHsYNeOw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8ibFPqP5+zZsmlggLdXLFWoSYDucEutY/P6uFj2BGHzqCUe27WVFbioCOI?=
 =?iso-8859-1?Q?fD/oIgi+yvCBQfAl5i7PYX0ZFHfD95B1qLD2BmHRSN8FhnEwIL7Qh/2wSz?=
 =?iso-8859-1?Q?pLuTjdqvca0CHYNehIZ5IjJ7UfBsILBvQ5cJ1a9LZTdHXIQzaXcV2IGWBr?=
 =?iso-8859-1?Q?B76V/vqadJ0C0OX8dqPXZWJT1EhhO/yFCEPwC59GGbzyUiTfRmveozsrbI?=
 =?iso-8859-1?Q?q6VP9Poj6c/PkmT0x5I+Ot0oANnjl9s9MWOfX9EJytP8ysMuZOlP5vjMg1?=
 =?iso-8859-1?Q?dbrMedIgaE+26mq5DAKa171Ud5FqjsMBR+3hFQIvnRgAHAhtGhCzemgYsJ?=
 =?iso-8859-1?Q?RiplTXeCdv7ogDLRAlQtBUpi/7j8EDkZtRhVtahKgiqldKIkyoAr0mK+k9?=
 =?iso-8859-1?Q?AbEtWIk0r7fDeXCgDqOZNp8fKDhv5bdGfRuqakxC/1ZYJJKN3dwKdDUWun?=
 =?iso-8859-1?Q?7Ev88/Ne/QhtpZOLTpfV0M19oMDjVwijQMlyIFrY9vEa55uHLXAinIqGhL?=
 =?iso-8859-1?Q?8kcLHGdy4PbmPDfMcohOSyyqjq34d3QENb5t9o2EzE+ruWOXitnLSug1hl?=
 =?iso-8859-1?Q?vLBU+pC4IK9h6KZY1m0M4Pulvn7KxYmamye2jL7cfauYc3Ig4Urzc3Nkjp?=
 =?iso-8859-1?Q?/RGBvXBiXKzwxhjj9EnKahWaDQO3AJGBdGpYGLRGhzSGmV9ORyFHzYaPh4?=
 =?iso-8859-1?Q?2jckuKLo5yjINoBISanYBO52k/914l96H7Le+JxErEqYBq0yglb+jYTD26?=
 =?iso-8859-1?Q?aY59LTE0rRVpbTO8jbOsWGFXDZJCzAMwXK8cxCP8F8e3iGc1YdVxTsIU3z?=
 =?iso-8859-1?Q?NvhxKQarLymoGmxMab2pcoeLdCA2r7kxRUVv4emBOjgo3r5OGTtfWbbga+?=
 =?iso-8859-1?Q?VAMMYt4IeklNAqEC9P9Fckt7WINQ/IlVZZ9qjTIUZSqoeTGAaERl4BkvGa?=
 =?iso-8859-1?Q?hsvR1w5842eQuo15mo6U2jxXg0/YB8njZrQ49TykkdWTy9+tcR7yw1xCEI?=
 =?iso-8859-1?Q?1LDXKiRKbQBcILx2Ddej1OTG2w0bEwnuJ0O7eSkmIYxAQ4/dO+tNeFPiTT?=
 =?iso-8859-1?Q?B/XwWVI+uCWxP0CcglU0Iq9X/n8vav299fLqy4iyjJ9U3kf8l58WCCDM6P?=
 =?iso-8859-1?Q?s2mfCxgMQbKOHKnVEMbQad0n8gpE+NSW7bpzRZf6tVv9iam6zXV6Ka2eYm?=
 =?iso-8859-1?Q?f8S6fgGh6HYMuS/1aUbwTgKWseyafQkYdfYjpYnAB3VCKN4MykVt3dGZpT?=
 =?iso-8859-1?Q?azsKlzVerCBimNgL3WGmyySpTmU+avwKTIxIk+WBUtv0LFyj8K5D9dAzrM?=
 =?iso-8859-1?Q?8Q0BI0F48PyD1zVhFTq6JaNzh5oMtGNX/POqMmovs/7I2Ham2jY+BW0VZ2?=
 =?iso-8859-1?Q?xRvvdvHuwzKgDZiKL85AOawB1tVLuuL/8G8gEN/uI+WtWcjz8Y4Ndu9rgw?=
 =?iso-8859-1?Q?vkbpnHeE0KkSfqwZtUUxSuNEMMeMuGnbYZrSoruNAT1xegHXdeyZl/WX91?=
 =?iso-8859-1?Q?ueBx9v1s9IKVTWQnBQgOZZWQy5xqMFV1p24Uv8ambuMuYQKjusvOe106Iw?=
 =?iso-8859-1?Q?TzlIZ5CLvyV4n4nII4vP9emYK2L9TUi3S11hyBaYJkJfUPwzq8hOYPeRBV?=
 =?iso-8859-1?Q?SeDP9kxUswlNUVYikAs3BcAKDmJRF6qctrX/u71Xzz0Nh0m3QzHMxmBw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6628ef61-b23c-49b9-98da-08dc3d77c5e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:53:00.1025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3a4ytEpTvYj99E+95QQwYNr5SQyJD//Uhy28ViLD2F0q2WNyQ7Y3tim6u0EdFXbpd065BE0qRd9iAaLBqoyKvuwNAGShRb1i77u9tjLvOOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-GUID: AZuEPUSY7e8kAnA4_9NPQHXhZ4KPTL1E
X-Proofpoint-ORIG-GUID: AZuEPUSY7e8kAnA4_9NPQHXhZ4KPTL1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=913 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
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

Now sub-drivers for particular SoCs can register them as power domain
drivers. This is needed for upcoming SM8150 support, because it needs
to power up the Ethernet module.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---

Changes in v2:
 - Reworked qcom_cc_bind() function
 - Added timeout to qcom_power_set()
 - Minor fixes in register names and formatting

 drivers/clk/qcom/clock-qcom.c | 128 ++++++++++++++++++++++++++++++----
 drivers/clk/qcom/clock-qcom.h |   6 ++
 2 files changed, 121 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 729d190c54..c3f8d96183 100644
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
@@ -30,6 +31,13 @@
 #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
 #define CBCR_BRANCH_OFF_BIT     BIT(31)
=20
+#define GDSC_SW_COLLAPSE_MASK		BIT(0)
+#define GDSC_POWER_DOWN_COMPLETE	BIT(15)
+#define GDSC_POWER_UP_COMPLETE		BIT(16)
+#define GDSC_PWR_ON_MASK		BIT(31)
+#define CFG_GDSCR_OFFSET		0x4
+#define GDSC_STATUS_POLL_TIMEOUT_US	1500
+
 /* Enable clock controlled by CBC soft macro */
 void clk_enable_cbc(phys_addr_t cbcr)
 {
@@ -223,7 +231,7 @@ U_BOOT_DRIVER(qcom_clk) =3D {
 int qcom_cc_bind(struct udevice *parent)
 {
 	struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_driver_data(=
parent);
-	struct udevice *clkdev, *rstdev;
+	struct udevice *clkdev =3D NULL, *rstdev =3D NULL, *pwrdev;
 	struct driver *drv;
 	int ret;
=20
@@ -238,20 +246,41 @@ int qcom_cc_bind(struct udevice *parent)
 	if (ret)
 		return ret;
=20
-	/* Bail out early if resets are not specified for this platform */
-	if (!data->resets)
-		return ret;
+	if (data->resets) {
+		/* Get a handle to the common reset handler */
+		drv =3D lists_driver_lookup_name("qcom_reset");
+		if (!drv) {
+			ret =3D -ENOENT;
+			goto unbind_clkdev;
+		}
+
+		/* Register the reset controller */
+		ret =3D device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)d=
ata,
+						   dev_ofnode(parent), &rstdev);
+		if (ret)
+			goto unbind_clkdev;
+	}
=20
-	/* Get a handle to the common reset handler */
-	drv =3D lists_driver_lookup_name("qcom_reset");
-	if (!drv)
-		return -ENOENT;
+	if (data->power_domains) {
+		/* Get a handle to the common power domain handler */
+		drv =3D lists_driver_lookup_name("qcom_power");
+		if (!drv) {
+			ret =3D -ENOENT;
+			goto unbind_rstdev;
+		}
+		/* Register the power domain controller */
+		ret =3D device_bind_with_driver_data(parent, drv, "qcom_power", (ulong)d=
ata,
+						   dev_ofnode(parent), &pwrdev);
+		if (ret)
+			goto unbind_rstdev;
+	}
=20
-	/* Register the reset controller */
-	ret =3D device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)da=
ta,
-					   dev_ofnode(parent), &rstdev);
-	if (ret)
-		device_unbind(clkdev);
+	return 0;
+
+unbind_rstdev:
+	device_unbind(rstdev);
+unbind_clkdev:
+	device_unbind(clkdev);
=20
 	return ret;
 }
@@ -306,3 +335,76 @@ U_BOOT_DRIVER(qcom_reset) =3D {
 	.ops =3D &qcom_reset_ops,
 	.probe =3D qcom_reset_probe,
 };
+
+static int qcom_power_set(struct power_domain *pwr, bool on)
+{
+	struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_driver_data(=
pwr->dev);
+	void __iomem *base =3D dev_get_priv(pwr->dev);
+	unsigned long timeout;
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
+		value &=3D ~GDSC_SW_COLLAPSE_MASK;
+	else
+		value |=3D GDSC_SW_COLLAPSE_MASK;
+
+	writel(value, base + map->reg);
+
+	timeout =3D timer_get_us() + GDSC_STATUS_POLL_TIMEOUT_US;
+	/* Wait for power on */
+	while (timeout > timer_get_us()) {
+		value =3D readl(base + map->reg + CFG_GDSCR_OFFSET);
+		if (on) {
+			if ((value & GDSC_POWER_UP_COMPLETE) ||
+			    (value & GDSC_PWR_ON_MASK))
+				return 0;
+		} else {
+			if (value & GDSC_POWER_DOWN_COMPLETE ||
+			    !(value & GDSC_PWR_ON_MASK))
+				return 0;
+		}
+	}
+
+	return -ETIMEDOUT;
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
