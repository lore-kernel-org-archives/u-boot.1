Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254F9C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 16:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA3D84A63;
	Fri, 10 Jul 2026 18:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="N1Fq2gHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C8184A7A; Fri, 10 Jul 2026 18:34:36 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B9C8498C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 18:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hfranco@baylibre.com
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667923d86a7so1886192d50.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783701272; x=1784306072; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zit/EsqILvVe1marImYgIjGwSi33gC+6uEF68vkq3us=;
 b=N1Fq2gHxgFMQz6I43rz/lIiz5xh6QBl9JZBTW563TY/U8AIUZxq9K3ZUW60aQGbFOz
 WubIWD+U6sUDKgJw20XwSXVh7e55Nr00Ry78WGtQl3Hlx7mcCv4djZPq/2lkG4ioI4D0
 tNgqU4HBasWioGm69xnJNXqpcOw9Uu3WWPecTr1xUncsixFdriHI4UGpvpYqEdVhC/1s
 5/PkkSXgqgK53CaPE+gl1D4/QVSb+Wf95gwK8I1n8c0rqIjmqSp9folBKxQCDhFutfYg
 h1TFOAiLs4FM+ZztcWgAYZn81XvMtlSVdztOvpDQtq1TlyoiTolgzs7/3X55+gF8nlU2
 PsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701272; x=1784306072;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zit/EsqILvVe1marImYgIjGwSi33gC+6uEF68vkq3us=;
 b=gKP63d/u2bpEiqt5zKK6D24mFHRgtIT4NpcS8/yC5X4F0kDdA4qGeUrhi4yCXnm3h0
 t2GfexgYXQIhRmTj5Fr7SV/lJnUkm5e1NSMol/om9eRzZUDtsvlsTeyHvUqNU6iCKloV
 Tg8tJyhHP75imct5gXpV9FzSGXQ3yHdJ10JWQ7+HyURUSYDMUX/A8SsOHKGEw4tBFREE
 AyPDWsFB0CrIu8o+AFtdSXlDJqU+WQ34kQjiFC+tbxgO4nVxU8KrFF9egADSFaejVSMJ
 i3igvtHI3ZPv5wFwKLVVawIAMLXeiNHUTrlssPJyC5CRz1PmOgf/s4rNuDFd8qB7TpOQ
 NbLw==
X-Gm-Message-State: AOJu0YyrsFbTLnxWpu+NpxgjgM8H8QJdAd1lUSN1jQdy3tcvPuI1zG3S
 qijh8qy5D0sgTwD7CEtsHZ5hShfa0EAJVtOuIXoriAzFRNBrWjuawUZnaTHiaka1yW8=
X-Gm-Gg: AfdE7cmcPq7PUrZRlX0fl8NY0Xuea00Epn5crdeASZyxTZxGW5Ty45PHktYNCtQhf8e
 KcybCTyU9YVu6ghYtfuKneZStNTcHa1G0GMv6OGw1PNWZxWxF3zzGlc1GZfAdDXEYsyM2Ei2fS7
 TyOjOh0oP3pPZKVrNzBFgbhfSaDiSwBVrYN4ENNAUFTsxU2HfAc1+4iRFKYldlCUBHOcKMhRH6E
 Y2UcweudNjL69q3c1tH+WOCxMoN8x/BtOhCi/HfcW4otnBBqfEZBARO8Z16UmO1zITA+U+G4kTm
 tVYaDQoatFs43xPQHihxsjqsvTbsXV984YZ9Y6SSICKoldT6X4DTjAADRgy4shevng32myqJ4lz
 C++BAYfhKte5x7IznzXPSu7jSFaVo1I5PVYB4fYPWR5RejvKs7pCaEZ8dkd7DxrknwISonVZM8K
 b0/zvBhRfuGbuGaa7GCTiXC4f8re2rmaulZb+DCVTZhskQIGZT36henUuHOgcentl/kWOk
X-Received: by 2002:a53:acdc:0:20b0:664:e24e:5b92 with SMTP id
 956f58d0204a3-667c5a6832dmr2442964d50.8.1783701272387; 
 Fri, 10 Jul 2026 09:34:32 -0700 (PDT)
Received: from [192.168.0.219] ([2804:14c:4c5:9534::40b5])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6c1ee792sm50007747b3.38.2026.07.10.09.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:34:31 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Subject: [PATCH 0/2] board: sophgo: add support for Milk-V Duo 256M
Date: Fri, 10 Jul 2026 13:33:54 -0300
Message-Id: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBtQQ4OuEi1Mpxr6MZQiiO6et
 PwW7z2QKTFlaMUDiS7OHPcCVQnws9snQg7FoKW2slESXQi48bpcGM6ojd1QWau98W4cagOlOxK
 NfP/Prn/fD9Kgct9jAAAA
X-Change-ID: 20260710-add-milkv-duo256m-1662c5cafb35
To: u-boot@lists.denx.de
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Yao Zi <me@ziyao.cc>, Conor Dooley <conor.dooley@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Andreas Schwab <schwab@suse.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
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

Milk-V Duo 256M is a small development board based on the Sophgo SG2002
SoC.

U-Boot runs as the S-mode payload on top of the vendor FSBL and OpenSBI,
packaged together into a FIP image on the SD card.

The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and
loads the result at 0x80200000, so TEXT_BASE is set to 0x80200020 to
match the address the U-Boot code actually runs.

The following peripherals are supported:
- ns16550 serial console (UART0)
- SD/MMC
- Ethernet with the SoC internal PHY

This patch was tested on Milk-V Duo 256MB using an SD card and the Duo
USB & Ethernet IOB (base board) [0].

This series uses the CV1800B SYS_CPU target since SG2002 shares common
IPs with CV1800B. Other SG2002 as LicheeRV Nano does the same.

Note: Linux device tree is not yet merged [1], therefore I am adding a
device tree here and it can be later changed to use the kernel upstream
one. 

[0] https://milkv.io/docs/duo/io-board/usb-ethernet-iob
[1] https://lore.kernel.org/lkml/20260710075917.159969-1-chenyou910331@gmail.com/

Link: https://milkv.io/docs/duo/getting-started/duo256m
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Hiago De Franco (2):
      board: sophgo: move ethernet driver to common directory
      board: sophgo: add support for Milk-V Duo 256M

 arch/riscv/Kconfig                             |  4 ++
 arch/riscv/dts/Makefile                        |  1 +
 arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 +++++++++++++++
 board/sophgo/{milkv_duo => common}/ethernet.c  |  0
 board/sophgo/{milkv_duo => common}/ethernet.h  |  0
 board/sophgo/milkv_duo/MAINTAINERS             |  1 +
 board/sophgo/milkv_duo/Makefile                |  2 +-
 board/sophgo/milkv_duo/board.c                 |  2 +-
 board/sophgo/milkv_duo_256m/Kconfig            | 30 ++++++++++
 board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
 board/sophgo/milkv_duo_256m/Makefile           |  6 ++
 board/sophgo/milkv_duo_256m/board.c            | 19 ++++++
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
 configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
 doc/board/sophgo/index.rst                     |  1 +
 doc/board/sophgo/milkv_duo_256m.rst            | 82 ++++++++++++++++++++++++++
 include/configs/milkv_duo_256m.h               | 12 ++++
 17 files changed, 259 insertions(+), 2 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260710-add-milkv-duo256m-1662c5cafb35

Best regards,
-- 
Hiago De Franco <hfranco@baylibre.com>

