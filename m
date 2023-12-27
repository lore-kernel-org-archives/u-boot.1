Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E521C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 20:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC228775F;
	Wed, 27 Dec 2023 21:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O+hCxhRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29838775F; Wed, 27 Dec 2023 21:06:30 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D3187740
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 21:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbd73ac40ecso3914758276.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703707586; x=1704312386; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2jZuo6kK3J43B0tlEHjY7lX9vOV7fnelDGfbw23fssw=;
 b=O+hCxhRtBwmJ4gr6bXNTh5ShnJX5TsBgXlfnR7eyIFAXSxxgdODKewoXpMkpot4XGj
 rZ5AIyZwxhipsdUv5kpc86euVJbwhNe5ma8g8Mb7pX1KqatfK5h7wADDUrXJ1iLSv/+r
 lwFP2LHmIabxpDXgS3e9T6VcBk/ue3UsGe2+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703707586; x=1704312386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jZuo6kK3J43B0tlEHjY7lX9vOV7fnelDGfbw23fssw=;
 b=kEf81M5PB+pNY/NNz8ti43y7PvhNf7aOXQLaznxZo5FKySOhEuXieQhNhaDiMANYN4
 1KnfQcfhaDfyGCDRW7+XTnVV3QyOp8Qfd0ej1vwQNJnWRcomLLEJxYXOT4PpSazDx+b0
 hYM35BULDpVlFrqOVPpe8X6NQXeWqR4ML6jX/LeKBHGcbKCCJhGiyf4DcOz7OHkpKVlw
 3Np9ZKWIDpocsnUc7+Iw0Pr/MUNGAd0W4xSoI2isEA5oQL2Ztn014pFxeb3vjwPhe6Sn
 rfQ7Jk1+ZFXIzGQxWLSTVhnzczJ64Mz3CR35qyy/FDL5F9SO6eIPZZc6vMDOzNbLI40j
 HfHw==
X-Gm-Message-State: AOJu0Yxze8AczBkQf9+pOdQum3ZOKLq3e6vFBLNk5rziemUcTnClZh4Z
 DL4QRFXWdxtQ3FmJqqwrSiQXS0SazRUqJw==
X-Google-Smtp-Source: AGHT+IGShM4zvpgztRolV8jGFMdGG1T8KpzmsNARR1byJdQcq412iSZQhuc6gtfS4x6iwn3OetGoJw==
X-Received: by 2002:a25:b20c:0:b0:dbd:9d84:5892 with SMTP id
 i12-20020a25b20c000000b00dbd9d845892mr4803473ybj.67.1703707586589; 
 Wed, 27 Dec 2023 12:06:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 t12-20020a25838c000000b00dbd15c3b753sm5446002ybk.46.2023.12.27.12.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 12:06:25 -0800 (PST)
Date: Wed, 27 Dec 2023 15:06:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231227200623.GU2652760@bill-the-cat>
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAFLszTjouSz2ExX7iWu8PjjWDF+F=bsuEX9hKCjuyUFbYXtvwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qYngqlwnigIRJY0a"
Content-Disposition: inline
In-Reply-To: <CAFLszTjouSz2ExX7iWu8PjjWDF+F=bsuEX9hKCjuyUFbYXtvwg@mail.gmail.com>
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


--qYngqlwnigIRJY0a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 05:48:42PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, Dec 26, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> >
> > > Standard passage provides for a bloblist to be passed from one firmwa=
re
> > > phase to the next. That can be used to pass the devicetree along as w=
ell.
> > > Add an option to support this.
> > >
> > > Tests for this will be added as part of the Universal Payload work.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > > The discussion on this was not resolved and is now important due to t=
he
> > > bloblist series from Raymond. So I am sending it again since I believe
> > > this is a better starting point than building on OF_BOARD
> >
> > I really don't like adding another option for "DT is given to us". Why
> > isn't adding another enum to fdt_source_t sufficient
>=20
> That is added by this patch, but...
>=20
> >, and if we have
> > bloblist enabled, that will look for and use if found?
>=20
> ...this is the question. I would like to be able to enable bloblist
> without *requiring* the DT to come from there, hence the separate
> Kconfig option.
>=20
> > Maybe some other
> > code needs to be restructured and cleaned up too?
>=20
> Possibly, but I really am not keen on this board-specific solution. I
> believe Ilias & I agreed that OF_BOARD should fade away, so I don't
> like adding another thing onto it.

I think you're missing something then. It should not be board specific
to just find the dtb via bloblist, without a new CONFIG. Whatever is
stopping that is what needs to be refactored and then you can just
extend fdt_source_t without a new CONFIG option.

--=20
Tom

--qYngqlwnigIRJY0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWMg7wACgkQFHw5/5Y0
tyxEaAv+KCpXrC/5EsFsUtMcmp5IIZ1Y+XRJCZf/xoxPAuu7d3461r++MSe39SAW
QEf8koJxEBvoQQoHyY/XL+Yk6pThCG7RpXzplOBf+Pw2F9bXSgqKmUIEhSoJnAEj
farR8gVNP/Ee45Q5i7JI9BOs09i2by2YF92l3uQBiTKkR9+dnPXOFIqGCwMMK1fe
1uB7vpO6W2EPRVUrJyGVlYNJxf9U6luEjj4Y3AWF1A+FZQlGMPBDbPbNWQXMH8MF
XRxtqUrOn5HG9VwhzHPlDzvbRGeiKovaeoz/8ByXidigh7ySIWRU3hwHRfX69GOw
z8YPz0FlGjLQ5p+a/0FKRXk5Wt46iqbyNAfP5eNvn0Jf/BBU/4PDZQH9c0/b7GgR
cNnqa8MLaIMkgcnbe0wYGSFEu5h9AU+031dqgCw3txT04oDnd95GQDJZfyrftJei
NLzYfevkLPtq92Zf6uTHYl+HIdGJcf85z251Zq4qOUWslxT6bqn/56dfRvP0oZ5Y
PtU3ErGu
=s05o
-----END PGP SIGNATURE-----

--qYngqlwnigIRJY0a--
