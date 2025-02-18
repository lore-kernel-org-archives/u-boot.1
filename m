Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DF3C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7F2807F1;
	Tue, 18 Feb 2025 13:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XWS//Pey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7920809A4; Tue, 18 Feb 2025 13:40:07 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176D0807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso8152489a12.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 04:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739882404; x=1740487204; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVMykBbrUlM9RmGkPnM/btUUAc8M108m8VEXmGa+rlk=;
 b=XWS//PeyTdW0N0CznJIoxV5w595517PsDuxCZyTioXtTaE2ibVxn6v0CAvZCBCeqaF
 TIFWtzezF4eOpM6Dzqtckr51tMwKa3YHtg2yfMhCtE5AHNPXy8v+DE8UE0UhaNSFkq3g
 lGIBHxdyde8g4C+D1U/m2o1PKUy82OHxZt1wShjZbae72nKSMAi1twYlfQeW2RRqhGOH
 Ml7tNLjVqycqqMdvn6hvC+ufNSlyakR4bih1q11m17tYz0t+NgH7WndH+4JVs9GC1ita
 veCpcZuPA/bS3JBN/zS8GZmTsN+YqbuKSMqGa4HQ4NAcmQwkqvLcgsLNtmLJ9GbZHy0B
 Qruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739882404; x=1740487204;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eVMykBbrUlM9RmGkPnM/btUUAc8M108m8VEXmGa+rlk=;
 b=ddotnO6wWJWBZmvlW6Z5p7OrDIuE7xClkUuBltDXNSdX51cgBVd00HBQOigSl/BHyt
 haQRyZnI4OrweNe8gu6XVB9wK1Q0CICpk0uq4OP65SvbwYPHZYIy6xfN+wq4+b4cfvLF
 se5xAWaxu1hqOG134oStN6p5zIznLzcLFEFF1z72vabvP6Z8hoQ1s4TYFHXwmJyW9pWu
 HuuuRtq6fw3IuSNQKIRUH8oURGw9YMT9QCyy1D8H+ibvIyKczjJ1lTaWgfnENv9WkwxU
 GbwE+4sMn8sf9gP9KmtjAHS8FcnhgUxbz5f0EtpXadvWCtjAhg8q5bvAax8u9hJwun8k
 MPQQ==
X-Gm-Message-State: AOJu0YzdWg0+Gt+ny9syljxN8nl/XM6UWlvKD1jabXuqgAbFwVElsQP/
 EaBrymqQZRXjN8D8v8oVwsNE2jEzR2Vr7yajPxMmVK4lZ87+Elksol2VPokaPLERZDrEFvT7WcE
 u
X-Gm-Gg: ASbGncvmh5QEHeC08g0NpChphO8VZl8FL6n+aORU2erxL28tRP3lrQDm+MxOuwCMLq1
 nZiDx13ahVLe9e/QDYPmWZaWHxEQhlOYWxxWL1b/VHHlWppcW+r1cGzq0bdnWKlIiZTUIl4qnys
 UJbFgYJSdHxN3wiWHvbijcfrIizoUm7KzTQ6v6OazJVjCYWp6nwXs/By2bHBh2waKJuAIwmubCG
 zp3azciYg4n+RmH6yNeoj4NLi1dDquqybhI/TMZV01diynmvuZPEaH9TWuZu4RXaExXfP3w2VBm
 XNocYmbJm6yFwQRmhZ+Ywa8=
X-Google-Smtp-Source: AGHT+IEsTbzPtHJegzK3ZNrxOz6donBT8RQLBLhoaeD9eD0yYt9D4Gbp5pZ59IyoVmB8DF8HioklFQ==
X-Received: by 2002:a05:6402:27c9:b0:5de:4f37:e59c with SMTP id
 4fb4d7f45d1cf-5e03620f070mr14680107a12.31.1739882404389; 
 Tue, 18 Feb 2025 04:40:04 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece2880fasm8555413a12.78.2025.02.18.04.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 04:40:04 -0800 (PST)
Message-ID: <598ce065-3927-46ef-ae2d-1e49d53d6ff1@linaro.org>
Date: Tue, 18 Feb 2025 14:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL next] u-boot-at91-2025.07-a
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

Please pull tag u-boot-at91-2025.07-a , the first set of at91 features
and fixes for the next 2025.07 cycle.

This feature set includes improvements on the atmel-quadspi driver, a
fix for the nand driver, and improvements on the pinctrl driver to be
able to use the Linux DT (also sync on the DT side as well).

Thanks,
Eugen

The following changes since commit 87dec3078a0a36d2e6da7602b9a750010c2d111d:

  Merge patch series "Enable bloblist support on Vexpress64" (2025-02-11
18:09:05 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-2025.07-a

for you to fetch changes up to 344e2f2cd4a407f847b301804f37d036e8a0a10c:

  mtd: nand: raw: atmel: Fix pulse read timing for certain NAND flashes
(2025-02-12 10:49:56 +0200)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2025.07 cycle

----------------------------------------------------------------
Alexander Dahl (9):
      spi: ca_sflash: Remove redundant dependency
      spi: atmel-quadspi: Depend on SPI_MEM
      spi: atmel-quadspi: Port collected fixes from Linux v5.10 and v5.15
      spi: atmel-quadspi: Avoid overwriting MR register settings
      spi: atmel-quadspi: Remove default mode setting at probe time
      spi: atmel-quadspi: Allow setting SMM to classic SPI mode
      spi: atmel-quadspi: Add support for classic SPI mode
      spi: atmel-quadspi: Improve probe debugging
      mtd: nand: raw: atmel: Fix pulse read timing for certain NAND flashes

Balamanikandan Gunasundar (1):
      ARM: dts: at91: sam9x60: Define pinctrl node with its label

Manikandan Muralidharan (6):
      ARM: dts: at91: sam9x60: Add AIC node
      ARM: dts: at91: sam9x60: Move pinmux node to board DTS
      ARM: dts: at91: sam9x60: Add missing pinctrl node properties
      pinctrl: at91: Bind GPIO driver to the pinctrl DT node
      pinctrl: at91: Add support to align with Linux Devicetree
      ARM: dts: at91: Align pinctrl node with Linux Devicetree

 arch/arm/dts/at91-sam9x60_curiosity.dts      |  71 +++++++
 arch/arm/dts/at91sam9260.dtsi                |  76 ++++---
 arch/arm/dts/at91sam9261.dtsi                |  77 ++++---
 arch/arm/dts/at91sam9263.dtsi                | 117 +++++------
 arch/arm/dts/at91sam9g45.dtsi                | 106 +++++-----
 arch/arm/dts/at91sam9n12.dtsi                |  93 ++++-----
 arch/arm/dts/at91sam9rl.dtsi                 |  93 ++++-----
 arch/arm/dts/at91sam9x5.dtsi                 |  90 ++++----
 arch/arm/dts/sam9x60.dtsi                    | 151 ++++++--------
 arch/arm/dts/sam9x60ek.dts                   | 213 ++++++++++++-------
 arch/arm/dts/sama5d3.dtsi                    | 116 +++++------
 arch/arm/dts/sama5d4.dtsi                    | 118 +++++------
 drivers/mtd/nand/raw/atmel/nand-controller.c |  13 +-
 drivers/pinctrl/pinctrl-at91.c               |  52 ++++-
 drivers/spi/Kconfig                          |   4 +-
 drivers/spi/atmel-quadspi.c                  | 294
+++++++++++++++++++++------
 16 files changed, 976 insertions(+), 708 deletions(-)
