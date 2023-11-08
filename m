Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A05BC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E7AF8762A;
	Wed,  8 Nov 2023 05:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="URvCcOwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0660287535; Wed,  8 Nov 2023 05:23:51 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130F08762A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo10672065a12.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417426; x=1700022226; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8dY4t7KFZ7P0ZfVvvEfCNpLnv3a8Kf5rRmGki3o+uKY=;
 b=URvCcOwZ8l5eUnsPQToZwySguJC9zMVZxkW5Rt0Zb8l+6lvauIQSqnNaA7rYZSPM4a
 WZW8SK0i3XrBTCaeWAEWAsfG6qrxHfbBG2mOi9llX1HHCP6nQrCLx2ID09YKUno+CTi3
 UpHwQb/EXu9fetaeLAJvj1tGyHOn1fd9yvQeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417426; x=1700022226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dY4t7KFZ7P0ZfVvvEfCNpLnv3a8Kf5rRmGki3o+uKY=;
 b=HuAtvwBpymDLtJxy29pHgMpKLSBqZbgsA1ZI2FaHk/fXhksIqqxFX7sZ/QT7VjpDnK
 fWq0ld9tvF1kQHQeA/UrUD1W/MGpPGjE3Ulp5/L63d1B06elUEJDlyeiY24z7OUkXyoP
 anTVsU02krWncltwMQDJgjnrVHln2r+SKop+nGY06b5OlLRfF8DU2mhZNwe2UC8ihz1L
 0Q/lDrC4AUpY2emIDuAdl2SQhhxl3Cxo4F46xse/vLVqh/2rh0wowU+OiQvSNBZAm05L
 O0F9StxLUaXzgNLVXxibfUZBxEe48sIsRJNpq0O2i9yCpnqRIL+D23N989+wJgo3Sx6w
 Vk0w==
X-Gm-Message-State: AOJu0Yx1iD3aUEfK0f/xd7wwl7EWOWhkjNzfOCbZ3ML75Orv7p/rWBMF
 YMOiqCPdGiUmZtr8TOvRuKHG0iMx34M+Bbv6b3LTwQ==
X-Google-Smtp-Source: AGHT+IE5pjn95WoeejmJhXShxrc4s/f2GKcOpTmFjbJIUlAzvHVD31rjPOyD25Y1mbZVhLzDm+/W6eSXvR06Sb7rPpw=
X-Received: by 2002:a50:d081:0:b0:544:b0f4:f13 with SMTP id
 v1-20020a50d081000000b00544b0f40f13mr500278edd.23.1699417426459; Tue, 07 Nov
 2023 20:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-11-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-11-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:33 -0700
Message-ID: <CAPnjgZ2ym0Nniq1aCjop14ZAn=T7XatwkvD1itXHR2d85p_=1w@mail.gmail.com>
Subject: Re: [PATCH v6 10/25] spl: Only support bl_len when we have to
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> Aligning addresses and sizes causes overhead which is unnecessary when we
> are not loading from block devices. Remove bl_len when it is not needed.
>
> For example, on iot2050 we save 144 bytes with this patch (once the rest of
> this series is applied):
>
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-144 (-144)
> Function                                     old     new   delta
> spl_load_simple_fit                          920     904     -16
> load_simple_fit                              496     444     -52
> spl_spi_load_image                           384     308     -76
> Total: Before=87431, After=87287, chg -0.16%
>
> We use panic() instead of BUILD_BUG_ON in spl_set_bl_len because we still
> need to be able to compile it for things like mmc_load_image_raw_sector,
> even if that function will not be used.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  arch/arm/mach-imx/spl_imx_romapi.c  |  8 ++++----
>  arch/arm/mach-sunxi/spl_spi_sunxi.c |  2 +-
>  common/spl/Kconfig                  | 14 +++++++++++++-
>  common/spl/spl_blk_fs.c             |  2 +-
>  common/spl/spl_fat.c                |  2 +-
>  common/spl/spl_fit.c                |  6 +++---
>  common/spl/spl_imx_container.c      | 10 +++++-----
>  common/spl/spl_legacy.c             |  4 ++--
>  common/spl/spl_mmc.c                |  4 ++--
>  common/spl/spl_nand.c               |  6 +++---
>  common/spl/spl_net.c                |  2 +-
>  common/spl/spl_nor.c                |  8 ++++----
>  common/spl/spl_ram.c                |  2 +-
>  common/spl/spl_semihosting.c        |  2 +-
>  common/spl/spl_spi.c                |  4 ++--
>  common/spl/spl_ymodem.c             |  2 +-
>  drivers/usb/gadget/f_sdp.c          |  4 ++--
>  include/spl.h                       | 25 +++++++++++++++++++++++++
>  test/image/Kconfig                  |  1 +
>  test/image/spl_load.c               |  9 ++++-----
>  test/image/spl_load_os.c            |  2 +-
>  21 files changed, 78 insertions(+), 41 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
