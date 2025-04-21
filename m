Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF35FC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495B0817C4;
	Mon, 21 Apr 2025 12:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SaEeIYbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A99181F0D; Mon, 21 Apr 2025 12:10:43 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3514F810F4
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f4d6d6aaabso5359283a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745230241; x=1745835041; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hUe6OsJWoqd6FY0vkWTtfOflOzqVT7VdEhQB1ev0AZQ=;
 b=SaEeIYbuPfDofazTlIV8of4dfTZCfDRHdSKLmEjNVWJllJhStxqM7JEcGxfQhMRLRs
 FgAdskiJNpMN6DvUo7kqDpSLLs+mB6kVY+aYRlZpxJM8ZZB96APyx5wXeEiwKW5/xrUd
 d8ufFN+Ul/1Mt/1KHH4OdGFsNg+Yk/oxGFu49K6lzCjnCTAi23XGnXEB6hY5srsbQb7u
 HbMSpDXvwk0gae/UzEHFZlykSvWowMj1sA8dShbJxdlDaVFvZ1LSPA7YGz0fUzJ0JhtR
 9N902UVCWPT29JpstEj3l+L304BRqduBAUbrc2pcX07kDLgCdSWFLu71mzTvhInE0r6e
 05ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230241; x=1745835041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hUe6OsJWoqd6FY0vkWTtfOflOzqVT7VdEhQB1ev0AZQ=;
 b=IqqvH+TNB7ykSxFMfNhluXFhrORj7lvit5Og0v1KczqDTDF0948HykHOXJWve53D80
 5wpuQaKIqCLjWwN36q89XhnTLMqEJZzbgX+CxTqLa/7YfFy+RUH//SBhuaWDjQ5sk3/+
 tpDefYejvmE6o07rlIijgSWFjlFApThIIrB/cSuiTjNOO750V5pebu6BI7w/2yJLh5aW
 CtexVlOmZYjBqD2VB+NcPRohvYTr5mGY0pqtT8S7094yyR9Vz0ylHrYkw5US6EN86tFt
 Rs23tmdRn3Yo9pX21legddqGejDpieB8vUH2PHQLhrZy3lowkFbqpEIBEeBg2QMvQ5Fb
 uZSw==
X-Gm-Message-State: AOJu0YwZPyY3t05P2Sy7ohbm8G1+gjDd7/K1F0L7SWspCFtBf9tfDYSr
 dmSPp425cf+HhLdeR4Tvk+GhntqSeKKQ9rlslKCFnG0csn62Z3mjPfIlZ6nJM/+vyS0LGhgumE5
 3sI/cBsVZ7XA4V0/LAVSXVdIO4TE=
X-Gm-Gg: ASbGncscvxr0c0JhDciB7Rrl7E5TuGxM2j4Fzl58LH4Bgsh/YvXd0aIpGxFXpvMl1th
 V93T63vqg1G8iIs9xnMtGGgt2ZfjZGks2ffZW+KVBPE3vecKfhpaTBW29kIIKmR0mUbDUCucNoU
 iHGZDUFGL1vBBDM1EZ+Zi/85KB4ii8dtM2jv8RS/IxAt3raEi2NyDKSZas4bxe
X-Google-Smtp-Source: AGHT+IFgvFRqygLx8V3QM9P5G0mcF7ydGjBoS/eGLQ4Y2qUNlhE6lz0Qrk/N8birEThDnkzAwd6bxyHOWiPWFfAHM0c=
X-Received: by 2002:a05:6402:50ce:b0:5de:39fd:b2f5 with SMTP id
 4fb4d7f45d1cf-5f6285185a5mr8352316a12.1.1745230240399; Mon, 21 Apr 2025
 03:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-4-sjg@chromium.org>
In-Reply-To: <20241220003447.2913443-4-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Apr 2025 11:10:29 +0100
X-Gm-Features: ATxdqUE7ul23n3vuwpbIkxzTW1pxirnpDZr-F4CIc6C-emHhuwpfX6fCy9t5agA
Message-ID: <CALeDE9OwrwvVJTROOkL+v37iHAJhKqfRKGJ0Qq4PrYk2KYBBeg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] rpi: Drop fdt_high and initrd_high
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
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

Applied

On Fri, 20 Dec 2024 at 00:35, Simon Glass <sjg@chromium.org> wrote:
>
> These are not needed now since there is a bootm_size setting to keep
> things within the lower part of memory.
>
> Drop them.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch to drop fdt_high and initrd_high
>
>  board/raspberrypi/rpi/rpi.env | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index a327fccc77f..9b9fad82828 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -66,13 +66,6 @@ dfu_alt_info+=zImage fat 0 1
>   */
>  bootm_size=0x20000000
>
> -#ifdef CONFIG_ARM64
> -fdt_high=ffffffffffffffff
> -initrd_high=ffffffffffffffff
> -#else
> -fdt_high=ffffffff
> -initrd_high=ffffffff
> -#endif
>  kernel_addr_r=0x00080000
>  scriptaddr=0x02400000
>  pxefile_addr_r=0x02500000
> --
> 2.34.1
>
