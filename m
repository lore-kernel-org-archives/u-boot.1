Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89446C4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA1B87191;
	Wed,  8 Nov 2023 15:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MTPaLfZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29C78717B; Wed,  8 Nov 2023 15:45:55 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640B286F92
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ac376d311aso81078327b3.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 06:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699454752; x=1700059552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7lLDUZg0rtbmueSdpnBQRBSZ59Fb5cBk7pWk/JVW0Zw=;
 b=MTPaLfZPkyrmnc+XUyXDfdz/wOpVzV1TcqSMN53S6HnHWKxaas/ob0CZla0HHl+Y2F
 PSt9Vc5xjk6JnPbJVjOP0fYJCT8oRdB5+/fbE3KGRjgDZga9yk8Ozl57wfsIuHiq8fl2
 XBqM9zhT+ty9BpDpu5gM1cMazoCJUY5B4R5s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699454752; x=1700059552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lLDUZg0rtbmueSdpnBQRBSZ59Fb5cBk7pWk/JVW0Zw=;
 b=kMtQKAVEpHIrPeURKsmTvaj0xdSPysquvv6hC99ejGGjI9kbEATv0UY/ciL5+cG03D
 MMjFA6qNjX+CD//aqKA6faE1Pss/E0n/hNrgQCvIpg29T/GwFZewuDajnwD9ECfJdb/R
 skTdPHjyCXtoT5CewZMzo5UoEo8k6lhLcIm+KNx/lXItzIh8RXTJw9aOM9tVDotC6oSi
 caL/hjGLoSSKX8/TcIh+c/XaOnkDUCaBoYFn6NsMHTwlINiyZ45qo8Aad3RkzAkanKDm
 eAkmucwuNttcFFOZrH5eWmobNxA0+MQDIyRNflPD/8w/QZAl68qOQM2yesbGCIOJTIG2
 3pmg==
X-Gm-Message-State: AOJu0YyZx8PRjMXzrvrZUN5YCVxr6nN4NJN0g/2oekNLmvOhSwwU7GbQ
 F74LB4fIXJGkn1TkLCahCg6SYF4s6CnqZDboB4f0sA==
X-Google-Smtp-Source: AGHT+IEBOK9s5miea4oqTloSkfkCGiCzT+ntyPug7kRPYj8pEImxyN9iREmjfQRUrqVyrQbMEdiBSQ==
X-Received: by 2002:a81:6046:0:b0:5ad:47ba:fa3a with SMTP id
 u67-20020a816046000000b005ad47bafa3amr1691728ywb.43.1699454752109; 
 Wed, 08 Nov 2023 06:45:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 h138-20020a816c90000000b0059511008958sm6959108ywc.76.2023.11.08.06.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 06:45:51 -0800 (PST)
Date: Wed, 8 Nov 2023 09:45:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com, rfried.dev@gmail.com,
 Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 1/6] net: split IP_TCP header into separate IP/IP6 and
 TCP headers
Message-ID: <20231108144549.GA1077075@bill-the-cat>
References: <20230725215658.2118831-1-dimorinny@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mSLCr0r0dXFdUcWr"
Content-Disposition: inline
In-Reply-To: <20230725215658.2118831-1-dimorinny@google.com>
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


--mSLCr0r0dXFdUcWr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 10:56:52PM +0100, Dmitrii Merkurev wrote:

> This allows us to reuse TCP logic between IP and IP6 stack.
>=20
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> =D0=A1=D1=81: Joe Hershberger <joe.hershberger@ni.com>
> =D0=A1=D1=81: Ramon Fried <rfried.dev@gmail.com>
> Reviewed-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  include/net/tcp.h | 54 ++++++++++++++++--------------------
>  net/tcp.c         | 70 +++++++++++++++++++++++------------------------
>  test/cmd/wget.c   | 48 ++++++++++++++++++--------------
>  3 files changed, 85 insertions(+), 87 deletions(-)

I do want to thank you for your contribution. However, the long term
goal with the project right now is to move to integrate lwip as the
networking stack (and in turn have more robust IPv6 and wget and
similar features). So, I don't want to pickup this series (unless you
think it's still important here-and-now, given the above). I would ask
you to please keep an eye on that effort and either try out v10:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D374882&state=3D*
or keep an eye out for v11. Thanks again!

--=20
Tom

--mSLCr0r0dXFdUcWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLnx0ACgkQFHw5/5Y0
tyzwAgv+JZlZcZAcp+5Wz6f0/SAsH+Gyiqx5biXCs8pDQxd5ZANz/LSfdH14vDPl
xgkfmkr65qj9XyyHcXHyHWB+WGPZ9yXkfWX84CoKDxPRz6+KdGqQ+DDr28Kiu2zP
YQS/4Tc21MlGa5EVO4UzAh1pyviG5X4osBB5PLfkRw9EZry8ewx7/5cG+t/UAUJD
58aNrTjlweinw+oL0XdSwMpRUc3u/YTrDC+ckR1vcEU2EeYVHRycTpJpcZr13isq
moeJsoEUnp0vztLAYduUrxQHsLzkyOPAHFM0aPd0eFFt72Wus2LPNqZ2SfbZWtwN
G0i/CERBwprCxN4hmu/eoK+0jvBNvmRTCG73pJt7U0pgSsbkWFYVuvMS3Oyn7aDS
UN8v3Qp2OsJv3AUpXP/ZKjAyEw53txRpsJgOFIz1RKeGT9PZlWN0d5By+wkbQAlM
HgbVt28SbRxgvqZ80oNNXOMc6W3XiemoY+rbqhgm3rHyeKTpR+cj9QFdWfMlYOIe
bCvshU14
=8Qff
-----END PGP SIGNATURE-----

--mSLCr0r0dXFdUcWr--
