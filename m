Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5B2FD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA5F840B5;
	Wed, 25 Feb 2026 16:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="meew9tl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C0B8409B; Wed, 25 Feb 2026 16:10:54 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F982840D7
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-673f0b73dd3so4163051eaf.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772032172; x=1772636972; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JzEpSsZz0dA44e4k1Ec/xmpO55EvcHSN+I1zODxjo2w=;
 b=meew9tl1GYP1MjfXOdM3Nmi73WPMVtk3peTsapYttppTnBmeyW+KvnfF74SuOr3MCZ
 SYX8NRQvWyXZL0jSCuCEjkguXtE1oJpYQJjLh4Sg3AfEEAAelsqdLEcgWfPnkyCWQuWm
 cI7GINuvn74E7AZJgyULVlq/quwpChCRVSPlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772032172; x=1772636972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzEpSsZz0dA44e4k1Ec/xmpO55EvcHSN+I1zODxjo2w=;
 b=J+wtJWOTsEa1+4zXmoAHUBQMAS4BMPiSZur/MukEIt9VU0HBZydQHXpN/uwq3rdtUp
 hzG8XoPLn95iUOfZ8169W6DIBVyyHUJsIqBh791H/HVJ41E0Uguugps2l4vTwDsNo43F
 vcmFzMTg1ixMASBWRktptA3nBGfVVjMIoa6x35Mmtq8Wj9y/F1arLmdyppXlU/SZIVmy
 qzIlUWk5Hxs67+FYxs8Ok54RNaeKSfoa3xWg29aIjeOIeRFwnyrpIMd+PZ4XQXg7+nZ5
 CsG0II9RrlQiiorsap4GSwLpNSo5NWaWSNO1w7ebZKZ1CaIHmvOx+BunRPZmGkwnX6kq
 6aCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPhQheWkUl4xL/yrOuHfFf+pBD8dppNSc78sG27G/DXDOs806KwYLVDSIS5M/FsP594T5WOSk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8Zw988ybwIcFh2XxOnUblWYxcXQztdeAgTGe+gst68nX8SKlg
 /TVfK6ogYNAUXjJYOQlDL5g/yLq1RI7QE5SEQbInrgINF4CsAtUjRJvLwUFsagnGuro=
X-Gm-Gg: ATEYQzzqRhaAnxbz9OixWmJPgDTrHra/SvwovaT8VSKe5AY5vATaXEwfjHcLq8Dccxj
 +2SVkeMvKN8KurSZU0R1OIuDqr9pBTQLImcO39TCZ7AY9uvWf9fzFFiRVeMckfquVATG9imQuH1
 CJJwmVzVbIL0zarBNTbxyT+6AZU64/d+cBn46GQ6ldSO6jn6NqZKYUjvOcYqs/CWotEQjDapVun
 cZjrBFwYor7h2mQBWpX4rmCIXOXVs740bsl5t8PBtMck4gtPayqmkY4oPvY8+crsXDsWyMgxXmP
 BWIMJDWmvK705j/LqO+8iIAf1NnyZbJrvOMpk1AZP7ekJn/K3TLAamB26EAfQMSUH1/a1B1330n
 Di8DPWcRTELpwTiK/eEeWp+l2Kmb135DU0pT6PQ+C6fjx2M/XfsXuBjO0+lTXNbktC4VjoHoyW/
 kMH9gTGDg2qJ7dbJEC0JBHajeM7Y/ZMpK6cBrYCuQRNh7ffRpvC9a/2poYLzPWYjDhtXGXKz3gf
 loOneL2U1lrYbDkhl/3I0N1b6tyql4+l5RbhXOEgj5coRKddYY=
X-Received: by 2002:a05:6820:2011:b0:672:7258:c4f0 with SMTP id
 006d021491bc7-679c46174b8mr8644269eaf.53.1772032172579; 
 Wed, 25 Feb 2026 07:09:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c565728esm10709838eaf.8.2026.02.25.07.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:09:31 -0800 (PST)
Date: Wed, 25 Feb 2026 09:09:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] disk: fix DOS_PARTITION dependencies
Message-ID: <20260225150929.GI1593142@bill-the-cat>
References: <20260225130312.60122-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DzUQeVMkln1rUAwK"
Content-Disposition: inline
In-Reply-To: <20260225130312.60122-1-heinrich.schuchardt@canonical.com>
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


--DzUQeVMkln1rUAwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 02:03:12PM +0100, Heinrich Schuchardt wrote:

> * The symbol for the x86 architecture is CONFIG_X86 and not CONFIG_x86.
> * Correct the description. The partition type is called MBR.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DzUQeVMkln1rUAwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8QqQAKCRAr4qD1Cr/k
CnZRAQCNrVpKK/532jdU5HuiypIs3gWRRroglXwx50Urs4yg5wD+OJ2WCSCplftk
SkLWy74Ft/QiGRK66FTLStYlRVpWfAo=
=2k/0
-----END PGP SIGNATURE-----

--DzUQeVMkln1rUAwK--
