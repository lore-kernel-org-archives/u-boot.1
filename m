Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DABC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03A587BBA;
	Wed, 17 Jan 2024 15:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rGPHG6KF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79CC87B9C; Wed, 17 Jan 2024 15:27:05 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5341987B6E
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5edfcba97e3so117060567b3.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501622; x=1706106422; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=suJWHQ+m6KbnzFLJTSP8uiWENLxjIRLzYmamcvb44Wk=;
 b=rGPHG6KFMIgDqCI3aa+oXuJWgeMpTdqbh4sqjBZRWE4a2QueUtf5c62fvy4lhtoCI2
 v8Hm14GqYsxOkdPd/kPgM/hS11wHX/I/H67zZf+F0j8UXfKBO0mVsmwThMODOBdFsBUH
 NHBixHEhARE3IVDPWhoHR84HKxCI2Bcs4u4z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501622; x=1706106422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suJWHQ+m6KbnzFLJTSP8uiWENLxjIRLzYmamcvb44Wk=;
 b=keYipDONZFAjclW6GC8MmEhf0RTt/xus2OCxJj8kysNWYZm1rB2cpyEBXefZ3WoRXe
 MmYXEgcStclwizCIbYY8x4ipRyQfdqLKqlnKpX5vJIHImHNjh2nB12GWaXPhCFH797FR
 cQr8EeNfcP5qwB5iujabMt3nzTc8ttCerUN1WUQtS5iDjqjkly9AMr6hSLdG2nPRszVS
 szhQAaEVha3w+cL3rygphAkDMzHsgIzZWBvX0J9uC2MvP0f6Yg/FM26jj15Kw5cM8zGj
 P5NnDja1MVydH2sR6vpKTV7wBpNVyb6ALS8587ltFqHj1O2YLE/39u0xbr7iZn8eKNRG
 crww==
X-Gm-Message-State: AOJu0Yx87u2qKuAa3KSR3NqAm7vA1+jTevLWJDF1SeRNxInFjSArOjq5
 J38lXbAKsN5idB7IGW8onWFpErmXMgzRqA==
X-Google-Smtp-Source: AGHT+IGO0OBDY/cA3VYgsR5SAhK6ffUE4pFMsctHsOS0u783ynsPsBu4BauPEj+T6iH8dp1Cca7eaA==
X-Received: by 2002:a81:9984:0:b0:5ef:78ad:b0b6 with SMTP id
 q126-20020a819984000000b005ef78adb0b6mr7170363ywg.69.1705501622102; 
 Wed, 17 Jan 2024 06:27:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 l13-20020a0de20d000000b005ff50fd9635sm1616400ywe.35.2024.01.17.06.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:27:01 -0800 (PST)
Date: Wed, 17 Jan 2024 09:27:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de, kamlesh@ti.com,
 m-chawdhry@ti.com, afd@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH] arm: dts: k3-j721e-binman: Add support for HS-SE 2.0
Message-ID: <20240117142700.GT12635@bill-the-cat>
References: <20231220113433.1690312-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gF33H2BGmFzu+BeL"
Content-Disposition: inline
In-Reply-To: <20231220113433.1690312-1-n-francis@ti.com>
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


--gF33H2BGmFzu+BeL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 05:04:33PM +0530, Neha Malcom Francis wrote:

> Add support for J721E HS-SE 2.0 device. Make use of the existing
> templates and override the phandles for sysfw.itb so that builds do not
> fail.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--gF33H2BGmFzu+BeL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn47QACgkQFHw5/5Y0
tyxXtwwAt+q3AuAP4eP+vBBweMRhXmrFm1NJNLM8qJ5HAvZVQjCdwUjsCQoIatmx
s12LZ0nrJBcfmFTys7QFK8VfE3+sbt443S+z0h2R0YnPtj0gLXOAJhb9lMFjZQTS
yD45TL3eKwXTaB9KoFrtrS7hiJOZ4ztCbI899fOPBRLZX1ZJvhZpKVjrmffeyCg6
e/oaIFUoS/8GPV9rjD0Im6lLYyetT10VCdMM++qqGBJrgk5fxynYjfAnVw5yv2ht
rSM7jnScESyeZz3fyAvLjyaF6z6Fu3H4CRtTWDG1XWg0wHj46/10ZUjmyBU89fuc
x/r9FIulvRF9zJDVaXHYq2q/XIecLxUOpvDG6FHlR570C+OgZqbWbDBVePojkNFB
GK54M2k8KT8jYke5vae4e95TK0++lzTgsEn5Upu7qjlEPkBvztfBTYQfdTX8B2u5
qHjajdSozrZtiywOybQ6Roe5pnknBP5QOHR04x80QX2wQT4vhMPYGoHeVOsT+QqW
YSPptskC
=57GO
-----END PGP SIGNATURE-----

--gF33H2BGmFzu+BeL--
