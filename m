Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190CAE7E0DA
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C7BB83CE3;
	Mon,  9 Feb 2026 19:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rpIeSzJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 566328397D; Mon,  9 Feb 2026 19:54:04 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE2083CE3
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso572445e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770663241; x=1771268041; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mGoD9NeCYhQAqpdJLD9xr/W/8xETsrHdghD6QA/Qrrs=;
 b=rpIeSzJh+yL7AYymObEBb3SO4bORJgSOjW5szzqYaNOGhTr79mMu718I7a4sIkqkZw
 ovJRhAQfrUwJ2l+5GeKS8I+XIoXquzC274pOYPQncdDgLmKH1LY3GMic8bZWIBofGIxe
 V+BTmeXnEm8O1v7vnmFqtGwC11Z2TxYdfvxLMZTSMZEz/piDFpAaIIqVrUztqNQimZh0
 UEjrw2897gMfrwPWq4b0sx3c6JZk5K8SaEAX2nJMubTMkYdSa8nvTcXVLzUIL5IgHK3V
 sQmNzd4lHBSKWOhNfLe8x3BBaR/s1J9yNmCF3K0hXYlB2Vp6mLLnCByjq6K/LTLXgX9m
 dtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770663241; x=1771268041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGoD9NeCYhQAqpdJLD9xr/W/8xETsrHdghD6QA/Qrrs=;
 b=LnEnrusaomtwVg0glBI8QXRQjBBVDuxhWRYio6AZNkoIXeixSBKm1CYRXsJiOjjumw
 IBUq6dHhgX2YBxgyxDaKcD15UPNYd7u4P0r6xBM9aH9/QWL/hZ9VeQpIQ/dKED7I2LIG
 jbRCnfjX00d4QLQIZS/13jzmV4D65A+zJZj6/xsVxb8f5k/4dsVnHsIsGXrYy5SEZhx3
 QLKN3NAVFZHg8P3ap9u84RsGLeanKqE8LeSyeqweZOXRkLG98iGeJC3IwDliHZ0aPQIl
 7CF8MAgvnZcoJAD5OCaQFqzCRpIdY2PJ0dB7ykUyDoRnJis6IRrbXLV5cURqs1+15wfL
 cRdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU+REhO0u/uPqp2I/klTl2WP2qPV2++s98XKpSFZnYJgTYsCrXMTJDw8LP0OV/T9WHQAFnJww=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7FH2dpBwSzbFJGh136e8h52PyiOODxYY+grbTeE+RRkOBu4bY
 a3fN4ZdU2OyEiYcPwOk0xoNcykUSKetmYe5LuQ09K116P7NbR2Ney8p3NeCb//3QoS3kyWpgR1J
 UeHRG
X-Gm-Gg: AZuq6aKYqQRmkGTY4n3LWAiz8WqfDRp/ugBO1PKYv2W3oPnAIlFXD86pdsQgMc5WF2Z
 iWzXMwFF2r9YD2QhkN32jt4v59U8dbcyBPVNNEf9DUhqR/8bmoKH2X2L0l09GkbSSnGk0Gfz7xZ
 d+bBuf+DPyjPvArXG5vcf4DTlzSpj7HrhuYGUVVak+wowT3NaayYpXsB4XH2ihroPopxgjWswYe
 mNqH90s76zbNh3rnZqITpFRsvfoP/FPFRAzGsF/BVaGIHYVXKrju1oA+FQlijryLWTt/ngW1Zst
 rzhjBiDwLVIlF/+y4p9l8jtpbrRIzMobuNIWIwWDN5wvQJPTzR1G/rGsPasXL9maZvFoLar6Cot
 ddLiQosZIwfgBlwXbpJEONzZZgpgvFBhiLuB/GJ+dazDdmN16nb4a1sLtpi+QB94ZnsAkGnUNET
 JSSKoyRpa+bbyHTybxklVcTh8HE05o4iE4zmoiEwJU/8jfiN3tBw==
X-Received: by 2002:a05:600c:3f08:b0:480:46c6:bf4b with SMTP id
 5b1f17b1804b1-483201dadb6mr180371285e9.5.1770663240875; 
 Mon, 09 Feb 2026 10:54:00 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209af8e0sm166112065e9.5.2026.02.09.10.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 10:54:00 -0800 (PST)
Message-ID: <50ae1a6a-25c4-41aa-9bb1-0496b730732a@linaro.org>
Date: Mon, 9 Feb 2026 19:53:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] board/qualcomm: Introduce TF-A and OP-TEE config
 fragment
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, neil.armstrong@linaro.org, jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
 <20260127062341.723966-4-sumit.garg@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260127062341.723966-4-sumit.garg@kernel.org>
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



On 27/01/2026 07:23, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> platforms. RB3Gen2 being the first one and more to come. U-Boot in
> corresponding boot flow is packaged as a position independent executable.
> 
> So, lets add a generic U-Boot config fragment for Qcom platforms to
> support TF-A/OP-TEE based TrustZone stack. Build command:
> 
> $ ./scripts/kconfig/merge_config.sh \
>        configs/qcom_defconfig \
>        board/qualcomm/tfa-optee.config
> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
> 
> For more information refer here:
> https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  board/qualcomm/tfa-optee.config | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 board/qualcomm/tfa-optee.config
> 
> diff --git a/board/qualcomm/tfa-optee.config b/board/qualcomm/tfa-optee.config
> new file mode 100644
> index 00000000000..1e8364c114f
> --- /dev/null
> +++ b/board/qualcomm/tfa-optee.config
> @@ -0,0 +1,4 @@
> +# Enables support for TF-A based OP-TEE as the open
> +# source TrustZone stack on Qcom platforms
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y

-- 
// Casey (she/her)

