Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C27C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABCE874CA;
	Sat,  9 Dec 2023 16:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qlPLEwND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8147F8765B; Sat,  9 Dec 2023 16:48:47 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED5E58761B
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-db548da6e3bso3551526276.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702136922; x=1702741722; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KrQLHIIzovsnIZu7/yAWptKDmWLu2/r6pXr9Xu20quI=;
 b=qlPLEwNDaD4nJDb77Z3FjB2HCuND+Im2yJz7cLmr74RRtvqjesQ8Fbnb5WBUyA0tMT
 noffC01xpqe74CnVrGmo2oW/BISa8g/ELAXAC5qe+8u+zOnkapIQ2rx6QNQHHiqySDuL
 2Ws3G6N+CSYEv3HImvyYKDUFe+8rQKIpQRGys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702136922; x=1702741722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrQLHIIzovsnIZu7/yAWptKDmWLu2/r6pXr9Xu20quI=;
 b=ldFSd78bPYLDBGk/uBUO7DCxVKA80HOOc4iAHy8LMZba0X1vAydEcFEx8coej+AKp4
 aimAnZxGtZ2xc4R6KCl6300DzxogXidWLhGG655SLT0ztVh1etlwZN5SgirFAnSoxpk1
 VOA7k0t82kVGyEIyAQ08XoRn3O0KWBTHVFDGgwVn1DSfwaDOEC4Sk4DuQdIUQ+63dkaV
 C0sK0pqCf2alAreGXYPsIYSwJbEmuKiFLYRbFUb2wcNDMAXq5FE0RUjp+bE/bJuWsJT0
 CipNk+qqSkTgvGgaWuYGJ2tw+Oy0OKLmbj0hV+FasVcPEYlot+PtdqJsbUb2tnVy3SIu
 h4ZQ==
X-Gm-Message-State: AOJu0YyPyEC3rqQaAyMTLnme0TzL7AEFmDvxzqa+F3sfT33pQyisznag
 FiQCa8y9AmlAynxkPB0xMrVFAQ==
X-Google-Smtp-Source: AGHT+IEGeWLpgEOQiC1PIm9YnI1q7S9ZnMkH3wbyopLYEfX1RFCIYR/2NO7tf2/OgOsSvmgaC+7T1w==
X-Received: by 2002:a25:aea3:0:b0:db9:8867:26f9 with SMTP id
 b35-20020a25aea3000000b00db9886726f9mr1603710ybj.50.1702136922577; 
 Sat, 09 Dec 2023 07:48:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a25e312000000b00da05d771097sm1313756ybd.22.2023.12.09.07.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:48:42 -0800 (PST)
Date: Sat, 9 Dec 2023 10:48:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Message-ID: <20231209154839.GG2513409@bill-the-cat>
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PhBrCGeTLUkBfAjn"
Content-Disposition: inline
In-Reply-To: <20231202153400.537050-2-sjg@chromium.org>
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


--PhBrCGeTLUkBfAjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 08:33:48AM -0700, Simon Glass wrote:

> The cyclic subsystem is currently enabled either in all build phases
> or none. For tools this should not be enabled, but since lib/shc256.c
> and other files include watchdog.h in the host build, we must make
> sure that it is not enabled there.

This part is what I see as the Wrong Direction. There's some code we
really need to share with our user space tools, in order to not
copy/paste the same code. In turn, this code must be as user-space
friendly as possible. Maybe even we re-factor things a little more, if
needed, so that we _just_ have the library functions in common files,
and u-boot or user space only files have the make use of logic. I don't
feel bad about tools/ needing:
void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
                unsigned char *output, unsigned int chunk_sz)
{
	sha256_context ctx;
	sha256_starts(&ctx);
	sha256_update(&ctx, input, ilen);
	sha256_finish(&ctx, output);
}

(and so on for other algos) as a duplicate bit of code. Much less so
than I do about adding <linux/kconfig.h> to a direct include list (since
we should never be doing that) so that later on we can if
(IS_ENABLED(..)) the existing code.

--=20
Tom

--PhBrCGeTLUkBfAjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jFQACgkQFHw5/5Y0
tyy+cgwAiVGv9/KWgl/KILFZERaUdgftZzqDSJsS4Yq3Hs0K3dQoMkEGQsgSrHAe
wuxb1NdbjpWVwJR/p6Mo95d3UOiiyvyfWwCZF4Twm7JnOvyFdo+t75OlRGeE5ueB
0lksxXLx0kGxnHjiM9tOjD7WCTLoXEAnuXsltwg5BPzfRZdiXweXez96h2KffBDr
bpzhZnbfosi3hso6fLMWZl4mdOw3I/CYevjyaXSUgMBGoBKQF26rWPuIcvtbMHVE
82061jFasQpnT0cakLkbJXeZLW+bjdBTGg6nBVZH+u/PpePHnk7UNy2xq/0R1SSv
wXnZHoYgu3umgI0ztMV2pkTOnnLO8yyrfgLuCogxD6OKZ9fs6imsNswL6VN14vnx
kZJ175dM5rlVFrqVDqiOD1lalioAJ5i1GUVNqg8dyBFYZfhTmcajL4BPSBjhcZZ1
jf4SU1I1xmf/eC9jXGkQaQYMU2Kv3wMzUKdrf1q9bjLnaenxRkdeFH7GIRNlGRyV
mNAdiqHf
=gqty
-----END PGP SIGNATURE-----

--PhBrCGeTLUkBfAjn--
