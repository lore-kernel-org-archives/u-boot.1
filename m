Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA4AC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 21:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD02087DB0;
	Mon, 11 Mar 2024 22:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="OYeSkp06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E307387F01; Mon, 11 Mar 2024 22:33:53 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC0E787D3C
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 22:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9800dbbead=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BHvYd0015991; Mon, 11 Mar 2024 21:33:47 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wt25w9fem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 21:33:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myqItf7vba9kbBCtI3hKtwXYLGywWebMwsMnI/I4cgSvR5ie7gyNW1rf1g0X932UE21xrx/tNloP2u/VV1iLvLwR485TdUrso3XAprpZ+e9KU5NAUvA8nmLKB4WpKsu//1F98QKuomPzMlnqtdOYETQmqzHM8K8KXtSuhzUCmJ9pzIWxMhLlf4vuGDXBEQtVLXjn4CtkmDwA7bm1jVIlyMhVHanyU7E8t9Vbi/IOTZfGueO+kMcsisRoJ9NQSCRmE3rUkXI45HLRJV5l6VxXHl45oXUbmnhfiw6x+n8L/VYKxVPcNHAy5w0bc79nXeYsKIzMZc3bP/kfKY6M/wZKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xuKvut8K8bJfA7/ykP9jGuKGkOrqS3ZwOqWgAHHY24=;
 b=CQikB/cXZzTCIjl7+9b4ZP0t18eB+AHMpuHyo8yf7tCCabbx4+9BdjtcsazdOviZZJPg8exh3fzmsGtJpdegAIIcQCBafEiS8VYDXNb0Yrd5yC858u7P+PxzCwbEE/Fm86Ynw83wjVhSGv/6KmCibsgz7FAMPRgAi6AdqDB9GzFjVh1gc0cijgE02CdBWYOrZkHAd/GEXV1mSD+Tg0KM3zIcg27qc4BwrxWf0G67ve181teGr9MtB/jygn+sYpY9z53Za1teVQu0YSzIoq3CjIJmavBMn4fuhjlCwp+RxLQvvNdnnXEYN+TwXNYP/f1LmWABjF+XHyy++Rqwa3G2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xuKvut8K8bJfA7/ykP9jGuKGkOrqS3ZwOqWgAHHY24=;
 b=OYeSkp06lUOghYhv8n7KloemmMDxblRXcMoZwetiRplfp6avTSK7iLxaUtB/tCCLu7t8N3MX5j3scBgjNF+gce17F+BdAEJzry2SKoS4G5cytDEttvTV3sN1OpMT4x6hhngMZRi0ioQcCsgemKc8u9jdmaDvhuxpAizZx0XImCVTsh+1ftVOaNZ5YVPQkLOPS+qOPx82E3CzMa3cyEktD4anBEpXyCtrE1HncGKe+bGY4B4XIjx8RiOCC6/H8VlJJgl2//KAE4ik/fU386C+045SdP4GZW6u2mMdaoOqJsp49q2wC9tlvfTLsFu8HXe6gGq96FJYGyK+iejoezlOmw==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU5PR03MB10472.eurprd03.prod.outlook.com
 (2603:10a6:10:526::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:33:44 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 21:33:44 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v3 0/4] 
Thread-Topic: [PATCH v3 0/4] 
Thread-Index: AQHac/vLlCN5ZcVQikal5zS4h6k3OA==
Date: Mon, 11 Mar 2024 21:33:44 +0000
Message-ID: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU5PR03MB10472:EE_
x-ms-office365-filtering-correlation-id: add1fce0-a558-4e6a-e658-08dc4212edd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NiiIXHSR8y17oO8VYvrExMIqL8hKN5X3DqgZ4B3u4eF1pi2/iEm2Y4SHOjRMcjATyCzAdRgexSTNxqUzh3ma1sn4T9cz7FlygQr6mD3KhtDsG/jw0BWWHPxXhCD6FellcuCNxClCblbnduEN7Px4CtDbHR/kPjh1yyRbSzMStEYIWJmY7V79Jxu6Mh293XqE6b778eAuRnxiEwrKlhgqr1AkWIR4+hTMVCjdLTTOWSS2LoMvmyKj+a8BVNUa2fN14gzImnJTKLWT7+xOCQiTLFQ4w6uZxBBpOaVUc4d01uk+caqbF4s3hjMFZJGsY1r/BNxhvOXhdFw829XKXBjwvgw/NLNPwO97ZutsnO+CVFQA0eSwRpDxwmOqMF2OHH4K6iJqdDFnZxoeSN0+mEWXcHfmm/sluYZjshzjkFe6FKmmfsyNiHyPambDGkywbd1oUdR4ca2uWviuvsEYLn9UR0BTkd8u75N750TtoFkAcUJm2RpiCgMk3E7XpRp63YVqGa9zoE2e/4kagSHHG1xDpQs1FSD014I7XmwHUtYpvt1MdoD5ynTdseDyp4mEFe3EywS2tG0YU/BIvc8MS9wHQ0rKsGFHsoRPmq/L3TMlw72nVun+d1mOwTFLv+dwDfhUsHyhnERBq6RFXwTIprNobQisEvjKXqokzaE6f1rmraSlJrXKmIN4jcUGB4EDOiPf0WHNYdFqnDZ6z3+MJ3BkkkKXTrC8SlcQ1FGO+rSaKgw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?52G0KsREvPFgJaeVbzcXT3krF+g1UNywiwRPd8YkXaFqhdUAfb8rHqYtBL?=
 =?iso-8859-1?Q?W77TevJY44Kzwo9phr6JXegRyq8U5pd6O1d58yk3j0IEoi8VSB9HUn/CFD?=
 =?iso-8859-1?Q?gOUNKHbXMWTyK59kmp5ZLgCvWjQ4qjhFRarYjWdnX9p1AhoQqIqqLXm67u?=
 =?iso-8859-1?Q?T+HOTygegmYVBCazg7Y5rpOdcnzVZhw2O23dCcFUQvQYoOzpwxOj7tx4Dm?=
 =?iso-8859-1?Q?lTXKvRCpjjvTqE1lqTnGo1EtvYMlTwJ89Tj9vJlkfTmQ2/ce0FIBiaSZ0B?=
 =?iso-8859-1?Q?prD7IGr7GS8GM/cZYUdYiufeQpZEHnulcp7Iw+RKxD96iI56P6wPbNjvj0?=
 =?iso-8859-1?Q?xOk+A8RKlW9MjAk1PygfKD9wQ6ixJxQns2eCloo6No7HpB+W/Gm6Buzddo?=
 =?iso-8859-1?Q?V/YkH9243se8XAerFXOWIzHfGqi/Vgeyj2XlETZyj6Ecz/r1DA/V6DkPT1?=
 =?iso-8859-1?Q?8sdKLIIDwqRXHtjndiGsi5rAVRa2rMHD2qsGhMgqnD6YLL+mmQq4QTZv/J?=
 =?iso-8859-1?Q?PT1twH1XVXbh+Q40g4hQkhTD6UUY/Z5WJ+hY5v+pCZCppPpRDjwMb3vCOh?=
 =?iso-8859-1?Q?RWZ0HKSRSzvuXgYN84wowTu5r6Wu34cX9qvx8nLIcELlJIR2Jp0NBm78pp?=
 =?iso-8859-1?Q?NQ/WkGrUWzvyQ8jjkA1b/KMMkt/HCpq8vRfENCUqBSQBzENPha+8SDHZi6?=
 =?iso-8859-1?Q?y7+lvmGdHlW+TYce/WWJBorL9bkfNg4YaXw2Is5ydgeOOUQVOzQ1OeCb4x?=
 =?iso-8859-1?Q?cDghQVL5uM67n8NDHXX0bIyPhu1AzWQTJnbYGQSWapljTD+fUDFN9dZWPe?=
 =?iso-8859-1?Q?t1v+cAmCer9kRLEmDmMjP4rOn7JLXgAD6rFuU3g1WaXd4zo2PtZzuM+D0l?=
 =?iso-8859-1?Q?GxVTIkfg1ZfX9Kf7+YByLPZRLOBQEux9+0ddX4c+YMCZFb1p+S7o9BQit8?=
 =?iso-8859-1?Q?qu+sL/Iy9Q5y+eiBuCbUNs91kwf+T8dPWq7DeeSorD2DPi+rZOKAPMATJP?=
 =?iso-8859-1?Q?V+suNqq15kGh284jjEgGiRDiVXG9EOISuqljJkbJqs0uhmU9QlmDGUNIyc?=
 =?iso-8859-1?Q?1fLClYanlkkKVvK1ygQGV+ZmGmYQvjrqKXLGNErHeZ2qaVf9liJStdZpil?=
 =?iso-8859-1?Q?7pNig8R0VDzQXSJC6yZGLDQ5vXPRoj38i3Fpva7Gs4XlZiKlHn6yk9D6kT?=
 =?iso-8859-1?Q?WDxvds3NB38eX+3OXQoPlZwq9VG0sahJWYORMBBm/y/amOgFng73FJ3dhH?=
 =?iso-8859-1?Q?xxSuiY6XWLRJ2Lvadc7kluE0w7V2kLNkc8n3OeTU2bcQjJHAEBEyXlRZ08?=
 =?iso-8859-1?Q?cu5caXqXA8vBhF/YNdPyr+v0fY7EUxBkwRjOAOjBPmY6cXHKLii8AVzPOR?=
 =?iso-8859-1?Q?NZ6PErNrXhFZHZh8aDmzn0bwtKE++WHRBgEbY+xzJrAoXiBsS0XHh8uRgV?=
 =?iso-8859-1?Q?psUsbe5LVeM9Z0h51yDLVHJE9B5p9qDefKBom7B+L4ZW9RTJSXF7OaY+LK?=
 =?iso-8859-1?Q?SxWfRCkGbdZVQ8V5Ail6fyBN0bKg8uvHQSMCBFiNV8FTc+oTuuwOxD9e6m?=
 =?iso-8859-1?Q?u2xIB57eJyvz8lAiwsD+0Qj2JU6a6LHsZK84nOVoJ2kQubGQvniB29qa40?=
 =?iso-8859-1?Q?/myHP30qcGILefSvC/uf7aFNp1kVXWA6Mrngo6g0jh3pW8HNX8JHd21A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add1fce0-a558-4e6a-e658-08dc4212edd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:33:44.5907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcdbX8bcczEXh/O2qbLC4r9E4JrCrXWUd/6QGWZmNuCvNwXuudWCdhOJJ4We0ZE/Sb0caxtA3D3t+FNKtmQ5Hj5e2UJ7Oyd9wZMdyyd7QEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10472
X-Proofpoint-GUID: MPjxeKaLWqc6GVC8a3tYlUME_fbrazr-
X-Proofpoint-ORIG-GUID: MPjxeKaLWqc6GVC8a3tYlUME_fbrazr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=625 clxscore=1015
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

Set of pre-req patches for Qualcomm SA8155P-ADP board support.

This path series consist of generic qcom changes that may benefit
different boards. It is the part of the bigger series that adds
SA8155P-ADP support, but I am posting this limited set because there
are other developers who depend on those changes and I am not ready to
post other patches of the bigger series.


Changes in v3:
 - Replaced fdt_valid() with fdt_check_header()
 - Added "depends POWER_DOMAIN" to Kconfig (see note)
 - Use readl_poll_timeout() instead of open coded wait loop
 - Print warning if power domain can't be enabled/disabled

Changes in v2:
 - New patch in v2
 - Reworked qcom_cc_bind() function
 - Added timeout to qcom_power_set()
 - Minor fixes in register names and formatting

Volodymyr Babchuk (4):
  qcom: board: validate fdt before trying to use it
  clk: qcom: clear div mask before assigning a new divider
  clk: qcom: add support for power domains uclass
  pinctrl: qcom: pass pin number to get_function_mux callback

 arch/arm/mach-snapdragon/board.c       |   5 +-
 drivers/clk/qcom/Kconfig               |   2 +-
 drivers/clk/qcom/clock-qcom.c          | 135 ++++++++++++++++++++++---
 drivers/clk/qcom/clock-qcom.h          |   6 ++
 drivers/pinctrl/qcom/pinctrl-apq8016.c |   3 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c    |   4 +-
 drivers/pinctrl/qcom/pinctrl-qcom.h    |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c  |   3 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c  |   3 +-
 11 files changed, 146 insertions(+), 24 deletions(-)

--=20
2.43.0
