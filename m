Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13353C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 11:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AE680780;
	Fri, 24 Jan 2025 12:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wf2U+hme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EBF807E4; Fri, 24 Jan 2025 12:40:25 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E12F80391
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 12:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53537d8feeso3005697276.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 03:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737718821; x=1738323621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2hoX71uztTtkpFBmWbF+W6wYEVIrfunHckA+qWUuILA=;
 b=wf2U+hme4el8iAZc22FIPXMpi6nxZk9dD7WTl+i8KQNp2p9bwTUVUeqwIK8adwT72t
 tzGrY5XKROqBxLqLnw4Dso5yXjK3iISUqGnJb0Ur1b1EbP4sW//ZQvwSqy/S2ueN2fge
 JeS3Y2ojvDWr+HSyL84gh8m4AJpEerJI0J8ODCUY7yFdKicWvfHambu2nCIVo4Yqr42e
 YGCExdRxkUDWVXpBquDSgzHdKn0YNFyvS+dlMueB4OJGuM7cq8ox3ED1ee3MJnDdZ6DL
 EEFFO+lVBAxvHbG7qe7pevfce3uJzy+tWJgEuJv+WA7rdQeFvUEXsPgd0qUiuljV8Bbs
 Exzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737718821; x=1738323621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hoX71uztTtkpFBmWbF+W6wYEVIrfunHckA+qWUuILA=;
 b=jCI3lZHUbIJ9BZfUVp69mOSg/S6nKpdJJxRTXuGJZiOvV120r6Kemxp5kWOghj+ldI
 j8EqTnlh2cnaYwHephRllSzC7Y8gsAk2CHyqoFD43z/R13mGY9FjgmxD2V7D3wYYMLfX
 dYjKEbH6Fo8ctlgJ/4Bx2DFy6KLLi/C56VC+mWPv/qigEP5uZjiSCkBAZAn254MYu0Eb
 WYpJ4MsWwTG1dtLEWdXaFV4pBG2dIUNQKB3ZpsjFBQG/Ocbc/QspLgt12M9qRxzI4nYR
 00QZtxVw1D2By5EV3P3SdWq0sPGJAWxlw76x1NHS76HQTZOafxAGKP22XcbHWpEApBW2
 vlAg==
X-Gm-Message-State: AOJu0YxMhiow/CcpLQlKf0XJRcZSbjMU2i07LloS/g70cO42J7367tBw
 JfkJTSAtUxF41vcS0N9RB4lPbotQT0uaqZpHhdm6a1TOHjCoJKy4YlJG8CNs+3OwmQVD+8WTugA
 8RVqcyRosM3l5d7FFkTu/Mw68YEd5Ub1BzPebBw==
X-Gm-Gg: ASbGncsctU+PTxXoX6LIen17v/G4StZij61xXG6URdP9iG811RMOl/lcwtKalpBNZlp
 qRty3QrhAsNR1xl3n7JmaaM6LXZ9o4vkrHbeb9U6VpL1eXvHrZwbebXdGuJwpp73bU6YRePRN
X-Google-Smtp-Source: AGHT+IEkYyY9S7cSH8f7d1L9eP9I7dJS5By1YROKserjQjypQqA/eIEy5LGa79rcuymBSHLTv2UPZB6a2XfcRexbEC8=
X-Received: by 2002:a05:6902:108a:b0:e57:4b9c:8443 with SMTP id
 3f1490d57ef6-e57b10572e8mr26795787276.12.1737718821317; Fri, 24 Jan 2025
 03:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
In-Reply-To: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 Jan 2025 13:39:45 +0200
X-Gm-Features: AbW1kvYLuo9aibBzzANOCs9G7Act7if9BAhMmqcow_qbg53BJ0cQgtXMIKIqO_I
Message-ID: <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add pmem node for preserving distro ISO's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

Heinrich, Tobias

There's a slight problem that I forgot when commenting v2.

Heinrich's idea of plugging this into blkmap is eventually the right
thing to do.

However, when I started coding this I only added the pmem memory as
'reserved' in the DT hoping that would work.
Unfortunately, this depends on a kernel config option. I've managed to
track down the problem here[0], but I haven't found time to test it
properly and send it upstream.
So for this feature to work reliably we *need* to remove the memory
map we hand over to the OS.

Since using EFI memmap function into the blkmap code makes no sense,
can we perhaps merge v2 (or a variant of it), which only targets EFI,
with an explanation of *why* while I try to sort out the kernel issue?


[0] https://git.linaro.org/people/ilias.apalodimas/net-next.git/commit/?h=main

Thanks
/Ilias

On Mon, 20 Jan 2025 at 12:51, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> When installing a distro via EFI HTTP boot some OS installers expect
> the .iso image to be preserved and treat it as a "CDROM" to install
> packages.
>
> This is problematic in EFI, since U-Boot mounts the image, starts the
> installer, and eventually calls ExitBootServices. At that point the
> image U-Boot mounted disappears. Some distros don't care and download
> the missing packages from a web archive, while others halt the
> installation complaining they can't find certain packages.
>
> If the firmware uses ACPI, this is supported by using NFIT which
> provides NVDIMM ramdisks to the OS and preserves the image.
> We don't have anything in place for Device Trees though. Since DT
> supports persistent memory nodes (pmem) use those and preserve the
> .iso for installers.
>
> The issue can be reproduced by attempting an EFI HTTP boot with Ubuntu
> live server ISO, or a Rocky Linux ISO. The installation would fail
> with the failure to locate certain packages.
>
> The earlier version had aligned the addition of pmem nodes with the
> EFI HTTP boot feature. This has been changed, based on a review
> comment from Heinrich to instead be done by looping through the memory
> based blkmamp devices.
>
> Changes since V2:
> * Fix a checkpatch error for putting a blank line after a function
> * Use blkmap device based scanning for adding the pmem nodes
>
>
>
> Ilias Apalodimas (2):
>   efi_loader: add a function to remove memory from the EFI map
>   efi_loader: preserve installer images in pmem
>
> Masahisa Kojima (1):
>   fdt: add support for adding pmem nodes
>
> Sughosh Ganu (2):
>   blkmap: store type of blkmap device in corresponding structure
>   blkmap: add pmem nodes for blkmap mem mapping devices
>
>  boot/fdt_support.c            |  40 ++++++++++++-
>  boot/image-fdt.c              |   9 +++
>  cmd/blkmap.c                  |  16 ++++--
>  drivers/block/blkmap.c        |  90 +++--------------------------
>  drivers/block/blkmap_helper.c |  47 +++++++++++++++-
>  include/blkmap.h              | 103 +++++++++++++++++++++++++++++++++-
>  include/efi_loader.h          |  11 ++--
>  include/fdt_support.h         |  13 +++++
>  lib/efi_loader/efi_bootmgr.c  |  22 ++++++--
>  lib/efi_loader/efi_memory.c   |  51 ++++++++++++-----
>  lib/lmb.c                     |   4 +-
>  test/dm/blkmap.c              |  16 +++---
>  12 files changed, 302 insertions(+), 120 deletions(-)
>
> --
> 2.34.1
>
>
