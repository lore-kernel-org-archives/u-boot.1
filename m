Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFC5FED2F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E6A683F53;
	Thu, 12 Mar 2026 10:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NHKHmInJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF9483F8A; Thu, 12 Mar 2026 10:10:12 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB95C83F00
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 44EDC43278;
 Thu, 12 Mar 2026 09:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E0DC4CEF7;
 Thu, 12 Mar 2026 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773306609;
 bh=2ugj71Zd7Ll1flI6aNNa6wCbbMbZJAJSfWibejngvoM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NHKHmInJgsMaiMuW8TLG+S+gJ4E8x8gltW+F3CqdmYMlYdi7r3gax60ZYSdIJGvLL
 9DeUmDsGTZbYho9BgPVxtCOyTSW7BIWeQBKpkNzeUEF85ebVLacXjcG0oosAd6TJjL
 Gj9Bh0I983VNPGO6EVACRzX9P8SwvZqk4SGxpe81bVi1hkuAqHBiwXX7h4Zc/eNOTa
 /vP18q/9Swsd/ACPTuSSWdMBJH1L17dp76mdIVV7NsTRHL1Mz8XxvwSiZ6fIZGGhex
 dN6VRo45+g1m9GZEjPOs5YbV6V2Bxca6vWE2E7qz7XC4sXxwXMObvpY3NxALZwrTIY
 5iLRpYS72OOZQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] dfu: Make the DFU_WRITE_ALT symbol available outside of
 DFU
In-Reply-To: <20260310162621.1163932-1-trini@konsulko.com>
References: <20260310162621.1163932-1-trini@konsulko.com>
Date: Thu, 12 Mar 2026 10:10:06 +0100
Message-ID: <875x71mn0x.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Tue, Mar 10, 2026 at 10:26, Tom Rini <trini@konsulko.com> wrote:

> The DFU_WRITE_ALT symbol is used both directly and indirectly (via
> UPDATE_COMMON) for EFI capsule updates (FIT or raw), but does not depend
> on DFU itself. Move this symbol outside of "if DFU" to remove a Kconfig
> dependency problem.

Looking at drivers/dfu/dfu_alt.c both dfu_write_by_name() and
dfu_write_by_alt() seem to rely on functions from drivers/dfu/dfu.c such
as dfu_init_env_entities(), dfu_get_entity() and more.

Looking at UPDATE_COMMON, I see:
config UPDATE_COMMON
	bool
	select DFU_WRITE_ALT
	imply CMD_TFTPBOOT

And if we check the code in common/update.c, we can see that
dfu_write_by_name() is called.

So fit_update() calls
   dfu_write_by_name() which calls
       dfu_init_env_entities() which might no longer be defined when
                               applying this patch.

I'm not sure how is this supposed to work. Do we have to stub
dfu_init_env_entities() ?

>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  drivers/dfu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 2cf4289b4486..962bda40ad2d 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -13,10 +13,10 @@ config DFU_OVER_TFTP
>  	bool
>  	depends on NET
>  
> -if DFU
>  config DFU_WRITE_ALT
>  	bool
>  
> +if DFU
>  config DFU_TFTP
>  	bool "DFU via TFTP"
>  	depends on NETDEVICES
> -- 
> 2.43.0
