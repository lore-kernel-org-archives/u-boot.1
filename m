Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456BCC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C21D9807D6;
	Mon, 10 Feb 2025 17:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kGYYmAfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6A580AE1; Mon, 10 Feb 2025 17:38:07 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC4A80548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dcf8009f0so1516892f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205484; x=1739810284; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yh6hQ5mX8N2HpyM+evpi3ZE475If9lPgRS7qXOfE61Q=;
 b=kGYYmAfOHKmehf0rUl8Fh/Kg0djJwwmpOfZPPZAUWQFqXaIjZa8OEwjSEJ2306jk+Z
 Byu4tXxLFCXSvp6bPpZQBHix9JIWkYrJKEM8HxeOYHFRmXo4ctsSJ0XI7JCuTflgGQ29
 OXwYiGA0TLMEZ6mui+/FLpnWw29Svo7JHvZnvf75FPpxaTq627dfrjFV+rQfH7H4K5gH
 Cd64S6/MYvMKf87antv5fpaeFjkUfKccT/9OnVX2haO9xXTDggijvNvFpmzTVBTxLRCZ
 drmwu8C+AHYNwq9c5gn19Tyxs2fBpmLZy6QIxYHhg8gmJMxJuc87hTWA337KEdYvyRAW
 30Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205484; x=1739810284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yh6hQ5mX8N2HpyM+evpi3ZE475If9lPgRS7qXOfE61Q=;
 b=wVulGMfxVPIpds1DqrWEr+zKByUxLxyQY9YB+OeaO1NoHaO3GeDrkMyAH3+wQ+LBet
 gVCMNf9liJx25P3KVTKX3+QGcj7nSKcAcgzF5BuP6iCypO/MAxy31iW3DIvh2e5uTaTh
 Rdhxt6Gi3AHme0pwal/rF/DLDlJlIDXNQbc0uyVue9IJdgH0PF9Yh5or7wXDRfLrUD9g
 AlW+UByRfE0NQXwQ7Kk7j9idkJOWqpIXdffFVAzKoHTQ6Yt7Mtxv2FXdChZT4gf7AsJx
 ZZKEfVLiQoMywr3cNvjfslIBpj3zJ7GIaJW41zkUfpOk4uUSTj/WP0t/dZ6Ho1iw3Ig0
 hrsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaHkg1PWBkz2Qhb9clBNNXjh04xAP9GkfDwDdFrPYkJ5r0XwMDCqmGmzlCGzkzUC4dUgeGUa4=@lists.denx.de
X-Gm-Message-State: AOJu0YzWMSmjDxGmKWLZsemoDlRaIFFxNNf254r2K8dyg2ilFs0Mld2Z
 SENmxaUjYTo9BZh1ay8AkFrRjU1P5tO7mWxKLnHQ8EOwFZEAJPMQusvVFqBH1qc=
X-Gm-Gg: ASbGncutFssZuK1bdrQ406upZ/xXz2XqT6FAw59VpWFMILJYPwZYu4oBK0Xs+hdDfJ6
 uPLHczSULK6Ose1WJ76W3g99EPk829/YGZb69hhUjphjBQnzkvh/Qx7c5RuD2okkaXlsI7zTmw1
 P30B8H6ZycMPPqfplGnnCavCDgq5rcjmZaUUhnd0VdDxbjIYCgVVa5EeuKq2hBPsM5RPHJPuqHx
 eB5vxsjSaGpwKk0ZjaeuVopFVzuy/NVvw8MVXGGTepBcKNU0pzIv9FxDF2qhka5nvKYAiR9oHXb
 mK3FhIjKu+5LPzv3rMffRdbyIPe8uy7D6Gv6Zy3QkbyffPBBIRMdR0/Gs5WOZSB83tCdOcwI
X-Google-Smtp-Source: AGHT+IGO+BffsFcGqhsAGkBBITeWIExFbQ5foiNlgiRwJD5qVBE7c/gcHT++2egNegEyQdWAujMDJA==
X-Received: by 2002:a05:6000:1f8a:b0:38c:1270:f964 with SMTP id
 ffacd0b85a97d-38dc9371f3amr10398260f8f.47.1739205484645; 
 Mon, 10 Feb 2025 08:38:04 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9?
 ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc4458d71sm11740150f8f.63.2025.02.10.08.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:38:04 -0800 (PST)
Message-ID: <4dcb5a0b-5b40-4892-9088-2e9985b79074@linaro.org>
Date: Mon, 10 Feb 2025 16:38:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Qualcomm: fix sdcard support on SM8250
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Amit Pundir <amit.pundir@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
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



On 2/10/25 16:30, Caleb Connolly wrote:
> Enable the missing regulators and fix pinctrl so that the sdcard works
> on the RB5 board and presumably other devices.
> 
> This depends on the clk-stub patches since the MMC block itself
> references the rpmh vote-clock which we intend to stub.

whoops i forgot to add a link (b4 should pick it up though from headers)

https://lore.kernel.org/u-boot/20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org
> 
> ---
> Caleb Connolly (2):
>        power: regulator: add additional supported LDOs for pm8150l
>        pinctrl: qcom: sm8250: fix pin count
> 
>   drivers/pinctrl/qcom/pinctrl-sm8250.c         | 2 +-
>   drivers/power/regulator/qcom-rpmh-regulator.c | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> ---
> base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2
> 
> Caleb Connolly <caleb.connolly@linaro.org>
> 

-- 
Caleb (they/them)

