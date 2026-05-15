Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610EECD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF23846DF;
	Fri, 15 May 2026 16:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XoKOtZ1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E851846FA; Fri, 15 May 2026 16:10:50 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03381846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-47bdee5bfc4so918999b6e.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778854247; x=1779459047; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wLd5gNYnnEX+LurEhtQnrVm7EfXty1UA15ai04ZSJeY=;
 b=XoKOtZ1gg/BY6qGUDWeyZz0Ef3nW1CJLmAej2K3H0PPR6zRqV8Eq248vGCeNkeENYe
 aNR8HHzcCK45UCIgPrPVHMduBTHaqUY6VJiNklhWryd4JG3RC8jCThtUuf5W3B8Ga4ez
 UwcEciP0V03DAYuAPhbyPZOUYfE0Cv9sLOp90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854247; x=1779459047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLd5gNYnnEX+LurEhtQnrVm7EfXty1UA15ai04ZSJeY=;
 b=LpjBdQRAUlfz9MijOz9RnaB9nsu0VGb8/beWWkY2/pPALDJyz8UF2fQd3vXO/CQ2QH
 3qRmG84fwi/FmsZLc1v9xJhTClra5z+5bgnCIaX4hXovWh8Oo6jW7w+waQDGK50ttUyP
 jpk28d7STEKxDj+0M7cCWMlGAirpsWPzYrqg+tbpzdKOLNrtp3288N3hpuWkC5uCg7PG
 Rs9rKM35I0Q/tRAmwxXSA1/C71W6n32Rv5wBFgRLuQ4Q6wiWScWOaWUt7EDRATnpZ5tn
 0YzTdBHnY2j4HEi8C0T5E2apDwB4Nb9WIKLsWaORvisCGafkg3/1tANh2fbdMrzR7co4
 9Zug==
X-Gm-Message-State: AOJu0Yz9RAvGEGUKzHkQeyWH8j1cLUkf8bsrW/D+jFpA2XOG9zEgjWdy
 PyN3yE26x7MKmaCAZ8aLbIfvjGqNyAr3cOM70wSGzSYn2vid/pLhvUb6f2Dd+Xa/y5Y=
X-Gm-Gg: Acq92OEOzZUjurPR704PJK+hI22/9So+Z8i3S2kUSU0iiLkAYQxp6g/caG9Ph8IxfNa
 LkNMPtUwOhb9mwSMyuTBDnBTmlURLj2RLymRT3CrcpIgExRJBHhMEuHaMBz/ZZ/KiZ/BdbZfGKR
 aypZRXohcGf6H0HrVZRNVt1Hyf6Pm8y/xhvrvgOU9b5EU2ZcQhvx9S/8hMduSGonf7w4e0mMeds
 Suq44+HkPZu1xOfnA8+DknS8W87i3ohrXlwkpybfnTodBQ/d+NuNMhymjRn+buspl8dqEfNU4+P
 w/8xHR0IKVJEzxtyomretpmUgHSkuB12V1S0y65Ok4+DlDY7ZwtyPI/skJR+XTxwySTMmunGZZV
 1njq1l6BmoXCpZSpO1By6i/UlgtbxyJn2ObCv7hQt+k0iUPpRx3bYzXzjBBKMDKII57d7Gy5TfG
 H4ouiX+opF4078522j9uKz1zLpwqmjEexsBHYlnf/XNSiMTx0RuQk8+//v9DeENXLbeJ4XdRhkK
 YUZXfLHvltbjvLtut9NwTdb3MWTp0+GNQ4Ob9AkVwf5gH2cvA0=
X-Received: by 2002:a05:6808:3095:b0:47c:17b1:e69e with SMTP id
 5614622812f47-482cb771383mr5164974b6e.11.1778854246674; 
 Fri, 15 May 2026 07:10:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee333d00sm881853b6e.3.2026.05.15.07.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:10:46 -0700 (PDT)
Date: Fri, 15 May 2026 08:10:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.07-rc2 released
Message-ID: <20260515141043.GY1858239@bill-the-cat>
References: <20260511220555.GM1858239@bill-the-cat>
 <CAFLszThULFjq_R4A1nWYjQcQ4Odw3aZ200RPmQ56Ecf3gO4UYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ePw1yOSkX62jVeuX"
Content-Disposition: inline
In-Reply-To: <CAFLszThULFjq_R4A1nWYjQcQ4Odw3aZ200RPmQ56Ecf3gO4UYA@mail.gmail.com>
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


--ePw1yOSkX62jVeuX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 06:49:25AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 11 May 2026 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > Hey all,
> >
> > So it's release day and I have tagged and pushed things out.
> >
> > As I mentioned earlier today[1], I would like to again thank DENX (and
> > the Denk family) for supporting the project for so long, and we're
> > starting the process of moving our infrastructure to the OSU OSL lab and
> > the u-boot-project.org domain.
> >
> > The delta between -rc1 and -rc2 looks OK to me, and I do still think
> > there's a few outstanding PRs to come in and a few things I should pick
> > up as well. But, the next branch is now open and so bigger changes
> > should target that and I will be applying a few things there shortly.
> >
> > To repeat what I said in rc2 (and will keep repeatint) is that it might
> > really be time to retire support for running our tools on Windows under
> > MSYS, rather than something like WSL. The move to support more modern
> > OpenSSL versions has hit a lack of support problem in MSYS[2].
>=20
> I'm not really the right person to answer this, since I'm not a
> Windows user. But as I understand it, this would mean not building
> Windows executables anymore. Is that right?
>=20
> Should we perhaps just build without the pkcs11-provider feature?

In the age of WSL, I'm not sure the value of supporting MSYS. If someone
is using this, and steps up to resolve the problem, great. Otherwise we
should end up dropping it. Unlike the macOS side, we haven't had a
report of a user in well over a decade I think at this point.

--=20
Tom

--ePw1yOSkX62jVeuX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagcpXwAKCRAr4qD1Cr/k
Ci69AQDWoFaeHD83MPBnzLXipb8YL+yNqjBqygldWIflgE4JNQD/dRsVL1JxO8vF
yHjB//Do0P9B6McBo3XUMjQmjqTL6Qo=
=HHyp
-----END PGP SIGNATURE-----

--ePw1yOSkX62jVeuX--
