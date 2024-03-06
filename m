Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D69BC54798
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538A487D33;
	Wed,  6 Mar 2024 02:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="CYeuiqfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CE387E63; Wed,  6 Mar 2024 01:53:11 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F7087D33
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425GnAX8024399; Wed, 6 Mar 2024 00:53:05 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wp05yb9x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+EfA24fp1DAgjNFM3XeQvfpnNJzA7D1b78uJcAsz7tKONKd0kuMVOWIvCXrgEnyWN+n7eKA3YxhgvB2hR59fORWd6FSly2+/COJVJcnTUPwLeIp+HqA1dnsVD51nVcfFjhdjBGZrj+dR1fX0DsmEdkGyIu1+IfG8OZtDl8jFMKChXLQ6kw0qQpDbEM4JYbbfq0xX5gDc8BWrc7dBUwt94nFH7bk8yJt3aPA8wdKnhMPRF8mEhslDlHIa+6UoCqrNJG+zsTbR1IIvpMea8tdcmcVUjwArtN15xe1LrUkfMysgHKUkT89Q/ZpMPvr428/JPnnAdwbxEB5ztfOpwoy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzWSk2QLRT6qObi8oan8d1FaxPiK6e6Y2NIgKm4Bav0=;
 b=ECiO6V0cWovqBx13lNSAt6k2iGxRLKft8vD+z7Fb67tURbB8f73OEvZvg4x1+e4pTTsH9qjCtZOqWRT2Ufn7iUsE/3OrKF23TnX25a1EjaFdFzOkd1TeOZtdcvwYH8qfNDeE74mGXzmScWoIXLwTydtKJdealaM/DuUmaPmMaec6M3sRzAbYhk/7QosNkUIsoXm2CcOg41eUMO3FdpwLGFF9tXMHYKauwYtPdxi8ZQ+8Fhrcsdijr3Ki9TGeTBi7I4yFrxgP5slElxuju0D+u9/Mw19ajZY1m2aYW9V5iBOIq5K8YAdsFAGhKC7ZdhBrHTUaQ70viPoqo6rq7Zyj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzWSk2QLRT6qObi8oan8d1FaxPiK6e6Y2NIgKm4Bav0=;
 b=CYeuiqfNR1DKFm70Bpl1xZ2VzR6XXaqxjX81bBy5mgFoz3mAT2jT/dSNjLE2ilZQpLb+7ZpM1pJL5jzh3tcC/oEXKU1GLfUdpY6liBWMroEZ24JCh3giFJ+kjKcRDfgic4pPhu094KKjlQWx/i9njznSgA8Wg467N2X9mFBYF4cXDIBmNQ8faMQQQhxMkNgYFoBJxBUsFgqho9XPDOnrjd+s0mVJOngGnFYOJ1slDWaKUqiHp8hMvfeNuAOBsPmNq4OfS9/8VMipUTuibAb6zBybaYiyjZtXMp2Eaw8TTX68KReiWM1vazj/eLNiqNlDnJGXON7Klkv3ODxxIjRzNA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9801.eurprd03.prod.outlook.com
 (2603:10a6:10:44b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 00:52:59 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:52:59 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/8] qcom: board: validate fdt before trying to use it
Thread-Topic: [PATCH v2 1/8] qcom: board: validate fdt before trying to use it
Thread-Index: AQHab2CiqoC0w1K1wEqt3SsOay+2tg==
Date: Wed, 6 Mar 2024 00:52:59 +0000
Message-ID: <20240306005230.2638972-2-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: f9a6a399-58d5-4010-f44b-08dc3d77c524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yH11EhwlCAGJu/Xqkc6IabCoQ0KqtqwzNRPOqiBe5zipLE9sFfn6XoAPyTJzFbvIv0Te+n7A3L6rdqXApeCYe1mRSv1wBFFE7YeEp+0sI5ZHY82l3l8dIDppK96ohlkipu9GEwxC9+ZbLwwlNKmJ4Kdl4RRM6s+xs1rEAlwGfC2pVY9eI6x35SAA4HqFFmDOVS81ndz8KZgJgVsrEP+jlFVW+lHFkVhRzDmjgqLe1CqzT/diL+58w0ky+Cl7jNCfHU1s4WmRNnYmLn4Q29U6UW38U6m/LsXSaQP08VW/T4r4O4i7hfwIZD4IEVZArLZfeUtwlVlktsRRVkpvMdSl4SgL0oRPKKuzV1CBwe786z1cmcUBYYsjQGs0+e/KBl852kWixS+myOYJdFOD3JqUr3bsO6coSdcQIHXRZLBKaWzjEg1gpKtPq637O8xHEk01FQsfxNgpmnJklsut+wbvQIsHpPQkqF4gy4b4i48yI+vbbbkwAmo6pFlojn/Cg4P9R3uFRpk4OGxSxTykhdb2NroeDtlsgoyubhuTbf5bXaEEVzZYwJhl0RWAe1s7H27NBuv3JfHcPEziR7GJVnLpDjsQ8q3lrXi0X5wUADk4Cs9/biDUl3jr6JHoeVKwj8ecbdglJiLYzwLk5V7jOaEtU53UeDzFj6KsgreNYZGm33HFKKAK5fSvZSSRwCncU3Ue5UZa/SZonYP8b2CLVeiPn/6zVIJsOkrU2wquHyahUaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RVJeU24WMgCGpFvMius6KQmrAf6OqHS5Cvd/GWGOuGLJ+ODNXCeF0VyPZY?=
 =?iso-8859-1?Q?AHhGJZasf6OPujpahMvXsKSKF2QilRfaMiqIpImUz1DB6wTwIgFz9AP3Ta?=
 =?iso-8859-1?Q?wXVmAPDvsm9OXRCCjFtHMO7shoScUE3+U0qZnHPdNmi+U7Y6mkQP13t7GS?=
 =?iso-8859-1?Q?n0Icnmp2OEv1v5ptdd/yoMgY77C8fpW8j6SLe8iQgrIK8tfFIuhXsHoZXY?=
 =?iso-8859-1?Q?HjwH6pUiEzK310lxm4l6ywAXuBPcPsA4t4+FGDrrWCUF4dTXvoBQC4wChJ?=
 =?iso-8859-1?Q?hnVTQNeiOGdwvsM5MKOFvl4QhC/FHtddOx1whFIPs6iqfu2/fiD2f4Z717?=
 =?iso-8859-1?Q?f0EPizzpaZ5/UFpyzx5xjgYvi4QCLt8XtovymYvz8+VOwVN9uL+evBqK/Z?=
 =?iso-8859-1?Q?88EevANM/G94I9kF2t2IqdbgEP8/vgZde+6DjFyptu5A5iuB1QKr8zdmvY?=
 =?iso-8859-1?Q?8PyoBzdwEX8/XU1jNimRn4UikmOnBf1AG7T1zJgrMNYEuR/IKckTZVysVp?=
 =?iso-8859-1?Q?ilxssiHiwxZ1Ey0SsaXi9gSXn+L1bTZ9zPPySTOEUtQ/v8AjywjD9S5Hwr?=
 =?iso-8859-1?Q?T0P7AYPMvpl+dr19bS3pBmA+uU9qZiskkaokgqqR6UG1rNWjmLIqg8WwnA?=
 =?iso-8859-1?Q?y8pr5ED6cG4g/Ehak1vAGwopxAMWsv33j6vGflBA4eEunxPBv6yyxwUbBA?=
 =?iso-8859-1?Q?+cmWDaZZZhr/9dWaS6dGyqGUHF/ArWoYhe6XsR9ilCZxDj8yNyezAwjJgg?=
 =?iso-8859-1?Q?jLYkL1s2AVfIdNVc9PAngcwoQqf02jM68YjdmN407OYdx6DM3gW4pWyLfM?=
 =?iso-8859-1?Q?3x2SjBc/RqJk2JaSuWQM7ulaj3s2t8QSrV/KL61dWlo4pmxgQ4blGLSk1y?=
 =?iso-8859-1?Q?m0dsQTYXd9WhJwGmMnDmgU4QX4URVRjCKBX0GXVaWqK7uvkwBB3Ke+ocQM?=
 =?iso-8859-1?Q?T+U/FxBr7ACR/dtz923zYBSUltyoTu9ZrIm/K0WyWmEgkG/viZuTGwzDwH?=
 =?iso-8859-1?Q?fIkoEmrlTbEXXFVLD0dj6OyIbfQQck/HSnDhhT3MeQ3ypfZSOYcCY8STpg?=
 =?iso-8859-1?Q?uAsS+mVMhOD+DgDkochqUHMnIe/N1Ju2WL3rai4Z+vnSx0sVWjVUuhMn/m?=
 =?iso-8859-1?Q?mIrx00XKs5gODqGJjvfJ9cLWb5bqN35nb8MHf8GP/Es0OlS9rGXiIdBgss?=
 =?iso-8859-1?Q?dt8ONF4gVUHlnf3/ocGI813mclI+ho/24NSb4r2G/pST2r+9BSyy7SQK3W?=
 =?iso-8859-1?Q?r2HRmQS4AEPMdXeMIZwx35VrjdmnD0BJMc+xm8DDfh8z3kpF97FRx+6dJ3?=
 =?iso-8859-1?Q?rY82kFXfZv6JexsInpMi5FlyPUSBf2VD6FmPzhS1u5mGCt0/pnyRsg/kbq?=
 =?iso-8859-1?Q?d0f2GxXSGeaU1YJH9rGXuvltJpaYkEYJmWLSUrQjXQY9Vl9HQWCnLcuq7V?=
 =?iso-8859-1?Q?LtlC4QM+QeNbK021049cbtzNwCj64vBu9yifS5+wVa9HDwOo4mkOz2sNrn?=
 =?iso-8859-1?Q?nImIye+5ooRnv1rlSvXc/OeKyI2yLYVssSzVTJUXJkiqKx8NksUGwvNJ+Z?=
 =?iso-8859-1?Q?DS3OkMHgzMwT2dzrIjHImZZMJSssGvMdO+AVNrLKBVQqwzDv2dACed2iF6?=
 =?iso-8859-1?Q?n4uvjzOHpmeNMWgxnmTTwwCI4QYrZEtHQAu8MtP2oW0sSOg57vyg4Row?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a6a399-58d5-4010-f44b-08dc3d77c524
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:52:59.0219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Q8fWX73SZeBqhMZLHb2PDpw99JjQWzrpFiNb3YEfiO9FaVf0j7xN8R3Sm8PlhRe+hsR+Gk8m52UVAo1aPTMcpIXK+z5KzE6wUxYkOeoQm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-GUID: _aXCv5h-dxjOyifIXlpug68TdWdf6u64
X-Proofpoint-ORIG-GUID: _aXCv5h-dxjOyifIXlpug68TdWdf6u64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=703 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
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

There are cases when previous bootloader stage leaves some seemingly
valid value in r0, which in fact does not point to valid FDT
blob. This behavior was encountered when trying to boot U-Boot as
"hyp" loader on SA8155P-ADP.

To be sure that we really got the pointer to a device tree we need to
validate it with fdt_valid() function.

Note: This approach is not 100% fool-proof, as get_prev_bl_fdt_addr()
theoretically can return a pointer to a region that is not physically
mapped and we will get data abort exception when "fdt_valid" will try
to access it. But at this early boot stage we don't know where RAM is
anyways so there is little we can do.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---

Changes in v2:
 - New patch in v2

 arch/arm/mach-snapdragon/board.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index f12f5791a1..10eec47ada 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -24,6 +24,7 @@
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
+#include <fdt_support.h>
 #include <usb.h>
 #include <sort.h>
=20
@@ -93,7 +94,9 @@ void *board_fdt_blob_setup(int *err)
 	 * try and use the FDT built into U-Boot if there is one...
 	 * This avoids having a hard dependency on the previous stage bootloader
 	 */
-	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt !=3D ALIGN(fdt, SZ_4K)=
)) {
+
+	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt !=3D ALIGN(fdt, SZ_4K)=
 ||
+					       !fdt_valid((void *)&fdt))) {
 		debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fd=
t);
 		return (void *)gd->fdt_blob;
 	}
--=20
2.43.0
