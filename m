Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44892EB4907
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 11:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FCF83C4B;
	Thu, 12 Feb 2026 12:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213918367F; Thu, 12 Feb 2026 12:17:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5C3E180FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6681E339;
 Thu, 12 Feb 2026 03:17:45 -0800 (PST)
Received: from localhost (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEAC23F632;
 Thu, 12 Feb 2026 03:17:50 -0800 (PST)
Date: Thu, 12 Feb 2026 16:47:47 +0530
From: Sughosh Ganu <sughosh.ganu@arm.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] fwu-mdata: Allow multiple metadata storage drivers to be
 enabled
Message-ID: <aY222wFN_8GWkAJf@a079122.arm.com>
References: <20260114095654.736511-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114095654.736511-1-kory.maincent@bootlin.com>
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

On Wed, Jan 14, 2026 at 10:56:53AM +0100, Kory Maincent wrote:
> Change the Kconfig from a "choice" to a conditional block, allowing
> multiple FWU metadata storage drivers to be selected simultaneously
> instead of being mutually exclusive.
> 
> This enables systems with FWU metadata on different storage types
> (e.g., both GPT-partitioned block devices and MTD devices) to have
> both drivers compiled in. The board can then select the appropriate
> driver at runtime based on the devicetree description.
> 
> The change converts FWU_MDATA to a menuconfig and replaces the
> "choice/endchoice" block with "if FWU_MDATA/endif", making
> FWU_MDATA_GPT_BLK default to 'y' for backward compatibility.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Acked-by: Sughosh Ganu <sughosh.ganu@arm.com>

-sughosh

>  drivers/fwu-mdata/Kconfig | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fwu-mdata/Kconfig b/drivers/fwu-mdata/Kconfig
> index 42736a5e43b..59571ac01ea 100644
> --- a/drivers/fwu-mdata/Kconfig
> +++ b/drivers/fwu-mdata/Kconfig
> @@ -1,4 +1,4 @@
> -config FWU_MDATA
> +menuconfig FWU_MDATA
>  	bool "Driver support for accessing FWU Metadata"
>  	depends on DM
>  	help
> @@ -6,16 +6,14 @@ config FWU_MDATA
>  	  FWU Metadata partitions reside on the same storage device
>  	  which contains the other FWU updatable firmware images.
>  
> -choice
> -	prompt "Storage Layout Scheme"
> -	depends on FWU_MDATA
> -	default FWU_MDATA_GPT_BLK
> +if FWU_MDATA
>  
>  config FWU_MDATA_GPT_BLK
>  	bool "FWU Metadata access for GPT partitioned Block devices"
>  	select PARTITION_TYPE_GUID
>  	select PARTITION_UUIDS
> -	depends on FWU_MDATA && BLK && EFI_PARTITION
> +	depends on BLK && EFI_PARTITION
> +	default y
>  	help
>  	  Enable support for accessing FWU Metadata on GPT partitioned
>  	  block devices.
> @@ -28,4 +26,4 @@ config FWU_MDATA_MTD
>  	  (or non-GPT partitioned, e.g. partition nodes in devicetree)
>  	  MTD devices.
>  
> -endchoice
> +endif
> -- 
> 2.43.0
> 
