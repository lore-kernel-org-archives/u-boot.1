Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D22CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 20:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB20F82C84;
	Mon, 20 Oct 2025 22:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AAE82E34; Mon, 20 Oct 2025 22:51:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DB5A0807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 22:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 077DC1007;
 Mon, 20 Oct 2025 13:51:05 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC973F63F;
 Mon, 20 Oct 2025 13:51:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 21:50:39 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/1] Makefile: pass KEYDIR when set to sunxi-spl.bin
 mkimage
Message-ID: <20251020215039.348651da@minigeek.lan>
In-Reply-To: <20250411011025.1434660-1-james.hilliard1@gmail.com>
References: <20250411011025.1434660-1-james.hilliard1@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 10 Apr 2025 19:10:25 -0600
James Hilliard <james.hilliard1@gmail.com> wrote:

Hi,

> Currently we pass this for u-boot-spl.kwb targets, however when
> building sunxi-spl.bin in the TOC0 format we may also need to
> specify a KEYDIR, as such we should also pass this when set
> to mkimage for the sunxi-spl.bin target.

thanks, looks good to me, tried on a Remix Mini build. Maybe that even
helps with the secure boot CI build problem we have, as the CI cannot
find any keys.

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Queued for the PR.

Cheers,
Andre

> ---
>  scripts/Makefile.xpl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index abc49fbe6c9..d1c1cea876a 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -445,7 +445,8 @@ MKIMAGEFLAGS_sunxi-spl.bin = \
>  	-A $(ARCH) \
>  	-T $(CONFIG_SPL_IMAGE_TYPE) \
>  	-a $(CONFIG_SPL_TEXT_BASE) \
> -	-n $(CONFIG_DEFAULT_DEVICE_TREE)
> +	-n $(CONFIG_DEFAULT_DEVICE_TREE) \
> +	$(if $(KEYDIR),-k $(KEYDIR))
>  
>  OBJCOPYFLAGS_u-boot-spl-dtb.hex := -I binary -O ihex --change-address=$(CONFIG_SPL_TEXT_BASE)
>  

