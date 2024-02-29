Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41544C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6633E880F9;
	Thu, 29 Feb 2024 15:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="C58Gvpgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608B2880E1; Thu, 29 Feb 2024 15:21:24 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF6387C61
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TEGl6Z018534; Thu, 29 Feb 2024 14:21:12 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wjuj380gr-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/ho6Tzgv9X1u+UYXKu/97pTRAM3OyZc5u7w3oeLSP0SmfMyBfCyiYcy9oincktvfknLQgNXwXNr09rhhikWAlOxMS6vuayrnFWJC1niTIFuFOydFqBqBsHibPrc0o10/NyI25afoeIgAbj3wUjq5dp7wtwJgv3zmKbkhoDN9DYgl1K0XdGM8aXvcfHRLbQiWGEtDakZzgiNh1R/fqINoH3HwdhybiFMK3kdLB6DyoSB7SITSglx+LpzmBmA91ZAbKG5qTysKulYHkKbEaMFt2AguuZrtEPdd5SfLl8pbx/0mkp/ayBoWXhm46kXFjmCTqSqfzMVBT/4C2PLDRvjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZXgb89rG9OFJXz9Zu6EnEfI80/ri4RDylsgshiV5rE=;
 b=GCIAu0m3owHDgmYCfW6TBMv541SOBAzxfilO8hL9Fbk7sOXXsxdMKw+oe80nNb/LD4TrMnlzwmIaWTvyzYT5VkYabrdgQtSbbWHv0FdD/uDuqgZEE2n8IIs2W45QBUFwSgaCuekwyq4cmwqyGYmWITVL2y2/VQgokuWTwdEd8YquRY7HmdejL4VVI+fAYaozQMKPcC48z1JF2cp/iWzGyspf2JexN7li8xk8uFMQsbfou0pXFnjLltesp3YxDdRuTrGqOAcekOWxzq74tNpro8OYr7ju9Uq41jvrgLdKNun4WGcvOmx7AmvXxhUNY+ew6gHzl6NNvqgP/L/T1lTJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZXgb89rG9OFJXz9Zu6EnEfI80/ri4RDylsgshiV5rE=;
 b=C58GvpgdSm2ADZ69vbVGQSjgwT284NDEzzap1o6gJsc5or9GrtLWS9FN0DU//3VU6ZwwWhL2UIdsBTfs1saOFHtLlJwT6dEUMRguPX6QKkVRTKB742q+x2xDpqPaXIVSSByGFqzzCgk1LiKN2gqtjL/YLTZnoYU8rMB9w+bxnHWbitsjXzQ17lD/sjNJGgQGfjrVVhXzq0HkJMJwWSlB3A2FHKtlpL28t4KZJnmJkY+RwonRlwaRcBL+/oNQ9MFHhn7yiwUk+3SaiS4LubAidr3vH9cV9NZWdSUoJXcdvBa4yF+STrm2yK9lAO057BCSmKV/T4f3dGprvoHYNwSzig==
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
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Elmar Psilog
 <epsi@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman
 <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Ley Foon Tan
 <leyfoon.tan@starfivetech.com>, Marek Vasut <marex@denx.de>, Ramon Fried
 <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>
Subject: [PATCH 3/8] net: dw_eth_qos: add support for Qualcomm SM8150 SoC
Thread-Topic: [PATCH 3/8] net: dw_eth_qos: add support for Qualcomm SM8150 SoC
Thread-Index: AQHaaxqJLio8kYWjfkmVdlPXNrUzeQ==
Date: Thu, 29 Feb 2024 14:21:07 +0000
Message-ID: <20240229142043.1263690-4-volodymyr_babchuk@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: cc6bf71d-5f75-4997-9223-08dc3931abcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6DkDu/lw60OwHv027sdK0gQS62dIUeXNeaIrpejD9q3c914yhVNRtTMjHXXJme98TWeCwBhIGYdQVKzggjUy1VKJ4jch2TXkygYyPdqIh/T8eg5p402fIqEyj4jMUr3FftFvvliUBd57xh2YFeOqw8akLFXfSzFw0mx8Mz9YBXN98g/8K75SUfntw+6bq0djzSCaJU+VEL7O4fXLc+UxXqCUKqILEaGYO/Lv+h21qQsZ30F2AwF72NTEExb5OZjCHGC/XiBeu4HwK+OwWvR+BZ1AGL0Ix7zqX787U3Avc2+lqgpHprG8/IaaAopt9hNzhIZW8KxCjsR0m0xGW+BhPbP25rrTcpFe4spoEVOtCnHVwg9ZoRYt4TueLRDnNihBIrG49iNDtcj9SaF3TQwoDoY9KxsKncUxsvpqtY442pZ5gp3n++XjOG32ikNd9nu5JtI4FDhnqAee3TMPxq1R/tXKXMSEaPFypbkNK87vI2uNpLIN6O9hcp6tfpnKrVc3k8lP57BtE1kWoXGLSfH7XHqs3aqZLuNvB9/0WXLHDOoKsGyQSK51wLdse8GXDFo7nKGavYsFeTX34MdNT7764S6x7ug1XtEp2NoCnE65tVadNw5d+X8xOKyOCfpuqMncwq4Vko1NijPpr1CTKRG+AjaKyjIrDhvlCSekjKY2tutD5jIMJQLeTFlxEDvC+zMOGb2DTqMd+PF5XXIkbvN5cyTHfNkLjqkBjjyms7lo9E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q14SaiA1RioJU5s371MQHWaBLt0O4aBDFOnwYA0w8jnVXGmeGSp53Iz8QP?=
 =?iso-8859-1?Q?dik3mXSbdJDAkpovKijM3n3Pf4kaKcaAWJI9akPlEkW+M+ZE/6/egGgUTH?=
 =?iso-8859-1?Q?ybZxWa0mFj1gpt0sKc3W3EoNg5ko1tyFz+re5avTyB6GubZY3ImOxarSpe?=
 =?iso-8859-1?Q?+wmO2KBjBOyqhxtrNIufZWPciTDxV0Xcgn4TnJVK6atNhNyQOr8i7pkD4y?=
 =?iso-8859-1?Q?hQ6s+uWkNBZEZc0duyOjlruujJP39tji4vBI+YjCXlNZ1cd9YDk/MK7Ge0?=
 =?iso-8859-1?Q?UDB3sAgMsk6Zlt6p+FJCjNe0V7PPgG+1EQHe3SeaZQnUODq3Tc1wGEoAj5?=
 =?iso-8859-1?Q?2ObNfGoy2I3/qUjERIOwm7s/w5m57hW6GStrBoyUbC9MzvxdxFhWlRjgAx?=
 =?iso-8859-1?Q?8Yyn/3+eVyLJ78HCesrRkWdCetUjHoaHJPc9WzgtsNFOucXYfMEyvbZ0u7?=
 =?iso-8859-1?Q?GnlAdua23grM64Uv5+KEcbu1V/ahc07tQ8zlCfT/nq04rJ4By5vP2ZDKq9?=
 =?iso-8859-1?Q?AG6f+MAwhxIinU+zja14sZUSbK1s39I0uWSdGnwtbH1sX2VTNQevl6puYZ?=
 =?iso-8859-1?Q?j4EJsyfmM2KpCf6iVqmSwRD4sL9Xwr1HCoM7fNIGQCF9JevfuQ5sy8Yn+g?=
 =?iso-8859-1?Q?+Y8iIE6thqIqrULH4QJpxTNywz30dqhz4BgakM1bfO948Jd7iVkYw1jKTi?=
 =?iso-8859-1?Q?KF+17ippkkW5N9Lq85icmgY5wSDh1TWT30BvAjP+j9YD/ExeK2Yk0BtZ53?=
 =?iso-8859-1?Q?iXNSbM3nlGjJ03OV0vTXlEhuo/y82WzZrcMISIFTZ/3/dghbDYXXEvXe+L?=
 =?iso-8859-1?Q?ci9VzaldXRQBM/zTYudbuWjaEqHUIjFLXQkRgGJh/lG2NpOOSH7zcuz5n/?=
 =?iso-8859-1?Q?rS0h6FzkKYh4isrX88sKA84Md5WJl33BgeBZ37KKwQ2YPKkbY49FrICGCt?=
 =?iso-8859-1?Q?E3Xjfx6bAFEkTtRojnPMZMACPw92izrsALh94E7h+9UtFuYZxUpcnjT789?=
 =?iso-8859-1?Q?y9LYHRM2A654emHUldowdxS5kvEGMsLfAd8h6RlRFe/FbnRzebuGtutJNo?=
 =?iso-8859-1?Q?Fla0A6c3DBx9CdAPUWTEuKivJuTNtzuUHRGfNqHDk7/KgN03a3mUfLcsnD?=
 =?iso-8859-1?Q?hh6k3GyBSflEc/jnHb4fRbN/nj8MSnoUyhoIAfq87/AIqwu272RqGuFfOF?=
 =?iso-8859-1?Q?scpX8+SmMpiMFD6rrZQ5+28Egyj0JbeDM7nirGjAez+JA0V94gB8mLzYXv?=
 =?iso-8859-1?Q?4PCqPaM8JB5Rdm6AW7u3J7GPupoMIYXSA1IuJrgwxIz5GO01YeeR41mUwG?=
 =?iso-8859-1?Q?nEAltNviGhLG06fI7BmxIGgj18bI0ZJvxtE6OLU9tBvXcbNqAPidVxPedO?=
 =?iso-8859-1?Q?0zrihoUn9IUm3vNa0a19LPFguNVBHrRq1Qb7e9uk+RkM8cTbygAf+xEBOj?=
 =?iso-8859-1?Q?CgcFYYWjHxXAe+s0HX1TYPsillCGu6dSY1AvMzw2zJcIMlzBaNmPzpzftr?=
 =?iso-8859-1?Q?S7n7BaXn6a0+/AMTh3LPjzW+Xl/ClGlqfJOZXoLKhdQuIdvOStPVL4fYzs?=
 =?iso-8859-1?Q?oyM5qGihdgwnh/pQpusq7I0gRNy415otWGmA5TQR2H0Myp5pPzEJYiBiJr?=
 =?iso-8859-1?Q?hLWxhSqSDlMQSQvh7iBBu7UwQHpYXj03vhtsCAVgQFn+WPYpsmEVQz2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6bf71d-5f75-4997-9223-08dc3931abcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:07.7430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OB0hGcrJ5JiPMJkoc2RWqXNUo+3XWMr27zdmnMVIYy4W7iDbup3p9Sy2Q436BXv3uzDSN8usdgjQMHrb4Xh5ph1bewzKYJZNCkoxuGFlxIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: E10TuUsZk86k1puEJsm6S14pM8CHHUp1
X-Proofpoint-ORIG-GUID: E10TuUsZk86k1puEJsm6S14pM8CHHUp1
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

Add support for Qualcomm SM8150 SoC to the EQOS driver. SM8150 has two
main differences from already supported QCS404: it has another RGMII
configuration registers set and it does require RGMII loopback to
be disabled.

To support different variants of QCOM SoC we had to add two new fields
to the eqos_priv struct: eqos_qcom_rgmii_regs and
qcom_enable_loopback.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/net/dwc_eth_qos.c      |  4 +++
 drivers/net/dwc_eth_qos.h      |  2 ++
 drivers/net/dwc_eth_qos_qcom.c | 47 +++++++++++++++++++++++++++-------
 3 files changed, 44 insertions(+), 9 deletions(-)

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
index 8178138fc6..e9592ff686 100644
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
@@ -172,6 +181,8 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
 				   struct dwmac_rgmii_regs *regs,
 				   unsigned long speed)
 {
+	struct eqos_priv *eqos =3D dev_get_priv(dev);
+
 	/* Disable loopback mode */
 	clrbits_le32(&regs->io_macro_config2,
 		     RGMII_CONFIG2_TX_TO_RX_LOOPBACK_EN);
@@ -202,7 +213,9 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
 				SDCC_DDR_CONFIG_PRG_RCLK_DLY, 57);
 		setbits_le32(&regs->sdcc_hc_ddr_config, SDCC_DDR_CONFIG_PRG_DLY_EN);
=20
-		setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
+		if (eqos->qcom_enable_loopback)
+			setbits_le32(&regs->io_macro_config,
+				     RGMII_CONFIG_LOOPBACK_EN);
 		break;
=20
 	case SPEED_100:
@@ -233,7 +246,9 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
 		setbits_le32(&regs->sdcc_hc_ddr_config,
 			     SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN);
=20
-		setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
+		if (eqos->qcom_enable_loopback)
+			setbits_le32(&regs->io_macro_config,
+				     RGMII_CONFIG_LOOPBACK_EN);
 		break;
=20
 	case SPEED_10:
@@ -265,7 +280,9 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
 		setbits_le32(&regs->sdcc_hc_ddr_config,
 			     SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN);
=20
-		setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
+		if (eqos->qcom_enable_loopback)
+			setbits_le32(&regs->io_macro_config,
+				     RGMII_CONFIG_LOOPBACK_EN);
 		break;
=20
 	default:
@@ -281,14 +298,15 @@ static int ethqos_configure(struct udevice *dev,
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
@@ -565,6 +583,17 @@ static int eqos_probe_resources_qcom(struct udevice *d=
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
