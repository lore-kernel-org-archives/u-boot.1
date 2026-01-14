Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD0CD37E44
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD84C80433;
	Wed, 14 Jan 2026 16:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W0CYM4kd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8618352B; Wed, 14 Jan 2026 16:24:49 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80C580433
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ed9b04365so13912795e9.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 07:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768404286; x=1769009086; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wb+nBDHJqE+W6/zaWEAFmROSquPK33QqKHQbFIDKCXA=;
 b=W0CYM4kdIHLMOzb4+FdyUaOZHmDDCI7LUGrt3GmTEESrY1E+P026gdQkCD42ggW5v+
 18zTJ/Qs0VnN9zUhUb0ClBUVyXZEcl4C2e9GjTyV5W8P+ok+Xs4IAm1ZfPkpx+OGosBk
 MVzlOQbrIWv7tTyKpbR2jkSArCHhbi+g5AcWUeYQvTLym08SzXSB4IAnQv7mykIFxS/M
 y2vkY/iYXf4I24S+i01D6eaSwTdvMuOGymv8zwS34SBh+Vd9YQFO03lFzQcGI8hOkUlz
 Y7Opphd8lEj2Eom9bxOhFQwSQzovkS9v6fgOguiWzYzQ5D57jiFdi+/xDIdji0YNAAmK
 LLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768404286; x=1769009086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wb+nBDHJqE+W6/zaWEAFmROSquPK33QqKHQbFIDKCXA=;
 b=FX0G3uNTdobZxldAXKydUwaPGSa+CroRMvQWDhMaWq+tLHqQhJvqIHh+hfBGk32MxT
 WvO3g2ZImyrW+cWtQzA8qpH91gM2Gl3PkABy83mMXCwITVl8WGGKfgS8Jzqhqy26/O0j
 XxOWUoMtdiUEjjdsWYP5JkD2DVUeXoKXLH2eWhn0BWoCaygBzJR34GjuVMP8HpIIhpIF
 d6wIcWw8q/qHg+R4cU3LOdOMsLLLKMKKV6Hu3MnM9ly7WV7tG9geOiKrFVxzMixcxC7c
 /IRtPB7/ugLCh8yi0GMecgrgf8ssnJ59L3yNsr+eoF3p0PjxirBkRjG7qxL0U6WEanAY
 I20w==
X-Gm-Message-State: AOJu0Ywyu9YxK+E4FsnMmX8zaAlqfuk35kYJ8mWfSmWiYoCX6oQY4dBj
 cMsCe4kvAFx5jlfN4iPQ6hUQRQjW4zJHpkvVhtLMT20Vv3DcS2y8WX34qVBUSEr6Tbk=
X-Gm-Gg: AY/fxX7f3sdH3GdeDZedfzI7Z5gJMnCbhKEBDyCtTw6iWlTeDnOPnXTQXd0/Qq1wKbi
 JA7Ru5Za2koZ+JC4bNQep82g9uJvwnpM+FsAFa4VQZF5daUNMWKiSL78yxaBCs8NIuC8FzgQYXu
 87I6FDo6ZzsBTqd4vjL/TMe+NKeV10QK/yjLIAuqunfw+KXmsV34ieggm81+X0phkzzAC0xPD1p
 SeYfcfZ8yUJmVju151wauqA98D0Ehti4vi9pscYELjw/n0wr0dTeSL7jrkR93JY2iyVgT0QLI7x
 lRl6Idl2ic4eCdpN9mIXN46D0811Ti1prfw9U+NotzWAIN2BQALzCRVr4271+UNpcVR0whkz2s/
 xbWIYsuBCLYBo2V/EseK3eKYUFEkC45mBsQr208EF8a5WTfo6x/Am7now9GF6pi9+MY4J38S0dS
 nwtbqxl+pAicANlIuHVRp10iNdWgtJ5wsnrVZBUTjfMJ+rh2DC01g=
X-Received: by 2002:a05:600c:8b88:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-47ee32e0281mr35579835e9.5.1768404286063; 
 Wed, 14 Jan 2026 07:24:46 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee2840b7csm21214075e9.14.2026.01.14.07.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 07:24:44 -0800 (PST)
Message-ID: <51543ec0-ee56-49cc-9434-f5f85adcab72@linaro.org>
Date: Wed, 14 Jan 2026 16:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] boot: bootmeth_android: Conditionally dependent on
 abootimg
Content-Language: en-US
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-4-24cdb50e860f@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250630-sc7180-android-boot-v4-4-24cdb50e860f@gmail.com>
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

Hi George,

This patch doesn't seem to build properly when cmd/abootimg.c is enabled:

../cmd/abootimg.c:26:6: error: redefinition of 'set_abootimg_addr'
   26 | void set_abootimg_addr(ulong addr)
      |      ^~~~~~~~~~~~~~~~~
In file included from ../cmd/abootimg.c:10:
../include/image.h:2044:13: note: previous definition of
'set_abootimg_addr' with type 'void(ulong)' {aka 'void(long unsigned int)'}
 2044 | void __weak set_abootimg_addr(ulong addr) {}
      |             ^~~~~~~~~~~~~~~~~
../cmd/abootimg.c:41:6: error: redefinition of 'set_avendor_bootimg_addr'
   41 | void set_avendor_bootimg_addr(ulong addr)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~
../include/image.h:2065:13: note: previous definition of
'set_avendor_bootimg_addr' with type 'void(ulong)' {aka 'void(long
unsigned int)'}
 2065 | void __weak set_avendor_bootimg_addr(ulong addr) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [../scripts/Makefile.build:271: cmd/abootimg.o] Error 1

On 30/06/2025 09:56, George Chan via B4 Relay wrote:
> From: George Chan <gchan9527@gmail.com>
> 
> If target u-boot img do not support androidboot v3 or greater,
> abootimg might not be necessary.
> 
> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function `boot_android_normal':
> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_android_normal+0xd0): undefined reference to `set_avendor_bootimg_addr'
> aarch64-linux-gnu-ld.bfd: /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_android_normal+0xd8): undefined reference to `set_abootimg_addr'
> Segmentation fault (core dumped)
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>  boot/bootmeth_android.c | 2 +-
>  include/image.h         | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 8c2bde10e17..d7740b86d67 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -534,7 +534,7 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (ret < 0)
>  		return log_msg_ret("read boot", ret);
>  
> -	if (priv->header_version >= 3) {
> +	if (IS_ENABLED(CONFIG_CMD_ABOOTIMG) && priv->header_version >= 3) {
>  		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
>  					     priv->vendor_boot_img_size, vloadaddr);
>  		if (ret < 0)
> diff --git a/include/image.h b/include/image.h
> index 11d33ceeb39..82a861ba8bf 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -2050,6 +2050,7 @@ ulong get_abootimg_addr(void);
>   * Return: no returned results
>   */
>  void set_abootimg_addr(ulong addr);
> +void __weak set_abootimg_addr(ulong addr) {}
>  
>  /**
>   * get_ainit_bootimg_addr() - Get Android init boot image address
> @@ -2071,6 +2072,7 @@ ulong get_avendor_bootimg_addr(void);
>   * Return: no returned results
>   */
>  void set_avendor_bootimg_addr(ulong addr);
> +void __weak set_avendor_bootimg_addr(ulong addr) {}
>  
>  /**
>   * board_fit_config_name_match() - Check for a matching board name
> 

-- 
// Casey (she/her)

