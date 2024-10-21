Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C78D15DB8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9340788E3A;
	Mon, 21 Oct 2024 18:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aML2WAg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB2588DB2; Mon, 21 Oct 2024 18:10:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4BC88E19
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a2e0=RS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729527017;
 bh=B9PzkfCMatxgFrXAGynY9/9xi3rqU9th8N75auu1sQ8=;
 b=aML2WAg0PzaCsolWcwa0jkG1wqq2OtreyOxblSDbkMkzK/l2uZpKfi8WZ/GwzisONfhu+Ysg8
 uDfLB2qXvYlFIamONBenNavqbs2t7Z/L8KArXBOIRn8qd14JmZ9rLiq119g3oDx+o4ZLPSd57/o
 HKoruKmzHU+qvAwxJdz35yji71HKVz/1RZWQ8Ggtm+OoHq9tDLd+3d44EdHizH8Ac2C159w+IlP
 W0pF6ohZHLg5xa3IiQ3CtXq3THc0pFzOdynzNkzm16WhmNbGzhA/BhShB+wKfHVFdXV2Zmy4Jc2
 EAlF9BsIQ4zFcklvWX2C9mkrWGC1yL48aM2sqiim6x9w==
Message-ID: <81b0a377-6669-46c6-9da8-c83d9758587e@kwiboo.se>
Date: Mon, 21 Oct 2024 18:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] common: Move autoprobe out to board init
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>, Artur Rojek <artur@conclusive.pl>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
References: <20241021155133.29557-1-sjg@chromium.org>
 <20241021155133.29557-4-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241021155133.29557-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67167ce78d3131205d38af85
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

Hi Simon,

On 2024-10-21 17:51, Simon Glass wrote:
> Rather than doing autoprobe within the driver model code, move it out to
> the board-init code. This makes it clear that it is a separate step from
> binding devices.

It could probably be good to mention that after this patch the events
EVT_DM_POST_INIT_R/F will happen before autoprobe instead of after.

> 
> For now this is always done twice, before and after relocation, but we
> should discuss whether it might be possible to drop the post-relocation
> probe.

If you have plans to drop post-relocation probe, I suggest you first
look into having OF_LIVE working at pre-reloaction to speed up boot, the
use of fdtdec is super slow in getting parent node/offset.

> 
> This patch also drops autoprobe from SPL. If that is needed, we could
> add a call in SPL.

This patch will break a feature used by the Pine64 PineTab2 because of
this change, please restore autoprobe in SPL.

The PineTab2 have a feature to power itself off when power-on happen
because of power cable was plugged in, for this to work it currently
depends on DM probe after bind works in SPL.

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  common/board_f.c    |  4 ++++
>  common/board_r.c    |  4 ++++
>  drivers/core/root.c | 17 ++++++++++++++---
>  include/dm/root.h   | 10 ++++++++++
>  4 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index 8684ed71284..6564b2ac2f7 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -822,6 +822,10 @@ static int initf_dm(void)
>  	if (ret)
>  		return ret;
>  
> +	ret = dm_autoprobe();
> +	if (ret)
> +		return ret;
> +
>  	if (IS_ENABLED(CONFIG_TIMER_EARLY)) {
>  		ret = dm_timer_init();
>  		if (ret)
> diff --git a/common/board_r.c b/common/board_r.c
> index e5f33f40643..a2948b7b55c 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -243,6 +243,10 @@ static int initr_dm(void)
>  	if (ret)
>  		return ret;
>  
> +	ret = dm_autoprobe();
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index 2d4f078f97f..f6bda84b2b9 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -281,7 +281,7 @@ void *dm_priv_to_rw(void *priv)
>  }
>  #endif
>  
> -static int dm_probe_devices(struct udevice *dev)
> +static int dm_probe_devices_(struct udevice *dev)

Why is this function renamed?

Regards,
Jonas

>  {
>  	struct udevice *child;
>  
> @@ -294,7 +294,18 @@ static int dm_probe_devices(struct udevice *dev)
>  	}
>  
>  	list_for_each_entry(child, &dev->child_head, sibling_node)
> -		dm_probe_devices(child);
> +		dm_probe_devices_(child);
> +
> +	return 0;
> +}
> +
> +int dm_autoprobe(void)
> +{
> +	int ret;
> +
> +	ret = dm_probe_devices_(gd->dm_root);
> +	if (ret)
> +		return log_msg_ret("pro", ret);
>  
>  	return 0;
>  }
> @@ -331,7 +342,7 @@ static int dm_scan(bool pre_reloc_only)
>  	if (ret)
>  		return ret;
>  
> -	return dm_probe_devices(gd->dm_root);
> +	return 0;
>  }
>  
>  int dm_init_and_scan(bool pre_reloc_only)
> diff --git a/include/dm/root.h b/include/dm/root.h
> index b2f30a842f5..2ba5104ce1f 100644
> --- a/include/dm/root.h
> +++ b/include/dm/root.h
> @@ -136,6 +136,16 @@ int dm_scan_other(bool pre_reloc_only);
>   */
>  int dm_init_and_scan(bool pre_reloc_only);
>  
> +/**
> + * dm_autoprobe() - Prove devices which are marked for probe-after-bind
> + *
> + * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
> + * entire tree, so parent nodes need not have the flag set.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int dm_autoprobe(void);
> +
>  /**
>   * dm_init() - Initialise Driver Model structures
>   *

