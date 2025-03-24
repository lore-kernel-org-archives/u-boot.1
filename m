Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E10CC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBA7808AF;
	Mon, 24 Mar 2025 19:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P33VQJUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD320809D0; Mon, 24 Mar 2025 19:12:02 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03ACB806FC
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso30609645e9.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742839919; x=1743444719; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GWe9gOO4hsur8rwZsEvhtvlPyJ9AlguH/C3nmSnxmjU=;
 b=P33VQJUDir7Bs7xum4Ug0RzayRm98AuvCgO9xxjhXLhgoZLkO5UEVz3/KBQJm+Px/C
 vY7m8lQjXbyG8hSaangkUmUrkipP2kE4K3XmwzQDYmjST4pmk/4iI8KH/qv7o+REtPIg
 LVi0LKzf/mKjgQIrt5WQ1WkW4AqFqQPPAXarA51BSoPeBwPPHTAlAhBPgFnzSY3g2Ew4
 equFIP3SZtt7gpLEzDqLGKw2zpDByguq6/g/XSktbgia62o8EpS0uESY13DpYExF+KMT
 uMlqiHHFknbONRBm4kJ69yQ+h6e33Alt9GTNhkiNpg13gt9orJrQTZ73tWk6lDqiMM0/
 GMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742839919; x=1743444719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWe9gOO4hsur8rwZsEvhtvlPyJ9AlguH/C3nmSnxmjU=;
 b=YbNmPr4pqKsXZYPtAr5pGBiF1Bn1PgXGVclA8l5u+V9gv+C80WVFrwZuCpRvmpjb9V
 c+pOmYFEeQdwdMUJA03G9F/UUUORqSzLRdGyIVE+KIqumPxy6Z/ESb4W3ZPvuGeMMVuG
 I0f1AUfRYbrUEGgBH0O0HJm4wlFGwIXgVSs28EwOVSzJoNT7HptImF/aBx+q7Qh7yDDm
 zVztcn9i+hutM4fKc43h7rrs00Pev/PQ5mhqUK63UUc58U3wvqcHRyUm+QFR8PooVhy2
 jwXHX1ejUQX5ycahjH2HaWcgD4fDBJkCsHpeypLFEaTdbzwq0iRR/k3DP4ctPCevAq68
 EqRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvYkppl+cF5BEN7rK9gGdSkj1i1aim2n5zihyrrfswFc631i3tmlos2vuLwlidSuZXLU+PAzI=@lists.denx.de
X-Gm-Message-State: AOJu0YzlEXWCpumKX+amzJOSlFj0s8SmHYZ6+0jo89Yngd0L8WrnOu1f
 wMAX1gXW4qYSwzkz77By8KXyKfaKhKUprWgvdSCijDn3RUFCJAqBNzUvRnzLlhI=
X-Gm-Gg: ASbGncuMNLZz6C2zeVXnXLMWLzttGR3CTFNII0jhZjzwyh6NFUkvhMXOCGm9GROGzf/
 OSPLpLr1fX70LlS6HdKDhfcldMc4pS69h0Z5ooXB0BSAMkgqfQ+hytfbQbFmkd4wIUhy3BGEh8M
 r8/Icl4hQbXIiYk7h1SEiiDe4+1o9rTY4SuC3oPiZJ2LYeXxP8XvYjUjB1IAod0lAv+JX9jq0Rz
 0yR5GjOytpz6ofxMmI7pN3eiaW5TjfhD6QH/QwNmsE9grnJbwSJaQG+3oRz2I3w4Xsb/shuDYtT
 yT5q5xRE9OL7xHx1df+Z5esHmMrx6x8G/qqPHvg3S6w1773Uf0MqZOdkmn8qTRTIa9ZQp+oByXY
 =
X-Google-Smtp-Source: AGHT+IG4RSDDexYymZ3cxRjpC0xyIZ1UfyGZPOEBnPn/xLWZ0WNB4swTaWecCKFOPQw15s5Fk6h2iQ==
X-Received: by 2002:a05:600c:4584:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-43d509f3bffmr112466525e9.13.1742839918601; 
 Mon, 24 Mar 2025 11:11:58 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceafacsm130082085e9.6.2025.03.24.11.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 11:11:57 -0700 (PDT)
Message-ID: <2b334751-0899-4ba9-a5d9-5093426e2db6@linaro.org>
Date: Mon, 24 Mar 2025 19:11:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mach-snapdragon: of_fixup: fix property length at
 writing
To: Rui Miguel Silva <rui.silva@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250227094911.497219-1-rui.silva@linaro.org>
 <20250227094911.497219-2-rui.silva@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250227094911.497219-2-rui.silva@linaro.org>
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



On 2/27/25 10:45, Rui Miguel Silva wrote:
> The length of a property includes '\0' in a string type one, so
> the length passed by needs to have that in account, if not,
> when getting the property value it will fail because it
> has the wrong size.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>

Tested-by: <caleb.connolly@linaro.org> # db845c
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 55368dd43b66..ea956a4791d0 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -86,13 +86,13 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
>   	}
>   
>   	/* Overwrite "phy-names" to only contain a single entry */
> -	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
> +	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy") + 1, "usb2-phy");
>   	if (ret) {
>   		log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
>   		return ret;
>   	}
>   
> -	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed"), "high-speed");
> +	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed") + 1, "high-speed");
>   	if (ret) {
>   		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
>   		return ret;

-- 
Caleb (they/them)

