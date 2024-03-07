Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63045C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 14:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9458087811;
	Thu,  7 Mar 2024 15:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lZ+RM/GT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2083C87DDA; Thu,  7 Mar 2024 15:35:09 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D564286D73
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 15:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7884bfc763cso8505885a.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709822097; x=1710426897; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jgt65plZvVjSIGHwNWNiPxldq1fnnDCKBgy2B8Jhucw=;
 b=lZ+RM/GTHnQz5E6K1cIi/GsLuTsJmF/TOEcHAFPnjIbMNmJYBH5h5OlwFny18POfj6
 GbNgXUNPj7xxWz1Z/4BqjSbEN0o3d86JuqxJZErdhdrvyCofAxCbPmtaKTqQi8W3p8xa
 v2yvrRnQ/hx/fWbwsQ7xnAGkxvyeTmKz4qt0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709822097; x=1710426897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jgt65plZvVjSIGHwNWNiPxldq1fnnDCKBgy2B8Jhucw=;
 b=aRc0qH97y7z/HX3R1NiwHyZdLY1kQykOq6Qnb5hOgisiKZ/D04WooSS3NovytJ09SS
 QHl/5CwZHmYIDpEXKlkpeCLnXZn43UaKDvb/hZi8NnyKscxgffFkHMwM5QHMYwygyQSm
 9kJAnRU2+3/loHzebg9liCcYf8nZYu08pjlJpyYEPFMNrAQrz5y323c6++3XVbs9RHkq
 rLN2v8Oc6yZ9CJdkPf2HfD8aqN5KshhFhjIvkPt3hkghTQ6/aJStlmrLFrZyqYxt/JYu
 6xzSGnKq17oFJsiFo/DKFm/kzWKFH1yhR+aq3XK4kOjmpJcVWeHs2RWd447ITN9d9dah
 zd8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwAaljglFT7aeRWfV/bKln0tGryoD2bYIZGve9QaSGHiRPvuqVuV8ZmHMlOvTPKVBH+sd0/nuV2IiNOiPvkZaBmtvLXA==
X-Gm-Message-State: AOJu0YwQl/WE3fN2rWy3f4/ck2oW/tU33WaPM7H89YOujFcljc5KKJ/V
 lxaIrmOcq06UgYVrL/UPrz8YiVGSl5Zo0Zd0IeSwquROrQYULA6PxndtdoVvEk4=
X-Google-Smtp-Source: AGHT+IH0QgaaiFlF5AlDEEpOjkItuY0cWZIdlXkGP2uHGrlTq5d8Lm42PU83fsLkWMZwGy2mmgD/tg==
X-Received: by 2002:a05:620a:22ca:b0:788:2527:1a46 with SMTP id
 o10-20020a05620a22ca00b0078825271a46mr7365076qki.60.1709822097527; 
 Thu, 07 Mar 2024 06:34:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 pj28-20020a05620a1d9c00b00787c1df4044sm7599686qkn.118.2024.03.07.06.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 06:34:57 -0800 (PST)
Date: Thu, 7 Mar 2024 09:34:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: mark.kettenis@xs4all.nl, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4] disk: dos: Add all options for EFI System Partitions
Message-ID: <20240307143455.GA152801@bill-the-cat>
References: <20240302112034.593441-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n30hwX03kvZV6X8u"
Content-Disposition: inline
In-Reply-To: <20240302112034.593441-1-pbrobinson@gmail.com>
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


--n30hwX03kvZV6X8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 11:20:31AM +0000, Peter Robinson wrote:

> The EFI spec states that the ESP can be any of FAT12/16/32 but for
> compatibility doesn't necssarily require the partition to be the
> EFI partition table ID of 0xef. A number of arm devices will not
> find their firmware on a FAT partition with an ID of 0xef so also
> allow the original FAT12/16/32 partition IDs as they are also
> permissable for an ESP.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This leads to these failures in CI:
https://source.denx.de/u-boot/u-boot/-/jobs/794519#L598

--=20
Tom

--n30hwX03kvZV6X8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp0IwACgkQFHw5/5Y0
tyzyXgwAnIQXPu//j3diEJx4j1iSRCvtD2coXEcSh6kLAoxRwQZlf8nY5tYUxIKZ
9ozIIzCV5dNbdyAFeSuboTOVFV4xhwkS70MVPR6K/ZY847OdVL5AiZFnKFRYDcSe
Q35lRG2JcHtzGK7cpPSor+71Rz3UTAGwl+m5TuKichZDhYiImnh7B/wVrWl5YtjP
Ii9CiS/+ivTt4B4MGav/vGt+M+8KXfQWrS1cOTcaQ/47vL8o1NVxQDGhTPWwwf1h
ktTsE1fGz2fexwVE0nFbPlg7GnnVit87CAr+GukLnqkjk6II4muLZMCk/9r051Ec
SU9JnxXvpAZZM9JI1FILmselRZZpFokUe1HL3laWtmxKL6i1oSg4kkA+yQulrN4X
buI47//7El7WrZ8/F5h7YRJc4FhPtMWyS4wOXPGuqq32xM65657GHFfGJHT2Xxei
gn5/FdXG+jhEkdNpTd/UQe+fnonv7rY4uORdQtxNni52uJNPv5Cx0pN3U8ln3vFm
KuI05sJU
=wMDa
-----END PGP SIGNATURE-----

--n30hwX03kvZV6X8u--
