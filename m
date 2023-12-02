Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74E7C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 19:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19984875CC;
	Sat,  2 Dec 2023 20:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U/i4qhKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0925875FC; Sat,  2 Dec 2023 20:04:13 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A1887554
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 20:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-daf26d84100so1556028276.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701543850; x=1702148650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WjALlrAVnJVJo1v+AVoT8zGWXVVCHavph+iS3F/9jB4=;
 b=U/i4qhKciABa/qK6o96xyO2ww3q3aZtzerNWyAL/J5IwlWj6aXfvIDTOtLGKvpH7tu
 mfB0dqmdE0EguM3MX31B1qU4w2B3F+8RsTXBVLk0Q/1fYtvF90niMH87ugjxzhj223fy
 mI/Yp9G92+yTuCeiWrMkHILOoc9pWn/XfbOG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701543850; x=1702148650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjALlrAVnJVJo1v+AVoT8zGWXVVCHavph+iS3F/9jB4=;
 b=BgbSADpss1U9F/R9yfHr6Opg83Zlo799KJKpxYoqV4uHNgZEF/aYTziMUChuH/TZel
 og4ztpHrFvMRhfNN9MmzVOgJnjS8w9EfjMEFMkg2UawSbHFl2+GXuYuZ60xs1u4Dus9R
 W6QwBZCd8Ut0KZIdVpglI0AR+vOLkzaDzp4M5vO+79sA6pDZ7HVYne1i5XvGCqYBaQYF
 7siIrD7NEAUyEdo8JifZ2HONIWa+y9VIDevNvDNTA/aejrV/4bHJ2M+QLK3lNQHqO9WA
 Xw0LNHTL7PESaSqg4ewjGPU6EGrmOYbDYI3Dnnc9lfOln1a/E0QZ1jCuFjQYCLmYKQi7
 e4Xg==
X-Gm-Message-State: AOJu0YzeriMNWIEGUq3lRDp5J2eXxW5wtjCmH0RAWIh4ZtXpbYt++uYs
 aQZZ+GMLdlZOAsaud+WijueAbQ==
X-Google-Smtp-Source: AGHT+IEX9xlb7EVJzta2TIEABDxRfyX7hf26KAKVtAS1eaQe7KxnMoVSQX5UeHhPbqgl+RRGnVdaZg==
X-Received: by 2002:a0d:eaca:0:b0:5d7:1940:b372 with SMTP id
 t193-20020a0deaca000000b005d71940b372mr1606573ywe.62.1701543850445; 
 Sat, 02 Dec 2023 11:04:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6796-c207-4c03-28b8.res6.spectrum.com.
 [2603:6081:7b00:6400:6796:c207:4c03:28b8])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a81a214000000b005d40a826831sm1372583ywg.115.2023.12.02.11.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 11:04:09 -0800 (PST)
Date: Sat, 2 Dec 2023 14:04:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de
Subject: Re: [PATHv11 17/43] net: sandbox: fix NULL pointer derefences
Message-ID: <20231202190408.GT2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-18-maxim.uvarov@linaro.org>
 <20231127181955.GO2513409@bill-the-cat>
 <CAPnjgZ157AQPoLse4OyFq2CrBZOf2AQX=aqvyw_q+tQeDQCUcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FTcpQHNwGJce1xz+"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ157AQPoLse4OyFq2CrBZOf2AQX=aqvyw_q+tQeDQCUcw@mail.gmail.com>
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


--FTcpQHNwGJce1xz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 11:33:14AM -0700, Simon Glass wrote:
> Hi Maxim,
>=20
> On Mon, 27 Nov 2023 at 11:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 27, 2023 at 06:57:00PM +0600, Maxim Uvarov wrote:
> > > Add additional checks for NULL pointers.
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > ---
> > >  drivers/net/sandbox.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
> > > index 13022addb6..75d32db3a9 100644
> > > --- a/drivers/net/sandbox.c
> > > +++ b/drivers/net/sandbox.c
> > > @@ -65,6 +65,9 @@ int sandbox_eth_arp_req_to_reply(struct udevice *de=
v, void *packet,
> > >       struct ethernet_hdr *eth_recv;
> > >       struct arp_hdr *arp_recv;
> > >
> > > +     if (!priv)
> > > +             return -EAGAIN;
> > > +
> > >       if (ntohs(eth->et_protlen) !=3D PROT_ARP)
> > >               return -EAGAIN;
> >
> > This part seems fine.
> >
> > > @@ -82,6 +85,8 @@ int sandbox_eth_arp_req_to_reply(struct udevice *de=
v, void *packet,
> > >
> > >       /* Formulate a fake response */
> > >       eth_recv =3D (void *)priv->recv_packet_buffer[priv->recv_packet=
s];
> > > +     if (!eth_recv)
> > > +             return -EAGAIN;
> > >       memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
> > >       memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
> > >       eth_recv->et_protlen =3D htons(PROT_ARP);
> >
> > How do we get to this dereference, and is that not a bug in the caller?
>=20
> I wonder if somehow the device has not been probed yet?

Given the failures on a number of real hardware platforms in v11 as well
(which I didn't see until after my review), I wonder if you've not
spotted the cause of all of those other failures?

--=20
Tom

--FTcpQHNwGJce1xz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVrf6gACgkQFHw5/5Y0
tyykGgwArcBCWCXEpRRLzqPJG3D7et55xQf9qU0H0vc9ArzpYElLwCqJr6KKlzya
KyKv3D6z72TJh6vUOTz1NswV9OtzSPnpM/JcKtiPMwHlu8RRw1H6JXsk/qbNPmTh
pgsH/jaYJ3oBqhNk4Q6Zfw1i8kQl8kxqzpu1FsFry98cn9RZliRKTiTLTKhlS0jd
jT4kSYurOI2ZKyEhm+5wcjAPHvSWeVx5kAFPAJdhBizL0uwxz+qFQOjEsFBjrW0d
dEKKwAkK0r1zN6nen6iurV8FPTIZgk6EHLAQcWFoEG4yVCJM5Uz/kO6BLLDtyMwc
pj18YtmUeExuOXZz2OZoGg2K1cHNvZc9kfrfYYCSwmkZSjhMxCB+DoeJYw1xQ4uF
PK8vk69UFxyeecJZMlZHTzLwEp+03EfpEZdy41JfzuQctksIOd5e14YuUeFaReXu
Qfp1xRoVKIK9ZfXzvodsKPmLA0TKzqjobb8Gu24ybmOxQAcE4LejfGTnt0CxgDSc
te+Ieh7E
=NFOk
-----END PGP SIGNATURE-----

--FTcpQHNwGJce1xz+--
