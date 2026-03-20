Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1327F1098786
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805B183F00;
	Fri, 20 Mar 2026 15:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fq8/ARDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2177083F00; Fri, 20 Mar 2026 15:04:55 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4B683CF5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so255964eaf.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774015491; x=1774620291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+1B3/iK0/V71F+B3aCVZCtYVUQI/bhGZEIvYAMsPGIs=;
 b=fq8/ARDg4awKZQI7AAM6inXYOU1W9lWKe7MjUUrIXmMA2Pnj/jhAe98M2cc3KzWdHp
 V6rnsFkolh9wFot/6dKO+1u65BIQB4XT9PvABSFch+bm3gEsd1MRO1jJv5CC6uYAJ1q+
 LmHHlUbICVh5ZCcccH0Tb5FJ2Z3zioIbnCOdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774015491; x=1774620291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1B3/iK0/V71F+B3aCVZCtYVUQI/bhGZEIvYAMsPGIs=;
 b=mkW5l+gcH/gCBypXdAXkkORT3cDSBoyeBZMYwAQT9T+goEr1JH9GQw1kk3lZ15bghu
 jDor+6lij6TFq4L9EkuKRnLHVXsg8P4LiIPD2HlqqPHOMUg1UeV1DNa02PMY7VaYJcsw
 WuDcIbJhQu9U5m6zbw99JS/qA723fIaW07RaVmudaUep5ugjdYLdVDQIkCb5mTzg74Xt
 KoeKi9yQJffAdKGdeyUNstLzJQI4KUJ9v2sJRtsvtni0KFKHkxyq0Wz30/ZWXn4CBZW7
 RTKffkB+EAbxz0NxC/xIWU8E2jxOSl97t1Xn1KRmX3DXEjWuuLcC/z5a/EtOLfDpuGly
 z24w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlpmIAHaASU37I1ckMyu+tMitvafdjesnI5f+7ZJldUUDLoi2WhC9IZtvNetTQ4g8z4dBjAH0=@lists.denx.de
X-Gm-Message-State: AOJu0YzHQJEJuA9HRWeShrQJbIg1DE4MYPtT2ihheW2yREajQ68gKHlm
 mJTDcjMOy76XuN6p2IC+iVvSrffLg1E5FhhdrmHd/YjBuLQw4OhL3FrmOSgSP9h2fbA=
X-Gm-Gg: ATEYQzxxSMKI+WhLXERkSd0eWYrP3y3ffoECFoOpySV8K6Sjntt6vCiUtVlm0+RHGcC
 l9ZIJzr6186YlP2AVKuYzKK1hGqHxGDwG2QV9UBTDI/UZW2RBODpjsMtCgfSivjHlnida6IHwQr
 /hUyQ41lTIX+z/AIr9VJk1dJ2k6CqiyRVGObmsZJWta7UfwOk8z4gnYIXILrTWFOwz0KO1loGqB
 TItLgnGtpB5nemlnYakg0sedyG5kXIdIpDqX/OiFC3Av0AC8wLA8DYyJwfIVDKHCl9nw5TFLLtg
 bsN5alvi/9XJhzL/xFVNqRX0zPFgy17xpHLVx3Tg6UfQ2hlSraKp/TXDwUIcUngVC0aZabRDS3T
 GZnkfHoGX0jOEjzCs1v5bKRGdz/F0pKzL5NYkIbROX2qM2XBFFP3pN/esPyyQV6V2ROf/p75vY2
 YOg7VfAGBMaaUVC6bAhePBVzBuwlGqMrSe9m2yib2U+f0orWDxz2iF6/Cxp67je2CMBsOXRSGcY
 YFijZCZKavhGcBTXMzpXH0CVGW63rX9F8teNWEfjXjo/eMM
X-Received: by 2002:a05:6820:61f:b0:67c:1c3a:2bbc with SMTP id
 006d021491bc7-67c22fae779mr2301790eaf.60.1774015491290; 
 Fri, 20 Mar 2026 07:04:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252fe793sm1282527eaf.8.2026.03.20.07.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:04:50 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:04:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 dlechner@baylibre.com
Subject: Re: [PATCH] scripts: merge_config.sh: support include directives in
 fragments
Message-ID: <20260320140448.GZ502704@bill-the-cat>
References: <20260319-merge_configs-support-include-directive-v1-1-dcfb1c7f934c@baylibre.com>
 <20260319162134.GV502704@bill-the-cat>
 <CAFLszTixyb6AvgZ2NHMKzadHHDt2S1XPxEGvaz4zCoijuaFzJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tZSiSxeoipl7Oc3J"
Content-Disposition: inline
In-Reply-To: <CAFLszTixyb6AvgZ2NHMKzadHHDt2S1XPxEGvaz4zCoijuaFzJQ@mail.gmail.com>
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


--tZSiSxeoipl7Oc3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 04:09:42PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 19 Mar 2026 at 10:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 19, 2026 at 05:14:05PM +0100, Julien Stephan wrote:
> >
> > > Many defconfig files rely on include directives to factor out common
> > > configuration. When running "make some_board_defconfig", these files =
are
> > > preprocessed and the includes are resolved automatically. However,
> > > merge_config.sh script currently does not handle include directives in
> > > configuration fragments.
> > >
> > > Add a preprocessing step to resolve include directives in all fragmen=
ts
> > > before merging them.
> > >
> > > By default, the include search path consists of:
> > >   - the current working directory
> > >   - the fragment's directory
> > >   - the default U-Boot configs/ directory
> > >
> > > This ensures that existing defconfig files work out of the box. Addit=
ional
> > > include directories can be specified using the -I option:
> > >
> > >   ./scripts/kconfig/merge_config.sh -I <additional include dir>  conf=
igs/some_board_defconfig frag1.cfg frag2.cfg
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  scripts/kconfig/merge_config.sh | 56 +++++++++++++++++++++++++++++++=
++++++----
> > >  1 file changed, 51 insertions(+), 5 deletions(-)
> >
> > This forks us from the upstream version of the script, and I don't think
> > upstream will want this.
> >
> > When I make use of this locally I do a two step:
> > - make foo_defconfig savedefconfig
> > - merge_config.sh defconfig frag1 ... fragN
> >
> > So, I am hesistant to start with to change this tool more.
>=20
> Related, there are quite a few buildman updates which could be useful
> here. If you are interested I could send part of the series which
> handles fragments. I believe you don't want the 'extended board'
> feature (intended for CI testing) so I could leave out those four
> patches.

buildman changes are something to bring up on their own, and on their
own merit, thanks.

--=20
Tom

--tZSiSxeoipl7Oc3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab1T/wAKCRAr4qD1Cr/k
Cl/0AQDa9EZyi8MG9m9LtbSHUA5ZuINlmx6WL78A/jKfbxy55gD/SmyA/TF+qC7B
aLORHf3Mr2ImKp++ptx4AqHt+YDuIgs=
=9WtJ
-----END PGP SIGNATURE-----

--tZSiSxeoipl7Oc3J--
