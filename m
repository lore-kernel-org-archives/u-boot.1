Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A9BC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5FD8888B9;
	Wed, 22 May 2024 18:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gGXxVlAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54B7888B7; Wed, 22 May 2024 18:22:43 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7E18888B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-572e48f91e9so11561342a12.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716394961; x=1716999761; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E+JNibEi5cAlDpkZihedK7tUxAu+MR+W02Q6HW3foM8=;
 b=gGXxVlAJR3YMlQJDOO4hjiqe59gKx8URDSNPpq8Xsxr9JqK4xBq/eqIFGDqqH57Jxm
 IFH2/pV7Nxw5GwsTEP8dvMVnj2O91f0Nt4hZFG3D359cNpZV61VlFumbsGobuyCON47X
 AW9AQnoiHj0CjGElHwz5gTOLdmp3PntHuWfl2QahX+fi8TrFqx8TYpDh5y0vgEWsOUN4
 z0EdwOy1AosOPXTWm2JFQGHwyPSJs42gKJpGWgLBt5eBwx0nM7THxZPa/k55SpAg1Rt/
 ngACD3O7wL1FadVhN2bHecfrM8cm85iAb+jUxhHL16FCBxTJT5PoswFxxDByKIo6G2uQ
 TYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716394961; x=1716999761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E+JNibEi5cAlDpkZihedK7tUxAu+MR+W02Q6HW3foM8=;
 b=aC/P1fsVMPdIdVaPcEk8yXp9QhMSM9TksZHBXk/FdhWWuimSqdLFO6YD7mx+DrDFa8
 v6to4QV8ojEuwdOHaK9ZPbJXktTUdcEubM+EG09sf8p2DSMJNqSn5LgOHZ87JvO84yAK
 IdEaaJayGPDGxTg/4aoca3d5F6kBhnr8sINP1XDyoGiNSpmMt081bfIaZsleWgojl7kg
 xuF4KVq3r2QE8/Wp+8ZoZ1RhMCzgf0LaNSJLkD/Ngk3jlEjYFD3bpAStBMjNG33nrMiZ
 Wn9C4K/reJc1/TKldDMDlAvgxCCJr9QNS0c0oOnvXd1e1PmY0MZdDq9Tlfxbb6ivEiaR
 Jndw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqMiioEKZtUo4VeUcUbByzP8H/URiyUWsNWRnpSkXKzb4abdxzwawNvWE1pr5tKBsnHOXImXMDzjJQF/EW8+HHQxM5aA==
X-Gm-Message-State: AOJu0YwWSGJ3M0hCRfwQB/HK36xM3vzyBYtyS85g6q0JIbPrBrlQ8Pux
 B2up0Wz6YRuCsWyWW0Mb0vn/CEidhi1ukOLs4Z+F42hYwWw1e0sknzYrgR6RUhA=
X-Google-Smtp-Source: AGHT+IGVQo8C18hmfJz+2dlYW2+MxA0eoZbsbkm+wldo44Qgf8l5YBF5YWkSpsLPcMkVQiUCHjuTNA==
X-Received: by 2002:a17:906:5d5:b0:a59:a8a4:a59d with SMTP id
 a640c23a62f3a-a6228199b5dmr161344866b.62.1716394961154; 
 Wed, 22 May 2024 09:22:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01399sm1834699466b.172.2024.05.22.09.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 09:22:40 -0700 (PDT)
Message-ID: <289a7fb8-7a27-43aa-8215-fd4ef941a88e@linaro.org>
Date: Wed, 22 May 2024 18:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom: ipq4019: add missing
 networking resets
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 j4g8y7@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240522101437.225880-1-robert.marko@sartura.hr>
 <20240522101437.225880-2-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240522101437.225880-2-robert.marko@sartura.hr>
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

Hi Robert,

On 22/05/2024 12:13, Robert Marko wrote:
> Add bindings for the missing networking resets found in IPQ4019 GCC.
> This syncs the bindigs with Linux.

These bindings are already synced from Linux in dts/upstream/include/...

You should be able to just delete this vendored file instead.

Kind regards,
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>   include/dt-bindings/clock/qcom,gcc-ipq4019.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq4019.h b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> index 7e8a7be6dc..fa05878575 100644
> --- a/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> +++ b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> @@ -165,5 +165,11 @@
>   #define GCC_QDSS_BCR					69
>   #define GCC_MPM_BCR					70
>   #define GCC_SPDM_BCR					71
> +#define ESS_MAC1_ARES					72
> +#define ESS_MAC2_ARES					73
> +#define ESS_MAC3_ARES					74
> +#define ESS_MAC4_ARES					75
> +#define ESS_MAC5_ARES					76
> +#define ESS_PSGMII_ARES					77
>   
>   #endif

-- 
// Caleb (they/them)
