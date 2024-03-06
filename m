Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B6FC54798
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0100C87FF7;
	Wed,  6 Mar 2024 02:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="ZZJ13lBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A484B87933; Wed,  6 Mar 2024 01:53:21 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0CE87E63
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425GnAXD024399; Wed, 6 Mar 2024 00:53:11 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wp05yb9x0-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArmUSiJ3UCSBuMXYkAOQrn9nFMdBMQF+wdo6/S6OVMQ9x55/xrAaYiR77QekKMdshke+TbdrMHPymkqtiXRtq7pZN++X4nfgBlBmxL3dm2ZE7cXVV7qDiqymEL9reTqgI5GVIOKtlHuGiA63woVt7d+8d2nUU/bRoeIFOSeuKCWOq8btAmxENG7fYYYaaOT/AXwiGQo3IZbbdlzd8X1Wu1k8vC350M+EGs+xaK7II0fXEGBN+d1UrpV3myKhv/Z9iVvtFuh0NKBqCGOGTmsw/mg01zOAgr9ebqc3nyXg6xo5LvR8nnujTD3iGWtlH+MneP7RP/Yq99JoxQTGWSUKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q74QnOD5hXeNSh6W4iP7Jh/Z6V0iVP9KdezTH3WPJdE=;
 b=FPXKfh1pv15mmNBH9YrTEPomHz5hFXxnu6RXnbdU8rHPEZqC/ubX3gjLnyMGulB9RecAvR9IWYPIHCp25qUgaZ/+9xPoTrcTbnTuYGl8FvpFBMED0dh6yFnaQc/zql3QFa6DhYRUlMHPSs/N5T1gpc3zRjNM6g7aSfksipoRLrOs6I1WAYvbs0iHzHa2btRrLHnAnu9Nk7G8uHNyOuVZUHVFIasaiFB0TKo39sT0JkF1vzxrEhjlCVyJIA3lUsm3Ez8C7qQ3YIUE9XjUG2R99pupwaZB/VrghG0LNuMCYG+h/Wv8POTUAD0ILH0xwFbsnJgEtM0FsrVk4K2ugZVeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q74QnOD5hXeNSh6W4iP7Jh/Z6V0iVP9KdezTH3WPJdE=;
 b=ZZJ13lBQFJKyJ1lshVCeZiFi7iHJtYVyhLTdie6GwdOGEYWS+LjiCYWOfNi60cOrvgH2cmDv43C5GWhr0iV3hqgh0YmYOnSVYE5hlIhKarlXIpHC3db4ShoYMBmakWtur3CmvvysOE5z8rsZAQkhG+8Mbzc3UjmTcm5AJhTSP98KOx62lfvTwnhKhuf2T0EkLyZpSIjDH5gpR8/m5JZl3ICsN7SnOpDqwCkXJpBYtEMfhpaywckxppf50zyayCV8x7H4ppBR4ue6VtSrV4bPNwKwJ8ZK40PAY2HYZ+lc9TYA4S7iiSvEsqc9609R/KHEAQRUfg0kfpOTmUOkdmBdsQ==
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
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/8] pinctrl: qcom: pass pin number to get_function_mux
 callback
Thread-Topic: [PATCH v2 6/8] pinctrl: qcom: pass pin number to
 get_function_mux callback
Thread-Index: AQHab2Cjs8jH36l7Xk+Okoz8i9LP0Q==
Date: Wed, 6 Mar 2024 00:53:00 +0000
Message-ID: <20240306005230.2638972-7-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: c21164d0-0faa-4aa8-b9d9-08dc3d77c65b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3cTypZkN6Wkqa0viiWCes3fxR5CDo/TGWLKufpj2H8fyGlJRXJ5Xh1pp//TAmdgacJVWOukyF8xqZo71/Z+tCOyPJusbTGNbPsDAd6oP+RuSBxSfujL7cSgMFNieLZ/H3dWFBIuUlAyLDs3Moxwjb5MEu3CS5QVNtwMAJQOL3FDKNSzwSYa4e5Gu9u0X6jtpBynsX2a73eFe8CMxXSxJ4OWoQehffsMwnCO8Q+TUk40yv9AZBwAz2GSSKcO1UvVGkhSlD8TpGNq9l1SP6UmBpWwDHrIxAuNZzjyDMvVU/01Dgit1tlrJn6xympS5rHtd7HjQTo5MrJz8STThLcsIlGZlJf56NzXQVcvgbJjO1qN0kEwcLVWCPGyPypDMHXMJdptA23j11nDSf0Qw3MrCxW85HWx0+gIze82Kg4oUrGfwHk/uBjggzZ05IRJDKxoAp7soNOz6oe3RM4ACkfGX7yWPrMybeI8s180AIL0YWFP1SSUccBuUOO0kFtwgaedsi1HXzGvo3C0mUZWjGyw0cipopXFILKkiJmVRswZh+hfixR/yvJYFaqRlYBgj6sRC0VyP89kkchDOoNsX5Oc9vb+vRgRy41bgtA7MV/o6NcFkT7tP5CtTy4VjuPRqd+JiBrU9/R4vXLWVoZhSDJlKeSREUnIZM15moLZG2V68vXKLnXpYiJIbIgA8C5HZ7fLYxGfwm73jkf67NRSLS0Kww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/EqwlchL09N7UXzNiQ5CqBq+Bkd02OnhCvLRLjebBUKqfft4nLaWDih4EV?=
 =?iso-8859-1?Q?Dm5FQlcFVHRXbEeKVVNq/dEoIPbzGKIUVLL5XvonzZBTyX/wcEnJKIN4Nw?=
 =?iso-8859-1?Q?w/eTKWowt5xbGQmCwi9Z+caEqEkXJiJsOGLkZh8NX1WvjWyMPukkO3L9Wp?=
 =?iso-8859-1?Q?vK7EbrBd9dpqyz8BbgXW2zPGvVXIcdH22BCYcU5nGdIevWLSBrRkoL7vTD?=
 =?iso-8859-1?Q?fFl1fn15B0uq38uG0EG1QNUllHW4LqYtoPB3iG9X5LAPCbam8eqE6bTH04?=
 =?iso-8859-1?Q?kVpdlBbHzquhlRz7DrAUda8gszAhngbEh3duqCUMQ23avG89mh5xZ+O2g8?=
 =?iso-8859-1?Q?+8rZPET3nd9+TKqJDKS8RoxtD4EIkm/yooXNFf5S5/p7/NpdzCm/xW14Iu?=
 =?iso-8859-1?Q?49fNKPlMGhI8peUkAfAv4VjSC0XdHv9LhEJ5Ei8PtvLToSGVJw1um9VbsS?=
 =?iso-8859-1?Q?+/6SPAIBuWtwxBxpZO7xqls9FXN2MMUR4Hld77G1tJbFP4+Ksi6Yo6mxx4?=
 =?iso-8859-1?Q?pkOygHsuEQo9rsnWWeLqNsEWTk/zBIhYBjPAiJBhD8VtDkJGVVTJoGBPgS?=
 =?iso-8859-1?Q?6Yp9pDvh7QRUTY5/pDEmn+a3omSHQh+EOayaO8RMgYHGHTS/afGGSok7Pj?=
 =?iso-8859-1?Q?AS0+D4QGljPLmPi9TpLpjTM9xypEAwByZYzojLs2mrwAcmpRGCLW3z3aO9?=
 =?iso-8859-1?Q?bT8Y7aY9O1CqhaLyWtSEj7AODikoIZCDSN+W2g3QKzmzTyQ0z0ggUae6dB?=
 =?iso-8859-1?Q?AvVr2vCzmeldQl6f1EEJzySKEDapNoYyVNyNBoKXUe5L4XxhvNYupa21X6?=
 =?iso-8859-1?Q?xPwS/CEF0l7aqcLBXBPzMQHzRdlCa/TTYGWeo06ClWNHqFNdE1LBXZjvlm?=
 =?iso-8859-1?Q?9WmsJQENGHdtXDbr+n9MqtyOhwqaA0QACvh3uEV7zYUoN1RM7XW4gP9jCk?=
 =?iso-8859-1?Q?NWel+jHsarTrSamWU4KCbE08T9yyFK9nORMwHby08vFG/ZGZarLDR+GNAt?=
 =?iso-8859-1?Q?RtDlUcAX2v9Rbs43UbN7GZrw1jr3toIicb+iana7Gms44zSIVFePIbqT9s?=
 =?iso-8859-1?Q?trm2/y+oDZm4tmSxeqtuvKgQ0gf6ilegvTYfVN18KOOj1xGHp8vjjy7JuO?=
 =?iso-8859-1?Q?18dftEcEdUcbTNpJwehhmIm7t2D3RwqE8xFN6wk75Qoad/iw3ZPhVx031j?=
 =?iso-8859-1?Q?35l+whRIdveLdIPtxR+oCCqnARxciZ4yK6RWosFadJRuggKHpBb8NDf5Kw?=
 =?iso-8859-1?Q?E7JfbamhTJd/K8KVRSVIJzqGFPN9CNFQwzKEadu+GWsfl4mxA40mHaOjHj?=
 =?iso-8859-1?Q?4KUL7qJjv6lgJ6SMDRG6qN7mIybZhQC9i8YBN/c6u14QkhCclFcqhxIkSt?=
 =?iso-8859-1?Q?lznNAGKcb3exyefYfyKkTxi8zsm5zpk4cGvhkdybc0WN9E80IavIG3iHuw?=
 =?iso-8859-1?Q?pj74/DGPVVcN13yh75GD3BBsZDia1cukgX6Ot1cEBsuGaj/oMxXvexFUpd?=
 =?iso-8859-1?Q?5ogxHpcsivCHfRH+l3R6Ne+xZ9PSlQwKXAgmTRjNlLYn4B6MiAx8FPBtBx?=
 =?iso-8859-1?Q?kW6DnX46t4jknKcbmfTaBxUUiABQp0UD52FRB63RA5OrdO3rEHJAir//ly?=
 =?iso-8859-1?Q?enh/iioPu1Uii6ZrA/LI2qPzssVrQnGpejL17uCMJMIpmAfycZ69FGxg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21164d0-0faa-4aa8-b9d9-08dc3d77c65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:53:00.7944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/qytO3xDmB2Erj+JVXl/NeL31xxrcBlDELLoUSw/kFnB1um2TR6gzzrmZvCzC21Xxn/wWM6Kuht6vTJtpcDt3JsDpXQINtV8eplGQODmoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-GUID: YJmW2oLl8vfth4TjYdS6BQcppesmiMYA
X-Proofpoint-ORIG-GUID: YJmW2oLl8vfth4TjYdS6BQcppesmiMYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=991 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
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

This patch is the preparation for SM8150 support. This new SoC
depending on the particular pin can have different numbers for the
same function. For example "rgmii" function for GPIO4 has id=3D2 while
for GPIO59 it has id=3D1. So, to support this type of SoCs,
get_function_mux() callback needs to know for which pin the function
is requested.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

---

Changes in v2:
 - Added Caleb's R-b tag

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
index db0e212468..a9a00f4b08 100644
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
index 880df8fe3c..9697cb5beb 100644
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
index 74c04ab87c..4479230313 100644
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
index ee0624df29..909e566acf 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -83,14 +83,14 @@ static int msm_pinmux_set(struct udevice *dev, unsigned=
 int pin_selector,
 			  unsigned int func_selector)
 {
 	struct msm_pinctrl_priv *priv =3D dev_get_priv(dev);
+	u32 func =3D priv->data->get_function_mux(pin_selector, func_selector);
=20
 	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
 		return 0;
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
index 3a2d468599..4b7c670c90 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -94,7 +94,8 @@ static const char *qcs404_get_pin_name(struct udevice *de=
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
index 76bd8c4ef4..459a4329ec 100644
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
