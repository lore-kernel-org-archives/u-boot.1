Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4FAC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 12:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E6C88C0E;
	Thu,  2 May 2024 14:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MXoAjH+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE23F88CC5; Thu,  2 May 2024 14:26:13 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C25F388C0E
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 14:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oliver.graute@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41b79450f78so46493085e9.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714652771; x=1715257571; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ahD4Px/QLVLucPSlyL/uheQVD3Fk3vPtVYLGA5cyKVE=;
 b=MXoAjH+pbfdrep8vhyRq6+XGjxhw53rqMimtfsgqVtdGUqnyqyjeln/UOilEcEK3a0
 13FbKg2NmoVe1ThTOyYHB2pB5hoAd8G7VnUYBYr3dp0A8gwMYjexxuxNmzlxyBEUZVrR
 0T/rPjhB3Ml11GUqNjmQXSpUjviau6Q4/ebTTwdKnNEM2XomCTwkoFRK851F+ItpqERf
 SB0qSlMdlJYyptjhfWaMu2DuSFD15/hkQmxhyip0p+XfOrY9Kfirok/a6w4MD5MFNwCz
 9NSTxgIBhYIKKXrHuYGdBSjd/hyMrRj43ULvWR0DalpPOezQm8jNmu2QUqSeTeG3rTMl
 dHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714652771; x=1715257571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahD4Px/QLVLucPSlyL/uheQVD3Fk3vPtVYLGA5cyKVE=;
 b=BsbXWfkXxPXPn6LOeRYGe8kB506zl7Hs/ANBYJA8o0sGvi7sVcJpWFx94myui+kWOL
 qyje9qj7KMosuVBStbOxMSWcVrfCDcUkoVy5Xyd9widR0EAjkTRU5PVgD+QZZ8VfHAaq
 vdfQTr8gBe8FfLgdNUVTi80tMP5YFmDGQd5rRdkM76Qf8YwBK49zpxIPwss/OAT8KlCG
 EEKwIgwKKmtpRsPIpGyZmFpa/GTv5vMJ1pzpLnEWiYWuxOwHh2BJk8sBsiYr1sAY8lFv
 nltUSZpMsGA3m+pa+G72S375qy+K3xml1VyHdTk3Ur9bxkx7ndTzK2QtJ9EWHU0wPLHo
 zuHQ==
X-Gm-Message-State: AOJu0Yw4V7PkUWkJelIUJMltmO0gZ91ML1d3jbhIkvp3lGYdZsgAdmnM
 8lYPGWnAyqCgLuiKqkl9VscugbGqN6IPSdLo2ekUaLMlSVsKjQ40PzM22bbq
X-Google-Smtp-Source: AGHT+IHYYzRdq1zwIrSgIMfz60/UWnZCsL8x22pk4DIpYfzE/pWNxfiBS/0rlekr/3CfoBBTvLKM6w==
X-Received: by 2002:a05:600c:35c5:b0:41b:e201:eedb with SMTP id
 r5-20020a05600c35c500b0041be201eedbmr1878884wmq.41.1714652771082; 
 Thu, 02 May 2024 05:26:11 -0700 (PDT)
Received: from localhost ([217.151.144.138]) by smtp.gmail.com with ESMTPSA id
 n12-20020a5d588c000000b0034cfb79220asm1155510wrf.116.2024.05.02.05.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 05:26:10 -0700 (PDT)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
Date: Thu, 2 May 2024 14:15:03 +0200
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 043/149] board: congatec: Remove <common.h> and add
 needed includes
Message-ID: <ZjODxxNePCbDNxZh@graute-think>
Mail-Followup-To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-43-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240501024316.1767971-43-trini@konsulko.com>
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

On 30/04/24, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Oliver Graute <oliver.graute@kococonnector.com>
> Cc: Stefan Roese <sr@denx.de>
> ---
>  board/congatec/cgtqmx8/cgtqmx8.c                           | 2 +-
>  board/congatec/cgtqmx8/spl.c                               | 1 -
>  board/congatec/common/mmc.c                                | 3 ++-
>  board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c | 1 -
>  4 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cg=
tqmx8.c
> index d8e5b1d69633..99c33a1943e0 100644
> --- a/board/congatec/cgtqmx8/cgtqmx8.c
> +++ b/board/congatec/cgtqmx8/cgtqmx8.c
> @@ -3,7 +3,7 @@
>   * Copyright 2018 congatec AG
>   * Copyright (C) 2019 Oliver Graute <oliver.graute@kococonnector.com>
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <errno.h>
>  #include <linux/libfdt.h>
>  #include <fsl_esdhc.h>
> diff --git a/board/congatec/cgtqmx8/spl.c b/board/congatec/cgtqmx8/spl.c
> index b432ce27459f..242e794981b7 100644
> --- a/board/congatec/cgtqmx8/spl.c
> +++ b/board/congatec/cgtqmx8/spl.c
> @@ -4,7 +4,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <fdt_support.h>
>  #include <init.h>
> diff --git a/board/congatec/common/mmc.c b/board/congatec/common/mmc.c
> index bb7a3d4a9aa0..74a189ab4d7f 100644
> --- a/board/congatec/common/mmc.c
> +++ b/board/congatec/common/mmc.c
> @@ -4,7 +4,8 @@
>   * Copyright 2018 NXP
>   *
>   */
> -#include <common.h>
> +
> +#include <vsprintf.h>
>  #include <linux/errno.h>
>  #include <asm/io.h>
>  #include <env.h>
> diff --git a/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c b=
/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
> index 315b6dc54295..4197e88fb6ff 100644
> --- a/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
> +++ b/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>   */
> =20
> -#include <common.h>
>  #include <i2c.h>
>  #include <init.h>
>  #include <winbond_w83627.h>
> --=20
> 2.34.1
>=20
Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
