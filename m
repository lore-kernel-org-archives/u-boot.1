Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9CAC4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 19:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BAC28701D;
	Mon,  6 Nov 2023 20:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qMOWlcHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F80868AE; Mon,  6 Nov 2023 20:48:31 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B06987016
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 20:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778a20df8c3so339976485a.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 11:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699300106; x=1699904906; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zD71h07pTBtuzstukgXZx1qoaDDqr81UNLAY9es3n8A=;
 b=qMOWlcHUZv9StXBhM5B+OWYn8fACWiR4k1N30vqpQyPZt0ze35G9FQ+zqCZzJGSARQ
 e321zBdY9pe35w6nJIvuMVnRo84mJaJB5CHxxQVy8NWV+cOLPaHKHzeWFAd9vq7z4h6V
 DEqy0ZnQ2nNUhBLSJiJTAC9RjDfS/Z703Mqdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699300106; x=1699904906;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zD71h07pTBtuzstukgXZx1qoaDDqr81UNLAY9es3n8A=;
 b=Rer3LOWrj/t8al/qK2GxTYoRY1AlWJXLZHGPwayABg0JyR2t2HysJuX62lcj7fiact
 Q4cbST0Z0t+Kw39Gz5ocrM6UyzBgq+H6ORhwO4dyllNjoiMG8ykOVItRDvZNT83qNovQ
 CIwBwu2YKQQHwuFzsjIU0x0m+W+C6drdPx/guOMtubpqyQpuEWsXz7kT23ueYFQPVoop
 EWvDfWBYh9kdHOTmaOetzS/bmAG8rWTDWF0oIv3BMR4o0o6eF6yNv2TfBg92aDxxBBCc
 hqi3fRSHY2bHDNuLfdhF/4Yvvo2T3/5nUCM/K+XH6TS1+pOzm0NzBbxBnZSxyOjBhuvr
 LDMQ==
X-Gm-Message-State: AOJu0YyMu6vGqwAF+McOl4gGWS9IapadNcCzdOyfuVQAoIVrPgVPdw7b
 k0eAgfFDJSP1dggf6q9Z28vecz/ozi0ULbsFYM7/yw==
X-Google-Smtp-Source: AGHT+IFaYx2CrJpeWtTjfp9wRHx/yc/jye4lTFMNaRJvIR5MoJhBS8fKS2ZUHhmzW4GK0JcmMHssjg==
X-Received: by 2002:a05:620a:172b:b0:777:74b9:219f with SMTP id
 az43-20020a05620a172b00b0077774b9219fmr37893347qkb.8.1699300105825; 
 Mon, 06 Nov 2023 11:48:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 n7-20020a05620a294700b007678973eaa1sm3572766qkp.127.2023.11.06.11.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:48:25 -0800 (PST)
Date: Mon, 6 Nov 2023 14:48:23 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.01-rc2 released
Message-ID: <20231106194823.GC496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9EmGG8bgd94M8nog"
Content-Disposition: inline
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


--9EmGG8bgd94M8nog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc2. Looking at my own queue I think I've
got everything out that's not for -next, but there might be a few fixes
I've overlooked and will give things a harder read once I've merged
other things in to -next and the page is just more readable to me.

Speaking of, the next branch is now open and set to -rc2.

In terms of a changelog,=20
git log --merges v2024.01-rc1..v2024.01-rc2
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on January 8th, 2024.  Thanks all!

--=20
Tom

--9EmGG8bgd94M8nog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJQwcACgkQFHw5/5Y0
tywNgQv/fgLfptOwmgcfX4mleDWOEjujrP3mB3lp4QP1d17Sck0A0t6YdBlxwB4/
3AmHrQUq9aBcNHyDmGJEOMRWy6ZVvldJuLK9rM5WYF7plpm0WFsJ1LfqelGYuPAA
TDGqyHJbHjpKiTdentdhYlyoXRSkMjxxqTdzYGo3Qg5tlAhMgWfsUQ02KqXCZ+No
iAV8nkJlJ6TDe79z34NuSP4qGV73Y3dIEk206g3J6xmfErvP1CURcrTMkzkLM4OF
+m+AOtT58JbsXM6ytRljilS9L7wzBR57WBa2QeP/PJxke6cCqqhiD9/YeqIaGRLA
pzDuzIpRbg/07HHnR/fnIiXJZ/OfX/7DhDHnkvCSNAfHVDVh9rsB8tbedx6X+xwR
+jsjkAX3uZ+hUrCwMWF+zlj8PSid0h30FjA74aTA7l4oJ5muu7R/ZHDihddcq084
2YcAS7XqGV7wK5AwWTDNnQa5ZMDu35jTGfop6Se0NQ/pNAkzunDWlTnpXnIiKv66
zqQTruJw
=M7t6
-----END PGP SIGNATURE-----

--9EmGG8bgd94M8nog--
