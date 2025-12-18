Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D45D6E2DD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F37180325;
	Thu, 18 Dec 2025 20:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iTH46fjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C2E8309A; Thu, 18 Dec 2025 20:04:21 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E12880050
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3e898ba2a03so817918fac.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766084658; x=1766689458; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TxGvZK0Lp2qd3AImCl8EFXGcy1f74l3nGuyT+CdguTc=;
 b=iTH46fjtPnh6l4uH5svg+ae0DOnIgEo63J4pCBeg0mE9f2RwE+qNMQVtkE0jSLlWYz
 Ij60LQYGciwXNOZ3GY2wxyDYyhSHPH+2qPDX41UbaY51rNYogu/c0xVzvEMdDZNvy6Jm
 XcNfKQcnWFvDaPcnvGxSMimtSc/9bdwkl4Dyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084658; x=1766689458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxGvZK0Lp2qd3AImCl8EFXGcy1f74l3nGuyT+CdguTc=;
 b=JRcFFcGfHfKaAqvicWQcFf+1ic5hNJwYsxjMHqlGGY69fdl+FG0Q/U6gHnKDV7vXuM
 LYk4eijnJTLUd9F3Vz8pOykAU13UAZYtUWzWzRyikGYCULE/vt5FKp0biGdgInx25kW4
 7cWsdydO0uXSpV7k6JYBZiSdsOjhEPL99Uz4M/p/7yLvN6qSNGVI7gkGYHpR3vH9HCLr
 NxjiJDljw1mKvcDlvFxyZH7p/xuVj/KyZVZ/cJNHhvNCao4HFD68Bkagf4CHsgAz4LS8
 E2Q6ggVtKgsWupKvMDlimni3QESlorXqH6WvJ2/cT0cwBcaJ2dVb8y+w0aXilzXsKlot
 zPEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU395WAPGlyzl3E8SBTxAiLe3OjDp4+QMmZ5ZNNruohaO8k97HomRBgp1L66JWy94GIssyzJyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxki0tmYHfS2LRnq1LwK2FRN2dteh8MRwfKikg3yUUsj+yGr7vx
 Rk7DTuPAMm8ZQ8L/ByqSR7dsV0k+HgjI12FdS9Ya3FG9Qq77RFpAgkCTaDfkPsZdz04KyZWfr8H
 7WDUVZQM=
X-Gm-Gg: AY/fxX7RRM9TsjzRhp8r7B+x+AUKJn1kjRjeFpUPu+n0vs4x2mIFQQ06AogoaIN/qWU
 sZm/hUkSfH02/BFQa8eoRP8ZEMELSzJ73it2lk5m3t+PfCD/ctsGc6rsaNCVeR4i/qKj4RcGPlt
 5v9tCz0g6alwfJPi6pZeZ0yRR8C/6y4NnMKr8SCSnHfPf+Fj1MooRm98pUMHBC8RUPR3O7vwGXX
 5W2pcG7C3MeuZIPa684YzQaF/kAA3vGXaA1e5Yl931tF8S8hgXvKbSYnUuEvin5tl2xO0MjHuKg
 SVv4phvS2TD9TnhWOWNiOMxguSPYcy/QiZ+anhNdQmygvDSYTIy8f2IqztYJ7bUVw/5hM3MTDc6
 P4zjqnexRSHypXbbXfCed/qGE/uo1TPnH+ZeO3u5UGiJRDVsWBWjrHuCr+VjaVvNpf5VBzRi84H
 ibUu/UB0iefdOSGU9LI7YQqw0txwBtkaYoAHyvWPBKrztwzdCWoQ==
X-Google-Smtp-Source: AGHT+IGJLEy0Vq3kqkh6ULHtJs4iyig8rb7uaUv6ul/ryvGGPGDUZrVOlFsWkuuD0aAC+xdL/bydkA==
X-Received: by 2002:a05:6820:168c:b0:65d:b36:bddb with SMTP id
 006d021491bc7-65d0ead9c3fmr252912eaf.62.1766084657721; 
 Thu, 18 Dec 2025 11:04:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69b9b0sm108398eaf.11.2025.12.18.11.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:04:17 -0800 (PST)
Date: Thu, 18 Dec 2025 13:04:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] board: Add QEMU m68k virt board support
Message-ID: <20251218190415.GN303283@bill-the-cat>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-4-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R0nhnQMj+lC+zKhr"
Content-Disposition: inline
In-Reply-To: <20251218185252.957388-4-visitorckw@gmail.com>
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


--R0nhnQMj+lC+zKhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 06:52:52PM +0000, Kuan-Wei Chiu wrote:

> Add support for the QEMU 'virt' machine on the m68k architecture. This
> board emulates a generic machine based on the Motorola 68040 CPU
> equipped with Goldfish virtual peripherals.
>=20
> Introduce the necessary board configuration and initialization
> infrastructure. The implementation includes logic to parse the QEMU
> bootinfo interface, enabling dynamic detection of system RAM size to
> adapt to the virtual machine's configuration.
>=20
> Enable the Goldfish TTY driver to provide a serial console, which
> facilitates interaction when running QEMU with the -nographic option.
> Additionally, include comprehensive documentation covering build
> instructions and usage examples to guide users in deploying U-Boot
> within the virtualization environment.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
[snip]
> diff --git a/board/emulation/qemu-m68k/MAINTAINERS b/board/emulation/qemu=
-m68k/MAINTAINERS
> new file mode 100644
> index 00000000000..c2f4cc40a56
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/MAINTAINERS
> @@ -0,0 +1,10 @@
> +QEMU M68K VIRT BOARD
> +M:  Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:  Maintained
> +F:  board/emulation/qemu-m68k/
> +F:  board/emulation/common/
> +F:  include/configs/qemu-m68k.h
> +F:  configs/qemu-m68k_defconfig
> +F:  arch/m68k/cpu/m68040/
> +F:  arch/m68k/include/asm/bootinfo.h
> +F:  doc/board/emulation/qemu-m68k.rst

There was Kconfig spacing issues here as well, but also MAINTAINERS
files are usually tab not spaces. But if get_maintainer.pl is fine, OK.

> diff --git a/configs/qemu-m68k_defconfig b/configs/qemu-m68k_defconfig
> new file mode 100644
> index 00000000000..765ed9b7424
> --- /dev/null
> +++ b/configs/qemu-m68k_defconfig
> @@ -0,0 +1,17 @@
> +CONFIG_M68K=3Dy
> +CONFIG_TARGET_QEMU_M68K=3Dy
> +CONFIG_TEXT_BASE=3D0x00000000
> +CONFIG_SYS_LOAD_ADDR=3D0x00000000
> +CONFIG_SYS_MONITOR_LEN=3D262144
> +CONFIG_SYS_BOOTM_LEN=3D0x1000000
> +CONFIG_SYS_MALLOC_LEN=3D0x20000
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_BAUDRATE=3D115200
> +
> +# CONFIG_OF_CONTROL is not set

This wasn't made with "make savedefconfig" and needs to be, please
generate it that way.

> diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu=
-m68k.rst
> new file mode 100644
> index 00000000000..19898e17cfc
> --- /dev/null
> +++ b/doc/board/emulation/qemu-m68k.rst
> @@ -0,0 +1,38 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>

Docs are good, thank you. But it needs to update the index.rst file too
to be included and also not trigger CI failure when building docs.

--=20
Tom

--R0nhnQMj+lC+zKhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaURQLgAKCRAr4qD1Cr/k
CsMQAP9n88iGqVYgqvbk0xYwwWPNQr+UZI31F5LRNk+/fwcUfQEAmCxQ8tiKLdfk
1Q9fqlFm/XWLUGelPE0jdiiAjCSu1gw=
=CgI/
-----END PGP SIGNATURE-----

--R0nhnQMj+lC+zKhr--
