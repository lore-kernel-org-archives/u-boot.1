Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD6C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A208215E;
	Wed, 30 Apr 2025 16:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cHjK6App";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1563A8215F; Wed, 30 Apr 2025 16:57:58 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E304D8210F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5f6c3f7b0b0so13810026a12.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025075; x=1746629875; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CsfOfnxTLsj8CKus/aD3W2fIg7OlIKV0+V8fn0r09iM=;
 b=cHjK6AppHFIbonRKsLMgf/yeFqQN8gmU1y8Jco14ArlgU5LiJyLi92IyUvva9hXU1u
 gnt03gnakO0Qmv7m9sCm+C6sABB6H5hcjApD+VGW7LQwfxC4P1V4i+nX3VxzrC+I12+Y
 AmG8xD7AJwV06tY1uP5fr/SM/HOEBqbVJQgrx9kaSOVMRLBKWuxrfj8+RGnccYWmK7Gs
 O4+pbI3fgyfdC0gv/6joxQpLOqTMqhFsLE3fnA83b1I/HAt1NHwI3yqr13eFnjB8annK
 /GiOS0wKY6H6+RfiMvUsLx+9dO9WESXbjUFjYXgsac0xUz24/fTftw4EcdGLlMAVy2g/
 duqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025075; x=1746629875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CsfOfnxTLsj8CKus/aD3W2fIg7OlIKV0+V8fn0r09iM=;
 b=wQ6gcywEYMZNavwFzXYv8DV4sodmgftnsQh2s9uTH3yO4xl91XLQ15olMnr1wXZPgu
 psk6iEukWXRv81T4IuT1xoraf1R6XIzAipMy1GWsMB7RacQl/F/nkpJ4V4XMr7iBUbQa
 2oyMNljGqChKbIft66qISV3D5c5DG4ZSGVp77yipewrxDf5MbWFGkYOXeIhADbDFbGbF
 swi8Cy2dboTdY6/oM2/5accBvyEeYbYz2GcBBwIpMO8FE31sKvMMZKtthMvennKdR+rt
 5ooqxw3TAWSBJR90CcwfPFnwaZbHlubtjtvOR2x30eeM1DwDzWzYBbNPIvOdZi/VffQq
 KVIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFbmbRYgobm18q6DEEo7w4fbUMK5HCLKab1t/CIW0/Sulf6E7baUb9bVzy/LnnVboqCqOELgM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3NJ+oigw5fjl/lIivAoCaIFNHBRUBi9ZGkGpQvcW5dbGF8jZO
 NXzW3eHB3KTXtYk3Ov8W1ykDA6SCsR5b/njNLxnPIiIXK8CEIQa7R3FONDZq4zeZnClY9ioM9+v
 fIsY=
X-Gm-Gg: ASbGncud3E/HtRCqTWv/SaNquO8I10OWdTgOIFWPPbvLKhKjQwBhzFoEAc8cPZPdI7y
 GytdmdhO47pxM2W/0lYd8nskkdkUiDr1GyV6pZUQBfUW1MzIvmDjBDNSceVoK6wW8EMghP1eh1Z
 oXGENyIjmc0jYTafdu8M/+RI7Urb8R6jQD067ygua8tdpDTNXkF3+gUoz0y6iJ2LeX7mFg2+eaR
 NGibcA1KWlD/LBzjcx0vCvMjzCHyH5G0cFZ4Fi7iMOMvDwvKl5rRMFZa4fDqicAxNVbvRzS8qvR
 xJEG1jNbKudFcGoXlcGnqcOiqt/u/tivluGyi0dbNETgoImpJuuwBdRHN6kXs9F9vQ+ADyBzTxj
 lGzrqXkB+m580+5fwzPIT
X-Google-Smtp-Source: AGHT+IFdWyc1Us1mLFcLFXR9zkp5n6VSxfH7a6qxWqexRiF2QTvK8YEoc8H35HmJ9QkOKHXcZ496qA==
X-Received: by 2002:a05:6402:2353:b0:5f7:eaf0:8826 with SMTP id
 4fb4d7f45d1cf-5f89b254f87mr2917488a12.16.1746025075361; 
 Wed, 30 Apr 2025 07:57:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b269:e2f0:3646:3c73?
 ([2a01:e0a:3cb:7bb0:b269:e2f0:3646:3c73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7ec0e6331sm5216650a12.78.2025.04.30.07.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:57:55 -0700 (PDT)
Message-ID: <d9552c81-6139-4098-a9a1-94d8376ae1cf@linaro.org>
Date: Wed, 30 Apr 2025 16:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: Use a forward declaration for cmd_tbl in
 net-common.h
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20250430144014.1698011-1-sjg@chromium.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250430144014.1698011-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
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



On 4/30/25 16:40, Simon Glass wrote:
> We don't need to include command.h just for this declaration. It
> eventually pulls in linux/byteorder which causes a conflict with exfat
> which has its own byteorder functions.
> 
> Use a forward declaration instead.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  include/net-common.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net-common.h b/include/net-common.h
> index 12c50e2a41e..f2613a41ad8 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -4,7 +4,6 @@
>  #define __NET_COMMON_H__
>  
>  #include <asm/cache.h>
> -#include <command.h>
>  #include <env.h>
>  #include <hexdump.h>
>  #include <linux/if_ether.h>
> @@ -13,6 +12,8 @@
>  #include <rand.h>
>  #include <time.h>
>  
> +struct cmd_tbl;
> +
>  #define DEBUG_NET_PKT_TRACE 0	/* Trace all packet data */
>  
>  /*

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
