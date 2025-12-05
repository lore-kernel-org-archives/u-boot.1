Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02332D33981
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 15:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C63584205;
	Fri,  5 Dec 2025 16:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TMLcq/kf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878BE84047; Fri,  5 Dec 2025 15:11:25 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E4883A5E
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 15:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3e7ead70738so1414586fac.0
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 06:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764943881; x=1765548681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vBCm9NNNZKrpGqnSI/9LLXq4S79ijI/MViRYxDl7+RE=;
 b=TMLcq/kfYAB+6UHXw00pYNJEYgnRMhwmZ1JjXBRCDXfAEQ86FzyLvC7a/Xc7Qn6F7Q
 w91i5ACchDXby1ZgzkMPf1KlHt7QZdTNEZM9kjV9hqsQ3dTNi6AHmzjycoGP753zL4Sr
 ES3k8VEyqzA3HJhai5imkq1dVi3HwztCkPXFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764943881; x=1765548681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBCm9NNNZKrpGqnSI/9LLXq4S79ijI/MViRYxDl7+RE=;
 b=pinYod8628Ez0SdN57+6jRh2KqCQeGzmEPRxK5cfh1G6trr8NTBWsJGQZmnD1qJuix
 5UKF+PZpO3AZDD7dIkaPyFvBXqrcFBwiN4yB7WAxcH8Mtcbu1LjruKn9Uk8DB4HqXx6F
 4OMF08c+oc1QZ5BIkNp9Myx6d4QH06bi3poa8lpMPuD8s6Oh/+Azze/Z/4LEio4i7+xi
 7yDQkBYxvHIrJtOkscYl7D/xGYx+zBR90y9D3+fqL+CySB4aHGose7pP1Ezd1OCUYmR+
 ZnZOxQTfsGP3HNgek/RlcQpMLaa4wbjPTRrkZjcpcQexJDZ+eLMNQROIEsQ77ZyECtAk
 qkaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpjiT9O1oBEVLiSDjwaKObaUJXDuVZKsYG9mBwP3RWJg0ELTReaOSe1cX1aGlwtxLlW3Kdl9k=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb+67RZgIjKL9N3tHtX7mD6Aylz2N2zVxZsNhIFYFHu5AZjUXM
 ibvqmLKQXr0mmvxj0NkNdbBr7gSoRj0FlIOJea/9U8z0jEOOPT5wY00lGjnwvnC1vSM=
X-Gm-Gg: ASbGncsaw/yg7HxmRLxHWhem5/9SAU2XW2YSCp6KmDEhrtzDrQBTDu1Niuo+CZRgr1q
 QskRSRseqY0sa0icebZZo444xxI7rHdxQAvBZkWAXBy5W1mZD7fqM5PTgNvY22d5L6+ofBNlva5
 wIrxgEvGUQNbkdw15iC9jtQQgeD+SDUVggXxmTM3hXQo8MZDyLrzmbzEh4EiTiO6DM0BNF7+GW9
 vUDZRmSi+VoPNCYSmFEldf3ppwRhZi0CAr2KABNuFWYTR+staWZ+1neGsKdjMYKHgVr/GtMa63l
 AL5+2lJWN8OsK4E8x6MA2OqCfuYfDVEzMNY3XziHZyLuXE+fP2nP2/fPPkWYkIc+1vpJLMmVcoW
 q6IylXEhAQ2JXicsSB9FDuF2Xch3FLgZsQo1fChvevNVq1NaeTJ0LPKxev/y56rujZvwFsob37o
 H9+tbP/lbP8ZOazByarkphRjGgyLEbZY4eA/CB2Z53ldthxRqx/w==
X-Google-Smtp-Source: AGHT+IEq6qY8zFAu3Wd80RjuRgOOMMnyJ8rKj6uP1FIl+sWH4Cizj7uKOsYead2SM6jOEhHmB4d1Fg==
X-Received: by 2002:a05:6870:b023:b0:3ec:4a8d:420b with SMTP id
 586e51a60fabf-3f506780c6bmr3865892fac.42.1764943881005; 
 Fri, 05 Dec 2025 06:11:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aaa0fdasm3431057fac.9.2025.12.05.06.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 06:11:20 -0800 (PST)
Date: Fri, 5 Dec 2025 08:11:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
Message-ID: <20251205141116.GH303283@bill-the-cat>
References: <20251118043042.27726-1-hs@nabladev.com>
 <176487670995.2050783.17410258029578449020.b4-ty@konsulko.com>
 <e2b4a1f7-d915-8e83-2f9b-7f48a56d8e2e@nabladev.com>
 <CAC_iWjJJEG2aUKhNLLY9KgqnROtTbCKd9Ex3-mhviado=r++Cg@mail.gmail.com>
 <6d29ed19-4fd5-afc9-56e2-f4c9df34ff70@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ddD44o6WL1k9cHrf"
Content-Disposition: inline
In-Reply-To: <6d29ed19-4fd5-afc9-56e2-f4c9df34ff70@nabladev.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 05 Dec 2025 16:34:34 +0100
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


--ddD44o6WL1k9cHrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2025 at 09:02:28AM +0100, Heiko Schocher wrote:
> Hello Ilias,
>=20
> On 05.12.25 08:24, Ilias Apalodimas wrote:
> > On Fri, 5 Dec 2025 at 07:03, Heiko Schocher <hs@nabladev.com> wrote:
> > >=20
> > > Hello Tom,
> > >=20
> > > On 04.12.25 20:31, Tom Rini wrote:
> > > > On Tue, 18 Nov 2025 05:30:36 +0100, Heiko Schocher wrote:
> > > >=20
> > > > > Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and=
 described
> > > > > at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> > > > >=20
> > > > > TPMv2 defines hash algo sm3_256, which is currently
> > > > > not supported and prevented TPMv2 chip with newer
> > > > > firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
> > > > >=20
> > > > > [...]
> > > >=20
> > > > Applied to u-boot/next, thanks!
> > > >=20
> > > > [1/6] lib: Import rol32 function from Linux
> > > >         commit: 6a0c939b88fd42c6b0a374f7c87317f292df46a1
> > > > [2/6] lib: import sm3 256 hash parts from linux
> > > >         commit: 41c0131b950a16747929ab310588cf5db8e38123
> > > > [3/6] lib: sm3: implement U-Boot parts
> > > >         commit: c4ab316269debc321907acc4f8f02dfe5653aeaf
> > > > [4/6] test: cmd: hash: add unit test for sm3_256
> > > >         commit: 213601a600f1e8894cea76b0bfc131f038882407
> > > > [5/6] tpm2: add sm3 256 hash support
> > > >         commit: 7c3f05ad51e4bc23dd4f411f28968f1d8f43099c
> > > > [6/6] test: cmd: fix a typo in md5 test
> > > >         commit: b30557b3b46c5162cb88a57907c517ed95557239
> > >=20
> > > Oh, may a little to fast, as Ilias and Quentin had some comments
> > > about tpm2 implementation/test (tpm2: add sm3 256 hash support
> > > patch). But I can send changes on top of that patches (but
> > > give me some time for it... end of year rally has started...)
> > >=20
> >=20
> > Yea I pinged Tom yesterday.
> > tbh, my main concern was testing the changes. I dont mind if we revert
> > and reapply or send the changes on top.
>=20
> I am fine with sending updates on top.

Sorry for getting ahead of everyone else here, since it sounds like
everyone is OK with updates on top, we can move forward. Thanks!

--=20
Tom

--ddD44o6WL1k9cHrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTLoAQAKCRAr4qD1Cr/k
CshZAP9p1NoFiGIMCHdwYj+S7xTX5BMA+waxd0iHUJGpqUW0nAD+KGo7oym39SUh
HTde8G3LKhJtDtvSPRFgAs+nExd5bwc=
=5izm
-----END PGP SIGNATURE-----

--ddD44o6WL1k9cHrf--
