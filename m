Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF23E6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C258089048;
	Fri,  1 Nov 2024 16:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXhpGzuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F202C88E35; Fri,  1 Nov 2024 16:32:54 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA48889A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso275527966b.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475171; x=1731079971; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VR4tmZg8AMlV7QXLzpioAsk0lgG+ZWitP7YhVk2lmjs=;
 b=kXhpGzuLYGCaUNMKuPv3OS3jHmkswuCtdBCLdfNnmAWBbYp0RKmWbg2OOpjxaMhpzz
 P7C4sNSukCBPy75uvWoyIL4i86Yn0LmxCwp4d/AtC0WVWp9eNTQ6rY04icyUz+4dnMe0
 yTtvOdn7Qc1fGd6O/QCw8rjq6iTbNwuo1ccLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475171; x=1731079971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VR4tmZg8AMlV7QXLzpioAsk0lgG+ZWitP7YhVk2lmjs=;
 b=X9wkuh4lQCgBpWY5I5SbCoD8VJtIwhWRt33/J22LtwpXnXHBU8m/5kBBGy2QRu3Hwd
 PUm6s9KgKH5n31FKehz23AQPQMSimsicQQTZHvorgN8jDEiakn9A3lS2PHjNL7oQr85S
 eSSOaFHnjyvOBuSvC9mfRjTX9EeMYdZ77n/F2lSwRvCJJImCYt1yxzN02sh+yUZc2jpj
 Onh/H1oSo+QOOYC+oWyklOHj9+HqW6z+3KuqzUxbQWU4bnY8bVHP5rzc3wsQ+eQK6D03
 y+PUpGbKOpZTPLQ18aFVD0zJxTUOw4G8ytL2ZD1HY4VmO/OK124QVGaEVB60HcAKMt5B
 y/zQ==
X-Gm-Message-State: AOJu0YxF0I6buTCDR9VIvZpztW2eTG2rQ600oUdkMJ39RsWOXFWlJa+9
 3m/2Lf958ZxL0VY4MkUztkCzRgLamluZsQUsRQEUf2VjiAGHWhR5/HkWSqGnQ4ycefOq20zKr8X
 vrRBcbVT/VSWCakiuUCV3QB1UN7vbYYO0zGvJYVxxe+lmstAbv2yu
X-Google-Smtp-Source: AGHT+IHjwhwwuXxzySVXfAxcI58SUnlV21SyaUZ+nDdDuc0whHsbOZx8lyOPZc1YaHV4IVdTBykIntF3tZCQ0xFsirc=
X-Received: by 2002:a17:907:9413:b0:a9a:1f8:6c9b with SMTP id
 a640c23a62f3a-a9de5fe7455mr2360706366b.37.1730475171331; Fri, 01 Nov 2024
 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241101152614.238747-1-sjg@chromium.org>
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:32:35 +0100
Message-ID: <CAFLszTgTX+SSqdJq3ASK4aeciSXrh_YAtYgrKFQYGU-LJABj=Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] efi: Add a test for EFI bootmeth
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Yang Xiwen <forbidden405@outlook.com>
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

Hi all,

On Fri, 1 Nov 2024 at 16:26, Simon Glass <sjg@chromium.org> wrote:
>
> The test coverage for the EFI bootmeth is incomplete since it does not
> actually boot the application.
>
> This series creates a simple test for this purpose. It includes a few
> patches to make this work:
>
> - Revert of an unreviewed patch to change the sandbox efi filename
> - Hang in sandbox virtio due to EFI probing all block devices
>
> Other necessary fixes have already been applied.
>
> Changes in v10:
> - Drop call to exit-boot-services
>
> Changes in v9:
> - Update license
> - Fix 'sevices' typo
> - Move the function into efi_helper.c
> - Split out into a separate change
> - Split out into its own patch
> - Separate into separate patches
> - Add new patch to drop sandbox PXE architecture
> - Mark the image as complete after writing it
> - Fix 'sevices' typo
>
> Changes in v8:
> - Add new patch to control on-host behaviour
> - Add new patch to move default filename to a function
> - Add new patch to report host default-filename in native mode
> - Add new patch to report host default-filename in native mode
>
> Changes in v7:
> - Update commit message
> - Drop patches already applied
> - Drop patch 'Disable ANSI output for tests'
> - Rebase on -master
>
> Changes in v6:
> - Drop the patch to disable sandbox virtio blk with EFI
> - Add new patch to disable the sandbox virtio blk device
> - Deal with sandbox CONFIG_LOGF_FUNC
> - Rebase on -next
> - Drop patches previously applied
> - Drop mention of helloworld since it is no-longer used by this test
>
> Changes in v4:
> - Add efi_loader tag to some patches
> - Split out non-EFI patches into a different series
>
> Changes in v2:
> - Add many new patches to resolve all the outstanding test issues
>
> Simon Glass (11):
>   test: boot: Update bootflow_iter() for console checking
>   efi_loader: Add a test app
>   sandbox: Add a -N flag to control on-host behaviour
>   efi: Move default filename to a function
>   efi_loader: Move get_efi_pxe_arch() to efi_helper
>   efi_loader: Allow reporting the host defaults
>   sandbox: Report host default-filename in native mode
>   efi_loader: Drop sandbox PXE architecture
>   sandbox: virtio: Disable the sandbox virtio blk device
>   test: efi: boot: Set up an image suitable for EFI testing
>   test: efi: boot: Add a test for the efi bootmeth
>
>  arch/Kconfig                        |   3 +-
>  arch/sandbox/cpu/start.c            |  10 ++++
>  arch/sandbox/dts/test.dts           |   2 +-
>  arch/sandbox/include/asm/state.h    |   1 +
>  boot/bootmeth_efi.c                 |  29 ++----------
>  cmd/efidebug.c                      |  25 ++++++++++
>  include/efi.h                       |  34 +++++++++++++
>  include/efi_default_filename.h      |  56 ----------------------
>  lib/efi_loader/Kconfig              |  10 ++++
>  lib/efi_loader/Makefile             |   1 +
>  lib/efi_loader/efi_bootmgr.c        |  10 ++--
>  lib/efi_loader/efi_helper.c         |  71 ++++++++++++++++++++++++++++
>  lib/efi_loader/testapp.c            |  64 +++++++++++++++++++++++++
>  test/boot/bootdev.c                 |  18 ++++++-
>  test/boot/bootflow.c                |  67 ++++++++++++++++++++++++--
>  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4924 bytes
>  test/py/tests/test_ut.py            |  53 ++++++++++++++++++---
>  17 files changed, 356 insertions(+), 98 deletions(-)
>  delete mode 100644 include/efi_default_filename.h
>  create mode 100644 lib/efi_loader/testapp.c
>  create mode 100644 test/py/tests/bootstd/flash1.img.xz

I hope this series can meet with approval and go in. I know it isn't
perfect, but we can then work on things from there. The first thing is
to drop the various .xz files, which I'll look at once this lands.

Regards,
Simon
