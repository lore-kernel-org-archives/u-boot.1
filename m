Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AFFC10F05
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3C3876E9;
	Mon, 11 Dec 2023 19:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t/vQRfAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5E98779C; Mon, 11 Dec 2023 19:27:16 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1FA87635
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-db99bad7745so4360162276.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702319233; x=1702924033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UEubL1JE/3kxL0SPsmfyQl3MhvC+XFaiaFceZsg2Og0=;
 b=t/vQRfAGNa5Nji5Ko0EwzX/A4qh+IAnYhdAexBBgPvFnFMVEqtK0ixz/WFRJTO2Is3
 6ISBJYMvA4GRX3AdMklZ0EXB/meD79+cM5aA59yolsBi0laS0ZJd9r7YmDKr4w1EzPOM
 /fzLZ2qQOi4PrvoGbCQSlCU5hwZLWLhMA9ZuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702319233; x=1702924033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEubL1JE/3kxL0SPsmfyQl3MhvC+XFaiaFceZsg2Og0=;
 b=VV2/wAgasyGguNII9eHNhWLM1Qx5e90sSWg11IAQPu5y7N03OLDYO38HzKaV1DHKrd
 yRqASLqJXlMjs7+1XdXgqdVbQqb217ll9+ZtjsW3qd+u+wrTy810In00EVKacKF4AMqA
 6pl7NeOQaYsaIvAe8fZaKTj5QOnf98iMmLMd0y0FBVwbbsr3oSqm11jwZ/nH9Vzv0hrd
 0lMA3lu876d3ExA465EXKRCIZHJPu7QsxH1f1C8O8vwGSqrEI13YUqCC8Qetmnk+Lwc9
 +Lsf1uL+2OWFhZGhXdA0G8olTCUQOFuFSdNocSUnx/a0ujHzVOl8MUXPDfpw94jy0Of0
 zQUw==
X-Gm-Message-State: AOJu0YwVGslONmy1G3SWwy1/0xW8WA41kyWgMM84JWY7zjZlZvnTCQRW
 3U5NvoB+0F/S6fUIhEV3+Kg0uA==
X-Google-Smtp-Source: AGHT+IHLKkTe8+el3Q4C/JRuVWkMyxtmWRKSXz9rAsytA/x4Wd0H9yjbB40N1lq1US+7BDWyvjq3VQ==
X-Received: by 2002:a25:ab11:0:b0:db7:dacf:2f1a with SMTP id
 u17-20020a25ab11000000b00db7dacf2f1amr3598338ybi.97.1702319233295; 
 Mon, 11 Dec 2023 10:27:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fa42-ae3b-3aac-d543.res6.spectrum.com.
 [2603:6081:7b00:6400:fa42:ae3b:3aac:d543])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5b05c3000000b00d72176bdc5csm2641184ybp.40.2023.12.11.10.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:27:12 -0800 (PST)
Date: Mon, 11 Dec 2023 13:27:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Message-ID: <20231211182710.GT2513409@bill-the-cat>
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
 <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
 <20231211181918.GS2513409@bill-the-cat>
 <CAPnjgZ3+yJCNgO635gSsDbrb-BpQvJTOqo4qHoWxunvbHZ8jyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0VGJPCUCdzrxTivf"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3+yJCNgO635gSsDbrb-BpQvJTOqo4qHoWxunvbHZ8jyQ@mail.gmail.com>
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


--0VGJPCUCdzrxTivf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:22:45AM -0700, Simon Glass wrote:
> Hi Tom,
[snip]
> > I think in hind-sight too much stuff is omitted without BOOTSTD_FULL.
> > The option itself then enables other stuff too by default, but some
> > parts of the bootflow command itself should be visible even without FULL
> > to make things easier on the user.
>=20
> At the time the goal was to avoid growth compared to the distro
> scripts. We could perhaps add some more things in with BOOTSTD_FULL
> but still have it as an option?

Right. But now that we've tried this, some of the feedback has been that
it's just too minimal right now. Like looking at the help message for
bootflow, list and info should probably always be available. And maybe
the flags for "scan" should be re-thought? Too late to change things now
but "bootflow scan -b" should maybe how it's always been for "scan and
boot".

--=20
Tom

--0VGJPCUCdzrxTivf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV3VH4ACgkQFHw5/5Y0
tyxobQv8Djg1D/vJx3+K8KH7kNjqRkmH2pkn3DBW3j5W6w5qah4y6/F/9h+CBpbJ
Et71z55b0GGzkqffw99R17NO6xxZT76r9lrKh31jdnGu/QEH+cTqQFPIUxbJVN2D
dnqEBYKKzfCTypE9kZMmW/Ux3eZD8AHg8OalA0RrEptbWdd/tNxORdB9ci5Gg163
6vsuDLSubvN2U/OovjK5AR0Mcf8wybU4pmz26RczYk+7aPzjLfxYDitnCwnMwa30
5a0jBBuDd/K4FRvCTlW9q3HymlM2ItVo5DQZDnxby0ngnZ1hu7BRmfWJL6qgnsig
wKSOqWFGmyp0rkbbeG80fwIDPJxCUfanRZ/e+mmwHI49qV0UQR9LRgGzxoKbBJLf
1RV8PtEvbVyJUcE6YFBs5Ys95aYCeZ4ehpJoBGsnxGKNEiG/l3KcHaIvzLQO3Gau
V65cslH6wdXvFDlDmi6nRUEixL2hupFYwX6ccYyL584O7QgCO48MJadhsnSRUtJk
99f9ClsO
=OaMV
-----END PGP SIGNATURE-----

--0VGJPCUCdzrxTivf--
