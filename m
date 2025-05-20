Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E87C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826AE82B97;
	Tue, 20 May 2025 13:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="zL01q2ua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A07482B7E; Tue, 20 May 2025 13:38:03 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D773A82A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso770465366b.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747741080; x=1748345880;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=42LWsMb6MVi2u1ai/XNsn9nC+xuCwGEwXU0LHSmeX/E=;
 b=zL01q2uaVYGSHuV+NiGm6ywc0iWaRcD6oimeh9V70mDKyOwFsMca0qC9ZGNYm+L3kl
 FmdVXi91fY4RSZmWjdYRZllSJOaev3YkVaFtRP1s7kqY6HM+I++Rwb9xCr0qI1ULJ+jf
 Zvu48WtCGbojWX69i37F2VpHSXBbUVWlmCWwHo0mNlZd8QapzUJZNQlRq77nezGke9vp
 Ll+0OiIHlFj4cisR5H1g3Ou9SmSdgcbXSeG4S9WEB3AzabIuKbsj9vsoU+qmTNZJn7Y5
 vUVk3buwvoAVQx9gF5fSqHop+C7jTVsQdpZ02Au6gpWI/D0/tOwEhDJvY4EeVw8nZc3L
 1PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741080; x=1748345880;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=42LWsMb6MVi2u1ai/XNsn9nC+xuCwGEwXU0LHSmeX/E=;
 b=XcaA1M7ou23Ip3wNjQqPE8nRs6nw3SOrirB1ccJ0lacyAInc/Ne6QjBwHRLzsamZuR
 PdqpK5OkLzdFPOp4gj8kf/BKWvG6E3OGrfO8QBiCrXfGqYxnq9Ex8wJ08oGwsQO9H6fH
 IwTl9UY0AvY03+f8qhlbWS8/oFoYmzercU/7P+4GWRfRyQ9wrhT/bv7E3h99GuLb5wAV
 vmOBd7hyXlXgtERFvKPCy5WfKpAlyRyTiKA/jCKoIJcoo0OWuRMzfsWkcqt5owtoUQh+
 l/etMd4y97g6p3p4cGAJaiGWnZVpRJjVu2UOFFsKLEfaGcNt08NRIKf0l+alq/Jws6h8
 rQuw==
X-Gm-Message-State: AOJu0Yw3oDEtsT3DPhWVSba2txck9Ik9SO/KUra7J/D0MZ3Yf8mmg+nY
 W6JGA2mnGyTZ08hOirgnZe7HbuF2cDV8GZfqCtnxXIoIoBLhdsby3uwHn4Pq3w/2a0Q=
X-Gm-Gg: ASbGncswofNfEYP6v8qXYG2hbXghNGj/MdVyJ3CsWzJ/Zyn4upgSTqxj0NHxxRyr0VR
 WB2WrnyXxvVMrGCrXqPGYPZjszobfRZUjMHzI2YZFxfcwBwLWmXjWz62IC/VbrSfJWq5BBXj1/s
 cLHJJLjpEU3Bo9dJfmHG9ShChaLbNW/+Nn+WkmCjJyA+HUllMvuE7C6pZIahYCNJHx0jFOPg2WA
 ZQIAGo3FqHwbk2cyVK7bJy5437dsgh7I4dn4QVfuJLX+k/blCy9lvRGUbyxbT5MZt0ufnzK8JI+
 G4JuZHaGkKbAA69Pxa5DC6Ei+KX94PNp3V7whS4iCBGMEQUzNwh3jmJB/76CD5jR
X-Google-Smtp-Source: AGHT+IF/+uUH+SP+xF39CDTVuvhMayMBTbXTbO97H2aOg2gG2kSXtjIHEjUWBG0/KOsKq0EspNHg0g==
X-Received: by 2002:a17:907:7f20:b0:ac7:805f:9056 with SMTP id
 a640c23a62f3a-ad52d518183mr1502382666b.32.1747741080282; 
 Tue, 20 May 2025 04:38:00 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383bdsm715331166b.122.2025.05.20.04.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:37:59 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v5 0/6] Rockchip: Allow to silent TPL/SPL debug console
Date: Tue, 20 May 2025 13:36:38 +0200
Message-Id: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZpLGgC/3XO0Q6CIBiG4VtxHIcDAYuOuo/mGsPfYCo0QCud9
 566ddLW4XvwPftmFCFYiOiczSjAaKP1bg1xyJA2yt0B23ptVJBCEEEFjrYDl27au+g7wKqRRyl
 KCQVXaB09AjT2tYPXau0m+B4nE0B9GU4kPVFGqBB5ISUTDFPcDa2KU64n0MY/Y2svyaihVwl0r
 n2/ycbG5MN7fzryzf97auSY4Bp0qU9M0obQH61aluUD4bLjg/oAAAA=
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

Changes in v5:
 - Replaced [PATCH v4 1/5] ("efi: stub: Define debug uart functions only if CONFIG_DEBUG_UART is enabled")
   with changing definition of _debug_uart_putc to inline, as suggested by Tom.
   This is consistent with implementations for other platforms and
   allows to suppress warning withut introducing #ifdefs.
   Same change is added for arch/arm/mach-uniphier/debug-uart/debug-uart.c,
   for consistency.
 - Added dummies for missing functions in debug_uart.h (_printchm, printhex1,
   printhex, debug_uart_init), as suggeted by Quentin.
 - Updated order of patches.
 - Link to v4: https://lore.kernel.org/r/20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com

--
2.43.0

---
Lukasz Czechowski (6):
      arm: uniphier: Change _debug_uart_putc function to inline
      efi: stub: Change _debug_uart_putc function to inline
      ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
      debug_uart: Replace debug functions with dummies if CONFIG_DEBUG_UART is not set
      rockchip: px30: Weaken dependency TPL/SPL serial
      rockchip: px30: Fix hard dependency to DEBUG_UART_BOARD_INIT

 arch/arm/mach-rockchip/Kconfig                 |  5 ++---
 arch/arm/mach-uniphier/debug-uart/debug-uart.c |  2 +-
 drivers/ram/rockchip/Kconfig                   |  1 +
 include/debug_uart.h                           | 20 ++++++++++++++++++++
 lib/efi/efi_stub.c                             |  2 +-
 5 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
change-id: 20250515-silent_console-af979569e24a

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

