Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF1BC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79848205B;
	Thu,  3 Apr 2025 14:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BEOiXyFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D43820A0; Thu,  3 Apr 2025 14:50:31 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FBCC82045
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso5512165e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743684629; x=1744289429; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNtJBzxFdcwuoHxKIX3epztKUHXSZFBylwtKuUzgvco=;
 b=BEOiXyFlsAl//vh8qcEQ80J1nla0brzNxQk1tFgek8haGkbrHef0VmbHHJrXVfI9ZB
 5GflqOX8nPzeY0VoybZhApftrGgs8g6Cnk9uFF+Wds1maGmi0tFSQiTTzqOF212ZwHF3
 BRuIqI3DKfZBWJkOy1Ys3EveIyCXEGO+KfDWJHW40vB4EYy4UcoM3lnvtfdFcVZgjb35
 vgbFGMVULv+0yjC6tUCjQAZMl7e5SCE17jwm0J7azrxfsL8Ecex7nglFegEvhWuB9Z/e
 l79T1kLqb2KVMow0kRKac4Y6DaYbEMkxUR6sTwLzjuyiOyp70kS9yA6DBArF5TiNQkNt
 hQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743684629; x=1744289429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tNtJBzxFdcwuoHxKIX3epztKUHXSZFBylwtKuUzgvco=;
 b=kxaUbtWdVw7ZhdK5bjOuP9sDz8e19H9V8eVp0v5fRjKHBt+6W1U3tqhjSGIsH9DPBb
 heQgNpPN+uYOaLB53PJzurupG8I4hr/Quu+GTenTIT6SZZyEjx97JqrMqir3vceIlxcX
 blYUGTCwmKisP3BJPhmaCWB8iNlQ9tbEAPysWoresRsh79r48iAddktLMsebWCVn+cHM
 SPVJ++GpsiwpOAp7T5jG2ObW8J5zhkCh5JoqwSptSSLuvUWR31sbLHSwcxryz0KlDZ4x
 1ZbFLw5uJiMs4B/RO8YdEBVZEd5r+leJC3JoxTsKXLSdgyDSk4aB9kLFE3H6/KpckTSi
 Nkpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2A6SKYCUk/5FpT5jm74057by+taLeFxkb7RYybizzYMDKtqYAhS8EgwWyMNkxazOyEm8s2t4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4mcarDQ8OsqtKiA8R5Wnyat3c8z4DUfymh/VwQfZOCiOyilkM
 7x4vxSliRknBKRrTW77lfihl1iSHNTqOh2TkwP0ARsLNbvXXwgwf/SNtk4F0LVo=
X-Gm-Gg: ASbGnctNV2ddUpZRThFnZL7hu3vrn5KyfhAlV6w8ZCETuu3Zc64v/ex/Jky1GqJzK2r
 3dD6vAAZISXNPahoRTl0kqnLPhdTUTMMtVU+k/Vv175rHjLSWWVCWMrB1Ks/CvpiUGfcmGst9vZ
 Pdf0U0Uk3PO/4e5b13EIJYz3tDaNAUmucbtqazKvqLaFBLbtcV3mQl/5U+HME8XiZwZYE2z5oUt
 h5idu651hvvy0iH4EgQlc7UpPR8JnYkRiO5QLfZdXyKok8KlynsV4H0jz1o32Ta6B+JHMj71B0q
 qYKydHKfeUwcAFVniGHR5yxXvN0O3Gg4PznmaoBo4v0J+rAGae8YBPS7bdZjM69riFVvgFW9nkN
 sGM78rZvP3J8=
X-Google-Smtp-Source: AGHT+IHSSXC4/4SfGYDVSDBGfGv8IzM0hHc8u0suc6BPXeTArK0AxBueknrpIcjGDpO72zre/v9GNQ==
X-Received: by 2002:a05:600c:3d13:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-43ec4438bc7mr19430205e9.25.1743684629077; 
 Thu, 03 Apr 2025 05:50:29 -0700 (PDT)
Received: from [192.168.1.47] (167-60-142-46.pool.kielnet.net. [46.142.60.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec163107csm21473825e9.3.2025.04.03.05.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 05:50:28 -0700 (PDT)
Message-ID: <71822cca-35de-4097-b591-b098d77c40ba@linaro.org>
Date: Thu, 3 Apr 2025 14:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: board: qcom: db820c: update contact details
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250403094601.9207-1-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250403094601.9207-1-jorge.ramirez@oss.qualcomm.com>
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



On 4/3/25 11:46, Jorge Ramirez-Ortiz wrote:
> Update contact details
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

Congrats!

Acked-by: Caleb Connolly <caleb.connolly@linaro.org>

Will you be giving this board some love? Unfortunately I don't have to 
test so it's not yet making use of the fancier generic support parts in 
mach-snapdragon.

Kind regards,
> ---
>   board/qualcomm/dragonboard820c/MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/qualcomm/dragonboard820c/MAINTAINERS b/board/qualcomm/dragonboard820c/MAINTAINERS
> index 7ef905bdf69..28741d98334 100644
> --- a/board/qualcomm/dragonboard820c/MAINTAINERS
> +++ b/board/qualcomm/dragonboard820c/MAINTAINERS
> @@ -1,5 +1,5 @@
>   DRAGONBOARD820C BOARD
> -M:	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> +M:	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>   S:	Maintained
>   F:	board/qualcomm/dragonboard820c/
>   F:	include/configs/dragonboard820c.h

-- 
Caleb (they/them)

