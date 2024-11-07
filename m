Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CDDD4335D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36297892AB;
	Thu,  7 Nov 2024 14:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGBycB/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC816892CF; Thu,  7 Nov 2024 14:45:50 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B4B189248
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ee020ec76dso783108a12.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 05:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730987146; x=1731591946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cOf2vEm9eJHPc0Zl49Q46DWSk7ExrZR/u/AALP3yScA=;
 b=cGBycB/JETAF2busB38fOTkGk5VwTVz0lJnoxiB86Kg8dDq6mS2XcWJIgB28YZrGVz
 1DfoqzDzj2CQPZogdabZz4DDBL85P2EEVtOuv6pBL2YprWKv+jOSm2VKq54o2evNNOs9
 kKY5hxqoXkIAxxrg1m48hi3jVVhqM7rPYqK4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987146; x=1731591946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cOf2vEm9eJHPc0Zl49Q46DWSk7ExrZR/u/AALP3yScA=;
 b=e1hKvpgEcYcf6E+iPENUwtX/A+FT6GcGQ44ybdterQMZn4JL7lLxbrUYQVBkwC2Iga
 vel/JMi1Z+NgOM7WGPzZ+doFV3tzDsLhIugSq78+FZy7Ng7hN85I6+w2iFiojKIfg36n
 Z153gwK7Z0rZS3MWpu5eTEyC+Cc4xkDZdwj8lOm69+wKteytuR7xyje7JIB23Ykr4TPI
 kOdlK8t+TwdD1PEM1U0CQhHthD3EqIT0MRXUaTfxPZbHBD9adWYR6mJcttkmYueFTYj/
 dNf/KHAptGmWammSKouL0IE734Y6FAqi82ZT4Z9TquP/Nud39rmi0E+LMgItiPnp7spa
 QuvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX+orqNwj5X1UduXfIGhXYWpuV6oBFgCr11GA5f0SnWI9CZqE1emV3x+KQu6V2Q4m2NglYpqo=@lists.denx.de
X-Gm-Message-State: AOJu0YyWzcQWvhw3qyGU+VymEGmsxpGOespLh1WFcGiZFHpYgL0oIWmm
 FWfpcjtiVk05hSikyliVeQAEavO2waWp6NdFuSEZtEoXJkqErRJeZ6VL03ocr3DhmtZc73xGxWF
 W1RGu1/7gzJLxCm3w7QkSFsCYciZcZmKufH12
X-Google-Smtp-Source: AGHT+IGnHgAUZPPKaA+DnPI+lpM5fYSsXL65S9eH3V1u5X41Yv1IU0y+sFXPoq/hJP8rttr7Zfqjb0rWI+k500Umt8o=
X-Received: by 2002:a05:6a20:12ca:b0:1db:f057:151d with SMTP id
 adf61e73a8af0-1dbf057154emr16920917637.35.1730987146631; Thu, 07 Nov 2024
 05:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20241101152614.238747-1-sjg@chromium.org>
 <CAFLszTgTX+SSqdJq3ASK4aeciSXrh_YAtYgrKFQYGU-LJABj=Q@mail.gmail.com>
 <bf63e626-0ffa-41a6-b464-9aa3fa3c9cf4@gmx.de>
In-Reply-To: <bf63e626-0ffa-41a6-b464-9aa3fa3c9cf4@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Nov 2024 06:44:42 -0700
Message-ID: <CAFLszTi1PMQwn3RatxAdaD=w+-6UZVp53G=cR+YRUOy_e9d2=Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] efi: Add a test for EFI bootmeth
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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
 Yang Xiwen <forbidden405@outlook.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 7 Nov 2024 at 04:29, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/1/24 16:32, Simon Glass wrote:
> > Hi all,
> >
> > On Fri, 1 Nov 2024 at 16:26, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> The test coverage for the EFI bootmeth is incomplete since it does not
> >> actually boot the application.
> >>
> >> This series creates a simple test for this purpose. It includes a few
> >> patches to make this work:
> >>
> >> - Revert of an unreviewed patch to change the sandbox efi filename
> >> - Hang in sandbox virtio due to EFI probing all block devices
> >>
> >> Other necessary fixes have already been applied.
> >>
> >> Changes in v10:
> >> - Drop call to exit-boot-services
> >>
> >> Changes in v9:
> >> - Update license
> >> - Fix 'sevices' typo
> >> - Move the function into efi_helper.c
> >> - Split out into a separate change
> >> - Split out into its own patch
> >> - Separate into separate patches
> >> - Add new patch to drop sandbox PXE architecture
> >> - Mark the image as complete after writing it
> >> - Fix 'sevices' typo
> >>
> >> Changes in v8:
> >> - Add new patch to control on-host behaviour
> >> - Add new patch to move default filename to a function
> >> - Add new patch to report host default-filename in native mode
> >> - Add new patch to report host default-filename in native mode
> >>
> >> Changes in v7:
> >> - Update commit message
> >> - Drop patches already applied
> >> - Drop patch 'Disable ANSI output for tests'
> >> - Rebase on -master
> >>
> >> Changes in v6:
> >> - Drop the patch to disable sandbox virtio blk with EFI
> >> - Add new patch to disable the sandbox virtio blk device
> >> - Deal with sandbox CONFIG_LOGF_FUNC
> >> - Rebase on -next
> >> - Drop patches previously applied
> >> - Drop mention of helloworld since it is no-longer used by this test
> >>
> >> Changes in v4:
> >> - Add efi_loader tag to some patches
> >> - Split out non-EFI patches into a different series
> >>
> >> Changes in v2:
> >> - Add many new patches to resolve all the outstanding test issues
> >>
> >> Simon Glass (11):
> >>    test: boot: Update bootflow_iter() for console checking
> >>    efi_loader: Add a test app
> >>    sandbox: Add a -N flag to control on-host behaviour
> >>    efi: Move default filename to a function
> >>    efi_loader: Move get_efi_pxe_arch() to efi_helper
> >>    efi_loader: Allow reporting the host defaults
> >>    sandbox: Report host default-filename in native mode
> >>    efi_loader: Drop sandbox PXE architecture
> >>    sandbox: virtio: Disable the sandbox virtio blk device
> >>    test: efi: boot: Set up an image suitable for EFI testing
> >>    test: efi: boot: Add a test for the efi bootmeth
> >>
> >>   arch/Kconfig                        |   3 +-
> >>   arch/sandbox/cpu/start.c            |  10 ++++
> >>   arch/sandbox/dts/test.dts           |   2 +-
> >>   arch/sandbox/include/asm/state.h    |   1 +
> >>   boot/bootmeth_efi.c                 |  29 ++----------
> >>   cmd/efidebug.c                      |  25 ++++++++++
> >>   include/efi.h                       |  34 +++++++++++++
> >>   include/efi_default_filename.h      |  56 ----------------------
> >>   lib/efi_loader/Kconfig              |  10 ++++
> >>   lib/efi_loader/Makefile             |   1 +
> >>   lib/efi_loader/efi_bootmgr.c        |  10 ++--
> >>   lib/efi_loader/efi_helper.c         |  71 ++++++++++++++++++++++++++++
> >>   lib/efi_loader/testapp.c            |  64 +++++++++++++++++++++++++
> >>   test/boot/bootdev.c                 |  18 ++++++-
> >>   test/boot/bootflow.c                |  67 ++++++++++++++++++++++++--
> >>   test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4924 bytes
> >>   test/py/tests/test_ut.py            |  53 ++++++++++++++++++---
> >>   17 files changed, 356 insertions(+), 98 deletions(-)
> >>   delete mode 100644 include/efi_default_filename.h
> >>   create mode 100644 lib/efi_loader/testapp.c
> >>   create mode 100644 test/py/tests/bootstd/flash1.img.xz
> >
> > I hope this series can meet with approval and go in. I know it isn't
> > perfect, but we can then work on things from there. The first thing is
> > to drop the various .xz files, which I'll look at once this lands.
> >
> > Regards,
> > Simon
>
> I tried to apply the series. But it fails in the CI.
>
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/941546

OK, thanks. The passing run was at [1] but I'll rebase and send a v10.
I suspect there is a test-ordering issue.

Regards,
Simon

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/23126
