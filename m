Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0789EE81BCB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 14:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304A6839A5;
	Mon,  9 Feb 2026 15:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h8NERxVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F16839D5; Mon,  9 Feb 2026 15:30:12 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E37F8341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 15:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45c733ccc32so2985602b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 06:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770647409; x=1771252209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hH40kMpfiq8b26OakfKTx41ubqFdSG/8AuhFjjN6WmY=;
 b=h8NERxVEDLV6zTuoBozUP4mI9VnYo0ejGSHuw9YvvTkykHVddAXaiBevHZl+nSeeWU
 ClfuCLqBPUq99bl5+A+FFagDeQeB3t/3IMKPAtwZaCZ8AXTc25S78SFJJMupN8TYs7uN
 wOaWgs0VIZmHHqDhHb3A6fHzuuDZTJnIXp9vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770647409; x=1771252209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hH40kMpfiq8b26OakfKTx41ubqFdSG/8AuhFjjN6WmY=;
 b=mv2oDqyGWftBt9kgnRlhTXzEBz/qutNMTb+It2CE9Z+KhcRFVb7yICohvanvKzhWe+
 64/rPtkfQ0GxgAvCJ6JeUBuWhWS7oQKpNpjOyYlYcUb25oYd7w+9Ox4DPI06u7795tka
 fOXld4NKVnHwPjmjmj5RAoPB2bZJXbTYmME0VDnt3QzUwCkrFQov4sq7T3cWo3fpRGeH
 mbpDRGt0n1on1xAsq+OsmGekiKacPv1/7MBXg4KGW7ZGpNeW7xUQrpJub589ToK2vGhj
 TZkKYQyo4t8qoUDPZtBXoGTXsmnJJSjdzLC5G5i01fjSHJRJSPggGl6NKbLbFL8e62/i
 wupQ==
X-Gm-Message-State: AOJu0Yyy9DU8R3Hk5lIQyUGbZEKwPnbcDgBdd4LtOKaIPsxqdgTC38jS
 CWSXoEACUXsm7s9WQHAENgj67o8eDeET0jzK5IHDhhHdjchWJzHdxBt/fzLBdT29fas=
X-Gm-Gg: AZuq6aJkn/geauTaXJoMqxR5kylbsT+0Ddci0XLGg6iI7q7Pbw+Ze/9W2ulVjE09b8T
 FdKCEG50w5DK8VqCho2+9PaA4wWXTyNzl9lHjkJhDHSNB27zm+68yr/UzVKtnj6jFbGClyoot4s
 KaAD5f5E1xnRFnhD/hS8axwiMBz9qlcL8cnVP9gcXR08x3qu/k2G0VZfHpRo2PfOh4cgA7qkQrE
 6+MKjZctug3I78JxGDmxb0+3dAqj2SGEDr3ezKtolcDyVc9VaYtLZOSutpAyYk5PJCR3LEklEmP
 mRzxPgP895AuXthPFjAbgE/q+SD//3GJF9hKWGufzTArGus87c9rsBEpJdC2zqoP1B58nh0lro3
 0qHpw6XPB8kQqLZ79UlpGdE1wz2DyOpBlpDx2jbMkrPIi1qIL38zGool7x8vFOKVRusQdLbDXJU
 k+CZnACa41TfHhjR/xQYxHTUF3tYeC+VSd59S/7KSXF3HSm++yHsmoafR+qkQUfPJ7tZo7i7asQ
 ENu8YrwPcDnZCy1ZrS4RMXbPF7mya0wtp4lMkE=
X-Received: by 2002:a05:6808:640f:b0:45f:131b:db33 with SMTP id
 5614622812f47-462fc9d27b5mr5896685b6e.4.1770647408502; 
 Mon, 09 Feb 2026 06:30:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99643fc8sm7909329fac.14.2026.02.09.06.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 06:30:07 -0800 (PST)
Date: Mon, 9 Feb 2026 08:30:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>
Cc: u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>,
 Phil Phil Sutter <phil@nwl.cc>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Subject: Re: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB
 without separate BSS
Message-ID: <20260209143005.GF2603314@bill-the-cat>
References: <20260130183635.2612933-1-trini@konsulko.com>
 <20260205234158.3768337-1-trini@konsulko.com>
 <CABdDSeWvfd2vK2ykQb12YrXreaq7oiuHDktgrCm+c94_6aj=Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q0Zs92JCB4M9mXqx"
Content-Disposition: inline
In-Reply-To: <CABdDSeWvfd2vK2ykQb12YrXreaq7oiuHDktgrCm+c94_6aj=Mg@mail.gmail.com>
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


--q0Zs92JCB4M9mXqx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 07:02:07PM -0500, Greg Malysa wrote:
> Hi Tom,
>=20
> On Thu, Feb 5, 2026 at 6:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > Which means second, 64bit ARM platforms. With the exception of:
> > socfpga_agilex7m socfpga_n5x_atf socfpga_n5x_vab socfpga_stratix10_atf
> > all ARM64 SPL_FRAMEWORK using platforms use the
> > arch/arm/cpu/armv8/u-boot-spl.lds explicitly. These other ones set
> > CONFIG_SPL_LDSCRIPT to a non-existant file and then fall back to using
> > arch/arm/cpu/armv8/u-boot-spl.lds. There are only 4 platforms which
> > don't use a separate BSS section and so could trip up the above as well:
> > r8a779g0_whitehawk r8a779g3_sparrowhawk sc598-som-ezkit-spl sc598-som-e=
zlite-spl
> > I have inspected the Renesas platforms manually, and I'm a little unsure
> > how this case works on the two sc598 platforms.
>=20
> Do you recommend using SPL_SEPARATE_BSS on our platform? After power
> on, the sc598 has 2 MB of SRAM available starting at 0x20000000 which
> we treat as just a single block of memory to use for all of SPL
> operation, so we don't have any requirement to do something like a
> bare bones DDR initialization before using it as our main memory for
> SPL, so it didn't seem necessary to enable. The boot ROM has some
> guidelines on where it will place its stack, so we restrict SPL to the
> first 192 KB currently but this can easily be expanded. I'm not sure
> if I should admit to it, but some decisions on Kconfigs were made 4
> years ago as an arbitrary choice during our initial bringup and then
> were not reviewed because things were working.
>=20
> Either way, works for me on the sc598 + ezkit. There's no reason for
> it to fail on the ezlite in that case either.

So SPL_SEPARATE_BSS is for when the BSS can be easily put in SDRAM
instead. It's not better or worse than SRAM, it just depends on the
system constraints. I only called these two platforms out because I
don't actually see where the dtb comes from and so couldn't check the
alignment and location matched.

--=20
Tom

--q0Zs92JCB4M9mXqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYnvbQAKCRAr4qD1Cr/k
Ct19AP9YlXd3qihz4KISyKDJsZG6MAVLH9jlErLldAoHWJ99LgD9HZmgZNFAB6r7
eqT45q9EPzktxt4KZcjKeP72Fn25mQ0=
=ZeYt
-----END PGP SIGNATURE-----

--q0Zs92JCB4M9mXqx--
