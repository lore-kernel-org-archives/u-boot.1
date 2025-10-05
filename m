Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA13CAC5BB
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 11:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EFFB809A5;
	Sun,  5 Oct 2025 13:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IXx7m38i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442518206E; Sun,  5 Oct 2025 13:57:19 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381A4807C0
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 13:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso3350674f8f.2
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759665435; x=1760270235; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnX12dZ3jR9L8FkhTyaIx7D2+odZwvuHtr9Kwsz+FVI=;
 b=IXx7m38iGT/gUOknhu1dwbfeG41RdlC0QjWHhwPN8PR94Y3kiUmlDNgvbk4XKlZkCJ
 TfuJWPil88ozBllB8QQmHdNkRuZgNUk0HCIgEks4pLwSaaKCKDR2rau8ZA1WzwlJqcyG
 w5Ky3VC3Luk0B4va1pw8/U/Ea3OOFugfJZtIkxYZrysQQr0bqMBTyjab513zzXTb0yH+
 LB4LA3Fs1PqnkrXkbLzr+wDt6Nz+68rMzUJtRDhBFjdR4e8uPHcsBEu8BFvTpEeVoyEG
 YbTSkqHU6DDd/0baIVCpmV1+8zJFxgBW+h9KEK7F2k5rsgNBhHSJuX+SdSQ3d9ZFvDdx
 dCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759665435; x=1760270235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnX12dZ3jR9L8FkhTyaIx7D2+odZwvuHtr9Kwsz+FVI=;
 b=k3X3vlvdpH0dBOTE4+wyxEVWl0ak3mJ3iSCrUuAx/zOtc9DW5jIqDJavbLobczFQb/
 TehAWmtb83cMMT/gFpwZv7wwlyUgoeWAZ2Eup9eZJ30g5/1modcoUCwehJUiAUr0wuwM
 phuHBYvMyq6vNSvOoqi/AIFwc9sm6uCbnj4+AmLU6fiThIpMigHvt+NgP4H9FqPrOG4Z
 X2Qz4Iwzv56JGVrFn3y/HhNEBQy94F7i5c5E0QkcKewpbN2W9v4iNUaDUm1uVb71f8kB
 eLjGqj8sB7JyCp4tx1vSsslr8XHo6lxPJLfWMY6RHUCLJn5x990WuY778bkqP+ZDPo2m
 /ttA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW94DTwRsEXzoFr89+N7FUWG+FV+Ep2VZtPxGVo0jmTaqgCluM0JM0Oo4O+t3iliYeGKsuLJzc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6mXB18xvhT9xsoybJQSaw5v8R4LEvy/ftjwUtKWMrb/Qmzpu1
 aTWn6zkuvwpoUcyZ+pUSauZX/3lMb1UEGyXwkoW9sUMp3wgFaXs5XBw0m0qjKULTC7s=
X-Gm-Gg: ASbGncseprJmgTKKbqKNJTKNA838Qb2j0E1YsKyXTurwhDBYUbzPsdA2jYqEpuk552y
 Jzak8XpLmnsLBmoEMGeZJ1ObMrq2hHnUFf0EybaS904gky531SiQf7VIACa2nkFqLyDF3X62ZKz
 cRHrawIWubDHUBbplBWH98HMqYWwCzS+t3kVjXUSQe9FXYC6xaV6VEbHPk+cbb5HyjUQ+1XnSmG
 jLh+XRqL1un5m2SM5iG+afYSlVIetF4FI7TNLXwbY1Eqbiteqg9itPYeCkBV8Ji4O4B6qv32i9L
 m/YR3AGlW3VPfhFnD682SyOz+YdR0fpi0f5OqTlw6P3SSbwMd7EbXalUextSdqzeSnzjTdTpZPx
 phNREITQ295ivOBPvGqnjPs5pQuLB2nUpbqTB82I8GIcW43FqqhtcbyTw7NYOsItZPTU93/BKVz
 IJlTK942llvJNf+tZT9Gg=
X-Google-Smtp-Source: AGHT+IF84G6yc8TllaJ8qa0FxfTuDNmXLhkwAmuI9/tx5EbnTWh7aMrJERgZQHWms2VW7/HYLLbIsw==
X-Received: by 2002:a5d:588f:0:b0:415:b17:1e47 with SMTP id
 ffacd0b85a97d-425671c18c0mr6143455f8f.54.1759665435566; 
 Sun, 05 Oct 2025 04:57:15 -0700 (PDT)
Received: from [192.168.3.103] (p57b4cc6f.dip0.t-ipconnect.de.
 [87.180.204.111]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01absm15997691f8f.44.2025.10.05.04.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Oct 2025 04:57:13 -0700 (PDT)
Message-ID: <45d131d2-c409-45f7-b8a9-fc5c3f6280de@linaro.org>
Date: Sun, 5 Oct 2025 13:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy; qcom: Rework Kconfig logic around MSM8916_USB_PHY
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
References: <20251003203927.1030052-1-trini@konsulko.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251003203927.1030052-1-trini@konsulko.com>
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



On 10/3/25 22:39, Tom Rini wrote:
> This PHY driver is required by USB_EHCI_MSM and not useful on its own.
> Rather than have it be a prompted option, it should (and currently is)
> select'd by USB_EHCI_MSM. Remove the prompt for this option and then
> correct the dependency chain (it must select PHY).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: u-boot-qcom@groups.io
> ---
>   drivers/phy/qcom/Kconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 61e5e2fca413..0dd69f7ffd0c 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -1,8 +1,8 @@
>   config MSM8916_USB_PHY
> -	bool "Qualcomm MSM8916 USB PHY support"
> -	depends on PHY
> +	bool
> +	select PHY
>   	help
> -          Support the USB PHY in msm8916
> +          Support the Qualcomm MSM8916 USB PHY
>   
>   	  This PHY is found on qualcomm dragonboard410c development board.
>   

