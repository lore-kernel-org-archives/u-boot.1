Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA5DE6FE33
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 17:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8DC88D25;
	Fri,  6 Sep 2024 19:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mDSzC1/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725AB888A7; Fri,  6 Sep 2024 17:21:50 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B26886F9
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 17:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4581e7f31eeso134401cf.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725636107; x=1726240907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=exv9vnsC2x+LB/rXuJXczUPgqlWHpSJjTDlb31ENGhk=;
 b=mDSzC1/yzrFvsCUHkioigWZUeY99oKhKqygJxmYyaOZcAGgkahgFzM7I5yM3i3BoLf
 FLr02WG7yifminKw9jj4EkjINS+8MetR86d804CYDWCeP8FbqgUJ1QQLyCacXNmBbWH1
 JzTq/xulYvd1QR4RkS7Us8pTdHlR0wQ4t7/Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636107; x=1726240907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exv9vnsC2x+LB/rXuJXczUPgqlWHpSJjTDlb31ENGhk=;
 b=LfEvYVB5bfCAvJ9xFOezU9WvAk0rqrwcVc64xP95sLMrIzirPGmNCeZZ4XPlQ3nzbm
 qeBsMQUSp+xCyueWw7EokFzC5NWZjbMiNoa7gpqbLGPRu0H1zMZWEGl6f7RKjRHm0ouj
 A1HYNEqRxAQzzIGJGJEmIz81L0lNVIEGO0Re7oCaS2Hy+6FbFRbUyxWZi6LsJ6qqD1dJ
 SziFi1ReDeUuzixCI2x6aGS/R2qjwj4ddjpU65am5vnOxctkQcSfVg+52BTUHKi6GJf0
 vzKeX1AM9l8mRwS/5i0qzpjbXAap9zmO0UlA5Y9L4ppRCob/BKojbQlunF1Zg2sOjAvO
 3L8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX01xuI5LGgJY+hUIcjfVggRVLzkWpxJk44rFt1qRM5grn13n0MkeszIvb5Qbn28CdtYgDrl+0=@lists.denx.de
X-Gm-Message-State: AOJu0YyyqnW47nIkMnhnAwclbeZMrh7QPTXT6wZfjWxxe0qaMUFoKOot
 kKIZ2ntQGBX66juMuijyu3T6t3LREa5xqWzEepZ2B6Cevd89mx7RLbiKUcRTIK8=
X-Google-Smtp-Source: AGHT+IHGxVh/AcwBrRwAZYMqSk6MKdQd25EMX8qvpLGJsjkgHrvdtXluSRWaOcPmAvXhIKZq5cKlZw==
X-Received: by 2002:a05:622a:1ba1:b0:457:c851:8b10 with SMTP id
 d75a77b69052e-4580c6fe459mr39342381cf.33.1725636106597; 
 Fri, 06 Sep 2024 08:21:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4581add3a5esm1969161cf.74.2024.09.06.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 08:21:45 -0700 (PDT)
Date: Fri, 6 Sep 2024 09:21:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Gilles Talis <gilles.talis@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Petr Zejdl <petr.zejdl@cern.ch>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Artur Rojek <artur@conclusive.pl>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Yang Xiwen <forbidden405@outlook.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Boon Khai Ng <boon.khai.ng@intel.com>,
 Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v9 20/37] net-lwip: add DHCP support and dhcp commmand
Message-ID: <20240906152140.GA3879073@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <36a13357261f734187444b48b74dec2540e73b86.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszTi3YRpf4krkAYE1u7Sex0=Dn_YscSKxE8mQEh9Mxcgjow@mail.gmail.com>
 <a946cdb4-648c-46a7-83c5-302ab0d666d3@linaro.org>
 <20240904152011.GP2479150@bill-the-cat>
 <5d0aa1f3-f8ce-46d5-8984-654a2786d5a5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U4SK8NIre+i4H2FB"
Content-Disposition: inline
In-Reply-To: <5d0aa1f3-f8ce-46d5-8984-654a2786d5a5@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 06 Sep 2024 19:06:02 +0200
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


--U4SK8NIre+i4H2FB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 02:09:28PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 9/4/24 18:09, Tom Rini wrote:
> > On Wed, Sep 04, 2024 at 09:54:15AM +0200, Jerome Forissier wrote:
> >> Hi Simon,
> >>
> >> On 8/29/24 16:05, Simon Glass wrote:
> >>> Hi Jerome,
> >>>
> >>> On Fri, 23 Aug 2024 at 07:49, Jerome Forissier
> >>> <jerome.forissier@linaro.org> wrote:
> >>>>
> >>>> Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP=
 as
> >>>> well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI d=
ue
> >>>> to this code having an implicit dependency on do_tftpb().
> >>>>
> >>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> ---
> >>>>  board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
> >>>>  .../imx8mp_debix_model_a.c                    |   2 +-
> >>>>  board/ti/am335x/board.c                       |   3 +-
> >>>>  board/xilinx/common/board.c                   |   3 +-
> >>>>  boot/Kconfig                                  |   3 +-
> >>>>  cmd/Kconfig                                   |  91 +++---
> >>>>  cmd/Makefile                                  |   6 +-
> >>>>  cmd/elf.c                                     |   2 +-
> >>>>  cmd/net-lwip.c                                |  13 +
> >>>>  common/board_r.c                              |   4 +-
> >>>>  common/usb_kbd.c                              |   2 +-
> >>>>  drivers/net/Kconfig                           |   2 +-
> >>>>  include/net-lwip.h                            |   3 +
> >>>>  lib/tiny-printf.c                             |   3 +-
> >>>>  net/Makefile                                  |  14 +-
> >>>>  net/lwip/Makefile                             |   5 +
> >>>>  net/lwip/dhcp.c                               | 125 ++++++++
> >>>>  net/lwip/eth_internal.h                       |  35 +++
> >>>>  net/lwip/net-lwip.c                           | 286 +++++++++++++++=
+++
> >>>>  net/lwip/tftp.c                               |  11 +
> >>>>  20 files changed, 560 insertions(+), 55 deletions(-)
> >>>>  create mode 100644 cmd/net-lwip.c
> >>>>  create mode 100644 net/lwip/Makefile
> >>>>  create mode 100644 net/lwip/dhcp.c
> >>>>  create mode 100644 net/lwip/eth_internal.h
> >>>>  create mode 100644 net/lwip/net-lwip.c
> >>>>  create mode 100644 net/lwip/tftp.c
> >>>>
> >>>> diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8=
mp/icore_mx8mp.c
> >>>> index e2ed70caa43..bfdc447c478 100644
> >>>> --- a/board/engicam/imx8mp/icore_mx8mp.c
> >>>> +++ b/board/engicam/imx8mp/icore_mx8mp.c
> >>>> @@ -33,7 +33,7 @@ static void setup_fec(void)
> >>>>         setbits_le32(&gpr->gpr[1], BIT(22));
> >>>>  }
> >>>>
> >>>> -#if CONFIG_IS_ENABLED(NET)
> >>>> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
> >>>
> >>> How about making NET mean 'net', rather than having two options?
> >>>
> >>> Perhaps the existing NET needs to be renamed to NET_INTERNAL or
> >>> something like that?
> >>
> >> The problem with that is it will make it a bit harder to remove
> >> the legacy NET implementation, because every occurrence of
> >> "if NET" would need to be questioned if it is applicable to
> >> NET_INTERNAL only or to NET_LWIP too. IOW, some of the thinking
> >> already done here would need to be done again.
> >=20
> > Would a new symbol instead help? Make both NET and NEW_LWIP select
> > HAS_NETWORKING or something along those lines.
>=20
> Well in principle this HAS_NETWORKING would be !NO_NET, wouldn't it?

Yes, yes it would.

--=20
Tom

--U4SK8NIre+i4H2FB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbHe4ACgkQFHw5/5Y0
tyyGnwv8C/20VUkUe2TBqibwW+rBfaVB5mnZ+hunhhLMoFJpJEUgL0I4GE8Uq5pz
pU7NcHhrzmT5tBtzG0wL+KFeoilbyhagPwQkNZvXXOLBGqZwxaSsmBRzIcFRRxFU
sJRNpIb1EzIZ574iGIUdy9dHCCo2aMo5u8VUxDNb5uAA+4jyXfyO98qcskqzA/v0
rGkuhsvhmrRPDhQZr7fqBSMz4FvAXL0EtXLdQqWI9GsB8N44gnqtZ9/2Q+SsIy8L
4C8TtV7YlxRFjp+DISCXsSv3H7zhceJfq8DCA+zQH5Z1TDchsWH4JE52ATbdeSke
lypRO6Wb8kP30+7/1M5GWeiAj5CSqVGZ80AXGgZrW6/7wtdhf+sGj539m1hPFhpU
ksi6YHPfsIkgyJZCs9ZxfYWR5X14F441V0O36v3lJfGTucLukuGeLXsJ1O8U7uPq
KyAaVlOSFMN9B6LQYI3BLSiB5Y8xD0BtI5wlsmetde9bcVkox/Uv+UeLMj+MfMGo
/DAw/yba
=4WPV
-----END PGP SIGNATURE-----

--U4SK8NIre+i4H2FB--
