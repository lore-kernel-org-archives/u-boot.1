Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E233C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 23:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBAD8817A;
	Tue,  9 Apr 2024 01:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kPUWnBOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A90518817E; Tue,  9 Apr 2024 01:31:41 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525B988151
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 01:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-434d85cdb05so520761cf.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712619098; x=1713223898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZB/dbM7GiIDgD1XlTZvg1fydcHhWy4yhvIHdHQPZX0=;
 b=kPUWnBOGXLoGwgIJjOnqGwk/QPxkRpf9MkAHGDKRqKf8F87pBus7DiHXngQG8bJns5
 Z7dhOIWp004XzGqYKe+srKe9tQjAaI3OQ8HC57r47Zfcxpf733G9WceCod47mTp/phEr
 LWbzoc8BQj8ykEYx2h7Jzk1tntCwhXIbEJVRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712619098; x=1713223898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZB/dbM7GiIDgD1XlTZvg1fydcHhWy4yhvIHdHQPZX0=;
 b=ZD+sYccZlcuukSW7PodgsTjNpsFWzMsX6gYOy6av8eQDOrCHJU+NXS8NpqWkVcCxqU
 sfHJq07cbJvwFWolw/FS8pUZ7BYG0zrCWK5L5VQ+FN4eVrU9EMDHvRZWXfXQebLkFqAX
 IlD4/lsC28wJFFSQFUQ6PGFaZSFAFv0b6wtGpJ6Ydz92Sc8RfjR8RJXwicilBBxyLOQK
 drou69gCnhvtfKf2q0JIL/if7y51NhZNVXGQrt9IvRXaGpLktWepwvvBb3EWXY3ZX3rH
 7+PAUDK8gw+cW60H47TQAaQtjp6v1mqEhnz9SLqGPd4lynRRrwpAqGJeZ23kL6BMJBHQ
 daBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAtN91uIBxUPTzBz/z3DtPi+tenis7KhARK+SC39fLFPcMLzcz4EKn8uQUq4eW9WPUuEeDC6AEGU2QwVSzDuHHyskfzw==
X-Gm-Message-State: AOJu0YzjjpjbH/uuBIQAVEQx6sNNIecf3MQARxTIuoc+M580Aihp/wlu
 5Jfv3yZ2R3zAaLEpc2il1wUuxoUzIU2QY+0OscN47bU0BcSaV76NnQQ6It9iOaY=
X-Google-Smtp-Source: AGHT+IFhNf+dKQ9MxUs13mAkWBQfRzuHBpolhXgV9sLxIvGsd30RBFbP50UbUxi/41Un7KmkroX0Fg==
X-Received: by 2002:ac8:5e48:0:b0:432:f68c:1a3a with SMTP id
 i8-20020ac85e48000000b00432f68c1a3amr12268632qtx.31.1712619098120; 
 Mon, 08 Apr 2024 16:31:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 h6-20020ac85486000000b004347d76f43csm2331894qtq.79.2024.04.08.16.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 16:31:36 -0700 (PDT)
Date: Mon, 8 Apr 2024 17:31:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: Pull request efi-2024-07-rc1
Message-ID: <20240408233133.GA2493117@bill-the-cat>
References: <d34e7f84-a22d-40ed-b756-c10ef935c49e@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PKqM+Lrn8zmfxUdr"
Content-Disposition: inline
In-Reply-To: <d34e7f84-a22d-40ed-b756-c10ef935c49e@gmx.de>
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


--PKqM+Lrn8zmfxUdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 10:28:42PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 9cba29b19f43f9450117e8bc89e7dda691ed5a=
b5:
>=20
>   Merge tag 'u-boot-imx-master-20240405' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-04-05 17:23:58
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-07-rc1
>=20
> for you to fetch changes up to 3f8d13044b32ddd906bb9f2fc705b988ec93df35:
>=20
>   efi_loader: access __efi_runtime_rel_start/stop without & (2024-04-08
> 13:05:50 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20252
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--PKqM+Lrn8zmfxUdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYUflMACgkQFHw5/5Y0
tyzeSQwAkmkFWV4DKfEzNIt+Eo0hCd0t/HwzKd9xhrUfZhEIbgXRg3v+xzscTtRU
GJKzMYHJyli9X5bxAl/ozlYusmG/N562SRf2YNsfpujfzLgTeJcM8igozZDGj3yx
olPjMc0bZeubDNzZ00JKkETjFQ43A/k7ok8Lxz1UoDo02iw0ch1a22qyWEgNQMUh
jC3BqnddZKyoe9PPb8oYO+WLnXWFKFmg5ZJR6T8jiKePb+atHgI8XtZefBV43mIw
mRbyvaRvIf97hQ+Rdjv6M63Vc5rIpFF0s0PCypqoi9uNk6u2jnUSrvXl4W/xbhEN
qB37qguVA7F18q6iK3t8tc8v0HLAiF/H1NRxvzaInPBBUOCNBg8ZnCb3o54QC52m
lvYwsVRX102zpZmVF+UVX1b7SKrLFQjGMbWVXt8NaYdjPSMb+/OVsE6BdQ3ygjCc
P1Vjz/XwRMhdaESqiP7nmadiNQEWjUrIF5f/usq1RwFN+NPjDAxqjtlO0JjlEI3m
Kykx7zeq
=qQ/6
-----END PGP SIGNATURE-----

--PKqM+Lrn8zmfxUdr--
