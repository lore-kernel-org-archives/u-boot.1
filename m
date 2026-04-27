Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CF9FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4FD8407E;
	Mon, 27 Apr 2026 16:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h+EEvvA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564F484106; Mon, 27 Apr 2026 16:06:53 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0572D83C14
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-68470763896so5380827eaf.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777298810; x=1777903610; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9x8GuFyFaBWJUB8Dl1oYSwoLPVmA2TniZGWu8M48vSo=;
 b=h+EEvvA0VH4WQAmNVLAxvvjiXH0m6yHNZeBQZtUFIsIudkSX5jxj+ejmyKaWxT7jSJ
 ABSoXFAkamoJSBEYI3bsLkaQh7lhFGs0dJB7UpluDbIClmmSQSdCiDloOjsgjKScnHG/
 F6eqRjPhYQBYLWOBTSuXyxqGMJFs859A4M/G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777298810; x=1777903610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9x8GuFyFaBWJUB8Dl1oYSwoLPVmA2TniZGWu8M48vSo=;
 b=FhmC0grb+zbQQulgr7bJMwQsRoKKPdOwBal3UBOxKLu/l88bajFJXoVG2bQOnPU3X8
 fBABtEuw5RSp/BHbnNCQfcEKi45mUOKXQvP4BE+aMpdgNgbdzCYfwjIaNeoFg81t3w3R
 /1DMTYvT7Cf2/ugns86YQ307DU7Nv/5egRKAwVAEjwhY+R549rVPge351Ej+Gcp7hhC8
 upsBxhfhlRDhZnpB8j0wq3Buvv02rOSuJrLkhDpGVYoUoK56SfYgXnJZhb4mx/iijwwd
 1iAcdbt5rd8FFzEnZb9isFb+7U1fudnRoHlZ1F7nDimYVpqaocniikIVK5q7R43hG1Cd
 8HVg==
X-Gm-Message-State: AOJu0Yw2LJy7eY7OYxh2SjVgpVLT1xgaegPh2qlkVIJurwBVLQG6n/Yy
 plx41Iddt62PNr8dKJiAScyJpVRP4qA6+Y8b2Df/+SkYniWS+yEW8coQoPPXzIrIuqU=
X-Gm-Gg: AeBDiesCcGz9JLwqL6Zuywa7VnDGOnJq3BSECoUwbNgK0wJo413dTRA7uha++hAERBQ
 dRaujDUl0xWo8RKh/HZTmd6pCFIf10YZD/NUfdvEflAHnxfShdPofzHQAd+XSLzcr1h3bkZIlPm
 7PPbd/4fCsdg3T1vlvsliRNF8+TwLy1GdCuqF8yXkg4N87px4qB7rztIwNXRkb+0HGGizG8SAx5
 6QK6XRz0W49ET0IVPzGohiM9IkibGwCsD1EekTllQPZEKRFfeg2TLjdPaaPe6Q6QWUYV05gdgp1
 /IRBfhORLHvMuW1lZB1TNMr5dKnlSSHqBW/1yrOjelcmmDxfOUdJ2KLBuHJ/8eePhdt4tS31MHY
 1Ipr2iQGmgacGU8+Yzhykav7YiM6J79CdXRqzbOsMa/JGiHmXCovCWOEgibQsfBuOSjp3K8toye
 gfwz1du3VibvHlXi6IXCMLMdaSKZq0CJr4MvfudZhO+OWIPWBdG+wMWAQjNShvf+QysUjfJvaiA
 +Wk4E5gaQ21GGmz/g0mxWGU0wwfO3xXdCi3Gv1/L2hwnfIEUjJK0X3bgm7PZw==
X-Received: by 2002:a05:6820:80e:b0:694:914f:c18f with SMTP id
 006d021491bc7-694914fc460mr16949378eaf.3.1777298809469; 
 Mon, 27 Apr 2026 07:06:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69464c77c7fsm19904321eaf.0.2026.04.27.07.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 07:06:48 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:06:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de
Subject: Re: sunxi pull request
Message-ID: <20260427140646.GD41863@bill-the-cat>
References: <aa0403ad-5d0c-464d-b8a1-d60830e10bd1@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xyFH+RerqLWdBOt1"
Content-Disposition: inline
In-Reply-To: <aa0403ad-5d0c-464d-b8a1-d60830e10bd1@arm.com>
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


--xyFH+RerqLWdBOt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 02:21:47PM +0200, Andre Przywara wrote:

> Hi Tom,
>=20
> I was about the wrap up this cycle's pull request, but realised that I
> forgot to chase up on some details. Would you be able to accept a PR later
> this week still? There are only a very few mostly cosmetic patches ready
> otherwise.

Yes, that's fine, thanks for letting me know.

--=20
Tom

--xyFH+RerqLWdBOt1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae9tbwAKCRAr4qD1Cr/k
CsQ+AP9n5OOF5F2WcQmExjtYaewwy/kbnScYpjrT+9QLb2oKdwEAnkJW9/KJfMx/
cfPWxHlrJGNl1UUpHgzep+sQ6dRKxAI=
=pSTe
-----END PGP SIGNATURE-----

--xyFH+RerqLWdBOt1--
