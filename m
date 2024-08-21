Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA50DC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27AFE88AA7;
	Wed, 21 Aug 2024 16:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gu/tadDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B4888B31; Wed, 21 Aug 2024 16:11:45 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F0D88717
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bed83488b6so5865611a12.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724249503; x=1724854303; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/kY835rdoZue16rgsyQGbfE7GzSD9RWFtHZU3qvSCQ=;
 b=gu/tadDVRuAkTOMpYiZxx46Zpdh+yXu0xAv2uwV/1xXAJTf0fjjjZiDLu1znA7mlmW
 f0TOQ3bvIhgCNbX6AbXSIb+DlvvlkT1QLIRh8vqEV6+WqCi/05K8ifezubExgSKNeIN0
 kDHK3MgI62r5poNO0GqJKe3lSUKCEWCqYb9mKOhbrn2aC758SIxcNhsHP44ZxFLy/N2y
 3d/8bsHopHacK2OIDp7afzWxtNFiX9NZ8s8N5LGB8wUtvrFurpgUp6r02RVnM+zgOwGN
 gW5+lR5INoEUOFydoSJRseWVDYPpWAtHGCO+bQd0zQOPh9Rp3t93n3sHfNrrQTmxhmfd
 S0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724249503; x=1724854303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/kY835rdoZue16rgsyQGbfE7GzSD9RWFtHZU3qvSCQ=;
 b=TFM+f187riX0o8eEUvej0smVZqvFJzGnvYlmrp3WGlSIjCbUQCEnvMDlPHkXdz6x6k
 MEEbC8eCWZToZ1HJsETXyi9R9DnG21lw15uhDWqQE1ShVDp3muAh0oEDFpKyBcg73KfL
 SF9AxGGZbVAfkVUrESwzuoMD7Cnl3WL4gYG3fPwRw1F5cCXlh08mG15V/WKDFpL+jfT7
 zKQKiD2nd6KZhxURJ1U+Oat81xrteaWz3m9jfkQVVV1gxtDJqzr174uFYIoR4rQxBqYw
 FqUPjfh7mhgokCORBrpjU/KMvDKPqj1/4kvxiOP8xJAlj8hbrqqJsxmL62yii+joTMwi
 a4KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0KLwaoirlfH5NILRBsHOlZRdHnWsuBpZwx8wo2Rf0nHwbJZpcHuMLHoHlVNV4GkH6Wf75yTs=@lists.denx.de
X-Gm-Message-State: AOJu0YxjoKIPdfAubOS+V+toNaDIGbPzTkMQWWZnAsx6yOyZlgpJtRP2
 19PBXqmxHZKU7XizlvuLbxYC4bpKxt3Ktu3WNS68pmFQC85/CWbFU0YZIqqY/lQ=
X-Google-Smtp-Source: AGHT+IF1ng4whfgvg0gk+m4+4M69iMEiRQqasPrSaiKzx15Xa8CILFTvoOqlLVB0xJXWMUdT1jzJpg==
X-Received: by 2002:a05:6402:34c4:b0:5be:caf6:9dc7 with SMTP id
 4fb4d7f45d1cf-5bf1f23301dmr1628829a12.25.1724249502454; 
 Wed, 21 Aug 2024 07:11:42 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc0812a3sm8093496a12.82.2024.08.21.07.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 07:11:42 -0700 (PDT)
Message-ID: <2a45562f-792f-4ad5-9871-bef82ccd2d18@linaro.org>
Date: Wed, 21 Aug 2024 16:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
 <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
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

Hi Simon,
>> +U_BOOT_DRIVER(gcc_sc7280) = {
>> +       .name           = "gcc_sc7280",
>> +       .id             = UCLASS_NOP,
>> +       .of_match       = gcc_sc7280_of_match,
>> +       .bind           = qcom_cc_bind,
>> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>> +};
> 
> This should use driver model, with a UCLASS_CLK and UCLASS_RESET

Please refer to qcom_cc_bind() which binds the clock, reset, and power 
domain drivers.

Kind regards,
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
