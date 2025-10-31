Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EDFCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F40183965;
	Fri, 31 Oct 2025 16:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qn5Q0tO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7191083952; Fri, 31 Oct 2025 16:15:04 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF47983965
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A180260277;
 Fri, 31 Oct 2025 15:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54159C4CEE7;
 Fri, 31 Oct 2025 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761923700;
 bh=T3IPx1nGsdO9TlvbHBvGOEOS3+Aq6p54PaiKeA27kMA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Qn5Q0tO8CEG1NxiLK6HW7pQXGApt9zdf6UeHu4qdHmgk8v8zP+v64d9AKnuLpDqz4
 NWAtTQRotxCmHm6smNoehfreHUKIIG5o/gPfEgQmxZz+lJNYTbOxwjMHDtOkG6LSSY
 yzPHpyT1m9dmKVhG763fmSeTAJ1EcPRo7MYw33PIGnDp9/0D465wAa3S/JM0pTP0wa
 sXgZytJxh0V0upcg3wxasscO90AaFHOjPNDCY3xyxQuvZMpj+Uaf/9YPbdlFpD4j/L
 zoS9KbRLdl7N0UYsBbxgIQWTkWlgntz2AEe3622NmgEI7lxcAbAimA571bKHUqZpeh
 tZL883By1sqQw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Michal Simek <michal.simek@amd.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Casey Connolly
 <casey.connolly@linaro.org>, Martin Schwan <m.schwan@phytec.de>, Quentin
 Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] boot: specify SPL_FIT_FULL_CHECK applies to SPL
In-Reply-To: <20251029-spl-fit-full-check-desc-v1-1-ebb42c9d97bd@cherry.de>
References: <20251029-spl-fit-full-check-desc-v1-1-ebb42c9d97bd@cherry.de>
Date: Fri, 31 Oct 2025 16:14:56 +0100
Message-ID: <87o6pn5ci7.fsf@kernel.org>
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

Hi Quentin,

Thank you for the patch.

On Wed, Oct 29, 2025 at 12:08, Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> SPL_FIT_FULL_CHECK currently shares its description and help text with
> FIT_FULL_CHECK which is quite confusing, so let's specify this applies
> to SPL.
>
> Fixes: 6f3c2d8aa5e6 ("image: Add an option to do a full check of the FIT")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 9adb051400f..db114baa077 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -193,13 +193,13 @@ config SPL_FIT_PRINT
>  	  Support printing the content of the fitImage in a verbose manner in SPL.
>  
>  config SPL_FIT_FULL_CHECK
> -	bool "Do a full check of the FIT before using it"
> +	bool "Do a full check of the FIT within SPL before using it"
>  	depends on SPL_FIT
>  	help
> -	  Enable this do a full check of the FIT to make sure it is valid. This
> -	  helps to protect against carefully crafted FITs which take advantage
> -	  of bugs or omissions in the code. This includes a bad structure,
> -	  multiple root nodes and the like.
> +	  Enable this do a full check of the FIT within SPL to make sure it is
> +	  valid. This helps to protect against carefully crafted FITs which take
> +	  advantage of bugs or omissions in the code. This includes a bad
> +	  structure, multiple root nodes and the like.
>  
>  config SPL_FIT_SIGNATURE
>  	bool "Enable signature verification of FIT firmware within SPL"
>
> ---
> base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
> change-id: 20251029-spl-fit-full-check-desc-15d43348db55
>
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>
