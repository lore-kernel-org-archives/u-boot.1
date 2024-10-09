Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09859CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAD98904D;
	Wed,  9 Oct 2024 03:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hhLbqsXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2652689043; Wed,  9 Oct 2024 03:51:29 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20158902E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso4960354a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438685; x=1729043485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rYZ2GYv8+O1pJZTUfA88BiNvJ2UJbJP5vIc1sWs7ZO8=;
 b=hhLbqsXANGwGaQBBTa6gg91dVez7C+/Ih/BmxCfdOmYFrUh48IawlWMhCq9wdfvEhI
 soDQ7OLRIfXdD6Xj1QItrvbWTtteX2WfrUqrTVq1kDl+Pf/NNKXinaG9BilM53U7iGO2
 qAI+DPSGwI/xr1S04CByDQ3DiauIdeMsBFDYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438685; x=1729043485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYZ2GYv8+O1pJZTUfA88BiNvJ2UJbJP5vIc1sWs7ZO8=;
 b=vx/0hzGO1jzjBI5jpO2hh6Wz2x0W7fbebAAHzuSD2tmVqBwUv/OdcqrfgMxUm9SHmK
 2usmbUYVCZqoMmG2gJq6BN/8/Wc801Wt0gA2nmFwR27c7naX5y+Qbx0zpjKaXHWYb+Ab
 zeC/envdy5GaGoN4wxyTAfUCHDnRYgxO69YG4zBz+mTfUl9Z0W59asY1Nc1SifXk7oOq
 7cyae/yHdjC9vmk79V/vMWkbnt47ze1E5XH1OEWI5OXAWV3qlZwPUyqFupPfGbhzBONa
 LoGD3lpoDR2+K7YfgXiVirKksMyd2UXPDlt2Png/e0WH5BUlbxSfquqHwDM6t2wKOTod
 BC0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiDtsHEyGklgWzqwGlVk2hAhIR2OC3GrRHywklrFq+YTlgTq58+teNg+kgGlvPyeRDFRxgxlk=@lists.denx.de
X-Gm-Message-State: AOJu0YzP92Ap/3RMdoX86teRRryhb8pCysYN2i+/QGwmg4nVSVJju0VU
 YGd2/75y4sH2TLbeOQsHutwNm7nu542v8VDL8tYWMn2fL0/y1BzBpNqvKcec1OF0nhH0jOhscQn
 DNg7ePJlxFXe0fkQtRo/MxdVfDx3BQYIk60ST
X-Google-Smtp-Source: AGHT+IHqIul6RRuxjijF2kbE9uiZdQoBkLSMuLWqH+y5bFflIVwQietYESIn2fe8W+wMQom6hF772tDzdYAVdsJEgaE=
X-Received: by 2002:a05:6a21:a4c1:b0:1d5:14ff:a153 with SMTP id
 adf61e73a8af0-1d8a3bfecd2mr1732628637.12.1728438685435; Tue, 08 Oct 2024
 18:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:50:59 -0600
Message-ID: <CAFLszTiJMO+0+tMVPCM8Ho95TzvfqCgYvSLBJzmNbPJXJk-rYQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 00/10] mtd: spinand: initial support of ecc
 engines
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>, 
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>, 
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Mikhail,

On Tue, 1 Oct 2024 at 14:45, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch series:
>  * sync spinand driver code with linux-6.10
>  * sync spinand flash support with linux-6.10
>  * add initial support of ecc engines
>
> Up to now only software ecc is supported, but other engines can be add quite easily

Is there a uclass for ECC?

>
> Changes v2
>  * update description of some patches
>
> Changes v3:
>  * split some patches to a smaller one for more easy checking/verification
>  * sync spinand flash support with linux-6.10
>  * add some ecc engine comments (taken from linux driver)
>  * slightly change patch order
>
> Changes v4:
>  * avoid double increments of error counters
>
> Mikhail Kshevetskiy (10):
>   mtd: spinand: Use the spi-mem dirmap API
>   mtd: spinand: Add a NAND page I/O request type
>   mtd: spinand: add missed add missed MODULE_DEVICE_TABLE()
>   mtd: spinand: simulate behavior of linux's function spinand_wait()
>   mtd: spinand: more use of spinand_to_{something} helpers
>   mtd: spinand: replace enable_ecc variable with disable_ecc and update
>     corresponding logic
>   mtd: spinand: minor refactoring
>   mtd: spinand: more refactoring
>   mtd: spinand: sync supported flashes with linux-6.10
>   mtd: nand: add initial ecc engine support
>
>  drivers/mtd/nand/Makefile             |   2 +-
>  drivers/mtd/nand/core.c               | 130 +++++-
>  drivers/mtd/nand/ecc.c                | 249 ++++++++++
>  drivers/mtd/nand/spi/Makefile         |   4 +-
>  drivers/mtd/nand/spi/alliancememory.c | 155 ++++++
>  drivers/mtd/nand/spi/ato.c            |  84 ++++
>  drivers/mtd/nand/spi/core.c           | 649 ++++++++++++++++----------
>  drivers/mtd/nand/spi/esmt.c           |  16 +-
>  drivers/mtd/nand/spi/foresee.c        |  97 ++++
>  drivers/mtd/nand/spi/gigadevice.c     | 194 +++++++-
>  drivers/mtd/nand/spi/macronix.c       |  32 +-
>  drivers/mtd/nand/spi/micron.c         |   2 +-
>  drivers/mtd/nand/spi/toshiba.c        |  43 +-
>  drivers/mtd/nand/spi/winbond.c        |  67 ++-
>  include/linux/mtd/nand.h              | 279 ++++++++++-
>  include/linux/mtd/spinand.h           |  47 +-
>  include/spi-mem.h                     |   2 +
>  17 files changed, 1778 insertions(+), 274 deletions(-)
>  create mode 100644 drivers/mtd/nand/ecc.c
>  create mode 100644 drivers/mtd/nand/spi/alliancememory.c
>  create mode 100644 drivers/mtd/nand/spi/ato.c
>  create mode 100644 drivers/mtd/nand/spi/foresee.c
>
> --
> 2.45.2
>

Regards,
Simon
