Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB68C27C79
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 22:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50478895F;
	Fri, 14 Jun 2024 00:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lFsbYu5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F15C888961; Fri, 14 Jun 2024 00:18:14 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFB0884CA
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 00:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24542b8607fso787794fac.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718317091; x=1718921891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F84kRflMu+RVEvEApHKs4CP+WI6zAKqoo53C+QBJ5vo=;
 b=lFsbYu5GXxt+hP9TYoq/lrQcCASgt6Lxc9W2+rzeYI6Rcsn2Fd2QSNO1ZflsSPz5Ne
 /gkrC48JDtaBJAqb7ooasFGiFEHqHHR3OYcdiuPH1LsswqFX62+ngheTuUVnG+kkzMb/
 e7G5qwAl4R0zviiDlQPsWybwEIGTM3VnDgUCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718317091; x=1718921891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F84kRflMu+RVEvEApHKs4CP+WI6zAKqoo53C+QBJ5vo=;
 b=N5fEwhfOa2YFGZQ3SQOXutfkGCvsuHjT4YL4C8aKv/8tlikpEay1NS/yxKKGMBKLxK
 nIdmb2PMDrpKHKmE2V7+Nvm09ahNu3KMDPQfeLiZYFaFOvNqIp/B9Myfx01D1SKWFSUW
 4MidEqPbLfh+CLmD0XToLF0C8zBVYpjM9A0p5NUsuLjGOTDNIEPTLyfuc7EcwJvoz/5G
 cwqd0vYijS71Kr1ey4QkJ91nGeHYjd4MX7bCLU261OOElJNfU7Meqd8Y9eZKC1g5KXSw
 32H4199S/HpnPJBpjH88V5Es/bCjmnr8WScStXjsqBi1FFeY4/I4TIs1Dy0HU0DPJ1Sa
 gbTw==
X-Gm-Message-State: AOJu0YxOj5JXs89nVCm6HV/rnKKGkmF1lbWt9nAzZZuuJ6zxNA0b+OtN
 5SN1Z3uI6TlFS+4NGwNvyA52ZDY1aifOum+u+vxVrcLnxy9y82YR7oP4biM7YrQ=
X-Google-Smtp-Source: AGHT+IEXyLB304akbRljz1KtKY4me7WnfcPuiumn6rAtfPNcHOtzXa1U2Ir5pmZXlsYx3JOtf2urzg==
X-Received: by 2002:a05:6870:1494:b0:254:b1b1:7ea4 with SMTP id
 586e51a60fabf-25842893a01mr993359fac.12.1718317090796; 
 Thu, 13 Jun 2024 15:18:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa79c65sm626596fac.33.2024.06.13.15.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 15:18:10 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:18:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 0/3] automatically add /chosen/kaslr-seed and
 deduplicate code
Message-ID: <20240613221807.GA2448330@bill-the-cat>
References: <20240530220634.155951-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iPaVt4AMAoqqaNMP"
Content-Disposition: inline
In-Reply-To: <20240530220634.155951-1-tharvey@gateworks.com>
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


--iPaVt4AMAoqqaNMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 03:06:31PM -0700, Tim Harvey wrote:

> This series will automatically add /chosen/kaslr-seed to the dt if DM_RNG=
 is enabled
> during the boot process.
>    =20
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>=20
> If we have DM_RNG enabled populate this value automatically when
> fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> is enabled as its implementation uses a different source of entropy
> that is not yet implemented as DM_RNG. We also skip this if
> MEASURED_BOOT is enabled as in that case any modifications to the
> dt will cause measured boot to fail (although there are many other
> places the dt is altered).
>=20
> As this fdt node is added elsewhere create a library function and
> use it to deduplicate code. We will provide a parameter to overwrite
> the node if present. =20
>=20
> For our automatic injection, we will use the first rng device and
> not overwrite if already present with a non-zero value (which may
> have been populated by an earlier boot stage). This way if a board
> specific ft_board_setup() function wants to customize this behavior
> it can call fdt_kaslrseed with a rng device index of its choosing and
> set overwrite true.
>    =20
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
>=20
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.

This needs to be reworked / update the test that now breaks:
https://source.denx.de/u-boot/u-boot/-/jobs/849988#L264

--=20
Tom

--iPaVt4AMAoqqaNMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrcBkACgkQFHw5/5Y0
tywGAwwApFEeC2P33QIKxEeaSqzyxrxuqUOO5fXQPsYvKghFaJwrgRxaPBgJVEd4
8Hkm13dJGGrvMjPprPNPDnyu3oO4fyPFdHlGlHz41OU6MIPswG8iCv5Krmi5gOx7
f0MGzSKM/u8010yUyaHTRNKgrKbGGYDBEq7RsG0ZJR1Tw7m5ofcz6w3D60luqad7
G2loTuDsvgqTf6fuxmnHt/2h3wuTPaz4kiGKxZKiMG+++VopctusYIgzZfWMk84D
T5gM34+d8GqVCwBdCukIj70XsSEOlD8ZwsvyM5bhT6QA3vJ9eMzdnegMQqjJIrMz
idBr2iJ3AQBIF4gZSdWN5Z2LWR6aS9u4yNATuqkwq7VpOaGlnnlZimw7iz2urMB6
ANVaryRRxrN+Qw4cdvlK5CSv3yutpARsHWRh+BZrjXEWo+DF8SeLiOBJS2QCaaYy
cgmstHeUXrJ/DOIcIRNBmjm3oAz5SskqU8JJjojtDflxLFpNhSOSQ1gSFzU3GQ1Z
Zn26Gteb
=yU2B
-----END PGP SIGNATURE-----

--iPaVt4AMAoqqaNMP--
