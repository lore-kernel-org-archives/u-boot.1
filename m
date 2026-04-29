Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF253FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13122846EB;
	Wed, 29 Apr 2026 09:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O4gGbV4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C78846EC; Wed, 29 Apr 2026 09:50:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55A7846E7
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b150559bso95901605e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777449012; x=1778053812; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJVaKce2aDYO6BmURt4xDZlPU6iVmCVIj3g8ExW4eRg=;
 b=O4gGbV4HAVggoggGkHQYh/+8xPK+uRnnxpz8312XMh5hg4XWEVGo6EpBp+diGQ6jlF
 eUo4rp930eQP+oSdPbrwLkcFuHht5iBxjSgd1PL/iwO04MmhQVVA2U4mBji0oW8SJm9J
 NIs0i1hR2BMZZklqNitxqvDnvPoc/p9JFkAgTsTeKJhZDlq49A9Ir47cY0jEDmxRPooV
 5WfNAS8IAHvzwXDii1jB6c1pTy3X/inngqrAQ9OQFJB/XvzqSHPt0WRV3+ziMfPwbg5W
 5QhnR9W8tzhW2UOxFxlK4B65xpEHzgSOq05kHB0rJndxy/uE9Za0xzfU+blk4fN3f0/d
 ZHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449012; x=1778053812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJVaKce2aDYO6BmURt4xDZlPU6iVmCVIj3g8ExW4eRg=;
 b=OF/egoZSv43f5dQZHVcKciFTeP8YUEjiDmH4273ZWJMI3+k/mtPgmfi9c6gGLSWh/8
 MxchQWO5G7JPKYH63X2Bt1anJH2v32MraW2bYmRN0FBx8thtcQUnRZDLXQHYG6O+Lhvs
 LwO/ufeMQsihbFWmVrkiUe1du1b9GkR9tkijz8i2LpoTmBPocgjKiry6xcIb0420U8Sb
 Gf5oFoVlJnj51qyZRtz13bnSsQ3KfYaSYLxIdjB9IQfPSy6Pe3no+SOdQDW2WSbKXubR
 Q7bnBwPKnMDtSdiZTJ6YtpSDeAwWsraGghucRkkSCbkcfRfIHansejmLFvieqUSBAvjT
 HSTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pF40/GyI7i35vmMapc3QKBnERZwCZ9ddQWxCG2wiwi4qJ/goauHWYpXNE6aDuTvXKz0km/eI=@lists.denx.de
X-Gm-Message-State: AOJu0YwFnCmnYF4X4Zm/jCIWER7LOZ9W5E86Zo97avYBYpAAYtMAAIqD
 APxWTsYaQpmhyRJxRqcXpCsLv2EEm9wpGdpgXgFi82tgphjkVhUmbRIi
X-Gm-Gg: AeBDievw5Y3kksmJffOkDyOzyIQiBFwQnKW/qngP3qe3puOuXEWmmqxgTD9UsvEITRw
 8NYSJr/uZU7GJTBAPqL841bMNk2zSEM/mPnxwXgcm5b97nXMDGiGKB/Wh2CJiHE6Oo7Euo4gOP0
 VjA9dmS1n+pP9v19IuIadS213XfPoCDU0hifp6qdE4zbTP99S5nVIZ/SWyYvqjTWoKY1F+I9d26
 scx56ySPaBZp26fCiAQOch9NQKqmDwhBTTMHIf8kTilzX9N43aj6BzoodqkPXzW2QBl4679y/J+
 SvJPaYudr3TdqJkpAQ6f2kI0IhIJEnoC1116bFz7BaF9qQqogA4ETlzO3cClcV4k1Vitm+DQVJ7
 zBFd+DcLs4KCd5qS0OKIUI7HNImUJr+wCDtb/sz/L2C1dOa+bx/dsJ2E/An9IbZuwoSv71QSbej
 3LjoQWxm9jDYgtw/9IkLrpeZZv9vOCJbNcmrBqCkMmgaPXMvtgZBLSW8UkldGs+ad4NM/DOLght
 cP6LKKn5Q==
X-Received: by 2002:a05:600c:354d:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48a77b19c82mr104652945e9.22.1777449012144; 
 Wed, 29 Apr 2026 00:50:12 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c5c740fsm31313655e9.12.2026.04.29.00.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 00:50:11 -0700 (PDT)
Message-ID: <488f6f98-762e-4104-96f2-60a2475585fd@gmail.com>
Date: Wed, 29 Apr 2026 09:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] reset: stm32: Fix compilation error
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>
References: <20260428-fix_mp21_reset-v1-1-d1f2dff3f507@foss.st.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260428-fix_mp21_reset-v1-1-d1f2dff3f507@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 4/28/26 18:10, Patrice Chotard wrote:
> The following compilation error occurs when environment variable
> KBUILD_OUTPUT is not set :
> 
> drivers/reset/stm32/stm32-reset-mp21.c:8:10: fatal error: stm32-reset-core.h: No such file or directory
>      8 | #include <stm32-reset-core.h>
>        |          ^~~~~~~~~~~~~~~~~~~~
> 
> As stm32-reset-core.h is located in same directory than stm32-reset-mp21.c,
> we should use #include "stm32-reset-core.h".
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---

Hi,

Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raph

