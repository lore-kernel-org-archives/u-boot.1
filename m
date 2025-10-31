Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE9CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8775839F1;
	Fri, 31 Oct 2025 16:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZMxlmL4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20332839FA; Fri, 31 Oct 2025 16:54:34 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC661839E8
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3c97813e788so1542311fac.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761926070; x=1762530870; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NTji4JdYpOdXNSnln0MQiOoFjTgigSJBkxtGQ3Qm8Zk=;
 b=ZMxlmL4yTCGhlAhUGP9YBb7RnRrbYl+n/+IR2vJiEpw8OP9jEdHtru2/oHT6pr/Fzr
 igVzNShF+F+XFXFvkCHPqCvv92AID21F+XCZcaU0CKyAQ3j5O4q1xJMvqrwZTueNErf4
 kSM2OOvkKsT4L5ytn5Owbl0IF8laaGUUbR7c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761926070; x=1762530870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTji4JdYpOdXNSnln0MQiOoFjTgigSJBkxtGQ3Qm8Zk=;
 b=Osx3z76TW67D8vpdDqnOdloDmlUOIZGElXbhvvjIBj5F3CnbFzIUeCtp6lmNAHrqrc
 eDlmFhQJvYk44fZLjkVuAzdkEmI67F6NfVOB2/jnuZt0YcwAV16oOARka25zqiE8bhO7
 TpMKFAeIu0vPaVGxLyMDaJOYjE+JMbXng9ANEj7G3ki1ozZS31oTFfEtXiYXwMRfZLKa
 C2DwsyxlERB8S6rU7N1gHqk4eeBUa/h6mdZ6ZLMzxzaI7AkUr+yDvOxrrlVx9p0K8gMV
 mxE4vMcKv5Ca4YEuextSThJ13FgmGLpbfUYKyNaQY1E0qnoqkzUnfwpIdkwItBI5ghE7
 3kpA==
X-Gm-Message-State: AOJu0YwIbKU0givN6NtUhFO/JY6fzz9TnLGWvsECU+JoE8pmJB3bLUmL
 Dtp42IrPEU4BcofofNYuLmTSz1mUW6p103kNgL67WEV51ps7r8GMzDl2PGaFK5qt+Sn3NDerGsp
 j4RBcrXnzYg==
X-Gm-Gg: ASbGncvw+9VVktlyf/WgZ61SND+Ex/zTi7eYpSzVFItfBns8xTwGcWsaW16/AKZXssF
 y7DTkS5TWQQV1SEFUXYT09XpovYkQRM7nzatBa0+Dhz6Xd0nFdaropkNT8O0TIhMbaLaJsmw4hK
 wwNyeQ+haBbNw4/M2N+olhxBIgQdgFbVQzBjZhm/8D6vW559WsL4rYPM8iDs9d+vS/sJbJLGi1P
 +VEaxZ+FQK8EO8UfJu5I6LZn+vnYiz+U26UzZaxxnA/nBudr8p+WvNgbZQOeSZNmS0iV1zu1HcB
 rVUokYGUYn+yT4AmthRb4QJuvdwJtmfWAInV2Tx1yGTD9R5Gf0uROIS6ueUGSn4EFVmwxvVqDVa
 DSDKKC35Fj4BKNFS78Z/Niz1Ws4FUbPxLe5+csJ/ZBJq7WcPaoyuNmOpyzjGc8TsZkJwNYw65j9
 ik7RBYCjXS9F3XTZ8A/8ALI2SkD/+pGcThC6hZeGuf4rXYAcxiPyBKuGhV/B5O
X-Google-Smtp-Source: AGHT+IFnwW8I7jYPUFk5nWo2UcCkCzsPGB54h0tz3oo/dnZcut56vBoGYbmVnE3CtuECcssP3qxXBg==
X-Received: by 2002:a05:6808:80b4:b0:44b:1f75:df07 with SMTP id
 5614622812f47-44f95ef58a5mr1909609b6e.30.1761926070475; 
 Fri, 31 Oct 2025 08:54:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44f9d7e3b88sm448374b6e.5.2025.10.31.08.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:54:29 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:54:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
Message-ID: <20251031155427.GC6688@bill-the-cat>
References: <20251030003359.1023-1-briansune@gmail.com>
 <20251030180940.GY6688@bill-the-cat>
 <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
 <CAN7C2SDcEC+A5-rmCKMYD=vEYDFdOAfMp1G=T5SuQcXYOHDuJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OSD0hHFAxwurFbix"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDcEC+A5-rmCKMYD=vEYDFdOAfMp1G=T5SuQcXYOHDuJg@mail.gmail.com>
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


--OSD0hHFAxwurFbix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 05:31:25AM +0800, Sune Brian wrote:
> > No, this is a build script that is a must and also required on every
> > clean build.
>=20
> Let me elaborate a bit more.
> According to the current U-Boot folder:
> board/altera/cyclone5-socdk/qts
> board/altera/arria5-socdk
> board/altera/arria10-socdk
>=20
> All these board folder files are not sure and high change to be stall.
> As the deconfig boards are not only official Altera board.
> As such [1] is a prerequisite to build U-Boot.
>=20
> So unless there are handoff changes until the EOL of 2030.
> These scripts are highly required on U-Boot, unless U-Boot
> plan to remove Altera SoCFPGA from the ARM support list.
>=20
> Brian
>=20
> [1] https://www.rocketboards.org/foswiki/Documentation/BuildingBootloader=
CycloneVAndArria10#Prerequisites

That's interesting. But that also does mean that someone needs to work
better with upstream about integration here as no, that's not where that
kind of tooling should live. At bare minimum it should be in
tools/something/ and have it's own requirements.txt file too for
whatever python modules it requires.

--=20
Tom

--OSD0hHFAxwurFbix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQTbsAAKCRAr4qD1Cr/k
CmvoAP9TOz9xWK/MKOF+SWnYMtuzrHhbl/KKJESKhVi/SK8DWwD/eoTBB+mDohE8
UqIj3Oy+VZ1sFekqAhcDoOG1nFRNEw8=
=icCo
-----END PGP SIGNATURE-----

--OSD0hHFAxwurFbix--
