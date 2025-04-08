Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2444C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 12:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B8E82ECC;
	Tue,  8 Apr 2025 14:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TLNd23ek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680F882EFC; Tue,  8 Apr 2025 14:17:33 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5523882E86
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so59516495e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744114651; x=1744719451; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKUJMqFgqWa2rebnZ6n4m/cdF5W39Ag59EsWfxN0EgQ=;
 b=TLNd23ekkhnqZ/H/2U6KnPedQhAkTHu/2Y22Rhp6V0YliMlqOmcwqJnj73cKiBsMA+
 lrqCwHGqEOsTRuHTjNKXpF8MYUHb5BqX6YLlEysnyAsuK32VyyPgBBCs6JX7e5X9uPE4
 qZnNFiyQxdYU6FZWL75EeueE2Ug3ySoYuKvT1aGt86Wfc+iCM9b8NKcQiMsdTLkwGuai
 BzgCZ1ENbsCogcgKNVb/sTqfqkPSNma0DmvRxwIBILtQ0ZoKLk1gEKqeUdg2qyQlYKMP
 6ffOOLEqUJagwm3xgGv/s2fviJ+E+rqpoxBQlaGADamo185lB2nJFzWY0ufNPm1Kicbu
 U4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744114651; x=1744719451;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKUJMqFgqWa2rebnZ6n4m/cdF5W39Ag59EsWfxN0EgQ=;
 b=CcXUzYcbwrw1O0YCWmDZ3HBULcNCereaDauqGjVky85w7KCR8N6Q6ga4OqsR5kqgfe
 PGs0MxuYNp9xxzkwcpLq9v0suuNfq+60ojLXQ6IUHTU3j1buKBdjcSmM1SyR73QFNhNm
 dU8YMMTF5N+v7PijHO2tmXkT0loKWOS2sFpCFDlS1gop2ayxC94hjHesEDH8lUnFZ8Gy
 9u0W77srNbcJOFbCHb5fK6FNRAIQ7SPjUk4EXMN85oag67j8G7fYKxTWg4Rx8RNoTMk1
 cshfRnDLx49HbSHPFsJNqxoDdht306WF9CBbgQArPNIb7o20qoG92jgCfCsVbhekYrGp
 qNug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhJKr/qiF4DkVOZ1RuLxDSl037NUPaTS0UFwYvfkHO0oRNBzv+fNwpPq7x4LzKiBd+IsUx2Uw=@lists.denx.de
X-Gm-Message-State: AOJu0YwiDGaoJ1CR2cWlsdW9BDYw61w6qbMFlsHb7appsvOztEWeQNjk
 7I0YQ6vjXTP8KoI/3V5+jiOwjbul0Stk5EOZtQKVIPd3mrT3MvDuMJKpbFU7YTs=
X-Gm-Gg: ASbGncu5aWnyWqQ9KkvgIzVY/ZTbxf0F4IYe/U7eckKg2Ija8ls6gf42Vdwc4mk54rW
 8NHekW40AuoEqyDcz6kv5DxAytzjtZAErb1kQqXwUpjc8ojq/UZG79Rx5M3ww5eeNOPNV6DoRr7
 cNrKWkEWls0UUH5EHTN98y0JCOC3LqWzVf28/Jdq7PBopKqLuqcsTPnvTlxbSD+R1DcTy9R+kfH
 52u0PHfpfrNGLk9fDxEe+42AP2kWrxkJbicjx6KHRDBlcJLBHC8HjwuLY6WZEFynMsWb09ti7zL
 TeHy7LNPm3CEi6b73Kvt/WB+PygK8Yh8NfMQSLB7dKiiqnuTJc3xYghAx41MOkvNUp6cDjWmOBf
 PXwwdA74=
X-Google-Smtp-Source: AGHT+IFhj4MlxS2PV6TNU5AaVke5DjVzUNcjF08Tkr/6DgZ7qMXSt5+MOAutFNEeYSnKnI6TZu4MPA==
X-Received: by 2002:a05:6000:420e:b0:39a:e71d:ee34 with SMTP id
 ffacd0b85a97d-39d0de67093mr12187584f8f.37.1744114650740; 
 Tue, 08 Apr 2025 05:17:30 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d6c8sm14634845f8f.73.2025.04.08.05.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 05:17:30 -0700 (PDT)
Message-ID: <baa7e896-a286-47ed-bd9a-18338978fc0d@linaro.org>
Date: Tue, 8 Apr 2025 14:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: dts: Add override for RB1
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407132810.35149-2-sumit.garg@kernel.org>
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



On 4/7/25 15:28, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add U-Boot override for RB1 to for USB in host mode as OTG mode isn't
> supported. Also, disable sdhc_2 as it's currently not supported, sdhc_1
> works fine though.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   arch/arm/dts/qrb2210-rb1-u-boot.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>   create mode 100644 arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/qrb2210-rb1-u-boot.dtsi b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> new file mode 100644
> index 00000000000..1e136ee405a
> --- /dev/null
> +++ b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* This is usually OTG but U-Boot doesn't support that properly */
> +&usb_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +/* SDHC_2 isn't supported in U-Boot as of now */

I'd rather avoid disabling this here, I guess it's just missing clocks 
and regulators which doesn't justify modifying DT. An error that mmc1 
couldn't be enabled seems fine to me?> +&sdhc_2 {
> +	status = "disabled";
> +};
-- 
Caleb (they/them)

