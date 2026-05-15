Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34651CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 16:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A412F846B5;
	Fri, 15 May 2026 18:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QB+tf9Wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F45846B5; Fri, 15 May 2026 18:03:04 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 839FD846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 18:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so5056942a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778860980; x=1779465780; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NsfM3Bq/2KsjkTnPXYT6RC7YZlpw8X6IsRw017xUjsc=;
 b=QB+tf9WttIqPdryKzRj1PGKLTmLvMSjlRcR6BFu6gYW4TFmEJ0Ple832TzanMO0RAQ
 M88VMa/4O16UuAuKlIz5/WA5TdRiwm+bRcrId3KHdHNT5dd8WD0BsxtlYvJkYiYkxEhV
 Gxiv5NJO45X3th5oIeNdrmG/RXOEHil1ZJ8hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778860980; x=1779465780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsfM3Bq/2KsjkTnPXYT6RC7YZlpw8X6IsRw017xUjsc=;
 b=SAXn4T0Z2H73weZx94CFUmgdBs4wJNuFgV69GDKBAvsuZefVCUdKsFIE+/oem7jaFh
 ajCgnABeKo/Ggne59nkKKsehONsdUC50qPAcyqExOz9lVmQdtALJ0354WWBseKS/aX0l
 UfDai0Qf+z8g1pIdxkE8xTiFjVzJ6ULAoaRw3Y9kF/lKUgnP2dU5Nmbb0n8ryFKwaEa/
 srshwelacZ6CjCCgiS+nXXdDb+EKDy1C1uZaHqxBPCvLtM2mxgL5lx5Ypk2XJqTV8TGn
 H/mtOsK4iQCLovd3GV/+AnlQuZ6dO/3t5Q83AkPSWwumdz9ILvYCsrrtqB5BiFUwtu9l
 zJwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cOTGxQaBn1RjoZPX6Ghc5gfIAHGsmCNLwCnQdRjhlVrnAnI6Bu29xo8SnaSCwMlo/N76P3lU=@lists.denx.de
X-Gm-Message-State: AOJu0YznFcNEjBsKo9Tjgzftj+rqbS00/LigXTGIOnPxgHEBRgFMBPqt
 /lAT1coi52vmupKBm3scBUXVgBG8PMGjNCE3QbyzrHp0H+5IVvqAFpYS3rBO6KayAWI=
X-Gm-Gg: Acq92OHfyUQsaYpLm/NAObCgedI56oEor27dtJyBtssMh5Lj9sQ2AanXjnJzi7dPNtT
 PW93rWjNS+bbhOjCIIK7QIBhPtUfBpQMdpUC0m9j2vnVuoVbpo7/keaZ7b3JePlx5zMV/hziGDf
 8ZvdN0LgWUKzfu0KpQM3OKJSU0cOWejUbC/kHJUdGAT4Tw8hrdJ3epLUWOk25SISwhPQD7AMwGE
 1Hlw7HyPNuwOJlnz6ujJh1usnu2yn0X4Rdkc8F181igAHnY+ZxKs1pW8WWs817kJ5IUvXSH8aio
 ofPIIk0O/a2432yIz8wje0Y32fMNWX0qgCR54id8Xt/zHP8WlzHqzo6ZKHDUksdnGUS6SMFVZyq
 tAOQYnS0mwqVJ0L7jQA9IezZ/vuJ5r/bpTnHEEtcrbJS5u816BYMm+O06Vwr5jroolYjUIVzbPV
 JyPmyL+N2AHB3daq+ZQr72kjka1TSQjX8yGh5pAXkqUAaBCO1BMvZs6DkdA2tKitbfm5Onk0OFY
 0dALaTkEDlBH4OWPSz+mkDaC95/HA1U9VOaq+6yLtYooSoY1mJItaWseaY2ww==
X-Received: by 2002:a05:6830:d04:b0:7d9:f50f:968a with SMTP id
 46e09a7af769-7e4ea03b63amr2844420a34.5.1778860979903; 
 Fri, 15 May 2026 09:02:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4b0adsm1606004a34.25.2026.05.15.09.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:02:59 -0700 (PDT)
Date: Fri, 15 May 2026 10:02:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, nm@ti.com
Cc: Wadim Egorov <w.egorov@phytec.de>, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
Message-ID: <20260515160256.GF1858239@bill-the-cat>
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N1PJXNfiJfEe/Kyx"
Content-Disposition: inline
In-Reply-To: <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
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


--N1PJXNfiJfEe/Kyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
> >
> > > A file like rm-cfg.yaml accidentally left in the source tree root
> > > shadows the board-specific copy. binman builds the wrong YAML, the
> > > resulting rm-cfg.bin may match a different SoC, and we end up with
> > > the following error:
> > >
> > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > >       Boot Notification response failed. ret =3D -110
> > >
> > > Move the board directory ahead of the srctree root so that the
> > > most-specific match wins.
> > >
> > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > ---
> > >  Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 552328f9f2c..1ec29dfe0be 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1682,7 +1682,7 @@ cmd_binman =3D $(srctree)/tools/binman/binman $=
(if $(BINMAN_DEBUG),-D) \
> > >               build -u -d $(binman_dtb) -O . -m \
> > >               --allow-missing --fake-ext-blobs \
> > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=3D$(of_=
list) \
> > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > >               -a atf-bl1-path=3D${BL1} \
> >
> > Why do we need to look in $(srctree) itself?
>=20
> See for example:
>=20
> arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =3D
> "arch/arm/mach-k3/keys/custMpk.pem";

That's not great, I'm sorry I missed it at the time. I wonder how easy
replacing that key is with a non-dummy key. Hopefully it's done in a way
that doesn't encourage checking private keys in to repositories..

> Also, people sometimes put files in the source tree, e.g. BL31 images,
> in the hope that they will be found.

That's also a bad practice and what BINMAN_INDIRS is for.

--=20
Tom

--N1PJXNfiJfEe/Kyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagdDsAAKCRAr4qD1Cr/k
CjW4AQD5mtHY+efAd0OWrGXEph6agrCR170b/pJATNGb7hqLZQD/bASaOwE6k1fr
dqK2yu/uld6S0//owAfL9u4gZ9QAEwI=
=T3AF
-----END PGP SIGNATURE-----

--N1PJXNfiJfEe/Kyx--
