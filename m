Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B6BCCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617978312A;
	Tue, 14 Oct 2025 16:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sdZdSo+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66186807B1; Tue, 14 Oct 2025 16:22:52 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400608312A
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-43f86ddb3f4so1940060b6e.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451769; x=1761056569; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wEctA2w32PuSWWYU82c3qHcdGNcSRYtbljYtH4SLUwo=;
 b=sdZdSo+iueGoBK04yW+1E1yHkAHneZt+NtWvsxlvyZ+sYDi4ETVz1Mu4PpzbK7Z8D6
 Hdb2dbUbfrdN7OKv0P6VJJ0EPVX+3tQ2uNkeacFmtXDBa9OGGZOpyBjMJf35Mdr5/1ze
 wRNIlPWWjdM2ILBAoiQtDuD5Hxqr75sheEg+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451769; x=1761056569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEctA2w32PuSWWYU82c3qHcdGNcSRYtbljYtH4SLUwo=;
 b=FuzQC/q2J9RLtiwpD9fCxDWcL0zUkn4UhcwkfeiFvS9SZKYPuDg5VFGMJeRV+7/4YX
 u4smkG+3sHx5SOuhj8azEF+44VrbDP52fC04sI9zlovCxXO1hToyvNc38rCbBDDQFGkf
 Fki1ENxXM9Eq+kU8RyYV4SKvVBuqwU8L4dkMYRtWa/je8tHZg/S37i3r0zktMgJCDVit
 TaWpZ1kemfimxhQAnesiVlybdAJI3raq/ABEJ6/4V7aqs5wOfdRTgGKoumV+c+xzuhnb
 PO4EU+KvNELCCIp1EnQX0HkhPYxN+H4Yp2EWcqLkr/GySEh6lZDC0hxDkS1DpgAn929q
 pYyg==
X-Gm-Message-State: AOJu0YyS+ZlVc0UirC0v5S4uGsZUZL3tO6RjytoAntikmSYfAz0GIr5L
 oW2WiiIw0+FEU4ZtO3RRJFJhX/lba4wcTUsdayY4Oz2FpNitJ9U6OJzvcr84x9zVLUX0X4HIm4Q
 lMt9KY98=
X-Gm-Gg: ASbGncsr7AGXrMbfT1u2CP41ipmvbV1RKVrdvwGQQxDmdqrmZzxzXogQt7i2gmH7gTB
 TtoDsul0w0lb9crPE6crhfJDhThaxge9wr9YnaSbQNluuTLjyPyP+ljy8ltzDPoe6bKouoR0Omy
 +8rZEETSlxekG+YwlUapv1Sk/Z5r19JmrIHXoL7om4wylscZHasEScVOSTpvYJvbNEYbUJeETuN
 43TnaBowe00DJUWqGPk8SJcOIxyVxkLiJMwLbGYP6QXSnlJbxPCSVabDsDN13XHXQa/busy7JZi
 O5HaNKfXscAlse6s7+FDdqt0z3oOEmD8cHrrD9fJf9U1Hsfios7OvJs9tOzGkcDa1boMQ7O5UFk
 IMX74cb4KjLi0kTtWSNEFrVEBSNwzRpa6vhjZbHD/2bMotA2k5xrgE+IGsVz6W2vkSIusfk8aUb
 xCvQxDafS4RYa/2Ow=
X-Google-Smtp-Source: AGHT+IEO4yXH3btx6YtaIrGCEzO2V4az5eDsxsBzdNQFztf7auFgMO+dkcNe3IwJed1xSvF+yIDYJg==
X-Received: by 2002:a05:6808:5290:b0:437:dade:463f with SMTP id
 5614622812f47-4417b3dae8bmr11498957b6e.34.1760451768924; 
 Tue, 14 Oct 2025 07:22:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419887fd8bsm3320246b6e.2.2025.10.14.07.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:22:48 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:22:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>,
 Judith Mendez <jm@ti.com>, Ryan Eatmon <reatmon@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 06/11] arm: dts: imx8m: Add remoteproc node
Message-ID: <20251014142245.GN6113@bill-the-cat>
References: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
 <20251013-imx-rproc-v1-6-fb43a3fafcd0@nxp.com>
 <20251013155546.GJ6113@bill-the-cat>
 <20251014015037.GA31468@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sxPSYHK7ToevmQhX"
Content-Disposition: inline
In-Reply-To: <20251014015037.GA31468@nxa18884-linux.ap.freescale.net>
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


--sxPSYHK7ToevmQhX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 09:50:37AM +0800, Peng Fan wrote:
> Hi Tom,
>=20
> On Mon, Oct 13, 2025 at 09:55:46AM -0600, Tom Rini wrote:
> >On Mon, Oct 13, 2025 at 10:49:25AM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>=20
> >> Add CM7/4 nodes for i.MX8MQ/M/N/P.
> >>=20
> >> Reviewed-by: Ye Li <ye.li@nxp.com>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  arch/arm/dts/imx8mm-u-boot.dtsi | 4 ++++
> >>  arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
> >>  arch/arm/dts/imx8mp-u-boot.dtsi | 4 ++++
> >>  arch/arm/dts/imx8mq-u-boot.dtsi | 4 ++++
> >>  4 files changed, 16 insertions(+)
> >
> >Why is this in the u-boot.dtsi? We have
>=20
> I am preparing the Linux dts patches and will send out for reviewing.
> Before those lands into Linux dts, we need that in imx8m*-u-boot.dtsi.
> After linux side done, we could clean up the imx8m*-u-boot.dtsi
>=20
> >dts/upstream/Bindings/remoteproc/fsl,imx-rproc.yaml and so your updates
> >here should be compatible with that, yes?
>=20
> Yes. Per the dt-bindings, only compatible is required and that is what
> this patch added.

OK, thanks.

--=20
Tom

--sxPSYHK7ToevmQhX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO5ctQAKCRAr4qD1Cr/k
ChkfAP9vI0N2x92olno4Rl/jM5lq5dysXJzNscQfBDyTWnRDBQD/W32QcDdXcJz7
j7IViYMlPNrfFox1W111yOB7BbTFDA0=
=rltC
-----END PGP SIGNATURE-----

--sxPSYHK7ToevmQhX--
