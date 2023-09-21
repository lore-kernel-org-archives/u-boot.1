Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68894E71072
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 14:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB81E865ED;
	Thu, 21 Sep 2023 16:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liFm4VW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCAE864EE; Thu, 21 Sep 2023 16:03:14 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66AD7865ED
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-530ea522f5eso1098550a12.3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695304992; x=1695909792; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LBp2xIM4793X7H+mKcTWRek9JbT/T6O0V3JEfarkhn8=;
 b=liFm4VW+t3R6dtAx7sbjlAWavvI/y6KdFcSeS/6HihpRUAdh33DuWNBx5/pe7FlF2U
 oIv+lVa0orb6YdyJhlvAn76Jj6NrApi6vpZQeoqtsi/UFqo8NA4TBW7SpKr3OO8MD8eu
 lg+EZydyYVYc/Ud/Dp4lqqjkTp4UN8jPwAwu4pPqLEdBeKryQnZEUqt4qrP24YtdKrXI
 2oIwXAchbRMX4nvUSvg9vvwxIgCogOO4jt3lc+OazqH0FqzJs/+VjsmxAQWuqiECipzA
 47ZmzQUQnQJNUhH3fo9kjC4xMvtzkJtuoMQybq0jJovN6MTpPk2eJ6rdlzHzB6HUTIC7
 IEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695304992; x=1695909792;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBp2xIM4793X7H+mKcTWRek9JbT/T6O0V3JEfarkhn8=;
 b=Cp8H5W9aUPv0aNp9Vk8DO/8VfLNHza0YDE8GwTU/MkgD55NOofMfcgiunvUX35jUoc
 Z9nCn94lg7R3IMqeBJiHaEwnaBWa+jgVd3Lnj2VT5lGpi0aOD8dgdaW4OlSYxzkaWVMB
 FE+5GXhtDoqWG3PTi8LlV8pRx5/+8H8nCRAnfpbFrGqYEodnpedUpLvKvdzPu+7cNKS2
 OatdHvgFqE291K87dhuuMXpFxaSzeZUs8OTUnDJYfxyumgf6gWlHim2bti5OHiFLBnij
 rjyj6PSzhBL5P6/FM0wYPH+bVPfUcJEvMCZB20Guypox0ienCKhJ4TwPWsPfq0vyHkGY
 m1Jw==
X-Gm-Message-State: AOJu0YyAjUycWjvL0J5At8/76q5LVy5cc6gdoP3nWFaoOhFQjGNv2rzc
 YXdbUOo+BuBEi5e6f9dTW6gbnfp6AxU=
X-Google-Smtp-Source: AGHT+IH0iunz5mtfJXXt8GWmrjr6nj0UuzpdJcilClzH7tCrUh6IfqSxafuia7krJZnG1ocGNhdyJw==
X-Received: by 2002:aa7:d416:0:b0:523:1fa2:4f40 with SMTP id
 z22-20020aa7d416000000b005231fa24f40mr5535961edq.19.1695304991640; 
 Thu, 21 Sep 2023 07:03:11 -0700 (PDT)
Received: from [192.168.10.30] (14-5-142-46.pool.kielnet.net. [46.142.5.14])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a50fc04000000b005254b41f507sm890542edr.32.2023.09.21.07.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 07:03:11 -0700 (PDT)
Message-ID: <8d8f83b1-1133-ab7f-1cd1-1a2977afe849@gmail.com>
Date: Thu, 21 Sep 2023 16:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20230920074225.1130769-1-linus.walleij@linaro.org>
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



On 9/20/23 09:42, Linus Walleij wrote:
> This adds support for the Inteno XG6846 board based on the
> Broadcom MIPS 6328 SoC.
> 
> The default boot will read a uImage from flash and boot it.
> 
> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/mips/dts/Makefile              |  1 +
>   arch/mips/dts/inteno,xg6846.dts     | 57 ++++++++++++++++++++++
>   arch/mips/mach-bmips/Kconfig        | 12 +++++
>   board/inteno/xg6846/Kconfig         | 12 +++++
>   board/inteno/xg6846/MAINTAINERS     |  6 +++
>   board/inteno/xg6846/Makefile        |  3 ++
>   board/inteno/xg6846/xg6846.c        |  6 +++
>   configs/inteno_xg6846_ram_defconfig | 74 +++++++++++++++++++++++++++++
>   include/configs/inteno_xg6846.h     |  8 ++++
>   9 files changed, 179 insertions(+)
>   create mode 100644 arch/mips/dts/inteno,xg6846.dts
>   create mode 100644 board/inteno/xg6846/Kconfig
>   create mode 100644 board/inteno/xg6846/MAINTAINERS
>   create mode 100644 board/inteno/xg6846/Makefile
>   create mode 100644 board/inteno/xg6846/xg6846.c
>   create mode 100644 configs/inteno_xg6846_ram_defconfig
>   create mode 100644 include/configs/inteno_xg6846.h
> 

if you remove board/inteno/xg6846/Makefile and board/inteno/xg6846/xg6846.c:

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>


-- 
- Daniel
