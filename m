Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18887D41C27
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 09:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4879689554;
	Wed, 13 Nov 2024 10:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="PcEu/hTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9CDD894C4; Wed, 13 Nov 2024 10:48:33 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E572F89555
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1731491310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiKBhVSR90QRHWUcu1b+akorW995Uq2GjLlZUqa3Zcg=;
 b=PcEu/hTbPY2DOztndyawbltxcWzXWAsZ30Z4h+V2heELdNqbbiEDM/KbgpgMyRhTpm8sDb
 Ptuxv5vno2lxLsM97BDdClS60Olw1KImzHEnHRXedreKqtws0Zy0yBhI8gdoJGBugB20Mk
 6Qett0uKGwtiIjxw91PhKqg6GBf9rwlQ5td9Rlsre9kTFR6Jl1bR2g8yLbfdhpDJ3iTTpl
 XmSMZdPD52GASnhkdCP65g4yGd8NII0aTXueR5Lys/UxhLRAMis//+74fXDqoZKz5/Sz2U
 aapJJufbVjqcs1dac/iXlQv76LMFjH+A2VkM8a+cZpATIpxJsZKQPd8l4y9BPw==
Date: Wed, 13 Nov 2024 10:48:29 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman
 <jonas@kwiboo.se>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
In-Reply-To: <20241113053023.1870736-1-caleb.connolly@linaro.org>
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
Message-ID: <50f69678f0fbb74aecc2e2aeb5f4dc6b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Caleb,

Thanks for the patch.  Please, see a comment below.

On 2024-11-13 06:30, Caleb Connolly wrote:
> It may be the case that MMC support is enabled even though the board
> we're booting on doesn't have any MMC devices. Move the print over to
> the print_mmc_devices() function where we can only print it if we
> actually have MMC devices.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/board_r.c         | 1 -
>  drivers/mmc/mmc-uclass.c | 4 +++-
>  drivers/mmc/mmc_legacy.c | 5 +++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/common/board_r.c b/common/board_r.c
> index 62228a723e12..232a8fd19f03 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -384,9 +384,8 @@ static int initr_onenand(void)
> 
>  #ifdef CONFIG_MMC
>  static int initr_mmc(void)
>  {
> -	puts("MMC:   ");
>  	mmc_initialize(gd->bd);
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index c8db4f811c2f..56fe29249c36 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -384,9 +384,11 @@ void print_mmc_devices(char separator)
>  	     dev;
>  	     uclass_next_device(&dev), first = false) {
>  		struct mmc *m = mmc_get_mmc_dev(dev);
> 
> -		if (!first) {
> +		if (first) {
> +			printf("MMC:  ");
> +		} else {
>  			printf("%c", separator);
>  			if (separator != '\n')
>  				puts(" ");
>  		}
> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
> index 8f8ba34be717..f4a049a4a4d4 100644
> --- a/drivers/mmc/mmc_legacy.c
> +++ b/drivers/mmc/mmc_legacy.c
> @@ -98,8 +98,9 @@ void print_mmc_devices(char separator)
>  {
>  	struct mmc *m;
>  	struct list_head *entry;
>  	char *mmc_type;
> +	bool first = true;
> 
>  	list_for_each(entry, &mmc_devices) {
>  		m = list_entry(entry, struct mmc, link);
> 
> @@ -107,8 +108,12 @@ void print_mmc_devices(char separator)
>  			mmc_type = IS_SD(m) ? "SD" : "eMMC";
>  		else
>  			mmc_type = NULL;
> 
> +		if (first) {
> +			printf("MMC:  ");
> +			first = false;
> +		}

Can't we simply check for "entry == &mmc_devices->next" here and
avoid the introduction of "first"?

>  		printf("%s: %d", m->cfg->name, m->block_dev.devnum);
>  		if (mmc_type)
>  			printf(" (%s)", mmc_type);
