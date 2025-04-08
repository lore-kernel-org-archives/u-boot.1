Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8153C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 18:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0818F82155;
	Tue,  8 Apr 2025 20:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="k0HcYmUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8544082D2A; Tue,  8 Apr 2025 17:45:06 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3265782CAE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 17:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOJ6myI2uJkotzqR50WUdh+H2lrjA7/PCZ1mMuh2EViW6f/gp5MpV9fZvYOp5blD5bBhzDteYX/0bd1qlqqOX2oin6QsY7mrTbgT77ETUoqnzf5YRoDRPIg9vQTsWFoGixVecD3ye9XHl/+yV1eEVFppOBB/357KcQAX/jR5bjUQt30FFlyaRkyyoKV7y7o6UA438yVssYcuh6Hj3vM/U+V7AlNikTrBmuwzvINUzAiWGojTlSS6dR4pJ7s/vEE1w+Tn7uygnDAXylwW3t/eihQGhjIShbn+X9BOSWJ0jGo7r/niEoIqF7Jvg8ZMq5MdZl8TwGlnUqNabssSL+afkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEQY4wxM4c9EY423XoPU22/RLKIbu4xc1+XRHWMYAIo=;
 b=OrlpS3wDmmqv/XetXsRR84T2Lwq2KJEhGaHfqvLGtGPKKwAgjx49DMHhLmclDHVBJTjQbDhQusfDJduIwHi94edBwnZGF3C4rHFyuYx88AvDi6jOAakApHV8o1LlwtoaWf7IUFt4w6rmr9HIkhamhxME2DUohA6nsWUOsKly63DGh41puynSE+5NLRlleM/na4arYBDxWmGPkSQF/u3tHPW6E0VndfGXnCSKZv0WaLLf5QUdCLla/SWhzOnNFaqRB8x//v7JeQ/7PPETdohyydxI2QuyH0NoSqLjY/EpfyQ4C1aen/TnWMns2nyBY760vvha+b5BsTghdWoMRtoA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEQY4wxM4c9EY423XoPU22/RLKIbu4xc1+XRHWMYAIo=;
 b=k0HcYmUukW+IXGvO40y8gxlZ0yj68L2OM1m28Y+mx/iHdrvaJ2dlBFmuudRFNAmRmg6m0fHYdwvRQ+SM7AOgAEh61JaQJ8GISdSQiR4WC5jZlGCmeb98CbpBeAR9z2avxiTzGksLZevkig+bsk84w73yuWCw3r24pz/t7XJtj/TmcqUBDFw0SvP2YiIn7pEibh5ybXq044oI0Ue2bIn9N60QH+iAzoG0xEw8YJYT6dWIGI24/xdlbrd9T+DuLUfKZaMtXA8Q/TowniPevO/vGnLQ+zZ91/cNtGKXsYDcTYjvmDB1UgO4has6Ay4jiZS8BBEe7hWhvauw/ddtNr7azg==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by DS4PR03MB8129.namprd03.prod.outlook.com (2603:10b6:8:27f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 15:45:00 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 15:45:00 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, William Zhang
 <william.zhang@broadcom.com>, U-boot Openlist <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@altera.com>, "Meng, 
 Tingting" <tingting.meng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Topic: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Index: AQHbky6RCL8eOFJt2UGFHujp6NeNdLOaE37g
Date: Tue, 8 Apr 2025 15:45:00 +0000
Message-ID: <BN8PR03MB5073D1B2EC5C07E867BFE46CB4B52@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250312090944.35977-1-boon.khai.ng@altera.com>
In-Reply-To: <20250312090944.35977-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|DS4PR03MB8129:EE_
x-ms-office365-filtering-correlation-id: d6891c0a-7d0d-4461-e0af-08dd76b45258
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AlawN4koTV26sRTRt6kTPv2C4Vf5xvk1BplzqXuNRuM7mcbU5akgf3Flu2?=
 =?iso-8859-1?Q?/K7Xpx/HzjnObtqO/kFYwgwKszZpTXWw7GOC3IO9cA2URkWyg1FTpItzui?=
 =?iso-8859-1?Q?qIzjk4DELLJTOgyj11Yv/XqH9XN+bp0n4qUGBSj4cwHE/39I7wrBH8NJcT?=
 =?iso-8859-1?Q?mSFGN1T4tnCw6zbB8yIMEWKePMGbo8ZMlhsSG/V0u1ekMcu6nr2DBAPdwx?=
 =?iso-8859-1?Q?0dJu/Jxy0+NeIFpAeVMHzoLnv6d8KDNsMZwogUu1ZJG2Oat49wunum2OQy?=
 =?iso-8859-1?Q?Sj26kl4M7ZiwYi1WZ3XEC99vu8Tl/c+GAEHuskr5OwrwU5siYbMDdVu5Wo?=
 =?iso-8859-1?Q?Ye/ma7/E+tDMrsIwhKphKOpt19QFPg1SXj0QaU0olE7VKQ8eUpxTyWh52a?=
 =?iso-8859-1?Q?4B0A6I/thtx+Rr87fjPiklmoicjMfstMphttotp5p5qTeXzYyeEWQPTRmf?=
 =?iso-8859-1?Q?4t+MVBPMsp/rO11lGy29umOoDw8YFnTCqlPsHGAr2tgaS1laIHk827v8OD?=
 =?iso-8859-1?Q?TXoSjDJLNnROImrAOuaytzqYPN2FFdUpxqmGAvxHoXIDlkICBzt2GD1eFF?=
 =?iso-8859-1?Q?bqA2+qlxVTQsV1+JD8Wv0nbXbt7hT0kYZMtHWqrG5iXvjXFItyrkVwztpl?=
 =?iso-8859-1?Q?t551638BjJmSV0z2AFgARAAXitcASvXtYJ2FGi8SnS9oSop7s9SKd2g3Bo?=
 =?iso-8859-1?Q?a4F/LeM2FPhFglai/mRogv3gyi1OcFW2aMgyfYImHMiCOHzcENfqy/2eId?=
 =?iso-8859-1?Q?F6rGV873WTT2Rh24nQdwG4ZhwxzOzMVZLXyF2vikWjH34BHEVHxtmdMr35?=
 =?iso-8859-1?Q?9On3VEjEt3RZv3LFCFImDb21zSzi2QVc7mOzd4tJRE9Rvk5bW0IuhcpT6E?=
 =?iso-8859-1?Q?ZCNeEXQzULkCGX0ofQ7IseVwdqoliDdaxsup/oQH6wGA2W/3VUhKqWy+wz?=
 =?iso-8859-1?Q?sqX9Bx8vGIREe+ixB4dTuC6Hb90WMaVfnloX0SozpH7RtmsxtwSNUZD44O?=
 =?iso-8859-1?Q?9thRtmz3FL+nQKFY1zob9Nh+1yWe6mgxcbq0M7mifQJSPL7GbxTNJ2GEuF?=
 =?iso-8859-1?Q?FPDLFcBTiMvqj+so1pdofF2TXWlQKpDVrX/3fooVreA7pB7D/KywSFrKEb?=
 =?iso-8859-1?Q?IItLDcxQHyjXXUSMmsAcL/fiZ6fk0ckDAs04XqeF9X5VURrCeJal/iTzQJ?=
 =?iso-8859-1?Q?Di14hXO2LMuayHvaCUnsBjgHeMWQ7V9/+aCxaZTSu77pW+79aI1McS/PKC?=
 =?iso-8859-1?Q?3xmejAiEqUrIToLdP9Umtz/E1vS6ix6t8mdBUKijcG/jSQwtrZpeAu9kYj?=
 =?iso-8859-1?Q?ZKJ8AkWOy+uW7286xZNkGvGj7Uwh7aoiB+y+uii/VchZT1Q1nHM2efsFDC?=
 =?iso-8859-1?Q?fyoXSDJlYXnqfK4RYwvJclN+QK2M+3KOKZcig7ZLR5STtQN7sSiVQ0YBq+?=
 =?iso-8859-1?Q?QVIDuIR0xGrDPB3cMFR/B4uwQOtNU+Gs/GzIvmZ/c+60UMtXq9p17+g14B?=
 =?iso-8859-1?Q?1fi3dlEuu0awrXxd7l/KjdbbAm1yNOdm7LlkydHE06mA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR03MB5073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZiSzMQfQH9bxML57z5MsSuD8c/Nq2VSUx3RAYZlP8gEyS0cjQHGN6sOP3V?=
 =?iso-8859-1?Q?4atj0tcBSt2EGNU1+qN60fNDdKnIgXm8wacVmLdUYXYsZoEyygJPaKynJR?=
 =?iso-8859-1?Q?MLVTLKJRizjFcSvITtqRjMveZDZgFcjBb+npdCjpp37RA97D2ZZwpcUT2T?=
 =?iso-8859-1?Q?vxarTN3R7Zw8erYt/S4VOKe7bdzDarJ+SBw5ItmlA9XPaLpb52M7fsfVVm?=
 =?iso-8859-1?Q?dUqHSSzuYZ3mSo+fw4hj9lZIIDXXTeN/qsQxBB5bixjHkWEq2mlKyYMWYe?=
 =?iso-8859-1?Q?c4OYwxsAcdN3Tjqz6oEsHDrWHcNFhs+4qnIBr92AzW/9eRU6uDRX/iZuA2?=
 =?iso-8859-1?Q?PQt32/M5G0VgsQ4BXhCS4+F5goURgSXR4FHpQOm331s+6mbofRuDmJvGoA?=
 =?iso-8859-1?Q?jcltEGSpm9n3Dcha1f+s6nuW3u1XLDGI+69zilcj9YnKJketKg4/0YBRMy?=
 =?iso-8859-1?Q?QKE+sGrQ6/5mu6eLMcB6wQlrFpoaiNmrGAre2E5Tv/cN88DD/UjL5H6riY?=
 =?iso-8859-1?Q?3Vo5yYFrk1ddOLiCAZeNJ7BDWcA27GFZSboLyLKI6RzBcQOA+AthFYePIv?=
 =?iso-8859-1?Q?cCp2ZgHy4hN8CoFUbXN5rUebf+3YahSYRKb6KqnP2+JQlSifgevFIlkkMX?=
 =?iso-8859-1?Q?ZrT5KwEzH8IyCp65aaPLstXIZ2o9aGDFFFQQpxRgXVvxLo9T3IZ+Jvx53x?=
 =?iso-8859-1?Q?34012xmU9kiWrD9TEe0kR64ZwHbaFIX1QfJ9e99myLsX2V+uTM7FkSzfPl?=
 =?iso-8859-1?Q?KGfdLcAh/KB6+TOri9jD4MMZKMQ+eBNJYH25gAjqMkCuue+MD4nTsp4nFy?=
 =?iso-8859-1?Q?u8mVioT5WV8cPz2gBKLgOgknwQ9NReObCuOyJgiV00PIi/47uvu7Tic88U?=
 =?iso-8859-1?Q?wQmRnTwmtcZRd8yjHMsnbzL2ZQJAoQuFnpDrfvIj3+ywDq/gBBF2dLehhl?=
 =?iso-8859-1?Q?exStc0bonmgkpUO9B4Ahjc37FhXjmKzGcXAM6Xpn5RSvptfz8HIPhJix4u?=
 =?iso-8859-1?Q?0z/EbdM8P0zxeKsUpTwxMJig7Dhe6PBZfbFtecX1TGBli26sILPgWcnb3y?=
 =?iso-8859-1?Q?FlCnyQpoxIKYi2FdOMNAo4MeF4pHn4h/So2SvfAubkiDbJWCMM6I3TVbTK?=
 =?iso-8859-1?Q?tvEecQ/2n6vhk0AOpaed2TCyd/fQdCvF53Qal9JFRHdOpTwhCKvIjULcVt?=
 =?iso-8859-1?Q?h9rQGys1F9xtm+gmVlPwnb83trNPmx74VtVYR9g+UsRKCukLaeRpsqTE4q?=
 =?iso-8859-1?Q?zW0UZBnqNUApT/DDL0+ysYis/cnlbYiSjdsNciP3RYAOz44CqxBvYTM2KV?=
 =?iso-8859-1?Q?RDqIR60lSFLR3tONP60AHjfJ05D8LH3uol/5eWH1hCqsEMoMXwpxuPHuEa?=
 =?iso-8859-1?Q?t59TLIRo4wLuIBM4BRrvbsqKevFlN0FjQwZTjznaobGXRzsxRDbHsKl1t6?=
 =?iso-8859-1?Q?jTOoZocnllxoFGyIq523HU/XKxqEKfkz9libJPrSBj4Ggb6w1BfC7Ixg4f?=
 =?iso-8859-1?Q?1euATA1v2X4/5y6Qm4z2ORWps+nL2oUh0AaS/yING/WK4EIvuhU81enIoi?=
 =?iso-8859-1?Q?Vf/pCIEgPd2DJgpqzTaqw5u9Trzr7Dr6qBl5LbB3338UcKL9h9Ob28v5jQ?=
 =?iso-8859-1?Q?81prNxllKfAKOR+hm1SRi19fIB5Z/PVrMG7gRDHnQARxmv/1K6Rh/SpWGB?=
 =?iso-8859-1?Q?Ed+KUvFnOoWDqtXvVjywvzm0hK8sExJJuKHn5rN6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6891c0a-7d0d-4461-e0af-08dd76b45258
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 15:45:00.3698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gFmVbjCD6mlgnB6HdNvKhX7qAeb4mQIRx7WMWrbt/HVX8Tr57SsMecjT3sHU0d/j8ueof2jcuFSZYDJMn7w4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8129
X-Mailman-Approved-At: Tue, 08 Apr 2025 20:23:52 +0200
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

Hi Tom, Jagan

I hope you're doing well. I just wanted to follow up on the patch=20
I submitted for review some time ago. I understand you're likely=20
busy, but I would really appreciate it if you could take a look=20
when you get a chance.

If there's anything you need from my side to facilitate
 the review process, feel free to let me know.

Thank you in advance for your time and assistance!

Regards,
Boon Khai



