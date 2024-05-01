Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA50C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 09:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E7D88AF5;
	Wed,  1 May 2024 11:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CKMRCTBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7AC988AFD; Wed,  1 May 2024 11:23:06 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB5487FA0
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 11:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2b239b5fedaso1977517a91.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714555383; x=1715160183; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKSYQIOgZunyOLmYG84QozqoNTehLMUK8OR6aPjWDRo=;
 b=CKMRCTBnlmky6zdYNZSqoAKXHKsz/5hMb6yzF+FoVEln51LpILDTc0699ohin3DDDh
 R54wajVnsnpzANmqkS+QHgODQvp84butzir6t6ZGb33EXcTQp2KrW/OqSEKhpQo6jE40
 W+/Q5YokVG+v33el7hB+6CO1/dV1AmkPjIbrlahIymejBIPGNd97xs1E1kuRKNgqvGg3
 25lnBt+xtKP57BrKp2q9Z9HvSqxdn6PtbiyTkyCBx9xhA9quEsypdvLSJPCanVx5ksqX
 QgxY8W1TZRZPaC9G174Zf5+pD2R9LOGLkhpQyLRWwFoyVWn5MfqkXGDqwGRZM+jrBost
 0l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714555383; x=1715160183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKSYQIOgZunyOLmYG84QozqoNTehLMUK8OR6aPjWDRo=;
 b=PGQURkc5FQlcwaWasWpQ6gcLhMZXm1uxqJg4noxMxfliAKMNEVMmpDv28l9c4ukbUT
 eD2qJ6rhfhszy1vgM159UMfE+BfnELM1u4zg9ioEhCd3TZNsv6GyXDy/a50E+a2A5zXo
 tM2lA3r4tjQ11dQLF1a9VndspMPNupr2+HIPprHMlelAUGuJxQxfzp42kNX6URhbNAOL
 cpW4SCXkfmwyyCsWcXQKJbb1oLTZ0p0IRPjrzSCki6jj0MlaaZ12iPx8NbQlPfOpk3/O
 uXEaxREDIOrea5olj/OYNm2F/UY6WaHCWuS9au/gVMfPWkBgS0if9c0XmHFlliWwiuGI
 jgEA==
X-Gm-Message-State: AOJu0YwWbaTwvxWWa8J7Y4nUgsW3bRBZkdt5ySd8nDmNTyS4l+RUKk1W
 jZVIc6TftqG3SHz3+VipbIQOpw/71Lhd/btmB1vsD3qigcNDdoFnwTYU1RNYRKT2UKD03c151mM
 pjYqSO92bUeQPkik2wOG5X5edNgh01w==
X-Google-Smtp-Source: AGHT+IHOilvOp8DkrdPOO2015TkBym4gC1HQrEdUBRxMHqsKWArp+xLIZ3CS5oq/4nopWXm1I7VZXloPSOmRxzQQh3U=
X-Received: by 2002:a17:90a:e2c9:b0:2ac:8366:8ab4 with SMTP id
 fr9-20020a17090ae2c900b002ac83668ab4mr1948022pjb.38.1714555382487; Wed, 01
 May 2024 02:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-23-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-23-trini@konsulko.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 1 May 2024 04:22:51 -0500
Message-ID: <CAHCN7xL5=KkyDsK-w_awPCRyoS+NCOYu9sQHRKZMTB_VtA280Q@mail.gmail.com>
Subject: Re: [PATCH 023/149] board: beacon: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, Apr 30, 2024 at 9:43=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by:  Adam Ford <aford173@gmail.com>

> ---
> Cc: Adam Ford <aford173@gmail.com>
> ---
>  board/beacon/beacon-rzg2m/beacon-rzg2m.c | 1 -
>  board/beacon/imx8mm/lpddr4_timing.c      | 1 -
>  board/beacon/imx8mm/spl.c                | 1 -
>  board/beacon/imx8mn/spl.c                | 1 -
>  board/beacon/imx8mp/imx8mp_beacon.c      | 1 -
>  board/beacon/imx8mp/spl.c                | 1 -
>  6 files changed, 6 deletions(-)
>
> diff --git a/board/beacon/beacon-rzg2m/beacon-rzg2m.c b/board/beacon/beac=
on-rzg2m/beacon-rzg2m.c
> index 99fe1edfb330..099053235ded 100644
> --- a/board/beacon/beacon-rzg2m/beacon-rzg2m.c
> +++ b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
> @@ -3,7 +3,6 @@
>   * Copyright 2020 Compass Electronics Group, LLC
>   */
>
> -#include <common.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>
> diff --git a/board/beacon/imx8mm/lpddr4_timing.c b/board/beacon/imx8mm/lp=
ddr4_timing.c
> index 8e48b9d81b77..c1498dd5eaf4 100644
> --- a/board/beacon/imx8mm/lpddr4_timing.c
> +++ b/board/beacon/imx8mm/lpddr4_timing.c
> @@ -4,7 +4,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <common.h>
>  #include <asm/arch/ddr.h>
>  #include <asm/arch/lpddr4_define.h>
>
> diff --git a/board/beacon/imx8mm/spl.c b/board/beacon/imx8mm/spl.c
> index 1632238bf5dd..12013aa5a4da 100644
> --- a/board/beacon/imx8mm/spl.c
> +++ b/board/beacon/imx8mm/spl.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <hang.h>
>  #include <init.h>
> diff --git a/board/beacon/imx8mn/spl.c b/board/beacon/imx8mn/spl.c
> index b4d46f11f98d..f03841e5a01d 100644
> --- a/board/beacon/imx8mn/spl.c
> +++ b/board/beacon/imx8mn/spl.c
> @@ -3,7 +3,6 @@
>   * Copyright 2020 Compass Electronics Group, LLC
>   */
>
> -#include <common.h>
>  #include <hang.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/beacon/imx8mp/imx8mp_beacon.c b/board/beacon/imx8mp/im=
x8mp_beacon.c
> index 8963a51fbba0..dd74e7c0f755 100644
> --- a/board/beacon/imx8mp/imx8mp_beacon.c
> +++ b/board/beacon/imx8mp/imx8mp_beacon.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /* Copyright 2023 Logic PD, Inc dba Beacon EmbeddedWorks */
>
> -#include <common.h>
>  #include <init.h>
>  #include <miiphy.h>
>  #include <asm/arch/sys_proto.h>
> diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
> index 591e8ca9ab5b..30d577f7e0e3 100644
> --- a/board/beacon/imx8mp/spl.c
> +++ b/board/beacon/imx8mp/spl.c
> @@ -4,7 +4,6 @@
>   *
>   */
>
> -#include <common.h>
>  #include <hang.h>
>  #include <init.h>
>  #include <log.h>
> --
> 2.34.1
>
