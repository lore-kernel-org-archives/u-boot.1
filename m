Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF6DF428F6
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 20:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078BD83FFA;
	Wed, 15 Apr 2026 22:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c2mJsA8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 572D48407D; Wed, 15 Apr 2026 22:44:29 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3544883B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d1872504cbso6431808a34.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776285866; x=1776890666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8XT+3jl6dd3wdwDDo7USgS31vI2kycOeeDl3WkRbI90=;
 b=c2mJsA8bcUfpJSmSOkxkFG7OWyY2+UaF94jMR+LcmmdJ0K32/+YuoBHANvvBKHKP4E
 Z6B6FZg2RB7wiWH2kd2BPjdUL5CDvyducy9ZjMTfTHG2ayma4hkfEKlGZJQafxa6lzwF
 UzxqNBxXEupryJGkQCtQ0SiDLZV0LVAv1WDwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776285866; x=1776890666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8XT+3jl6dd3wdwDDo7USgS31vI2kycOeeDl3WkRbI90=;
 b=mw6xuwblUPwEYgQdsbEg1ThYgbMwYy+vyplZjf0OifEfweqiNJXhAO7LfxD1DF6Rlq
 Ajp9O/71hlGVNEESC7jY0nJQPk38bGHoifTqyI3qmFCIYY6zh7p1E7Kqq1/u6OLQegmm
 su/MVmCE3Vmrzpij3JAShMIh6P/of+h2q02TrmQmf1SJ6pQty48OXkAhg6m+m7YwfL9A
 LSpsE2CnbQGDOUQgEopjGqHb3hJNOzdxUyKwFZcKbLWFGJrbrlLthBEG/pFXnpRfKhLG
 Y+UmyQ1SQfD+oYWKQFJdXkPANW5OktyHyW+4WRp06GzlQ4ZviJC3CYTHcAUv49kzQLGI
 My1g==
X-Gm-Message-State: AOJu0YzWErFR7E8OgOEtZU1tfpud6WCkMzHtQGohqOJ9gfWeKiHUMNde
 0yGEpcfhoYaCBhWAxeYGUXgpI9AU7YkMKy3RTFhFL3JxzyxOy52XKjHRnNEKwWrMY8R34cyIXUE
 yJYdpGCQ=
X-Gm-Gg: AeBDievIVfjoLln54lXfJAHz0Ul5fL3Zb0EzdxoUtC0cKFDY0nP+98cYImNMLG64WCA
 DxsmKwVHNpOG7UXYLOH/6exYa9SkNdfkWYsBhB5OVWTFqU0w4+IvL0FKY7ill3xEC/sK50HYVpI
 /GuIIrazcKpwvOvcCtlDSb+jkjwo10Ddom7f+edErTjlM+Xd858B71tgrBFzZHP2+FnxkOsJVfO
 ePVQfRxrMw6Xof7gpG49GfhX6ArVqdJbCw/WxHMD3zatgYWnBWnnT7XH4e6b4w2/w56SwpvLD2u
 Bnj6lFKiuq+SQOcUIWkes83zyGEtbqXaYp10smfsP8CTBAwtzCol05ifSv5E2XrHu6MNQowL/oz
 h0s0LSycPAn9CblN6ar2GxNqCrUUV//I/4j/+erIrLEAOwL3aAM6fjSS+2yO1ppjrXzB2X1xVbt
 VYJrcnYiIPguBnIb3qRXtQ3iuGzlWRKyCv6Uh3id+ldgUG0KHqZ36PasDyi7rM3XNSuQ6aF8TnB
 2NWQt2mDVzxLAHWSAnN0JE8MasgeSeWL0MkiSQOJtx2DwgHTdhAglZKu1ev9w==
X-Received: by 2002:a05:6820:80c9:b0:685:ad47:d7b2 with SMTP id
 006d021491bc7-69423310442mr537207eaf.21.1776285865864; 
 Wed, 15 Apr 2026 13:44:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-693ec6a0605sm674865eaf.2.2026.04.15.13.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 13:44:25 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:44:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH v1] drivers: cadence_qspi_apb: Add 1us delays in polling
 loops
Message-ID: <20260415204422.GA2526031@bill-the-cat>
References: <20260312114419.21163-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M8NjSihaVV8beqJT"
Content-Disposition: inline
In-Reply-To: <20260312114419.21163-1-boon.khai.ng@altera.com>
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


--M8NjSihaVV8beqJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 07:44:19PM +0800, Boon Khai Ng wrote:

> Add 1us delays in busy-wait polling loops to reduce CPU usage, minimize
> bus traffic, and prevent watchdog timeout during QSPI operations.
>=20
> Three tight polling loops continuously check hardware status without
> any delay, consuming excessive CPU cycles and potentially triggering
> watchdog timeout on long operations. Adding small delays allows the
> hardware time to respond and reduces unnecessary register reads.
>=20
> The udelay() function includes WATCHDOG_RESET()/schedule() calls that
> service the watchdog, preventing system reset during extended QSPI
> transfers.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/spi/cadence_qspi_apb.c | 3 +++
>  1 file changed, 3 insertions(+)

So, this is fine, BUT it pushes socfpga_vining_fpga over the size limit.
And I see SoCFPGA isn't enabling LTO at all. Can you please get that
tested on at least some SoCFPGA platforms and then enable it for all?
Then we can continue down this path, thanks!

--=20
Tom

--M8NjSihaVV8beqJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad/4ogAKCRAr4qD1Cr/k
CrmZAP9/z0gjV5AFeNl6JLJGLjo8quW1NaAvh6k44bDYt02rNgEA1ou0hwQs3jEy
zturxqHTMsgBYHlektI5Yc4V4gu7hwk=
=n0cr
-----END PGP SIGNATURE-----

--M8NjSihaVV8beqJT--
