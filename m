Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A101CCD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3601383EEF;
	Mon,  8 Jun 2026 11:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="tjbGRjvr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69CD4846A7; Mon,  8 Jun 2026 11:36:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DD37C807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BBAC3290;
 Mon,  8 Jun 2026 02:36:33 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 63B163F86F; Mon,  8 Jun 2026 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780911398; bh=4dIhojNCC/evGjuZU+Ndktpm9LuvQAY2lMaQ06gCeko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tjbGRjvr7G4gRJbWCRoab0nidQhc5voPk0VA/SC5GtpdnIuC7wu8cLw8KrDnr6KYP
 ipActPQwbFjfJpLOBxzmEFf2OVbSK7fDGUekT5wXN9fSEwq/cxdSiVzkRQhm/CDty1
 pVFR89SZXSvbfHDLgWmp/ru6xHTSwn5amYl75Eso=
Message-ID: <325826f8-659c-4237-a55a-6027d2297aa2@arm.com>
Date: Mon, 8 Jun 2026 11:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH mmc: sunxi: fix MACH_SUN9I typo in get_mclk_offset()
To: Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
References: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Omar,

On 5/26/26 23:28, Omar Ivan Fardjoume wrote:
> Hi, first thanks for everything you do.
> I was working on reviving a cubieboard4 a80 board and I found and fix
> two issues that prevented eMMC from working on sun9i-A80 boards:

ah, very nice, thanks for taking care and posting stuff upstream!
I have some patches to enable Ethernet on the board (or rather all A80 
boards), I should probably post them now there is at least one user ;-)

> 1. The get_mclk_offset() function used the non-existent Kconfig symbol
>     CONFIG_MACH_SUN9I_A80 instead of CONFIG_MACH_SUN9I, causing the

Ouch, nice catch. While at it, I grep'ed the whole tree, seems to be the 
only occurrence of that mishap, though.

>     MMC2 clock register to be written at 0x06000090 instead of
>     0x06000418. This corrupted the CMD2 response and made eMMC
>     completely unresponsive.
> 2. The legacy (SPL) sunxi_mmc_init() did not include CONFIG_MACH_SUN9I
>     in the 8-bit bus width condition, so MMC2 (eMMC) would only use
>     4-bit mode in the SPL, which is insufficient for reliable boot.

Ah, yeah, seems right.
While looking at it, I am wondering if we should rephrase that 
statement, for instance to just exclude the older ones. Though I am 
wondering why we have this filter anyway: I see that we have at least 
one sun6i board with 8-bit eMMC.
Need to have a deeper look into this.

> Tested on a Cubieboard4 A80: with both fixes, SPL loads U-Boot proper
> and boots Debian 12 from eMMC with no SD card present.

I tested this briefly (though just in U-Boot proper), and it indeed was 
broken before and works now.
Have you tested the eMMC boot partitions? Then we should add 
CONFIG_SUPPORT_EMMC_BOOT=y to the defconfig. Will have a look myself 
tonight.

Btw: the patch seems mangled (tabs converted into just a few spaces), 
but I can fix this up before merging.

Thanks,
Andre

> Signed-off-by: Omar Ivan Fardjoume <ivan.fardjoume@email.com>
> ---
>   drivers/mmc/sunxi_mmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 4c5fbf8960f..3d5e7c1a234 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -546,7 +546,7 @@ struct mmc *sunxi_mmc_init(int sdc_no)
>    cfg->voltages = MMC_VDD_32_33 | MMC_VDD_33_34;
>    cfg->host_caps = MMC_MODE_4BIT;
> 
> - if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
> + if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I)
> || IS_ENABLED(CONFIG_MACH_SUN9I) ||
>        IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> IS_ENABLED(CONFIG_MACH_SUN55I_A523)) &&
>        (sdc_no == 2))
>    cfg->host_caps = MMC_MODE_8BIT;
> @@ -663,7 +663,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
> 
>   static unsigned get_mclk_offset(void)
>   {
> - if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
> + if (IS_ENABLED(CONFIG_MACH_SUN9I))
>    return 0x410;
> 
>    if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))

