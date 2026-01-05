Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B66CD0426
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1434383A7A;
	Tue,  6 Jan 2026 00:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dHBNyOHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C0183D9F; Tue,  6 Jan 2026 00:47:32 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29EA83A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-459a516592eso315993b6e.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767656848; x=1768261648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/8DqAfJ9moISsrbk05r+Anf1Erzn6ML6nOmfEb5QIHM=;
 b=dHBNyOHhp9kGK3K0YmsCktvBscu8u3k86BWkYAUmYQ0PThFX5yO+rQhf3yKHVb6sOE
 hGpIvHJCD5lvNOO3PpebLbJG4yzAknP++vxlbUZaiHXx/tOcyp7o0sRGOoErUzrjdhUZ
 Eu/9IG2adjsIpUGjx/vdVdhbpVyOKxxhZFgbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767656848; x=1768261648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8DqAfJ9moISsrbk05r+Anf1Erzn6ML6nOmfEb5QIHM=;
 b=nJBjLGC2p6Bv5cPodgljrW5Y+m6at48gYqJlfGPlgS0VWjtjQlR7HhcEwIiDYa0fVn
 b9RXIWKvhOmUWnR94WhzERtuus3+5GhTgTZRaLw2CQBCHQ0CPlyZMZeBCeNvU7s5txn6
 1m1/8PxXfrQqK3JMntXA6PuyQWli2U0xFEOdvCHa3cUvTx74FbxLlaqoEdGzuZhdEmtv
 1paAiue5wCMmWWlFKjD0WWYhGI73B3Xr6uB50pNYkw/7dEzPPISks5HJg6caicjs+Wr6
 lSs8gaI61asCjyZXoOd8oX0MAVuO56byBWWPCcioLBaAT/cYVYCd30qqR5YUGr1LCXPp
 bU5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDJ1OXYhv3jG2BAYwHPewD3YCryAWaKr3j+iWqBotIKh7EawwHTeus3pEv/Xc1GlYv7IiAXUs=@lists.denx.de
X-Gm-Message-State: AOJu0YxSJICtpHSfavALg/5nJVNaZw3chnPEJ+V6bkcvZeczWyv9YrdZ
 eUE97v9ptsrjEbvu234mpeaiGVuiPmAYoHwb5K6ZTYrMUfCNVF+2DR61VzAXMet8qGE=
X-Gm-Gg: AY/fxX6Aa5B4ZUjNageNiw6iJhESU9X5+LcfB308FvD3GwiEwEDQbP+dWBhGCusJLtI
 r6+wAK2QHNcLiDq4VSleMdnkaRnZhc63znbBjViPa00aqZ1AqNMmd0W0gBP1L9/dmjg4mju1gN8
 8XawOhfepzNoaDe8RDj3p64+Kd73N/cWq6RTEn5zwywLKt2AKWAOkPdgRk6rHJrAgtffJJDMMQB
 jriAPKJgW+atIYHlonHsWf3IbK4RlIP0Cb4G87MJBN0uPAzUNs+MPBqQ63cINj8Vb1TbQFVpG8S
 MnPwP6qTq/kYSg9jL6hrj0kEbb7eIDQoGQ2WiNKkxv+ei4ZM31DqLHIsQZ9XMcNExyFd+7ZUvgu
 pQF139E9NEzrDkzy08maEgs6iLH/nT/iCaRRBOsJ7Ja13qsgJda4LXWYI7tztwzwPUXv1qQc0jB
 N63kMQ/xTZyFIpGk8WBBREbMemzKs9PJKPtBkmDC3yvAFQNo+3f6O0q5n2pjrOzBIlTRwyiJmAg
 6RX5sOsYgmDdGkXiXRDo/4SnSgX2dwKJC4fFCQ=
X-Google-Smtp-Source: AGHT+IFTChUFIMHMkLlCGMcf/DsTIiwtn5SSe48fYFxXX4crwVGQvv3tJJzY3AUnMGol8DqIJ40Bwg==
X-Received: by 2002:a05:6808:c3f2:b0:450:d471:dce5 with SMTP id
 5614622812f47-45a5b19168cmr866539b6e.6.1767656848633; 
 Mon, 05 Jan 2026 15:47:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e1b0779sm204088b6e.7.2026.01.05.15.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 15:47:28 -0800 (PST)
Date: Mon, 5 Jan 2026 17:47:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org, me@ziyao.cc, daniel@0x0f.com,
 heinrich.schuchardt@canonical.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 3/7] rtc: goldfish: Support platform data for non-DT
 probing
Message-ID: <20260105234725.GA3416603@bill-the-cat>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-4-visitorckw@gmail.com>
 <CAFLszTiMZLXoXEk=JL3siZURVD2YdnmQ7HXy=Viw8uUFbrL6qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f3T1YcJGC6mMR1C2"
Content-Disposition: inline
In-Reply-To: <CAFLszTiMZLXoXEk=JL3siZURVD2YdnmQ7HXy=Viw8uUFbrL6qg@mail.gmail.com>
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


--f3T1YcJGC6mMR1C2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 04:30:26PM -0700, Simon Glass wrote:
> Hi Kuan-Wei,
>=20
> On Mon, 5 Jan 2026 at 11:20, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Currently, the Goldfish RTC driver exclusively relies on device tree
> > to retrieve the base address, failing immediately if dev_read_addr()
> > returns FDT_ADDR_T_NONE. This restriction prevents the driver from
> > being used on platforms that instantiate devices via U_BOOT_DRVINFO()
> > instead of device tree, such as the QEMU m68k virt machine.
> >
> > Add support for platform data to address this limitation. Update the
> > probe function to fall back to retrieving the base address from
> > struct goldfish_rtc_plat if the device tree address is unavailable.
> > Introduce a new header file include/goldfish_rtc.h to define the
> > platform data structure.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > Changes in v5:
> > - Rebase on u-boot/next branch.
> >
> >  drivers/rtc/goldfish_rtc.c | 13 ++++++++++---
> >  include/goldfish_rtc.h     | 15 +++++++++++++++
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >  create mode 100644 include/goldfish_rtc.h
> >
>=20
> You can package your own devicetree in the U-Boot source, to handle
> what you need.

That's not helpful feedback here, the correct path is to use the machine
as QEMU provides it and not start yet another pointless argument with
QEMU. And this probably applies to some of your other feedback as well,
thanks.

--=20
Tom

--f3T1YcJGC6mMR1C2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVxNiQAKCRAr4qD1Cr/k
CurtAP9oAYe6Ezh9W1P4vmNKqmlkn21VozOo7eoT8gap3R3HXgEA1bc59Q0OqwTe
o924fu36kYUPdhEwOj2JBZXymfUfGwY=
=XkUB
-----END PGP SIGNATURE-----

--f3T1YcJGC6mMR1C2--
