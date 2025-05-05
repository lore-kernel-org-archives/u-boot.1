Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB518C3ABBF
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91FC9829D4;
	Tue,  6 May 2025 01:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F5tj6ZNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8822829D4; Tue,  6 May 2025 01:35:37 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D655680079
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3feaedb4085so2984459b6e.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488133; x=1747092933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmLCDLH+7mcMZo/lRt4+Lyt3XvpaC12sgHU1RuWhyWM=;
 b=F5tj6ZNEzdZg/6mVogMLfCYMyUl1fVKQNPnpsJcuvPOG0Ex/mlEqUCKuwWAeFAEOjg
 hKMSuH740fOq8AoqsTsnSgkGEIv6DzKP/Iiw3cEto0OYAhen8qUHFkCwY8CGLG5DGJU5
 +lsGYynl2a+v+JstI7h4NB/qCTfiqzYVL21Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488133; x=1747092933;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmLCDLH+7mcMZo/lRt4+Lyt3XvpaC12sgHU1RuWhyWM=;
 b=g98pI10Po3I6RSavmqyX6bUJwnHcJA+/K0gRuYV/vmmzXs2L9hB5K7C87SAIQ8tAXV
 WGouE9sP7QzPuyUTw1hbVphi2PNWs0WUEJPFjlMcAIKCMz10nnXl+t0OIzC9BDYQ8Clc
 q7VaP92U+Y4AKGIpvnbn2xAUnvney+DSecobHKme9JiweOny6249i/zkWLcIHf40m499
 RmfMjk/US+U2HNsL2RMIk8aMjsY7li6wDGpL47JA/9jSnQPw3rVtbww9KBfuXHmBzPLM
 q9t9Asr0ny0zZL5H+gSnzzHdSS78GSRXZ8/tNJuVX1kR88k1yS8KqC8EsCrfR2PoHZXS
 0pQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtaeQZQnju2/VoZhg8na8/OpgbLFTZ0S5Nq/66bh81jeTCWpjnMG5iSGUpkAIPbUtXf0/GpMc=@lists.denx.de
X-Gm-Message-State: AOJu0YxpN1HP0MfLcXxB0H2vB72/A2kDrScGWwIxaTKG/eKhNVSH4j0z
 PsdMTeiTcW7ZSENv5DylgsoOAU1zHtpMlYhgtE+Mn3yoT8YBuOTrE631DkmR6zo=
X-Gm-Gg: ASbGncv2TNWinQEUpkJynpXK9ckLVkSSyvDyunPKttO1wWefMMvQW4pTaezdZ0bT4mq
 gq9mnoqOzxFK2eQXEJECUL6EgVIQmwSQApyBfmNgwKRpoqSwa271Tb+0BM9yfuZ1tSPkZVmHVF1
 nwaAYYmV6WdVga15LicNJsXCsa1/HIh7427iM/zdLjChawQV2nIrMe3uk2mN6t1yVphh3eC/crY
 1bOliH7ElCDvPEi5hrS0znaMc6Mu12Nx0xgmF0BfB19IDfuaQf9kmeMTdWe0S8MEhbjaR7VG2yf
 oxPymId05ToYDz2KwQzdqfdCspr0UTzjYcMBfaIDBxkLiFgjgUt5KcUpWZhwEDpHmkvR3ANKAnT
 T
X-Google-Smtp-Source: AGHT+IFQUJ8YhisXsdNl5EtPkJioHW2Se39uOjYAvkCcITgSbcPnZtHGg2InKAknilBxO/d0+a2OVw==
X-Received: by 2002:a05:6808:17a2:b0:401:e61b:5f76 with SMTP id
 5614622812f47-403698b6dd0mr425155b6e.33.1746488133684; 
 Mon, 05 May 2025 16:35:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: mkorpershoek@kernel.org, anshuld@ti.com, upstream@lists.phytec.de
In-Reply-To: <20250429120818.3365069-1-d.schultz@phytec.de>
References: <20250429120818.3365069-1-d.schultz@phytec.de>
Subject: Re: [PATCH] configs: phycore_am62x_a53_defconfig: Remove
 CONFIG_SYS_BOOTM_LEN
Message-Id: <174648813249.69658.14084767046473031103.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 29 Apr 2025 05:08:18 -0700, Daniel Schultz wrote:

> This config was defined with the default value of 8 MiB. However,
> the default value is different when CONFIG_ARM64 is enabled and
> should be 64 MiB.
> 
> Remove this config from the A53 defconfig and use the correct
> default config.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: phycore_am62x_a53_defconfig: Remove CONFIG_SYS_BOOTM_LEN
      commit: 1750ba44d573b9e7de3b2b24205cc80ba5872292
-- 
Tom


