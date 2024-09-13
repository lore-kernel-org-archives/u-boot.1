Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34475FA3757
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 13:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A0188D5B;
	Fri, 13 Sep 2024 15:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FAeXw1fO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10D788D8F; Fri, 13 Sep 2024 15:59:54 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFFE488D2A
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 15:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c355155f8eso7620766d6.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726235991; x=1726840791; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5ATcILJ08F4IyLfaSaA206ud4prL3FqNEqv83qTIAtM=;
 b=FAeXw1fO3y3fhjLd+6tfJM38f+pXHHVz7ORZ6AZuPQqU3O99IHKYscUJHzZ7Ue7aTp
 4pzRmeANBIs5cwtwX5I6Mc9qHvMsSPuHbc6wK5q4NMFe+z46ICnU0tBI9ljXIONFM+/e
 EZs89QjXEzpWsOAyZlC0H91RUxKzLpd40/tso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726235991; x=1726840791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ATcILJ08F4IyLfaSaA206ud4prL3FqNEqv83qTIAtM=;
 b=WMzD5rWHFfwVG7c4SEYYENucVp4GcRORyquC1cV+VYlrhzetqDqPnPtrvNEoHF3GV4
 3p9fFmY9nUY/cWtZO0WxiimICQ5fCQ2YqmIWt8uo+TDPQrkKBSnDmpfLy6uYMX1EZs6S
 gx6uHgwXu27SiWfOa05Eg68YjDyNi63ahwlUu+rTdPEVpm4AlqDbHfMelFRm+vmOmUYQ
 zqBcncjiL+gmU4zQcrh0pSkUNDpDwYAvPhcwoXPftWTcqvQQ68eXmmczXj3dmnbOBQ4B
 7zH8jQ4SVWIf2terTH9AHXINTetMOxBTF/uueYlSdgiqC+glOEg0qj53z+A1pz68vES7
 lnTg==
X-Gm-Message-State: AOJu0YwMW0b6QyjDOPT08FJ5JUzGkWyAyYRBPFt1rQF47LMIAf4KQctK
 yfCIeiTNLzcS83k0lBCMZyjuc4nvrgTNoLFsK8iUgKmRq4a9qXyjk+y5QfLnx+U=
X-Google-Smtp-Source: AGHT+IF43SOjRgYHhXt/3Yg9+SuXNizYVFyZbQSpErbldMCx/Ntds7Sz7m00BW/EkCXWGCHZ47t0iw==
X-Received: by 2002:a05:6214:469b:b0:6c3:5afa:e6e5 with SMTP id
 6a1803df08f44-6c57df6f936mr45487976d6.10.1726235991431; 
 Fri, 13 Sep 2024 06:59:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53474d732sm66775906d6.91.2024.09.13.06.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 06:59:50 -0700 (PDT)
Date: Fri, 13 Sep 2024 07:59:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v10 00/25] Introduce the lwIP network stack
Message-ID: <20240913135947.GW4252@bill-the-cat>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
 <20240906175433.GE3879073@bill-the-cat>
 <4b66d045-5410-4991-96e5-1d9cd98cbdf9@linaro.org>
 <20240909161932.GC4252@bill-the-cat>
 <ecf381f7-d48a-48a5-9395-c12b301108d0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tC/ivBEAnaXC1eI3"
Content-Disposition: inline
In-Reply-To: <ecf381f7-d48a-48a5-9395-c12b301108d0@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--tC/ivBEAnaXC1eI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:33:31AM +0200, Jerome Forissier wrote:
>=20
>=20
> On 9/9/24 18:19, Tom Rini wrote:
> > On Mon, Sep 09, 2024 at 04:11:37PM +0200, Jerome Forissier wrote:
> >>
> >>
> >> On 9/6/24 19:54, Tom Rini wrote:
> >>> On Fri, Sep 06, 2024 at 02:33:16PM +0200, Jerome Forissier wrote:
> >>>
> >>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add l=
wip
> >>>> library for the network stack" [1]. The goal is to introduce the lwI=
P TCP/IP
> >>>> stack [2] [3] as an alternative to the current implementation in net=
/,
> >>>> selectable with Kconfig, and ultimately keep only lwIP if possible. =
Some
> >>>> reasons for doing so are:
> >>>> - Make the support of HTTPS in the wget command easier. Javier T. and
> >>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to =
do
> >>>> so. With that it becomes possible to fetch and launch a distro insta=
ller
> >>>> such as Debian etc. using a secure, authenticated connection directly
> >>>> from the U-Boot shell. Several use cases:
> >>>>   * Authentication: prevent MITM attack (third party replacing the
> >>>> binary with a different one)
> >>>>   * Confidentiality: prevent third parties from grabbing a copy of t=
he
> >>>> image as it is being downloaded
> >>>>   * Allow connection to servers that do not support plain HTTP anymo=
re
> >>>> (this is becoming more and more common on the Internet these days)
> >>>> - Possibly benefit from additional features implemented in lwIP
> >>>> - Less code to maintain in U-Boot
> >>>
> >>> On am64x-sk (am64x_evm_a53_defconfig) I'm seeing:
> >>> =3D> tftpboot 80200000 EFI/arm64/grubaa64.efi
> >>> Using ethernet@8000000port@1 device
> >>> TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> >>> Filename 'EFI/arm64/grubaa64.efi'.
> >>> Load address: 0x80200000
> >>> Loading:
> >>> ... silent hang ...
> >>>
> >>> Which I didn't see with v9. I can test other TI K3 platforms if it wo=
uld
> >>> help.
> >>
> >> Weird. I compared v9 and v10 (rebased onto the same commit as v9) but
> >> I saw nothing obvious. Would you mind running the test again with these
> >> traces added?
> >>
> >> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> >> index 1948fc1c309..9bbfd8ee5a7 100644
> >> --- a/net/lwip/net-lwip.c
> >> +++ b/net/lwip/net-lwip.c
> >> @@ -35,6 +35,7 @@ static err_t linkoutput(struct netif *netif, struct =
pbuf *p)
> >>  	void *pp =3D NULL;
> >>  	int err;
> >> =20
> >> +	printf("[OUT|%d]", p->len);
> >>  	if ((unsigned long)p->payload % PKTALIGN) {
> >>  		/*
> >>  		 * Some net drivers have strict alignment requirements and may
> >> @@ -252,12 +253,16 @@ int net_lwip_rx(struct udevice *udev, struct net=
if *netif)
> >>  	int len;
> >>  	int i;
> >> =20
> >> -	if (!eth_is_active(udev))
> >> +	printf("[IN]");
> >> +	if (!eth_is_active(udev)) {
> >> +		printf("ERR: !eth_is_active()\n");
> >>  		return -EINVAL;
> >> +	}
> >> =20
> >>  	flags =3D ETH_RECV_CHECK_DEVICE;
> >>  	for (i =3D 0; i < ETH_PACKETS_BATCH_RECV; i++) {
> >>  		len =3D eth_get_ops(udev)->recv(udev, flags, &packet);
> >> +		printf("[IN|%d]", len);
> >>  		flags =3D 0;
> >> =20
> >>  		if (len > 0) {
> >=20
> > I have the log, if it helps. However, with debug prints added, now it
> > completes.
>=20
> Duh! :-/
>=20
> > And I can see (as part of trimming down my test setup) that
> > without the prints, some tests are OK. The much smaller "helloworld.efi"
> > file and test is fine.
>=20
> I suspect we might be hitting the test framework timeout, because TFTP
> with lwIP is slower than with the legacy stack as mentioned in [1] (lack
> of window size support). Although it seems weird that you don't see the
> hash signs at all, as if no data were received?

Yeah, it's acting like no data was received or otherwise just locked up.
If you have a beagleplay it should also show the problem. I can try and
find some time to check it out, outside the test framework, but also the
Pi platforms pass this test fine (same binary, same physical network).

--=20
Tom

--tC/ivBEAnaXC1eI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbkRUwACgkQFHw5/5Y0
tyyVSwwAolW+fifu7cvH1uZh8gof0uq9m6bF/huuvaDcaRpDFo9a3wHfF/SxrvC7
ktWNAdwNutcrlCZTMj4Ih5grrs3jRUcCJyPfTXYV35PS0nzVxMmDgwMBQKD7AhUs
pXjg2Yg978wUyAEDj+b1U/FFx/9Dw6Zw5kUioxs5F7UFdrkyzGvG6OabfhB/olPa
tjs5OP9aNdplTJLSrbudG85sFY7cMvncEVnXASPOccpdabljWxURe0NgX9OKbUDX
Moy7P+64x3gqzxSat1fKapZ7LK6K1sTBTXQK3X+GnWE2lLTgYF2ACRaTeUgVaqfP
3HXgFzFQz4BOIPwvreWPzpo9B9QG1JOXX7mqfrdkg7Of0vBPavufIqgi+W8ltBfd
sELWwVKlYuXRe4Vr8e3h/fImIgfj8blFLtAUk5P19glQ5tR74mSeozed/oiMhwx1
dpYkN4M5q/yZ4ooXFZ1PFYtJ15iaLpJEOgfD8mFBVQqMcDOMK5OwhOJiDWZj4Awa
1LWQF0Bs
=mtSn
-----END PGP SIGNATURE-----

--tC/ivBEAnaXC1eI3--
