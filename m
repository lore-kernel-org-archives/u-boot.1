Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A23DEBFD1C
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CCF836AC;
	Mon, 13 Apr 2026 11:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Myx6cNdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE99839D5; Mon, 13 Apr 2026 11:08:44 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561308352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfcisnb4lqtPWlY33EEhdHTOSlwjdGlWklKX6JSHdeaKMNEZcKn6DBj5DZc60QO2W4hU0XgVOZiIG7b1n+Lu4C3tnQ9flVu7GxTgi0pluYpZX2rcaJoHGdV0WZxEL7ZZ+eF9GglksxdWgAO4XN4SJVwL/R0jokAp3lecQV1sTVucCkOB6qNDPn+9rcNPjGk0SkocoWTpKr3EehvrMeaoSg4CXoPrgwGJuSTmwEdCOjwXet/QoH+uAwmVihcZ13Z6xINqJHd3/a31FT3+1Mcf6rUcDNz8wXHU+WzK+cDk3yuSk8PbI1JnPdmcNe3F9It/tFVyvwSALmFfEVI0nG+xPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/6Zwa6yQYgx1Hro9sVt7j8LaQ2LU/rFGzmX1h9gBtg=;
 b=P0Tdk1RMDuZLFUO9sMfOYhobUGBe4kbwmh8aE+OQqEtycnWbSDuC9oPm6hugzpw8+lqLaLYvXzp5oCJPc1xIh6agxhM86I3XAZByaxvL8Vh3hZX+Gi4BXyg50VKzC0/SCZX3jTgyh1L+QwkZzskvrXaTw3cl4urtga9zg5mzPnZU6KnDm9HApPXuSRc0yH8AVBJruYuwIblJFOVJs4x3mg00rz3gdaIofNBnz6XF5xy8F4/lcSgHOUiLaaO6XqhBpW20KckKAsTD++24XGKITCcqWK96dSeCZcff0YrGrQxRXvt1G6gLW0PhwQMCD+xDm8y6UdYQmXPHLdZF8qCMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/6Zwa6yQYgx1Hro9sVt7j8LaQ2LU/rFGzmX1h9gBtg=;
 b=Myx6cNdNhD95Q3vCv5Ss8A3iW6jNynDAN51gMT62jX0KzNqzC76aqeDFE6lyveR5A9ffF8M7ubEcBUoH60HuNDqoGNiTE55KsnPYRHDrwdUTpcINAiu4y2YC5OH43kDnMT9P4CrP3w9iBUoMUOhkJiaAwsWcnkhaVptL+OLZr/ON1z8oeP0qvxavvSmxVG2SUruCoiGMnUEX5OUtUdyN9pGIGuseucpjg/hvOkXrmrUUVJPnm+zOUMC7oy+pzA08BjfjocBT/lDISTZplwi6AhOWMXlM53Iv6MhYQorUEHMSlvz+5ngVTwxGmN7uxK5Q73UgKaiyBz/h8jg3GxUkDQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6047.namprd03.prod.outlook.com (2603:10b6:5:392::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:08:38 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 09:08:37 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Dinesh Maniyam
 <dinesh.maniyam@intel.com>, Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Kathpalia, Tanmay"
 <tanmay.kathpalia@altera.com>, Tingting Meng <tingting.meng@altera.com>, Tom
 Rini <trini@konsulko.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] arch: arm: dts: agilex5: Enable autostart on watchdog0
 only
Thread-Topic: [PATCH v1] arch: arm: dts: agilex5: Enable autostart on
 watchdog0 only
Thread-Index: AQHcpfxAbTdvaExLuU2AXH8WusIXZrXc9rdu
Date: Mon, 13 Apr 2026 09:08:37 +0000
Message-ID: <LV8PR03MB8137C30887F61517C6BEC00EA7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260225021238.21547-1-boon.khai.ng@altera.com>
In-Reply-To: <20260225021238.21547-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DM4PR03MB6047:EE_
x-ms-office365-filtering-correlation-id: 75724fd5-c2a0-4349-50dd-08de993c3f6e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: KiobE66BBs49wuBx9E+FkfV0Az0LnnqyjWdhrN8Cba3cVa3fuBqlS8W8aHOlRtFj4On95hSO/bCaVysdqHl028tQ/EXF+mjllXW/6YsL2wEqV/CbElCfgkscGfq4dbcdCnFs/KPpfss4ZIq3VjbuctV8ELc2gnGzvz85kFnqrm8uW7Dfc0ch6RTqblarqZF7O81fcrTphrjHsq/CbnwjUI0OXHM22kpTbc4tZsinRfm/FoTL1JPIIkK3aamrb4xNf0EyRLyl6iczaQGQSEJepSecbEL4WDNPIKTidz1oNsVzbNS32+3O+O7N4emDD69O391HexiKwi0DtutL7t3T+CGWBbaQIk7XhaEhO3gMaKD1BiLBeNBbWjuMLlUbTKl+wHUqO4occPox3A9GR3VXt14hnSTeXWzl3RaXx+4TPnS9Q5qBkgRzlQvjZuFIkS3AwLnyx6FFHJVFV6T4DjPY6j7NiDNMsoRqfQq7Tih3ah2Xoemm6SYd38y9e/REbdD1ulhYAXMQBhuiwK/IJ9DsMIl0JTv/NNiUAlRU1HKSA5ghYZcqLISpTWczwV/LUk5U/FnozijxeuFT4xuTy6+pZtgbCcQFtTMZLK6jN0EkPRvv7Q6apqbzV0whmXY307FB+SURi5VYFPGQOCRqyFDPQUik887N42tB9XHPZK8Rs1DaKvVJWHjB28843L165Oq0SCHiBlW8IR2axuZLVQIDlArfayptwvfaPlw0t71meIZ2Gzd+f+2t8HAWvp9asNwfZl9vEjcpWOGBxqi/tgpR/Hc2DtBsUaZEnLeANzoQ0uU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uEvJucMWfBd96ro4QgiJBUNApvTDozoHO9gZRS6DQkWO67kd/NZif8OsKX?=
 =?iso-8859-1?Q?/UjAoTg+pXrTUKP6IRTNrPiI+18ni8Sl/5rF2NP/jwC5JtkkcJCayw7pGB?=
 =?iso-8859-1?Q?Pv5rV9K438zklZbmN07N452ghKiCamROY3Q0DdkM5IzPy3Rsu1IgBXGcB8?=
 =?iso-8859-1?Q?7F/gH8wGmSi2RxFjd15T7KsPhKp+YOc92xiekIwyFKtbrCZJtuM2xmKSIM?=
 =?iso-8859-1?Q?QOibaNzDmskoCFXv2tyCnsbG3O3zJyl/bQtNLoat5HHCCeTrLwMyGX/VOh?=
 =?iso-8859-1?Q?vtmo2e8NEk+VnjgVP2VjDhPDFJysUXsAmTQs7V5VOz7yqdmc1yShu/Iyj9?=
 =?iso-8859-1?Q?69ghnh3k+rcMLWSrd3ORClvJ4AorXNAul2rB7W2ChOYpcPeBFmOtu4EHlB?=
 =?iso-8859-1?Q?Dtj0iJKVJ3yYEEgHD54/PLSlcOlnaunzjMluA7N+5sfNsYwojgaX52Z7D5?=
 =?iso-8859-1?Q?SxZ3aK6u+pwIEeItLdxSH8odjIw9hybfw9D+IQ/VT6/A2OrDiYBU9sY3Lw?=
 =?iso-8859-1?Q?tNpBk4fGB0vUWKQVaEFlM1mFwkZ6YmJl/5aHyi9S/SpBJBMnkNYbfY+mYF?=
 =?iso-8859-1?Q?GoOzTnzixAtKcfmFkJgbLt/N3ga9rQLfb8re3L4rScPpyV7x2vXf/kGs78?=
 =?iso-8859-1?Q?OlKQa8m9s1ATkwPsGaSBAcM2bV1SlmWuHHR/v0oY0C9KE5UzretGW/LQfB?=
 =?iso-8859-1?Q?8GW5OS9mo/qUkjqr15EzVLkoqyx0hsekex+n9nGAwGF8hn2LggDigc8QhU?=
 =?iso-8859-1?Q?4E+yVOwSzT2pkocDejiDYUiH1Ddj5VJk3q4C6GFBvyW7muHAE1OvM1FhXx?=
 =?iso-8859-1?Q?acrXZxEME1Nije8lySOsdn9v9zFM6nX6hMVgWVrNGY4jWWjkJFW0L9Befa?=
 =?iso-8859-1?Q?Jo3fxc0O0UhTRZgkCDDuIXEcy87dcptbeTdlY9doQJ2XXYQa2rV218uC4R?=
 =?iso-8859-1?Q?Ms6CrNM3yW66Pz1QPvvQMjqoqZ9Zyb6AGq53yf1zpZQ6w6LdnPpgrWrM/Y?=
 =?iso-8859-1?Q?zQ6RORmvjPdWJzGYxqij4XENX9kaiQR7qwCgoPJymx2hbyWVKw30pm6T+m?=
 =?iso-8859-1?Q?suH63icNUJHWvIC/vCXEesKUlNMVey9LM90QI6P9GThxo8X0IuzeKnV1wO?=
 =?iso-8859-1?Q?xOlhLEC3HnOa95+NAw1Ir4SK0LoPBUXwFgsfIilJnGRliw/A7fDLyrncJW?=
 =?iso-8859-1?Q?PfAZTuK8e4wFZP+E/axAboDvRokp6nd2A4zFlRzZvS23RICgp3HQGliobA?=
 =?iso-8859-1?Q?RujY/dRjiRluqWiwIeUW5X7KCsF3FEdfdve6EaBqqxU1fmzH8u0TaFm3lb?=
 =?iso-8859-1?Q?JGNYw1ZfMGmj4iXVGcIkh1kGZTaUwSLk8qe6Zn29rOAwC9eswiO/IxcruZ?=
 =?iso-8859-1?Q?62PBoWsTvhCHlykGYJga06b28aj1h1S909Bu4gNBczsilKNJZ/0kBo2RuG?=
 =?iso-8859-1?Q?MfEaKXTLvF/57Zz0C9CRTOz/MQzEo2oIMddTv0Y1YZ0mtFfP2mE8TCzS71?=
 =?iso-8859-1?Q?EdGH9wSRoNCdqxwlHjF7cLpdAJ9BkOE0l4S5N4z4tXJPKfHQCjX5W55/sC?=
 =?iso-8859-1?Q?n2QP9869XgFgFFnnpfou8oYunOyIAhGdJ0LjSCdMEtJXOZWNzlQ+v30Tuy?=
 =?iso-8859-1?Q?hmUaMyK0J77PZt3F+fu2TEm+WtAr29E9ge06grC7gg56HagXB8JmDCpd63?=
 =?iso-8859-1?Q?UQZ7FEjjZyIB1ef+qOu9+cffTLTu8WSy3+XSguZ768bgG7vxjhOo2nTP4B?=
 =?iso-8859-1?Q?YkhA7jYQ/hVYatgOQx1FCQbIQDtq30WW7Jnt3tK6ZTnrqeS15zO3R8cLeo?=
 =?iso-8859-1?Q?WNes0N37fQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75724fd5-c2a0-4349-50dd-08de993c3f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 09:08:37.3974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwANEYHHgSCZMuWpY33b49xO51TZwne26hPMnkrn2pj6wUVKZKxkmGuzuqt3WGy6HzeoyeDI4px7BSMek4RqI2UZoDj8Sgc7gHxee6vJctE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6047
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

> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 10:12 AM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Ng, Boon K=
hai=0A=
> <boon.khai.ng@altera.com>; Dinesh Maniyam <dinesh.maniyam@intel.com>; Mar=
ek=0A=
> Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com=
>;=0A=
> Kathpalia, Tanmay <tanmay.kathpalia@altera.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tingting Meng <tingting.meng@altera.com>; To=
m=0A=
> Rini <trini@konsulko.com>; Maniyam, Dinesh <dinesh.maniyam@altera.com>; L=
ok,=0A=
> Chen Huei <chen.huei.lok@altera.com>; Hea, Kok Kiang=0A=
> <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1] arch: arm: dts: agilex5: Enable autostart on watchd=
og0=0A=
> only=0A=
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Exclude watchdog1, watchdog2, watchdog3 and watchdog4 from automatically=
=0A=
> starting when probed with watchdog autostart enabled in the defconfig=0A=
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0arch/arm/dts/socfpga_agilex5.dtsi | 4 ++++=0A=
> =A01 file changed, 4 insertions(+)=0A=
> diff --git a/arch/arm/dts/socfpga_agilex5.dtsi=0A=
> b/arch/arm/dts/socfpga_agilex5.dtsi=0A=
> index 769678af31a..9a63a0b8d5a 100644=0A=
> --- a/arch/arm/dts/socfpga_agilex5.dtsi=0A=
> +++ b/arch/arm/dts/socfpga_agilex5.dtsi=0A=
> @@ -534,6 +534,7 @@=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
interrupts =3D <0 118 4>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
resets =3D <&rst WATCHDOG1_RESET>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u-boo=
t,noautostart;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
status =3D "disabled";=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> @@ -543,6 +544,7 @@=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
interrupts =3D <0 125 4>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
resets =3D <&rst WATCHDOG2_RESET>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u-boo=
t,noautostart;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
status =3D "disabled";=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> @@ -552,6 +554,7 @@=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
interrupts =3D <0 126 4>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
resets =3D <&rst WATCHDOG3_RESET>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u-boo=
t,noautostart;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
status =3D "disabled";=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> @@ -561,6 +564,7 @@=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
interrupts =3D <0 175 4>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
resets =3D <&rst WATCHDOG4_RESET>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u-boo=
t,noautostart;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
status =3D "disabled";=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> --=0A=
> 2.43.7=0A=
=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
