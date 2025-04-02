Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E384FC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 07:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4B38171B;
	Wed,  2 Apr 2025 09:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pfzorl7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C5581F0D; Wed,  2 Apr 2025 09:01:46 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6286080584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 09:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3335661145;
 Wed,  2 Apr 2025 07:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E856C4CEDD;
 Wed,  2 Apr 2025 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743577301;
 bh=1HYCeGAORCIVQ5EOYYUJ62BAxKdvULkm+7tGC85HUeA=;
 h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
 b=Pfzorl7gXFm/FErfmBMwYMUfcYFDwnuoJ8XzWlNWuTgiMWejnNlJNFYqXIWQX3rHp
 kRIgaqVvl9QBUoGYvIqc26jEfX+u2R/shz1jRtvp7WEMDap95xxuS6KYiG3oCCzGsi
 DNGymwU5U9DqGu7WckHGoL1bDsYYUPYfJReS5qUgbC+GSU526dDrBteg4koBKhI/kG
 dndUka9wUKWQn8ZbfjL/omP/6aUU149sRm7FDwPbMvpzDQOmoEisZHkMOeUO6UBYYM
 i0WpZ6uDMZX/tZbguFE2bxemUyWyJnLOREirD2YRvSnJbtMGIs2/Vx/az/un4Am857
 IABDzSNWfFM6w==
Content-Type: multipart/signed;
 boundary=e6ee05f6e2fe5a26e200d4de9e394ca62b09c860a7020402f0ad861cfdc0;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 02 Apr 2025 09:01:36 +0200
Message-Id: <D8VYKGGMN3DQ.1TYW767T1V3WJ@kernel.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Benedikt Spranger"
 <b.spranger@linutronix.de>, "Simon Glass" <sjg@chromium.org>, "John Ogness"
 <john.ogness@linutronix.de>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Christoph Niedermaier" <cniedermaier@dh-electronics.com>, "Quentin
 Schulz" <quentin.schulz@cherry.de>, "Marek Vasut" <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
X-Mailer: aerc 0.16.0
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
 <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
In-Reply-To: <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
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

--e6ee05f6e2fe5a26e200d4de9e394ca62b09c860a7020402f0ad861cfdc0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> >> The issue is that disabling TINY_PRINTF may not be possible (size
> >> constraints) and some code is compiled for different stages and people
> >> typically don't check whether the format used in printf is valid with
> >> tiny_printf. I've had this issue already in the past, I vaguely recall
> >> "complaining" about it on IRC.
> >=20
> > Yes, I've stumbled on "%pa" with tiny printf (i.e. in
> > drivers/pinctrl/pinctrl-single.c) which is printing the very wrong
> > value, actually :) So printing anything unknown as '?' would really
> > help here.
>
> Something like that would help:
> diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
> index 48db7b1f78f..b918d6d7386 100644
> --- a/lib/tiny-printf.c
> +++ b/lib/tiny-printf.c
> @@ -280,6 +280,12 @@ static int _vprintf(struct printf_info *info, const =
char *fmt, va_list va)
>                                         while (isalnum(fmt[0]))
>                                                 fmt++;
>                                         break;
> +                               } else {
> +                                       if (fmt[0] !=3D '\0' && (fmt[0] =
=3D=3D 'a' || fmt[0] =3D=3D 'm' ||
> +                                                              fmt[0] =3D=
=3D 'M' || fmt[0] =3D=3D 'I')) {
> +                                               fmt++;
> +                                               goto unsupported;
> +                                       }

I wouldn't mind printing the pointer for %p[mMI], but %pa prints the
*content* of the pointer which is really confusing. I.e. in
pinctrl-single.c the reg value pairs are printed like

  dev_dbg(dev, "reg/val %pa/0x%08x\n", &reg, val);

with reg being a pointer to a physical address. So with tiny_printf
the address of reg (which is a pointer to the stack) is printed in
this case.

I don't think we can print %p without putting more logic into the
decoding. I think the culprit here is the fallthrough to %x, which
then leads to the confusing behavior shown above. IMHO if we want to
avoid that, we'd have to make %p entirely unsupported.

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index faf55d7f327..8147ffa2c1b 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -269,21 +269,18 @@ static int _vprintf(struct printf_info *info, const c=
har *fmt, va_list va)
 						div_out(info, &num, div);
 				}
 				break;
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP) || _DEBUG
 			case 'p':
-				if (CONFIG_IS_ENABLED(NET) ||
-				    CONFIG_IS_ENABLED(NET_LWIP) || _DEBUG) {
-					pointer(info, fmt, va_arg(va, void *));
-					/*
-					 * Skip this because it pulls in _ctype which is
-					 * 256 bytes, and we don't generally implement
-					 * pointer anyway
-					 */
-					while (isalnum(fmt[0]))
-						fmt++;
-					break;
-				}
-				islong =3D true;
-				/* no break */
+				pointer(info, fmt, va_arg(va, void *));
+				/*
+				 * Skip this because it pulls in _ctype which is
+				 * 256 bytes, and we don't generally implement
+				 * pointer anyway
+				 */
+				while (isalnum(fmt[0]))
+					fmt++;
+				break;
+#endif
 			case 'x':
 				if (islong) {
 					num =3D va_arg(va, unsigned long);
@@ -310,6 +307,8 @@ static int _vprintf(struct printf_info *info, const cha=
r *fmt, va_list va)
 			case '%':
 				out(info, '%');
 			default:
+				out(info, '?');
 				break;
 			}

-michael

--e6ee05f6e2fe5a26e200d4de9e394ca62b09c860a7020402f0ad861cfdc0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ+zg0RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i4/gGA3sF04LHCKEneTK7z3ELDuGcZQxYxefd/
oIx5wjMiTLhrvpeLZf6u49HSp0aoggMoAYDuhz8/VOBvCdHV1Dh8IJzNOrIhjUnG
8rgX6WI43MvZ/3/X+ThwNk0l7Vi1V7ulHDk=
=F221
-----END PGP SIGNATURE-----

--e6ee05f6e2fe5a26e200d4de9e394ca62b09c860a7020402f0ad861cfdc0--
