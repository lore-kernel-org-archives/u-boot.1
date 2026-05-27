Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC72CCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 18:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8F2847C4;
	Wed, 27 May 2026 20:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S/QNSwt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B9984837; Wed, 27 May 2026 20:36:51 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2890C84704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 20:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF3513F976
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779907008;
 bh=Hsvb1lqaKgNNO0p9AmluK3JjmWtYwgBoD4g39erno3A=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=S/QNSwt3u4w918mczBKRDzzS4qjyTwim9NNEDiG+R1nV1s2tNIO6tWFS+YUmjCj5g
 PF4n+psMb18ktEI2QZvPVsRdqD7ejEH7A8ryq507vX9nClZFaeVp0moavttAG9gmIJ
 7RGwOiPq1+d4NpwTjGokCNelMyFlUWnmoloOe6CRcwgyUi4LS/93zKkgC87cSUjuup
 XjEnHXt4W9UWglP+A+9jcx7jDSLrJDwSMbCcEWfzrsjb7NWl0f0BSepYA5SgyZlqe5
 T+ySIFq/gmAseBKRwSxzWEqlDzzxmZMVYRT1rTh+cntl2DVnTbFtoo8NEcDqL8Qq/+
 Rh2PVS8W/78TLkjb9aQS/Cn4PqbbPmzxm8qLfIeEmYRP1QF476rlsqTNefs0FWtCzO
 yuGJJY0YRypCA+UvgjdXyDjk+bcTt7uecRlUtluCJLijmIwOx3vmqh732P9OFDdBZ3
 PuRbZqJSTD/eEdMSn6+z9Sl79tttELLKbbXuBkOCAipJ1MfRcb6jM436QsHm+RSprR
 Eqy59FxOIhj2ORVH1o1VEs82LYbA4ujx3bCNPPk9mvmKxyLX8Z5ZwPkp6X2wuOiN4d
 wgRctOh/+Pcjqscz9GZT6CM6uPoZhh0M/y/ls4D7xA8eK5KOm+vPlN5x/JpYAYTjLo
 K9iQ9gkdczgsCSoNxVhrKCoM=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fe40b61a3so79002065e9.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779907008; x=1780511808;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hsvb1lqaKgNNO0p9AmluK3JjmWtYwgBoD4g39erno3A=;
 b=rfXCHylARjNoO7gWpxRAQY+Kd/C8x3hRs2kaReLa2/iwRaxz2S8YzxkBCdhaBGOIEs
 KnxkA0t+r2hpk6lalkn8g7M1AvmfcAe3/Um9Az0wDJQJoDJkNtP/j1ZUY+HyUpwZFECO
 RsO213xEyxKiS6ZFueDUI/O9evV3UEuKaNxZp4izoBe/n+PjciKbqO+Gy/Nii+6vZV8j
 GaAcHDANlDns5Z1rR06QskkO3Bvobf2szzr190USeUVP/bk1nM67UtKWKBHcZCXxtZR6
 5iAOkYVeHED0F4QH2/tnVpfnNzgcGSd4Qez3L+vR8NzVH9Q54ntYkKInEk3SnSnSUNgf
 1JzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/uO4szUuq7RdwVqTe+vf5o1AyItQLwuebfYpqz8QFvriLEi45poPJoaqbeAOy2VEQC6Cu0LA=@lists.denx.de
X-Gm-Message-State: AOJu0YzAMdddCr+z4ZkNl29qS000qfxqyucrXD0N8iWIvnX54nq0YsMN
 vW17t9/B5YRVW8VHwTs+7H7Vr/YKtNsqc+jgQsRlzvSDCTuGX6JpUnZkN7NMjsWmL6CObp+gaD8
 TzWRKSE9lb4tP2vbjAO1bVoWab8FBu8t0s6/cyA8St+Vv1j4k6wJdKKzidOnjw5oW0TI9Ox8=
X-Gm-Gg: Acq92OFZwcZwbgmZEnAlfymlp2/08nUzMu4aLLzwvceiyeaRONmz5K6qmm4mHoHD9eM
 M9VaThZm4woZdI6NWx8Z4MJcFAmGiLThjc8NsL3ww93RyH8d6h/80tudxmo9XnjUEspt6sb6jz4
 aLTs7+X8k3Ji8A+rmAldtBN33plKo0x5ejGdGz4O7+Bl/lwbw5Nh6EPAqi5KBGf9PBz4GHnr6Hu
 5nvFghbu6iYtYAmupdHUIpTmA0baKiyMr/qwTRHuruWC7xobSuot1dxov2ltHTLJURtFpInGvO8
 Ou45dxzlbVfKOkBgcpINxN5H5vIz9t9TD+BRvtTxvjk3aL2s5O+Xryq5iYbsP0QkW3ri7m83dM3
 iEpyKW2ealM6pKc3LvG4O+DRaHAJqGO8Yd7xURdmfz2wdkwN6wFrUWW0UQagR9cDhEYnydDhb2z
 Z3cYNQJNhm0jtD6YBDCUikoD3JP9KMgCmP20+bBZ6BMmpOZxthKw==
X-Received: by 2002:a05:600c:3e0c:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-49042489c30mr466015885e9.5.1779907008285; 
 Wed, 27 May 2026 11:36:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0c:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-49042489c30mr466015465e9.5.1779907007840; 
 Wed, 27 May 2026 11:36:47 -0700 (PDT)
Received: from [192.168.103.110]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b8aa05esm621705e9.13.2026.05.27.11.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 11:36:47 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
Date: Wed, 27 May 2026 20:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] alist: Allow inclusion from OS headers
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-3-sjg@chromium.org>
Content-Language: en-US
In-Reply-To: <20260527161033.3273795-3-sjg@chromium.org>
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

On 5/27/26 18:10, Simon Glass wrote:
> Sandbox needs to include system headers in some files, but also wants
> to use alist. Adjust the headers to permit this.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   include/alist.h | 16 +++++++++++-----
>   lib/alist.c     |  1 +
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/alist.h b/include/alist.h
> index b00d9ea97d6..69d7cdb722f 100644
> --- a/include/alist.h
> +++ b/include/alist.h
> @@ -10,8 +10,14 @@
>   #define __ALIST_H
>   
>   #include <stdbool.h>
> -#include <linux/bitops.h>
> +
> +#ifdef USE_HOSTCC
> +#include <sys/types.h>
> +#include <stdint.h>
> +#else
>   #include <linux/types.h>
> +#endif
> +#define BIT(nr)			(1UL << (nr))

BIT(nr) is already defined in include/linux/bitops.h.

We must not assume that no module includes both alist.h and 
linux/bitops.h. E.g. include/expo.h and include/lmb.h include both 
alist.h and linux/bitops.h. We should avoid redefinitions.

The following is an abuse of the enum type:

enum alist_flags {
         ALISTF_FAIL     = BIT(0),
};

As this is the only use of BIT(), we could simply use the value "1" here.

#define ALISTF_FAIL (1)

But as ALISTF_FAIL is the only bit in flags used, the best solution 
would be replacing flags by a boolean called fail.

Best regards

Heinrich

>   
>   /**
>    * struct alist - object list that can be allocated and freed
> @@ -41,10 +47,10 @@
>    */
>   struct alist {
>   	void *data;
> -	u16 obj_size;
> -	u16 count;
> -	u16 alloc;
> -	u16 flags;
> +	unsigned short obj_size;
> +	unsigned short count;
> +	unsigned short alloc;
> +	unsigned short flags;
>   };
>   
>   /**
> diff --git a/lib/alist.c b/lib/alist.c
> index 4ce651f5c45..0ae07f0f5c0 100644
> --- a/lib/alist.c
> +++ b/lib/alist.c
> @@ -8,6 +8,7 @@
>   
>   #include <alist.h>
>   #include <display_options.h>
> +#include <log.h>
>   #include <malloc.h>
>   #include <stdio.h>
>   #include <string.h>

