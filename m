Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F494C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE018816F;
	Mon,  4 Mar 2024 16:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qnwMXjGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047078802F; Mon,  4 Mar 2024 16:29:09 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC8D88035
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7882cc93e73so47426485a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566146; x=1710170946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NXjSsqvNkVe1fWUoSC/rwS8CLq+9O4noU2tJBwtnx68=;
 b=qnwMXjGC0y3rcRA7J7plgzHq1l8NE8Uk7Nr2DLSGhHRbtvrzUqevx0N9BItR6ifkRw
 2gL7EmqJ/az8+YgV8aKYIxoFW7RAvTt9tbHummd9Ro7d2qzdWCVVmM+4ySEPZcQzjJg0
 lCI4vOD+i50IC4QZ1dP1UwrtiT9CfgbbfN0tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566146; x=1710170946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXjSsqvNkVe1fWUoSC/rwS8CLq+9O4noU2tJBwtnx68=;
 b=BRvB6ppsGhrLMMXN+AXZbOIFnfju+96P/XN/BAnH+dB7UnU4nBruPusaCFywKCYDX5
 FQYreq/2ImDxJebCcGs5VfR7gYMlr20HF21m8SzrIJwOor+lV+QWddrKeV+yfV1IksSW
 Y7o1PyLtGOd3eGXJrdx9o1OP9e0/oKjVJy2qTl7XyJ4voSLhkhTxsrJsC+xuVlEH+rqH
 o38QiPJLnqRB4GNqqAuDSvqqhqGqAnAXyimBvIJu704q5S92dzSlrZrWKFPe1cMDNO4Q
 vT4K02B38s7sz1+50OflB8dwW1U2zgcIMVjC8nqfWFkYUkcz1dupYkIGaEGSyj8wqZWq
 OZTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtgA2lI7EC36osqNRrSIfYZiIKnJSbYS4eBpr7a0jmnvGaYEq1HOc/NUQanO29mV0fPR1LSQrqgW/sKcmipaxVvCRVpw==
X-Gm-Message-State: AOJu0YxR64ulvo/mWofrrkva5TDrznq9oGbokkfX5IRiOfz5SKfCeiTP
 PpcbX6gVraZS9LKZK98XPZHv2a2oFHuP8eNRWxLl2YLgTct6BUza9YArJdsyhiMIHNFuIcQAQ37
 X
X-Google-Smtp-Source: AGHT+IEsfyZkoMye+mIKstKBK+aU6FUAdtELiZlZ0dUSo1i5aP1X4smLft2/nbgWYNmJejqlui1U8A==
X-Received: by 2002:a05:620a:5797:b0:788:27af:6b6e with SMTP id
 wk23-20020a05620a579700b0078827af6b6emr4153837qkn.0.1709566145827; 
 Mon, 04 Mar 2024 07:29:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 v15-20020ae9e30f000000b007876a732823sm4465611qkf.25.2024.03.04.07.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:29:05 -0800 (PST)
Date: Mon, 4 Mar 2024 10:29:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] remove Broadcom Northstar 2 Target entry
Message-ID: <20240304152903.GJ1523872@bill-the-cat>
References: <20240218111629.849167-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GlriI34xEblvaCLV"
Content-Disposition: inline
In-Reply-To: <20240218111629.849167-1-pbrobinson@gmail.com>
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


--GlriI34xEblvaCLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 11:16:20AM +0000, Peter Robinson wrote:

> The Broadcom Northstar 2 support was removed when the
> bcm958712k board was removed but the target entry was
> missed so clean that up as well.
>=20
> Fixes: d59bc09d829 ("arm: Remove bcm958712k board")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied to u-boot/next, thanks!

--=20
Tom

--GlriI34xEblvaCLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6L8ACgkQFHw5/5Y0
tyzEGgwAl88RzSCdZoXA2riGv/5rcbh82dhkPWm6YCk+9edeudXHeZFkdIIJK5nH
Rvgy+yUgHqe+IG0QztklxfMDQPbpCZohI5AP4R89oiFAjnF2DK4OkahkSr+CQ6R9
o6duoRIHhoWLsTW6C3FS/XZW/a6PT4SBcAoPC27BOJ9Kd1m98Emyc51LItFZdEp7
W2SqupQNN9WEWpMVXjaRD1BPWyip28mgQPbmWgd3SXERN2vmIrHQ55D87FNjsvjd
wWhlVWr8QCb8L+wOXHBm/vsjZ9KH9p7CjKNl47mzM2XPpghX0HsyDhFdB0YeBw7s
CCtza+QembVEoWWc+YLKrhKBrEP1QLKTR7RVREPplNcrmtpo80aeH798YXGw+bFn
Y5YQl1o/MMITbUI61XcUwKsDaZPJHr50bIQhxb+L58zK6cYb8TA1iE2zMvdGkxZS
0cxICAUBAGvTRLHNlrVLJDfFDBmhJecB8wDfoq11CWL77M4I54Hwpx1WTKSXQP5Q
oPpuhwRf
=Bbuw
-----END PGP SIGNATURE-----

--GlriI34xEblvaCLV--
