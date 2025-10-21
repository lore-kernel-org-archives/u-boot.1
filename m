Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3A1CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 09:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CD6807C0;
	Tue, 21 Oct 2025 11:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2C882B20; Tue, 21 Oct 2025 11:50:42 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A2FDE807B1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D57291007;
 Tue, 21 Oct 2025 02:50:30 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97E153F66E;
 Tue, 21 Oct 2025 02:50:36 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:50:32 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Anand Gore
 <anand.gore@broadcom.com>, david regan <dregan@broadcom.com>, Greg Malysa
 <malysagreg@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Philip Molloy
 <philip.molloy@analog.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH v2] Makefile: pass KEYDIR when set to sunxi-spl.bin mkimage
Message-ID: <20251021105032.49267720@donnerap.manchester.arm.com>
In-Reply-To: <20251021075934.549466-1-richard.genoud@bootlin.com>
References: <20251021075934.549466-1-richard.genoud@bootlin.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Tue, 21 Oct 2025 09:59:34 +0200
Richard Genoud <richard.genoud@bootlin.com> wrote:

Hi Richard,

> From: James Hilliard <james.hilliard1@gmail.com>
> 
> Provide private keys to build sunxi-spl.bin
> 
> Currently we pass this for u-boot-spl.kwb targets, however when
> building sunxi-spl.bin in the TOC0 format, we may also need to
> specify a KEYDIR.
> As such we should also pass this when set to mkimage for the
> sunxi-spl.bin target.
> 
> Tested on Whatsminer H616 board.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>


I have queued James' original patch just yesterday evening:
https://lore.kernel.org/u-boot/20251020215039.348651da@minigeek.lan/T/#t

Cheers,
Andre

> ---
>  scripts/Makefile.xpl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Changes from v1:
> - remove superfluous From: (sorry for the noise)
> 
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 3e940bf562d5..52f014ad3324 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -442,7 +442,8 @@ MKIMAGEFLAGS_sunxi-spl.bin = \
>  	-A $(ARCH) \
>  	-T $(CONFIG_SPL_IMAGE_TYPE) \
>  	-a $(CONFIG_SPL_TEXT_BASE) \
> -	-n $(CONFIG_DEFAULT_DEVICE_TREE)
> +	-n $(CONFIG_DEFAULT_DEVICE_TREE) \
> +	$(if $(KEYDIR),-k $(KEYDIR))
>  
>  OBJCOPYFLAGS_u-boot-spl-dtb.hex := -I binary -O ihex --change-address=$(CONFIG_SPL_TEXT_BASE)
>  
> 
> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66

