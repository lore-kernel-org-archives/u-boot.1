Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0248AE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8494F80291;
	Wed, 18 Dec 2024 20:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fVRtpHQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92321802B4; Wed, 18 Dec 2024 20:43:36 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD2368022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6dccccd429eso253296d6.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734551013; x=1735155813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bjaIc+QjN4lwhF2Rj642/LW0Q74Zrt9ueV3lbvPU6bQ=;
 b=fVRtpHQYMe9ZI9rMFlupF+qMizxthjdOJWojTJAYUkHFNWvQkabundwKbnjTVVNyMc
 NEMAAFESGBQtkbWZzW7xhglRnWNxJO1XyGtgdr+ZQ90UCiUGwgX1xSmXwnWYQ4mxsJz3
 H7yV7FTCZ/vTaIn77wqf/E2bgFFdr1f+UU42s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734551013; x=1735155813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjaIc+QjN4lwhF2Rj642/LW0Q74Zrt9ueV3lbvPU6bQ=;
 b=h+dhqaOtZBt+sCNvSu7MGphVi0ojdNd30KBLPF7wIAqmmlQ83rl2xuZB5ajBaw4C8G
 w+waTAHaWSJA8FoS+skY4FT0hW6PDqSW1BX788c7IztU8xGmg1avCHyGVEK1acMjW1Sr
 is73RnmI+cUa54OCnkA4h/EE6dgTlH/++4f4ghkk5pexw2bAeGRaI4AUBYK8MmRpucz8
 7x/qwgxTBzw6aUj9+FqyK1xmMo07dCGBLMJmFyDRpZxDPU9kJxSLtGCAAt94SBxHi4gX
 jKw1ehpGRrojqSqwnzB0Vyi4jPYhQZyIy+m/AMpQTUgZ5V31H2OdiQMq2/Hutsqwc9VO
 r9Mw==
X-Gm-Message-State: AOJu0Yyjj1/AAk2Itw7uSHPLBcaMvFiGalbAh8jLFsMR++PASpOIMz9v
 vmmW/HHn2Os7z/ZtMeVmtMtxe8+4Rcua0OOJ61zF7kHtZjBz31NSwh/NM75V7S0=
X-Gm-Gg: ASbGnctC0ff6Im0TdGjuYMaQNwM6EVk1HfI4KLO+D60v1RzpuWMucN/IGkwrm2NM6nH
 hoUO29gptIv+8+nVt+CGpH1k6OAUR9jJQPlHw8sLebfF2GlxRrBfMD3U5qEHrRw+7JNMNGekv3k
 dfY/KdM8JZNuUWrOs2Y7gmO0xHOS8dal5NkkI4yK/J+uNJrU/dAfRThEImi/mLwQAI8LoXjMswa
 oYkT3LbmrnGXRlyz0xvIDCEMxYQhsj0NUbLPrnyk938fVzrfeOAjTsF
X-Google-Smtp-Source: AGHT+IFI2V1RNrqdIFKc7y7sJ3/m9/r7I2dAC5HnhYD1TGwVpFpxGoPiok40TOihSfKSrLKnuD2ZyA==
X-Received: by 2002:a05:6214:2a89:b0:6d8:8256:41d4 with SMTP id
 6a1803df08f44-6dd091afa71mr74593956d6.19.1734551012724; 
 Wed, 18 Dec 2024 11:43:32 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26e4f8sm53897586d6.67.2024.12.18.11.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 11:43:31 -0800 (PST)
Date: Wed, 18 Dec 2024 13:43:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: renesas: Enable TFTP_TSIZE on all Renesas hardware
Message-ID: <20241218194327.GO1505244@bill-the-cat>
References: <20241218194143.79136-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zkgJYXNHxcWSqZcT"
Content-Disposition: inline
In-Reply-To: <20241218194143.79136-1-marek.vasut+renesas@mailbox.org>
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


--zkgJYXNHxcWSqZcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 08:41:28PM +0100, Marek Vasut wrote:
> TFTP transfer size can be used to re-size the TFTP progress bar on
> single line based on the server reported file size. Enable it by
> default for Renesas hardware to avoid long scrolling walls of '#'
> character during long TFTP transfers.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Anand Moon <linux.amoon@gmail.com>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: I wonder, shall we simply enable this by default ?

Any chance you did a size comparison before/after this patch? That'd be
handy to know for making this default for everyone.

--=20
Tom

--zkgJYXNHxcWSqZcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjJdgACgkQFHw5/5Y0
tyz8pQv/eQ30k8lPmvBiPcJdPzGDYELDSmVLPAdpi/KcWsFlDUMkWWCCf2+j2ivI
KdUv3VuP8qNBkXuvBvv9/QfdPnNsDJkH4X5K6D0VEsV63tKYebbqN7GOU9OMbVc+
a7FcnNih1VmZgxngwjfPbrq4V8YvzMLEsKD4aJeLJn551woGqAMg4U7YYgHdYCcF
m5VfLubGquhx2nUnbbZoufI9584gvgmaMvatv1byyTinnBMrBUyFVBkJQrT24duQ
uijeQnwU3E6KAi+tbh6zqE1vUQfPqxfZkueZ7JRRl08tItV6xR37D1ydjbKiJW32
pM5xBoSOAhtO1hLLmUvqEJ9Z0WulmzjX4StF37+Ocl+6yz+P4PHecNqYD90ixWha
Dunfx/AoAWMx11MSiOztm7p5p7TFPLUeHnFNSBzkMG6a5ylLfPz888EUS18AOA3H
wfTfASjoXcyOcVCUjn7L9ngYjyyus/3ncXRK1kYbERDq+6MeIsEKhm6IPDhHKEKt
eWyNAY80
=Tqiu
-----END PGP SIGNATURE-----

--zkgJYXNHxcWSqZcT--
