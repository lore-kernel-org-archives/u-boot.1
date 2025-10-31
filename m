Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE68CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7544383927;
	Fri, 31 Oct 2025 16:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BGZFVrOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBAC83946; Fri, 31 Oct 2025 16:13:50 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E639B838C2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 34D224404C;
 Fri, 31 Oct 2025 15:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38198C4CEE7;
 Fri, 31 Oct 2025 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761923627;
 bh=fNQnEfkcI+g2mw7614JicCsxxg1st0nYft29jHrJ/K4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BGZFVrOBxmzxtAY2wNuE2pkBJPhgcnOx9WdnX6QmeMUAIydb2wUBHF/ovkL2mtS7M
 44QuQr/39qCoF1vXQSl5+eBAMfQJV/ioeFCT9hwbGKpGChwx6Z95vMSkNXF0qZ9P3g
 SR3w2N0jFoeyS0LaBLo9c/S0XTT8PUUeWEqzNayBnSxEQBfnSb0TqeclpnknoEzUv2
 bLXwPMjD6hGnYfi093sDNsqe40lM2HdV27mw6S7gZidgKKPRu/xGMvuDwpiVno04Nc
 2YjQ1ODvUEf2nBAo3XB1pBgqVUlZmkuEX8Po+4P+KTG8El03ksBdyDqzXMbThXhGB1
 rBaeF8yuU+aew==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Michal Simek <michal.simek@amd.com>,
 Martin Schwan <m.schwan@phytec.de>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH] boot: fix typo in SYS_BOOTM_LEN description
In-Reply-To: <20251029-sys-bootm-len-typo-v1-1-5f1858d9e80d@cherry.de>
References: <20251029-sys-bootm-len-typo-v1-1-5f1858d9e80d@cherry.de>
Date: Fri, 31 Oct 2025 16:13:43 +0100
Message-ID: <87qzuj5ck8.fsf@kernel.org>
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

On Wed, Oct 29, 2025 at 12:19, Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 9adb051400f..762bf4e2dee 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1053,7 +1053,7 @@ if MEASURED_BOOT
>  endif # MEASURED_BOOT
>  
>  config SYS_BOOTM_LEN
> -	hex "Maximum size of a decompresed OS image"
> +	hex "Maximum size of a decompressed OS image"
>  	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
>  		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
>  	default 0x8000000 if PPC || ARM64 || RISCV
>
> ---
> base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
> change-id: 20251029-sys-bootm-len-typo-65afe0aa772c
>
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>
