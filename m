Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A99C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 08:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF26582A8D;
	Tue, 20 May 2025 10:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eFR4RDOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F09582B07; Tue, 20 May 2025 10:55:12 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1B9829F5
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so43635195e9.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747731309; x=1748336109;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qqYhhofxAzh+pZpae6XEm0Qs11R8p5K77DvbTWoQcH0=;
 b=eFR4RDOxCOurDGQ/QCoBZoqwQAm1XgYdc6VOvy4dPVEDW9btEZAvU9ZgfGEif4HTGs
 A5xhP9JSyFu6U+lbjuwvsfX4JG52GN7mcN1iudZf8h/LPAxvgPyyyzqWk12xjgrmp1K/
 2z4Y7dM3f30aXdQU4zhojpSwbdA5coM8Zs5Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731309; x=1748336109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqYhhofxAzh+pZpae6XEm0Qs11R8p5K77DvbTWoQcH0=;
 b=FYO1gV6D/1kq9+8ytoD57nbO8vK8gey/FgCSUjiNXM4ybCXGum4IF98Eirmsp2haNq
 Y+vxWMuuIO2BpZVOgflxXk3SA5Qyb+E/61kYKJ4K885CyPj5PyoyN0gDjn5wJnYU4tQC
 jy8QuqiSesNbizFpn7WgaHqs5NBKELDnLWhRDKCitKlaaOUCTQwnqTVrAGYUiRgpWh+2
 YsQyIZP656FZmpdGYOFq69teWmpzplJUyuHdvdCLqeYn3LuOplWG9dVWz8yySLstdUyx
 2qufMcz6UtlPDJOXw3gENomNZ7AdtIk5MqQ95/8BcTTcB9a9Wx6M46hUD5KBThIEyT2Y
 yvFQ==
X-Gm-Message-State: AOJu0YwqbxB9s/+dW2j56MeoIB4jRezwT21WplzUZ6PZR5cm1Ls21SNI
 N8l75/seCBBo13Yv5cgNVpyT0IJ6YRZnxDibdUTDiVv8nUw86NiBL4doD3Nk1x7zwk5HJRM2TaX
 +ziRR
X-Gm-Gg: ASbGncttZYWA5/p+UueALMG5POCj3RUb4Fui5QH9EqQ8GWPzdTO/f7GBGhY7meJHXrV
 gfnZnddAkfga4w0nkOLquWWtiBz34Fshi+K25Zdm2hTjECIJ3w3qi/0MCB45rdrvrMNW/GOsH9K
 qcHuWWhQ97o5+4BOSmP/G5tVHxKs0LfnN/wJfs6TnRgIQ5P1RTQv67++7T7lC6Tp+1VU5vVsNNv
 ZsBx2awcEzZm83GzQwiMTF1snpXpyRutqutH6DFaKdk2L+Q7RL8ur/n6Q/QoVC5BO0Q7sueMqX+
 nJ5lz8EpkGXJ+xZoUnzTkr+nqSjYuAHsG0WMXKF2HqJ1lD4halzaFpfrTEt/5SzSmBOBGHj0pWz
 OMKQQ8kxcQC2z5p8vVQ1FdcyvfA==
X-Google-Smtp-Source: AGHT+IHH4FuUlxwKiryS1AiPowfGtfwT1W2C22DzEXhDybFfkYRBi7+OwMybfB7vqAmdmJC+Qz9M2Q==
X-Received: by 2002:a05:600c:46cc:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-442fd672025mr107786705e9.22.1747731309550; 
 Tue, 20 May 2025 01:55:09 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f062fcsm21541315e9.15.2025.05.20.01.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 01:55:09 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Sven Dembiann <Sven.Dembianny@bshg.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH v3 0/5] Restore imx8mn_bsh_smm_s2 properly booting
Date: Tue, 20 May 2025 10:54:15 +0200
Message-ID: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commits [1] and [2] broke the booting of the BSH SMM S2 board. The
patches in this series restore proper booting.

[1] 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
[2] dda454e933c6 ("serial: mxc: Support bulk enabling clocks")

Changes in v3:
- Drop patch 4/4 "serial: mxc: restore booting for imx8mn_bsh_smm_s2"
- Add patch 4/5 "board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
  CONFIG_SPL_SYS_MALLOC_F_LEN"
- Add patch 5/5 "board: bsh: imx8mn_bsh_smm_s2/s2pro: let clock system
  enable UART clock"

Dario Binacchi (5):
  spl: Kconfig: support U-Boot load from raw NAND
  imx: spl_imx_romapi: support raw NAND sector
  configs: imx8mn_bsh_smm_s2: load U-Boot from raw NAND
  board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
    CONFIG_SPL_SYS_MALLOC_F_LEN
  board: bsh: imx8mn_bsh_smm_s2/s2pro: let clock system enable UART
    clock

 arch/arm/mach-imx/spl_imx_romapi.c     |  8 +++-----
 board/bsh/imx8mn_smm_s2/spl.c          |  2 --
 common/spl/Kconfig                     | 15 +++++++++++++++
 configs/imx8mn_bsh_smm_s2_defconfig    |  3 ++-
 configs/imx8mn_bsh_smm_s2pro_defconfig |  1 -
 5 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.43.0

base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
branch: bsh-s2-break
