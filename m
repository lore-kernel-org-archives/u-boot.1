Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95ADC48BF6
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 01:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1079387E6C;
	Tue,  5 Mar 2024 02:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C4887E6C; Tue,  5 Mar 2024 02:22:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CC84D87E1E
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 02:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3AD12F4;
 Mon,  4 Mar 2024 17:23:20 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970C63F73F;
 Mon,  4 Mar 2024 17:22:43 -0800 (PST)
Date: Tue, 5 Mar 2024 01:22:37 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] sunxi: restore modified memory
Message-ID: <20240305012237.329e74ca@minigeek.lan>
In-Reply-To: <20231227212843.397349-3-andrej.skvortzov@gmail.com>
References: <20231227212843.397349-1-andrej.skvortzov@gmail.com>
 <20231227212843.397349-3-andrej.skvortzov@gmail.com>
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

On Thu, 28 Dec 2023 00:28:43 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> Current sunxi DRAM initialisation code does several test accesses to the
> DRAM array to detect aliasing effects and so determine the correct
> row/column configuration. This changes the DRAM content, which breaks
> use cases like soft reset and Linux's ramoops mechanism.
> 
> Fix this problem by saving and restoring the content of the DRAM cells
> that is used for the test writes.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Merged to sunxi/master.

Cheers,
Andre

> ---
>  arch/arm/mach-sunxi/dram_helpers.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
> index 661186b648..e487f87bf3 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -32,13 +32,25 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
>  #ifndef CONFIG_MACH_SUNIV
>  bool mctl_mem_matches_base(u32 offset, ulong base)
>  {
> +	u32 val_base;
> +	u32 val_offset;
> +	bool ret;
> +
> +	/* Save original values */
> +	val_base = readl(base);
> +	val_offset = readl(base + offset);
> +
>  	/* Try to write different values to RAM at two addresses */
>  	writel(0, base);
>  	writel(0xaa55aa55, base + offset);
>  	dsb();
>  	/* Check if the same value is actually observed when reading back */
> -	return readl(base) ==
> -	       readl(base + offset);
> +	ret = readl(base) == readl(base + offset);
> +
> +	/* Restore original values */
> +	writel(val_base, base);
> +	writel(val_offset, base + offset);
> +	return ret;
>  }
>  
>  /*

