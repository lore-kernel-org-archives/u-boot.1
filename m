Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4EAC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821B582EA9;
	Thu,  3 Jul 2025 13:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MxoYOslL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE1982103; Thu,  3 Jul 2025 13:39:47 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D319382F6A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d54214adso56581675e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751542785; x=1752147585; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c2ZDYsLWIy53RFWmvU0AhdlWPlvPnVnXk8k3d6LCWLo=;
 b=MxoYOslLX4JqJ1UPX9rZflloQ9B7g3H2Z3d2w/fQ9i0qTysG4CvFHWaX5fCB+7nVgS
 fExP7AIHy3VMXQywFsQDLO6QKXolfwEjcbQzOjaUAPidoOEDUIrSF/nhcAUfZBGKRbyR
 xlSRPJX3a+JqOfQXPGqYiQHtDjdrTNpyiOSqWFlueOw6kFwozQEeh8T+Q+absAMcjUBH
 uxCtaqiYKSh2uonpBEwqKhV5LLwCgTV8R8o6fuP3UDwHTuLk3lUQZto/yX1+n7vulNli
 guK7Dzi1YH13QcIC9lpU8dtRjZvEfX/UeHDdb5Du0leelZMXjRSE2gVgzUcwI63NLgLn
 IxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751542785; x=1752147585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c2ZDYsLWIy53RFWmvU0AhdlWPlvPnVnXk8k3d6LCWLo=;
 b=WtYMTAKsE4wopagRDrZ9fWNnYcf9xCpBOisN7TgmPvVwaK2q1O56sMukZrsWQRrHaJ
 wjsXlS5hZQMrfk7VoydDIQmawZJkZrtsWL9fsy54LiUk4M10/y2rtwTekVNhPvim5Lz+
 k5QNNPIcwZgkOKF415JpvgnYBP/NWydzYdPBF6rhrO3X7rMmm38mFwPoTXkYzWZULWL9
 uyQT6RnONxHYg5uyJCPZJ911wpwVHUvbR4+AgBKcYH85k9HCqVKc9MlAnVMbFjaNhnE3
 J94oOoeEWvf9jy13juKULph3dXkfzKC9HX60PWcBB9Ivuu1YRGWy2nDdOh0SI+uFi4sS
 9NxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBLrC2u7qTvIy5e7g3rT02mdkVsf+eZh5M5O8Qjx9GJ/c2pNHEUcXde+/rhNIfgraaZs+y5vg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv4q78q21eBG8z4q3JFyx5M3/mbRQ8cu0NRRZ7q28BJvxpXC+4
 GbtTPyRcQMRleVGC42IFD41J7fj2SZ3KfW/kfMJfUxhdDJR7RYd9MBzRP0BXJ1qaOd8=
X-Gm-Gg: ASbGncvN7SNDCP6SI9HgVT/5P7V9U9ytyHiJd2SycWn6hreGBLUhudhJqn0B67mlqC6
 FA8wrK7Vb+PRc8ylPVD73chEdDVQXkNIU2merIgvbZF4cn6Zf120ZYWu1KAsc1hdReTBe1m90N0
 Ovhb9jNsOL/fIkf/XuukWUHFdfuxza8IgfRqXn40N6kXOO3hDnYqwrgKTALoV06rZbf4YI0Rib+
 NjM7imMWi5XtSOD630QUuI9H1Q2+Yi6FSr/2rubEvoU76Qs52D9e/5j3zpL8Kof/riqR76zqLYT
 5vZGVz3nh2432kg9LLiYIkikt6YbL6/fs0ZJAlU2xKTjSzPZN2Aq/Cj//NM4B+FEsCV6lcNYaEH
 2u3QPQoGTw8zuRmRqD4LuPULeoxdA
X-Google-Smtp-Source: AGHT+IE9cRe2dL35HUP6aQdwSHQJwP7evakfdA4miTsJfT0qE3G3EiK4hi0aqS7EtfYnRtMav2alWg==
X-Received: by 2002:a05:600c:3b01:b0:453:99f:b1b0 with SMTP id
 5b1f17b1804b1-454a3706e45mr61752665e9.20.1751542785175; 
 Thu, 03 Jul 2025 04:39:45 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3d084.dip0.t-ipconnect.de. [79.195.208.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8e1sm18219732f8f.88.2025.07.03.04.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 04:39:44 -0700 (PDT)
Message-ID: <11d46fc2-10ca-46a3-b543-40160bb51f9a@linaro.org>
Date: Thu, 3 Jul 2025 13:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] cmd/exception: missing include string.h
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-2-heinrich.schuchardt@canonical.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250703051951.43372-2-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 03/07/2025 07:19, Heinrich Schuchardt wrote:
> When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occurs:
> 
>     In file included from cmd/arm/exception64.c:87:
>     include/exception.h: In function ‘exception_complete’:
>     include/exception.h:41:23: error: implicit declaration of
>     function ‘strlen’ [-Wimplicit-function-declaration]
>        41 |                 len = strlen(argv[1]);
>           |                       ^~~~~~
> 
> Add the missing include.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>  include/exception.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/exception.h b/include/exception.h
> index a7f21e73d75..0d4dff49954 100644
> --- a/include/exception.h
> +++ b/include/exception.h
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <command.h>
> +#include <string.h>
>  
>  static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
>  			char *const argv[])

-- 
// Casey (she/her)

