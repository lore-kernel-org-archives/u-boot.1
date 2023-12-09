Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BECFC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05DB8755D;
	Sat,  9 Dec 2023 21:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PbbzAwlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C56687645; Sat,  9 Dec 2023 21:56:33 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB96487517
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d400779f16so23794107b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702155389; x=1702760189; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cGmDlRBulH5jh7+Atmj6u9k+LCzkS4OHcL7vkk9/9DU=;
 b=PbbzAwlJPOAAHo10LIbnbZ3KSyGEbXSP+F+iZM/2jAGWb8xxIuXLJ5nqPzTljQzM5f
 D+6whEE2qjHGrZEQBIPYyU7z3SfRvJEE1rqdc59tXCffEdv8s8KPbu1RHdTq5ZLOnVh9
 3bDa9oH5TTqQfNqFaJZKy67HIIqbCEtNbNvEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702155389; x=1702760189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGmDlRBulH5jh7+Atmj6u9k+LCzkS4OHcL7vkk9/9DU=;
 b=j0zIB/X0GDG/RBlCjxuevo6iDBSDgniupX5Mb1Cj+BrRS7vN9LDK+/xDn6Hm3hD+2H
 RwVn63XSMQ1kNKMUcD4iYH5Y5ECeFiEUF7vUJHmnE8utiKyGaj4S+7LBHvMpfBDe36OD
 7QdbVFUDEVDC9Dr8eavwj6JKzCcp03oZ0iHy28XBih4ohW2apini0xTpHZYmHC+fj3bQ
 A/2V1NZEYI41yGGc0N+z5w2JSV+281n5XeCCxXfA4xrc5NI9iTrMcM4XVBnxiyTyq/I1
 YxwcgdQCuKbaDf70iseS6Jd7ILNQqJ0bq/TIOsAdtwC6OnqFCcx4kLla0F/RwkeeXIp4
 CV5w==
X-Gm-Message-State: AOJu0Yy29XB9UyiZhS576cIhNjjcMHtsr/cyNBT8qnF1xngSt9BG4/8w
 aDjyXje+eKj2pUgtIRcvAOLj8eFMA7TOiICvi/kHEQ==
X-Google-Smtp-Source: AGHT+IH8drKtZgs1zHLE75IhU0a16zN25TOhVymse6fUCStFtDe/4aTYxCX4xu02fIqQAxN/1qjRYQ==
X-Received: by 2002:a81:9284:0:b0:5d9:3d8e:59e7 with SMTP id
 j126-20020a819284000000b005d93d8e59e7mr1718914ywg.45.1702155389568; 
 Sat, 09 Dec 2023 12:56:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a0dff05000000b005d38b70b3easm1744285ywf.19.2023.12.09.12.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:56:29 -0800 (PST)
Date: Sat, 9 Dec 2023 15:56:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Message-ID: <20231209205627.GI2513409@bill-the-cat>
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2JFhyYQgbmjWw553"
Content-Disposition: inline
In-Reply-To: <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
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


--2JFhyYQgbmjWw553
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 01:59:26PM +0000, Shantur Rathore wrote:
> Hi Peter,
>=20
> On Fri, Dec 8, 2023 at 12:59=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Shantur Rathore <i@shantur.com>=
 wrote:
> > >
> > > Hi Jagan,
> > >
> > > On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@amarulasolu=
tions.com> wrote:
> > > >
> > > > On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@shantur=
=2Ecom> wrote:
> > > > >
> > > > > Rockchip SoCs can support wide range of bootflows.
> > > > > Without full bootflow commands, it can be difficult to
> > > > > figure out issues if any, hence enable by default.
> > > > >
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  arch/arm/Kconfig | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > index d812685c98..fca6ef6d7e 100644
> > > > > --- a/arch/arm/Kconfig
> > > > > +++ b/arch/arm/Kconfig
> > > > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > > > >         imply CMD_DM
> > > > >         imply DEBUG_UART_BOARD_INIT
> > > > >         imply BOOTSTD_DEFAULTS
> > > > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > > >
> > > > Yes, but better to give this option to specific board vendors as
> > > > defaults are enough to boot 1st bootflow and what ever media's it h=
as.
> > > >
> > >
> > > Yes, that's correct it is enough to boot but by default there is no o=
ption
> > > to choose what to boot from.
> > > This was discussed in an earlier version of this patch [0] where I was
> > > explicitly enabling only for RP64.
> >
> > What actual extra functionality does this provide, what is the impact
> > on the size of images? You've not provided reasonable justification
> > outside of very vague statements, it would be useful to know what the
> > added options actually solves.
>=20
> BOOTSTD_FULL enables all the options in bootflow commands. This is needed=
 if
> - you want to choose between multiple available bootflows rather than
> just boot one default.
> - if you need to list the available bootflows that bootstd has found
> - if you need to select and boot any bootflow other than default.
> By default all other commands in U-boot come with options to show details
> For example, nvme info, nvme detail, usb info, usb tree but with
> bootstd no way to know anything.
>=20
> Image size - u-boot.itd without BOOTSTD_FULL - 1193984 bytes
> Image size - u-boot.itb with BOOTSTD_FULL - 1214976 bytes
> Difference - 20992 bytes
>=20
> According to binman for RK3399 u-boot can take upto 4M [1] so we have
> ample space.
>=20
> This was discussed in the previous patch in the link below [0]
>=20
> [0] - https://patchwork.ozlabs.org/project/uboot/patch/20231111001329.537=
704-1-i@shantur.com/
> [1] - https://github.com/shantur/u-boot/blob/master/arch/arm/dts/rk3399-u=
-boot.dtsi#L68

If I'm recalling everything right, this also brings "bootflow" as a
command more in line with what could be done with distro_bootcmd in
terms of "cover every possible case and let the user override things"

--=20
Tom

--2JFhyYQgbmjWw553
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV01HQACgkQFHw5/5Y0
tyxj9gwAnVMlNwRwIcli0sy5/YB/A/ISjswA16disGwG/8+93KfDwY1GGjMgz+Oq
my35rERwcOar7mIJPYrdap7K81u+lukt67G+lvKAIJqcVyir4PD6GUpW5i+bv9qH
APejOyr/poqEGoC3zzsxd5l2gG27qQEIciqOZoa0vA9P8jLOU0tn7VbLgNFsXaqI
7FcUek5bSp/Y6Tmn2pORUhJsEWgvOlkOTCfFBRriz3WhLLHwXRjkQcfjT3uEvCve
XB8Yupy5RIaA4IoI5/pu1iYWDFu0TxrK180M6MrkYPc6wJv3GjJ0GXDbU6GLGdUK
9oEXdT1w+GMu+WpoebPTO92uGXaY7dygc9TxkpAeU3uLHoxSNSOZEq+bH4/wZ2GN
SEkFp15JL43cTkvTSHv2KTAQ7XeubJON+uKFYQA3/uFcenFPid98iiNdOuQJlAbj
Y4JcWDsgdi8NIP34SbaexPZMRvPZ6MN5r5xqVNyI/3vqThFRtTCb33a248/s7cPK
6TRi+ANF
=SR4k
-----END PGP SIGNATURE-----

--2JFhyYQgbmjWw553--
