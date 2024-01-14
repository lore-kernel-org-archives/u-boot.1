Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFF4C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 14:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1096987067;
	Sun, 14 Jan 2024 15:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LqAG1rgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC8B86E05; Sun, 14 Jan 2024 15:37:23 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D4C87707
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 15:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7831362c9bcso653202385a.1
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705243039; x=1705847839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W9lZm0/YHkXHEUFhgKE4ZL2YBlZilt5GSgj/3TXc1gg=;
 b=LqAG1rgu8iAMfjeTVakO0qWWEqmihncPLNnZa7R75Dm6Qg/Ozv2fBls1rOoUSCc7vm
 KiOygNyumMwCr76r3nB4eGLW3INFhwwsAAgKGJrDFy3FBrs4+l/iCzbFHUCZjCCYcKmw
 SsE8wczidezchPR/kWmLLfs3LRv5gb7T+Qxos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705243039; x=1705847839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9lZm0/YHkXHEUFhgKE4ZL2YBlZilt5GSgj/3TXc1gg=;
 b=eNo0BHX8d3xrxqtQgRaqoBpY2Wu+9mPCdF2EfYBXCZqoC1aN65FqIVSGCr7pvXTvWJ
 RVGi9BrSEFu4TqekoH37RCiEV2I9e2EUrj/ksUzqs9/EldyYfQz2QrwNEGN+c12gWfi/
 kdg6glFBU+D2Xzazb2dJAuu7UVEKivZcWfyPAH9xEebOhm/EQUPGYK5jnsDMCysHTyWe
 wy0YH0FZvLDt77VTfKBVIcqeKXONlvrCu4uGiY4jCqsxvg4ZbQgNvzOIjTpcHqxwZt1o
 4ZuLafL+je0MoI2nTyR66e2Sbxd+hNk50G5nUR0om1mTIRWw1OKx6VNlUUJ1J7u38q8U
 hG7g==
X-Gm-Message-State: AOJu0Yy1WtFDQ3ufAhOTLd1kjf8ysFHk1YlpDN3fSteZG9l66AnWdRcM
 m9eUCXqmPOdZFwLlCPOYq2sZT52VolMFEA==
X-Google-Smtp-Source: AGHT+IFoOJ48GUUq6koVv5VJtrwLUhkRYLg6UL4oKVMCCnKJL+/9KniuKGOGV7Ah1VmfTPobT9iaGw==
X-Received: by 2002:a05:620a:94d:b0:783:35f0:ad93 with SMTP id
 w13-20020a05620a094d00b0078335f0ad93mr4570814qkw.108.1705243039344; 
 Sun, 14 Jan 2024 06:37:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 a1-20020a05620a124100b007831fbfc8d0sm2295775qkl.133.2024.01.14.06.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 06:37:18 -0800 (PST)
Date: Sun, 14 Jan 2024 09:37:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Dennis Gilmore <dgilmore@redhat.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Message-ID: <20240114143716.GJ1610741@bill-the-cat>
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
 <20240113-helios4-spi-v1-3-2a5663a10e6a@solid-run.com>
 <20240113172236.GI1610741@bill-the-cat>
 <a28684d7-46e7-46d8-9018-4857de07a3c2@solid-run.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U9gS7dRyRl4BeCsc"
Content-Disposition: inline
In-Reply-To: <a28684d7-46e7-46d8-9018-4857de07a3c2@solid-run.com>
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


--U9gS7dRyRl4BeCsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 09:47:31AM +0000, Josua Mayer wrote:
> Hi Tim,
>=20
> Am 13.01.24 um 18:22 schrieb Tom Rini:
> > On Sat, Jan 13, 2024 at 05:36:57PM +0100, Josua Mayer wrote:
> >
> >> Add a new defconfig based on existing helios4_config file to support
> >> booting from spi flash.
> >>
> >> Settings for environment location are based on vendor u-boot:
> >> https://github.com/kobol-io/u-boot/blob/helios4/include/configs/helios=
4.h#L59
> >>
> >> A separate defconfig is required because the options are not
> >> intuitive from menuconfig, numeric values in particular.
> >>
> >> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >> ---
> >>  configs/helios4_spi_defconfig | 81 ++++++++++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 81 insertions(+)
> > So, a super new thing that might be of interest, but please try this
> > since I'd like to prove/disprove the use-case.  This could instead be:
> > configs/helios4_spi_defconfig:
> > #include "configs/helios4_defconfig"
> > ... enable/disable options specific to the SPI boot use case ...
> I will try it, I like the idea conceptually.

OK.

> > And so now both boards will otherwise be kept in-sync for general config
> > changes.  It could further be done as:
> > configs/helios4_spi_defconfig:
> > #include "configs/helios4_defconfig"
> > #include "board/kobol/helios4/spiboot.config"
> Here is potential for making it infinitely complex.
> E.g. one might argue there should be an armada38x_spi.config

Yes, and it depends a little on the use cases of the hardware platforms
what makes the most sense. Today we have some Tegra platforms that
started out using config fragments, but thinking about it right now
should perhaps change to this style of defconfig. On the other hand, TI
is intentionally adding feature.config fragments as the "feature.config"
doesn't change between parts of the K3 family and should also be re-used
on custom designs to enable that feature. Things are new enough here
that I want people to experiment and see what works best for their use
cases rather than providing strict rules just yet.

--=20
Tom

--U9gS7dRyRl4BeCsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWj8ZkACgkQFHw5/5Y0
tyztpQwArKdYR6Vfoi4fin0TbfB/Pfdgs2ykH1LWcrX/9o1yDVmtcurmnl9yHPOR
BHamn0CCqbe8br57BDYva2sfrra1c2Cs2gdXitONI4fXI9U/OFghRVnCp9Kc5XNF
qsjPVEM3HoJyxk5Jm5OIT6Yg3mhEtwD04Csp2KRwwcDG+yjyliu6PB21fYrJH7T5
6pWZ8eaLx8p9dIDFMMGeIph9m5hhkbSPWcqWtkNexmoCq/UGtq0DACk8Hw7KH7ul
DXvusebX3QHXn+UAHnMS/CwQbGUzeuPwSp1M1uhpKTPp5zithBtsuP2jz50xXrRy
DssKkbTSPWpr4ziYl18Y6we0sT8h8jZYmfDhIGp7GdlWuvKzhOfRtUyKnLbt1FZs
BxeP854DcaWjd3pH4XsSO4CiZypXVUByv3y99g/PVrRu1r/420RdohJfwmr7IMuU
wcN6SfYmm2f6mcN41iuyobrLB0XaBjq+QavWGaxQ0GWBZIburPaWq2UDftj3iVIm
+O/vyuB0
=+WfR
-----END PGP SIGNATURE-----

--U9gS7dRyRl4BeCsc--
