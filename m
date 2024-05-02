Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD46C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E412E882AE;
	Thu,  2 May 2024 15:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="phLMX1ai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9088838E; Thu,  2 May 2024 15:41:57 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A51882AE
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a52223e004dso891442866b.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714657315; x=1715262115; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRRDRfOe1hRWoy+hOvgi8leU0HuFtqezAnUxxqvJjEI=;
 b=phLMX1aiIsv8KrcJUuhbvvqAzkXAOQVtc3ees3gm/HHSCxqwVzqSxe1MyY/s3BXCLy
 onZLcsoZVsdUQQCOug9XerfxxOVkMwtr7s+RA+KpWZ88A2FUKBvgzfWGkKje88M/l63u
 tooP//zgs/LyNR1zcCY0Oj4N3bBRqzreRHQjupcGElezuirah6zGY1hN6dlx3hyuPQjv
 R1OsZoz6me6Mo9RoK9HVRgisZoTa0edt3AW66+R1G/HeTQqtw9qDdL+EzSiOZkBdnrWM
 dRpnBS7K7tZmlBywWMpsy33KPb3EwHXX9p9feFTfWyA/v0cqZszPZc/kSmy9NdlIDDvs
 J5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714657315; x=1715262115;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PRRDRfOe1hRWoy+hOvgi8leU0HuFtqezAnUxxqvJjEI=;
 b=SAP4rueNtvgyVJjPQbAzJbiOI+H7Jsu83dD6OmKSH1RDAUrapO29THwbbl0Xr3JTY2
 wZN6fdrLoNcDrh/MQD7Z5niX91di1II7rzhQ7rkXn13PLS7CS6TlcZZN6khxOIsUWF6e
 gKiR19S3rmVRymDHU0TSUmiLiQ2oRCEsb1ASsk+AcrbD4W03Lxk931scd8Sq5YXU7Scr
 3N01v6qpk9b17bG1dIbSZS2a3LpxrW6I2h1t1EKEA/DJDICIhMfXoLu3SeIObcEqeLe4
 +27FY6B3lB27jfycHPzAZvZNK2tqG5FsPEgNBGKTL7aELLPLUtFlaWo5EWN6Boih+sdD
 3Erg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbGCZ2ecOjYG6nt/F1ovsWqHPww3RaHJ6AuWkmw2Vt0aEyrJvDQQcml0PJxQVouUZVxcAZZg9F4+dU1Amd32FUsricMQ==
X-Gm-Message-State: AOJu0YwRfccPTt8oQ0F0J6r6nq28b+6zi5rd0VL270lGxuRR1+I6GUBx
 p4TiKrB4z37dauE1Y25D1Q7GCYi8NxQOxag9n4RNs/rJXjduNQdMbOmRYUxwjQQ=
X-Google-Smtp-Source: AGHT+IFdl+rW8djF8tNiQT84EAiZURmsUCYuJXD9xUp2VdFHr3tdFXlh39ogTnj+un6nsx7Q/GA/2g==
X-Received: by 2002:a17:906:e08:b0:a55:5ff4:ff4f with SMTP id
 l8-20020a1709060e0800b00a555ff4ff4fmr1603021eji.71.1714657315234; 
 Thu, 02 May 2024 06:41:55 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a17090606c200b00a5910978658sm563684ejb.208.2024.05.02.06.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 06:41:54 -0700 (PDT)
Message-ID: <526f5a87-24e6-4147-a29b-ee4e74c6abde@linaro.org>
Date: Thu, 2 May 2024 15:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qcom: ehci: enable core + iface clocks
To: Sam Day <me@samcday.com>, u-boot@lists.denx.de
References: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
Content-Language: en-US
Cc: Robert Marko <robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
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

Hi Sam,

On 02/05/2024 15:16, Sam Day wrote:
> These clocks are mandatory, as can be seen in msm_hsusb driver in the
> Linux kernel.
> 
> The appropriate HS_USB AHB/SYSTEM clocks were added to gcc_apq8016.
> 
> Technically there's other adjacent SoC families that can use the
> msm_hsusb driver with different clocks, but only msm8916/apq8016 are
> currently making use of it so I think this change shouldn't break
> anything elsewhere.

Thanks for the patches. I have a feeling this might break IPQ4019, you 
might need to stub the clks there (cc Robert).

Seems like the To: and Cc: addresses aren't all quite right still.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
> Sam Day (2):
>        clk/qcom: apq8016: add support for USB_HS clocks
>        ehci: msm: bring up iface + core clocks
> 
>   drivers/clk/qcom/clock-apq8016.c | 31 +++++++++++++++++++++++++++++++
>   drivers/usb/host/ehci-msm.c      | 37 +++++++++++++++++++++++++++++++++++--
>   2 files changed, 66 insertions(+), 2 deletions(-)
> ---
> base-commit: ff0de1f0557ed7d2dab47ba976a37347a1fdc432
> change-id: 20240502-msm8916-hs-usb-clocks-34bc22b03f3d
> 
> Best regards,

-- 
// Caleb (they/them)
