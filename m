Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFD2C4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539D487239;
	Thu,  1 Feb 2024 15:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bDpD+1pX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7D4871C0; Thu,  1 Feb 2024 15:38:23 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0317287CD8
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d0512f6e32so13064731fa.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706798300; x=1707403100; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YYAGWTMtkFmlyfBYPqJoOa8EhPVO27psJjcSibL53FQ=;
 b=bDpD+1pXMq8RTAKMzzUtjcHlHE1qyD40uDypbMoPS+BTu7uTGC1R/8m4s2AqK0ubFg
 IRKnatpQQqrKLHPODfcYar946Rxs32myxkqZiPLdv83+HJj/a9FAbvPdDPwhJJpgdVhO
 Boq6rDbXk47xfoerJ5D7x1Ca0x7uJ9vfTd2ls+kdPNXO1AkoaZ/Zk2pZDv03ceUvJYri
 Kk3dPYBT2kiyGlQxBct/4hC3ps98Q/9rRk6GMlzqNc5O4BAgfD4gyJIYrnGuZXSZPu2N
 qUcc7yrmcbUmg9IQDUd1Fhpn6gEH7cq3ZiEelUyBojGImdUjhN6xTuKu5X0BuuaJxZjk
 jdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706798300; x=1707403100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYAGWTMtkFmlyfBYPqJoOa8EhPVO27psJjcSibL53FQ=;
 b=RoxQXBgiojLhUMFkg/AjPb5uiZooMANBGk4JuY2EyMysrPL0Q814xlVsIU3uSRNxbH
 /1AclARRdrLgu54py8YARqTY1nOyND+k5UNrUzQcpKnHooyx0U7T3X7jix2EvQnyLHxA
 KHGkCOhw6TarCt7WzXeVg2hWJLsPD+x1tpE5lmRyVyrWidxft5q/sVXIBwyBwLxGvWHb
 T2CwiCmg2VwFWZMqlgg2+aUdsC6Qj4Fh1P4NuszKWZ8ezPnX8L4PGfC13h28F+VXZK0A
 5RXHDC1OxVoUxVHMDlLZasAmh6PQ1F2hNM/Qh51c/K4S+SHmRUppscS2ymlFcmOXtE5V
 hqxQ==
X-Gm-Message-State: AOJu0Yz7es+g4tIUnqOUoSDMcowzlFn0/xqg8gf7PLX9H1rLv0xf5BPV
 sgluavqlqgV9R0ZgseSDTJtyJNviwRLG5l9wfEPa4JfvxsmN1oFhRWPvISp6y1g=
X-Google-Smtp-Source: AGHT+IEVUqzid8lx9fKjj8i9UZoUMwx0y3zQTQjl7CbVrto5aIRsWuqp+VBRIrzLiWnkLWE8txz2KQ==
X-Received: by 2002:a2e:a589:0:b0:2d0:5f90:2b29 with SMTP id
 m9-20020a2ea589000000b002d05f902b29mr2026490ljp.12.1706798300120; 
 Thu, 01 Feb 2024 06:38:20 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUqrmiZ2NnBUfpfLT7u3zsSV4g3zjGiyqETX87EwAlJHG/2unZHPH8iMjG17dJ3TiqCwx0T0FGiTcZPLmZw2e9Tz6KFsNLq/kRLWoUvdIS7Y31Cl9lAYC90xaMo9ikVMWGNETIPcxwu24BkNWvyaSwa/GP6FNndW+QbU6CReXVPhFjZoxF2pnv+d+hBelJiXAE02q8qc7V7nopwuuLjPpCoQb2WktuY1ppCKhLLRzw51OHCjpBNtMvJzpZE3SJKZKzmxzXkgB5OjTSwZ3IbtLlpnJHO3ybXjOX1WJSafO9/pLG1xe19bGEgk6HJ9lUGViDYSZ1nRAbB6C/HUdtYuMyXoyI/7N22kAYoYalEUdpKfnHjBAM3EZ62RU/C+3lmnpVK
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adffc8f000000b0033affaade9csm5171714wrr.68.2024.02.01.06.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 06:38:19 -0800 (PST)
Message-ID: <f8be48a7-d593-4397-a153-3dac5ab0205f@linaro.org>
Date: Thu, 1 Feb 2024 14:38:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/36] mach-snapdragon: generalise board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-17-e523cbf9e556@linaro.org>
 <CAFA6WYM=9FrvX+hrkQEPnw0o1S3wEODozJtF3o4tyg6wzBpz0g@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYM=9FrvX+hrkQEPnw0o1S3wEODozJtF3o4tyg6wzBpz0g@mail.gmail.com>
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


[snip]

>> diff --git a/configs/dragonboard845c_defconfig b/configs/dragonboard845c_defconfig
>> deleted file mode 100644
>> index f29f11e342e7..000000000000
>> --- a/configs/dragonboard845c_defconfig
>> +++ /dev/null
>> @@ -1,29 +0,0 @@
>> -CONFIG_ARM=y
>> -CONFIG_SKIP_LOWLEVEL_INIT=y
>> -CONFIG_COUNTER_FREQUENCY=19000000
>> -CONFIG_POSITION_INDEPENDENT=y
>> -CONFIG_ARCH_SNAPDRAGON=y
>> -CONFIG_DEFAULT_DEVICE_TREE="dragonboard845c"
>> -CONFIG_TARGET_DRAGONBOARD845C=y
>> -CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 845C"
>> -CONFIG_SYS_LOAD_ADDR=0x80000000
>> -CONFIG_FIT=y
>> -CONFIG_FIT_VERBOSE=y
>> -CONFIG_BOOTDELAY=5
>> -CONFIG_SAVE_PREV_BL_FDT_ADDR=y
>> -CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
> 
> I would suggest keeping this config option in new qcom_defconfig since
> it allows to package FIT image as intramfs within boot.img...

Ah for sure, nice catch.

I know this is a pretty huge patch, but for future reference please
could you trim down irrelevant stuff when replying? Otherwise it's easy
to miss your comments...

[snip]

>> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
>> new file mode 100644
>> index 000000000000..e50b3bce5cdd
>> --- /dev/null
>> +++ b/include/configs/qcom.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Configuration file for Qualcomm Snapdragon boards
>> + *
>> + * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
>> + * (C) Copyright 2023 Linaro Ltd.
>> + */
>> +
>> +#ifndef __CONFIGS_SNAPDRAGON_H
>> +#define __CONFIGS_SNAPDRAGON_H
>> +
>> +#define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>> +
>> +/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
>> +#define CFG_EXTRA_ENV_SETTINGS \
>> +       "stdin=serial,button-kbd\0"     \
>> +       "stdout=serial,vidconsole\0"    \
>> +       "stderr=serial,vidconsole\0" \
>> +       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> 
> ...as otherwise this bootcmd won't work.
> 
> -Sumit
> 
>> +

-- 
// Caleb (they/them)
