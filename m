Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907A8E6F066
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FB88902F;
	Fri,  1 Nov 2024 16:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wu8urIqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EEB89045; Fri,  1 Nov 2024 16:14:30 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C17789017
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so18346165e9.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730474068; x=1731078868; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JZr4+9g0ajNm45X1Bm2Sl2RZRfcwoGn3jeq0QyjOq/s=;
 b=Wu8urIqCRNPr5xO+9XmzGDvKTXvWfj+TAE7Rj/TEyXRsK4HjYTPZOhSKRPstIrA+kv
 4puywu6fibUGfbwohnx/ScLMDcXHRbbk2kraan0FvXhyBpaOeXmnDY3ldTwLcwj0I9DZ
 wkLBfefyDO8UEsL298iaf2W4H6eFr6LuHDjFL9O3jCiQr1bwlquuY4rgCzd8Cio+E0Wp
 LkM0BWcI6Zbzo7l8WKfiHVevolGZ54IUGlS/0ZXnxvOvvEhwyHqEv7KgtOPqiI3pU/cH
 cvJTLF8ljHYvtHjJIA8h7c584Mt25adicv0rSsCiEYcw/EcgRXefxAdsSkaKWHd0mp2i
 0wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474068; x=1731078868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZr4+9g0ajNm45X1Bm2Sl2RZRfcwoGn3jeq0QyjOq/s=;
 b=GVUK6qNlcdKjsZx+3i+vcGhUqTTVrJUO2T7Ql/BQyK6/seGCQyi2B0oByfritsv35g
 LzjVZn9HSNz0lBQ3DoRAF2wXO7q/3wGTztOlKij4sv/TsE5MRHzcVRvRXUDEazMFoJsC
 C+O6LwWj4dTHJgLiK3PH0T5FqQQAFhndg1DG1q6888atPrhYYtn2Iu37ZjEAxNIdovd6
 bZwr9Zgx2XslQvf6f+pTOcZVYOjmaAoHwEB0RdpvGoap6tTZ04H4BoMjEZ9Dwfg82AEx
 V70Ayflu/KEozpahiBcZcTm6euDUO8Yxq6F6MFTSqH7zKJ40GmcwfduRF5FFWtGjAhLb
 fCTA==
X-Gm-Message-State: AOJu0YwRwNs/AaqIdMmvQ/NTKjypstbSaZVGV9Sqy0fwSGYfYkpT1fUd
 FFxIrPi3bLWmEaGvbXjXwFwwNZDUBO+NX52/V1WQ8XKDHX1bYEgilx4lHW+JMb7QFR8FD4zGXoj
 c
X-Google-Smtp-Source: AGHT+IGAmNFJnA8m25wlC/5JaG6DdeZ39rQ4v5cZyGKiFBy9F5REL7emYmgWqsyb6+NS2dq4TrhALg==
X-Received: by 2002:a5d:6da3:0:b0:37d:4f1b:35a with SMTP id
 ffacd0b85a97d-381be7ae2acmr5438541f8f.3.1730474067599; 
 Fri, 01 Nov 2024 08:14:27 -0700 (PDT)
Received: from hera (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a99d3sm95719455e9.38.2024.11.01.08.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:14:26 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:14:24 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/8] arm_ffa: Add NULL pointer check to the driver
 operations
Message-ID: <ZyTwUFY-peThqXTe@hera>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
 <20241101142017.79311-2-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101142017.79311-2-abdellatif.elkhlifi@arm.com>
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

Hi Abdellatif,

Something is wrong on your setup and you only cc'ed people on the cover
letter.

On Fri, Nov 01, 2024 at 02:20:10PM +0000, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Add NULL pointer check for ops
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> ---
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> index 96c64964bb7..5ec7654ed1c 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + * Copyright 2022-2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
>   *
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> @@ -954,7 +954,7 @@ int ffa_partition_info_get(struct udevice *dev, const char *uuid_str,
>  {
>  	struct ffa_bus_ops *ops = ffa_get_ops(dev);
>
> -	if (!ops->partition_info_get)
> +	if (!ops || !ops->partition_info_get)
>  		return -ENOSYS;
>
>  	return ops->partition_info_get(dev, uuid_str, sp_count, sp_descs);
> @@ -979,7 +979,7 @@ int ffa_sync_send_receive(struct udevice *dev, u16 dst_part_id,
>  {
>  	struct ffa_bus_ops *ops = ffa_get_ops(dev);
>
> -	if (!ops->sync_send_receive)
> +	if (!ops || !ops->sync_send_receive)
>  		return -ENOSYS;
>
>  	return ops->sync_send_receive(dev, dst_part_id, msg, is_smc64);
> @@ -1000,7 +1000,7 @@ int ffa_rxtx_unmap(struct udevice *dev)
>  {
>  	struct ffa_bus_ops *ops = ffa_get_ops(dev);
>
> -	if (!ops->rxtx_unmap)
> +	if (!ops || !ops->rxtx_unmap)
>  		return -ENOSYS;
>
>  	return ops->rxtx_unmap(dev);
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
