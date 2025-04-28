Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91574C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C058E828D0;
	Mon, 28 Apr 2025 19:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GqIukcyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C529182AEF; Mon, 28 Apr 2025 16:25:59 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA5982A53
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4923563f8f.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745850356; x=1746455156; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5bC49Uy+pbrR8v8+eJkLWA/jDY6zHuCkew8rFGykOJ0=;
 b=GqIukcyN3HDvwt5jaVRv5Zsx+YG7W0PQ8AlR89eQQXJDWj7dOT1OCmPk84Ys7u/a6c
 BSfIJlcRj6nVvWdYCzi7gTjC8S1OgOANcjvBZvxUvkbnJ7Fqh0oKUo+2LUb93Kv5MUW4
 CK03sderxkrV8ujmlyM7p4ERFk2bCmLphJ4skDTvrPsHreTRiwmXImv5sbEhJA++F78Y
 P38PEpRgDXpB6jsvveo4cPakrd8VDhwq8ii8rAvresJisSno39J1twnrIid36tDbfvnp
 O1+NfAPmrIQnw6xYUoAFWorFIuMelwpUTTdXxlTnFht/bZxMXZeipYB+wE6DRMeufIvu
 FWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745850356; x=1746455156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5bC49Uy+pbrR8v8+eJkLWA/jDY6zHuCkew8rFGykOJ0=;
 b=YrQN6XbN4s45j5XHwc1q7roJGlhSGuB98keE3tPR1sa6BdncVFUW3MerrPc1aHF/yq
 EhP1xqWHvsgfYRxuXbr/KZBA1l/h8tnUvJ/gpxM2l7N2y0vj7mweTK2N0wOE1BGIikxe
 iZCqNO8Au9pZrdc7eGant8Jps4pFQ0UwYcZwjNVkQOdOKhqJNih2IOzBJdrrNhglpft2
 nar5yY1ZupqHRO7J+u6fwrq4s5gTP7kTzNITZtXp7/NX4FzhIgIGIcb+TxNjiKg/mjcT
 biHtEBWllHMv0e/jG9KevM9aS3iKS2J9j02NzUnuW1KHqSjZTrgCnIAWXv15O4R0teqF
 lbsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCVY1ZlVC7HJnv2bjRxo3iEV1sdNDw6N+cdmmatTtKK3+kETa+B/MjV3K96DLCtYKmOvBWuLY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqn+GsM3uGjHYE8oWQTvAf2eskDZDTVXtx2qUi4KN/pX046EnV
 jegLykcFS6OheTn8Dy6l2KuTiiinnOe4ldgSGSS7TJZCS+os/rYXsRtlX8Vsi5g=
X-Gm-Gg: ASbGncs3o3Q7VDPxKz52gaDYFRHfkvDSy0/b24wYx3ocF4OMGmwypVQQwa8jJu4c1Ik
 kRtyOCqXpjsZAl1AucegbYqtJsAuNI/1L+cePPb9J358ncJEJB31xkB6cwPzUZDJHua+TIufWkj
 zCHtJSUzLwNfO33FgqFZ7qWAMiFefSBKGHmbdBLK1uJfzikjpck3UuRJynoXKEL3rmJ+MpGUESa
 xRWckdApPcaKPsPDT2wfBzB94o8gHOxbSklnkFpVme8fs1O5b2n9FTa35SzNPOqiMiDmAdlVSjl
 xT3WHhlP1NcGJ81ILxr2E3WONCuk+HOiwwyB44y1f0hTtCZ/Qh19aNy8bsLY4XlUL2entZ8=
X-Google-Smtp-Source: AGHT+IFp2QeUtv8Gv/kNRWHIjkZUAHqmm0d4+gPcR7AocNOARsuS0UQTB1rIkV5jCcBwU5XrGTsNXw==
X-Received: by 2002:a05:6000:1ac9:b0:39e:e438:8e32 with SMTP id
 ffacd0b85a97d-3a07ab8a919mr7696116f8f.55.1745850356216; 
 Mon, 28 Apr 2025 07:25:56 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e01bdsm161222955e9.38.2025.04.28.07.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 07:25:55 -0700 (PDT)
Message-ID: <67a3d89c-1404-4ffb-bf7a-39ba725023b3@linaro.org>
Date: Mon, 28 Apr 2025 16:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] board: dragonboard410c: More fixes for U-Boot v2025.07
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:31 +0200
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



On 4/17/25 15:49, Stephan Gerhold wrote:
> Fix some more issues in the U-Boot configuration for the DragonBoard 410c
> that I noticed when testing the current master branch after the recent
> changes were merged. Ideally these should go as fixes into v2025.07.

Thanks, I'll pick these up and send a fixup PR, also hoping to get a few 
more things in.>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
> Stephan Gerhold (3):
>        board: dragonboard410c: Fix button cmd name
>        board: dragonboard410c: Drop custom reduced malloc size
>        board: dragonboard410c: Enable support for KASLR in Linux
> 
>   board/qualcomm/dragonboard410c/dragonboard410c.env | 2 +-
>   configs/dragonboard410c_defconfig                  | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> ---
> base-commit: 5b4ae0f3f040908602c80908c3023b5454883d4a
> change-id: 20250416-db410c-fixes2-7db207c10724
> 
> Best regards,
-- 
Casey (she/they)

