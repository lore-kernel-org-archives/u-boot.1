Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B05C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDC88718B;
	Thu, 16 Nov 2023 19:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pZmKpHrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216028718B; Thu, 16 Nov 2023 19:36:12 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C798615A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-77bb668d941so64182685a.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700159752; x=1700764552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0iFEWJmIYb43sqBvUn5TjQGqexc6KQ9lGoPFqvWNNdk=;
 b=pZmKpHrrLSaW19RNck93nsJ1bXkb/uSRFkufISaARPSJbyDfc8zUD5SZ85mIPqWC82
 kw/qyJgKcW1qa4cIbmGEsW/oj71ZngpaCEY6cGGkfWmmHE6kOlxydiKohEb+m6jEgS7r
 2kWKSluiFGeaUR25mB8COFGYD85oBDRjve2Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700159752; x=1700764552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iFEWJmIYb43sqBvUn5TjQGqexc6KQ9lGoPFqvWNNdk=;
 b=WhbItxF8UglS/k5/mh38aDs9j92ir/1Im++cI+Pnr3NSJtyfB5RqTwS3qmL3EFHtbS
 oL9pFAARfhbFkUYrSzJD+iQ7NAFqPj9Ry7uHWwhy2CiRLDW81SEs4p8vUXp4eJA4hfzl
 A/GiF91FYqD85N6POA/1WFnAfUTTOwbATXEO0JoAdTn+y9ElFqxEmVxb8icjho9hnAul
 baU8U8RVm07XZSWbkvpoLYvydvSUGT+hkioA4RB44+guCdq+45qjITf3pyiltG39p+WF
 YKleNxH+h9K4vNElNAahbIftB+XcNYNwzGmCiFiAcFUS9xtjt4AIeFHHVVW5Zfj6MbZW
 zAnw==
X-Gm-Message-State: AOJu0Yxrwm0BmMVu1Ye3VkwFSnO2kMcC5SA8yOQ67gU8zQu0Tn6r6qPE
 BXETJkLB8NTwyM/Iap4AiWTmuw==
X-Google-Smtp-Source: AGHT+IFooxHt8pIgyNEjcBbMy3kWSVthiZrFjvXEiZsLRPqP9DMzLZzHfEgRG8+a+0cv1bsrcEiEJQ==
X-Received: by 2002:a05:620a:55b8:b0:775:73f6:1b39 with SMTP id
 vr24-20020a05620a55b800b0077573f61b39mr8015062qkn.25.1700159752144; 
 Thu, 16 Nov 2023 10:35:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 m18-20020ae9f212000000b007756d233fbdsm6528qkg.37.2023.11.16.10.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:35:51 -0800 (PST)
Date: Thu, 16 Nov 2023 13:35:49 -0500
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
Message-ID: <20231116183549.GC170968@bill-the-cat>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ez1tcLzPGChLrK9x"
Content-Disposition: inline
In-Reply-To: <20231115142355.123038-4-heinrich.schuchardt@canonical.com>
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


--ez1tcLzPGChLrK9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 03:23:52PM +0100, Heinrich Schuchardt wrote:
> If U-Boot provides ACPI tables on RISC-V QEMU, we need to copy what QEMU
> provides.
>=20
> Provide the qfw command to retrieve information from the QEMU firmware.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/emulation/qemu-riscv/Kconfig | 2 ++
>  lib/Kconfig                        | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-ri=
scv/Kconfig
> index d56b4b5bc1..933b035991 100644
> --- a/board/emulation/qemu-riscv/Kconfig
> +++ b/board/emulation/qemu-riscv/Kconfig
> @@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>  	def_bool y
>  	select GENERIC_RISCV
>  	select SUPPORT_SPL
> +	select CMD_QFW if GENERATE_ACPI_TABLE
> +	select QFW_MMIO if GENERATE_ACPI_TABLE
>  	imply AHCI
>  	imply SMP
>  	imply BOARD_LATE_INIT
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 19649517a3..a94adc388f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -300,7 +300,7 @@ config SPL_ACPI
>  config GENERATE_ACPI_TABLE
>  	bool "Generate an ACPI (Advanced Configuration and Power Interface) tab=
le"
>  	depends on ACPI
> -	select QFW if QEMU
> +	select QFW if QEMU || TARGET_QEMU_VIRT
>  	help
>  	  The Advanced Configuration and Power Interface (ACPI) specification
>  	  provides an open standard for device configuration and management

In this case we aren't "generating" the table, we're using the table
we've been passed, yes? I think that further shows the need to add a
symbol which means that, and use it where appropriate. Or am I
misunderstanding the GENERATE_ACPI_TABLE symbol?

--=20
Tom

--ez1tcLzPGChLrK9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWYQUACgkQFHw5/5Y0
tywUCgv+IZNQjKm6nNnwZOfUrsjinsyp63peqFRWf2DBUxY8FCi3xBAkAJVmPdmP
ZoTzxHqj51DUiyVClEjSobrykuhRaxwWSf4YCNJ/YZ/7EeaZ8VOu0ygC4AqWxzWs
UCe0BlN/BWbhVcLMwOGiAnvD1eQuLfYEI6JTbHnpKLDpaRsB5KCWmOgMHpP1aDnH
U0aBde5DkwoPwCTp99yS7ZP8FLX76H4uOy/zitfbjhnDWn+ZWZW+PdnyH8u25gDt
J1+wdxIIaIRmdU3/57llBAVxmcPzqgae4p9mGv4wIwPjTAqXmXT5SXrwFt5si+Rc
okUv2oTThAqSl5yn/PNC8fmwU2IhElskboXj1dDFrufRTlrwwMo1R1OqQyIol4Tr
PdwVj5wL8EwDKjfnJ3yh9exCN84p5NyxcF0UIF9jbhyZi7oBjOOe/tprEu744EZl
VzCFAuL8ubo2kO6evTGhTgoPHdWP4BGe9BqHVrsZgzQfj18ev4xKChECk+WaD1EA
JpIgsMDV
=zvZ/
-----END PGP SIGNATURE-----

--ez1tcLzPGChLrK9x--
