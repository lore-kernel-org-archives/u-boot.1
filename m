Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1EE7719F
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 12:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B76A805DA;
	Mon, 13 Jan 2025 13:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="dMrpI3ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C70805E7; Mon, 13 Jan 2025 13:15:46 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c407::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DDD801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 13:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybaTu9P3LD5udluunf6bhjFx/xJ7c2182cWiQl8ApyCVR3NZFsqeBCFt/rXfPucuxGz4bwz/A+hBIb1s3VX+66HVdno37BoOZxyvyNS3wtVS/2PhZZar5I40KRA5jx8VTIYT4uD7HeXrAez6L4jp6HPRm1WlEoUQU9syd9JmS6JaaMFZR6nuDE1PgmsKoKvYoPovuYeqR+aU1wnhZ8yId76r0Rc5J+2iKB3cqAMVYCmEsN28ud4T7TgmIe3LeAG0uH7S+GOstU5ystcl7uqiDOOmpiF7i/6XXZb0D3BfACjJoJ89D8kJKKvKCpko80lkzDl8rc1faSiSjVWT5xjbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hda2GoOQHVxyXkBeBlTHdnnw/WQWOmPfe8tZTvRlE4=;
 b=ZWJEhsEYS+VpjMt4k7rAsBBbTPTBFRwW2cAyDSYM5IsT8q0Y4OiAStAsfRAPnQQB8SDT5Wl86wN1nk1M+phlwIs/4D1tv0YXaNar5uGUAZTrSmHKAvGecouMC5ImrAWuJIjzXXiWB9KI/5uTEaL4r2cJO8gTqUW8kBu4haC6alpFaaspH7IfqMYKspKcal1/F245pHSvY0qSLUwJbr1i+nw+qCmYZPJJB6CTZzLlbsU4NrIoFU3IoCExF7nGzJd6yYc8fJEf6gn1SfLcuPZgOxLaeRzznOuODifHoqdBykLiH96pG3RsRzW6cfLjvm21oDiwmI8olC7AvulK1uwKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hda2GoOQHVxyXkBeBlTHdnnw/WQWOmPfe8tZTvRlE4=;
 b=dMrpI3timUB6f4yKf8XnedOMr79zCx+OHEveQWjXC3kKfkhfN6qT8IB+glKTbRkmutMyJOhxkWTvOx9BbbodMHLwZl7cy6Tw91oyqlnH42MrpLrtojbTeqHCfTimnzKb5K0Mv/izrNnpEUUZVBw1uQMkC2r+pO6lybUPtXqy2Q4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9477.jpnprd01.prod.outlook.com (2603:1096:400:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:15:37 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:15:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Andre Przywara <andre.przywara@arm.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Julien Masson
 <jmasson@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
Thread-Topic: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
Thread-Index: AQHbZUK9XZFiTRN8BESZIPlrQZlnMLMUni6Q
Date: Mon, 13 Jan 2025 12:15:36 +0000
Message-ID: <TY3PR01MB113468B93D55B10C9D38ABFAE861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9477:EE_
x-ms-office365-filtering-correlation-id: 55869abe-b308-440b-ea58-08dd33cbfc81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AHQ4mCpEFtrMU/OJn24TaHv6/L2+YPtSvozOagOQsRQ4ScROE7VNZhW5YbKt?=
 =?us-ascii?Q?sbfbXaGHytfJ+YNAt4vm58x+I4F0S14Im0EhTnWlRw7/9hTAO19Ztg0GIj6O?=
 =?us-ascii?Q?6eYTR6yAILPaqiamAjTLQM9seOLLeiIPl6hMSb8PtAkqBVj9wWSXOdCkGY7m?=
 =?us-ascii?Q?/WOkC2VWvZhgU7XLDzrLfdMrsCOs0Mds43mZALLxEA/oekCujpSwJUBC91M7?=
 =?us-ascii?Q?BMQidcxJt0Kkwqpum+U46WlFMWyOcTXa+6BOwEti+nrFktf0BdLa+D+bByuS?=
 =?us-ascii?Q?dEphp0pJ8SVsqzTZ65SyUYYi6iZDbEm9WUaWoPufj79LI+QuBZt3NAp5eLMp?=
 =?us-ascii?Q?3KIABvRd2xXcjHw6nysIHutpIQY3xPX27jKMQYQV3ODzIlij3tzjBMU1azlH?=
 =?us-ascii?Q?8yKIkiYZlGZdowLDshtgRUtFjhS1J5xTJ7mYTnJy3xGp0h4+kXNkcA6jPGSG?=
 =?us-ascii?Q?hCAKFv7xkem3HUNBLec2Ggzc3fS8Rke+nRt/8plKLEoGQTbfG4zc6aucSdXn?=
 =?us-ascii?Q?qW1RU7wa0KGBo3ljqKGbhmiaH8E0UnaNQWFhUAQrh4B8RB2l+ZllKsuVTp1E?=
 =?us-ascii?Q?Bd/gOk0LIO84Dn0fiVJHPlNCXQ6MHpcTOzlUz+0bZq2zNqwFOL7ews85fIbP?=
 =?us-ascii?Q?XdIdTpoHgpUDG2rXKZyqLggtYP6iipvOCXtbPGNd9wggiFWcASCXfubTIlzY?=
 =?us-ascii?Q?XzcicwV8pvV/EQzK5ubvWUzp8EemnBVpVrCO7sbRN8JSY94EwivjFzBuRXwc?=
 =?us-ascii?Q?Kxg4+T4KGgwydihAtXoztcLJnnEwKRjluv/rCfv9KOrF9U20wCpgYEiopaqC?=
 =?us-ascii?Q?nfDetpIDvYOncuLLKK6EdvFhTxQPU84tvgq12zfh6VV8qMNvWVxjrbfYnCgC?=
 =?us-ascii?Q?fXnkQRD5ThZQnrE/W5Kvj7PWTo2wap82E/Qt3oQLc1apFSRkFI0lcuYv38Cm?=
 =?us-ascii?Q?xMyeY1jyRyr4mQXe7G9STpjVz4rmg20aENkLKWRNyVQbSgJ8CKDDXy83CceZ?=
 =?us-ascii?Q?V/p898KGaImnrdvVD+bKXzmqmjR+fx/ehARnHMWMjhYFRQWh+81uezNyrnzL?=
 =?us-ascii?Q?RN+XXzPd6C+BI9XUWAD0O1YDXQlNtwXmhX0xHGkXGQsRi8Y5BVxHKWGu6oiz?=
 =?us-ascii?Q?RvF7eIgHUb1SzBSVVY4EIS0PW/kun0LSZ0QEUOvXQeuFZmxDWYQlGqCEJdhb?=
 =?us-ascii?Q?vW2iiT/I5P0ZFMAV0vbcKL6RYVQ5LKAnCE1F5RLRuMzETeFgu4L8DiGgVgo1?=
 =?us-ascii?Q?jTH1LS5Gyn69mMNJD1v3dQcB0DfLagZEbWPutDC33+n9ztBsA/zMPrpvdhTy?=
 =?us-ascii?Q?ZvlE7EzE/WWyFHN0zpWY0KKgITLnM1v3PHWBCkYju8APMxPhf07pc4kEcQsj?=
 =?us-ascii?Q?P0qLNXT7QcfjuM0PZsjQ+81rcrGPy7mNz5qt9Yznq0+fOeIeD7TC+8lVW19K?=
 =?us-ascii?Q?o+a3DayyylOUapfVn32UdrDbXyOsAbJL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wz1s7LWf/uTWpVoMZkcIVxnR/wBpQ+f/JwAevqcaLukdIJJENQGMrrlhMRkY?=
 =?us-ascii?Q?lVUybYrBKDgkgw3fQoV4q4Tz29RWNIsdY33tyQ+GynAbZt29HP5Mw6iJOMDy?=
 =?us-ascii?Q?lJ2zXXKJm8Zao6zm9ckBApt7Y1YBu3KHoTzU3IocZPVTvwpg4VjcEf+cgyT1?=
 =?us-ascii?Q?GWt9ElNx5ChOXkatKRyJyp2rpH04BOqoKJULjPYdblBEeXhdzEJet3GccczB?=
 =?us-ascii?Q?KYx+IjETstcVvq2r4/TbCldGwX3KMLB525liq8lZR6w2h5XAO2ep5s4ME3Qu?=
 =?us-ascii?Q?PHsW03exTU8Dg4QzQGzX3KYYUpFgJeDULRQcHtMXSWwXOYzyoSDgDNr2NKvL?=
 =?us-ascii?Q?DgQAga5BeaS2Wsi64tIhAn1WDaYZezWvZpQO+uXFoyy7XR7BqwblTpXrXevC?=
 =?us-ascii?Q?OmZYiMcFvhgtQcPzRAaZHhSabdbfmMIRuvOMJptSYmqQ25lO7GuelO259DBB?=
 =?us-ascii?Q?bbCIgA/+NXgCHyzlm4ot1J99cEh2hM7HGCETf5r+Bn8BGBuy2Ov64bKYkz3b?=
 =?us-ascii?Q?czj9kXonlFIRf5H8801C3O287IRv+K0jjoha585tZWe5UEIZ8iUd+8oqt/Fp?=
 =?us-ascii?Q?lhiFELeH61YakiU0J/k+37Dk1hvc7vGbgVGIvTtYu6IjYa/diQu7WzXCKSpp?=
 =?us-ascii?Q?A4uMY+/yXaRyWOY7epnl/BsmrqOl3PQfEV3XpO68Au1VR1BjOAGBxUMlmScl?=
 =?us-ascii?Q?4lLbm5kOBI/7WduI4GVS7jnKaDFNbIJPqpjfAYQu/m8rikfVRAmn3xJFRobj?=
 =?us-ascii?Q?+G3T9ujRnAVtrK5L8JgrTGNfiOa7fVj3UD5lHj1eJ0TiaTLW/UzPnk8FEQf+?=
 =?us-ascii?Q?UO6BtkYRqEYkN7y3qRKJnmf8opt140E9pK0sEY5sOspwh9l19J3QOyQOrzuQ?=
 =?us-ascii?Q?EOqXtXzsX8A8OpnGGFHtUM4RrYWWcyyZ4rPBYMIWnFezFKygld1IJWXRnINT?=
 =?us-ascii?Q?wFrjAbp+fUzfE3I1LSuheKVlxNeQ9mJqThu/oxzDrb1fNm6EKhCJ1mx8HQ4p?=
 =?us-ascii?Q?g0E/cFKn5n8ZEl1hE74+LwhY71PJ7N9JPxkT+6rfxAfC+VOok0uEqKldXUhr?=
 =?us-ascii?Q?ip9pt51wC8I3MBjHQoenpGaZBIqnBGjLWklGf8iyZl8ei6x9fOcseHFt6VvD?=
 =?us-ascii?Q?IG4scKn6Pktn7UfVeiaouBkiCcIRteNTHvy5gnIARaDcXhwr+JfkX6wy1XIQ?=
 =?us-ascii?Q?Or7Qn04ZA67NAbI3RoL6GM0tKGujm0ghR3xBKgJwTCG+vIZy5Z09Kf8nCQAq?=
 =?us-ascii?Q?5lMwNwcGgjhD91hGGx7icI7XIaFY/F8P9LdSLWwID+DiHfbhTit73xfdXO6u?=
 =?us-ascii?Q?GAVS9r/9KvkcuQqdfSuKJwXUodkh5melwluGyY57dsOb4uGVAEmHeCJ3jZBq?=
 =?us-ascii?Q?XWVaBymDxbmKKlRi+P2N7vq3wqjQ7dvv8WQgFDPmwJ7fbnFiqA3DLloJxFyN?=
 =?us-ascii?Q?FKavtWp7Jx7v4adAbTM0XDfbbs6r1ycpybnO8NZ/6bsKgB/5uObYl3omlePV?=
 =?us-ascii?Q?775/6+z+QcUi0Y8P13SlzNvC1nzmIBRaiC8PEYnDYxtfiMaX7dZt5Avba3zF?=
 =?us-ascii?Q?1N448iOXSSCaum0j5YDUsAdOu6fRaUGGixiut7R/CDu7TbWGrR953y7FORR2?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55869abe-b308-440b-ea58-08dd33cbfc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 12:15:36.4187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAs0iGW5/uyn/8zmsc+ZxnQSl89wikqE7BzS/l1jfVZIUYqhk/gPm2jZunb+/gMUX7HIss4gpO6LOcQfT5msglCn2BRdfNk7rdQGFS2FlZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9477
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

Hi Marex,

Thanks for the patch

> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Marek Vasut
> Sent: 12 January 2025 22:37
> Subject: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage=
 loadables
>=20
> Add support for starting TFA from U-Boot running in EL3 as part of fitIma=
ge boot, so the user can
> start U-Boot in the highest privilege level on the platform, bundle TFA, =
Linux, DT into a single
> fitImage and boot such a bundle as a whole.
>=20
> There are two main benefits of this approach. First is the ability to run=
 U-Boot in EL3, where it has
> unrestricted access to the entire system and can act as a useful debug to=
ol, as it was always intended
> to be used. Second is the ability to easily and safely update of any comp=
onent in the fitImage, be it
> TFA, Linux or DT.

In this case, who will do switching from secure world to normal world, u-bo=
ot?=20
Do you have any link to the u-boot patch from secure to normal world switch=
ing
with kernel entry point passed to BL31?

Otherwise, kernel, also will be executing in secure world mode.

Cheers,
Biju
