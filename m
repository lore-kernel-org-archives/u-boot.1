Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81ABCCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC60836D1;
	Thu, 16 Oct 2025 16:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YvPBZ7rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D295836F0; Thu, 16 Oct 2025 16:40:32 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9861A83655
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63b9da76e42so1590233a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760625630; x=1761230430; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ShWKyJ++An9uXeF1SKxoLdycOgadqLomJ9PahbMPh+Y=;
 b=YvPBZ7rnHzv2JmEAwhRIrXOeeIb3nQ8WGxmGKB8/8qw/HCSoSOB5zYcyDwhhCofSsb
 ag5ytcnEVLlRRQuywrzIZyBxLXcqQh/b0Nz4E29b/AVbyp+qaUzK/zK9mxdc7njyJg+9
 fxOzdZEDlTgp01c3aNdsSRHsHNCU2PV/Kzd0z+uoxqRJmf40Y2mx5lSFvHUVWHcbTYri
 +rvtjshP0NbD6djXeQthXH3XKcsAE1BpiNr+zTN4r2AF/iWMLBUhdaRREIblLqw7vA0A
 7qC1ffiUq5cieLuuKpeCowXxzh4pHh6fe2MbGGP5IJT4+QNNvMkWGhfUsLnorahhncdX
 F/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760625630; x=1761230430;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ShWKyJ++An9uXeF1SKxoLdycOgadqLomJ9PahbMPh+Y=;
 b=wz3idn2dwm2sOZtVYz8cN12w/zO5Tp3fHChidQ80DoRAfSwDqMfxwWvRrykVzikEXJ
 hPjdMX7/M5bBLoJsCqeu5aY9Tpzwm+jjfAh+ymhSpeXjLuUvBhVnzhfV+pGVflCcevq9
 5qXdun0GAZFihZtUSCOpRfmnJvsUqcZENsU9rD+u1YbzmLT5PQ63Syb0dETDUqFe7JY1
 SuaprJV0kSrPRczhQZLsg4p9pHicLZEeCD6Hc80/r6n9wXae4nvypPuoC+B3lFeoCFxe
 hzV5lUqnvDYqNz+/WjyiPtiYQ7QdGHflYu1Ftdo7s0FS0ttrvl1w4wqiAmWRgbJdBqkV
 DGYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMMhWnAR0LsKdnOkKlpT8LzgDfLErWjg6ZQ4W4u0apTAqn84gBjgBjlNK+euaxl4oCSrUHoCY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz39cyRxRVHYtSaFitbEZ353/5kEKDEGr2PU/ZPsqSnVRM7B/uG
 Cfn7gmZLJ5zyEIn02WzB45vrH/yNIWjQR99kziwaHaewG+mKEHOEsxFpLW1RNrdRxWE=
X-Gm-Gg: ASbGncvksEGTPRpjfmAH9ZNQbQqGLdHKURENWNzFGvI91YEJ9cAS7wr9sRZHyLdEMuW
 kqz1jFTPoGdfCQlIakIjfxxjXXqVsn7ZqtkdljvTAunhhhWxUSlmcGO+11GuGBsU9UEtCFi4OHo
 j5laBF7VXA0rebnw69/v/Vl0IyGdgSQvm/rRMmwU8+t2n3Ct1g8WtflTniEM+Hn9qSUOyCj9Zq8
 qDK/JVNNoi/FDr+PpOskAA+SJWGq+11749Ml3YvuLDwZLuBLEu1EPRBsRXoeOQwDgW1SGRUeafR
 i0H15XtHsFnoSmFZcM949NrVVN5gB6X2iO9yL4C5Wpia3+kPr9JzyWPtL1hL/bYpYrsl1NyMZ6E
 is2g6J0pw3Trp7lY0vGP8+B8FVxxBygKFY51EaPTtlHlbJsqnsY91BKh1zOYToMbVAlzxmok5tu
 JZoz/waisVBzME37atIziWmaQWU5KbsfmjxQwhUbyB7+Uo
X-Google-Smtp-Source: AGHT+IGUybIka8VnpUgporu5Nt4Ts5S/LYuvBZI1Wwo+6Hrmme0uGWYY+/XknGwl77Ohyhfm3qzllw==
X-Received: by 2002:a17:906:6a1e:b0:afe:b92b:28e9 with SMTP id
 a640c23a62f3a-b647423f370mr19517666b.49.1760625630052; 
 Thu, 16 Oct 2025 07:40:30 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e551.dip0.t-ipconnect.de. [91.41.229.81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cce3cec76sm528616866b.25.2025.10.16.07.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 07:40:29 -0700 (PDT)
Message-ID: <86d96562-214c-45b4-8206-df3030c7e8aa@linaro.org>
Date: Thu, 16 Oct 2025 16:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom_defconfig: Enable meminfo command with mapping
Content-Language: en-US
To: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 u-boot@lists.denx.de, neil.armstrong@linaro.org, sumit.garg@kernel.org
References: <20251010051200.2313081-1-venkyada@qti.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251010051200.2313081-1-venkyada@qti.qualcomm.com>
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



On 10/10/2025 07:12, Abbarapu Venkatesh Yadav wrote:
> Enable meminfo command to be able to see where things are mapped.
> 
> Signed-off-by: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 8d1269b4634..4c00cf91166 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -29,6 +29,8 @@ CONFIG_CMD_EEPROM=y
>  CONFIG_SYS_I2C_EEPROM_BUS=2
>  CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>  CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
>  # CONFIG_CMD_BIND is not set
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_DFU=y

-- 
// Casey (she/her)

