Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D18C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE543800C1;
	Sun, 30 Mar 2025 16:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DuVT04W/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5FAA81D3B; Sun, 30 Mar 2025 16:47:19 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1800280050
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-60208b7a6d6so1089619eaf.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743346033; x=1743950833; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zL+JBZfZ6MoWu7nA7USe+UHw4QZgJfbqXYOWC/Sr+7g=;
 b=DuVT04W/IDvaen+EMeQLahHy6MUCmcCuwiaochRtRwYmYXnySolJjdqyAbedPMthNh
 SZAXyAysNoX6g9N9n/e4l9Tjs3Nvk3uPXy/dnInDv4PxZ2u5NIgvaZVnUISQrXyJTqj1
 X8KBcSDxxyEHh3Lq/wTvW1QWYo3pUu536seJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743346033; x=1743950833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zL+JBZfZ6MoWu7nA7USe+UHw4QZgJfbqXYOWC/Sr+7g=;
 b=Vzqw7BWjP8eoJoN108zBObHBEvcYnA5lKRAb5XeaNr8fnNhMhvzFPlAMt7ZqM6bmxr
 qpa6IGMJQ+rSI3Q3It/idQDGtE6uSmh4HdwW2+n3x48DRUjciSSSXR4zkxqNvYP88TME
 FpkgGb6faARjPsJ2Vmzd/Rmr59U2gZ4bRoVuMxYyekGpbLgUCpoycZvpsJt/6Ultb2Xq
 dVwDuC34aJQKMfSqdGZ1BKdqB8cNp5lQASARhdPpCZ/NQb3jY9BCU2RrfLE+kqaHXb+O
 AinIMVEfitH6a5eh25AL2HzTvcjaWKNxKEvCx96zvpq0VTGOldwhkm/3vWNOb1SfZrcd
 dqLA==
X-Gm-Message-State: AOJu0YxWuPgcdHOqvE5CxkULOFJ/tphjM/5PAeoa/t6GV54usoJGJEZy
 CNQcZT6QL/zOVpI25rWFU14GoDJSkP2KrDdGBs05GxRzvSgakUSxOMnOD61smXw=
X-Gm-Gg: ASbGncsqUDJeRwUxn/JYijDxeW2po3MOFseoqHGBZNxLjrFcW+k5qLkmVy28uZWUJ0u
 VwEmYH54WSeQrEfO2Cggl0tptZPhhfQLfJEuGoiuI2+VJSp8EmcZL5+hB+FP59vACPRHoCzs7wo
 O0a5f4+nFiLZFce/1G4mL2Sg1Mr8VGGm66zoSjhFZBjm1FT5Ks62ZKmbhJlBMgPB3ls5KXhvO0c
 SdfUi3oEKiYcYBfjs8+PzkXOb+66H87SSNmta+1SZg1AHxc1bwPlOL+8mD2JzMluqt6Egp1Jb0d
 qaXogggXIlPswWoZ66gPg1M6T64CcPFuJQzjnPrpOqD9aG8RK72IJPEGglYpTMg4nrF8iB0dosC
 60zdwLw==
X-Google-Smtp-Source: AGHT+IHIxz5sX6s8gUOCdT8B2SI7+VY600hYx7RsFo5JZmqhBiRH0gb2FpX9oPn48rJc5wUipCQ75w==
X-Received: by 2002:a05:6820:c88:b0:602:7744:6815 with SMTP id
 006d021491bc7-60290c1161amr3377075eaf.0.1743346033663; 
 Sun, 30 Mar 2025 07:47:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602844ff89esm1134279eaf.9.2025.03.30.07.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:47:12 -0700 (PDT)
Date: Sun, 30 Mar 2025 08:47:09 -0600
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
Message-ID: <20250330144709.GR93000@bill-the-cat>
References: <20250328130713.2612648-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U0nIamHe3sGB7e7v"
Content-Disposition: inline
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
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


--U0nIamHe3sGB7e7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 07:05:47AM -0600, Simon Glass wrote:

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

Did I already say this for v2 and forget? It looks like you forgot,
again, to split the expo stuff out from everything else, which others
might review.

[snip]
> base-commit: 37ef92a972663c6de1b81d24d2ca5cfd664fc6df
> branch: schd2

Of course, not being on top of mainline, no one should spend much time
on this anyhow.

--=20
Tom

--U0nIamHe3sGB7e7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfpWW0ACgkQFHw5/5Y0
tyzK4wv9Fda+lO+Ccy9GIa+UeOBHNclcg76Pf0z5Rc2IdzdADczaa4zGDoNAcU1H
jR2igPhysDWRdYzUvUweRoEY96i+wE5eDSSoiSb3yCiBHlQbRKiWjyBQ0m9lYLaO
+zcFQyw0Ss7m4lB4doQkfxu3t9LL1ojg5AI69NKxYjt8lKzAPMJVgkcbj7SZ+tby
05nKjYRWlzGEW9p/sEIhVe3h1CkpdFEJ1g2FOJNxT3KT3HyaE2OyXZsZAGfRvWME
6p81Wejmu1q9EpyjiBDByqSF99Mja5mI8NifYAbg+xd705FGJVM3/YXb+npZc5Ej
f8bHgF7r7MLXNZiUlEIt73PlD+O68ZJq16ePmS8/2xtzokml7iRsS19MZxIqG3gD
rG5UeFqna/40TXb8U+lMIcgekrtBugMfz7yPGJapUTaVRgjfdToR9EK4Z4hMcmjL
jXRAgULImm8ea4bGF3W7tz/nHHVOQXhEB2Gpa7+P8UwFucmN1Tyo+DoCq0sWRMk9
EG3bPDDM
=/PtW
-----END PGP SIGNATURE-----

--U0nIamHe3sGB7e7v--
