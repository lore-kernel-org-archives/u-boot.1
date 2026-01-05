Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E262C79F81
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 12:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D78483CBD;
	Mon,  5 Jan 2026 13:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Xk2oFAam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B997C83CE3; Mon,  5 Jan 2026 13:00:53 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4728839DD
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 13:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+TP8OZBNYQP09txdamH1kpSFodWmY3u3oYieMEQgjg8FBetZemZx0Vugmz81v+almscZrlVGc/v22IxZsMkS5T5O37S5suClq5CFGDkoDQZw/wbNeDusASGc0lDQvJuJMLJHBhvnrE75KUr1ZEh9JrAN/LkCbGkiHymzKLoPCa6wRr+eiesQTDzt3h0oHZ+/J/SAnqtgrYlduICAxYckOSRGi5qy58dd6DJrlg4IZIEV3dlzZ+/380cq3RjLZgOUt+YseNKZ2YxBX9ovqwwUv/JiFsKocaxPCPHsLmJITC2ecuJV6GqKn409BdQ9FifcBpj1dO6io7c1jkoBX0WtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/Xp2ZBrPWV/pHpbEb+teCWp31vyH/Qw909fiXtuRwk=;
 b=jHFrXl/WwX7SDkbjq3U//LpQTzpqZg+zw3eYOz0q4Tjc5gR++kQ4YQ1vnZcomMFbRnZvhSy7anWplUVoVx2Plz48tQZk8ymOOaulv3aFwq/tFl/EukWepT3sYI5NSit/21R4UZLK7YK2A/5Hax70C8GaHcH2iyJAiVzB9Vj05vGEFCABlhmYNSW2M2opwSbQMes8fk0KUAEnkZRqxTF10nDt+A+KmYks+y1XqCfqq4HKZGQG43l2XqNwkU8fye1ZQpeitI5LJ0Tjp80VC2tnfisAtp+eSUlhFxvVuJPgZfCXfxi/9/2o74aJJfvEBVF3tbvXGL7NZ4GUT2UZk4OKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Xp2ZBrPWV/pHpbEb+teCWp31vyH/Qw909fiXtuRwk=;
 b=Xk2oFAamALhlRW2y36Ih3dcFZuULtZvpE4j2fgXD0pLcfmnRtb5QGbhcgR7ibd1p5cjJoYhBBiW6XuEpca9lx6zO/FBFNdCJjTML7iggeiLMB0Qae1E5CtYz4TayUGeB5wKJv5w4wnndr8kgd/fD1QoBYC/aII09q+THLRGDJOWmM/Dj7vAybOtG6TpjTA7pCnfVkV4O8hQg6VGmDKZ3su5T+OLQKF2CmQ5JC7Yg+r1bS02JOja3SpGP9TehgAPnsPXb3M8uXl+pK/5tX5g6w9q7kaNCdQA9WfYuSHb6KGczcxazB0NY8BtEr+d/tClbE6ayUD3L45eBT0cC+Eqasw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10094.eurprd04.prod.outlook.com (2603:10a6:800:247::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:00:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:00:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, U-Boot Mailing List
 <u-boot@lists.denx.de>
CC: David Zang <davidzangcs@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathieu Othacehe <othacehe@gnu.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Topic: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Index: Adx0FCd9b/X98XjTSguLZ16auIS7yAAZ7TGgABD4UQACXnf6MA==
Date: Mon, 5 Jan 2026 12:00:35 +0000
Message-ID: <PAXPR04MB8459B7B10541BDEBF8C9A8D18886A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <GV2PR05MB1194100C3AFD5CDBCA957E91083B5A@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <PAXPR04MB8459DED744093008D9F2570688B2A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <GV2PR05MB119418B930F7ECB982F03602D8386A@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB119418B930F7ECB982F03602D8386A@GV2PR05MB11941.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10094:EE_
x-ms-office365-filtering-correlation-id: 81a6d12e-75a6-4829-6727-08de4c5208f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rMuUCnCeJ4ch38I1ImB+FRJbOANqrlhXnhmmJn/tY+Wg+U9DuuAme75PMq6o?=
 =?us-ascii?Q?/62M7yy+eU7nt2xf1KYeCrb3CHr5McC1/jbzd0HKAeK0FjE5NFtJCLJ/8BkS?=
 =?us-ascii?Q?KpSQ9LyEgvSk3H49P87Nclt4duIYeb4PyUzMNu5wLnwWNV7wa6bZ0dOKRG8+?=
 =?us-ascii?Q?H2ChtVDEsq0vkl7ncyqLm4ExLr8/lUvD2FFrUi7ZEsdrtCIb/26bNEhVgMbG?=
 =?us-ascii?Q?LAMXIxuc0WQcCU9pHW1JtdtMOTyS0qi9wnCoboJyZRlZyOg1sIeECGDou96d?=
 =?us-ascii?Q?4UVJwuZUkefgbpEt/4Ibk8U6Sf3l7sSL5S/PflP7LtDffmD95itda230Xw1Q?=
 =?us-ascii?Q?cjWlRCy9r7gnU1Nez0XCis5gfhslqVyyIXqvE6C25SlkWYy2kQZi166tCv5o?=
 =?us-ascii?Q?jd7FG+sy+9+TQ5oAvOphMKXvtGcRYtzi7DbYjR4srSe5aLMEX+G/NikqSySt?=
 =?us-ascii?Q?tQ+C9XTLiDbhPRe1VCPjIAQHSS7AGza3/wdLI+ExQiQ5l2K5OZl6xOE3ZaCT?=
 =?us-ascii?Q?It5o8Iwo0e9PyuynYRFOwTEvPWZ25XOEacVd3g3m4iZr8Jd5dw90PtE234uj?=
 =?us-ascii?Q?Ny799AN2lGxTuOealKrOCrMXYpdmuvwP1AdmyFHrbhORE0+aP0TeZehdqdcU?=
 =?us-ascii?Q?kaHnxC4o9k7sb/tmHvNvsd9UbLeIjTr8HtG3EtHnz0ODYPV8d0XQCJoqY8S2?=
 =?us-ascii?Q?bMHMYjcQtPMcT+XNaZAA8Q9Sqy4nP61PKhatlqhpt1F24kgXMidiv+Y9xIvb?=
 =?us-ascii?Q?c7k+bjne30kvfYTgPT6eoHF95IC5Aomz78lIwt8v3WieKdwHwX+F+3vEyYoT?=
 =?us-ascii?Q?kQMOB1v57LjrQtjXuBrBfyRdRf6fNI5XX1UhOG6QUFoNONcUx+Mk6l+Qomp7?=
 =?us-ascii?Q?3KiU0dalxwh9KDpcQN/ToSp2Pw8kCLx3TZ//d+bdisxfB0+Q9AIRy8fBcrmJ?=
 =?us-ascii?Q?SUHBbtUl//am1hO75M9e6gUwXxa9Ox8QE1w+RJ34ZiItlhUmHERq/EhvyBrK?=
 =?us-ascii?Q?zZjy3WshEAmJaeGwgWimfcXiVq/wfIDG7AHRBhROKq3ybFFP0Vl85L4UPnXW?=
 =?us-ascii?Q?OILZ7W9QfeeHIF5NYkr/KymeUODCDd1ap01zIfdXDcbobPN02Aq1MWn1t2K+?=
 =?us-ascii?Q?Y70LAJb4JsY2YQ46RpGeKrIgP2YCczH0ushzG+xX9+q4H4DRLrcq3kNwExti?=
 =?us-ascii?Q?LpgORRZCBch71F1IGL/nTQOP3VBApnW+GbckLIiRx4Ns2uoRZTz2fEEdvPK3?=
 =?us-ascii?Q?OE4wglpsqkoHWtCJoomVb44n32h4N3LJngZ9aRugBK0+wprn7Q3Bhg7lHZCk?=
 =?us-ascii?Q?3b/OvCTirwlrdcLjS1DsCGJ7y2AgTEMR0oSZJvoidn0F3V30nSNLzMIH7VRc?=
 =?us-ascii?Q?zWaFhYsRjHmkjakOblGbcJdNWVfpZVKe+9WIy3+iMkh3IDQSXypUKRaQlP9W?=
 =?us-ascii?Q?OCi9AgMjMBkVwhi5hYj/h+jILT054cvQoZEfa6SMJcnnkACc3I0Xz3ibB8Ld?=
 =?us-ascii?Q?EFYGv2PkdVU7vNtj3TPbe4cByrZj2l1TUafZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DbM1xiYFK8eGZ+4PP1ukcuAPbWPxXZ6x4v33R4SIqOBjZtQNSuQCMl+jTdqN?=
 =?us-ascii?Q?7XAv6oE24GU2JHee9dQQaq40nnuzMY34dHv3gvCcPh/0PNpOnS/4MXC6TapO?=
 =?us-ascii?Q?si/yrJFdqMKhF96GLY67Pw+bWzm+GAEtjITinGPuQQ1n4xMQuk5xDwaZrk1F?=
 =?us-ascii?Q?NQXkNjKcXjqJAyzTRdXJnsn0ME7drAPgy4jTbPVdY/N6n4JclESIIwVOK8Oa?=
 =?us-ascii?Q?Pb8JGf5TAPALuWFNi3yhv+oZdKUKQGnLHmQVZfl+7yrB6sLju5fW1/qqjm8r?=
 =?us-ascii?Q?jZ2sponwsR8E8vsxV3iO+rwdZb8Jklb8Fpye3WTq6Ltl6M/RZY4txhX2Ink2?=
 =?us-ascii?Q?biN/DhWpiWCQzJ8Oz4PDeeQCdaXlAGc913w8eGXpucwrQlcdQM/e5RvLm7/t?=
 =?us-ascii?Q?7WTX7XMJQyoV8zq/YNjO3k2fPtgAUab0nxeENqRKSau1drH8Y+fHSokrj0MS?=
 =?us-ascii?Q?jW0JHrTCZ6K1Nx4u4BfpQs5Tdua4MBuQ7kJUJz5/Pt0ixHgTJGlX08tw87O2?=
 =?us-ascii?Q?HG56q0AoQjodZYoBY3BdTxQDO7H9XhYk1O15YTbrwd6YbZ4LfSF71UpYgHzF?=
 =?us-ascii?Q?tQ6Ol0WLd/XbVur9awKpAxfBCZ0NN2qj5KiJbOKrEQnNFyjR/16yDoyCppQJ?=
 =?us-ascii?Q?exOS4Ou79yhCBO6Dq//I745pgxldjuz9LZ2R16BzseAjy6XbnnAtJ66DQ1Lr?=
 =?us-ascii?Q?+6N6i/dGS9FN0Xmu6NdzWfz/NU5Lrql3jjlIgwBYCxnBqVOQIuoV7XOp5B7K?=
 =?us-ascii?Q?IexAoDX21+f0Ofk3Q9+X1NnzmGM61JEH5IrlFpPvVy+33hbNe2fXQxJaN1fH?=
 =?us-ascii?Q?0AKUFE6BB/QCgCMEoe7PmIDk2s7RVFjfKHCq7DnaRoIXGnQAP5XmkElAhjIt?=
 =?us-ascii?Q?q+WKo5pJ7BxiX1PrqYfns7RQT1uXm465yPZ42fB4LFkzoq8yarWXsoQptLRv?=
 =?us-ascii?Q?QKurFlWzZcPpoCwWgQRU/632ui7DF6u1rSG0M6DQDDFQNeQtXk8o8Zek6XD1?=
 =?us-ascii?Q?0jEo7OiMqsAwU2TwvmBQOa4ISTjy3h6V1rtgWlksij2KFOmYtVlrJff2bEw/?=
 =?us-ascii?Q?+WN98ocCSnL6NdPMs9KxxSvRtnyrdpvD7FLqcP9a20CxN5NJPhru9oz9xcwH?=
 =?us-ascii?Q?pcThVfeG8DyZIswnmv795XH4wEq6O/T7+HCryolAH2gk5Id4Yl9YTvvUSgC6?=
 =?us-ascii?Q?SNhgk091uaFQDGBf+nTWNKBZJHBX7CTFwB6KTCy9R4HZqCiPV/7vW/W/hdQc?=
 =?us-ascii?Q?DYgQtkv0+iB7HlFVdTZSaFhlbLN9cLFHlEmJAcYC+QEK+fBYTn7lbjbvkJTc?=
 =?us-ascii?Q?D2WnYJS0F43FBspYRyaU5hGKPB9ldUSBTBCXLJ5k169ypVLDRz6nDwpwomSU?=
 =?us-ascii?Q?NVIZlmF9aAk9/gjeTM3xwsxO9NwtqJ+6Z6tkgyUm4yFZ9iy56JO881SxIWbR?=
 =?us-ascii?Q?HkXjnVfS/IJ2G92+QvzBBt05XL4x51w5XyZQv5mQtk5u+CWXNzs1NPGk5fqd?=
 =?us-ascii?Q?7kNx333iEsgsOPy0IDIhPg8BbDEYpz2fxa8b8TtUC8g06WjJC/NQfhYi19BT?=
 =?us-ascii?Q?PdX75Ly5j+ztpJxz2wZESfXYAYo107Cre86O3D78YCIL7Tll76ZkyP+35JFf?=
 =?us-ascii?Q?2TFl2POqzsI2ICwKwb+PJorkoRZkMxvQNeTCMDTve0DPLYril0DD1HPGavEJ?=
 =?us-ascii?Q?ZSCQH3Gs33udl3Y0mvb+b9ijDzlksJwCpkzzsfjB8ARpq/Hm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a6d12e-75a6-4829-6727-08de4c5208f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 12:00:35.4417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJ9EaPqf/ZWoEM4Pkb2RT1onnZPFY63lXGJDRXBub4e6n+G7secaEQuZU3bpH6oJoma/6IoTUChCbzjQc0RePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10094
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

Hi Maarten,

> Subject: RE: [PATCH] omap_hsmmc: Support
> CONFIG_MMC_BROKEN_CD
>=20
> Hello Peng,
>=20
> > From: Peng Fan <peng.fan@nxp.com>
> > Sent: Wednesday, 24 December 2025 03:22
> >
> > > Subject: [PATCH] omap_hsmmc: Support
> CONFIG_MMC_BROKEN_CD
> > >
> > > Add support for the CONFIG_MMC_BROKEN_CD option to
> omap_hsmmc.c This
> > > should be selected when there is no Card Detect connection on a
> > > board.
> >
> > There is broken-cd property in common mmc controller yaml, could
> this
> > be used for your case by parsing broken-cd property?
>=20
> Are you implying that the currently existing
> CONFIG_MMC_BROKEN_CD option used in drivers/mmc/mmc.c
> is/should be deprecated and will/should be removed in the forseeable
> future?

TBH, I have not checked which boards are still using MMC_BROKEN_CD.

BROKEN CD is board stuff, not controller stuff. For DT based boards,
we need to use "broken-cd", and avoid using MMC_BROKEN_CD.

I think this option should be marked as deprecated.

Thanks for your understanding.

Regards
Peng.

>=20
> > Regards
> > Peng.
>=20
> Kind regards,
> Maarten Brock
