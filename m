Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A38DD18148
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF26C890E4;
	Mon, 14 Oct 2024 23:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fPnW088K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A468E8907F; Mon, 14 Oct 2024 23:05:31 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868DE89143
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbd1a4217dso50345166d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728939926; x=1729544726; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aHx5Qp46dMY6yIs7hbjLv+pFZv7NLN7J8KE4HZSWRg8=;
 b=fPnW088KSsENCyF1ACHbEctSeG+VAwv3o7r3Ul/KcE1HeS4vUd5RHIPJc53dvjPvJ8
 Smc2poDhVsG/Ol113A1A9qeNd9r4TcJmz8dBIvL+RNsKSeBbV8H0VnlK5RTcq22/WJ1M
 YNMe3DNsWhkziRmekcTQMB0IrJejeKJW025ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728939926; x=1729544726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHx5Qp46dMY6yIs7hbjLv+pFZv7NLN7J8KE4HZSWRg8=;
 b=jOnPsOgRENP9yj3wkXh5ULc059Kti1OeGlk6nlADytTqQO1HeD543cmRov6piPbF/D
 UjzuCtVjlta7pZ75eP7ErKDyi12JeWq3GbKXTYHhg7Kbkl3b6lCswXKIpQZfE/6Mv4cF
 neVeQsNWdD2mczmppC+BiOkuy7AtG6R71xM8AlyT6AqlW89DzdyVnbcMOAOEbcX39So3
 NtrZ9sqviWuW33Jqn2RbZJxdK01mlIM2yNTpGtEP3e6VPbUS0afCtnYG60a/OMAv/cvh
 cwqLEC7PFsAnWzITNOI/TLHc7fnPhsUBhBBYwZyf7v5Ui6zENJpN2YP+GODL+3xJox1f
 Fpjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsRNVd1mcDvqRtfIAaEEIPW1e20AmjOEojGafVrkC7b87Ln4izicAHyRmAvCVFAq37KozXGtE=@lists.denx.de
X-Gm-Message-State: AOJu0YxEzKRUdyLXjeYUO3yNa0rDdTiS4Aqxyjmp61syrUamEkyuJ3gL
 tiQ+nuVIzxwrbm9L7kT7PCi7f/mNr+Xo9H/67jTghVelT8mHiE0XavI218i049Y=
X-Google-Smtp-Source: AGHT+IF1FmHiPeErJpTcgC/luB7Qxe+t0bFuGuqcb88EeeEbXB7I8i+27RAFRCK5NsDh275aCf5SOA==
X-Received: by 2002:a05:6214:3b83:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6cbf9d08a54mr121865486d6.20.1728939926345; 
 Mon, 14 Oct 2024 14:05:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8608c0esm49998646d6.85.2024.10.14.14.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:05:24 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:05:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
Subject: Re: [PATCH v2] dts: Deduplicate dtbs target
Message-ID: <20241014210520.GV53053@bill-the-cat>
References: <20241004001118.322531-1-marex@denx.de>
 <CAFLszTiMNeU__kzyRR-3qKPUUKaXEqaypf8YYQgxL83E-2gt3g@mail.gmail.com>
 <CAOMZO5Cp3TUdMFYfBSm-k49mS_xaOtvpGwqoQH+eCjC5eCfpbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AP9KnRae/m+GIDEM"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cp3TUdMFYfBSm-k49mS_xaOtvpGwqoQH+eCjC5eCfpbw@mail.gmail.com>
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


--AP9KnRae/m+GIDEM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 04:08:23PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> On Mon, Oct 7, 2024 at 12:23=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > On Thu, 3 Oct 2024 at 18:11, Marek Vasut <marex@denx.de> wrote:
> > >
> > > The dtbs: target is almost identical in all architecture Makefiles.
> > > All architecture Makefiles include scripts/Makefile.dts . Deduplicate
> > > the dtbs: target into scripts/Makefile.dts . No functional change.
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Marek Vasut <marex@denx.de>
>=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> I have some patches in my queue that depend on this one.
>=20
> Could you apply it if you are happy with it?

Yes, I'll pick it up soon.

--=20
Tom

--AP9KnRae/m+GIDEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNh5AACgkQFHw5/5Y0
tyyPgAv9ESmWZ5uP7TuLR73624SCXYYud2cqvRR4PdtemTgcRAihRwVN1JGxBL8q
FAOIlSgs7B3JnHkxX3QGqSLMhDjpzWHGh2SRXZXlYVv/DIH6D606mQ09cVfKtcZN
dWfj2qzKTAtk3PxVOguCRK8PhZKrfSaaam4nEsgrHqY0ppehDvSlTOdbnOSL7WvI
cmQfFGJw7SgmYRkYxIU5U+0hm6BFOl/o0iqqzO5ZFopiY3oB9wAk/v5SGvG3KiTB
niQAGLbWU0osZgyUPu+AMx+1kG5bx+F8lJW+/RrB5kJjO6ej5u4OGYQ7tq7poRD1
XgaiFSiviNz1VjuYetTZ45RvHoKAOwtSN0LTiVYSQwjktvklc7zW2E1IwB4fxtxA
ONqbAdZgpqjMamUN5I2uTx/JstLmbSXrbTCAPub1BCMuXSI9o7PnScaJjEY1DjHI
RBV1SreF1+SFoH2XKjxLYawz0ahO6ehuaZDMIIgU5PpdwyofNxWbzKPlJ3drWWru
+2mTFsTq
=nbsr
-----END PGP SIGNATURE-----

--AP9KnRae/m+GIDEM--
