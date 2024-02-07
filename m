Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14595C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C03687D0B;
	Wed,  7 Feb 2024 16:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fADzpv8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E8C87CF9; Wed,  7 Feb 2024 16:46:22 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F9187C9A
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42aa241b91aso5556291cf.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320779; x=1707925579; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ko4daIQa3GgKnM9yOTIMwU+jq2r1pBXPE413F4bXHzo=;
 b=fADzpv8bRre2qzh8TpnCh80Ijx+GY6ui1UfO7F2QGji9EuOhhZ8pQeew9ko/EqKNcG
 CsfdFPRsSQm7vfF30SZpEKPBStNByGpAzYXf88nk1tuPzSRYCi/bs8LAyY98/+yi3DRN
 K3Y9cGBXSPRQ0h+hMz9vWh2dVADHXcjWvfFw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320779; x=1707925579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko4daIQa3GgKnM9yOTIMwU+jq2r1pBXPE413F4bXHzo=;
 b=CIg6BFUIV8niUZjm9y1FqrcW4FnEXYCazlTjNjbkdFm+hOvU/VG0MdAR1pu5vFjazl
 tkHh8jpJe7ItlGvjhwCJp50DGal88jozRE8lkUTDmHC6P1W7DZyCQ6qfbIRknvHnsOHp
 gobmYhCDFFMS5xXniGCX0uXYhQcKKQCdk+8R3gjs8XRBPCBrLU+3WlIYMnZEBcoqCdCL
 Bb1lVq9/k2b4IeDUbm0wqTCuKKPyC4iGuLx30jVvP2JkY57ZFwZDQFGTDkBrSuokApOs
 F2Xp5gdssCOt0yVJ16pKueTq183Nxi88LWFZep1YsU7RcZjwjwVL6Tto3dnsszIQ2WX9
 7Rsw==
X-Gm-Message-State: AOJu0YyuhXn8vCaygLZ33geD0vHJVKTQz/b9ucUGtmSgnnjeOEEL+oXX
 wlU7x7gkGxXzbIm8MhTSqE5vGxL+pZTn2D0hZrpP8ThkI963WrIE7v8uwhyj+3M=
X-Google-Smtp-Source: AGHT+IFRbnvWuNQMnnG28IgiNZiA3is7yze+dKEfoKV68kBBYHzy2WfMAlAd7EdEiLECWsN6sqtPvA==
X-Received: by 2002:a05:6214:2a82:b0:68c:3df8:735e with SMTP id
 jr2-20020a0562142a8200b0068c3df8735emr6476974qvb.63.1707320779782; 
 Wed, 07 Feb 2024 07:46:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Vs2v21kOLWEjhX01Dv0fbiHU/I4PfN4Qv9ciXXnFUIuGRY4XSQPi+/YFk/uJkPemSkkzDodiRUonQMkS/nbUOJI/iw==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 dl8-20020ad44e08000000b006862b537412sm688295qvb.123.2024.02.07.07.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:46:19 -0800 (PST)
Date: Wed, 7 Feb 2024 10:46:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: REGRESSION: [PATCH 5/9] toradex: Use checkboard() instead of
 show_board_info()
Message-ID: <20240207154617.GI1152441@bill-the-cat>
References: <20231113030001.240020-1-sjg@chromium.org>
 <20231113030001.240020-6-sjg@chromium.org>
 <e40ed93bd8f371ec56b8fc451dcb458f3ce6dcba.camel@toradex.com>
 <102745d532a1fffa810160f06592a34eab321b6a.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="umv9RRC9iKUI/fvM"
Content-Disposition: inline
In-Reply-To: <102745d532a1fffa810160f06592a34eab321b6a.camel@toradex.com>
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


--umv9RRC9iKUI/fvM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 03:23:10PM +0000, Marcel Ziswiler wrote:

> Gentle ping on this. Any opinion on that matter much appreciated. Thanks!

Perhaps you need to RFC some sysinfo driver that ends up providing what
you expect?

--=20
Tom

--umv9RRC9iKUI/fvM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpckACgkQFHw5/5Y0
tyyivQv/Wux9m0uNJhID3ri0YF28vA9g22xRrGjNG+YmK2fRt4g64scQ0ka2gZIw
MN1MM55/Gt/YGTCfcuMqXFCeug0LOfjROExPZQ4VnbnQtxXTEdYUp8gLAOurCFvX
tWNGAsUo59vmShhdiwsdi3uKHJ3FoIpvEJRdQVezsGxfehAJKrvoetKvCC3JDHpw
DZWPf4pWcSZ3/1o0AwVCkZi+ywF90PZTS7TpPWGM6cZ8+TUbdA7rOElSDrE9Ftdi
P/az27naspy1cuQxaBZKie+e6E1u/RF0m7krKfnWTgyv5sBGZnWJQfiBL7g/RAKe
C58FT7qdJ8BpOQYrkn9WwJb1N43gjeRqXgdTwnFOWDHkKVKbVOiajYepXYl0JxYx
LgGuMXt4yTUikf+VRlbmbQRL58DgO0LZu9sxLQDHNmNDIphP5p5GFHgrkPEK8pHp
9CUk9LemaxqOcEcrE+i/8pIT2M2SCKs452d4/aeZiDheHUy8wXc+0uRZ/mhQ54ZS
IeFvoUgJ
=fPaw
-----END PGP SIGNATURE-----

--umv9RRC9iKUI/fvM--
