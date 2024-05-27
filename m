Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A076C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 07:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027328820B;
	Mon, 27 May 2024 09:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bq/XGqzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D31188228; Mon, 27 May 2024 09:37:22 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF76881E7
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 09:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-627f46fbe14so46610947b3.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716795438; x=1717400238;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+9m0pksCorFLFrdKXdEvUagoobBkCvZEaMJvcZ+DEA=;
 b=bq/XGqzX9nhO+WxQBHDOXNn+TEi3glBBrJ979g3+eUN39PgxFx8YMx44RTeQenYPUq
 CLe34qBoIW1SfdxbeRJaY8iu5Q3JInPAPwlcddBG73wu3hM4Y9gMl5i2rXJTxa+9UvZU
 ZD/sDjKfjnRFJAn1PJf9kCnyFiSPZOLfxIiTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716795438; x=1717400238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+9m0pksCorFLFrdKXdEvUagoobBkCvZEaMJvcZ+DEA=;
 b=LASnQSyYsZG0hRrA0U/FjAawCS7eJiKc1JjmbmqnmXA9zqXCgoiM5av0zGXl466d6+
 XkdSsm9KP1sB2tH0azkmM88dGaiVLQ+9oPfdT+jf8zKizzQdWS7ONqpp0H9kbFJbjnUx
 r4ITjTFZFWDqsAzJuTkJddUCUaK0Zz4nZ27O/jpKxBCp9hKyUTgnhchfvZqI27D1PN4B
 dCLC4XuV9CLQPiUJW8G4FA8lmsrtXGhmZWQJlM9y0r3V21L2Pxo7bx0zPMMS6DyeJCBr
 1aACfJBUJG6MKokgI3tJXCXB5cCtQl1YzB5ovL/pdyfrxXvJ1dTiZIDtoTTMl5fqA7ql
 71oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDRxS8GkrdHZtlPnmd+jgd1+HzV0Mg7LStKSwI3O3HvPT3U+JmQWXVah3+zPEo5gO6Mfe4NXcIt/uflLm4wz7n8MHxhA==
X-Gm-Message-State: AOJu0Yw2lf2JwhxnhwCG1uUyvdqmgRTWVDevfSaUX3r/W486sw0jKlJb
 Q7MO5PPPfRwfCgeBbtzvIG2pVXZ/gWvSsC5Xs+r+mAgObrB02lNaRZOg1JQz3dWHYkVcM5VH/mQ
 Gu3jsdcE70EsfKpowBTUpLwiQJdpnIUKHXfqd7w==
X-Google-Smtp-Source: AGHT+IFZGpe3pi5jXQLgNL2RV5lrrhwHiln4g6BrAS0qxdRxGBDzZNHrzdOODsVZrY3isUi0JOajOad4v95bdtQDfbo=
X-Received: by 2002:a81:924e:0:b0:610:b464:9f1a with SMTP id
 00721157ae682-62a08fa8ce9mr78337577b3.45.1716795438123; Mon, 27 May 2024
 00:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240524102920.2631731-1-avromanov@salutedevices.com>
In-Reply-To: <20240524102920.2631731-1-avromanov@salutedevices.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 27 May 2024 09:37:07 +0200
Message-ID: <CABGWkvpHE_Vxu-sWz_XB-2zm3LEaHZu_4WY6javZW9NxkuAp_w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Introduce mtdblock device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: michael@amarulasolutions.com, frieder.schrempf@kontron.de, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com, 
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com, jbx6244@gmail.com, 
 abdellatif.elkhlifi@arm.com, michal.simek@amd.com, 
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com, 
 kernel@salutedevices.com, u-boot@lists.denx.de
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

Hi Alexey,

The CI still detects some errors when applying both series:
- Introduce mtdblock device
- Introduce UBI block device

As an example:

+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/=
13.2.0/../../../../arm-linux-gnueabi/bin/ld:
/tmp/ccOTHlvl.ltrans4.ltrans.o: in function `mtd_blk_read':
6816+drivers/mtd/mtdblock.c:95:(.text.mtd_blk_read+0x40): undefined
reference to `mtd_read'
6817+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnue=
abi/13.2.0/../../../../arm-linux-gnueabi/bin/ld:
/tmp/ccOTHlvl.ltrans4.ltrans.o: in function `mtd_blk_write':
6818+drivers/mtd/mtdblock.c:162:(.text.mtd_blk_write+0x9a): undefined
reference to `mtd_read'
6819+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnue=
abi/13.2.0/../../../../arm-linux-gnueabi/bin/ld:
drivers/mtd/mtdblock.c:122:(.text.mtd_blk_write+0xf4): undefined
reference to `mtd_erase'
6820+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnue=
abi/13.2.0/../../../../arm-linux-gnueabi/bin/ld:
/tmp/ccOTHlvl.ltrans4.ltrans.o:drivers/mtd/mtdblock.c:126:(.text.mtd_blk_wr=
ite+0x110):
undefined reference to `mtd_write'
6821+collect2: error: ld returned 1 exit status
6822+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnue=
abi/13.2.0/../../../../arm-linux-gnueabi/bin/ld:
/tmp/ccaNKMBK.ltrans2.ltrans.o: in function `mtd_blk_read':
6823+drivers/mtd/mtdblock.c:95:(.text.mtd_blk_read+0x36): undefined
reference to `mtd_read'
6824+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnue=
abi/13.2.0/../../../../arm-linux-gnueabi/bin/ld:
/tmp/ccaNKMBK.ltrans2.ltrans.o: in function `mtd_blk_write':
6825+drivers/mtd/mtdblock.c:162:(.text.mtd_blk_write+0x88): undefined
reference to `mtd_read'
6826+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnue=
abi/13.2.0/../../../../arm-linux-gnueabi/bin/ld:
drivers/mtd/mtdblock.c:122:(.text.mtd_blk_write+0xe0): undefined
reference to `mtd_erase'
6827+/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnue=
abi/13.2.0/../../../../arm-linux-gnueabi/bin/ld:
/tmp/ccaNKMBK.ltrans2.ltrans.o:drivers/mtd/mtdblock.

Furthermore, I need to fix something in applying the patches.
So, please rebase your series on master and run the tests locally:
Please read tools/buildman/buildman.rst and .gitlab-ci.yml to get info.

Thanks and regards,
Dario

On Fri, May 24, 2024 at 12:29=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
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
> Links:
>
>   - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@sa=
lutedevices.com/
>   - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@sa=
lutedevices.com/
>   - [3] https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.sc=
huchardt@canonical.com/T/#u
>   - [4] https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@sa=
lutedevices.com/
>
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
>  drivers/mtd/mtdpart.c       |  69 +++++++++++
>  drivers/mtd/nand/spi/core.c |  20 ++++
>  include/linux/mtd/mtd.h     |  12 ++
>  include/part.h              |   3 +
>  9 files changed, 336 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/mtdblock.c
>
> --
> 2.34.1
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
