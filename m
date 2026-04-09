Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F128CF31E39
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B440783D8A;
	Thu,  9 Apr 2026 17:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="hVBxJpUV";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="FFg7Ek/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6042283DC9; Thu,  9 Apr 2026 17:35:17 +0200 (CEST)
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com
 [205.220.165.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5E183CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9559b1c231=colin.mcallister@garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639A8RXI141674; Thu, 9 Apr 2026 10:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps1; bh=6lJTG
 9E0ctvhJq/DQ3TJ4lFSaO42NRZ8OSg1cbRp0W8=; b=hVBxJpUVUpeWLUCoszAYc
 FUfFt62guryHt/5Qzs34PX7tO8vr1TiPQzyRCfG3vMxEOVAw4yUXh3+Xu+vGeeGO
 yaQN9haQrdMbCSsDqlMh8eC3CYapovblVzam+unErKvcLdAQt620Oq8f+Ws6ye6E
 vfpHrEJbokc7m2QRt6d/ER+brx6K34aXq12u7Gt6Uz6pzCTnAM2XKdLxAt9Alrko
 R0QXrArQVDGry81lLp4A6i5pP/OUafXGQT1aS+WFvhLAsCMzP/D6ENXj/dckATTg
 Yn9C/5XDP2PG5omkZT47NKGB5PVeYnGf0zS7L2m2xBGR5eDInRtFSG/QmRP8Npxf
 Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022118.outbound.protection.outlook.com
 [40.107.200.118])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4dea368n1x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 10:35:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjvR+QKuvrwg66UPO8fBV3fpGgdtuM5eZvcucJBO7IaPp8G7YsjZPvhUkJ9sI9QnhhO1Y/O+8zVVoEGsuDZ9uggijrBUVVTBi8aRC8b5mguVMll7FO9YJSsW56MxdChr3hB1GNO95t9AnAAkTzjEsFNkCgZutMZcClHi8mVZr8KgZeGnVZ1HxhIrVY0hyV7w1FnAOGV/UNoawX6hoCjbiHxSuZRQ8O53zq5wBJsxogbRAb+2vgxIs32cQjkQPTqN7CeyzIkinaJEWeIPxOU7OSaGOjjoWwogfjqeTe6jGzxpYHqNLro5tqLlX5E9jxjlxeITGwl1rOHeJDS1DMVgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lJTG9E0ctvhJq/DQ3TJ4lFSaO42NRZ8OSg1cbRp0W8=;
 b=FBpdTY1D+ONpBylP/shD/VCEk/lQH5vLHPSpbM03Qx0uLCniFc26pNAflr/esBFRINFHcQGkC+vm6+iGeg2qa4ic7rKuwmdllJcEFXLnqrrGmIO6PHvfoMZwoWPGqCzZCLjd8qDwG2RG8THk6Oq1JQzeLiYXSiRe+2zlIuXwqSMoQtr4aF3gwkgG6SSDDfnGLrMbvkwZIRFUNjf9oXJLQN2Fz+icKHThhSEkbj15f5H45pGP29a529+UlzjK5++8O9d2BsHHR5tBxyqLUuXNv5QctPZhnTrl5B+rylNKYW4JrW6nOv3ET8Lz137GEDKusHPe1N54qKWE4RvPlMG6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garmin.com; dmarc=pass action=none header.from=garmin.com;
 dkim=pass header.d=garmin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lJTG9E0ctvhJq/DQ3TJ4lFSaO42NRZ8OSg1cbRp0W8=;
 b=FFg7Ek/+hEY3A5egCqFoYtTw+dbaEPNPuBJVEUAbx5JQCtDEBSTpt/3n77woAD3G9ekob1IysjJTXNt5CNfcXDjYqWv/Q5rQx83ienksKKMxhFyKKwqZO0IVZmDiMnRHkjgPTlQ0wJLWrNyK8ReetOcoTljzpYgF2pWsOL2Fjau/7W/Gl3btwsduJ7Ee7HSUX4WaCLS9HrAt/UuuUnM5ifsW/cCAaU33EZwQVPES4mYZKLlCqArctiQ3J/44l5jcO0fh3b4qsQZi80AwcyysDaLS53fK40PMfGnD1zIW9t0LKRrgDBmaWXTnhBKoY/rA4nucT4AW2dtpfoxPFozyAw==
Received: from PH7PR04MB8731.namprd04.prod.outlook.com (2603:10b6:510:236::6)
 by CH5PR04MB9574.namprd04.prod.outlook.com (2603:10b6:610:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 9 Apr
 2026 15:34:58 +0000
Received: from PH7PR04MB8731.namprd04.prod.outlook.com
 ([fe80::2c0d:8dc9:e80e:38a3]) by PH7PR04MB8731.namprd04.prod.outlook.com
 ([fe80::2c0d:8dc9:e80e:38a3%5]) with mapi id 15.20.9745.035; Thu, 9 Apr 2026
 15:34:58 +0000
From: "Pinnell McAllister, Colin" <Colin.McAllister@garmin.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] android_ab: fix slot selection
Thread-Topic: [PATCH] android_ab: fix slot selection
Thread-Index: AQHcsyYGohQw9okCnkmcBUmBM2atNrXWrugAgABQl9k=
Date: Thu, 9 Apr 2026 15:34:58 +0000
Message-ID: <PH7PR04MB8731B036A282B4DC1644B052F4582@PH7PR04MB8731.namprd04.prod.outlook.com>
References: <20260313201415.255744-1-colin.mcallister@garmin.com>
 <87zf3ccu3l.fsf@kernel.org>
In-Reply-To: <87zf3ccu3l.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Enabled=True;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SiteId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SetDate=2026-04-09T15:34:57.689Z;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Name=Confidential;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_ContentBits=1;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Method=Standard; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8731:EE_|CH5PR04MB9574:EE_
x-ms-office365-filtering-correlation-id: 9f7281f0-f4ee-4d13-23ec-08de964d8e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: H2Gm+0sx7CNuWin/5sQk3mmtp5w/iwk5MlntkTrQTJCiciAqEnvSOIAgs/l35FjMHIUVKlIWNRRcfuQ2udGKopc9zKU0DS+uBFmtmzDQkt4+qrP941gLgMzMgXy/pgLTLK0w4w1e1IuvNAOeFVNtAhfSnowH+/nDobtRvtyFN2aomyyGWOedlYMTB2cq79XU2jXNIZ70ci/i+qBckHQL59jydEJbI/NF6gRtvuGxhvyLl5tySmBIj6h9zz9pxSZxLpi6PX/ENCwdP2njocgOfp1BScVn4iTj/mcAobL4/zdVeGDPLEz+HVp9K4RTe2ziDli3SL5TTKdCdJM8Az5mnr8wAoo/xGTQu+c+FUqy1/L0yU0/bSiMvSM12JQZ+NgSgOWRGsUMa5uYIHDrNN50tFGZKUGKRwp6kJ4X4J46+v7vaLFTec1gEt+8QUERzwJzAroEjqpRyAXuh7GNTQrqZROMgqseYP+22tbWYs+XBWUFMxNdN7QAl1eqffH5jgErFL5n7pph7BL263OompIy+AKqvvIZBFlx/+03SidnTgjZERG+vxFY33laKsF2/V7oG+XmtyxTZF6Z79jL31skXxt7VuowycsazmOipKyr329fKVyUX24e9OzsjfQPQiVUnkFyPRJZbC2Uvh9hxlox1lDYlGnHJkghdpKnKSSz7xdPM0doiMipqhwjt4PJsMrZ8513JVe6ORb/RnGTm1kz/MePpIbZS6GQZeTmAC15hpSswfH6eaywFr/qRHSAdCKD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR04MB8731.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jPYffUuw+Jp/qREAwElsN6T7Us0q15n1Xyan/Benfye8DfIVdKgKi+6huj?=
 =?iso-8859-1?Q?NH+jwweuBOgMlqob3g0YTQWZQpWiXBMp9mpFG2nLBYOTWLP5v7T25o4/hR?=
 =?iso-8859-1?Q?kf8YYQUgtkRuqd6vma3+waoJeWjqmrDT/4K0/ZWInGd2vhEHu+2MXUy+QS?=
 =?iso-8859-1?Q?TwFOpack38gFykuP3qoBjPOTMp5GgMG+7QzLX+eW2g7w0DVH2XWiBHcj0w?=
 =?iso-8859-1?Q?Ez9jC+hTj7PwdqvaPi/yNxpFRRZpuBkgjmAs8Bq6Xz/epcjuBHOqcpOSgx?=
 =?iso-8859-1?Q?/ifv9Cv++n43/iZK9/skSdJx3A7CdwsbKrmQc9olD5lzhZ6ZOZR16KyL1H?=
 =?iso-8859-1?Q?JNy2Wvrea8d01wmK18ZtCgXLnls8/I4gxKOJLks5dmu/DmxP5zrLGtYKVy?=
 =?iso-8859-1?Q?QdvTmytLrRH4qZuPM+gMW17WFAoMSFsG96MN+hiAZGrGLvQ1ohPdfCONLe?=
 =?iso-8859-1?Q?x7Zlq1NHOJIcQbe2strxg5XFkrkyUc6zWkcMDYXcl3mlD+EP2UOKtWC1qC?=
 =?iso-8859-1?Q?X0jJY9eNr3TR4yf8G2RpJZ1P2vH0L/ijWPPn5RRwxaL76z5tmGbDURm+MZ?=
 =?iso-8859-1?Q?4vb4+yKxUhPV7aZPu4IGw3X619WVALQALp7bW51L4hvWgcT78gmU09GnX7?=
 =?iso-8859-1?Q?uGUWUzc3ngDvkG3kP6fqSknWYpVYw14+kQO7ZktooG735EG7uiMitEbg4x?=
 =?iso-8859-1?Q?tPlqbVG6OFXs5eKxsJdjZGoxiasU0NbZ+MhcM2mTgMcwHBaBagzO03Prpr?=
 =?iso-8859-1?Q?X6W7NkT8NrufrPiSICDf9mCEeAwrLrw4a0h/+9fdg8c/VxiQQiv4nGob13?=
 =?iso-8859-1?Q?zxkVTBmdg+747wY1YziKciNV/l4Te1jiLO0e3CBjD8kpc0hOf33t6hfE2P?=
 =?iso-8859-1?Q?BZDNlAHyF6tOln41Rfq+PuTqh+2u8RKQFNEAn4x/clbS1YS0HQEGg2Nf4P?=
 =?iso-8859-1?Q?SyyAsd1e48Y3KdEDieYZGlsJfrIi9kbZTrJiP8wKggHviW2mf5KXNdfbzw?=
 =?iso-8859-1?Q?e8CxAmzkgLdgLohNNbrv1yOeOWYCAFy2WJO7MHcl+NgJ94F+eKdxEJe/rk?=
 =?iso-8859-1?Q?a4z28pgD5IT4b2NxzIONj98yGtcLK3pGkLV4WnGjfW5leVBXhHc9OLVulc?=
 =?iso-8859-1?Q?1dmGjV5ObRE84D2JiSXFcSJGUL3IYVbr7rleMCgNiQ+BAmVKDrXhz+zHgn?=
 =?iso-8859-1?Q?c9rFlduo80IdtW5Ov6FIRPYlITzCi9wwmX5UsbPGXdYLH2QTgfgmtYqIXd?=
 =?iso-8859-1?Q?ea2MDOPRwIOPdg6KvnOVL7d2U5221r5drK3j5jqMfIKGtGaHW8cDHILGxR?=
 =?iso-8859-1?Q?z4/qDPS1++zdzohxy3kGDCSdwEnvrdQBG89lOUXxJkYYK3TvYMgzn76CTj?=
 =?iso-8859-1?Q?iGVQZR8yMYOLPvLESdDp1I5plb8wGGi58uNqI3deP5fDPwjPk2+47aPRSR?=
 =?iso-8859-1?Q?20WpBT5HzS9glsFK4pgsdzuThEhqR3FLaCyFJf1vXdUjpoHL2xDf+M2I01?=
 =?iso-8859-1?Q?AR5apAVe6ivZ0HJ6Vt7Nlwcu7eLi4CjbNHVTPNeIcyg987WBJvcu5rc1bX?=
 =?iso-8859-1?Q?O0LLJGjN94VCzxt2Afemf6WNzoWmBnflCANMGyffilIGZsyBoLiA8oAx5A?=
 =?iso-8859-1?Q?Zs/okHjt9sbNy5lZV4gdYb4ojriGfyS3CUY9VM23QOSWHDlxHQL0g/1KYW?=
 =?iso-8859-1?Q?KOHGtQNTeUurhVuV9asNaPXc0ezR93v0Ox7jd5YKZl8vteeJ8IYwLA7nqK?=
 =?iso-8859-1?Q?7hfR19xJiggWNnmTqp+ErkNJ33MaIRb2paqar+vx28DE/Tf/m9995CuScZ?=
 =?iso-8859-1?Q?5M9fhdXZlA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qm8oVSb1yUjuQ81Eo5av9kFtdYmXRkFFcFNnY8IDKbwg4qDqdbaWbmAjHAykLvhF5CXZOp1UqhU0TxAVkcfyBtOThxU6INhQDC8qMua8CyBya/5dd3fzPUFYzG5bKMEEKH/d9qKqK3DITwCBz3hnI6xIuppnWaJZky/TMLdvfKCje/xio6jb5arJUkFKxA9VYesZ/FUVSS5lnxxy2wNfO75rCQgzvvf5BtBjuRmhVmZK7SHeX8M/9LXm9jKHTIlxmes40hWjM1TEnx6CpQF/7pOMJTku34Ibq88Jo/Npw7sMd4MLziDTSibUyZ9oUv4u8NillqM/1lZBfhJkPsp5bg==
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7281f0-f4ee-4d13-23ec-08de964d8e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 15:34:58.1060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cva8K+QZ6Qd90suQKCpxc/DRbVRMZUDyaNf80RXR6ka1cxNsxOlHCr5s4BPj/ydwBzYhIwVE47CupCjYkcAyXxQdgM3rmCGYSfPF0ajkeco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9574
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE0MyBTYWx0ZWRfX/5RWHspxsy6Z
 KKT0OCb3i9K136VPEm0V4z+IJv5hrmoST8Ka8zEvdT5CGSEXR9GIUWKK/PpV7089i4rbch8EJph
 nrG+osaA1a27pqrQkg9jkPctMXPZO6c9mcTEouf3FMRI+CipcDPSbyPAtD58jZrMj3Fi/Rh2uCk
 lDo0F3YWo/lU0P/K63+CkK/Vfx/oafn6FvrPiXsL2bfEg+LOwZ5dknpqQOmCK73cY73+pVTb2w1
 gM5M0N9DwLwAkjk6Uf2EgBohePYx76kXKc78fZO9n1W/B6IKeDlw7fpPYEvRxwp5Jcjw5nLj1a1
 9+aX3vodKNyreQ+UyLsbjTKiow3yLUoABOWqeblo0prn/hvOn7i1qlIArPeXMSic1dJjIpQmLnD
 sdJMJ8v6isOdUDvONtXH1b2gTLgy69ITLJuOb1gVfuEBXIifUGk5GO5da7TOTYsFiQpBL+ImIeC
 5aiJ/AudNfOVgNQkAhg==
X-Authority-Analysis: v=2.4 cv=H4frBeYi c=1 sm=1 tr=0 ts=69d7c725 cx=c_pps
 a=XvwqfKrzn4xeEGDWI/eySw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=qm69fr9Wx_0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mT958ORwFhrKhj1UMJhN:22 a=YTLoTrrJEVZ6FbNdITQk:22 a=n8i27M1mAAAA:8
 a=XpE1AkgCAAAA:8 a=Oh2cFVv5AAAA:8 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8
 a=sR9KmcgI3xOZXGcgEwgA:9 a=wPNLvfGTeEIA:10 a=dpZMgbseYPk84XhQl7oQ:22
 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: j-SCDfG--8U2BzjqeWy7BguSU_KHyA8f
X-Proofpoint-GUID: j-SCDfG--8U2BzjqeWy7BguSU_KHyA8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090143
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

Hi Mattijs,

Thank you for the response! This wasn't a critical change, so no worries ab=
out the delay.

Outlook is kind of terrible for replying inline...I should have used my gma=
il account for this patch. My responses to you message are below.

> Please use ./scripts/get_maintainer.pl -f boot/android_ab.c next time you=
 send a patch.

ack

> Can you please give me more references to the boot selection rules?
> Is this just the code comment that's mentioned (boot/android_ab.c:276) ?

Yes, that is correct. I do not have any other references to cite.

> It seems to be using libboot_control as a static library.
> libboot_control tells us that a slot is considered unbootable when:
> tries_remaining !=3D 0;

I also see that tries_remaining is set to 1 on successful boot:
https://cs.android.com/android/platform/superproject/+/android-latest-relea=
se:hardware/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=
=3D260?q=3Dlibboot_control

This is what we also currently do when marking a boot as successful. Howeve=
r, it is unclear if this is a requirement in the spec and what the behavior=
 in u-boot should be if successful_boot =3D=3D 1 and tries_remaining =3D=3D=
 0.

> What happens if the tries counter is zero and we attempt to boot with
> dec_tries=3Dtrue? In that case, we will decrement tries_remaining which i=
s
> an uint8_t (see: android_bootloader_message.h).

As I read the code, dec_tries only decrements tries_remaining if successful=
_boot =3D=3D 0. So in the case where dec_tries =3D=3D true, tries_remaining=
 =3D=3D 0, and successful_boot =3D=3D 1, the decrement would be skipped, wh=
ich aligns with the behavior for a case where tries_remaining > 0.

I'm not too picky with a solution here. A valid alternative solution would =
be to simply update the comment at android_ab.c:276. I do think I prefer al=
igning the code to match the comment as it makes more sense to be able to b=
oot a slot when successful_boot =3D=3D 1, regardless of tries_remaining. Ho=
wever, if that goes against the spec, simply fixing the comment makes more =
sense.

Please let me know what you think and what solution is preferred.

Best,
Colin

________________________________________
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Sent: Thursday, April 9, 2026 05:21
To: Pinnell McAllister, Colin <Colin.McAllister@garmin.com>; u-boot@lists.d=
enx.de <u-boot@lists.denx.de>
Cc: Pinnell McAllister, Colin <Colin.McAllister@garmin.com>
Subject: Re: [PATCH] android_ab: fix slot selection

Hi Colin,

Thank you for the patch.
Sorry for the late review. For some reason I have not been cc'ed so I
missed this.

Please use ./scripts/get_maintainer.pl -f boot/android_ab.c next time
you send a patch.
See: https://urldefense.com/v3/__https://docs.u-boot.org/en/latest/CONTRIBU=
TE.html*contributions__;Iw!!EJc4YC3iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5D=
gRMsDkFUXhf8ofhAJ1slRLYnu1EpkNnuaZHqRBDVgEpNOTGCclGX-d_1n$

On Fri, Mar 13, 2026 at 15:14, Colin Pinnell McAllister <colin.mcallister@g=
armin.com> wrote:

> The boot selection rules state that a slot is bootable if it is not
> corrupted and either has tries remaining or has already booted
> successfully. However, slots that have tries_remaining =3D=3D 0 and
> successful_boot =3D=3D 1 will be disregarded when picking the slot to
> attempt.

Can you please give me more references to the boot selection rules?
Is this just the code comment that's mentioned (boot/android_ab.c:276) ?

I've checked:
* https://urldefense.com/v3/__https://source.android.com/docs/core/ota/ab__=
;!!EJc4YC3iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXhf8ofhAJ1slRLYnu=
1EpkNnuaZHqRBDVgEpNOTGCclOK45V17$
* https://urldefense.com/v3/__https://source.android.com/docs/core/ota/ab/a=
b_implement__;!!EJc4YC3iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXhf8=
ofhAJ1slRLYnu1EpkNnuaZHqRBDVgEpNOTGCclDWZu3M8$
and it's unclear to me from that.

Then, I've looked a bit at the default bootcontrol AIDL hal at:
https://urldefense.com/v3/__https://android.googlesource.com/platform/hardw=
are/interfaces/*/refs/heads/main/boot/aidl/default/Android.bp__;Kw!!EJc4YC3=
iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXhf8ofhAJ1slRLYnu1EpkNnuaZH=
qRBDVgEpNOTGCclARJQAuu$

It seems to be using libboot_control as a static library.
libboot_control tells us that a slot is considered unbootable when:
tries_remaining !=3D 0;

See:
https://urldefense.com/v3/__https://cs.android.com/android/platform/superpr=
oject/*/android-latest-release:hardware/interfaces/boot/1.1/default/boot_co=
ntrol/libboot_control.cpp;l=3D332?q=3Dlibboot_control__;Kw!!EJc4YC3iFmQ!Tlm=
_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXhf8ofhAJ1slRLYnu1EpkNnuaZHqRBDVgEp=
NOTGCclOsUzpyr$

>
> Update the selection logic so slots marked successful remain eligible
> even when their tries counter is zero. Also include the successful_boot
> state in the unbootable-slot debug output.

What happens if the tries counter is zero and we attempt to boot with
dec_tries=3Dtrue? In that case, we will decrement tries_remaining which is
an uint8_t (see: android_bootloader_message.h).

>
> Signed-off-by: Colin Pinnell McAllister <colin.mcallister@garmin.com>
> ---
>
> An alternative would be to keep the existing behavior and update the
> comment in boot/android_ab.c:276 to remove the successful_boot
> condition. I do prefer updating the logic to match the documented rules.
> Currently, the userspace AB code will need to increment the tries
> counter for a slot that has booted successfully but has no tries left.
>
>  boot/android_ab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 13e82dbcb7f..93e74f81d4b 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -289,11 +289,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struc=
t disk_partition *part_info,
>         slot =3D -1;
>         for (i =3D 0; i < abc->nb_slot; ++i) {
>                 if (abc->slot_info[i].verity_corrupted ||
> -                   !abc->slot_info[i].tries_remaining) {
> +                   (!abc->slot_info[i].tries_remaining &&
> +                        !abc->slot_info[i].successful_boot)) {
>                         log_debug("ANDROID: unbootable slot %d tries: %d,=
 ",
>                                   i, abc->slot_info[i].tries_remaining);
> -                       log_debug("corrupt: %d\n",
> +                       log_debug("corrupt: %d, ",
>                                   abc->slot_info[i].verity_corrupted);
> +                       log_debug("successful: %d\n",
> +                                 abc->slot_info[i].successful_boot);
>                         continue;
>                 }
>                 log_debug("ANDROID: bootable slot %d pri: %d, tries: %d, =
",
> --
> 2.53.0
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
