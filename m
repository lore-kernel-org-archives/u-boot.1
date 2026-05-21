Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0221BCD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 17:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E718482E;
	Thu, 21 May 2026 19:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BG1nqILk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99A6846DE; Thu, 21 May 2026 19:42:14 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E0684704
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 19:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbd23bc684so3477981a34.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779385331; x=1779990131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rj4FIzzZgaWGvQ7WvpRwcNacQNI3VVMe+ss8t38DqDA=;
 b=BG1nqILkLg3Oo0k4FeHwkSRaur7FawYnFjzzLjCrui6pVujAnQncd0IVracTLP/KUv
 wqT5AsXzLOumupFhUFc5Pwxr6xh8wdAUSfwSguS92Ab3gn5SYFCmVvPx1C48paUCClcy
 vZjJZl7wEGlNqtq0p1K/RyqYPCambQdsM6bsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779385331; x=1779990131;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rj4FIzzZgaWGvQ7WvpRwcNacQNI3VVMe+ss8t38DqDA=;
 b=bqm3Zhjpy4Ha6cpuGGqaPO3Q50bSjPIXsCctd5oUl1+nCPJCYRKNXGX86siiQnU0Ai
 PGLq+6JnNUTStVzk7FVVkyzgGPHWOyKKTScoleZ6MumoIigUP6vpwAg7H6/ciX8gebFW
 zkB5WePKItMDBAwIFz9xTerrhwqdIsDLBiafj/eSsYC9RQYda/GWePflDWr7xoXvnUkH
 kSk7MzD3jAW6VzBGwsDT65iPm2tc0VSDjO3VWb5BP2JtbGtlbco6A/TgPhqUYWfhZkrP
 +rcSYeEjMhWw2aaQWq4r8kfDQAXCTqP2mLFuraeAzjpFrhIghIli07EC9erRYD+M2gtg
 +LDQ==
X-Gm-Message-State: AOJu0YwfkrM9mOcDiruA8VTLwKwDAgK4NbdQJVr7sD9P8WfTQwGmzd8V
 cgoTzGWolmIdPPBNEWeGChZNYsdlJL/I3xk3CI97B99QjfHqDwtEW1BbJvkTNQyHT2grxCG5ewo
 n3htrXI0=
X-Gm-Gg: Acq92OFHw2xLtEwvISw+fPZUV9fk/4AQtt2njsSc5CaGth04Y3Hr962VLyfXsLKtjzT
 0MXdABS18pXnHUTnUzIs34B5R82Id9qsEEtp1lU6QX1X5xm+47mkG54tTrBtwBz4hdtOyicdPwl
 B5QqLPwptmdraebDL+sU9RnohrFM+9J6bzgb08Bp6y4z/tMUwDmihhbXwGgh6vtdzncTWnHDUcc
 Nd4RBYJTBn8gtDFjmcfwQldt18N+GquMQpAfIZ9PcOt5CTn5sIBtY+AwrF9aJFJ7zQwOfSSt2Hj
 TEzRoil5lCVa+vFlPZqPEEKoDIXWLG9cATHYFVYJA56ghcBsyNzMI7pPDIp9DoZlcauKq/KHRkl
 5F5alW1drG5fEhESRS/HRAMhf/Qk/jh9OKgsp+JLiqsKyytUIdJhKqJN9BMS4LXy5j1rPtqHbSy
 w6Ch/FbXF4hkAqgkgzoESjNwi9p6Bt+tBiAvk84pNDblge2BynN04T4s1/jzdk+ktD8RuhCFltp
 4WxHz62rdWMyu42gz7h645adxnsmILOhhXRebfzd1Cb
X-Received: by 2002:a05:6830:2404:b0:7dd:e032:3cdf with SMTP id
 46e09a7af769-7e5fef2e3e0mr53195a34.19.1779385330991; 
 Thu, 21 May 2026 10:42:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6e714cesm872525a34.14.2026.05.21.10.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 10:42:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Francois Berder <fberder@outlook.fr>, 
 Zixun LI <admin@hifiphile.com>
In-Reply-To: <877bowokep.fsf@kernel.org>
References: <877bowokep.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260521 into master
Message-Id: <177938533030.2085599.1584639335918961068.b4-ty@konsulko.com>
Date: Thu, 21 May 2026 11:42:10 -0600
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

On Thu, 21 May 2026 17:24:30 +0200, Mattijs Korpershoek wrote:

> Here is a PR for master with some fixes for USB gadget.
> 
> Usb Gadget:
> * f_acm: Fix memory leak in acm_add()
> * atmel: Fix gadget support on bus reset
> 
> CI:
> * https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/30195
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


