Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B8CC54E76
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31E38718B;
	Thu, 16 Nov 2023 19:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="polcQysV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CC686D85; Thu, 16 Nov 2023 19:33:59 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C895E86D85
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-677a4d9ba82so5798706d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700159628; x=1700764428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IbLdM2bxY7vN5BFhHpeRrU7LwIRa5u5ky4ZkXyGNovM=;
 b=polcQysVMW5R3FHjjxOGZYPwHmaAJBYioyrKIzwpV7VLP0OeyBOKXMhc8PNC9JPPUe
 8lQhK3rnfwxQUeAyF2ep1lL3m7lVa4702g86mqII1Jie9jDmt33Z+piUlYzaJIAmClY+
 lSkIvRqAvoszQKPX/Xpjhc6waIi4Eue/Qm9D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700159628; x=1700764428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbLdM2bxY7vN5BFhHpeRrU7LwIRa5u5ky4ZkXyGNovM=;
 b=eAUb2Lw1+gXX8LFCyWe1++/4W/A3zfNgPou9FPHvQ2SW7mSKAM8A8Piwj8GqvcEeYw
 LtYtxQcnuWIiysYjM4dpAITI499l9frlXCP9o0K0sTlCk+txuG9/JA8VF8+2PZFxOUHR
 u8EtVTnPiv/v6DBqzuPkkVoPHVhq6djNHPgwgydQ0cE/BVASpJhqxenV8pA5uwYfRMZZ
 aO9E5Yt68CBMbqPmY8+ChzUCAbo1FGWWKzL6ZeNtJEI9+qQLnPHI/tARyN4ohgH2tEMf
 6UNdvzM01LOH10hynCo/vcaIG5YR+DOS44VCKWYhelzz2GrJ/TYT3yIwOd/LJsoD7q/+
 fpBQ==
X-Gm-Message-State: AOJu0YwAzTc0Lxh+DnKK+3OvJAP9T/4iLXsXapXblYHlmdSJ3rHm5GqN
 x8bJO8lKWGxVZjJ/Q56gaw4pzg==
X-Google-Smtp-Source: AGHT+IHJVczHRemMuGhk0to3Qekp7T0Dsgo5SjIuok/loqTliBHfGexljm10kKbr0pOEWvawzV0zbA==
X-Received: by 2002:a05:6214:1c8d:b0:671:e02a:8bfc with SMTP id
 ib13-20020a0562141c8d00b00671e02a8bfcmr11959577qvb.16.1700159628493; 
 Thu, 16 Nov 2023 10:33:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a0cc351000000b006516780a0a5sm1561479qvi.117.2023.11.16.10.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:33:48 -0800 (PST)
Date: Thu, 16 Nov 2023 13:33:45 -0500
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
Subject: Re: [PATCH 1/6] acpi: do not write ACPI tables on TARGET_QEMU_VIRT
Message-ID: <20231116183345.GA170968@bill-the-cat>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+YACovo/1j3GUP2W"
Content-Disposition: inline
In-Reply-To: <20231115142355.123038-2-heinrich.schuchardt@canonical.com>
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


--+YACovo/1j3GUP2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 03:23:50PM +0100, Heinrich Schuchardt wrote:

> RISC-V QEMU provides the ACPI tables. We do not need to generate them
> ourselves.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/acpi/Makefile      | 2 +-
>  lib/acpi/acpi_writer.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
> index c1c9675b5d..19fa6ac869 100644
> --- a/lib/acpi/Makefile
> +++ b/lib/acpi/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_$(SPL_)ACPIGEN) +=3D acpi_table.o
>  obj-y +=3D acpi_writer.o
> =20
>  # With QEMU the ACPI tables come from there, not from U-Boot
> -ifndef CONFIG_QEMU
> +ifeq ($(CONFIG_QEMU)$(CONFIG_TARGET_QEMU_VIRT),)

The goal here is to say that we have been passed ACPI tables, and not to
generate them, yes? Lets just introduce a symbol which says that and
enable it as needed in both QEMU targets and others as needed please.

--=20
Tom

--+YACovo/1j3GUP2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWYIYACgkQFHw5/5Y0
tyxsyQv9Gz00BKUXU8hJcuW/jzS4Nn8aAT5Xot+KerFC05UZJ8A35tWywLKsUCex
nY9T8B4mYF5kVGaDshVfz17urb4SOwHsIgzOJidqJXW7P2IuNTWYP5HXKZNYAHoR
H6QWuf2WTsJmyMES3MjLAZfdgr+dOAb7C8RiKnpYWS+I+7H55sQR6lUn/dopRDTC
mq26m0oVYMOBC38CCcB4ZHXcFZNGzWUICQmH51+3us/4vLV3TD7CZoWj1W3fkIy0
pU62DiL16Q9oV/JX5XmrQJP4AlzkkEOhKysNenVgoMzpWGaQhWZ8nTjxraEF3npL
V9C8B5dVWjhZm1SiJzTYW57OwbFMc5gFR9M4ctgRcg8J48x3QgzEL6+wyzUnkXlL
7TR1IyEzz7u1RYRcI0BC+HgYAE5kRF40lffksj9S9CUqjPYfsJBSHorx57kSLjtW
9RTKuQkSP85e3PDuDbEKMi8hRnVcJG14RhuXKSDpOHww+OmzdMFl19LxzwSEs10s
RcnRHJdb
=oXsN
-----END PGP SIGNATURE-----

--+YACovo/1j3GUP2W--
