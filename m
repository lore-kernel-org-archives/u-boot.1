Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C4AC44524
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 02:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EFF8607AE;
	Tue, 21 Jul 2026 02:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQXnukf3_TNE; Tue, 21 Jul 2026 02:56:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB99D6066E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784602605;
	bh=i12oTSOvBd6eKVmyctG4QEusUPFKxi5FlBcKLTW1+j4=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=N5fLjy3Aydg6mkJL2ZULpI7GLv45s1FBMlQmC3rPZvjrx27TF/71gS28zeBrrddqQ
	 UIsYFcZOeoyFK59gT8/WDrljYH4wPeYt7V+9QFm0XCYHyK2mnlyx+Squa7dA85Yy3p
	 hZu/yGMAmU2Ndq323TmhpZE7iPQFadiVOznxtclmF5mk15JQz0wb1RF4cjSBy/26+c
	 vJudvXF/cWqa8HfNcHShYagrtL8abjFNKS5KxYny/at6zqxcJdrF3A1i/bX/bpGDjX
	 tW5BPp0vtgvFVdjbCqoCppj8wfMyi2OCaUWHUxfYICo1Y6eLbCm+MZl022DDldHejN
	 Qdigtb2d4lMJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB99D6066E;
	Tue, 21 Jul 2026 02:56:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C5401331
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28C3840792
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gpV8BN257QbZ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 02:56:43 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=boon.khai.ng@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2B25640785
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B25640785
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B25640785
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:56:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED22846A5; Tue, 21 Jul 2026 04:56:40 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF3682991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 04:56:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPYghcrgp/lCTZHu5DvbfdHTtE51Rd7PkLV1twiVpDtK0YAaToWQb9VfyJilHCHKUccK0lBEpx72h7a09doNhi0e/RfGSpQXhFg/i3ZbiC+8LTc/Rbcn0Xw6H8smFru40jiF9CgxcrHKFJaxAT71wSCzfkNs9W7kpxlcmI4oMebtgKm0xwgcojzKfcgQX5OL2+RvyBVmQURS96d6F7j2viLmElPNfy4VwZsZHj2HrV+TqDoclST22eNtvmkUQy4lai3+SFuO7vB56Foao2QvdIkThpD0dV3HoFHqnri06g8cEGclHMDD/qT4qORjkmGmMn814fayu5GBSEXjtWy4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i12oTSOvBd6eKVmyctG4QEusUPFKxi5FlBcKLTW1+j4=;
 b=rjlTDVuktPN1PTezCwUXwXb9GOp7seqYXNGpjFKbMfy9HaxyKcAKX9y5IFPBb29jGdoyXwfzpLJhDlU5YH9fXCrr4WkFGHc9XGwc3mZSNPk7BsvKMFmVpCB4La4vfNh72WYIPeO8L78gWsenB3hRs0POcge0eHDUAux+9q0aFsT76+IV5WpavKUJZ4Rm7RfdFgAWXrgsVeSRzP6b1iBk6zfClaHu7INKy4r2IDGNDKWhT41Rq/OKVyIX9hDlz+v6rUthT0C6WJa8U7j/kSwZ5E/MN0nfrWhoHoFTOraZUBjIndg07ngLZ3HZGMp0xYOoNMTXBafJKfAwLN4V4Wl+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN2PR03MB4943.namprd03.prod.outlook.com (2603:10b6:208:1ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:56:31 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 02:56:30 +0000
To: Marek Vasut <marek.vasut@mailbox.org>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>, Janne Grunau <j@jannau.net>, Mark Kettenis
 <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, Tom Rini
 <trini@konsulko.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] usb: xhci-dwc3: Call xhci_deregister() before
 asserting reset
Thread-Topic: [PATCH v1] usb: xhci-dwc3: Call xhci_deregister() before
 asserting reset
Thread-Index: AQHcpaDgqmVUfZEG4kqSet6iemlXGbWWdliAgOG243E=
Date: Tue, 21 Jul 2026 02:56:30 +0000
Message-ID: <SA3PR03MB718757EF71E7CD6F2A16DA67B4C22@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260224151828.20838-1-boon.khai.ng@altera.com>
 <321c50e3-2557-4b46-924e-13e66281f1e8@mailbox.org>
In-Reply-To: <321c50e3-2557-4b46-924e-13e66281f1e8@mailbox.org>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-07-21T02:56:29.080Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=1;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|MN2PR03MB4943:EE_
x-ms-office365-filtering-correlation-id: eff7b05e-5a2e-4d0f-d837-08dee6d3aaaa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|22082099003|18002099003|55112099003|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: faVsUg9nj8UWBjiKYG6jQegn94W2EQI9nugq7FGIBmvI1TZWmIi2MMV1wux2riQfQelocDSYOnWhHChXj1crxxOd53fZBxT1HaRCG/DtnqcM6sGfBaZaoUKrSAIf+c9/nRX7/gtw0d6kBWL6f8dwrv0GLBRsY7LAB5tBlWLWw9ik2hI0SiSDsKdg0RlNy3tIIOmentNGusUcXqnPcTMU3D3utfp1va0qy/zZb5lN0hBjzt6nZqYqaKmVsJxTOQG3LKgj/ti8GIARzb+kp85UcBN6l3Om27lBrkwfGlNyWtyyJ3Auxe26ii1tID07HuJoTM0ab3Bk2jTxlgLnfLDRxXdTn5UdFX8FWD0zJflaPhryDOKdxmnTfVusUQufbY/iMC+bMDTgt3jTos5Y5b8evFhGkD4TxSaKybocjF7CaIgB/+KQV0TPNGBKFU5UQz2sBCaNkwEBRbTPU+X08NWWPBm/6JSBVDRn5y4G7asvCiPGwS/3Nr/kjia9JkiA2aODaIs0lPE/8/PIk7mi6YW2UrDtGuws9O2Ej5pbhFSQcUNLxsHVbARjjLybTsLxXNQOf1AeQOW7JAtw+IK9w/dK9fgeIlvT6guV9JX9Tz/oC6XTnsctufKUqWAN9rK3i9bsdhN3bp3RL6PaDJ97YaGxNju8J/Uw23YP4apv0S9q54G+v5fZcJLTm+1DZ/Tf36yA/VT+0BdDM9k2l7B866YlrEgxq3eU7Ttrt1mG46Ugq4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4p63bZlRRVCeq7ZNklkgPTDabvnIGJysuia+634KyMhPwCuBO1VLo+aZkr?=
 =?iso-8859-1?Q?5I8+UVRES4jH04srJMIZEwX7VyTB5z0PFrsgEpWFvIPdLhVDhYtKhqQ1KF?=
 =?iso-8859-1?Q?ZucXYa4Cn7c7HIZvfdhpH5lekCzJ99UnHcCaFmGUPVYCyQB1fZfmW2mzMS?=
 =?iso-8859-1?Q?OFlJhVOA5dZaZWtxVlahNw9tqZ/CX5GcweURNYvlSE+i9OpqAmEEyiwpIx?=
 =?iso-8859-1?Q?dwOFqn262t5BrtyTIb0wJ5M2zuTXNMBksleMC5HIHFPzR/NJjbSZrlWRNh?=
 =?iso-8859-1?Q?R7yymwwjVALJvTy0kgwWiVHtE1mXLoD5eW24VmrA+jspY5J/YH6ikhZJSM?=
 =?iso-8859-1?Q?aXZFQPE/NR3f4jptUF0FtUEiHqOXJGHSnzNlYXVPoreKdMFKTFf/7A/pEq?=
 =?iso-8859-1?Q?wEeAzJ75K8tpH/GA4l/RYBPjQNfMoxrqO2A841rpmj8Xz+FCi1QBbiFUbl?=
 =?iso-8859-1?Q?0F6WiW7vDizZ79V/xtY0zSXf18IBfeFiD+iipCwZ0TtTmKX68vN9/LSqXU?=
 =?iso-8859-1?Q?AeZqsB/aUShhDqe2beEtNisPoCGkGkCsMulAhHPOerLMfJTEb9bn7toUxX?=
 =?iso-8859-1?Q?vQFemQMCK82njz+CHYfWMHMCDXk6FWPOB7Wum4yA0CIuoVPilERo/FI4/n?=
 =?iso-8859-1?Q?T8fpwxriN9WoGgmjcWUlHJ6gMrhn9EaD/a7y1tnr13D9QlvaaCg4yWUKeE?=
 =?iso-8859-1?Q?i3axMrHBNEItn99PzD6VkqpNSqzzDmbKgnW7koETLQSZmABpMxpypCKN2y?=
 =?iso-8859-1?Q?A9CtlHSF/VxAnj/u10W9wT9D35y9VwqNuJrqjytirH48sgBfdnlaiU+fXA?=
 =?iso-8859-1?Q?v/3ebFdgp73riItslrv/lIjg+3OkcrXjNM6VjWfaNUDnLTyUEIMSJMVsnO?=
 =?iso-8859-1?Q?noyPiIbCzciPZZ/Gobj3n2sCmYKyc6Ooy6AZSleUZxkOLkGVMiadrdegTH?=
 =?iso-8859-1?Q?Oe8h4fs6H7Ew5Si+588CqvVKI3EqoQhHWI9YcBHlpwP+NbGqb4ZjqaGhBx?=
 =?iso-8859-1?Q?AVIUCLY6eB+JwHBo/Uw3UO/tWxJkYcCfqyIO8jQJuoesEzrJs/dNVzy8Rw?=
 =?iso-8859-1?Q?taK1iIAHJ9F+8nxwhRqiPQ4AlViMDr2gM91nx01KAtj8s6Yo8f4Mfp7D5V?=
 =?iso-8859-1?Q?o8cw50uT+8fDP/JhIPdqy6On5BKtsI+EYAgqYOI268cwZ4GR3yrzZqRl/A?=
 =?iso-8859-1?Q?5/QfL6YZ0aTFm8v9sKqM0j7hAJsKmC3luaj5VbImJO+z4ak4HI83IFbQs1?=
 =?iso-8859-1?Q?891oVeok6RLClC3Fiz5BDvLW3/MCWWU9g7dN4QpaUcsy/UPJG45C/Mc+yi?=
 =?iso-8859-1?Q?btqNMK+0PfU9WUGFO2A9VgoUC0FfjjkeLmJr2ueC/Jf3RZtiNAMOOlXpc0?=
 =?iso-8859-1?Q?4pUOIaepFzp6pwAx7WDQnhRr9oDHQrG8DI0tCnzKIZe33gsuRz+igAOW6i?=
 =?iso-8859-1?Q?RIQnUyFOaTN2vDbRT4Vd+CAo/3Q51AB2Dux7zg28k60UzGWzkuK6TceUAj?=
 =?iso-8859-1?Q?9imiKXfI1Oa86pbhWMVTxP7rsXbgrQURWw4Nkw1/Oj5ibMoA0NdzJCIqXb?=
 =?iso-8859-1?Q?B8ee2RbLKAP626zrMJu9d/Bo98ggy9rfFH2kBzE6rrniW0+i9CaBtUG/zv?=
 =?iso-8859-1?Q?hBtnA6mqPYelXQAYS3rdvFWSpExFrepebrtQiJ5Z7nTcZ9UAHf/njePt6y?=
 =?iso-8859-1?Q?u4s0ETidL5Q+XzgS6jrib4Ie1Y823KmhSXyM+dEOAcA8onow7JrxLBr5aR?=
 =?iso-8859-1?Q?qWI6nOjND0TbK+fqMDwROOofcP2EX3qir5cx/Iro53uWNwbyI4O/7rlNn8?=
 =?iso-8859-1?Q?PGDL5GV5HA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff7b05e-5a2e-4d0f-d837-08dee6d3aaaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 02:56:30.8394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSnSzGo5wwM9gMJk/yR2pCTen7V1JcXRHmxD7GIH0e5BK84oHZGja3nN+rh8Td1r8WzDksljSzGaTireKfiKrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4943
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i12oTSOvBd6eKVmyctG4QEusUPFKxi5FlBcKLTW1+j4=;
 b=SmlW42RYi47T4TS7Resse4xjlURXn8EvuVYT9a0UrB7Rx4vLohf1uvIgWVyXafeYq0LtJZQ+t2rWfNEejLPApWiVxhYYd51tVFI2abP4Eqsjy9Ir7bCepkHhW2Pkqx7l/9Fkkt4XUSFdDOCM7OPpwmmWnB4qTHaQkRr1SA5rvT6GxRbTrQ32RdoV4+on06RIVU8hTalfHqvLJvH2OA9ouF1SnrOWfplXz2LQKuC49VYb6A+wIxsYSEfCbRChMBQzVlHoJuDvPbyqQJQJtUwqP8FTXlJOwSN2+/EPP7FDRnSflaqouUvkMq1Qm8e8C2Q9cTBEUeSg20t3uXwbrpz7iA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=SmlW42RY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=boon.khai.ng@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="SmlW42RY"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "NG, BOON KHAI via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "NG, BOON KHAI" <boon.khai.ng@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Marek,=0A=
=0A=
Thanks for the review. Just checking whether this patch =0A=
is already in your queue and when it might be merged.=0A=
=0A=
Thanks,=0A=
Boon Khai=
