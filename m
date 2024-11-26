Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BC8D5A6F9
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDEF8965F;
	Tue, 26 Nov 2024 09:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBnTOmq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B9689A40; Tue, 26 Nov 2024 09:13:20 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97CFE8965A
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7fbd76941ccso2321934a12.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732608796; x=1733213596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ibR9jmSII6+4WSfKwAFnhgkasFuFaU3XNKfR2u8Ec3g=;
 b=kBnTOmq87TuCn2P0nsbgWiSg7SkUByopI+8ndfMIz/ciX4T6hkxkWQI7CuzYm1Ob0E
 H/XF85Ql+IWAzPpCRtrJPKo2Xf4btqt3fC5U3I0Ye5bCd8vFBFucWAb43AaEJY3zS/8c
 vPZ0CNQN2eEzSoKKoU0g/wZme9GqKYpx/JOUXXO1xui7BvNY7WDoKjyGqKKq5ZKlszZ2
 z1mhZCVMM5mJlDq0lal4HPrgT4JxlbhrJ8oEG3hCuT5Lf3+2Dy+iO817/fJqE0d8r9fq
 D0x9dK66k9gN4hDYngdRAoqMAHfs39haAWv/igyeIPNAowpXPiY+yEHmLAxwte0KQUtA
 D4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608796; x=1733213596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ibR9jmSII6+4WSfKwAFnhgkasFuFaU3XNKfR2u8Ec3g=;
 b=XkzhtVIaR58i58n6SldashrZek5xkU0/ucdjVPcGggPV5jTY3+mnqcP3HP2eewBpyD
 LeK4K/VtHRSIT4dB7OG5dwQizRxtcF8nokT9D+uiRB7ST5oxW6vv1xTZz2ymxqEiQK+M
 v/q4jRqNub65hWquKL44ai+Jay0KCJcM8X/9t0KkfQjNnXLbKTUh8l9EB14GzNV+rSlo
 Uen9ZNa7fgVRcgAuVS5C/CL8MaKlqhFAv13RyElVp8j0URahqvWUcEOr7yC75Fu0s6Rp
 lJzfZU3fAeDhDT24JgUz/HqZqItUGW1bgnb+1kYq8DrQVbjg5lqhk7z2z9J83yx0wP1N
 rruw==
X-Gm-Message-State: AOJu0Yx58UsUfsIoFCqQ5/QUmn49SBEUfgWL5KDfKe6SDa8+/QAZAhvC
 MQNfne14npXsnRiraD2sbq6ZwTKzwx9Z20qTQRZPqx+5kiuhmWfR1gFBghMtL/DrEnVfdloWliz
 SG9y77ABDH1HCrw7whksTsU47Y40Acg+8H0LDKw==
X-Gm-Gg: ASbGncuu0IdzZgHtbabWg9Z3RtSD7GHoyPe2Pz4156gHAqQQSj2ML/2dihEs2gjB8Q8
 KTXY+PmVCRc0gy+9WDf8DNpEceQvFzw==
X-Google-Smtp-Source: AGHT+IHGfscceswFFz0i/iSdIk4QywUH+u0xEGXYVlvfkoMBtiLoiG4LPEP6AjcMN7Fa8XHfVdouO0RuPy70BdWIwQ4=
X-Received: by 2002:a05:6a21:3399:b0:1d9:78c:dcf2 with SMTP id
 adf61e73a8af0-1e09e5ff718mr21693028637.43.1732608796004; Tue, 26 Nov 2024
 00:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 Nov 2024 10:12:39 +0200
Message-ID: <CAC_iWjJif4Q1FYGkQC6fO3bSkxtrYYBkPYagd-Wn1fQf7GV2kg@mail.gmail.com>
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

Hi Simon

Apart from the comments on the other patches, the SCT memory tests
crash with this series. Please run it locally before sending a v2.

Thanks
/Ilias

On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
>
> The EFI-loader implementation converts things back and forth between
> addresses and pointers, with not much consistency in how this is done.
>
> Within most of U-Boot a pointer is a void * and an address is a ulong
>
> This convention is very helpful, since it is obvious in common code as
> to whether you need to call map_sysmem() and friends, or not.
>
> As part of cleaning up the EFI memory-management, I found it almost
> impossible to know in some cases whether something is an address or a
> pointer. I decided to give up on that and come back to it when this is
> resolved.
>
> This series starts applying the normal ulong/void * convention to the
> EFI_loader code, so making things easier to follow.
>
> Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/
>
>
> Simon Glass (13):
>   efi: Define fields in struct efi_mem_desc
>   efi_loader: Convert efi_get_memory_map() to return pointers
>   efi_loader: Show the resulting memory address from an alloc
>   efi_loader: Update startimage_exit self-test to check error
>   efi_loader: Move some memory-function comments to header
>   efi_loader: Use the enum for memory type
>   efi_loader: Make more use of ulong
>   efi_loader: Tidy up use of addresses
>   lmb: Reduce mapmem contortions in lmb_map_update_notify()
>   efi_loader: Simplify efi_dp_from_mem()
>   efi_loader: Tidy up efi_reserve_memory()
>   efi_loader: Drop extra brackets in efi_mem_carve_out()
>   efi_loader: Don't try to add sandbox runtime code
>
>  include/efi.h                                 |  15 ++
>  include/efi_api.h                             |   6 +-
>  include/efi_loader.h                          | 100 +++++--
>  lib/efi_loader/efi_bootbin.c                  |   3 +-
>  lib/efi_loader/efi_bootmgr.c                  |  11 +-
>  lib/efi_loader/efi_boottime.c                 |  51 ++--
>  lib/efi_loader/efi_device_path.c              |  18 +-
>  lib/efi_loader/efi_dt_fixup.c                 |   8 +-
>  lib/efi_loader/efi_helper.c                   |   7 +-
>  lib/efi_loader/efi_image_loader.c             |   2 +-
>  lib/efi_loader/efi_memory.c                   | 246 +++++++-----------
>  lib/efi_loader/efi_var_mem.c                  |   6 +-
>  .../efi_selftest_startimage_exit.c            |   6 +-
>  lib/lmb.c                                     |  10 +-
>  14 files changed, 251 insertions(+), 238 deletions(-)
>
> --
> 2.43.0
>
