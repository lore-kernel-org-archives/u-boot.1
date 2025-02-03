Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57854C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C458880137;
	Mon,  3 Feb 2025 21:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XSRL5QkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FDF803B5; Mon,  3 Feb 2025 21:08:38 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F88801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso442586385a.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613313; x=1739218113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fsc0AayT87B1oaK9v3IMIh1C4B6gZklctATrcb3p7kY=;
 b=XSRL5QkAYnbGD4hLKQPdpntNJ+imuEXB7beUbkzZOapEM/iD9S7C/opxixTBM3ZBOD
 pNVMBnOA4f0qNiyfOo0wJ+kC9YNt5y7L6PChhe0kbW9Ayn8P1uMR9gFW/GNC5Gq8ksK4
 vfRwATbP7AJ+35+ZEnCcT/kmFaIXNL7ibn/aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613313; x=1739218113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsc0AayT87B1oaK9v3IMIh1C4B6gZklctATrcb3p7kY=;
 b=SDr7XpdXPq61WVZ2yrgYZGnGdbuOLfuNZEBjvhgIkN+p6hIqCBnkZS0OcFeb6dQMEl
 236NTBPO1Ir1JsUA9uMLZ1Oky7C24hT4jizdnMGfGkhb35BGXzYXi6lnx0jchS60BpRe
 Uro4i2eqMB4eh+su/jkss0r6w6PlkZZjmFPqe752Np9t9jNj/1eQd5myFxkKMNccsncX
 m0qK2TaZ2xWFQpb52c6xP3VQebLbk/yATOCO7tvtDhM9nFJBrqr3j/egw+FnmrZNqn94
 cupeniChE643GkjfjMw7v63CMu5dWOVKGG6YizWw+p5FqswblM0En34dwyZSIADqo+4G
 IQnA==
X-Gm-Message-State: AOJu0YzHsolci6BrDN8gzXwafle2aTK/rbdKNfVM2K36tTDjHBZ58wKQ
 pzv0BJpDpQ0NSUfMLUfVii9sQxZivgzLDvqH05fexLYprOKPB/CA8HU9St+EbuI=
X-Gm-Gg: ASbGncsh0hzGAlwBLh6PbFLIsLJpDno2KjhNu3D4n0haly946/FiFsQwvBGJc4YYXyJ
 6ga4RgD1WQ4EYlI28hb98qH+GkjWZ9kJ/93mHh2K8syXlRgwigM+dwXmwrYLimzF32XoMwKR30s
 TQ5Xh1kYB3Uu9JpzftwbixD/+Iju7hVH1SKLDtbTm8ILYavD0ZrERuGW5KweXmQnreH3/Vxgs8U
 9yD6PefGv35+fHOAPaG2C99O0aThdrc5dwhKvAHBpxYKQlz24Q4enHVqqMjFUh3bSG9I0g9sBPI
 8I+KosK1QVTYmLM=
X-Google-Smtp-Source: AGHT+IHIu4ClZ1OT5vzb0/p5wlZqRwZCTjMw/3HNr6zkVlBTdn8bz1CdmRJQm6D7aImB7HOpE+O6Yg==
X-Received: by 2002:a05:620a:1923:b0:7b6:da2d:73f0 with SMTP id
 af79cd13be357-7bffcd070f4mr3510705485a.30.1738613313086; 
 Mon, 03 Feb 2025 12:08:33 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90d3c4sm567009185a.111.2025.02.03.12.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:08:32 -0800 (PST)
Date: Mon, 3 Feb 2025 14:08:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 09/32] efi: Allow board/efi Kconfig to be used outside x86
Message-ID: <20250203200829.GE1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vRED2UqTJ593qjxX"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-10-sjg@chromium.org>
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


--vRED2UqTJ593qjxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:02AM -0700, Simon Glass wrote:

> So far only x86 supports the EFI app. Sadly ARM is going the same way,
> so allow these options to be enabled for ARM too.

Please omit "Sadly", that's tone wording we don't need here.

> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vRED2UqTJ593qjxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIj0ACgkQFHw5/5Y0
tyx9agv+JKRrAmn3MRV4h2zVD7+0KZeXAiKTPNk8TqrCiCO4yDwAGRBSGz2I9XJL
+Qyt5KP4E0mIeSfzg9jiXg7Zs2jki7jonnjR96U/YLHPZWRUwkQ9SQ7uGpUi5qcz
NVTNO/8pEjLhs9qidj2WP/m/Sz1kZ+T1hQAWP9pTiZrWTQ843RGPygeSli17y/Ni
uDg0NHyDmsZ0h5uXO69lJbx1Xj959AbRbVoJrXpRwI9nvTD/4gFxqnNpi8vYuIy3
iSjNc2gcuJBwYcl6j290FYuPjz1b++fleqZHQjAlJQAcGkvLrs8F4wg2h1WjVVyv
5mDQZPfKvfiH2Vbg7BHdXBwCv3eedf7SzjVca+6S2zdyuVHZaL/cgXrPOqK541Ic
e35QWVpXVRU+RjXAJ5GjBVxjSpCBx8xcWyZy0g+X0tzBkq17VaMlbUO8IcmPWElL
CfU/gbqFmuY3i0oUkKcLvCT5x4bpyfM/eCH+ZxMYkBjsVxPOxKtZmat2WyrizrUm
HsJSDtXS
=zJdt
-----END PGP SIGNATURE-----

--vRED2UqTJ593qjxX--
