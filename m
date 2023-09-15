Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CF0EE6459
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1A086998;
	Fri, 15 Sep 2023 13:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="mUCc4z9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5264686549; Fri, 15 Sep 2023 11:03:04 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD968653C
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 11:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 96B7212000D;
 Fri, 15 Sep 2023 12:03:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 96B7212000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1694768581;
 bh=UqJJfltXEXiviJGPrVSr2cVBwSX58hQxx64Nr7qlfsQ=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=mUCc4z9NjRc+zi5ZSm6fmE+zLjRWcdYo9hTmsJ32fThd53/8q/wGjlBaxePpIIcyH
 9a9ZabYUHK67HGiah83uS2tGojP5QRgC1TRSJ0atuWf4TCTNbwsqhvjg6REpzYupam
 qb1Q4jesbFv8AA592oyI3AoYu8HbTvjAlqdNW4N1mLQWbb4pYIZPTiYX80Ia6P9XEH
 v/cWqjRQzeCMH4mdvcw670hpOJfYfsUk33IahVi1X4g+UbVTQCTcWK5OwK++c4ua4R
 /OAPiO1SoCvEZG+h46hjo7B6NpZGUPrFzvD0RNCz5VLzVQM4hkwz4FeaXINkT0KDv1
 0Tcch+5Klb5pg==
Received: from p-i-exch-sc-m02.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 15 Sep 2023 12:03:01 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 12:03:01 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([::1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::80e5:bab:4999:4480%7]) with mapi id
 15.02.1118.030; Fri, 15 Sep 2023 12:03:01 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "narmstrong@baylibre.com" <narmstrong@baylibre.com>
CC: "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 2/2] meson-a1: dts: add ao secure node
Thread-Topic: [PATCH v1 2/2] meson-a1: dts: add ao secure node
Thread-Index: AQHZpESUCWYbW1/1v0+ihKwLQP3aD7Ab7AQA
Date: Fri, 15 Sep 2023 09:03:00 +0000
Message-ID: <20230915090258.dqzqqwvlp6rsjuu3@cab-wsm-0029881>
References: <20230621132953.83343-1-avromanov@sberdevices.ru>
 <20230621132953.83343-2-avromanov@sberdevices.ru>
In-Reply-To: <20230621132953.83343-2-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF3B2F778A8FC74A8DB61E5F2ABA444D@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179884 [Sep 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530
 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m02.sberdevices.ru:5.0.1,7.1.1; lore.kernel.org:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/09/15 08:32:00
X-KSMG-LinksScanning: Clean, bases: 2023/09/15 08:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/15 06:38:00 #21896258
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Fri, 15 Sep 2023 13:26:40 +0200
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

Hi Neil,=20

On Wed, Jun 21, 2023 at 04:29:53PM +0300, Alexey Romanov wrote:
> ao-secure node can be used to get information about the board,
> so, for example, using show_board_info() we can get following
> information for board with Meson A1 SoC:
>=20
> SoC: Amlogic Meson A1 (A113L) Revision 2c:a (1:a)
>=20
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  arch/arm/dts/meson-a1.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
> index 1f57c137384..149cc0e23a3 100644
> --- a/arch/arm/dts/meson-a1.dtsi
> +++ b/arch/arm/dts/meson-a1.dtsi
> @@ -145,6 +145,12 @@
>  				compatible =3D "amlogic,meson-rng";
>  				reg =3D <0x0 0x5118 0x0 0x4>;
>  			};
> +
> +			sec_AO: ao-secure@5a20 {
> +				compatible =3D "amlogic,meson-gx-ao-secure", "syscon";
> +				reg =3D <0x0 0x5a20 0x0 0x140>;
> +				amlogic,has-chip-id;
> +			};
>  		};
> =20
>  		gic: interrupt-controller@ff901000 {
> --=20
> 2.38.1
>

Applied into v6.7/arm64-dt here:

https://lore.kernel.org/all/20230823213630.12936-14-ddrokosov@sberdevices.r=
u/

--=20
Thank you,
Alexey=
