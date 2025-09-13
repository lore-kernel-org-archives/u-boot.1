Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED65CCAC587
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 15:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7319982FC7;
	Sat, 13 Sep 2025 17:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AveXgrZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3382B830A0; Sat, 13 Sep 2025 17:55:49 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1400A82AE1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 17:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3f663c571e2so29061015ab.0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757778946; x=1758383746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VGLU3UExZzsIJVTuSZ1NkSJmFpUFE8gHA+qDAh9Gg/o=;
 b=AveXgrZ1elkJ/DkNnPUlcE1CrTFaDlTnL+NnGTY3DMKu99mCozq1dLe0xJSR5VapyH
 8/G1GBG6Og6YShLyhWf5bAzyJcVCULx/0RUZoUQt/ttu0dZgxfQ9DMniUoBg78/KQPl+
 rP0rJVqiTdOJac6+10I/T2WC9XtPEQ9t8tNQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757778946; x=1758383746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGLU3UExZzsIJVTuSZ1NkSJmFpUFE8gHA+qDAh9Gg/o=;
 b=UWiHCFaWP09dBsKKxfj0zR0yzkovIazfBFHQnzukZ2t3Dt2EQ5b11NMnMZgBUELbx4
 HisrRQkdHVE0pbYslTHEspZyXwrNOLVYpwl4HO+aFwwtQNzldcL8ExY9p1kK7P0IV73F
 TJotTv5jy0VAr9+wZd09dZ25x+k4fLNVe4xpt8W8XC2StvzBttPtcAMjfqf6cQzOL/qr
 X+S/PGCikESWODdNyh1e+Uv32P3KCVR5KzhQd3sr79pPl0eWWMBE+r4qd4O8Y93nwOPE
 oCcUmpI1CR42kUzCgMIFw6SFiWbzc3B93qsxpHX7uab1SmihYJ8Kv3Bwclo4fbgW9FJT
 FB4A==
X-Gm-Message-State: AOJu0YyTIZeBOBRh5aloOo3Nm0XsP6lnhC1hdkRevDuBuDPr5ff3G10I
 QlSSaYcdwK7Wvq4LLm2ZREEP8xWn0Ee0m2ALznjR6yVwoa9+9Yhgw8kHqa0ovPXu/Te1fwojqjJ
 SElkHn1s=
X-Gm-Gg: ASbGncuY7t72E58grJmaKB5nHv5fEAE+IMM9jbb6y5kuOPLnDqy4PMCmPN7JonKPkWL
 vJ4ISi9scKi9QKwgH7JF51HWp9AmYjVyhWgIjD25/Bm9rL/9qwPQCQF/1TvQu0POVTly93scqwK
 R32IZrbHX9wocnnsFD8T3d693Clh6yKpOZy3wRmyNoAcipkwYi6sbnh7Vf6y4EIlj2cg6VD6TB+
 8yI3RyzdPd5FCLT1rNkXTBtpijcYjUuOtORsxNR8Ts50mQdWfdUfH2YyzK5sqzrn0rA/MwlyOCt
 5gSs9IxhS4PcLbbWrdIxsLttZY48DPqHex0jPMHZHvgi98Qqj0Q4Nu9AiQKJr+hSmZI+XKgxuwS
 JhOz9VYxcyjYgKzLJm7ibkOrnr6JXHoM8UBSz5g9cfx88T7tF8RXlHPVkFsvrny5+xlM=
X-Google-Smtp-Source: AGHT+IHMQQvNJg3U9StUsriO9S+dO8J7STX7GNz/GHYaW9ED9bVlfZqYL93Ov6r1PkIHXqPEC6fKWg==
X-Received: by 2002:a05:6e02:178f:b0:423:fb9b:c3a with SMTP id
 e9e14a558f8ab-423fb9b0d97mr9878635ab.20.1757778945758; 
 Sat, 13 Sep 2025 08:55:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f3067b89sm2771764173.38.2025.09.13.08.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 08:55:45 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:55:43 -0600
From: Tom Rini <trini@konsulko.com>
To: briansune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd/dma: fix generic naming, spacing, and Dependencies
Message-ID: <20250913155543.GG124814@bill-the-cat>
References: <20250913080414.1687-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d+8JqLMJKJ73W9Xt"
Content-Disposition: inline
In-Reply-To: <20250913080414.1687-1-briansune@gmail.com>
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


--d+8JqLMJKJ73W9Xt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 04:04:14PM +0800, briansune wrote:

> This adds a new U-Boot command 'c5_pl330_dma' for Cyclone V SoCDK
> boards. It provides access to the Reset Manager's Per2ModRst register
> to release the reset for ARM PrimeCell PL330 DMA channels. This allows
> software to initialize and use the PL330 DMA controller properly after
> reset.
>=20
> Tested-by: Sune Brian <briansune@gmail.com>
> Tested on: Cyclone V SoCDK
>=20
> Signed-off-by: briansune <briansune@gmail.com>

This is better, yes. The subject should be fixed, your real name used in
the Signed-off-by (and you don't give yourself a Tested-by for what you
wrote). Also:

> ---
>  cmd/Kconfig        |  9 +++++++++
>  cmd/Makefile       |  1 +
>  cmd/c5_pl330_dma.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 cmd/c5_pl330_dma.c
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 29de857ba7c..75c388d19da 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1791,6 +1791,15 @@ endmenu
> =20
>  menu "Shell scripting commands"
> =20
> +if TARGET_SOCFPGA_CYCLONE5_SOCDK
> +
> +config CMD_C5_PL330_DMA
> +	bool "Release Reset DMA Channels for PL330 Handshake"
> +	help
> +	  Provides access to Reset Manager Per2ModRst. Enables DMA
> +	  channels for ARM PrimeCell PL330 via reset release.
> +endif

This should just be "depends on TARGET_SOCFPGA_CYCLONE5_SOCDK" if it's
that specific and not slightly more usable on other SOCFPGA chipsets.

[snip]
> +static int do_dmareset(struct cmd_tbl *cmdtp, int flag, int argc,
> +	char * const argv[])

This spacing is still wrong and what checkpatch.pl notes. Thanks!

--=20
Tom

--d+8JqLMJKJ73W9Xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMWT/gAKCRAr4qD1Cr/k
CqOhAQCDqYFEDiQHeKNXIEwev+NfVNHCoTsDcsJaGZ/7fV/z3QEA3XH8x/W8qsSk
5uqkP5AiihdV8A5lVuX1vNMIMNQRTA4=
=BKL7
-----END PGP SIGNATURE-----

--d+8JqLMJKJ73W9Xt--
