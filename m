Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5B5CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385A9831C5;
	Wed, 27 Aug 2025 16:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PuKmUOlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DEC83236; Wed, 27 Aug 2025 16:41:11 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0505E831B4
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 16:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74381fbd6f3so1599550a34.2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756305668; x=1756910468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdNd54wOtdiYIuKfzkR4h1bEdv3hp+6cnX3cTbbGrRU=;
 b=PuKmUOlEcHzcbyQFw24zJGGDNsSzexYBBr8Tq3cbtexGFDfRtZLo4uyP1ewApiYnjq
 dKG2pYooLs5j3Olbcw3/FB79GzlpL1BYKatL1i2byfINRfv6rOd338tjmOwqPRGx3w1Y
 BB3IWr7MjyrKw0rwnF85k4ed2gJhkjCIq5tDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756305668; x=1756910468;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdNd54wOtdiYIuKfzkR4h1bEdv3hp+6cnX3cTbbGrRU=;
 b=SP9CwAkYfhHlZs/uHIsQzDWLXKgzJqrOEbFck/lVeLtSybsPC8nG7srT1+9L+iOHJE
 LIpEmJoYcTHr8D9mghUGs99Ejc7LA+QBR5wm8do4bpl1UMp+quEZotnTS+FVcap4k/Mi
 OWNQSS/YDyccqIjwzdRT8gW5iZKqEWEsetOterb5FwktwnrIPFEZIqvGLrgdCOQusPI8
 qsoxEtLiwF3csFoejHZ5n5YW9tyA1Sf+Rc+eGpUT+5u+0uiDND0G4X/6Y5Vwc50ebVBD
 3WD68ABgoeX9OZ+NeYpNfzXOjeMKusU7qxgOY5fYIGm78QxdPTo6INPuRbqQFUtNKQ+C
 jVmg==
X-Gm-Message-State: AOJu0YxkcIHQFQKDvVu02S2+ilxr9C+mifo457NjKSYGlG2tkcZYuqyD
 jQbpHpuj9MGWX7sh5/REFpnJ8Z29KIbYniRj2Ybvz1vklr+PpHdpa95z0saAsamW15mDsyPx4sR
 W5kxOCwU=
X-Gm-Gg: ASbGnctDqpIJSl/LQf/Gn+LrhmcrRz4HWIQ9MKGh8Pet0WiNhWGv1cWrkXpLISGFl2S
 GnMGRTLoCKx1gBPkUuPxkU6nSXKaLbxzCB26NbhQQgS4shLyhQTDmAiCFs8goyJJgk6P1b1uLnD
 rx9x5xrSQvDcQ4b3t/X6Ie+jPgeTC1cmJEiGR/TMRtZXsXIRNLpj0g8F89MJDpjVu4oyNj8D4gL
 2ESSK7lHloyWyMQaobSZbZ0tMyN1CmHOtIzNpcPMfr4jGu9oCLL9kCtwavNQm9ATsSzq/bwo998
 fJgAzkpjnuPoMgePohaKIC+E51FGHtLGr6ydeTV/WTeFhGvSS5YUq+FfytO/WMiE3w4nUdsCo07
 IXo+D4AOCJ7IWRZdEs06Ayf5DcjjYqyIeFFAx5W2v4d5L5L7Fx+BFyqUaIYBK9iXcPg==
X-Google-Smtp-Source: AGHT+IEbSYMC0iI4eL3JavyoZ3L85hTCVyRdIIFTiWgLlKxTGuGX3vIsv5fBcUuwjtRSyEiVE5pp8Q==
X-Received: by 2002:a05:6830:368e:b0:744:f112:e537 with SMTP id
 46e09a7af769-74500aface3mr9497390a34.30.1756305667724; 
 Wed, 27 Aug 2025 07:41:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e11af87sm3029411a34.0.2025.08.27.07.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:41:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: d.schultz@phytec.de, ggiordano@phytec.com, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20250815111051.2277173-1-w.egorov@phytec.de>
References: <20250815111051.2277173-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/4] Update SoM detection related code and configs
Message-Id: <175630566670.642307.6688071913577019152.b4-ty@konsulko.com>
Date: Wed, 27 Aug 2025 08:41:06 -0600
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

On Fri, 15 Aug 2025 13:10:47 +0200, Wadim Egorov wrote:

> Update Kconfig options for phyCORE-AM62Ax to align with other boards and
> prepare common board code for the upcoming phyCORE-AM62L which has the
> SoM EEPROM connected on a different bus.
> 
> Dominik Haller (2):
>   board: phytec: common: Add PHYTEC_EEPROM_BUS to Kconfig
>   board: phytec: common: k3: Use CONFIG_PHYTEC_EEPROM_BUS
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] board: phytec: common: Add PHYTEC_EEPROM_BUS to Kconfig
      commit: 88a1816a9b4ef6a202a832c7f59099ddae903e6b
[2/4] board: phytec: common: k3: Use CONFIG_PHYTEC_EEPROM_BUS
      commit: 437f663e6c35bb210a115bbbd295efbd9d9c54a1
[3/4] board: phytec: phycore-am62a: Update SoM detection Kconfig options
      commit: 9cf4f522fc96e29df4ab23f5bcbbbe432ae32237
[4/4] configs: phycore_am62ax_a53_defconfig: Resync after savedefconfig
      commit: 7e86c8f1dc1dceb50294902f95b3ecf21f8af687
-- 
Tom


