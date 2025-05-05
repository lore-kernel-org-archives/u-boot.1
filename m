Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF47BC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 20:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A2D82102;
	Mon,  5 May 2025 22:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gtzbd8nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4582E8210A; Mon,  5 May 2025 22:38:17 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F63A820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3fea67e64caso3588061b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746477494; x=1747082294; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5eohy1ey5eBwonFIw4MGlYm2q4bTfC5Esqulo+BLn8U=;
 b=Gtzbd8nxo5sc/VxiVrI4s1we17VmTSTiCXaksTaDh+ugUN8mdP6MyebPnj5c/3UK2B
 Vnpdj3ytCsEMo09SYPcHbHuzgreOYl67YlrktgO9MBDkFr6NSOZECeG6iZVDNwTL8WMI
 uMxvewYHD065FIBnRMQa7PQqW+knMkPUd/fSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746477494; x=1747082294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eohy1ey5eBwonFIw4MGlYm2q4bTfC5Esqulo+BLn8U=;
 b=k9mybaYoobuDhOaFsAW9v3qo9oTYwUXrH1hwT2jVbt1b0rx6YomfhnY/waRDj/5tq8
 2yxToXZvIhloNg5+eVTiEP6IvJKtAPV9rtWsvBPDSJpeGQ10hXy86EeOuAeUI9ZS8QSL
 izJ+oBJmvZAsT+b8QsXIdc5JXo61Zm/8UxnJBFZ8uilsCIuNvIh0dGwcXbYUDmfIoQwF
 F+d+EIyFl4Pyh/rUIrVx1M+/2KsDUUYH5YqJank2ynd4KWZiL3hIVyKLNsZ2PBlhn1zv
 wLu4hWlH03W6YT3KoPODle8lQW/x0uiScMvVDNaQBCLMKsp9AlXKxxbfOOMh/sApHtsf
 dhBw==
X-Gm-Message-State: AOJu0YycS6CoPM4l5VUGDb04o9NY0O54tlNi8c0kKjsymBT5n82efafJ
 R9PYM/3c9KF4qfqqbIzGI1kMTjBS1jQjo5yGc0df57kX6wwsYyoXGQmrncENEZE=
X-Gm-Gg: ASbGnctQZQtT0XG1z0iUD6HXvgtpGeupYWfPizALq7P7ec3bGhogRu/C7uvZZWujmbh
 35H6Zqe3kA8fGOTy2azXaJBvocgX12WEVNy94g+Rda4B4nw9TpKwsOiU/z3+FGYxr7y7OaPe9B1
 1AoHBgyLnhkRNi/PUUqnoZG068xGe8zvPCaIwA7tI/DqGIih2gPQElj39fp/cQlT5TnW1cobWKs
 9Q14LS1OjlGYLpmFo+sm9QU8LlFAu46ezJxE73qctqU4BDm0yybji3Zfwy8Oysy0/Ygzo66YoMJ
 ze2Z12KVk4xWRcfCSVBmj0W6eDa5TeuVgzkui9Uo+K8bvRjeF1sFWV5pvrk+g/+mDe6Z6Mn96c4
 gQQ==
X-Google-Smtp-Source: AGHT+IEdYdtxRo8tyhCsRVrufmYumLC87GUJQ9OygvlYwhxPuvrYc6C/8t3eL11hWrXcLgw34w9byg==
X-Received: by 2002:a05:6808:180b:b0:403:31a4:f3fa with SMTP id
 5614622812f47-4035a5d55f7mr5614382b6e.35.1746477493721; 
 Mon, 05 May 2025 13:38:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40349a8f7cbsm1720530b6e.50.2025.05.05.13.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:38:13 -0700 (PDT)
Date: Mon, 5 May 2025 14:38:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
Message-ID: <20250505203810.GM5430@bill-the-cat>
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JBTTJ2esteAa4umg"
Content-Disposition: inline
In-Reply-To: <20250501133726.2627373-2-sjg@chromium.org>
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


--JBTTJ2esteAa4umg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wrote:

> This construct appears in various places. Reduce code size by adding a
> function for it.
>=20
> It inits the abuf, then allocates it to the requested size.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Add new patch with a helper for initing and allocating a buffer
>=20
>  boot/cedit.c          |  3 +--
>  boot/scene.c          |  3 +--
>  boot/scene_textline.c |  3 +--
>  include/abuf.h        | 11 +++++++++++
>  lib/abuf.c            |  9 +++++++++
>  lib/of_live.c         |  3 +--
>  test/lib/abuf.c       | 22 ++++++++++++++++++++++
>  7 files changed, 46 insertions(+), 8 deletions(-)

This just made me look again at the abuf implementation itself and
become filled with regret I didn't reject it back in 2021. We're
introducing wrappers around standard functions and calling conventions /
patterns with something homegrown (and so not intuitive to others) that
mainly hides the "sysmem" challenge we also have and I wish you were
interested in revisiting how that part of sandbox works instead. And
even if this is a better design, for the sake of argument, it's not
something everyone else is used to. And that's important.

If we *really* need something different / new here, I'd rather see us go
and wrap common/dlmalloc.c with kmalloc/kfree/etc and so give people
something even more familiar-looking.

--=20
Tom

--JBTTJ2esteAa4umg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZIaUACgkQFHw5/5Y0
tywBnwwArMYz4yp/DZBRuZS+xow7vEEYuR4YG6V0z3u9io4534y5fBye03sIy9FK
nuokJmLe80zd7A9lz2yDRzX2GVChdaLXx+cgXe4Co2hG+Cj2iu1FS+7GzoT1TuaX
kSLF0wjk8YbaIuguVn7Q0pIFuTsnMKAv8wN4igZDFdIjkW2GkQN6FI3xBU3tnFKW
rtjWOJi76Bcbt8u6JZ67emHIYXMrBgX/nHaxyGNcyHe2ajOzJvfrn03PV5rDk9wd
VitkPYNHMtP+Gr83UxspOqfy9pWJ8zEU+BvC/ZRJAc6V0uASI9YTtSe9tqovFye6
yUWW0LJDKRdjAeWwXHUsNDvdz2c7OeIv5dOFaGwotKMvJt4bk3Vko3sCbsBz/9x0
94GaDFwkB0QAbZA6ffqJrHNld+jw9esbh4/b/EkyFC3+EOANOoa9Dj/MlwJV8aoD
uxzGYq7DDyqqrLMg+H8YZp2btu+eIOWgzt14jPoxARgzd+pYLtVd4zCeiVl0DfuS
t2RVgvtj
=EBsc
-----END PGP SIGNATURE-----

--JBTTJ2esteAa4umg--
