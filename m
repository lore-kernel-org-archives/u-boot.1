Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90979C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 15:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FBB88079;
	Tue,  5 Mar 2024 16:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GvV5Ccu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658A088081; Tue,  5 Mar 2024 16:16:10 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EAD88079
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 16:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5135540c40dso819205e87.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 07:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709651768; x=1710256568; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xk67OwgBJc0dundtRlUoie+jRbCxZqli0P7DB44CUR8=;
 b=GvV5Ccu2z9+hDx+3ETGUxuZlEZ/vmquRfw2ILi1P939Tj4ftZesPIvXX0kEZeYHq4H
 3mISCsF2+Yqpromc15wCMrWqTKr+E0uAKk9wZSyvtkjaQoZDjhKY03PIjaEht597Tupq
 yMxKKdxWtFYNmK2ISnpowZKEAyhuGTf0q0JeRuJFcioi1SIZuwOJKcZe2rK23kn/kfzl
 myoyg9glys27OMePSnd1jryoTexj9SMXxfCPEbJMmrAjAk1xJ4iV5wbq4ptXH9P1ZcCo
 jSE4+c5dWClKlgNxzzgdSnzdW1wNuGQu9kpoVOFwqdSpAGcDXKUuWOyUC6oSXlSRlY2N
 MyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709651768; x=1710256568;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xk67OwgBJc0dundtRlUoie+jRbCxZqli0P7DB44CUR8=;
 b=mLiZX2W53zkm7xyGIjPlYvMU4O91aTZbNwOGMurmyq8ZZezaNn2bSGQgZrXzKRFRfE
 dBpJ5/KJrVJKaZJXaF2CEYoS0l+Mjr1HodQT/gZhNbsOHLV9Up2qGJ7zvUzMrqMh6RlA
 blzouCciROfefM5UbAP10fW0rl11TnLQo3hRToZh179q/dVTv9esED02jsC3mzWBOrb+
 zE7R7nWwJ9YMU0xnOvoRVU34Rt8ZbKajK33Ho93P0gXvUO6iHdyfslLv+fvdjZ6/QJuO
 r4yav0VPRkC8m3e+iUoiqTVLEDExRK2V1b3b2JHFQY74I3YnQW24qrG2hLR2J5ZRItfQ
 +Yhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV9qkcAN1sr71iCc5h34jgob4OWQoj4oIeUl4b/9XRx2sYMJfFOPBSckkdYOfDMKVQN6teCnAC7NAKTYFEjHLt/+47vw==
X-Gm-Message-State: AOJu0Yz7GEVVfq/yJbCqpCebvM0R+VVYo2fhq8M2wv9GCSTzWxjMUdyW
 HqaAi/F4TKIkEzcZKTLyC8xaeYk/Q01gfUqzTu8ZQgb9e/AvXjrarAbs9YihR8w=
X-Google-Smtp-Source: AGHT+IEHr/UOE+lFiQpI1Pp69rgLZUQ8Sc2QWVfSBTN/BQaMRZnzYvvzAlNcjJCZ9GQJ5v6jUG27zw==
X-Received: by 2002:a05:6512:546:b0:513:1ff9:2bb4 with SMTP id
 h6-20020a056512054600b005131ff92bb4mr1593650lfl.30.1709651767682; 
 Tue, 05 Mar 2024 07:16:07 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 j12-20020adfea4c000000b0033e11bd9febsm14744075wrn.90.2024.03.05.07.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 07:16:07 -0800 (PST)
Date: Tue, 5 Mar 2024 18:16:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Subject: [PATCH 0/2] Select CONFIG_64BIT for sandbox64 and x86_64
Message-ID: <c1a59f6a-ef74-4774-8319-983b1508927a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I had previously set CONFIG_64BIT for arm64.  This patchset does the
same thing for sandbox64 and x86_64.  (Mips and riscv were already
doing it).  This CONFIG option is used in the Makefile to determine
if it's a 32 or 64 bit system for the CHECKER.

Makefile
  1052  # the checker needs the correct machine size
  1053  CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)

Dan Carpenter (2):
  sandbox: select CONFIG_64BIT for SANDBOX64
  sandbox: select CONFIG_64BIT for X86_64

 arch/sandbox/Kconfig | 1 +
 arch/x86/Kconfig     | 1 +
 2 files changed, 2 insertions(+)

-- 
2.43.0

