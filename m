Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F96AC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 12:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59DAF81FEE;
	Fri,  6 Jun 2025 14:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qngEXYqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B4981FEE; Fri,  6 Jun 2025 14:22:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15AF181F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 14:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 023F75C5A75;
 Fri,  6 Jun 2025 12:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E11FC4CEEB;
 Fri,  6 Jun 2025 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749212538;
 bh=EX5sAfZ05NqgJtIYwp8/2mYlo/VRmth1IrKnqIlBJTs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qngEXYqAiIrVY1FZ95AUAMUPBIDuiGh653Op0uPb7n266ky51kTL8qxpc0iveLu62
 zL+I7UFtTIB4UTKvtuffnPIoJUO1J3ocxbtmPQl7gn82JHiVGzT67U+xQCK/Bu9NKV
 A0FOVo44G030K2gKi1lm+Zf4n8MrdUSZSDhqL4aK1a72q2L7UdfT2+SO0hbPPrymAv
 lgKAmZbiHO1pOV3AymZ/a9/FN1Z3OjHyUeF4iK08Xxuds0GOACeA/fNoa0HQEu2y1f
 1LzxqgxrDXvQetess8iPcjXtATEteeKT7PrM4m6pBt4M+1b8Ti+kmgzCyEhiPgCFL7
 dy7qhip+JgM+g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v5 0/3] fastboot: add support for generic block
 flashing
In-Reply-To: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
References: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
Date: Fri, 06 Jun 2025 14:22:15 +0200
Message-ID: <875xh9kqko.fsf@kernel.org>
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

On ven., juin 06, 2025 at 11:33, Neil Armstrong <neil.armstrong@linaro.org> wrote:

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

Thanks for the changes in v5. I will pick up the series (for next) in
the following week, to give some time for last-minute reviews.

Regards
Mattijs

> ---
> Changes in v5:
> - Removed BLK dependency on FASTBOOT_FLASH_MMC
> - Removed BLK dependency on FASTBOOT_FLASH in patch 2
> - Added back BLK dependency on FASTBOOT_FLASH in patch 3
> - Rewrote FASTBOOT_FLASH_BLOCK_INTERFACE_ID help text with Tom suggestions
> - Removed default for FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> - CI test run is fixed with FASTBOOT_FLASH_BLOCK_INTERFACE_ID default to 0
> - Link to v4: https://lore.kernel.org/r/20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org
>
> Changes in v4:
> - Rebase on next
> - Fixup Kconfig default values & description
> - Link to v3: https://lore.kernel.org/r/20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org
>
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
>  drivers/fastboot/Kconfig      |  29 +++-
>  drivers/fastboot/Makefile     |   4 +-
>  drivers/fastboot/fb_block.c   | 323 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_command.c |   8 ++
>  drivers/fastboot/fb_common.c  |  22 ++-
>  drivers/fastboot/fb_getvar.c  |   8 +-
>  drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
>  include/fb_block.h            | 105 ++++++++++++++
>  8 files changed, 504 insertions(+), 205 deletions(-)
> ---
> base-commit: bed3b33e732f2f2d9ce93801f7dbe09a02b52c3a
> change-id: 20250408-topic-fastboot-blk-c5e14cd59224
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
