Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2C9CF34CA
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 22:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD96988E3F;
	Fri,  4 Oct 2024 00:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Du3QK1/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFEB388E65; Fri,  4 Oct 2024 00:25:41 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E41E888D75
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4581d2b0fbaso10432921cf.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727994339; x=1728599139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/tdPGKTRpyNy66gWpeoMRW/UZC0CGNA76S61xsVjTag=;
 b=Du3QK1/OEsKT0rlU+hEGxRIvpOTyoeneJ6qRTGwbOyDxuQTynXP8ZJiskZHCCCr/jN
 v9gC6JFEinr/I84MgvajOcxnR3rCLFsQWaCkz2O06oIZvpi/sdFTRaOGMWjkVUl4M7So
 vsQbXsFoCZBl1XfWOu7iuvOUlhUD32NFFsSq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727994339; x=1728599139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tdPGKTRpyNy66gWpeoMRW/UZC0CGNA76S61xsVjTag=;
 b=eIJ7nZ23Mz05B20y//3DbMhHpy/99flc5sH2rzXLWCbTWh/0SZkGp0qgqTudAnzewI
 ceo15jkA/v+zHGORG4BYfi31udztf2eQfbB6z5p/mAmffiSpTHALi3GOFjvpB3Ie3SEq
 G25JUg9c7qgehSjDCyun9DzFpbmO1VjP4WHGbi9PuexYQNyo+3rLV1ui6BZJENI0xhYk
 9lrm0WqlT6+gISEcq5Lf/72DqBMA0O5HE7y5PlVWTbeL4s1RGXtaFg6N/d1bJVj52LEg
 MiIiujRjIB3yn3h3R14gfzuaHDZ3NgSXnd6mx/Pd+7Ou9svBzTFzTeHk/GExVcrasB6O
 dwaQ==
X-Gm-Message-State: AOJu0YwrOOdSDRmKdyvx7MJtesWJvZyIDyUAF2tsMuD8wWBRiCOLxP00
 O8iBW8ug8LY6JK+xroT/amQjlMcljGBtVRN/9WrLGddud11wzd9KAus7WNFSrSw=
X-Google-Smtp-Source: AGHT+IFtNEtUC6UYQ6GkzKNQoRDC09+X2lFVHE7Hq2fAJVteYHlZUFxRb/q69xK5TQcyuzeCzLuCYw==
X-Received: by 2002:ac8:5a87:0:b0:458:4b53:e0c6 with SMTP id
 d75a77b69052e-45d9ba630b3mr12099081cf.25.1727994338810; 
 Thu, 03 Oct 2024 15:25:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ed4f49sm9064321cf.67.2024.10.03.15.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:25:37 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:25:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 37/37] CI: Enable qemu_sbsa
Message-ID: <20241003222534.GX4737@bill-the-cat>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-38-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x3s5xTd89H/kNwgJ"
Content-Disposition: inline
In-Reply-To: <20241002094832.24933-38-patrick.rudolph@9elements.com>
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


--x3s5xTd89H/kNwgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 11:47:28AM +0200, Patrick Rudolph wrote:

> Add QEMU's SBSA ref board to azure pipelines and gitlab CI to run tests o=
n it.
> TEST: Run on Azure pipelines and confirmed that tests succeed.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--x3s5xTd89H/kNwgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb/Gd4ACgkQFHw5/5Y0
tyzJlAv/XVtUDkrEoATy2oY/uUiClHL3babaxYqMHBQrbPxHUTWK2OTH0A6rMvbj
WjFFNFCauVkM8Lg+pdjKoSBvNAmhDvl8pXLBhSX8hw6BkVEE6uenuTyQ9T820uPK
fMhIvL+akImmiCWtzMpjqJZoDSOc3dQ/C+sQVoRf7c5za3wMcc36ZXdJeC5XsX+H
IeMGKI+OPwA9tXllMp/MKUQ3a/A1SeERwvDMbsSYmqdInrUu6r/fXv71zfvUGme0
0/JBguK+qsNZ3t73fU3UvF1S1xX7NOEMvDNvIQkCfakC1xMyEm7TjPy3jS+jbCX6
6EpqbvRHJxhFKOcUxtZ+hnxmHeiOFXulKvjcwjx2iaq2yX5sta4q1qAGHEspjw+T
VitEwJUknjrj7pokXtaNA8bWCbSXWsjrM6kP4R8ExH0I02Qzh+iDcSbqP5dL7j3b
SkDGnVbIMRVxSbNssrjG2c/424rjS6/MtSeqimRhkQweKhkNe2qipfac7Ly0umaA
NQdlH+5x
=7jF3
-----END PGP SIGNATURE-----

--x3s5xTd89H/kNwgJ--
