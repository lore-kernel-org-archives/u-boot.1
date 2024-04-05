Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A44BCD1284
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 14:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF18088370;
	Fri,  5 Apr 2024 16:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="QYBCs4m/";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="LAjHoa+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A436488370; Fri,  5 Apr 2024 16:46:31 +0200 (CEST)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E84883E0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 16:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1712328381; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=b4ZfNSYTin+yOP0Jwqu5N5sDk6GhoJMY5jse7c6Yfs31IFoBos6KBCL6F4fCIuL+H4
 o0bN+lQRrPQrUpHUQ1kCfYbMcqMXIlMkF79eunL7HjDe8td/Nmw+kpYd54S37QjkJzfi
 7tzByMyFk1wsFl1h2Nv9UmLFl3ML6oF9IdwZiZ4Df4YwG5N6k6zyED3BUY1QdbTmseqt
 HaGDySe0o1epK/oKSfKTVBNWnHyQwBYT3nltiGf2dlkJBUn1BGdw56cGYRG/BKN1crXo
 eSur1WpMsnYkuAoPlBH/i73K7GklhrYQDUylW+z2x1aX/73GlWpCmEQ88vRaZb8mM4DJ
 5t2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712328381;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=t1OU48+pqToF5dZnNx/exDPQylNO0fSk4TW8lQuI454=;
 b=LLGU16/fy1diQg68zIzjAs2FQwYtPLqppIZCvCFK2JpWTsQxd4KVH2kSf1pZchdSxk
 Ptn7hM29McR4AwaKyBEVk8sZGcIdrGCYB/6unAhbV07iAwATYxte4dsfi4Oo4m9PSkaU
 i4QhALAbDeqgvlaqoGxGhH1iVgiUS1s5K+QcIoyp0Cqn9o86Tl0F6HW01xjK14cfFKjr
 SFPUNUOcRNtnVD/AB1K7RkSIRYm7VfrHxe121pMIKRO6gdxQQrQQLKF7vKi8e1LKWmIg
 24Ka8AmId5YjWydk7f6KU4zjplHHrtGloF9dL+Pt77N2HrK/mOdDXfIponDuJewWpbk1
 sGzg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712328381;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=t1OU48+pqToF5dZnNx/exDPQylNO0fSk4TW8lQuI454=;
 b=QYBCs4m/HK3mL8ECirsPSFa6mMw0R9llynQInJQGSLBuhxk96QwOec9iZgQ4XNGXPK
 DGJpK8QrEUOcAyMAlxW7KW3ZPjIfH9Q31j/PV+ZZaEFJWa1rVrV3EfpKRlUYRpehUVYj
 bTP73zcW60PbGAX7f5pJ95iDRsXq5VM616jogcT3/YHVC2h3KZXEjagV1EHoEkp08BQ+
 l+QiPTTRYhS+O2xJ2uwM9W20JfTnP2xpsjwaBVSNCB/kenXlzQ0wTUlwCGbD5EvR27lY
 YPRED6vQZiCHrETY4g9OlYuCVBIZptW2KB1nwFMo/wRF06Uy0HHQJhhYnt/aBFPkBmHM
 8d8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712328381;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=t1OU48+pqToF5dZnNx/exDPQylNO0fSk4TW8lQuI454=;
 b=LAjHoa+MUDlsTR30dWyeAEobjca+lEjnpoyvXFeIQ0MSKKwqXBWkg6VubDJdErsj8g
 +pqofEGS1ZZwZkE/GbBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8piJ1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
 with ESMTPSA id Raf125035EkL7jG
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 5 Apr 2024 16:46:21 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:46:14 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
Subject: Re: [PATCH v3 6/6] board: add support for Schneider HMIBSC board
Message-ID: <ZhAOtg6dmD_rBaO4@gerhold.net>
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
 <20240405090742.4148304-7-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405090742.4148304-7-sumit.garg@linaro.org>
Content-Transfer-Encoding: 7bit
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

On Fri, Apr 05, 2024 at 02:37:42PM +0530, Sumit Garg wrote:
> Support for Schneider Electric HMIBSC. Features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 2GiB RAM
> - 64GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
> 
> Features enabled in U-Boot:
> - RAUC updates
> - Environment protection
> - USB based ethernet adaptors
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I don't think this is a big deal but this patch would be a bit easier to
skim over if you move the (unmodified?) import of the Linux
apq8016-schneider-hmibsc.dts to a separate patch with a clear note in
the commit message

 - where it comes from (link to Linux patch), and
 - that it can be removed again with a future update of the upstream DTs
   in U-Boot (once it is applied upstream at least).

You kind of have that information in the cover letter but I think it
would be good to have it in the commit message.

> ---
>  arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
>  board/schneider/hmibsc/MAINTAINERS        |   6 +
>  configs/hmibsc_defconfig                  |  86 ++++
>  doc/board/index.rst                       |   1 +
>  doc/board/schneider/hmibsc.rst            |  45 ++
>  doc/board/schneider/index.rst             |   9 +
>  include/configs/hmibsc.h                  |  57 +++
>  7 files changed, 695 insertions(+)
>  create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
>  create mode 100644 board/schneider/hmibsc/MAINTAINERS
>  create mode 100644 configs/hmibsc_defconfig
>  create mode 100644 doc/board/schneider/hmibsc.rst
>  create mode 100644 doc/board/schneider/index.rst
>  create mode 100644 include/configs/hmibsc.h
> 
> [...]
> diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
> new file mode 100644
> index 00000000000..66dfa549ce1
> --- /dev/null
> +++ b/include/configs/hmibsc.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Board configuration file for HMIBSC
> + *
> + * (C) Copyright 2024 Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#ifndef __CONFIGS_HMIBSC_H
> +#define __CONFIGS_HMIBSC_H
> +
> +/* PHY needs a longer aneg time */
> +#define PHY_ANEG_TIMEOUT		8000
> +
> +#define HMIBSC_BOOTCOMMAND \
> +	"setenv devtype mmc; setenv devnum 0; " \
> +	"test -n \"${BOOT_ORDER}\" || setenv BOOT_ORDER \"A B\"; " \
> +	"test -n \"${BOOT_A_LEFT}\" || setenv BOOT_A_LEFT 3; " \
> +	"test -n \"${BOOT_B_LEFT}\" || setenv BOOT_B_LEFT 3; " \
> +	"setenv raucslot; " \
> +	"for BOOT_SLOT in \"${BOOT_ORDER}\"; do " \
> +	"  if test \"x${raucslot}\" != \"x\"; then " \
> +	"      echo \"skip remaining slots...\"; " \
> +	"  elif test \"x${BOOT_SLOT}\" = \"xA\"; then " \
> +	"    if test ${BOOT_A_LEFT} -gt 0; then " \
> +	"      setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1; " \
> +	"      echo \"Found valid RAUC slot A\"; " \
> +	"      setenv raucslot \"rauc.slot=A\"; " \
> +	"      setenv raucpart A; setenv distro_bootpart 6;" \
> +	"    fi; " \
> +	"  elif test \"x${BOOT_SLOT}\" = \"xB\"; then " \
> +	"    if test ${BOOT_B_LEFT} -gt 0; then " \
> +	"      setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1; " \
> +	"      echo \"Found valid RAUC slot B\"; " \
> +	"      setenv raucslot \"rauc.slot=B\"; " \
> +	"      setenv raucpart B; setenv distro_bootpart 7;" \
> +	"    fi; " \
> +	"  fi; " \
> +	"done; " \
> +	"if test -n \"${raucslot}\"; then " \
> +	"  setenv bootargs console=ttyMSM1 root=PARTLABEL=rootfs_${raucpart} rw rootwait ${raucslot}; " \
> +	"  saveenv; " \
> +	"else " \
> +	"  echo \"No valid RAUC slot found. Resetting tries to 3\"; " \
> +	"  setenv BOOT_A_LEFT 3; " \
> +	"  setenv BOOT_B_LEFT 3; " \
> +	"  saveenv; " \
> +	"  reset; " \
> +	"fi; " \
> +	"load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm"
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"loadaddr=0x90000000\0" \
> +	"bootcmd="	HMIBSC_BOOTCOMMAND		"\0"
> +

The "text-based environment" [1] is preferred nowadays, i.e. defining
these inside board/schneider/hmibsc/hmibsc.env instead (similar to how
DB410c has its environment defined in
board/qualcomm/dragonboard410c/dragonboard410c.env). This should also
avoid all the crazy escaping to encode it as C string. :D

However, I suspect that right now it would attempt to load this file
from board/qualcomm/hmibsc/hmibsc.env since you do not seem to have
CONFIG_SYS_VENDOR set correctly. It looks like Caleb removed the option
to customize CONFIG_SYS_VENDOR in commit 059d526af312 ("mach-snapdragon:
generalise board support"). It might be easiest to add a prompt in
arch/arm/mach-snapdragon/Kconfig to allow changing it (similar to
CONFIG_SYS_BOARD).

Thanks,
Stephan

[1]: https://docs.u-boot.org/en/latest/usage/environment.html#text-based-environment
