Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA36FEE6459
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E970C86785;
	Fri, 15 Sep 2023 13:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="TqB7ndf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A0D86680; Fri, 15 Sep 2023 11:00:53 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CE786596
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 11:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id E0070100008;
 Fri, 15 Sep 2023 12:00:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E0070100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1694768449;
 bh=dEtjIlum9E2WutR0h+P85zhA0qekHDw5zqIwQfOVByU=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=TqB7ndf74qQWLamIQinhC2iwfpiEjQnYLaKKmgViowNZgzRD9H0vONY1HIhps1z5L
 LgpQLqplFSsF54221U39WYtoqaCofqVaZyDXTKYbfhI9bUNbR5qA+3tNitcogWMUTI
 dniKURgtAaNdy/Hm5deFKykhinSiGa8x670pNDfCP0mFgoAkXf4dwYi8tTih33FWqU
 Fl5ReCIeIsxLlbbrqL6EJpfIyKhgn2bUCTIga+cXW8yiyltfwlBWRPdtPdG+ZMCPeN
 O2M6jh5gYRmURTl6FAcXr/6H8rmzZXoUwjXr5nnc7orfsOUBI/9vmVwAIsIIHtGquE
 dBPxQfp/ot1Lw==
Received: from p-i-exch-sc-m02.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 15 Sep 2023 12:00:48 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 12:00:47 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([::1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::80e5:bab:4999:4480%7]) with mapi id
 15.02.1118.030; Fri, 15 Sep 2023 12:00:47 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
CC: "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] meson-a1: dts: add hw rng node
Thread-Topic: [PATCH v1 1/2] meson-a1: dts: add hw rng node
Thread-Index: AQHZpESKQgBrmoKmCUuOnkfZaTr3ma+Wz9SAgIUbj4A=
Date: Fri, 15 Sep 2023 09:00:47 +0000
Message-ID: <20230915090043.vcdfuhyqcowfwvjk@cab-wsm-0029881>
References: <20230621132953.83343-1-avromanov@sberdevices.ru>
 <89fe8b9f-729d-f761-0e57-0defb2b95d3a@linaro.org>
In-Reply-To: <89fe8b9f-729d-f761-0e57-0defb2b95d3a@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <660B7DE66924BB40B9F3565242824136@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179883 [Sep 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530
 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;
 p-i-exch-sc-m02.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
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

Hi Neil,

On Thu, Jun 22, 2023 at 06:19:33PM +0200, neil.armstrong@linaro.org wrote:
> On 21/06/2023 15:29, Alexey Romanov wrote:
> > Add support for hardware random number generator
> > of Amlogic Meson SoCs.
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> > ---
> >   arch/arm/dts/meson-a1.dtsi | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
> > index f3560cbc3a4..1f57c137384 100644
> > --- a/arch/arm/dts/meson-a1.dtsi
> > +++ b/arch/arm/dts/meson-a1.dtsi
> > @@ -140,6 +140,11 @@
> >   				clock-names =3D "xtal", "pclk", "baud";
> >   				status =3D "disabled";
> >   			};
> > +
> > +			hwrng: rng@5118 {
> > +				compatible =3D "amlogic,meson-rng";
> > +				reg =3D <0x0 0x5118 0x0 0x4>;
> > +			};
> >   		};
> >   		gic: interrupt-controller@ff901000 {
>=20
> Weird, you introduced amlogic,meson-rng-s4 previously but you don't use i=
t here ?

This is A1 (not S4).

>=20
> Anyway please add those to Linux first, them sync the DT to u-boot afterw=
ards,


Applied into v6.7/arm64-dt here:

https://lore.kernel.org/all/20230823213630.12936-13-ddrokosov@sberdevices.r=
u/

>=20
> Thanks,
> Neil

--=20
Thank you,
Alexey=
