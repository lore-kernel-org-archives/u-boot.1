Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7B4C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 16:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9437F879E6;
	Fri, 12 Jan 2024 17:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7403879F8; Fri, 12 Jan 2024 17:01:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 692D48797C
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 17:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BCD31FB;
 Fri, 12 Jan 2024 08:01:50 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3BAD3F67D;
 Fri, 12 Jan 2024 08:01:02 -0800 (PST)
Date: Fri, 12 Jan 2024 16:01:00 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Philippe Coval <rzr@users.sf.net>
Cc: u-boot@lists.denx.de, Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Sam Edwards <CFSworks@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>, Olliver
 Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] arm: sunxi: Reduce inrush current on Olimex
 A20-OLinuXino_MICRO
Message-ID: <20240112160100.274ff616@donnerap.manchester.arm.com>
In-Reply-To: <20240106222142.170219-1-rzr@users.sf.net>
References: <20240106222142.170219-1-rzr@users.sf.net>
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

On Sat,  6 Jan 2024 23:21:34 +0100
Philippe Coval <rzr@users.sf.net> wrote:

(CC:ing Olliver, can you confirm that this quirk applies to the Micro too?)

Hi Philippe,

thanks for taking care of upstreaming this!

> This change fix reboot, it was tested on debian-12

So I am wondering why this only comes up now. Was that always broken, and
nobody cared (or ran mainline U-Boot)? Or does the problem only show under
certain circumstances?

It would be good if you can elaborate about that in the commit message, to
show *why* your patch is needed.

> It was inspired from for-master-20181206-10-g8311e84b18

Referencing a commit here looks odd. You could just mention that this quirk
is also used on the Lime2 boards.

> Relate-to: https://github.com/rzr/u-boot/issues/2
> Thanks-to: Olliver Schinagl <oliver@schinagl.nl>

Please don't invent tags. If you want to give credit for things like
advice or support, mention their name in the commit message, and maybe add
them in CC:
If you have a *stable* link with useful(!) information, use the Link: tag.

> Signed-off-by: Philippe Coval <rzr@users.sf.net>
> ---
> 
>  configs/A20-OLinuXino_MICRO_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/A20-OLinuXino_MICRO_defconfig b/configs/A20-OLinuXino_MICRO_defconfig

If you change this file, that probably means that the eMMC version is also
affected? Same as the two Lime2 boards, where we set the symbol in *both*
defconfigs? So can you please add that symbol there as well?

Cheers,
Andre

> index db4270f9b2..673ab85c8a 100644
> --- a/configs/A20-OLinuXino_MICRO_defconfig
> +++ b/configs/A20-OLinuXino_MICRO_defconfig
> @@ -20,6 +20,7 @@ CONFIG_ETH_DESIGNWARE=y
>  CONFIG_MII=y
>  CONFIG_SUN7I_GMAC=y
>  CONFIG_SUN7I_GMAC_FORCE_TXERR=y
> +CONFIG_AXP_ALDO3_INRUSH_QUIRK=y
>  CONFIG_AXP_ALDO3_VOLT=2800
>  CONFIG_AXP_ALDO4_VOLT=2800
>  CONFIG_SCSI=y

