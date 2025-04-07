Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5CEC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 05:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1EF082B9D;
	Mon,  7 Apr 2025 07:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PQcG2OC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B1E82BBF; Mon,  7 Apr 2025 07:27:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC5382B00
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 07:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 75CDE5C56F9;
 Mon,  7 Apr 2025 05:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA422C4CEDD;
 Mon,  7 Apr 2025 05:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744003674;
 bh=IViMmBuZdtbctJbjAcVayVDAm7P5WpHQimX7cs3Ww5Q=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=PQcG2OC24M+xLjCr8ukSXLdjW7mKM8cCYzNvkJ7ijZbig/uwuyidmlgEyxgt4diP+
 X6TQlT1xkkiWZCPV7i7KOj+SDdPpctkw5hY7+HCUG8s0uTiM3ExDm+KgVzl0tCyudB
 qmaSYVttzPDeyrYzX0PkstHKtOysq0daANHXOMOD0TxByyVPGmYo2skW+fn5qQ9iPK
 IPR1u0oymJbE6HXfodla5SxLZYnZNEjngkQHFwQgvtRE0WvLih0Ld2jVIpIcHhFbab
 mjjAW88/ZRGOGXfIs8nk7/dw8ku3u8BEIqFxvPxeF9TaiUn5NtYrdUMcn+gQoeEkHT
 Z31Fr1YIEbdNg==
Content-Type: multipart/signed;
 boundary=6aa10b9814bcfbcb3f077bd586aed1df1ad36268bac2c63a695ff602a74c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 07 Apr 2025 07:27:50 +0200
Message-Id: <D905PDKW5YBK.34KA6NCU8GLWB@kernel.org>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
Cc: "Christoph Niedermaier" <cniedermaier@dh-electronics.com>, "Quentin
 Schulz" <quentin.schulz@cherry.de>, "Marek Vasut" <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Benedikt Spranger"
 <b.spranger@linutronix.de>, "Simon Glass" <sjg@chromium.org>, "John Ogness"
 <john.ogness@linutronix.de>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.16.0
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
 <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
 <D8VYKGGMN3DQ.1TYW767T1V3WJ@kernel.org>
 <de267e9022f844cf83bfd3e284c67955@dh-electronics.com>
 <D8XPRUHR9LEF.1K6BBAH3IJS1Q@kernel.org>
 <20250404145856.GR5495@bill-the-cat>
In-Reply-To: <20250404145856.GR5495@bill-the-cat>
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

--6aa10b9814bcfbcb3f077bd586aed1df1ad36268bac2c63a695ff602a74c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,
> > > > I wouldn't mind printing the pointer for %p[mMI], but %pa prints th=
e
> > > > *content* of the pointer which is really confusing. I.e. in
> > > > pinctrl-single.c the reg value pairs are printed like
> > > >=20
> > > >   dev_dbg(dev, "reg/val %pa/0x%08x\n", &reg, val);
> > > >=20
> > > > with reg being a pointer to a physical address. So with tiny_printf
> > > > the address of reg (which is a pointer to the stack) is printed in
> > > > this case.
> > > >=20
> > > > I don't think we can print %p without putting more logic into the
> > > > decoding. I think the culprit here is the fallthrough to %x, which
> > > > then leads to the confusing behavior shown above. IMHO if we want t=
o
> > > > avoid that, we'd have to make %p entirely unsupported.
> > > >=20
> > > > diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
> > > > index faf55d7f327..8147ffa2c1b 100644
> > > > --- a/lib/tiny-printf.c
> > > > +++ b/lib/tiny-printf.c
> > > > @@ -269,21 +269,18 @@ static int _vprintf(struct printf_info *info,=
 const char *fmt,
> > > > va_list va)
> > > >  						div_out(info, &num, div);
> > > >  				}
> > > >  				break;
> > > > +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP) || _DEBU=
G
> > >
> > > What if we fine-tune tinyprinf via config here?
> > > For example SPL_USE_TINY_PRINTF_POINTER_SUPPORT and
> > > select it by NET or NET_LWIP. If someone needs it,
> > > the pointer output can be enabled, otherwise '?' for
> > > unsupported is output.
> >=20
> > Yeah I had a similar idea, but I'm not sure if yet another config
> > symbol is worth it. That's up to the maintainer to decide :)
> >=20
> > In any case, we have a different behavior to what is printed
> > right now, as we drop the fallthrough to %x. Tom? Simon?
>
> A Kconfig symbol that NET||NET_LWIP select seems fine, and fall through
> to printing "?".

Great! Christoph, will you prepare a patch or should I?

-michael

--6aa10b9814bcfbcb3f077bd586aed1df1ad36268bac2c63a695ff602a74c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ/NiVhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gRFQGAj6vMQXLW9oKaBq1W0p8oFF8NyObvUqBa
EESD+avzx4149YgQBXdzRrLtC1TXug0HAX9kZqqLx65JG/H4EXfn07r3uA6r+Bc0
INCfn4pKPcJAI9SS2u22qsZ5v+MODMvdlgY=
=GgpZ
-----END PGP SIGNATURE-----

--6aa10b9814bcfbcb3f077bd586aed1df1ad36268bac2c63a695ff602a74c--
