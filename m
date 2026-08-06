Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49C1C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6521F6081E;
	Thu,  6 Aug 2026 21:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iHoZfUDW8LPf; Thu,  6 Aug 2026 21:09:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7744760836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050585;
	bh=jKIp3JhCrAD/8coBltB/fsdAD5dnx3rQf+FS4+UMgRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bf24R2ZXwLtHhfXUXazdH2QJqzwcWn3ZmSI2uvJfw+Hq2J1o40zoA0X2EGVQ+hq4W
	 ztxgwL2G3tn+iEsnbkXFJjHO93NsSY/M+3QSa1lEvPPt9x7MH0GSxF/UlPcjPLzrQY
	 WJduJLJL88OQiHZbl9tXcFYO/h+5qhEqlbYGk1ARpzLG/n50yxhxBqT4+9QiWHsBBQ
	 Ajsy39ZFHh6To9imbvSdxyhqgrXCWOg5EAyKim6jr2DB7IwugotDJWHs5PaX8vdjp4
	 n4IcO9utOa9Dlht78BGNmLFKIA0MNXIMKARid5Zt9m0zi7GpF5zv86uN+zOHJDHKi1
	 Qi+yThAD7cx8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7744760836;
	Thu,  6 Aug 2026 21:09:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81BE323F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73E0760836
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EbYY2JKykI0C for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:09:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0109E6081E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0109E6081E
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0109E6081E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:09:42 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so4531487a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050581; cv=none;
 d=google.com; s=arc-20260327;
 b=ZUWZDhFS1OqfQ5FXoQKNkwdUUhERA4NMWm1RPf/to77yTNBljd2bgYWHL6kx9gbsTG
 oyqBui/gdYaDAuqWXr+4dQNUxifL3hBaQ7WJ9JEZVHzh/63Rc2PgblsFYWY4+ISVTa7Z
 99v6e8u+sA9yrpaajZ8mTdlqoIndXVUH+eB0MHhjrsiUkjTQgGwK525el6mUZ/KRjzZh
 5dG1cGVSdQdE/43Xj/DsPE5J6xdGdF/sRv5DOxLo26lsAZlMQJEQs0yCv3I0eyrf8Wks
 PNFgq/l69CS4OHz+tulb2iak3XPPQIPswuBLdvxPXdijEFewbMa9ja8fyv355xgIF79R
 UunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jKIp3JhCrAD/8coBltB/fsdAD5dnx3rQf+FS4+UMgRc=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=ifndgcdANV1AR53HzfAGKlAsJXxBIBc6pPf0GO9FpR9UlDCk48eqmHVE6brUG9U/6Z
 HXhyUic/Zu+xTM0eaCY2hQYPSToQ6EyY0/uOxc9JjkhF0DEKgmMmLF7eoDzIIAdssljn
 WnvNxba+A9elTpMMS9Ggr+NjyEibl74DxSW6iDAnrCqOSY/uPUejy+kHFA/1uVC70Fgf
 KGUI/Acyopma6sZss28EfPMJfOmLgnTsnmFoesvMqnbjaz//0bJrFVZr4xDQ04276n9E
 zCXR2MQWKxN43UfIi7Gcz8d7QNq4gusiVZOpQ9WfWNaXBnjv+eQwLuEl2r0rY8xZ4hwf
 L88A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050581; x=1786655381;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jKIp3JhCrAD/8coBltB/fsdAD5dnx3rQf+FS4+UMgRc=;
 b=qLAVo0/nEZqmesvk6Nk7oS9SjEvcSCBL2ljSillvsj9kXe4igwAX63G4pLO8SMvBBw
 qsi5VdQGn15fB2vDIWaObZ4peRV/lTXfiIy8re+z75dobMUnLv+AQfwJm33stwh3MiCa
 PL3Hh9QDV0m+WYgvk7GdqNaD3nQJiwmAavVj1qgZvTgW8jv4K5EpPrpzyd+keUBrCbFS
 3ejQfmy4U9qaPJD8zYRRJrYyMvA9hiQX2l/Anl8l3909M8V6XaHRHDncB/Bobj2zpKRg
 flu8Bs1x50QZm0dtXTEHRZIam6liebWPB+06KUWVkQ9AYgpSVWWVBz5WKAz4jnOmdVtL
 41hQ==
X-Gm-Message-State: AOJu0YzSdtoJFQ9hfssj2to4/ygp+RoyaxLyhWDgQYvQ2jRKXlSf7t+3
 UgnTn70xWIlhZO2l5pXgIVIf9Goz9bBXFm57pTDzWfK5kuZdlBqcZXalq7/yNMRBAQU1DKH3JIg
 xi2gc7DWuyLfeApNX9/XiiSDOPbqaX9rPsTpCesOxqvNef/Ifyqw=
X-Gm-Gg: AR+sD13pEaz6qy75HZHojMW3UeMK8M9u/ROj6eUjGzMY71+fWx/xhCxDyv9+hx8QaCJ
 aD8mUS6F57RvSmgixGKCqVJU9Kg7YNXY2L7vSpQaw3c4pa4EJY00UnZxC0K5XyU5UH/KJHkppKF
 3Bd9YHuK9OIkEZd69lY50E4v31YMJue4XM54OKHp96AsZ5kLL050oX1AVre6BMZu6P4Jt4eUpF3
 Ew7oKU0SujgEet28UAPuu9eEUROVirNzuoZINtsFOx+68TQTa3TL1WA2TPt+h8DuvYGILvpU1v9
 BmKkpsWBb4ZtNRJxo7uNRxCZUKZHIwzAC8EAmhqnoq4=
X-Received: by 2002:a05:6402:28c5:b0:6a1:dbd:bfe with SMTP id
 4fb4d7f45d1cf-6a14f0badf1mr9471100a12.7.1786050580981; Thu, 06 Aug 2026
 14:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-6-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-6-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:09:28 -0600
X-Gm-Features: AUfX_mzCBrefX2YzzmLXmzlYhPPBlUTGtJsSyktF7__qEu22tIyJ63eesULpvY8
Message-ID: <CAFLszTh9foQEBVa3BfNHpZ9-2Fr4BGNGCH+oYyLz4yCGr6SkhA@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] board: ti: am62lx: add initial board files
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050581; x=1786655381;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jKIp3JhCrAD/8coBltB/fsdAD5dnx3rQf+FS4+UMgRc=;
 b=Jy6lw9LSHKEHk1da8fFa60VqS1lJwNjIMN3oUeYWriy4CgG3JZIZyyW4X3er/Fu3oE
 kR4FhCtkEz0Ip6GXLo+UfkRgAUO4th6WNIihoQqW/F41H3nRzYNGscxcIup505tGj+sE
 lX5eApKvJ7DUQAxBA+jSS2UjE5/m9N5O/DJ00=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Jy6lw9LS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bryan,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> board: ti: am62lx: add initial board files
>
> Add the initial board files to support the AM62L3-SK reference boards
> for basic boot via SD and MMC

The other patches in this series (defconfig target AM62L3_EVM,
MAINTAINERS entry 'AM62Lx BOARD', docs am62lx_evm.rst, yaml files
describing AM62L-EVM) all refer to the EVM, not an SK. Please fix the
commit message so the board name matches - and also add a full stop
and drop the mention of 'SD and MMC' (or spell out 'SD and eMMC' if
that is what you mean).

>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> board/ti/am62lx/Kconfig        |  19 +++
>  board/ti/am62lx/MAINTAINERS    |   8 +
>  board/ti/am62lx/Makefile       |   7 +
>  board/ti/am62lx/am62lx.env     |   8 +
>  board/ti/am62lx/board-cfg.yaml |  32 ++++
>  board/ti/am62lx/evm.c          |  19 +++
>  board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 473 insertions(+)

> diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
> new file mode 100644
> index 00000000000..cafafb8ede8
> --- /dev/null
> +++ b/board/ti/am62lx/evm.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Board specific initialization for AM62Lx platforms
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +#include <asm/arch/hardware.h>
> +#include <asm/io.h>
> +#include <dm/uclass.h>
> +#include <env.h>
> +#include <fdt_support.h>
> +#include <spl.h>
> +
> +int board_init(void)
> +{
> +     return 0;
> +}

None of these includes are used by an empty board_init(). Please drop
them and only add each one when the code that needs it lands. Also,
none of the other K3 boards (am62x, am62px, am62ax, am64x, j721e, ...)
provide a board_init() stub at all, so I suspect the whole function
can go away - leaving evm.c effectively empty. If that is the case,
you might as well not add evm.c and the Makefile entry until there is
something real to put in it.

> diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
> new file mode 100644
> index 00000000000..0dd86db400e
> --- /dev/null
> +++ b/board/ti/am62lx/am62lx.env
> @@ -0,0 +1,8 @@
> +kernel_addr_r=0x82000000
> +fdt_addr_r=0x88000000
> +fdtoverlay_addr_r=0x89000000
> +ramdisk_addr_r=0x88080000
> +pxefile_addr_r=0x80100000
> +
> +dfu_alt_info_ram=
> +     u-boot.img ram 0x83000000 0x400000

Just to check - the other am62* boards pull in env/ti/ti_common.env,
env/ti/mmc.env, env/ti/k3_dfu.env and set
console/boot_targets/mmcdev/etc. but it looks like this board is
relying on standard boot defaults? That's fine if so.

> diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
> new file mode 100644
> index 00000000000..abb3174d4bc
> --- /dev/null
> +++ b/board/ti/am62lx/board-cfg.yaml
> @@ -0,0 +1,32 @@
> +  bm_writer_cfg:
> +    subhdr:
> +      magic: 0x7D8A
> +      size: 5
> +    allowed_host: 10
> +
> +  reserved: [0, 0, 0, 0, 0, 0, 0]

A one-line comment pointing at where bm_writer_cfg and the reserved
block are documented in the TRM (or the tifs firmware header) would
help here. Same for the magic values in sec-cfg.yaml

Regards,
Simon
