Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A95C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 11:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CCC81E1F;
	Mon, 21 Apr 2025 13:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="nqt0Nug9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F2D81E72; Mon, 21 Apr 2025 13:30:30 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9B38171B
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 13:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 4a7e57db-1ea4-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 4a7e57db-1ea4-11f0-beb8-005056992ed3;
 Mon, 21 Apr 2025 13:32:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=SkjLCpYOBc4dO0AykeLBZ7vUWRltZtFPu3r/QzXd05U=;
 b=nqt0Nug9emft9SHbWveLeYaUi6mF6ZTLj6ygA0nKKkSWM413ngBrgVON8FH+tBxvOifvgM3GixmS7
 kduoYN2G7nVLdr0w1twIuNaMHnf9vqaYRuhzH7xjAl9DTmC9wKRUNUdvArSMMrR9XJDiQIx6oBnqS6
 KgkcFxXp/mDEWBWTg4CfwUSkKcYn1gvU/Uz7MNZPUjgKCg6neCzisuz34SS6aqrUwiuNqtrZmm18UC
 HyTHrgYNNKL2ZRq7yBS1Jt9kCLeARnkHnyO4n221TyBvAgS91R/nAhnAkL1gdOGtixqbb1FmWFTgLH
 /gTheMJr58pg0K8/P8V0bcClAFkU3hg==
X-KPN-MID: 33|SY8glorHsEM79ugkWLX0/GWxp+LM5dmxjSthdgtqGMDSUgZgTJtdFNGa9E4P1Ng
 r38HQ5qC47rz4vyJl30AWvJyaHMr5TXgVVavqIVXHhso=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Tw66fghsa4X8nFnhokhqeMWPuB0ApDGfMBlJGG1Wzbs7Sr5D1oKhuc+9H75bewu
 GuQRDBFMtMkOJcFbu0ZG2OQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 05d4f2f6-1ea4-11f0-99e8-00505699772e;
 Mon, 21 Apr 2025 13:30:27 +0200 (CEST)
Date: Mon, 21 Apr 2025 13:30:26 +0200
Message-Id: <87jz7dvjjh.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: sjg@chromium.org, trini@konsulko.com, mkorpershoek@kernel.org,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
In-Reply-To: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Mon, 21 Apr 2025 11:43:10 +0200)
Subject: Re: [PATCH 1/1] boot: BOOTMETH_DISTRO should select
 BOOTMETH_EFI_BOOTMGR
References: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Mon, 21 Apr 2025 11:43:10 +0200

Hi Heinrich,

> Distros expect the EFI boot manager to run. It falls back to launching
> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
> 
> BOOTMETH_EFILOADER is obsolete.

I don't think this is true yet.  For one thing, on my Apple systems I
still get:

  ** Booting bootflow 'nvme@34bcc0000.blk#1.bootdev.part_4' with efi

even though

  CONFIG_BOOTMETH_EFI_BOOTMGR=y

Not sure what's going on here yet.  Maybe this is related to:

  Cannot persist EFI variables without system partition

(There definitely is an EFI system partition on this system).

To me this points out that something is broken again.

But I also think that there are other ways in which the integration of
the EFI boot manager code in U-Boot is flawed, and frankly I don't
think the idea of having a self-coontained EFI boot manager is
compatibe with what some users expect from U-Boot.  And I think
keeping something like BOOTMETH_EFILOADER is part of the answer.

I meant to explain my thoughts in a reply to earlier messages, but
could find the time until now.

From eralier discussions I have composed the following (incomplete)
list of requirements:

1. Some users want to contiue booting using "legacy" boot methods.

2. Some users care about booting as fast as possible.

3. Some users want to be able to boot from a specific device but don't
   really care about the boot method (EFI or "legacy").

4. Some boards have sepcific boot methods (FEL on sunxi, maskrom on
   rockchip) that need to to be tried first.

The biggest issue is requirement #2.  The related issues in the EFI
subsystem and EFI boot manager are:

a. Scanning for ESPs to find the file that contains EFI variables when
   EFI_VARIABLE_FILE_STORE is selected takes time.  Unfortunately this
   is the only way we can support EFI variables on many boards.

b. Scanning for ESPs to boot from takes time as well.

Of course the way bootstd looks for additional boot methods by
scanning filesystems as similar issue.

Originally the EFI boot manager only handled the case where the user
explicitly configured EFI boot options.  The "fallback"
EFI\BOOT\BOOT<ARCH>.EFI loading was handled later when the distro boot
scripts looped over the list of configured boot targets.

Later code was added to the EFI boot manager to do that.  I believe
that was done as part of supporting an EFI boot menu, which to this
date isn't really used by any board, at least not in the default
configuration.  And the way that code works is by creating "default"
boot options for all devices with an ESP.

I think the way to fix this is splitting the EFI boot manager into
different phases.  The first phase should only look at the boot
options configured by the user (either explicitly or automatically by
an OS installer).  That still requires us to read the EFI variables.
So I think we should restrict EFI_VARIABLE_FILE_STORE to only scanning
the device from which we booted U-Boot.

The "fallback" EFI\BOOT\BOOT<ARCH>.EFI should then be done in a later
phase, after some of the other boot methods have been explored taking
into account preferences set by the user.  But that pretty much is
what BOOTMETH_EFILOADER already does.

Cheers,

Mark


> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fb37d912bc9..89076220adb 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
>  	imply CMD_TFTPBOOT if CMD_NET
>  	default y
>  	help
> +	  This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
> +	  launching EFI\BOOT\BOOT<ARCH>.EFI if no boot option matches.
> +
>  	  Enables support for EFI boot using bootdevs. This makes the
>  	  bootdevs look for a 'boot<arch>.efi' on each filesystem
>  	  they scan. The resulting file is booted after enabling U-Boot's
> @@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
>  	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
>  	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
>  	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
> -	select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
> +	select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>  
>  config SPL_BOOTMETH_VBE
>  	bool "Bootdev support for Verified Boot for Embedded (SPL)"
> -- 
> 2.48.1
> 
> 
