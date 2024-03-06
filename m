Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF267C54E49
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765A288022;
	Wed,  6 Mar 2024 02:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="jPAB9YZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 812A887E03; Wed,  6 Mar 2024 01:53:29 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378AC87933
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425FtP8s019808; Wed, 6 Mar 2024 00:53:09 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wp390jh44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpV27MT+aq/VdGLnL9CTIHGQM/pn+oXbwjtP0FaedkcaXSLP9lBJ2vSVrOG6TjdoKsKEMTCw0Urj/XKki/MxG1KcNTDa17mjquQXTIyrcfa43pZnuVC2Uel9JX3nggmILQ+xEW6ewvP8mXj7rlxbD3EijKcHtc5i1HzlTXMElimnlx3T8W2lVoPq81vL8gTKuKVwtPwi3UGp6aaYd1Ty0WLnrsma14r5WmkwmAYCMeHs2k99BN3cq4aWWJm2jKrORw+6VKL8o6fatEgj6uFonAOc9X3cMivwLAg8UNC19HsP9PSrPQ7zcrN6d2RtnJ6muFzGKwTOK1ZmwuoAM4s2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuZbPIPsHC5GQXzB6DoxXBC5TjoFsAJ1qzwQTLan4bc=;
 b=bUqTuDnXq9XPBj7OE2iEp+dsBA3H1gOqtUc8TdhpJ5GYwmexPtgGY1IR/Y7AjZestSrvQzuqCcgZeoAKpZgXUTHsNDnmn9H21ZCTJtohztUipPBHwhZ/aMOagRfJu4u3+nNzpSi1v6Q+vxR5ZBjUCmd+bljdzGFcruSG/BBO7ezxYjmnOpmMmTNOMSG7Ko/xavBrqP/aNoEtm6vyKeXIQjyEZsxeYfj7DZ/0fnEAPofxsu4ue9fmjZR9KDj0TSKFJoV7uBQwBxIODzSFzj0Srb3etKlH+RjSnAlNBOFJM/7S5DMfJxEIDTbpJ8uIjqwMDkhP/1ylwiAVZdAvFfZMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuZbPIPsHC5GQXzB6DoxXBC5TjoFsAJ1qzwQTLan4bc=;
 b=jPAB9YZHV4kapWdj7ukmg6hFl/LzTtLQf+G7r1JyZmg4tWcRPYynF5LRlGPzvBopQK0jm2Ec7agBBtAEUCm2v/XoXd5MVwJ4YEax6KNaBnW5qaHxK7HLKBsZ4/baHZU1dcWnnVLMh5KmgSuoIggf1PyXYkLnGaIFGT/tz8MErZ9BkyLzE+DNrWgZqAyodo0LTr5uKzVfISpuriZJJDIO+DUzlzL7gcTSYF2rzqk3lua3MzEKZo2oZ4ke+y9JcOJ3ttBeVNJobz2WAae6DVkdCYvQsSR5NJWiI7Ngg3FxyuWDmAVFRNVCRdb6FnzHG8JQDkRAWqQrhEd3Wz3t7i69EA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9801.eurprd03.prod.outlook.com
 (2603:10a6:10:44b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 00:53:00 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:53:00 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Elmar Psilog <epsi@gmx.de>, Joe Hershberger
 <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 =?iso-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v2 3/8] net: dw_eth_qos: add support for Qualcomm SM8150 SoC
Thread-Topic: [PATCH v2 3/8] net: dw_eth_qos: add support for Qualcomm SM8150
 SoC
Thread-Index: AQHab2CiBFC5bRn6B0qB37v0NjUnUQ==
Date: Wed, 6 Mar 2024 00:52:59 +0000
Message-ID: <20240306005230.2638972-4-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: 7790ee83-44ff-416b-b622-08dc3d77c59f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Hmktxsnj+J50xHFumzovfB7YBgCRFQA7BiK1c9iqyGqdC3w3W0zm/6xldasI92YQcGaOrC8iHCvnoK30yuQ/GQSKn9Tev/Fhy525kuB13wXdCuwB9/W93+O7G2YXKSS3It8iMZg+eHSgqien6Va5OL7mEOMnCmuNoRLmtMD8zC0opolFapUV6qDMdF04gyACEbgocQj8uCEhJ/JVxYCYDU49grtB/6O+JuIHD+7ncUgdfFNJJBfYV/bdKBsByXXOHhCssjUalzw+2X+p7n2fjH8Z4FZ6tOmbfuYZoDiAQv5RfyZHVer9LViiDaxb4LD4NkdIN20rUNe5VmOhLM1gCecGmR8jSbMpi9PqMi6InqbXPYslvuLt/2CKL1GLCBIfc/Vt0lSL+g663TmjF+kUK1LrPulQcuj8fqxtajxTFsHkJ2moccS9jlir7qAEBj6DpJ25FSnF+Z/P1TgLWdTZVwHnzyaJiJZPvKJGPIo9l3twqHSUX/gYhokLDMdAxn8j2cx7R1xRDgNTvybl0ltK2Yxc2Hv4CX/YLDFWlZvrI7aRcOLnGtgVeRAvk/1BoIWL7yqAY//X1yU82m8V3KDh1CmuPaxh43jPR7hlc8xWBP4I5rWA40ZGrbOvmYT27O8FIZ7a66qnLHII5QF1/Zx6bb3m6rfhGGEbvGpCKNxWCeyoo5rh1+ZcZqkuM34bItD/nhEPUehCInES39JrAnGch++8y1GIZTQqDZDoqqts8w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WNFtFyCYjBb06s6B2fxhVGoeaemM8e13A4KGv+4gNFVvGaY9T7kQk0EVd/?=
 =?iso-8859-1?Q?0nRLiDzeic9ykJfoD4IQkCifKZhwlXimRGwPvSDnVXp55dpd/va2OL9dD5?=
 =?iso-8859-1?Q?xjXo9RwXLE/+Ls7agGi0vCeVNSPZhHmOtkMTLKATjCvPWfc0QZkGi3kMuh?=
 =?iso-8859-1?Q?J//m2mZ2iDdKafH0TcWSIfnnZY9aJjegfUMU5evrkO5F3NhEggznA/gduD?=
 =?iso-8859-1?Q?QStgR4hp8t/UnpFwlGefkW9ykCDckRJqXnH/+ABZzddCouCK6U/ZPpMr0t?=
 =?iso-8859-1?Q?wC2gTF5wVJJvM4TmO9v7cZOrJslErh0CuR3vtkIZa4oSPwCMIdK8wgvrTP?=
 =?iso-8859-1?Q?0auCQM9PgATKf43Avy8+YPRI5SjXUU4pfb680NHa8QC562Q/P1r+hThw4Y?=
 =?iso-8859-1?Q?3fA87NY0zYWYZVfNKcAlvluIyrpAKT/oZ4Bgndkj9nL1vQsoOqAV+WlycI?=
 =?iso-8859-1?Q?K0a6sNWw03E+MVuJUKw/EU3+b+e3VHakpdsjEoeyv3U4hqY/XwM0hMjxkG?=
 =?iso-8859-1?Q?va2/LPeJkmgSgJ6RCnLt0dQH7i/lCgp8C1wzM3mpvxl1mGQ6Q9nv+6OoEH?=
 =?iso-8859-1?Q?0yCxJkIw6AwcDZex0KJtlrKEjHyxnQiOSb54bchQiL+2Okb067RWW9PlSm?=
 =?iso-8859-1?Q?sdeyvJYtt5lk+vFnFeKJF8Yo1SOKRY4MZggXEszBECcwthEYpO7Elb8ydK?=
 =?iso-8859-1?Q?AJUUOChNmpNvPQlUiaFYUx3VzGdhSrF+hQb3zhkxghspJZ4mTSZwEHdlXE?=
 =?iso-8859-1?Q?0UX57GrisgCnedBMwrNxRym0AYSmP2TK+5dcMFRr1A1CgerBIIivKR6Bx0?=
 =?iso-8859-1?Q?IuaAVvbf1lnQ8etji9ufydgYlr21KH8nvUi2lmwWeTCUAkToHfJsE/s+ne?=
 =?iso-8859-1?Q?6beEgkRbyN0qlUYo+fpHX6U1oU+7UQFlVL6i0aPEL6dyU5O04QDp+C13iB?=
 =?iso-8859-1?Q?Qw/efRjJwBFa80RyENfrKYeTZi27QtI5GiJ+3bDze/cki70cJV4dXrFLae?=
 =?iso-8859-1?Q?5jdpR1ZrNuFxIyP8UxResQVQVBmkE1KvpLEyuR/3Bu1qFD57p3zG9jSwfs?=
 =?iso-8859-1?Q?sVaBbJg2l66gNcQsT+K5EwzSBhyf0PxG1PKxWsYC5Z9ZjlLDkPchb01Pz3?=
 =?iso-8859-1?Q?7gpzvtvHxI7kFjk+jirLB2k/5t5iHq8x0GU/898C7rcFUvIgEUBUytI6kL?=
 =?iso-8859-1?Q?A5PrsVMMmvjfhyJRZ9wNOH+p7lLLf9x98ZjLcTbJRTasomP6UzUapNcYNw?=
 =?iso-8859-1?Q?IKJws4GkJsnf2C4YNSrx5M2txiZWfupciggtOwicG889OAK+BcgWEwbESL?=
 =?iso-8859-1?Q?1EsXK3Cy+xaOgbgJZEjLL1BhWE3qHm3lF5sUbzDKmdxSbmxQSrrPDs+/zC?=
 =?iso-8859-1?Q?lz3dqO8aFHtp8MkTPb2Anw0yuv75EQulNepjtV+XhWHXV6cTrGisfeGq3a?=
 =?iso-8859-1?Q?8weYyQLGbRWJ6xFblp4l7JuuhcZPsP2D1v6offdhD4uoKfl8s7KIjL80ny?=
 =?iso-8859-1?Q?ggbMfBSvlkYtWh97rVzUk2mJ3OJJ+MK8uzlZ2OvtL7X3pAGF3osu/Wnkdk?=
 =?iso-8859-1?Q?RNw86leG4KhXWNk8uFn0kV6mnN6xpuO5ii5FeyTqObc+SUxa86THiqvOfs?=
 =?iso-8859-1?Q?gtLutgToTzxRfDt2ES4jJM+mhnKIxI5eFRUAj6TqurxE2iK0AxpS7Sgg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7790ee83-44ff-416b-b622-08dc3d77c59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:52:59.7255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFMt3RtWsQ2CpC6r0P8cF3tBnIhES9/E8hf3qZvL9zM49hLtDny6y+lB1L5pfHF87+zfb5ycjb0SFVtGWZg0cb158UZo4mcrlctOiz5bdZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-ORIG-GUID: HaLLb7OTzCHhNcwMZVJZUV0HxBjRD3UJ
X-Proofpoint-GUID: HaLLb7OTzCHhNcwMZVJZUV0HxBjRD3UJ
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

Add support for Qualcomm SM8150 SoC to the EQOS driver. SM8150 has two
main differences from already supported QCS404: it has another RGMII
configuration registers set and it does require RGMII loopback to
be disabled.

To support different variants of QCOM SoC we had to add two new fields
to the eqos_priv struct: eqos_qcom_rgmii_regs and
qcom_enable_loopback.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---

Changes in v2:
 - Clear loopback bit explicitly

 drivers/net/dwc_eth_qos.c      |  4 +++
 drivers/net/dwc_eth_qos.h      |  2 ++
 drivers/net/dwc_eth_qos_qcom.c | 46 +++++++++++++++++++++++++++-------
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 9b3bce1dc8..882b854697 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1700,6 +1700,10 @@ static const struct udevice_id eqos_ids[] =3D {
 		.compatible =3D "qcom,qcs404-ethqos",
 		.data =3D (ulong)&eqos_qcom_config
 	},
+	{
+		.compatible =3D "qcom,sm8150-ethqos",
+		.data =3D (ulong)&eqos_qcom_config
+	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STARFIVE)
 	{
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index e3222e1e17..216e1afe53 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -255,6 +255,7 @@ struct eqos_priv {
 	struct eqos_dma_regs *dma_regs;
 	struct eqos_tegra186_regs *tegra186_regs;
 	void *eqos_qcom_rgmii_regs;
+	struct dwmac_rgmii_regs *eqos_qcom_por;
 	struct reset_ctl reset_ctl;
 	struct gpio_desc phy_reset_gpio;
 	struct clk clk_master_bus;
@@ -277,6 +278,7 @@ struct eqos_priv {
 	bool started;
 	bool reg_access_ok;
 	bool clk_ck_enabled;
+	bool qcom_enable_loopback;
 	unsigned int tx_fifo_sz, rx_fifo_sz;
 	u32 reset_delays[3];
 };
diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.=
c
index 8178138fc6..ee8420c71d 100644
--- a/drivers/net/dwc_eth_qos_qcom.c
+++ b/drivers/net/dwc_eth_qos_qcom.c
@@ -95,6 +95,15 @@ static struct dwmac_rgmii_regs emac_v2_3_0_por =3D {
 	.io_macro_config2 =3D 0x00002060
 };
=20
+static struct dwmac_rgmii_regs emac_v2_1_0_por =3D {
+	.io_macro_config =3D 0x40C01343,
+	.sdcc_hc_dll_config =3D 0x2004642C,
+	.sdcc_hc_ddr_config =3D 0x00000000,
+	.sdcc_hc_dll_config2 =3D 0x00200000,
+	.sdcc_usr_ctl =3D 0x00010800,
+	.io_macro_config2 =3D 0x00002060
+};
+
 static void ethqos_set_func_clk_en(struct dwmac_rgmii_regs *regs)
 {
 	setbits_le32(&regs->io_macro_config, RGMII_CONFIG_FUNC_CLK_EN);
@@ -172,6 +181,10 @@ static int ethqos_rgmii_macro_init(struct udevice *dev=
,
 				   struct dwmac_rgmii_regs *regs,
 				   unsigned long speed)
 {
+	struct eqos_priv *eqos =3D dev_get_priv(dev);
+	uint32_t loopback =3D
+		eqos->qcom_enable_loopback ? RGMII_CONFIG_LOOPBACK_EN : 0;
+
 	/* Disable loopback mode */
 	clrbits_le32(&regs->io_macro_config2,
 		     RGMII_CONFIG2_TX_TO_RX_LOOPBACK_EN);
@@ -202,7 +215,8 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
 				SDCC_DDR_CONFIG_PRG_RCLK_DLY, 57);
 		setbits_le32(&regs->sdcc_hc_ddr_config, SDCC_DDR_CONFIG_PRG_DLY_EN);
=20
-		setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
+		clrsetbits_le32(&regs->io_macro_config,
+				RGMII_CONFIG_LOOPBACK_EN, loopback);
 		break;
=20
 	case SPEED_100:
@@ -233,7 +247,8 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
 		setbits_le32(&regs->sdcc_hc_ddr_config,
 			     SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN);
=20
-		setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
+		clrsetbits_le32(&regs->io_macro_config,
+				RGMII_CONFIG_LOOPBACK_EN, loopback);
 		break;
=20
 	case SPEED_10:
@@ -265,7 +280,8 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
 		setbits_le32(&regs->sdcc_hc_ddr_config,
 			     SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN);
=20
-		setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
+		clrsetbits_le32(&regs->io_macro_config,
+				RGMII_CONFIG_LOOPBACK_EN, loopback);
 		break;
=20
 	default:
@@ -281,14 +297,15 @@ static int ethqos_configure(struct udevice *dev,
 			    unsigned long speed)
 {
 	unsigned int retry =3D 1000;
+	struct eqos_priv *eqos =3D dev_get_priv(dev);
=20
 	/* Reset to POR values and enable clk */
-	writel(emac_v2_3_0_por.io_macro_config, &regs->io_macro_config);
-	writel(emac_v2_3_0_por.sdcc_hc_dll_config, &regs->sdcc_hc_dll_config);
-	writel(emac_v2_3_0_por.sdcc_hc_ddr_config, &regs->sdcc_hc_ddr_config);
-	writel(emac_v2_3_0_por.sdcc_hc_dll_config2, &regs->sdcc_hc_dll_config2);
-	writel(emac_v2_3_0_por.sdcc_usr_ctl, &regs->sdcc_usr_ctl);
-	writel(emac_v2_3_0_por.io_macro_config2, &regs->io_macro_config2);
+	writel(eqos->eqos_qcom_por->io_macro_config, &regs->io_macro_config);
+	writel(eqos->eqos_qcom_por->sdcc_hc_dll_config, &regs->sdcc_hc_dll_config=
);
+	writel(eqos->eqos_qcom_por->sdcc_hc_ddr_config, &regs->sdcc_hc_ddr_config=
);
+	writel(eqos->eqos_qcom_por->sdcc_hc_dll_config2, &regs->sdcc_hc_dll_confi=
g2);
+	writel(eqos->eqos_qcom_por->sdcc_usr_ctl, &regs->sdcc_usr_ctl);
+	writel(eqos->eqos_qcom_por->io_macro_config2, &regs->io_macro_config2);
=20
 	ethqos_set_func_clk_en(regs);
=20
@@ -565,6 +582,17 @@ static int eqos_probe_resources_qcom(struct udevice *d=
ev)
 		return -EINVAL;
 	}
=20
+	if (device_is_compatible(dev, "qcom,qcs404-ethqos")) {
+		eqos->eqos_qcom_por =3D &emac_v2_3_0_por;
+		eqos->qcom_enable_loopback =3D true;
+	} else if (device_is_compatible(dev, "qcom,sm8150-ethqos")) {
+		eqos->eqos_qcom_por =3D &emac_v2_1_0_por;
+		eqos->qcom_enable_loopback =3D false;
+	} else {
+		pr_err("Unknown QCOM ethernet device\n");
+		return -EINVAL;
+	}
+
 	debug("%s: OK\n", __func__);
 	return 0;
 }
--=20
2.43.0
