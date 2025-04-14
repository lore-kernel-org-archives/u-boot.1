Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02612C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62AF382928;
	Tue, 15 Apr 2025 00:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XAv4kCti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9564B81E1F; Tue, 15 Apr 2025 00:53:14 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1ED82905
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2cca475546fso2324970fac.1
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744671191; x=1745275991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d6hTdFtrsHbJ3Fg0A2YglBXUn6TXTodfthqptCHVoP8=;
 b=XAv4kCti5Tn9oi27YydNEN8HfTHjxBqWyFfKreu3ZephqRAhUFlvcRq1u0JrQHMe8X
 NaFPvrSwdwiUMS4jE4xRlcL7RjclYYsIyADI0bMTNfj6EXYBb//aaZJtxlknHAlSnc5f
 PJ2kYJnfAp11eJuLgFCXDUROrQgARF78kYJFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744671191; x=1745275991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6hTdFtrsHbJ3Fg0A2YglBXUn6TXTodfthqptCHVoP8=;
 b=BHVEs+lSY0b0ufsPylgB8qs5PdcrySJj5nfNuXKgGY6YQ1ROe5nUvOHNmDYnSQhg8/
 bGEWoALnWkZ1xJdOXrgSlGEFRdxEQEANkt0uN5wepsMyOWXyX6j1Tfhfobzt7scs7/xX
 YXq19Gf89piIoF0vKE+4mr35PcXXL/cBSgEv0h0xc202d9li6xUZ8sFPapHXZfEmVBfj
 DGXAPVquRx3Ir5AmeHYyCZegXU6ED31djqPuKv2n3s8dSUzbLOU/HVXG92hIOc8gNPmS
 vblXkWOgcUQwwe+1XZPXTdVyza9CG7DD9Ijdmka4vIOwPdHwifGsdhFBSuATVHHiJBcY
 tN4w==
X-Gm-Message-State: AOJu0YxsSbYANr/pbCZVgsLOQ/qnoQzGhgFbOkoVR2ktrG+D6RPtIk/m
 sTW5gqcbnv8aIO6izHustxVCR0MjJM0p70CLATlVbLXeTLddepOfGMYFN0NbOyQ=
X-Gm-Gg: ASbGnctqK5kFM9UHAYDlMZI4uIx5vVd/k0UIagzlHcCC4hvrbAwSk9cqUdKaIhh/j28
 kMBIpOF4SX83qtsr62ng0dq8sxSS/RAuGdT8ueNpSSw7sK4dW5b5EWr1e8HC0ohOpJPjrjjL+7f
 72VVDcE5BdcB+N9xw+CzuDLm3FlH3RukneZhtbbLT+U4SFIC8AxhujSq18tWQ5eQ/ymEgMJXYyj
 Kc4sJeon55UyWxP1vbZ+hmaEpXsG9n8Fyv1Gdo1TRRV9qRTkTmRcTH7sNEA67aPmyIQ4bs4ocY2
 ajQdNh8zdMK3XKXZRG2TVpX0ANcPwrffhxaJ9yF+lwOEFk8TXqySTUZguTq6SNvjFCnkbD2se+o
 NjA==
X-Google-Smtp-Source: AGHT+IFOWUXJtBI7QbsbViD29KDmW1rHcVqLBjVG47ncScGZ6p+MGzRYs7qe0PCgQguXhZg44ENRLg==
X-Received: by 2002:a05:6870:4f0a:b0:2c1:4e25:e67d with SMTP id
 586e51a60fabf-2d0d5ef3099mr8411387fac.24.1744671190679; 
 Mon, 14 Apr 2025 15:53:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0969d2a32sm2581496fac.29.2025.04.14.15.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 15:53:10 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:53:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
Message-ID: <20250414225307.GH5495@bill-the-cat>
References: <20250405190711.365419-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3/PoCKKCH25dZtjR"
Content-Disposition: inline
In-Reply-To: <20250405190711.365419-1-sjg@chromium.org>
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


--3/PoCKKCH25dZtjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06, 2025 at 07:07:04AM +1200, Simon Glass wrote:

> At present it is impossible to change the qemu_arm64 defconfig to
> obtain a devicetree from the U-Boot build.
>=20
> This is necessary for FIT validation, for example, where the signature
> node must be compiled into U-Boot.
>=20
> A proposed change to QEMU to allow device tree additions has been
> blocked for several years. The only known workaround is to use QEMU's
> dumpdtb option, merge in the signature node manually, disable
> OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
> complicated enough that it is documented in U-Boot[1].

This paragraph and then

[snip]
> +	  Note: this work-around is necessary since Linaro has blocked
> +	  addition of a feature to support additions to the QEMU devicetree:

This part of the help are overly antagonistic.

[snip]
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 2e88d210bb8..53f7e246a80 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
>  	  development purposes, but it is not recommended, and likely will not
>  	  even work, for production systems.
> =20
> -	  Note: This option must be set in Kconfig and cannot be enabled or
> -	  disabled in the board's defconfig file.
> +	  Note: This option can be disabled for QEMU usiing QEMU_MANUAL_DTB thus
> +	  allowing QEMU to support FIT validation, where the devicetree must
> +	  include a public key.
> +
> +	  See also this for context:
> +
> +	  https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.=
256484-1-sjg@chromium.org/#24481799

And we don't need more wording here. The QEMU_MANUAL_DTB option itself
is enough.

--=20
Tom

--3/PoCKKCH25dZtjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf9kcgACgkQFHw5/5Y0
tyy4kQv/bAJTRRP3M2SZW6US4FMXhkv6XmgTF2IyIzvtFvmftAHZ8Qjbu2etNwS2
TYVzxoBy48D96UzOM6nSXUGj6mLcblzIF8hxQE37KYaAnwfx+Uu+nl9gsRk+Bkk0
c2c/z/OFhiZ99Vip2YY0dL2ZWa1br54HXbOiP9lyLeMQETeiv5WCK0Xkz7KfbwBe
ueLGtGD5fGDhag56gB7rOZpEoHS9w8/ct1/lGJhX2YDEQr0bs0mGhQmcqh41hGne
5n+Bgly9yXGEGOX48Kal2hQJMUddp5ttFYFNiR99PIZyjVSZLaeedhdGVxaqbGrh
weJK356XX3ZizS8R7ztGFLGYiAnt4loZUtOlQ8+5iq7tOdivu4T6FOWB/UXIrLIa
PL2Q7zZeJQ6OYKUrKtWtgHaDeaVlmzdu47ICsrzSxXrVEtICHCWJYol3X7E1ZIvz
Q6HZqYomyqsqV3DREhXGR2esY/rksjEdlXTnKZlmx+WzDs6m5ATRzZsSZ+Ly85Ma
nFjPzvA+
=UHp6
-----END PGP SIGNATURE-----

--3/PoCKKCH25dZtjR--
