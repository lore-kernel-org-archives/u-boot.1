Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA0ACD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0962B845E3;
	Mon, 18 May 2026 11:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ht07/SCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3601B8460E; Mon, 18 May 2026 11:05:50 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29D084150
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso25204255e9.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779095147; x=1779699947; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZWznzA97tH20aUaf0XccqoSyT3wECQZ4l09vr0ou9Fo=;
 b=ht07/SCzWP9D+C7eI0fksrSjROLI5Py6h3bWYUaKj3EnCpgJZvpsUdoiuSAJWTR1h1
 3R0DbirHnWR4+qhiZ9VGxIg3b3euDTZLv6/G198te+DKF/sCHR0CH3w7jQA2Jah+r+Tj
 I9MiUT4/Zb67ZL7/6QzHfJfZt3rjVpK9cvUgIW7byVp413MF4ghiIRHsZIwQoTIHExZX
 xlXVCM7sT6OwAUsk4fTVHl/8s5QHFGCgCZAVVxwcl1Gw1KFlp5ZttKtcifaetNJeHbAX
 wNWUUuW7I99DSE97RG6z11MgyPxL7MH5VpBAayVcQ/+4tAtYwlcu/4flCRP8m3sct4pS
 L1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779095147; x=1779699947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZWznzA97tH20aUaf0XccqoSyT3wECQZ4l09vr0ou9Fo=;
 b=kqVB8XUf4WTp+VcId4kSE2N0LTvRszp1bMWcJarfc1sUqzEXZ9cjoDE2EYZYiiSbRk
 yJDYRKwzngX77Rmq+syrZLQw0F7qBkATQ4VXB9WfKWcFlvuzD9S813F9Ydp12GVmdjmh
 T7oMhdcSvRhMFz66NnkJY2Ul5bbEZz7VwzYT207NQu9UFoGyIPGT0LZOWmkp5rsVhDA3
 T1EppnX1aBd7Bsjtzz+rv1nbf038smLM84yObmg26JLF0jTDQ+8ObFGY9XjaSIS50Udn
 AI0tgANt+51/aRdAKuo6EVf5MbzBW6x/romq4WWF2zFGWmS5k6B3cQAWIRlkKstwD2qK
 VbCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8O3PykpB+5mPzlY7CYafrUL3c6G1m6Rm3Cb2Tns4eA8+Kn5aJ0QEFVPlzmmQej/13xbat+uN8=@lists.denx.de
X-Gm-Message-State: AOJu0YzjGNc4cTQ0JBPPIh5affthjOKPTXa0R7l5id+wLWfrvt/flx6g
 glmL9n6Dd9cWFMcd3clQbCiNRXR2491R3NryCDOJg22PJUDWVUgTrO8XtpL7nD1MqO8=
X-Gm-Gg: Acq92OGAMQ045jI2ELPyKlA6jMOX5S1WfKp4DKw+AlYHZbBHmKIz6Q5goez53xxc03O
 8hVoiYfj9ApP/DBoJQPYdjZDFebV0d5UoAxGIR6Td67S22jnxNz+4+mslSjAVZv22QwHzrvthGQ
 Nx0Vr77cjoDP/yDY3Famhlt2+24nCxn9TdA5yspNm/Cg6o8FDJnBQ4RGdBGIXnBrJatf3wSsYEr
 xDO84Is2P4sT0FYIA4DuD2N+b3KFh4CCCORRzGpROyA+TNiXowrUZUgDNZegaKc7zJ2fCtH/AwW
 Mn8De3bFLqvRDxhegbqRkxw16eTcMltX09253HjdqTtft6vqPlwmR45liW5ciCk+1YEnILAlvxf
 XwIkVrPWSv9eGRa7XsCZ+7GbJXmToAsUTQV4Hf6L4SruZsitSMe7zHVRVQqNpQFaIrzcRxPyxHQ
 uomh+11n/Zws7NbusdYzpjB9lHJQkJFHcCzeNH9EdAtpIxsWPHffpJCbm7CnNDy2fQwHNph3J9v
 UwN
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id
 5b1f17b1804b1-48fe59b047bmr239157765e9.0.1779095147204; 
 Mon, 18 May 2026 02:05:47 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb029180sm113331415e9.4.2026.05.18.02.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 02:05:46 -0700 (PDT)
Message-ID: <50306a7e-6d04-4ddf-9fcc-beba9c3f507a@linaro.org>
Date: Mon, 18 May 2026 11:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add SM6125 UFS support, Fix QCM2290 clock, Add
 poweroff command
Content-Language: en-US
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
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

Hiya,

Didn't see that you already sent a v2, I'll just move the config option
while I pick this up so no need to resend.

Thanks,

On 15/05/2026 20:10, Biswapriyo Nath wrote:
> Changes:
> - Add poweroff command in qcom-phone config
> - Fix vote_bit of gpll6 clock in qcm2290
> - Add SM6115 and SM6125 to QMP UFS PHY driver
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
> ---
> Changes in v2:
> - Add commit message in clock driver fix commit.
> - Link to v1: https://patch.msgid.link/20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com
> 
> ---
> Biswapriyo Nath (3):
>       phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
>       clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
>       board/qualcomm: qcom-phone: Add poweroff command
> 
>  board/qualcomm/qcom-phone.config    | 1 +
>  board/qualcomm/qcom-phone.env       | 1 +
>  drivers/clk/qcom/clock-qcm2290.c    | 2 +-
>  drivers/phy/qcom/phy-qcom-qmp-ufs.c | 2 ++
>  4 files changed, 5 insertions(+), 1 deletion(-)
> ---
> base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
> change-id: 20260512-ufs-sm61x5-ea6fb71b585e
> 
> Best regards,
> --  
> Biswapriyo Nath <nathbappai@gmail.com>
> 

-- 
// Casey (she/her)

