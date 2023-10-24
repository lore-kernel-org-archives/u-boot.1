Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00EAC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A4B879EF;
	Wed, 25 Oct 2023 01:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JjkHV7+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43FB3874BF; Wed, 25 Oct 2023 01:15:58 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752A887100
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a86b6391e9so51289907b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189351; x=1698794151; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t1EiGgY5KZtbGqIRgh73NDc/AB5XIzXz6osTWl/uMsk=;
 b=JjkHV7+LDwauIxNldM9xJ3rbdgZ4aT6mSzwFAXtUxLFScj0DEExKGinAuMP35qVPIo
 nMyzaWdcxu6gOJDFcTq45q+1+fG551yhysuvyLODJv3xFOpn19YNPDGPz1GbLUbkZw/V
 uLqHrOOIypbEc2bXmNhm3Yl79CkLaAmOeXVyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189351; x=1698794151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1EiGgY5KZtbGqIRgh73NDc/AB5XIzXz6osTWl/uMsk=;
 b=Od2S50+ueCOXilBSHtYmjTON8oMYRStNhmWTkpPAjYlct0Vc+bUB4D4Y7/E0hXxLOd
 3r2q0UAdXp2/DdtjnRA8qKGNhluVcT3L7sabp2NsgRJvIYVF8ll0kPn2AL185aWUtBTN
 5E9pE5UzWpO8GQzQ+QpAtaHZK/sxacOoQLtokwnPrc3sa88PjjKWHJDBMU0u561RQv5J
 QZQMW4EihKuo6IHY8EEqTCDtRM37Iftsf36QQ4F7Cx6IoGXMSb2bS4/4zGTDRbunHxqS
 bTkbCRqQ5ZatT1QzhIDqrm+rLOXNo+dwdr49nq/IlwuZdU1IqjvczOQCkRuWCdVRrEzR
 UCsg==
X-Gm-Message-State: AOJu0YwhWuIXNZ9JbX+rXeGe8DE1q12Lcoj5YxbpIVAk7/ohLnE+qi9Q
 e2VELG4EvJz694EmZ1R2nXJlqRLHR9jVh8PfpACZLQ==
X-Google-Smtp-Source: AGHT+IEQ3a3qQVujySZAlBYquDmjQMR9Uvvez6YdSfBIphlzMsh5HKoBYie85t64L5U8Ep1ZkcIDGA==
X-Received: by 2002:a81:47c2:0:b0:595:9135:83c7 with SMTP id
 u185-20020a8147c2000000b00595913583c7mr15422228ywa.47.1698189351097; 
 Tue, 24 Oct 2023 16:15:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a0de615000000b0059be3d854b1sm4450392ywe.109.2023.10.24.16.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:15:50 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:15:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 1/4] spl: atf: Improve comments and code readability
Message-ID: <20231024231548.GO496310@bill-the-cat>
References: <20230916082301.583248-1-massimo.pegorer+oss@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EajiCz+0nxtjjO6h"
Content-Disposition: inline
In-Reply-To: <20230916082301.583248-1-massimo.pegorer+oss@gmail.com>
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


--EajiCz+0nxtjjO6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 10:23:01AM +0200, Massimo Pegorer wrote:

> Rename bl31_entry static function to avoid name clash with its first
> argument. Fix spaces misuse. Describe code accurately: load address
> is used if getting entry point address fails, and not if addresses
> differ. Remove not up-to-date comment about BL3-2 usage.
>=20
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  common/spl/spl_atf.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)

Please rebase this on current master if this is still helpful, thanks
and sorry for the delay.

--=20
Tom

--EajiCz+0nxtjjO6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UCQACgkQFHw5/5Y0
tyyibwv/QOwHwXqq9kAQTixqXNqknSW2937l84kZvnX0VIwHSZE5i6u0MKmFF1Wi
lCSxZWz+BAJ7quN1+tdn9gEev3j7aYiJw3asQJVgQIW/SKN8L6MKCm9ls2MUY0Ce
kvEU4gvFtEgbXoH3miEPGNev+xB34IFflcO/RdBhNXj2uY/KtX3j7xrHZbY8UHJ0
uqKuLvIq3oTlVslSbJdi44pBbwT9WCicwVypLgpKDyV9V8MLkyVgt6EAQfy2APBj
CWm0cJQrBkzd0M41RzsmkndKCMEKPtzr7h5FQCyJG+rh1WWRAy49ZKQS5Wka1yw9
Bf9OV8N6SEbjPn6o5LNAQcRz+v+3Bp0UaD+O2MC59hZkxll2QoRBXId6NFTLEJFC
tnT2dndLXnahA+u0m6tDwDkEtwNX6214K6uP2ei6UQcRFMBpImOUW5QLqddRVPMW
d2NRBBlMkzRd39smxLrsd5hER/36WrmRTzfg+D45TR1hRu/j0pWzRO5ZCDjxB91N
WELmkoiX
=+ctS
-----END PGP SIGNATURE-----

--EajiCz+0nxtjjO6h--
