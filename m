Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A931CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71D188250;
	Thu, 11 Apr 2024 14:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bj272iij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2539388270; Thu, 11 Apr 2024 14:40:46 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C52880A6
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a520410b7c0so268602166b.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839243; x=1713444043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hEejlosWP6Iw/WAmIQqvmtVzPA9kr0Is4KlY4kBJR8w=;
 b=bj272iijej51+OeysaOeBxsGzUemzfsA/23u/Z/cH7VLiCNmvPVo1cUynAxM+sxFF8
 Qom9umR7MuZrshIjTV9vpKTEcEvAmah5BxP5OmfQ+7c+v3//9On6dv+UGOSn9GeBNxdU
 SNo2A21I37LxViANMqFmTbwT17lQMRHxZhOH+ODxyItC0aMORT+thSE5ZeorQvmlZCjZ
 ViKEIvdFLiGfUpylvQWoZupiQV0uSuo+id9HbyX/Wo0vFjLa0KpcEdi7LvfX4hXlyr2u
 ESE6TAbtrgvBGe5xVob1UTQ8ajppAsFXxb5Yx5Ukr/j0wnMcNy2UJsFdUEvl8z92Lmx8
 S5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839243; x=1713444043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hEejlosWP6Iw/WAmIQqvmtVzPA9kr0Is4KlY4kBJR8w=;
 b=roa+13xPaF1JHdkdSmiXfXL+kCJEfVYbLs/H07PnChjXq1tDg8OnO1MBdAgyjXPV0C
 f9QxUAAN6bhCKEvA2qplJsaBLNkls3xh2/t43KhMWoE6D2SqYMmjOKwrh2buUhQgX0gI
 JDDJ+7Evp9cTjUk2pdxYxdd5dGoIRP9NoQhnmNle374wITHkBlIQWS1SeDPf+EeafoES
 kjJzDGnC7DF6iySxElHjyPZU1fk739AQ1i2lvvkwNBoMlgyF3VU4vajGHbaS0UjnKuev
 y62DPZ6BWYgucNdvYw21edevs0qfYMJULFZ4RboO1wioxAv5ClxjRwYjqS8ZG28HiR3v
 35ZA==
X-Gm-Message-State: AOJu0Yz1z1b/7VSV4mhejcKO/IlT6MQT/ogrUcB56zhvmCGZHuV+Foiw
 vEmEU3yPQ4j90JaS9/6Aqv7/GNY8U8CswmIGmfH++hzekXPW+e25ki0E+C+5IAs=
X-Google-Smtp-Source: AGHT+IHRd/yzK5rg0JDk0j8GLk/2qq1E0xBGJ5fVBFqvYvSW62btLtNVYGmDpvnP2OqfVFSP6kH7gA==
X-Received: by 2002:a17:907:7ea0:b0:a51:b008:dc62 with SMTP id
 qb32-20020a1709077ea000b00a51b008dc62mr4044930ejc.59.1712839243201; 
 Thu, 11 Apr 2024 05:40:43 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::570d? ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 h24-20020a17090634d800b00a51b3d4bb39sm718741ejb.59.2024.04.11.05.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 05:40:42 -0700 (PDT)
Message-ID: <faf4805b-b9cd-465e-bbef-e6e7a2f0b691@linaro.org>
Date: Thu, 11 Apr 2024 14:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] smpi: msm: fix version 5 and add version 7 support
To: Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
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



On 05/04/2024 10:21, Neil Armstrong wrote:
> First, fix version 5 support by using the right ch_offset in
> then msm_spmi_write() reg accesses.
> 
> Then:
> - properly format command by importing helpers from Linux driver and
>    use a switch/case to handle all versions in msm_spmi_write/read() command.
> - handle peripheral ownership by poking into the cnfg registers and
>    mark periperal as read-only when the owner id doesn't match
> - finally add version 7 defines
> 
> SPMI Arbiter Version 7 is present on SM8450, SM8550 and SM8650 SoC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Caleb Connolly <caleb.connolly@linaro.org>

Mateusz: do you prefer to take these? I'm just as happy to take then 
through the qcom tree.

Kind regards,
> ---
> Neil Armstrong (4):
>        spmi: msm: fix version 5 support
>        spmi: msm: properly format command
>        spmi: msm: handle peripheral ownership
>        spmi: msm: support controller version 7
> 
>   drivers/spmi/spmi-msm.c | 148 +++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 116 insertions(+), 32 deletions(-)
> ---
> base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
> change-id: 20240404-topic-sm8x50-spmi-fixes-aec9b392813b
> 
> Best regards,

-- 
// Caleb (they/them)
