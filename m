Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B3FCF65C7
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 09:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076D483EA9;
	Mon, 26 Jan 2026 10:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oSpcilR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7C983EB3; Mon, 26 Jan 2026 10:48:12 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32CC583E70
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 10:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E60CF60132;
 Mon, 26 Jan 2026 09:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C13C2BC86;
 Mon, 26 Jan 2026 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769420888;
 bh=6x2YBPAmO8JtziddrfuFcCRXkB+gZUIo7hDppI/tvrs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=oSpcilR3I+Eb1Y7LcWrd1mqI7YkCtEZn952vWOz5Xbgp+akGm4hWgBnFGOGz2Xt7B
 4mEkdAHqpmZdL9e54G6RoWZYe4uzOJ6EHW5cN/FlmMhSzAEk6zIHAX/iYMO9R97xEp
 eKrYuUcqu2fFZcxENTvVyzsCoZ2xauF3W7U7jBJP8k/8+gX1I3Bl4p+RKwUwSFCUZg
 15UrpQ3OwNL4nlKQPr6rOwOSoXlmxJLsnoZhuUJFZSbkbOLmawhQ9Rvh77OJdkDkhk
 IuBKnNTrWnm7/03ruhiAQq8Twt4sROtzcxv1xNZlyMhmp+GlNwMJks1MiLw+nkum5D
 IApu+dvD8nZ4Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Adrian Freihofer
 <adrian.freihofer@siemens.com>, Dmitrii Merkurev <dimorinny@google.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, Stefano
 Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
In-Reply-To: <20260124054712.7939-1-hs@nabladev.com>
References: <20260124054712.7939-1-hs@nabladev.com>
Date: Mon, 26 Jan 2026 10:48:06 +0100
Message-ID: <87y0lkogbt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Heiko,

Thank you for the patch.

On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:

> Not for all SoCs the bootloader start at offset 0x0,
> in a hardware partition of an emmc. So we need the possibility to
> set the correct offset, where bootloader starts.
>
> Example:
>
> imx8qxp revision C0 emmc Partition layout
>
> | eMMC block / partition | Offset     | Size  | Purpose                        |
> | ---------------------- | ---------- | ----- | ------------------------------ |
> | /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container A           |
> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
> | /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container B           |
> |                        | 0x00200000 | 8kB   | U-Boot env 0                   |
> |                        | 0x00202000 | 8kB   | U-Boot env 1                   |
> |                        | 0x00220000 | 128kB | secure boot signature rootfs B |
>
> imx8qxp rev B0 emmc Partition layout
>
> | eMMC block / partition | Offset     | Size  | Purpose                        |
> | ---------------------- | ---------- | ----- | ------------------------------ |
> | /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container A           |
> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
> | /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0                   |
> |                        | 0x00002000 | 8kB   | U-Boot env 1                   |
> |                        | 0x00008000 | 2MB   | imx-boot-container B           |
>

Why can't we use raw partition descriptors for this?

See:
https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors

> If we flash now the bootloader image flash.bin on a B0 revision with
>
> uuu FB: flash bootloader flash.bin
>
> we overwrite the environment and board does not boot at all, as offset
> is wrong.
>
> To prevent any API change in the above command we propose
> the following implementation from this series:
>
> We add a new weak function fb_mmc_get_boot_offset() in drivers/fastboot/fb_block.c
> which returns 0 and call this function instead of passing 0 for
> the offset where offset is used/passed.
>
> In SoC specific code (currently for IMX8QXP only) we implement this function
> that it returns on B0 SoCs the 32k offset and on other SoC revisions the
> offset 0.
>
> This is tested on B0 and C0 based boards from siemens.
>
> This patch should have no effect for other SoCs.
>
>
> Adrian Freihofer (2):
>   fastboot: mmc: make boot partition offset configurable
>   arch: imx8qxp: Override weak fb_mmc_get_boot_offset function
>
>  arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
>  drivers/fastboot/fb_block.c  | 15 +++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> Azure build (series is in a bunch of siemens patches sending
> now to mainline):
> https://dev.azure.com/hs0298/hs/_build/results?buildId=202&view=results
>
>
> -- 
> 2.20.1
>
> base-commit: 547e4ff610d72169a2a8c72ffe9741046abd1b2e
