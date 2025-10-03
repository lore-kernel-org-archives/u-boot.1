Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E3ACCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 21:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591C9838A0;
	Fri,  3 Oct 2025 23:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C6WOylIY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35BB838A5; Fri,  3 Oct 2025 23:01:56 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C4CB8386F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 23:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-42e6df6fe53so11270685ab.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759525313; x=1760130113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BFbqJ8O4Xcex29hkdLji41ActStYubYXxnBo2mt/Ecc=;
 b=C6WOylIYlUWgT3LnFGwQ/NNvSft6+S/eiUszcFFyTFp6RzRrF586uWospS55OjmRVE
 6xOE7n7q8aN7wQ3AuWKu9sYrzE7cR4oHk8vnN7dgiESt2qCKIVxJbeMpZEU8NzbV4aCM
 VYd+sGhiVPoIfxvwt3c7kOrXOC+uQH+CWF1a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759525313; x=1760130113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFbqJ8O4Xcex29hkdLji41ActStYubYXxnBo2mt/Ecc=;
 b=COdc3LmK0OqftWYxYnZKo41vKniuWo1C5pG2eE7pQRUuqP8J2WIdnJKXnGWdeadPvb
 hymbI2PH5eZlOmf2zQu5BG9JV+enfjawTBILVokFchhZzh0J94Abj4cysebTyU0bCKL6
 oBjOgWOk4BRVHJrijQhDJqrNdrc66LnQxTXtlTLaaOVyPGMmEUeKhA5/BaXw3p17dEeo
 wTDRC46z6qIFfi+fZKLIHm0NhEDFjeCgqpmpko7R1BVES41SciatC51mCDcmZyepcxdR
 fsO8C0adKO4W0/DqwS8ig0rTXQNpYLXGt2i7oDK+cfaPoO1W7MK7TPqyQqbVXjCzR7mY
 K7+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi3g7nGXX+X+QQHDFAhzN2SAX50zWOmGfFRsa7IZWA3c+y4U2Q1q1aU9wm7/whGfXQ25NDQFY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxn5g+TMW8BeNXN+2mx412+66fybe2j3xKBGXqsW5F/H4/bzjOZ
 w4rALthOkVAO2KcHX02YaYoZDTbxGY+puDupU+3gISckGpoTJW0FJ4qcVPd793GBWz0=
X-Gm-Gg: ASbGncvy99NR/JhB86Ewl+1XRgNmDkdHHqVYSze3D6F7bSUDNOBMKAKohmMtYqNkxJe
 cb2Fh65wCx7KnqUGzw5Nt/AICHS/sFO49bLFJ12OEN+zu9suuCmNksj9m8XKWMVelNeY03IT/p2
 kYBZkFdNeYZ8I0jkAnWo8482rf89ypQ7du/FzDSRvxOdAqxpob++DjGHSYcRNaWIAnF7A8+bHR9
 Fwz3HsLKhZKgjGHSVIEpTQn/WxPoJaTwYhs0f8KZxkHklamvUjCIoW205Vj65IZQkFj/WcuLQ52
 0QDe5MlTUqWPnYV+a/UcgTNZFj+GHj9pb/mGN7xusJp5mcr690HdqR9kRVMoXrZO+IwbSY2hb2V
 lB/630qnPGt7rKXZBAJ/hcbau8r4QDTbs66ZCPErVIwDUNWOk+Q2XPpnXSAdFEeA8PQaHDmnNCF
 0sjLtgyrdAsw==
X-Google-Smtp-Source: AGHT+IHo6YwsOd8g+YDpZdAPqoPol/XBuTzihjXRfzP81GbYkrhx6qf8ebabXgc+fFfCl23bqC9zyg==
X-Received: by 2002:a92:cdaa:0:b0:42d:8a3f:eca4 with SMTP id
 e9e14a558f8ab-42e7ad2e15fmr58516905ab.14.1759525313078; 
 Fri, 03 Oct 2025 14:01:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc84dbsm2213550173.35.2025.10.03.14.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 14:01:52 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:01:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org,
 tharvey@gateworks.com, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Message-ID: <20251003210149.GA6093@bill-the-cat>
References: <20250529150213.27149-1-richard@nod.at>
 <CAPLW+4n42ctJC2j5vUnibcWNYr+V1t8jfmD7p1ju95q8R89C-Q@mail.gmail.com>
 <CAPLW+4=gQjdoQA0qy71iDwAJz-fqekfGsUbar00m0Rm65YTHhA@mail.gmail.com>
 <10664479.lqRGMn8q6B@nailgun>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZIDIjWijU/nzyxFg"
Content-Disposition: inline
In-Reply-To: <10664479.lqRGMn8q6B@nailgun>
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


--ZIDIjWijU/nzyxFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 09:09:20PM +0200, Richard Weinberger wrote:
> Sam,
>=20
> On Sonntag, 21. September 2025 01:01 Sam Protsenko wrote:
> > Hey Richard,
> >=20
> > Did you have a chance to look into reworking this patch? I'm still
> > carrying a revert locally (to make GBL EFI app work), and would like
> > to get rid of it. Please advice if you have a plan on handling this in
> > the near future.
>=20
> Before my vacation I had a look but found no nice solution.
> So, let's process with the revert.
>=20
> My current way to work around the problem is having these commands in
> my U-Boot scripts:
>=20
> fdt addr $fdt_addr
> fdt rm /chosen linux,initrd-start
> fdt rm /chosen linux,initrd-end

I do wonder if the best path forward is adding some opt-in CONFIG option
here?

--=20
Tom

--ZIDIjWijU/nzyxFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOA5ugAKCRAr4qD1Cr/k
CoRaAP0cEqFPj2K2vKKLnvn02bSzTv6uIH/lLB0b0dIkdWhQ0QD/Y2qbDwSTHTa8
8u+AkEJ8murCh52hwz3CjITCpLkGxQo=
=hadM
-----END PGP SIGNATURE-----

--ZIDIjWijU/nzyxFg--
