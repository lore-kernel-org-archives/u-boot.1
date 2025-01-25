Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BCAC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016FB80F10;
	Sat, 25 Jan 2025 23:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rn15T3tE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0792980F56; Sat, 25 Jan 2025 23:55:20 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB0780ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7be6fdeee35so529579085a.1
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737845717; x=1738450517; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cLz7wfgGrg58brlZhRHxzcq6FwbES2C6dgppw1rS6nI=;
 b=rn15T3tEF6takhhC5Ohiwj5rFQFbz8C/cFOuQL2NesD8SUwuopfKNbjdnlbysIjWhD
 AfLxOsChJyTRG7Ulj2JLGzqxTeOB0MqIJKExCCLXtQCGk1y2SHHVKV4L9i3PvV5Bc8Ox
 Fv/F4zySKD+Yp4cEdA/dQz9tF0eVks2wiGrdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845717; x=1738450517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLz7wfgGrg58brlZhRHxzcq6FwbES2C6dgppw1rS6nI=;
 b=Zzyx2zbcv7VLglFzIuN2aBwtEVA/FnJvRY6GT72oYgMp8LfCZovThyIoHx0A6WUS1u
 K8iB8LEaK8EKVcr4ANEqhUGHjz1SK4QDIkkSvpcvCWYzmj/7IYlROYvBWtLs93X6wOuU
 i+Z/LcAMJg0yF+qfAttOwIw6rUOByvuz0d2c+uYin5OvlXhTqm+XBtywmX2l8K3rENOT
 gDJTsfweoUM9biz9EVT8gAg5ExggWd+LHfl0D2ouMRO66OvQl2fLlXMHSSqczmNQkGva
 cagQwcARESJC2/IbdL6EaT0Q7uN0XrjATqzO7et51kxgq1wl24oatu3VOgfqFfJpZhAu
 d4gA==
X-Gm-Message-State: AOJu0YxqvFA/YqCbI2PYrfWDJk+cw1fZDYwoKFGHsp/PlCJ7lHvj43WU
 mRw2theRaEVMpWuLZr/+QP9f7aHp1ZS0cpwvv5/0Q+hxs4chZw852/C/exIoxrY=
X-Gm-Gg: ASbGncsUzqEYm38aGV5SMZ1uEud8/G6Oow7D/U/Cl/W2EGC0/ZZRBSXGF+nPFQ1hznx
 BJYQuo+sdv1ShooZAqbKw7ocSxnrQ0HTppWnZ2JhxNORPRkSX77Mx1fIFilmmYK2eMveo1m2l1Z
 RogNULBiB4bh5FDppBrO3OiYLf3UaQkC9FzDKezs9tbxT0IV+Ncc3GUy/fzxRBiiruBRvI2OkDa
 /MMbNLE3qc3Zfa7iEpsFVs0ZMWygQsqvt7iwRvHE0y40xdu6RhVUDoB9+dCPMGW4FmDN8+doz3Y
 4yPf
X-Google-Smtp-Source: AGHT+IFjxUUYhyY0u7Rb+/Ldt35RJKfxI03K0CFf8feVA0RUX1NDOpDfiGENEy2lVBTQqlHx8YtvSA==
X-Received: by 2002:a05:620a:1a0e:b0:7be:3cd7:dd95 with SMTP id
 af79cd13be357-7be631e7260mr5089293885a.12.1737845716763; 
 Sat, 25 Jan 2025 14:55:16 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae8aa00sm235697185a.41.2025.01.25.14.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 14:55:15 -0800 (PST)
Date: Sat, 25 Jan 2025 16:55:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huang Jianan <jnhuang95@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Weinberger <richard@nod.at>, Roger Knecht <rknecht@pm.me>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
Message-ID: <20250125225510.GJ60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat>
 <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I79wL8RukflE6lL8"
Content-Disposition: inline
In-Reply-To: <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
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


--I79wL8RukflE6lL8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 03:42:00PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
> >
> > > This fixture name is quite long and results in lots of verbose code.
> > > We know this is U-Boot so the 'u_boot_' part is not necessary.
> > >
> > > But it is also a bit of a misnomer, since it provides access to all t=
he
> > > information available to tests. It is not just the console.
> > >
> > > It would be too confusing to use con as it would be confused with
> > > config and it is probably too short.
> > >
> > > So shorten it to 'ubpy'.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > >  102 files changed, 2591 insertions(+), 2591 deletions(-)
> >
> > First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> > it's how we interact with the stdin/stdout of the running U-Boot. And
> > indeed it provides more than that. But ubpy is too abstract and unclear,
> > and looking at the diffstat, I don't know that big global rename is
> > justified to save text space.
>=20
> I actually get quite confused hunting around in the fixtures so I
> suspect others do too. I would like to settle on some better names.
>=20
> Yes, I don't like ubpy much, either. Your favourite AI suggests
> 'fixture' or 'test_env', both I which I prefer. The only challenge is
> that 'env' has various other meanings in U-Boot.

Yes, until someone has a better suggestion than "ubpy", we should leave
things alone. "fixture" has its own meaning within pytest and so that
would also be confusing.

--=20
Tom

--I79wL8RukflE6lL8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVa84ACgkQFHw5/5Y0
tyx4Vgv/VyPUb0LZfjt1/JjdS7LPbbMaQGclrNkfRnggtxWlbE02Q46+fkv5THOQ
/KYpClFVhHppJkwVQ+ksGK+bZnTyAwRRAp4y7yn3fhv2c5LElD7nQHhL3LzE1D0b
+7L5kgZ1SKO51eqP/5CefjpPmmzDLPMB/ikiMSontX+misKI9f8kOJAhLT886stm
mRBGzIhS8oPCCGBSexgqpM+FAGyPXyRWaUI2jNnJsJX0tzRPIg+gtlhahz4PRkrK
KCsonaXEVdUHCU4+9ScNENB5fLWFTtVwKaRybBas1LnlzyxhFipo58KT856aUHBq
h+f2nAz05EXt/l5IBgxaZlrneHb/FzaEMGYTFKRUOwRfVjPuW6bhwT1CN/vO+4C2
ENMF7IJd0gm2Ea3Nqv4YDQguTPaaNQoc1g/8x/qKRj/tmxFBGruqHtUk/LcveKHb
zVSkcD0AX8GkTNTPJct5tVJAhcjoUHRTGtWY58YPnleVbrvWKAgXmnSXK10F/Tik
UVymMluO
=l3Is
-----END PGP SIGNATURE-----

--I79wL8RukflE6lL8--
