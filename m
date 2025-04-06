Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F38C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF1482C7C;
	Mon,  7 Apr 2025 00:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BK+gL9/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92AF582C8A; Mon,  7 Apr 2025 00:48:45 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA0782C90
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c12b7af278so2738777fac.0
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743979720; x=1744584520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cd4RYsLYWiRvRcehEI5wzw9ZXJ6FFmiDp+3U/X0Z3a4=;
 b=BK+gL9/VzWL+hLNjSY2XRtrmhu68a2g60PN8f/oUkjU5NE9judA7EFCf4bi42acJUc
 2dQMnqyoS1Y6pIcutxL7RzYIe4hRbmn5rJGR0DCP7g9HD+W8SpxtVefEyle7WCfdoSiE
 srtroIvRUfJNSK3PwqeEL5qmRL8Gc7MyMM3Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743979720; x=1744584520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd4RYsLYWiRvRcehEI5wzw9ZXJ6FFmiDp+3U/X0Z3a4=;
 b=bOr1RnZ6OogoAicB5T4n2T+/3JXoNB1wdMc7NdoPGjHtCKJ+LCc9+VCO+21Ibj9fVe
 A/3OIyyZIGk+Lsl9pgiwzJHpnoAQzvMp7n2+rFgH0gsc/M2tYd/InU5G5dwB9tDcYHh4
 0lUOUFMCNH9kDM3qTg646IPBa0Eh+CfYjtDyHQefw32bCdDVO+Md2J5+WOcChxT1Kuj5
 bydeDVKlpkcr/qADipDjTJVMvXuxCJpaPDnhlAKEBmKT9U/jS36JpfPZjNXbc88PsZGs
 1u2r2Dt9ZqSaDyPGcDMm5uhLOhsyhQAFQi3dJ5yP701v7p9gylOejYRk8z/mDlRUBthm
 7x0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRrXNSzmT+xFugL9+IAjmhAUy3sNf2QdwqVRio+hnjeoRuK8s4+Fp1RtQu2P6vOLl5b5/2TX0=@lists.denx.de
X-Gm-Message-State: AOJu0YxmKtlDDmMQ0JlH1VjmtbDRlN/ONOsWrgUB+cbTzjpm65N2df7E
 GijCuPFhn1AgDHq3X+jF+NIeJXy/cYzx7/mrrX8U4SbsS0uVu06E99qMcUL09MI=
X-Gm-Gg: ASbGncuUekGy7uy/3KQbAcfBoP99TsScOLx+XI658EbRr+TL63ePlt4RkBqwtcez5jO
 fufhWyl5CaiEptMYtuvo1DPtObcPwYSdgiMv8st60BxcCADLwxP2ZAX6knIRU9qurx8Pc7OYD+u
 gRVid6p5pz29A7CKKqDSCjYGKnFyal0rNGthnMTzbIVtFvYmz5SNx4Rw3lKD0d2y4LfwmWVRBl4
 lxRc/cVlT02xpwUdpw/ZYpxheMKv5msxhFGXIdJcx7SBJbEwB67qpCD3mdwuBkEp4gE7uFG7jpi
 G0/zcSVeCv+MqkUOGKooHZa9JsufZR2e3M9vbffQYYJ300PZ7UevtD0rpMYgXu3XxrRiOOp+I7D
 hq+yF6g==
X-Google-Smtp-Source: AGHT+IFtC2JOEYLMcc/0HR071VADHFeY4b5zAy/+AT8DI7TTq0/GJ9eJl+pVE5V+3YuW7IJGTQcG/g==
X-Received: by 2002:a05:6871:7292:b0:2b8:5d9e:d0d9 with SMTP id
 586e51a60fabf-2cc7a595721mr8126103fac.4.1743979720094; 
 Sun, 06 Apr 2025 15:48:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc84b26ebdsm1776032fac.32.2025.04.06.15.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 15:48:39 -0700 (PDT)
Date: Sun, 6 Apr 2025 16:48:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Jonas Karlman <jonas@kwiboo.se>, kever.yang@rock-chips.com,
 sjg@chromium.org, philipp.tomsich@vrull.eu,
 arnaud.patard@collabora.com, quentin.schulz@cherry.de,
 naoki@radxa.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/4] Add support for RAM boot from maskrom mode
Message-ID: <20250406224836.GG5495@bill-the-cat>
References: <20250405153832.1427549-1-jonas@kwiboo.se>
 <8734emy4te.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gkfUlFAm1fK5y/Vh"
Content-Disposition: inline
In-Reply-To: <8734emy4te.fsf@bloch.sibelius.xs4all.nl>
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


--gkfUlFAm1fK5y/Vh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2025 at 06:02:37PM +0200, Mark Kettenis wrote:
> > From: Jonas Karlman <jonas@kwiboo.se>
> > Date: Sat,  5 Apr 2025 15:38:20 +0000
> >=20
> > The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
> > cannot be found in nand/spi/mmc storage.
> >=20
> > In maskrom mode the USB OTG port can accept one of two custom commands.
> >=20
> > Initially a 0x471 command to load TPL into SRAM. After TPL has been
> > executed and it has returned back-to-BROM, a 0x472 command to load SPL
> > into start of DRAM.
> >=20
> > This series adds two binman images that can be used to RAM boot from
> > maskrom mode:
> > - u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
> > - u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
> >   payload with i.e. U-Boot proper, TF-A and FDT.
> >=20
> > These images can be used with rkbin tools/boot_merger to create a loader
> > image to be used with rkdeveloptool or rockusb tools, e.g.:
> >=20
> >   Create loader image:
> >     $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini
> >=20
> >   Boot from maskrom:
> >     $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
> >    or
> >     $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin
> >=20
> > Or directly with tools such as rkflashtool or rkusbboot:
> >=20
> >   $ rkflashtool l < u-boot-rockchip-usb471.bin
> >   $ rkflashtool L < u-boot-rockchip-usb472.bin
> >  or
> >   $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin
>=20
> Hi Jonas,
>=20
> Would be great if you could document this, maybe in
> doc/README.rockchup and/or doc/board/rockchip/rockchip.rst?

I would just note that doc/README.rockchup should have any content not
found under doc/board/rockchip/ migrated there and then removed, thanks!

--=20
Tom

--gkfUlFAm1fK5y/Vh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfzBMQACgkQFHw5/5Y0
tyw0AQv/YbzQ5V5C4sSg3XHCyYq0ake9gNkLXThDxu73i+bF/QeAvDjSV/z3oBGS
AvSXuIDxr/00syL3usaN1MprDGdsEOaBecNSoZMXi107EmzAEnLcL4DysLRyt5xC
GhqZfaWObKYDRzgWbyGDMyL81YByWSKMLUxqBuNm6ZaJ9swQfk9sOsAerTrZG0ow
g04c4ZADUGN4IOB+KyjdTeoijNWnrMCejLGhhm1AX5HFGiK3MXfZu6SDOCBQ4FLg
4eWOxUJiKzogelTUdX5RGQ9HzmySUFFWelK4B5MUXAW71YoIjuNsRKbBP1OLmJfY
BZCOXCL/WUZpPmErlF44sKvBMQ8pFjQjMao43x31l3Cq6UeKxvTvS1fozrFB/Lle
7negAIrr0FYGiYBPzoSF9pE+zUVb9F1x/fagyQg7oRFSVnOnWFEmDRgC1eEtA3WR
PziSTShWuDSQG+Bdl2eqTXRtsFTNkJhr8YD41mnkgSvtubVGF1cYVLzt1MFEmk5m
LbENKbEF
=auQK
-----END PGP SIGNATURE-----

--gkfUlFAm1fK5y/Vh--
