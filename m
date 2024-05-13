Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0123C25B74
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 17:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E55087C75;
	Mon, 13 May 2024 19:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UCnd5+WN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351D287C69; Mon, 13 May 2024 19:52:15 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437EA882D8
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 19:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b2a66dce8fso1319804eaf.1
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715622731; x=1716227531; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6u/y8JUV0KlK7ubW5bB1zFw2lpk2htIvt0tEAdOws8w=;
 b=UCnd5+WNvSka8TVPcPiOIyHlxLvVb+ZA1WvEC/nKsO1TLicckoVahGqdgBjMh9cJ4l
 EnTr/w+bNwnCRUy9fGLefvsnLb/B481141ykZ/kvm071jpfLFLYCKue5k4+0GRMJinax
 Epw8ZcU0s00U17pzyVb8MN3dZ/QPwynuutoDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715622731; x=1716227531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6u/y8JUV0KlK7ubW5bB1zFw2lpk2htIvt0tEAdOws8w=;
 b=QAFN7gZpz9IZVuNFcKfmaULgJ0QPdSof4mDO3b1rIrOVYpvj73CQz37FSuxUeN9pJn
 2XyYpN4pVfKYRiFCt5CmXA+wTSqwJJuE4GJpRwg+5ClYsSDKZ969HWhYiigz4uuUhTLZ
 nN7FRTqyIoQwPcL007wqeB607lhyIOTJxmdKC4Es8IRVQmfxmMy90EZHEypk7tp+iwER
 dOYyCxpT6oaHD3QMP2lihadcE/KwW5c+uPb5XjZp5k/aDMlLP71rX66wMvgJ/+ZNNJj7
 EO9/siIsP3m287E+jg7b3Qbge0AjpiPg7HdNbooh0SAM1QMpl+NCHYnXqhTLAVXT1u77
 w07w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA/jWzZgeFRqzUaNVuibL3SFVNHEs3yCITbV2kfKfD61stqmIi5AiiSFBCmbWSVRqZypifHFyUVVAGX71ls4DB7vOCLQ==
X-Gm-Message-State: AOJu0YzZt86369ESBk+bVXYweW8t3iD1q6GQLaIn+MogSmmQyrnNFhSi
 RRnAOW2rLES14XiXWnZzKCRzTRJqgTQGsoshlvXL4nWOhGTTDpQouhUcEpsU974=
X-Google-Smtp-Source: AGHT+IGvq+R4+Vkxo0v/Dv3sMtn+7wzf98PZViWPlzP97Onq0vvJoRINqutDS5r9Hx0u0ZmrPOypoQ==
X-Received: by 2002:a05:6870:c34a:b0:21e:a839:d807 with SMTP id
 586e51a60fabf-24172c344f9mr13987237fac.54.1715622730961; 
 Mon, 13 May 2024 10:52:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fca1dsm476003585a.92.2024.05.13.10.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 10:52:10 -0700 (PDT)
Date: Mon, 13 May 2024 11:52:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, eugen.hristev@collabora.com,
 Maxim.Moskalets@kaspersky.com
Subject: Re: [PATCH] arch: fix arch-rockchip/clock.h dependency
Message-ID: <20240513175207.GG2568172@bill-the-cat>
References: <20240513165916.24259-1-Maxim.Moskalets@kaspersky.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pe6+7TZPlZKIPeQW"
Content-Disposition: inline
In-Reply-To: <20240513165916.24259-1-Maxim.Moskalets@kaspersky.com>
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


--Pe6+7TZPlZKIPeQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 07:59:16PM +0300, Maxim Moskalets wrote:

> This header uses u32 and should include header with this typedef.
>=20
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>  arch/arm/include/asm/arch-rockchip/clock.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/includ=
e/asm/arch-rockchip/clock.h
> index f01c5aeb71..ade53e6fd9 100644
> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> @@ -6,6 +6,8 @@
>  #ifndef _ASM_ARCH_CLOCK_H
>  #define _ASM_ARCH_CLOCK_H
> =20
> +#include <common.h>
> +
>  struct udevice;
> =20
>  /* define pll mode */

NAK. In the -next branch, common.h has been removed. If this header
needs type information it should include <linux/types.h> directly.
Please check the next branch as well as I may have already added it
there.

--=20
Tom

--Pe6+7TZPlZKIPeQW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZCU0cACgkQFHw5/5Y0
tyzlFgwAugmgUg+wmorgKgoMwFvCfL/i1y54exmB9ijsJYiDOBYtEExaPtLUwfSp
QrdLFqvqCvMXJSjjCquTwI1Gc5L8Jv4jUso8Ph839jVVbAFZL1/j2b5NtukgSk7P
MuBbrypRr9F5mfPabikS8RfenuH9qnWUhjt5VeBgD1fpwSMJAXPzT8sgRjjT+lGo
+Dn6exulr4fCiLnU48OdFbglzoJitnGXUJnFGnbeMAVbVr/VZLDiour2ePyqhfZH
xGkHV+DGf5zoYbspDBTGoDVc8pj/BqouajM1ahuQbP+xnZ2PdFREvGUkjMtpRVnU
dBK8NaiYKOKji4YueLZI9dvrg+2dZ8vkIF2mkXv9mmtc+ef2IPmQKHrxH0eayMz8
GLJI5hqb/5en42TzM5t+momh3aru1YbALe37hp2LitRpvPEL1S4QOBVYKrYgn1fR
tpes7hYH4tF/CXQsipPOiEX3Lqyy0no4P3hjEMsVUPhAzl/A/Y88HkBxq5tkNEGp
TB8wAfzx
=JFC9
-----END PGP SIGNATURE-----

--Pe6+7TZPlZKIPeQW--
