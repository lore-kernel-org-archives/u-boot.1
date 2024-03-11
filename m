Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3328BC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 21:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C18087E32;
	Mon, 11 Mar 2024 22:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="kf1Zqz0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B0E87F0A; Mon, 11 Mar 2024 22:33:54 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC9987ED6
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 22:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9800dbbead=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BHvYd4015991; Mon, 11 Mar 2024 21:33:50 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wt25w9fem-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 21:33:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+VzSUj7ZSfnq5ccUk4OSNZ+xAKRiEc2EhPAFsK6yNhRbdpkp5XRBXFM/54D6s6gkusV7kCYj/mstrjZyP6PzQmAhN/gJcC4qIsVUmAHYOh9NZDBFxjAt8yfQy+CMMeqfZ3cmsrCZTW6bJfPfmMCEh1Upw05wZMSp4vSMk63yXmcwr0NCx9DJk+c79h+7JW2Bt8oCOlkWK2ST8iX5F0yD48g0QCnbY6w5gsDeTNLKesNsAwW9MVXOGSfeLIx56q2ogBKFzaOh9krMMNbz7D4afCKCG678MAnSoQfJBFjlMorgq+MnkYq+jDtaIbFtoqFwelT9YEZL3tK6SkvYyua7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KkWY97M3xCC39/I435uv385jt40/m0bMRFD1dE7s+o=;
 b=FpJ62D9hizEhoUIIzFbcFX5ZhmA1IbiQ94OQqUbB4G78bz6VeaxDOEniZwPwnUyuwE9ulWHigNfVX8Io4uJQGaUareDiY3WnG/pLAv9TmmMvM4Zppaq8bwjQV6DMu1oXhrhp24R9Vw2wwlFfREq/u+hJ2GyQ9MNFTWifYhMxjwlvEysAyaxf0EVfvenn0d5nFvvMgSS5JHKWHjJg0+uZN1VA+OV2deWzzwltBEKS5b+9jTX43754BVGjzi455S8759IbAz3Bp7uqXjRMW4JFkIYCEsOgVhVxWQfYvX0pHN+fY86Ju8XfI0S6P02RBRFUClgS16B/5CrHdV5uOGCIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KkWY97M3xCC39/I435uv385jt40/m0bMRFD1dE7s+o=;
 b=kf1Zqz0vAALTh+/RxFqt1dR6HXOQtW6wRrPcG2iBYkZbR6TfJYPy+CZlxKYZfuMZJHQS1K3D6YNMP2RqKiP9YjZmsMGBR83Tw582S04UG7GfB+9yK7fR3/WRNLSxO1imGrjB/jXvGmes+bHNW4I7po/iN3U9rh2hwxl62TCWb8ePZ6sJlpbk826q2/bzxXosiIi8jfhkRNSQc/VDIAv7/+686/OUk4TKAzC080eTEK1P1TeJ7DzS6n2jITjlg1q0m2/UBT/EN9Ea+kbJFI3kaLvJf3cmj5MyRmJsVZW855t6INRXBnZa4XF/tCppmid/zwZrV2m8vAydlhSgc2M6tw==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU5PR03MB10472.eurprd03.prod.outlook.com
 (2603:10a6:10:526::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:33:46 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 21:33:46 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/4] pinctrl: qcom: pass pin number to get_function_mux
 callback
Thread-Topic: [PATCH v3 4/4] pinctrl: qcom: pass pin number to
 get_function_mux callback
Thread-Index: AQHac/vMSxTbLp2zIU2uTm4nVZEnag==
Date: Mon, 11 Mar 2024 21:33:46 +0000
Message-ID: <20240311213334.3567389-5-volodymyr_babchuk@epam.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU5PR03MB10472:EE_
x-ms-office365-filtering-correlation-id: 3f9f7ed1-4be0-42be-32c1-08dc4212ef16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: piHYfaztiKWJvGep13p2xvcgXkBzuNNYVrFbzIvsGOQmFsf0/zIQX0XzsiaOUUZb83vz2PYEQgACwoK/2vhbP2rmr+7l5YWkA5JWxw71+K0WTJxAUAOex1qqSoCjz5X1RSNxhocRfHnLgAYOqg3becUcyxL0Bj8iezIHpwiyfrk0Ab2iKAl1ZMZi2EibetSMFF/Y8FP50dHS2nImwb3fwePQc67nKeQ8uUpPTEIClrvwibpKQXpUcCkLK69idNzjq5Zu75zXBSuuk+hRlMPzDarkLwjYIysgIub2GQtoAKQo5jclAJ+lcYGci54rugV2vZsLNhSuD3nx5N8+nj5DoVDBmDna9y9QBImYWtVoyDvZ+9gD0YcKCKptptXZC2OAd38NTlrRG8l3jGwnBUZ8ODRFwoUcOmuK6xzCue4o+NRKJzIxgF14pCAvlxQfeqcxDJwC79SqpDMmF/6TvBxHiRuslBUa6qEWnQuDtGmNxnOvLpM5lLM+uozWkJg4rMYosUtk7gAsCvZ/37tW6lXlAlPQIamHbj6Yb3z1qRYGFQOwBiw/Sg+rfwV7e389lcFYr2RMBFY649+S5si0/HX8NDX++8ArnxGn0NJIBOGuPH8Ko36W3SVxv3OkpKa1GM+6N37z6RA+fjphwqnT63Bi6HHzdhbanhoyU7YwY2YEJ0menVi8J8XVdnytFq/Kv/QSwCQs27cJsED1gDvRVzqBog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UJJ20WvA3zVC3CQbuZ9sbS8UVVMPQkNzGAwyOxMTndGUCOyqed3gkHyUNv?=
 =?iso-8859-1?Q?l58O+LsrCXqR4Dtdfs9XZFNMYGxKxt0RnMwoFritQ46QsUgBDt9ECF8/+n?=
 =?iso-8859-1?Q?Kqx/kEaPvnXnvI5qEDKTIMnOb7G0gZCJ77m+RXkHjUsaxrv6O+jV6HeXcu?=
 =?iso-8859-1?Q?8fzE4LbpltQ4idwWL0fT03SQ+fHfNTgX9sdYmS2DmKVold525jQFixJ3kc?=
 =?iso-8859-1?Q?UfN4/49QuY0EnlBUrJQqLq0/H0nXVOIwZl3lFEBN6wBGwxv7KbCqHfNREE?=
 =?iso-8859-1?Q?l6x0AQayg43lL84h274Py2RH4iKWYypgO6SVaVwvnCnYbZFkcev2NCbODk?=
 =?iso-8859-1?Q?KEy4C9RLVqu1StgDWfwgw7mBX1sUnffIRCtut5RC0hctTCjg2fALn74q3k?=
 =?iso-8859-1?Q?3tFq6IArHta2iSrn9NUhQHVi+9Ixhu4Jq/8xDcFbLwBfWjWPfCi7VIhpdR?=
 =?iso-8859-1?Q?qeaGslUGkVOqqFApVuYEHUQ5Va7cxOcPdshC2iZgWOCHfBv0gZhGQTk5zU?=
 =?iso-8859-1?Q?xCT80+D+bJhzrRjQCvWTVhT9nEt3td1tFGyinZ9EuWLtQUNSwJmyBHIU6A?=
 =?iso-8859-1?Q?Wgvoj390r/fF//BriYlf/h5vD35+BjSgnZwyXL13C2NrVfEfTQDX/ktqz7?=
 =?iso-8859-1?Q?KS2B9JIGjrw3hX4L6/6q5XC2jgeFCWSoNz1CFZAFDAsaI1Iume/wqVlpNl?=
 =?iso-8859-1?Q?86AMYLNXT44IO8iq4gJyDGy7trsKnNZjMobjoGW8s6NVFa8eT/AGPV14Yf?=
 =?iso-8859-1?Q?fMBdaaZpc9GA+0WyB7dRTlE8yCAiH4oUe1AvOPrTb/XSoOz2yKAFMetdCo?=
 =?iso-8859-1?Q?VwN4Cm3F3K4bnXnmvKW+oXZfCQGzPSKyF42tH75LrCbpyE4KKqOIT2v39H?=
 =?iso-8859-1?Q?uO5UGSJBVA8HJLlRUo8TmaXtnz7Nh9mQbOB5zy7/MX2cwbiUkEHgjSS/Ac?=
 =?iso-8859-1?Q?SIFtphMjkZ8CvGlILnxsuPQ9kffieqw65nXAR7gupyBO/hjs7xeju/BUJR?=
 =?iso-8859-1?Q?h76k+38OkgUmm13BOO9FIVRFu9pFAknm23wA4oYoJLqvmk4KNMVETYmkt6?=
 =?iso-8859-1?Q?dB1AtWh3+nu/55COA9WZqFsCo54inYw8qtSKec4nZW2j1ZqVd9onvYZIw9?=
 =?iso-8859-1?Q?7WJgZSVRKfmdTFyKPF5xPD+dqd+Pv4lYy0SV8a8VuC+tk/NlHE48aFeseA?=
 =?iso-8859-1?Q?tv63rIAtA8f6gT0iw9L/zLsYwRQ5kkvEjYU4OyLiY046EZDM7KESD/swMx?=
 =?iso-8859-1?Q?xWmlAmbHcB7IwpA60Pjb/0YQV5HmzCGRhmlsNWrVgQgygdxjZcUdKSk7Z1?=
 =?iso-8859-1?Q?nXGzI8bK4Vtv/HjbSRVyhLw4DUN/MqsvwgMrk8EC4mXoaEJWb+XPD6xptR?=
 =?iso-8859-1?Q?B2IUsbSnyCQKFgGnvIbcixOdWFdvE8/pzNRTE0ugcP96t17izd37qriS6/?=
 =?iso-8859-1?Q?Xk+98qfblh211wHLyjcBQ+MnMbEuUNfHFiOQtw8CqbRkGW8kMe8sOuxfxr?=
 =?iso-8859-1?Q?QKdj/Yhdz+JM4cUhlzx8VQSqpXxfAUxGceb482fZrvYj2hSTJ7yM4OSq6C?=
 =?iso-8859-1?Q?cpi3WA9nDAvOSpVWCFgLG2hlETwo2QJD5BFDct1RQLVCgJalPGoYobXaIS?=
 =?iso-8859-1?Q?Dq8hGPKlTFdpMYYOR/dNSJdHTYYl5hy7b2iP8B9g/vwCdb9i04tO4bjg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f7ed1-4be0-42be-32c1-08dc4212ef16
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:33:46.0932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uh+s96tvUMzN+5iCJHbGqT/6oUAAIDekjZTRUT2EE2uB6Ne2E97BQ0DOXOgvpt8V70MCnnmnLnWgrJrpNj+NWa3JG/ZFQyfGWjL12Yrkt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10472
X-Proofpoint-GUID: mW68KETEdIaqwXMxFiYcle_z5JSvKm2K
X-Proofpoint-ORIG-GUID: mW68KETEdIaqwXMxFiYcle_z5JSvKm2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110166
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

---

Changes in v3:
 - Added Sumit's R-b tag

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
