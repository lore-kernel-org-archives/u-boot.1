Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0E8CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B51586D4C;
	Mon, 25 Sep 2023 16:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PgYTvpQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B3586D4E; Mon, 25 Sep 2023 16:06:00 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F9C86D27
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59f7f2b1036so21555507b3.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695650757; x=1696255557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5dZZLCjaLNKGV98h6S50bYUevwkAMxEBjhrqEnBGbQc=;
 b=PgYTvpQQqkC1VgzY0OVWpKOq/5Z9So7+8EWeecpVUqFBarErjKh3ExeN0iZPEIc7Od
 NdGtlUX5oKpHbTPr3fQIjeSzb0D+rJq0ZGyT0GcL7195oWzGrpPoCN8lK3PLLutULJyc
 ExRBR1YOA0rLwuKnMdHp7n6mSbq/uB+Eg66cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650757; x=1696255557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dZZLCjaLNKGV98h6S50bYUevwkAMxEBjhrqEnBGbQc=;
 b=lYOyjpYV9t4uKOa9Fqnw2JCxiH2Q/NL842g7qhE+d2uTXpuSArwqHm5Kl16nrPZ6w2
 1rqJNJAJHOpqCKerQm8VCX5e8ZI0xb4c6qs9z7R8C//F4/56bs0yYdoNwH1EyZ9yEjVH
 Xk3tNnquxZPAtkZTxfEC2xxPOcqN9QiLrpxhauP7suHdBbPogMfIVRx4UcdFq5FuqWhl
 7nuPnY7f9JmssEtfPPJrLDEkLfsoo19UOhNSxw195edDV0kFWRXHdif7SqOK7DkKPFpr
 ZAXIAc9Lo5X0TPu0b3CKozySo6ETM7l6p+yIR22/UaDyBl7/ZAWjD7UHQt0MR9F+uX+u
 oEiw==
X-Gm-Message-State: AOJu0Yzo4QZBpe1KcSbMRSsJyJwUGj0r/Ts3luVRDDyO7m9yLJsao4Vn
 uRy5wggv+17+WtAnSHpGglzQu5oP3uz0srp1o++diQ==
X-Google-Smtp-Source: AGHT+IGQfRAVHsnUJMqhacIAVo2V88DK7WxSzsMSlHLIaClb11DzYImo6C7o1A/Zl3AY+2mS0G42Hg==
X-Received: by 2002:a0d:c987:0:b0:59b:bd55:8452 with SMTP id
 l129-20020a0dc987000000b0059bbd558452mr7315314ywd.36.1695650756657; 
 Mon, 25 Sep 2023 07:05:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 w129-20020a817b87000000b00589e68edac6sm2435240ywc.39.2023.09.25.07.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:05:56 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:05:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] common: Drop time.h from common header
Message-ID: <20230925140554.GU305624@bill-the-cat>
References: <20230925023958.1913268-1-sjg@chromium.org>
 <20230925023958.1913268-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JZlY6vs2I5cz5d80"
Content-Disposition: inline
In-Reply-To: <20230925023958.1913268-3-sjg@chromium.org>
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


--JZlY6vs2I5cz5d80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 08:39:51PM -0600, Simon Glass wrote:

> Move this out of the common header and include it only where needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/cmd/cyclic.c b/cmd/cyclic.c
> index 946f1d78184d..f12edfa6b727 100644
> --- a/cmd/cyclic.c
> +++ b/cmd/cyclic.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> +#include <time.h>
>   * A general-purpose cyclic execution infrastructure, to allow "small"
>   * (run-time wise) functions to be executed at a specified frequency.
>   * Things like LED blinking or watchdog triggering are examples for such

This is wrong.

--=20
Tom

--JZlY6vs2I5cz5d80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURk8IACgkQFHw5/5Y0
tyygxAwAgTsTKVhvhd7XKcA5MDB+C43bGcrERHRh+djYPiKPhbaIgutHQnYr+9n1
QHBJ/ZNWIbKNjrUd09ViCplMuhI2MYVRKHJZpI+anLdFRzuPG+F9mKuAdqbtQaeh
sXwCGmFmDWIX5OmaXYuH92F1bqE8wCKI8ACYPDmlp2/QVkUA97iZXCCjO+XkXXto
TtFrephqkOwglZWlgXIQvNj1SVNTx+MIzUXGqujTnqSd4wt9WamEvQX11j6s5Nsv
Art5/QfXdgwqtUesi18r6f2kOO98G3+To/5+HFfSXHWSE3/pekqdriJuTsdJK3u7
UP/ZyiCqSp9guvmNR/y63lobeS/NbAJN7cygoPy3Lww10VIH5OJQkgJg8lMSIFN8
cpZFaQfGVviL3RI6SRjyHWJUN9yX4HB99ixuyCo7NG0/GbRL58zwjWs/tmnPpW+y
JlWR139Om44ytQvHKHS9wZx2lmZOHLiUbhCr3QnYUOzhIpnlqUUxHaP+oE2ZFHBy
fmE9lyV0
=ZfXr
-----END PGP SIGNATURE-----

--JZlY6vs2I5cz5d80--
