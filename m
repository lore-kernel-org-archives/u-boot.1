Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EDAC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 20:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF119885D1;
	Wed,  1 May 2024 22:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FbKomNA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A28B885C8; Wed,  1 May 2024 22:21:41 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5135E8857C
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 22:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-572669fd9f9so6879393a12.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714594899; x=1715199699; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmKJRfefhq7WbrfQZf5OemwXm02c/1bDiwJdJz0R1lA=;
 b=FbKomNA4EB/nntWhT10xu9KxHvltl+vz2zs7QwTHiQzLY2aHqc/49YTHkp8hkuTJ1u
 eHp4hdtzQV9G6HfiXDXmLZ+wN30A0nrjDdYSLCDNtfck6VnJvJB4yIibc2uk+ExnHRTT
 SiqRU7HegojnOuKY+fduhIVm4bEr09A1iBhoyiwYfYL5IwmhckmQqwYySgY4FeuRSuXG
 14ZTiNPa3d+E3QWvME2ANBVfrgSgeJR4bU9pSkfZQ59coJOjVuNxODA24wMax4H8UbPB
 K3ZEcRuLVew71wGma6sBHKv2chMiFiWXrPc49wjS9+m19GYxCXcfQw8z0sM2HYjpZGiQ
 JL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714594899; x=1715199699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmKJRfefhq7WbrfQZf5OemwXm02c/1bDiwJdJz0R1lA=;
 b=T4mb59hlsD/tMn1bHx0eX51/ejUFcO79T5bV2RRslSpwMa2TGWnqWftiGCk6uqt/WF
 aLHWB3+xT017oXiMbLNlGc9CGx87e3/Vs9kk4owUcwFqsdaV9c1Q0FoUil/mPZ1wWW04
 1u9reIoLXwOg3gw0R2Nj8afRMMJdVQ5fAcX8su87CT+yQlgIJHgxQIY5KoctKF05UxsT
 12TPqavWo7EOFsUecb5WoKcYR2OlPGqBlpgpDf861GVVk1HHFyQwYioCixvks6Pnzd0a
 9x1lCnkqFPdpm7iLnpXWoDYpiZoAv/yyJ+KsmvDJaCyJcXKBCRPjRbYJc7QcgW936pKl
 s0GQ==
X-Gm-Message-State: AOJu0YyY+kDgBSGesUMV+GsBSAfFR14HuwvSqklopvdxjE9o5AHIEW+X
 5iT3w11BpYoHCpcXPoRP5keNX4iajiKQWYrkhAptbAQsyo9YIubl1s7XF5HbhAKa+x/SwspJ2/H
 nlP8RdaRzNC3kd5LzhFFfP/SgLxy7PyBu
X-Google-Smtp-Source: AGHT+IE9ULBTFVmek86MekKv14zCJrN1zsaWlHbfOaY8gXc2y/wRz5m6brZBdJVhFTQer5aBU+2ezACX9L0COCOFwPc=
X-Received: by 2002:a50:f613:0:b0:572:71ad:98c2 with SMTP id
 c19-20020a50f613000000b0057271ad98c2mr2119371edn.4.1714594898694; Wed, 01 May
 2024 13:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-11-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-11-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 1 May 2024 13:21:18 -0700
Message-ID: <CAJaLiFym8hMwEiRbsYHx-0jn-UrUo0k+8_-4eB2skV3F0QVTKw@mail.gmail.com>
Subject: Re: [PATCH 011/149] board: Seagate: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Evgeni Dobrev <evgeni@studio-punkt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 30, 2024 at 7:43=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tony Dinh <mibodhi@gmail.com>
> Cc: Evgeni Dobrev <evgeni@studio-punkt.com>

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

> ---
>  board/Seagate/dockstar/dockstar.c     | 1 -
>  board/Seagate/goflexhome/goflexhome.c | 1 -
>  board/Seagate/nas220/nas220.c         | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/board/Seagate/dockstar/dockstar.c b/board/Seagate/dockstar/d=
ockstar.c
> index d72e3ef24ee6..e6ec00a9c6cc 100644
> --- a/board/Seagate/dockstar/dockstar.c
> +++ b/board/Seagate/dockstar/dockstar.c
> @@ -9,7 +9,6 @@
>   * Marvell Semiconductor <www.marvell.com>
>   */
>
> -#include <common.h>
>  #include <bootstage.h>
>  #include <init.h>
>  #include <netdev.h>
> diff --git a/board/Seagate/goflexhome/goflexhome.c b/board/Seagate/goflex=
home/goflexhome.c
> index caea89c10e07..b2d0ad8c3f22 100644
> --- a/board/Seagate/goflexhome/goflexhome.c
> +++ b/board/Seagate/goflexhome/goflexhome.c
> @@ -12,7 +12,6 @@
>   * Marvell Semiconductor <www.marvell.com>
>   */
>
> -#include <common.h>
>  #include <bootstage.h>
>  #include <init.h>
>  #include <netdev.h>
> diff --git a/board/Seagate/nas220/nas220.c b/board/Seagate/nas220/nas220.=
c
> index cd2bbdad1cd6..fa7553250d1c 100644
> --- a/board/Seagate/nas220/nas220.c
> +++ b/board/Seagate/nas220/nas220.c
> @@ -8,7 +8,6 @@
>   * Marvell Semiconductor <www.marvell.com>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <miiphy.h>
>  #include <net.h>
> --
> 2.34.1
>
