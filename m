Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A36CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6870D831D3;
	Wed, 27 Aug 2025 16:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lszOiAQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B23B831B4; Wed, 27 Aug 2025 16:41:08 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8919D831B4
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 16:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7454509f088so207490a34.1
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756305664; x=1756910464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JlPThANqdGD5nIAuQfGc6N1RisI9OWyYyyjS586l8rc=;
 b=lszOiAQ3OIznEb9rjZjxDPqJDs5CF5ws6Wkf5QLo70KWqvKDLoQRXLIaPA1Q55beZ0
 Gt2uODJI2/cPqWJdp0N0pqm3Np4z65B8un4tfbob4CnTvdpqX5aBCZyeYV5yY3sdz+r3
 O44AwSzVPa6d2jfxtVSUmz9ga4Tyj8uWMxVik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756305664; x=1756910464;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlPThANqdGD5nIAuQfGc6N1RisI9OWyYyyjS586l8rc=;
 b=pKqMIwd7StqVgHryqzKsX9/36M8j8hlt0geGhyUOb/V/xCMaEynuk/RH5278xSAsCG
 Ba9Nd4GesD3UtwS7+2NtF2xxyCJQ8q2iiaVMAnJqoFxLZrF1bNnu5QArcWCn6uuPV2P6
 A6sN4zhjS0yEp4ttDAPyXtuAq784I8quog86xZCjjIYGWg+24jA7xdwFf4UTrY7D3k/d
 urrh87hHg62KM3ZcP1shU1Zy7tk/zgCgEwyXMEFwV3ALbL6lOPQkDCic0640gDcf/cmt
 fpsKbf26Sd/GmsjKMz1IxSS8SDRoMWtewK51PxRF4UDCntE76+GwJl3aDL86oiIWWJ4w
 KaNw==
X-Gm-Message-State: AOJu0YypTFuOLWJEHmbAn7S2CJfj2A1OaW2ERWhGFMmIEC9TyhV2zV3X
 kWedzwRScAhqbkqPQ7KP+1zZVOu5h/0Lrk0/gj1qNSHlOIwEwwqK4yRlGSwfP7vaczE=
X-Gm-Gg: ASbGnctJH5SAr21QrKacK+0W4gkHMGefUGVcX+fDyXbrrw1gkyUObJPI7jvx+hYaaAl
 PxywT2xV7y/Fcpsn7vHt6/BgaaOIbA9y1i469v9CXyYOqyCxYC7sXHDg1i0192jdRNsEefl4YMp
 YTmEJmH2sH6nbcmVfEJwmi/5Wfc4prHJS5v2NyuRJVIcafxAG0W5F6qfG4uGYOF864vNBccH7IV
 wLMUwg9a1Vj7ixDEScexaMlhpcr6AmNFScy5mZpVPrhuBjChP/rLy/w8bjluV2Fl2FRo5gceQzx
 N6MT5yX8NP99+3kUT7uUs/YdiJRfb0pzPtTHwJaQEam5bjcrPxKyKq3fhP3ivYUHqCnNjyarokl
 EopfsWfu1ReypZJLB57otlN94vTPhGfD0kCAVXJjE0X4ZfSSNh9ymNR/bs6pj/L1Zww==
X-Google-Smtp-Source: AGHT+IGdYzXQvXq4htjaoCgtahjE5gnQ4plHT1LVqPRYwXcFc+f+c9cR7U4Ex1+/KEEg6Spfd0GsLQ==
X-Received: by 2002:a05:6830:3787:b0:744:f113:fef4 with SMTP id
 46e09a7af769-74500b6b416mr11088997a34.31.1756305664035; 
 Wed, 27 Aug 2025 07:41:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e11af87sm3029411a34.0.2025.08.27.07.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:41:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250826073510.357157-1-ilias.apalodimas@linaro.org>
References: <20250826073510.357157-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-next-25082025
Message-Id: <175630566287.642307.17685377148033215512.b4-ty@konsulko.com>
Date: Wed, 27 Aug 2025 08:41:02 -0600
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

On Tue, 26 Aug 2025 10:35:10 +0300, Ilias Apalodimas wrote:

> The following changes since commit 51214ffcc543dde83ad687c35cb2de61a34e0602:
> 
>   qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT (2025-08-21 13:27:59 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-25082025
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


