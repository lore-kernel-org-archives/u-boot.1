Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C408C3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 18:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D4382A64;
	Fri,  9 May 2025 20:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j9Q1VBYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C462882905; Fri,  9 May 2025 20:57:55 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40278269F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 20:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72ec58e45baso1669708a34.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746817072; x=1747421872; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iEcODwY5IOyRsBSDhRojLS6OOYUKEqJXfGeC1vDW0D0=;
 b=j9Q1VBYb5FnW97vw3YMjw9g6p5z1kKmcpCs8cyTKQBmtASlwXKYFQ2oIFr6+RTfaUA
 jLhHjxYU/rOzg19yPnZZx5SDpk+wI1QYg35/6/jas8QGlvcJCc8149ypdNEfiUUxyI7S
 UTT4pCzE31cFsBiF3QVQyBWOlKXQOWZWri/KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746817072; x=1747421872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEcODwY5IOyRsBSDhRojLS6OOYUKEqJXfGeC1vDW0D0=;
 b=YrKMjCe5wT3jRJFekQdJDvZF7qI2x+JsvOx09TfRIFpkAqQo1bRzbiskGNBdHUtXFJ
 qGy3Xh4409+a1ECdlEmsodDQt8v+h8JtGOkDmlmMq2B/fmOYF0oJERwVuhQbHgUY2VAL
 JM/UVeH/IGN3YI/89xaV8XoPHmzYE/ahgXQ4IPx3YoEjI2uzUwRr03Q7o0K98gSA92NM
 CRSSbNUfAZc0aZ4c+AV27/WcRRV0duArM9Z33wrkSxzAtdWnRKJft9SqlU7OIptIVMZa
 tyLztwOAwQf0h/AYDDg7OaYT8GobAvkfscBPZ4TgImKX3GE6WOM+iVms1KZlahfBAUyK
 9mpQ==
X-Gm-Message-State: AOJu0YxXFGq7u9nQsFS+dvcC0MmnANOT0BoSrAP0LFlOM9A5HWTcrzJc
 x3eMA1LHb0vdHoVsM4vvPaPkzTqNW/3kM6u8A+YRj8YTORk7vl+QQVXEh8efNag=
X-Gm-Gg: ASbGncv3bAWltz9eoVjLph6BF9yGa7WVhl2vNPpO2frCMrLw2YUA4UsSBtOuaJ9Q/zx
 T3UhFbg6agktslDN+f9zwne26N/WtZJVWbI6pdylnV1W4l0Yqt0cpYYKuX0C6U7/+lu+v6pOGG7
 /Ym7B1OWHW3oXM3u5j8GfCl0c8pcnOufGlkka2lP8flmtbrdezwWwdQSxfUGigTk10knOg4GWn+
 szYau/p/cAbpy1KM80RXq8I9I0Lk34ef+7rCHOv/BfJnnARfLP8Do5zrrbKdxaoSC6WGlXUAGZz
 LoxLydBinLVElFoS4vk3pRjJ+EZAacsc2z725A2h3uR/2vqvQeoNu9HU2GKqzAklyIhOSU0IbIk
 M2inmmTV+2PMH
X-Google-Smtp-Source: AGHT+IEjFmyQaTWxLnVwIBBUXNNY9eFIAZHw+29mUvDnmJGQf3dppmp1UVET6gNrbT9DS+oKd2zuLg==
X-Received: by 2002:a05:6830:4427:b0:72b:a009:db44 with SMTP id
 46e09a7af769-732269bc446mr2770468a34.1.1746817072417; 
 Fri, 09 May 2025 11:57:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264b0403sm638565a34.18.2025.05.09.11.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 11:57:51 -0700 (PDT)
Date: Fri, 9 May 2025 12:57:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v1 1/1] x86: cpu: Describe board final hooks in the header
Message-ID: <20250509185749.GK603748@bill-the-cat>
References: <20241018155557.2184819-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dA68JuLsW1FWVv4X"
Content-Disposition: inline
In-Reply-To: <20241018155557.2184819-1-andriy.shevchenko@linux.intel.com>
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


--dA68JuLsW1FWVv4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 06:55:57PM +0300, Andy Shevchenko wrote:

> The new two declarations board_final_init() and board_final_cleanup()
> need a description. Add it here.
>=20
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--dA68JuLsW1FWVv4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgeUCkACgkQFHw5/5Y0
tyzvnAwAoZJyKP9oqTikKkveSSVP98ZR8ZycUiPpIUUS51Pp/plZx6wE0obbxWnj
bKSzw43m49xQq/8cMWuS9jzfOpNhrPgJnol6ZGtsVvuHykOKFga9ZzNuLrXuYZSG
6fMHM3fz/IaWaEPY5QSgQGYAg9nugc9666QICNW2Ej6qNF3UoknNe4U5lzbfKcOj
4iNyhyqIdukMHMSyEDoz/gMQ/a1PIXMCoEDXZOZT2nDLqDC5FY41oQKFgFPSgY/y
aPRoVrkWAMxlK49ZjXkSEGThGwu4r7L7IeCQU7dPrpBL0pMY6dKDmCSPk1b1ZDSK
zuSbTXGrWT+28NdqLckOEd7cIXreVZw2PUTDiaYFFk51iyV94G72RGZrB28lij+T
hQT6ukwz75CyLIPOutgdPyCvwhc3DbfPBgov/QLaBBXt2tXE0Ub1j7wtEY7h55Qy
qdCB3gfaYqDZ2K0nCMl5byxnHCqq/JBsdtd6F6EVew7E/ZVjNb9i6YGmwnJwPri3
pewjYMXK
=nRtG
-----END PGP SIGNATURE-----

--dA68JuLsW1FWVv4X--
