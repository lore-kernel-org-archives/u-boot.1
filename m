Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FFAC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 14:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E89AF82AB1;
	Thu, 17 Apr 2025 16:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fv4vx+Po";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77FDF82B7C; Thu, 17 Apr 2025 16:58:50 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A52181F45
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 16:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D6B54A179;
 Thu, 17 Apr 2025 14:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8DAC4CEEA;
 Thu, 17 Apr 2025 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744901925;
 bh=gQdL01t68RbFTnNhadpDsSbQ5Z36CDgR9ydHhU7lXJ8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Fv4vx+Pom1diU9HPekR9Qa2XlewOuaxdSVzMrlq3yoge0B6tnNCNlGy5ErIi9ywRq
 +RUJn+M44IzBgmBDKZyQbyPZ2Zj3hlS+sIVdNh4A+parUc+USvRSiuK87/exs8FZLW
 XWkpfJQJ1eSwPx/tin8EnOUSm4eeS9jUejolzqxpFhAE7L0BftvEbjinpW53nZyN6o
 oAOjrjWZUUtTgepcyIDW8ZvwpROeouQ/LC4cgF/pSKlf4ZVRG6/zGRQ+cq+QrrMh0n
 iSvsROLa4QC5nB1Fn2J4r4J3qfebH+YIsMYmQJhat13LGOLR15go5Hdi+bqCA1IJsP
 8nAR14bDpfgQA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v2 0/3] fastboot: add support for generic block
 flashing
In-Reply-To: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
Date: Thu, 17 Apr 2025 16:58:41 +0200
Message-ID: <87y0vy7s2m.fsf@kernel.org>
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

Hey Neil,

Thank you for the series.

On mer., avril 09, 2025 at 09:58, neil.armstrong@linaro.org wrote:

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
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

On top of master (commit 5b4ae0f3f040 ("mailmap: update my name and email")),
Using khadas-vim3_android_defconfig, I did the following:

boot the newly generated U-Boot with boot-g12.py:
$ boot-g12.py ~/work/upstream/yukawa/bootloader/u-boot_kvim3_noab.bin

Run fastboot from U-Boot console:
=> fastboot usb 0
crq->brequest:0x0

Then, on the host, reflash the bootloader:
$ fastboot flash bootloader u-boot_kvim3_noab.bin

In U-Boot, everything seems fine:
** Bad device specification mmc bootloader_a **
** Bad device specification mmc bootloader_a **
Couldn't find partition mmc bootloader_a
Starting download of 1288048 bytes
.........
downloading of 1288048 bytes finished
Flashing Raw Image
........ wrote 1288192 bytes to 'bootloader'
resetting ...
bl31 reboot reason: 0xd
bl31 reboot reason: 0x0
system cmd  1.
G12B:BL:6e7c85:2a3b91;FEAT:E0F83180:402000;POC:D;RCY:0;USB:0;

And after rebooting the board, we are on the newly flashed bootloader.

So, to me:

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

I do need some more time to review, though.
Thank you for your patience!

> ---
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
>  drivers/fastboot/Kconfig      |  20 ++-
>  drivers/fastboot/Makefile     |   4 +-
>  drivers/fastboot/fb_block.c   | 313 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_command.c |   8 ++
>  drivers/fastboot/fb_common.c  |  16 ++-
>  drivers/fastboot/fb_getvar.c  |   8 +-
>  drivers/fastboot/fb_mmc.c     | 210 ++--------------------------
>  include/fb_block.h            | 104 ++++++++++++++
>  8 files changed, 477 insertions(+), 206 deletions(-)
> ---
> base-commit: f892a7f397a66d8d09f418d1e0e06dfb48bac27d
> change-id: 20250408-topic-fastboot-blk-c5e14cd59224
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
