Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F341C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 07:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9291682D06;
	Tue, 29 Jul 2025 09:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yJRq7l7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3BD82D21; Tue, 29 Jul 2025 09:42:25 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA9B829E7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-af0dc229478so749164266b.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753774942; x=1754379742; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpufK/4mvmBNNOaVLviVeyudcHq8obHmiOuqwk9DSeE=;
 b=yJRq7l7mc2OWhDEl45g7wkB2k9D9LPLUAjB6VAwLeELxsmT8rWXqWgRh5KtLayWnaN
 kh8tQ4IZolXgsqfYQHROqVmRAMAXsq7fqXrzn5FKGq/mIiMNWK9LSgVaCvKd4fCp4ghB
 Gdwk7yckyOqFH8iIQCB9wFS2yQaSOV/AyNLGfIwV/ud4TxOZJ87+AKNIJUScMmhV9DXn
 lojxu68isEtVyYqi1S0GW6dApuyOPLiguh0D54t6m39mreS2GPQE746Ys8vYwr3qtxay
 yxQi1IMRIv/FQRI5XkJ37KsgZLuMRXyOM6TSVi+OPAJ2ZNZrrME/OuNKRlTZrw8pT3Oj
 9NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753774942; x=1754379742;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dpufK/4mvmBNNOaVLviVeyudcHq8obHmiOuqwk9DSeE=;
 b=VG3SEd+6k86U6a/3wb+xUWYOTgHC7L+ogX+i5n5OQ5DtC3wySIqsp9nPa2Ko43cmYS
 J19++/TPUjtVQ6DhpL1ykTNy0fum9Zf1SYikHpxX4TzCNgU0qC+rpuNeNwpc539hCpAP
 2hUvqud3HNc0b+OZ3yD21X3mHizJucZmz0AsXeJLVjBVElkeMcSJxWvOrMaJJRvnu8vf
 A0nOGQJc3OEs0DLsLTHNhssYJpa6Td0tRU8Oo++POgsS/YfW0GQcqrmI833PQTDaAvK2
 4egCtsAWHi6NKrIOzooZYRIMhZpIouYVlxk+RScfn175+TvNThwUD/pD7zY6v5zdfEbs
 jIkg==
X-Gm-Message-State: AOJu0YxSG2bKMdCfjwDFjCaPtkaF5HAgmafSOHQZ8cIy4QPvmepBLrwP
 UjPz3DziUs8AjAcxocXJcCfp+ERFICUye6cWG5BMqjk4/8m+yKiaM/gpthb/8lMSslKRChvyGUS
 rzV9e0eJNE6xh
X-Gm-Gg: ASbGncs90NQU1CDFPuXiQBJJCxGf2EWHKJqCC4rvsSQUJ9F9sOwqrFQfmGE1/IR+qoI
 eks4o/TIyWFlUNtxbIUkoat31MDGOvUohIwE58k3/7rwv13t/wjmkG+jAK/2bFb4o2+yFmI3vub
 BrvMvPMjJQ1ktsj9ojxWsn2G4VyhIKngAYeoZknbE44p0s0DBaoivk9JRfKOp7Z5p4xiQkC7Ad+
 lU0FpXtEjWPYBS+uRp/awucL+81fjT/HHNeB5z5SA5zJCG+KdHLhEuZ566PYS2dCGmy9l495liW
 u2Qn9tWyG6nLiirw4ldhQ+46OkVdsDtdYuF45NUohYb61rnMxlFkXRxOf53qiWshH/mGLlyXt4s
 c36cj4l8Co4b6kGibGzEA8ILAwpfcJFu0gzvd
X-Google-Smtp-Source: AGHT+IH+vusbzy/2NGhFpZ5Avf/vlMVchH+a6uJShPmIzzqHLjVkSgOz9Ykqvh4q3Vau1eX8ezDWsQ==
X-Received: by 2002:a17:907:948d:b0:ae3:6744:3680 with SMTP id
 a640c23a62f3a-af61e43b5ddmr1693207866b.42.1753774938743; 
 Tue, 29 Jul 2025 00:42:18 -0700 (PDT)
Received: from [192.168.91.100] ([185.132.172.209])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af63589fe4asm549732666b.41.2025.07.29.00.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 00:42:18 -0700 (PDT)
Message-ID: <26a13b67-9c3f-4206-9af9-49fac4a80d07@linaro.org>
Date: Tue, 29 Jul 2025 10:42:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-2025.10-b
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

Please pull tag u-boot-at91-2025.10-b , the second set of at91 features
and fixes for the next 2025.10 cycle.

This feature set includes the addition of new sama7d65 SoC and a new
board named sama7d65-curiosity.

Thanks,
Eugen


The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc669:

  block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-2025.10-b

for you to fetch changes up to ecbe341012f8c9b989daa61309b1c16d2b7298a7:

  configs: sama7d65_curiosity: Add defconfig for sama7d65_curiosity
(2025-07-25 11:54:43 +0300)

----------------------------------------------------------------
Second set of u-boot-at91 features for the 2025.10 cycle

----------------------------------------------------------------
Ryan Wanner (6):
      clk: at91: Update MAX PLL and master clk ID
      clk: at91: sama7d65: add clock support
      ARM: mach-at91: add support for new SoC sama7d65
      ARM: dts: at91: sama7d65-curiosity: Add DT tweaks for
sama7d65-curiosity board
      board: sama7d65_curiosity: Add support for sama7d65_curiosity
      configs: sama7d65_curiosity: Add defconfig for sama7d65_curiosity

 arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi   |   80 ++
 arch/arm/mach-at91/Kconfig                         |   13 +
 arch/arm/mach-at91/armv7/Makefile                  |    1 +
 arch/arm/mach-at91/armv7/sama7d65_devices.c        |   31 +
 arch/arm/mach-at91/include/mach/hardware.h         |    2 +
 arch/arm/mach-at91/include/mach/sama7d65.h         |  107 ++
 board/atmel/sama7d65_curiosity/Kconfig             |   15 +
 board/atmel/sama7d65_curiosity/MAINTAINERS         |    6 +
 board/atmel/sama7d65_curiosity/Makefile            |    7 +
 .../atmel/sama7d65_curiosity/sama7d65_curiosity.c  |   75 +
 configs/sama7d65_curiosity_mmc1_defconfig          |  108 ++
 drivers/clk/at91/Makefile                          |    1 +
 drivers/clk/at91/clk-master.c                      |    2 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |    2 +-
 drivers/clk/at91/sama7d65.c                        | 1451
++++++++++++++++++++
 include/configs/sama7d65_curiosity.h               |   20 +
 16 files changed, 1919 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/at91-sama7d65_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/mach-at91/armv7/sama7d65_devices.c
 create mode 100644 arch/arm/mach-at91/include/mach/sama7d65.h
 create mode 100644 board/atmel/sama7d65_curiosity/Kconfig
 create mode 100644 board/atmel/sama7d65_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sama7d65_curiosity/Makefile
 create mode 100644 board/atmel/sama7d65_curiosity/sama7d65_curiosity.c
 create mode 100644 configs/sama7d65_curiosity_mmc1_defconfig
 create mode 100644 drivers/clk/at91/sama7d65.c
 create mode 100644 include/configs/sama7d65_curiosity.h
