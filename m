Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DDACCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F5583771;
	Mon, 27 Oct 2025 14:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AKhH9Xih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0A383804; Mon, 27 Oct 2025 14:23:03 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6BF832AD
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 80D8A43B4B;
 Mon, 27 Oct 2025 13:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21F3C4CEF1;
 Mon, 27 Oct 2025 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761571380;
 bh=HkP4S3rQqmPZ6g6kj5y+L4v1LnFi30+wm7nv+CC7S/M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AKhH9XihZRu8llejcql90pv0ExasGuCYK2RxIjsowCCe0l+9jG+Xf8YXTMAXiQd6f
 nR6jus5iYLxMuYjlQkhRAvQDCg1w7QTxS75EpTWNqXlvLvOAzG2cJ+TLg5Aw02L5i8
 n6JPdYWPVrG1rSewvNKwZhtr6CgoWaiFlh7FLQ5nS9AtxNyqhSsZV4gfm1P0lCRucg
 +tHDr48V5wyYDtceD2ai36Sc2KYFLR3WcPs5E05EldqckTz//IUUCAXPHthDuEg1Ag
 9TwZziRs0Q1VwlRKJ/bdp38DOtuShZ/lgzDWFL3xrXr4tmSkj9z5shaCtE7gqDLRTr
 PEZXjiUA10GUA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>, u-boot@lists.denx.de
Cc: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Michal Simek <michal.simek@amd.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/9] boot: kconfig: Fix typos
In-Reply-To: <20251024151219.100970-5-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-5-wolfgang.wallner@br-automation.com>
Date: Mon, 27 Oct 2025 14:22:57 +0100
Message-ID: <871pmolbri.fsf@kernel.org>
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

Hi Wolfgang,

Thank you for the patch.

On Fri, Oct 24, 2025 at 17:12, "Wolfgang Wallner" <wolfgang.wallner@br-automation.com> wrote:

> Fix typos in boot/Kconfig.
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
>  boot/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 022ec05de0a..9adb051400f 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1780,7 +1780,7 @@ menu "Image support"
>  config IMAGE_PRE_LOAD
>  	bool "Image pre-load support"
>  	help
> -	  Enable an image pre-load stage in the SPL.
> +	  Enable an image pre-load stage.
>  	  This pre-load stage allows to do some manipulation
>  	  or check (for example signature check) on an image
>  	  before launching it.
> @@ -1812,7 +1812,7 @@ config IMAGE_PRE_LOAD_SIG
>  	  u-boot.
>  
>  config SPL_IMAGE_PRE_LOAD_SIG
> -	bool "Image pre-load signature support witin SPL"
> +	bool "Image pre-load signature support within SPL"
>  	depends on SPL_IMAGE_PRE_LOAD && IMAGE_PRE_LOAD_SIG
>  	select SPL_FIT_SIGNATURE
>  	select SPL_RSA
> -- 
> 2.51.1
