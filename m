Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744F8C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AC71407D3;
	Mon, 17 Aug 2026 15:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V1f-EEdWw5Fp; Mon, 17 Aug 2026 15:59:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3A1540756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786982356;
	bh=zo0E4Rm61XfO8yqwl7mvUWFRABFfKNV7+WGFp7nyvwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S9aa+VEa2ULojn3PYQ9Eji0fO3cof1uVRlR2a+lmP0LttUqYv9JJyfGD/fTW9Gnm3
	 OuxTiLYZGRnG+5zWcoY+/2DwOAWy0uu+beZ//CjKSUoRdhPzU6mU5qybeXhKE+Ptxo
	 YmjX7se/x0YPFSvYXfs7Q0ceI2+SnPsN9SXumRTcOE6BZvFtvcXnBmye8Lf2uhYmi4
	 Da1RjUeXeFKsq34NijL+mXcVqCh20xvlu634XWCb8aeO03OwInhRF3Bp8v/tPSaVC3
	 ThKsrG5V318LPyBjeUZjN3FLOEDXQb5nvGNLqqT7aXxLHYhtk8zz2cc4UlZhaUnPnJ
	 WvXj0shMRuryQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3A1540756;
	Mon, 17 Aug 2026 15:59:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 201AF333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0652D40200
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIpwEPTUJ674 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:59:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E7AF1401E5
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7AF1401E5
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uBbz0CKd
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7AF1401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:59:13 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f84023916so3388667f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786982352; x=1787587152;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zo0E4Rm61XfO8yqwl7mvUWFRABFfKNV7+WGFp7nyvwM=;
 b=uBbz0CKdOX4ClKi/oh+2d17Oqm39oJokmPGw2KtgHx6tq7t8TrRivm1mNl05Zyue0C
 f+I/kcKyzN7FHcL4qgMthLWcyeO871Wi1jro9VFn+e8Z/NEQa/cGV4GvS2KLk2ylfT7d
 hlzsF8/kMd5KUIvynbPxEVO1qO07LIDLMdRKVeD1FUqlEVrpBs7zszvfWxaBa1l9+XWd
 uMKC8Q3IP78wW48nn53I51jSWzFjCe0fzv7Ip+4sUwKOGRcwmL7heAFoM52iog7s563x
 mAov7CoE5U+Y2eRKzFZ/oKZqkUq2xVZ5WpzDWR9Md8vTQHRmsJ4AlfrbTybV+kGSXTCW
 Rf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786982352; x=1787587152;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zo0E4Rm61XfO8yqwl7mvUWFRABFfKNV7+WGFp7nyvwM=;
 b=VA3x4BxQkkiQTQ8jU3eK06CKzEguHjXWRNuWpJ7UmBiFvBZSEShyyPahBRnHOD/4mm
 SbmLO5EqfY9q8CtWLkhgZis2d+xPo5QjdgXPHRGUlFmKPXoni3bjGyNDBTlmrPHIU2zb
 3MBCuvXGYaXuOgmmWjdvLiE0WBtr4SQicjT6VYPbIiDsLJolir6e4sUSbSchK2FIDd61
 92daA+jFPlF2tgR46G4oS8OXopq1oItmB7dxNMULC8VXyH7z5OTgHz0THnzqyE1Ljm7g
 AcpuJlJLuPDdcwwe7/KyZKxVLw5ZVYWMh6KAglLVIWBXCWYZ5sQr7TrTXR0g7zA0xcTL
 q/iw==
X-Gm-Message-State: AOJu0YwmhKh9NveOl3BEZDSe+HZdIpLGRPTadw2rID6RxFz1HFVazU02
 VC1h6T/F1jEgXfF+5LWUDcnKoOLZmW+GtmrDrIYuDPf98/K16L4kLcITAts/FrTSY5hE7GcRvuC
 v6EZ9RkQ=
X-Gm-Gg: AR+sD11GR52gDfzmj10+mbs45MkL7FEcitsBm0kNt8ozLpY8EaR0re0AphjnWoGs22H
 Q1z0vgqo5iAO1AMT3ftwsHX0LSJVtvPVUlCcc7flfoUibhxNP8SwPzMqJupTzxHgJigoFlpzAqd
 5MVbc0n8CvJ1O8WRWSSCyLxr2iTIam7lonZFSP4sqS27fUlvRmmGw+z7I7RHH4v8OYBzdPMt8X5
 XNS2OqCxv1IsvcT2/DvPsu1aeNjb6HmE5kFZefa9F6Y/NwGBXAjvICsjocqSLN/3nXeQHvPabd4
 LiHJVWY8zkuZxsZsr6xqChRVq6MTldcwqtVxzX792dWQ66RoXBxEV2oH/SHBvA7Bwu7LO3mwuuy
 uW0EOKDjhmfofkF1lgr4ydT9WMUj0ooMUFA6ndafaTPBJdBevW3p0oO0qU+6KIScqBF+OGfdzBc
 ps4CD4XeuRlxrH2UmIWfUSvpUn30Wx0I1mYfsuos4KCKMdo+w8r3jrfbT072xuQPCexzfYRPP/
X-Received: by 2002:a05:6000:480c:b0:47f:9283:1fbe with SMTP id
 ffacd0b85a97d-482a8fde687mr2548229f8f.0.1786982351351; 
 Mon, 17 Aug 2026 08:59:11 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:ee4a:c814:cb38:c5b9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b81748sm5414198f8f.37.2026.08.17.08.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:59:11 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:59:09 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 2/8] mmc: arm_pl180: Configure Ux500 signal direction
Message-ID: <aoMvzdZpiH5KdGmg@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-2-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-2-ca9a110bd9c6@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Aug 17, 2026 at 11:31:51AM +0200, Linus Walleij wrote:
> The Ux500 MMCI variant can control external level-shifter signal
> directions through the power register. Parse the standard ST MMCI
> device tree properties and set the corresponding direction and
> feedback-clock bits.
> 
> This is required by the external SD card slot on Samsung Janice, where
> commands cannot reach the card unless the direction controls are set.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> ---
>  drivers/mmc/arm_pl180_mmci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index f00b0ff0dc95..af21b814641e 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -427,6 +427,19 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
>  		host->version2 = false; /* ARM variant */
>  	}
>  
> +	if (dev_read_bool(dev, "st,sig-dir-dat0"))
> +		host->pwr_init |= SDI_PWR_DAT0DIREN;
> +	if (dev_read_bool(dev, "st,sig-dir-dat2"))
> +		host->pwr_init |= SDI_PWR_DAT2DIREN;
> +	if (dev_read_bool(dev, "st,sig-dir-dat31"))
> +		host->pwr_init |= SDI_PWR_DAT31DIREN;
> +	if (dev_read_bool(dev, "st,sig-dir-dat74"))
> +		host->pwr_init |= SDI_PWR_DAT74DIREN;
> +	if (dev_read_bool(dev, "st,sig-dir-cmd"))
> +		host->pwr_init |= SDI_PWR_CMDDIREN;
> +	if (dev_read_bool(dev, "st,sig-pin-fbclk"))
> +		host->pwr_init |= SDI_PWR_FBCLKEN;
> +
>  	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
>  
>  	ret = mmc_of_parse(dev, cfg);
> 
> -- 
> 2.55.0
> 
