Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A8BC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D4B481FDE;
	Fri, 25 Apr 2025 12:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n5+ole1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75DB8209C; Fri, 25 Apr 2025 12:46:38 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C949C81F6B
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so418203866b.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577996; x=1746182796; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A/NO/4/+nKcJo1andROuEympeeRco8tLx5CCUVF8UoQ=;
 b=n5+ole1T0Ehc/rR6OlQvqMFE3fmAX632Vw7snv1y26xnaiv7t8pfiko9vAHqqmUTVW
 eq0mD5VrB178bX6h+JYc3PH6EZ+J7vP+87BBM1iqiKddU8QvvIxbScuT42epQPwNKLSo
 KppD0LwdHbOsNSxBpsvwMEIt6lE3I7T+rnHsoaNTQfBVmLl5GLVkM9iPziZM7R09AdxJ
 8GeS1FWgs63exb+a6hhOxnMVwJilECEsEyWGbfIqgz21ANL/0kfEbUC6LUN5boa9ThEq
 6DMgR2jxIuTj8oIjrNuiRe7feQNzOWmUdVxEzdj7sZ6rjoYjCuyZcIjqFWb/wZvHEypA
 ZYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577996; x=1746182796;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A/NO/4/+nKcJo1andROuEympeeRco8tLx5CCUVF8UoQ=;
 b=APQaufCLaygOmLgz+8ijqqGmjt8vFaScgiye8ALrsibTIBG+qLmaSm7RDJm9C9morK
 dKO/k4Gtu0leqn9Kz9c5BAAf8WYjN1oEtCexM3Yt2+Au/XAypuAU81ZH4G34o5hUBpId
 yjvWaPZG7KHO8dqwxi6/9YvgYZJN3tXHNQr5R5Hq8Mf9G0p+QLU59bN+yxphA2luiZ3k
 fgghnbzW9O7RVgfQkVtC+CMQINYThaqjCxzy6z5rqheL45D+kCX/ZlIJ6GS6itRVnBIr
 uWTLz/MnK8hNpGCgapT1lK/c7CXGo5SE6faE87uhgL55IxAZY5MpPk9v3baxVCn6qCz9
 2fXw==
X-Gm-Message-State: AOJu0YxCxV+ks9KFGtCaEvQBWLMhGwulJFBaX0+IVx+uO8SWL1vyIZlR
 5RN33WFlNmve5K37cZILmktAOFGE88+8KQvsA0lhkd5NbnpldKjuErt60dqGepQ=
X-Gm-Gg: ASbGncueNGkXiRZGKbcnNFqIKKWYRgpnw1QlMlBKowivJML/RYjwi1my6PpDc4bMy08
 +/rdAILTS6/ZIxSUimdDE1kj51DwE56kCyCT5xOh608VyIskhYCKRsKL3EtBXIQ3rZTUfGFwN5K
 e5GF3HUjPkUVKtg5+Myi824mWkQP2ywLAhaa+glQ8HksxM59Jcyu5cZUnsLFHmMcDW4Tu5hq3k/
 y4bhbZMj474h+iuoS1+p8h8kuF1uBeInkvCV+4WEfMJ/RTFjCQEjZDSZ9vXpnQop4UI3CkjQhLb
 zFy/VVfayROYLR6VQrrLNfb4ygIhDWhfnyEiYI399YDDR4jMGeBGaKBhfXE=
X-Google-Smtp-Source: AGHT+IEb17qajE+tyxvA8CkoAKdNo8wVKlW7usSUW+Ncogh1LYeD3bDaC//7nqJ14ODsk5+ZZEJM9A==
X-Received: by 2002:a17:907:7f8d:b0:acb:b1be:4873 with SMTP id
 a640c23a62f3a-ace71038c6dmr162218166b.2.1745577996203; 
 Fri, 25 Apr 2025 03:46:36 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf8c9bsm116591766b.101.2025.04.25.03.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:46:35 -0700 (PDT)
Message-ID: <2e0114a9-6114-49f3-8dcf-75166b998358@linaro.org>
Date: Fri, 25 Apr 2025 13:46:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] arm: at91: wdt: Remove unused at91_wdt struct
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
 <20250417-wdt-v2-2-49939de473e1@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250417-wdt-v2-2-49939de473e1@hifiphile.com>
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



On 4/17/25 12:09, Zixun LI wrote:
> at91_wdt struct is not used by anyone, let's remove it.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  arch/arm/mach-at91/include/mach/at91_wdt.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
> index 8ef8e007d7767308a5b46be46b02c51073723a41..78ad0453fd9eb3e42674d10cb11ce3da820cdc6a 100644
> --- a/arch/arm/mach-at91/include/mach/at91_wdt.h
> +++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
> @@ -19,12 +19,6 @@
>  
>  #else
>  
> -typedef struct at91_wdt {
> -	u32	cr;
> -	u32	mr;
> -	u32	sr;
> -} at91_wdt_t;
> -
>  struct at91_wdt_priv {
>  	void __iomem *regs;
>  	u32 regval;
> 

I would merge patch 1 with patch 2 (this one).
Removing references to a struct and removing the struct itself is a
single logical step. Having just patch 1 in the tree would leave out a
state where a non-used struct exists.
