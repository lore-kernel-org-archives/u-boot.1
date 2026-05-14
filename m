Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1730ECD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370EA8467A;
	Fri, 15 May 2026 01:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XsjbfKBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28604846C3; Fri, 15 May 2026 01:15:57 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9778467C
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 01:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-408778a8ec4so4857719fac.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 16:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778800554; x=1779405354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftrI2KWjcMaPYt6kn+L3iKySYyoiY25jRaRtUXBuqQM=;
 b=XsjbfKBk0rkcJZfKb7ZVXzsdNJCSDJE84h/77w2RgNu69AfKi2S2Ub6iD4puxtOlM8
 1IRaiH/HW1KJHXaeoHSJfLDcYi5h1mTa5gACyZPhz5+jxTlPoAaRSxYGluRL+Lus++0g
 P9qpGqaevcQNBzhyyRkJdI2VcdTw5GnzhlJ6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778800554; x=1779405354;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ftrI2KWjcMaPYt6kn+L3iKySYyoiY25jRaRtUXBuqQM=;
 b=FKiTXvSEL1kV8o7Z1R7nxZO3CF51kwiJB/MMr4FO+lVmNIFP6Ov1SayPf6fnRL6hc6
 zj4v1eHnMp+8izoSGh3jiiBrStP1xTISaZE/lpkyqyAyGHkiRJPqGAcxN0HVsixfmP4C
 VV9FzAIVjsfAZNu368VsxXZ2zafz1ioNuzIfpLxvTmhmaAixqxgxCxCgAHRt4aslzr5F
 nncNvis4bjpbDLsIVxvBJ/gfs86ZPAaicDyHVR1UAhBanx4Ev1TTdAz6W2/CYfdAY488
 Ire7t1xCq5VKXlIE+ZHOYqS2xfeCyawrQh6FAn2RC5fDhdX9de1vUEZjUVipTr+vr5r4
 6ogg==
X-Gm-Message-State: AOJu0Yz/HxyXV7UIR/XwHTI2HNFu4zzRKm4mALIeQtEeQqdRUcoe/GUa
 aSNEHWDoS9VpWWwe+MIU9fqERakTiZn1/JKSfHUkEjVXHV7as/5vzT6ova27Vlr96MsC0FSHGXw
 jpGntUX4uc/nk
X-Gm-Gg: Acq92OHvzz6rfTkzieO/Kt91Zcmzzi+X2fiXEj+/ZjKj/PAy97BGo7jGYthW6UJEqwb
 4B84QUKKtx1okUygj60teplwRIhg8H/v7DzNkgZMcbwrZcUQSu911So6G31ZPy8oTX4HFPZ8BTs
 pGJWsDJF/oxcI8uKCBDfVE4/NgnnnSiGs4NmFeE/cGumxfn9fPe0NwWUQft/Qz3OY/k7VD0Jcmm
 Y2hzWyUll/ySJ3WkA39V88CLlvoDX5DEUnxVoaOAt1U9CZLwDBfH/PX8n++zs/hCKe+HmT8eeNm
 HFJT7f3OeL7bwwU1KM9dstzQpQa6P1uXyKsRxBs1rre0fPVZo+9D7ooY27aTOK0tqFan3ZjohLt
 YSPwHESVLoKwpczKIGywIB9iwmiy//u6cMbliAel/Vc3TaxPFhnR44IgAYrjlJlOJsWR8GaqahW
 e3tBKXrR+iLUTW+UB9Kp+E4ENv3qr73+lXltjXlQ7+bv+dHyW2Cv18/QUOKEv2vq2uLNTQH6uX1
 v4M8Df6Fy6s/SiHDCGyJbOV0drjP49zjLe4xPPblpRujD8EQA==
X-Received: by 2002:a05:6870:ff04:b0:42f:caff:34e6 with SMTP id
 586e51a60fabf-43a2de07a4fmr1146007fac.31.1778800553852; 
 Thu, 14 May 2026 16:15:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc144b86sm3020885fac.1.2026.05.14.16.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 16:15:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Charles Perry <charles.perry@microchip.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
In-Reply-To: <20260507185123.2210247-1-charles.perry@microchip.com>
References: <20260507185123.2210247-1-charles.perry@microchip.com>
Subject: Re: [PATCH v2] gpio: Correct dependencies for MCP230xx
Message-Id: <177880055257.4123088.3542194348515751358.b4-ty@konsulko.com>
Date: Thu, 14 May 2026 17:15:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 07 May 2026 11:51:22 -0700, Charles Perry wrote:

> This driver depends on DM_I2C and DM_SPI, add it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] gpio: Correct dependencies for MCP230xx
      commit: 88338f9d147397c42bb996937b1ce31bca096626
-- 
Tom


