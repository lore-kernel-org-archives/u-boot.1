Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ADCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E3D87E55;
	Mon, 18 Dec 2023 16:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DQslZ5rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D369087E49; Mon, 18 Dec 2023 16:02:38 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDD687E08
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbcd7d63789so1401546276.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=766oR2URasjhwKYDCEc3CNi2pu3OFdtRwt4o3ucv09w=;
 b=DQslZ5rgZ8/tIJnVV9zlm+L4GMB0BPqUS5G0bOC7/m3iN/SDZBfE+g3jzUq1FiOg99
 2tht+3TPl+NyUSoAyMUInOCCmwe50+reAverI7yQO3LAFetK4KZVEJ7OHXmSVGZjdO8a
 zxHAxa4eWM529gx3k0sWTuS/dHlOYvyiHjX5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=766oR2URasjhwKYDCEc3CNi2pu3OFdtRwt4o3ucv09w=;
 b=iffYJTCy8Z4AkB5C3T/K4mV07OnJsxJmQuVp9bF1zXm0S7K+j3xM4rsric7uStkstm
 RBhBPxUP7PYdjRyDrXPu35j5e6DFjT7MySNWFwcWrxKiBhU42SpA5QHJD0ZJeyeV7j+o
 7bKVkzeLp9g9TUwlTDydechji9tExaBhjDK2idjSR7LQbnUHSahNPXPeTnVGWFV9AtO5
 li37aoE7UyKfCzSDKigTmYIPENU2wyZvD/FA0ZShhi2kaoCZotW+eZ9vqY1Uy8Z+eU5T
 TVYHkFnqqf8r7s7PkK3tRtBHOb/RORkuGJz681oZNSWpeY3tOgaNdTUWZ82K+pabZNxi
 PnnQ==
X-Gm-Message-State: AOJu0YwtWlPgMGzdlJK3kQW2hqTyJYLXpAO3C9Ob/Q5OmNQU6ZT4U/Ez
 HLagblr/2x5e1r+J6YNJ6Xb/7vwxmup+SiAhtK3v9Q==
X-Google-Smtp-Source: AGHT+IGAyixWMyEf4HC6wGXbZQpdp7usvM1WFL2ncXnTvckGGVYTNClEM9WaYzpA3F8Fd64M2PXWcOsNsdx/ecM8b4c=
X-Received: by 2002:a5b:a:0:b0:dbc:eeb5:f1e2 with SMTP id
 a10-20020a5b000a000000b00dbceeb5f1e2mr2701238ybp.123.1702911752798; 
 Mon, 18 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
In-Reply-To: <20231218023842.281336-1-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:42 -0700
Message-ID: <CAPnjgZ2JsMkZ=6fFOiCPN8Qf0cd7_SYd7vWNUtppsGyCzyf=tQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] cmd: bootefi: refactor the code for bootmgr
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi AKASHI,

On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This patch set is motivated by the discussion[1] regarding
> CONFIG_BOOTEFI_BOOTMGR option.
>
> # It has been partially merged in -next branch. So this version (v3)
> # contains only the remaining commits.
>
> At the end, bootefi.c will be decomposed into two parts, one for
> providing the command itself and one for implementing helper functions.
> EFI_LOADER will now be available without CONFIG_CMDLINE or specifically
> CONFIG_CMD_BOOTEFI if invoked via bootmeth/bootstd.

Great!!

>
> Then, EFI_LOADER library side will be further split into two options
> for fine-grain control:
> CONFIG_EFI_BINARY_EXEC: execute UEFI binaries which are to be explicitly
>     loaded by U-Boot's load commands/functions or other methods
>     (like a jtag debugger?)
>     It supports bootmeth_efi as well as "bootefi <addr>|hello"(/"bootm"?).
>
> CONFIG_EFI_BOOTMGR: provide EFI boot manger functionality
>     It supports bootmeth_efi_mgr as well as "bootefi bootmgr".
>
> As such, We will no longer need CONFIG_EFI_BINARY_EXEC if we want to only
> make use of the UEFI boot manger for booting a next stage OS.
>
> Prerequisite
> ============
> This patch set is based on top of Tom's latest "next" branch.
>
> Tests
> =====
> * run UT efi_selftest on sandbox locally
> * run test_efi_bootmgr on sandbox locally
>
> Unfortunately, I could not submit a pull request for CI test.
>
> Changes
> =======
> v3 (Dec 18, 2023)
> * rebased onto Tom's latest next branch
> * remove already-merged commits
>
> v2 (Nov 21, 2023)
> * rebased onto Tom's next branch
> * remove already merged commits
> * revise commit messages
> * add patch #5 which was split from ex-patch#5
> RFC (Oct 26, 2023)
>
> [1] https://lists.denx.de/pipermail/u-boot/2023-October/534598.html
>
> AKASHI Takahiro (4):
>   efi_loader: split unrelated code from efi_bootmgr.c
>   efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
>   net: tftp: remove explicit efi configuration dependency
>   fs: remove explicit efi configuration dependency
>
>  boot/Kconfig                     |   4 +-
>  boot/Makefile                    |   2 +-
>  cmd/Kconfig                      |  10 +-
>  cmd/efidebug.c                   |   4 +-
>  fs/fs.c                          |   7 +-
>  include/efi_loader.h             |  28 +-
>  lib/efi_loader/Kconfig           |  11 +-
>  lib/efi_loader/Makefile          |   2 +-
>  lib/efi_loader/efi_bootmgr.c     | 493 ------------------------------
>  lib/efi_loader/efi_device_path.c |   3 +-
>  lib/efi_loader/efi_helper.c      | 499 ++++++++++++++++++++++++++++++-
>  net/tftp.c                       |  10 +-
>  test/boot/bootflow.c             |   2 +-
>  13 files changed, 544 insertions(+), 531 deletions(-)
>
> --
> 2.34.1
>

Thanks for doing this work.

Regards,
Simon
