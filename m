Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C08D0C5FB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C41E88F94;
	Fri, 25 Oct 2024 13:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H+DWBiBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E90888DFE; Fri, 25 Oct 2024 13:19:40 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A3688ED2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71ec12160f6so1339242b3a.3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729855163; x=1730459963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GpPOp7UslCyv38dK/QwFCNlQhTiyBiudV5Cjfj0cGAs=;
 b=H+DWBiBwQvacT+f8Gla97d/wqTY/25y7RWorWHG2/A4QzrkKvJv9lZ/wXI0O10VDGJ
 vej/+9rVllUlr1j6imEl+1nInx5BXKkD8WLR3mJRGLl7ErZdXv+urJB5rhY45MI5dPyc
 gq8u1Ypz3PcprTSFo5dg9wO92fsy1A5enY2qdSsJ3iRWPDlK3FmK7p5VRPzCdHGF1+tB
 4HVftqMbmACXrnyE4+bzxknhQFSC2wqjOYP8o6azcopz4OjSHoQD7Ftht0igfu4gzSJc
 4ftOwhOazStJQ2iVehU127AC+VuOXDnJVP3EqR034npR3RAUBa7NlolIG9ZsFkeXr+67
 2B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855163; x=1730459963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GpPOp7UslCyv38dK/QwFCNlQhTiyBiudV5Cjfj0cGAs=;
 b=V3quuDgG052N0ML/0WvfXzYHWczmEJHZ7e2CoBglMGbebUIA1FuaC5jLz7mBgOR2Mb
 hxk88na2MDmLUULvZbJs68Q+1AhijK0YUQInjVAFxJYpCBaMnb1sZPlwwGULPhUGpOtk
 ghAvHyw7g0bzjnn8ugJIWZZ4X+J0kcLZ5lfDUqtGMKbb4gHDFxqjEtAKP7nlNgADS1ON
 Z0t1kHXon5QhH1WeVVo8EEkq2HwzJhuxWHce+qEpBPYjUqrXB2wkL1eSDMOMlgDZLkpO
 kR+OuQ+f8Irye/TpYIXo8UBuHLAkPdr7zMC6yu9EwMBwbElzvXqqGpv8pjF46WDBj/jT
 LNjQ==
X-Gm-Message-State: AOJu0YxuJNTSyDYnP0ylzLg+AoXsSc5DfJiGGwYm4oqNut8suzfpGFgx
 94fxbk/9s3xDlGv+CiiUQGFtuAAOBVsqsnNYIDCN61n6IRt4SmV86ydhPURRAZOHrrOROmzebGB
 aib3aePqDK4ngcYkfBvNriuOlnS122Sgz4tdYgg==
X-Google-Smtp-Source: AGHT+IEpUhs002EhtWWpFJMmmnb1peBXy9FICwfVXZmiv54Ar2tyx+2zIT3Pw3VCU1bq72bE96fZtJodcVlHbRwuO9Y=
X-Received: by 2002:a05:6a00:39a8:b0:71e:cc7:c511 with SMTP id
 d2e1a72fcca58-72045fa4418mr7190942b3a.23.1729855163555; Fri, 25 Oct 2024
 04:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
In-Reply-To: <20241025111411.165904-1-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 14:18:47 +0300
Message-ID: <CAC_iWjL1R2D=vcOzTn=snNf8GfWT80JCET8vB-+nAvS8J=PPvA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add pmem node for preserving distro ISO's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>
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

+CC Anton

On Fri, 25 Oct 2024 at 14:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
>
>
> Ilias Apalodimas (2):
>   efi_loader: add a function to remove memory from the EFI map
>   efi_loader: preserve installer images in pmem
>
> Masahisa Kojima (1):
>   fdt: add support for adding pmem nodes
>
> Sughosh Ganu (1):
>   efi: add helper functions to insert pmem node for DT fixup
>
>  boot/fdt_support.c           | 41 +++++++++++++++++++++++++++--
>  boot/image-fdt.c             |  9 +++++++
>  include/efi_loader.h         | 28 +++++++++++++++++---
>  include/fdt_support.h        | 13 +++++++++
>  lib/efi_loader/efi_bootmgr.c | 43 ++++++++++++++++++++++++++----
>  lib/efi_loader/efi_helper.c  | 12 +++++++++
>  lib/efi_loader/efi_memory.c  | 51 +++++++++++++++++++++++++++---------
>  lib/lmb.c                    |  4 +--
>  8 files changed, 175 insertions(+), 26 deletions(-)
>
> --
> 2.34.1
>
>
