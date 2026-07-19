Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002CC4451B
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 16:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCAB848BA;
	Sun, 19 Jul 2026 18:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="kLCZrmSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49E884949; Sun, 19 Jul 2026 18:48:27 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E280780517
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 18:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784479699; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FttkAwjj9KUTbYjZUkFgkSpJrv+upSN+zFgbxQL28j1KW3tT2bqn9lfEfroLeFD5hG1z47mnUDipygKqV5bAlj3fyCDHIyXryjFdr2I/cgcC/v6qoe0mY24B1FnDOCIv1t56fVvc4grBPW/2V7+2ur3vi2vZ7H5p38GHRewXxAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784479699;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5IHLoWRsmSmofHlrCO9+J+IJ7kzu62b9Q27RvG9TNoU=; 
 b=CFrmqbRz7Fi0wWyddpEBTClZkzMmTD0Q8ND7J9uGFJ9LM//51VM8J2RkmoyOMxe8/TAflhaMKZ+TGiFpDQL5eU77n9mJH87VimbW6CWPbahN4olmROQvS50xYwT39J3E2xyTfB9xlpqXBfQcqyq/RPt//FKXGgmsboNst4ltjQQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784479699; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=5IHLoWRsmSmofHlrCO9+J+IJ7kzu62b9Q27RvG9TNoU=;
 b=kLCZrmSJdS0LdnkAbGBjKE3O+kZ/tfqRjy5YXh0NgBMg/E4uibnUNXimGo82ftQh
 otq9lNIVLCdLtOXi3JducxASlVFQEJgK8wbMYQ2+ZqniDgB6PdikL3AZOmJV3HWhJib
 UgzHbFOOGflYWMKYHjTapSgX3W1gsrPsDtKTF0l0=
Received: by mx.zohomail.com with SMTPS id 1784479696359383.67396222549235;
 Sun, 19 Jul 2026 09:48:16 -0700 (PDT)
Date: Sun, 19 Jul 2026 16:47:54 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.denx.de
Cc: Kongyang Liu <seashell11234455@gmail.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor.dooley@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Andreas Schwab <schwab@suse.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Chen-Yu Yeh <chenyou910331@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] board: sophgo: add support for Milk-V Duo 256M
Message-ID: <alz_uu2oVU-byE0K@pie>
References: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
 <20260710-add-milkv-duo256m-v1-2-0f761100361d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-add-milkv-duo256m-v1-2-0f761100361d@baylibre.com>
X-ZohoMailClient: External
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

On Fri, Jul 10, 2026 at 01:33:56PM -0300, Hiago De Franco wrote:
> Add U-Boot support for Milk-V Duo 256M.
> 
> This board has a different SoC compared to the Milk-V Duo 64M, it uses
> the Sophgo SG2002 instead of the Sophgo CV1800B. Both SoCs share many
> common IP blocks, so this board reuses the existing cv1800b CPU support.
> 
> Link: https://milkv.io/docs/duo/getting-started/duo256m
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  arch/riscv/Kconfig                             |  4 ++
>  arch/riscv/dts/Makefile                        |  1 +
>  arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 +++++++++++++++
>  board/sophgo/milkv_duo_256m/Kconfig            | 30 ++++++++++
>  board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
>  board/sophgo/milkv_duo_256m/Makefile           |  6 ++
>  board/sophgo/milkv_duo_256m/board.c            | 19 ++++++
>  board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
>  configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
>  doc/board/sophgo/index.rst                     |  1 +
>  doc/board/sophgo/milkv_duo_256m.rst            | 82 ++++++++++++++++++++++++++
>  include/configs/milkv_duo_256m.h               | 12 ++++
>  12 files changed, 256 insertions(+)

...

> diff --git a/board/sophgo/milkv_duo_256m/board.c b/board/sophgo/milkv_duo_256m/board.c
> new file mode 100644
> index 00000000000..b8454e0a1e9
> --- /dev/null
> +++ b/board/sophgo/milkv_duo_256m/board.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
> + */
> +
> +#include <dm/lists.h>
> +
> +#include "../common/ethernet.h"
> +
> +int board_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
> +		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
> +
> +	if (IS_ENABLED(CONFIG_NET_LEGACY))
> +		cv1800b_ephy_init();
> +
> +	return 0;
> +}

This looks identical to milkv_duo/board.c, could we re-use it instead of
introducing a copy at least for now?

...

> diff --git a/doc/board/sophgo/milkv_duo_256m.rst b/doc/board/sophgo/milkv_duo_256m.rst
> new file mode 100644
> index 00000000000..671f3a0b964
> --- /dev/null
> +++ b/doc/board/sophgo/milkv_duo_256m.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Milk-V Duo 256M
> +===============
> +
> +SG2002 RISC-V SoC
> +------------------
> +The SG2002 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
> +
> +Mainline support
> +----------------
> +The support for following drivers are already enabled:
> +1. ns16550 UART Driver.
> +2. Synopsys Designware MSHC Driver

At least this part is not accurate, according to the log below,

...

> +Sample boot log from Milk-V 256M Duo board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +  U-Boot 2026.07-00002-g0b690770386f-dirty (Jul 07 2026 - 13:33:36 -0300)milkv_duo_256m
> +
> +  DRAM:  256 MiB
> +  Core:  20 devices, 13 uclasses, devicetree: separate
> +  MMC:   mmc@4310000: 0
> +  Loading Environment from nowhere... OK
> +  In:    serial@4140000
> +  Out:   serial@4140000
> +  Err:   serial@4140000
> +  Net:
> +  Warning: ethernet@4070000 (eth0) using random MAC address - 0a:f3:23:40:7e:55

Ethernet is enabled, too. Please update the documentation to reflect the
support status.

Best regards,
Yao Zi
