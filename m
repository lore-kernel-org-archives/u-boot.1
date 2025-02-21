Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8200BC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 19:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D95C280EC0;
	Fri, 21 Feb 2025 20:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LvHN6hDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5542880F5C; Fri, 21 Feb 2025 20:26:03 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3128807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220e989edb6so69728865ad.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740165959; x=1740770759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JECBJ7Moi5TUvs/1J/uT9IsRgsOO2V391W/ehqlQOpE=;
 b=LvHN6hDFgMaqPs8WRODZKLfCg5heEKdemjoWRmNlH+xwgH4aRUppgPmE1iMeKoRcUN
 HfmK3W3a8YLcpy27uD6UCyNSPQER5YJUoOe91L0DO+FfNerT4sksjtx9LDghZSTISNlE
 H7aTVFOR+Fx1p7jRlF4yj/e9fLOghwW8ioQEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740165959; x=1740770759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JECBJ7Moi5TUvs/1J/uT9IsRgsOO2V391W/ehqlQOpE=;
 b=GVcTpki8SPk3OGUKmYbTTmg3vdKx7KijuY+aAhK1HSSx4ClBn9LWKyp5xEvH60l1nD
 4dTxACkhwHhmk6kD0EnZ7EUnWkUhIReQ5o7f1UJX/6vqzTnmjT1adUXa/r6yqIO50CGc
 tY584y3rndmpK5j1yhRDTv9lKfgm+ESvr3O8sNM7GZX8s3EBGxTzugkzCrvwp+m2clN+
 GyUm5nnkSKgudwuERglyiFE3abjrCLk83eqrkilF9kDvVkADctKRZhq6K2WYxvNYz+Vp
 GjaJBC1Y9OrZ5VKucdJ663xaABxdPDnTfH2cfIJ8Zw30WSniSm5UQdjwAgd8WVD70i7N
 7T+A==
X-Gm-Message-State: AOJu0YwRTPT0KaIGoO2E77wp3Jm1651K3S1QiQFEiwZIO8y+0CXd8cn+
 a8aGpCkxA1AkgwE1BHuORBSaCDlWF4abbPE7Mh458enbWdB1/p3e+jcP6N8MOpg=
X-Gm-Gg: ASbGnct1vFcHN4eUSGtGBdRo3oqDHXGLSCNx3CU+Mt1Q6KGmi7NlDv6dIN3qq1cQ1eQ
 jgYH17ANFgwL8v7gbcp3ajBgJH7Rv6YAjkXOWYbAgU7B1+qUPoApu7hMzgr35TPhqEtl8D10js9
 40Wn8N1Zs4basQ65HD+UT/dck18N807cEyPAMyQiJ6fygV9wMlng70bqNG47buxgQmmRRUXhhHh
 ALcLrxqg7fQnTryFpNycuPVkLladXBRCnWQSi0Wla4K1UBDYYwbK6XvMR7GysSeswM/8872uFPS
 lzLnH6mM11pnvWwC9Y8iQtxY
X-Google-Smtp-Source: AGHT+IFoUlddSN6yVDHEbzj0IYU3GkUUTP3CIrcelZeTa+wo/J1DPZMNhfQPQ8l292WqBI+zZzd11A==
X-Received: by 2002:a17:902:dacb:b0:21f:c67:a68a with SMTP id
 d9443c01a7336-2219ff631e9mr73474075ad.31.1740165959396; 
 Fri, 21 Feb 2025 11:25:59 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545dd95sm138839845ad.135.2025.02.21.11.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 11:25:58 -0800 (PST)
Date: Fri, 21 Feb 2025 13:25:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250221192556.GP1233568@bill-the-cat>
References: <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
 <20250219203406.GV1233568@bill-the-cat>
 <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mh5uK74rzQQix2WW"
Content-Disposition: inline
In-Reply-To: <20250221141940.GG1233568@bill-the-cat>
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


--Mh5uK74rzQQix2WW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
[snip]
> > > I will look at "splg4" once it's somewhere on source.denx.de and I can
> > > look at it, and refrain from otherwise assuming how it solves the
> > > problems I had seen previously.
> >=20
> > I pushed an updated version to dm/splg-working but it is not very
> > updated. Still needs more work.
>=20
> Thanks.

So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
changes, here's another example of the problem with your approach. What
stops xilinx_zynqmp_kria from building in splg-working is that
BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper (or
since I always use O=3D, rm -rf) is needed for changes there to be picked
up, but that's maybe just a missing Makefile dependency line. But that
just makes it easier to see the next problem, which I don't see the
answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fine.
For SPL however:
  CC      spl/drivers/spi/zynqmp_gqspi.o
/home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In function 'zyn=
qmp_qspi_of_to_plat':
/home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: warning: =
cast to pointer from integer of different size [-Wint-to-pointer-cast]
  203 |         plat->regs =3D (struct zynqmp_qspi_regs *)(dev_read_addr(bu=
s) +
      |                      ^
/home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: warning: =
cast to pointer from integer of different size [-Wint-to-pointer-cast]
  205 |         plat->dma_regs =3D (struct zynqmp_qspi_dma_regs *)
      |                          ^
=20
And I don't see, really, what's even getting us down this error path.

--=20
Tom

--Mh5uK74rzQQix2WW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme400EACgkQFHw5/5Y0
tywpYwv/ZC2Oh90jo20RKt2IdNQuyZ+7vVEZViniaJVBMASlvruL+kT9tqoAReHw
PaKmfsK+PFZ2qdi1vpZHG5eTj5bsiatpWNRWOfsWE/+fPa8IPMkPkmQmaLwZ9C1W
uhT4Q7VFutNHsX8+vhpPOxnPdjoSyhOQp3dC5X+MHqaoahgq4G6WKwFoGoDk9+Aj
VDEqBDy38qubVT1KOY82nPYTRo8ENwu9+UdP8x9xCbuxv29V3t0xCsyOxG5mzybI
SzkFbG9czxFnoOhy0tGAcldwGDS4dAdPxr7ETYFvEesrJZ8aE+2USevCXhsQYmCa
vlmd5VVol9x4Sm3gGaIIh1CKV/vEGRo4Uh8o57AwV/cx9mfrOJLfPSwoay0l0VhT
MMTpx8QIk/mfPhc4it7PTPp+kIuuArWzwpUK72dYUiWAYArEwJDkGYC+G7cyoeYI
ESs0qsM9FijdOWwjK7T8ADXT+9ZBnvuvnJSVIQxWTZ3BlTBSN6Uw5wDbzv4UKn4x
xzTUeMJa
=ht9q
-----END PGP SIGNATURE-----

--Mh5uK74rzQQix2WW--
