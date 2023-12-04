Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B8CC10F13
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 06:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2645B87264;
	Mon,  4 Dec 2023 07:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x8amHzWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BCC8744C; Mon,  4 Dec 2023 07:16:52 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E32870B8
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 07:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c9f42ccb55so16627821fa.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 22:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701670609; x=1702275409; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EZVQKBKfY0Nwiaid5kOtOJYqFY3RnsqbivvFepTDX5Q=;
 b=x8amHzWJsc3PeEsxNvgmUAPXe7M1u/hVQ7eejJIMapA8/M3NP7T8sY4bgK8VhBvZ5s
 HeZ7G229I8bM9zr8k/jk/pJYzSUhWrUmqpAxP9haA2eKxT7WbX7iWnNKMwR/cyt8/4FQ
 Ng3dD5TGVe3Q4VRo+IwuSywmzqo0jaW4Q/QEPxp8qfQ7BIf3cvfHXiYW5jHE22l4bxwQ
 lxrnT7fGx9AxCaZpJAziycRwPN7KorwsZwqQnkiPX7FTi4XCbPAp7WR/zySVDAloYqVI
 3hWQ0pJPbUkkNgRKY/cNXwlXwH9ia1nkh5zSUhH+Ts/bCU8bDyzKY2zHexnrh/LJRyxV
 Y6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701670609; x=1702275409;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZVQKBKfY0Nwiaid5kOtOJYqFY3RnsqbivvFepTDX5Q=;
 b=ib1Qmq/5+hoE1y7aAXF1bsr0PMIGjYqQp3CTI3EdeMoYefSI4qV9JcM52Vk5JT/Vra
 M/KjdWuA4rDi2z45gkVBgIDKskFBw2siY5gKE+9zskwyArfJZ9e0CyGhUAaaY8CCABXI
 d8IIpfwHFhU8JY+2GAIYDw+JkarbTVQ1xzMb6o0acHRmxN4ip/hDf2KAA0aLsBmUA2hM
 A/ofugxQQiurKaEl4bHo6WkKK//AKyEDexpOLO3rrF18pYAYegHb6Lt5kjK8FVbnI4sK
 JobmM6XYAnWWvxYAwxAPngoctNBGyLm603i3C00nEyhtQFwfykjM+QGBfRpMZNpSdA6b
 ncmQ==
X-Gm-Message-State: AOJu0YxTHdDBKGWL4oRbwqKOZjymbrZXoH2U7sdX4YDBPREzMjpW+lIF
 7Fwc8lBQlLEPKyauxb8ehf1grWnDtV8bc/zJYwrNPw==
X-Google-Smtp-Source: AGHT+IFRyoel0RsqrkqGlkPJe3wxcBmRzE09OuQbaPjF0e47L6UAiyFXzCpGw6wQ1Cq1zGEoUguho6xhGQ3gC5U2fIU=
X-Received: by 2002:a2e:82d6:0:b0:2ca:2ce:36a3 with SMTP id
 n22-20020a2e82d6000000b002ca02ce36a3mr378686ljh.52.1701670609173; Sun, 03 Dec
 2023 22:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <ZW0yUHaTiPA8xxpD@octopus>
In-Reply-To: <ZW0yUHaTiPA8xxpD@octopus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 08:16:13 +0200
Message-ID: <CAC_iWjKYG_4o67=SW1fgbr-pPtd-bYyGRzD9QqaQU2Z24GjtnA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] cmd: bootefi: refactor the code for bootmgr
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, trini@konsulko.com,
 sjg@chromium.org, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

Akashi-san

On Mon, 4 Dec 2023 at 03:58, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>
> Hi Heinrich, Ilias
>
> On Tue, Nov 21, 2023 at 10:29:38AM +0900, AKASHI Takahiro wrote:
> > This patch set is motivated by the discussion[1] regarding
> > CONFIG_BOOTEFI_BOOTMGR option.
> >
> > At the end, bootefi.c will be decomposed into two parts, one for
> > providing the command itself and one for implementing helper functions.
> > EFI_LOADER will now be available without CONFIG_CMDLINE or specifically
> > CONFIG_CMD_BOOTEFI if invoked via bootmeth/bootstd.
> >
> > Then, EFI_LOADER library side will be further split into two options
> > for fine-grain control:
> > CONFIG_EFI_BINARY_EXEC: execute UEFI binaries which are to be explicitly
> >     loaded by U-Boot's load commands/functions or other methods
> >     (like a jtag debugger?)
> >     It supports bootmeth_efi as well as "bootefi <addr>|hello"(/"bootm"?).
> >
> > CONFIG_EFI_BOOTMGR: provide EFI boot manger functionality
> >     It supports bootmeth_efi_mgr as well as "bootefi bootmgr".
> >
> > As such, We will no longer need CONFIG_EFI_BINARY_EXEC if we want to only
> > make use of the UEFI boot manger for booting a next stage OS.
>
> Any other comments?
> I think the changes are no doubt trivial.

I had other patches down the queue, I'll have a look within the week!

Thanks
/Ilias
>
> -Takahiro Akashi
>
>
> > Prerequisite
> > ============
> > This patch set is based on top of Tom's "next" branch.
> >
> > Patches
> > =======
> > Patch#1-#12: I hope that those commits show step-by-step refactoring
> >     without introducing degradation.
> >
> > Tests
> > =====
> > * run UT efi_selftest on sandbox locally
> > * run test_efi_bootmgr on sandbox locally
> >
> > Unfortunately, I could not submit a pull request for CI test.
> >
> > Changes
> > =======
> > v2 (Nov 21, 2023)
> > * rebased onto Tom's next branch
> > * remove already merged commits
> > * revise commit messages
> > * add patch #5 which was split from ex-patch#5
> > RFC (Oct 26, 2023)
> >
> > [1] https://lists.denx.de/pipermail/u-boot/2023-October/534598.html
> >
> > AKASHI Takahiro (12):
> >   cmd: bootefi: unfold do_bootefi_image()
> >   cmd: bootefi: re-organize do_bootefi()
> >   cmd: bootefi: carve out EFI boot manager interface
> >   cmd: bootefi: carve out binary execution interface
> >   cmd: bootefi: localize global device paths for efi_selftest
> >   cmd: bootefi: move library interfaces under lib/efi_loader
> >   cmd: efidebug: ease efi configuration dependency
> >   bootmeth: use efi_loader interfaces instead of bootefi command
> >   efi_loader: split unrelated code from efi_bootmgr.c
> >   efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
> >   net: tftp: remove explicit efi configuration dependency
> >   fs: remove explicit efi configuration dependency
> >
> >  boot/Kconfig                     |   4 +-
> >  boot/Makefile                    |   2 +-
> >  boot/bootm_os.c                  |  31 +-
> >  boot/bootmeth_efi.c              |   8 +-
> >  boot/bootmeth_efi_mgr.c          |   2 +-
> >  cmd/Kconfig                      |  21 +-
> >  cmd/bootefi.c                    | 670 +++++--------------------------
> >  cmd/efidebug.c                   |   4 +-
> >  fs/fs.c                          |   7 +-
> >  include/efi_loader.h             |  34 +-
> >  lib/efi_loader/Kconfig           |  11 +-
> >  lib/efi_loader/Makefile          |   2 +-
> >  lib/efi_loader/efi_bootmgr.c     |  37 ++
> >  lib/efi_loader/efi_device_path.c |   3 +-
> >  lib/efi_loader/efi_helper.c      | 498 ++++++++++++++++++++++-
> >  net/tftp.c                       |  10 +-
> >  test/boot/bootflow.c             |   2 +-
> >  17 files changed, 700 insertions(+), 646 deletions(-)
> >
> > --
> > 2.34.1
> >
