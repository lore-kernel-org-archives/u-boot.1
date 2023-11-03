Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5C5C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 20:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A41870E1;
	Fri,  3 Nov 2023 21:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HwZ8ELjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F76870DF; Fri,  3 Nov 2023 21:20:55 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591DA87211
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 21:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b3f6dd612cso1384639b6e.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699042852; x=1699647652; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7kqNfSOnAtztPwTXNe/vYsHkJB7RAUZiNvcvo705rgg=;
 b=HwZ8ELjcXD5xOwMqy1skk0yt56iqA+vBNQOSskFNvipsdlqV89DhiEyxwZ4dQJnbLY
 KTfD/bL4LdnimS2slrgIsonskOBKoz8uzQiqLAIsoL31Rc8cx2ocJ5tRtu9Y/6nIzRg8
 C02wFwP8620d+Q3KEJsvGVnePcWmrCr7yQnGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699042852; x=1699647652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kqNfSOnAtztPwTXNe/vYsHkJB7RAUZiNvcvo705rgg=;
 b=ldhOSG/FxCUf0e732rViB6CG5fGPMctKexMgoveFSwVSK3ySAl1WpMTscu7679aSRT
 zFAAgzX+WbqABiQSbsWCzAo2EjIJeEv3oMcw/vbRV8cJ8uMf2AWDyjUzQNkyxQKR20uN
 Nqp8bKdb7FH3ZOM5V3Gi5/zkLCxGrGKQM5ZNhYkyA09QUbd73//dGUWmzHRQ71UlFDNj
 rbw7CjKChHPwGYUiRFsQ7ivFUaFKMByBcz6ozgFa7B5Q14Xx4W1WzEKTUHOAYVweVW/C
 sulvE8Mm6xwFQs7XKyrklbuSHYewxQcxqa5Ui/CxT+Vt2phcEsgZlmXkLPjyHJ/6Krue
 8mtQ==
X-Gm-Message-State: AOJu0YzWU539DI6MI0unQG+DNquaChxV9ggw9xVX3FG64gTHAC9DZsIa
 hpHT47sMSX/l9jFLW3f2f0ALUw==
X-Google-Smtp-Source: AGHT+IEQvAuOuIkQOGFNThdTDhrrefGiA9YcDKn3ZEGHgDW8GU4g3D3WGw7M3eyPcYvQpzW1uVnqrw==
X-Received: by 2002:aca:1a06:0:b0:3a8:74bf:8977 with SMTP id
 a6-20020aca1a06000000b003a874bf8977mr21054989oia.56.1699042851882; 
 Fri, 03 Nov 2023 13:20:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05620a031000b0076ce061f44dsm1030142qkm.25.2023.11.03.13.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 13:20:51 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:20:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 14/15] board: ti: Add j721e_beagleboneai64_* config
 fragments and env file
Message-ID: <20231103202049.GV496310@bill-the-cat>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-15-nm@ti.com>
 <f0f4b6af-9831-4231-8316-1e0b0dd2dab2@ti.com>
 <20231103190629.flhz4cr5wyjyym2g@remix>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j1V8Xc+ipJkidZwO"
Content-Disposition: inline
In-Reply-To: <20231103190629.flhz4cr5wyjyym2g@remix>
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


--j1V8Xc+ipJkidZwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 02:06:29PM -0500, Nishanth Menon wrote:
> On 13:51-20231103, Andrew Davis wrote:
> > On 11/2/23 7:38 PM, Nishanth Menon wrote:
> > > Add defconfig fragments for J721E based BeagleBone AI-64 and
> > > corresponding customized environment.
> > >=20
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > >   board/ti/j721e/beagleboneai64.env        | 19 ++++++++
> > >   board/ti/j721e/beagleboneai64_a72.config | 55 +++++++++++++++++++++=
+++
> > >   board/ti/j721e/beagleboneai64_r5.config  | 19 ++++++++
> >=20
> > Beagle boards are not TI boards, add the board support to board/beagle/
>=20
> Huh, why bring in commercials and organization changes here? am335x
> and am62 are under the TI umbrella.
>=20
> $ git grep beagle board/|cut -d ':' -f1|sort -u
> board/ti/am335x/board.c
> board/ti/am335x/board.h
> board/ti/am57xx/board.c
> board/ti/am62x/beagleplay_a53.config
> board/ti/am62x/beagleplay_r5.config
> board/ti/am62x/MAINTAINERS
> board/ti/beagle/beagle.c
> board/ti/beagle/Kconfig
> board/ti/beagle/led.c
> board/ti/beagle/MAINTAINERS
> board/ti/beagle/Makefile
> board/ti/j721e/beagleboneai64_a72.config
> board/ti/j721e/beagleboneai64_r5.config
> board/ti/j721e/MAINTAINERS
> board/timll/devkit8000/README

So, yeah, we've been bad about this historically for a few kinds of
reasons, but it makes more sense now to have board/beagle/{x,y,z} than
it does to have board/ti/... for these platforms.

--=20
Tom

--j1V8Xc+ipJkidZwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFViEACgkQFHw5/5Y0
tyzmjQwAm1KSwuMuMa5QZSMhIYeMemOebcQxQQS8VQdMiRyuQsUdQqNyWjsUvrKD
scV5kGl1QJtg3UvXwMQJzY5MEV6oK06/I//zqmL99N7VCqNRFNfm3rev1CZbKacU
5A1rajNTmDyVS5twqyMI451JPyWIIhwfrZke5CXwayEKjvb1OXNRl+LARnFBme9A
ukX2ii57/mqdmPieLAigaTAcOVPL+Ux1wcA79hHQMQFhou5DNUdRKn4RA+HW699s
oHrISZTJsoboHKL7kjF6EcLUJjLsMrrErMCz6O9ux4Fgd54dKiMXFUUaticHwh+j
2oIG7vvPcRdjMBDP+yMJEMH0845wY/cxnNP60Qxosn1fOSGSDn7yESQ7m1s9lTzV
8CNV1+63GOL+Ritrr2TQ3tOhsQJgzpSgEX9EMMJqeYudOZ7uTFOO5gcgVKcwKHL5
i5MjFTCZd+uw+Fd4nmv1CCqzIJgKaS2Zu4ZkWXjUI1XkT1axyLPX19fVwk5/dUdF
Uoi5JabO
=FAqB
-----END PGP SIGNATURE-----

--j1V8Xc+ipJkidZwO--
