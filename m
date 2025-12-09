Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51036D3B981
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 16:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8D6830A0;
	Tue,  9 Dec 2025 17:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MUmLD0cQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1F283C40; Tue,  9 Dec 2025 17:27:28 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFAA80FA1
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 17:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c704bf2d9eso3538164a34.0
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765297645; x=1765902445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cgljv7eYDFKYdHDRvW4k9W0aBTaOP9XPPMax/me05KM=;
 b=MUmLD0cQC+Q5oCHG5/DpxUYsgiKorzYyJWtygoHdfRZEd/gO1eVPw8A2Ode4MgrVqR
 43Ko18zeoCOef4g573IKEk+9iT+4VoYMdZtsKHm5S44ogntMEuFtR2NOF9z9FvEl1l5N
 6WzkM0QxwFuJulAv2W7Gtdb1SJpNG/5+QijU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297645; x=1765902445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cgljv7eYDFKYdHDRvW4k9W0aBTaOP9XPPMax/me05KM=;
 b=YNQwBZAfSMsbalHaaOFb4Bp9Pe6Rb1uYLXKmkieYwfXXlvvw3qMWsrfKMFur8o0if1
 vgUd3hsv4Wkie00zddYnwKj3d+uMahdJqv01qcOCpf7rPiDCZgwJuGBzisaZpCxSYeAM
 QHPJHETi1Wd8spCgYyLePchunxzcfmdKffrJb6tATClFNtfUnwwGGtsHCyTKsu9S1uyx
 MFNtnYEnhVHcbbdr2x9PRYZjh/PaKZ7fzMSTJ35RyuL0bZ95mtw/hFys1kuRaO2hdiYh
 wRFGjrFDz9qpMw3zb5FQX2AWLmFUl9jQ2vzWJwkeqE6PpQ2TCOSE3kif9mGCPQMAY3fg
 AW3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2FeBmLZF9gkMqHQeJJX5SecKH340FB+bO3CouqudH5ZVyYA3+ndBfC0/EH9urLImvURxUZcE=@lists.denx.de
X-Gm-Message-State: AOJu0YyqhBqyCdrqcaX/oWHnCADF/FRJiHfysrFXVh4uR2P4RFlF5mWT
 cOBX8nUubmOio42vMXcqOd06oPX+xO1IrjC2Es4l5UzVx5h3IITRiIW6XPRXyoEpOps=
X-Gm-Gg: ASbGnct5iv1LpKQo/aEr47O65xJZugrXPUt7xLbnTflhvAbllMmllStcrPnuytdqsXc
 OnurUfXdamDi52IVX6kNsoKVn5z/Q/4OhgD9ni7eOwcT/dJI4SJEcLIIhsplcj1FemcxU39cc21
 SVqxrqoE/5w1FGdj3axmmvXkXhZV3E8cOShXPWggvxOH1MibqK7T7eF8Uub1B4p8+clj7jeVde1
 r/grgT8xw1TtE1U8tIUkMQPVub8xk65basTtexbZE6giInUI5RwaUKl06S5NeiezzZ1D4vYtoY6
 3NMj9Miom8wdYSuGL+pTZpQAsG2+xcgxidj19ByMPPT3+wcui56fRO9D8Ju/cP5ZE2KlTxLCktE
 BGpbf/72DM7HsewE8Y7QAuYUnkCFG0LtX173yWy3cW645WpOwO6eZq5FILZK+oENtPhfwDcjJMH
 YjjyEIVL39d+X0LzQtpZNnXswdZ+JbMNAyYMV+eWuUVL2Z4u/g+A==
X-Google-Smtp-Source: AGHT+IGbE4w/s9716d2aGPTv/99AsOM8ehDGKnttvWb4wsNBJe7AzgPjx5z408eH7Ee0eiizN5inPw==
X-Received: by 2002:a05:6830:2541:b0:7af:1d61:1055 with SMTP id
 46e09a7af769-7c9707ca9femr5919231a34.21.1765297645143; 
 Tue, 09 Dec 2025 08:27:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acb0565sm12236085a34.24.2025.12.09.08.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:27:24 -0800 (PST)
Date: Tue, 9 Dec 2025 10:27:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, jm@ti.com, nm@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] configs: am43xx: Migrate to CONFIG_SYS_MEM_TOP_HIDE from
 CFG_PRAM
Message-ID: <20251209162722.GZ303283@bill-the-cat>
References: <20251209055043.1410085-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ide4hCTQGrPcN9oB"
Content-Disposition: inline
In-Reply-To: <20251209055043.1410085-1-b-padhi@ti.com>
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


--Ide4hCTQGrPcN9oB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 11:20:43AM +0530, Beleswar Padhi wrote:

> The TI AM43xx HS boards have been using CFG_PRAM to hide the top 64MB
> firewalled DRAM memory from U-Boot. However, CFG_PRAM only prevents
> U-Boot from relocating into that memory, but it is still open for access
> for any other usage.
>=20
> Therefore, migrate into using CONFIG_SYS_MEM_TOP_HIDE which reduces the
> ram size itself ensuring that memory is not visible to U-Boot at all
> (either for reloc, or general usage).
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

So, since it sounds like we're failing to boot now and this fixes, it,
it's fine for the release. But what's using the memory under CFG_PRAM,
if we aren't relocating ourselves? I want to better understand the
failure case here, thanks!

--=20
Tom

--Ide4hCTQGrPcN9oB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaThN5wAKCRAr4qD1Cr/k
CvHwAP9g4Ng49nihJoxP55tRT/1n6BXqgMcWOx3Xs+C2JzLLzwEAt4ZLvNwD9lI6
4PXErA7yNBvk3F+owUC6qsDF+j1kXgk=
=F8nU
-----END PGP SIGNATURE-----

--Ide4hCTQGrPcN9oB--
