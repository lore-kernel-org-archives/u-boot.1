Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F903E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 11:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965E0870FF;
	Mon,  2 Oct 2023 13:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10F787100; Mon,  2 Oct 2023 13:26:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7553186D82
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 13:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27716C15;
 Mon,  2 Oct 2023 04:27:12 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E17A43F59C;
 Mon,  2 Oct 2023 04:26:32 -0700 (PDT)
Date: Mon, 2 Oct 2023 12:26:26 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Gunjan Gupta <viraniac@gmail.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>, Ondrej
 Jirman <megi@xff.cz>, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
Message-ID: <20231002122626.047b4043@donnerap.manchester.arm.com>
In-Reply-To: <20231001161336.31140-2-viraniac@gmail.com>
References: <20231001161336.31140-1-viraniac@gmail.com>
 <20231001161336.31140-2-viraniac@gmail.com>
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

On Sun,  1 Oct 2023 21:43:32 +0530
Gunjan Gupta <viraniac@gmail.com> wrote:

(fixing Jernej's email) 

Hi Gunjan,

thanks for sending a patch!
 
> On some H6 boards like Orange Pi 3 LTS, some times U-Boot fails to detect
> ram size correctly. Instead of 2GB thats available, it detects 4GB of ram
> and then SPL just hangs there making board not to boot further.
> 
> On debugging, I found that the rows value were being determined correctly,
> but columns were sometimes off by one value. I found that adding some
> delay after the mctl_core_init call along with making use of dsb in the
> start of the mctl_mem_matches solves the issue.
> 
> Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
> ---
> 
>  arch/arm/mach-sunxi/dram_helpers.c   | 1 +
>  arch/arm/mach-sunxi/dram_sun50i_h6.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
> index cdf2750f1c..5758c58e07 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -32,6 +32,7 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
>  #ifndef CONFIG_MACH_SUNIV
>  bool mctl_mem_matches(u32 offset)
>  {
> +	dsb();

This looks a bit odd, do you have an explanation for that? And are you
sure that is really needed?
I understand why we need the DSB after the writel's below, but before that?
The only thing I could think of is that we are missing a barrier in
mctl_core_init() - which is the function called before mctl_mem_matches().
Can you move that dsb(); into mctl_auto_detect_dram_size(), right after
the mctl_core_init() call (where you add the udelay() below)? And I wonder
if a dmb() would already be sufficient? I noticed recently that the
clr/setbit_le32() functions don't have a barrier at all, maybe that should
be fixed instead?

>  	/* Try to write different values to RAM at two addresses */
>  	writel(0, CFG_SYS_SDRAM_BASE);
>  	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> index bff2e42513..a031a845f5 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> @@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct dram_para *para)
>  	para->cols = 11;
>  	mctl_core_init(para);
>  
> +	udelay(50);

The location of that udelay() looks a bit odd, any chance that belongs at
the end of mctl_channel_init() instead? And how did you come up with that
and the value of 50? Just pure experimentation? I think the original BSP
DRAM code has plenty of delay calls, so we might have missed this one
here, but I would love to see some explanation here.

Cheers,
Andre

>  	for (para->cols = 8; para->cols < 11; para->cols++) {
>  		/* 8 bits per byte and 16/32 bit width */
>  		if (mctl_mem_matches(1 << (para->cols + 1 +

