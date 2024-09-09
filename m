Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24234ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 14:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416EA88DE2;
	Mon,  9 Sep 2024 16:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EhvpncmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A01E88E04; Mon,  9 Sep 2024 16:32:43 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D7288DF5
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 16:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-458362e898aso3829901cf.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725892353; x=1726497153; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cEAnBsWGO5kj7E5F3FRucptVxWm7RSIFcRZi451PqmA=;
 b=EhvpncmLDsug6SQg64zgZP85ZpGxqUjW0OyN4Ydt48hmDaceG4kM0he669VuVmZFxe
 S+kwrOX1cpVuFvBjKMy1rUHntYTi2N9QcYjJm9pnQwvjwJ/AeX36lnWfH5KRP1gZl55B
 tThbj10Q5WPRmMlPPjWOHMFomwDGqTfxM9U8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725892353; x=1726497153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEAnBsWGO5kj7E5F3FRucptVxWm7RSIFcRZi451PqmA=;
 b=jMkWTlmz/WJKyVjrOY/rmmrj+sHxy3hbiNGu3PIQdfRN6QFjZrviSA6o9ADGW7E+GQ
 Lc/YrGJppC0w2/URxidPSH22g73kiKPipZPKvNd451ky5YCeOJ9Yz83Q5F29MYW/ep0A
 h1aeGHsgbfh8cuNxuI4Ndx+l8DiTaK4XurTKUUnHDhUAJ5/e+bZIeG2VP/vgR7TnwIXc
 knyJEWMv5YcGAPJ0gaKPv9smy+2mWlHMECq3XELt/8/UzaP0wUE++JTb8RL4AyESLBCA
 UDBzUjJZ4d3FyuV85gmDGttdRO4FlVI/sTZjML9GrGeCGz3fpC0aGPI9ZrZe8XGLFN8W
 VDmQ==
X-Gm-Message-State: AOJu0YzJoNmTVrjBgx1TQuOQujo29asgo2Dzduo0PqJRN4SOCCxVWMtt
 5bqHnmVHphMvcVz5WWc/sziZkxkLADm33lZJ8cnTQ/Wo8g+FBF3rfe0EFj5PhZc=
X-Google-Smtp-Source: AGHT+IGOioQFkhwVLUI5iNr22fkdCtgomCzJ0wW5px/VoLxvOXDH6t5JOAhehTgSly/A5ut8h/jpAw==
X-Received: by 2002:ac8:7f55:0:b0:453:74f7:556a with SMTP id
 d75a77b69052e-4580c6717a8mr111810051cf.7.1725892352817; 
 Mon, 09 Sep 2024 07:32:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e63dc4sm20834421cf.3.2024.09.09.07.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:32:32 -0700 (PDT)
Date: Mon, 9 Sep 2024 08:32:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v10 21/25] Kconfig: fix undefined symbols (g_dnl*) when
 NET_LWIP is default enabled
Message-ID: <20240909143228.GA4252@bill-the-cat>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
 <9462e25d33d93c670a882e6ee329ca7e6668d7ab.1725625913.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H6HdseY6/sPJtE/A"
Content-Disposition: inline
In-Reply-To: <9462e25d33d93c670a882e6ee329ca7e6668d7ab.1725625913.git.jerome.forissier@linaro.org>
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


--H6HdseY6/sPJtE/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 02:33:37PM +0200, Jerome Forissier wrote:

> Fix for link errors on am62px_evm_a53and other platforms when NET_LWIP
> is enabled:
>=20
>  common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to =
`g_dnl_clear_detach
>  [...]
>  common/spl/spl_dfu.c:29:(.text.spl_dfu_cmd+0xb0): undefined reference to=
 `run_usb_dnl_gadget'
>=20
> - DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
> which is implemented in drivers/usb/gadget/g_dnl.c which needs
> USB_GADGET_DOWNLOAD
> - SPL_DFU compiles common/spl/spl_dfu.c which calls run_usb_dnl_gadget()
> which is implemented in common/dfu.c which needs DFU_OVER_USB
>=20
> Therefore add these dependencies to Kconfig.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--H6HdseY6/sPJtE/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbfBvgACgkQFHw5/5Y0
tyyh+wv9Hs4xKWnb5vpRGXIcqFWkZwwXU3dj+REraLgbTItIZvgEgSTC0ohpfk9R
kduOM7LgJgVYmvUgUgdXANEUYTMSba2m6Z0kC8UrCHV1KGC0PjfDvPe42dcBJJAf
petYxTqRDXAg1UnknGQq4Iz1TGsqyTFgyHLMPFhwm2Zg/JDyWAx1uoEXMmlKJ8ff
UkznZ+iaY1HSJZMYnFTIZ3kb8V7aH0/0vArE/RTtVWHuwzK7oZBXo7Ot3qdKP+kn
Q/QB/kY+5a/eqnE4L2WwjC1DvIJU/euELBU3W2u64BF5w06tPMJF4f91ioIOOjW0
ZhWs7tobHtHTMC3p6YplkayTXHTBCcWdZ/Bnd5hFRpOv7pNS7LvSKcZbwXTMpYuR
lzcRQGdXOuY8yDZUpCi/R1s4P+j3NTz+fW1hL/6Y79Dsrcx8LU7/NUuWpH1ZjAit
j5yKimgHTZRaDQrquMW1p3K5YFo9aAPoJi8ZEq/dPEPxnmCI04dNmBW/ucIoYRwQ
N7csowZk
=dzjV
-----END PGP SIGNATURE-----

--H6HdseY6/sPJtE/A--
