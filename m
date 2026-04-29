Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178BDFF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8D584872;
	Wed, 29 Apr 2026 16:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TdD6H2FG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3194D84874; Wed, 29 Apr 2026 16:08:04 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B1584862
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso17382651a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471681; cv=none;
 d=google.com; s=arc-20240605;
 b=WT9FqeEaaexTmIbV9r8dZ4++amscqXUGGKAp2AHXgIdaokNjVyC8/L66IvDhE8Kzna
 iLD3nbiBPA+BndVc8/Yl0INcU/t3ocY0F/61Cpp6E7X4vCKKb9jyqDm5Hg+RieLdUz+r
 3L1BQCjSQtbTK8j9w4ZcGMtx8fjUqwlVCJlMAeV5lZ2BCfZePSOgI06iK+GeQAb0Q+eM
 auR+3FfOMHyR0i2N4TQ9d6dGr6U+QGDxEHPGhjQfzIzDKSYKCMK0vzI1zofoniFWl8Z3
 oZRatgU06i/pN43irbkOxtmJXUR/s+eWlI1/x0jejKB9vyH46k2R9K5lZTofgA4F6ey9
 5P7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=25ccK4hs2UGZtdteqt6ctH/kCbQdFSIbAh/gfUx+cVQ=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=icFZreE0Eu6nBGvR1JypFy1ZcCnkoDbhWGIG+Wtxmw6VdrLiX1CWWvY0xmqhRHRpt4
 dJjPsbq1VFEdoi2+lY3EkIvYkN6Fc9JzQX106W4j0Ayv6e+HfXzcSV9WQnn/cps2eveY
 bjfsTXh7bVAvLfZ7WeKhrH4BSxTFferppPLKsz5Q8G/0iio6mv/uWXgMV1eLshbmn+6R
 go7t5AYacqQ9H+grnhNjWgnZDoWpfAzSV2gbFLKiHv3BHP2i3+qfqAVlZX12B6gPes9s
 rVEIFaP9n8oQFJYCdqD2eTDqR6HEimCTsRKZtR05di7CV/9ls+H2HCabnPLhOfYtJ4F/
 YIiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471681; x=1778076481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=25ccK4hs2UGZtdteqt6ctH/kCbQdFSIbAh/gfUx+cVQ=;
 b=TdD6H2FG6sqM6zmRvzc3lPcvqlVDwu+gv/vY4oxU0dcjrS4G2lWkAgP5Zw1YXpqvdY
 9BTuEaYco3U6d1ttBLRU0EdZ2GAbeh57cZFpBwAJjjlNrWOXDM3EWHKmkFHfnbfmSVcm
 TAXROH6iuECKYyy/w36YLFsg0+AkRojUjoRng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471681; x=1778076481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25ccK4hs2UGZtdteqt6ctH/kCbQdFSIbAh/gfUx+cVQ=;
 b=Xu4JTiy1JW5l7isQjHHGefv1y6F1qsPCuDysMZ7bI67oysAkjisnleiZuTV/sfgKH9
 +3uDxVAfrcHF6f/nayzjin1duzjJlvWqFL9th6LUmDdOEzR2+de+etz21pnmA/hsnmCI
 cxhaepUxT0JOURdndlrd3zQ+C70XlSXz6f/rFmTt1LUogU2NOP4S6GNOKF4InmFjJOHo
 dKvcWGuK2nPxMBiujDj2d7N/h68HnejWifnvqaTbgy+689kB443Yvl9kqnFdQK1k1Iai
 6QJWMY2x98ZL4QFRrfjpjzTLiFK9B5nFqiRl1EMPDozvkctrqouUsNKP6hLN4JzsfFWm
 ruPw==
X-Gm-Message-State: AOJu0YxnQVI8nqWVcZZCAvGsBSQTnTv6Ta7FxTq1uOkeuqh1Pq2wDXKK
 P9sDQf0GcIDOzDO4uyYv/zG09I6fD61q00itZFikxX1S0gNRXw+z5JbE6hjf9A+Q1bUOMvE0Ka4
 mtsfV+g3B+evgBfBVKHOhS9OkZ7ejAhrOhhWvzf+Y
X-Gm-Gg: AeBDieshVDYnlDV9nOHoEaAvK+WiCX6ebxzvyy3CnVONKvS8IjAHQu3rjVWuVxMZ4//
 KYxajAGG2APlAjIMnBozAyJ6Sqk0Kxygx9prC7jI2PFwds3HgrtoFtqZC+H/msje5OcjyBuO3JJ
 F0QIFyFq4nenEo3DHdITvk+yrZ23G3/zb7FN5xCrG/MnORVTcNc0j20D2UVCChsVQe1PUFkBEE4
 smJV6Xm+Po+zIBXqgUsrNnr0sBp98LGXzRhVIcx1795CFHYhIHPxOyudvOpwG2M/BHlV6LEUDzc
 EEvZXzHURjEv1ARx
X-Received: by 2002:a17:907:84c:b0:ba5:bef2:2aa9 with SMTP id
 a640c23a62f3a-bb804c31c08mr453657366b.35.1777471681535; Wed, 29 Apr 2026
 07:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <7771d2ff3f10bcb9a2453849b51a195f9301bc21.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <7771d2ff3f10bcb9a2453849b51a195f9301bc21.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:07:49 -0600
X-Gm-Features: AVHnY4INJrk1oBFv5Zg6RWUC373na6pgpTVpGVVXtk_G7wuM2gb1YwKflXVpcdM
Message-ID: <CAFLszTgG1+cW+1-uKnkX8w0pY4Y=S=EPwCSxdc-q2BXrEGm9xw@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] mach-sc5xx: Update boot commands
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Update boot commands
>
> Update the default boot commands to match the expected
> bootargs in Linux and new SPI partitioning scheme.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezkit/sc573-ezkit.env           |  2 +-
>  board/adi/sc584-ezkit/sc584-ezkit.env           |  2 +-
>  board/adi/sc589-ezkit/sc589-ezkit.env           |  2 +-
>  board/adi/sc589-mini/sc589-mini.env             |  2 +-
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  2 +-
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  2 +-
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  2 +-
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 +-
>  configs/sc573-ezkit_defconfig                   |  1 -
>  configs/sc584-ezkit_defconfig                   |  1 -
>  configs/sc589-ezkit_defconfig                   |  1 -
>  configs/sc589-mini_defconfig                    |  1 -
>  configs/sc594-som-ezkit-spl_defconfig           |  1 +
>  configs/sc594-som-ezlite-spl_defconfig          |  1 +
>  configs/sc598-som-ezkit-spl_defconfig           |  1 +
>  configs/sc598-som-ezlite-spl_defconfig          |  1 +
>  include/env/adi/adi_boot.env                    | 16 ++++++++++------
>  17 files changed, 22 insertions(+), 18 deletions(-)

> diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
> @@ -74,3 +74,4 @@ CONFIG_SPL_TIMER=y
>  CONFIG_USB=y
>  CONFIG_USB_DWC2=y
>  CONFIG_USB_STORAGE=y
> +CONFIG_SC5XX_LOADADDR=0xA2000000

Adding CONFIG_SC5XX_LOADADDR to the four sc594/sc598 SPL defconfigs
seems like it doesn't relate to "update boot commands" - maybe have
its own patch.

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -40,23 +40,27 @@ nfsboot=run init_ethernet;
>  #if defined(USE_SPI) || defined(USE_OSPI)
> -spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}
> +#if defined(USE_SPI)
> +spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL

Cramming setenv sfdev onto the end of spiargs makes the variable name
confusing - I'm not sure if there is a better way.

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -40,23 +40,27 @@ nfsboot=run init_ethernet;
>  spiboot=run spiargs;
>       sf probe ${sfdev};
> -     sf read ${loadaddr} ${adi_image_offset} ${imagesize};
> +     sf read ${loadaddr} ${adi_image_offset} 0xF00000;
>       bootm ${loadaddr}

Hardcoding 0xf00000 (please use lower case) loses the previous
${imagesize} indirection - please explain in the commit message why a
fixed read length is correct for every board if needed. Also the new
ospiboot is now a verbatim copy of spiboot with only sfdev differing -
previously it was a one-line 'run spiboot'. Don't you want to keep the
de-duplication, e.g. by setting sfdev in ospiboot and then 'run
spiboot' ?

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -40,23 +40,27 @@ nfsboot=run init_ethernet;
> -mmcargs=setenv bootargs root=/dev/mmcblk0p1 rw rootfstype=ext4 rootwait ${adi_bootargs}
> +mmcargs=setenv bootargs root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait ${adi_bootargs}
>  mmcboot=mmc rescan;
> -     ext4load mmc 0:1 ${loadaddr} /boot/${imagefile};
> +     ext4load mmc 0:1 ${loadaddr} /fitImage;

The shift from mmcblk0p1 to mmcblk0p2 silently changes the on-disk
layout assumption - please mention this in the commit message so users
updating from older builds know they need to repartition. Same for
dropping ${imagefile} in favour of a hardcoded /fitImage path.

Regards,
Simon
