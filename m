Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200BCC36002
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 12:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E5DC806D8;
	Fri, 21 Mar 2025 13:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M1jRjeaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0939E803DF; Fri, 21 Mar 2025 13:29:57 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2AC8197D
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 13:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2260c915749so25157925ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742560193; x=1743164993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CNGf3cGVOHh6xuUjhlSXqnHlPZLw0AUd42oz6BRTO90=;
 b=M1jRjeaVws6leZ07D1fXcqyRHfoTBtfIqaZ6Se5FNeB97sQN+DIJrw1ChTM/x4UPpT
 NpVskG2T/JAqMn/rmDFXHB2ZbbXtz4UecbmvkaOu4eWUwIq9P5gOzTGZbjs5v5IG7APZ
 +Kd2s+SsmIAqjvCiuMQfx+jfBIUYRl/uS3agaXhjd0K76G9p8uXk4lizG7DXcVVTwsuu
 41zCaW58QMgY8p2r2bqcPAucl79KCTEkWu5weC1HiihQbTVus+TkJvh8jpC+cZlfxu3w
 acKir0xW2E8yxq3zGXCl6pApH+y0bxkOH41SeHQlW8QIFexVXgI6tcCp2MHX99KPteeG
 jYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742560193; x=1743164993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNGf3cGVOHh6xuUjhlSXqnHlPZLw0AUd42oz6BRTO90=;
 b=Mbcfy1yukhghGRoSbDV/1wTJegG9ZC6J6pLi3VssdqhCoi4ASmFaF6hMtL1IXd6UkZ
 8cM0wCBsqqxngk5FtAy1/CulZYhGpSkcRAJf6RGK3R9iXqzklp2Hl/j8bjhE8YTmHeuT
 6qP924/lNTZHMbU4MH4rI02W59ONxWLMtEAP5VUxbRhUgsAO9TQWGI69XFYEaISyy63v
 fZ/sGlobfnmNes6WHj9Q+nILwZ99uH5T6nfoBO+qBPwuHWTEfA/c6C6n8ivw998ZNo8B
 ZWobfU4FcLAiz2bFiVjhZKUEySn9ejgYnJF9pnA5kecS8C0Wxe1DrdBe9Hi4VZSRh2Zn
 lbYQ==
X-Gm-Message-State: AOJu0YwWST6+Fgn7esVlswi8Z5u3FZB3PFxlGsV9HN91Izgg0LynB4wJ
 Edsi0IclJPYlAUhrlWlJsB8EGiMrihUQjb7vqAkRysX9CySQIHOx8yQznQ==
X-Gm-Gg: ASbGncvSOgNcTRN96+svt6YeX6DRUc1UUHHCiKozZtmUwr0Xa4ItYMMNvk9hG4Rt61d
 4yFNGsyQrGHYM8o1k82SIEy6Sx4mWswY1NKkMSDihY2nFP+ruBUuPbLlgg/moAXUTJPjl1L49dr
 zGP3bCPT9hd7MlEAPVTm+VRyTmnr2uTH0Tzgl7TfWFYhqebWl5/5tAtVbGi2jHf92/9Q7Kb2Vul
 E6OVeFPbIlITij4vBG+79eGHS7VFiuHFWlE1KnAMAxt52oocEh1z3vlxE/3RrzdYL1nZ/D/HBIl
 Q2XqljHrRoJVMvaabGuORdJMCJZm0WoHzmHHVng3Q6iwIWEw8Z+mZlpUXvU=
X-Google-Smtp-Source: AGHT+IHbxbqHlHmRNU99sO+2Ecjuv0VOTMcSMX4FPzocYniaxCBwMJcrJm9DyAesxDIH2M2h/yRl7A==
X-Received: by 2002:a17:902:ef12:b0:224:249f:9734 with SMTP id
 d9443c01a7336-22780c54cfemr56111815ad.4.1742560192649; 
 Fri, 21 Mar 2025 05:29:52 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14d:9099:464d:8348:47a:56fd:2ab7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4baffsm15193205ad.66.2025.03.21.05.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 05:29:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250321
Date: Fri, 21 Mar 2025 09:29:47 -0300
Message-Id: <20250321122947.26401-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 8bc3542384e3a1219e5ffb62b79d16dddc1b1fb9:

  Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE" (2025-03-18 13:12:51 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250321

for you to fetch changes up to cc9dcba9cce185d8bca2dc5c4b55b21f4505cbe8:

  configs: Remove duplicated bootcmd 'mmc dev ${mmcdev}' (2025-03-20 08:18:35 -0300)

u-boot-imx-next-20250321
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25267

- Allow the registration and enablement of the i.MX UART clocks via DM,
without the need of manually calling init_uart_clk().
- Remove duplicated 'mmc dev ${mmcdev}' commands.
- Rework some of the RAM related Kconfig symbols for phycore_imx8mp.
----------------------------------------------------------------
Adam Ford (10):
      clk: imx6q: Properly handle imx6qp ECSPI clk_sels
      clk: imx6q: Register UART clocks
      clk: imx8mm: register UART clocks
      clk: imx8mn: register UART clocks
      serial: mxc: Support bulk enabling clocks
      board: beacon: imx8mm: Let clock system enable UART clock
      board: beacon: imx8mn: Let clock system enable UART clock
      clk: imx: select SPL_CLK_COMPOSITE_CCF when SPL_CLK_IMX8MP
      configs: imx8mp_beacon: Select SPL_CLK_IMX8MP
      board: beacon: imx8mp: Let clock system enable UART clock

Aristo Chen (1):
      configs: Remove duplicated bootcmd 'mmc dev ${mmcdev}'

Tom Rini (1):
      phycore_imx8mp: Rework some of the RAM related Kconfig symbols

 board/beacon/imx8mm/spl.c                 |  6 +-----
 board/beacon/imx8mn/spl.c                 |  2 --
 board/beacon/imx8mp/spl.c                 |  2 --
 board/phytec/phycore_imx8mp/Kconfig       |  2 --
 configs/imx8mp_beacon_defconfig           |  1 +
 configs/mx6sxsabreauto_defconfig          |  2 +-
 configs/mx6ul_14x14_evk_defconfig         |  2 +-
 configs/mx6ul_9x9_evk_defconfig           |  2 +-
 configs/mx6ull_14x14_evk_defconfig        |  2 +-
 configs/mx6ull_14x14_evk_plugin_defconfig |  2 +-
 configs/mx6ulz_14x14_evk_defconfig        |  2 +-
 drivers/clk/imx/Kconfig                   |  1 +
 drivers/clk/imx/clk-imx6q.c               | 28 +++++++++++++++++++++++--
 drivers/clk/imx/clk-imx8mm.c              | 34 +++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mn.c              | 32 +++++++++++++++++++++++++++++
 drivers/serial/serial_mxc.c               | 11 ++++++++++
 include/dm/platform_data/serial_mxc.h     |  3 +++
 17 files changed, 115 insertions(+), 19 deletions(-)
