Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06EDC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE18187B89;
	Wed, 17 Jan 2024 18:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBUuVexR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D458879F3; Wed, 17 Jan 2024 18:17:24 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F52879F7
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5592d1bc4fbso4264337a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511842; x=1706116642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RHyp8FihBJ+ziCEwQ7Vka8TJl0BH9REZSYIiOO6abMg=;
 b=UBUuVexR8JyQPCKBdnw85nMBMNO/QxMaJaZbbLK7QYcvOhdfkTth0Mgj6am6ICudkT
 lJ0r6SPvLj9dUw4RXS75FfNHG3Rkv/Ff7rBsQx1oSoKW90HRuhpT3zaWamPPwGzDpHdB
 qd+qdi7Bd/y07h3EP7v6NK7/Z3WT4V37HRCMMXaUeMBOCww7cgZ7vkzAgh7DwodLpAPB
 LJTUzOpg+9zBfAlUKmk+GC4oopuPY1og4UXpKjY129YwFYTUfpJ8fEKHQHXtoP3/XYVQ
 cdMGDSMGKM7mPZ+ufxeq/vkQxF+xXdoUPiHNo5NWNFAR3aZjRM+ZtuBj0vK1jssMGFDr
 nnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511842; x=1706116642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHyp8FihBJ+ziCEwQ7Vka8TJl0BH9REZSYIiOO6abMg=;
 b=NgvBdDIQ+laChozvUxH3PtrHfWykK/qwiJCZtHnnJTeZxbp6S50VXqEns6XtaIVXAU
 eXu7TsiTOr+1GcsFsTEkShEtJFhf+U1g98W3y4cDjKSWgghVe1fe1eoF6L3LR9AlsPTo
 HzJfEWe2lI2nbvQBu6iBPHzApJN3PKz+vEhDvqg1+eWQBY3VEO2ewiqycll7cPYEbQ7L
 Y3Dxo4kRrj7p2WLz2ZbhsCuMhPUMpQ7XrY3u2f9Rz9lwc67FpHJEsMUEsrn7tIsN84ff
 3lqa4YGGzyKPsjpdq58Hty8bRC1r3LIJ7YKisHyqqoXzai0d1Gqc3VH6S9naLhiwldR7
 iNPg==
X-Gm-Message-State: AOJu0Yzanurio6hK59B/7MwORXTgWx0llcpO+PCMZWLsdBCzF+PqpQMH
 oBWE+DZqprg6ZcC7M83KCZ8=
X-Google-Smtp-Source: AGHT+IEfEMnQAxJ6a8gHswoF5gWO4Pstc10QNIqIBGqZdu5PDD6v+2pFAqiVrME/Xna+e20zsphIdw==
X-Received: by 2002:a17:906:2351:b0:a2e:d304:97c9 with SMTP id
 m17-20020a170906235100b00a2ed30497c9mr661686eja.4.1705511841820; 
 Wed, 17 Jan 2024 09:17:21 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:21 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 00/13] Add T114 video support
Date: Wed, 17 Jan 2024 19:16:45 +0200
Message-Id: <20240117171658.22324-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

T114 is not that different from T30 and all T30 drivers will work
on T114 as well with some adjustments.

Patches propose general improvements for existing Tegra DC and DSI
drivers as well Tegra 114 video support (experimentl).

Commits pass buildman for tegra.

---
Changes from v3:
 - fixed the clock divider calculation if PLLD/D2 is used
 - removed unnecessary pre-configuration
 - set correct video FIFO depth for DSI

Changes from v2:
 - fixed image distortion on devices with 180deg rotation

Changes from v1:
 - reworked patchset entirely
 - diverged DC configuration per-SOC
 - consolidated dc headers from different SOC gen
 - initial support of DC detection (tegra has 2 DC)
 - added PLLD2 support, resets and powergating
 - added T114+ MIPI calibration
 - added DSI detection (tegra has 2 DSI) and resets
---

Jonas Schwöbel (2):
  video: tegra20: dsi: remove pre-configuration
  video: tegra20: dsi: set correct fifo depth

Svyatoslav Ryhel (11):
  video: tegra20: dc: diverge DC per-SOC
  video: tegra20: dc: fix image shift on rotated panels
  video: tegra20: consolidate DC header
  video: tegra20: dc: pass DC id to internal devices
  video: tegra20: dc: add PLLD2 parent support
  video: tegra20: dc: add reset support
  video: tegra20: dc: add powergate
  video: tegra20: dc: fix the clock divider calculation if PLLD/D2 is
    used
  video: tegra20: add MIPI calibration driver
  video: tegra20: dsi: add T114 support
  video: tegra20: dsi: add reset support

 arch/arm/dts/tegra114-u-boot.dtsi             |  13 ++
 arch/arm/dts/tegra114.dtsi                    |   4 +-
 arch/arm/dts/tegra30-u-boot.dtsi              |   4 +
 arch/arm/dts/tegra30.dtsi                     |   2 +-
 arch/arm/include/asm/arch-tegra/dc.h          |   8 -
 arch/arm/include/asm/arch-tegra114/pwm.h      |  13 ++
 arch/arm/include/asm/arch-tegra20/display.h   |  28 ---
 arch/arm/include/asm/arch-tegra30/display.h   |  28 ---
 drivers/video/tegra20/Makefile                |   2 +-
 drivers/video/tegra20/tegra-dc.c              | 211 +++++++++++++-----
 drivers/video/tegra20/tegra-dc.h              |  44 ++++
 drivers/video/tegra20/tegra-dsi.c             |  98 +++++++-
 .../video/tegra20/tegra-dsi.h                 |  24 +-
 drivers/video/tegra20/tegra-mipi.c            | 188 ++++++++++++++++
 drivers/video/tegra20/tegra-pwm-backlight.c   |   3 +-
 15 files changed, 540 insertions(+), 130 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
 delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
 create mode 100644 drivers/video/tegra20/tegra-dc.h
 rename arch/arm/include/asm/arch-tegra30/dsi.h => drivers/video/tegra20/tegra-dsi.h (90%)
 create mode 100644 drivers/video/tegra20/tegra-mipi.c

-- 
2.40.1

