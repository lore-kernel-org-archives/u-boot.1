Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E12D116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 15:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B54883E86;
	Tue,  2 Dec 2025 16:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PfEayMkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B7A83E86; Tue,  2 Dec 2025 16:30:14 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4215E83BFE
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 16:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso33553465e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764689409; x=1765294209; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umGoDU1xUTQResfsYDwL/DhYDi74odQ7uQiGBuQB4Lw=;
 b=PfEayMkkIJ7CYywjsyOwRb2+fULOLgUlBaQfvjMBwkwTRtRYBWeu9hzPoYx/ByPaxk
 4IFwOL7IpUgC5XGQKvgmnzR8ghH1nQuxiF2Wl8L8J3oNC/sMisSe2QQ3wT0lUpGbOOae
 d3RDeJ7IyhSztK6uucR82f4jBvcNq2K0T39m4dYDziy5HGBabD0CX0A9B8Q5XMeKBZ2k
 p+2H46kb8Pg7/ph6oOi2pM8VTJUErBd5Q5KrWkXm8dtwz1D/ZZ1yfG59ev/3BW8Li2Aw
 +EMkY2m8YurvKXUZkSkHg/n5bOQtWuv74t7baYcAN94vV3u2WIDRiHrsd5Fj8SXuZSzw
 Nzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764689409; x=1765294209;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=umGoDU1xUTQResfsYDwL/DhYDi74odQ7uQiGBuQB4Lw=;
 b=CChuBjubn6N0mYQjXoqZtgAJ8oaPlnk+dW53O17NAmvJKk1fK+7/+rw4M4RFQ83YYm
 UcqUhqmK3NbDYQX9Ke1eQFMKd6PDL6HH/7NK6xFT6emjZ08CYSrPG8dUHPZB45NRjRh8
 ad7BbVZHS0u46JWJU4wr8wqLT0c5Cl+f2q43c/gw/PhuRUUVtxhEsQxF1fKc+mTcZk1D
 TI5V26qmO4ozimaBORMMjfGdgqPZXKvIVGrUiCvd6vlgxif7mAzN40Bp7VE/aRneUSXC
 mxhJwYEpz3BRCUkhupL4dWuryIDJ6an59leGuasxMImPk2qMgCtSWHfcWjijN8bJKKoy
 rBqQ==
X-Gm-Message-State: AOJu0YxVzRVF3XCMN6gFOcaW4uLtTPqPf83/S9ZEmSeKQJksnHFY0V/A
 kZb3Qbu5ifo/5QQ52NMcSfzNWM7ms8unZEc+abVhTQoS/r9WjsaBVUODN594Ty4tpG8=
X-Gm-Gg: ASbGncu2NSvFlZ75k0cXrq2lRUBxnROGoM0DPvkTOpf8rikBejQyh6eLo6urtkn2xrF
 i2GbIEj3weMjMP2ONu7SA8ya/bh+WB1IF8ww6Qcmz96peE7K1+bN9HeKLTZfu/omphhGxAiln/7
 38TtSbekeBHbzT3g0KsQ7F4nW1WqJ2jMfcGfp/QQMjbnPBW7HUHmILN9YTxUK9yKdN1vuR/ov6v
 S2ehZkLi9dSEEmxX3mRAMdGLh0ah8nx2gxWpf19HwKoESnyiP4/FpTMPhSVx4IYmtfNH/eu6N26
 vavJsjJzeePAaJFTfZ6Mo9P7eYX9sXf1/2KxWEVw7zv0euHxMsF9BP6zrG12otwsSN3IuSh8q+K
 JnuXbMtNc1sp3PbhyuPIKPr0ncmtjHhgkWkkcs+CvXrVYwpOIcoDNqHe+HEJXn9hHD1jHBpgJAg
 49SLvcLVqzeHmCbCjU
X-Google-Smtp-Source: AGHT+IFVvZ0dBmoPVniZAv5j9kY84o5s06ZQMtAF909UEyZ0HxkhFOngnwRX6As++wFIKkdzvLmNhg==
X-Received: by 2002:a05:600c:3b86:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-477c10c8038mr429888275e9.5.1764689409476; 
 Tue, 02 Dec 2025 07:30:09 -0800 (PST)
Received: from [192.168.1.221] ([5.31.29.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4791164ceecsm312239745e9.14.2025.12.02.07.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 07:30:09 -0800 (PST)
Message-ID: <df70d986-6bee-4f90-a146-85388114753c@linaro.org>
Date: Tue, 2 Dec 2025 17:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-fixes-2026.01-a
Content-Type: text/plain; charset=UTF-8
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


Hello Tom,

Please pull tag u-boot-at91-fixes-2026.01-a , the first set of at91
fixes for the 2026.01 cycle.

This small fixes set includes a fix on the mtd pmecc driver.

Thanks,
Eugen


The following changes since commit b10c055d4e1b5153a331a61ef82a5b01b5bb4c45:

  Merge patch series "boot: Support priority for global bootmeths"
(2025-10-22 16:16:31 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-fixes-2026.01-a

for you to fetch changes up to ba7721badf08a1e52d8f76b406c52070d2aa9320:

  mtd: rawnand: atmel: atmel_pmecc_create: Remove unused code
(2025-11-21 10:36:11 +0200)

----------------------------------------------------------------
First set of u-boot-at91 fixes for the 2026.01 cycle

----------------------------------------------------------------
Zixun LI (2):
      mtd: rawnand: atmel: set pmecc data setup time
      mtd: rawnand: atmel: atmel_pmecc_create: Remove unused code

 drivers/mtd/nand/raw/atmel/pmecc.c | 11 +++++++----
 drivers/mtd/nand/raw/atmel/pmecc.h |  1 -
 2 files changed, 7 insertions(+), 5 deletions(-)
