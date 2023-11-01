Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48581C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9610287D0C;
	Wed,  1 Nov 2023 18:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFQcZeQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB15487D23; Wed,  1 Nov 2023 18:56:06 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51298770F
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cd52c51abso43802681cf.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698861360; x=1699466160; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gX+t++kTKy2RkubgGSc3+gV2mn5GQ/xNEgL/y5Rl7CE=;
 b=SFQcZeQTrnAoUilt7VKQBuoVF0+5LB0r1gzESvO6Jt5rZ5/QJO5O/OwI9V4H52ZCeK
 YCrowX2EcNzsaRtL/VXWdbqVVlWsaQfXBZW2xTGXswA1KS6wbhBy9iJ0LSXJ7xljtJaI
 /slloalsrp0FuyOBmcSIuF3AB/O1vOqX9MoadlX8pae412UmSGWvQivFBJYozRnjBUk4
 ckk+ir9c+qnd8wxKPphdCCvrELzdvD/6bgko5BEQipdfIxaPDvXcf71RaMShTJMqDM7z
 f6LwIpZ6q6tRFGiDk5gnEapvIe3HptwC6mXqD1wdG0tp6vbHsRDkP9T3l4+l8XTaLvMG
 W0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698861360; x=1699466160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gX+t++kTKy2RkubgGSc3+gV2mn5GQ/xNEgL/y5Rl7CE=;
 b=l3xwfjeN4Ejax+eKGnPCSzFlsUU5fEPx+VEu+HTf1VmEetP1cJm/a/uE1Bn613Sn1i
 M72PRna/+WZBM6vtB0l9KVzJPaVzhjDDs/pb5hqUW+IIfyFpLRxevrgywU63CzYQyGGX
 0unC0xDFone3jpvbHaZNiJEVpMLxVcnriQgis1x9Wa/3+SK96urlYnmJzUvlg5gy/46/
 VOKWtL6cK66eftkAaKpbsgw4YCS5gidS9JjYwiq1r4ZvwREzFPykmwMf9rrJbdi6rFA0
 sDOLApbipYSJn+aygtOE37cjaXUDKJCA+ewYGNmo3zaHJEbZXaFHAWFcFurH6j9MtN4g
 mWnw==
X-Gm-Message-State: AOJu0YyRA3sLI2V6BwUuoli1pLOIbAWTcSzTvGxB0CvOCkfeT2QHSu+x
 nPOrjP+NGiS0EOxV7GYLFrWhSThjLwNgmA==
X-Google-Smtp-Source: AGHT+IGpVDasiG+8Henti0lrYA5jnKqCHRfV6p8LfMSX8wnK3VhB2sNdIu6umGduQI2wgkDS82LWlQ==
X-Received: by 2002:ac8:5a47:0:b0:41c:cca0:171b with SMTP id
 o7-20020ac85a47000000b0041ccca0171bmr19271762qta.32.1698861360640; 
 Wed, 01 Nov 2023 10:56:00 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 e26-20020ac8671a000000b00417f330026bsm1604561qtp.49.2023.11.01.10.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:56:00 -0700 (PDT)
Message-ID: <02b22344-bdab-ea52-cad7-637a94aa852f@gmail.com>
Date: Wed, 1 Nov 2023 13:55:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 2/5] clk: call log_debug() instead to avoid console
 log printing
Content-Language: en-US
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-2-49ec18f820bf@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230818-clk-fix-v1-2-49ec18f820bf@outlook.com>
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

On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> it's a very common case to register a clock without a parent, such as
> clk_register_fixed_rate().

Actually, that seems like the only place this is done.

> Replace log_error() with log_debug() to avoid
> useless console log if not debugging.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/clk/clk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a5a3461b66..a38daaac0c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -24,8 +24,8 @@ int clk_register(struct clk *clk, const char *drv_name,
>   
>   	ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
>   	if (ret) {
> -		log_err("%s: failed to get %s device (parent of %s)\n",
> -			__func__, parent_name, name);
> +		log_debug("%s: failed to get %s device (parent of %s)\n",
> +			  __func__, parent_name, name);
>   	} else {
>   		log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
>   			  parent->name, parent);
> 

I think a correct fix would be

diff --git i/drivers/clk/clk.c w/drivers/clk/clk.c
index a5a3461b66c..cb333c83f66 100644
--- i/drivers/clk/clk.c
+++ w/drivers/clk/clk.c
@@ -18,17 +18,19 @@
  int clk_register(struct clk *clk, const char *drv_name,
                  const char *name, const char *parent_name)
  {
-       struct udevice *parent;
+       struct udevice *parent = NULL;
         struct driver *drv;
         int ret;
  
-       ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
-       if (ret) {
-               log_err("%s: failed to get %s device (parent of %s)\n",
-                       __func__, parent_name, name);
-       } else {
-               log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
-                         parent->name, parent);
+       if (parent_name) {
+               ret = uclass_get_device_by_name(UCLASS_CLK, parent_name,
+                                               &parent);
+               if (ret)
+                       log_err("%s: failed to get %s device (parent of %s)\n",
+                               __func__, parent_name, name);
+               else
+                       log_debug("%s: name: %s parent: %s [0x%p]\n", __func__,
+                                 name, parent->name, parent);
         }
  
         drv = lists_driver_lookup_name(drv_name);

--Sean
