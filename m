Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E353E74ACF
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 20:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984D389048;
	Tue,  3 Dec 2024 21:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ul1Yp7yI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5BC896CF; Tue,  3 Dec 2024 20:49:02 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758A68967D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-466943679bfso53473051cf.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733255335; x=1733860135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sMCDoxCEzwxRUq+0lQMe7xvx+8AC4XXddrt4LsZ2xb4=;
 b=ul1Yp7yIG/RBR9MfaKtip1r824ZuYuhVM4UG9brVugP0hKFyo3HAbfvXW5eK49mzrG
 mvzNRbHBgiAhVbif4IC9VrDPE66aIZH0QwOTs5tRMO4xNrrX2AJGHImKQOulrdyDg8K2
 MI/2m4zQTZeE4TTj5+yYRi9swHkN+gIubgDvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255335; x=1733860135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMCDoxCEzwxRUq+0lQMe7xvx+8AC4XXddrt4LsZ2xb4=;
 b=vyHlixBVrsCCXEjtrbCef95lMgyGSmtK7nrjbO72eiAhuO8RXndQfE4tAxrbBJr1JK
 L+0jDMr8NOv4R9jlr6JXDE1nlXVtESk/Rlr4n4vDmflPhibmf5yscxx6+XptiQUtkocn
 AIHcijxVb8mX/xRkLZwmjlSKTHLivtGwJ0f9EE6x0qsdbqD1GO6QQjvtuUrdTwS8ZgAw
 qWV1s9D6Q2+oUOX+KFwx08F0gVSxfY2vsdxidb3YZLkUow10fPkKtXLEdzRDvo/9nvpk
 tvGsip8SYkw9QBQuZV8Kj0hL4dlYUsXwLWlLB0JXx8djexD6sYC5fYN1XB6POjPfz4xg
 k1cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0McxO3AJ3JiobJuSabYUnGWJJ7ZXJsePcOsm4PyjMI5x6aCDeCjdjCjfCi4pOt2nT6TMHa1w=@lists.denx.de
X-Gm-Message-State: AOJu0YzfgwCKJpO4t1zTkcPMT1uAfVzqGBeDWX2UEVzb2x+WpD/m3+fB
 rzQBkVMJp12w+puLL9l+7tDm8JCIgSXZmKtRqgcS3mICFOLWITUVaA3r94rUKpE=
X-Gm-Gg: ASbGncsuTlbErymo5MgvF7zSIE6Qggoq7PQvzNIG3fM8k2vi/yrR7Bf30UWnTcHDcHr
 FrYiEYcK+WuG9JCN/dfINdv7jeiaMnXSztFMqy+q6zfrCXk0MbeYdlj5+vZM+XKGBMaRhpTBP2U
 b0sDFZuQ9XMiaMBhI73h7TMyzMjXcWg4n+aVz7XEcFrKGzvOtHqUZiiFQOJHRiWzw02wypJ4TkJ
 As9iO6BIQuhnWgsW+/U1bu645mGiGdqp4BNYFz7rXKij30X9A==
X-Google-Smtp-Source: AGHT+IEbitIYAXt7ZZaRZOMs46GmyHKxxPKvNboGd3OF7Ltwwy5E08yN8XZpsBOiOXnAHAvzsCFJBA==
X-Received: by 2002:ac8:7e96:0:b0:466:9a61:273a with SMTP id
 d75a77b69052e-46717ce5b21mr30973181cf.52.1733255335246; 
 Tue, 03 Dec 2024 11:48:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4054bf2sm64636811cf.17.2024.12.03.11.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 11:48:54 -0800 (PST)
Date: Tue, 3 Dec 2024 13:48:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
Message-ID: <20241203194847.GA4022002@bill-the-cat>
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
 <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
 <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s7q5Ss9MtVH/krld"
Content-Disposition: inline
In-Reply-To: <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 03 Dec 2024 21:08:57 +0100
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


--s7q5Ss9MtVH/krld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 07:33:51PM +0000, Peter Robinson wrote:
> Hi Simon,
>=20
> > On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com> wrot=
e:
> > >
> > > On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > There has been an LED framework in U-Boot which uses driver model f=
or
> > > > about 9 years now. Recent work is underway to improve it and provide
> > > > more features. It is probably a good time to drop the old code, whi=
ch
> > > > is only used by 5 boards:
> > >
> > > I don't believe, from what I can tell, they are feature comparable, at
> > > the very least I have not been able to get the Pinephone working with
> > > this so as it stands I still don't think this patch set is ready yet.
> >
> > I don't have that hardware, nor the other 4, so cannot do anything
> > with this feedback.
>=20
> Don't you have any HW that has a LED on it that you can substitute to
> see what it does?
>=20
> > Can you please be clear what you are asking me to do?
>=20
> Either produce patches that work on the the pinephone, or docs I, or
> other developers, can use to implement the functionality.
>=20
> Currently on the Pinephone the green LED lights up in the TPL/SPL
> (very early before ATF) stage and is lit up right through the the
> various FW stages, with your patch set I get no LED what so ever.

Please note that needing to confirm that we have equivalent
functionality between old and new frameworks (and
https://lore.kernel.org/all/20241110115054.2555-1-ansuelsmth@gmail.com/
might cover that) is why this series isn't ready for -next at this time.

--=20
Tom

--s7q5Ss9MtVH/krld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPYJsACgkQFHw5/5Y0
tyzYlQv/UvIv0/ZyO4EbCPO7yWd8hSWUZS6mxCKkyK8SR6CQzrcLxT0LaPXRFyAx
wbD4rpzXflKjkrETlgaGm8q9mDnHFIct7JB1++PHxlPsAJf1cSl+TvdtbAt37ntn
Vy6Aj7lsPfabnYsSD37+bCpE+aNg0oebaZypNoaAD8YqMEqZ/TcoK9AGE8nuVewt
x/I8JeFyGx9H4DI7rImc3omxt2D2ilKR6GigIK/ALLOhj9ObWMa3FOHgtkMTE/c+
oUeuDgXBo8tWmvK1CGiKSiPJz8tgDibOXVmudvu5hBIu6Y3ZQy3RD38mT7LdV5zQ
8o+aYzNdesK+Tmx1iT40jynFSpNiZpnkJOz51KIRs3KF+Z7tOKhp5jh4fL331jMO
I6gmR+j4kAvz+9LJKvA17Aaibwq0t9QMFwUuSLDIchmKS0snZzrdwHnKUHgmQ/kC
bNIJ9XFZFFX6SAU4vTMK5pRf6Ise6qETuzPJw6ZpA4VFDFTUeSXrmWrC507bVP4z
XFEFaBBu
=IlS9
-----END PGP SIGNATURE-----

--s7q5Ss9MtVH/krld--
