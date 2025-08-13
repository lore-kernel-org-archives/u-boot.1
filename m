Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C119C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2AF82CEA;
	Wed, 13 Aug 2025 15:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FNTx5gDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE3082CEA; Wed, 13 Aug 2025 15:39:53 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E777F829F5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 15:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459ebb6bbdfso41446445e9.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755092390; x=1755697190; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SV8vMhXkdAoID+hqT8gk3Ao3ja8YF4q+hHI159zgFHs=;
 b=FNTx5gDxugEQ7aHy6q9/eWvMJlOd2lZRs5RTT4zWy+DsYYXip4EmulIgp30PAvRbaH
 GBs8Owoqk6VFOyAsq0S0reflrEjgvfZbriBW0oI+WcDPmoUvkMofOKgBDPXf+uMKQDrc
 RL9n4yGxHjn3ht6Icsb/3PL7gOCgHROFPD9XpHe0izOTXNoJzp9UGxM/5JjtjEikffla
 rJj0IOgzaF5GLhpOCws1qZrBo9tSlqWYAPjKA2uz9XCJF2Pt0z7pHolPNqZgdqbhDkZJ
 KsOy3fDNyfXbFOI7s5BXou2KR/A7atJAWbCShbdhyuAS0QyfcxPAP4qLjUrV9JnFwNuf
 IKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755092390; x=1755697190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SV8vMhXkdAoID+hqT8gk3Ao3ja8YF4q+hHI159zgFHs=;
 b=Dd8xb8RityW9Aj+JxCwFRZ9+xRlGpvcV/sYWhwpBVvHSvMfojbO1CMHq/6ZxC8F03y
 XQe+ehAFYHCI3V4hOxLq3SssvEa6HjvoxWhiPvE3qvWOO7JNyJok5FvzVxgwTCmmOb1l
 WtgA5OPNPhwok+U8hPGHAQD17OWPF9jc09x9FTe6IV69tFhkzT23qTnaRIiYggCoCEqo
 YS90p+Lz1rd00l9vANiX1/Q5zVizvt8Ym2PA1xbTcgbDZlRSuzSDNvbhuuZYfqGUfxy6
 QIwQq6Rjaam3ktn4qEIRmNo04T8HMIcktWkrjP9rhXx8tuJgdYs6Zc+M5jQNdfdpSX5P
 9m9g==
X-Gm-Message-State: AOJu0Yy1gFaE5km2Pokt+2NtKCmLyZYApgCTRYiIHQIyjzV9Dw6jwNb4
 jvC2bKroLkvd354pxyunuR52YP+8WArK0H+SoYG8EzwBavG+rvYlDWSC6NekHnlxURY=
X-Gm-Gg: ASbGncvIy9n3k/gWHS8wVpqTW8pIW4rlDG8odUaLStxtlXlBwiw60d+dnI8ijw3nLwC
 Wcxz6mAB+/KotcVNMbUMbSWlF5asdRB/T6EiB5V6XwjUo8ReTU0jTgZhi41aSdKD8E4NGN1rE9N
 qPhSndOPbNFICeTSxn+FY/FUya0inqEy2UMOOwEPYcJywdpUEzrQQqRD8SKwWdSmv3oPXqC+IxO
 rCOaWXPYe9c2PbQc0T5C4xFZlFznlyx2+pDWGqm/Ix8y58VXOF0NWXsNxoiqv7ltkLnpcqL5qqE
 STvjYTVZv2cRYyppS2reS0+O4aiOmbERLQVTHluHJLen0NSAgN6iAy823HcX+sK9RIIQt393UDM
 +oWg5iNZ7+xwjStn+ccjsLTHpoKqtglJg7Ol2g1cCioITr9UjOaneHUK28vRWe78W
X-Google-Smtp-Source: AGHT+IGYUknytZ3neh/iy0jSNnvtbVrW2lPOA9NISpilhuXTwAhiER0paPoxR5XJeTc8xNr4Z4nSCA==
X-Received: by 2002:a05:600c:1390:b0:459:dfa8:b854 with SMTP id
 5b1f17b1804b1-45a1659ffe6mr29584735e9.5.1755092390141; 
 Wed, 13 Aug 2025 06:39:50 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a536d27sm3016475e9.19.2025.08.13.06.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 06:39:49 -0700 (PDT)
Message-ID: <764f11e1-c269-4ad1-8d5e-6054de6eec4a@linaro.org>
Date: Wed, 13 Aug 2025 15:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] A series of patch for enable sc7180 android boot
Content-Language: en-US
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Vitalii Skorkin <nikroks@mainlining.org>
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
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

Hi George,

Sorry for not getting around to this sooner, I got it mixed up with your
other patch series!

I think this is ready to go but there's a few checkpatch errors, can you
run "b4 prep --check", fix the issues and then resend this and I'll pick
it up for next.

Thanks and regards,

On 30/06/2025 09:56, George Chan via B4 Relay wrote:
> Since attempt[1] to embed android specific boot param into fdt bootargs,
> a new idea is formed as to make use of env file to contain default param
> value. Current code logic is already working fine, unless the priority
> of param at begining is higher than at tail. From env file, bootargs is
> treated important, and prepend at begining. So there is a need to
> reverse the logic, and make sure default bootargs value at the end, and
> let androidboot img bootargs value sit at begining.
> 
> So a new kconfig item is introduced. Once enabled, the bootargs strcat
> param will get reversed.
> 
> A similar logic is needed for fastboot->bootm glue function, so split 
> function of patch #1 into 2 functions as #2, fixed some issues #3, and 
> apply #4 with same trick to glue function too.
> 
> Some one-liners patch is included to enable device driver for sc7180
> soc. It is about iommu for usb, usb gadget vendor/product id.
> 
> Reduce dependency on abootimg when androidboot v3 or greater is not
> needed. Since Tom suggested to reduce __maybe_unused directive and 
> use IS_ENABLE() instead; two __weak func proto need to add into image.h
> 
> [1]https://lists.denx.de/pipermail/u-boot/2025-May/588828.html
> [2]https://lists.denx.de/pipermail/u-boot/2025-May/589926.html
> 
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
> Changes in v4:
> - Drop patch #3.
> - Refine #2 to remove intermediate variables and code style.
> - Link to v3: https://lore.kernel.org/r/20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com
> 
> Changes in v3:
> - Collect acks-by and review-by.
> - Split function and replace old #2 into #2-#4, code reuse in #4
> - Modify changelog and Kconfig description of #1, suggested by Mattijs
> - Slightly modify #5, add back line break.
> - Rebase to latest next
> - Link to v2: https://lore.kernel.org/r/20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com
> 
> Changes in v2:
> - Add new patch #2 that is same trick as #1 to fastboot->bootm glue layer.
> - Remove default n to patch #1, suggested by Tom.
> - Use IS_ENABLE() instead, suggested by Tom.
> - Collect review-by from Casey and Neil.
> - Rebase to u-boot/next branch.
> - CCing myself too.
> - Link to v1: https://lore.kernel.org/r/20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com
> 
> ---
> George Chan (6):
>       image-android: Prepend/postpend default bootargs value with given bootcmd
>       boot/image-android.c: Split android_image_get_kernel into two functions
>       bootm: Append bootargs value when bootmeth_android provide cmdline
>       boot: bootmeth_android: Conditionally dependent on abootimg
>       iommu: qcom-smmu: Introduce sc7180 compatible string
>       usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM
> 
>  boot/Kconfig                  |  9 ++++
>  boot/bootm.c                  |  2 +-
>  boot/bootmeth_android.c       |  2 +-
>  boot/image-android.c          | 97 ++++++++++++++++++++++++++++---------------
>  drivers/iommu/qcom-hyp-smmu.c |  1 +
>  drivers/usb/gadget/Kconfig    |  2 +
>  include/image.h               | 14 +++++++
>  7 files changed, 92 insertions(+), 35 deletions(-)
> ---
> base-commit: 490ae8ceae2d5999c9de863e014e463f5c1495a6
> change-id: 20250520-sc7180-android-boot-a845ecf48a48
> 
> Best regards,

-- 
// Casey (she/her)

