Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FA9C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 09:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2232388009;
	Fri,  7 Jun 2024 11:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F5oGwwvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4880787FCD; Fri,  7 Jun 2024 11:23:28 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5875F88020
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 11:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42166eb31b2so4376795e9.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717752206; x=1718357006; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KB0ipqRgbeyVWquyIs5JLDlJfeTkK8PTwVtJW3ybnWQ=;
 b=F5oGwwvVf6CHeNiym+NAHA4axO89wArZvQW+uCRHpGnn6HHNs0eRobMdQO7N7kFhnV
 +1Bcx6bSmP8ZR7G6dnc7mIP+/5SC3Hh+2XDpPVvH7aXtNjxNFZRM1ZXO3tb2FIdtjjlJ
 a/R9Bo5p4wu1QbEhrRvlO1kmXw5E4IPHFi5LV/j5rouTVnXWrLr0ctklxuPIvoS7g4M3
 odM3NbRpd5zxwTxsy/99FHmy3rInJpkThkAE+hg2yMKLGGALBwEx4SBwPyo0PJ4Xr/3M
 Ravo8IbEBsTr8firtn7cJAr9RVAyI1J85i2/NUxIJvfpJH6iQvfZZEmEq04JKhCUDcTK
 bJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717752206; x=1718357006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KB0ipqRgbeyVWquyIs5JLDlJfeTkK8PTwVtJW3ybnWQ=;
 b=JtwWvPkFt7fMoWS5ZYOV4LPx/KE4DHkStSukEBlk4TABPNVpd0+ZwWQWYe3pvNx1h4
 5wLvzHms1/K5vR6QjfTJxSrdTparHJLhrrRSWzy6RS7EoUkKxTnqcnov7Tt28MFIM26x
 oXKagIrmCwFQlCY/vfi8nptVjqeAe22wdipjRUyZj0JO20e2GL0bOWZ5RyqwnKmCPljx
 sjCwNM8Q5zApVY2ASNsSXreQ9bOEpuOzbtWYscI+0RUYrBFzSA/gcoPICu5752LJEVqM
 rKEycv5Bx6ZfQsiyjwtLgAwCmF3E7EgKZqjpPBUtGvETFzwETLH86JLURRXkr9Ufvw2b
 FIIw==
X-Gm-Message-State: AOJu0YyLZZTMQYumElafpDVQsj6W2UOh2qJTnYGgLqwhioHEwZ3L47sC
 n3y/4YYTLDRRDFvfZwHxFH8IWElU00NTRdYsYNKMuCQIbSb602snNJocXwCVtBw=
X-Google-Smtp-Source: AGHT+IHGkdcxHNI3XW95PnaE4TYbJu8BC7NNrLudK+g1p9NE0khA2PlP8WNSlEMVyYRQ7uLfQkYc6g==
X-Received: by 2002:a05:600c:1d8d:b0:421:55a1:afc2 with SMTP id
 5b1f17b1804b1-42164a37103mr17878985e9.38.1717752205663; 
 Fri, 07 Jun 2024 02:23:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c0fe4b3sm47173885e9.0.2024.06.07.02.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 02:23:25 -0700 (PDT)
Message-ID: <486e9493-9882-4590-b03e-a3cd0edfd13c@linaro.org>
Date: Fri, 7 Jun 2024 11:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] net-lwip: add wget command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson
 <pbrobinson@gmail.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Edmond <seanedmond@microsoft.com>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <16eac9a19f8f6572ea111cc20cc5793bfb5e6f94.1717680809.git.jerome.forissier@linaro.org>
 <CAC_iWj++SdJxHouuX_rhgTpeKcfqvudHgtjDQ6Gz0HzYUXoV9Q@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj++SdJxHouuX_rhgTpeKcfqvudHgtjDQ6Gz0HzYUXoV9Q@mail.gmail.com>
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



On 6/6/24 17:41, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> Can we split this in 2 patches instead?
> A preparatory one, with split the net-common etc and one that adds wget?

Sure, done in v4.

> Thanks
> /Ilias
> 
> On Thu, 6 Jun 2024 at 16:37, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Add support for the wget command with NET_LWIP.
>>
>> About the small change in cmd/efidebug.c: when the wget command based
>> on the lwIP stack is used the wget command has a built-in URL
>> validation function since it needs to parse it anyways (in parse_url()).
>> Therefore wget_validate_uri() doesn't exist. So, guard the call in
>> efidebug.c with CONFIG_CMD_WGET.
>>
>> Based on code initially developed by Maxim U.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
>> Cc: Maxim Uvarov <muvarov@gmail.com>
>> ---
>>  cmd/Kconfig        |   7 ++
>>  cmd/Makefile       |   5 +-
>>  cmd/efidebug.c     |   8 +-
>>  cmd/net-common.c   | 115 +++++++++++++++++++++++++++++
>>  cmd/net-lwip.c     |  12 +++
>>  cmd/net.c          | 115 -----------------------------
>>  include/net-lwip.h |  51 +++++++++++++
>>  net-lwip/Makefile  |   1 +
>>  net-lwip/wget.c    | 180 +++++++++++++++++++++++++++++++++++++++++++++
>>  9 files changed, 375 insertions(+), 119 deletions(-)
>>  create mode 100644 cmd/net-common.c
>>  create mode 100644 net-lwip/wget.c

Thanks,
-- 
Jerome
