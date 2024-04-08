Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CD2C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 21:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7587088165;
	Mon,  8 Apr 2024 23:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="mG2uk6CE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E4C8817C; Mon,  8 Apr 2024 23:17:27 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E58188165
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712611045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGZPQpAN01ckjtqeo2bf9+p7HfyADyYvt6/8FIrVD4E=;
 b=mG2uk6CEVcUfD+OtF0Ke4sitvDnWwwXspoTKKk7kBFqkSEXrqwOmYND4PE6RtNqgpkhauE
 WCJ57BCYHyoEAlBVrOw4g8IyipIxUjCvIJ/gq6Wz/LBiES9b6QDbf5qkHipBx/wf506XtV
 Y5MSXul5UOwLuvIdDaqceRSc9Ye+aQcP+1BCBpTW2Xt/rh1N7d78Om+M0qEvKfIhAOidfs
 Sp4qsj667j2a7sAAzsfHWlvT8Q9GXeVzkW8C+CXA8FbMh4wtGx619wYPBM0Tt0TK2iyqhB
 Vjsm81Zanqwg2+rDHRLQY/PanmNzCGXD/ZwJugkW6dsQ2XJsKjwR9GTpVyiiwQ==
Date: Mon, 08 Apr 2024 23:17:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] mmc: Add support for the no-mmc-hs400 prop
In-Reply-To: <20240408210619.3749231-2-jonas@kwiboo.se>
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <20240408210619.3749231-2-jonas@kwiboo.se>
Message-ID: <8a08e5e3d7b1001f28878154078412b4@manjaro.org>
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

On 2024-04-08 23:06, Jonas Karlman wrote:
> The linux commit f722e650d965 ("mmc: core: add support for disabling
> HS400 mode via DT") added support for a no-mmc-hs400 prop.
> 
> Add support for the no-mmc-hs400 prop to disable HS400 host caps.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

The description above should use "Linux" instead od "linux", but that's
perhaps not worth sending the v2.

Otherwise, looking good to me.  Great job catching this!

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/mmc/mmc-uclass.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 1349da72b102..1b454e8ec758 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -256,6 +256,9 @@ int mmc_of_parse(struct udevice *dev, struct
> mmc_config *cfg)
>  		cfg->host_caps |= MMC_CAP(MMC_HS_400) | MMC_CAP(MMC_HS_200);
>  	if (dev_read_bool(dev, "mmc-hs400-enhanced-strobe"))
>  		cfg->host_caps |= MMC_CAP(MMC_HS_400_ES);
> +	if (dev_read_bool(dev, "no-mmc-hs400"))
> +		cfg->host_caps &= ~(MMC_CAP(MMC_HS_400) |
> +				    MMC_CAP(MMC_HS_400_ES));
> 
>  	if (dev_read_bool(dev, "non-removable")) {
>  		cfg->host_caps |= MMC_CAP_NONREMOVABLE;
