Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A095CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996CE846F4;
	Thu, 25 Jun 2026 10:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VLAbPbBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE3E848F0; Thu, 25 Jun 2026 10:53:01 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB348460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c6c57c5bcfso16176085ad.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377577; cv=none;
 d=google.com; s=arc-20260327;
 b=LI2VYsv3x3IfyL/IJDqCsNEOq5BtehxeAS/tCTySLLxyzTuJSPbRQhXRPtdD55+3aO
 G/B/yQt5uYX5wHPvfStyyj3BSfQE46w28AQywLw9Js3kCCWygFtr8a2fOP6Y1YbZqUTp
 wvDeu2z3IqnJ5KPwj4Hys+GG59pbKKWqUIYwNbt224xvfEC64A1kcJD139aDhYFWJZua
 GZc4DOeCAN0jSttUozcOwsFTYcg1CZ1sHKEBLmAFXEje6WKMfNOQcJFHqqQMW0ayK24O
 AKn18LuGl3SwGEZDDDC4BOFDYxBq1tNYTNL+GGMB0WRaQG5/fI0dnF2KkrPYrzUrVGZN
 vhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QRLUI+K1nGkoRKpfxMNFE4hJ4W9Z8JFnknl9tcMFdEU=;
 fh=pr+yJGxR4iMOI8QrSzHWnLQtcISvWxF+voEtoDuJ+Ys=;
 b=k4PjEG1lEk7sqj82yjU/XX8EHdjGz/yAUT2QtDV1Vj31tDYT0XnG5iJlnCl6B8zlAl
 WoNzl4S0+o6QlyVo3xv2HDYZc7MzfKcY+b4/P1QZqPJ0stG+nAuzIyUXPS3YoKNzFqBu
 SMeyYseS0TRiKCyZv8ajHR2o17gE8OwiK8l5W5o3fhzGWcsLDEiHMgWyhKo/bsacfyu8
 wCNzbuOA0Wwr2i/3G+kbsjJXaIwY1WG6a/hnkE3ZI/yOiNI7DKHgrAXz1PfKcEDiiNFe
 e9SOWyXgIsluKG20d2hsVwoJQk6T03WgwIAYpNEWeNuPLwF3sG4MHiDAwTC81bBLpC+i
 6lfA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377577; x=1782982377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QRLUI+K1nGkoRKpfxMNFE4hJ4W9Z8JFnknl9tcMFdEU=;
 b=VLAbPbBZYd0J3bF/S2X6HiXx+35N0lYYd6A802ZdRCDJJcE33WVMifbcn1f4fnx3C3
 jU5IfRnEKcEk1gBDSbBcXsWk164z24dyAGKCv2NSu0jiLQXs1jc0nBuCjfOsJhioq3ns
 VrqpRP14rJ4eO5jYuTiTa4PxYwqllUkNbzw+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377577; x=1782982377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRLUI+K1nGkoRKpfxMNFE4hJ4W9Z8JFnknl9tcMFdEU=;
 b=W2bEK18kibOPcdnhWxbz7bYh52mgD5AO34mLbpkEbJfcTdgCTI9/4kF+jtXTUl+3Ex
 zyEuJj7bXEXd58SlHpu3tKZhRiWOE/OIkG2SSUtbUAhnwzKCHZ+1t/hMGhUNCV7H8eHL
 GnoU5nwzznHHK6JKPiqQFzuThgoke5FNKnuB0Mu2KNTUTftFc23qMfsZZxuRNHAkUqgd
 RmiOnyDiorUeMfL90Ulf6qQFpXqePHtGozKuI9yrOEz6ThpF9gXFi46x61oWNwPQVmN/
 WqTPor4Sa2RGxfiM3cdPtbKP4DSG1mkh0KcEesWb1ECpOi/Yx0qPb7ZwdBbY0fiwKeGs
 pwbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhiCEPac6BFsqzOY4IFBp/acbUzbHWhhAsPbih0ZxpxaSI4qQk29lw9yvjzdryTVx3Mqrlnfk=@lists.denx.de
X-Gm-Message-State: AOJu0YxHrpjZa0cqKRo58hIHMr72dtxMGxaf3+/UqnYDdOQiYvbMn6Zq
 317Hvnqr0MACHSrU0BurI6iz5rGX/gda3n9s4omoo4QopNMssgqbC+ZxW+LNosypOjTwwq/nAgR
 t/4VQF7H9+asZdgOeE5hc9mET4ZxZcFwwX/EJ4BdG
X-Gm-Gg: AfdE7cm+2j2qicXXbjmHtOpETyrywghjsMym/SQ6rFmOdAyp+eOYyeClpIrsUSE7wBM
 Omg9KM+ygK1znrjS3ivj+4npjW3khqYNkaWh2I5tFHDF93DzZvp587Jz7rmuNVyxMxr+IDZKEG0
 ndw7SMzCBXSm8uwZ1Jh+yvMfEI4m6JAXVNw6I/2qBF2xKbOc9zkjflvaJiHtk3T0vGb7qrTYeDs
 UZnF7PZ1U93PPM1K2odWkikqjM+0qxfCnJ2C4pPSPo5VjT71Ut0+PBfmSYZ9DHeFRcLiU4z7Q==
X-Received: by 2002:a17:902:ce87:b0:2c0:bcff:e191 with SMTP id
 d9443c01a7336-2c7fca191a4mr19207575ad.36.1782377577071; Thu, 25 Jun 2026
 01:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:52:19 +0100
X-Gm-Features: AVVi8CemKLcXlMkl5Rsjjkd5I9GxRIOiMaNQLZaHBGGzGY43lhbsjAduwN6zQuk
Message-ID: <CAFLszTiBfFnOvgoSYoj9Vw_hRLXxxm0gE=_HuhYTsGF7ZjuabA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] efi_loader: fix open_file_system() memory leak
 on fallback path
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: fix open_file_system() memory leak on fallback path
>
> In dtbdump.c and smbiosdump.c, open_file_system() falls back to
> locating the UEFI system partition via locate_handle_buffer() when
> the loaded image's own partition does not expose the simple file
> system protocol. The handle buffer returned by locate_handle_buffer()
> must be freed via free_pool().
>
> The guard condition read 'if (handle)' (checking the image handle,
> which is never NULL) instead of 'if (handle_buffer)', so the buffer
> was freed unconditionally even when locate_handle_buffer() was never
> called and handle_buffer remained NULL, and it also obscured the
> intent. Change the condition to 'if (handle_buffer)'.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/efi_loader/dtbdump.c    | 2 +-
>  lib/efi_loader/smbiosdump.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> @@ -350,7 +350,7 @@ open_file_system(struct efi_simple_file_system_protocol **file_system)
>                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>       if (ret != EFI_SUCCESS)
>               error(u"Failed to open simple file system protocol\r\n");
> -     if (handle)
> +     if (handle_buffer)
>               bs->free_pool(handle_buffer);

The fix is right, but the commit message overstates the bug.
locate_handle_buffer() is always called before we reach this
free_pool(), and the success-of-first-open paths return early, so
nothing leaks. The real bug is that when locate_handle_buffer() fails,
handle_buffer stays NULL and we call free_pool(NULL), which is
undefined per the UEFI spec. Please reword the subject and body along
the lines of 'avoid free_pool(NULL) on the fallback path'. The code
change itself is fine.

Regards,
Simon
