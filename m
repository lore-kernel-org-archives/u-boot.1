Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6E4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 11:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E210887CA5;
	Tue, 31 Oct 2023 12:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aGj6pmYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964E18757E; Tue, 31 Oct 2023 12:54:17 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7835A875EB
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 12:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d9caf5cc948so4993412276.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 04:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698753253; x=1699358053; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cdhYHpQkVUx1xx3v6V44FRYNQssqzpeyjj1sDtLIn34=;
 b=aGj6pmYJ2HdJfDRMO2iAka6gez819MyH+Q1vq9xxwiBQi8ZSQqLSQQeRQgiC6SZqQC
 3E/mL+qvobRVuY+C8XVgUjtxdnniy8s96XI+m+fweb0kotmAEBnUrqpjswCu3TBw5ZPg
 apolfuAmmB7rSSjbYFywZoA3oFTiMisA/1ee8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698753253; x=1699358053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdhYHpQkVUx1xx3v6V44FRYNQssqzpeyjj1sDtLIn34=;
 b=QWGBTfMQaiNClBT70CSNXTbYIWFzG8thO2jkZUOjwJAxCpy+taF4HqjKCxmMJkRjyi
 ce6x6l2YJlDooJZDem/nK6GhHA44iar9PPI2FvCb/JyZyD6uwMmB/Culbj2+oxIR6MWi
 y0dKshv5sP8jKajDdbClRRK5MSFnHUSipQtnkh6Y+Ockb8GzhzkiZGrrATXldetpcKrT
 ZOKpTXevI3MrF+1DGFGLl6OR028IiV8K+M8MpKuteoLQps0txKY5ckpwYqnt8sb6gWWr
 FGenX9ue/kiO4HckFlWHiYv8Cud2rwLDQqjvG8M5W79lTQ57AD047sitFlzNShncG3Mu
 2vOQ==
X-Gm-Message-State: AOJu0YyP+eML5t0vX9IWplrjsplkS3HHE8ROQ+lqLHGjFqzs7rnpYMxF
 MygibVyG3q/tsEVouq2op6E+yQ==
X-Google-Smtp-Source: AGHT+IG3+yM9mBvK+ak1+kMgYaYqJ24CVdskQEQm8yMd20cfmBYUiV+BxFpnXjwIU7H+Gr25McSdog==
X-Received: by 2002:a25:db47:0:b0:d86:357:e314 with SMTP id
 g68-20020a25db47000000b00d860357e314mr11634195ybf.47.1698753249200; 
 Tue, 31 Oct 2023 04:54:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 ki12-20020a05622a770c00b00400a99b8b38sm422000qtb.78.2023.10.31.04.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 04:54:08 -0700 (PDT)
Date: Tue, 31 Oct 2023 07:54:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: u-boot@lists.denx.de, greentime.hu@sifive.com, vincent.chen@sifive.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Subject: Re: [PATCH 1/1] board: sifive: unmatched: move kernel load address
 to 0x80200000
Message-ID: <20231031115406.GH496310@bill-the-cat>
References: <20231026032254.23043-1-yongxuan.wang@sifive.com>
 <20231027164307.GY496310@bill-the-cat>
 <CAMWQL2grduFNgGPLYryXOaXTzVvO6Y9s6o=2MMQ3h8Mj8z8P7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9DvxV/dabhb0M+LT"
Content-Disposition: inline
In-Reply-To: <CAMWQL2grduFNgGPLYryXOaXTzVvO6Y9s6o=2MMQ3h8Mj8z8P7w@mail.gmail.com>
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


--9DvxV/dabhb0M+LT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 03:56:45PM +0800, Yong-Xuan Wang wrote:

> Hi Tom,
>=20
> 0x80200000 comes from the result of the relocated_addr in booti_setup()
> on HiFive Unmatched board. If we load the Kernel Image to this address,
> it will not be moved. Currently one of the first two 8-byte of RISC-V
> Kernel Image is j _start_kernel instruction, so it's OK to execute the
> header of the Image.

Thanks for confirming.

Reviewed-by: Tom Rini <trini@konsulko.com>

As a follow-up, can you please work on migrating to plain text
environment?

>=20
> Regards,
> Yong-Xuan
>=20
>=20
> On Sat, Oct 28, 2023 at 12:43=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Oct 26, 2023 at 03:22:52AM +0000, Yong-Xuan Wang wrote:
> >
> > > U-boot initially loads the kernel image to the kernel_addr_r, and
> > > subsequently relocates it to memory address 0x80200000. Setting
> > > kernel_addr_r to 0x80200000 can eliminate one copy operation.
> > >
> > > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > > ---
> > >  include/configs/sifive-unmatched.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/configs/sifive-unmatched.h b/include/configs/sif=
ive-unmatched.h
> > > index 74150b7d4b..de8bfc1123 100644
> > > --- a/include/configs/sifive-unmatched.h
> > > +++ b/include/configs/sifive-unmatched.h
> > > @@ -36,7 +36,7 @@
> > >       "name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system}=
;"
> > >
> > >  #define CFG_EXTRA_ENV_SETTINGS \
> > > -     "kernel_addr_r=3D0x84000000\0" \
> > > +     "kernel_addr_r=3D0x80200000\0" \
> > >       "kernel_comp_addr_r=3D0x88000000\0" \
> > >       "kernel_comp_size=3D0x4000000\0" \
> > >       "fdt_addr_r=3D0x8c000000\0" \
> >
> > This is I believe subtly wrong. If you want an execute in place kernel
> > image (and are using FIT images), this can be made to work. But if you
> > load your (Linux Kernel) Image to this address, the header will be at
> > 0x80200000 and not the payload so you still end up moving it. Are you
> > sure this is (a) not still moving it and (b) it's OK to be executing the
> > header of the image like it's code (or is there some catch in the header
> > to lead to a jump over it, in that case) ?
> >
> > --
> > Tom

--=20
Tom

--9DvxV/dabhb0M+LT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVA6tsACgkQFHw5/5Y0
tyxXkwwAiHPwgcRW5Jymf6u7Be8/6MfffohFWY3oDvMvE/4orZ80AC7pHico3yqs
2g1oYxzt/69ebMbvaRf0drviaRo8Z+42pIbbRxwO4Rc+IRzYgdTh9jjlbj3SXFqO
NlfcSqprZ3tBhTUHis0JxdZ5lmwxMOm3tx9YQMup/0fHuBl25QH0EwH/GkSdhmKD
oDmoobP+diC0wIPmhxdwzd2BwgAYoxZu/DQ0Cl4Sc0FOd9CaLUs1yBJOA8Vr6YV4
YSrnrqDT1Dwgqu/2RkskRO+Ifk6PN/F6mpv8Gcao396e8ZEX9/1f/N+JsaxN4RIK
vf96+R0J+edgRWm/hKYR694nh9tnsIRt89YgkMWPX4GBeI6NOHq1YpwDQHSfqwEa
QCDQBzYPZkuPljYCta8ReFJE2GV/7PxEGBgojawcYAU/lf8qypFkIPY+i8DzLtnp
7xaXLbo4d35neq9x3iNA8/mNlbpaj645LhrISDZbPDIHqRsYutPVi1aKtmkyap4j
wX6lobTH
=V+Mx
-----END PGP SIGNATURE-----

--9DvxV/dabhb0M+LT--
