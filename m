Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6454EC83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA3638651F;
	Tue, 29 Aug 2023 16:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s/kZWhmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253758651F; Tue, 29 Aug 2023 16:09:57 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECD886500
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59231a1ca9eso50162697b3.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318193; x=1693922993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=urMbme71Vnm0ECruCgFOvRIQEiY/pPUpe+byA4owOzo=;
 b=s/kZWhmSoo2B8rKKzcyQXTaVC2paiUGwptT0mf8Prwho+70ahfiPlcrecXm0o9i3nZ
 xMX0Y2GbA/zlkZJb1un54rL1KGvfhd3Xy5NrxvPKfwBeAq7WFslLDyZ+gJhgx3BqiDGb
 81rgpEgxG8t2zlqor2Z7HQzGTncYJi5JnpbtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318193; x=1693922993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urMbme71Vnm0ECruCgFOvRIQEiY/pPUpe+byA4owOzo=;
 b=L32S1k6UrArhgp4oyvU1QY4pb8qrKv7BqqCYmVfITmXOxtCSXFxpXh5a2EbtUjWBzK
 YjRAL4TiZm13sLfvnEjADl/iSOOW6Ii4Z+bdWl+NwoDo+zvKDTDWoCemb2XU3InVOMHq
 NihimrzO+l+FhDkmiZXCa/h/PmYNzzts4o8Zbu+KuBx+wqn/6KR9jYftKSq2tryZU2O+
 +e4WHGJ58GP8lRXYVFIYZy9+yym39qnz8xxpmGXkWeHTJaF5Yin6v5ZpUgnSj5aHw2Mf
 cR0Bh2ojXXaTioVSerY7EXMeQ+yLBxpY6d2Idn2Qm8z79pzpA8BhIu/rAHVYFKcA0uBq
 fGcA==
X-Gm-Message-State: AOJu0YxIdHoTpuq8VBwDi9Ek+3UgvGL5vqEnETiHNCOQGn+G15xc9UDk
 N9PjUC4jfLCKo7mUx73kgfMuUd7NpL2gocQkEoKOkQ==
X-Google-Smtp-Source: AGHT+IEqbG1Cfm/fyDTY+ZVTOjjqf8bagqqf+m+l37rAeltz+6ODPPMjsl2qmOmIquPjW2VLuQ1qHQ==
X-Received: by 2002:a05:690c:3341:b0:595:e1b:b978 with SMTP id
 fk1-20020a05690c334100b005950e1bb978mr7582886ywb.21.1693318193106; 
 Tue, 29 Aug 2023 07:09:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 q67-20020a818046000000b005869fd2b5bcsm2754122ywf.127.2023.08.29.07.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:52 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] spl: crypto: fix including SHA* object files in SPL
Message-ID: <20230829140950.GB3953269@bill-the-cat>
References: <20230823145633.10948-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AETo6vTn5sqQoO5A"
Content-Disposition: inline
In-Reply-To: <20230823145633.10948-1-oleksandr.suvorov@foundries.io>
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


--AETo6vTn5sqQoO5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 05:56:27PM +0300, Oleksandr Suvorov wrote:

> If one of SHA* algorithms is disabled in u-boot, its code is not
> included in SPL even if a given SHA* option is enabled in SPL. Fix
> this.
>=20
> Fixes: 603d15a572d ("spl: cypto: Bring back SPL_ versions of SHA")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--AETo6vTn5sqQoO5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/C4ACgkQFHw5/5Y0
tyycOQv/ZfgsXX91yC9ZkxiGNcdh7XxjV/RfkArYgW15yD1Mh4D7Pm4rpK0MpdJ1
lhd67Xre6YAAVOhS2QLj824l3GjA/hCxhSwnJRvP++uZv+d3jBEO5Bz+k+AaYqs+
sXL8u+zNzAToGtQHI7W+3nWEhseY1GiwcKBLJ0OyxG69yhshKqkvV4N1ChQlSwuj
awtX9OSgDgLdbXgqmns9H6DVy5WS3mCia021FuOygbs34OB+FQ/FXafKwkMQsxoD
Ig5P8yQqeGc4rz8iyVZwdFtozJtG5zlJgaG33NjdR6JKyvYf32WiwbDZ9Zck6JzJ
remGDrIEfG6v8fKrHkQ4MITgN7A3OGImY4WNohPMVgTZce5K8fb0DhF1+Xo2sdlC
M4bTxFGv9zZwkd3mvWTD8a2N40wOxKjZgE90OznnbiaGCSNoW/TbCva5D+dC4XKQ
l06Wj/G80OA0FtmfrKkuyRtjw/9ibtUmLCucawGaEQtzTBceswbVnuefl/mCDdRQ
E/EMZxYR
=exvR
-----END PGP SIGNATURE-----

--AETo6vTn5sqQoO5A--
