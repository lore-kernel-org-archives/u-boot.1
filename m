Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB37CEBF60
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 23:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F30588FBD;
	Fri, 27 Sep 2024 01:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="olhHpwzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4796588FCD; Fri, 27 Sep 2024 01:23:15 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8F188F85
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 01:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a9ac0092d9so142032085a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727392992; x=1727997792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M+PeOJ2xTNXv+DKQ0m7w2ar6+gn6uEyTs9XiAkux7kw=;
 b=olhHpwzRc/DLsHliGLmR7CpdbB4wNIu9KzFKJzV61RzbUG1IT2i255/DwOh6M6IHnc
 oel5GhbivimnA8ExVUjfZjZvQ3YgiJBL5CYjs4vFeHn00U4SzVBTsSiE7L7mdFiKFenZ
 0Wsly23cu/RSkcPsZC2CQwpbNrokj1qvjN9LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727392992; x=1727997792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+PeOJ2xTNXv+DKQ0m7w2ar6+gn6uEyTs9XiAkux7kw=;
 b=rMpL4B+c3nXn9igFq73L3tPtx17/anARmOqLkQkDOZ6T0cwm1Hmay24leMN+xA8Um/
 mLsA7itoQCDFxCRIvfWWsVyRA1CYyg1ZujvOzT2q8/xYMdbzYluELjeBoRAuq7mptSSW
 9ogKUEFxuacXJS6u767EVKkiv/XwOB3YgSWtTXx644Xm0oY4zlEnpkhKncJXhc3QFXnS
 PlMlZXC0uJQIwIbQdTIVav7Zz5NOFAZ6OPvmjGLNE9TuPyJiUeff5zygH/IH/FVzLrG4
 mEZa+RoEPnvf+atxN0W4KIefnpVxrC5JRRdHgVCghUZi15bHYJoVUUMY9BplRI79UeXb
 vR5Q==
X-Gm-Message-State: AOJu0YypDV46+/9bgtXZ+N12cURltoRkvQSvGrljizgPd0d4ad0o0y6n
 3kw9tI3d9LYGc8tkK8ggMe3jfXZ/Rk4HSEPoNx9OpwS11UP0LUA1ttacpRQRbzgmQMf5fM11SF7
 4hbQ=
X-Google-Smtp-Source: AGHT+IHf5Hf1sLOmMQHLVTX0eHZHbUojxs1YYCCm/HTRFNAnK3pbGKxXM/oFyg7Frq+fPYU+KIyDsw==
X-Received: by 2002:a05:620a:318e:b0:7a9:d4ae:5f85 with SMTP id
 af79cd13be357-7ae378c35f9mr191244085a.43.1727392991850; 
 Thu, 26 Sep 2024 16:23:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae376c3990sm35526085a.0.2024.09.26.16.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 16:23:10 -0700 (PDT)
Date: Thu, 26 Sep 2024 17:23:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 01/19] spl: Reduce the size of the bl_len field
Message-ID: <20240926232307.GN4252@bill-the-cat>
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-2-sjg@chromium.org>
 <20240926040636.GF4252@bill-the-cat>
 <CAFLszTjtW8hBpYMTUXZKALPUuC=4QE8=DQLgOn52XEmj6qg7ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OAmpG1T5MG8t0i1z"
Content-Disposition: inline
In-Reply-To: <CAFLszTjtW8hBpYMTUXZKALPUuC=4QE8=DQLgOn52XEmj6qg7ng@mail.gmail.com>
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


--OAmpG1T5MG8t0i1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:36:17PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 26 Sept 2024 at 06:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 02:55:27PM +0200, Simon Glass wrote:
> >
> > > This is a block length, so typicaly 512 bytes. Reduce the size to
> > > 16 bits to save space, before more fields are added in future work.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  include/spl.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I don't think this works as intended:
> > 02: spl: Reduce the size of the bl_len field
> >        arm: (for 1/1 boards) spl/u-boot-spl:all +8.0 spl/u-boot-spl:tex=
t +8.0
> >             chiliboard     : spl/u-boot-spl:all +8 spl/u-boot-spl:text =
+8
> >                spl-u-boot-spl: add: 0/0, grow: 2/0 bytes: 8/0 (8)
> >                  function                                   old     new=
   delta
> >                  spl_nand_load_image                         60      64=
      +4
> >                  spl_mmc_load                               320     324=
      +4
>=20
> Yes, unfortunately some ARM devices need more code to access a 16-bit
> value. Perhaps this optimisation is not worth it?

Seems not worth it, yeah.

--=20
Tom

--OAmpG1T5MG8t0i1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb17NsACgkQFHw5/5Y0
tyxECwwAjZ3q2V7NZfVFsyEccnZj1Uv+BTyZFqPzMMSkXuJeJA1N2C6OmMhXeI8I
na/g43ZVz7TxfSM2b4SoLFk3j236+e1AxVyQAcNtZAi7L82SVjm1pjBbBCR6OkVG
ad5oih6Z32+BUguRKaIsB0hd7E4jWdQY0XkXsHECswO/85mHTfPu6HpDET81nhvM
LrmOn9OwPWNk6cJqbWTL2M40bwc4fFJ3cii2Z/5JufNeKdb/c8Pr5z/WzHq4/VC/
hJKOQ24diTTlJtdnR1KdmosC7dkCmj/nnZr9Adb6c//SF3pHSpcETNujJJwRPO/M
0BC4hW7VKCZcuajpUFV42mEOsKUUUCDGQ3ecrRGj8cu1uKlWboaxasQylNkVjThr
O+3O7Rpz/i63RydReoZNjqrIXgpRK3e5dEmC6pt1pACRlojNUddWNK6jwXWv9jd9
FEyYx9mP9UumxKmmSQQlbazhACQS2vYwjbuZG710rPXJ5BhTh+cswiGZn2XXGiog
On9akyI8
=9/j1
-----END PGP SIGNATURE-----

--OAmpG1T5MG8t0i1z--
