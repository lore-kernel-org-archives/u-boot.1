Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF30C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 11:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBAED82B63;
	Wed, 11 Jun 2025 13:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kSYmzjlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77D582B70; Wed, 11 Jun 2025 13:58:58 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D269282B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so52917385e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749643136; x=1750247936; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vha8vSPIAswvCXbWQpvwb9SE9ImFP5FRFBr4KIYgrC0=;
 b=kSYmzjlYcuIYMXWGKx9lNqJjApyQRP+6/FiAznyKuHKCLW3LJ1npVlKm90hwXRXSE7
 UCqkl0uh5zEj88tEkf0gPdOhcMO5QWirgVKnvhqgh3BUHiKz3DTJRVv2NuuusRkh85dl
 oMHqR2fcPft0C0yXgHHBceTJjqu5STaIQdVm5V/QuA9FZsYf+peE9EH67DzzKHl8sTN0
 CNbeRRpXa7ihu/ea5rgfXdFHeuAmFZwIiJPFuR30kPbBwyZfXXj8xNAobdmZxTnx27Os
 ubp2Knr0Uki1+qdmnBgKNK8J2VR4Bmy3VK5Tz0g2CUhPmzbzgNqjw7R856MwiGHupe4l
 KUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749643136; x=1750247936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vha8vSPIAswvCXbWQpvwb9SE9ImFP5FRFBr4KIYgrC0=;
 b=wmvmJQjWGO/EAwcumuND/BnUdNu++y3zbUZlFnvonESsx/s1gl0iCwCmvtnc6sp5dn
 xldv06NiPcOytnvEJJ+Z7wOVDjI2kCeMtv2qSLPQdiKMlO6GuKPI3vKZnKO7B3DSSXVt
 nbIiul9zpjyrcCNBMA7XZyqOjrmF95uJHzyO7sis5msq4KyoPs4IV/lvAbBfFmAzCX3p
 9nFDtNj9pQZqifX9/DUbvoCEy4wog3/y65dIUN02rPZO9kncwjNxMqwgaFx02OUQHY53
 wpWQqfjsmqUrNAn97ucnWa6weXWnKzFZCVXUegFNF7lCOsYJ1OiAAAbx0TeLL/wAn9vv
 3KyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWdFvuVlmjIwup8CoPYzIZ3gqBJiYzkfGnyAuLB/fgVPUaQx+VU/U9sunCKRcbLrXCwJ3+mf4=@lists.denx.de
X-Gm-Message-State: AOJu0YyKfUlg9pi4foTT5OdfFz/tI0z4ZpXxPfS05UfdkI06SuoXciJi
 mLDbiVLYaMtKnOXGWraYBddHey5JEAMysTkcRmO+vlrJmD7GUKUuwd20IQKjCXU5Fwg=
X-Gm-Gg: ASbGnctwu31SJ/qQMZ6mzjSoU+K3t/wMuGeZs8B3nkZcL/rdWoCD7Rd/EipH0Y8oxIu
 4sxrDgchNBQZ3Id8Q0wlTKwG2iigaMYIYjEpsXUyDpOHMjqSni46b1SGl6aiHVt6c96+R0nGrvr
 O6+v2vCy2dLwHrMEIXpElyuVS5OI3yLxC7isT5GtWgzCJK8k3Vx4j3S3BU5rXkwvGODmyY5VZgc
 W/R4bpm/pkIh9DCqurpn7kaCSHevBPhEB0ItT2k9jC1bU5qBX+zpLmeLLBy2VOKdxa3KIN4i3Os
 xbpssCVftQnB+X6f0ups2GnoQcOu0PZQ9n6BrzuLW321qhYoSZ7tYZOlTQ4ZpnL7ulTug8dW3Cu
 2pgM3RR/rs1ZXCCgE+XpWDnmwCmbYbOwU8q/TOw==
X-Google-Smtp-Source: AGHT+IG2GxXJIS7ix/XMrla2ByZ8QXdNVtsvFy3eRQr62l58Y7Zgw9Pd8fGIIdoQcmVX+5XcXLyLJA==
X-Received: by 2002:a05:600c:4e4a:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-453248a0a8emr24929565e9.5.1749643136279; 
 Wed, 11 Jun 2025 04:58:56 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1a1e:c277:1c68:9459?
 ([2a01:170:117e:fc:1a1e:c277:1c68:9459])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45325216534sm18505855e9.30.2025.06.11.04.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 04:58:55 -0700 (PDT)
Message-ID: <ada6508c-4148-4afa-879a-7fb1b3ee947e@linaro.org>
Date: Wed, 11 Jun 2025 13:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Update Qualcomm generic boards doc page
To: Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
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

Hi Luca,

On 6/11/25 13:51, Luca Weiss wrote:
> Modify some text which fixes up incomplete instructions, and add an
> example for packaging up u-boot for newer SoCs, with boot.img header v2.

Thanks! It's great to have someone new run through the instructions and 
find all the broken stuff heh.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (3):
>        doc: board/qualcomm: Fix commands for compilation missing CROSS_COMPILE
>        doc: board/qualcomm: Replace buildman build instructions
>        doc: board/qualcomm: Add example for boot image version 2
> 
>   doc/board/qualcomm/board.rst | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> ---
> base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
> change-id: 20250611-qualcomm-doc-update-42f39f3a600c
> 
> Best regards,
-- 
Casey (she/they)

