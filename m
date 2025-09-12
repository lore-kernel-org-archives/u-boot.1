Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B2CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 14:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4188340C;
	Fri, 12 Sep 2025 16:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D45F083429; Fri, 12 Sep 2025 16:27:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8D68D83285
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 16:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A5F16A3;
 Fri, 12 Sep 2025 07:26:54 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32C7E3F66E;
 Fri, 12 Sep 2025 07:27:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:26:59 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Debbie Horsfall <debbie.horsfall@arm.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <fenghua@phytium.com.cn>,
 <linus.walleij@linaro.org>, <Peter.Hoyes@arm.com>,
 <liviu.dudau@foss.arm.com>
Subject: Re: [PATCH 1/2] vexpress64: Set the DM_RNG property
Message-ID: <20250912152659.42851235@donnerap>
In-Reply-To: <20250910151342.204255-1-debbie.horsfall@arm.com>
References: <20250910151342.204255-1-debbie.horsfall@arm.com>
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

On Wed, 10 Sep 2025 16:13:41 +0100
Debbie Horsfall <debbie.horsfall@arm.com> wrote:

Hi,

> Enable the DM_RNG virtio random number generator driver in order to
> consume entropy within U-Boot. This allows U-Boot to inject entropy to the
> kernel via UEFI, so the kernel can use that early, for instance for
> address layout randomisation, or when the kernel does not provide an
> entropy driver itself.

The change looks alright, but is a bit useless on its own, since there
wouldn't be a usable entropy source by default:
- The FVP optionally provides a VIRTIO_RNG device, and this can be simply
enabled on the FVP command line (*.virtio_rng.enabled=1). But the normal
DTs omit the required DT node, since that would cause SErrors when the
command line option is not provided, so this still doesn't show up, even
when now CONFIG_VIRTIO_RNG is set.
- The FVP model can provide the ARMv8.4 FEAT_RNG system registers
(cluster<x>.has_rndr=1), but the feature is not enabled in any of the
VExpress64 builds. This feature uses auto-detection, so it doesn't hurt to
have it always in.

So I would suggest to enable CONFIG_RNG_ARM_RNDR here as well (another
imply line?), to make this more useful.

Cheers,
Andre

> 
> Signed-off-by: Debbie Horsfall <debbie.horsfall@arm.com>
> ---
>  board/armltd/vexpress64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
> index 7e8709444fe..f413c51ac43 100644
> --- a/board/armltd/vexpress64/Kconfig
> +++ b/board/armltd/vexpress64/Kconfig
> @@ -21,6 +21,7 @@ config VEXPRESS64_BASE_MODEL
>  	imply EFI_SET_TIME if DM_RTC
>  	select LINUX_KERNEL_IMAGE_HEADER
>  	select POSITION_INDEPENDENT
> +	imply DM_RNG
>  
>  choice
>  	prompt "VExpress64 board variant"

