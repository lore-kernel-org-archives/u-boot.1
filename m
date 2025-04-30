Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22541C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 08:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BAC82B17;
	Wed, 30 Apr 2025 10:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tCI01Jog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258F082B20; Wed, 30 Apr 2025 10:56:09 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F448216C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BA63D615F0;
 Wed, 30 Apr 2025 08:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD98C4CEE9;
 Wed, 30 Apr 2025 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746003365;
 bh=4a56cED/cT5OBYhTfGG02DrFKGHBY0iWoMPyrnBKAIY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tCI01JogFaW8GREHxw88fk9K4By48PSGbl4aw3/meUfizYKzxjNviZn7uifMfRRtn
 p+tqBFwi4rI0bw9yTZb9Y9PRgYqE78hhdlxTTaCntt/BG1OpzA2y7Cus1aG9cW9OiW
 FMLlLFYk1FXHwJEQBo6yA6IcDjGcxrWHktMLlUOZncY1KDxsVJEe/HERNuB0MPU2f0
 8HR/JORe/i8/nZijMvYuSMXZtDgQld9IjTOSQfmP4arclH+ozxK6sDUgAIF5h7AUWy
 oCrh0oRjakl5EdEilpZiZ6XUCw8Cgqi82Fd5Q9b6zxAK4or2MEW10h4PnCExgtZ1NY
 jGvfeMDIO1dAg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, Peter
 Robinson <pbrobinson@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] boot: let BOOTSTAGE_RECORD_COUNT default to 50
In-Reply-To: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
References: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
Date: Wed, 30 Apr 2025 10:55:57 +0200
Message-ID: <87y0viqb8i.fsf@kernel.org>
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

Hi Heinrich,

Thank you for the patch.

On mer., avril 30, 2025 at 09:34, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> BOOTSTAGE_RECORD_COUNT=30 is too small to record booting a FIT image
> with EFI kernel, initrd, dtb as seen on the StarFive VisionFive 2
> board.
>
> Increase the default for BOOTSTAGE_RECORD_COUNT to 50.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fb37d912bc9..2456856a572 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1170,7 +1170,7 @@ config BOOTSTAGE_REPORT
>  config BOOTSTAGE_RECORD_COUNT
>  	int "Number of boot stage records to store"
>  	depends on BOOTSTAGE
> -	default 30
> +	default 50
>  	help
>  	  This is the size of the bootstage record list and is the maximum
>  	  number of bootstage records that can be recorded.
> -- 
> 2.48.1
