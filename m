Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A3AC25B78
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFC1882EF;
	Wed,  5 Jun 2024 04:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="POIb6i3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E058881D6; Wed,  5 Jun 2024 04:13:50 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F85C87AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-df7722171bcso6277944276.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553625; x=1718158425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DSPqky3uR24F4ReMgeveC5yL5GmJOIMXBED0kONPpzo=;
 b=POIb6i3t15KUX+eWYKqKV9xZLKbpVv50kungkUGz0+HCsNaBm2zJLyZcWXldfTBKLr
 1PHVuuJ0t7CesqYFvHQvBmcsHOdE/E6XyEMd0QzZWF4G28TkykUve6aVkttw7OqdACtp
 UL+0bpPaGr8k6Q9SoAv0TS4bd//UdXM1yXOsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553625; x=1718158425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DSPqky3uR24F4ReMgeveC5yL5GmJOIMXBED0kONPpzo=;
 b=PISfFJPGLDDZgpPFOvzX3oKg3SmjCfej3it5QTMsdCNs4Tl4Tphxt7qhd4Okwtbfb9
 uw6h9dcJ3IHjgUpBc6yYBBcNWMx8hMKgkiWOlwkjeSVv/LRgZVrGLa9hwzjiOlyPgrcd
 2cn4SJrrWp6Takd/NrF2ZAzPfen7ocAMIYYAjB84Kas3vcWflPGQsnx33K/8OzK7rD6p
 eFNrXg4DCnpS4zTqUrlbvQ/0IpvIkQ0SO+mLgngms6/GNrRpG6KQZqKJvpd9CMXopwzm
 JjWkQQaJXwXunbvJ0AQCVoX1/OcwUxPIntJS9aDYO7tlj1+4Pw8TWuAAJ+x+scU203e1
 P3Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUp0mUhZV7Cs8pQ//BqZALkr6I+HEnkf7fWFb07nonF2AvWWNFjxfoHIOIV1VMTTqoQPm878V50l6nvivemM5zmRbqdg==
X-Gm-Message-State: AOJu0Yw9pfvalkMoCUAWucsSdBwuskFhvn9rK+qyj1bBcUYK6ZrHrj3v
 Xz2aapwCSPGl9q/4fztO5g+KNf0Sa1GN2SikVMLUJGfYu3cSvePbW/WP0zoEIrEyaOWbwBXtX7Q
 wsne5v5vQDFijmcCD/byBwiEdjkA0VrmYFlrw
X-Google-Smtp-Source: AGHT+IENX7t+OE8syu2OSDspUuf4ZwI8bInh6gtn5j12sU0u+tqUYBQn9G/edT5l9o18yHju+EQaKtn5X6+wCZWK1QY=
X-Received: by 2002:a25:2d0b:0:b0:ddd:696a:8656 with SMTP id
 3f1490d57ef6-dfacad060d7mr1143957276.41.1717553625143; Tue, 04 Jun 2024
 19:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240603155702.1840464-1-avromanov@salutedevices.com>
In-Reply-To: <20240603155702.1840464-1-avromanov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:34 -0600
Message-ID: <CAFLszTi+ONdb2P5gtSX_OMUD162G7OtRMD-LbmzO7xuNLRX_HQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Introduce mtdblock device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Michal Simek <michal.simek@amd.com>, mikhail.kshevetskiy@iopsys.eu, 
 Patrice Chotard <patrice.chotard@foss.st.com>, kernel@salutedevices.com, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Alexey,

On Mon, Jun 3, 2024, 09:57 Alexey Romanov <avromanov@salutedevices.com>
wrote:

> Hello!
>
> This series adds support for the mtdblock device, which
> allows to read/write data block by block. For example,
> it can now be used for BCB or Android AB command:
>
>   $ bcb load mtd 0 part_name
>
> Tested only on SPI NAND, so bind is made only for
> SPI NAND drivers.
>
> ---
>
> Changes V1 -> V2 [1]:
>
>   - Drop patch [2].
>   - Add warning if bind NAND mtdblock device.
>   - Move documentation of mtdblock implementation
>     from commit message to the source code.
>   - Remove __maybe_unused from mtd partition functions
>     description.
>   - Use blk_enabled() instead of #ifdefs.
>
> Changes V2 -> V3 [2]:
>
>   - Rebased over [3].
>   - Rename mtd_bread/bwrite -> mtd_blk_read/write.
>   - Fix GPL-2.0 license short name definiton in headers.
>   - Add empty line after MTD_ENTRY_NUMBERS define.
>
> Changes V3 -> V4 [4]:
>
>   - Fix build warnings: use LBAF printf format string for lbaint_t types.
>
> Changes V4 -> V5 [5]:
>
>   - Rebased over u-boot/master.
>   - Fix build errors and warnings if CONFIG_BLK isn't enabled.
>   - Fix failed tests in cases is mtdblock device isn't binded.
>
> Links:
>
>   - [1]
> https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
>   - [2]
> https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@salutedevices.com/
>   - [3]
> https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.schuchardt@canonical.com/T/#u
>   - [4]
> https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@salutedevices.com/
>   - [5]
> https://lore.kernel.org/all/20240524102920.2631731-1-avromanov@salutedevices.com/
>
> Alexey Romanov (3):
>   disk: support MTD partitions
>   drivers: introduce mtdblock abstraction
>   spinand: bind mtdblock
>
>  disk/part.c                 |   3 +-
>  drivers/block/blk-uclass.c  |   1 +
>  drivers/mtd/Kconfig         |   1 +
>  drivers/mtd/Makefile        |   1 +
>  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtdpart.c       |  76 ++++++++++++
>  drivers/mtd/nand/spi/core.c |  20 ++++
>  include/linux/mtd/mtd.h     |  21 ++++
>  include/part.h              |   3 +
>  9 files changed, 352 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/mtdblock.c
>
> --
> 2.34.1
>
>
