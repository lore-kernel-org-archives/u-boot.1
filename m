Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A6ACEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 18:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBEB839A1;
	Mon, 17 Nov 2025 19:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gGeTwPCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB65839D6; Mon, 17 Nov 2025 19:40:33 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849F983979
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 19:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-657534478a0so626776eaf.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763404830; x=1764009630; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W7je+gMSAU4jlPntQgLA3wkPYQU2cs+oSotqPUCbPoY=;
 b=gGeTwPCYKgmZPWW8okP+ikMHHd4FYnH2a9jzbOMsuz3IX99nuBhWM+/l72PzzK8Sum
 9JltBe1ChfET7N657QrqY0YQqJrZ/dwfSVEAi2akb68QRE3sErB/3bggKQP2zAuRRriJ
 lZ+0PYx1hp2nrt698qW/PYNWMisXknm1D23KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763404830; x=1764009630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7je+gMSAU4jlPntQgLA3wkPYQU2cs+oSotqPUCbPoY=;
 b=Aef7V3IxpWGVfmDUpI+VHglmEjNf+kHn2XpEN4wF0l8sdlqNotkP0xuyZ9jTECVYI7
 Oow37tc21GSKWv4JVRrw24PmyySDf53sepE3+yzPVSDJepQ/d3SwiGSZ+xyKg7oEb7ZQ
 wpHf6jPYcxyFrPALyctQ7t03sRqhbhXlvu8vcNt1OI7p6U7ovheUzYmdwVllHaX5Pvdh
 NC/elGPoJnRxK4PNYS2xgsnJ+lwn33ER15zvJG0GrOd6XifB2dzFlKeGtCAkqgD8wea5
 vj/Q169a0aYIuXB221gPNckvJiSIgHE0Fv8Z3xrM4Wk3YwYwuF5hjU1u+zsbxaL/nbG8
 EFcg==
X-Gm-Message-State: AOJu0YxY/yyz362TL70rUGCwzzVp13rjHAdX4s32r3AiBW3HDnaMNf8l
 pIzc+nVEBGQ9DmmgKJv4vvvhjC/+qmUObq9JfPb8t/f5HtF+6lraMKl3WeAGR6Ihszk=
X-Gm-Gg: ASbGnctoWzeBZOj69KleAU75O8xjF+jID43jXHo3CXb6+Ol8bri5K+JoJVR/zh22XyQ
 3u2YSpKXI3wh7XiIigi+kOTw8x6lGH2lVexBSujYK+GoHo5dA5d2pcyz8pETMheMvCSqUhRZyiM
 0VhpMzxUA/T6kpOwzgeuj7AGzQzERkPyxczLRASGetbecvxSoBgu5ZzM293eruqkXnPT49UOnrY
 CQj5yphLeUQZJ1ii+YWRHHTxobDKSzxEJ8j0ouxcyyFwvywaC9YcgpaIFvRlCMXyxYggBfTgm6f
 Yf8zsUfGbO1xvOwqlISRuqfw8YKV45MsrPkiIXAqW8ryQyeNYjqHazHxdk2WNjyqsuCkU+/chuz
 L4slxzS0Dyo5qazLIW5rdZYe8WTNtb9cRjir4Ec3QFK/u1nSitLH9FPzXRbflEpYis7TKjRcAv7
 Y5ZblwZlASm4zTHoNOMi+3oY6vXAxu9V/gCB08DeIkQX+vGt9QOQ==
X-Google-Smtp-Source: AGHT+IEKefT7sWqtdw1wysD7nojNlSM/UhofwTrbeOiME/cInJ5zYE7NTUWQ/umkfi66clPzn/T4eA==
X-Received: by 2002:a05:6820:4b15:b0:657:4e02:34a7 with SMTP id
 006d021491bc7-6574e023697mr2595316eaf.1.1763404830170; 
 Mon, 17 Nov 2025 10:40:30 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6574484261esm2158625eaf.3.2025.11.17.10.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 10:40:29 -0800 (PST)
Date: Mon, 17 Nov 2025 12:40:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
Message-ID: <20251117184027.GN2125796@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
 <20251113184917.GN6688@bill-the-cat>
 <71261c83-0a3e-46b6-a0db-d3587a54d71c@mailbox.org>
 <20251116141151.GC2125796@bill-the-cat>
 <11a631a3-644a-4c4f-8b09-7202687a4a90@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="USKbliA5ZVkQJQ5l"
Content-Disposition: inline
In-Reply-To: <11a631a3-644a-4c4f-8b09-7202687a4a90@mailbox.org>
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


--USKbliA5ZVkQJQ5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 10:48:45PM +0100, Marek Vasut wrote:
> On 11/16/25 3:11 PM, Tom Rini wrote:
> > On Sun, Nov 16, 2025 at 12:23:30AM +0100, Marek Vasut wrote:
> > > On 11/13/25 7:49 PM, Tom Rini wrote:
> > >=20
> > > Hello Tom,
> > >=20
> > > > > CI does show that no boards went oversize . If there is some grow=
th on
> > > > > existing devices, maybe we can shrink that, but maintaining obsol=
ete DTC
> > > > > code base going forward and picking random updates into it, that =
will only
> > > > > lead to increasing maintenance pain, so I don't want to do that.
> > > >=20
> > > > Yeah, it's not an easy spot. But I'm really not happy with growing =
main
> > > > U-Boot almost everywhere by 2KiB - 4KiB, and SPL by ~512 bytes or m=
ore
> > > > just to keep up. I do see that integratorcp_cm1136 barely grows at =
all,
> > > > so maybe there's something that can be done more widely and just wa=
sn't
> > > > clear at first. m68k only grows an average of 500 bytes and MIPS is
> > > > ~1KiB. PowerPC grows a lot. RISC-V a little.
> > > I suspect this might have to do with DTO support. The imx8mp_dhcom do=
 use
> > > DTOs and the fdt_overlay.c code grew a lot.
> > >=20
> > > I also found out that if I patch out can_assume() and replace it with=
 plain
> > > 1 , then the size drops by 1-2 kiB, but that's probably not what we w=
ant to
> > > do.
> >=20
> > I'm not sure, maybe we do? Or maybe we need to look and have *one* place
> > that confirms correct alignment and either fixes/complains
>=20
> That's already part of new libfdt, that is also what triggered the various
> fixes I posted recently:
>=20
> scripts/dtc/libfdt/fdt.c:       if ((uintptr_t)fdt & 7)
> scripts/dtc/libfdt/fdt.c:       if ((uintptr_t)fdt & 7)
>=20
> > , and then
> > every follow-up location doesn't need to perform that (or possibly many
> > other as well) validation checks. My impression from when I looked at
> > the code last, a few year ago, was that it was designed with "validate
> > with most? every? function" and we would be happy enough with "validate
> > once".
>=20
> If you can make that assumption -- that whatever we feed into libfdt is
> valid -- then we can simply patch out can_assume() .

Maybe the question I have then is, why isn't can_assume being optimized
out at compile time, if we set the mask right. Makes me wonder if
there's not something to fix upstream too. Or maybe we need to change
the default to higher than 0?

--=20
Tom

--USKbliA5ZVkQJQ5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRtsGAAKCRAr4qD1Cr/k
ClR/AQDqAHzyvLVr51lnGHd36mx5VsgZ1yhhpnnu4E4H+qlVrwEA/NQ8DGHA9X94
+3cmkhc5zXq3Kbk+dzaJUCTILSZ59Qo=
=3p98
-----END PGP SIGNATURE-----

--USKbliA5ZVkQJQ5l--
