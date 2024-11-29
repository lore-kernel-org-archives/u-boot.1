Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C40D6EC0B
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 13:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D86189338;
	Fri, 29 Nov 2024 14:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EIVbn2ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9D089338; Fri, 29 Nov 2024 14:46:20 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36A5891B0
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 14:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4349fd77b33so17152525e9.2
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 05:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732887977; x=1733492777; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfK5VAYatvGWtuJ5L78ya1rK/EcMsgemUCyFztEdx/4=;
 b=EIVbn2tssfsTEkWBftuQ2yE3bLOz7tGDYtO6ByxYEquL8nt3tUAJpVy0+Q+NJPYwLJ
 hhZWq9P0b28ePJUhlLBiam8y8TKrnxD/sVP83xwqCy+WS1ZIH4I78xcIgKSccqtz4fBQ
 Y4H0AnjIYLOGMDJbUK9kxZXNpLQ0Lp8ym7SDFeZBN3KC7iUW8TzfGrD3n3QIU8+rmZem
 uHv0MlsbT6x1yn5vwd+iNVEdGWbjjmmzPlwAvjxdlS0m1Vl2CSvRzL3WGr4sFjI5T0os
 jeI6WP3EvW+XDfrhr1iHQqOg2dfvau3jk+ioID/UES08O3WG1GoG2MrCJESkenBcRrNr
 5WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732887977; x=1733492777;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HfK5VAYatvGWtuJ5L78ya1rK/EcMsgemUCyFztEdx/4=;
 b=BKNx3NU9JEsV6vNRwD68BrTrVxPrJzFJ7ENLE0y/D7d3ds5Dk1Sim3FFfoiabJX2Bx
 CxBul2jTG5bjOdz1HRCAycPAggYDbrVj9sxQ/2PTZ1/szcXavpdozPPYXGSHe/xeIaPQ
 6dzMdZeeg9jO6uiQPVug3USz/CkuPSQ2IPtv0J+K1kGPnq6mifODPSsrysTEmiAopKM8
 SVJd1NIQHaOQ3fGec0eEBcVaFUPT9VFTBZ8ulvrJ7IAPgleSs0WbU8ENqJPY4MYKRuyu
 GXM04o0VnIYLuUIjgRLcoPwB0rddZD4Gzj6hn3cULNMgcENpVysX8QWg0nytCPvd54I4
 riJw==
X-Gm-Message-State: AOJu0YwUtuZGZxx4Gi/xrysvuz2ZTYW8/WxCDQJxE7GA1MfIRFqYbIfF
 FocgOzAjrTAdfii7ZmHJHlCRxQo0vc4Ib/N0CDbWECbLtXTvCkO+0Ld/nBGcLHWKmytrIOmUO6A
 JKE4=
X-Gm-Gg: ASbGncsOztgHc3Pskk9yq44TZeuFLU+zKYvEEYYeNNsI9FXgQlhvdRYpRHMorsvRt1Z
 5eSAbC04XT1XR6EcUGsTV8TbIoOeoKBRoJ8tO7btaujsOJa4xDdgQmRnLfeajz9I+oRxGaGT7Bf
 AAU7qehL15/bIt3MrfUGzU3KMBuZtW8HNYMlPru4ACYBJwqzHk3HZ3Tea4a+xXPDRblZ6XXFw3M
 Me0GGo2JZBqff6Yx5YwXPkq/HoYzvtty2VA60S+ZDzysySf36wyzjewGFY=
X-Google-Smtp-Source: AGHT+IFgbL9+C7GpY+Dh/bmfKGnej6Cu+QlGH6MC8MPjjNGuPzqgGUjHPHSHdgUPv2zrGQsAX6EyLw==
X-Received: by 2002:a05:600c:4750:b0:431:60d0:9088 with SMTP id
 5b1f17b1804b1-434a9dc5241mr110478695e9.13.1732887977052; 
 Fri, 29 Nov 2024 05:46:17 -0800 (PST)
Received: from [192.168.0.190] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74f18bsm87305195e9.4.2024.11.29.05.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 05:46:16 -0800 (PST)
Message-ID: <9c200bc9-e481-4c2f-a4f0-2ef594c2a512@linaro.org>
Date: Fri, 29 Nov 2024 15:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PULL next] u-boot-at91-2025.04-a
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

Please pull tag u-boot-at91-2025.04-a , the first set of features and
fixes for the next 2025.04 cycle.

This feature set includes the at91 gpio driver function alternate mode
for pins, and some fixes.

Thanks,
Eugen


The following changes since commit 62224280d9e89648ae90346c0aede76f9b7e7610:

  Merge tag 'u-boot-dfu-next-20241126' of
https://source.denx.de/u-boot/custodians/u-boot-dfu into next
(2024-11-26 10:50:05 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-2025.04-a

for you to fetch changes up to bf424a110dc6180b65e6cdf05897428ca7cac98d:

  mtd: nand: raw: atmel: Remove redundant PMECC probe (2024-11-29
12:59:27 +0200)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2025.04 cycle

----------------------------------------------------------------
Alexander Dahl (1):
      mtd: nand: raw: atmel: Remove redundant PMECC probe

Benedikt Spranger (2):
      tiny-printf: Handle NULL pointer argument to %s
      drivers/mtd/ubispl/ubispl.c: Fix error message

Zixun LI (3):
      gpio: at91: Implement GPIOF_FUNC in get_function()
      gpio: at91: Implement ops set_flags
      gpio: at91: Implement ops get_flags

 drivers/gpio/at91_gpio.c                     | 97
+++++++++++++++++++++++++++-
 drivers/mtd/nand/raw/atmel/nand-controller.c |  7 --
 drivers/mtd/nand/raw/atmel/pmecc.c           |  1 +
 drivers/mtd/ubispl/ubispl.c                  |  2 +-
 lib/tiny-printf.c                            |  2 +-
 5 files changed, 99 insertions(+), 10 deletions(-)
