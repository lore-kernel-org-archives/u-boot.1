Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5857BC83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 13:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD61680E9A;
	Wed,  2 Jul 2025 15:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0EDtm/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55CF81FEE; Wed,  2 Jul 2025 15:50:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B56A9800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5EAFF5C39C2;
 Wed,  2 Jul 2025 13:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96F7C4CEE7;
 Wed,  2 Jul 2025 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751464236;
 bh=XV2R8zbqMRnejJFPMzV1OT92Q1Boqlt02SvwiDWMQas=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=M0EDtm/brs5uHxUfhofsn0l9QTlDgh/Pkd49a/F0Tj0hnWXEMlmXODykxIKbfHTm4
 8+hcaVnsjn9U9cZ8Y6Q87rOgHrVwkHWcJR+jcNuuDErlLvo3qhGDSvGpHHhdurFoeL
 ET8FW+Jy8D0BwiiLCg/dyPMXaUYjNHTLJAiCI1U/sGB4A5pJguaEsOT04z4M/N/FZg
 QXerT1yDMvBDflwisB1r3OgsD3bcq44n+LdGdgV3VN2nGsik9Zys0OhAhWlRXSnJuP
 l5bVWBaDrv1dqJGvOEchPEh/n5Tq1XFvWnKHcD4ZBOm3qXhIaHzmmXz9FP/CnIHsp9
 CDtMYuoy9i6pw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v6 3/3] fastboot: integrate block flashing back-end
In-Reply-To: <20250630-topic-fastboot-blk-v6-3-7cdfd3a24786@linaro.org>
References: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
 <20250630-topic-fastboot-blk-v6-3-7cdfd3a24786@linaro.org>
Date: Wed, 02 Jul 2025 15:50:33 +0200
Message-ID: <875xgau2fq.fsf@kernel.org>
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

On Mon, Jun 30, 2025 at 17:19, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> From: Dmitrii Merkurev <dimorinny@google.com>
>
> 1. Get partition info/size
> 2. Erase partition
> 3. Flash partition
> 4. BCB
>
> Make FASTBOOT_FLASH also depend on BLK, but make sure
> it doesn't affect SUNXI and ROCKCHIP platforms since they
> default to y already.
>
> Make it only default on SUNXI when MMC or NAND is enabled,
> so it doesn't break the CHIP & Ninendo boards, and for ROCKCHIP

s/Ninendo/Nintendo/ ?

I can fix when applying if needed.
Mattijs

> when MMC is enabled.
>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/fastboot/Kconfig      | 32 ++++++++++++++++++++++++++++++--
>  drivers/fastboot/Makefile     |  1 +
>  drivers/fastboot/fb_command.c |  8 ++++++++
>  drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>  drivers/fastboot/fb_getvar.c  |  8 +++++++-
>  5 files changed, 64 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..b2b20a2c5e430cccc49fd6c04d6fb8825b67ec04 100644
> --- a/drivers/fastboot/Kconfig
