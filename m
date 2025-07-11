Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBC0C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FE682AE9;
	Fri, 11 Jul 2025 17:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SbleHlCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5ADB82D21; Fri, 11 Jul 2025 17:04:22 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18B580194
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-735b9d558f9so685192a34.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752246259; x=1752851059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jvXmr7eTKaChmAA0SfJW/3jltiEoonNKRonk0c+5Ud0=;
 b=SbleHlCqg1kAn2W9hccfGA1l8bnAUDHb7f77w1jql5ABKhkC7zm3tWGcSvW2ir/L37
 ChgN7+ROx0hJwEzn6dhuFnhd5Atp8/RIX8ve8wUuxdc2D1FrauleZys/GkEYBxNY/rRH
 i0O6hfzxf9oKtReUM7F4TqimYwMP6IpFYshBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246259; x=1752851059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvXmr7eTKaChmAA0SfJW/3jltiEoonNKRonk0c+5Ud0=;
 b=NmkesVSy75y+msTm97g/yuwxZIO3X2g3bwUXyBkJtBpRXSwSgr3CBOF3/SiWhEb03x
 fIYgM4G1hPwwzkMK3xPzFC7rZYUcFSvHkEOgZM29LHNagOCIpVDHIuQ4x7YUdje5kmof
 8zOxiUBCfY921zctmSeoIjBTzttDui/a0eJYLTp0AzVu95vmL81zypI6Ea695L1SlLeI
 YZVxJj6IKkfLvi9wrENrifdV+w22/JB2BN/faEpHM92OTuOrNyJiBQzGuWm3gw9BzY2x
 GJxXQA75wzmNIpkFDmkSQO25CXyRmH9ab5A1V0Qy2tXA3HQV2C/KLnhBABSkXXdXe0e/
 tzoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ljbsYuWyylb3ZcyT8tLnUhjGHcpbL89tmKd3qDCiQ1hZwYkBIQacl/f3Bay6pMvvxkXlQ+8=@lists.denx.de
X-Gm-Message-State: AOJu0YxvhhWDdeGev3AhIgRogPaTuaRLrbEq9/c355D2uwrxxA2bI46i
 C6yXQCp1oidBFj0aayuSGoQTn/BUgFIJbT51M/0eBkZlN4lzk7+2IqpZ9ES2K4l88rA=
X-Gm-Gg: ASbGncuwpXeZLMx8qBnnctaKvlamzNuiZR1QkVyZd2SlGcoxakOWV03y+jgbDnB2mVe
 oUE+1AnGQyQn1nhCHKpV/uKYqiY5XAYS3K7tzRyvQewHJ7UwavCPI1KO7jIOUEthx3X7nMqYKLm
 sJLSWW4vl5zb9j9T8G6zzqZ0kI2ohTSZJNggEI1sF8BGnua/2TBImGpjksyhcqaLeTdhEC36B/P
 4ILTWF643LiAigMtUlM12hPBQiIMOQ3OoMKVGie7STPop3yWs79Ni/C9nPUY/ge1D4dH60KARi1
 5H0/n5TMKoWkwfwCmp0WEdWQb9eutxdZP8Va6snGKqVaC3PTwzqLwroaHk2LcL/pZfepNZqmx27
 G6Hso1h3AxW9gya+jj4DdhI/Zgb2dFGqIlI0NzxG/I1qj1pGCAdmwdkY+
X-Google-Smtp-Source: AGHT+IHS63mlKaV5/2TkI8wFm9upL44e+naDFlIhS/UE07srLlD6DKYnHWmxdc6cJqXAXrjFdc4e/A==
X-Received: by 2002:a05:6830:3748:b0:72b:992b:e41 with SMTP id
 46e09a7af769-73cf9f2526dmr2667644a34.23.1752246259135; 
 Fri, 11 Jul 2025 08:04:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm586088a34.34.2025.07.11.08.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:04:18 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:04:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] binman: Fix typing for python >= 3.5
Message-ID: <20250711150416.GF6424@bill-the-cat>
References: <20250711-binman-typing-fix-v1-1-66ab075015ac@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NaiwpKkwkXExeZo7"
Content-Disposition: inline
In-Reply-To: <20250711-binman-typing-fix-v1-1-66ab075015ac@phytec.de>
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


--NaiwpKkwkXExeZo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 11:23:27AM +0200, Yannic Moog wrote:

> To make it work with python 3.5 and 3.6, need type hints from the
> typing module.
>=20
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Fixes: 21bc3433a43d ("binman: rework dropping absent entries from package=
d image")
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/etype/cbfs.py    | 3 ++-
>  tools/binman/etype/mkimage.py | 4 +++-
>  tools/binman/etype/section.py | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)

There's some seemingly unrelated spacing changes in here, can you please
drop them unless required? Thanks.

--=20
Tom

--NaiwpKkwkXExeZo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxJ+wACgkQFHw5/5Y0
tywb1wv/UIA+PqPxIrCWGECJ1LODBsS9vmwsMSx+e+FTe+pE4nJTB96rB8wmYS6h
6QoKGocZKNuVzGzYrO8QZlOipTks8iOtMZqTq8VZwI37q7qF6Ugk6Jrbr+A/EIj9
cn6V4woWSST1xulnsj6G0JPOhYGZhr24pWQc/GQWyVKUb97juw2uKfV1pz41d24D
0+MYaE0UcUq0c5e79uu14Hq7c9aqa57wPAlHyF9ljEEI3bbhWCyu/kqfkYiW/P+d
10yM5q1+6EOhmlvefHjSiB4El2I4t7y7MiNWcxLhUjua9l9nzDcq/YPUCA670dIx
v5txV1asXZK87GC3V68DdlD27iYv/ZU159x0G1uUxfrEYjqZCafo85WdhLn5f246
4TeuvDWJfQf9Oz+anDCKfjDHIRMyZczg5uz5M5p148hDbvFSfmcCm0iZ4L43KXua
D0lgfhwgq25E5U4DHdvbwqA6O0E4W3qX22JcCR8nuAdBkyfxS/AQW/WKVmC9gvl+
raWUxCb3
=kB76
-----END PGP SIGNATURE-----

--NaiwpKkwkXExeZo7--
