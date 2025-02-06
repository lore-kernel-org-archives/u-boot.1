Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452C3C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 16:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA1380840;
	Thu,  6 Feb 2025 17:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z30iu10G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C2B80AE1; Thu,  6 Feb 2025 17:23:56 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962678083C
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 17:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so8842555ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738859032; x=1739463832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lgwGcr0Nor1BwEJCjQEBWLTBgb3O6s6pxFqOgOi3mOQ=;
 b=Z30iu10GxaHwVl5pi/l3C6HMhJGA4e7o/SJYy/K+UWspjykIAZzEQC8FDj9Fcq5igZ
 IeUcpmIRHYwqCul7eCjTZCVS+B0kTziNBiPM0e4ZeVAYF0ICO1QXa6zZEhYE295BaeLe
 BR4bFgjWfHUpVpPBOyzgYlZ8FVaIJiLxKoKO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738859032; x=1739463832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgwGcr0Nor1BwEJCjQEBWLTBgb3O6s6pxFqOgOi3mOQ=;
 b=es8n+im2gLvuoxy/zxP/zz42S2SorM8J1RxB5KaKa4x2hMvza+G31STzcZ4jyv1RmU
 ID5lAJYkgEymF7kWTvx6Atb2qtVdkQ2bB1Ub6Qc7WW31rA4Yh5O8gXlT8YQr70y0uFRz
 biutDwoYigEdbC7XLFaLNDDhkkED87sipR8XrcaK9BJYotxq3r/9qcXZCteQUrL5ywKJ
 i+QkW2vQ+U3kTzFr4/7MV79IWRlHI3PBJn3wAYeN+vfUXiO8rEtoOSL6HP2PVKmWNRgX
 uaHte83iyc+8Ggw2sUSLrHhU0W5+v+PVzOJGOzOwfVy+r/atjtWGLa7FlrJpcqairB1K
 5XXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpPDzol3YC5oEqVyPs3AuGAQBuYfyPN415vuB70B7bDw91D3X9syvOVOQUSYOnEh/X4RVb5Hs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywvv+JKbpzfwYRzi1PEDNifwLp+o/v+dwu6Rk2WihjENjVOgjNk
 WP2LvrQKJk8cIMO1jmZEf9YtA7HGofPB8MKgfgaNSn9S0k+SYo4XT6UgzwTuYzw=
X-Gm-Gg: ASbGncufenyodplfbQVNTSooCLeLc3jyysX0zhwp/pufndErtJsuuYDsUBXGCfpJrQg
 +Hi89jGgx05UohvWar399Jb3ZCy51xOBbJd10hRWXr60QkRuavj1xk5qToqz1zcKfEq/vdi90Bm
 jOugMItFMvQj+mR9Ucl1gdcCgJRaJvTULacorjccSScHgggQLnVxL0n1XSzjtwIeb7RrWRWnMNa
 B2xEz7DUIIdoJ/Jln6MiYy6NrdQVjrtT7/ox0w0qoMuvBfD3qziGXz6RIlMj6iCKHWsWxwHE2vY
 7hBfwwcEfC22YgI=
X-Google-Smtp-Source: AGHT+IERiJ5OKFaquqoIqEO8TJFgUJirjnddll1dkfVSTjVi9I763+mlgMVKsWQpyCRNw17oV5KQTg==
X-Received: by 2002:a05:6a00:1411:b0:72a:bc54:be9e with SMTP id
 d2e1a72fcca58-730351ec0c5mr10695649b3a.15.1738859031745; 
 Thu, 06 Feb 2025 08:23:51 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ad27fesm1494282b3a.37.2025.02.06.08.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 08:23:51 -0800 (PST)
Date: Thu, 6 Feb 2025 10:23:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
Message-ID: <20250206162347.GD1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gKbn8BwZTxOvFXDL"
Content-Disposition: inline
In-Reply-To: <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
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


--gKbn8BwZTxOvFXDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 08:41:09AM -0700, Simon Glass wrote:
> Hi Raymond,
>=20
> On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > +CC Ilias,
> >
> > Hi Simon,
> >
> > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The logic of this has become too confusing.
> > >
> > > The primary issue with the patch is that U-Boot needs to set up a
> > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > phases can then use that bloblist.
> > >
> > > But the first phase of U-Boot cannot assume that one exists.
> > >
> > > Reverting this commit seems like a better starting point for getting
> > > things working for all use-cases.
> > >
> > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > >
> > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFryq1Gn=
7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> >
> > If my understanding is correct, you want to add some logic to control
> > when the U-Boot should or should not get the bloblist from the
> > existing register argument.
> > But xferlist_from_boot_arg() should be called when a valid register
> > argument is there, I didn't see this in your patch.
> > Maybe you plan to do this with other patch series, but simply
> > reverting this results in a breaking of handoff policy and the
> > firmware handoff won't work.
>=20
> Yes, I certainly did not want to revert it, but the current code is
> too hard to understand and I did not look at it at the time it went
> in. I've had three tries at working with what you have here, but each
> turns to spaghetti.
>=20
> I would like to build on this and get something running in CI which
> uses standard passage. As Tom suggests, perhaps we should disconnect
> bloblist and standard passage?
>=20
> On the CI point, is there a board we could add that uses the
> xferlist_from_boot_arg() call?

Yes: https://patchwork.ozlabs.org/project/uboot/list/?series=3D442824

--=20
Tom

--gKbn8BwZTxOvFXDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmek4ggACgkQFHw5/5Y0
tyx97wv/S7KU0IRYnaP/RzGGQ74zxCQsVb6Mc/Thp7xX5GH/WofoHIzIpxl9fOVc
Ykromel0DzXsFdyXuqg4wNEdg5qEf9rUfu3Clz4SWakATjoniqfXXxqdfSpP/tHD
FCRiXFkgLYMcbl9fhTy22T5cjreFowkae2+Gv1mmDAMrWWu+jEXI47nDNtmLuE1V
tcgkojYa4FgJJ0XKacY8rFVTFGyIX29XPksaV0g7BuehUek8JOgaGdPGTRCO2aKd
n1dHz6OVwfJRnP18yJ/WjJsGrnDM60LIEqI+jDX0q0lSZM06t+sU811LjLYh2FJf
dWolxB8qJe1VST+Cu6d4h3J8G9QNXO77PEPSnhjhXmn4V8yx5R7lz3FT4lyBGE1V
kfzvd41TWUsSCDhskjjL/D9XY/S4RrRAENw5lYm+EgojEKJEfoz+ZL4Z50nyNdM5
5SSXCHKXwGsTW2I4S0xV8ookFcqdVA9/xjw1VFdB7Pn0ggBdxyQFYbv5OfM/x1tN
U6TGqh5y
=sZNa
-----END PGP SIGNATURE-----

--gKbn8BwZTxOvFXDL--
