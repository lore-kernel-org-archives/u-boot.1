Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAF3C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9EBF83118;
	Tue, 15 Jul 2025 19:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JRhYwTaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673D483102; Tue, 15 Jul 2025 19:20:29 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A7E830B6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6159d8a10fbso210345eaf.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752600026; x=1753204826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RE/AmliIgASqaZUV+Q87jfrniqtz2z48Clc5mT3KysI=;
 b=JRhYwTaFDguZxDSOpN7yqyzxqbfk38qZdAgnlz4wPQEtlKw5PLSzeC4QBKQ0Gvvo1N
 Lh4PNrGpPZzyOJ98C4eYOKvcKlSPxW9P/+l6z9EgV5P/mCYrSQRu0UZmglFCmgvjC3Dv
 a6yiiU+6lUNYV7dXwksXyl8DfCwGnFdCBO0xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600026; x=1753204826;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RE/AmliIgASqaZUV+Q87jfrniqtz2z48Clc5mT3KysI=;
 b=i7m4aW9MHYDf6fHIE5Mh4OcTrO3IAcn7TKKVpiUUNWRRsRgf9eo7jCR1ck3wMClHmF
 Xx/7Fv8q9FwCCJ94IkAWHToixI2jkCmAJ319Bg2IdibFdSjs85aL0PUScFYdm89mu8QW
 WS4J/+f/SpqftFIYhYhS41ldGQfkkuAqZs1oWxC36hVdKcTW1wpzpDu6ebiQ+YX0HFQQ
 Vj6/Bwft9GY2YcP0gwYNM5rw1VsZCeVXh9dRwY8uZ7ngsD6iqflYHPe4nAiUr6fGN2Hl
 vda4fJs+VL3h5p5zCIDGpNIGiEZffkOSYy9sC3uvPZafM1uMbgYQVDMCA8gPqds9k7cA
 Qavw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3DDorXFveiUAG5k0VuoImkcT7vFFlWE7NW0jvAKWT/O4Rgz4nF7GJ/HdHw0MNkqLIA4Auq0U=@lists.denx.de
X-Gm-Message-State: AOJu0YyTjQkEgDXZ481lKGtGq8u0idoocCvtYr8+0dedXYuxCggiPY+L
 RxOlRswmUDMzlXbW6/+0Y2G6wchYEowVnRuTNoYQriURego4BeuJwb1JG2z9PPya/V8=
X-Gm-Gg: ASbGncur4OJQlfKz8Pa/wQqXSISm/lGjf5JJpeR+u7+Uaqoi87+LhMFdUOJVrzze3xZ
 R8dwQu/R8IOV1PfQe/n6zUiYGGm2IMaOI3PHJk2Cjm4pXZolYJZ9RfpQvyuYcyYY2cHRz43SvOl
 K8uGkOTEUexfR4r54Q1ZaldTyPdBTCkpd+ex+GHDtysg8OZ2Sve3QSomfuJpOFJH36GDEIUp67t
 42DASqZ/sCfKvkhmbIgDXGUGLN+OvOSEsaP8Db5cwqVgPF4RW1p/b5kcVmGq4GlE3xrvZYgLvOE
 oMR9U5ml5ZFtU4D3VAHDb4is0ZHesWf/R9e5Il6tLZ0MmJRMPHLBaC5qSP96S7/EbJEQ0g2J1HN
 EcDuVpDMCRTxOBZFzF8GzDf6soRPpT4GKL2YCWRHC/n4iKHaAFhgTzE8=
X-Google-Smtp-Source: AGHT+IE6xdwlUSBi3j0ZpdKitwjGsexIsD0AdpOcn458nXLx5D9CWYzD+TqpyLQltt/W2EraweQItA==
X-Received: by 2002:a05:6820:270d:b0:613:84b1:c4c1 with SMTP id
 006d021491bc7-6159feeadeamr95561eaf.5.1752600025976; 
 Tue, 15 Jul 2025 10:20:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6142b0961fbsm988894eaf.35.2025.07.15.10.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 10:20:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH RESEND v4 0/4] drivers/net/airoha_eth: fixes
Message-Id: <175260002516.441891.7505452267182704364.b4-ty@konsulko.com>
Date: Tue, 15 Jul 2025 11:20:25 -0600
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

On Wed, 09 Jul 2025 12:28:06 +0300, Mikhail Kshevetskiy wrote:

> several fixes for airoha ethernet driver
> 
> Changes v2:
>  * update patches description
>  * improve formatting a bit
> 
> Changes v3:
>  * national letters were replaced with the corresponding english letters
>  * code was tested on 32-bit and 64-bit airoha boards both
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] drivers/net/airoha_eth: add missing terminator for compatible devices list
      commit: 189d0b4477077f0445772d7899d8bd0a17e1f67a
[2/4] drivers/net/airoha_eth: fix packet transmission errors
      commit: 5d49fa9e56bb0e0b085f5c794ba508349385f6b8
[3/4] drivers/net/airoha_eth: fix stalling in package receiving
      commit: 997786bbf473b3567bea5fa7ead21a8a9299c2ee
[4/4] drivers/net/airoha_eth: enable hw padding of short tx packets
      commit: 0e59a2ca9d29da7e87de2089bbeb77cdc9e927b2
-- 
Tom


