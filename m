Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559E8CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 06:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57BAF87916;
	Wed, 10 Apr 2024 08:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QYqRoOnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E59587EEB; Wed, 10 Apr 2024 08:44:30 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AEC087861
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ganboing@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so4484945b3a.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712731466; x=1713336266; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqNnEQ6OinN8WGL3nP84+WO9nx3+GcsYjGp1XVIzjEw=;
 b=QYqRoOntpxaejL6aDD0KEHcf4HFC1hhhOORJgXDao+HggT6itF/ahYqC8zrh2FOcCD
 5EYTg1jZCB6v8yAPLDfCo6tQfIQ6VUCU5IY9Fxu0/FG2bzNEsOoSs8zEcKH0qvdTcW4G
 ywsU9Pn/G8FhH9EVqB1RMFjtqArBjwQnELjF8B65pTYEAxmcT4rCg2XHlO5Lqe/7Rgv6
 PyffZzs4WW00YDg3hLrku0VUo/eYf0lI2wv6FnQOb32MZqyWGkBZ4gbQKSXYovZ0yiu4
 NCPEwNJsiGtie9U514tmIlZJW6fAELOCxH8EblrN2fzEToCgrHrDdw/Zf877njWSMUQk
 buxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712731466; x=1713336266;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OqNnEQ6OinN8WGL3nP84+WO9nx3+GcsYjGp1XVIzjEw=;
 b=GE6ce7jfG52EhoB/5/hTBRIyg2TUPF4cSvNTUbeRPWJdA4RbLprrcI+A+jnO2rgSdr
 J60pPz9ORpr91qYE8hn9sv0V/9OEn649+K5PheU5/L6YAKoKWRh/8vlGn/HINVoYziZ2
 0bI/gvVVtjlcIoFW9PSm35ZxonUOkC1Y9Mjk2j527BS3zhJ2wLRRZbIsy77FDrJ8X7YN
 wec8zP/H0OHAfM/7ar9oY6J6wFBxSyri2JGNtbiw9pGeULdi3pMjMDS9A3cB0XUWr40k
 Xbykb78IbLsqt4DEB0njG99emJr3Cm9eDzfIfKV8VYEhJwm6924S47uDiy8SrYCC4IyH
 fXqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbkIdWhw6FeshB5hAqdITopZpcHVNFcMkxx+WGPQxMhsnSCTDEcrs1Ck5quIZSFRlacCxfaiXHe/XNN8ZBTHClwgYrZw==
X-Gm-Message-State: AOJu0YyiFoStJdc6msaCeTpwuTMfKyHYRK2Zt/g58vNxyz+KjDr+Pwal
 vUtJ4nKTzBejdDmCwuBBXmolVS6OC3zgTErmhFnhzxUfUK4/ABXNYGoYmy14bko=
X-Google-Smtp-Source: AGHT+IFzhCQTCLEImiScKlxnjFV4DGH84ODKP7WOX7XE9tk1G5F9MwAS3R300BhBLH31h2P4gdNMpA==
X-Received: by 2002:a05:6a00:17a0:b0:6ea:b1f5:112b with SMTP id
 s32-20020a056a0017a000b006eab1f5112bmr2263479pfg.21.1712731466270; 
 Tue, 09 Apr 2024 23:44:26 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a056a00228f00b006ed37f1a912sm4686445pfe.89.2024.04.09.23.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 23:44:25 -0700 (PDT)
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
To: E Shattow <lucent@gmail.com>, Hal Feng <hal.feng@starfivetech.com>
Cc: Bo Gan <ganboing@gmail.com>, "rick@andestech.com" <rick@andestech.com>,
 "ycliang@andestech.com" <ycliang@andestech.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, "duwe@suse.de" <duwe@suse.de>,
 "namcao@linutronix.de" <namcao@linutronix.de>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 "chanho61.park@samsung.com" <chanho61.park@samsung.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
 <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <0eda64cb-4ca8-f8bc-7515-6d2a2d3d4638@gmail.com>
Date: Tue, 9 Apr 2024 23:44:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 4/9/24 6:55 PM, E Shattow wrote:
> Original speed class SD cards fail with this change "unable to change mode".
> 
> On Tue, Mar 12, 2024 at 4:12 AM Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>>> On 06.03.24 11:00, Bo Gan wrote:
>>>
>>> Previously PLL node was missing from SPL dts. This caused BUS_ROOT to stay on
>>> OSC clock (24Mhz). As a result, all peripherals have to run at a much lower
>>> frequency, and loading from sdcard/emmc is slow.
>>> Thus, enabling PLL node in dts to fix this.
>>>
>>> Signed-off-by: Bo Gan <ganboing@gmail.com>
>>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>>

The BUS_ROOT clock will have to be switched to PLL2 anyway in U-Boot proper or
in Linux, because it's the parent or grandparent clock for *lots* of devices,
including PCIe, i2c, spi, qspi... If there's an issue with this change, then
I suspect there's something wrong with the dw_mmc driver.

Bo
