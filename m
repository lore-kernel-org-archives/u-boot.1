Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC6EC3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 12:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB06820EB;
	Fri,  2 May 2025 14:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mkSagVCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F27801BE; Fri,  2 May 2025 14:32:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4E88210D
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 14:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so358457466b.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746189117; x=1746793917; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TE0G5YRyMp72H0uH8pozLg0ec0X7HBgjOp3xKFN+obg=;
 b=mkSagVCjhWV4j57Ch0z3xYAENUhncOTh6zBkmv407VTFkycfZ82TM4zvlmy0S4xuj+
 28tndp4hdGAfnzcp3G7Z+nfNYE5a3bqYnTrGXIq6tJ83/ruFErlPNTnrWJNCXFzU3uCB
 +dOtIZ8eQX300LXn1jURuMm7PLubaKJHFfIBIj5VctbC35qiGyOerQuzQxEXVkiv9R/B
 czwxx5Rj+nK4Fox123FnQ2ZyTki+WTycJIaigwSslqsN0d1rslJBv6ilPKhUTZMaEqke
 nqQGvCN5oxa+TGoGlsP0WtdPDWijbQghrdabHU5Bg5pIIYJXKhArW6ippKeZzrnKi6yt
 ehnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746189117; x=1746793917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TE0G5YRyMp72H0uH8pozLg0ec0X7HBgjOp3xKFN+obg=;
 b=Htn7mpGsfQIyMehIUePjsGfPKaK62QWak3NGspSQZ3QxRVSmxYxbWucygrQCD3oXWC
 nFRK1YPI7VZJ4i9S8iNuKBIS5j6M7yKiIbt9C0Z/EqeZkwUl0qTNUXlrzWsa2Qc/0iXO
 Rjko05QHTP1R38+VkKTsIPxjJ1QrsDMUm8y2eQPoiQyFc321L7mCI91v5xEggZvOoysh
 rKGOZN9vG3IaLf357QRYjJ+o7zcIu68yrB7ONTZb7+jGymvMJt6pxI8JDR2BaPGeRMI4
 lPohJyaQa4BDVhHUEWQPrmm+iYTvdCuIEJVUDk/zpNN/x25F7KVyV341/dYCZ/EcwZnH
 Jixg==
X-Gm-Message-State: AOJu0YxLrW78XzdLbVcZ4ejL6fQxYBGs0AsxDmYovKHJuetVep6aKq6I
 ij+QjyVRPsjqPeRGt0gbkqBnS3+F1biGIZswVMTg3tMyh5NdR4dmqyYJ0gdtVgOMRG1VKc6RHTh
 I
X-Gm-Gg: ASbGncsistPgjxc6kP2/9YRWt7bJZ4iZG3r1DSzMSHgmKmPbD8M2HU3909SCg/O8+6r
 cso4UBDzxWohFAu0Db7Ho0F5KNhFpugZPq0X6nt1xxCebJa88kk9tHeP3rVtslbjFd4o25Djha2
 rtUFEVEXf05z8KVp/gX+52hev4yOpu5/QeANALQaq7vX5F0mnSFdO3WPSHuDUyB+BGQzAZ2kIZt
 OTwyIuEK+dvS+MO0yepx/pJtBButhcG1FmsiZkGYKmetpm2Tr92RUuYz9C/lKdkFP+F4mYXnRyZ
 MQZcMI1r6MBiLV4Ik+7lLC46Q1vaEKQSBKk93z9Pz98/rBZdu5Wj6p9+zTo=
X-Google-Smtp-Source: AGHT+IGgOp0vZxd3aqjlBlZNNQgl573W5pN0bWgJIcXeasBFQe1gStDNYPPMY+tkohpqv3qUwRbH0w==
X-Received: by 2002:a17:906:4fd0:b0:ac6:d0f6:c85c with SMTP id
 a640c23a62f3a-ad17ad463c9mr291907666b.20.1746189117403; 
 Fri, 02 May 2025 05:31:57 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189147329sm44542966b.1.2025.05.02.05.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 05:31:57 -0700 (PDT)
Message-ID: <21f41a3e-5858-4e84-89db-cfad40442c7c@linaro.org>
Date: Fri, 2 May 2025 15:31:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] ARM: dts: at91: sam9x60-curiosity: Enable watchdog
 node
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-6-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250428-wdt-v4-6-bb7d1c7c051a@hifiphile.com>
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



On 4/28/25 12:16, Zixun LI wrote:
> Enable watchdog node on SAM9X60-Curiosity board.
> 
> A default timeout of 16s is added which is the maximum supported value,
> also matching Linux driver's behavior.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

