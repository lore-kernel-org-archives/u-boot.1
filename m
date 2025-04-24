Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41DAC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417CD809D4;
	Thu, 24 Apr 2025 14:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IisNCIIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F1880F9C; Thu, 24 Apr 2025 14:19:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA3280194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so6245475e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745497148; x=1746101948; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v22zDW2OgpQQ+4yWbgh3aX07aGYI2UZq24l+DYa5DAk=;
 b=IisNCIIWPn1MFk9Wvy130BRotULFGjSDGgyxAi8/o53Rf1V7HAUniBmE0Tgm3MbfOB
 ynBrliOptEJQdstSsQ3rLi9XzOsgo+566HYzbpQCrA1N/U9XAbs5iQFsYFZmc4y9h2j6
 hOlICjQJiYQQK/Ox/It6+Ud/9FtWSAxcFDYDqysXHvUiceXqr9nH/I+Q0P4ze+IU/L+Y
 Ac4cZ5vZSbxZap/4dHYZwcMXuSaJR+SUvYXFPMsw2Y6GnT4XfV1gVCjgLoFHUcZG7Rz9
 Ncb/DFb57w5bbIgEnVAQRh4YpuWsOoZgZQi2SfwalGc/WcI8u3t4ggPx9yn12i1VAeAQ
 mfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745497148; x=1746101948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v22zDW2OgpQQ+4yWbgh3aX07aGYI2UZq24l+DYa5DAk=;
 b=nmgOFvozTdYyQEHENfKCrnbLKGMTbvq+VibjWzdkDBGSRRpltJ/olf1UY+hY0DPJdM
 F9wzgP1s7DiRFQviazpAnF2y37njv+0NFxm0O3jSVbyEV75TsjNMP/2gHOBPLJ44GORO
 HYXNEFhPB8X0nDFldARYqKukUaa18EODn0TOORU1E/ZHQ7c/zT9SLWMsfUbLnNuKm7hn
 w7BR6SXYCEq9WK76KXRJspEoax1sGELcRvZS/d5uhbXwkb9XCUfzaxfh0+KfN60RYKkh
 JBofv+azspoR46H3aIoL4lYX/ijNS88t7ekTSJHKBMFPTskbK5c9iUQNLrRAEFKpcbkI
 +pZQ==
X-Gm-Message-State: AOJu0YzA6+5KFWwnj4LCE2BYTNVkeSUtrOaYGDWj3tuuJM3dE9qVnq60
 7uMq8lQqA64/m3bS3nan7bAFGSWPKKAGSQC0Iqw81btE3RmGIpYcPS6slxeAvB4=
X-Gm-Gg: ASbGncvrosXr3KVJKzn/Lf8Odb/GfEbDDAgQ0FkcT3UvNlbGROjlecTLAF+fHhqh/aO
 FmoB/q43+D+/H5zL8Czbx0x6SgWIMYYNYGPybdk43c1Dou/E4/jTq6WXU8pDUGB5dTsMkfCJgiC
 C67a004NTBD44d8hyxT+LJ045rs8sYi8hEyUfAKJmacF/kkbnLCoT4iOV4Y/WYqqXlJL2zMOaC+
 IT/DwGOc4RuTSG1MfrkQ9/7VNv1241QeykAExCu7q8gaEFk5gUaCR50MDqLRsqb9SGf4awzCM7X
 kS5tlJF7QM/MOca/lfFfNEjPN7I2+jydYMHYY/Bx/GuVFn9a77o3C/dyhOrcm/fn/Qa8NBtKLwB
 wjz9uAhXWo0Hj0Gnt8w==
X-Google-Smtp-Source: AGHT+IFadImXcRzyCtM3or3nBHRftBPvWel2a4UkIdwl1YVF8Pg4MlvEcAzlfJdkBrf1YrnjQR0JmA==
X-Received: by 2002:a05:600c:4fcc:b0:43d:7588:6687 with SMTP id
 5b1f17b1804b1-4409bd22e82mr20853415e9.12.1745497148271; 
 Thu, 24 Apr 2025 05:19:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1455:2ba2:63a:a22b?
 ([2a01:e0a:3cb:7bb0:1455:2ba2:63a:a22b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29bf7csm20977205e9.4.2025.04.24.05.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 05:19:07 -0700 (PDT)
Message-ID: <31982429-d675-4696-991c-a14600723d65@linaro.org>
Date: Thu, 24 Apr 2025 14:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] NET_LWIP LMB fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
 <CADg8p95zBr0H-gj1XQL+Wm6G=65Ts0sZVWdq1MrTo0wJTA=vSw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CADg8p95zBr0H-gj1XQL+Wm6G=65Ts0sZVWdq1MrTo0wJTA=vSw@mail.gmail.com>
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



On 4/24/25 14:00, Sughosh Ganu wrote:
> On Thu, 17 Apr 2025 at 18:57, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Two small patches fixing issues with tftp and wget when the network
>> stack is NET_LWIP and LMB is enabled. Plus one prerequisite patch
>> fixing a problem with wget that does printf()/puts()/putc() when
>> called from EFI which is not allowed (messes with the console output)
>> and a small refactoring in net/lwip/wget.c.
>>
>> Changes in v5:
>> - See changelog in the individual patches
>>
>> Jerome Forissier (4):
>>   net-lwip: change static function wget_loop() to be wget_do_request()
>>   net, net-lwip: wget: suppress console output when called by EFI
>>   net-lwip: wget: add LMB and buffer checks
>>   net-lwip: tftp: add LMB and buffer checks
>>
>>  doc/usage/cmd/wget.rst                        |   2 +-
>>  include/net-common.h                          |   2 +
>>  lib/efi_loader/efi_net.c                      |   2 +-
>>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |   8 +-
>>  net/lwip/tftp.c                               |  56 +++++++--
>>  net/lwip/wget.c                               | 117 +++++++++++++-----
>>  net/wget.c                                    |  23 +++-
>>  7 files changed, 159 insertions(+), 51 deletions(-)
>>
> 
> Tested that the LMB checks are performed and wget/tftp commands do not
> overwrite on an existing LMB reservation.
> 
> Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Thanks Sughosh! Would you mind giving your Tested-by: by replying to [1]
and [2] so that the tags are picked up automatically by patchwork? As I may not
send another version if there are no more comments.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250417132718.2023555-4-jerome.forissier@linaro.org/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20250417132718.2023555-5-jerome.forissier@linaro.org/

Thanks,
-- 
Jerome

> 
> -sughosh
> 
>> --
>> 2.43.0
>>
