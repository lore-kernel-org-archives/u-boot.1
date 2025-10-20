Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4C0CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A815E836B4;
	Mon, 20 Oct 2025 15:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OYA/EwnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB0483741; Mon, 20 Oct 2025 15:58:49 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C20A83631
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so3259810f8f.3
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760968727; x=1761573527;
 darn=lists.denx.de; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8S6gJ3TPrx06m48vGZBal2efQ5FxAGAs6xq3FYlnmw=;
 b=OYA/EwnU5t6gYo3XuZANPK0alZzashjWjjkV7FZ4MV1sukb3N/VUsuncjtequLmk+2
 Pujl5s50x8xd6o6ow6UojwNAZlOYyUhCGHrLAPSeQRPmBQU9LiqIqkhpaRHlu/JFYbsc
 T0E4ERVgpE5YRlcPMK5M+KDeqS3ftegrCjP21y/X3JnyiA4flQ9ewJlYUZ7O420bJzGl
 hqEXhrr1p+Ak/QPeN3KBqLSJdixzFaap88ac0aVltSO1vdpV8OYivFecIHbspzcgBjgJ
 DRiCn9mrJcXQ9bygKCMszQXVJii+OEw17WhPkz5QHyqzHcyfuQC4QfD7XoXmoigLHqrD
 4ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968727; x=1761573527;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l8S6gJ3TPrx06m48vGZBal2efQ5FxAGAs6xq3FYlnmw=;
 b=FqdGXsngSM/A3abniIGkRhHBQLdbFKswS454hJ0zq8841apTwdyKyJ57AS1hFeb0Cp
 cxLfihOODNmdQo9N7dBIY8CQriIsmlpBGeY7Us/spHQB/SU/Wo6KZGWev2s+g9lV5xFd
 wO2mCYuTm+pSNUUAyQ7DtpiOPHAn/d/1+sQVI1bi0bgWn4Fz/KldpsBw04/0KOdwxv48
 /bcH9003KGeiCKuGXj/p7HY1e8pulStp0Z6kVVk+CC1ZfvDCMKT10Eg4XCQzUlRcouLv
 dewLr7DYABGRz/F2BwzpOOGaSNhILwgXVnZS5owlIUPx4FnZOtoaABc4fcfbg0UGWLLU
 OB9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZomScOrBWfeFH5pVsdvu3jXxMY9iMbRmPK8L6xTjxV2tUTp2DmoFeHLD1E78FdgajqVGL97E=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4Ac28yV6V0LHR2qUewIrr0ciUFl3RXQC8oWgxvtsy7EGsWKJp
 qEhJSW/rgPWrIFd7uCC6dzlw6kczp8QUBRCPzNhI+mkq9TsixX4IzRyrCGHHXImdm7E=
X-Gm-Gg: ASbGncuHi9zVEMXY8CXvmxPkv8vJQq9U49yJDTkAKMHY0CCOf1HWSWBk/pYCXf4wGve
 YxARxjEAN3gIsuMcRAuz8dQjgOX6TZoT6a6McPwYw2sPvzjBrZJZGkk3ftIsWSiQIyGm+UN5zaN
 yBkhOXiB3NZ71eaQQQFY5zx6Zvrk27FUfqRnTsPlWiJFx7uRR7AkxVhYcBGjQiHb16Kl5Kg34k7
 6XpE57Tf3N8QFdN8Jwu3E+WbCNFsi2gKczENbRIP/6CvNmKMKlt+YYM3/YJz4A71KCvaa5uiDGH
 tRE6vcviknMI33fWnJBt80fWHK54Yl47llHqniNcy+Xeb1k/i5MfhCtdu1rShAGiYvY2RY9ob74
 xpHHfvypMfydSIILZZ37B/ebKUom0VjStPr/4QQXOYSY594byq5PmlQbivMPdLJRHBnoF+zPwoQ
 QQyGcSZlywGKd36CUWSINTu1w2DphFNPQakI+RCgtDXg==
X-Google-Smtp-Source: AGHT+IHvMduRMOSxWdpVzuA1OVLQhRDDVPQbkRME/a4eVvhPy+tSlb0eplGy9oHg+2ims3VQEr9rSQ==
X-Received: by 2002:a05:6000:2305:b0:427:928:7888 with SMTP id
 ffacd0b85a97d-42709287b06mr6706016f8f.55.1760968726309; 
 Mon, 20 Oct 2025 06:58:46 -0700 (PDT)
Received: from [10.1.5.55] (88-127-129-70.subs.proxad.net. [88.127.129.70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f7dsm15237206f8f.4.2025.10.20.06.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 06:58:45 -0700 (PDT)
Message-ID: <1b0bb579-5024-47b2-8fe9-58c2edfa081f@baylibre.com>
Date: Mon, 20 Oct 2025 15:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] android: add bootconfig support
To: george chan <gchan9527@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, Sam Day <me@samcday.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <CADgMGSsxkrqZ3Dirq9KPoP0aaHew0A9DZEuoTotvqcHsfkEw6w@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CADgMGSsxkrqZ3Dirq9KPoP0aaHew0A9DZEuoTotvqcHsfkEw6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


Le 18/10/2025 à 08:07, george chan a écrit :
> Dear Guillaume,
>
> Thx for your patch.
>
> 在 2025年10月17日週五 21:19，Guillaume La Roque (TI.com) 
> <glaroque@baylibre.com> 寫道：
>
>     This patchset add support of android bootconfig partition[1] in
>     u-boot.
>     With Android boot image v4, all androidboot.* arguments must be
>     passed via bootconfig instead of using the kernel commandline.
>
>
> it looks like the above add logic handled bootargs well.
>
> is this logic support the use case of appending existing bootargs from 
> env and handle the one mentioned in
> [1] for simulation of vendor bootloader behavior to append some 
> androidboot.* bootcmd to formulate a new bootargs? Or is this series 
> complementary to [1] so as aimed to "move" androidboot.* only to 
> bootconfig? If this [1] user case is covered then I am very happy to 
> stop [1] if this series can have same result.
>
> Btw, I am wondering if this series assumed Androidboot v4 only, so 
> kernel ver must >= 5.4 and enabled with bootconfig. Since then 
> bootconfig can be unlimited to it's length. So all predefined 
> androidboot.* from bootloader, can now move out, and no need of 
> default bootargs in env file any more.
>
> And how about those Androidboot v2 case?
>
> [1] https://lists.denx.de/pipermail/u-boot/2025-October/599708.html

in TI project we have this patch 
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04-next&id=9d802d798ac143e06ffe545606aa657a6c32cc63 
, we forgot to upstream it but i'll plan to do it if it's not a problem 
for you. let me know if it's ok for you and i send it this week. Normaly 
this patch resolve your issue, it's not mandatory for bootconfig support 
but needed to not lost all other bootargs no link to android in bootargs 
when you use bootmeth_android.


Except if i do some error in code, boot config code was only do when you 
have android image version 4, code take all androidboot.* param in 
bootarg, remove it in booatarg and put it in bootconfig partition before 
booting android.

some arg was adding in bootargs in bootargs automatically(serial, avb 
arg, slot etc etc) so instead of check where it's done version of 
android boot image we have  we prefer to do it just before booting.

for fastboot boot i never test it with TI board.

Guillaume

>
> Regards
> George
>
>
>     [1]
>     https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig
>
>     Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>     ---
>     Changes in v2:
>     - Add test
>     - Add new command to be able to load and read bootconfig before
>     booting
>     - Somes fixes to works with sandbox test
>     - Link to v1:
>     https://lore.kernel.org/all/20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com/
>
>     ---
>     Guillaume La Roque (TI.com) (4):
>           boot: android: Add sandbox memory mapping support
>           boot: android: Add bootconfig support
>           cmd: abootimg: Add 'get ramdisk' command
>           test: abootimg: Add test for bootconfig handling
>
>     Mattijs Korpershoek (TI.com) (1):
>           boot: android: import addBootConfigParameters() from AOSP
>
>      boot/image-android.c                        | 180
>     ++++++++++++++++++++++++----
>      cmd/abootimg.c                              |  35 +++++-
>      test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++--
>      3 files changed, 292 insertions(+), 31 deletions(-)
>     ---
>     base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
>     change-id: 20241128-bootconfig-276e247be992
>
>     Best regards,
>     -- 
>     Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>
