Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3CBC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1C8846B2;
	Fri,  8 Aug 2025 13:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MbGzS+vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45B6846C7; Fri,  8 Aug 2025 13:16:17 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACAA7846AC
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-af95d5c0736so326117566b.2
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754651775; x=1755256575; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E8Tv+eTepCIyjpdXjF3YvLuGk30UUtqvj5RCVPT628c=;
 b=MbGzS+vdToMun/n832H+OAz2nQbGxVRazFVTE0rRjPKJX7kCHOiCXVoqPCQiSYXmds
 zVHiTr37AzcBLPc6ahSmyeYEOzz5qtR2GSlJNla2UK+gDer+GR6FIYCcapUSBwGDaOhA
 qE0csVZo4iiurFCkPnfzQ+4aEJfEMF5dTVXTeT2A5zvb3eMBds6O8Sh5pby034QGgwgN
 D1yrF7DD0sGJtz67eJGLmr174zoUFMWElq6o0/AbCN9QsuNOsakAqUQH/7mhc+k+x1Mr
 bgrr13EaH7G9CQ3pWK7J8bpYtC9/wVemnHibjrS/s3CVncKu0bpgbJueN00K4e4/1Fwa
 BeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754651775; x=1755256575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8Tv+eTepCIyjpdXjF3YvLuGk30UUtqvj5RCVPT628c=;
 b=LGKADqybfNgxtGODQYwiKfgfY7AK7505RPs155kKipGx904ZPASZ7fb/W9gk2c4wid
 XwQZbkigDcnvzrPQhXxcrDy9qitQiP3V5OftFaMaeXUro4iytpurByyiPCMLs1IQKJmM
 aNAevmr5HhQ1LOnyvhWl0EVukNMIjxMDSdCeOExtl69sAvvKd34DHFLzIJiFC8/ZI1lj
 Gvy/vmXsTVH9dkEuc0iaPvn8Eb70BzIbjT3LTwJYqGvTKGqRahUTTNeJfqxkH6exI9jL
 BlodZDStQN7cKDbhJSUTj/GYsc1cy/RP/JZ8pyMxxOTRXmi78Zahnsdeyq1A3ojWWz4J
 UQ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOPJlNCdd2VTV4F+Atr6s1dxI0/CZNk7QPOFcITBeQxtIp8b8OfQLasNvy8kPPpbfFsKNAiEw=@lists.denx.de
X-Gm-Message-State: AOJu0YweWjLitKnBNA3SrXu7HWodlEzM5lEg9MrBQRcCzuwvEY3G9+Gq
 K4QZey4CP6Mc4LfJ8LHivWotr9XLea19h+CNA6gGFXue7N+y94WQ8Uyx
X-Gm-Gg: ASbGnctTICVXl/tRKNCdTskblquOjOpqRyi33b8lTBIF/KCtej1ITIvPe0nI/z7hair
 N7Vw1x+Hi3tgIxUE8G5fcA/z5pa3rYTVdzLxrQW2db06f5QEqgEq27WswZVh3j58/L2yGwzO6sf
 yvaW9a/QWNmWwXJgi0LgIV9gk0BNftHLIPjMMDPmmQAfmvWrLUELklE1d9h2p3Ib7YN/K7J7VMV
 XOz4rNE0oHiSyj0idf8kGm/Q0XPKvwATwpLkQFku3UpsPGtkOCrpI8l3K2COOJCf5lAGkDTil/X
 wTDTDqIo/p9nKWsupqvRadVKiDU7KAVWgUkbKh38l9EVRQlz2AGrSouT6ape0PH5IKYUz2QPRGA
 jaWNnL1ts3jCzPPDJHZnRGndW5S0YhF0K8/BMzJYHtaRG4Grpr9okcEKm+7jmluDZeEUbGVmZAg
 3KvnmEWhjfyA==
X-Google-Smtp-Source: AGHT+IGNiJLNWPYCjpfmkwAdPnC5qgk5kzCk5NUEbZFL8YI+Z8N37cK4sieYe8vXEwoRWhllPHr2GQ==
X-Received: by 2002:a17:907:7f90:b0:aeb:3df1:2e75 with SMTP id
 a640c23a62f3a-af9c64fb1b7mr202364866b.46.1754651774915; 
 Fri, 08 Aug 2025 04:16:14 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9c:3e10:4efa:fd63:dc77:6cc6?
 ([2001:9e8:9c:3e10:4efa:fd63:dc77:6cc6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a21c0ccsm1469687566b.111.2025.08.08.04.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 04:16:13 -0700 (PDT)
Message-ID: <d09e6df0-1143-4779-9ab5-c45f8424dbe2@gmail.com>
Date: Fri, 8 Aug 2025 13:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] mips: serial: Silence "unused variable" warning
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20250807075653.356088-1-pro@denx.de>
 <20250807075653.356088-4-pro@denx.de>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20250807075653.356088-4-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 8/7/25 09:56, Philip Oberfichtner wrote:
> Before this commit, mtmips_spl_serial_init() caused the following
> warning:
> 
>    arch/mips/mach-mtmips/mt7628/serial.c:14:23: warning: unused variable ‘base’ [-Wunused-variable]
>       14 |         void __iomem *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
>          |                       ^~~~
> 
> This happens whenever CONFIG_SPECIFY_CONSOLE_INDEX is unset, which leads
> to an effectively empty function:
> 
>    void mtmips_spl_serial_init(void)
>    {
> 	  void __iomem *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
>    }
> 
> Add the __maybe_unused attribute to silence this warning.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>      Changes in v6: none
>      
>      Changes in v5: none
>      
>      Changes in v4: new
> 
>   arch/mips/mach-mtmips/mt7620/serial.c     | 2 +-
>   arch/mips/mach-mtmips/mt7621/spl/serial.c | 2 +-
>   arch/mips/mach-mtmips/mt7628/serial.c     | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

