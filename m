Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D50BC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 14:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF8BD803DF;
	Mon,  2 Jun 2025 16:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GwPNkP5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4EE580BAE; Mon,  2 Jun 2025 16:57:23 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361828006D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 16:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-408d7e2ad03so596616b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748876240; x=1749481040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+1q7J03xLWWtK3Tkt3J8MLQp7MQfsLIEhfCN6N7FrO8=;
 b=GwPNkP5lt/JsQTkeGu+7wt5s0MmGmbgmWz00nAMIEwN395kw1E5umiERxGMYI2cPpl
 R0a8uKsCpA+N7wfitMAlo6Glg3uXtjxxY3uPO90FR9Jw4CJu7Tv9PKQX8TTNdP6FoFHH
 c1LoVLcBvX1TR0D/wT0wnj9tmwVt6fT1RYpJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748876240; x=1749481040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1q7J03xLWWtK3Tkt3J8MLQp7MQfsLIEhfCN6N7FrO8=;
 b=GL3LDX2EkusVjyiPzhykkihtDAwCmU0zkb8nt8T3EWASl20f7fxyn8yRGxsPi5xoIH
 oAFXD0Rgc3cU3IXTMAWMy6v2Kom5TEvwSW1zs3Jud34fR8c1hDeS6onpmojdt711aegK
 JK7pLValpo4VfPvbrvHtOOiUrUM6UEe8ELecYWtZ9oqRHRw9vtNwSr6tR5/96wdbLBGx
 163k8QgrbqbtYsUZzO2SYZCdBT8okj1OAQ31uJIPIhRKdpH1xavGtK2cwmnKIcuyMuUa
 cdFLDyrJBX2XRUbCO7nNL0Yxn0fvLmpBH+HauQPCU0hXN5TMjtZBaXVcRc9B3y9WDnpE
 Eb8w==
X-Gm-Message-State: AOJu0YwXSstQcPwhmYxbZd/tOq/hh9b6DXn4MyANEZIOOH8JiPjmvJFZ
 /e33E7rtKB67QfmpLUa12n6mlviz6H8BNISd31cJwvPQkl8MIHSygXg5IvZJkkxxLO0=
X-Gm-Gg: ASbGnctfWq7wtqQdB74eup37Gimh/nlF2zdzxN0L9haw/i/qxj/mGHGtI4B7L9sNBxW
 dRDASeBwrZxJgfU/SbAB+6iD1aVvDpsKwBun4Chy9faZHulOfcOSrlatQiZeSzVVZww2mUi1j+/
 /YWqW30CVB134fwDPwWL0BCLNIMoTYjdSnGU0TZ8e2zQmIQ4SuC/Z857TApHX0w36b2sdt0iYHP
 uEq21oA8xuhXKwkBYq1iA7610hOvtSARntSb2+wxfEn9HU8PScVa+89eLJvIauprOmzDXR9el5a
 6L8bt9gOhVHo8VqUUvMDI7D2t2vGvyb0wUSm4Xrcyqk1NELTOVC5AHAsJARU9WjSD1uadHgfZQh
 C5b53oMQu95RNRH9glxxsNs6dI9bur/9oGg==
X-Google-Smtp-Source: AGHT+IFysSINy98RCaHRVbFcWV6Q+LXk6XWKlUPHIN3tdJHTqiwOnIqsXfV5/ASg/lD/ZI/a3vTXLw==
X-Received: by 2002:a05:6808:6b89:b0:407:a47e:6e5c with SMTP id
 5614622812f47-407a47e7654mr6703863b6e.5.1748876239880; 
 Mon, 02 Jun 2025 07:57:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8fedsm1466395b6e.34.2025.06.02.07.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 07:57:19 -0700 (PDT)
Date: Mon, 2 Jun 2025 08:57:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
Subject: Re: [PATCH] atmel: Remove local <dt-bindings/pinctrl/at91.h>
Message-ID: <20250602145716.GX100073@bill-the-cat>
References: <20250528000118.3002916-1-trini@konsulko.com>
 <72a265ca-d5e7-40ca-b05f-5a3cf8f0f0c8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3VYLsGOqUsyqKEiN"
Content-Disposition: inline
In-Reply-To: <72a265ca-d5e7-40ca-b05f-5a3cf8f0f0c8@linaro.org>
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


--3VYLsGOqUsyqKEiN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 03:04:54PM +0300, Eugen Hristev wrote:
>=20
>=20
> On 5/28/25 03:01, Tom Rini wrote:
> > We have this binding file in both include/dt-bindings/ and
> > dts/upstream/include/dt-bindings. These files are identical save for the
> > fact that we do not have commit adb2424d0d05 ("dt-bindings: clock: add
> > clock definitions for Ralink SoCs") from the kernel applied. However,
> > this change is rather important and should not have been omitted here
> > most likely. Remove our local copy to get in sync with upstream now.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Eugen Hristev <eugen.hristev@linaro.org>
> > Cc: Mihai Sain <mihai.sain@microchip.com>
> >=20
> > The full kernel commit log is at
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D0b3292852863215825f88905b9dbafc3101e1d7e
> > and so this sounds very important. Please let me know if this should go
> > in master for v2025.07 (or Eugen, please pick it and send a PR). Thanks!
>=20
> Hi Tom,
>=20
> I do not see the connection with the Ralink SoCs. Maybe wrong commit
> referenced ?

Erm, the kernel link for me is "pinctrl: at91: Enable slewrate by
default on SAM9X60".

> Anyway, on the slewrate bits, as of today we have DIS=3D=3D0 and ENA=3D=
=3D1 and
> the driver treats them the same way. Hence DTs with DIS flag will have
> the bit erased in the register
>=20
> With the kernel bindings file, DIS=3D=3D1 and ENA=3D=3D0, but the driver =
still
> considers DIS=3D=3D0 and ENA=3D=3D1 , so the DTs that have DIS as flags w=
ill get
> the bit written in the register.
>=20
> If we also port the driver patch then the driver will also consider
> DIS=3D=3D1 and ENA=3D=3D0 , so the DTs with DIS flag will get the bit wri=
tten in
> the register.
>=20
> So there is an important change by changing the bits values, as the
> register eventually ends up with a different value.
> The driver patch apparently just interprets the DIS/ENA bits
> differently, but the end result is the same
>=20
> Please correct me if my logic is wrong.
>=20
> I would also believe testing on the sam9x60 would be required for the
> slew rate change. From what I remember back then, slew rate change was
> not needed in Uboot, but I might be wrong.

So, there's I guess two parts to all of this. First, yes it would be
good to test this change on real hardware and make sure things work as
expected. Second, yes, it looks like we need to make the parallel change
in drivers/pinctrl/pinctrl-at91.c (to match what the kernel did at the
time too) and we can't just remove the old binding file we need to
update them at the same time (since long term we need to remove all of
the old kernel dts stuff).  The final thing is that it really is
important to get them in sync as it's valid to pass our device tree to
the kernel to use. Can you take care of the changes here?  I don't have
hardware to test on, thanks.

--=20
Tom

--3VYLsGOqUsyqKEiN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg9u8wACgkQFHw5/5Y0
tyx3MQv/UhItx5yrd2F59ikik+XCR7ueMNlTOvFsdpz0hSW5OoQCuyr4Xn9xkQBX
Pd3d8/GuYHxbOnfaRvAS9CEo0QgvjMUpGqzYIh+mNEOIjxTtQuaIRxhbflh4Mqob
JeTJyFV7kFct7K2mm6oHZF8vsnSAkx2CjUIm0h1xzeJguF8Au2/nMYAcQve1XH/X
AjPZ393mwz1X5Q3IWdBtG/3tYOm2Oef26Ve2d82/a7ficFlsWodXVKfY2k3W6BIS
SwIdBuP+C4N076ODemdcQcC0KtUk4scrCh7BA3YXr9192F4qpP2wNlkzqcw63Bho
8kk4NMcdPdKyXbe69dohQPHLTDIyZs307qh1YPJpnETqLpKgPsr2+GOu7+IqFcI9
LFuR1xsSm5JptFNQs+mfjt9lW+w41KWhGkgqCyskee8xwainrF8qYpx7o3vDBTZ0
cuP7n7qk7eX6RgJo1nwlwcx9owezzxS4PsSvmo1bZy4jgMTRqzbWbldGN23Xu3gW
1K+8xYNO
=/DWW
-----END PGP SIGNATURE-----

--3VYLsGOqUsyqKEiN--
