Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F15EC36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63FBA806FC;
	Mon, 24 Mar 2025 19:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Oyede8hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95EC8808AF; Mon, 24 Mar 2025 19:00:59 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013A08186D
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso43528565e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742839256; x=1743444056;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=634baF+8vyDp0dvmy7CnoRrw+gWbjJIGLJPMeou/TbE=;
 b=Oyede8hmswbmKvyZfZGFCHiTbN/Kv982nlCwUNMEyNiDUvMs+qXzle3WM1pNZEUEep
 V1Tte0+6LQuPRuac6EMK+xoSDGOm/lyZAWvztoSSjZL2qtETxid7Dw7QGRBcemCa0VzC
 ZOFja1RdejO0nshggNY3oB1jYmDQTHi7IbD8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742839256; x=1743444056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=634baF+8vyDp0dvmy7CnoRrw+gWbjJIGLJPMeou/TbE=;
 b=Qut11YSW5Sj6Os7wYE8fNn8Dpt+XG7mP9AkG4qqnX26l2Lq4dzDme1ESHFUSkjZNBa
 ZyjI8AmzS6C+509nZa29z7fxaT9jYJogfkucE0TVP04EpNLdLGOWPu7FxIWSrkOriILZ
 Uo3kKgH5J4g3fANDAhYNFfzrlC+7z5ON9atS5nE9keuwQ+YFFzTqcrkRuVV2RgIEZcte
 6vMJcE0NpyNrNiq5FOLokemmF2BMubh7H+f9FVKRFjTHVVFlq2fva3BnlADV3Sc8yBcY
 z7+qo2duBFlTh6kAhANRBhIQEIqMFi0NxFcOwxxdcTMCbC4rPM66NzcjZuOwWVg1+Tl6
 NmiQ==
X-Gm-Message-State: AOJu0YzT3FuPbtBGM/a2ymqQfpUzhcI0jZA2lbFP7VvlK2DpJgY9fxFo
 ewWeIeoCn1BqUpPBWmLlh+sOU1yLXRtMurAAH0QqB1As0YrWu42OLVcXtKDXcMGW0583PX3EaIV
 T
X-Gm-Gg: ASbGncsEfNSRwixAjL2pPXXIysGFgY66X+SQsiz6UFAQJ6Cs3+GuAnM6V7mUA/Oz/jD
 iTP7GprqOB8pnfVX00NWh6xSB+aOevK2ohRwseiHHkWa8QkUmyNeD++eou7i/y951jJB1SOFaCI
 NUkQVfGTje6kP/Ao/IFymkGoPZMrngdm3MTCdazCJX82ghTDsP2uOcGBBgzZ5msYLOYH1HhEfFt
 5UbbWZHCD2NwRgN7MEy1mxa4tB95h03cm9w5oue1kZ9nGoaOlQsgvtpkrTGLQJT8KXyxv4fRz6/
 4vigQfQwYw27nwTNVjDGW1BwP76FEypeN62TV4rWdTZ/Zkeq/LPfwZ0XX5ttGZa5bJSyerT0le6
 9VNoi3ZGm1wMibTSr+ia/qU/HNpyG+TIUBXY=
X-Google-Smtp-Source: AGHT+IFwaItYxj5X1obGtAdJ6BEXdKr4zJY0U4rjFSiu/qn+30IVF6Nj5IXRj8fg1tnWC6Lxqkt5zA==
X-Received: by 2002:a05:600c:c07:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43d509e4640mr136027735e9.4.1742839256235; 
 Mon, 24 Mar 2025 11:00:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm178289285e9.22.2025.03.24.11.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:00:55 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 4/6] ARM: dts: add stm32f769-disco-mb1166-reva09
Date: Mon, 24 Mar 2025 19:00:28 +0100
Message-ID: <20250324180047.1571378-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
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

[backport from Linux commit db4fc2c79c533986795a7750e9a12caf9d620b48]

As reported in the section 8.3 (i. e. Board revision history) of document
UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
related to the board revision addressed by the patch:
- Board MB1166 revision A-09:
  - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK

The patch adds the DTS support for the new display which belongs to the
the Novatek NT35510-based panel family.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/Makefile                               |  1 +
 .../dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi   |  6 ++++++
 arch/arm/dts/stm32f769-disco-mb1166-reva09.dts      | 13 +++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 267b0179a5f2..8719b58152fd 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -523,6 +523,7 @@ dtb-$(CONFIG_STM32F4) += stm32f429-disco.dtb \
 
 dtb-$(CONFIG_STM32F7) += stm32f746-disco.dtb \
 	stm32f769-disco.dtb \
+	stm32f769-disco-mb1166-reva09.dtb \
 	stm32746g-eval.dtb
 dtb-$(CONFIG_STM32H7) += stm32h743i-disco.dtb \
 	stm32h743i-eval.dtb \
diff --git a/arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
new file mode 100644
index 000000000000..43dd3b993d5e
--- /dev/null
+++ b/arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2025 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+//
+
+#include <stm32f769-disco-u-boot.dtsi>
diff --git a/arch/arm/dts/stm32f769-disco-mb1166-reva09.dts b/arch/arm/dts/stm32f769-disco-mb1166-reva09.dts
new file mode 100644
index 000000000000..ff7ff32371d0
--- /dev/null
+++ b/arch/arm/dts/stm32f769-disco-mb1166-reva09.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32f769-disco.dts"
+
+&panel0 {
+	compatible = "frida,frd400b25025", "novatek,nt35510";
+	vddi-supply = <&vcc_3v3>;
+	vdd-supply = <&vcc_3v3>;
+	/delete-property/power-supply;
+};
-- 
2.43.0

