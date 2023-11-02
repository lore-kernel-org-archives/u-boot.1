Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4AAC4167B
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 13:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A04875A1;
	Thu,  2 Nov 2023 14:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TBfDHEB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A42875FD; Thu,  2 Nov 2023 14:27:26 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9861C87588
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 14:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a86b6391e9so11471427b3.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698931640; x=1699536440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N8cEzirDcMusZD5vO4x1OdT7G70JFyUYCIZG6xg57uY=;
 b=TBfDHEB0EfFoho2Su3bLoubzPDxhBXIdSM0jSnrMbRjSHiGmpMRb0qOCsvFxD5fl6B
 V+ylFoCrGNhzYj6usNPHWb7BAYimqEiDcJYaWDk4Ko2NPWLmQIvFafuSOlALHnUPKuFQ
 xVp/0Uh6UHDBFI+TmJlMYIslQCtyVh8bZSKIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698931640; x=1699536440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8cEzirDcMusZD5vO4x1OdT7G70JFyUYCIZG6xg57uY=;
 b=qrYiTaWT8hnlIruv+rkkhkDMMPgLbOd9zVUYkeEXtRaMcL+i1nMxQaiB8DHTiSCR9w
 OPIA4vSLOWnncl51Suq4iwItq4lWC4y5ZTFMH+oiBKsRbnjyHxzPhfxUPl5hBdXDp9aA
 L3LUNGrjhXmsnunuR0DqGtqiuq/ExKvF11VtYM2f/39DXBi0MetOHdxiSBuY569apgLJ
 GqsgaY0chYeIRLHiFjqDUmQ57/gLHdnp32OmBkej3uOaAXsUXtdL6iGAeCLFdNhWx2WA
 HwrRwWBZEMNw9/W6SrPtV42xokWG00/gz3hRVNOfPWohPPLPq7/tWhMnQVnzn4a1dl49
 fkOg==
X-Gm-Message-State: AOJu0YwJA8Ox+hV/wRJvhqX3mMF6hAjLVRQ3szephmFsNc/zFQPFOV5H
 PI7uWcoyOAErDZp1A9mPqwLAZQ==
X-Google-Smtp-Source: AGHT+IF3f1v3c9L8p0Le3i5+aegviwPpHHoTu3fXtmIvzryWm+eon9L34Ogo9WyQ5TL4yj+jxT9nXQ==
X-Received: by 2002:a25:ae10:0:b0:da0:5b63:d062 with SMTP id
 a16-20020a25ae10000000b00da05b63d062mr19059331ybj.35.1698931640196; 
 Thu, 02 Nov 2023 06:27:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 q9-20020a0ce9c9000000b0066d04196c3dsm2391598qvo.49.2023.11.02.06.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 06:27:19 -0700 (PDT)
Date: Thu, 2 Nov 2023 09:27:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: u-boot@lists.denx.de, greentime.hu@sifive.com, vincent.chen@sifive.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Subject: Re: [PATCH 1/1] board: sifive: unmatched: move kernel load address
 to 0x80200000
Message-ID: <20231102132717.GE496310@bill-the-cat>
References: <20231026032254.23043-1-yongxuan.wang@sifive.com>
 <20231027164307.GY496310@bill-the-cat>
 <CAMWQL2grduFNgGPLYryXOaXTzVvO6Y9s6o=2MMQ3h8Mj8z8P7w@mail.gmail.com>
 <20231031115406.GH496310@bill-the-cat>
 <CAMWQL2g=5QC4aPq2onYy1XsPVYXOv6LuAE+hMuL4y=KhP0KBgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mg0iW4Mjz+eShrGu"
Content-Disposition: inline
In-Reply-To: <CAMWQL2g=5QC4aPq2onYy1XsPVYXOv6LuAE+hMuL4y=KhP0KBgA@mail.gmail.com>
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


--Mg0iW4Mjz+eShrGu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 06:27:37PM +0800, Yong-Xuan Wang wrote:
> Hi Tom,
>=20
> On Tue, Oct 31, 2023 at 7:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, Oct 31, 2023 at 03:56:45PM +0800, Yong-Xuan Wang wrote:
> >
> > > Hi Tom,
> > >
> > > 0x80200000 comes from the result of the relocated_addr in booti_setup=
()
> > > on HiFive Unmatched board. If we load the Kernel Image to this addres=
s,
> > > it will not be moved. Currently one of the first two 8-byte of RISC-V
> > > Kernel Image is j _start_kernel instruction, so it's OK to execute the
> > > header of the Image.
> >
> > Thanks for confirming.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > As a follow-up, can you please work on migrating to plain text
> > environment?
> >
> > >
> > > Regards,
> > > Yong-Xuan
> > >
> > >
> > > On Sat, Oct 28, 2023 at 12:43=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Oct 26, 2023 at 03:22:52AM +0000, Yong-Xuan Wang wrote:
> > > >
> > > > > U-boot initially loads the kernel image to the kernel_addr_r, and
> > > > > subsequently relocates it to memory address 0x80200000. Setting
> > > > > kernel_addr_r to 0x80200000 can eliminate one copy operation.
> > > > >
> > > > > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > > > > ---
> > > > >  include/configs/sifive-unmatched.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/configs/sifive-unmatched.h b/include/configs=
/sifive-unmatched.h
> > > > > index 74150b7d4b..de8bfc1123 100644
> > > > > --- a/include/configs/sifive-unmatched.h
> > > > > +++ b/include/configs/sifive-unmatched.h
> > > > > @@ -36,7 +36,7 @@
> > > > >       "name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_sys=
tem};"
> > > > >
> > > > >  #define CFG_EXTRA_ENV_SETTINGS \
> > > > > -     "kernel_addr_r=3D0x84000000\0" \
> > > > > +     "kernel_addr_r=3D0x80200000\0" \
> > > > >       "kernel_comp_addr_r=3D0x88000000\0" \
> > > > >       "kernel_comp_size=3D0x4000000\0" \
> > > > >       "fdt_addr_r=3D0x8c000000\0" \
> > > >
> > > > This is I believe subtly wrong. If you want an execute in place ker=
nel
> > > > image (and are using FIT images), this can be made to work. But if =
you
> > > > load your (Linux Kernel) Image to this address, the header will be =
at
> > > > 0x80200000 and not the payload so you still end up moving it. Are y=
ou
> > > > sure this is (a) not still moving it and (b) it's OK to be executin=
g the
> > > > header of the image like it's code (or is there some catch in the h=
eader
> > > > to lead to a jump over it, in that case) ?
> > > >
> > > > --
> > > > Tom
> >
> > --
> > Tom
>=20
> Sure. Could you please provide more details or examples of the plain text
> environment? I want to ensure I fully understand your request before
> proceeding.

Sure.  An example conversion is:
commit fc2af2d978b525e188b15d909e321caf9445bdb0
Author: Simon Glass <sjg@chromium.org>
Date:   Thu Jul 27 15:54:30 2023 -0600

    arm: rpi: Switch to a text environment
   =20
    Use the new environment format so we can drop most of the config.h file.
   =20
    Signed-off-by: Simon Glass <sjg@chromium.org>

--=20
Tom

--Mg0iW4Mjz+eShrGu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDo7IACgkQFHw5/5Y0
tyzB7wv/V9aLODV4/ZbCwdj4dgQf3mlgVzx7hcqtjum1SbX3AdNtGeQPss5gJ0nC
khP7vVHC4uaMHgGQvtarQDvbq0kpiSGP5dFzPQ86puVv59tSCeqRFGV8amas9nv0
g9bXisZQayCyN/3UQ6MENdmWhLlz4WhKFgDLNSKuAGOWrlCCeJAK/LTyAaOpc3sL
/TqvkYKPYIxL7JAnWB9P+9ylBf2Q6KapO/pApC378awv+sqIn/Sr+KkG6GkmUvTe
cy5tkXZeWdgYzeBbRM5Z1W6al8ViTwgEewU9BqP3OaGAeHVqk/XqZs05aSeIqk7v
F2DuVW0v9W6xPRv1IkRm8lhMTY2+EBGsTzXlKPmSGlZA76s2l5PueMI1WkpoZunK
yp8rlZ2Ho+UPWtxpj3gL1Y2x18utceKh26RaQAL6V04IiIYoUy6KZeWx1ivauz5h
IGG1U+9aMFAyLpdoeLSQfeiRmW3ANQZhDyHxJDao3RE5sK2Tex6SHdKAXuODVeiH
BH3NPhQF
=BvuA
-----END PGP SIGNATURE-----

--Mg0iW4Mjz+eShrGu--
