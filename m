Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1DAC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F3680B98;
	Mon, 10 Feb 2025 16:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ea37Yh7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE5980BA9; Mon, 10 Feb 2025 16:52:52 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E7080C58
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so3323446276.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739202767; x=1739807567; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kNmbwaHJ8kmBAtziUPS3GqYuJDUEpFkaY0c+0IZxO6o=;
 b=Ea37Yh7LTq72KlPigNm7VrcWU8i9vQWyTgXqzS8mrWiRv4hiqfiZNjKSybWjpiDpoz
 xE1BqXDkeek3nt6v8SVrU5VGp32B66JWvlcwGz1HSBbMFtIYnLIZMzK3ASLLRG/JpFap
 +3iVorq+c7i2EViLgCxV63RnNc5gy8tPJPIn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202767; x=1739807567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNmbwaHJ8kmBAtziUPS3GqYuJDUEpFkaY0c+0IZxO6o=;
 b=vvsSVJhUwzgMhww4ziA6c2sihjOTaR1q2B1MphklCVVQsJi6LzKv5ORfzMHTezUCp1
 sqOL5yPilxaA21s2/JYtHopuehiE1sTLULLU1Yyw+zG93px2tOca/fnksD19RTH4ehpb
 ofh5paMhBEpC2AextcBxwyN99/lcSMojvjrTMvQ05xoDwk+AiWa2+HDrSw43fCPGvlfd
 JYgdKcjQCKYBOlZTKt/2faqr2OdFGuo3Yo4lFJkzH7+ZCROwF4oTEVI0GpuZ+BtES6rW
 mpXwcPuQEXFp/5F/hCIcoI/q9hH0Kr1ayzjbG08hGP5nuEIyHr6iz1thOY0BHRikgQSy
 n61A==
X-Gm-Message-State: AOJu0Yyu3BTPZ++vECyKqwPgLpI48EZ4uSxtX+TvqF62Efju1+F1zkqA
 KhkEuxY0RhFzvNm9FetdOdBFnBnshuc+wc7M5aoA28qXt8LNH3xca8kBwbXgkwU=
X-Gm-Gg: ASbGncufLYKyhkaEIl9tpMGhjKa6z9cCd5N8GCag2eWlsadj6Qm15hiPLfp1DJlBCxM
 3bMS2GAUgLTRzzM8ZiMuLp1K7tL6X7Da78+W4bYBROW+qOadFDLWiD/vJWq59g/faYXLpv0rq4e
 eCKlQ3sG8A9/ID+mC7Lbqt/xylW4NDX3wqRE7SF/1AF/qBJuAwl34kH/oTmx0UMaUe5Pn0neMNv
 vU/I0Ur13C2c/4eWgoKRuDX3zD4BswyVc8VnNk3sXAMvCiGTr6Jfm6Uqxo8BeGAtb/2UuZqdad0
 ubMkU2KhLhTLDr0=
X-Google-Smtp-Source: AGHT+IHMti0DKGI4gUo7aBU2w/k6mZXuAqFGLn5YccPFHJnHYMwYnZmQk7wkayR5pcD33sowwiAWig==
X-Received: by 2002:a25:5f11:0:b0:e5b:608d:7d2 with SMTP id
 3f1490d57ef6-e5b608d0999mr5226370276.46.1739202767109; 
 Mon, 10 Feb 2025 07:52:47 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a45d7f1sm2621633276.40.2025.02.10.07.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:52:46 -0800 (PST)
Date: Mon, 10 Feb 2025 09:52:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v3 17/29] efi: arm: Implement access to global_data for EFI
Message-ID: <20250210155243.GK1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rBCYl1p1z5tX29ss"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-18-sjg@chromium.org>
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


--rBCYl1p1z5tX29ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:16PM -0700, Simon Glass wrote:

> The EFI app likes to use a simple variable for global data. Implement
> this for ARM (for use only with 64-bit ARM at present).
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rBCYl1p1z5tX29ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqIMsACgkQFHw5/5Y0
tyyv6AwAkI1FK52t3f45koKXPbmvk2kXp7jPZfhFpnxNoreScl5tTIUOgtCRL4OG
vQZaiHzKUwnwfNypNwxZ1tiUuPXI3b/FXSVwa4ShR0qU2p80r+wVI5qFrpVT/tMv
Y88uE3B5/KNKZDc66p/mdy+tGU6o62d5bni/bUgzbELJUPIotY2xCP19pz+Ha4g2
+6UYLTaHIyH7dkR1Uz91zym7n+qAqeaGagiDpzmasrU6l7vyCawFOrDlFx0Qp3IG
uzNH3kYtcp06BZX5E2WyMd+wgcQzziPqfHsQ+UrGSz1KJVT6RGrYo3cdl5c9p/y4
gBzPRkZH7++9xY6gCou2/PXNbMovtik5jjttLm9qSpFSdsDVBfPauko+JZo735pk
Pv+jJInIVZs2y/2puNbEYrYAQsW3HsCq8Noo31hL+QUbvygS6ngt2CXeKvgISt5x
olgE+nn1U9QfmXrET65ElPWYVlVMWF9WLJKTYVQgBPbZ8VUUylSa+43v/Wt5i7il
G+bBjaEg
=/ARW
-----END PGP SIGNATURE-----

--rBCYl1p1z5tX29ss--
