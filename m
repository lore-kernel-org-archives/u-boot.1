Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845C1C54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A372880E4;
	Thu, 29 Feb 2024 15:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="epPGIEs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC6C880E1; Thu, 29 Feb 2024 15:21:20 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97571880DB
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TEGl6c018534; Thu, 29 Feb 2024 14:21:14 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wjuj380gr-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8qaS/+XH5FZqNPdkK7LMEIbuEImDyqE4G7LfHpJvyDz3bllv53kRhXfWU95OTluoUtd8oaCveNHFagBY6WW6gSSwEoI5zhpKUnUHHKGlQe8zupsytA0gLHHOCHXFyPpaxnrTf5qV7E1L6OCZoffm5jFFH/dPbOZikDMCwfsT96XLElAQwtoCrLdwhwUxwLlPmNCL329aV6hsBHSi7InGQ5CCykrNg9jRXiUooRXkXxG1c+H91dyR/6NMRPLdRhN5rJ/Io3ybItGoPOGPfh9AMGQZZ6NSr/jcI907ze5Pbkw970NjEpzzfluEoKrBOZYCn+BGi+g8EVOPPUJYhuO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jO/E3jk2Lw65qA3i1wu2wSWXhBQVZueAHBE7KDwVls=;
 b=D24uBUijDzUbxt4ih6eFrl2QIMbUmCLypp1fY/OcmO5zUhbN3WKKMF8bFRNTLPvswsHYBMTzHtpbM4aV6Fb1xBpQnglj4omIzQgZ++mAvGberrGXpBH39dLYWTzapKwmk/HeCLTu1Ir0SZqokM2ldaMpfC46+k/tZhFAQEi3eYryqJFnWH75Ti4fGhP6wC6IopcmZJNc3qM2BWoVnblQdZjTbaeaxei4gho/OG+xB+0wH2r0R9a8nu1tr1gP5Kl5aWLGCaA7HHFA2hGSSGVLYP3JKLcn6OEmz5gGma3mgYOVPd+XB+7O9JjOlcZsaS+/nY7h2fHcSubVhl8I1Bd/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jO/E3jk2Lw65qA3i1wu2wSWXhBQVZueAHBE7KDwVls=;
 b=epPGIEs4Sxuzi54jCjSkMZxUHE9idenHhKIt788akRqMEMVksDrWvB8MO/lv6lR+aUpK7jb57PYArkzFenBDGPD5e4GjNCIKG722gWuq9g/zmHCBKSCUvIGxgdQJTjRP317MIhBXSyIE/KezUb2WlaQ2x79aVsLoDV81oxdfFHIcZ/+qN/9rmGgT+qO/uILxU8oz5U2Uqj7qqcYbPuuUIcrIcEW/jNxu6mXuFQtQu7ur0MxadxY1tsbvYj6TxoX90gig16P2N3KgyNp66XuV64c6zFJIro3Ybe+UWrxg2gpJ6uGsRp56ybib/zfJHph1Y8w8zEiFJH9OMvSK6N/Eog==
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
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] pinctr: qcom: pass pin number to get_function_mux callback
Thread-Topic: [PATCH 6/8] pinctr: qcom: pass pin number to get_function_mux
 callback
Thread-Index: AQHaaxqJ5XDVCD7YgU6ZE+Wt6VHPbg==
Date: Thu, 29 Feb 2024 14:21:08 +0000
Message-ID: <20240229142043.1263690-7-volodymyr_babchuk@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: d90aec38-1c2b-48b9-9b53-08dc3931ac99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uq+NODHq0Qb1pXwZNZNODRfRAeWmYwHQSD5vXgC/XVhGhbMDP61gsT+VFO1AKmryesQv9Zc6tpQ4b0SLaQXxPETaDCxfpQ1Cpm7ZMgyw71utxaFQt9LDkW3glII8OTgpN6uX4KWqbqqIG6KT+tCWebtoCnl+TGAZL4TscGL54I0smNxt00hENn4gw9jSyCxhirBfnuaVqc/jwFpaIPQ9T4feg02RxDSvad6/ZlP4toiTtqcXYNY73cIsr2w5YpKHKEV6XyqDnH5sXrWrXeIv3oaA4NzkFb3zh7vgfL1WWelbyB2Az6m/3VCu90TdGodj3HMIsDuXDZzUioAiYMtQDXirbaNFPLaC5qTJ/fS9CtsBl0gusREKWuS61Kg6paQBivUeSqCnakKHbzjdypD/Lkd6XN3punj/KAZb85GKv0lBJPigCsCXknZuTyw9FmNLxF1BOFcOTSSnhunUUYKr2ZSyQmv2YLszjLVILXJJkkGf6+m6BFDV147hu1JlXIw14gzr+eTSkZz+OHT/oihq0uqfBmeVYli+nOdkaUWdoQyNyrY2kamIWsDTvlFrE/C/2YbKHQJZ9MqvSVOEoQwS41wlHaLjf4Ks+4YF1ZVlqsB7739mfNxWkSZLC4sFu0ftwc3HHBKgc5BuKXW/WMVak7oZMGIj08yDQERoQfXecjYB1LH9ckKeaCr6fTO7EBo90mXEErN0OueRdjJfEmSxIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ew3x4YwNdqxODRCCR/GnLI3I857J2k74Afd8g8WFRo7vHCbLDWdHIfcYOf?=
 =?iso-8859-1?Q?ewTf69xOXaEcm2shz95LLqw0TUQKIDw0UjX/Xt65+Gwg0kw0GyQG5G/D2i?=
 =?iso-8859-1?Q?yiMLuc/Mwj7ArXfT8IafeuWlA0MEXTHeTBtyHYaYXcVkm60nEqTAooZu5f?=
 =?iso-8859-1?Q?Uc6+TccydSJrry5PyBB7iFEZ+mFehoSr5iHa+OGtzXuSVWblifPGRjBnEn?=
 =?iso-8859-1?Q?NSBs0VRqv4KX80esfswAcFGG0p8ANI2POo9Imk7XYfuQAChRp4qKtWcUQq?=
 =?iso-8859-1?Q?VOw1Co+qzn8Si4Jm+wmlfZ68NRgcu07aIMFdrx8ECUIMiqxCtIfUWNseJw?=
 =?iso-8859-1?Q?+DvvKpKj9DC1iAmA0Jd5qG12eawPSxD3bZ5zVWn2JHkk3mcwFks79i2k6a?=
 =?iso-8859-1?Q?bQGpGLGD9PiQnirQs9sZBBMQqyhq5w3JS23NLqio4USncz9RX/QMJd/4fT?=
 =?iso-8859-1?Q?FUCDYzkEFFU2JNg9RFwsRtvc8NH5NPSjUwJrW/Pny5lj7h+PYIvNWF1Eue?=
 =?iso-8859-1?Q?mvjH5lj0bbhS8kDTw4DZigxD5PeaPBL39zDwwuV0lLFXWKUQEPqHWt+mJA?=
 =?iso-8859-1?Q?Rqu/4LQf4ZK908ftfWxdsy68JcF4j5Zg3NcMEVeFwZbXy4oDNSUUpAKSwC?=
 =?iso-8859-1?Q?QJsDHDEsNvBMrAemSdMErFVutBGhmb+tD+VaqkSCNzRiYqeaiKt1z2VhFA?=
 =?iso-8859-1?Q?HBtuv8a7mOfA7tu2eHVP3+ejRS8RNYnYwe1TtskwEp5YblGrfToi4pMZYx?=
 =?iso-8859-1?Q?qUt0X8kFEnZ+aLu4bhi6rhms6hlsEY5iUtcR+/ES8TQqMVN3u4Ui54dxBT?=
 =?iso-8859-1?Q?7FJijxEsjM7XKYywR8dGC9XS20KmrfuOdb3Xd+VjMpWTgoZEponBjeiI5J?=
 =?iso-8859-1?Q?5NJECF4UiOOMLo890BhA9L/hbuszLa0yV0pNBR2aB80Fs9XkSW+TEuJX6S?=
 =?iso-8859-1?Q?E+c6ekwgHbShponzURZXRb3g4SVZjEpdfy6xTOTBqjs5gYXiVVme/MWKk9?=
 =?iso-8859-1?Q?SMKgFcijMzEaHkzdzTd3QF6dVAem6pHgBIj+fl1k+1JfY/wYeIs1s77SoX?=
 =?iso-8859-1?Q?tBp2tdDq7xBqjzPi1UEXRvQCgtpORcvcHMhLjRiGVHYKtPNfnEVNan8cB/?=
 =?iso-8859-1?Q?XVy+1G8eED2cIc9673Cng8RGAfTUynQnnUaRYgDioU1gLoIZFX+qfVR/Do?=
 =?iso-8859-1?Q?Fqybf2oywQR/y3WiLGZawMhvzcEfnBCmPlVrUBqRUFYmikSRZVMQnCnPN8?=
 =?iso-8859-1?Q?gbTVpddT0z+cvQ0z5UmlKLdpoGOwXedQdwoHSVk4nUTHtJ0cwSvce7JI+y?=
 =?iso-8859-1?Q?TTr+EY2In4e5UVtyESSgZYeAavCKY/3GfiXtmw3kbgJpOT5Yht7uA6vLBw?=
 =?iso-8859-1?Q?WpfHJrJzIgfxgUva5mPi4IrMdDeDen8PGNuWju8oHGD0omSbUHuAoE1QtE?=
 =?iso-8859-1?Q?Diypxj/0KKbI1EPOciCquA8sHS/0Fw/9wL0TW3o6h8LdTOQjBlMqfaTuFo?=
 =?iso-8859-1?Q?N4b+/bLTjv5nEBoIzDVKlGrNhT1Rpwy1C8TjKr0BBKZUPamjTMO4/dV8Ay?=
 =?iso-8859-1?Q?dfKbuTFXyBjU+My1dpSBESgWA7hzF1a/cNr5Tb2znjaC/6EW75/RoTOx3c?=
 =?iso-8859-1?Q?0KbWehfvgNKZQ/346YWqqkqBKyNLoKGiRSvdd2ac9vB/2L8DDw6EzbVw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90aec38-1c2b-48b9-9b53-08dc3931ac99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:08.9758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPhGz+Dw6YwYipMx4mogBzzbpndVbRHRn3jW+4Av1pr5/iJizbxf4ToWQfzSrGSTVJA++EZJ1AcDZe8MWokyFwaJpEOOyRsUjqBXbj6KuQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: NqADhgGPiWnL507cv5ogUFrxT_o_g3GY
X-Proofpoint-ORIG-GUID: NqADhgGPiWnL507cv5ogUFrxT_o_g3GY
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

This patch is the preparation for SM8150 support. This new SoC
depending on the particular pin can have different numbers for the
same function. For example "rgmii" function for GPIO4 has id=3D2 while
for GPIO59 it has id=3D1. So, to support this type of SoCs,
get_function_mux() callback needs to know for which pin the function
is requested.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/pinctrl/qcom/pinctrl-apq8016.c | 3 ++-
 drivers/pinctrl/qcom/pinctrl-apq8096.c | 3 ++-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c | 3 ++-
 drivers/pinctrl/qcom/pinctrl-qcom.c    | 4 ++--
 drivers/pinctrl/qcom/pinctrl-qcom.h    | 3 ++-
 drivers/pinctrl/qcom/pinctrl-qcs404.c  | 3 ++-
 drivers/pinctrl/qcom/pinctrl-sdm845.c  | 3 ++-
 7 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/=
pinctrl-apq8016.c
index 8149ffd83c..53042b6e05 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -49,7 +49,8 @@ static const char *apq8016_get_pin_name(struct udevice *d=
ev,
 	}
 }
=20
-static unsigned int apq8016_get_function_mux(unsigned int selector)
+static unsigned int apq8016_get_function_mux(__maybe_unused unsigned int p=
in,
+					     unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/=
pinctrl-apq8096.c
index d64ab1ff7b..8dcd171259 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -44,7 +44,8 @@ static const char *apq8096_get_pin_name(struct udevice *d=
ev,
 	}
 }
=20
-static unsigned int apq8096_get_function_mux(unsigned int selector)
+static unsigned int apq8096_get_function_mux(__maybe_unused unsigned int p=
in,
+					     unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/=
pinctrl-ipq4019.c
index 2d99f99e1e..c2c358f556 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -40,7 +40,8 @@ static const char *ipq4019_get_pin_name(struct udevice *d=
ev,
 	return pin_name;
 }
=20
-static unsigned int ipq4019_get_function_mux(unsigned int selector)
+static unsigned int ipq4019_get_function_mux(__maybe_unused unsigned int p=
in,
+					     unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pin=
ctrl-qcom.c
index dc3d8c4d90..de0bb4de0a 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -82,10 +82,10 @@ static int msm_pinmux_set(struct udevice *dev, unsigned=
 int pin_selector,
 			  unsigned int func_selector)
 {
 	struct msm_pinctrl_priv *priv =3D dev_get_priv(dev);
+	u32 func =3D priv->data->get_function_mux(pin_selector, func_selector);
=20
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
-			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
-			priv->data->get_function_mux(func_selector) << 2);
+			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE, func << 2);
 	return 0;
 }
=20
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.h b/drivers/pinctrl/qcom/pin=
ctrl-qcom.h
index 07f2eae9ba..49b7bfbc00 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.h
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.h
@@ -18,7 +18,8 @@ struct msm_pinctrl_data {
 	int functions_count;
 	const char *(*get_function_name)(struct udevice *dev,
 					 unsigned int selector);
-	unsigned int (*get_function_mux)(unsigned int selector);
+	unsigned int (*get_function_mux)(unsigned int pin,
+					 unsigned int selector);
 	const char *(*get_pin_name)(struct udevice *dev,
 				    unsigned int selector);
 };
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/p=
inctrl-qcs404.c
index ac00afa2a1..977f7b2ac3 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -56,7 +56,8 @@ static const char *qcs404_get_pin_name(struct udevice *de=
v,
 	}
 }
=20
-static unsigned int qcs404_get_function_mux(unsigned int selector)
+static unsigned int qcs404_get_function_mux(__maybe_unused unsigned int pi=
n,
+					    unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/p=
inctrl-sdm845.c
index 9f0f4085ce..64ce1bf15e 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -70,7 +70,8 @@ static const char *sdm845_get_pin_name(struct udevice *de=
v,
 	return pin_name;
 }
=20
-static unsigned int sdm845_get_function_mux(unsigned int selector)
+static unsigned int sdm845_get_function_mux(__maybe_unused unsigned int pi=
n,
+					    unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
--=20
2.43.0
