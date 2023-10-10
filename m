Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AF5CD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8D786B54;
	Tue, 10 Oct 2023 14:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rz60Gxtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04657869D8; Tue, 10 Oct 2023 14:57:31 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFF8869D6
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d9a58f5f33dso666678276.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942643; x=1697547443; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VeRUdpx14w9t7uUR7v/KKcVs7fpD/y5VDI0ahrKVvBM=;
 b=Rz60GxtcZZ9ygqtpKLpnM6qU8EHll82fCGMbJflLU46YWlNrAiRctWyiHjtZXSzHrN
 Alm2+/q96iI7/lQqEk8M53ndy0RPmxjK0O6lafDaln4TTpxYYkanlCM34zzX4CIhnC53
 wndowjUo/ziBnA3d0u8zJRcRVhAQ1Statf1hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942643; x=1697547443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VeRUdpx14w9t7uUR7v/KKcVs7fpD/y5VDI0ahrKVvBM=;
 b=GKwl2VmMJyrw3yKCQ/AoYgJKRiFMFEc+hA748DhOBnXlTtq2SVs87uDoUnxF1F36mq
 nECzo9Gdmi7SHhO/nH/YK5NBA56B76/3lVTAZ3nShi1eb3Gwz9bIJg4kbtcMjMTLQYMr
 XTFZEpIWkzQQUhxrvEVnxCsVFVP0cLKxcMwFNxwVgEgWdPT5JAf/gNuWZkCFKI/5Bh/y
 sWUQ23riah7bUP/ZLnPLcgvs726t+rW67T05M6XLriV0zOdAwTP4kGMjAHaxGRjF3z+1
 2y4jwXXwJ8FcedEwfbxiqz3p/cYnVIeeDiN7ZAe9F69wdNeATvFgppaZd/mEh0VHGqVa
 XSdA==
X-Gm-Message-State: AOJu0YxWVS1WlLecafbpw206U3lxRNDcdYiwHsnWtMZs/Hkm7hvDcvci
 k2meYRe9dAOCZx94sG3exOmyKA==
X-Google-Smtp-Source: AGHT+IGeUfaX087HWLB/w8E4V/ieBgFgJJKCL8CKE3p1qfDB/qioG8Rr5lrO7vw6yuD4ctx5V2IjKA==
X-Received: by 2002:a25:9e83:0:b0:d86:57cc:aa74 with SMTP id
 p3-20020a259e83000000b00d8657ccaa74mr15021203ybq.35.1696942643069; 
 Tue, 10 Oct 2023 05:57:23 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 v188-20020a25c5c5000000b00d911680fd10sm610169ybe.50.2023.10.10.05.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:57:21 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Chanho Park <chanho61.park@samsung.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] spl: add __noreturn attribute to spl_invoke_atf function
Message-ID: <20231010125719.GP2227687@bill-the-cat>
References: <CGME20230908080912epcas2p311f577b1f5d36af18333daf4a327e7c9@epcas2p3.samsung.com>
 <20230908080856.2819538-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hkvNAXMlTltlj5O4"
Content-Disposition: inline
In-Reply-To: <20230908080856.2819538-1-chanho61.park@samsung.com>
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


--hkvNAXMlTltlj5O4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 05:08:56PM +0900, Chanho Park wrote:

> spl_invoke_atf function will not be returned to SPL. Thus, we need to
> set __noreturn function attribute to the function.
>=20
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Applied to u-boot/master, thanks!

--=20
Tom

--hkvNAXMlTltlj5O4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSiwACgkQFHw5/5Y0
tywN8Av/dV6n26OuA0n84KoleqOPAoRM7fXEpT4Ipen6eMlvfnTHVuMm8+4lE6Qz
U9mj1x5RmWLrpEFR3qfrBn9qwgG9T8zz3x2v/07eLk21YTASV89z/a/TjLT9G6Pf
5jj+4PHt9EKPXAnms0VYqyql8YDi6GjZihZvnGAyyA5rKu3oTrKP0CeCukEWMUcH
Cq3+gSBA39QaKlV6TfVo5Z5GSDafnX0GJhlVHso0z/YspGCTsK+SbIknsLMEWxwo
QqN4Jmk+6ZEEffPxpq3hJoS2u8Vm9MEVu4V7aQeoZsf3beD7Zy/CC5uCB53gMERg
BNHdmTmfFi2+mpajjrycx6xxHtbke2dJy44MydskEG6DQPsZuYURWWYazr4/a5+n
sz5PqUl/GOunl6PBEBvnP3oibp2ZzAldFw1mpVu+bAkANVjPo5T2C+pc8IrBCI80
ZzzMIFeT8xsROPtaI/RAu3SZSLXB8RMabt1nuC3jIgynyHhYLcTEeCaUCN/NEN2j
0dSsuowS
=JImF
-----END PGP SIGNATURE-----

--hkvNAXMlTltlj5O4--
