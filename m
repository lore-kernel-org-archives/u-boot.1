Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D94C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22CA874D2;
	Thu, 16 Nov 2023 19:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RbS/sLll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9181A874BF; Thu, 16 Nov 2023 19:47:11 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A1F3874BB
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d134a019cso6576856d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700160425; x=1700765225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LLsXVyiBSLdsV1omqtPXsuL6vRMxEOaanXDnkxt2iiw=;
 b=RbS/sLllC0JbY64V5HXJerf+PbLUdagUa/Z4/y3K9+rAamk9vdu2cqPNpavr7yCUTC
 /HvpL7PZcx+3c9CNU+WlWAGhs9MGM5wh5rptUCCTCzKpIWduIqfKASp3fmMurTBZFT91
 KJRjcwW2hVEYtyDFNPo9IJIIfBQylGayJ85MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700160425; x=1700765225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLsXVyiBSLdsV1omqtPXsuL6vRMxEOaanXDnkxt2iiw=;
 b=XsY/Ucff/GHNrW5MIo8Ed9XTWwywc3TFWABxo6gCj4dvvwxZCE1NeXJP7VlILIzqPC
 41OUdmsF1Wehl72jn2LLHKodn7ds5uAEFfc+4yfl6rooD5JxXdV2YqQmcJwgCRfgQfq8
 Kppfh8N+uvw21AOPWD9dsNNVvXmd07NijnQ5UZpN8oT6B+pf+2TM8P7R5ejHZCkTToJE
 Qvv+5WEikL9O767ProLpWMrkbYYKyO9QL+OI8mKgBPPtxPnUab3ZRzM/XbC2Q9YF4xRl
 J3t9YVMZUsfp/sbxnqmrgqRk8NmTlicx3uGL5E1/C8GYo8NDRwn82qCNOhF789t0eLYA
 He5w==
X-Gm-Message-State: AOJu0YzIF9EH2eFUDrI58S/9/cfx/EktrOTuVIfuMoKbVjrSisMLd1mO
 khQQPVqFneEG4URdOIllZiBHqQ==
X-Google-Smtp-Source: AGHT+IEYxFsp9bNZnrTl7I7LC3XIrxFwj/EdUvaCScyM1XHg33XiqInPQcl+5EbofaUHLtegq5yxwA==
X-Received: by 2002:ad4:588c:0:b0:66d:92a4:ae3c with SMTP id
 dz12-20020ad4588c000000b0066d92a4ae3cmr5255639qvb.63.1700160424879; 
 Thu, 16 Nov 2023 10:47:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 em6-20020ad44f86000000b006585c7f64a3sm1572319qvb.14.2023.11.16.10.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:47:04 -0800 (PST)
Date: Thu, 16 Nov 2023 13:47:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Aubin.Constans@microchip.com
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Message-ID: <20231116184702.GA344953@bill-the-cat>
References: <20231105022742.632175-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iSWBwYglDbBWCNim"
Content-Disposition: inline
In-Reply-To: <20231105022742.632175-1-seanga2@gmail.com>
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


--iSWBwYglDbBWCNim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 10:27:42PM -0400, Sean Anderson wrote:

> Several AT91 boards are quite close to their SPL size limit. For example,
> sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit and doesn't
> even fit with older GCCs.
>=20
> All AT91 processors should have thumb support. Enable SYS_THUMB_BUILD. Th=
is
> shrinks SPL by around 30%.
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> This has been BUILD TESTED ONLY!

We in turn need this for Sean's other cleanup series to go in. Is this
OK? Would it be safer if it was only for CPU_V7A ? I do have
recollections of thumb being sometimes buggy prior to v7a cores. Thanks!

--=20
Tom

--iSWBwYglDbBWCNim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWY6YACgkQFHw5/5Y0
tyzfJgwAmQKb4JpJvhaV1GPBckSRyppR7p1zaDiXvHYcSSjobsP8jghILpySrjfN
dsL4Zq1OFy5drpqHPRMexnBjMZMA4G/p3gFrDpbJ0gmlpX8k3A1wBrZNVFqcTm+C
Sor782zqnzr2m8yk+1XGP1vozkTfEPjGkHUR5fH3MmHpCAP9BYBpusv7PIKz/ajm
5yYPbfHTLCcXCT/v7WcmpMTkj4gvny9fDoqNA84OXqyX3nD6QyHfjlQLjweuhwZY
mXD8sPkAoYURjCmrGfvweeV6ZO1tQ/vBd9T0HAF/14ytcNji55WO0EvgaV7pWTKD
IGPzVP6b9OoWKmy8mcc685DOmbV68P+80U4dRCcXCaOikXW7hXofD0ynLiININtO
gH/UiexIEWa0LWty8Jd6SJeYS4f5584iniGa19LJscmOLRwA8Cno82AECA+H2o2U
TUu+huQskeVEy+Ny8Lw+hXTNRmCXp14hd+HoxfZHyACmlP1EtQxCyQqX60SHL/wj
l7Ggm2VA
=xfTn
-----END PGP SIGNATURE-----

--iSWBwYglDbBWCNim--
