Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66484C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E505880A3;
	Fri, 10 May 2024 21:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D6czmsJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA73288005; Fri, 10 May 2024 21:32:36 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E688800C
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43df052337bso12229401cf.3
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715369553; x=1715974353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WEmIBd6tihR64X0+2TM0aEFWP4+aYnAh7ts+719DYyY=;
 b=D6czmsJHho1WCD3Wm/rjzf0envkQQP2YianWKVmq3f8r8qol031nU3ONedsJBy8SZ6
 Z5qqk5FXx7J4UYQCaQ7nFmD3bRuy1zG3xVJEYyx//GvvQCweO2hui/UySnOkDF2xHpbJ
 p8furoc1UWzrQ5+2C+eeKJxzGtxyNpNwHeTDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715369553; x=1715974353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEmIBd6tihR64X0+2TM0aEFWP4+aYnAh7ts+719DYyY=;
 b=bxT3uBobbUcBOZgNcCYhoSRgxOhGS7FvM6UE5QJkZmC3LFuON+OWk+3qKiZ40HcsJZ
 c+TO9XvphMoiTXk8Lyp906i7449hDi23xkF3mbDTHW6oaKVZx1uxHnTeytB3VL0j7yHU
 n/b6BJsSdg47GKnlWKw4lJJEFwT5VrySy/wu/PDke8/0N06cehl0RTXiHcKaJPEMSlEQ
 3QZ5DrHjHycbTMbsVZ2ZJe8EgifHD17iJuQ3Z2J9KXZ6bLne417MBiQjKZFdGCWmXXuk
 SzvOwGcKkoA8ytFHWtbXuJXAsbFs7X51JBiVIseftMXEcsRhvC6yR/BHDw7ZviYHI0Uf
 p/+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNSy0BWdS1V+q2jewFyKot5wirOfSVVqPYanQHBDzNNjyBx8+nNmuGaEUohhaBssyZec/w4ZEkVx+7XRDN+e7f3EZgFg==
X-Gm-Message-State: AOJu0YzfJvCNtYjVK6R6RKn81JUignjUo2D0YNS/12giSI1p44X6Qio3
 MzRVxatytgxcemCDWPhstByVVdfYRVLL4Yvn+7WrpalDyL7ulf5h1QJV4/aUoM4=
X-Google-Smtp-Source: AGHT+IE38pegeTjMYX3eIDNMYKWupuIHE+6roQbx5faQMHEP/rZp0WQY4ZqFZtJ4Kft3JvqneHED2Q==
X-Received: by 2002:a05:622a:1313:b0:43a:cc86:569e with SMTP id
 d75a77b69052e-43dfdb08016mr36526181cf.9.1715369553032; 
 Fri, 10 May 2024 12:32:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df550c10fsm24664351cf.43.2024.05.10.12.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 12:32:32 -0700 (PDT)
Date: Fri, 10 May 2024 13:32:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mach-k3: Move code specific to a SoC into that
 SoC's directory
Message-ID: <20240510193229.GW2568172@bill-the-cat>
References: <20240425213832.518539-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FroD1sBouILfLx+V"
Content-Disposition: inline
In-Reply-To: <20240425213832.518539-1-afd@ti.com>
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


--FroD1sBouILfLx+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 04:38:32PM -0500, Andrew Davis wrote:

> Each SoC now has a directory in mach-k3, let's move the SoC specific
> files into their respective directories.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Please rebase this on top of current -next, thanks.

--=20
Tom

--FroD1sBouILfLx+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+dkoACgkQFHw5/5Y0
tyy44QwAugtMNxSe41eEXnZGn4j8+tEaJ9Lmfq510hyqFcCPpYkfLmfycw+vAbAk
wjs3257QyQ7TAJSrGw5HkT4gKcXJ40MZ1PiKJouQRGY2pc3y6RD2Q1sF6Y/Kb6S0
+YgoJ/FjTr4BPCtqtyzpefyTHWvCkg+mJtYYyGzb3XmzSU8t2H7qid2IwQJlLBoD
nnadMpeNLYrx99gbktfQWAqhfKSuzcnkpDDIyxvWtrASjX3xUYO0WGNfhsJRTZ4Y
Xho6Pxr43vVevy7qOKAIVINWRXO6pVYew//y8i0Y74qG5sbfhXrGbHmn1U2Tf7qb
s3g5ZDIhp4HYt6Vu0KGZqK12S/azsvk6nkVG2V0xRTrkGQi2bXZZArQ9pj16P0zl
7lWcK3rJK+M11b/GW233C/QxFABM2wpheKGhHGZ87XTQfb52rPeRopmhuJzk2yCH
oo3aB7ZiqlRXnhkg0QWUJ0JcmKqPsjlS1EyWbuECGThBZ3uHmgwMGYGKZDhMQMV6
oyo4ajRZ
=du9K
-----END PGP SIGNATURE-----

--FroD1sBouILfLx+V--
