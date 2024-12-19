Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221FEE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 11:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826568021D;
	Thu, 19 Dec 2024 12:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oRPTQg4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF658021D; Thu, 19 Dec 2024 12:11:52 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144F3801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 12:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3984b1db09so514847276.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734606709; x=1735211509; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V5SBZzkyIq/kd37euRNUMMztfpDf/PfC0ngJ9O6LLfw=;
 b=oRPTQg4be07zeFSz1fx1cMkUEcu2UYz2HGwm0t530/6z95DSch/1x8hY7PP2UIa2Lz
 cEpOG3YrLDajl6hVc+if2ZYYwGgaPZRth69j8DvNHACNhg9yxHnNZBWkA64cGQF86jab
 BUfoC1d1ZRev45xRmmDKulrKyGFJnfPWNZjgU0JgC3eiuUT/+IhT+QYoIyg/db7iTH8N
 zX9a1JGfcVVU4bNSVN+YDiM7ueEBdpuaGUCBB281TJvbW6wSfpGFPkXosspHbOqgDjEL
 5SgyAka33K5+Eiy6WqRiouxewGIglcIDpe2YlNWuogbPFEjKNiTG5y5v5c1diIijvmmq
 4CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734606709; x=1735211509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5SBZzkyIq/kd37euRNUMMztfpDf/PfC0ngJ9O6LLfw=;
 b=q+n9Sijmzo9CJkO9FyCRZ9niuaEB3JWPxTCPQc7z5r1S7zNqk2tcFSEBoxzRRDnWxJ
 MMhreuC8rD/Hjs93YcHtMShXnwe5h/wOqWR879dBWadq4MjHr4kUvQO79X3UuDZa3ykY
 xj3+LJV82pGqVbqPYSinq7j9HZKy+wnnluW28sG+fOdEOULDuwf55JnGRFNRTrMysCc7
 w93IU7HSrS4PYP10KYPQWBEYOquz+W8FgDVoUf9a7jdpcQhSeJZx5agEMatRpAB57DRG
 8XESI3mj4xspDptrECbmwpyYQQEr0KQUMLbUvAjjlQFUHKx4/Va7QLRtUtEIeYhgNnZM
 bybA==
X-Gm-Message-State: AOJu0YwxFA9bunn5RCYFsDm6l2XsoHHBT8ZN951heV8bb17JCHo/tUp2
 7sG1dDQ4o9o512X0sSDsDElI/c84NE+G808dixYU8ZsydJLGvDSE3l2ZuVf60RbjQjpelvP8c33
 5Fl/fhkRhH/N779RQIZIEyV30NaMNaySXNAht3A==
X-Gm-Gg: ASbGncutFsTX0pxOyUvodA3KWMx5B3Uo2/mJSwGaaVQF6x8Yi/rBVgTZjeE7goV1gAi
 u3P0DOFT5g0eMmkTuRGqs6vaM6lWrD5M9cWORkg==
X-Google-Smtp-Source: AGHT+IExmIONcQBJab6029d7EEzstG62eHw3E+rw+sv5cCK8RpPyPHt8slrgDbC2tc5Ykc6gr42BGGzcDOapT5teBUs=
X-Received: by 2002:a05:6902:1a4a:b0:e4e:4337:68e9 with SMTP id
 3f1490d57ef6-e53764dcc99mr2289711276.4.1734606708859; Thu, 19 Dec 2024
 03:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
In-Reply-To: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Dec 2024 13:11:13 +0200
Message-ID: <CAC_iWjLZ=4RAJuMBbxEZuuM6c61x=grO0T82k=x5P8R0dpXBOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add pmem node for preserving distro ISO's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>
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

Just a ping in case we can move this forward.

Heinrich we've tested with various distros including the generic arm64
poky image and this works fine. The poky image[0] is missing OF_MEM
support, but someone is working to add it already. With a modified
kernel this boots fine including the missing modules this boots to the
login screen [1]

[0] https://www.yoctoproject.org/development/releases/
[1] https://paste.debian.net/1340517/

Thanks
/Ilias

On Tue, 3 Dec 2024 at 18:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
>
> Changes since V1:
> * s/ommit/remove in the commit message
> * s/rfom/from in the commit message
> * Add a period at the end of the sentence in the commit message
> * Use log_err() to print the error message in image_setup_libfdt()
> * Remove "ERROR:" from the error print in image_setup_libfdt()
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
