Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D2E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56EA583D8A;
	Mon, 29 Dec 2025 13:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ly0Cs/1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A31083DAE; Mon, 29 Dec 2025 13:27:11 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FD483B82
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 13:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 85A3A3FE51
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767011228;
 bh=IICw2dmuSCi/uhstQ5ukUP4jabl0t+F8MccniGfafsA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Ly0Cs/1etZvU6OU0pO5LjgCmtVgE0c66ghXbO/IvqRB+oXA2HF9VRmhgd048es66s
 xmEF39g0vH9EC7IO2RfcOXsYv9PbORU1dXdgnCEFrW83/YsbwpAUL49q/NcHQrBkG2
 N0Le0KYwrdjepduseO/nI3cZz6UyAPYN4e/8pMjZKUHnAxz9BknlourWkAWs5wfKZX
 7yFQrSi5YOi7WCqV8UGbVr9C5oG+uNtDvPhUV7mjjHEcIHUvUOGrJJSnFfbnXiVzTd
 B93PhZdVWL3q0m7QUQd+mxvR5Zn8JFE70UA+IJUNC1Dx/v4GPBl2kDsAJtOU5NEqjw
 022qDDQokqoCcyYc85olYCh3vq/yQe3UZxmAuUJVKo0WONhp5gZSvKw8+Cafc4SEIe
 kWhIJ53YOtfWDkA2NN7y8ZvUpkIosuAdtcKKZCLvSYvBszBZJkY+RtfsrwFtnfAZFD
 6STNJ+Qfe9Jl9rp1QZOLRVKCXJaS0SQrmGXSEnedMEdGxDCwi6NP130nO90WlsFgnz
 QRuLDEgxCPMDCyFahZiVW59mT8Sp+efnnsPrGJFfi2HEBrY0uOM5UkuMwYcbEPMwvM
 Ts9Cqazp4Q7FwJy+g/baQ9rXXoLVpAMSJRTwlbL0RpOr39DuOrA5o5UPmRs5/reh0G
 4nobfJXkLje6OwsA3e1TJQxU=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4325ddc5babso3370045f8f.0
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 04:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767011228; x=1767616028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IICw2dmuSCi/uhstQ5ukUP4jabl0t+F8MccniGfafsA=;
 b=XQ6EB7U/b0uyvYWpBdNflqgKSUYPL50vF+H8Dy26Sp6Ronle5Lp270Nf2ydGLLgLFF
 N8z4ptHzMLG85cfYKIEm9g6ieDjQ2Jv95O7X03FNmYlatl0Mj5ghUA9brSQyZeM34hlO
 3+g0ykT/RXAP5kRMve6yvKGnfuPPKQv4NxHEqaxBkzP4oGyQx9capSQYat1p47NM6ok/
 1/BJkgEnlPBNu2VqUpMalDGt90l70SZ+XllWoCjvARRAua/7cQmgg2Oa2jR7v2ApQyN3
 10y2deQQgpijge+ODaCK/xBG2J3enCMHygNNEbBZnD3M6dfmWLpPxgrPVD9BkSnukRIY
 JcEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU47t3UfY5XSmeInXEbKxK02vpEg1Vkti40SYOL5HOG+N8+YSyiY8IlVJ3Hf2js7Bqc4M4raVs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1wMLXlnl9YM1/bp/FyCmoNleMnivYSGbb/wz5mtgPkd5MDgx4
 7O5O5FvVpYUOF5t3XUJ36rf6dK/Y0u7f9NI8MgPlYbu+6GDFAlKxieWUrnSJB8AGlMBnMerCWqB
 4pU0CysSG6/3Q/jWAktQoyBkvZvfPHCCGH/Tfa+qqHbpksW+lFCseqEqCVO29H9UAWai4xQA=
X-Gm-Gg: AY/fxX6/EmQFcunrGEMPMAiD3kcyiJKA7o2NrQ6gQ/EcU2UPH0OZmLiR4d9rH+lf1N7
 NtWTtF47+QbvXPMyVLuVniLMjW02DJqP34PGnlJRcjCSRna4ZHBN4RgikVp50W/U03qtsgvjGGa
 x99eHUwojRXeEGhFoknbDYP4Jt1pVtyRAvFxU/Wr5V/E/b5gNARCPn/SwfO3DQJnO9JXe1k1NGV
 YTseGm9zNWVuIS5ClTsMUN/IlsQIl59BSfAxwPtkk86NSsVipPrdqNHLc4kunfB8noi68ErHjBS
 6Ptn9J5ZZM52x0LmoQS2Yws7lWO6NN1C8vSGR1xjBDmDdQ+yonoXazY32sdvbfZtrA6LNg/WO3v
 XYqrEkYJqKR6FL3OuHe1bWem3l4VlKVUUnYrqeH03PsPUGMguv8s2GSDvFqfofJqxwoQiToF7fe
 A9+cRUu/Y=
X-Received: by 2002:a5d:54d2:0:b0:432:5c34:fb22 with SMTP id
 ffacd0b85a97d-4325c34fe1emr31829382f8f.22.1767011227987; 
 Mon, 29 Dec 2025 04:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZRXyDQzjLGu5M9rIgGi2W9yoeUe3mUpfGZ8NsirdFYvTVo062c1Fh5AQIH7NTYzkgVuNyjw==
X-Received: by 2002:a5d:54d2:0:b0:432:5c34:fb22 with SMTP id
 ffacd0b85a97d-4325c34fe1emr31829355f8f.22.1767011227593; 
 Mon, 29 Dec 2025 04:27:07 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm62868974f8f.30.2025.12.29.04.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 04:27:06 -0800 (PST)
Message-ID: <fc5976c3-0cb1-488c-ad66-1adc5510ea00@canonical.com>
Date: Mon, 29 Dec 2025 13:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] trace: correct handling of recursive call
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond
 <seanedmond@microsoft.com>, Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-2-heinrich.schuchardt@canonical.com>
 <CAFLszTgiG=NyaVrGAnTJsmkpYc4OOaUo5ebKy=mTrw4Nwc46jw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgiG=NyaVrGAnTJsmkpYc4OOaUo5ebKy=mTrw4Nwc46jw@mail.gmail.com>
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

On 12/27/25 14:45, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> __cyg_profile_func_enter() adds timer information to function traces.
>>
>> Commit 852d4dbd70ba ("trace: Detect an infinite loop") introduced a logic
>> letting any recursive call to __cyg_profile_func_enter() deactivate
>> tracing.
>>
>> This implies that a lot of the DM core and timer drivers functions need to
>> be marked as `notrace`. This in not desirable as those functions are part
>> of what we want to trace when not invoked by __cyg_profile_func_enter().
>>
>> A better approach than switching of tracing is to immediately leave
>> __cyg_profile_func_enter() when reentered.
>>
>> Reported-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/trace.c | 59 ++++++++++++++++++++++++-----------------------------
>>   1 file changed, 27 insertions(+), 32 deletions(-)
>>
> 
> Please see here:
> 
> https://docs.u-boot.org/en/latest/develop/trace.html#board-requirements
> 
> This really just papers over the problem you are having. You cannot
> use driver model to obtain the timer as tracing starts before that.
> 
> So please instead do the small extra work of defining timer_get_us()
> for your board.

Hello Simon,

Thank you for reviewing the series.

Making timer_get_us() driver model independent could alleviate the 
issues that I tried to address with patch 2/8 (trace: initr_trace must 
succeed initr_dm). Yet, the current patch is about handling recursive calls.

I think we should use notrace only on the minimum set of functions that 
are used by tracing only. All functions that may also be used from 
outside of the tracing framework should be instrumented.

This patch addresses how to avoid recursion when instrumented functions 
are called by the instrumentation entry and exit functions. This should 
be handled gracefully instead marking it as a total failure and 
disabling the tracing framework.

Best regards

Heinrich
