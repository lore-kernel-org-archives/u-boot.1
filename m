Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28AECFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5294F84508;
	Fri, 28 Nov 2025 12:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RgXBI9cD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D586784509; Fri, 28 Nov 2025 12:24:36 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D6B0844EC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b32a3e78bso1661592f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764329074; x=1764933874; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NJIoNzXvV/MqWILhYSVmF8FUeYEww6oFu9SojaoxcjE=;
 b=RgXBI9cDQClEaNJRShzI+sD48Fne9W8O1kap3ET6VZk/le5MxdZd0LKz/npr+nvxaT
 3mZPT9qdNmLwkj0p3ButZu4/zgAaqr/kMHLW7+2ZXMKOBcZChDnXsRARRVT25hRMO5Fm
 VBAFGiOLly34xBOQJGe/bgmUrtnw8i3e1Tw5oeaqP1ABlvKzCKtEYTirA4RsqSmXjPrj
 +cBuho1ytslwE+lIEYJsHqbZnX+sfGLQ58lZYAkpCBvI3j94aRxakUmPFZV24Fg5GfSq
 xGrEoJ2ruba6cwXbgYLxnAApYyv64wPv8j/slsZLjpyC+C/otce2pvra3VwSADyC5Uzw
 7xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764329074; x=1764933874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJIoNzXvV/MqWILhYSVmF8FUeYEww6oFu9SojaoxcjE=;
 b=Qn2miQTuzpJvp6rQexqrJ9a1r+qaK49FHudk+BIAJgV1CMmcbx73PePkGSfQwN9a/z
 kE9E2TTQqnoPCi4sKkN7hK3G1i/+mWkFmGKryKkXvyyKDf91uPO48KlsDYP8yEifkorY
 MSfMfsUIN8VtUWQpwDsVrALhNce8jfX/flLuJ14szTwx9sZ+3AajZNeCVnQ+CfZVBRJm
 OQW0r56Nlk5yi6gLk3UhRiA1iOEyDQ+EkXaQCny3oaAhyVFEsSBhDRMnH1aH1winyQYe
 onDhNIQ6iUEf3+A7LEd8gjpFsqEMEJszDXZsMhhpDWYT+I4c8kXm5324oB+KYV19nrC9
 MuIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE/eXMRu/GjzS9WfU56vqyfGQ87ZexSUGdl3Lghmy2cyiYk4Ven6Ui6ceTS6CrSd8dNby92r0=@lists.denx.de
X-Gm-Message-State: AOJu0YxjS0ch5QT9gO+9efEw5pjSa4G/iGKC7x8K95gDmqvq7Ji5k2Cu
 lBfhgeAppVE7CfFLH9TT1fYJqVAyTd6hoaKuunEza6UA4QDgKNaIbarLnvRtHDn3CBo=
X-Gm-Gg: ASbGnctxHqTp/q2tXTdL+vBTOZfFS+0fHUHTFC0Dmsrl0B0+jyndF3P04JSXFiadLim
 I7cmYRIo+ZNTj2V9qhMV+mequQoZyEOSy7HBoBpNySDb00A3GH4mngb3UFx68m20hsyaCKXR7Gm
 DQTfxnZkD0sw9BJfpg/6cyisS+6BTpurXO+ODpebLljzQXeN9xxY56d8jk6Ft5AdORpMDteSEw7
 HhNtk1O10d7UqNl7ApVNjH6bMnRYPUz10OMgz+1My29SoZOn/ClaVLB9C0LqcuRfCW7SgNbomfO
 bj50jwXV3wI1KUyuMbC4d2z192lyKyB8iDqMvQYJu98r+OwcieHZogn2UbMSlwdiy6yJGETC8fe
 hg+OGjU1gm860FMihXpagbyQh30ncZ1b21sqpzw++8cCy2f9JciOrFpQPN6VV3GPH8JWZUIAw0n
 oySVwJeggfGtpD4utzYX4sly97Noi3qt568fmhCwiz4xV4JG1iRsSut+Ry7yR1l2rUMaaFJyhJj
 87a
X-Google-Smtp-Source: AGHT+IEa7uL3rXGhMohvKtKYM6ki83XZjiFw5dWNzTyRw8qYb7dhskvpy9f9AozZMR6CTq3i+VXH3A==
X-Received: by 2002:a05:6000:2c10:b0:429:d33e:def1 with SMTP id
 ffacd0b85a97d-42cc1d0cef2mr30396979f8f.29.1764329073455; 
 Fri, 28 Nov 2025 03:24:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b0d9:d0c7:cd48:383c?
 ([2a01:e0a:3cb:7bb0:b0d9:d0c7:cd48:383c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1caa5d02sm9243083f8f.36.2025.11.28.03.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 03:24:33 -0800 (PST)
Message-ID: <beffce51-87fd-467c-b35f-1b580ecc0099@linaro.org>
Date: Fri, 28 Nov 2025 12:24:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docker: Use GitHub-mirrored TF-A repository to avoid
 clone failures
To: Peter Robinson <pbrobinson@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20251110133758.1644822-1-bmeng.cn@gmail.com>
 <CALeDE9OdRuey0yWsXU2R4cPiuG_poPCb5c8g+XnQjUBk=M9VPQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CALeDE9OdRuey0yWsXU2R4cPiuG_poPCb5c8g+XnQjUBk=M9VPQ@mail.gmail.com>
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



On 11/28/25 12:12, Peter Robinson wrote:
> On Mon, 10 Nov 2025 at 14:03, Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> GitHub Actions consistently fails to clone the upstream TF-A repo,
>> returning the error: "The requested URL returned error: 403".
>>
>> To improve compatibility in building the docker image with GitHub
>> Actions, switch to the GitHub-mirrored TF-A repository instead.
>>
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> ---
>>
>>  tools/docker/Dockerfile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>> index d2384219c06..201a1cdbac1 100644
>> --- a/tools/docker/Dockerfile
>> +++ b/tools/docker/Dockerfile
>> @@ -243,7 +243,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
>>
>>  # Build fiptool, bl1 and fip for fvp and qemu_arm64
>>  RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
>> -RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
>> +RUN git clone --depth=1 https://github.com/ARM-software/arm-trusted-firmware.git /tmp/tf-a \
> 
> If you're going to use a github mirror use the TFA one, I've seen
> issues with the way they sync to the one above in the past where
> things like tags disappear.
> 
> https://github.com/TrustedFirmware-A/trusted-firmware-a/

+1, good catch. It's then one we've been using for OP-TEE CI.

Thanks,
-- 
Jerome

> 
>>         -b v2.13.0 && \
>>         cd /tmp/tf-a/ && \
>>         make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>> --
>> 2.34.1
>>
