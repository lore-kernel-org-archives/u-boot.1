Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB74ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 16:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D4388D17;
	Mon,  9 Sep 2024 18:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ufwfe8Xf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA75288D1F; Mon,  9 Sep 2024 18:19:45 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D84388CC2
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 18:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5e174925b7bso2870906eaf.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725898776; x=1726503576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i9p73k4oua7KgVJQWjG3/qvtd8pBpnIrsER8xyf67Cs=;
 b=Ufwfe8XftUAEjRO5n5CMJT/5o5tGUwcfRgcidW2VjJ0va54P5nXwBDF5yqlM85SkCS
 0IF06Tv6PrffFDxTULuU++xiNq1m1CtCwFy+PtXi/tBYDtd+XCm8GMgpmn/G1l0c5WO2
 dDB5eWD8klC9hSd2lAfTALdjh69C0PyAm9fqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898776; x=1726503576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9p73k4oua7KgVJQWjG3/qvtd8pBpnIrsER8xyf67Cs=;
 b=GbwM7JVpWE+csyudowcABHA4a9TC5Hqb8rR/u3Kd1YBuJnEOQDY8rXkftzWH7HXgRw
 BetP2c0rLnOOurC+ujBuSFsvXTeInOk6+0QELcp2kS7OMNOzjdY63GLlfvFEXuVlDMn+
 nMM8mES9TvHExHy9lZkc4A982MUxuunDjdx6GtajURVRIBvYINbIcZnOVZ2OC0Ytql4i
 kH8d0KTEK7iDRnoEtq1nkIo6OQR1Fp5Ji8Md7zrZU6GGrMzpcEBZ6ZNMt/D7odv1Xxhw
 oyoSTSV64SU/9c+aqxJTRNqKODD0s0lge77GzkJ5AjrhyRsqvk7Vx4lDbml8Kbn06lRH
 KEPQ==
X-Gm-Message-State: AOJu0Yz8UHlppGRZfvo9oM7aZIM1rlb68sVvWMr9mJLiC49ApN8EATJE
 LypN3o8p8r6E1OnWHd/qDB3O/ycqr/pPWiiuCpNmFJvTypry/Q2djsoreo4wBOM=
X-Google-Smtp-Source: AGHT+IHK2I6ZH7n1zYrp8uXmdHGFao9IbvD+q5g5fSYlgaaB4S43Qqw2K3XZlNrG9to7RODxE6DNAw==
X-Received: by 2002:a05:6358:787:b0:1b5:c53d:74b2 with SMTP id
 e5c5f4694b2df-1b8380e78camr777790955d.0.1725898776125; 
 Mon, 09 Sep 2024 09:19:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7967e7asm232412085a.38.2024.09.09.09.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:19:35 -0700 (PDT)
Date: Mon, 9 Sep 2024 10:19:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v10 00/25] Introduce the lwIP network stack
Message-ID: <20240909161932.GC4252@bill-the-cat>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
 <20240906175433.GE3879073@bill-the-cat>
 <4b66d045-5410-4991-96e5-1d9cd98cbdf9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="35Ss66Vv7KzIGTns"
Content-Disposition: inline
In-Reply-To: <4b66d045-5410-4991-96e5-1d9cd98cbdf9@linaro.org>
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


--35Ss66Vv7KzIGTns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 04:11:37PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 9/6/24 19:54, Tom Rini wrote:
> > On Fri, Sep 06, 2024 at 02:33:16PM +0200, Jerome Forissier wrote:
> >=20
> >> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >> library for the network stack" [1]. The goal is to introduce the lwIP =
TCP/IP
> >> stack [2] [3] as an alternative to the current implementation in net/,
> >> selectable with Kconfig, and ultimately keep only lwIP if possible. So=
me
> >> reasons for doing so are:
> >> - Make the support of HTTPS in the wget command easier. Javier T. and
> >> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >> so. With that it becomes possible to fetch and launch a distro install=
er
> >> such as Debian etc. using a secure, authenticated connection directly
> >> from the U-Boot shell. Several use cases:
> >>   * Authentication: prevent MITM attack (third party replacing the
> >> binary with a different one)
> >>   * Confidentiality: prevent third parties from grabbing a copy of the
> >> image as it is being downloaded
> >>   * Allow connection to servers that do not support plain HTTP anymore
> >> (this is becoming more and more common on the Internet these days)
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >=20
> > On am64x-sk (am64x_evm_a53_defconfig) I'm seeing:
> > =3D> tftpboot 80200000 EFI/arm64/grubaa64.efi
> > Using ethernet@8000000port@1 device
> > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > Filename 'EFI/arm64/grubaa64.efi'.
> > Load address: 0x80200000
> > Loading:
> > ... silent hang ...
> >=20
> > Which I didn't see with v9. I can test other TI K3 platforms if it would
> > help.
>=20
> Weird. I compared v9 and v10 (rebased onto the same commit as v9) but
> I saw nothing obvious. Would you mind running the test again with these
> traces added?
>=20
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 1948fc1c309..9bbfd8ee5a7 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -35,6 +35,7 @@ static err_t linkoutput(struct netif *netif, struct pbu=
f *p)
>  	void *pp =3D NULL;
>  	int err;
> =20
> +	printf("[OUT|%d]", p->len);
>  	if ((unsigned long)p->payload % PKTALIGN) {
>  		/*
>  		 * Some net drivers have strict alignment requirements and may
> @@ -252,12 +253,16 @@ int net_lwip_rx(struct udevice *udev, struct netif =
*netif)
>  	int len;
>  	int i;
> =20
> -	if (!eth_is_active(udev))
> +	printf("[IN]");
> +	if (!eth_is_active(udev)) {
> +		printf("ERR: !eth_is_active()\n");
>  		return -EINVAL;
> +	}
> =20
>  	flags =3D ETH_RECV_CHECK_DEVICE;
>  	for (i =3D 0; i < ETH_PACKETS_BATCH_RECV; i++) {
>  		len =3D eth_get_ops(udev)->recv(udev, flags, &packet);
> +		printf("[IN|%d]", len);
>  		flags =3D 0;
> =20
>  		if (len > 0) {

I have the log, if it helps. However, with debug prints added, now it
completes. And I can see (as part of trimming down my test setup) that
without the prints, some tests are OK. The much smaller "helloworld.efi"
file and test is fine.

--=20
Tom

--35Ss66Vv7KzIGTns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbfIAwACgkQFHw5/5Y0
tyz9OAwAllrb1Mmf9vEeH66ckexZA9iGHb4tqhrYm3mjKzJA8smH8GFRcXg7xHfT
5aTcAbX7zq0OiXatGcGgUauSH1bYPb6FBsK/p0V7Nf3kxtCboce7RZ9CxQe/5O1h
1O4tDIlmxXOHs74X18lkL0rdq7zTn7BDlDjIHcY6YdO1Vok2QifdLfTPLFpOnPMm
9Fzp/ODQ+Yr5TZvhJpptSMmUMgoRrSK3YFi4Qb+W9iXvredfkpbgfZbTAoY64p9G
WXev5CsOI1lndM3ZZvy0qJegJ115FicVTDzLjn6+18vkbl3cyetrksmcwmvMxw94
CUw05QQemWoyM+6It+wOISIqbb8QyxOUhRGdMCBO4BwOsbl+sHyRpHKGC58WWMZY
mI60fwh0kUu5ihL8qyn6cukvIZUYULRIUvDlcHtvopPHL9SeVPHhZ8GcoEg/tJro
PmJ2srWet61llL2Nd7mQOiC9OSFMGrcaIEkrW1RDS3Wuzjgv7Nby41OobUqYrWwm
V+fi0/HV
=cdu1
-----END PGP SIGNATURE-----

--35Ss66Vv7KzIGTns--
