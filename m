Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80813C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD65B803DF;
	Fri,  4 Jul 2025 14:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VYvE6YLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 289F28206E; Fri,  4 Jul 2025 14:12:35 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A193801BE
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F9DD3F921
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 12:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751631152;
 bh=F2UqRnQq+IxyUu7HClGP6irTmHw730wmRgaL4F1NDIs=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=VYvE6YLzsQSHCajxinicx2iDUn4x8HoVPErqAk+MgI6KlLOMovrDS+9jAEe0Ca4d9
 rdl/HR/xK+ix0IlRqdUXjdwsBlFKD16BGgOM8cnJwTfzs0ib+fFK06KVl7zPo+kXIt
 TP5Yh4y8Ipqcp1yjBfwWTX8cyiRn6EnJYYqiC7YadeULj4Jneo187sIQtgfMZKp+xt
 dOEjCe9NNP1A/DI28CkmUjzHMcjFCY3h4u7r88WnF7qW4CQRtMyqF0noZfH56NTqNF
 +zjQrQbhvJCnbB8Ron3GAqd1USRhsj/nkk9Dzc5qnUVnsCO4bURwfKlCnGSdDEZTQl
 XmP3LMhlVi8pg==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae3c5ed22dfso82308666b.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751631152; x=1752235952;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F2UqRnQq+IxyUu7HClGP6irTmHw730wmRgaL4F1NDIs=;
 b=NApRyiQV3akqEPTvQnzf+hyEGSaKDBtsiZcXIA9NN0Vr7BORyMxSSGc9P8DRR+5Kc2
 AHvLZTl5qOV65hQmQAHAcKeoqUc7BcQDZaCK8Mu2uJh6DKFy5q0//LzD6ZVkhQ+5lm+H
 lv5/FEYyQEVekgFbTC1JDscD/EfLeh765Dg4Zg1G+ZkTQZmMH/zCAcqr2hm8MGqR8BoO
 LoE1b4ct5CvLrvlAxjcXUhDDwhrjGppnTXMk6FXu3/Ln9Jz5yca9cqNbNfjiZNEOt8qp
 7aNnFOdVGVTOKyeTXd3qyh1v0PC1AB8bRZGU3xpdpduT8n5syN/J2UOri3DKBoioelLb
 EYsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj+v2lDLbhJhY0Wp5HG6qmSrrVnjTBlQD1zE/gPY5bOydn61MoAAnI57j7J+ddcu/Jv5ftNxk=@lists.denx.de
X-Gm-Message-State: AOJu0YxDsKp/fVwa1oWCSSLy5hNzn6N9gbr/+/M3x3yZg/PCkuR3e0XW
 7py4hEV8y0XIQBUWkthA9uiEz+/BA2Oz0k9C8WWEOHRg0f6tOUDplKjN/0kDdI5qYA3waMmmOXK
 /q3ri+bCwVNE3R0M0dwxtovDh62T9DEZcCgeeEM3A5JSyJ36HxvyZC3y2wQ2R5iyGj1WZxVo=
X-Gm-Gg: ASbGnct1oREPIkMrHYshexR+VrCz0QwkynbAqwYZQtjqSUaTiE2j8Py/Py8qRMYugh5
 CSnJWbw7fX/dOi1a1ubptOBI5brbrX6BOkAYfP48zd6UiTpbUCdhWdr5QGT5DdogND16+gVCeN6
 Rz+n/h+N/TLIh84rz8FV0ZiG38xYnJ3nNBBCqRk6LnezosuumWQ+f0n1K2QvORrv0KpnIRF/jnQ
 bvoUZYo3O8agct/X1bcnQROUVJjPOzoGZ+af0Kk8RaQSIdiqwn0pHwp0xJU9IY4wyrwM3I97+YB
 gdaXddy3JzeJdKKbDktV2n90sDS6I0EJ6wYrY6Q3YOz3nSlz9bUSiV1mCVNvTXdlJxgG7BiMGgg
 94w==
X-Received: by 2002:a17:907:9815:b0:ae3:9ec1:9c03 with SMTP id
 a640c23a62f3a-ae3fbd4a32bmr230704666b.37.1751631151802; 
 Fri, 04 Jul 2025 05:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTYlQ6EdrU3AorYEve5yJzbWBWaSmFpBOHsLM/bhrG2H8MC67vhHkQT9xSdRiiqhPKcQWdYg==
X-Received: by 2002:a17:907:9815:b0:ae3:9ec1:9c03 with SMTP id
 a640c23a62f3a-ae3fbd4a32bmr230701366b.37.1751631151382; 
 Fri, 04 Jul 2025 05:12:31 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac45easm162381066b.100.2025.07.04.05.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 05:12:30 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <602b2d22-dfd1-4fd7-9e78-371c5b37158b@gmx.de>
Date: Fri, 4 Jul 2025 14:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] arm_ffa: Add NULL pointer check to the uclass
 driver operations
To: abdellatif.elkhlifi@arm.com
Cc: trini@konsulko.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
 <20250702152528.1180414-2-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
In-Reply-To: <20250702152528.1180414-2-abdellatif.elkhlifi@arm.com>
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

On 02.07.25 17:25, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> Add NULL pointer check for ops
> 
> The device driver can miss defining an operations structure.
> So, ffa_get_ops() can return NULL.
> This commit adds checks for ops in the uclass driver operations
> and an error is returned when ops is NULL.
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/firmware/arm-ffa/arm-ffa-uclass.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> index 96c64964bb7..f8d231204db 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
>    *
>    * Authors:
>    *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> @@ -954,6 +954,9 @@ int ffa_partition_info_get(struct udevice *dev, const char *uuid_str,
>   {
>   	struct ffa_bus_ops *ops = ffa_get_ops(dev);
>   
> +	if (!ops)
> +		return -EINVAL;

uclasses that use ops typically don't check for NULL.

Why would we have an FFA driver without ops?
Would such a driver be of any use?

Best regards

Heinrich

> +
>   	if (!ops->partition_info_get)
>   		return -ENOSYS;
>   
> @@ -979,6 +982,9 @@ int ffa_sync_send_receive(struct udevice *dev, u16 dst_part_id,
>   {
>   	struct ffa_bus_ops *ops = ffa_get_ops(dev);
>   
> +	if (!ops)
> +		return -EINVAL;
> +
>   	if (!ops->sync_send_receive)
>   		return -ENOSYS;
>   
> @@ -1000,6 +1006,9 @@ int ffa_rxtx_unmap(struct udevice *dev)
>   {
>   	struct ffa_bus_ops *ops = ffa_get_ops(dev);
>   
> +	if (!ops)
> +		return -EINVAL;
> +
>   	if (!ops->rxtx_unmap)
>   		return -ENOSYS;
>   

