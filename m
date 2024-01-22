Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C466C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 16:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3454387A01;
	Mon, 22 Jan 2024 17:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LynEXh58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E5D8799A; Mon, 22 Jan 2024 17:50:06 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F0487872
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 17:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dc227feab99so3130045276.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705942202; x=1706547002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cTmln5YFkUcqsu7sdiN5m4jKouMH8CU6zI1qoD/6Fc8=;
 b=LynEXh58RgALkyTcik9WNx4ejPQbRFOw+W3xGopULTcQqc4cgYU09bOAdzvot33kX+
 xoRoxkYl+BQAYlP9Faf5bdswQOnqAcJfjHoIaPNIQ2mprI4cCW3u7TU3BF4yzJhn1EkD
 lliMU67GXNZdq+gvN4ck9EKd05j2px0c+GMa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705942202; x=1706547002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTmln5YFkUcqsu7sdiN5m4jKouMH8CU6zI1qoD/6Fc8=;
 b=SM62/NB/Rtv4c5jTHm7q9mdGrkZoUKjpFMaNgEw9w+HqG0FlOrZEDFkSQklIgV3TqN
 N9h0Nw/zIlioUvvCd7PMmB6HcnvmFgXoYroZ4Bc+ODuc1YWQhc8V74H9QtXQHC0gTIg9
 2G6G4jdtgZE8U2QoCP33Ruw8I1GPZ8JtkFu8/DrUKwQ+uCfxM9fRWTd6BcCelhCX3pW/
 ryxqooFnPRxMguE01h7hYk1O7R4GGYYn7Jj+p3kg8881MMsWugP1DPtsaPxON+5j+Szb
 aYY7yZxVevDTauI077s2rPbD8ZQsj35HwFRyPx7+xT4wixjSIHMWEYvP5pT8xzpd5IzL
 nX/w==
X-Gm-Message-State: AOJu0YwsBSGmhJwEJh1h2yJ5aOleRsltbwm9cFiitQzJfgtSCN2687iu
 srPbdYsdZIwyXNgLr4JJ+INe/KKicN3woH6ZKzIBoBbYjix2M+Y6EZpXwl6ZEUU=
X-Google-Smtp-Source: AGHT+IEF6+TcUvCsIXLu6L95Op24cEXI9JOg3sW33H61TqcL9UGXaY2mLFN0Y3x3VUPWM7yyHTHigQ==
X-Received: by 2002:a05:6902:107:b0:dc3:6a40:b6dc with SMTP id
 o7-20020a056902010700b00dc36a40b6dcmr591019ybh.113.1705942202672; 
 Mon, 22 Jan 2024 08:50:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d1-20020a25eb01000000b00dc36ad3af97sm174583ybs.50.2024.01.22.08.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:50:02 -0800 (PST)
Date: Mon, 22 Jan 2024 11:49:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240122164959.GN3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240122114515.760e9cd3@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/gu2cU7P5GliUFp5"
Content-Disposition: inline
In-Reply-To: <20240122114515.760e9cd3@donnerap.manchester.arm.com>
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


--/gu2cU7P5GliUFp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:45:15AM +0000, Andre Przywara wrote:
> On Wed, 10 Jan 2024 16:05:36 +0530
> Sumit Garg <sumit.garg@linaro.org> wrote:
>=20
> Hi,
>=20
> I certainly welcome this more automatic synchronisation of the DTs,
> however have one comment about the upcoming sync process:
>=20
> > ...
> > However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> > use devicetree-rebasing repo [3] which is a forked copy from Linux
> > kernel for DT source files as well as bindings. It is tagged at every
> > Linux kernel major release or intermideate release candidates. So here I
> > have tried to reuse that to bring DT bingings compliance as well as a
> > standard way to maintain a regular sync of DT source files with Linux
> > kernel.
> >=20
> > In order to maintain devicetree files sync, U-Boot will maintains a Git
> > subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
> > U-Boot will regularly sync `dts/upstream/` subtree whenever the next wi=
ndow
> > opens with the next available kernel major release.
>=20
> I hope this doesn't need to stay that restricted? Can we either sync more
> often, or at least on the kernel's -rc1, and not only on a "full" release?
>=20
> The reason I ask is that we have a chicken-egg problem here: without a DT
> merged into the kernel tree, no U-Boot board support can be merged. And
> without U-Boot support, we cannot boot a kernel, at least not in the
> canonical way.
>=20
> Since the U-Boot and kernel merge windows are not in phase, for sunxi I t=
ry
> to sync the kernel DTs either as early as possible (-rc1, sometimes even
> before, when the maintainers have merged them into their tree), or
> sometimes "out of season", if a board defconfig patch is coming up.
>=20
> Otherwise new board support, which typically has a very low regression ri=
sk
> for the rest of the code base, would need to be delayed until the next
> release. In the worst case the U-Boot merge windows opens one week before
> a kernel release, then new boards need to wait three months?

Would it be to bad to bring in board X with OF_UPSTREAM=3Dn for one U-Boot
release, and then with the next one switch to OF_UPSTREAM=3Dy (and delete
the dts from arch/) for the next release, when we would have gotten back
in sync?

--=20
Tom

--/gu2cU7P5GliUFp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWunLQACgkQFHw5/5Y0
tyxkFAwAmVK5A9Ioak+Y3y2oqk+t/z5JJRl4Z84ZR0kitSYj6iL938ayoYJGaFgM
3eZVsw2zj9vBt5Ye6rI3d4Hale9z6JHbJYxjKunKlkUZu9TNmyb7rJMqg62uOnDN
NqUU+fQqzNIZV28MGW9pvVhkkKSWWDPs+NYF66SlaXjXfup0Ro0OBe8NiX/1Qx0V
8IcyUCjQQKTW4S8uyvEG2D18gLY0j0pjyAjokRIr65mZfbKSMcyN/ENqb0xWsYBr
WHS1t5JmRJWSVGc+PiTzYnPjpoyMhtvozKgB+MB6mhKn2UJtJse+ZbuueOTQ1nn7
Tuqcd2FuQDxai1b5mfxfsoTnWHmBH/6Xg8pQijv+H5EZaGICp9AXV4lK5juj0LAE
OxszEP/cVKF7wCrdeAjoiK+6UeHqr2qCuRPWCwgc5EAB0MzaGGfVyOJ6LadiwoA6
45uQ10FdrYdRyQpLSZXXaLugOZ592OaUz7RIxvzaWKanWWre4lCHACdr0WHf1f+W
cLmVYIHv
=yqYj
-----END PGP SIGNATURE-----

--/gu2cU7P5GliUFp5--
