Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0283CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 19:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8258487F;
	Wed, 27 May 2026 21:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q+mlVzHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316C784886; Wed, 27 May 2026 21:26:13 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF09847C4
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso10247563a34.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779909969; x=1780514769; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VLKQ/9DNAs7bA+adBVvPG53W6LgqhzdG7xn8otFpcD0=;
 b=q+mlVzHrHntZ97NS3FhgYI/2JxuTTyGna728P0uj4DsO1z8PVjR6poX3owYcg8xA3A
 /MH23VpHDfTeJBEH60E+eVmfqQjBPBbtHSwbxyltmO13M9Fca6cbCDFwfO168EQOYhqg
 Rf7UuPmp1p9jR3ZPnHP5HoST1VcwE64lOz6WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779909969; x=1780514769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLKQ/9DNAs7bA+adBVvPG53W6LgqhzdG7xn8otFpcD0=;
 b=Etd+Kk8Img20RgRmsvy2bivvzGo9CUMb2ZqIrGnJXptuh1FTAMESHkFlmjO3OPA1C2
 OwNhmd8730gQ/QJvgJg/cFEVBGn+kn9G6+4czlAjmQRE8g4XOqZU75TIzJwJmyWoxNjW
 J20ib34u88/74nNQPd7T0tvsMdlfrE7vU1Q4G6IJvFh82JNPKZI0sP/AiKFDHXaoULGa
 T5vDkfv8Rhrn1irC0IejRGmkGPYx4cyAvLJdwtN2Cuuh+YvZhQ52bkUzQledXEXRe7eY
 6r4VQB405rOwRsP42dtMzWY9fgm2VJJGKf1hyQHiV+DkhYbBCViOxI3B103TlVYpXkt2
 OWtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QLDWZVfwJlHjkn2EvDECb9DIctkx8oExqnQ2PYtd6jbFywvhtDhzR+VYKksT8DO2NDFjNEFg=@lists.denx.de
X-Gm-Message-State: AOJu0YxKht5YT0Oud9GQt096lO4RVHmqF4/ZHXM6f9EjsKQpfQkWkcgy
 Eq5ipaD3ySbx6bDCuIHzIsU9jQLIRXO7zcVbkriUHDsByjbHN8O4n+iTmlNPxiJAG7w=
X-Gm-Gg: Acq92OFdW2hRnSuG7PJBYPZlekTGSyT0MOGfGfgPqNqcGmo476j1D6K2u5EoF2ILq7F
 UfshxW/yYru/HnpId054hmiimrFN0UDWHEkuH7nruLuYNTgpU1L599xP4eKBoMckH1aldgZlwBs
 Obu/Coel4kTnEL2zwpMv3Lrqw9V4QwRoF9zR51BwkCY6gvblCoyLF+ifs+QcyYJhDthXp3eJ9aA
 ZsrzrqWUl0Yj8ByFnRgLcz850M+GJdCZ3eygT3S8GlEj0RRNyv+D8MiXuRbjNHtg/kyGcTD+ynC
 MjF4XlXKhJoJ/hQ9uIk8hmZPXY799wRrcNglhH4g4qYkIvC+Y/Qh6GCaxHwlGy2LKlZbeRCE+JQ
 eGkZAI3iS425jAw7rzasMOcJXzwb81GyrOWnnZ5+/ZUwfwQdX+lyMK1Zks0hr1O50lz8V3Nlqi5
 Nt8/3VCsJRsI9W3b8CUchF0ISAcZNEus+n60Gd5HLPhZ39NCtG9K9PYy1VgU4lVUGYPEhFfF+yg
 rJP0LKyyKSD0KDez3lEzRr13K7Oh0qadgJus+MqAuoW7zzuUQHxF25BuaR8uE4kEb8=
X-Received: by 2002:a05:6820:1612:b0:696:982b:1c24 with SMTP id
 006d021491bc7-69d7ece2e97mr12435758eaf.57.1779909969524; 
 Wed, 27 May 2026 12:26:09 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aa422fsm7807111eaf.14.2026.05.27.12.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 12:26:08 -0700 (PDT)
Date: Wed, 27 May 2026 13:26:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/6] Relocate U-Boot in the last bank
Message-ID: <20260527192607.GI1858239@bill-the-cat>
References: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
 <20260527192501.GA93464@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EOdb1/DuM9ZWUuZn"
Content-Disposition: inline
In-Reply-To: <20260527192501.GA93464@bill-the-cat>
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


--EOdb1/DuM9ZWUuZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 01:25:01PM -0600, Tom Rini wrote:
> On Fri, May 15, 2026 at 04:52:21PM +0300, Ilias Apalodimas wrote:
>=20
> > Hi This is v4 of [1][2][3]!
> >=20
> > There was a discussion recently on the mailing lists regarding our
> > management of memory above ram_top [0]. The tl;dr is that we have two p=
roblems.
>=20
> FWIW, you dropped the reference to [0] which is:
> https://lore.kernel.org/u-boot/CAC_iWjKFAzpj3B_MEW7-dnOrcAV-rfkhXXo8Bv0Kg=
LNP2VJxRA@mail.gmail.com/
>=20
> > The first one is that U-Boot always relocates to the top of the first a=
vailable
> > bank unless there's special board code to sidestep that. The second is =
we don't
> > successfully deal with devices that can only do 32-bit DMA.
> >=20
> > This patch series deals with the first problem by adding a Kconfig opti=
on
> > allowing platforms to relocate to the top of the last discovered bank.
> >=20
> > It's worth noting that this is easily testable with QEMU
> >=20
> > qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
> >     -machine virt,secure=3Doff \
> >     -bios u-boot.bin \
> >     -device virtio-rng-pci \
> >     -drive id=3Dos,if=3Dnone,file=3D"$image" \
> >     -device virtio-blk-device,drive=3Dos \
> >     -object memory-backend-ram,id=3Dram0,size=3D4G \
> >     -object memory-backend-ram,id=3Dram1,size=3D4G \
> >     -numa node,memdev=3Dram0 \
> >     -numa node,memdev=3Dram1
>=20
> So, now all of the sandbox runs in CI are failing over at least one of
> the existing tests, and the Pi 4 platforms over in the sage lab are also
> now failing the tftp kernel test.

Ah, sorry, wrong failures. Sandbox is fine. Pi 4 is not and is a failure
to boot:
https://source.denx.de/u-boot/u-boot/-/jobs/1464655
U-Boot 2026.07-rc3-00156-gc5e6dbd538d2 (May 27 2026 - 19:08:11 +0000)
DRAM:  1.9 GiB
mbox: Header response code invalid
RPI 4 Model B (0xb03115)
mbox: Header response code invalid
bcm2835: Could not set module 3 power state
initcall_run_r(): initcall board_init() failed
### ERROR ### Please RESET the board ###

--=20
Tom

--EOdb1/DuM9ZWUuZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahdFTgAKCRAr4qD1Cr/k
CvsvAQDiKP4k0iqAL29iMXLDmq13D3ITIEMy3F/boCGZNcT0hAD8Cnf0O2JderPV
VlyCfDmh3WXA+7Fsrj0r1cIjTMjzKQ8=
=26Sh
-----END PGP SIGNATURE-----

--EOdb1/DuM9ZWUuZn--
