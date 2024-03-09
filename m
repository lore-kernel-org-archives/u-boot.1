Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D52CC54791
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 22:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A471887EDD;
	Sat,  9 Mar 2024 22:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dHrprTKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C515187DB3; Sat,  9 Mar 2024 18:53:51 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B6C87D5E
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 18:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e655a12c81so2329598b3a.1
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710006826; x=1710611626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wt344X7LsW5XxQlam8eTqx1zCXt+Dq57vD0hgEZsoR4=;
 b=dHrprTKglsAOgHOMp/tyUgbtMJ92Qbgb2dGOZ/p1rHdK+Sp/a57ag27gTwI4EDmvIJ
 Pit3PktAun6J7ZUHZf1qs90HTv+9S5AaLqvK6oatubjBaRwXGvELsN4NGB1Yqn5m75hh
 LrjHiIVAxEF/GQVWg5FVzN3pbvrb3/l/qhEUuMfhGElHiUA3iojcY/7og7qKz/5v4FCU
 S5cgn2dUfzpps+xn373kC82kJLzfHD3AUD0GpmIY06lP6oOix1XtaJJprfsqALfjWbKI
 FvwP+vXRsvaFX42fiH/yzXX8cwVhMPKy/WRkus4dV0cE4S16KHWiPeTi+J/Hb/U4umVh
 hw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006826; x=1710611626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wt344X7LsW5XxQlam8eTqx1zCXt+Dq57vD0hgEZsoR4=;
 b=Il6u3T5dZRTgJHzOM+smndy5MFw4MQ3bUlMX9VHEoP2xlu+q8aTOogfuEc+JGKi41B
 1d5OlKZt5KBq3X33WPAuO4b5j+/4075jOxA4fID1kbCXeFxO8G0vBB+PR6HfqQO0x5s2
 wBS3iP83Ibj+gaxCfJG7zVDrSZOpedYpofSCzlbnlCILA/gWTY0kGCHUWOQiYngfosWN
 cZriAi36+g9fZI9BXjDiUYmUSkjyo24SfokTIAb25UlBV+OOrsOtg8Hu2Ih34y0X05K9
 wGiuDO9lCWRCkG3mfwN3aRxzw1SD/G4W9ACcWcZy/3ST1Eso9BO3p6M8Xtn0F1QefSah
 /jAQ==
X-Gm-Message-State: AOJu0YzHbTCLP+3/DP5xMeWtO9B5PGcDFSc8bB2QlfKDjALV+TQXGM5p
 /d+5BcftlzZPEPpnlWu16ipAuNqgDx8qMHCblzqEZ4ARLjfzm0yF9Z6sPfBR1Qxfww==
X-Google-Smtp-Source: AGHT+IHSnZYjMSqiiaNL4eBkX1SJ4SWb17q7JibZQf2dLS1Hx7GmYwvUSXnCCtW15VXg+hT203gPhw==
X-Received: by 2002:a05:6a20:2590:b0:1a1:8c3f:dd5f with SMTP id
 k16-20020a056a20259000b001a18c3fdd5fmr2875814pzd.0.1710006825907; 
 Sat, 09 Mar 2024 09:53:45 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a631e02000000b005d7994a08dcsm1530651pge.36.2024.03.09.09.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:53:45 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Geis <pgwipeout@gmail.com>, Rick Chen <rick@andestech.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] mmc: sophgo: milkv_duo: Add SD card support for Milk-V
 Duo board
Date: Sun, 10 Mar 2024 01:51:54 +0800
Message-ID: <20240309175330.79267-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:37 +0100
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

This series add sdhci driver for cv1800b SoC and enable SD card support for
Sophgo Milk-V Duo board.

Changes in v2:
- Refactored and simplified some of the code.
- Sync device tree with ptaches from Linux kernel

Kongyang Liu (3):
  mmc: cv1800b: Add sdhci driver support for cv1800b SoC
  riscv: dts: sophgo: Add clk node and sdhci node
  configs: milkv_duo: Add SD card configs

 arch/riscv/dts/cv1800b-milkv-duo.dts |   8 ++
 arch/riscv/dts/cv1800b.dtsi          |   4 +
 arch/riscv/dts/cv18xx.dtsi           |  22 +++++
 configs/milkv_duo_defconfig          |  10 +++
 drivers/mmc/Kconfig                  |  13 +++
 drivers/mmc/Makefile                 |   1 +
 drivers/mmc/cv1800b_sdhci.c          | 116 +++++++++++++++++++++++++++
 7 files changed, 174 insertions(+)
 create mode 100644 drivers/mmc/cv1800b_sdhci.c

-- 
2.41.0

