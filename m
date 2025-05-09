Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6744DC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A48828BC;
	Fri,  9 May 2025 14:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZjtoEUIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B338210D; Fri,  9 May 2025 12:45:26 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078458059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 12:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so19365415e9.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746787523; x=1747392323; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3pO0DLAkd3GC996HDvj/5yP6402iUEjqru3cg/EVLTM=;
 b=ZjtoEUITnzBKwtpDgchrMYRejwqiUioKPkapQYGQ43w/G2//89RJm62jemozHLSyBy
 zf1as3aDHsQ8Uz2J25RVmdB/QG/NdABo6LYMrrgJGtssYDCY+0UJpwPleeHM+lropvSw
 zJJRvzDAFke0x0lLdiSC4SGbXQ7rR6pYK/PWFfhSYPiwKbwQ4oOZTX5m7EKBenIwiM0x
 NUmznjiSboO6AEh16I4EhW/7eBNh0Zw+7kldPeGiaGKCVWbv69uCefpeeeasZGEFzmdU
 a3+9yN3xakORNgpVpFXupGvH5mo3UG/MjMcTHGU7EBtuF7WfhOo9Eh1GF8fLJObOe3oI
 os9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746787523; x=1747392323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3pO0DLAkd3GC996HDvj/5yP6402iUEjqru3cg/EVLTM=;
 b=DmHJThmd1qzLUEKL4z3SI5Yd8jwSdEpS6hxLQKsrbCYqpC8VYkdekUl2SAuD1PbYZh
 fK7+fOSUfGUiV+dEosENPqDwH7k5DyPgPFdqTeMKPt8BGBtumM7umuvmW3d8W9+zX5P4
 O6S1zWsmb6UzfjBrriNTYUyVfOM0b/Nb5zYZOZkmSmK2p1k1UurMcDoXwIn1vnwF633z
 yEhGVdhDIoOoYF6nZZWfcYDAdeQiW7fG1lai9pnGLsZFrkkb31gqtsMjfwn0EAGLwWyE
 vVY7/wyvHQQP6L4V9bC1UhWBIg82lFq/HJL8J0qBccgd9UOjNY4Hk38x4k1lgW3CRhbU
 hZwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1+kmJ4SYW0rfrJiBrm/mn0fito+MtPZyCmxTBR4HGJZwHmTHBnnD71nUTyWjvOYM9om76xlA=@lists.denx.de
X-Gm-Message-State: AOJu0YyPEMYWKpwSOm67Ps7zT8v/nbhoGRtiTf+jOF32z+mQvTnfHAq2
 fvWHL2q8MQjEcCI8s2LzRer3w2UyfekkJIWOzbSbW3aIEo0TIexV/A9/Ve5Zs2TGLhECueIngOf
 J
X-Gm-Gg: ASbGncskI05tRTsPXWQBthWr4Dl0GmQzPxsqIMBvPpKDOyve0o9YOu+i7GLORab3R/9
 nfwOoYESkgXRhtaNQc/v8sGA5S1R9NvJ+KkBi4zpEfLCvLUzkQkl6qF4NRvTnt1ab3f7yKBwbIR
 vccaaPsNOMv3fntkQekcAlIOtyyGnzdtzLPMAuki353LYQH1T2J2vCnsGXZ3CTdM1eWt45YFr3X
 ty4fuqde9OAF++11zJBMutGEk0mWPACcOLk+6RaZZ/89Kr5Y1j4G4Cvctdb1xq/1hKnT/gfQ9T0
 1FWylX5vukmRQvjlErGoUMDTz3x4nLTzLS7rzHaBuwYeu2Pi5GFNy7oxVFLQLnwqjJlLTnjGDmn
 s/kRDDk4FYlCY7Q==
X-Google-Smtp-Source: AGHT+IHz6hLX0yhGxG/mUr7KEBw83sLhxYTmRff5ycC2z/EDmzlp0mclpAUZ/6v9xym2vJaNGW7t6A==
X-Received: by 2002:a05:600c:529a:b0:43d:b32:40aa with SMTP id
 5b1f17b1804b1-442d6d18c05mr26554955e9.3.1746787523465; 
 Fri, 09 May 2025 03:45:23 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3af15bsm68285705e9.30.2025.05.09.03.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:45:22 -0700 (PDT)
Message-ID: <fe44fd2a-f16e-4f84-affa-3f9fbbbbdc9b@linaro.org>
Date: Fri, 9 May 2025 12:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508103238.230608-1-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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



On 5/8/25 12:32, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> When debug serial port isn't connected, it is at least reported on RB1
> that autoboot gets interrupted. It is probably due to random characters
> on the UART RX line when disconnected. Lets try to fix this inconsistent
> behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
> interrupted only when the <SPACE> key gets pressed.

Honestly I'd much rather fix the bug in the UART driver, maybe it's 
broken pinctrl?

The older UART driver (for msm8916) had a similar but that Stephen was 
able to fix with better configuration.

Anyhow, this is a sensible enough workaround if nobody wants to look 
into GENI...

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   configs/qcom_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 36e2f45d22a..e3dac23f1d0 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -15,6 +15,9 @@ CONFIG_FIT_VERBOSE=y
>   CONFIG_BOOTSTD_FULL=y
>   # CONFIG_BOOTMETH_VBE is not set
>   CONFIG_BOOTDELAY=1
> +CONFIG_AUTOBOOT_KEYED=y
> +CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
> +CONFIG_AUTOBOOT_STOP_STR=" "
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_USE_PREBOOT=y
>   CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
-- 
Casey (she/they)

