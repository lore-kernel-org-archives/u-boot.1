Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C5E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FDC489080;
	Sun,  3 Nov 2024 01:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R00veVY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EB988F50; Sun,  3 Nov 2024 01:32:24 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C831889080
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso4204390e87.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730593939; x=1731198739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CiOQUq1yVKkJEvq26zaLOMDermM70fg+ujJ63eftt8A=;
 b=R00veVY0s+M43EsY460dscRDihBDrTs0zvoBz7XGITV4uk4/2NP+9/LJMowtrWzzgw
 YCnhFkayTTM72c//EWe7AXBYXCSRL4dNCb4F81oWEdmRnbEfUMPD5iaNBPzyWxjZI1Uw
 SqvY7YtKL/UDbdkhlVn3t1cIndJlR2w9qkPRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730593939; x=1731198739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiOQUq1yVKkJEvq26zaLOMDermM70fg+ujJ63eftt8A=;
 b=PMYniaA0dY8ggSOWyWXe4JQiLL+xtGqLd34CA8OBx47wUzOxb1Mi0w+2jPjDWt0ZAa
 uOWDJq7G3Sb9HzMzJpeCrwHNTciFKXRkel9+udYYy6puRR+UgWyt/VWlALzuRKKE4DFw
 ZWkVzRI6mKY38QPAkye5U6yCmo6t6B1TZ0isWu2LXZblDt0hdIgwLUZOmsmkOzwKgX4s
 da/Nk/k//OVPwd3ni6FsGk7+zAZhLAfYIMw5xgfBNTXtH6D5qe2fpa1jbUad6G7JGHOY
 kzBWWB+X9H6Xuqjdmy4nRYxsg1Bgen2jW243ohPPExV/ccDC8EC+ENJrqVxRsj4krc30
 /4Vw==
X-Gm-Message-State: AOJu0YzGsU+4J5HxIyB2N89TGsyhL0lUlVtrFi/9z+UQEPwFaZrpC1vw
 8gisXai84SUJiRWefqiFZZ1A/iJul72IN+FCdVAOEmwSY9bsxWe0FB5q9YiblTKbUGyWgEQK6M7
 sygA7MVP93PPhEfT+52WiMLHe3NwWpBBmFwMKJenTujECzQzppA==
X-Google-Smtp-Source: AGHT+IEtlCYv1dbMieNrhsSria+ax7Z0hr56mMDm+sf3kkM/OOz9Fk+aNK5nJDJp9NJyKchjPAElToBYLmBWrTSlLwI=
X-Received: by 2002:a05:6512:124c:b0:539:9ee4:baab with SMTP id
 2adb3069b0e04-53d65df2701mr6005397e87.30.1730593938817; Sat, 02 Nov 2024
 17:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241103002828.624931-1-sjg@chromium.org>
In-Reply-To: <20241103002828.624931-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 18:32:06 -0600
Message-ID: <CAFLszTgC5OLLSViWeN_sK37JGivVt_CyJN2_fWkewqJz9ZqDag@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Adjust initial EFI memory-allocation to be in the
 U-Boot region
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Stefan Roese <sr@denx.de>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi,

On Sat, 2 Nov 2024 at 18:29, Simon Glass <sjg@chromium.org> wrote:
>
> U-Boot relocates itself to the top of memory and is supposed to avoid
> using any memory below that region. This allows the maximum amount of
> memory to be available for loading images.
>
> The lmb subsystem automatically protects U-Boot's code and data from
> being overwritten. It relies on this region being a contiguous area of
> memory. This setup has worked well for at least 15 years and has been
> documented in the README for as long.
>
> The EFI_LOADER subsystem currently uses memory outside the U-Boot region
> when starting up.
>
> Some of the downstream problems this causes are:
>
> 1. It can overwrite images that have been loaded
> 2. Requires lmb reservations to avoid (1) even if EFI_LOADER is not
>    being used
> 3. Uses regions which scripts expect to be available, e.g. the existing
>    kernel_addr_r variables
> 4. Introduces confusion as to what memory U-Boot can use for itself
>
> This series sets up a very small region of memory which EFI can used at
> start-up, thus avoiding touching memory outside the U-Boot region.
>
> There are still a few tables which are not in the bloblist, but that
> will be resolved separately.
>
> Other than tables, the amount of API-visible memory allocated by EFI
> before booting is actually very small: 3 allocations, of a total of
> about 250 bytes. However, there are some areas where EFI allocations are
> done unnecessarily. For example efi_disk_add_dev() uses page-allocation
> to allocate an efi_device_path, then immediately frees it again. In this
> case it would be better to use malloc(). Since each allocation consumes
> a page (4KB), 256KB has been chosen for the size here, enough for 64
> allocations.
>
> As soon as efi_init_obj_list() is called, we know that the EFI subsystem
> is to be used, so we can relax the restrictions and allow EFI to use any
> memory it likes. This is handled using a simple boolean flag in BSS, since
> it cannot happen before relocation.
>
> Changes in v5:
> - Drop the word 'warning'
>
> Changes in v4:
> - Expand the commit message
> - Reword the commit message since this feature is needed
> - Use a different technique to keep the memory-usage in place
> - Drop changes to pool allocation
> - Reorder the patches
> - Rewrite the cover letter
> - Make it a debug message for now
>
> Changes in v3:
> - Add new patch to drop the memset() from efi_alloc()
> - Drop patch to convert device_path allocation to use malloc()
>
> Changes in v2:
> - Drop patch 'Show more information in efi index'
> - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> - Add the word 'warning', use log_warning() and show the end address
>
> Simon Glass (9):
>   kernel: Document ALIGN macros
>   board_f: Correct stack reservation
>   board_f: Rename reserve_stack_aligned()
>   efi: Drop the memset() from efi_alloc()
>   efi: Show the location of the bounce buffer when debugging
>   event: Add a generic way to reserve memory
>   efi: Reserve some memory for initial use
>   efi: Keep early allocations to the U-Boot region
>   wip
>
>  cmd/meminfo.c                     |  7 +++
>  common/board_f.c                  | 15 ++---
>  common/event.c                    |  1 +
>  include/asm-generic/global_data.h | 28 +++++++++
>  include/efi_loader.h              | 33 ++++++++++-
>  include/event.h                   | 11 ++++
>  include/linux/kernel.h            | 31 ++++++++++
>  include/lmb.h                     | 12 ++++
>  lib/efi_loader/efi_bootbin.c      |  9 +++
>  lib/efi_loader/efi_memory.c       | 98 +++++++++++++++++++++++++++++--
>  lib/efi_loader/efi_setup.c        |  5 ++
>  lib/lmb.c                         | 12 ++++
>  test/py/tests/test_event_dump.py  |  1 +
>  13 files changed, 249 insertions(+), 14 deletions(-)

Ignore this, sent by mistake due to my getting confused by a flaky
internet connection.

Regards,
Simon
