Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E82C369CB
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 22:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5F0830A0;
	Fri, 18 Apr 2025 00:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b3yQke4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5CDE830EB; Fri, 18 Apr 2025 00:04:38 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9FC82EBE
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 00:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-400b64ac5fcso629789b6e.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744927475; x=1745532275; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0zRR35p3PAnhXnwZ+NJZOBDR5VGG7ZQVQ4fO7ZnmUMY=;
 b=b3yQke4nuAHnb95epU+Vq6SC6Fv2HIuhQHQxH2UQxpez3MylN7M6VgN5tfywcRhKOy
 1ZgNReXVr3N8ypYY3mjRDtufVEsQCzb+6i3sEOkHIew1dyUY+0gyisEYMhsv1CgusZz8
 M4u24Sozvx/VpJLev6hOE5lxaqxnFSfu75GNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744927475; x=1745532275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zRR35p3PAnhXnwZ+NJZOBDR5VGG7ZQVQ4fO7ZnmUMY=;
 b=j7GUq2Y91C/4dRNFiKFfpa7Qu+2wDkhZ4dPYowYr4R7gAHrb/feBNlvXkt3vXhEsNd
 wcToCkWqvG64TIzU0CufiZnwQxRLfKW61H5r1ZpLf/4CvktkRU28VBHGzPnMoCI3zNso
 HG/CZBMHl/Oy/fAHuWZwklxTDUtK1KyrLYfF1bdFwc1I6MkysY2TECR/YHM0K2NSosRH
 8vtbOiAMUHh43AB7Osf+d38fz035OwNFzgRVzPC74fbI9/G0nZ0QCMXuIq8BEtDJhqtq
 DZxR1k5IM8cepR3NrP/balNWpYLhxOEafUSlylI0adPthNGxVNtxFKZpBiNuTsphFE8p
 RIJg==
X-Gm-Message-State: AOJu0YyKxsfj3dU4H6hv8AJ7+MtX253tPS6KWVT9ooIvOuuwo50Z9HS1
 NrA24dyqtyCIjVD9GH8lsJhS2alWqpO8w9cfPhAhVOcNaapcdTHyapeE/UgJcqKY0jd075+7Z/9
 d
X-Gm-Gg: ASbGncuzEINhaj5Xj1c9pqp6nwDx+tn2EvLPI8AnlnY8CbJrZT5LJmkjOTLrrNhJgUG
 7htFYp5dPTaKSpb0stA4ye6ejKfoRgUWq7w/LMYigrrzfRepNoVEGut6ih4N1XVk7DgQqkyqbUn
 1xUv1WxsVGz+diIYlI50jVoTqyHKnqTUs2uRqTn2zSjOe0aEiIRRIzEzffwmzZgakCpPM7S9BJL
 3PTU+FY5kl3uLUjp7ZTeqsRqaIOir0HaPm+za8aIwMU+kr043fo83MolkmhEp3minAtsEHeDul1
 7u52tOfGs2CMdf9YfpBXYrq7BgG76Y9jOXQjySXQ4ufq++ZembX9tJ1Syu9Vt01AFF+gO/Fjm2W
 9/w==
X-Google-Smtp-Source: AGHT+IHaf97CQ8Mn/GUIN+bpFOYnCP1ArSBikbo/g47iU6miUkSuufcHn2ZHiITAPgcFFCJgLuvv4Q==
X-Received: by 2002:a05:6808:80c7:b0:3f7:6824:5839 with SMTP id
 5614622812f47-401c0ab0f1emr277890b6e.19.1744927474679; 
 Thu, 17 Apr 2025 15:04:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401bf081eafsm95539b6e.35.2025.04.17.15.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 15:04:33 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:04:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
Message-ID: <20250417220430.GE5495@bill-the-cat>
References: <20250405190711.365419-1-sjg@chromium.org>
 <20250414225307.GH5495@bill-the-cat>
 <CAFLszTj82Lw+anq9U5uQOFO7SmfqLpuVAc+1af1s4i2emkau7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SqH0z2shg0P7ZniL"
Content-Disposition: inline
In-Reply-To: <CAFLszTj82Lw+anq9U5uQOFO7SmfqLpuVAc+1af1s4i2emkau7w@mail.gmail.com>
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


--SqH0z2shg0P7ZniL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 03:39:57PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Apr 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Apr 06, 2025 at 07:07:04AM +1200, Simon Glass wrote:
> >
> > > At present it is impossible to change the qemu_arm64 defconfig to
> > > obtain a devicetree from the U-Boot build.
> > >
> > > This is necessary for FIT validation, for example, where the signature
> > > node must be compiled into U-Boot.
> > >
> > > A proposed change to QEMU to allow device tree additions has been
> > > blocked for several years. The only known workaround is to use QEMU's
> > > dumpdtb option, merge in the signature node manually, disable
> > > OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
> > > complicated enough that it is documented in U-Boot[1].
> >
> > This paragraph and then
> >
> > [snip]
> > > +       Note: this work-around is necessary since Linaro has blocked
> > > +       addition of a feature to support additions to the QEMU device=
tree:
> >
> > This part of the help are overly antagonistic.
> >
> > [snip]
> > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > index 2e88d210bb8..53f7e246a80 100644
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
> > >         development purposes, but it is not recommended, and likely w=
ill not
> > >         even work, for production systems.
> > >
> > > -       Note: This option must be set in Kconfig and cannot be enable=
d or
> > > -       disabled in the board's defconfig file.
> > > +       Note: This option can be disabled for QEMU usiing QEMU_MANUAL=
_DTB thus
> > > +       allowing QEMU to support FIT validation, where the devicetree=
 must
> > > +       include a public key.
> > > +
> > > +       See also this for context:
> > > +
> > > +       https://patchwork.kernel.org/project/qemu-devel/patch/2021092=
6183410.256484-1-sjg@chromium.org/#24481799
> >
> > And we don't need more wording here. The QEMU_MANUAL_DTB option itself
> > is enough.
>=20
> I believe what I said is true, Ilias' comments to the contrary
> notwithstanding. If I were trying to be antagonistic I would perhaps
> express my views in a different manner.
>=20
> Perhaps we should discuss whether Linaro should have maintainship on
> these important projects? U-Boot depends on QEMU and for it to block
> that patch is really not that good. It just makes things hard for
> open-source firmware.

If you wish to argue that Linaro as an organization has undue influence
in the open source community, this project is not the right forum to
raise that concern on. You should submit an op-ed to any of the
OSS-focused new sites or something perhaps, I don't know. Because QEMU
is a member of the Software Freedom Conservancy project, which is also
where I am trying to steer us to, and they take the idea of keeping
community projects as community run seriously.

--=20
Tom

--SqH0z2shg0P7ZniL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBeu4ACgkQFHw5/5Y0
tyzgiQv/TC8KTmv7kXYfLi+Awamwl3l7Jw1F/Rvii1IWCIADFbZ0jIzOvQOrm4GF
mNTEzOT87Jtnb74Uvlfa9+CVGsv12xuVkeEsq171OvvOzttJDXO/Yo39Q1bNK6yC
UaKeqfCQHjAQ44YA7k36iRFr/oHdofsa49yViTp1w7Co9R4O4R/MHxZZWAmM8miu
k6K29LXkhCQrBsJ3Q63Ls8KJmkl5mMkSuaAtOJisku3if2w+I5aiY3YtTYA2S1/Y
xTbkAlwslKZPlEjFkFYZAq9LvaToCf98wP7wIRsKXl3RLmsactWydrci11KvIncb
zf8fwKaFqmpQ1COyG9DoE/+HVkOVZn07YKFkWE1nDJjg8B4P4qBk1C4kZQ07mT87
K1xi6r+bMqnmDteXC/kjAztMAGTMvfASXnmcNyueD7BtUHWf2VA5yINdgSt4svDV
ivpEuZQEvN8GuqVyI2FrVG2skjbi4nXL0llhGx7BWoBKnZbtlOfLKrwRLPznDPZM
AEDZyT45
=Tn61
-----END PGP SIGNATURE-----

--SqH0z2shg0P7ZniL--
