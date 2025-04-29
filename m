Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0A3C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97EB58210F;
	Tue, 29 Apr 2025 14:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCNAn3S0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ECFB82145; Tue, 29 Apr 2025 14:31:29 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABCC8210D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B8D6261567;
 Tue, 29 Apr 2025 12:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14733C4CEE3;
 Tue, 29 Apr 2025 12:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745929885;
 bh=g0MuY+WIGhPrcuT/niJcY6e2qCgAf4UXIBR9RplkFcg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UCNAn3S0mzwbvl2LSJCjUZlU8s2rQFNDG81X8WDgKpSlKZ72mF9Ra9HJVb/4uRRhN
 USfWQ3oW/epPll+4v6Z1INaHv1TdhCBu8DYnEMlayD5M4hQ60fIZ9jNHUSehjr3Pqe
 SlbjhhIXQ6Wta9AusH9zCo15vEFfz/E5pF8N/Y8Em9FxTVpsC/yjNDXQIBfDDnG19N
 gkbxmwSiQYvQOmXCG5tB7gfItoyYrYZjZSusxDfSRGjsfZ0zzlX83OYf6hJuLnNJ5w
 y9vXQkXt4K/tgqy6qILR0QXcbjmFAMawjy5dhlqybLSDgTK446J9b59FC4wHXJk5o7
 63TGC6yCurp9Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Daniel Schultz <d.schultz@phytec.de>, w.egorov@phytec.de,
 trini@konsulko.com, u-boot@lists.denx.de
Cc: mkorpershoek@kernel.org, anshuld@ti.com, upstream@lists.phytec.de,
 Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH] configs: phycore_am62x_a53_defconfig: Remove
 CONFIG_SYS_BOOTM_LEN
In-Reply-To: <20250429120818.3365069-1-d.schultz@phytec.de>
References: <20250429120818.3365069-1-d.schultz@phytec.de>
Date: Tue, 29 Apr 2025 14:31:22 +0200
Message-ID: <87plgv5eud.fsf@kernel.org>
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

Hi Daniel,

Thank you for the patch.

On mar., avril 29, 2025 at 05:08, Daniel Schultz <d.schultz@phytec.de> wrote:

> This config was defined with the default value of 8 MiB. However,
> the default value is different when CONFIG_ARM64 is enabled and
> should be 64 MiB.
>
> Remove this config from the A53 defconfig and use the correct
> default config.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  configs/phycore_am62x_a53_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
> index 4ad399893ff..c52a2f76200 100644
> --- a/configs/phycore_am62x_a53_defconfig
> +++ b/configs/phycore_am62x_a53_defconfig
> @@ -28,7 +28,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>  CONFIG_SPL_BSS_START_ADDR=0x80c80000
>  CONFIG_SPL_BSS_MAX_SIZE=0x80000
>  CONFIG_SPL_STACK_R=y
> -CONFIG_SYS_BOOTM_LEN=0x800000
>  CONFIG_SPL_SIZE_LIMIT=0x80000
>  CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
>  CONFIG_ENV_OFFSET_REDUND=0x6c0000
> -- 
> 2.25.1
