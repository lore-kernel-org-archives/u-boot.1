Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA63AE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A1E7805D5;
	Tue,  7 Jan 2025 13:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736253803;
	bh=QFfXzr2uJRLmO0k38eb5Kx5WkRkQMxrhqOWYmCAl3FE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xyI1dEaMN70DSpWhcKRqONgWyWGcdZJtZQyGNYoG6b7CxxVOM1nTlgh2uJ1nSmKvV
	 w6T9FZeBaGkv4T5GlzXl6NV7prL7AvakYrJddR6eilT6eHqIlEZvOOuvfDK+/T19Qf
	 XkYm5pZXvHbaPOCVlOa6SOhjKoqQQZUycGhLcRcWIEEV9CCketYZRfmRSHsoy0b7mi
	 w7V1LxLs+ggsCqFdaxEQ6egrotB3FmWAwlj48zpYcQcjVuYzZke4L44V0sKNFeRxGh
	 hhfd30Byk8C1plSMsyEsNSAFTu56RLdF3GVZkhEkDBZlaGjcKZDmTwWnylOKhyWf9m
	 RW1ELbewyBTlA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680C380079; Tue,  7 Jan 2025 13:43:22 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBE6805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YS9h41YnBz9swn;
 Tue,  7 Jan 2025 13:43:16 +0100 (CET)
Message-ID: <6851153d-b8f0-4404-9da2-1a3c288c37da@denx.de>
Date: Tue, 7 Jan 2025 13:43:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: rti: support SPL (or re-start)
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 08.11.24 22:15, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> If the RTI watchdog has been enabled in SPL, enabling it in U-Boot proper
> fails because it can only be enabled once in HW and never stopped. This
> however leads to a situation that wdt_cyclic() watchdog trigger is not
> being started any longer and the WDT fires at some point.
> 
> Allow for WDT re-start by not bailing out if the [previously] configured
> period matches the one to be configured.
> 
> Enabling in [A53] SPL has been tested on AM62x-based HW (where [A53] SPL is
> responsible for loading R5 DM firmware and not this driver).
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Applied to u-boot-watchdog/master

Thanks,
Stefan

> ---
>   drivers/watchdog/rti_wdt.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 99168d0cad03..320c5ca19e0a 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -131,18 +131,19 @@ static int rti_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	u32 timer_margin;
>   	int ret;
>   
> -	if (readl(priv->regs + RTIDWDCTRL) == WDENABLE_KEY)
> +	timer_margin = timeout_ms * priv->clk_hz / 1000;
> +	timer_margin >>= WDT_PRELOAD_SHIFT;
> +	if (timer_margin > WDT_PRELOAD_MAX)
> +		timer_margin = WDT_PRELOAD_MAX;
> +
> +	if (readl(priv->regs + RTIDWDCTRL) == WDENABLE_KEY &&
> +	    readl(priv->regs + RTIDWDPRLD) != timer_margin)
>   		return -EBUSY;
>   
>   	ret = rti_wdt_load_fw(dev);
>   	if (ret < 0)
>   		return ret;
>   
> -	timer_margin = timeout_ms * priv->clk_hz / 1000;
> -	timer_margin >>= WDT_PRELOAD_SHIFT;
> -	if (timer_margin > WDT_PRELOAD_MAX)
> -		timer_margin = WDT_PRELOAD_MAX;
> -
>   	writel(timer_margin, priv->regs + RTIDWDPRLD);
>   	writel(RTIWWDRX_NMI, priv->regs + RTIWWDRXCTRL);
>   	writel(RTIWWDSIZE_50P, priv->regs + RTIWWDSIZECTRL);

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

