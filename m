Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F134C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 21:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 672F8880FB;
	Mon,  8 Apr 2024 23:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="kwmZ9+ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7586E88134; Mon,  8 Apr 2024 23:17:15 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B9787EB4
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712611033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DhP7ycA9AxYkntS6kkpb1dHpZ5oYiFVLZGaHMpLmQbk=;
 b=kwmZ9+gaFxFniirYgFfA8Bhe4LyNvDN11osxjF1Px8RjeNCquyaiYZ3mM4jSWL117v+yKG
 FuvbjBVibaaLghxxo8S8Dkg8+y0/1JXjnhDYEt4NTJ0LdNj2PUgZMjl1+XD2kcAn7zMesA
 Ko/wbrU0M9cIoydjwT1tWfTQFkPxkQ93+2Wql+JeM6C8bYaFj7Vo0VLn94uzc8WPXq52qS
 1eRPt5xOvCKQOvPb/3umvDal9HsJ7GSuGVHhkn604OSlLbjiAbr9VnLdfSN0GgRj+GPd+A
 mf4cP12EevkVZsoAKHJPSLZrBJSkgEtB/STewLKVmP+0+wREzMnfR6dxfDMEPQ==
Date: Mon, 08 Apr 2024 23:17:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
In-Reply-To: <20240408210619.3749231-1-jonas@kwiboo.se>
References: <20240408210619.3749231-1-jonas@kwiboo.se>
Message-ID: <a3181a7c7f718818fc7646658b574fed@manjaro.org>
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

Hello Jonas,

On 2024-04-08 23:06, Jonas Karlman wrote:
> eMMC nodes in linux device tree files typically only contain a 
> mmc-hs400
> prop to signal support for both HS400 and HS200. However, U-Boot 
> require
> an explicit mmc-hs200 prop to signal support for the HS200 mode.
> 
> Fix this by follow linux and imply HS200 cap when HS400 cap is signaled
> using a mmc-hs400 prop.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

The description above should use "Linux" instead od "linux", but that's
perhaps not worth sending the v2.

Otherwise, looking good to me.  Great job catching this!

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> This fixes booting from eMMC on nanopc-t6-rk3588 and quartzpro64-rk3588
> that probably broke with commit 6de9d7b2f13c ("rockchip: rk35xx: Enable
> eMMC HS200 mode by default").
> ---
>  drivers/mmc/mmc-uclass.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 328456831dd2..1349da72b102 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -251,9 +251,9 @@ int mmc_of_parse(struct udevice *dev, struct
> mmc_config *cfg)
>  	if (dev_read_bool(dev, "mmc-hs200-1_2v"))
>  		cfg->host_caps |= MMC_CAP(MMC_HS_200);
>  	if (dev_read_bool(dev, "mmc-hs400-1_8v"))
> -		cfg->host_caps |= MMC_CAP(MMC_HS_400);
> +		cfg->host_caps |= MMC_CAP(MMC_HS_400) | MMC_CAP(MMC_HS_200);
>  	if (dev_read_bool(dev, "mmc-hs400-1_2v"))
> -		cfg->host_caps |= MMC_CAP(MMC_HS_400);
> +		cfg->host_caps |= MMC_CAP(MMC_HS_400) | MMC_CAP(MMC_HS_200);
>  	if (dev_read_bool(dev, "mmc-hs400-enhanced-strobe"))
>  		cfg->host_caps |= MMC_CAP(MMC_HS_400_ES);
