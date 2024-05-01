Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B20C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 20:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34432883AD;
	Wed,  1 May 2024 22:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XMwSB2Zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB97885A4; Wed,  1 May 2024 22:20:36 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C562388348
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 22:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso6427004a12.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714594833; x=1715199633; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BAPc+N76KBMY/dJsqDeK4/mf6GNoE36Oe+LtN5W25I=;
 b=XMwSB2ZtK9HPP9s8CH4JlL/wWOifOPOv+LWGRdUNXzkqFLeaOqj/33/v6dOuvMubYC
 PrxYj2PZlTWe70fVzjUinzM4V2HWY29jDWuSAz9qxgljFnRo94md4nYbPlhAko6E3Reh
 oEmce0ZS94aZxy/CO9m68eOkV6Az2FminSNFrbvz1xjJQKLmZzjiJoM7GYZFT3NtlPZ+
 3uIEae55DNwrT5Fi98LqGlvF7Jut6IxmtrOkA1uZB5vktIQqGcXjcjIvVOUHshgc3KOV
 ZyfU71ts8pj6vRTGAMPjgSDnq4u8aDvkxM6wYffswD44cNWqSaHWXGbCCe+2n2i84ISl
 aZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714594833; x=1715199633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3BAPc+N76KBMY/dJsqDeK4/mf6GNoE36Oe+LtN5W25I=;
 b=Jg4oYxp2K+uTg2RTQEFhWx65JwAr2kWMumB+ftk/DnFw3cOls7BNBb+t+Yimpn2c/x
 IXWqC04JqcP8R0MhBMv3sA7pXjaFVow9ofnIHGtW7I//5KWgLA2GZldOpYy0jCuRuBb2
 SvVv1F27iuj0haOVecOAcbcLLTm5SfMOq51dlgY9dRjceWI5ue+LALVUPwJv02HNWH6s
 ELHVx55AdCNf15G8dWtxm1tdAHzPwZr5+v+XL0SsSeXyNzKNDyL4AK//obE/ujW8Rf9r
 rIoW0J5bWohz7U0ucUpvy2hTK1fDhmKBOFUJwiQHlzEXXkpnVsREkVxHEkcfynxJBnQM
 YAHQ==
X-Gm-Message-State: AOJu0YwK8WxrANKJ7RmaQbVUXwATE6JLI+WQVlQ7FnuZiiLVs/O1/aBv
 CdRlQn1twDv1prZMdyGZmKACGyElwK9QAJWLDDxOFB22UBNdIhJr+Umov3TLbKWb1WJj9GBGdvH
 d+NwNTx8t9tDPMnXVjt4Si0S8fjw=
X-Google-Smtp-Source: AGHT+IF616bzEmmR9On21OtBbj2ANGvV4gZ1VvWhJup/GecCM3GdnFdraHyecpUZtfPXh4GNH3E8ulqb/LpaKZ0+DyM=
X-Received: by 2002:a50:d683:0:b0:56e:966:be7c with SMTP id
 r3-20020a50d683000000b0056e0966be7cmr68514edi.2.1714594833013; Wed, 01 May
 2024 13:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-10-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-10-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 1 May 2024 13:20:00 -0700
Message-ID: <CAJaLiFwUFnb7Yc8LRbvm=dmLhAzUqzjJnBVzVhMEQs0YaLtkyA@mail.gmail.com>
Subject: Re: [PATCH 010/149] board: Marvell: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Jason Cooper <u-boot@lakedaemon.net>, 
 Siddarth Gore <gores@marvell.com>, Aaron Williams <awilliams@marvell.com>
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
> Cc: Stefan Roese <sr@denx.de>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Tony Dinh <mibodhi@gmail.com>
> Cc: Jason Cooper <u-boot@lakedaemon.net>
> Cc: Siddarth Gore <gores@marvell.com>
> Cc: Aaron Williams <awilliams@marvell.com>

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

> ---
>  arch/arm/mach-kirkwood/include/mach/mpp.h     | 2 ++
>  board/Marvell/db-88f6720/db-88f6720.c         | 1 -
>  board/Marvell/db-88f6820-amc/db-88f6820-amc.c | 2 +-
>  board/Marvell/db-88f6820-gp/db-88f6820-gp.c   | 2 +-
>  board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c   | 1 -
>  board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c   | 1 -
>  board/Marvell/dreamplug/dreamplug.c           | 1 -
>  board/Marvell/guruplug/guruplug.c             | 1 -
>  board/Marvell/mvebu_alleycat-5/board.c        | 2 +-
>  board/Marvell/mvebu_armada-37xx/board.c       | 2 +-
>  board/Marvell/mvebu_armada-8k/board.c         | 2 +-
>  board/Marvell/octeontx2/soc-utils.c           | 1 -
>  board/Marvell/openrd/openrd.c                 | 1 -
>  board/Marvell/sheevaplug/sheevaplug.c         | 1 -
>  14 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-kirkwood/include/mach/mpp.h b/arch/arm/mach-ki=
rkwood/include/mach/mpp.h
> index 4d1f58c0cbdf..e2757942590b 100644
> --- a/arch/arm/mach-kirkwood/include/mach/mpp.h
> +++ b/arch/arm/mach-kirkwood/include/mach/mpp.h
> @@ -8,6 +8,8 @@
>  #ifndef __KIRKWOOD_MPP_H
>  #define __KIRKWOOD_MPP_H
>
> +#include <linux/types.h>
> +
>  #define MPP(_num, _sel, _in, _out, _F6180, _F6190, _F6192, _F6281) ( \
>         /* MPP number */                ((_num) & 0xff) | \
>         /* MPP select value */          (((_sel) & 0xf) << 8) | \
> diff --git a/board/Marvell/db-88f6720/db-88f6720.c b/board/Marvell/db-88f=
6720/db-88f6720.c
> index 26c30647fbb0..920421366f11 100644
> --- a/board/Marvell/db-88f6720/db-88f6720.c
> +++ b/board/Marvell/db-88f6720/db-88f6720.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <miiphy.h>
>  #include <net.h>
> diff --git a/board/Marvell/db-88f6820-amc/db-88f6820-amc.c b/board/Marvel=
l/db-88f6820-amc/db-88f6820-amc.c
> index 122c63d11f99..0f92cc385bc8 100644
> --- a/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
> +++ b/board/Marvell/db-88f6820-amc/db-88f6820-amc.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2015 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
>  #include <init.h>
>  #include <miiphy.h>
> diff --git a/board/Marvell/db-88f6820-gp/db-88f6820-gp.c b/board/Marvell/=
db-88f6820-gp/db-88f6820-gp.c
> index 1edc1cb6515c..8f8b2720107a 100644
> --- a/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
> +++ b/board/Marvell/db-88f6820-gp/db-88f6820-gp.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2015 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
>  #include <init.h>
>  #include <miiphy.h>
> diff --git a/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c b/board/Marvell/=
db-mv784mp-gp/db-mv784mp-gp.c
> index 9e1fdecfca4d..6bca1f91a0a4 100644
> --- a/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
> +++ b/board/Marvell/db-mv784mp-gp/db-mv784mp-gp.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2014 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <miiphy.h>
>  #include <net.h>
> diff --git a/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c b/board/Marvell/=
db-xc3-24g4xg/db-xc3-24g4xg.c
> index 0abdca1cd210..a7a84798a53b 100644
> --- a/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
> +++ b/board/Marvell/db-xc3-24g4xg/db-xc3-24g4xg.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2015 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
>  #include <i2c.h>
>  #include <init.h>
>  #include <asm/global_data.h>
> diff --git a/board/Marvell/dreamplug/dreamplug.c b/board/Marvell/dreamplu=
g/dreamplug.c
> index d15faa1cb7ff..381275061318 100644
> --- a/board/Marvell/dreamplug/dreamplug.c
> +++ b/board/Marvell/dreamplug/dreamplug.c
> @@ -8,7 +8,6 @@
>   * Written-by: Siddarth Gore <gores@marvell.com>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <netdev.h>
>  #include <asm/arch/cpu.h>
> diff --git a/board/Marvell/guruplug/guruplug.c b/board/Marvell/guruplug/g=
uruplug.c
> index ea87ded222e6..7c3cea22b936 100644
> --- a/board/Marvell/guruplug/guruplug.c
> +++ b/board/Marvell/guruplug/guruplug.c
> @@ -5,7 +5,6 @@
>   * Written-by: Siddarth Gore <gores@marvell.com>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <miiphy.h>
>  #include <net.h>
> diff --git a/board/Marvell/mvebu_alleycat-5/board.c b/board/Marvell/mvebu=
_alleycat-5/board.c
> index 0c4f8e03b859..c1b7cc3b613c 100644
> --- a/board/Marvell/mvebu_alleycat-5/board.c
> +++ b/board/Marvell/mvebu_alleycat-5/board.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>
> -#include <common.h>
> +#include <config.h>
>  #include <asm/global_data.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mveb=
u_armada-37xx/board.c
> index 1685b12b8478..df3fb6d21645 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <dm/device-internal.h>
>  #include <env.h>
> diff --git a/board/Marvell/mvebu_armada-8k/board.c b/board/Marvell/mvebu_=
armada-8k/board.c
> index a8899af6e5af..6d7042117424 100644
> --- a/board/Marvell/mvebu_armada-8k/board.c
> +++ b/board/Marvell/mvebu_armada-8k/board.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <i2c.h>
>  #include <init.h>
> diff --git a/board/Marvell/octeontx2/soc-utils.c b/board/Marvell/octeontx=
2/soc-utils.c
> index 43a19a90717c..64eb95f3b400 100644
> --- a/board/Marvell/octeontx2/soc-utils.c
> +++ b/board/Marvell/octeontx2/soc-utils.c
> @@ -5,7 +5,6 @@
>   * https://spdx.org/licenses
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <malloc.h>
>  #include <errno.h>
> diff --git a/board/Marvell/openrd/openrd.c b/board/Marvell/openrd/openrd.=
c
> index 581e2e084d6f..dda56a582b3e 100644
> --- a/board/Marvell/openrd/openrd.c
> +++ b/board/Marvell/openrd/openrd.c
> @@ -10,7 +10,6 @@
>   * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <miiphy.h>
>  #include <net.h>
> diff --git a/board/Marvell/sheevaplug/sheevaplug.c b/board/Marvell/sheeva=
plug/sheevaplug.c
> index 26ee39ef77f9..23e761d5febf 100644
> --- a/board/Marvell/sheevaplug/sheevaplug.c
> +++ b/board/Marvell/sheevaplug/sheevaplug.c
> @@ -6,7 +6,6 @@
>   * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <netdev.h>
>  #include <asm/global_data.h>
> --
> 2.34.1
>
