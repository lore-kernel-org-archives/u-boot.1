Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10BC36002
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 01:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE39782BCD;
	Mon,  7 Apr 2025 03:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i72SILDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1C982BF3; Mon,  7 Apr 2025 03:35:35 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72C082B9D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 03:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2295d78b433so33897415ad.2
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743989730; x=1744594530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H/8ynHvWh7awCBJB5kkCN7bc7IfKpF8BL7z/gPfes9w=;
 b=i72SILDeqCYXqaeoiCL/iqp3b/4xvEjlcQ5bFCpnWC4Yv5zcwK0IoaJLhPMhMBOnv/
 bZFjAp1qCHbXZQJp12uYjKE++qyw3raQ68FQdFcDwsxIDA1M5LSxxVub4wLb2+wdnqTd
 9jl47osXugQ7P4v5GnJSx+TvFFvFevaRy3CHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743989730; x=1744594530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H/8ynHvWh7awCBJB5kkCN7bc7IfKpF8BL7z/gPfes9w=;
 b=cux42Iz9iK2DtFZF5sIF8aUx4O0QipDiqPtLWrermyLvBiELqWmSRffSpH9GfjxRQE
 B3guFARfR0BP3ZANdAtfPWqWQmSHktC1r30LQoEXYstQhCSoGYVwR9poprbpySK5wR0B
 Xl8PpM356JWmba50KFQekDVuAwGoofK8rTpz28SGnAfMWg1wda57oR2wFWDjwjNPg8Zp
 LGAU8hHIcjF6nr47DxwdeVAB+k9XtqA8lrmP2VoInwfyE8e1ucQuiVgzB0gU+hwvZtJ0
 vfZV/nP7XLJ73c/pq1MiMFbgvnqRBV6h1fQveapeWUG+g1HESnuYEAu9kPqAzUMaTLO/
 D3nw==
X-Gm-Message-State: AOJu0Yxip/HIlymeRzPnDQxPIL+5qDr8cAbkcMJwNFfL40oZ72LAZmQm
 Z2cJMXCDrt8+u91KfXDuCycHtgkfBqFCNNmghAOVkgtIBKlJfT4ZLt0KOB+YLL46w6T8XOQoCbA
 gLQ==
X-Gm-Gg: ASbGncsJ8Z2Xpw0afwrWHhsOOQzonOAUhkdFia2wzzBjMbxWpmo14I2ZdOUKOsweBZt
 rwP1JUASsNW2IEEYaaDG50XC0jaHepKp0BMJKtl6Qo3jd1dlB7zMxkLAiyfF5+TL2Ume4up6RQW
 xCbYLYlGmiz8ATVL+JXWJZVr8Ey0f2weldR+M+r4wZJE8/Ba4VZ7D/17SbArq56DUqqHZUypDSk
 i2YGeunWtNi1CPdEJJ6rx2QEKFDMdP0Iu42pAjyuglXyFn8zTu5Yzndj/yg5WTNSOVfkFn5h26S
 YMSqsL/h59+jWCf7jrSC9qEuB9vl1VkXvd0WS4Ug/eVgfyH61ouq3zaYGJ4=
X-Google-Smtp-Source: AGHT+IF6qfpZtGvUt2BOjU2x+PXSxSfxqKyca35jL9bX7uvtHVtZkeQUBv/dQAn+QcCXewrIfsPRiQ==
X-Received: by 2002:a17:902:e5c4:b0:225:adf8:8634 with SMTP id
 d9443c01a7336-22a8a0b3f58mr136658615ad.51.1743989730618; 
 Sun, 06 Apr 2025 18:35:30 -0700 (PDT)
Received: from chromium.org ([161.29.84.47]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 18:35:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rick Chen <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot-amlogic@groups.io
Subject: [PATCH v2 0/4] dm: net: Assorted patches related to networking and DMA
Date: Mon,  7 Apr 2025 13:35:06 +1200
Message-ID: <20250407013513.638110-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

This series collects together a few patches related to U-Boot leaving
DMA running when booting.

Changes in v2:
- Use the designware_eth_remove() method directly
- Add gmac_rockchip too
- Reword the commit message to mention the uclass' actions
- Add a new patch to mark drivers as having active DMA

Simon Glass (4):
  designware: Use the remove() method with related drivers
  net: designware: Mark drivers as having active DMA
  efi_loader: Move device-removal later in exit-boot-services
  dm: core: Rename dm_remove_devices_active()

 arch/arm/lib/bootm.c          |  4 ++--
 arch/riscv/lib/bootm.c        |  2 +-
 arch/x86/lib/bootm.c          |  2 +-
 drivers/core/root.c           |  2 +-
 drivers/net/designware.c      |  4 ++--
 drivers/net/designware.h      | 12 ++++++++++++
 drivers/net/dwmac_meson8b.c   |  3 ++-
 drivers/net/dwmac_s700.c      |  3 ++-
 drivers/net/dwmac_socfpga.c   |  3 ++-
 drivers/net/gmac_rockchip.c   |  3 ++-
 include/dm/root.h             |  6 +++---
 lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
 test/dm/core.c                |  2 +-
 13 files changed, 44 insertions(+), 23 deletions(-)

-- 
2.43.0

base-commit: d47b5693e21f78d8cd8caa8fcd9e64fd6ae85759
branch: eth2
