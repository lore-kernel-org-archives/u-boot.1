Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2B4C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA07988008;
	Mon,  4 Mar 2024 16:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kXvlXMit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83D587FFA; Mon,  4 Mar 2024 16:27:15 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207AF87FF3
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5a1206ba5cbso992693eaf.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566029; x=1710170829; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vSNc9QvIThmYTtRiIf+vUVwc4R/pnwH5Uvu/tN/ngpA=;
 b=kXvlXMitFOM07PNvLCsj53XjOQlw+Q4IpFskHz9L5V2+tg6Pg8sgylffKKbigRDgsC
 QPXZTrr1BWb+IYAo1sEp+H+6auy9p/Xl86LgxiAU2Lh8+JIg5cbkfRsZJoLYFQZHN9vJ
 mt2BNbzddbgS0tML5KIeOebJQdfDD6zu+/CmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566029; x=1710170829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSNc9QvIThmYTtRiIf+vUVwc4R/pnwH5Uvu/tN/ngpA=;
 b=Rd7O9NFYbemOVIBlmKasQH/qsE4Bd2p3TYahk87m9+G6LvV4p8/w0no6g3mjNgG8sE
 eYLJ13etcO+DfUyv7n8rUQ7PAm/P9a+ZCU43yahcEFaf1rbmse1hGT+SO0HnxruTHkke
 BAdR9M+/g0H4zlSCoScELQ5/8t8R/G/ZBUdHswMyZIiY6iPRcS+iztqyRD9gq8kg/1bP
 11sHu4gq+2RVtHT8oQ1tvEAWM6AMtp2Q85/Y7n081dSeoq5qGfOuQXbMVNaHP5NSgrQV
 4WxXIWU1AtSyhaZZZ52h7zZrwGI/emvkxiKIntnuXEpgPBh86RhcFmFRG2J4+2pcrBOe
 2Fzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcaUhCjdkAiWBqcxQxc8A2fdMczy95shfcbn2f56ga9zW6xu9yT3S8O6pb+AH8u1PYJGdx44BpgPnBp7yMIHZCQMIMsQ==
X-Gm-Message-State: AOJu0Yw+q5q1YMzjEOi+lHrulUBRryztN/Zy+2o7fT6yDQFutQ+oy0r+
 xLMtYheqQFG0Up0mnMqARTpC8WHuF9u5UOHyddef+QSLxwIdcTa+V25nkduJ/MY=
X-Google-Smtp-Source: AGHT+IG/7b2gt46CJ71W8uMUqzcrvFmMf8ds2HJ/hOkNxRS9ezIK523NfBmjCBjwy710jyn8NzcICQ==
X-Received: by 2002:a05:6358:7e0d:b0:17a:e17f:7f07 with SMTP id
 o13-20020a0563587e0d00b0017ae17f7f07mr11945777rwm.15.1709566028732; 
 Mon, 04 Mar 2024 07:27:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 nc8-20020a0562142dc800b006907904691dsm936552qvb.17.2024.03.04.07.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:08 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Bosch <stefan_b@posteo.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] arm: s5p4418: fix relocation of vectors
Message-ID: <20240304152706.GO1523872@bill-the-cat>
References: <20240126125056.16439-1-stefan_b@posteo.net>
 <20240126125056.16439-3-stefan_b@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zIRAyl6vq3Ri2Gb2"
Content-Disposition: inline
In-Reply-To: <20240126125056.16439-3-stefan_b@posteo.net>
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


--zIRAyl6vq3Ri2Gb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:50:56PM +0000, Stefan Bosch wrote:

> The header (NSIH) used for the s5p4418-SoC is not loaded into RAM by the
> 2nd-bootloader, see boot0.h. Therefore, use an adapted version of
> relocate_vectors which relocates the vectors after the header (at _start)
> instead of the 'dummy'-vectors at the start of the header (at
> __image_copy_start).
>=20
> Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
> Reviewed-by: Minkyu Kang <mk7.kang@samsung.com>

Applied to u-boot/next, thanks!

--=20
Tom

--zIRAyl6vq3Ri2Gb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6EoACgkQFHw5/5Y0
tyzhJQwAgq7AuDmrg3r/ast9uIscsYnTnoa60dZKxxhm+RWkMgVYNq0rg9aI8i6S
3lzu4+wZTBO5Tl1ulYyF/9qTdHe+ZTdwpURs5W3Hpfu88OBWtgSBGhKsQu43vV2L
WvSw6uua14b72ey0hyure9hoJdqqF2EphwcyEz28Cp35whBHc6kCoDIOp8jm1X8O
iOlzL44NSdHp7LuZRVXBmXP0iz0QX2/hZAPcoR0oc/92ZNBuOG4GxlCh4NodT5I9
Wv//mxMzdyDwVYgS7gD5mktIV08W1nrX/TMhn3tcl7WvdX0unbXyUf3qYwAOwtYL
Q+MqGQTmsHJxv82FnxEjjqMJfxvOPXEuBae5ZKFyion7bvgFThRQpAQZahwG4zbM
0LMeWvzt9+9gc3yMotGESSFFnEdA6bSPgfjiAzb4ORUMkrzWaUBmKYuwfYFh6sSS
ZospdgFvgyedfzwMiqwUwEQ3H5ughgjrg545NPGPto7nE+0kR59pxERBZq2RkaIm
xPq45Ujb
=nou/
-----END PGP SIGNATURE-----

--zIRAyl6vq3Ri2Gb2--
