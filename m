Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238C7C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 15:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9113881AC;
	Mon, 20 May 2024 17:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ppWbn7cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841C487E49; Mon, 20 May 2024 17:06:38 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50805886BF
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 17:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-574f7c0bab4so9497013a12.0
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716217596; x=1716822396; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=boxKd+ymYwOCX3OrGYRnAwwxugaXlqCNRMJR5hPkYFA=;
 b=ppWbn7cVSUdJlaWQJqaSMrZ6DsQmM2mnielz+nwLA2dG7dcFViT2esrIDmNS4ZzMpk
 uSJU9F4Dq65LK6BsQfJQ+iSmu1Yjh6xUPkp9D8s1WzROIE92K22lsUFeh3vWWZavyjKf
 8ScwjR+1cO+r/2mfxvLbNHYOAZk7RUEMg+ANufJeozPgTTWL0olKh672robHLwM4jzC8
 E/s13O58GlQW5mZaM9xnvzHx3nXW47FUJr6hSPaRSbE3IIAIthJgD+vctfJygB4V2zIN
 tNdsbH/zYRWApEtus4wc72XmpqqSkU1LyIAGX6szqXckOkZ/fmGoe7kLmMDpHImzTMXU
 CzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716217596; x=1716822396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=boxKd+ymYwOCX3OrGYRnAwwxugaXlqCNRMJR5hPkYFA=;
 b=mJSGPrZx7nAh/agV2KMUkaCZ8FxF5cgKj2VNCo8EDQX9+dGohHCxKODHlZ6K/tI3LN
 b1pJyq10zsJ3kQR01BmpQKiD9tPDzbS7BBt16pxdKWXwSnQxnslaAaRZgf5fYiZ5u7zt
 0ucS4GTIwUZ2NsVGVRKFnsZzaPRimrHEHB3brlPrgPwlWKnbSGhRuzX8P1uwDDCykbFA
 5XZhJ0rmcizktXdTGrm4TgNCd6pDw5hs/Mp0hP+gxAZANXxM4mquwKVv+XQBXcMvqeZk
 TaGBINBZCa/uFwM5i51lTpHM+//nEevx12tEVm5+Gx+iPvw6ZzLfQiGlVNzYq5D6KgTo
 EhdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs2aB3/kp41pG8cF8ORPy6mhmRZkzdxpkCpkmiRMdCQ0z2st7iGNVupJ05pvjgVhMFHfBRxdKj51hQz1tsB5Rulbym+Q==
X-Gm-Message-State: AOJu0YxxSLdX87uzoJvsLCnabSgrL4qFHto/O5KbrgVzcBr1IKpnf4t8
 Umat8rpOtZMyRLY93w/JfzI8HxU/tA88aHQdOXvhJpRYWclOsHmO8FyWkPGZprI=
X-Google-Smtp-Source: AGHT+IFS8K16VxIvG8H7tcU+aUSoFh3kCM1WkUUhSHqcHvfNXD8B4zeHbA4cSKOBqbdM+7x6EVBIgA==
X-Received: by 2002:a50:d61c:0:b0:575:2a03:8ff6 with SMTP id
 4fb4d7f45d1cf-5752b4c9117mr6129277a12.16.1716217595823; 
 Mon, 20 May 2024 08:06:35 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bebb56fsm15079020a12.33.2024.05.20.08.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 08:06:35 -0700 (PDT)
Message-ID: <4caa053e-0faa-428e-aea9-b2a3d03b0be7@linaro.org>
Date: Mon, 20 May 2024 17:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sysreset: add Qualcomm PSHOLD reset driver
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: j.beck@linefinity.com
References: <20240424124500.391735-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240424124500.391735-1-robert.marko@sartura.hr>
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



On 24/04/2024 14:44, Robert Marko wrote:
> Number of Qualcomm ARMv7 SoC-s did not use PSCI but rather used PSHOLD
> (Qualcomm Power Supply Hold Reset) bit to trigger reset or poweroff.

Applied, thanks!

b4 missed this one...

https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/19d175b1ff7a2e1272d4ad41415d2421fcb0adf0

// Caleb (they/them)
