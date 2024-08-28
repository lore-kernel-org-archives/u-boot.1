Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4605C636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 20:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12690885D1;
	Wed, 28 Aug 2024 22:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s6O7XUrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BAE885A0; Wed, 28 Aug 2024 22:05:46 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D982182BA7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 22:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-44ff7cc5432so53126101cf.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724875544; x=1725480344; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c0vWDuf5GNQKN4kyTBADOa7jzSnyYqk4M2qjZHwV1lU=;
 b=s6O7XUrljStR6HXnU57fv59dW3PEUPuffpBAXQs8sU/bzypXVm2fYHdyP8Enex5Zvm
 FkCKEN6lv/t0IFfiT0LtPIJRjwkXFo4pdagnDr4GHlRMq/ii49jn5YWo52+GB664DPma
 tJXapvbBr1PRDCuG5Hc9Ib6rtTfb1cLb9Fg80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724875544; x=1725480344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0vWDuf5GNQKN4kyTBADOa7jzSnyYqk4M2qjZHwV1lU=;
 b=RSeVjmbnE0Vx3cHOUIcUaURKM8Tu1BJVLmqZ5XXnwAl2mGwoQFQp5aVftEQR/p5wvC
 zKkf5fwP41OfiPsMKyIhmWj86jzxlTOz6F0BZt/gxG2tPH01/XoOE4Xjqz/iTb/ls/n+
 hr+jdN8iagSxt4OVulwQeC5FeiwqUzYqx2GhqfC2edfY+Bu45/QoWB5BsSQU0kiYuVXP
 9zSBNnOOzyBmYlRIh51RVhQ9j2GFjFaHliBI5m7oPCUg72imwMecKZV0/knTUEhFwRNa
 +1sO5PFVgIBwn3xqNk4xeRtOR9K7TaiU+/DHIn5DNfBtOBtXY0IHSKwwhsyXazGUWGw1
 SQ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWApy9KoNAukcqZc+CulDSVtS4uP+4ltoeIIrADEF4v+A/UxSRr/OlTA91MX/zTPlFqhT+gCNU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg42BJYnxVKwFxPjWBucZFtMQ4I/PrCTbB+OF33F+VKf4ATXNV
 y0d6yB7siC9sk1micm2gigdAbtwJ/Y5sYwK8djcSchI8FM7F9BpLfazbE4T0Plw=
X-Google-Smtp-Source: AGHT+IHoAPiciTNH3UTDL/o7tonwPwOM7byvHso4zIrU7B38zQlKQwo1+mGrgV32Nq/fwjEKq809Tg==
X-Received: by 2002:a05:622a:418f:b0:445:50f:b586 with SMTP id
 d75a77b69052e-4567f5872e9mr6757161cf.35.1724875543609; 
 Wed, 28 Aug 2024 13:05:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fda0d474sm64529441cf.0.2024.08.28.13.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 13:05:42 -0700 (PDT)
Date: Wed, 28 Aug 2024 14:05:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Message-ID: <20240828200539.GU2479150@bill-the-cat>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qLP0QlMrE2EHHwh4"
Content-Disposition: inline
In-Reply-To: <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
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


--qLP0QlMrE2EHHwh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 07:14:01PM +0100, Peter Robinson wrote:
> Hi Simon,
>=20
> > With Labgrid we don't need to specify the various methods, except for
> > the console, which simply calls labgrid-client.
> >
> > This allows supporting any boards in your lab, without adding per-board
> > configuration to these hooks.
> >
> > Provide ellesmere files as an example.
>=20
> What's ellesmere?

That should probably read something like "Provide ellesmere as an
example lab configuration".

[snip]
> > Changes in v2:
> > - Make use of the common script (only) to set bin_dir
> >
> >  README.md                    | 50 ++++++++++++++++++++++++++++++++++++
>=20
> Maybe that should be in a separate labsgrid readme?

A followup / separate series to better document all of this would be
good, but TBH I feel like what Simon's added here matches the rest of
the document.

--=20
Tom

--qLP0QlMrE2EHHwh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbPgw8ACgkQFHw5/5Y0
tywViwwAtgYi8rx90XlHxs2kmHdZLjQqVQMBAPVyyhpJEa8ywwgRemyiJmNncOcm
q/pd4WmNFeo/Y0fSzxSLZ6YJEzgPj5CI6o25WyRAy0Lb2UOHA41XNXg9ylkIRwMm
HAR9NM1EhaYxf0AlyShcf1JHvT76N/siiU/DAa7sGT0El6n8zDHDKP5Smly1linc
yd3tr5DYnTTXxP7bGmv/kAv4hOblkb9Aw92+GbhmMSQDJDpAIh3IMzPIgdDtg75F
ieS3rV4/BUQwX4a5JfXXUw3f+f43n9k0tfS9oFFKTStf9FiilMmOrYDeU0B5E62M
3jE3Q+OuMm3GWKyj8/ulRrng3dpSc9FeKjZcVtwwGGoKR/tu6SaPgj4CsNUiIQLq
tZyFiCXOOb/Z5rveROgNQ3hQP8D4rGDzAw3Zji7RKtDvpi7DKN9gHLtM5uL+2aC2
t5dX+CaolPxf0ikYP02Sa4ZEx+bXoVqHL37yfhbKwepnKWuiS72y6KqrERqB1FWH
hgdUa+q0
=BT+J
-----END PGP SIGNATURE-----

--qLP0QlMrE2EHHwh4--
