Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81443C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE6587930;
	Thu,  4 Jan 2024 17:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="VL3lEzxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770A38796E; Thu,  4 Jan 2024 17:51:16 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA8187716
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704387073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=924GDkph7lF6O8li8F9cd/LLChONscPwWTMY9RMCTWs=;
 b=VL3lEzxomB2zJpB0sljiOJ2HVBDEPCkmQQAKjHaXlXNwl/gGy7bL70JLDeVwaHgHZvR7y5
 OHlMvb1ZMcZEDFKbZdJICGMuPQLV2o5ulc8D3IqwhJGYowjrE093iGHMra9t4aTzec4D5k
 YEGNWu2PGeDtmyqWXSpC66eRHVrArt+VfXGO8pHrgD61f6sXNPntNCBY8DIuI91jLqszhU
 ZT38wxIwsysONdgikM+Q+/lYltw0digEtoPBUhB2PM3ScstF2tgi/BE+TjyXHx37YNdxBo
 WjO+hYLOkmTwwgrhSy/hq2+gm+gQswEaijZP0bt62318oB2j177jq+MKA3Decw==
Date: Thu, 04 Jan 2024 17:51:13 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [resend PATCH] bootdev: avoid infinite probe loop
In-Reply-To: <20240104160346.285881-1-caleb.connolly@linaro.org>
References: <20240104160346.285881-1-caleb.connolly@linaro.org>
Message-ID: <e92d3669c76cfcd69375ef3c2f4b814a@manjaro.org>
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

On 2024-01-04 17:03, Caleb Connolly wrote:
> Sometimes, when only one bootdev is available, and it fails to probe, 
> we
> end up in an infinite loop calling probe() on the same device over and
> over. With only debug level log output.
> 
> Break the loop if we fail to probe the same device twice in a row, and
> promote the probe failure message to log_warning().
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Looks good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> Resend, actually change log message to WARN loglevel.
> ---
>  boot/bootdev-uclass.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> index d01d603700d9..cd1c2bc06774 100644
> --- a/boot/bootdev-uclass.c
> +++ b/boot/bootdev-uclass.c
> @@ -636,7 +636,7 @@ int bootdev_next_label(struct bootflow_iter *iter,
> struct udevice **devp,
> 
>  int bootdev_next_prio(struct bootflow_iter *iter, struct udevice 
> **devp)
>  {
> -	struct udevice *dev = *devp;
> +	struct udevice *dev = *devp, *last_dev = NULL;
>  	bool found;
>  	int ret;
> 
> @@ -686,9 +686,19 @@ int bootdev_next_prio(struct bootflow_iter *iter,
> struct udevice **devp)
>  			}
>  		} else {
>  			ret = device_probe(dev);
> +			if (!ret)
> +				last_dev = dev;
>  			if (ret) {
> -				log_debug("Device '%s' failed to probe\n",
> +				log_warning("Device '%s' failed to probe\n",
>  					  dev->name);
> +				if (last_dev == dev) {
> +					/*
> +					 * We have already tried this device
> +					 * and it failed to probe. Give up.
> +					 */
> +					return log_msg_ret("probe", ret);
> +				}
> +				last_dev = dev;
>  				dev = NULL;
>  			}
>  		}
