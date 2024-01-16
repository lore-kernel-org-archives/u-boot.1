Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88999C47DA2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 14:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CA38796E;
	Tue, 16 Jan 2024 15:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/ccRm/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE45879A0; Tue, 16 Jan 2024 15:56:53 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B9B287078
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 15:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5f254d1a6daso101409837b3.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705417010; x=1706021810; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Darfz4+Jcs8VyaDI5+CjGiDknbuqJMXNjXoPy84sK0=;
 b=X/ccRm/FKQxcQsqO9OFPi063AJINIayS7D+ra8wppQ0x1rGiEUC7Q7qWNclLowJRQu
 8TezYN2oV6Sx4y3zShn1YezVpeSY0Hg3N3Ave+j9shJIkIT2Vwekwjyx3NgVOtc+yJ5q
 Qo7hPhb7GWjMhk3ZxZFDH01r01hCv3PKqZew4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417010; x=1706021810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Darfz4+Jcs8VyaDI5+CjGiDknbuqJMXNjXoPy84sK0=;
 b=GXxMMK+ncEhq8Oz2Iry6DPUeMJ2p/OKluuPwQ7oSEykzuNCpa4BAJJK7kzozXIMiZX
 jbdrc4autj69ZPxvP/ungDgwbF175VHBmiBL42mOH+TQucICtXvOOHNv8eWMw3KKKZXF
 sLMeXfYmWpVuxcRgAcprL214kYlptNEJyY4nlXuwSL3tZQpWaZADmhqh0VfbIAHz1f2K
 20Ed9aCw12TlUE6YDQzOTMw0XXdADgl1rKZUFptOdS51CnXvg0VOt73OrLf4umWE171x
 HPPGtfXgCTaAEK42eMnyCDsjQa6DPJwltDUH+Y45b3YrSW3Ozi9K1dKkICMuoEq9NWXp
 N8wg==
X-Gm-Message-State: AOJu0YytMgLG4AccdOfJLwHu5PHCB1HDN5a3uH759T7oes9UJfm6yXfm
 BatsJijaJjrAbjlgzjwFyP73CioY/1HPKw==
X-Google-Smtp-Source: AGHT+IHL7nZ3DrINE6UWEQ9Pjtcn1g1Fm5zuVFvfHKHuRd+MxXxeP0FwS1v7zBLCceJpg4YZQSSyLw==
X-Received: by 2002:a25:1f42:0:b0:dbf:6c75:b5a9 with SMTP id
 f63-20020a251f42000000b00dbf6c75b5a9mr2423511ybf.86.1705417010034; 
 Tue, 16 Jan 2024 06:56:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 d1-20020a25eb01000000b00dbf23ca7d82sm4279728ybs.63.2024.01.16.06.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 06:56:49 -0800 (PST)
Date: Tue, 16 Jan 2024 09:56:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v5 8/8] fdt: get FDT from bloblist
Message-ID: <20240116145647.GC12635@bill-the-cat>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
 <20240112213337.185460-9-raymond.mao@linaro.org>
 <20240113152732.GH1610741@bill-the-cat>
 <CAEfUkU+fDjfJ02Pjyeock=MhV-SUU0raw8uSvfAi6mwxq_R=xA@mail.gmail.com>
 <CAEfUkU+xJ+Zwyer-2fo=EtfcELYw4Gw0QNM9pd1PuNYk-RXf3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b9US/ieZ3d1ROTvt"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+xJ+Zwyer-2fo=EtfcELYw4Gw0QNM9pd1PuNYk-RXf3g@mail.gmail.com>
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


--b9US/ieZ3d1ROTvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 12:08:26PM -0500, Raymond Mao wrote:
> Hi Tom,
>=20
> On Mon, 15 Jan 2024 at 09:57, Raymond Mao <raymond.mao@linaro.org> wrote:
>=20
> > Hi Tom,
> >
> > On Sat, 13 Jan 2024 at 10:27, Tom Rini <trini@konsulko.com> wrote:
> >
> >> On Fri, Jan 12, 2024 at 01:33:34PM -0800, Raymond Mao wrote:
> >>
> >> > Get device tree from a bloblist if it exists.
> >> > If not, fallback to traditional way.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >> > Changes in v2
> >> > - Refactor of board_fdt_blob_setup().
> >> > Changes in v4
> >> > - Move the logics from board custom function to fdt library.
> >> > Changes in V5
> >> > - Rebase the changes on top of master.
> >> >
> >> >  lib/fdtdec.c | 18 +++++++++---------
> >> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >>
> >> Why was this just not dropped after:
> >> commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
> >>
> > In commit 70fe23859437ffe4efe0793423937d8b78ebf9d6, the FDT from blobli=
st
> > is always overridden when OF_BOARD is enabled (OF_BOARD is enabled when
> > OF_HAS_PRIOR_STAGE is on). I think this is not what we want.
> > The FDT from the bloblist passed from the previous stage should be the
> > default setting.
> >
> > If we want to build with OF_HAS_PRIOR_STAGE=3Dy and without OF_BOARD to
> avoid the
> FDT from bloblist not being overridden,
> `imply OF_HAS_PRIOR_STAGE` needs to be dropped from Kconfig for ARCH_QEMU,
> otherwise check-of.sh will always complain.
> Do you mind me adding a patch to arch/arm/Kconfig? And then we can drop
> [PATCH v5 8/8].

Platforms that are able to migrate towards using bloblist should disable
OF_BOARD/OF_HAS_PRIOR_STAGE/etc and just use the bloblist, yes.

--=20
Tom

--b9US/ieZ3d1ROTvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWmmS8ACgkQFHw5/5Y0
tywN5AwAuphRYfI2fceIpJRVBe6g4MfF04P1w6s8lz82FjFMmBPxEJElQAux9tDR
Y+K1IKdU8UXe6XvrD82S3fYDIR/df/s6gW0JSVAL14wv5RgsF5JANUtbsdaxfewJ
8sndPtRGn30ioyvkQQelsIyxTpMqTaFeUufxF4mexj32rwx6fTKYiHdg++Gx4epl
dyo7v14yhWWhHPME2//LTKURUVLO4BInGoe80kfuBYWhy3ex1PCpisEliCmY5rjO
PKYxDN/VIEh/idcS5qyOZ/glgx+mMglYnBPaKXnfeSArnjPzCOLXrev3xkcgcZNy
fk5YF8gpQkeg2hYnQZpDTd/SdLnK3i/URaC0RzG8GwXji7JBic2SLNlvh49xh1CD
KOKURQ9v5+olFWcbTvE2xp2hEdCLPbVYgZhWU1Q33yRWtY3gcu2w8c8pfQRAqh41
ct/7wuQI8Fe1TD4ohtrEYcdCUHHumY4g+4tbLGDE3pzDc59xkZlSGr2uA7nARVXF
7K4y/Qf4
=drOm
-----END PGP SIGNATURE-----

--b9US/ieZ3d1ROTvt--
