Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3437FC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4B988511;
	Sat, 13 Jul 2024 09:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QHjoA96k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB2DD885F1; Sat, 13 Jul 2024 09:51:42 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AF38850A
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c651c521f2so1418855eaf.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720857099; x=1721461899; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zSx+xCRRVbQ42S/J7nZklNJuMZipTpXdjf4cApV8kI=;
 b=QHjoA96kp/UpgNorLnDLTqKx/13FaOU2Lt9GHmJoldXvcQGzoTt4VFnk0pMDNpyUL6
 3t9SMwRy9XBfOkKFq/FNYdK0fBfRU/hYDKi2skydbvU9sRgMzeJC6mCUjmARCMmguaia
 JB5Adw1NkZFMXcRifbq76FNpYSarklGjpocGRPAXS6Xg5V9QRhlXCdQxCs6mGeocRRrL
 KLviCqSxRRPraF9FAoNOkMw8qXvWN/04duNvF2jCpJoc/qeVZLLzTYXZIXlTBow+hH5Z
 xstuC1Uzi0e6zkL+bhuD4NQryxaS700QFleq0X+77+X0poverqskS2lWaP3Xzd8QS9TR
 21Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720857099; x=1721461899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zSx+xCRRVbQ42S/J7nZklNJuMZipTpXdjf4cApV8kI=;
 b=Yz5A/SRWZviaBvQWxjgJTN+T6vHtEym9ZHZu1yWwYn7/szNHOwdFBo3Q+O2SqGxtUY
 VmPorZiosE64osuZ7eDk/zuO908K4mDAlWmf62YNVhn0UJrI1Hg+LXVep/4rZHTCmsU9
 ZN943pj4Cdks71iv01cqimMZw1N6Jxco7Xb9tgUXu6kCqzoj6Z0Xy/82sI41xRtMGCDs
 enSXodNcn9f+mdmzxKp8xegNcKjzRV+Qq1ShFm8UazFbRvv7fCRy6a1M9e/AvOeRRQjT
 uImG5ComMhlYdVdziKUzM93fx3jyFMAQw3SyFp0vW0dQjCldbFOhMzp2EZ4LJeWqgGwI
 OmWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdInAU9EZUXFmaDwGZsk7SF/CpNkQr3d5sQj7fQ/jCscBlMw3fowarsYp5vsMhC12ZPEyAhSLWQkZyjpeg5unN6EXZQQ==
X-Gm-Message-State: AOJu0YzagUqphZghvdflGt+Fz2RXz/9/FN7DOELZQ3nWQvXhMXeyvXf4
 nYAABRAMNG8GjtLyliRI+Ob2RXR/R5ttEIp63mIw/2fFUNq+zijlV6xyX+tUH9PRCimOwJW1I1L
 5ZTgFjCf7ZtYn3wL6SBWKYKEENo0=
X-Google-Smtp-Source: AGHT+IEM5E0i1YYJChkTJWtT4OjcHAx8IZovZg/21Yu6VnWRU/vKlxdyAVplxffEfRiX5Ni7CxXc9InKjH5XFGAg7QM=
X-Received: by 2002:a05:6820:2914:b0:5ce:d2e3:b18 with SMTP id
 006d021491bc7-5ced2e30d42mr359116eaf.8.1720857099146; Sat, 13 Jul 2024
 00:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240626151522.83561-1-linux.amoon@gmail.com>
 <CAPLW+4kqcLVFxxdGL8V66TquKEtPz0VX7NyejAYS=reJmjJWEQ@mail.gmail.com>
In-Reply-To: <CAPLW+4kqcLVFxxdGL8V66TquKEtPz0VX7NyejAYS=reJmjJWEQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 13 Jul 2024 13:21:23 +0530
Message-ID: <CANAwSgT3nEwKytX-6D3YSWvEu8G=PxAk-SCp8YBaNf+SFjCywA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dm: exynos: Correct CONFIG_SYS_BOARD setting for
 Odroid XU3 boards
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 --Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi All,

On Wed, 26 Jun 2024 at 21:07, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Wed, Jun 26, 2024 at 10:15=E2=80=AFAM Anand Moon <linux.amoon@gmail.co=
m> wrote:
> >
> > Fix the issue where CONFIG_SYS_BOARD was incorrectly set on
> > Odroid XU3 boards, causing boot failure. This was resolved by
> > correcting the SYS_BOARD entry in Kconfig to load the correct
> > device tree source (dts) for the Odroid Exynos5422 Platforms.
> >
> > Fixes: f76750d11133 ("Convert CONFIG_CONS_INDEX et al to Kconfig")
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > U-Boot 2024.07-rc5-00042-g80a111f426 (Jun 26 2024 - 15:03:09 +0530) for=
 ODROID-XU3/XU4/HC1/HC2
> >
> > CPU:   Exynos5422 @ 800 MHz
> > DRAM:  2 GiB
> > Core:  74 devices, 12 uclasses, devicetree: separate
> > MMC:   mmc@12200000: 0, mmc@12220000: 2
> > Loading Environment from MMC... Reading from MMC(2)... *** Warning - ba=
d CRC, using default environment
> >
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Model: Odroid XU3/XU4/HC1/HC2 based on Exynos5422
> > Type:  xu4
> > Boot device: MMC(2)
> > Net:   No ethernet found.
> > Hit any key to stop autoboot:  0
> > switch to partitions #0, OK
> > mmc2 is current device
> > Scanning mmc 2:1...
> > Found U-Boot script /boot/boot.scr
> > 2046 bytes read in 22 ms (90.8 KiB/s)
> > 8104280 bytes read in 519 ms (14.9 MiB/s)
> > Failed to load '/boot/dtbs/exynos5422-smdk5420xu4.dtb'
> > SCRIPT FAILED: continuing...
> > No EFI system partition
> > No EFI system partition
> > Failed to persist EFI variables
> > No EFI system partition
> > Failed to persist EFI variables
> > No EFI system partition
> > Failed to persist EFI variables
> > Loading Boot0000 'mmc 2' failed
> > EFI boot manager: Cannot load any image
> > MMC Device 1 not found
> > no mmc device at slot 1
> > ---
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>
Thanks

Gentle ping?

Thanks
-Anand
