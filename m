Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BD9C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F2182C2F;
	Thu, 15 May 2025 17:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="eEdL/w19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB4982C4D; Thu, 15 May 2025 17:58:14 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0316782BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad216a5a59cso161040966b.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747324691; x=1747929491;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NM80y3ygojKBp2ltdP2CIc/K4MfrF1mRcda2hMH0lpE=;
 b=eEdL/w19Xmpb8LMuJZhcPTCp7YWMYmRlS/J/QDzNkNSg0LolF5DfveBpeNhJMEop+w
 yb87lZ+5Zmj8bmLpRb2q7bwFgfVMlIfpZxcopT/i0nldCZ6u/yso/Uo8aDc8hr4B4J5G
 QKmemkbwHn8sNNkp/88d5fkKgydO5iR8DDqxRYhsn4OEYcRzw1ab+5DKRJwzVBBJUihk
 TyBoA2H+cRSlsYJW4cA9rFBBP0ni0vr62mJ30RdXV2hrawu+B+/DWVSMZTGQgHlgLrSj
 iZiea5kf2zJMpdk0xXBDNmnAKjhUJqry7TpuNkjd28RdU8lV7LXac0Idls2KBtJWLF5w
 UDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747324691; x=1747929491;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NM80y3ygojKBp2ltdP2CIc/K4MfrF1mRcda2hMH0lpE=;
 b=rVk+Q7etd4QVnDapRr2The7B2eDzeMcCl0dDpVvPaYW9nUVPaaG7JHrRRSRxYovpDp
 c89CNGtRhHZMdVd6uvX/AE0XmXC/dndI8Ns/UNZCz4NYDJ8lq3KxjYZWxgVxVfTM3Z3h
 9MV1QcRtxfuXvT5MqWtRLsBSv/g+3e5AiOdW6KaVLr5Ip+HiXGsZo09GOvi4hvX1qKBV
 jn6eCohMvzRF6Wi0tViF8LrFeOI+Tnj4NgMPzTmuE0LQXYId4CoisNkqvjLhi1emZptp
 iZNYgObhoIw3DKbtnEupm2DkA26QWipIMqjqHXAlna8kOZ+mO39y7qVI7Y7Q4NjYRbyL
 VOoQ==
X-Gm-Message-State: AOJu0YxoAv4ThoGs9ybhfgelVZ9wBP8TXNDfl/cjzuJPyYTAbspd2Y61
 gvqEzQUg3gNHOiCftc+rTpC0rRwfSyEOfqKyqriaVc6BABTb5Ed8NUBxSL0l69LL3S0=
X-Gm-Gg: ASbGncsRGYbsgAO3nWr9Dlc4unUbF7RiGbA8O2a/8BHJ7oCABN/K/qKdydACy03yant
 Cl6CGi32Js9nEcyu6VyQJpAVgJBUs9zny6eX9JDWVkj1TeuXGSaC2wB0uAfvyHCpMZ6/VpJayZu
 Q0x3jpHOHm1dqkLcspqdkAP9aNPY3MxSA2XROvpQDNPoOp3Y7IyhZrQfNkgiLcybpsU4HIXNFzW
 JkUbaz1d7ClnC7fh1mQq8Mz89ptcmqOrqO+nEhGMdvaXfemRMoHe8bzSVwInW2c4cnIM/N6JyEv
 2EWvj/oAioa6fTqkCv8nFPVz85aOjLElLrCVLEPozyJqndNeWh9nKcsw/Xtlh1Xr1uBz0J9pO4Y
 =
X-Google-Smtp-Source: AGHT+IEaU20PM1uaog15oLP3/J2TgmKjqVwPAmUjzB1oubEH3RoG6qbwwV9R7LEUrScQvvzofsCXWg==
X-Received: by 2002:a17:907:1c9e:b0:ad2:1d12:fd68 with SMTP id
 a640c23a62f3a-ad52d5d8596mr21180666b.48.1747324691348; 
 Thu, 15 May 2025 08:58:11 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm8698266b.69.2025.05.15.08.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:58:11 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v4 0/5] Rockchip: Allow to silent TPL/SPL debug console
Date: Thu, 15 May 2025 17:55:43 +0200
Message-Id: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH8OJmgC/zXMQQ7CIBBA0as0s5YGKKi48h7GmAlOhbQFA1RNm
 95dYuLyLf5fIVPylOHUrJDo5bOPoULtGrAOw4OYv1eD5FJzLTTLfqRQbjaGHEdi2JuD0XtDUiH
 U6Jmo95/f8HKt7lOcWHGJ8L9R3Iij6LjQupXGdLpjgo3zgHlp7ULWxXce/Lk4nCcsZFsbJ9i2L
 0QgPRmqAAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Currently it is not possible to completely silent the debug console
in i.e. PX30, what might be required in some embedded devices.
Disabling DEBUG_UART results in errors, due to missing symbols.
In particular, rockchip sdram driver performs calls to debug_uart
functions (i.e. printascii), defined directly in serial driver.
This patch series fixes the dependencies in Kconfig and provides
dummy implementation of debug_uart functions that are linked in case
serial driver is not used.

changes in v2:
 - Update commit titles
 - Create separate SPL and TPL symbols for RAM_ROCKCHIP_DEBUG

changes in v3:
 - Dropped [PATCH v2 3/5] ram: rockchip: Add separate RAM_ROCKCHIP_DEBUG config for TPL/SPL
   As suggested by Kever, dependency on DEBUG_UART is sufficient and this patch
   was not needed.

changes in v4:
 - Add new patch fixing compilation warnings in lib/efi/efi_stub.c, if
   CONFIG_DEBUG_UART is not enabled. The #ifdef directive is used to
   conditionally define debug uart functions, as suggested by Quentin.
 - Fixed invalid redefinition of DEBUG_UART_FUNCS macro, and changed
   the dummy print functions implementation in debug_uart.h

--
2.43.0

---
Lukasz Czechowski (5):
      efi: stub: Define debug uart functions only if CONFIG_DEBUG_UART is enabled
      debug_uart: Replace debug functions with dummies if CONFIG_DEBUG_UART is not set
      ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
      rockchip: px30: Weaken dependency TPL/SPL serial
      rockchip: px30: Fix hard dependency to DEBUG_UART_BOARD_INIT

 arch/arm/mach-rockchip/Kconfig |  5 ++---
 drivers/ram/rockchip/Kconfig   |  1 +
 include/debug_uart.h           | 15 +++++++++++++++
 lib/efi/efi_stub.c             |  2 ++
 4 files changed, 20 insertions(+), 3 deletions(-)
---
base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
change-id: 20250515-silent_console-af979569e24a

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

