Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B2EDF17C
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 16:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFDA883015;
	Fri, 13 Feb 2026 17:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WHUbtfiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDD483AA9; Fri, 13 Feb 2026 17:09:00 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3176182A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 17:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d1872504cbso1035362a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770998937; x=1771603737; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N4j1e5GgqKTe7of2VpZmUSB8vvlhEG1c/GRajm9SVC0=;
 b=WHUbtfiyxSzyq5P5WhBA4TxyqbGfMX/ha5mlPKuVQvaCWP192QQ/kQed4LnzuYXDIT
 5j/bfOvlLO/9xH7gUXGvQfY/zUBt3nT/fa/Cxf9ufDjw6c4KXz85sXXRlADxYtIC8L2O
 VDpyFYUBn6gdzU44h5rQVEAhifJf5MfUYKBMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770998937; x=1771603737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4j1e5GgqKTe7of2VpZmUSB8vvlhEG1c/GRajm9SVC0=;
 b=bL7fnGXYSQ9ZPAKYtimOovKyrFQr1SlVgzLTUGakSY0NBu2h3TdjZIvY7xzOZi+4Pg
 EOip7W29j388TG4ZRB4NUQm/FWL8AbbD0sGewsuAnx0p3o0kCVmNujQ06gILLFJH8lb7
 TE9edt7W1BmMrkas2oQHKY1T5D7zprNVXZVp4ElMObX4kDz5vObI8iO29CtRRqv2EXAu
 rMpmvu+VxuWNQp4m1d/rz1928yMtzLANQH2noxiX4pStz+rVfMubs4bpHojUpSOQ2ro0
 CK6WSEPSQLJztSFD3G3QaHVhQ+0o2BBlBaYI5DIfafBB70IXlEwlL7V0f6KM9gRGwWg9
 xp0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW86UFpSbqF2xjsF05PwKpvPlfkBQDM2pvea0SWDXuor6yN1WCvo1s8eiZk2ZsACepYZneChwM=@lists.denx.de
X-Gm-Message-State: AOJu0YzC6VglPQ0RpwqIxNLa4GeG8E82/Va0qj2azHStAHQLVYsgygUj
 E9RLUdjiM6v0ZqNDJiq/noE15XNXNyq0+0WRuxh0SglxdwWd59/rukDXQS3Vsh+NRLIrazj0aVQ
 19WdyTcg=
X-Gm-Gg: AZuq6aJH7SMfl0MoiOgpxqNgR39YeU1DWih8g2yiORlZmVs8DEFAnIvqsbuQrwV5DFs
 fXWPURAtED8DVX54hk++Xm28nO/RQI47D4lKzjDsq310M6yk7oWFJqm2SWFLj9rgC94cMkNyuQB
 qBIzdbaVLLavqEk3JR/8YiVwUOMzkzM5kJGBPabJLVruM69bsNzGdJ4s5vnBUZCrJVIuRycH5cY
 VfNY5fSwUH5E6V6WXaYX0y/x7GPhqa9YY/J7iYbPEron6CEW5TZqBt3mdr9VAfMndHDQDcN0s19
 9aqIISaibiETX5tKh0Tf989iDyK9DqrYytAewNubGKRr1RTRlFootY3aGRrA51VPZzJLFwbsnZ6
 rYTYOATVy6uE8vzwZiydgoTyOEDUW1O/pWRrLDguzeAGZ7+smQwllpU6CQL69Y6pm2bp4F1QEiR
 WDq5ykfTUuyKUgxZ4LUSgaGtYeZkInUnr3KqHscH9lO4BVEHyS9xAobCxgEMW7jW9oc3e7sM/XJ
 N7S4eGXlRwbtgAXvRkcPoOv6SIxg0Ncy72cK88rCDRLXBONPpXP9ggHEf763A==
X-Received: by 2002:a05:6820:f02f:b0:674:4b83:8720 with SMTP id
 006d021491bc7-678208a4ec0mr243424eaf.13.1770998936672; 
 Fri, 13 Feb 2026 08:08:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6772583294bsm1442528eaf.14.2026.02.13.08.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 08:08:56 -0800 (PST)
Date: Fri, 13 Feb 2026 10:08:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for AT25SF321B and
 AT25SF641B
Message-ID: <20260213160854.GA2374632@bill-the-cat>
References: <20250701-nor-v1-1-ca3435d582d2@hifiphile.com>
 <CA+GyqeZ+vj0cQMT51=OTTPaya26p-fiwNJLzJqUC7Q1O3NmP1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6rwOFs55kYbSUeqg"
Content-Disposition: inline
In-Reply-To: <CA+GyqeZ+vj0cQMT51=OTTPaya26p-fiwNJLzJqUC7Q1O3NmP1Q@mail.gmail.com>
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


--6rwOFs55kYbSUeqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 09:47:56AM +0200, Zixun LI wrote:

> Hello, any update on this ?
>=20
> Zixun
>=20
> On Tue, Jul 1, 2025 at 5:16=E2=80=AFPM Zixun LI <admin@hifiphile.com> wro=
te:
> >
> > These flash chips are similar to AT25DF321A with Quad I/O capacity.
> >
> > Signed-off-by: Zixun LI <admin@hifiphile.com>
> > ---
> > Tested on SAM9X60 custom board.
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-id=
s.c
> > index e7e97780d7cdd27104fd7db900b3a779d2188922..18bc6f2f06e9a02594da6ad=
1880489e78458a60f 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -76,6 +76,8 @@ const struct flash_info spi_nor_ids[] =3D {
> >         { INFO("at45db641d",    0x1f2800, 0, 64 * 1024, 128, SECT_4K) },
> >         { INFO("at25sl321",     0x1f4216, 0, 64 * 1024,  64, SECT_4K) },
> >         { INFO("at26df081a",    0x1f4501, 0, 64 * 1024,  16, SECT_4K) },
> > +       { INFO("at25sf321b",    0x1f8701, 0, 64 * 1024,  64, SECT_4K) },
> > +       { INFO("at25sf641b",    0x1f8801, 0, 64 * 1024, 128, SECT_4K) },
> >  #endif
> >  #ifdef CONFIG_SPI_FLASH_EON            /* EON */
> >         /* EON -- en25xxx */
> >

Sorry for the delay. For ease of future re-syncs these should be in the
upstream linux kernel first, and then brought to U-Boot, thanks.

--=20
Tom

--6rwOFs55kYbSUeqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9MkgAKCRAr4qD1Cr/k
CmZjAQDAP2v6GDWEQiN+KGCsURKBAO7w+99R36lLHUU5yQf0gwD/UCJK5zczdua5
XRy6MLSlZjh3KLwlpBLjGses2KkE1gA=
=bXYn
-----END PGP SIGNATURE-----

--6rwOFs55kYbSUeqg--
