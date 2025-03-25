Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB3CC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 12:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D8380EEF;
	Tue, 25 Mar 2025 13:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UTBUykap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE5F81026; Tue, 25 Mar 2025 13:51:34 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3D3808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso10131875a91.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742907090; x=1743511890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d589mvMFWRrlFPyVYTwDIlfolqKybPC6sioUz827GQ0=;
 b=UTBUykapNCkyWqMXjI8DeDiqcU1yz24wNHTuQ7i28x+NdbfZQZrdsArGKYTwe6GV2j
 jYwO//y0E35uEqUzbHMjmexbLgHp2T+RSAaqydK0q2xJ2rqaMAK+VBuSWnowEFrTeGa1
 Ls6as13RkhUSzJOkXhSl8K7zr5r92wByfzAzlD9vMZBNGZNiler4DAEarz3UZfGCVkeo
 vAnYhr3Vh7aROZS3bPvab7lNq2uGRmCWqCVJJjhstl2bZE6mnYU3sh1nIH8NWQkevpHT
 npzTI4XqCFVVf2yt1nMSodvOIumChq5LDdoDGaBd4qTh+Xc98L9NI/gI8oa2QkHcrQn+
 CTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907090; x=1743511890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d589mvMFWRrlFPyVYTwDIlfolqKybPC6sioUz827GQ0=;
 b=U+4uOakCWZNXCtqPmzE5WtEstVjaiOF2s1Iw/44iyCho4je1OfxDiczyY74RxWusve
 FQTaDVcBlZRqLeEOP9YLt6RL+TY4HMmpjaG5YnGPBjKjTe2UyAHS6OGWPtJk+qdJE63o
 fC/zRCWne0+QVT/L7n+SHdCxR6gtTC/Ri4A8lZWfQDPE7/imdiB2/JCDLs2DzIJSDFbY
 Sy8aw+a8NtQjePrUuABOf+9xYlQsRjQXztOKmrldIzDZQDGmOgtl/JfhefFlYJ6SpZkx
 6RxEQNuEz5nHxt2C/cOg6ne+vDWvAtMm8TD9vwrAbESiDdRIgz3zurgDAgLHsQNJYlf0
 iEPw==
X-Gm-Message-State: AOJu0YzHL8CMwVgbTPxWMB+8qWy9V7fD/o3zedzdpTtDzTXCTDbYoIod
 LoflBTBS0/XhQKSKzCqEyKHOO7EtmO/DCT865+xbteeV6hQ9OlcD299brA==
X-Gm-Gg: ASbGncvNPCPUFQXS9/OxmF1D146ZT55KfkMDmR1EiKuEPMGNQuNNAKu36PWiXTQR+GM
 dKig8IFxgcSThZ1r880ZhpxkacYwTn7WACuPteviRTxSQ4Csbn1mWJE+aAow1OdKQLSaC4Rbw1z
 GSNiRQDrXln32gI491DBRQ/jcc7ol1VuZ7n2V7d3WrM5bxaqRbfaKSKcoXqcO7xLWvQIFuh6vsd
 b6CQdXYy6+UVK5rbbpL0K4UN2AMmZcjmPs3Wy7wGdq0J6lF265/boyu1JXyEEiJzivarH74b0p7
 /k3DgWwx33NgIImh6qC2AhvNAnl+E+XWCDw9who6YVhwJoP6Ct7K9xngVA==
X-Google-Smtp-Source: AGHT+IFl2azTA5o14rT9Y+hzeacOOG2OFQ37KzV+4xmWdNmSAFCkLumkC/qW8GrcCrDaiahrdq90qw==
X-Received: by 2002:a17:90b:3b8c:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-3030fe9e9famr26686761a91.17.1742907090169; 
 Tue, 25 Mar 2025 05:51:30 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ea2:dde8:5d21:f750])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf636122sm14246785a91.45.2025.03.25.05.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 05:51:29 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250325
Date: Tue, 25 Mar 2025 09:51:26 -0300
Message-Id: <20250325125126.612733-1-festevam@gmail.com>
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

The following changes since commit cc9dcba9cce185d8bca2dc5c4b55b21f4505cbe8:

  configs: Remove duplicated bootcmd 'mmc dev ${mmcdev}' (2025-03-20 08:18:35 -0300)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250325

for you to fetch changes up to 6bd1b740dd09f852ed3f313bd05f31c2324a916a:

  imx: imx9: Imply CPU_IMX by default (2025-03-25 08:32:16 -0300)

u-boot-imx-next-20250325
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25324

- Imply the i.MX thermal driver by default on imx8, imx9, imx8m.
- Add clk_resolve_parent_clk() and fix up iMX clock drivers.
----------------------------------------------------------------
Adam Ford (8):
      board: beacon: imx8mp: Fix GIC clock for Overdrive mode
      imx: imx9: Imply IMX_TMU
      cpu: imx8_cpu: Expand get_imx_type_str list of supported CPUs
      imx: imx8m: Imply IMX_TMU
      cpu: imx8_cpu: Print Speed grade if IMX_TMU
      imx: imx8m: Imply CPU_IMX by default
      imx: imx8: Imply CPU_IMX by default
      imx: imx9: Imply CPU_IMX by default

Marek Vasut (25):
      clk: Add clk_resolve_parent_clk()
      clk: clk-mux: Fold clk_register_mux()
      clk: clk-mux: Use struct udevice instead of struct device
      clk: clk-mux: Resolve parent clock by name
      clk: imx: Pass struct udevice into imx_clk_mux*()
      clk: imx: Pass struct udevice to clk_register_mux()
      clk: clk-gate: Use struct udevice instead of struct device
      clk: clk-gate: Resolve parent clock by name
      clk: imx: gate2: Use struct udevice instead of struct device
      clk: imx: gate2: Resolve parent clock by name
      clk: imx: Pass struct udevice into imx_clk_gate*()
      clk: imx: Pass struct udevice to clk_register_gate*()
      clk: clk-composite: Use struct udevice instead of struct device
      clk: clk-composite: Resolve parent clock by name
      clk: imx: Pass struct udevice into imx_clk_composite*()
      clk: imx: Convert clock-osc-* back to osc_*
      clk: imx: Pass struct udevice into imx_clk_pllv3*()
      clk: imx: pllv3: Resolve parent clock by name
      clk: clk-divider: Use struct udevice instead of struct device
      clk: imx: Pass struct udevice into imx_clk_divider*()
      clk: clk-divider: Resolve parent clock by name
      clk: clk-fixed-factor: Use struct udevice instead of struct device
      clk: clk-fixed-factor: Resolve parent clock by name
      clk: imx: Pass struct udevice into imx_clk_fixed_factor*()
      arm64: imx8mp: Gracefully handle disabled ENV_IS_IN_SPI_FLASH

 arch/arm/mach-imx/imx8/Kconfig                    |   2 +
 arch/arm/mach-imx/imx8m/Kconfig                   |   3 +
 arch/arm/mach-imx/imx9/Kconfig                    |   3 +
 board/beacon/imx8mp/spl.c                         |   2 +-
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c |   4 +-
 drivers/clk/clk-composite.c                       |   4 +-
 drivers/clk/clk-divider.c                         |   7 +-
 drivers/clk/clk-fixed-factor.c                    |   6 +-
 drivers/clk/clk-gate.c                            |   5 +-
 drivers/clk/clk-mux.c                             |  47 +--
 drivers/clk/clk-uclass.c                          |  18 ++
 drivers/clk/imx/clk-composite-8m.c                |   4 +-
 drivers/clk/imx/clk-gate2.c                       |   5 +-
 drivers/clk/imx/clk-imx6q.c                       |  80 ++---
 drivers/clk/imx/clk-imx8mm.c                      | 254 ++++++++--------
 drivers/clk/imx/clk-imx8mn.c                      | 246 +++++++--------
 drivers/clk/imx/clk-imx8mp.c                      | 348 +++++++++++-----------
 drivers/clk/imx/clk-imx8mq.c                      | 226 +++++++-------
 drivers/clk/imx/clk-imx93.c                       |   8 +-
 drivers/clk/imx/clk-imxrt1020.c                   |  42 +--
 drivers/clk/imx/clk-imxrt1050.c                   |  78 ++---
 drivers/clk/imx/clk-imxrt1170.c                   |  30 +-
 drivers/clk/imx/clk-pllv3.c                       |   9 +-
 drivers/clk/imx/clk.h                             | 116 ++++----
 drivers/cpu/imx8_cpu.c                            |  54 +++-
 include/clk.h                                     |   9 +
 include/linux/clk-provider.h                      |  10 +-
 27 files changed, 841 insertions(+), 779 deletions(-)
