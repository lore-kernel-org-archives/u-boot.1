Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B54CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3955783071;
	Mon, 29 Sep 2025 16:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PB11hLKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715D583071; Mon, 29 Sep 2025 16:03:48 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE8182A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-74c7d98935eso2515836a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759154625; x=1759759425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bbHWYtGOwTLzbYw3mnCLx3rG2T009Ui6DcsabVN7pTA=;
 b=PB11hLKENHjkhP7K1BmO4EHLXuseHo98ERkmMm5BqfnE3hiazqS6Z9cjLEziS85HNl
 OHRY5H0agrUA1jcs93ckStjGYrire7BlnFvAJBGHo0Z4Nleviq7N/1vG8fiZ97eSIxnn
 DzdJrDFGzfGWG30vyln1EHBSqIcbUDPTIt10E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759154625; x=1759759425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbHWYtGOwTLzbYw3mnCLx3rG2T009Ui6DcsabVN7pTA=;
 b=Y5rvbJ868qyvdTBRfMdTPa+MpnGwei6AtsWpEIVYg+Yra4okEhS3mpBaR3EJ55te5A
 8kkWpZKVU+Ix/RVdH3SsObPxp2Arid3XQwnLBv7LMaiwd0iS7xM5NZkMDh6RmzCE2uXU
 NQQ/+AziSjmB8e/BU66At+iGyKil43jPo0n5DklFBnieujux9NGZ1bnwHHJMfzeJtsaI
 BaXkH6W8bAHDJFl46yKCvnk8KaUoKspGKAM1wAbTYXcc8mImHDgtdA8SKi+Io5QI9uk5
 +K+BCw5gNw6ISP1XwdWTxUsSq5FbeAWMaiX7ar4g9unTsQoVUgxBEjfh4UGzzClzDGq6
 6+uw==
X-Gm-Message-State: AOJu0YwAi47Vv0T9GB1nDiXEvIrqOA87IEIIOxUJhnlKSEQJZRvEVg8S
 FzBe1oU3ug/Oq//MhVI43lclTyFg4i8nNpORHFjvh71SuGUwbd6Zh8LhS6aSNnsPW7I=
X-Gm-Gg: ASbGnct+NbB3D+keLn2ZUekN/qHOEUSQvqXFb+zknmkL3tcGB20hckrw0VHB/JjRuC5
 N2BTdrcH7RAytfInCscE1TwF76nFi5cRASlfpuTBlLBuUIZuayM4KHTpo2Kp8tKOyclwJMwK99U
 08ctwrY3ID4Z1uYfGJccdzjzw06FAlTjjM/7FtGCJmWpBWFvq7Acu80/icKknld+OQ8ygxcXQzV
 Lxk8LEdC4keZkrT9uVQSwhS0xsuuc5OILbzehspEzRNGv+QDzZ+pRVnUOzapdGHNXfmRQfudetE
 hJ7CsmBZAvFGW2eMmOeUJElmdP/2pYj9CDUbj5aRR9guapKJ3DBzqzmnoFCQ8OzgHw5V4XqovDs
 CUsbtHd7qHNPsvDA/Ztm7va9OXo8ksNkCCaa6kjmFwvIXQd73Q8gMwZbjonJ9CTSm57E=
X-Google-Smtp-Source: AGHT+IFjJBmjyVTbWK6pAKtTh9qBgaY8cLNdTAa26YTpOwJOzigyHI2NnKRBdz+RkmMvPLsqAx/FVA==
X-Received: by 2002:a05:6808:7008:b0:438:2440:a58c with SMTP id
 5614622812f47-43f4cec351bmr7751520b6e.43.1759154624900; 
 Mon, 29 Sep 2025 07:03:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43f5123bd62sm2195777b6e.24.2025.09.29.07.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:03:43 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:03:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] test: led: Add missing ';'
Message-ID: <20250929140341.GB6093@bill-the-cat>
References: <20250925205026.3561694-1-trini@konsulko.com>
 <68da5bf4.c80a0220.2f77f4.4c19@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uuvKGKimahHA/Oe7"
Content-Disposition: inline
In-Reply-To: <68da5bf4.c80a0220.2f77f4.4c19@mx.google.com>
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


--uuvKGKimahHA/Oe7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:14:09PM +0200, Christian Marangi wrote:
> On Thu, Sep 25, 2025 at 02:50:25PM -0600, Tom Rini wrote:
> > Some tests here had not been compile tested before submission and were
> > missing a ';' on the end of declaring struct udevice *dev. Add it.
> >=20
> > Fixes: 9046279d92bb ("test: dm: Add tests for LED boot and activity")
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Christian Marangi <ansuelsmth@gmail.com>
> > ---
>=20
> Sorry Tom for not catching this, I hoped the CI enabled these config.
>=20
> Does the CI for these test use the SANDBOX defconfig?
>=20
> Just to prevent similar error in the future.

The issue is that the new options weren't enabled on sandbox as well.

--=20
Tom

--uuvKGKimahHA/Oe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqRvQAKCRAr4qD1Cr/k
CqZKAQChtgMj7KXLqLX8JhiFBWcWapto0o5FMeXSFzRKzkKL2AEAgfTldVBEtzqU
Zz2Vv5EY7JTzdwycPD1oa/5UouWM+Ao=
=mW0O
-----END PGP SIGNATURE-----

--uuvKGKimahHA/Oe7--
