Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9281EC369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D48782E0A;
	Tue,  8 Apr 2025 16:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="pmGxWSoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D9D83348; Tue,  8 Apr 2025 09:29:33 +0200 (CEST)
Received: from pp0155.ppsmtp.net (pp0155.ppsmtp.net [132.145.231.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14EAC82EFC
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1193e21e32=anton.gres@ifm.com
Received: from pps.filterd (pp2080.ppsmtp.internal [127.0.0.1])
 by pp2080.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 5387P9t8021081;
 Tue, 8 Apr 2025 09:29:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pps;
 bh=jfEDEbzcMFqY4x/4mbeFV4kDWeY9oqKcRKbk4SWeubs=;
 b=pmGxWSoT7N9ENntWMvBCGXbx+YcIzNhBbhxRt2EbXVdvlpWdky7MhlPpiGB5m6dn8A37
 gL9wfljJurgYm5tqy1/6krtYka0Exi1Hl5C7vTu84pfouDfVweXhiHlgr0BB6Q8N8TdH
 p/4f0SmYGSPyp6T4ZvpFWyOkWFSIBArw1hbLNX73GUpm7HicpRZNnLRVNF0+RffkiwPM
 qfMe1sXrGAxRNgThTWywsq5HMJyJM6VBGhpLT2xcM/EoWKqJSdg9LeSqXgP7nSGr4owp
 EsQ+KCCeReATL+f/30w/SupouzmORjqXmdnntCfPCgVnDujf/uFy1NP/QGp71UTEUIJ1 aA== 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCQWhVxRVtHLgJs5vwkHAUdK3xHs0+TYxy0KXBDPwEavCjHyVbHhSEeRp8Vb+F/YBWZ0Bb2kGVD7qTztBvCO4PDMe6PGX8eDVxUgtvU2stvCc4Y/bBeqA2t5uCusRCDfB3kynCmheYLVGJkwxLbATl+OMXtsM//U7C5bVaBa/v7DsJbMZDcShD04YX2suW3jQKagHyx2vlLTexEX3n8qoacXhdKlK3Clmi6SLiCp2Rx6o/oxoI6W99NDGBEI+FUAXji+LfRn/Y4X3vyXsaYx5RkgldgKyexrmzGbORLBCUpicFySO2Qtswm2MbY5pJ8YsjXJoFKHa8Pc/dcP371Hyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfEDEbzcMFqY4x/4mbeFV4kDWeY9oqKcRKbk4SWeubs=;
 b=xo1QNvquomgIOgN1GcCU4IyiwHU3R75/wwNvD+iPVYV5BQq7lTVPWugWkJQ1XrCdsZLf10YGg6MTxUZurqI5+2vqrWaaGzM7NzQHd2XNhyKpChLc9oKTss2/KA/QqFSmGnl+ju9Q1dJE/acgVHOTs1b+7xjXUjmdVB4BSfoQfjkfalYDNwMde87AL7G7Qz2mbkD4iGWuOEVZdoBx1uQhO+8enVO1zWMWsCnoqXAMwOGHnJvwq0TyZyliUJVNlJeaJBfNfs4mFnci59qsQ8z1YhT8w3Bntjy9ltVki3yzCF6z0W0vVTpMGwLhYYFTh2cDlqscAHxgYMPhsce3GqfDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ifm.com; dmarc=pass action=none header.from=ifm.com; dkim=pass
 header.d=ifm.com; arc=none
From: "Gres, Anton" <Anton.Gres@ifm.com>
To: "alice.guo@oss.nxp.com" <alice.guo@oss.nxp.com>
CC: "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "alice.guo@nxp.com"
 <alice.guo@nxp.com>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "marex@denx.de" <marex@denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>
Subject: Re: [PATCH v8 17/19] doc: imx: add document for i.MX95 Image
 Container Format
Thread-Topic: [PATCH v8 17/19] doc: imx: add document for i.MX95 Image
 Container Format
Thread-Index: AQHbqFVfrTjBvWobkUqWZ5SUqPgFCw==
Date: Tue, 8 Apr 2025 07:29:20 +0000
Message-ID: <AM0P189MB0818D6DA0527C56748BF28E180B52@AM0P189MB0818.EURP189.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P189MB0818:EE_|DB8P189MB0665:EE_
x-ms-office365-filtering-correlation-id: 3445aa53-a2b0-4688-fc62-08dd766f140d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jBMZ2YOW4Gw4zv4TV4+ub+vWogKp/xp4Fn+9hYihNF3pIxhVIdPucOAik5?=
 =?iso-8859-1?Q?xKFtNdA6w2vj3Rlf79j7aP82QNERX8vgkQFbuVA70wLR2p32nQVY11hCoo?=
 =?iso-8859-1?Q?LddOs0pf/HQOKkcFrQnFdcp/a74j1HD0mlPRvbic/8bNJ+oZK8djpYLurK?=
 =?iso-8859-1?Q?ymRpXZsO8WwcNNM6TEwkGtoef5RrQtvsuawyDJvHDftjLRK4FH6MrVMT3G?=
 =?iso-8859-1?Q?hqDce7xOeRv2TlBovuuSRcGjGYaaa8HybBolUJ9LX5WJsMSRZ6TKVBnr6e?=
 =?iso-8859-1?Q?5kbGX6OLOVhttJYD27vqG1DxWmr936u+ZI/nvyOT+MZP8P+IRRnIAghMLI?=
 =?iso-8859-1?Q?pmRIknRYouMd70A1T3iw9uFrIRUus4Su8bBCpjD0zr7X3lxZjhl/Zy3nM1?=
 =?iso-8859-1?Q?DtRVzM/Ax8XxgwdEtjKXf5z7soDadTZiOgIXx25s09x6MekONfkoXgE7d/?=
 =?iso-8859-1?Q?ubvaqqiPhgaSIFafj97D0kjIhstSE9ZHF1IajERXRpr3Wzdth1+9wNFkSa?=
 =?iso-8859-1?Q?WSQz3fOnt75dUXYBhspwN2EDOGIvG2IoI1i4rmU/FosKkf0QksuCpRpgYJ?=
 =?iso-8859-1?Q?ZsGUFB7hYKXg0rWs0AQkZKNA9mjINheG16HCZTQv5DgIQC4Mbkiu63BeB7?=
 =?iso-8859-1?Q?pgD6vYARwkeuFgq4XgVpUv9KjY5TeOVkJXfjbjir0onInb1X24HwJEvwmX?=
 =?iso-8859-1?Q?kqa2QjMNWtqnQe7snDmbwAGVRzrjXQXuXzAAOtAndEyP+SqyGiyf7FxcHg?=
 =?iso-8859-1?Q?dThG20WuXZlWEN+RK0iAhx8V5xtyLTLsCKWIpputzD2dz/NeMoINjI+Co0?=
 =?iso-8859-1?Q?4g2K1pXeSB9+7m8rFqYGpqGkF+FmMHoS41OTqItvFpHPtwVJ16u8Vjlna3?=
 =?iso-8859-1?Q?NtX/4zEiigBdvJ7e+MqHSOqlM5j7cuccLmKxbW241TNYyHZvy+8CUatRIl?=
 =?iso-8859-1?Q?dxBuBe0X47Q91vKh1bhYpX7nTJ83gqLoYsla08Yr2hxfCo3LwDNNAncEKI?=
 =?iso-8859-1?Q?OOTXwhvjPj9CWfcLWFwAZVPkX/U5rcXQaHSuGaMYCiMta6eKRRhcudsZ3I?=
 =?iso-8859-1?Q?nbwu1FHBOT2u5GXu9syX+Ns262iaJRvyGpSxs1q+yh3tz1qWmoPA/HZBdK?=
 =?iso-8859-1?Q?cxOXXWZJZK8B67Co+mwu4dFH0HQgzupM5p+EIh38dJq7yFvsGE5OfHWvjf?=
 =?iso-8859-1?Q?xPwkdaR2r6jK16Rx9uNbX30owcaPOi3F8LvdjxfmhK9j/knyGt5zQ5qYM7?=
 =?iso-8859-1?Q?Qh4VIPj6zge+JquJOngbETiHMRmYStxI/I5lUfHYMVrAuWOpQVpxxN4qyK?=
 =?iso-8859-1?Q?z8XFKZzhG0lY/iN583I1+uZeeL2QwWJcK7rlQo2uMZRabcxb8PRywBjJe5?=
 =?iso-8859-1?Q?woQsB0ar1fHbAKdFmXG6NR/Jr1pDSRzMvRmaCbOqQpmOGd0v+KaZzlthtH?=
 =?iso-8859-1?Q?4tqh9/iFcP7Fh7HYP/mj3MLrJGt4QeXO7JnR7FKGJmwr6ohEpSM/TWdKjS?=
 =?iso-8859-1?Q?R/feO0XkQP59TfFjAze0J2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P189MB0818.EURP189.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J9ida/suy0aPS+bfnKchbbnspo8E95HUk/qerNFTjmrZ1cvNEHo9obD4MZ?=
 =?iso-8859-1?Q?xxMVaeQjGRLkqt6LGvQMskasiNA9g585inE8p5D7XyU9zLDiN1vAf4ZflW?=
 =?iso-8859-1?Q?qKCCdS9WhVqv5rUogY+Dfd3CvzLcX0fXM3sEAeeSj/kQTHMVdJ6J+vT0ky?=
 =?iso-8859-1?Q?vKJ+psyuwFArD4YM+HPiCGSwDdu4tTB2iCXgJzZ+uxvkxWwOC2BO+Iwc7J?=
 =?iso-8859-1?Q?nLwoD0L4vsx5qIX4wwEvwhG967AthLmWJdOA8qoJN4/F2KH3xbvq5V5m7R?=
 =?iso-8859-1?Q?WLJ70q6in39fsE+PlmyhiOEd0kNPnNNG9Tx7Vb1SdFCwsEDCEjWBpXmHmY?=
 =?iso-8859-1?Q?AWBfWP/P0DmXHqxzioYz57kguRW8x4iJEEWAxlgdcZXTiXJL2WoY+6ZtaP?=
 =?iso-8859-1?Q?/Pa2KQ8hSPEPdr/gbeWbLW5tCxm0Cokw5eH7YTxEcaoubsUZ+3KCHgbZa2?=
 =?iso-8859-1?Q?S2hXrMzmVpfE9PqOm8awLM1GwnvHCRx/J1QezB0tmtuU7wr8x1LvxeOsbF?=
 =?iso-8859-1?Q?3rPBfuVmMSkQVUD7mj0VQ1tg1peH7O4i5NoMBOdazQqCPPWjOv/COMFJPH?=
 =?iso-8859-1?Q?z3W/A0l/XwUINLJuyoepathJi4VsHKdbTJeeUtUBLq9KH/xySLoWt9U9E8?=
 =?iso-8859-1?Q?y0GZ7MoAi6KBvsEBn5qLb4AlsrssqV9/Vb53fFehh9IRwlHTLc7cSwQKjo?=
 =?iso-8859-1?Q?eySATlqxSnMfSdJ95zQkYZpAvr1Rl1C6zjec1M6nUSDnq44Iz2Wx54jst3?=
 =?iso-8859-1?Q?/CQj4fKEtsxFkG5zGs2thyQgJibS8A2RW7MhjtbOhf7lSQ5icz6UQuG2UX?=
 =?iso-8859-1?Q?qT5kl4wjvtdVn5JnE8dr3qXJH6Fj7T2kW8cK//uKjRdg1qYCLeHGDqDZF0?=
 =?iso-8859-1?Q?FYJWMm+5iksRYBe3WBPZivQy2EESpbozNIKNtClDGe/Lcy+SF1aBoOGBcw?=
 =?iso-8859-1?Q?N4n0w+nEuxQiLd2e1nLA9+XO3pn7Jf3pskG2I5nhrdMG2TV8NhPJ6xQI1v?=
 =?iso-8859-1?Q?IeZ7Vd5gOEDxl+8waNYH2DJeVxcVhw1pOVHRQlQUlihuvVXDDSFPPJeY7R?=
 =?iso-8859-1?Q?VdXw1OWKrIZwN/AWdE4PRdpEZLF3JCiTMlEorbSqoGpSzUciLrcc4MCmmH?=
 =?iso-8859-1?Q?4t9h83PjUhBuoL8xVqe5ryQ1Mqg0A3qNXBevqScBM7Qq8z5hWLVpACvU1Q?=
 =?iso-8859-1?Q?WERJUND9rW3h1Omhw/2v4rO8OvWMyAmF7mliE3cZkhpZpZxVKVYwGBrcRo?=
 =?iso-8859-1?Q?qIVe3iufpe93hqMQSxbfXxmRchQaviRBL2OwaKJYj52RjoulrE2tx8afas?=
 =?iso-8859-1?Q?zamzdpz4hZB7JKJMA0v+ff2IwjW6u4Cl2Pk++HHRpPqdcx5S1LOVY/BQdc?=
 =?iso-8859-1?Q?3rXw29ylzvDBNNn8bEUZqXQ3xfYJSQyvhDdhUeo3iDxaL5fFuHdJxDJ0Z+?=
 =?iso-8859-1?Q?f31QWGveOkaUhhphz6PAfoI04nmKRZA0I1lURK42P7DWmfb+F5kV2wkxzp?=
 =?iso-8859-1?Q?TIE3gICZXFmoaEpcHsePbxX4okPCxHfSyeR7+txYur18wUh5po1vp8Z+5Q?=
 =?iso-8859-1?Q?xjZpJDiLUmK1uPAmiwFpCmPvDzZxb5FR6rkMfsvp4Ro0FXRrCdxPBwhwTZ?=
 =?iso-8859-1?Q?4/R8Y25Ut4Qlo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ifm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P189MB0818.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3445aa53-a2b0-4688-fc62-08dd766f140d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:29:20.6116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2782ef14-4849-46b4-b90d-d7e83fc425ca
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9SXhTY1e64Wq8c/bIJzjzr3eSQlr1M+2fzYHzVNC/HV/tsHuJx1tG2XvsnkDiaPrxoTapOtCSO5mMqWRlSkcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0665
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0P189MB0818.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC: 
X-MS-Exchange-CrossPremises-originalclientipaddress: 77.12.240.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating; SFV:NSPM;
 SKIP:0; 
X-MS-Exchange-CrossPremises-journaled-to-recipients: bma_f893cf61-8c78-4ce3-9360-a036e8d5e7db@mas.eu.barracudanetworks.com
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DB8P189MB0665.EURP189.PROD.OUTLOOK.COM
X-Proofpoint-ID: SID=45ucm8wssw QID=45ucm8wssw-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Mailman-Approved-At: Tue, 08 Apr 2025 16:21:49 +0200
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

[...]=0A=
=0A=
> +Figure 1:=0A=
> +------------------- +--------------+--------------+--------------+------=
--------+=0A=
> +          ^         |Tag           |Length        |Length        |Versio=
n       |=0A=
> +          |         +--------------+--------------+--------------+------=
--------+=0A=
> +          |         |                           Flags                   =
        |=0A=
> +          |         +--------------+--------------+--------------+------=
--------+=0A=
> +          |         |# of Images   |Fuse version  |SW version           =
        |=0A=
> +Image     |         +--------------+--------------+--------------+------=
--------+=0A=
> +Conatiner |         |Reserved                     |Signature Block Offse=
t       |=0A=
=0A=
This should probably be Image Container?=0A=
=0A=
> +Header    | ------- +--------------+--------------+--------------+------=
--------+=0A=
> +          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, =
Hash, IV|=0A=
> +          |       | +--------------+--------------+--------------+------=
--------+=0A=
> +          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, =
Hash, IV|=0A=
> +          | Array | +--------------+--------------+--------------+------=
--------+=0A=
> +          |       | |                            ...                    =
        |=0A=
> +          |       | +--------------+--------------+--------------+------=
--------+=0A=
> +          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, =
Hash, IV|=0A=
> +------------------- +--------------+--------------+--------------+------=
--------+=0A=
> +                    |                            ...                    =
        |=0A=
> +        ----------- +--------------+--------------+--------------+------=
--------+ <-- SignOffset=0A=
> +                  ^ |Tag           |Length        |Length        |Versio=
n       |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +                  | |SRK table offset             |Certificate Offset   =
        |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +                  | |Blob Offset                  |Signature Offset     =
        |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +        Signature | |                         SRK Table                 =
        |=0A=
> +        Block     | +--------------+--------------+--------------+------=
--------+=0A=
> +                  | |                         Signature                 =
        |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +                  | |                   Certificate (optional)          =
        |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +                  v |                      Blob (optional)              =
        |=0A=
> +        ----------- +--------------+--------------+--------------+------=
--------+=0A=
> +                    |                            ...                    =
        |=0A=
> +                    +--------------+--------------+--------------+------=
--------+ <-- Image0Offset=0A=
> +                    |                           Image0                  =
        |=0A=
> +                    +--------------+--------------+--------------+------=
--------+=0A=
> +                    |                            ...                    =
        |=0A=
> +                    +--------------+--------------+--------------+------=
--------+ <-- ImageNOffset=0A=
> +                    |                           ImageN                  =
        |=0A=
> +                    +--------------+--------------+--------------+------=
--------+=0A=
> +                    |                            ...                    =
        |=0A=
> +                    +--------------+--------------+--------------+------=
--------+=0A=
> +=0A=
> +i.MX95 Low Power Boot Image Sets Layout=0A=
> +---------------------------------------=0A=
> +=0A=
> +    Image container sets are handled by M33 ROM.=0A=
> +=0A=
> +    --------------- +--------------+--------------+--------------+------=
--------+=0A=
> +                  ^ |                    1st Container Header           =
        |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +    ELE +         | |                 Padding for 1KB alignment         =
        |=0A=
> +    OEM           | +--------------+--------------+--------------+------=
--------+=0A=
> +    Conatiner     | |                    2nd Container Header           =
        |=0A=
=0A=
Here again=0A=
=0A=
> +    Set           | +--------------+--------------+--------------+------=
--------+=0A=
> +    Header        | |                 Padding for 1KB alignment         =
        |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +                  | |                    3rd Container Header           =
        |=0A=
> +                  | +--------------+--------------+--------------+------=
--------+=0A=
> +                  v |                 Padding for 1KB alignment         =
        |=0A=
> +    --------------- +--------------+--------------+--------------+------=
--------+=0A=
