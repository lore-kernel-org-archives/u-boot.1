Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA0D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536BC83CBD;
	Mon,  1 Dec 2025 19:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XLCjlzCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303FE83D03; Mon,  1 Dec 2025 19:01:41 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01373803F5
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-44ffaeda17fso1728066b6e.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764612098; x=1765216898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=54UB4bWdTmhr9G+c7hD/IRyiwSJmqCau8ZZhlmy8a5Q=;
 b=XLCjlzCXzDwj6yAPoAvmkzGrri1saqPOeb/YumWH4cHY0Rv9iOZIUnT3DRcHoErXRW
 FC4B3jdk7Jn8B71O055DFhjILTPA4MSmJjatU8Jag5lqUPJcQi50rxg6pnVgqz3rkIWy
 hrS9qDawtzPEtbLzjJL8Z03z6i5TB3i2sArgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764612098; x=1765216898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54UB4bWdTmhr9G+c7hD/IRyiwSJmqCau8ZZhlmy8a5Q=;
 b=k+IccyiMEscb7c9XjZjRxkueZencqCGRlLL/Vk+pQ31Q5oDEo8yAIM8V0iZMELVaoA
 sFDDZuUwiGUpXWPcndzFshj8S7MYeokD06AgZrXbFierbW7r9kw/sag0AH0X0pz7dXXL
 KJNtRJxmLXwfisB0vZkga94x1odOPnXqQDR/jCRgYOBMIgoEBpbdbcF6NIZ0jmgx9l2q
 xcmYjaQYH7xjBEGb0pcqr4aKJJT2XsSwMPXWchQUgFOVJjoeTtNH9OXp9cXGGOWlhrZw
 2a7GGMsLBQT4xmGYL/u6T8/WbeaG6eRfBizKs9Wea+HupfyDDiNRRr6sD90BrhmQz2/k
 xZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmTnQHQTm9JU71HgGzNv5qFwjHN+bKCeVLm+FXL8QLVuXApKpGpwbqhP9f4uYCZpvJR5m0s4U=@lists.denx.de
X-Gm-Message-State: AOJu0Yxr0JPcgSIffODff1n7DocdXlPTWiKHGGfJXbPSpTzxqHpr39uo
 FPLVy5SCccSZNd6oRG/XqTmoRSnNMjdqeKxEBDt4SIN/geyqJS0nKqPtAQw8sS6Vcrs=
X-Gm-Gg: ASbGnct170Hqkmv3ERpB7U8h9orNa7RBCS6KOxudnCXLpefpzKUd59A56AIIakN3NLN
 0Rvhyk8mwUm5Q55fKbVyxelws5YTDGOoH/QRjU7iCOM4erNMdCaFJWVEpLKzMKpBxfbgPzKIbRK
 29RHrUgRAEN2o5l+3FOo5t2Bf+iat1NqDGZagrAmPMv+s2ekao1G4d6L/ZqO8/vHN1rKd8/w171
 d24u3B0uMUjPnccWs3AZIQtEsLz0uXj8YWclPv5FtzdecR2+fOty49pP3Wn1cR/5RgUkkO4G9C+
 /1KY2NR5uWHmG9K6kboYmv90kKSl3ZtEBdCAJ26RKEznzNu67K8CMKCiPjuDhn4v3FYtxcMNv5e
 5jvYjyD+Q5W3xRhxVLzQpNZLQDRHPPVDnTIgNYGLkwEEb3n/neG4ANUq6jVrIwJu1j4s1ZbT1f3
 hpxw9XiUTw8bxE54lHImpbLHOdpHBZQ0OCcQNGutPIEh0r1tbFOQ==
X-Google-Smtp-Source: AGHT+IGilpxMZLxbaJd6P+fe100GIg/FyrX/roetqgt/8swzgUZDL4sgENHVh5EuV2WwWk0h4cmGyQ==
X-Received: by 2002:a05:6808:30a2:b0:450:cfd3:cfba with SMTP id
 5614622812f47-45112d29054mr18364667b6e.57.1764612097344; 
 Mon, 01 Dec 2025 10:01:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd0299c0sm5524696fac.18.2025.12.01.10.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 10:01:36 -0800 (PST)
Date: Mon, 1 Dec 2025 12:01:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Frazer Carsley <frazer.carsley@arm.com>
Cc: abdellatif.elkhlifi@arm.com, harsimransingh.tungal@arm.com,
 hugues.kambampiana@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCHv2 1/1] corstone1000: Add Cortex-A320 support on FVP
Message-ID: <20251201180134.GN303283@bill-the-cat>
References: <20251127154752.589691-1-frazer.carsley@arm.com>
 <20251201090424.34519-1-frazer.carsley@arm.com>
 <20251201090424.34519-2-frazer.carsley@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kiZaI2dO7zOf7wSs"
Content-Disposition: inline
In-Reply-To: <20251201090424.34519-2-frazer.carsley@arm.com>
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


--kiZaI2dO7zOf7wSs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 09:04:22AM +0000, Frazer Carsley wrote:

> Enable Cortex-A320 support on the Corstone-1000 platform
> (including FVP) and update the device tree to support the integrated
> Ethos-U85 NPU and GIC-600 interrupt controller. These updates make
> the platform fully compatible with Cortex-A320 while retaining
> backward compatibility with Cortex-A35 and GIC-400.
>=20
> **Cortex-A320 enablement**
>=20
> * Extend Corstone-1000 compatibility list to include `cortex-a320`.
> * Ensure build and device-tree logic support both Cortex-A35 and
>   Cortex-A320 configurations.
>=20
> **Ethos-U85 integration**
>=20
> * Add `/ethosu@1a050000` node describing the NPU register block at
>   `0x1A050000`.
> * Introduce associated reserved memory regions:
>   * `ethosu_sram@02400000`: 2 MiB on-chip SRAM (`no-map`).
>   * `ethosu_reserved@A0000000`: 32 MiB DDR carve-out
>      (`shared-dma-pool`).
> * Connect memory regions through `memory-region` and `sram` phandles.
> * Add `dma-ranges`, interrupt spec, `region-cfgs`, `cs-region`, and
>   `ethosu-mem-config` for full driver support.
> * Enable the NPU node conditionally via `CONFIG_ETHOS_U85`.
>=20
> **GICv3/GIC-600 support**
>=20
> * Introduce `CONFIG_GIC_V3` to toggle between GIC-400 (v2) and
>   GIC-600 (v3).
> * Add full GICv3 node guarded by `#ifdef CONFIG_GIC_V3`.
> * Adjust `cpu@1..3` `reg` values to `0x100/0x200/0x300` under
>   GICv3 (keep `0x1/0x2/0x3` for GIC-400).
> * Update Ethos-U85 interrupt assignment to **SPI 16** to align with
>   the new interrupt map.
>=20
> These updates align the Corstone-1000 platform with Arm=E2=80=99s latest
> Cortex-A320 and Ethos-U85 configurations and ensure proper interrupt
> and memory mapping for both secure and non-secure domains.
>=20
> Signed-off-by: Frazer Carsley <frazer.carsley@arm.com>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
[snip]
> diff --git a/board/armltd/corstone1000/Kconfig b/board/armltd/corstone100=
0/Kconfig
> index 709674d4cf7..9476d64d0b0 100644
> --- a/board/armltd/corstone1000/Kconfig
> +++ b/board/armltd/corstone1000/Kconfig
> @@ -9,4 +9,11 @@ config SYS_VENDOR
>  config SYS_CONFIG_NAME
>  	default "corstone1000"
> =20
> +config ETHOS_U85
> +	bool "Enable Arm Ethos-U85 NPU support"
> +	default n
> +
> +config GIC_V3
> +	bool "Enable GIC v3 support"
> +	default n
>  endif

The first, small thing is that "default n" is default, so those lines
should go away. The bigger thing is that we will soon enough be seeing
code to support these options I assume? And I don't know how broadly
ETHOS_U85 will apply to other designs, we have things related to GIC_V3
elsewhere, and so I think this symbol belongs somewhere else, probably
arch/arm/Kconfig near the other GIC*V3 options (inconsistent naming
today) and maybe should just be GIC_V3_ITS once used?

--=20
Tom

--kiZaI2dO7zOf7wSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3X/gAKCRAr4qD1Cr/k
CoVeAP9bEA9gGkIiBAFGGgq8bapqWFZRSGb5DLMeS5yFqFObbAD+LjzkvP8joZmg
TlGSohT4TzdbbTRiIFdKLzgCJ8vk8Ac=
=Zi2I
-----END PGP SIGNATURE-----

--kiZaI2dO7zOf7wSs--
