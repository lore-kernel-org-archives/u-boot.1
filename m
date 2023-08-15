Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3DC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8523486986;
	Tue, 15 Aug 2023 16:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EP5LIieL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B315186863; Tue, 15 Aug 2023 16:43:01 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34C986997
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-589addee1c1so48792627b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110578; x=1692715378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pg+BBSnfZA2ZVDS3iIF9npAeusmA1mAMDwfIGa1BnVI=;
 b=EP5LIieLWuGZxDmOrpu6iBgjKrqq4A8jT/9Hf79uA7iEHfe4UhuYNXqB3qARLkXqBg
 xjLlWqLpyaET2FX8/Db9xfI39F0ft4xz7jyLtQXDxtCExSAcQJy270t0yT5HCsM8YgOb
 2K6u/YH2359+FIYatqDmjvI2CLy9HnD/YdQSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110578; x=1692715378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg+BBSnfZA2ZVDS3iIF9npAeusmA1mAMDwfIGa1BnVI=;
 b=hlk6KhjD/xV3NtqKY+k/R65WuPJj+BCtz6KXSAH1NpoSFlr/161J58XeY8dfyxT0u9
 ryIcVbufO/zL5QBbNnR/EGv3T04jKhtcPigMyq4p6sIDwvSLH2Dluj3S8bOXeO7c+xlR
 SKtVURtn9S+gjBjpPrQmAMyCTTOmQkKNQ7kh3tXmLVaLNCoK+gM81eESRk0jX2guCQIn
 1XI3cWv7VQ8fV7lIhvDgtj9tYESBUXBkMh+OC8sdqXbQT0SK5CWKqzGGquQzja1rAGLT
 xFjK+LLXuvYeFg8di3kRzAN8REO7nNpAqRC3vEJwN6lL42K0siOGxYqNyL7gbQrRApT2
 +w6w==
X-Gm-Message-State: AOJu0Yxg7UmjxU1AN6cALKgseKdtnBr86gge+69i7qaM/o/kreGEEFZs
 JFb/2RN6ZRYy1NELEavybnLQrdLglPMYuqAd/LnaZA==
X-Google-Smtp-Source: AGHT+IFvIIw8F9hf+U+oZi5/wF8tffE45O5YRbkt+zIFAWCPuamdiDVKMNNjWcEJmsS6c7ZahelelQ==
X-Received: by 2002:a25:c7c8:0:b0:d6b:1531:bc6d with SMTP id
 w191-20020a25c7c8000000b00d6b1531bc6dmr5913977ybe.30.1692110577803; 
 Tue, 15 Aug 2023 07:42:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 j71-20020a25d24a000000b00c5fc63686f1sm3012089ybg.16.2023.08.15.07.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:42:57 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:42:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] pci: apple: Enable CONFIG_SYS_PCI_64BIT
Message-ID: <20230815144255.GN3630934@bill-the-cat>
References: <20230714191516.37531-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zo5bQqSkJXLtRF04"
Content-Disposition: inline
In-Reply-To: <20230714191516.37531-1-kettenis@openbsd.org>
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


--zo5bQqSkJXLtRF04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 09:15:16PM +0200, Mark Kettenis wrote:

> The Apple hardware supports 64-bit prefetchable memory windows so
> enable CONFIG_SYS_PCI_64BIT. This fixes BAR assignments for the
> Broadcom Ethernet controller used in some of the desktop machines.
>=20
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>

Applied to u-boot/next, thanks!

--=20
Tom

--zo5bQqSkJXLtRF04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbju8ACgkQFHw5/5Y0
tyyA2AwAjNN5QstSDCNgxVNhJ87L9NEk6g1+hF1EtoD7pQnfJ1yXdTeAbeQ3k0X/
8ra99wulZ+E15otGOt0FgFIVvrB/v/8UAb1/XtYe+XCXrMghC3fpWiO3HW3jrlCA
JQpN6wRcFQsC3i+jrEr3GG73wBxy31BGsLbDAFvEu+9LITTwp6LxZyN4Zn77McoC
Hc9ukAVNOBZB5+iSINsR7bM3qz2qCz5RG0EdoleNkCePFZa4gVNf1tqg3v0UMxWn
FLg+9NXayHaAKVuFKBHRhU+ah/+pX5RVzfgscxpys6Kw7M7/nWWuC2O+ByUNIUMK
UC2tadIsbvDfHI73aSaql4Aupq/wAWPLnb6ASuO/Sn/bLlhQEngJGwLxZz8XRNlb
lDWVCJhI6RJ25KVXlBxYEKkhb9HXsqoY+45WBkd9L8aRcg6UTPu+t5WdwO81kIdM
LrLBtrEeiF1McmNJhwZyHxipKZuAPgpTLfWw732Au+Z7AMCGBCtCQzZ8RtO4dk7d
zYdgbnCx
=flG4
-----END PGP SIGNATURE-----

--zo5bQqSkJXLtRF04--
