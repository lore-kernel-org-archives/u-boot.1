Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D83C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F334982C84;
	Wed, 13 Aug 2025 15:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iTTLMlIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04584835C9; Wed, 13 Aug 2025 15:18:42 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1022B80FA8
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 15:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so61252425e9.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755091119; x=1755695919; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDG6+av9C5rAN4Htpa7D8JCl0QzwlsQEsZqj2ovqczE=;
 b=iTTLMlImuEsXwTGbJYNVNxbJoHVtR0sOIobPOrzQeYswj4x4CrcP641VN3JljUJThx
 u50DtIPQfFhv9c+15npLIXjY3lSVoAPX1Z570Io5/Ktf6sqY5NTj3xYVrsJKMNSGszu8
 hfygDFgHozJ89IUy+zUauZ4cDPr8vEg2JCAliYtqjjOuITioUEJz7JtASndzmKuiB+JW
 H4/ZS6hUNTu0WTYU+yshwsQUYSiEa5e5Zk6zOrqRTqm1ZbaWDz60xrjqyQ0EPIz0vjMJ
 +milUg+QY/oMCZtvhBH9smh4aKB8VJ3SQMn0MY2ced+308eYvuOu0/tZiNXDRC211+Y/
 z+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755091119; x=1755695919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDG6+av9C5rAN4Htpa7D8JCl0QzwlsQEsZqj2ovqczE=;
 b=dPLgCL2dSaJhQ3fmbkeeHD02xi0eCrgrPjzvDsd6f7hf0gYCa1aXWYhfLNeskpA+BI
 Jiv0Lh+8M2DbRpxYdZiNjBA3+denjbDVE/fKzBJkmvUq8XqrXC7rPAMrzogDHQYZazFv
 7gQTbh8H/JCCqSPzRPqBB7vKJddDAvLgZSVe1L2OP+qeTuWeGpph/yFqboMt3PAginTB
 4W27CSpG/XGi6wH4wIBX8uO9BAGLh5Yu0AFEdENZTU5mKw0HN+Gm/LV9hBY0VRVF5eEW
 EEDkq6DZOXCXNAD4umaGHP7f6riM0oGtapHjtuoxn5jK4GgcXLCQwHmyINnawfiWWSP7
 XOEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI8o2/SQYXWt+hHLOKEgrx7ckdfpDx4wXWjK3T7UIsiJJ5y+xN7f0aIDj1hJk/PHsskvcBruc=@lists.denx.de
X-Gm-Message-State: AOJu0YxNfvPIZMXN39ztMMYuD98FkedZp62PIko8oSk1d0t3R9RxaK5o
 OP2wzbycJLlafRi9q3ja4hAg8Ow77+YRPKyjVDlVSvj9TMGSrNC7qaOVLbLJdzb99WX9CE2YcJk
 5AqF9
X-Gm-Gg: ASbGnct2CvL6baP4oYciYZrEkqdmBusM58hDLw86eC4nyUC6zycyeXZk9MFTdmgQEZy
 jh/2s9zz/BlAYnOh9bg76oPcHshNyJCiCjIpZTiOxVEKWUEaiyKJ9BHlVcCt8eAFA6kFeI5QmTs
 ioVVz7a0LfgEqalLk6daOTNZYcPxfX/56jPbZKn4VWRG3yqK0qZU1wgnjC8PCCfUulrspSKjgxP
 t59ZU7w6tB00HyaTJaT29xaIBHF2hEYgFDa24aSQRaz8GJ3m8N4Z/9sTze+0d+jM2M4l5O8YjoO
 GKeipA2NMHzT0NpZjHHc8oko334wofVj7r2PDSeMgmhlki/cowsmnatz4Wmikb4iw4MKMgnx1nR
 U0VN2gJ+L2B3T5LjaZA0ynJ7BM8kEvivN1ubP/TXHkdK+rb+bVb8KWCRWKoq7qUWYI6o4ME6U9p
 0=
X-Google-Smtp-Source: AGHT+IHGHHaWxn2Zny4zTHFRXOUGoFEBvT01WHZUg8S6yz3iDSIHYCCgH0rOYeBDQwIYydv7GpdE0A==
X-Received: by 2002:a05:600c:4f8a:b0:459:dfde:3329 with SMTP id
 5b1f17b1804b1-45a165f7e8fmr29993895e9.31.1755091119464; 
 Wed, 13 Aug 2025 06:18:39 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a5961a0sm1929545e9.27.2025.08.13.06.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 06:18:38 -0700 (PDT)
Message-ID: <b506b4e6-3ff4-4319-a851-1583815ba005@linaro.org>
Date: Wed, 13 Aug 2025 15:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pinctrl: qcom: Address two Smatch reported issues
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250807-pinctrl_qcom-v1-0-42fac6707fd5@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250807-pinctrl_qcom-v1-0-42fac6707fd5@linaro.org>
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



On 07/08/2025 13:20, Andrew Goodbody wrote:
> Smatch reported issues with the limit checks in these two drivers that
> could lead to an index in an array going out of bounds.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Andrew Goodbody (2):
>       pinctrl: qcom: sa8775: Limit check for array index not correct
>       pinctrl: qcom: sdm845: Limit check off by 1
> 
>  drivers/pinctrl/qcom/pinctrl-sa8775p.c | 4 +++-
>  drivers/pinctrl/qcom/pinctrl-sdm845.c  | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> ---
> base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
> change-id: 20250807-pinctrl_qcom-5aa7ec35301b
> 
> Best regards,

-- 
// Casey (she/her)

