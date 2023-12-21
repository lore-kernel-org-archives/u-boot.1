Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE64C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197FA8786E;
	Thu, 21 Dec 2023 16:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o1wIfSck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 730B787874; Thu, 21 Dec 2023 16:05:28 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919DB876F3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so9305355e9.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703171126; x=1703775926; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Re6CMJGShaUGXSqlvDKO0NordjN8aj1R1YNviJZfjSA=;
 b=o1wIfSckmT02/X7EnJ4xemTbMn8cDiJtAS3de5ucRsW2kmBKcf/Y61FZ9bxr1HKmb1
 b0ABXr1XoAeNeBEVLbUa4BrrKhx1pA01PqmJ81E2hyO9aTVcuvaGApMSgZXJegBCSj3V
 Ne/qlCrLUyDEn0Id7wxMvjn50KSYUuw+jF1C7a1/as0u4kmmB/gdDUqxv9UdafUK5lpI
 Z7PifIfI9o6HJLEO647ENMr1oXUwaykBdXcFE2/RazUST6JVlkzvyxOs9fDY5vBXOrMV
 715/1J+XSSp77+4TUPBeVY8q/xO+7aU+QNW5F1auLiMBNhBiaijlz+jE4Nsl8z1qDOXZ
 /sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171126; x=1703775926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Re6CMJGShaUGXSqlvDKO0NordjN8aj1R1YNviJZfjSA=;
 b=FPHPHWkSAcU7gvwo3psTuYf5I6chp+54TQXMh0DNFxrOHCivJTX0CMZBIXDJY/ar7b
 n39agBG4M7BOyq1Ss6zjLp36o7xy6RPH+h0eZf20moB5RLXSwACdfavypC4l1RVis7KT
 EMC56CoBFWXMvL7B9VoH5lCUwD7C7dfeT1/fvdYqb7OX2g839KvLp656dU9IyJ7dp59O
 y7QlMm21+Yk2H6ZQWkuY5UgFllvtCkN9uu/swk310f0GdF3OLKCATwbrDV2zzdMC1H0c
 RIbaQRDOonZbJlrUg1LjJr9gHc2IlvtbB+xr4Dj4YrWJ3hTO+XivEiBp4mzgOC/GF/dT
 uCBQ==
X-Gm-Message-State: AOJu0Yxc+9tjIl7v4ZNukXxTyH8OzVMH0rKAHz6WeDlXNeWu+YlQooA8
 HaZzkVSu5K7aky3HNc9+pn539g==
X-Google-Smtp-Source: AGHT+IFm6QpcCirMp86kmFEy/7RCiZzXPMkLYXBj84mRfH60zLyAquvYicMu8r1TeuRSb2foZiXVWQ==
X-Received: by 2002:a05:600c:4311:b0:40d:3dc7:2f71 with SMTP id
 p17-20020a05600c431100b0040d3dc72f71mr612587wme.34.1703171125577; 
 Thu, 21 Dec 2023 07:05:25 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a05600c4f0200b003feae747ff2sm11518854wmq.35.2023.12.21.07.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 07:05:25 -0800 (PST)
Message-ID: <ef6d33b4-3df4-4ae8-b25a-137de0118e36@linaro.org>
Date: Thu, 21 Dec 2023 15:05:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] Qualcomm generic board support
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <CAPnjgZ13umAN1E2MqMwTmG98A=o_Q5RQFOY_Q_xpgQq-gmdoNQ@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAPnjgZ13umAN1E2MqMwTmG98A=o_Q5RQFOY_Q_xpgQq-gmdoNQ@mail.gmail.com>
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



On 20/12/2023 04:46, Simon Glass wrote:
> Hi Caleb,
> 
> On Tue, 19 Dec 2023 at 09:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
> [..]
> 
>> == DT loading ==
>>
>> Previously, boards used the FDT blob embedded into U-Boot (via
>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
>> bootloader, so we can instead rely on the first-stage bootloader to
>> populate some useful FDT properties for us (notably the /memory node and
>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
>> map changes above, this let's us entirely avoid configuring the memory
>> map explicitly.
> 
> Running U-Boot as a secondary bootloader is the degenerate case. Are
> there any Qualcomm boards where U-Boot runs first? In that case,
> perhaps the DT could be used in SPL to determine the memory size as
> well?

Yes, I'm totally fine with having memory maps hardcoded in DT, this
would be my go-to approach for running U-Boot as a first-stage bootloader.

> 
> (this series is fine to me, BTW)
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
