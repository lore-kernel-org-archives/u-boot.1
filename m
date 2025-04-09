Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E232FC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 754BD83873;
	Wed,  9 Apr 2025 17:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xSTFz4qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ADB829F5; Wed,  9 Apr 2025 17:13:57 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4A68388E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so3823320f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744211635; x=1744816435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=No3jbhbIUd9WHdGrHKKuJVnqgWGCmy7rlEkfAqhuXew=;
 b=xSTFz4qb86Jl4brPdrZYajaVH+8BwJiqTxVYcZ1dXYTn7YRnSCYjN7Fl7kRy+2DX+V
 w3ce8/7ss1W7ZIJXoh7CilRGu187op2v/gX7HHy7H5jcxgkIPX/i0EGvL4B4syPLiNL+
 oVasOoDPEnEeS0uq86t95xkvNn2gnnr4Qoax9WH1bn/QJHCjtmaBHuIIgclHybNfXx6X
 3zD0HiY7gjkZYsIyXJoWmUzJq0hhKMy+vu4D35fmJdasNjrnfboCbuEaPPL5TMubpcoK
 iZtTlBh4DEphc23vGGkTTQVxBSBPU8a+9X6DTjgAFXCCn/PFQMFNGneEiA0s886qnJtq
 pYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744211635; x=1744816435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=No3jbhbIUd9WHdGrHKKuJVnqgWGCmy7rlEkfAqhuXew=;
 b=k9aaVTx9lufIzie4I+FOOMkg86dhfXXYcvY5R5IXHE1JHlWg3keZeCJTAH8ALKv5gC
 VvuqW0qdmt5DGIoYSdxz9gMRnVFcbKz0k0HTQkA+bXelwHYudsbCqdyldYbv2/W4+8ni
 Qn6R040PMR09JaQUTe58hIBvDmiujsqr9GqOaU3UWFCWWTZuyqY0CVeGChkADdGF0VLN
 e40M/RhYEmTj0uVE8sb2lQvURyHFBP8zmgdTdTU+pWhKw1wq0oHvAnf/1z8sKc8Cqtly
 N7w9Mcmvxpu8KTkqvhArVvORW8kvVTLcljVJTrYNhAfkyKlRmvybtmSAOf8w0wW/Rly5
 zv/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLqi8ns4g/bY9BXSLuULHASaItJVfi9wG1UNxfnsPfEImGrtZ5dlzhXl1VC1XA7Q2nzrgdfmE=@lists.denx.de
X-Gm-Message-State: AOJu0YzqivqbVQc/M8jKZvUJ7AlJAIqUPbaJEXXBtWPm2tRtP/Uf5d5u
 MV5VPKIlMS84N1XkltncLy2UTP1M8khmMEI7HUEdiCZyE647xdsH8jTdk/3SL44=
X-Gm-Gg: ASbGncvq5uogAcdG+OOFuIY8TD0EhCZhiRO7CbERR7NnYHdHyV7MhkN7RyHPKNNwhDG
 rzZ/x++mpE8inRVewki4EC2dMD7gLqaKpj4bGfwBGWVFBHh1J5hrlpebf02YlOZdfddXzNN4vwD
 baHclShadwpeADzvEtt0U1byYyrpWBe4aOzPiN5H1xLgo3Hc/1qe56cqj402ynb7/htxxZl4g6K
 BCiZSeNL7u1A5zpZZXMBmEj7uMoP+U0LnHCmZ/u8QJs3yhlpEJObynJcsJwgAh5AJKDa0NIfjIO
 xIti/81j0D2tBTcSvjaXxXw5AGJHwXMkbzdANFb/bW4fETSfY1EZ3OOK2bRJZU8ZccF8
X-Google-Smtp-Source: AGHT+IGzWpSDJ0o16oUOAqUWlKxkaUUCkbPjt7wFL9L3mGN2pU3ScPfzUS85HJEy4Av8IbuCbV9mzQ==
X-Received: by 2002:a05:6000:420f:b0:390:fdba:ac7 with SMTP id
 ffacd0b85a97d-39d87ce2890mr3008184f8f.51.1744211634806; 
 Wed, 09 Apr 2025 08:13:54 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm23447895e9.9.2025.04.09.08.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 08:13:53 -0700 (PDT)
Message-ID: <7411b34a-7dde-45ca-a7e3-79404745ff1e@linaro.org>
Date: Wed, 9 Apr 2025 17:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] configs: dragonboard820: updates
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
 <20250407175617.3494506-5-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407175617.3494506-5-jorge.ramirez@oss.qualcomm.com>
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



On 4/7/25 19:56, Jorge Ramirez-Ortiz wrote:
> Configure GPIO and CLK_STUBS
> CLK_STUBS is required for MMC initialization
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>> ---
>   configs/dragonboard820c_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
> index e29bea7deb2..2a5b7212f74 100644
> --- a/configs/dragonboard820c_defconfig
> +++ b/configs/dragonboard820c_defconfig
> @@ -45,4 +45,6 @@ CONFIG_PINCTRL_QCOM_APQ8096=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_QCOM=y
>   CONFIG_MSM_SERIAL=y
> +CONFIG_MSM_GPIO=y
>   CONFIG_SPMI_MSM=y
> +CONFIG_CLK_STUB=y

-- 
Caleb (they/them)

