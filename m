Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB75CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 18:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9DC839B9;
	Wed,  8 Oct 2025 20:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J5w026OA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401D583A2A; Wed,  8 Oct 2025 20:20:35 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2946A8394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 20:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-43f715fb494so59235b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759947632; x=1760552432; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qf1aHb1obK5lI7VeHqmhCGgJqQVEpyMlVrWlzzeaxrY=;
 b=J5w026OAMkQuoUx2dnq9na7Iz3egl1GLXXJrAkRVGLfoLpdoI33V+ZExSoyLThH5Sd
 xbKtjiIxjkDz2xfg10RsMPmK4yHyYLjCfwDiib7+ySgJFLW5c21ekYIm2wjeulgSYz23
 Rw2DB9Vr56qhYSiRBWTtPRUfC9KhRAzXecIzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759947632; x=1760552432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qf1aHb1obK5lI7VeHqmhCGgJqQVEpyMlVrWlzzeaxrY=;
 b=mzDCPR4uE++0MWqhinzjvwrGXg0V6/ToVkRqZRfXmadKWSW96CPWPYCuK4ui0kpoMJ
 YAzWI6QFPJjHZakh8fqFf57nYbdAdtyYOJKdb50GlAznbJ5UelWRM29hl7GCr3qizjoR
 aLCUBpiwHUJK/Yisv7giQe+9CjTErEYWOXGyQW5asEVPz2T7Jl8sHNIT1k96mrRtFpO0
 CplZFGUSMRktURjaTne2ZitRWiFvdwoSk845TOOp1jZYAB41aCpB70+rKogz79WQkt7z
 kQQzTcNUgBVIsAG+lZNpgjJ4puPuUzoNTsfPXbrDXMEiMaoaCITMZLdbVTjWJBLelOFQ
 Lw1w==
X-Gm-Message-State: AOJu0YxkdEFl8hjOOTGq6xR0Nav7ZHuhI9bZ+pD21Odf5DFmiHsi4MTD
 YraufHXL0W6yAw0Wsx6g3npMQepGOC757qi37QRo2FmeQStRNwgxkARsMnHZfSghCIM=
X-Gm-Gg: ASbGncsiljPmIZLxKoCYMuzAWR/9FzRTuLAf9llwjsaX2igwJ7aVaeFWYoBYcUNjrzg
 V0C+5eVoyfOS50u/Qkt3m+M+wW8LYTDjhUYFDhgkTFIDk+4MUfrv+mcN8k1O3WW3yiN7+LhPJFp
 Na9u6KWz/Q3AON7hNaHq5+HMPJ0AN9v1qxeqDjAx38bUrrNUpM8eEt+P9GZnIO7h9LKdBdDeBu7
 aYbmxDmJ1uMStBN6jQzzg9wDzQz+yW1e10zj0PqOuLhxXkw7TKHSNPt3tnpTUxvpJ/xoWfhqZZ1
 4JW7ToO+Kf0p7KtMNmf2TsWg4hFRAVajNoxpkwS013nuyGe+TKOIG1PCVXCWIncD9uibPfVYD+p
 yLh6P3xkWXSIZDqrwklLt8VmpRoZk6qwkV7ZHUMEGH4iInw76YNQ2RskNXiKoHH8K7m49E2VKMp
 t5QUHsuKQtKg==
X-Google-Smtp-Source: AGHT+IGmfDr2vzkc+BXx+OaW99Llti/RaL5R6io55gtffTSqgw7YBttsMDEH9iNNiENMsTyT1qPekg==
X-Received: by 2002:a05:6808:5242:b0:43f:48e3:5791 with SMTP id
 5614622812f47-4417b2c3968mr2428296b6e.10.1759947631830; 
 Wed, 08 Oct 2025 11:20:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1b7a88ecsm4119847eaf.13.2025.10.08.11.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 11:20:30 -0700 (PDT)
Date: Wed, 8 Oct 2025 12:20:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Subject: Re: [PATCH] phy; qcom: Rework Kconfig logic around MSM8916_USB_PHY
Message-ID: <20251008182028.GG298503@bill-the-cat>
References: <20251003203927.1030052-1-trini@konsulko.com>
 <35bdb934-d923-4dba-bef6-b3acfaa62f0d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ENnqz6lwPc4RaqFT"
Content-Disposition: inline
In-Reply-To: <35bdb934-d923-4dba-bef6-b3acfaa62f0d@linaro.org>
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


--ENnqz6lwPc4RaqFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:19:11PM +0200, Neil Armstrong wrote:
> On 10/3/25 22:39, Tom Rini wrote:
> > This PHY driver is required by USB_EHCI_MSM and not useful on its own.
> > Rather than have it be a prompted option, it should (and currently is)
> > select'd by USB_EHCI_MSM. Remove the prompt for this option and then
> > correct the dependency chain (it must select PHY).
>=20
> Subject has ";" instead of ":".

Fix that when applying please? Thanks.

--=20
Tom

--ENnqz6lwPc4RaqFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOarZAAKCRAr4qD1Cr/k
Cvw0AP4zuheVPoKB4RLd4nH6jCW+7C1MCigD2VuWf6yNU+i+UwEAmb655kXCyjjh
ihrUdn3DecjpVrEMjRQ11Tq7HGpkJAI=
=Qfp5
-----END PGP SIGNATURE-----

--ENnqz6lwPc4RaqFT--
