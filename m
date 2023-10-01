Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D5E748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 15:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2409F870BD;
	Sun,  1 Oct 2023 17:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iQSYljvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F32870C3; Sun,  1 Oct 2023 17:55:42 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C5F870BE
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 17:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d81adf0d57fso17388339276.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696175739; x=1696780539; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nKpgv5fOB0tvT609NQYmHnCm2agPz18qYroBxCcJJF8=;
 b=iQSYljvlIyqAVhq9A/XUsygssUHGPM5cmIi/+E02o/ZZWvZMK72t2LrG+OSDL1NHV9
 aPuaP9EuNn48cqaYMSd99YsJUKW0mfopBDkOUczliJKA+Iwh4DcdROAKDG2MhgwuRMQl
 lvm3e7HkhoM5xXCWrGFAMIXNzR9r2WAJJf/5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696175739; x=1696780539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKpgv5fOB0tvT609NQYmHnCm2agPz18qYroBxCcJJF8=;
 b=rRwx4JqB9XqWfUKU7lCCPNOjgqfT8jWFXlS+GNJSM6NIoCw6pv3Iv05zsDGwE6KB7C
 0XcWLjh6vLbOymP0GcUBWzXQaNqGUlMxeGQ8qWbEcWvFiQ/N/RvLyqd9hS7kAoUy+OKx
 iB4YaXULMAZx8dCNNJ5oZSJyYNrs3/iga+PvU3VA02nnsMHI1FPo60N2MNJyZ9A2hM6a
 Fruw0tKO47x26TAzj0Fxmg7WZGq+dzpDpp8tkGeyqrPegMLd/oPkmD6A48/zJh8bL44v
 P3h5mLd945FifYf83cdwUp8l7kwt1U31hZ0GWnK6Bv7SAyZVn2LtG2fWDxj9VjEa0fLI
 PodA==
X-Gm-Message-State: AOJu0Yx5HUAATtbYZaWKYY+kQjQyGoSLj0CLel3veWOJF0wGK3psdil/
 gpPIskvl8IFMsGFfFywSAGVWKQ==
X-Google-Smtp-Source: AGHT+IGoyoEtMGN7/nTQP3YeBZzlg0QRyycPtJJyS2Bh/9dNbre0wxY1Ls470MqwEVKcNz/5Lk1XQw==
X-Received: by 2002:a25:ec0b:0:b0:d85:4c83:5d81 with SMTP id
 j11-20020a25ec0b000000b00d854c835d81mr8075302ybh.48.1696175739569; 
 Sun, 01 Oct 2023 08:55:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-13fb-ab5b-9ebe-9b3a.res6.spectrum.com.
 [2603:6081:7b00:6400:13fb:ab5b:9ebe:9b3a])
 by smtp.gmail.com with ESMTPSA id
 203-20020a2518d4000000b00d5d4bae6fdfsm6391462yby.30.2023.10.01.08.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 08:55:39 -0700 (PDT)
Date: Sun, 1 Oct 2023 11:55:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Knecht <rknecht@pm.me>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] cmd: xxd: move xxd into shell commands
Message-ID: <20231001155537.GB2767539@bill-the-cat>
References: <20230907144950.653-1-rknecht@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GBV2AELGBcm54Fik"
Content-Disposition: inline
In-Reply-To: <20230907144950.653-1-rknecht@pm.me>
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


--GBV2AELGBcm54Fik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 02:51:43PM +0000, Roger Knecht wrote:

> Move xxd into shell command section.
>=20
> Signed-off-by: Roger Knecht <rknecht@pm.me>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--GBV2AELGBcm54Fik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUZlnkACgkQFHw5/5Y0
tywjbQv+MWODQ3oPnb9yl9c2u63217Gk2O+LK/cgG9bW1QL8gIaAhN/SavKMVEie
ji3oYDjVj9hpguwVOrSby2Jpa5gimsN7Of8Oj0c9uR4j8Le/duXIHTsA8P3XOEyJ
sU8UNAEFczqQ+1SnKv84keQTIa27l0Yfe38j3j81t9V0x6/tzcK/M3I9BZccQ6/2
NJhIRIyNru8EeN5HLSVlADX9LQj/ns7Doq68SMPLEuGWYRRmwuo5Y9QX5W/XE+K0
5Pm0l6kBNcT2tdwsL4mFQOc9YhrifKF4k1battKz49KGwPptOmOHEvRZccFtpJB7
ZgUF8L87kXbnNkycuJ4kUWqilgL/2VTC3eJYEPfmsDuSxoBgLeRQkPRWfTzSKSpI
xcyIuy4y/882MEcnPDUMs9cE+DFkexLi5C6a+Jib2fXmstfg6dr99dHi918fU2du
S7uarSySwL/z7dP5L7kETGLkgTbtMj8u4Z591LbG/5VRYoOOZdeKH8aCls2u3jGu
SqrQkgzr
=zDUs
-----END PGP SIGNATURE-----

--GBV2AELGBcm54Fik--
