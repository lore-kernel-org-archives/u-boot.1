Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF47C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 10:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C1886F40;
	Mon, 15 Jan 2024 11:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kV2M9Yoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEA086D82; Mon, 15 Jan 2024 11:17:27 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3195885E44
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 11:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dbed5d1ffb0so7466214276.1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 02:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705313843; x=1705918643;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXp73V/H1/sNhp9ahuFJG6d1NYs2msKRokeY5l7iW/c=;
 b=kV2M9YoocnflvXxG+IrrOzOD1rRiiJHFgBHYOZOACvZVXIrCMMtoOZriBZ420eeFNu
 8fmSYSd2ZhbUJqnnlvTdlppluYhr84tQeeIUnPGzztV0qOdtW015Xpc0RyZj1ncleoJk
 8C1YlPH8qkBVQsnsC8C5RS0aKQc9iLpnqBDhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705313843; x=1705918643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXp73V/H1/sNhp9ahuFJG6d1NYs2msKRokeY5l7iW/c=;
 b=VZ8grzbOMvLFfXWm/tmaQpY/Ra7i6OZMMxDpMFjANAEx4RdWgTwR9DFYU2n1D4zrUN
 xOXXpkjoWs0zbTcZlzKUg9w4yZw4rLVTGjXqJWU6/JmM8HbSvrV9pPk2c51vS/Kb/2YS
 aP90VlZNh5aPiBOojZIIkHEgHRPToodS683kJrEDfM8f4+aCQbGl3sc5JMVlEKFA0Z4j
 phcuFoU6v948TDoUnzS5CjO95yhegQu2dzibVdvs1WEj6gseYd9hh9BbSdEqu1NYDfRQ
 qHFv5FfCGdKq1hnYckLVSzamT3873JXQu4stQOogLBq7nrJ9eD2rhqgLNqaK2oGNW2VJ
 IK5A==
X-Gm-Message-State: AOJu0Ywp8LsyOEuamXtHPzsa/lFed7SYePzcCH/4Mp8MJTFkryCEEVGa
 vF+EIRa6lWboqqNehZTidjfqKe6aQqJL75pc+YTlPHFH8tTUsw==
X-Google-Smtp-Source: AGHT+IEtHWriMHKPyW6h/Hzr7B6QQZUBVEWoiHge4oBQmNm+3WMCqUwX3CpQcyGNpQRXlT2j0XP7uZ6cSBnyeUIOtac=
X-Received: by 2002:a25:c711:0:b0:dbe:ace5:c053 with SMTP id
 w17-20020a25c711000000b00dbeace5c053mr2283829ybe.5.1705313841444; Mon, 15 Jan
 2024 02:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20240109173231.78920-1-avromanov@salutedevices.com>
In-Reply-To: <20240109173231.78920-1-avromanov@salutedevices.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 15 Jan 2024 11:17:10 +0100
Message-ID: <CABGWkvrF3YQHK-rOZtQvrFw9o2qM1tukR=0ZYE_RVqwF69H4jA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Support SPI NAND in fastboot protocol
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: michal.simek@amd.com, marex@denx.de, michael@walle.cc, 
 stcarlso@linux.microsoft.com, tobias@waldekranz.com, seanedmond@microsoft.com, 
 abdellatif.elkhlifi@arm.com, neil.armstrong@linaro.org, n-jain1@ti.com, 
 xypron.glpk@gmx.de, michael@amarulasolutions.com, frieder.schrempf@kontron.de, 
 sjg@chromium.org, hs@denx.de, sean.anderson@seco.com, dimorinny@google.com, 
 mkorpershoek@baylibre.com, patrick.delaunay@foss.st.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com
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

On Tue, Jan 9, 2024 at 6:32=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Currently, fastboot in U-Boot doens't support SPI NAND
> devices. This patchset adds support for SPI NAND in fastboot
> nand subsystem.
>
> Changes V1 -> V2:
>
> - Rebase patchset over u-boot/next.
> - Move nand_unregister(), nand_reinit() and nang_page_size() functions
>   to NAND core folder too.
> - Move changes about CMD_RET_FAILURE/SUCCESS into separate patches.
>
> Alexey Romanov (14):
>   nand: move NAND initialization API to nand/core.c
>   nand: don't overwrite mtd name in nand_register()
>   nand: move nand_util.c to NAND core folder
>   nand: move nand_erase_opts() to core NAND folder
>   spi: add board_nand_init() function
>   spi: use nand_register() instead of add_mtd_device()
>   mtdparts: use negative error codes
>   mtdparts: use CMD_RET_FAILURE define
>   jffs2: use negative error codes
>   jffs2: use CMD_RET_FAILURE/SUCCESS defines
>   cmd: allow to enable CMD_NAND for SPI NAND devices
>   fastboot: check device type for SPI NAND too
>   fastboot: enable FASTBOOT_FLASH option for SPI NAND devices
>   fastboot: fb_nand: add missing newlines in pr_err() macro
>
>  cmd/Kconfig                      |   2 +-
>  cmd/jffs2.c                      |  45 +-
>  cmd/mtdparts.c                   | 154 +++----
>  drivers/fastboot/Kconfig         |   4 +-
>  drivers/fastboot/fb_nand.c       |  12 +-
>  drivers/mtd/Kconfig              |   2 +-
>  drivers/mtd/nand/Kconfig         |  10 +
>  drivers/mtd/nand/Makefile        |   2 +-
>  drivers/mtd/nand/core.c          | 193 +++++++++
>  drivers/mtd/nand/raw/Kconfig     |  10 -
>  drivers/mtd/nand/raw/nand.c      | 182 --------
>  drivers/mtd/nand/raw/nand_util.c | 664 -----------------------------
>  drivers/mtd/nand/spi/Kconfig     |   1 +
>  drivers/mtd/nand/spi/core.c      |  17 +-
>  drivers/mtd/nand/util.c          | 709 +++++++++++++++++++++++++++++++
>  include/nand.h                   |   2 +
>  16 files changed, 1042 insertions(+), 967 deletions(-)
>  create mode 100644 drivers/mtd/nand/util.c
>
> --
> 2.30.1
>

The series doesn't pass te CI tests.
Following an example of errors :

Building current source for 1 boards (1 thread, 64 jobs per thread)
59 sandbox: + sandbox
60+/usr/bin/ld: /tmp/ccyLvZ90.ltrans5.ltrans.o: in function `set_dev':
61+cmd/nand.c:239: undefined reference to `get_nand_dev_by_index'
62+/usr/bin/ld: cmd/nand.c:244: undefined reference to `nand_curr_device'
63+/usr/bin/ld: /tmp/ccyLvZ90.ltrans5.ltrans.o: in function
`nand_print_and_set_info':
64+cmd/nand.c:411: undefined reference to `get_nand_dev_by_index'
65+/usr/bin/ld: /tmp/ccyLvZ90.ltrans5.ltrans.o: in function `nand_load_imag=
e':
66+cmd/nand.c:1002: undefined reference to `nand_read_skip_bad'
67+/usr/bin/ld: cmd/nand.c:1037: undefined reference to `nand_read_skip_bad=
'
68+/usr/bin/ld: /tmp/ccyLvZ90.ltrans5.ltrans.o: in function `do_nand':
69+cmd/nand.c:511: undefined reference to `nand_curr_device'
70+/usr/bin/ld: cmd/nand.c:563: undefined reference to `get_nand_dev_by_ind=
ex'
71+/usr/bin/ld: cmd/nand.c:635: undefined reference to `get_nand_dev_by_ind=
ex'
72+/usr/bin/ld: cmd/nand.c:657: undefined reference to `nand_erase_opts'
73+/usr/bin/ld: cmd/nand.c:705: undefined reference to `get_nand_dev_by_ind=
ex'
74+/usr/bin/ld: cmd/nand.c:480: undefined reference to `get_nand_dev_by_ind=
ex'
75+/usr/bin/ld: cmd/nand.c:734: undefined reference to `get_nand_dev_by_ind=
ex'
76+/usr/bin/ld: cmd/nand.c:740: undefined reference to `nand_read_skip_bad'
77+/usr/bin/ld: cmd/nand.c:743: undefined reference to `nand_write_skip_bad=
'
78+/usr/bin/ld: cmd/nand.c:456: undefined reference to `nand_verify_page_oo=
b'
79+/usr/bin/ld: /tmp/ccyLvZ90.ltrans5.ltrans.o: in function `do_nandboot':
80+cmd/nand.c:1093: undefined reference to `get_nand_dev_by_index'
81+/usr/bin/ld: cmd/nand.c:1137: undefined reference to `get_nand_dev_by_in=
dex'
82+/usr/bin/ld: /tmp/ccyLvZ90.ltrans8.ltrans.o: in function
`initr_nand.lto_priv.0':
83+common/board_r.c:370: undefined reference to `nand_init'
84+/usr/bin/ld: common/board_r.c:371: undefined reference to `nand_size'
85+/usr/bin/ld: /tmp/ccyLvZ90.ltrans14.ltrans.o: in function `sand_nand_rem=
ove':
86+drivers/mtd/nand/raw/sand_nand.c:462: undefined reference to
`nand_unregister'
87+/usr/bin/ld: /tmp/ccyLvZ90.ltrans14.ltrans.o: in function `sand_nand_pro=
be':
88+drivers/mtd/nand/raw/sand_nand.c:628: undefined reference to `nand_regis=
ter'
89+/usr/bin/ld: /tmp/ccyLvZ90.ltrans41.ltrans.o: in function `dm_test_nand'=
:
90+test/dm/nand.c:31: undefined reference to `get_nand_dev_by_index'
91+/usr/bin/ld: test/dm/nand.c:51: undefined reference to `nand_erase_opts'
92+/usr/bin/ld: test/dm/nand.c:55: undefined reference to `nand_read_skip_b=
ad'
93+/usr/bin/ld: test/dm/nand.c:68: undefined reference to `nand_write_skip_=
bad'
94+/usr/bin/ld: test/dm/nand.c:73: undefined reference to `nand_read_skip_b=
ad'
95+/usr/bin/ld: test/dm/nand.c:81: undefined reference to `nand_erase_opts'
96+/usr/bin/ld: test/dm/nand.c:84: undefined reference to `nand_read_skip_b=
ad'
97+collect2: error: ld returned 1 exit status
98+make[1]: *** [Makefile:1766: u-boot] Error 1
99+make: *** [Makefile:177: sub-make] Error 2
100 0 0 1 /1 sandbox

Please fix the errors.

Thanks and regards,
Dario

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
