Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73772C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 23:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E4088207;
	Fri, 12 Apr 2024 01:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sDP8HaQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001EE88211; Fri, 12 Apr 2024 01:58:37 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CB588137
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-61871ad6cabso3630267b3.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712879914; x=1713484714; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IWpY3yM1Dp+mhEtsdrYAC9H0XyZl3DZvSprCmh384RA=;
 b=sDP8HaQPQGTzMISFhyFZwL9dJW7DcvGPp3CszzLU2Hy9NrBxnD5eoekNR1VzAdm/1K
 jK1OfA+I4bECalE6pH01M2ZWOB7D5TgPY82WYJBFw4WK4Rc17zNoT8L2ScSeju+ohLbp
 OC92z3W63/z8OYlhgHhFz0YRUpyA6bQH1eBB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712879914; x=1713484714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWpY3yM1Dp+mhEtsdrYAC9H0XyZl3DZvSprCmh384RA=;
 b=w/SQhP5Euhy5ETp4V+EdJMBLoYRXuS8fdLKKhNrvXLAnrT8ARP71u4xbHLlnyX9hnM
 a78q5JsR1GRZ8yKgXNui3tpjKMaBR56LYolkDvBS26ZDm0ax+c7XSntV/PFARIDlox6S
 cUhgZjeqIXGnO2fBQMykAnUKY+0Vk2mSUcTFM9LbjgK0zSh77xzx/WTAMEZHORWpcNv7
 N/0jC9msSnKIjrdgYjVr60CmBwaCDP9k031pym7b2lk7Ihzj2r+6TV3EJ3xCC3dvABq1
 FsrHHpXvEKWWqKiErBBaQphQDkC86lWjDO6rHpRpWKfnIx0jF3ud52sHFVFYQiWaWaCk
 hS1Q==
X-Gm-Message-State: AOJu0Yzq39EUcszp5OPWSFcF5w0hNGhv7YV1H2LpAcO4G7Zaw4ZohIcJ
 rCHv8SmkaJLWYiucn1ej+9O97Z2bo+slrq3ZWUK8Yl4caF5882ORA8/C0dCDe34=
X-Google-Smtp-Source: AGHT+IGoOfrd26Qg07aSUs4Ri+ouBG5zcra81hZds7QCVG0J28mdvhMqgeQowY2sqgK9rU8DcHmvwA==
X-Received: by 2002:a25:ae17:0:b0:dc2:65da:d3af with SMTP id
 a23-20020a25ae17000000b00dc265dad3afmr939303ybj.65.1712879913918; 
 Thu, 11 Apr 2024 16:58:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 a5-20020a0562140c2500b0069b5150712csm959098qvd.56.2024.04.11.16.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 16:58:33 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:58:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <greg.malysa@timesys.com>
Cc: u-boot@lists.denx.de, Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Scott McNutt <smcnutt@psyent.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH 1/3] arch: arm: Add Analog Devices SC5xx machine type
Message-ID: <20240411235827.GL2493117@bill-the-cat>
References: <20240411234021.14534-1-greg.malysa@timesys.com>
 <20240411234021.14534-2-greg.malysa@timesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iVDBRvqENaneFU2Z"
Content-Disposition: inline
In-Reply-To: <20240411234021.14534-2-greg.malysa@timesys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 12 Apr 2024 01:59:21 +0200
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


--iVDBRvqENaneFU2Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 07:37:28PM -0400, Greg Malysa wrote:

> From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>=20
> Add support for the SC5xx machine type from Analog Devices. This
> includes support for the SC57x, SC58x, SC59x, and SC59x-64 SoCs, which
> have many common features such as common ADI IP blocks, and SHARC DSP
> cores. This commit introduces core functionality required for all boards
> using an SC5xx SoC, such as:
>=20
> - SPL configuration
> - Required CPU hooks such as reset
> - Boot ROM interaction to load the stage 2 bootloader in the reference
>   configuration. Other options are possible but not officially supported
>   at this time
> - SoC-common configuration expected to be reused by all boards
> - Early initialization for system clocks and DDR controller
>=20
> Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>=20
> ---
>=20
>=20
> ---
>  MAINTAINERS                                  |  13 +
>  arch/arm/Kconfig                             |   6 +
>  arch/arm/Makefile                            |   1 +
>  arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  | 115 +++
>  arch/arm/include/asm/arch-adi/sc5xx/soc.h    |  18 +
>  arch/arm/include/asm/arch-adi/sc5xx/spl.h    |  41 +
>  arch/arm/include/asm/mach-types.h            |   4 +

We shouldn't be adding more to mach-types.h.

>  arch/arm/mach-sc5xx/Kconfig                  | 464 +++++++++

Here and elsewhere I think I saw whitespace issues (help should be
<TAB><space><space>) in the entries, along with adding "default n" for
new options, and that's not needed as n is the default.

[snip]
> diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config.mk
> new file mode 100644
> index 0000000000..b80644d6dc
> --- /dev/null
> +++ b/arch/arm/mach-sc5xx/config.mk
[snip]
> +ifndef CONFIG_SC59X_64
> +	# Select the Analog Devices processor.
> +	PLATFORM_RELFLAGS +=3D -fno-stack-protector -std=3Dgnu89
> +endif

We should be using the defaults here.

Also:
- Please switch to plain text environment instead of defining in board.h
  and so on.
- Audit your #include usage, I saw more <config.h> that is likely needed
  for example.

--=20
Tom

--iVDBRvqENaneFU2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYYeSMACgkQFHw5/5Y0
tyzvSAv+M6l47riLfKUxg2EGhv6AY2Ie1BNs9FB2bFlujGCo/cFg2eJjqxcM1817
F+6clTgW+jhOyEfR8P4aWyXhmUdG+dciq+QUe1xrxFw0nbAi8K79K3jAKdmMwfqS
G7LcrJWFbh3urlxC5lLCM03rckPWwGKR3VgD/qnxxsfwJm/PfS/R2TOmPTX0b9xF
rTVEFf0xOzc0Hu1sIauG13MK+EQwEur2X66aj49aBJOmtWa01Ihhswe0VVC/xtX2
7qQzaKHoJJL7CwF8DO6iydfV3SRJ4p5yxtGUwFCgA7tqgGKgx6Vny3WKp3lMLFWU
KaDCIZusC7n/P+obH4QUhREqnGgR+KtLYFnxQsu8sZpbQMmgpX7u7HkCx8LQ82a+
LeDO2UCtkdSuATLfoh+s3z3Ilr12gL2Ordbmp6glD/HBGRWoq4/R3YjYlj2DsX2G
cJvYhybIokqaXU0yCkWWP++TUZYYnmrBvqGv5t49zihWkEz26AtA//AAg2X8u8n4
74yM1DsV
=slRs
-----END PGP SIGNATURE-----

--iVDBRvqENaneFU2Z--
