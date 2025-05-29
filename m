Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D745BC5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 19:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 672DF82F8E;
	Thu, 29 May 2025 21:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g3HsXGTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A30018307F; Thu, 29 May 2025 21:03:46 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA3282B20
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 21:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a36e950e41so830185f8f.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748545424; x=1749150224; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OOHIEuKO0DkVynqaEAlfb5Uiz1atXroFTCjt7STNeIc=;
 b=g3HsXGTVVB4NdBaRioCyeJFPD58upmRm8zp0fkLINROxOrT0PLIUkiF9Ldn7d1UybD
 CMc18S7qfFYJtSI+StfcprCmuwIKpkCfsLRObTpYoW9G4ytS4U9XHLxbKNXk7o18A7X7
 OiB/DR1uVb/qwAIB6e97/yWSQe3VIqa6AczmueyRMU4uXaDNi/gtAeJbvAMFdYCKQaMG
 XZ6sTQ3pLxPhQO97aekvn9h7IlA4O0rkxMnMWs0Wo+3nEXd46vGh5hSLyNnYGhnC/59S
 e3teEKqHO7AS9VXOPyGYXjskxM2LVoY0LLpaBWI+IwPHNHYpjaxVJZOAJT4bI9WL0wu6
 zv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748545424; x=1749150224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OOHIEuKO0DkVynqaEAlfb5Uiz1atXroFTCjt7STNeIc=;
 b=VLIXm+TDHiW1t7KsfWSJd67lCKz+o2OH65p8+PPgeNmiG3L668/OCGrMXGSOyMQ7sJ
 w4sBJnnedVJRknTTIj74D/K5Kyiysa8wHdnUi25KFT4AFpvKoEG1XUDSQim8DX91IukU
 7whXhES5LIE1N9+FtGvz6acfAPpXgnD9+vNNB9EWTQUPpOLIHuKXJUxS6yGoy8KRqJ58
 qEAloh74gTiOLfkAkK+JIgFvMEireK0GYMszO2P765+ooaB4a7Cluo6LW9CqTyPxyrns
 dcUjMFiiBPOxbiY8ICq26oR9mF8oF4eB0dG0GrRBXNYZEsKAYovVvH9aZpeiYk0MrrCO
 paxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdEpXs3NGfAA0C61czSfwu5ZSejEIWcB8cnuZXqT0RdlmtT68UvdLuSnDilsao0IwaPFsD1OU=@lists.denx.de
X-Gm-Message-State: AOJu0YxzxQfJ9r8XfWxcWyrPybDB4DyKJaiu9mJrHMlygHju6taxCbTM
 0YVa0ed91vdhha1s9IrSpnaxy0mj5FXM6JZ8zSMzvsisxSYstJ5A3jJW7gu/aJ4/i4o=
X-Gm-Gg: ASbGncsSC29JbcnTrDZQGqiGjVcSsuih7AGaCaD0YerMbX4ogDg/YLLHl5RY6UXuEZy
 3dnuv3kYpRtmOY7+l7Pqc3y6/Eum901zvp2YbF0mGgoUqGDknoUOE5AsZQw17FbGeVKdAI3wytz
 9I+yPSaENvBQ8IODV0Z7pgWuqadtcTX7IjBLRuCQOgaLuENQgB1Cn2b5bvqPwFM5ZWrfTs30eEF
 WxVI0fwcbgimiRs18I+3aWu8FYFmYIiLNhu6ghxzkWB/fJThRRrV3yIq7V2iSL2QWj92hT2CgcU
 uWoOT/zWBSuswj2Hufv0AguFs+mUu8cgDG/WvQH8x9LOPeKACzq97wUz1Pn5/yv+E8Rwj7VhPF6
 6kTkaElv7V8X1zDUVNC7BN/Nl+xp1RV3Njb1D
X-Google-Smtp-Source: AGHT+IEzvrBUSJMUT4UIApimvjl0cY3uVzKQRdCsjSsQ/8H+rDdr2xvGNgnJS7vScycI+khe26Kcdw==
X-Received: by 2002:a05:6000:1887:b0:3a4:d53d:be20 with SMTP id
 ffacd0b85a97d-3a4f7a4c9a5mr320106f8f.18.1748545424101; 
 Thu, 29 May 2025 12:03:44 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:9bc3:77c2:6c71:775c?
 ([2a01:170:117e:fc:9bc3:77c2:6c71:775c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe74072sm2844764f8f.52.2025.05.29.12.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 12:03:42 -0700 (PDT)
Message-ID: <348f3857-f5c5-4f7b-90aa-50cd95bc35ca@linaro.org>
Date: Thu, 29 May 2025 21:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Enable env in SCSI
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, avromanov@salutedevices.com,
 michael@amarulasolutions.com, sjg@chromium.org, hs@denx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 venkatesh.abbarapu@amd.com, ansuelsmth@gmail.com,
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250513091710.3719292-1-quic_varada@quicinc.com>
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

For all except the doc: commit

Acked-by: Casey Connolly <casey.connolly@linaro.org>

On 5/13/25 11:17, Varadarajan Narayanan wrote:
> The qcs9100 based Ride platforms have UFS as their primary storage.
> Hence add support to U-Boot env framework to be able to save and
> retrieve the environment from UFS. The environment will be
> saved/retrieved from the partition specified in the config option
> CONFIG_SCSI_ENV_PART.
> 
> Also add an API to convert partition UUID string to block device
> descriptor for UFS. This API will be used to get the block device
> descriptor for the partition specified in CONFIG_SCSI_ENV_PART.
> 
> v4: Use 'if (CONFIG_IS_ENABLED(xxx))' instead of '#if CONFIG_IS_ENABLED(xxx)
>      Add documentation about the platform
> 
> v3: s/scsi_get_blk/scsi_get_blk_by_uuid
>      Fix argument name in scsi_get_blk_by_uuid
> 
> v2: Add part_get_info_by_uuid() similar to part_get_info_by_name()
>      Use SCSI instead of UFS
>      Use UUID for SCSI_ENV_PART instead of name
> 
> Varadarajan Narayanan (5):
>    disk: part: implement generic function part_get_info_by_uuid()
>    scsi: Implement get_blk() function
>    env: Add support for storing env variables in SCSI devices
>    doc: board/qualcomm: document iq9 building and flashing
>    configs: qcs9100: Enable env in SCSI
> 
>   configs/qcs9100_defconfig  |   5 +-
>   disk/part.c                |  39 +++++++++++++
>   doc/board/qualcomm/iq9.rst |  62 ++++++++++++++++++++
>   drivers/scsi/scsi-uclass.c |  30 ++++++++++
>   env/Kconfig                |  15 ++++-
>   env/Makefile               |   1 +
>   env/env.c                  |   3 +
>   env/scsi.c                 | 115 +++++++++++++++++++++++++++++++++++++
>   include/env_internal.h     |   1 +
>   include/part.h             |  20 +++++++
>   include/scsi.h             |  10 ++++
>   11 files changed, 299 insertions(+), 2 deletions(-)
>   create mode 100644 doc/board/qualcomm/iq9.rst
>   create mode 100644 env/scsi.c
> 
> 
> base-commit: 48db49b0977cc1c9c9abf82c0fb704238fcef4fd

-- 
Casey (she/they)

