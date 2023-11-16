Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AFDC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 20:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1D886F3A;
	Thu, 16 Nov 2023 21:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M1yTZ7gr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6623D86EEE; Thu, 16 Nov 2023 21:15:42 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028028718B
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 21:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6d645cfd238so695786a34.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700165736; x=1700770536; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GshOM4Ao0XEYCPo26sEiZlqbyKS5lKb8biqkc9IA5I4=;
 b=M1yTZ7greqc/lhvawwHxKdWNZFuiSK6MlG7UQxxGpxU/wO9j9ufqAOHU6CQx2XlpaN
 hcIT0H0Q9HtkDI51sSNg6SSvJorf2W6Axy4ET77t6/ecZ4BVtas7lhIUIKVax79YiKjP
 AVX/gWjIYjDmkwzg8oqtOVULVpukKXqmLYgss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700165736; x=1700770536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GshOM4Ao0XEYCPo26sEiZlqbyKS5lKb8biqkc9IA5I4=;
 b=RupI+S92a1+9UmA0baGHfxKj5kG6f+qmBLPFEmmWirGmSAxvX/AuEBSLgOHTOOQQJv
 Ez2lGmzi67lYlBwMJ44g1vy2TyZR1hWiaRqyi7TiTzQV9mWmsaikeY6PD1X0Zmq/0v4o
 UcbBOttPVaCkjU8Yz7ZeGJtwKRPmtPNa0EtXu+YSZUml3ot4OMQp8zu7fad0UejGh7HK
 TaBowP4pe69zZIdKt0SN0sPj5y0yZYieZ3RYh2gDXloPYuWV0n8hj2OeSsr5+2W6MTlK
 m+xJ/qD4aEynQpAwpYavMgXJm50MeoUw6NFZA2ylfh6zjYJ4xnE6JXqdWyYH8tCGXqBz
 oDkw==
X-Gm-Message-State: AOJu0Yw1m/+pMCqX7lG84VKoxyLSdik4k2aY0/eMUgsfXIo14SvDciZP
 ahe+3eE82hsjJn13kI0a23hyBg==
X-Google-Smtp-Source: AGHT+IFkzU+jRtIBaqBlQq7qisZG05quqrXkEgwIw3L1IqB9xVl9NMChuN8hczps8iGuanKg7Ld2Wg==
X-Received: by 2002:a05:6830:454:b0:6b8:f730:7ab4 with SMTP id
 d20-20020a056830045400b006b8f7307ab4mr10522811otc.0.1700165736450; 
 Thu, 16 Nov 2023 12:15:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a0cf684000000b0066db331b4cdsm40693qvn.86.2023.11.16.12.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 12:15:35 -0800 (PST)
Date: Thu, 16 Nov 2023 15:15:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/6] risc-v: add support for QEMU provided ACPI tables
Message-ID: <20231116201533.GG170968@bill-the-cat>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-4-heinrich.schuchardt@canonical.com>
 <20231116183549.GC170968@bill-the-cat>
 <a9f15562-d6fe-40d7-9fed-098061a5e523@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q5HloY0X2YZVPDAz"
Content-Disposition: inline
In-Reply-To: <a9f15562-d6fe-40d7-9fed-098061a5e523@canonical.com>
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


--q5HloY0X2YZVPDAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 08:54:44PM +0100, Heinrich Schuchardt wrote:
> On 11/16/23 19:35, Tom Rini wrote:
> > On Wed, Nov 15, 2023 at 03:23:52PM +0100, Heinrich Schuchardt wrote:
> > > If U-Boot provides ACPI tables on RISC-V QEMU, we need to copy what Q=
EMU
> > > provides.
> > >=20
> > > Provide the qfw command to retrieve information from the QEMU firmwar=
e.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   board/emulation/qemu-riscv/Kconfig | 2 ++
> > >   lib/Kconfig                        | 2 +-
> > >   2 files changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qem=
u-riscv/Kconfig
> > > index d56b4b5bc1..933b035991 100644
> > > --- a/board/emulation/qemu-riscv/Kconfig
> > > +++ b/board/emulation/qemu-riscv/Kconfig
> > > @@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
> > >   	def_bool y
> > >   	select GENERIC_RISCV
> > >   	select SUPPORT_SPL
> > > +	select CMD_QFW if GENERATE_ACPI_TABLE
> > > +	select QFW_MMIO if GENERATE_ACPI_TABLE
> > >   	imply AHCI
> > >   	imply SMP
> > >   	imply BOARD_LATE_INIT
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 19649517a3..a94adc388f 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -300,7 +300,7 @@ config SPL_ACPI
> > >   config GENERATE_ACPI_TABLE
> > >   	bool "Generate an ACPI (Advanced Configuration and Power Interface=
) table"
> > >   	depends on ACPI
> > > -	select QFW if QEMU
> > > +	select QFW if QEMU || TARGET_QEMU_VIRT
> > >   	help
> > >   	  The Advanced Configuration and Power Interface (ACPI) specificat=
ion
> > >   	  provides an open standard for device configuration and management
> >=20
> > In this case we aren't "generating" the table, we're using the table
> > we've been passed, yes? I think that further shows the need to add a
> > symbol which means that, and use it where appropriate. Or am I
> > misunderstanding the GENERATE_ACPI_TABLE symbol?
> >=20
>=20
> If you look at drivers/misc/qfw.c you will find, that we only read ACPI
> tables created in QEMU if CONFIG_GNERATE_ACPI_TABLE=3Dy. This contradicts=
 the
> long text of the configuration symbol.
>=20
> CONFIG_GNERATE_ACPI_TABLE is used to decide if we publish a device-tree in
> the EFI sub-system.
>=20
> Simon tried to clean up EFI a bit in 53e8e6f98679 ("efi: x86: Correct the
> condition for installing ACPI tables") but did not change cmd/bootefi.c.
>=20
> I would agree to calling the current usage of the symbol incoherent.

Yes, we need to start by making our ACPI-related symbols coherent. We
need a symbol for "create ACPI tables" such as we seem to be doing in
for example arch/x86/cpu/baytrail/acpi.c. And then a different symbol
for utilizing pass-through tables. And then probably another symbol or
two to handle what U-Boot does with these tables once U-Boot has access
to a populated table.

--=20
Tom

--q5HloY0X2YZVPDAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWeGEACgkQFHw5/5Y0
tyx8nwv+I6+kjeuJzBE0x7PqatjmQoo81/eItLfWyh66xC6KadpjvXW1iLULYfk/
qqTFpiIvYYefrScUzZJn1dVim2pD6T9exf3oasGiuxA8a/LfwZ8hvdsg74dK9zXI
W79KNzahUQwLuN6KG1LLJIR2KtbMy5vZouwC56NO/y5Is1cYTW0pAMKqynVuZb/V
6nhIGSpOwH1gIF8v6/kynlXc9KinQmmYYl8K1pl1iGn3Qb5fVpfB0rvXehc42twE
ZDdcqFGWzQ7pBeZ2t6w+aNgQn6zAE5g7ahgf+Aw9DHqL1vC7ppAzpaDjjks+Qm+1
Dr4+zZuhR4ucfPbjRjX5H+xNBn8Q6Wyzmou/YoXRCZa2z+EeclXq4rcMdO7t/uUQ
LWC4kVu225o7SgnPRIxKi3C3bxIdHb2QwRTW9bimh3dtUClqjTM4QmlrXx8kJUqU
GD4D3sbSRiRzKw0BYb/AFxE9KBScYx8ac9HM7EC12Ps/wMBZN5HMszDWMlmPpA26
W3VCkX97
=E6pY
-----END PGP SIGNATURE-----

--q5HloY0X2YZVPDAz--
