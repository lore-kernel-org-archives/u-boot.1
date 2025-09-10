Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FA2CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 16:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D677883281;
	Wed, 10 Sep 2025 18:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEBB98329C; Wed, 10 Sep 2025 18:48:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 76910831D5
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 18:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C5E416F8;
 Wed, 10 Sep 2025 09:48:18 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07B03F63F;
 Wed, 10 Sep 2025 09:48:23 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:48:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Said Nasibov <said.nasibov@arm.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <peter.hoyes@arm.com>, <david.hu2@arm.com>, <michael.zhao2@arm.com>,
 <marek.vasut+renesas@mailbox.org>, <mkorpershoek@kernel.org>,
 <pbrobinson@gmail.com>, <ilias.apalodimas@linaro.org>,
 <m.schwan@phytec.de>, <quentin.schulz@cherry.de>,
 <rayagonda.kokatanur@broadcom.com>, <tien.fong.chee@altera.com>,
 <casey.connolly@linaro.org>, <patrick.rudolph@9elements.com>,
 <alif.zakuan.yuslaimi@intel.com>, <boyan.karatotev@arm.com>,
 <Oliver.Gaskell@analog.com>, <duje@dujemihanovic.xyz>, <1425075683@qq.com>
Subject: Re: [RFC PATCH 2/2] vexpress64: replace distro boot with standard boot
Message-ID: <20250910174821.4294fb17@donnerap>
In-Reply-To: <20250828130657.249153-3-said.nasibov@arm.com>
References: <20250828130657.249153-1-said.nasibov@arm.com>
 <20250828130657.249153-3-said.nasibov@arm.com>
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

On Thu, 28 Aug 2025 14:06:57 +0100
Said Nasibov <said.nasibov@arm.com> wrote:

Hi,

> This commit updates vexpress64 configs to default to standard boot, and
> explicitly select bootmeth_smh when standard boot is enabled.
> 
> The distro boot related variables are deliberately not removed to preserve
> compatibility with existing distro boot flows.
> 
> Signed-off-by: Said Nasibov <said.nasibov@arm.com>
> ---
>  arch/arm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5872455a0fe..527a865e4dc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1413,7 +1413,8 @@ config ARCH_VEXPRESS64
>  	select MTD_NOR_FLASH if MTD
>  	select FLASH_CFI_DRIVER if MTD
>  	select ENV_IS_IN_FLASH if MTD
> -	imply DISTRO_DEFAULTS
> +	imply BOOTSTD_DEFAULTS
> +	select BOOTMETH_SMH if BOOTSTD

This will not work, since the Juno board is also VEXPRESS64, but does not
feature semihosting. "make vexpress_aemv8a_juno_defconfig" consequently
produces warnings during configuration.

 	select BOOTMETH_SMH if BOOTSTD && SEMIHOSTING

should fix that.

Cheers,
Andre

>  config TARGET_CORSTONE1000
>  	bool "Support Corstone1000 Platform"

