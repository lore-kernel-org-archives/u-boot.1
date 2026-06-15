Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8344DCD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 23:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A431846CF;
	Tue, 16 Jun 2026 01:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EnBm14xz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B271846B0; Mon, 15 Jun 2026 18:22:59 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F136384105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 18:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e6b5c374e5so3629728a34.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781540574; x=1782145374; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nxrrOS0I2JaKdX+MPovR71VYCMIMqrzn97l9KiFZ8X0=;
 b=EnBm14xzqMTFX9qvNuyb//0nC2dd3Svzo7/AMQCQE03kNM2oHvALyCjlnCWeWObRNb
 15bz4Lh0EmlW4n3GdCG7bompgF33L4Cdc0i89GcAQt2p9rrkWCr8XM8SzMZDnmB769GY
 VxTmZ0w5sYp/Bv4nPLGtFIQCKfKWh098qleow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781540574; x=1782145374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxrrOS0I2JaKdX+MPovR71VYCMIMqrzn97l9KiFZ8X0=;
 b=j3LRzaGUTIELFxNNTBb42+NWocuI7PCHVT2yNmtqzEVs7TQCZNYhz5S4wUt/Onil7G
 NR3xTDcwHbK24GDFBu+2Dtlmasj1OZprFBpTnndomHGVTdeiT+c1vzHUMOlz6Z4kR9mP
 QAYSaOccN/K4g9+ZGGS92dxrT2NDMatmrt0B3nkRYRIEr6yeZb+rBCilYFXMZeWQBnCw
 P+SR4FT2a3KxXssr7XxLVBMkHIwrGDdieVAc9FbThMX4/gLBTIfxP9yKaX16/jWjoeRt
 3C35IUowlg05grA53gq5KYr1dn+rIXHBO44vbdPzubgmG2Pe5z5Wq3RTJ/b4Xhimicv3
 0k1Q==
X-Gm-Message-State: AOJu0YzSZ5pncIHFa3/ZzD/elOBm6NuOCLZ3JGrCPB/7AypVADFtai6M
 jYjar9r9Z55X9n2t3tWcYXhU9fucGMcqjPHqh7oNkILpVFmPJCwEHuyS5iyS11+aB3A=
X-Gm-Gg: Acq92OHITau2dwcsX+Ue2b3unSQqCBaank+IM1ZaucCL2Bh4ysUq3ak3p5LU5y5LM6W
 pjhzzJexwczxq/WWxNzoYCStr7G3TPsiD5UAyW9ZUNcXWrZV54mMCagxbOIb5LzHRIQaaow+MY3
 d7G2LM8Fm+WjwN6JhuZBwSS30enmXNNrj835DMWGVAAMjFmE1YBbrYEqZ+90NRwRMwQZUXjx8yR
 UWOzZ96qVq5+1+sFL1Fuggfz4aj3aXUVWqCIOFKILYyI9XBOlU8wTG1Qv6C7ev46N+EzlydEHWs
 7fizibKbGDoZetwZJ7vqIUZO0zckIyNzluMEIY+xJZT0NMOPOGgSSZB5VEiAHwtwB3obP38EkXn
 6wxTV5rUn8LqemAux6YBDKTycb9S0K6Vr3rS0DcZ3uSVnpJjfw6MuzVgQjIjBcLrMvTasBXEDe2
 pliFHHieOq+B1llEqgWrM/BRzSUEEFr3kCXAFwnzOAnYa0qJTKpdSZIQ8xpmM5/yWJhaVau7WS3
 v3sUQ9lqztn21r9Xx102VeW/+oILrUbY8sEaNy4zLiSuZLXq00=
X-Received: by 2002:a05:6830:1613:b0:7de:c870:46d4 with SMTP id
 46e09a7af769-7e8fc7fb48emr64089a34.1.1781540573737; 
 Mon, 15 Jun 2026 09:22:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6b8624sm4326216a34.16.2026.06.15.09.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:22:53 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:22:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 01/14] spl: ufs: rename SPL_UFS_SUPPORT config to
 SPL_UFS
Message-ID: <20260615162247.GY382693@bill-the-cat>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
 <20260615-spl_ufs-v3-1-360bceb29596@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1D7o3h+zlvfA4xaf"
Content-Disposition: inline
In-Reply-To: <20260615-spl_ufs-v3-1-360bceb29596@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 16 Jun 2026 01:14:20 +0200
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


--1D7o3h+zlvfA4xaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:29:57PM +0530, Balaji Selvanathan wrote:

> Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
> the naming convention used by other SPL storage drivers (e.g.,
> SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
> $(PHASE_) prefix macro in Makefiles, allowing uniform use of
> CONFIG_$(PHASE_)UFS across SPL and TPL build rules.
>=20
> Remove the unnecessary `depends on UFS` from SPL_UFS. This dependency
> is not needed because SPL_UFS is a build-time option that can be
> independently controlled.

The problem is that in drivers/ufs/Makefile we have:
obj-$(CONFIG_UFS) +=3D ufs-uclass.o

So we only get the uclass with CONFIG_UFS=3Dy. Can you build a boot a
CONFIG_UFS=3Dy CONFIG_SPL_UFS=3Dy target with your series? I expect there's
problems.

[snip]
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba33281..86a54b5f332 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -73,7 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) +=3D usb/host/
>  obj-$(CONFIG_SPL_SATA) +=3D ata/ scsi/
>  obj-$(CONFIG_SPL_LEGACY_BLOCK) +=3D block/
>  obj-$(CONFIG_SPL_THERMAL) +=3D thermal/
> -obj-$(CONFIG_SPL_UFS_SUPPORT) +=3D scsi/ ufs/
> +obj-$(CONFIG_SPL_UFS) +=3D scsi/ ufs/
> =20
>  endif
>  endif

This isn't great, and I'd like to see the relevant part of the Makefile
itself cleaned up to be:
obj-$(CONFIG_$(PHASE_)UFS)) +=3D scsi/ ufs/
(and so drop the unconditional obj-y +=3D ufs).

I don't see anyone upstream yet enabling SPL_UFS_SUPPORT so there's
likely some more general Kconfig updates / additions needed here.

--=20
Tom

--1D7o3h+zlvfA4xaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajAm1AAKCRAr4qD1Cr/k
CtRzAP9ngNFmCwn95wimVFHJhaw8Qc3LIx002w2vyHxO99EvTQEAgnATE8UK4fVJ
5Lq6jp7YtC4DGKfCKNYsW7CF+xmV7AI=
=fSVr
-----END PGP SIGNATURE-----

--1D7o3h+zlvfA4xaf--
