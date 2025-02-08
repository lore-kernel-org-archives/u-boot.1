Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC6C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939EA8091B;
	Sat,  8 Feb 2025 22:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i5GnzBN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B6080944; Sat,  8 Feb 2025 22:33:55 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA10C80A29
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso2288387276.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739050432; x=1739655232; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AZRQ3N2uOhMcA+GG3JJkadylRrJ9aH4QE6aK4uozfgo=;
 b=i5GnzBN2jb/2kFRYOSkL0Eisq45IHrXPNQamJ4thLysc4+jF2CopNs3EEW2+/8F5WM
 OMHUf98FdcLN70j4H0sIo0nRlP4pw+0JwvBNS1Pk2A6mKaMSU4CXBXI5R6qUrv7UInF3
 wewxEjQsYB+8otbmXZhWDX/EjK/7gX5NOsZS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739050432; x=1739655232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZRQ3N2uOhMcA+GG3JJkadylRrJ9aH4QE6aK4uozfgo=;
 b=mo+n4io0duGpMe1TzEgJnWOL7IXUY1PquD2FwMK9EH0mgnsJDa+oTyHUO5NvQZcK3F
 ojmRvvXudvzSpu3aJi7JLAVoXFRwoNl3IOib9Y/pbXRe24jkrCbPKi3y3tgZ3IZ5Am7A
 73+DxD7zkUOKj+rCfP641qITd8HkbExKxMCov1mUcXOATqKCeXQYCkWN2r9zRXVEqGA8
 GjCy4WE+JE2e71belsU+w6vJRW6eofgAiCtjCBGLQEw7rbslHunpcVAzgglThtMmOG/L
 pm0gFhivBLeFPubN0I6uIzeKHTz1Wh401PFUlBAz8C6S0TJLKapW5HUWGLvM3E7uZYjj
 ShPA==
X-Gm-Message-State: AOJu0Yzd7eWMVe78Vd3RWcd0obgkokTFgTcJdyA1VA2oP3lVU+H4IJpK
 JbqMZRg2MTjjskN3i7V6YDKa+htgNQMSCl8VRW1e1HrtoK2qWcOPlcs4PV/CWbY=
X-Gm-Gg: ASbGncsfgs2c8cpv4TsEiPcA81V2Pc/DByhqAjvYLJL7eVWQNrK3StfdikBFuxFeBO1
 7q4q36l5vLFNA5LDxphHT69+9yHWefk2yL4QHdbjJhxRlGE35zdyHfeg4MCsklUfBIxDBE+L3sI
 a5Zop/Ij++SoCcnFDNprkEu2uybXmZ3u2v4EXJqnhUl2G1EqRbw5YZl5B4yJhix0z3ymQzyTfKX
 zOGIdZhwLUlWNBJbY1u9vjqKA3NugmbINy8sQQVOM5RC8GKix2vW9F6daP8HAbHCoEvV0mvS4k1
 YKOZyLIbcOv1jOY=
X-Google-Smtp-Source: AGHT+IHIBhlqM6uEw28J/aEJ8EmZ5vr06tKpLhl+H7JaritzJkl/WPyOEcGWLxYYBKVDYS0SVLeiVA==
X-Received: by 2002:a05:6902:2389:b0:e57:3c46:fc86 with SMTP id
 3f1490d57ef6-e5b462b177cmr7233949276.48.1739050431795; 
 Sat, 08 Feb 2025 13:33:51 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a45dd8esm1625867276.35.2025.02.08.13.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 13:33:50 -0800 (PST)
Date: Sat, 8 Feb 2025 15:33:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v2 23/29] efi: arm: Adjust how the monitor length is
 calculated
Message-ID: <20250208213347.GH1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-24-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EkzIAr2YFEMzieaj"
Content-Disposition: inline
In-Reply-To: <20250208171154.1305761-24-sjg@chromium.org>
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


--EkzIAr2YFEMzieaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 10:11:43AM -0700, Simon Glass wrote:

> Adjust the conditions to support the EFI app when running on ARM.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--EkzIAr2YFEMzieaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmenzbsACgkQFHw5/5Y0
tyw8XAv/S7uNMCbih2ZBn6Omc5uXDrU6FYa93AxSP9Bb0/nl9clBOJOpPXnGkApF
G8uoWx3NExPT2LQ52jXUyc75hJD0FAL/YTNlChLbtgh4lIrmF0V68KVhM3TfDN1u
Z6ReksAIcL0Z8JG8cpS5rcRYnGWD8HvWhrAEs80wS8RwPzVxYOHZhohoYplLYqwO
QJk6D6tpWCbgt5CL8wrJIdPHF8rk90GntoudyF7+byXIXbirCIBOPJg+PmwsMwSo
zam4HYyolMKKgBuQm3Vo/EmqJjixVG2hXmnw/4XCYqLX08tOBgZDN+QOPbD57uKK
sNqQ77hxLqe0iHS7aBccieQg5AWKgDr+Gn5ve7SKWzecsEdiVtnbQ85hCWzEcnox
zvyREgk5IWUeU4iJQ3K2FnsXXxqG70YF9+ATl3UfNCQeC65eapg8gF8TFuXnKVwF
orxuzUqBAKHeKthn1F0RgG/DazmhVsjZGlARoNV7F20DviTgGT90zMP1t3KZL4v9
14d5W1ku
=BN6J
-----END PGP SIGNATURE-----

--EkzIAr2YFEMzieaj--
