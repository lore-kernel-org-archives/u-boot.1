Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06694F4BB7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 19:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1C383981;
	Tue, 24 Feb 2026 20:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iRIxdYSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791CC83D8A; Tue, 24 Feb 2026 20:44:21 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 789B883642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 20:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-45f0b597eb4so3799635b6e.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771962257; x=1772567057; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S4LpgSN/VFtcFQr0nDmabWyFqVPTEpvhsxLcMuuN1xo=;
 b=iRIxdYSa1h2jadSIBboFN6LXt2eeeZ2MgXMrMzKPUTby3HoFQINB7qLrvtWSs6NFS8
 z1T8i0U8/kNaHMjXD9aziRfVYhU4DxSUo3a+kQkBu6Dpg1E0io8FdZpzEqh9+cAfm5RV
 JGn0xtZHUfJNp9LlwET5tUzrRQNjrMBsrr5tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771962257; x=1772567057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4LpgSN/VFtcFQr0nDmabWyFqVPTEpvhsxLcMuuN1xo=;
 b=kUsL3r/4fpgOK/1xMy0q2uyVNeXfJd3KeskSAZqQRE+14OtJ3iAtZX4I4OURup4x5E
 wi4D9IRnWMnU2U7qJ3iEIRPibRNodNIIDZU5Do9STb2Hx0vrivWSm0OhbR7gWA5DovzN
 q1jagNb1+4XmOmDqdEPuIJFmDmBEtJIvugYiPuSKjrCtMfuXKnWeb37x1vrGBC4Y3hVm
 Rx//0grxlhJ5YXX/nCj0ZyK1fo0p0snJffc4trLuR4xckQo9pOMrr+FEqWA1oJlxxVG2
 9LnBklrox3lT7vIsQ8ZbBt6SoLmOJzP2TQMxUyH8ybqQM4U/19pSlO2vmnmXk62Pq/5g
 3lcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpIJVjsAjNpuvir1ALjWFU1xk2muQJ91LRifZFjR/IP8RV5/iTIwyZLbqyxLDWwDRL0q5Pa0U=@lists.denx.de
X-Gm-Message-State: AOJu0YzVzONcEVOwyZ1ksUCwaVA6P6lSPO21fiUezYL9y6rHcAw6m4CK
 6dMpx/8xZLiml7IFqHpchsK1oiJErEGxoMlMg2KPzccL3rfCB6Wim9TP0nxr2nOxo22HIFtgN3v
 z025BOwM=
X-Gm-Gg: AZuq6aL2pI6+izVvbchxVhsANoW1C0C5adofdPFzzOm6d8ud/AGQxPiegUPKgs0N2N8
 IOfBw8DyR+HA3w/5g+8Un1VPjhmHImq7SAwhi9UTHwwqx1x3wfa5xqjXHAet8+/DLOiBhmhH3hv
 y/Po5bLhulmi8parBgXD/QZlaUlg0LOblhgjQUaqeBz7U3CzkAIbMoQHmINgaBtCeDk3MDPlRZS
 pB8HYYwVmW/m6C8pZvlYy8tm9LU6/CY2LnELsUtUZB8gL7AGColFUTa2i2wvGvHDWa5NKEakFge
 sPjeF2ONR4oY1HNdY6MnZaUrAlZe9yVg1D9GauqdqFJe0SNRBZYngGpAUl7/mu9WdQW4P1FMksR
 LLa4SRw8GDOK0suM4qhg3UOtphYNAIk40fibSiCyzLOtdPyAOtH35/Qzof+DvWzMWHIN1h7Z/Wc
 4aiqvLbkFwUFWucNeeeq+AU4PG2pX7j/gR4fbM0uBm+xzjOnR8r4nNQMw2XCgSCHCC6oaQ/Yn4k
 1v7WSqyAxpf5mpsDi6pRiXvjRGx/6A9TqdZqgUAip0jRf+LkY4=
X-Received: by 2002:a05:6808:152a:b0:45e:f947:c8e2 with SMTP id
 5614622812f47-4644640bb88mr6732075b6e.62.1771962257125; 
 Tue, 24 Feb 2026 11:44:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d038dcdsm10507123a34.16.2026.02.24.11.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 11:44:16 -0800 (PST)
Date: Tue, 24 Feb 2026 13:44:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alexey Charkov <alchark@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for
 non-secure masters
Message-ID: <20260224194414.GC3233182@bill-the-cat>
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-2-jonas@kwiboo.se>
 <CABjd4YzY3sQiVkH8ypZKuH=Yk-PPHnYgZ2V8Xa_x9TKFVGMPAA@mail.gmail.com>
 <af448b67-8c79-4f40-b1c4-c9a7a0b67bd8@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p/9oNUs3ph5D5WsQ"
Content-Disposition: inline
In-Reply-To: <af448b67-8c79-4f40-b1c4-c9a7a0b67bd8@cherry.de>
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


--p/9oNUs3ph5D5WsQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:56:21PM +0100, Quentin Schulz wrote:
> Hi Alexey,
>=20
> On 2/11/26 9:22 AM, Alexey Charkov wrote:
> > Hi Jonas,
> >=20
> > On Thu, Jan 8, 2026 at 5:36=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> =
wrote:
> > >=20
> > > The firewall block access to pmu sram for non-secure masters by defau=
lt
> > > after reset (0xffffbfff).
> > >=20
> > > Change the pmu lookup configuration to match the default lookup config
> > > for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.
> > >=20
> > > Mainline TF-A will re-configure the firewall to use an even less
> > > restrictive lookup (0xbffe3ff0), so this change is not expected to ha=
ve
> > > any real security implication.
> > >=20
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > ---
> > >   arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> >=20
> > As mentioned earlier in the other thread, this also helps fully load
> > ATF and U-boot from UFS storage without resorting to bounce buffers or
> > anything like that, so thanks a lot!
> >=20
> > Tested-by: Alexey Charkov <alchark@gmail.com> # UFS
> >=20
> > I wonder what's the fate of this series going forward? It would be
> > lovely to have it merged, but it hasn't made it to any of the
> > custodian trees from what I can see.
> >=20
>=20
> There are three maintainers for Rockchip architecture officially listed in
> MAINTAINERS. Philipp barely sends any mail to the ML anymore (max a handf=
ul
> per year the last 3-4 years according to lore.kernel.org/u-boot) and I'm =
not
> sure he has been involved in maintainership for years. Kever reviews much
> less often for the last half a year at the very least, as far as I've been
> told (not by him) his work responsibilities have drastically changed last
> year, so I am not sure if the situation will improve (soon or ever). His
> last mail is dated Dec. 14, 2025, date of his last pull request. As for
> Simon, I'm assuming he left these maintainership responsibilities to Kever
> since he was quite active for a long time. I assume it was important for =
his
> work at Google (Chromebooks?) but since he's not working there anymore, I
> don't know if there's still interest (or time, he's maintainer of many
> things already :) ). So in short... I think there's nobody left to merge
> anything at the moment, let alone review with their maintainer hat on.
>=20
> I'm trying to review Rockchip stuff when I have time and some knowledge (=
or
> opinion) to hopefully have patches ready whenever there's going to be some
> maintainership activity resuming. But I also have only a handful of
> platforms (RK3399, PX30 and RK3588) so makes it difficult to test things.

Yes, this is likely another area where it would be good to have a
conversation about who has time and if anyone would like to join up more
officially about custodianship.

--=20
Tom

--p/9oNUs3ph5D5WsQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3/iwAKCRAr4qD1Cr/k
ClqZAQD6VuuGyqnB7JId5ed8LRQtKUczMpNuJajtggkmLflg4wEA0AjHJEBemU4C
XyDNbpVjY2yW4rd0+DWLD1XAT/1a4Ag=
=4Pbc
-----END PGP SIGNATURE-----

--p/9oNUs3ph5D5WsQ--
