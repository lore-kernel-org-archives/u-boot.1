Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08D0C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DBE78144A;
	Mon, 31 Mar 2025 15:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iIB9NJk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFBC81703; Mon, 31 Mar 2025 15:42:47 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A7E8129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f94b7bd964so2992670b6e.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428564; x=1744033364; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=60TYNPwyx3xQhx7ShWDxgJ3xY3zhiuFmjiTr+fzqVSE=;
 b=iIB9NJk2ltZKzBSPV3dSX1Z0p2h8020yhlaWqGD/XVHN99BHRaUtZ72GZ1LTW5UVSM
 Y2V7Fx0Mzi1SNMAoFXbidqHoGwF5CzYr9O3geGCk28Cp+QwkaSQu26z49UhptDfUuiJI
 OmlZnn+kS7ipNhRwtj8Hda/QVfTrMgr8bMMxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428564; x=1744033364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60TYNPwyx3xQhx7ShWDxgJ3xY3zhiuFmjiTr+fzqVSE=;
 b=DnVw8oI+zLpnwgeyniys9cilnYOCDGZxvlBg4BBDdD8uN0SSNEyGGWmH0wShvjj0SQ
 7pdC3uWIkSokCmtUubXgDU1K4EgZfEBVjGCied7ZvBDdCNVwb8cWIm8WcqLq+GsAg+wy
 y4wW3pgBhhKjqGj1lbdTvZPon8R7OF2iOjZ84DoTAg+LcqmUlArscB0ZBJGB91zV64gp
 GgveBqKSfu6o9wGVXwxLyWdmGmEuOfuRMlYS3qkkpZN4xx7IVyzWznOAGboA+XCVVicA
 vY87/rDhf9gV7aVWpy5Lv4KrI76LLHqzCSmmvikS/vjr26D8BH3tvaYHwCeqMPTo5DLh
 HZjA==
X-Gm-Message-State: AOJu0YwqwHpZLBQaI+SiDTNPw6aAH/0z5bRsoOKelmi2KvB4AHce2r+J
 MYnqVVRtDP8dpY1FUs4r4qrQM4mg1btODzOsAblmATmh4Ox7KuUV2u1XI9wVPFs=
X-Gm-Gg: ASbGncugGb5/eg84hOQTWfX79Ywd8ulGv5st5pchbCEDcztzWTOjNbzhXwkzuX9CfM0
 WA3/7MsSQsVMRUh5/lCo11F32lSvY5KPpGNm5JsVY46/2fQkcQ/yf6qupNP4y+Clb5y4pworB3z
 /y6xnDv/OlnnpmGhTLDnoSEzg+dU33Ss/piJCzlL01mPGiqIywim2UhIWIhH+lRHvLN9RQ56112
 YOqWBj0z9iry9cagpxvgvJ+VGYGPKS8HXIbaZ0OHRaKXkXgxLz1E23vBumlCpYNVc8VpM3+1wAL
 6GJP35DWQdbmhgyhEtJXb5BeXXx6h8QxTX0CgchGTHx2XicOfpiy1XeVLkLC/6y9cXGk9+z5q9U
 7h4tuVQ==
X-Google-Smtp-Source: AGHT+IHvNmvq64PjRECtXNMsWUPUAF++pE+gm34SiDSVpbF95rrlwHjzrtoJjDhfGe7OdbxoKI29oA==
X-Received: by 2002:a05:6808:2e45:b0:3f7:d16c:e293 with SMTP id
 5614622812f47-3ff0f4fcdb5mr7234452b6e.2.1743428563861; 
 Mon, 31 Mar 2025 06:42:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05166b27sm1530122b6e.3.2025.03.31.06.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:42:42 -0700 (PDT)
Date: Mon, 31 Mar 2025 07:42:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 00/56] expo: Various features and improvements
Message-ID: <20250331134239.GS93000@bill-the-cat>
References: <20250328130713.2612648-1-sjg@chromium.org>
 <20250330144709.GR93000@bill-the-cat>
 <CAFLszTiykZ4EaLz2oBmUduLm_OsdDxamANf0cbBFaOvzyMwmMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jGBFj0KaEEhuu9EE"
Content-Disposition: inline
In-Reply-To: <CAFLszTiykZ4EaLz2oBmUduLm_OsdDxamANf0cbBFaOvzyMwmMg@mail.gmail.com>
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


--jGBFj0KaEEhuu9EE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 01:18:25AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 31 Mar 2025 at 03:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 07:05:47AM -0600, Simon Glass wrote:
> >
> > > This series collects together some new features for expo to make it m=
ore
> > > useful for boot menus:
> > >
> > > - measurement and display of multi-line text objects
> > > - internal alignment for objects (e.g. centred text)
> > > - editable strings in text fields
> > > - new 'box' object to draw a rectangle
> > > - highlighting of menu items, rather than just relying on a pointer
> > >
> > > Expo's boot menu is restructured so that it is possible to iterate
> > > through various bootdevs and update the menu as new ones are found. T=
his
> > > is more in keeping with how bootstd works.
> > >
> > > A new textedit object is added, intended to provide a simple text
> > > editor. Future work will complete this.
> > >
> > > With this series the boot menu has a better layout and appearance.
> >
> > Did I already say this for v2 and forget? It looks like you forgot,
> > again, to split the expo stuff out from everything else, which others
> > might review.
>=20
> This series is all expo stuff. Can you please explain your objection
> more clearly? I still don't really understand.

All of those patches that don't start with "expo:" aren't expo changes,
they're changes to other parts of the codebase.

> > [snip]
> > > base-commit: 37ef92a972663c6de1b81d24d2ca5cfd664fc6df
> > > branch: schd2
> >
> > Of course, not being on top of mainline, no one should spend much time
> > on this anyhow.
>=20
> As I thought we agreed, it is helpful to review patches so we can keep
> the trees in sync so far as possible. I take your point that few will
> be interested in expo and there may not be many comments, but sending
> it makes it available for review and potentially sending a PR for your
> tree at some point.

Yes, said at some point we should try it. And it's been a failure, so
I'm saying to stop. If it's not based on top of one of the mainline
branches, don't post it. Enough other contributors have expressed their
unhappiness at reviewing non-mainline code.

--=20
Tom

--jGBFj0KaEEhuu9EE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqm8wACgkQFHw5/5Y0
tyzKFgv+MY1j7C1XmJ4s15OqTok0k0w7NwFlJJIuZ/cZmdbEncKy1AuH0YkDAHy/
omjsUflVplveb9cHKQH5lPacOT9q/w8JLZG+rw8TMG9GYM4Qbdx7kul7RTEm5Xe1
R4z4jGEAcAXiAGggmhjJim6lkN/OyL9qJI53ZoqqsmRZB/Q2L1Gbzg4FRpieGlV6
FJoFnpMK5uSpn1dWsMxzetOYhvk5fKGY8omTsbWOfiga+zSjWjAj3t/zkWMvTuJv
UAdGVz+kli/c3OXbj5SOASW6otGuUBqX5Mtp/8OC0LqLs1KD1X0AAYoddxieMvl0
P+wmyCYjzyGskE/I3z5QLdH3D6Ib4OkAf4CIaEvBU4e6RwWQnq1DNn/pZM9+KO3j
lK2kIpt95IPb2VXoB4Wt9EVS/enUB3i/XTy/ALQNNQOyRwbATLiDbkY767oaMhIx
g7k3ZMm/zJ+K1MgwQNmtlEiDmkFrh2zmyOqr3IZSqfDAdxOAzgoqqzcSPvLbHJjg
m0NuRYbN
=wjpa
-----END PGP SIGNATURE-----

--jGBFj0KaEEhuu9EE--
