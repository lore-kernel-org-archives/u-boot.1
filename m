Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7821CCAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58EC3833D1;
	Thu, 11 Sep 2025 19:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K4GV+rS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78CA833C6; Thu, 11 Sep 2025 19:12:36 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A01383390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-30ccea8a199so768778fac.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757610753; x=1758215553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08AQ54ugUw5tbT7+hCeM6FcxgMOOGaljwYKZrqSse6c=;
 b=K4GV+rS96QDomGoNROwG9DyGB1E/2s39O7UWKT8i4bDbz37ivIsAVB92Oytz2mjtuH
 lyye8M/AlSq6MVqREqjV5TvFxo9MR9o+AkhxTae6zH3/dc3h7M5HKeDCfl+oocpDtPVe
 2POP4FqA1aIFw/hUq4Rjn/3BbuKXagEP99oyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757610753; x=1758215553;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08AQ54ugUw5tbT7+hCeM6FcxgMOOGaljwYKZrqSse6c=;
 b=doPEg/D6BAFvQ1iXz8lprppcMYNT6sBIWM+dk0yR53CwPxoqyd65vJxzhSuC11WCyP
 GMKryKe8K7iM4A7ynx9GNuBh1MZUq0tp6VJjPmvDnLlZ36f0Hm6blQdNjdgLX3A+bhdG
 eEKpAymfvzZrtfeCQJ0tv4TbatEedQQgRo8b8WrxmecmW8UGyYWZIjU0wbQE8gVFseGj
 cVS8ylhMd1M8NKiSQOPvYOuN8lQI/PXcf2Fjs0qYvbq31mxO+2aL0KXLhBIVr2um8gso
 FiLxlkcWWrk45NMgkI/6toLMzT9kEt5yWmUaKdXPWh5p998bZYlFYLgvwxmyUXMyhljC
 tJ9w==
X-Gm-Message-State: AOJu0Ywln+dmWO/yEz8BW3D+nAsiOdJIOagU0Rx2QaonB/Nh3FE74pOH
 XsTjH1ksJojYv6JK1g/0J1M6sPUCKtx+ho24zj1Px7NuyROxemTLBGzJvJRBDfCtMks=
X-Gm-Gg: ASbGncvT1COQ7cr9mmd9nDeduCQ8fPU1Z/lwJVQlIjTPaE3n5OBtnMOu7qsm8hkPQ2J
 8/wdsIKCJM2OHBXdi0fkIy4XIGllSEOmkwcE4njGB5WsiLKvAxKohts4GfkWecTOvhQllar5Ih5
 1CIDlnfbrj0U44EeHmhDbBpAsVXrUru8mzZMmTmi8yJacb9hVBi1MIhdbnC3LwBA3i3CHjnUC1L
 6dP8QILix18volua7kSZJYBMURARHJBDBfmqxpzNIQwXXVrBfw9DRHI/5BDjPLby1AhLHYoAzTj
 TatqLV4Y0LieFRHIrmZ7CCYDNyt3Ft6wwNTXM8Nb7odCPDHB7/yLyIV3POpdUeJyXFWeadiGIzm
 jflw9K+LedRRo+Ry8G3/pbB8chcbjiBSSyNH06e7ndVR6EaCxV8DnuD7ZkDLWXptk6g==
X-Google-Smtp-Source: AGHT+IFbtErm2pOJL/nYA5Z6EYYjubrS2gGjXS+XfT4tlLxtbp+8N9txUcbuSIJ3fNvEg/iGk6g6tw==
X-Received: by 2002:a05:6870:8088:b0:30b:904b:c76d with SMTP id
 586e51a60fabf-32264c1b7bcmr11373156fac.29.1757610753065; 
 Thu, 11 Sep 2025 10:12:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d33454175sm539312fac.10.2025.09.11.10.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:12:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, u-kumar1@ti.com, p-mantena@ti.com
In-Reply-To: <20250903115207.572304-1-anshuld@ti.com>
References: <20250903115207.572304-1-anshuld@ti.com>
Subject: Re: [PATCH v3 0/2] Fix dma_addr_t for R5 SPL
Message-Id: <175761075183.2771962.263662742609919573.b4-ty@konsulko.com>
Date: Thu, 11 Sep 2025 11:12:31 -0600
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

On Wed, 03 Sep 2025 17:22:04 +0530, Anshul Dalal wrote:

> On various TI's K3 platforms boot failure was observed on SPI NOR since the
> commit 5609f200d062 ("arm: Kconfig: enable LTO for ARCH_K3"). This issue was
> root caused to stack corruption by the 'udma_transfer' function. Where the local
> variable 'paddr' of type 'dma_addr_t' was being written to as a 64-bit value
> which overwrote the stack frame of the caller (dma_memcpy) as only 32-bits had
> been reserved for paddr on the stack, specifically the r4 register in the frame
> of dma_memcpy was being overwritten with a 0.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
      commit: e9e55fefb1ec3e1d2525ef69655914c17e913c4c
[2/2] config: arch: k3: enable DMA_ADDR_T_64BIT
      commit: 7bcc604ef80244ac45d8112b823ceff21af61e39
-- 
Tom


