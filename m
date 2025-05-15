Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3321C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A4782B97;
	Thu, 15 May 2025 15:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y19bC2SN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5083182B95; Thu, 15 May 2025 15:12:53 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503E382B54
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so7495095e9.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747314770; x=1747919570;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tweNOC6MkDgDTNt670jcYkDjYiePAQjPehFzYWOKMg4=;
 b=Y19bC2SNB6DZMFqTl/vIsgpYKuYptXrm0WB4Z7i/EBwP4WHKPgvGFr4LCQiMIhCSle
 rsiQDxC1BfbQ7Eiw2Ky+u2ClhiaFkWg1W6vy+l3n6dfU4t3ETlIaHkbJF3vma1XPOlNq
 9rWCbI/crDcYfEfSANa8vXyCl3iht6f6bjxTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747314770; x=1747919570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tweNOC6MkDgDTNt670jcYkDjYiePAQjPehFzYWOKMg4=;
 b=L01CbCiV6hKTJ0HVCQ1Lh+D7Zv2JPR0NOJQfcU30ffjlvXvPQ5Pdg+qerQa5muuJLG
 x58Xk0kUSJr/PecmWTwvMK8FWMOdWQNDGOPHFA5Plf/nhR/TEK8aV0Fllww1CoHdPH3U
 Iwqs6+Fi1IGpHvwcm95bme5Av8Wx3if3Sn770BaO8q3w+QO6KElV56O4Hcr+hKlmzrXd
 EIWGnDTWAlDKgsLD598t04NodvIin6mH0FL9JdbDfu1EV1qQdNSOXOAFkkRehin2o9QO
 zU8ABSPhbUdenJw8De7aRXXwHl/L5+hwrVq4wshHCtzQQIziaeNrtCSiP0YsF56CU91V
 2MOQ==
X-Gm-Message-State: AOJu0YzODHO3zZtWErtlYUq++48LS4JZ1RYm3DXY1w4MgXQy7Lkhr7oT
 kj4IGo1K99YU4R2PK/+6p4emsxRQhZWEe2HW7kCiSQRpgnn8nmnRwJid4uMoqDzEbkQWVep80Um
 FYZs=
X-Gm-Gg: ASbGncv+k72nMagPnU10b/6Or81bjrHlzVPQlH+x8qx/PDLdaDuCfGY0KschSMXXXKZ
 hO8Fcd0BUUhtEPiIpAFrn1n2pldiijxWpXx9JqQXQTdAv0/r0AC91NDiAY3SgZD4hwjIT/4HpfG
 KLxzcZCoPOBpuamg3dXGjHfYzTB7n44KiO9oDjZ98P6J2Z8alGQO7vZtoeZH1cU425u9lfiF7Uf
 1JJCHfKh5brPMbPiTZlGEhfkHieQvUukeFFkKcIPNqsZ7OHy5HqmANfoDy0UOOMgruDEhiD2Tyr
 mtXEsYRqI/lmKZafDOZsPsDxL+kYCUUX0WIrKP1r599//F4+rdXFsl3A210Mw/UmTQdIg+AFgLK
 M18chpxROuf0yxaHP+U8zkvxk95sZqk36LDnvFvRprUY=
X-Google-Smtp-Source: AGHT+IGpjezpluNaxOFaTEoOYqUuTZAGFSdHX2gN5qQbNM3fJ4WxuengpnNUMgQr0kZKUUH1UjDwTg==
X-Received: by 2002:a05:600c:4e54:b0:442:f44f:678 with SMTP id
 5b1f17b1804b1-442f9714e7fmr25956905e9.31.1747314770566; 
 Thu, 15 May 2025 06:12:50 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef811sm65516825e9.35.2025.05.15.06.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:12:50 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [RFC PATCH 0/3] Restore imx8mn_bsh_smm_s2 properly booting
Date: Thu, 15 May 2025 15:12:39 +0200
Message-ID: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
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


Dario Binacchi (3):
  spl: Kconfig: allow to enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR for
    i.MX8M
  configs: imx8mn_bsh_smm_s2: restore
    CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
  serial: mxc: restore booting for imx8mn_bsh_smm_s2

 common/spl/Kconfig                  |  2 +-
 configs/imx8mn_bsh_smm_s2_defconfig |  1 +
 drivers/serial/serial_mxc.c         | 23 ++++++++++++++++-------
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.43.0

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
branch: bsh-s2-break
