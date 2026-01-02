Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C55FFA3748
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 925A183A2D;
	Fri,  2 Jan 2026 15:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VcAG2RoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC2A83A3D; Fri,  2 Jan 2026 15:43:16 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE51839AC
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45330fe6e1bso7210710b6e.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767364993; x=1767969793; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f6ktQBounpaQArsptfmcKLZONV3pZvxyQ/DPhj7VKpc=;
 b=VcAG2RoTpVrB22M3DEjT5oAMf4Wck4SXPWTytP6aMTQFSt1OJ5XqN3YOCguxpTQJ7M
 WA0wOMRpeVyXOagE7QsuPMsbB2RD3UwaWfZRq8QNTF6Y6cey5FrLrWPeSShUlAmN9a5h
 R2upExzp4LIs94mwpuS05QHmqQbmnwqUUgWpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767364993; x=1767969793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6ktQBounpaQArsptfmcKLZONV3pZvxyQ/DPhj7VKpc=;
 b=uUdsjIvtERjSUHUiK9jgNWvMwefyoFiP13WIKATg5LXAObEb+P+sGOJS62wgKhSoKw
 mtvHDwGTU0tjCaE/dc+3fgXV8jgsnG9qIwM6CB6xoIAncQFZtwTqjx0dv/MQ6121fGjV
 138tul9EAi3o7zUmxcRR15/ncwoiodGAW2AIwnVyh0b3znypPESpkX7Egtd/LawfxtD7
 Ekr9HHjfO/JhVP0bfc4Gl7WSz3sFbBmjnYokfTMq2IhP098pQYpBJ6A0Sv1crRjbJNff
 o10fALnrc/RJ/7f78p0XcS3GiCWWAMfOLfHhXh93+yVgwVifWOJvm1tTaHcRsjSG5P7D
 TMVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI0Jc9cGCwM84KvLZ8M8Bqdwn6rmUp5RjFhTM+IdJ1bN/naQmwOez9erMcSz0wOS5MFYywLx0=@lists.denx.de
X-Gm-Message-State: AOJu0YxwffM04EwskfVgQn7fEEP0jATf2g2wQ4UVzg9U4rI/VkHrymzg
 ESio1RiuWpBKx4jEQwUWhsrjOtGFDy0ZsDTLTtYz+rtnuHD04PW1BVl9JlP4gV/n0Nc=
X-Gm-Gg: AY/fxX6pARUdzs6bClFZb3TtRfER/i0hayASn/TKJK2U3wdqL2iMd5jQL5EjjgskjwQ
 D8PGL0lof3sTF3dy1ImiJ7k90eAIkOnSiJ+zbxNCpnqoM92LJKWwCgqOn9ww1MaPaKuhS3zKoRR
 X3RQBO79uEFLu6Z8dYzVcszb24EHObf5GgH2Gw6vVH+z6CBoyYiQN832bYuXrIqg7rko46QFagC
 ZeA0JgZsZ6nXwoxchRkcS1gYO2AlbChmDj6Rx73O/N2EviIuQcg8ArroH9Ca/UAP6AwsDj0gYyb
 JitNVYn6SdNb8u83T+D5dwPmRCoqhgdCph1yapwrjibofp5jtLvCu/hLSyDV/SWoDWxBjEZcUJt
 D4sISi4GEaVCg7p3AypMO/IcSNJS6Bhd6QfOJDibOD4RpYkq/UJGNQx+NjpaYAfv0CXw5DGW88Z
 hip0gdKe2hQTnnVEqvmqZkKs3TWFvxRKu0HtuAHHpk6c5wVskA/fCyOArcOlMBdg+evsVMh8cMK
 5sX+gNc5+iuC+th5wLor3QoCnnRQ/AJZ/vJC80=
X-Google-Smtp-Source: AGHT+IGlWrWFLJcH4QSCiSKbEtKSc+Hrh/jpuT3PEwA3PNKKgkwRwrrU9jgteROc4Km19YBf9jxtfA==
X-Received: by 2002:a05:6808:5088:b0:450:b14:7a6a with SMTP id
 5614622812f47-457b20403f4mr21106082b6e.60.1767364993135; 
 Fri, 02 Jan 2026 06:43:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667563ffsm28460582a34.13.2026.01.02.06.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 06:43:12 -0800 (PST)
Date: Fri, 2 Jan 2026 08:43:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com,
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 00/11] Add support to boot TI K3 HSM M4 core
Message-ID: <20260102144310.GA6124@bill-the-cat>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="24w5qNLmg5M0Uto1"
Content-Disposition: inline
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
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


--24w5qNLmg5M0Uto1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 11:06:10PM +0530, Beleswar Padhi wrote:
> Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
> Module) M4F core in the Wakeup Voltage Domain which could be used to
> run secure services like Authentication. Boot flow for HSM M4 core is
> different than the general purpose M4F cores, and is as below:
>=20
> 1. Request control of HSM M4F remote processor.
> 2. Assert Reset on the HSM M4F remote processor.
> 3. Request Secure Entity to Authenticate and Load HSM firmware into
>    core's internal SRAM memory region. For GP device, load the firmware
>    manually into core's SRAM region.
> 4. Deassert Reset on the HSM M4F remote processor.
> 5. Release control of HSM M4F remote processor.
>=20
> This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
> firmware is packed inside the tispl.bin fit image. The firmware is
> unpacked into a temporary DDR address which is then used to load HSM
> core. The configs to boot HSM M4 core are disabled by default.
>=20
> Note:
> This series is dependent on the device-tree changes series posted to
> Kernel mailing list:
> https://lore.kernel.org/all/20251231165102.950644-1-b-padhi@ti.com/

I see there's already feedback there and I expect at least a v2, so I'm
going to mark this series as RFC. As I expect you'll have to change
this, please wait to do v4 until the dts portion is in linux-next. I'll
look over this series itself now for high level things, and leave it to
TI folks to poke at any specific details, thanks.

--=20
Tom

--24w5qNLmg5M0Uto1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVfZegAKCRAr4qD1Cr/k
ChF5AQCPglEVDlRcZeRQLB0t/QldLqz+tMbcKyZZN8DAgL9G7QEAxKSXIrEJ/1r+
dsJSOscZZiYOnsMaWJh/nXl7q0Sseg8=
=/0ow
-----END PGP SIGNATURE-----

--24w5qNLmg5M0Uto1--
