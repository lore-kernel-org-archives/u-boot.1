Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD41C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA8F80834;
	Sun,  9 Feb 2025 19:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XARdKEgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926FC8083C; Sun,  9 Feb 2025 19:05:32 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C15F80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e46ac799015so2633799276.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 10:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739124329; x=1739729129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zgNGRGuFqGsbW8L9pV36jNJuXurTkavUVgooKngu/OI=;
 b=XARdKEgnhf5S5H3OVyQ7YsNyiSTobUi6tuKfi2BkuHCj91nYaLK4iVDXLQRnmK6g25
 UXirBFF2f1Yc24yAwSKAbzEqW+2QywVnyo/WSesj6DaW3vApxp+gyR2V9bF5soTl2TGf
 +t9O4R2N+vnGnDf8lkN1d/1pDS+9J7edY23sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739124329; x=1739729129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgNGRGuFqGsbW8L9pV36jNJuXurTkavUVgooKngu/OI=;
 b=ELp39SDyYl5nA6VkSVw9izoJiIsbxD2Emh7XCErlANfKf5NW42BVBI6dHxaKzDhY/D
 JBzHNVQozFMTI7VBTLNVY9JlAkt60s69E6jixAsAtwasHoRZragFd1XhP/lFWP7IDUiV
 w1d+VtmBoBOsv3m3/sdiIoZ57otebFqOjJJW+J49xfaLo3zqaz2iMs9cslXT15hq448x
 Imfa2g8VynZ/S5gelE1seeBS73Hn2UzyXk1VGLtgXBz1oGoNCRRx2B3vJ8cnBL4ACFjQ
 abvz0nWiiXHTkAcE54aH2svS8InegOnVsqqi2ZH8GrM4ckAUsZXKdVgslOSCt82m2DWz
 sY/A==
X-Gm-Message-State: AOJu0YzND35Qg/HsXBEy2QqPInOYZvVk6WLwL3VRhkls5vCv/9uahvC+
 TDCPWi6eoeD+28fi7fzN2n/aewv5Eff1pH9pvMatn/cQ/mgqZI8oIlFRDM9Kqqs=
X-Gm-Gg: ASbGnctSdNHKVf5VFlEEitLMQGkEZE4rLEabQhAWr0D7z9JsyiAJBNvxWt7J17x7VTN
 wkHFgLTxcAAlTl4y1Nl8VckOjG2e5EdrHlVMN56hYWrSZFYW7Ly/07H9tnEh+3fFuSNZqNju3D3
 kuQYUUEt9JXkW2jbPDrSe421OwFhuxXm21VROTG4FtLjUHdEG/ab7DpjAhP6qjMdCOs8ac1D4OG
 Brcd+TYZGZuijFVrW+FJ9N17GProfLf8CQm80RObTlLbsJRw5g6K/kwN0N1268f6brOmsfcq1HM
 Vgue9NrNmEBmrrE=
X-Google-Smtp-Source: AGHT+IFcXMrJ93mbHcEHmr5bny/5fynlYy7qPj1kRon0VOJZIgzLe3SwL/FufUXVOUE9Bux9m8Jwtw==
X-Received: by 2002:a05:6902:2682:b0:e4d:25c6:c398 with SMTP id
 3f1490d57ef6-e5b4616c88bmr9380348276.1.1739124328904; 
 Sun, 09 Feb 2025 10:05:28 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b46077780sm1665768276.37.2025.02.09.10.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 10:05:28 -0800 (PST)
Date: Sun, 9 Feb 2025 12:05:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 01/29] Makefile: Avoid using TEXT_BASE if not present
Message-ID: <20250209180525.GR1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zTS9cCj3rs3PSpns"
Content-Disposition: inline
In-Reply-To: <20250208171154.1305761-2-sjg@chromium.org>
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


--zTS9cCj3rs3PSpns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 10:11:21AM -0700, Simon Glass wrote:
> This value is only available if CONFIG_HAVE_TEXT_BASE is enabled. Add
> conditions to avoid introducing errors in link scripts when it is not.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Depend on CONFIG_EFI_APP instead
> - Drop change to u-boot-elf rule
>=20
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 2f7614191a1..f989c31073f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1050,8 +1050,10 @@ LDFLAGS_u-boot +=3D -z notext $(call ld-option,--a=
pply-dynamic-relocs)
>  LDFLAGS_u-boot +=3D --build-id=3Dnone
> =20
>  ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
> +ifndef CONFIG_EFI_APP
>  LDFLAGS_u-boot +=3D -Ttext $(CONFIG_TEXT_BASE)
>  endif
> +endif
> =20
>  # make the checker run with the right architecture
>  CHECKFLAGS +=3D --arch=3D$(ARCH)

We should just test for ifdef CONFIG_HAVE_TEXT_BASE as the second
condition, that's already going to be never-true for EFI_APP.

--=20
Tom

--zTS9cCj3rs3PSpns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo7l4ACgkQFHw5/5Y0
tyxK0Av/WLwQXUPdFZoSa9UXur3N63XkJvFk1tShUuFsJM0cvcb4sKl/kxIgy3Zd
n4EnrPgfqjWT5F5pLPv00UOaW5hudcUGrCHjq2cxh2qBf88UNzrVFjHPktKITU5l
JhFAbZX0l0m6O93hY8b6lz9hKzxpBgjcICDRyoxZyfOR0wXOK1espBewqs0GBUZH
hy/vpT4fsd8720j2INSCBYO3Q+TE8tUG1qm/AIZoAo6ZLlnTXAApaOdMH+/bweiM
FRa7X6dhWtKL1elModQzcGJlzat52GtbQ001hi88+gZgrdcnSlk4aA4CRph94avD
hAAqoVu10klrsa3lQBHWXcL3GPEWoD50nS7OPIz0jP6vpKrdGzc0+L2rhlBst/yr
ACzBEOoGH03XR++0S2gGKHPELbedQdwNYpZh+H1xzTsg9FzslFuvF61dEdSlypj6
IKpEDYQbscXLP0JCFPvEAhySqGraQzc9p3HKFg/vz45v0ryqIJIv0ezcVg9t93mB
EPPfWpN4
=zV2a
-----END PGP SIGNATURE-----

--zTS9cCj3rs3PSpns--
