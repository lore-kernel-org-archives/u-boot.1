Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D26CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D6783700;
	Sun, 26 Oct 2025 16:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ga7TnrAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA4382E34; Sun, 26 Oct 2025 16:40:44 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE72836EE
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c5333e7033so176530a34.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761493241; x=1762098041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PQpW8MIBTfueyaYy0g7OaJ5pKrxqKApxSqZUHzUtnPY=;
 b=Ga7TnrAFJaQlfZLlG2x6OC7yAmJ/LBNqucGfL8W+OyL3P2vP7y0+f/E/Fk63bAN0Dc
 /Mjg9dZ2r19idFVmNxPBBvxK4gk018wflXHVzEy88Hb4nI9zbTgG10+1qTIc/IyAVyaG
 Swwm7RUsnBxqOaGaKRXHje90O7r4gBA/s5UJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761493241; x=1762098041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQpW8MIBTfueyaYy0g7OaJ5pKrxqKApxSqZUHzUtnPY=;
 b=njn8NwUqCBe7gdalCE0WVwb/du8zgy9ChjFlblqfNk8XrpBv1Dkx8DYlIIRndce/Tq
 03G2Kvhrnmjljr6TWFNAEmhAkLRA0n7gLWg1C8ouvpowQoG2ygZhRdJct2Ikl8kTVARs
 DqJ18l2199IT73g1g3E+HNmWDrGramW0tKfMVeG49HDWXUQLDnMepj7GdHsT219iJ+RZ
 KymG7SYMQO+2/xUJZe/VfJotNAjtDpL4ZJGp5QbeJGJOm2vAzNn7+BxPMs5Id/GzbJ69
 crABTq7pQQHZviRglZmUO59tfdl20b0jBCr0ZiPaZbp8S9pVtm4Sy3HXF4pkpOS6uUGJ
 ePgQ==
X-Gm-Message-State: AOJu0Yy/0G0btzYnsghH9+1Up0WRn2huirLXze32bRhYRKhXIAmkQ4GQ
 jcFfMajub+WjcutLGPdMJoC4R/G38JUzeSQJIKTCMf6jOiyIQh9HUqCfnaW4ybKLvus=
X-Gm-Gg: ASbGncsmcO2vN8MUMt9d2R7+K/dylXNXr6QjGnXM4TMR0hEUfxVjlukZBhVAgeQVz2A
 PHy/AdfhdyWx0PyQEn5wmLcV42vvH3bvy3xc06wPaK46xPfj2Q8MrpWKLdlYsWAPhPJh+B+9dN6
 UdBRXp0sTN5NN7vZktxtQn2BWG7cP+HgztPIJ88piXrNSX58l2nAU+JFKK5XdhyA3FvUWXKlbml
 YnIUzVo522Z6t9lyMxX7izybUBVXX/prKNd1nZ4Fclk1rYrwZ8KaAguM/9aGXVuuTCVanRxHM8I
 JkD8qOog3C2wkLhd9/JqNNuHIvDtQoOKKtl8FhlGIAHdx9cTNyX4RKUmdtVwcue4D95x1Po78BU
 sx0mwRmJBjhk075TrncmkFTy8szbMnjKI7a+nM56Ffd7WGOX8vsOPilbeBkSNMFa56RGlnDXNUZ
 IYITd/YCpeGomlUtRaJnXjXJ+qg2zRznMQ6G7bhSVxKAp6/JOhFA==
X-Google-Smtp-Source: AGHT+IEIpJ9qXNu2i90gR+YqNYR0gJ4vEu6/P3cSgwjmmGDjtVsWjKKzBYkNf9E6dlMEfEDJf66HHQ==
X-Received: by 2002:a05:6870:96a4:b0:37e:b2e3:dae4 with SMTP id
 586e51a60fabf-3d1771bf704mr2879786fac.13.1761493240837; 
 Sun, 26 Oct 2025 08:40:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e395cbf1sm1658327fac.20.2025.10.26.08.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 08:40:39 -0700 (PDT)
Date: Sun, 26 Oct 2025 09:40:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Pull request efi-2026-01-rc1-2
Message-ID: <20251026154037.GV6688@bill-the-cat>
References: <9793c710-20c9-4536-941f-9ed50793f8fe@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3U5vQNtHgsnydVdv"
Content-Disposition: inline
In-Reply-To: <9793c710-20c9-4536-941f-9ed50793f8fe@gmx.de>
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


--3U5vQNtHgsnydVdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 01:47:50PM +0000, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit fd976ff3a233ae7c6a9f5bec790b02bbbf57bb=
24:
>=20
>   Merge patch series "firmware: scmi: Support SCMI LMM/CPU protocol for
> i.MX95" (2025-10-24 13:47:50 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-01-rc1-2
>=20
> for you to fetch changes up to d4fc62452be05c4aebe951b3855b4523aed077cb:
>=20
>   doc/usage: Add a reference to General rules for commands (2025-10-26
> 10:24:50 +0000)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28024
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3U5vQNtHgsnydVdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP5A8gAKCRAr4qD1Cr/k
CrPYAQDEesw0esEGXlEkxPGkBchftBeFroVspGGUMNQAVZe8hwEA7yhv3x+umrB+
39MXV9jIR72VSuzC9FariJi0akJmVwQ=
=6HTm
-----END PGP SIGNATURE-----

--3U5vQNtHgsnydVdv--
