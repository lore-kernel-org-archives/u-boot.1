Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CA11125811
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 18:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AB58415C;
	Wed, 11 Mar 2026 19:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GPwQdNKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BDA84166; Wed, 11 Mar 2026 19:12:39 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8F884013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 19:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so1186015e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773252756; x=1773857556; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lTQr1Qlz+nnFqqw7hVdMtsq/uvIBqh+9UbS2Fl7V6Y8=;
 b=GPwQdNKBv2G5l4mCWdxrhle3SLGKzKzYNgURGdzjixpR/dH0CtFUVXE1kIwtCceCkw
 fSx+FZYfnxC7wRkrZ3kJSqQgMbnrQw851DjpF9lZ6U8BKXB5hZwT6aj8FcUYawcZ2EpG
 Ss1amGU6Rtu/2UupUrTvOqLnCZ3xMNjtHmDxzvKQIZxQpFnVzqUQuSN6rdQFkCivcIVU
 xjnPUIr9BpR/ajsXrGYEmV0AJLv7purW3IOev7TEiNiIxV19D+w4apnuhjW9PFGWaDRr
 S+68a0g4h+pQ+50ihcT16SMVVjR85lrC5e20z8KeJdzouHZQOYgFFhG16wkzALtoK1Kb
 30fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773252756; x=1773857556;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lTQr1Qlz+nnFqqw7hVdMtsq/uvIBqh+9UbS2Fl7V6Y8=;
 b=B6AAESUd1iKPbbtM/VUhGvvCzausfOlATRCPT8TQb+nVp0imGK1TuMDG0ZudOVfXQb
 D74ULgQhE7MXjXi98G81RHFDGYvn8xSu7fYShxn83ohtOEs0sugBg8EsOaC7TyqmP0zd
 Np+ZEW1O3Bl5ACX8lCtjhtQFfG4LshdCrsQY6m25nX6EYQDSqIyCkZSoXqjcoajgCiD6
 lkWtjinjQiZ87f1KKT1sMY2XocowXBcxEVUO3O+wl5CBc/+knpet3pn3YEOLidpRBStO
 UO/Dp/CNzwAqngmvxocMNkog0hf/9ZyO3ajTTCT3phmcKWt3RyegktGBQ6anDq9hiYRG
 l7WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZEzTeXpLpep5qjCAwFhXqMs3+7sQ/bi29yn/0y8DiAYHqpa6Vpio/CNmP9CW8gusKN3QiHlo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj2IxY8TdmDFWLK5bLv4GS6zblsMsO4oAPxsG2Y8LfoFyW9RVg
 ZiHjrBVy9ZcJwLLHB4+756FSwYTjCuscQBdWqCH7ZBH8xjB/livBI8vW
X-Gm-Gg: ATEYQzwXV5jcY0PK4CzB88dOETl5fANoiscaa5+pd5xr3FSfEAjrIAZQpT9Y0A3f7C/
 VQzwir/5fBfB2IRlld3AepIC8ygQ/vtFpUyWk40gWQr0TRqFraPXJaw0BWjvnW47+gDWwiDNObz
 AFpAYa6IvS0jWIz1CUJql+C2tx40Hb67INo4+fr7GWDpsods4bUtba5gT8UQtJsFiLSrQzikvGy
 uT0GjWaY8snnCXfGGRUVJqQ9t53LS3KxUvksmJZRE+Pr9i7TqmscItKjHH28+l7DrrUCUDw43MA
 f4TDiZUdYEWvTgLVIH+Le59u3YqH77izw09ByyfP1etbVhuENOilurQQWq0u7VQAe6zCceyuhGM
 XfBL34AjOxpGotj6/b8GZfxRRvzqNjug9z11fDKsSVXCuKMhq/1V7Ca/l8xwLvLKIgvfpPuLQEW
 CMXaNTUKlI8NWn9EmxPCV+qTybZARwBI8d+M5qySVawZ44BlSzices+3dz9vjjNLNUUp9UVLgDF
 y0=
X-Received: by 2002:a05:600c:1f87:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-4854b0a4a9dmr60793175e9.5.1773252756396; 
 Wed, 11 Mar 2026 11:12:36 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c?
 ([2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0c678asm28025465e9.13.2026.03.11.11.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:12:35 -0700 (PDT)
Message-ID: <fe2773d5-0255-45bb-bf98-bd9f66617f96@gmail.com>
Date: Wed, 11 Mar 2026 19:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] mips: loongson: add watchdog driver
To: sgdfkk@163.com, duhuanpeng@139.com, u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
 <20260311084129.12809-7-sgdfkk@163.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20260311084129.12809-7-sgdfkk@163.com>
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



On 3/11/26 09:41, sgdfkk@163.com wrote:
> From: Du Huanpeng <u74147@gmail.com>
> 
> supports watchdog in loongson mips embedded SoCs
> 
> Signed-off-by: Du Huanpeng <u74147@gmail.com>
> ---
>   drivers/watchdog/Kconfig        |   8 ++
>   drivers/watchdog/Makefile       |   1 +
>   drivers/watchdog/loongson_wdt.c | 127 ++++++++++++++++++++++++++++++++
>   3 files changed, 136 insertions(+)
>   create mode 100644 drivers/watchdog/loongson_wdt.c
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

