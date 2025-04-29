Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2D5C3ABA9
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 11:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103C4809A5;
	Tue, 29 Apr 2025 13:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j6WvEB0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016A3809A5; Tue, 29 Apr 2025 13:41:46 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC888070C
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 13:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so39395865e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745926903; x=1746531703; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VcG72a3VYMisWUji/+qlZDQF0A0sxl0GhhNFM1vmv3s=;
 b=j6WvEB0owR9fkcN4zAioar8oXvVYbH3wVne69Mir3t5Yi7jHC/AGg3ISy6pexpo7sN
 8rp2yNB2APctF9mUO5HeeBzLHI9ACiUAl83a9abU1ZZoemhlcPHdDBDNH9g7IrdmYuKi
 r9WdpqC4mGDyBgF9c0+OqiLZFvwHv1N4htCH7awOmqtij8yIpDEeqCXcfJlU2RMAJNnF
 inReGYdYU17qPT+W3XddlmBZIjpatk2c9nAM6SAc2ZvSrSHir2aul27Wryvw4GSVKwJW
 kPBSmVwMld6tmvqKbXA9udjTk1j9Xl70Hn7AXSvthxYUrDx8iZQboIZItnKw0zhPmVk5
 3J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745926903; x=1746531703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VcG72a3VYMisWUji/+qlZDQF0A0sxl0GhhNFM1vmv3s=;
 b=aNDs3X/7lPeu5wjAR1VzhcvrzhZaESk+qrvOtrZU8+l/JSbQuojMEjULGSDm8XMY3J
 oXgIyn24wwBm9v7wOfSKDxOOeWLDX84cVEaeLbV7X55eB+uYe1nFpUEfoED0UUy4gpLx
 jWPyrQXTJ7qIMWfDzTtD8eizEOslgtAogwknsfFH3KN8LZQDQp61bV5dpwqh/qGkNx1X
 Cg8Cx5RuVQyRYoNp01Rpv334S5l9ho1YKvrBIn01VI2YXeXmaB0/BdliFbKOPqzQH8ky
 gxFedg3FJFoLAjwBqOWLvKkabDfzJsiq/rpIAJMzgRu+tCXjMQYAcRjsvMyueUHXUM/u
 QuAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8dj+4uPPWvM4PA15Fc+mjWA268VqWuPvTmTiEYkcWqNXipnLy6+/Gn9u3v3nI15T891c9PEc=@lists.denx.de
X-Gm-Message-State: AOJu0YzrezjlbTePIHjh5GfRb0KQ+jKvEdZtll8J6h62QMrVUUWA0wOF
 fxU2OijTmGNo7eh/L03YMMShWIxpvOQEGMi7c6kU3tVMu10SRepWV01Veb/rM44=
X-Gm-Gg: ASbGncuDMXRViIGr/dFM7jcg/B0oLanD7PhSjO3vzdBXgAD37eSfa5Tn08eWnTr5e84
 hQ455rBUxnA9g2VOTzyENfhYWO0u0mL6AgzZ+N8eVpQx0PdWXN/DnU1bhiw8gsxe1wnbSrvGi6v
 55/JolSXsSUSCTkWR8AOM6IjFYlNvWeqbABXJcQyLyUFw63BsnSk0ATF/9sBqUgFVTRrY8bjCHi
 SkCsm97xs343j/iyEsy3NJzQXxk8AN3aMMW6Vl/1wXWRf7ORwdnMejqzowtWjxNxpKE0+MgYSZh
 gUCyW34dEZglM1BFVQ4D+bb10ZSy1RK7r+GHoRMdxjEYwWHS7Qi9Dg==
X-Google-Smtp-Source: AGHT+IGnngkJPHvSUChJ6uyyawIJU+2IoBK2X1heGjj0MMg//MQPM9A0FS8hStIvaj2u5Ik0iEDcnQ==
X-Received: by 2002:a05:600c:210:b0:43c:f680:5c2e with SMTP id
 5b1f17b1804b1-441acb70646mr21639025e9.13.1745926903240; 
 Tue, 29 Apr 2025 04:41:43 -0700 (PDT)
Received: from [192.168.7.92] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac079sm186738985e9.18.2025.04.29.04.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 04:41:43 -0700 (PDT)
Message-ID: <1609cc3a-d061-435f-9061-31527c8ca606@linaro.org>
Date: Tue, 29 Apr 2025 13:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: board: fix build condition of noncached memory
 initcall
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>
References: <20250429020424.48795-1-weijie.gao@mediatek.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250429020424.48795-1-weijie.gao@mediatek.com>
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



On 4/29/25 04:04, Weijie Gao wrote:
> CONFIG_SYS_NONCACHED_MEMORY is defined as hex, not bool. It should be
> replaced with CONFIG_SYS_HAS_NONCACHED_MEMORY when switched from #ifdef to
> CONFIG_IS_ENABLED().
> 
> Fixes: 6c171f7a184 (common: board: make initcalls static)
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  common/board_r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/board_r.c b/common/board_r.c
> index bc6fd6448c2..b90a4d9ff69 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -639,7 +639,7 @@ static void initcall_run_r(void)
>  #if CONFIG_IS_ENABLED(CONSOLE_RECORD)
>  	INITCALL(console_record_init);
>  #endif
> -#if CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY)
> +#if CONFIG_IS_ENABLED(SYS_HAS_NONCACHED_MEMORY)
>  	INITCALL(noncached_init);
>  #endif
>  	INITCALL(initr_of_live);

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
