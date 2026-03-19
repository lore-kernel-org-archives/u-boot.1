Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73EE109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50AC483FC0;
	Fri, 20 Mar 2026 00:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="EJYrYpCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C170383DC9; Thu, 19 Mar 2026 18:38:58 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5571B83D71
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 18:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Frink@ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J8dBcq3853770
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:message-id:mime-version:subject:to; s=
 pp1; bh=KjhhBbakLjSUq4AE6pX+KCL2m/SQa77d3gAVt+L+dvY=; b=EJYrYpCJ
 Z5bFJORwK4w7OR3dzdt/KEnOQuZIlsnREQThVbPicNTWHsbfujACfsbnmaSVcYwP
 63L5133Qj5bjC+hVlq8Vg3VnJWXldP2JqEUTmiZiqrp/WpJepzhedb4Y4MBniJcJ
 DqXG0+Y9/BQAlQ+Vut0IDlIb3h0kLo0yVrco7+0FmVrUFuvkcG9SokIFqvLk/u2h
 j7+nqJGqdky2o4WV2xkx4vju8vELsaVb7PgO5xKO92pU8RWxIqJsa8tr3rCaeqR3
 yu9G3K8pnprW18mPhN7DsfMnGufDqCuha/6KVkK4j/ZJYteoKWctLcUH2KSONmPO
 7zNVnPgZVn6Jeg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsg5db-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:38:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTQtqdwePpd44qJFFOZttn59vS75dKRLC96dUesoXIeu6BlLPfWB6EpNRmHCJf+rwJj9zXcP+4izPEHXA3LK9lFowZfExYagBpDYQW51O58c+THCIUMM5PjsMayOoKqD5zYXB0zBCH8mma4ckm9kXU1k3PnSxjt04e5RaPsDKeWHzNwCk63UerWdhA7xs8/7ph2+l4+HJrHt5W8zGgQy/FBm2CoFzEFLg9ZvM32Dvr0+nMirITalb53sXAimwUNLJ/Yge5O+1+C1E38FIL90oJW6D/1mkuIH+wdaEwKNweib2dWMRDriodM6VAhVDsReQWzIrtJR2xDQ7vXe+MQL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjhhBbakLjSUq4AE6pX+KCL2m/SQa77d3gAVt+L+dvY=;
 b=GzXji/VpaQcNTXdHcJFOecZaEQaw2cdH1pNMgS38nkwETUErNKSbZ1w6m1ybKHYmjIWRZ1F9PyrvxjxUvCl6VAIA85yby7qvK1t2GUgVkv7c/TDrnPSXKvT3NW8pYXv+9X86sAq0d745o4b4CiLM5ig4B+5uJojSJ90bgp0kncGGIxGU9Hzc88ZVd2zmGqD64azUdweDRDqJOTN6qqIU/weIr4kdyKVxKPj8IxQy3ofV0hvlsGyWCflCrJOBBwpvLRPkIdIfN+CyRODRXJ4/1+gQdPUY8smmsbqa5d/lUg/xfH4IhguUteboaV0bAiZK/QurWa0tV65HKpvUQcOUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from LV8PR15MB6416.namprd15.prod.outlook.com (2603:10b6:408:1eb::13)
 by SJ0PR15MB4487.namprd15.prod.outlook.com (2603:10b6:a03:374::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 17:38:49 +0000
Received: from LV8PR15MB6416.namprd15.prod.outlook.com
 ([fe80::c4e:1092:4441:53cb]) by LV8PR15MB6416.namprd15.prod.outlook.com
 ([fe80::c4e:1092:4441:53cb%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 17:38:49 +0000
From: Daniel Frink <Daniel.Frink@ibm.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: George Wilson <gcwilson@us.ibm.com>, Chris Engel <cjengel@us.ibm.com>,
 NAYNA JAIN <naynjain@ibm.com>
Subject: RFC: Remote signing support for mkimage
Thread-Topic: RFC: Remote signing support for mkimage
Thread-Index: AQHct77beMUtibAM8UCS7jFnDIT0HA==
Date: Thu, 19 Mar 2026 17:38:49 +0000
Message-ID: <LV8PR15MB6416D60889EA3D73880A85688E4FA@LV8PR15MB6416.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR15MB6416:EE_|SJ0PR15MB4487:EE_
x-ms-office365-filtering-correlation-id: a2db66d5-eb64-46e3-89ab-08de85de614d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: AkVKQW/LKpA70wFiJlrrJjpSvL9NOMpvUnGaLlI2rFX/JjtOKXVoAxB1WtZ19YVw6NRs1BnXmK2W4NSimNkN70MvzfBO9QkaW9CAR6qkbagOVQKWZVNQpP5+uVYJVPYViMW0L/vbn5cOkCneSrrKS7rqkxL4Du1YPQHiL7v1NGxjqwid3PdEepDP5Tcu/dRJz+50fIVX8XTNZNO4gRnlCiBEvJSP1m4NLPsznYDWPID09rLq6FlQGKPp1wpFiz6NrKLhCTA8JTuv4NRS2FpbvyyVG4mwxQLVoNqWBrHC+t4JneX+tvn1FpiLYggEILLLpQg7hf2Nl8TU+U4qDTsXTni7VeXUIp9/ff6+2FKsQA6uZ+LR8MNEBKCxXVmH4cJzFOjOJGQCXWzee78rv82amIVHCRfnIlhEaUxmOeH4R4nlnNhmT67OKjYPcKl7qTiH14zaXzHDbzICADNA43FOgxPQB7IzkOa2748Re1A2+Wn5pueyGRzaPUNrHnxTQn+0nppqEb63SevYkXdh5jVLlG9+XZsY8lZYdAmOEG9EQHOJnnWPaZG5CMla6Gsm5OfYO/iAKeTnm3ubf+IuGZqYaUAG2DGcnJ1y77TidIgZRa83I8fK/gwPeByCAQcX1JtbQCOkPUpIznN8HJvEVaYgF9UB9kNSZwrStTMDNTdlk1hb6PQCMc+lwCd/JPrvqtF4UFLf4btA8mnHidvvacL7ZyWL+mEKDyTxH8Y3kgyDynnLWPIwYiT0dLIk3+cNRsLzg65UFG832B7dUYYTdwvh10tWT6en35fGA35qRY/Nc/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR15MB6416.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?0o+KqJOq9MVjSOe8oBJPxcZAYXBCfF1hYIUySVuy0jiS3B5tr0MPnev8?=
 =?Windows-1252?Q?/w/vuCzTnJC9FKpHy5H1UKGjjLPlWLn0O+cbzAZq/QFlFub2YOfdGFQn?=
 =?Windows-1252?Q?GzQVx29nZvthZLDuiuPEybkboE6mmJkcgOKrorHLCZgFlolOk12GvxxO?=
 =?Windows-1252?Q?tQlw1faXUHi34jC1p5HETl33C6scwkXP0sFnX+TKDZGTNp++FgL/ktAE?=
 =?Windows-1252?Q?6W7rxNLvX3CmQpBddIsJwBjxUmM08DxKPNb3ZubHn2MreuQIVBz4HGgS?=
 =?Windows-1252?Q?3cd3dkDTpJhunHgqlQ4+HSS3uBiqS6s2cVEOUbAvsJGNe2SSCF99Mtds?=
 =?Windows-1252?Q?vvR0gL4ppoGMR6m7rkulDV6WQco0KzGFfpZJOuG599KIevTHWgG+lWBn?=
 =?Windows-1252?Q?fBANt+vERG6tBWsyPwwpnCUxrzT1NqwItfoXoXE1Hm3MlHGnJXGiBv5z?=
 =?Windows-1252?Q?lRaDYPJielDQYGWkpe2bMqm+cKHVdL3/CcShKnjivPrA+dSWrjVxvBXz?=
 =?Windows-1252?Q?dcevMI0FUXrr7//qo2IPV1XWgVo+5P4SGeQaDD0lWBcXVEgwdd3f+Goz?=
 =?Windows-1252?Q?vUd4uEpAmDZiqCf7vUP3Wtv04cfHAIylnagKo59h7OtH3lq5yUtvS/uR?=
 =?Windows-1252?Q?kolsruT0thZWPOmHKQspIMNahuOJSuCVkgv13P1qWGx5wF2bhvLMKHgU?=
 =?Windows-1252?Q?UFnY8KTmMj+aZgerQQGC88hfNKtDtCxuS9LJg4CCiyaHW8QEO4tgp/YK?=
 =?Windows-1252?Q?lzfj+rgtwovDLgg1p8TqAQIAFmDlWnWigXCezMeaZt4qzURgWmpSalXe?=
 =?Windows-1252?Q?reAEqTn7nVqdfSHTxj2kQLr5TVtyqGEeXaWip+7jTRBipLnlf9C/i0Vm?=
 =?Windows-1252?Q?d5Diov+E6YHcjk0SJXfOoCHsWni3Vc9VFTOVQ1X8Ew/q8R/TdF9FoSU/?=
 =?Windows-1252?Q?qgQvTQ1t0kl85ZplApmJnwtiWDGfjJChEfh2TARWzjApbtrXMEX+TjgT?=
 =?Windows-1252?Q?C4y1axx0VlCfDK8fpYEDO9W4rsi97YYqm7vAtCOWgG0YJ0adbkEBs45D?=
 =?Windows-1252?Q?JhC5shOvCVxnTQXiVfOiabd+uWUwGpO5lfuoccLnhEvxQEMdq7Wpdtjw?=
 =?Windows-1252?Q?ip9dnkEl28l+1rm5Zr/5lP14DRfzWqchl8J6PtgTroq/koeGTlsBqLER?=
 =?Windows-1252?Q?2ckq2MRmkj5Mf9mVmi4xKakqzIlAldn5NztdfRiF5XbMZpfSb1jYMwV9?=
 =?Windows-1252?Q?GNBGj/ui3QKw09p2orrVM1lNdlHw4sJUn6WhovZmJRc+rypgE1xwnu6Y?=
 =?Windows-1252?Q?n45PehUuAnKH9VlgDrdjWKOrjoiSnT8yX7o7Y13XWwDMPxtE0zqe5QtI?=
 =?Windows-1252?Q?Qxuzp1ahFELN74tcfhUXS/hjTBqRSBOzbzIi3AEMS3AM1jmWjH8UgZVB?=
 =?Windows-1252?Q?n8riMSCpD2alsuVZxqKWdCFaSjIswt7vgQQblOAmfj8Ewax9mkwHES7T?=
 =?Windows-1252?Q?9LYeLdQ2scnw2zQjpjHNNV+Bw9R1tOPfD2dNwdGDpZrCpFAd6iyTZtvb?=
 =?Windows-1252?Q?qJEr1Jw3vlAAXevBVENW/w7p7j1e/tBoStQ2wqCxvRDCTTEiDGTo52P+?=
 =?Windows-1252?Q?GG03A7Oi3NNwlUgl9XuJkoql5PMQ/DovXjoV9lIKrhCQZPVH/eM1ShqE?=
 =?Windows-1252?Q?3GHvdO86BBmMdGfGj6UgB0We7gev1/UdkpyvlK682cycn+k5+AjFavnJ?=
 =?Windows-1252?Q?7nW9Nr5Q/ybTQiFygMO7rnrmXcdCxmSDgphSGAthFRwYYF5GFMF+cCvl?=
 =?Windows-1252?Q?umMQFIR1ngH4NplJStsrfx0HFdqGXKBKAd6EFS5zoLFuBA1bCAlqjSZY?=
 =?Windows-1252?Q?08roDCGYRZatTg=3D=3D?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nTARRRgZ69XgIhQiKrdvrPJ0VeJLtUSgedOknCJ4C9rSCZtTXEaCRTgGutB8aC2Hd48m+lrUsGyJiWbMENvCwNVijY916Vhw6NUWRxtdrOX8RemUpR5/RllNSWXC9jc6a3xiEXlS6l9R30+uBU5W7yqRChJ9JxfWieZGtmsBD/rqxz8nEoQ/kGwDC2wRKr7f7X1OWA27lac/Ildh1Se4z+xOD5QFhNuMhrpHx9JtjuIV7rgqBp+dIojubgF1vYPVomrO9mQFOwuZgFHMAfJR0OeuVsbGxasHI46PIQ2s53Tx0mdPgCxNV/5evVsBoqs2i+Md/aiuSo4p0nemYsHDbg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR15MB6416.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2db66d5-eb64-46e3-89ab-08de85de614d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 17:38:49.4255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmeEj/auCEgtS9Qhn3MqladctddoP2AxgzDqzPJ9/ziPyNZ2DIPIMFEHb7ojupEuCqBpXXHlEafdDMeGlexCBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4487
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bc34ae cx=c_pps
 a=mt+QW+PagoHSMqpqf5GGBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=AwUmBXpErqFXrdjOMcYA:9 a=pILNOxqGKmIA:10
 a=TSwInww0fiNdrA1B:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: -I_ND6wYuhjE-K40_0c2MuohdPr2082b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEzNyBTYWx0ZWRfX1BXmsXQx/MKD
 /RJPxbVXPI54aB67q8T+XBICHU0sqGvAxuICMFb6CH9jIg+Hl1nhfRCcizsYYkKx4Su5o7v5ocp
 T6GQRnmn2cJj9Ucn9EA397FLrBc7CmE7XSBe18KgQ6P57sb5P6SPh++YFVrqSDcmOBoe59oDqNs
 LhxEQ0ncm8ZEjZaQAm05h+UBFq/SzUZh4eVLTq0UgAwiERdDF5MK6quF6qbYiC6rnuR1O/yjmqN
 m5FbgU1UegZ4nBNPNivJ80rJm95fAPaxhr3iGRd++UOU2XUAln8UZTzCU6c2zHiz3jFUCvYG3kG
 TbGLLHSFPpMTnE0yHPm8xpUepkZsr0d/UblPFFKYyJK2JiitgHK5QGaEOPBuVEVw4uapdwkrU8N
 IWInV+B2jeKkINx5zpGGN6nl+qe2lpA7CNUCQCn1FFOKal2O2WysLqq66IhwDXFM1XPgqYvM5Mf
 39YGCONjhJe7IkcnTcw==
X-Proofpoint-GUID: -I_ND6wYuhjE-K40_0c2MuohdPr2082b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190137
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

I wanted to check whether a patch I'd like to submit to mkimage to better s=
upport remote secure signing servers would be acceptable for upstream.

Currently, we support this capability via a custom PKCS#11 module via an Op=
enSSL engine. The migration to OpenSSL 3 (and the need to upgrade our libp1=
1 dependency) is going to force major changes on our end, as newer releases=
 of libp11 no longer reliably support signing with our OpenSSL engine/custo=
m PKCS#11 module. The libp11 maintainers have explicitly stated they only s=
upport OpenSSL engines on a best-effort basis.

It seems to me that the ideal solution would be support for a 3-step signin=
g flow in mkimage:

1. mkimage --emit-hashes =97 emits all hashes that need to be signed
2. External signing tooling produces signatures
3. mkimage --inject-signatures =97 signatures for each hash are provided, v=
alidated against a provided public key, and injected back into the image

We're aware the OpenSSL provider system is a potential uplift path, but we =
believe a tooling-agnostic signing interface would be more accessible to or=
ganizations with diverse signing infrastructure, avoiding the need to imple=
ment and maintain custom OpenSSL plugin code entirely. We'd also prefer not=
 to resort to workarounds such as signing with a throwaway key and manually=
 extracting/re-injecting signatures.

If this direction seems acceptable, or if you're open to the idea but have =
concerns about the approach, I'd welcome your feedback before investing tim=
e in a full patch.

Thanks,

Daniel Frink
Firmware Engineer - PowerVM Security
IBM Rochester, MN
Email: daniel.frink@ibm.com
