Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43689C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B4582B97;
	Fri,  2 May 2025 17:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f+H2LY4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAC4828A2; Fri,  2 May 2025 17:00:43 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8A4828A2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 17:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-603f54a6cb5so1328541eaf.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746198040; x=1746802840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fkdmi3QAX1G+PQcITLL86CLb4y+VTEpRZVLKIOEgR2o=;
 b=f+H2LY4mZs1X8dDPKvQNoIyi1foNBkIYg0IElSpe6dI9pxXcdu2Qmuto/MYgFsyhKY
 V+hed5/3gAvZ7iaIC8QgLSkzPUyCSDuyweerSo8FRPvw8Y+8+B2R1DGk9cWpAaF7Own9
 1oeB79o73fvEow/b/b/wwDEHVJqbu9kAZG1do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746198040; x=1746802840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkdmi3QAX1G+PQcITLL86CLb4y+VTEpRZVLKIOEgR2o=;
 b=am7RkNCSWK4hpZxZ8BnOMDEvUDQzI2JEQ72OoKtKX6MOQeBU1pHgIsr0hmzzEhQmeR
 +Ulgqz9+e8hRPfNZQRPjXfh9L1BaM06Z1fByxPlz5jXnEsy1OH21+SDL+0D3BojXgK7I
 6ob5aDTrdIDC1HMj+6denTS0u5jWsqRzbTbL6UWojdD2Km/nN4PgNDC5gW++K6Vt5wBH
 FHfMHEkOMyd4TwrIJG3Dc8ApXB2Vj93JiQgPI5Z/Uuk3hUBsRU14qJJie60Mj5BXyhRQ
 qnBLbD11fh+OixVxO7CASTM6/bmXajh831xdRuOl7ORnBngGFxpjHSmaZjQbYirsANz5
 ZyVA==
X-Gm-Message-State: AOJu0YwT5zH1rUX+5QqgylJrEmc3fpqzQcvb6L1xPxY3Bi0kzAlaumPV
 w95DRIrCuB8ll9AH3Pfg1db1h+Drg+XDtlRFn2gX17RvDKruNVxnpjWWeil8P0k=
X-Gm-Gg: ASbGncvbK8QhMXuG6bOQkwU8KqXYMgm/VBU7zfL9WKB8dncrGbTfNeIURUv9SFx7hL0
 AkP0Va4mW2Ur1iMqKFKHT9CLg7LZR1lz8cPa533jrUFSzo37PVTemIJCXax8K6665/lp+6syn6P
 MK5yLUl90r8SKNlR5jfhoIsOG/FAxyrzgma1KamnG6t/aP/Nw9qz0GVtQ2WHbiekZ0ybJ4EvWCe
 +HNslLlLswXDKumibVIUoP6gXzh0rKU1UkcFNYWDBKc7waEDGAC3I+jOgwqNtqSsGw2y6sPdTBA
 Vbf2tLKXXfAPmrOpS/HCn6dTSbSDoTfV8eBp9/5N0hIDvVhVIHNTHsevGoMqmQMKZgCqS38EZbA
 XrDNt9Bx59SeJ
X-Google-Smtp-Source: AGHT+IHQIkHXzzGnySsbHHzOmGnCtxhBc4rtpzlcshNH6kQsihVZtC+sPi9A0kO+8hKUAmC/1hMOKA==
X-Received: by 2002:a05:6820:811a:b0:606:85ad:881 with SMTP id
 006d021491bc7-607ee5132dfmr1529677eaf.0.1746198039863; 
 Fri, 02 May 2025 08:00:39 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7d8b7b4sm545585eaf.15.2025.05.02.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:00:39 -0700 (PDT)
Date: Fri, 2 May 2025 09:00:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 00/60] expo: Various features and improvements
Message-ID: <20250502150035.GU1261075@bill-the-cat>
References: <20250502144718.313633-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZWxnFFx29HdefRgi"
Content-Disposition: inline
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
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


--ZWxnFFx29HdefRgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 08:45:58AM -0600, Simon Glass wrote:

> This series collects together some new features for expo to make it more
> useful for boot menus:
>=20
> - measurement and display of multi-line text objects
> - internal alignment for objects (e.g. centred text)
> - editable strings in text fields
> - new 'box' object to draw a rectangle
> - highlighting of menu items, rather than just relying on a pointer
>=20
> Expo's boot menu is restructured so that it is possible to iterate
> through various bootdevs and update the menu as new ones are found. This
> is more in keeping with how bootstd works.
>=20
> A new textedit object is added, intended to provide a simple text
> editor. Future work will complete this.
>=20
> With this series the boot menu has a better layout and appearance.
>=20
> Changes in v2:
> - Add new patch to pass in the video device for cedit_prepare()
> - Add new patch to test rendering a lineedit
> - Add new patch to test editing a lineedit
> - Handle the case of an initially empty string
> - Only check the text objects used by the bootmenu, for now

=2E.. include the 13 part series you asked me if could go in now,
yesterday?

> Simon Glass (60):

60 is far too much for anyone to provide meaningful review.

--=20
Tom

--ZWxnFFx29HdefRgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU3g8ACgkQFHw5/5Y0
tyzb+AwAsLkK+4yK+Q+qpJFqfvrhGfIX6uh/YH4y+ntEg3V4/RVlZ4fd6qSrfcdE
VVbL9sARo9WJqrhQ7wbFXlxIC0TTj/GyH9u7/sDhJscQotcuceLuWehT/yuPAXQV
U0biwJzPMmrl+SMdAaNzijgMt3b21YFrp51T2Urt5gN2/AuHRL3ixXDIZmQWNlTS
uZAJ1VtYRru53tsjGFoIM4oZMcEIJdSZtE43HuZahISJZZFX9pXMO1jQW9eqzZ38
+wQi2exgKJl0LsvLmkpgwPGfQsVpd1uWdGzfm4CT7ejeza862P0oHQ4s2g5Spcqb
kq5XmZinxdO1A5wFXYfO8F+gBOkZXDneFJTKXs5ffEsFQAKiUESJq3uJvlbJMvhN
Bt5w7IghLBLTqhFZD6haaJe7diTPhKPqPVVf29wTRIB/9TAH+fT92IcwNdyCZYOR
doE5TiWGWe5fY4L9D8u3CiWJYE0Sa6C8EPgfwL4t9mdF+u0epnZp/M7R02RvGJsV
R2GX67nH
=QKKT
-----END PGP SIGNATURE-----

--ZWxnFFx29HdefRgi--
