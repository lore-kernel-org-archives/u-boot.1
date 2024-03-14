Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D043FC54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1673587FAA;
	Thu, 14 Mar 2024 01:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QJJerEzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B4687FAD; Thu, 14 Mar 2024 01:40:10 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E600387FA3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42f3d88bc20so1740861cf.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376806; x=1710981606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xzr3hmgLk0sZVVSg/POOADPKvhtFytcECKgnzCcBbUA=;
 b=QJJerEzPAbmEOvRTZkqQ4o4QL5HYHYW9rjuCvczNojqYkUEWeIGOf/L3OEZlbhOgea
 z7VzxTWZ3AtXCT3l+3x8huwsK1/kTJ/vTmHjt5oZn2y1h5cNaVPVK1D9rmrrPNG6OJKU
 aYDrP8pSBkYAaCmZ6V8mfj+FxgrhMPB4MRVQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376806; x=1710981606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xzr3hmgLk0sZVVSg/POOADPKvhtFytcECKgnzCcBbUA=;
 b=pFIzCzDrZt4OgwG6vuUWxYf1Tr3q8ebw/WmOtr+8Ibf/7+j+awbtD98oQK1doL5DFL
 FNkzBcFlrChGy2E9ufOzAJpEy07kX60icCFVN/TJTGbE9qO10LYbTPr/3Li6DwrdqfeO
 ZIOSimrgdtII/dE20eieU8dBXBCQLQ+z2XWMzVfg0u5PtXTjfXFIuA9hrlGz7h9Zuiyt
 bPnB/7m9RelhI4tZJuOrv4sWcmMlmOzH1PCXD8sKl0vLY9tnT+PNEZBlRnziV8fJtXe6
 CemxocAa6IBDBabaQPpkoMUpBGhTsk1BDLEwZ1pDgyEi3Iyjgd1DFBDgiosWkC2S5GDy
 q7GQ==
X-Gm-Message-State: AOJu0YyAkZarB9xfRRQholzaYl/dE3yIG4MKJK/13t5A8rw4hEi0atvz
 3DlFwx4Nv49EVoSdbcB9v0Vc4CMgKKbffnA+DhWVfRYII3lTHPkiObdwYfeYC2g=
X-Google-Smtp-Source: AGHT+IF/IvX1pE2KowepAl7HsTy6wcgxQ6UCz+C5fCl66ZEpk7GdPj4U5BtE8GZ9rpiWuewRAW24Og==
X-Received: by 2002:a0c:f10c:0:b0:690:b7b3:76da with SMTP id
 i12-20020a0cf10c000000b00690b7b376damr323874qvl.62.1710376806123; 
 Wed, 13 Mar 2024 17:40:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 e5-20020a0562140d8500b00690daede7f2sm227135qve.54.2024.03.13.17.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:40:05 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:40:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] board: developerbox: fix mem_map setup timing
Message-ID: <20240314004003.GM3442575@bill-the-cat>
References: <20240306061110.2514611-1-kojima.masahisa@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HuNjpeu1ti0/IPVM"
Content-Disposition: inline
In-Reply-To: <20240306061110.2514611-1-kojima.masahisa@socionext.com>
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


--HuNjpeu1ti0/IPVM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 03:11:10PM +0900, Masahisa Kojima wrote:

> The setup of global variable mem_map was moved into enable_caches()
> by commit a70c75cabae1 ("board: developerbox: move mem_map setup later")
> since U-Boot was directly booted from NOR flash in XIP
> and bss is not yet available in dram_init() at that time.
> This has a problem, mem_map variable is used by
> the get_page_table_size() to calculate the page table size,
> but get_page_table_size() is called earlier than enable_caches()
> which fills mem_map variable. With that, U-Boot fails to boot when
> 64GB DIMM is installed.
>=20
> Currently U-Boot on the Developerbox board is not booted in XIP
> and bss is available in dram_init(), let's move mem_map setup
> in dram_init().
>=20
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>

Applied to u-boot/next, thanks!

--=20
Tom

--HuNjpeu1ti0/IPVM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR2MACgkQFHw5/5Y0
tywAJwwAreSCsaO6avjc48brTtPIBQ2NYmzDpNechaE/rBpJ429LV+Zely7SO2pp
HvFcaMrejZ/mXa/BQTqi5nJ9ezQPzaAkvKoYQvK6AxO+7nTN7OrBHSUN42cnBFBR
RR01xHpu0KYwt11YgZAt7JmrL24+XKwwTkAxbsU0BYVFzUUKBAX+qGK8D6NPcHP6
ZkyQRrJ8tsfZ4JzYbpTsYjRrXqJq02SJQgnA9lKHTzBvU5VtcrNi4ffV0ejGmkaL
BDx7d9S9wOxX06y4Ixk8Xb/4KDwsvbRivhpSy1gfRH004zKhyZWwbNSqnD7betBs
/rNl6T2cTPqNGLkZNlbN6may5ZDzhkmZs2zKEK2tISTnNyX3/OgJXNUs/0I1QGZe
XxHI6ikzwbZDcdd8IbJ/RhCkdfAkkoqvr/yMhb5fVJXXkDm8nIfAPlTdRiCRzJRT
Iqxc/qlgX0mE85dPuYXFibP4/AIG6Riw3cJtTkx/EJ4bQYfddxob/FN4XW6oDCGn
MLJHzUBR
=d9UN
-----END PGP SIGNATURE-----

--HuNjpeu1ti0/IPVM--
