Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035AAEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB588645E;
	Wed, 23 Aug 2023 16:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SR4jx/mL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1105A86403; Wed, 23 Aug 2023 16:42:28 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13CD6864DD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5922380064bso31757557b3.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801745; x=1693406545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1XuVqdVNjfLdc9lJDSowskOLcw52QwPWd6A2egBc+cQ=;
 b=SR4jx/mLKKwXtWo1nml4fFmmtZcEt9s5QNaHrpd2Mz9wvBElbqW3Z9tCfux+YCkjpk
 6PqUVmnMFAC9hDDq1CaRBiwYQBVKTMNNWSCS1a+wcU5WGMfbWhkuNTc+4iwxuGFiBe5I
 /jFqvOhn0wTppcgQMKmAj4b+lkBqinSP0Odzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801745; x=1693406545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XuVqdVNjfLdc9lJDSowskOLcw52QwPWd6A2egBc+cQ=;
 b=R7+nJoLSp/s59Jq9jFjeazv90jWYlIInrnsqHb0WpJ0dZ+lgnYl9IkVyJSYbBXWU+K
 jgmDRGY44Bpl6P3gVzFL17Vcu+mYoZVk26SfsuLxUUd+I08aDeCobUohpuiLIk21Ztu2
 8NtBsgv6rfzsOyuhvltceXe9EBCjAPPebJO5jgnautYH8UT8/D32t5fz3U2Je6MES4ZH
 VDmgqyExIf11AcOfAnr9gOl4MlMfHuu5F6pOcMJwTRguMA1SnpMTZGTw6vS9rWcB8fMv
 J7kswfutaqm8h6Fpd3kpKQtXcajAPMzC1wpvCT0KIsnJDZSdlKsHBn0yMpGxAUcPU9CJ
 aj2A==
X-Gm-Message-State: AOJu0Yxx0KGibPyW2mmpAGFlfj8LWQnrJ5XCIDkgRgexX4zuvxeT2K/Z
 gSqoiUWQHwfWnR3TH+2CD2TQbg==
X-Google-Smtp-Source: AGHT+IEs1IS1Gn+dh04Uah2GZmriD3EA1PAPNSycI31zc2ZoqK0l+wgK+4XCe5mSWR/04z7hE66jDQ==
X-Received: by 2002:a0d:d457:0:b0:577:617c:8cd with SMTP id
 w84-20020a0dd457000000b00577617c08cdmr12549515ywd.35.1692801744822; 
 Wed, 23 Aug 2023 07:42:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 y73-20020a0dd64c000000b0054bfc94a10dsm597665ywd.47.2023.08.23.07.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:24 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 6/8] disk: Switch part_blk_*() functions to disk_blk_*()
Message-ID: <20230823144222.GX3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-6-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1o9muTGATjOlOBNs"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-6-marek.vasut+renesas@mailbox.org>
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


--1o9muTGATjOlOBNs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:46AM +0200, Marek Vasut wrote:

> The behavior of the part_blk_*() functions is now identical
> to disk_blk_*() functions, switch the former to the later.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--1o9muTGATjOlOBNs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGs4ACgkQFHw5/5Y0
tywuMgv/dFi10pAvhim7LZ9KftA2WaVtJ3qOB7M3A5PDfiWKmjqOYFSjmhGYA2fv
UkAuVRdahrQbSpG4j6S1TkFtsqmwsTMJ8XQII6sugay4Cg4Y7Yb2Ny5p5zzXpe8S
iYRPB1j3F1qgtqrc5qZE3XMImsOTwwRK/8Pp2Sk6VkF6DBLXaOhQpOfXXkf7Ym3q
xRZAYsUwfLdKyriOmncVJSJpvLC8rVtMx6fB+G6q45Kt19+GkERdYNX2797foy1J
yzDM52jqskSfB4XKcUZq10ODh3SjrH7TfZm5opdLHYSaxioibHHW8GwYgzhvv855
/5O91xp/8QUCxycIt3A1YQ6zptAGE71+k/thifWE1hs/DRlOU6M7ODsD2wbWW9Mm
yBD3cvCz/ZFyhQxoTI+IF3IY1p/wkeNqvaOj0vZOlGWbXUSCIWthcMRgP6ZRBfiR
nOiOvml7X7UGzUcBj3sQVZkCdrBrYITzjgL0r9n/PRrfDBcfVa5msvGtI/nnx+Th
IUg9q3GQ
=gBFh
-----END PGP SIGNATURE-----

--1o9muTGATjOlOBNs--
