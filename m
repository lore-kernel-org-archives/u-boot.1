Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B05C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 10:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C6A181F32;
	Wed,  7 May 2025 12:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OGEZiHJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2943A820EB; Wed,  7 May 2025 12:02:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760208007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 12:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B4FC1440A5;
 Wed,  7 May 2025 10:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462DFC4CEE7;
 Wed,  7 May 2025 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746612129;
 bh=9XGkXZBJqlnHC0j0+op0vGbgGaSLxxzZ6jc+q39Zgjo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OGEZiHJqwVxa7AQUslU7A8DUiaMovYmswEiYwz7vPM5F1sRX1i537Kq8tyOXihXGs
 mvo4FyaNfPs3L9tH0Fnx8Bs9GO62bkVSK8GbuNRQqzwEyzt/tI3muCQYp7OJPmQtSz
 NtHBq9BdnNnAb2zThbot9/xP6PUM82y4mdV59Gt0jItTH6aVU1e8lroCXFjxwHgaoV
 b+ROokO3G3OTzCuNR+IodXzb18xhQhrBj42WiYVUyheJot61TgswzZvwBTvnj3UIp+
 xK2nXakjSHpx2Jt0U5N+7Qjuaw4beYhcuFgW6iJAT5EpBRE5bmdlavhL7cXfHi5Omk
 gs6rBFVjzykJQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
In-Reply-To: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
Date: Wed, 07 May 2025 12:02:07 +0200
Message-ID: <87o6w4agdc.fsf@kernel.org>
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

Hi Neil,

Thank you for the series.

On mar., mai 06, 2025 at 18:10, neil.armstrong@linaro.org wrote:

> This serie permits using any block device as target
> for fastboot by moving the generic block logic into
> a common set of helpers and also use them as generic
> backend.
>
> The erase logic has been extended to support software
> erase since only 2 block drivers exposes the erase
> operation.
>
> Tests are welcome to make sure this series doesn't
> introduce any regressions on the emmc backend.

I've tested the series on khadas-vim3_android_defconfig
keeping CONFIG_FASTBOOT_FLASH_MMC=y (so with the emmc backend)

I tested the following:
# flashing a raw partition with a descriptor:
$ fastboot flash bootloader u-boot_kvim3_noab.bin
# flashing a sparse image:
$ fastboot flash super super.img

I also testing reflashing the super.img when using the generic block
layer:
=> fastboot usb 0
Warning: the fastboot block backend features are limited, consider using the MMC backend

$ fastboot flash super super.img

Both work great!

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

I've also opened a issue on gitlab to harmonize the fastboot emmc
backend with the generic block backend:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/issues/6

>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Move Kconfig/Makefile changes over the 2 patches
> - Relicence to GPL2 with Dmitrii approval
> - Move soft erase in a separate function
> - Update help text of Kconfig BLOCK entries
> - Add warning at init if MMC was selected with BLOCK backend
> - Link to v2: https://lore.kernel.org/r/20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org
>
> Changes in v2:
> - Dropped applied virtio erase patch
> - Reorganize patches, introducing helpers first, using them in mmc afterwards
> - Added soft-erase logic
> - Added move helpers to handle the partitions erase & flash from emmc
> - Fixed const var on last patch
> - Link to v1: https://lore.kernel.org/all/20240306185921.1854109-1-dimorinny@google.com/
>
> ---
> Dmitrii Merkurev (3):
>       fastboot: blk: introduce fastboot block flashing support
>       fastboot: blk: switch emmc to use the block helpers
>       fastboot: integrate block flashing back-end
>
>  drivers/fastboot/Kconfig      |  28 +++-
>  drivers/fastboot/Makefile     |   4 +-
>  drivers/fastboot/fb_block.c   | 323 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_command.c |   8 ++
>  drivers/fastboot/fb_common.c  |  22 ++-
>  drivers/fastboot/fb_getvar.c  |   8 +-
>  drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
>  include/fb_block.h            | 105 ++++++++++++++
>  8 files changed, 502 insertions(+), 206 deletions(-)
> ---
> base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
> change-id: 20250408-topic-fastboot-blk-c5e14cd59224
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
