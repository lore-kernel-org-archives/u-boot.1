Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C366FD3A66B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446E6891D2;
	Tue, 29 Oct 2024 16:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BB+QQx/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0AF89070; Tue, 29 Oct 2024 10:58:57 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE93A8910C
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 10:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e5a1c9071so4013604b3a.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730195932; x=1730800732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lfQIK0ip+qgKf1b5ma/T9yb97W11T8zhBf++0vbfk8s=;
 b=BB+QQx/FXsA+uT3UOlDDfRLw7/ZgA/EkP2dqrFRskJ2zugmgNYrXFaDCglKP7sSTQN
 T7iSd0Rk4vafdQlZjJqRm1+Oysxa+qCZzgegFqWHvj/qBtA8Ov75W/vI/APkpdVqbLfb
 Q9RKuR5INrytc9r01IA2aBlWnREr/GiUFI2+VAvWKoqtle9fpVZdMyAJuMq+Q24Q6xVN
 ZkhKHwIkYG2FaPD1//FSe9mg6y6Y61V5xDIzjV/uAqMxTKXoJXDdIqP52mBGbMSUiUOk
 Zxfp1PiyM5vSJGB/7kEFaN0s64tgxtkXyxZuq30iRQzF8PwIiqjklwv1rgZ6eCx8ispo
 Ui8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730195932; x=1730800732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lfQIK0ip+qgKf1b5ma/T9yb97W11T8zhBf++0vbfk8s=;
 b=V97PTh4/MPbf0mZXxrWHlC3kxXG9kqXl07TTrgFr3nL27eX1UtxP2jYtzy2m6CIqQZ
 4SZmaDMuXS5ausUSeWnXdVRk95k3F3CWDycutmFJ+b6tFM/XhUi71Il9QqWSTc9EtLZ9
 7xavd+0dImRuLE2UICC6fkYtGgRavzifvYOaoAyt1o6lqcHZIYOe1khQoc+JOx7toQRt
 qFBuo2hlJsN7veZRsLxhsB4pU3Pcs3HTZrMXQetd9IlADzw55lHnGC+nPf6Z+2saFzW7
 6Gca/ymSpj3JDGbmOZACK/ZihQVpFiwTztTquoMm3R7r8XJR2eigF6HzPeu9e8HrqdUP
 UrFQ==
X-Gm-Message-State: AOJu0YyYeVM6B7K4Ptu8GI8qHMFWFm7rnAIh8vK09t5Ej+ZL4XLDFtpu
 lhUXUMguMpJCMlwxvVCno6Wv8IiU3nNS/NPHa8oOxzrdhuwSzKiUqkZtoi+8zmRzEkkd1CF5Whd
 IEzRZypQO92DnJ4U7Y+FZfGaaWp7dWn2aDhO0Yg==
X-Google-Smtp-Source: AGHT+IGXc5ku7Q1DRn2ZZavQwKmeRMDtVGaMVk+kM6bdyf576hDfU6TXCLqBdJPbRbgzTs4Ua/HtC56tTcZ8a7Q+sXQ=
X-Received: by 2002:a05:6a00:218f:b0:71e:4c86:6594 with SMTP id
 d2e1a72fcca58-72062f8374dmr16844748b3a.10.1730195932264; Tue, 29 Oct 2024
 02:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 11:58:15 +0200
Message-ID: <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 29 Oct 2024 16:18:23 +0100
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

Hi Simon,

On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
>
> It is a bit of a pain to log EFI boot-services calls at present. The
> output goes to the console so cannot easily be inspected later. Also it
> would be useful to be able to store the log and review it later, perhaps
> after something has gone wrong.
>
> This series makes a start on implementing a log-to-buffer feature. It
> provides a simple 'efidebug log' command to inspect the buffer. For now,
> only memory allocations are logged.

Why is this problem specific to EFI and no U-Boot in general? Do we
have a similar machinery for malloc()?

Thanks
/Ilias
>
> This feature makes it possible to add tests to check which EFI calls are
> made by U-Boot itself. It may also make it easier to figure out what is
> needed for booting Windows.
>
> Some patches to help with debugging sandbox memory-mapping are included,
> but for now EFI's use of mapping is not adjusted.
>
>
> Simon Glass (15):
>   log: Add a new category for tests
>   test: Allow saving and restoring the bloblist
>   bloblist: test: Mark tests with UTF_BLOBLIST
>   sandbox: Convert sb command to use new macro
>   doc: sandbox: Add docs for the sb command
>   sandbox: Add a way to show the sandbox memory-mapping
>   sandbox: Fix comment for nomap_sysmem() function
>   lmb: Drop extra 16KB of stack space
>   efi_loader: Fix free in ..._media_device_boot_option()
>   efi_loader: Add support for logging EFI calls
>   efi_loader: Create the log on startup
>   efi_loader: Add a command to show the EFI log
>   test: efi_loader: Add a simple test for the EFI log
>   efi_loader: Use the log with memory-related functions
>   efi_loader: Add documentation for the EFI log
>
>  MAINTAINERS                    |   7 +
>  arch/sandbox/cpu/cpu.c         |  13 +
>  arch/sandbox/include/asm/cpu.h |   3 +
>  arch/sandbox/include/asm/io.h  |   2 +-
>  cmd/efidebug.c                 |  53 +++-
>  cmd/sb.c                       |  42 ++--
>  common/log.c                   |   1 +
>  configs/sandbox_defconfig      |   3 +
>  doc/develop/uefi/uefi.rst      |  22 ++
>  doc/usage/cmd/efidebug.rst     | 109 ++++++++
>  doc/usage/cmd/sb.rst           |  79 ++++++
>  doc/usage/index.rst            |   2 +
>  include/bloblist.h             |   1 +
>  include/efi.h                  |   1 +
>  include/efi_log.h              | 316 +++++++++++++++++++++++
>  include/log.h                  |   2 +
>  include/test/test.h            |   3 +
>  lib/efi_loader/Kconfig         |  19 ++
>  lib/efi_loader/Makefile        |   1 +
>  lib/efi_loader/efi_bootmgr.c   |   3 +-
>  lib/efi_loader/efi_log.c       | 444 +++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_memory.c    | 119 ++++++---
>  lib/efi_loader/efi_setup.c     |   7 +
>  lib/lmb.c                      |   2 -
>  test/common/bloblist.c         |  28 +--
>  test/lib/Makefile              |   1 +
>  test/lib/efi_log.c             |  93 +++++++
>  test/test-main.c               |  13 +
>  28 files changed, 1305 insertions(+), 84 deletions(-)
>  create mode 100644 doc/usage/cmd/efidebug.rst
>  create mode 100644 doc/usage/cmd/sb.rst
>  create mode 100644 include/efi_log.h
>  create mode 100644 lib/efi_loader/efi_log.c
>  create mode 100644 test/lib/efi_log.c
>
> --
> 2.43.0
>
