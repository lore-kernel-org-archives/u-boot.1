Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46372D6D226
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 14:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8724C83D07;
	Thu, 18 Dec 2025 15:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kTTgmPAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F48983D8A; Thu, 18 Dec 2025 15:17:05 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E53B183C2B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cc50eb0882so198238a34.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766067416; x=1766672216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MWPg0ln35q+nk/KPtHtTH+BDxQjlMTsFGEEchfxGu9w=;
 b=kTTgmPAuOHkiv2mks+4p8rDyse+hrjWgZleaM+E0tmhvqqRSKufp/sVvlgQF/VMLcn
 GpL349YEOSO9wNGAotkPAMb6Esbr+cX/QndagYwqAaFT+zkF1t0Jljh6MThwVObKHV40
 j3uNOt4xboyCa9+DP3mB7EfDz5FgMVlk0Va1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766067416; x=1766672216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWPg0ln35q+nk/KPtHtTH+BDxQjlMTsFGEEchfxGu9w=;
 b=TgSLQNMZajamPAkZspr2RGn61OlTs2lALPMIOQ6kH478wi1ePCY5Zsg8mzlepX0XeA
 ceLKFqiEt2j0IcJYTKRLhk2B3m4QDUfx+ZP9Yymktp9lKiOEV7JuhTiOt/scpB8GlEtG
 dkyLn32ldqF8jeI4iavfNdkQvyoc8E/C4VVXnaBuKzVV/6OlBiJgA407MfHEjI8bgGhA
 oHmrW5ig/YR+LAcYxr2vKXgffszJ7LYYNwdtJ4UMxXMNzwYxZSzgKykCUdha3SNEyudH
 9rK23nITHkHHSnqCLnr0QmjlBF4WRAMfoKWMi8ZIJSI2uEuPj2FNMgHdln5RRwTT1qEn
 c4bQ==
X-Gm-Message-State: AOJu0YwAbEDQ1GWVkroYCG0NIRju/jVkZieoJajSNkvdiSOEwcESUHev
 vhd7145OsMaXe2cL0MBtJxUTn3cooUswawi2r2iPJRWXxfGDFPVgtG1djrk7I4hn+Jk=
X-Gm-Gg: AY/fxX6VyeOy/wgXmy7sAFDKRpxqjZ28nObGkJXN3DYxUW5tQxW0skHRGBjL1yWFsp0
 yCiGxG2WzuxZl0TgWCZRq1s4MuapUJUKbgvsTOkU3WlVpo2lhI24xGiTiwBoeO/ILT0vrIWJwxd
 03iXn4iQ2IKMV98mVdHY4WHQxmW/GM6A1+edleBN7K5SNpVuMlsv7kk2Ku3JRYZw9tctnsZjP2o
 D193EurTDswnwDxKPJddvDmMTbUjGwQ/G4cppPhW3yNGdiX1Hge8S8kGeYXrU0c4LaZyUefvMc9
 S3UyItbwrN688zQv6SmFhsc5Gq7QMZ7tC5TETBI3YyUcpp2RZMN+fwrkiW3LWL5JwQYavB4igWQ
 S93ekEBSSzNwD2p0KfZGUijSVNTvu2uHN/jZYXlrBeGiUiJWtM9SnQpvDHZIhJUEi94ZddphtEB
 yBKJArAp3LIwKsykT/DVjD3/8DCqi0QrsmtiQs9Ajo9lXe8VtbRA==
X-Google-Smtp-Source: AGHT+IGl2oPcCMwkiSM4GRwnjnX0iTcr9FhasmMJ3YCWjucwVxxcyC7fKYEA4b2TbCb7Tn9IzAwK9A==
X-Received: by 2002:a05:6830:6f0e:b0:758:1e20:c41b with SMTP id
 46e09a7af769-7cae83aad8fmr10186999a34.33.1766067416561; 
 Thu, 18 Dec 2025 06:16:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59a9a905sm1686156a34.13.2025.12.18.06.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 06:16:56 -0800 (PST)
Date: Thu, 18 Dec 2025 08:16:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>,
 Judith Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
Message-ID: <20251218141653.GI303283@bill-the-cat>
References: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
 <DEZHV1ELFZ43.E3FN619R0UNY@ti.com>
 <20251216140104.GU303283@bill-the-cat>
 <DF08W9D84X84.1DQ1VM5S8TT9D@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8WmHKny7JGh5RH0U"
Content-Disposition: inline
In-Reply-To: <DF08W9D84X84.1DQ1VM5S8TT9D@ti.com>
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


--8WmHKny7JGh5RH0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:03:43AM +0530, Anshul Dalal wrote:
> On Tue Dec 16, 2025 at 7:31 PM IST, Tom Rini wrote:
> > On Tue, Dec 16, 2025 at 01:52:37PM +0530, Anshul Dalal wrote:
> >> Hi all,
> >>=20
> >> Any updates on this patch? If possible could we pull this fix into
> >> master as well for the 2026.01 release?
> >
> > I thought the feedback was that this was a generic problem and so the
> > Kconfig logic should be universal, or there was an incorrectly /
> > sub-optimally handled case in the tiny printf code, that needs fixing.
>=20
> We have a few ways to go about fixing this:
>=20
> 1. Fix the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
>    with an extra Kconfig"):
>=20
>    Pointer formatting used to fall back to %x handling before the
>    commit. Though going by the commit description, it looks like the
>    change was intended. So, I'm unsure if we should re-introduce the
>    confusing handling back where %p is handled but not %pa or %pap.
>=20
> 2. Add SPL_USE_TINY_PRINTF_POINTER_SUPPORT per defconfig:
>=20
>    This was what v2 of the series were attempting to do but as Andrew
>    pointed out, there might be other platforms with similar issues and
>    it would be better to fix it for K3 overall.
>=20
> 3. Change usage of %p in k3_sysfw_dfu_download to %x:
>=20
>    This is a suitable fix imo but we might still have to fix similar
>    usages of %p in other places. We'd also have to be more careful when
>    bringing proper U-Boot code to SPL since %p would not work the same
>    way.
>=20
> 4. Unconditionally select SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3:
>=20
>    This allows us to remedy the problems with above 3 solutions with
>    very little overhead to the SPL size (<100 bytes).
>=20
> If this problem is faced by non K3 platforms as well, perhaps it might
> be better to take the hit and make SPL_USE_TINY_PRINTF_POINTER_SUPPORT
> default y.

Ah, so now I understand the problem, with point 3. So yes, I think the
right fix is to add "select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if
SPL_USE_TINY_PRINTF && DFU && CPU_V7R" under the ARCH_K3 symbol.

--=20
Tom

--8WmHKny7JGh5RH0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUQM0gAKCRAr4qD1Cr/k
CkLQAP9iN5qHPUX593yWpHsNtJ0Q/9CUCo0/v9Iuk4KEiRulPQEA58S4QDLpwvIo
sRs3qUDwVGNk83NBTTprtablfZc4TgE=
=zG2w
-----END PGP SIGNATURE-----

--8WmHKny7JGh5RH0U--
