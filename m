Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCD9C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF402831C2;
	Sat, 24 May 2025 16:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tvu165wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F45583327; Sat, 24 May 2025 16:22:27 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2788882AE2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40337dd3847so574050b6e.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748096544; x=1748701344; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kn+Oga0DfvwumpZqQydRg2eD93R9mURQASXIW35aAWY=;
 b=Tvu165wPeA5VRwrisq9ukhM0dPAMcQHwEcWtpuxmYfdpx82HAsbdl3Jv7PP6+CjOqM
 D0Beomu5OYSHqgG3kfaIfENTid9CG/CwDelZ7Mt5T12e3yOo+dZG8RR8fwmR9kwwn9sB
 Zi2Oy9JIbiwan9JXaFgb9Yb1sEAsj92wy3XCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748096544; x=1748701344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kn+Oga0DfvwumpZqQydRg2eD93R9mURQASXIW35aAWY=;
 b=LC5RWw23XD7VAaxC4z7/p1rT3CKnpMdbZuMbvVQVF5xtNt0qWP3evLMBir1oD/rV9k
 54rhSHqSjhtQYspxAKuU7lP+01ZMvwZG5oLYRNJHXK8fuoVgaTK94U2Nkmt2szSD6PgS
 8jBGKzV3xSd/aRMZS0m6WmqZQuPD2Tjm7fqgoVu72uxoqRkbTAsU//j4fL+yrsCBZbBc
 mdo6kvtq2bCnbTJwAFRZxBgMOdk9IuGcwHufpbTxhRHDaVXQOCF83bwo+xLzVmMkL6x/
 X2EOtW/8nIWrZTPFMyxABTQUZde7y7rjmRWK1yrtDV5ArCqFMisxlfLgDpzgdekkZRhc
 yvuw==
X-Gm-Message-State: AOJu0YyFrzcmz9HN9NCKbIfDYxGYRpZ174K+NKpoTVJhUeyoYKHV9sWN
 F7xHV0O92g6VVHgJf6CbyKWrQMtaE3FTJoirARPXhEqZi4YpGhKn0DEHZODbfcDowCE=
X-Gm-Gg: ASbGncv0bVowGxdVUHlLd+fxUv54ONPl+TYs0mqi961UfoPq2OjDQOGwvFDQw+DzVLZ
 jlh2K79lXD1VyJxB/f5zYMbGfLYMHPFIXWkPEjiJBn/sJVBLlnv85cW0fr57/2jabKoRa9yiJ0m
 c8aPXPI9vRRm0zLyPKL/rwpEx7p/Jp3wYl2+cxsAFP+Pomz5TacgD4RqxgNdtPBDeJIfOOQaSZi
 bZKsWS2hBMpn66nK4aSJY4/blxpVX13/Cm4WxvRC8u5OKYBhyvv4pd7qqQMpYZdXiOHy55k+LlS
 EocPuVEs8cQQm9f6odDsiKsl/GHrBjLlv5GYiTXy0pVNqiM1ndt4L7Cpaoljx65dkeVSDjba2r7
 emxIdUmLF4ZBO
X-Google-Smtp-Source: AGHT+IF/ycE4hd9I1r+V8+gTB/rGMEP5vZ8PlUCLhFcXik9GU79x/EkSJzsvHGESfVtd8TvPj/bpgw==
X-Received: by 2002:a05:6808:3a0a:b0:403:28ab:cfe4 with SMTP id
 5614622812f47-406467e3b1dmr1625892b6e.22.1748096543724; 
 Sat, 24 May 2025 07:22:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98b2714sm3469983b6e.39.2025.05.24.07.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:22:22 -0700 (PDT)
Date: Sat, 24 May 2025 08:22:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
Message-ID: <20250524142220.GD100073@bill-the-cat>
References: <20250524120904.684977-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pHwOB5h2Bvrxc62x"
Content-Disposition: inline
In-Reply-To: <20250524120904.684977-1-sjg@chromium.org>
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


--pHwOB5h2Bvrxc62x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 01:09:00PM +0100, Simon Glass wrote:

> A previously rejected patch to move the EFI public cerificate out of the
> devicetree has recently been applied. This series reverts the change,
> pending further discussion as to why it was accepted.
>=20
>=20
> Simon Glass (3):
>   Revert "efi_loader: Moved the generated ESL file to objtree"
>   Revert "efi_loader: Move public cert for capsules to .rodata"
>   Revert "doc: Update authenticated capsules documentation"

No one wants to discuss anything about your personal tree. None of the
reverted commit hashes are in mainline. Stop posting things about your
personal tree to the public list and asking for comments about them.

--=20
Tom

--pHwOB5h2Bvrxc62x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx1hwACgkQFHw5/5Y0
tyxecgv/bIN7nktDR9HWPFdUYxjTtcjk9T/ms3B7bWub8FhwADnyVDv1g00JtzPF
JzeNh7uX2pSJK7f05jtD9tr9s28EjXkKhY3hOI+U2xmSeu1qjUctbAKRFQ3S57c6
JNERaY3e+dqZ4fBsL28PxOcKeLBHAGHlb5xsTmviT8cvyG5SJZgZ7CYqcfjotq/6
CwDWfOg+/fun3hFTBJk/FsJaUb86yjEr3kgLB3CAC/Jb/GkmDsKEN9dOtriKJ8sA
U4Ts09JKnEZDCVqdqldpFxyymDazbxKG3/hLDB1oGtcT51swYj34grp39jjmGD+u
PrIS/I3GMFRWXrqVZNJYnBwx0XGTnhXcTUxd87t/9LFSSEh2tvwFZBSITISDfPRF
L+OXXnDFvkvwor/E1noG22CyTTOAe0gNEiHDveG0B4KQVH8K4vejShtohAmqglCK
t/T6bdzQLOakqEEkn1H2bfZG5kfLBOhHEhIj3Tva307We+s+oNw/sCdzpHXyOxoN
r302VYPT
=mm2H
-----END PGP SIGNATURE-----

--pHwOB5h2Bvrxc62x--
