Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C98FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F12848C1;
	Wed, 29 Apr 2026 16:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aPjZoSVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C68848A1; Wed, 29 Apr 2026 16:17:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5055848C0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so2089397566b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472235; cv=none;
 d=google.com; s=arc-20240605;
 b=h76YoGIJ08rfxqEbQuQPsCXTb7CSA4A+C/J5kySNsukrm4LfixE1GRceZq5iMG1MG6
 kE57ZkbGOcmcYvBGOqXjUFRg1sRcd7DRKp1oENEoM6s+9qJVZ9HhcFQlVwDVS/AVPY58
 tvfmFlHudB4bZhYPN+RenN+USzlu5D9e511b6e5bpmpEbtJ/2mgJNQ3jJmMBWaD2DUfp
 VWRxAyEHK8LUhRSsLAOTuwgB2BQn7PN6HjvwrIoSG1RvOgRB7Fmz1kJd360NMAWO2eXp
 74SF7gfuiYc3DZ2YYIMepCOzPeClnQITWSzljUmnFPGEubbkIPbGE6IBV9XXqrPeo+Hy
 YDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jnirWSun7s9YZzs3frfETtKacXRL9VHuCF6IeqnP5NI=;
 fh=FQ2ggemV3oWkRQKn7KPV5Ohm32+M634w9oqGWHJ9TyA=;
 b=PJ4NdTII3XwxKkiW6Lic15ky8565elH0ow3KfCyWjfDu5xG+IH4ISSOM0OWxhXLWDc
 foan3A4TEfouj6A2fyy7/DvM+u8UBYxd64/hkaHg/1wWkUMrSe4ReWQyz6nFsq3tKYse
 0uFKJATJnoM3Ptqxsyw1UyxC0pxePGGpApCtzAeEWL2ZzSjEKb1m/WuFtpWpanIawC9Z
 2KWpx/FgLseWq5OQ43+TaS5J+9fvmugo1GXEt0oYh82VJDZwtGjD6U32mDp+qvq6nifn
 Shku1pu0JSKO9nuMJ6mJgcrYfTM4t4jDXw+1Fq6dVLwVDzkPrjI5PNb3OkBj2G9hMVch
 NGxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472235; x=1778077035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jnirWSun7s9YZzs3frfETtKacXRL9VHuCF6IeqnP5NI=;
 b=aPjZoSVOZ6vUeb27O1J8EpGtA8rPy1fLAlVPBJkPtV+LU5ZCYrPF1dmpYUdWd+xpT6
 C2t5HVbzaSospyBiMVxIGtuB5MjBzeZk7maP9LUYquIq8CM5oBIhplXaVj/GP/Pq/6ob
 h5AjWDzjllyct9wsEb9NXpWhuvMmTFVKvHMCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472235; x=1778077035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnirWSun7s9YZzs3frfETtKacXRL9VHuCF6IeqnP5NI=;
 b=X4SjqNbueDXanV9gZ0mV++rDJ1bib9vUdXddC8GvbZedAMaWz4Rex08I3lxly3f2V6
 jabusduercLfjqj4CXodxOFjrHyP6lJGVH9bOVEP0kWTtonpPcrYvPz1SGvZat9n+xpB
 Zy2M4WYKfTnFfBV6TpLCvMr3HadhWZaHKDWMklC0SuKs7t1eir5FKjW+X9lEvPFUjPMv
 MpTEPfkndO9r/EA650kHPlziuu55w5jOoQ6FwoSwslLZ5Wg3rjk0Teek3vfFmi+iblXC
 2ybQTOqX3u60ED+bGkgD7XAtdDynWXbJC2TD03hXFF0zJNAzMPtIJssFa1R/wVZhBk8l
 bscw==
X-Gm-Message-State: AOJu0YzBmJX0kZdPIMYD8sADvsCb0AGZIB8ILyEbtDLDT0wayxfHqiDd
 vRw/HtFsV7wsrguMW+haK/gELESe3w5NIdeJqTYz8bL2q6uEETrsSo8BunKUKpMxPhYk0eGXjMq
 nQMpup1b0s0rxTF6XNYYkPaFgQm/NKZ872u2SlwRv
X-Gm-Gg: AeBDies7YD9QXjVtIBnTP4i1od/MJ/nrjeBPnySGNHBctfvMnjv8hFXPrzlsmkEdfD6
 eezk0zIxgKJvqPkgC/zV26UMMgJHrhGrHqzA2GRods3jF7ndiW5eDqkmRKEoUP/OE2f9tiJg4fd
 Zt1b3N9ghL/23FbkAW08G5+FG5aAh6+88xYYh7hEvx4FwEfluPzevF8pcFknvg+He3PGOPGtqX4
 pCaBFgP8vI0agxXdXvBVPD/YPOk8lb//DNxh6FhKbSStbSyoojov84L03FDWsRmUJIWnQ/PH4Kj
 K5aWBCwObDxiEcoU
X-Received: by 2002:a17:907:7210:b0:b94:a1d4:ceff with SMTP id
 a640c23a62f3a-bb803d6577amr480644166b.35.1777472235087; Wed, 29 Apr 2026
 07:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776949417.git.jcethrid@gmail.com>
In-Reply-To: <cover.1776949417.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:17:02 -0600
X-Gm-Features: AVHnY4JQ8RmXMD9E3Z04hg5Ra3g6rYg77R5hqEAx3Bp-StwPrr9sZyx4V0IaS94
Message-ID: <CAFLszThGOgq=H_CuVbo1eSV6=XreLwjFbMeDVYRNUWpcGVHAyg@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] sc5xx Environment Cleanup and Fixes
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
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

On Thu, 23 Apr 2026 at 08:25, Caleb Ethridge <jcethrid@gmail.com> wrote:
>
> This series performs a general cleanup of the default U-boot environment
> for sc5xx boards, stemming from the decision to no longer store the
> environment in the SPI flash. The environments for each board have been
> edited to contain the minimum number of commands needed for all supported
> boot modes to avoid confusion, and the default boot command synced to spi
> for all boards that support it. The filesystem for the SPI flash has also
> been changed from jffs2 to ubifs.
>
> A bug with the Ethernet reset line on the sc594 has been fixed, and the
> sc573 has been renamed from the EZKIT to the EZLITE to match the name of the
> publically available board. EZKIT was only used internally before release.
> Preliminary binman support for sc5xx boards has been removed as it was unused
> and full support never added.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> Changes in v5:
> - Updated several commit messages for clarity
> - Corrected load addresses for sc594-ezlite
> - Added sc584-ezkit to USB support
> - Removed now unused Kconfig options including SC5XX_FITIMAGE_OFFSET
>
> Caleb Ethridge (14):
>   configs: sc5xx: Do not store environment in SPI flash
>   mach-sc5xx: Remove update commands from default environment
>   mach-sc5xx: Update boot commands
>   mach-sc5xx: Switch from tftp to wget
>   mach-sc5xx: Add USB boot command
>   mach-sc5xx: Remove preliminary binman support
>   dts: sc594: Fix gige-reset line on EZKIT
>   mach-sc5xx: sc573: Rename EZKIT board to EZLITE
>   mach-sc5xx: Update image load address
>   mach-sc5xx: Update SPI bootargs for ubifs
>   configs: sc5xx: Set default bootcmd to SPI boot
>   arm: sc5xx: Remove SC5XX_LOADADDR
>   arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r
>   mach-sc5xx: Remove unused image offset Kconfig options
>
> Ozan Durgut (1):
>   arm: sc5xx: add missing boot env selectors
>
>  arch/arm/dts/Makefile                         |   2 +-
>  .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |   4 +-
>  arch/arm/dts/sc594-som-ezkit.dts              |   2 +-
>  arch/arm/dts/sc5xx.dtsi                       |  41 -------
>  arch/arm/mach-sc5xx/Kconfig                   |  71 +-----------
>  arch/arm/mach-sc5xx/init/dmcinit.c            |   2 +-
>  board/adi/sc573-ezkit/sc573-ezkit.env         |  17 ---
>  .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |   8 +-
>  .../{sc573-ezkit => sc573-ezlite}/Makefile    |   2 +-
>  .../sc573-ezlite.c}                           |   0
>  board/adi/sc573-ezlite/sc573-ezlite.env       |  16 +++
>  board/adi/sc584-ezkit/sc584-ezkit.env         |   9 +-
>  board/adi/sc589-ezkit/sc589-ezkit.env         |   9 +-
>  board/adi/sc589-mini/sc589-mini.env           |   9 +-
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env |   9 +-
>  .../adi/sc594-som-ezlite/sc594-som-ezlite.env |   8 +-
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env |   9 +-
>  .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  14 ++-
>  ...ezkit_defconfig => sc573-ezlite_defconfig} |   9 +-
>  configs/sc584-ezkit_defconfig                 |  10 +-
>  configs/sc589-ezkit_defconfig                 |  12 +-
>  configs/sc589-mini_defconfig                  |  12 +-
>  configs/sc594-som-ezkit-spl_defconfig         |   7 +-
>  configs/sc594-som-ezlite-spl_defconfig        |   7 +-
>  configs/sc598-som-ezkit-spl_defconfig         |   5 +-
>  configs/sc598-som-ezlite-spl_defconfig        |   5 +-
>  .../arm/adi/adi,sc5xx.yaml                    |   2 +-
>  .../configs/{sc573-ezkit.h => sc573-ezlite.h} |   4 +-
>  include/env/adi/adi_boot.env                  | 104 +++++-------------
>  29 files changed, 106 insertions(+), 303 deletions(-)
>  rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
>  delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
>  rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
>  rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
>  rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
>  create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
>  rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (88%)
>  rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)
>
> --
> 2.34.1
>

This looks good to me. I've given it another look through and made a
few more minor comments.

Regards,
SImon
