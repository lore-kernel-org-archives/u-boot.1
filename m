Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29E6CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 13:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEFDF84AFA;
	Thu,  7 May 2026 15:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fee9MYx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2B584ADD; Thu,  7 May 2026 15:27:32 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306AF84A6D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 15:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bc177ebda91so157249866b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 06:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778160449; cv=none;
 d=google.com; s=arc-20240605;
 b=ACcREDNz3K6DP+bQBieK80wjGgSmZxl0tXDd60M1SEhn13xTWDWFmcfr9hFgkvfbWv
 fe1LNUkSrRHDc3wtponqGfVsBZJKtFMc3IubMJfTAKJcENNdP5R16tgcI8VV17hhYQZc
 OoLnGfPxNwLlK1Ev3jaEYNHAbKm1k8CfOnPD9/X+9mn5OFjdjLJJDs4DHiz7G0Vig3Sf
 I7p1AxY7/etdqZReUkmOA4U/Oe5u+FMrTLx49scfBL985VCo0EEwX7mr0V250IhYl0D1
 lnWbwcpvt2hhVDtFtTwxJYGe7757UjDp9IK7daYMlvpp4rQe/D2Ad7NQsj8LjyP6IgoJ
 428w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PMzG+MY9y+dfUiqPaXVc86qUUTsxGDFWwyNYLs8KNdc=;
 fh=HdAOgKCO+gGyWWUY07YX1HIbVzH0zmehjZouPtYwrPg=;
 b=CeLRcal4AUBQHW+cKzweY1/fdZ9acUTRsnK5UTgJhUwQ3krkRztBMPlrDcDcLbCFGI
 Zt05m8mAtx/loeHiQlQebpvqK6gsBF/qoNqJ1YqkNNp/q411kTsrB11VTNPp+1UWot+9
 OUk6UqWv7HMDiv1xjKTaojPDzW7lq7jDCO1w8mQ/iK9UTe9cEq4u2Hf2WHS8bABeRV2W
 blPl2tJixjCFKIMZW4mkuz+X7nXIMXISd0hB6BV2RYJztcfYLOhvSKlyWXVlAghUrwka
 r/Exx/RTQJAe4dPQ9HYm6wqURbTcILeg/U9egv/xtwUB+p9ev4ayvotO999xo/RB3IT3
 z1NA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778160449; x=1778765249; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PMzG+MY9y+dfUiqPaXVc86qUUTsxGDFWwyNYLs8KNdc=;
 b=fee9MYx1nX+djueB2rYcaAxkLakO8sC7N7jKumACngZCEGPmyAhFzsOQ1s7WfHlNy8
 gY1JPKok/k+Nsjz1BNd0+DI9/RNpjdlCB0eAHdT8832fF96pn+VWtylUfpUJ4/vLbn0J
 X+uCajfIllpucgzPqEFpgAM+eqpL81pubReMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160449; x=1778765249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMzG+MY9y+dfUiqPaXVc86qUUTsxGDFWwyNYLs8KNdc=;
 b=WRI2k9nKfenv9JdMWt9xcjTamhPElFNVm8cN+NBj+RO8aO3FxojWZN2VOxXpCxuxHK
 j8KTOE3aoiHJ/QpgXbXD0i2QXy2AHRO9Bjj/+ojAFNzpZmSa8dRlUkp2oQKV3xKsSw29
 ev3LZRvQzTyQ2OoUmarNJ47UtWQAUpXkqspro8K5eGh4r4Y8YJmK4yjdvo841u6DZyJh
 xBj8GiolDE+YRsZq3N7Mx1eYtMeo9Ejk3uVDpvmVMdYvpqqFsV/y77QbDt5eGfkwdYBv
 dP+ZqIvP1xlMk5ZFgZJ3/vh0qqKExfjPCZcX30JKjGdE9xhF0njdEPqDDXyFO9aCQRGR
 7+dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9Zq/YKJA6+bqsB+OcmHjYWVWRJpjBlNCz6nlFs4z+apvg2rhEmiElSCWBgBmXT2RQUNUx3m8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi0rcPw11V9pIDA43nhZUch4dCayp8+O0fuqqvgX0JAPd9xw4x
 2PGREKG6T4WSKdSP0Nf5y9p7GTIsl/nG9pQI39PepdCX3BZguI9qxO0UM0YCej7ab8SaDzdgwsQ
 IbaugMwJD/3/VEDmib0jadHfXCuZmDFFZm97F5Q+y
X-Gm-Gg: AeBDieuzwithRU64kzBe0TmijJEWJrSUmpwlnHfHwgCnATlaiFtGF3i26q1vebcCetq
 B0GUrnfp98hSSG1k9TxmAF6jQHKOqkJI83NhaSb7GEuaLCA9QLYjwFMSB2cMKdY+PlyaU/ujfxR
 7IFJkL3Rb3C2RrAu84J2/jBeiD+jSqtwfoSNfk08iu5V51GI+ScWcF17PkWWTHHpNF8j0zujK+A
 0rHtjSC2dx//OBsuvsKhDnvdr10luOTQL0ppIXMZSTxppeAT7PD677Tzj6rYRGdMyShPnJnpv9/
 8NmgOcd1yBnY39qW
X-Received: by 2002:a17:907:7255:b0:bc6:d755:4454 with SMTP id
 a640c23a62f3a-bc6d7554dccmr246755966b.23.1778160449467; Thu, 07 May 2026
 06:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260505074948.2603870-1-daniel@thingy.jp>
 <20260505074948.2603870-4-daniel@thingy.jp>
In-Reply-To: <20260505074948.2603870-4-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 07:27:16 -0600
X-Gm-Features: AVHnY4Jmq2fX5FmVE_M8quZbkdeTNorCX1WAMJugGnodIGus9zj8Paf0_Hp_hzk
Message-ID: <CAFLszTizJt5i9H_OD4FbLtoOEAh6AOaryjtJOEdEvdxHCkbS+g@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] timer: goldfish: Use __raw_readl()
To: daniel@thingy.jp
Cc: trini@konsulko.com, visitorckw@gmail.com, angelo@kernel-space.org, 
 bmeng.cn@gmail.com, sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-05T07:49:33, Daniel Palmer <daniel@thingy.jp> wrote:
> timer: goldfish: Use __raw_readl()
>
> The Goldfish timer registers are native endian, so they act as
> big-endian on the m68k virt machine. Currently, this driver uses
> readl(), which works by luck because it's currently broken on m68k.
>
> Use __raw_readl() instead to avoid breaking this driver when the
> endianness of readl() is fixed.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@thingy.jp>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> drivers/timer/goldfish_timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
