Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E772CC54E64
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 01:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278D887F6F;
	Tue, 26 Mar 2024 02:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IEDEoHPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645E7879A0; Tue, 26 Mar 2024 02:59:31 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1DEF87F77
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 02:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78a26aaefc8so311124385a.1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711418366; x=1712023166; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=stPaFWgGyOkb477q1K/dnU16JeuEfkSDIrrST6r6Y2w=;
 b=IEDEoHPhRjwCaf/8iE/nFsah2+4GeqX+xyMriHfC3diw4ZpusOyrsZ9MhQl7jZnb8u
 RSKi7yN60WnkQ/A2RSixE9+v711rpBl76KTbQhDvrqxXWzz0bwfbX6xLuKo1+pCaLjeO
 R1qWzo05UrF7XWqrLv8/WEl53KVQssuSiAUjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711418366; x=1712023166;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stPaFWgGyOkb477q1K/dnU16JeuEfkSDIrrST6r6Y2w=;
 b=fKxilhJ4pfhWxBsQ/anRjC+YN6QwNa1xxVZZ7pKz+8/8wYzmAmh7rO2xqOkuApkcJp
 uxjP7katW61zmFyZ/CaoHJoHbu4Op5CJB4lIef5Tlkrsf0IFoR117xjaL/aVGShCgha8
 WVkiL76SlXgyqWdKPEArohVnmRlz3gVVg2paHjOcEeTI5R+XgNfbu6pvU5kC76owDow2
 eQhZq7yEXHL9/nQFGGYB5zfqR4SA5DlkfDN33aqcfJx99YRKFa34U5vM6ggkuo/8ECs5
 NArSFNWcRinmxCNj75uGyMgyz00aCPHBCnM+5OhraEVoho0CoaPjwgItyxJj3Kh39qas
 xCQQ==
X-Gm-Message-State: AOJu0YyKHbxHPIuKlrOaXvgndvLn31fwUwXHMXiez8aNCh54akTpNP7W
 GJgXb7uOvwBepWpn2iyYDlR7A2M28NJ4JSb6bw+BJns4WQRBP4vFZX0F3sIEY+JO5QsDfvAIlAO
 Z
X-Google-Smtp-Source: AGHT+IHdpc2kFTvQ+O2UDVn6QFZSjMSJZCXEX16djbhaoQteTDiGaDeD8YS+CudwnCsGWvwEuw2xhw==
X-Received: by 2002:a05:620a:2f3:b0:789:e983:9f1 with SMTP id
 a19-20020a05620a02f300b00789e98309f1mr8704154qko.14.1711418366370; 
 Mon, 25 Mar 2024 18:59:26 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 d26-20020a05620a205a00b00789f221a46bsm2601731qka.119.2024.03.25.18.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 18:59:25 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:59:23 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.04-rc4 released
Message-ID: <20240326015923.GE3442575@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/5NwA1KuOZCrBIWC"
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


--/5NwA1KuOZCrBIWC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's very late in thee release day but here's -rc5, and I'll be updating
the next branch with this as well shortly.

In terms of a changelog,=20
git log --merges v2024.04-rc4..v2024.04-rc5
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

At this point, we're a week away from release on April 2nd. I know
there's the boot fix for some i.MX8 families but I'm unsure about the
testing impact on non-i.MX8 platforms at this date so I'm tempted to
just let that be picked up as needed in distributions that can get
testing done on other platforms (or are i.MX8 centric in their patch
applications). If there's anything else that must come in at this point,
please speak up now, thanks!

--=20
Tom

--/5NwA1KuOZCrBIWC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYCK/sACgkQFHw5/5Y0
tywEMQv+PWjDtLN10ml1UjXk6AI9hsDC1wAKEdU+YWgFvZiO6y7qnz2+2aIW1vkY
vB5OtkGM2B+i0zVOvSl/yH3CuymZLthUyZtkIc0fpcDL2VoxpfdDXW5jLc5WpIaJ
Gy6EfvWYHAVFkdwg9WvX8xm/8fcn06bdeCFJSGLFQsdFpOgMDtbVYvmZTnUKmMNR
Il55daMGgUBDYuVKAhrEXkpg2B+PEga0HFIw5n2/55KfS5zCumMGFR0Y06cxbX7p
1QEp93EcFoktTiVSX2fx6Py8YZYFqirbojvLmoFxy81e++YH+js26kN59vDvpmks
ajXt0RIxCfUTev0p1Lwyhk7JryvhUJ+HKyQD5v4oYnwwhs9ffuv404tq7T51mcyM
pxVi2vpB2gluLRlNCJtcnXGPN1jF18e8FCr6KCP2rloUpe7zTdEqMbKZXg+i8jrv
/sqN/34GXtgsfomfeH5dIsOgEM83mQs9QRPBYapcdINq5SAZpoHAfJLiYs+CqFpX
O8GRklu2
=fiUP
-----END PGP SIGNATURE-----

--/5NwA1KuOZCrBIWC--
