Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20583F99C8E
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 19:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B390783B99;
	Sat, 18 Apr 2026 21:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BCHX8zzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC2383FF5; Sat, 18 Apr 2026 21:50:00 +0200 (CEST)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E90839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 21:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-688a8e5fc2eso1100293eaf.0
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776541797; x=1777146597; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5BBGvJlX0jX0LR/vkmoqdZtSuaVHBZgBldDEf+hejNM=;
 b=BCHX8zzcnRK5Ihar2UzkFQ2Lwf3V3O1mtMkFjTLMfrN+HvztGD+juYqJl2wJDMemN/
 nEVWtqi8we9+pP1M0IJNKtpxru8Wsocjy9aKtzp78687rsDv1Wg12a7O+c9fRMS7UHL9
 nJw79jcUUA49BLCWdl7K8yjfq2MHPs0Bsmp9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776541797; x=1777146597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BBGvJlX0jX0LR/vkmoqdZtSuaVHBZgBldDEf+hejNM=;
 b=gbfvAX5kbDxIW7QGC1xQVlk0YsqmQ0gi6H7AAV0WhV6rP1b+CBNglUP/GW4FqBrfts
 kHBbawqucF9O0PnjqcsebuFncCsVeLB3/lEkkv/l1ZCxt05IzeLol9eravtDhzBjwf9r
 W/M96s7BUD7Txjfc/rdcfIVA/T08hu/hPtz/muDm/HbLiE71x0pkne1/Y7IIxH84XLDi
 nStrgD+EvBuZ6NIcXEZVKYxTh7MNZu/BgO7Nta3D1l4V0h2y8WpMxxrM670ljx+A7blF
 Dt9jMRLi2O5xFrCUAMlr6R0L2ZmBBLfF/ZxsgZdWYA5D0HIQqgdJ6MOxcpRlpdiLQgWy
 u84Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zOdMl7HVEF6Ti8XGOFfc3/Sm5FGr3EbBpV5RaUFKqUiEhRqftjrIBTsmmkRmAHAi0RRbalT0=@lists.denx.de
X-Gm-Message-State: AOJu0YyB1Y3tgC9Y613vXpQvDXSsqdz5FHi1LwjQ6DxZX5C90+PRY+2v
 6gTOLb/25hVZMvCJK2YZ7qzJSngdMMggHKlZnB9wXrNu7rG1OUU7iHTVWL2136amXVvkC3vZU+E
 dx78SafF/uuu1
X-Gm-Gg: AeBDievqoQaiazHKu8wk6yxjYFvYYkMqcrHa6UUjLRHvTAjNXq6y5rdJbMWZ9KEkbk6
 3P/OncVnlSUjhRJduIUVu/NhBcjKlZp7D/fSuOg88G6kOnR2DiLEKlRGWcrENYBpdrKLCMRdMXc
 yk0LWmNBOWYfuUMUV2RQFOfvp8WPjW5R/HBsfQd9aKggQUZH8QT2+8X4pjxHC+4J5RpwlBzQi7M
 A5hOZq60Itao4KAGOY2oPm5Friqs0JsbCLAXgUdj2FQSpLBUIEO2vaSpgerOx3TWlsj88i4H1FK
 uEMuvAKf1OeZ9zMxk6iM+HdMypDoBhBmOVKuUktpK6WnC/G1bTwPDt7zvbgTMQHKZrWP2L5qh76
 icXGRRulzOhKdNYlfg9E/nQbEo8YR9GmTPlrenthgL1mda423Qy+zJ0jXzOfu38yIFT0UHdDMF8
 5DDFYCGTZGX7MyIJcoyIGcWpP/OmulDdH/vhBS1jJO5e1TDQ5VJlEb3pbUc3Uw707hd98Pv4NtZ
 0k9wg6DA5byCkqcyM76nYo/APyhYj6qQPB4jN+zcuf+LfoRrKpN8g1Bkq7Y+w==
X-Received: by 2002:a05:6820:162c:b0:689:ceb5:6f38 with SMTP id
 006d021491bc7-69462de1bdfmr4251493eaf.5.1776541796838; 
 Sat, 18 Apr 2026 12:49:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bd9f2sm4151900fac.8.2026.04.18.12.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 12:49:55 -0700 (PDT)
Date: Sat, 18 Apr 2026 13:49:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] scripts/dtc: avoid discarded qualifiers in
 overlay_fixup_phandle
Message-ID: <20260418194953.GT41863@bill-the-cat>
References: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
 <20260418190921.GS41863@bill-the-cat>
 <b67ed115-b040-48b0-b7d3-936dc8fb7dd6@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DgLeuglLftnjHMn0"
Content-Disposition: inline
In-Reply-To: <b67ed115-b040-48b0-b7d3-936dc8fb7dd6@canonical.com>
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


--DgLeuglLftnjHMn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 09:46:47PM +0200, Heinrich Schuchardt wrote:
> On 4/18/26 21:09, Tom Rini wrote:
> > On Sat, Apr 18, 2026 at 08:15:10PM +0200, Heinrich Schuchardt wrote:
> >=20
> > > When building with GCC 15.2 the following warning show up:
> > >=20
> > >      scripts/dtc/libfdt/fdt_overlay.c:422:21: warning:
> > >      assignment discards =E2=80=98const=E2=80=99 qualifier from point=
er target type
> > >      [-Wdiscarded-qualifiers]
> > >        422 |                 sep =3D memchr(fixup_str, ':', fixup_len=
);
> > >            |                     ^
> > >      scripts/dtc/libfdt/fdt_overlay.c:432:21: warning:
> > >      assignment discards =E2=80=98const=E2=80=99 qualifier from point=
er target type
> > >      [-Wdiscarded-qualifiers]
> > >        432 |                 sep =3D memchr(name, ':', fixup_len);
> > >            |                     ^
> > >=20
> > > Define sep as const char *.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   scripts/dtc/libfdt/fdt_overlay.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > Is this something already fixed in upstream dtc?
> >=20
>=20
> 9a1c801a1a3c ("Fix discarded const qualifiers")
> in git://git.kernel.org/pub/scm/utils/dtc/dtc.git
> implements a similar change.
>=20
> But the patch is not applicable:
>=20
> error: scripts/dtc/fdtput.c: does not exist in index
> error: scripts/dtc/meson.build: does not exist in index
>=20
> The change in fdt_overlay.c is identical.

Yeah, we need to re-sync with the kernel again, and there's some other
issue to sort out. I don't recall what, just that someone else had
looked and it wasn't a "update, no changes required". So we should look
in to that I think. I don't know if gcc-15.2.x has released with a bug
fix for building all of our platforms or not yet:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121588

--=20
Tom

--DgLeuglLftnjHMn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaePgXgAKCRAr4qD1Cr/k
CnRRAP9HbOj4PQvIJINwJ2hMFi4dGw0tp7bokmjKZSmICJ29UAEA+tKtH1mdt79y
beAH/J5PWd8Chbe1fE75EzUJ2biwxQA=
=aUxl
-----END PGP SIGNATURE-----

--DgLeuglLftnjHMn0--
