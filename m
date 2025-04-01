Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AC1C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58E481FC0;
	Tue,  1 Apr 2025 09:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WEk/6N4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A436E81E6C; Tue,  1 Apr 2025 09:01:37 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8FF80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso2889664f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1743490895; x=1744095695;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhbjrMtU46LbUzCOqT3OHGhciFay44vkvwWGQgfiFJo=;
 b=WEk/6N4NgDt1xQ4f5WQAzHOupIunN5tSU4PLZUYIc4Umbx20XyIhr3PqEj/I9hHViu
 9Rr5/jWBKHVrZYR+bIaVJLVRUKSThUA9tLkFuDKfgevqvtLcftiWhGT+uGymH78rgCu5
 /ZvC4mXk27HPllP86cdHUDgER0VAIMIFyMezc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743490895; x=1744095695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhbjrMtU46LbUzCOqT3OHGhciFay44vkvwWGQgfiFJo=;
 b=qAtOqH1qYHjCSowjXyhYDgHNhhWzW9CL1+mabAV+TM0UCcXJiznUSqmrJHTbaeWtgt
 KjuHc/ADnrjkO0fUeUmxSudG1bbxjYiE2lDzgUpY0XGdpEtPXkNKo6K0owmsAtnqwI57
 KlKOp6cl4Ms0xIoDYZbGNIkAraP5YwgXapZ73AMTS+sjX9Q0eByqJ3RBIYCeVlot/r6W
 LTwP2Jy1Foc0UJm+hsROaUsvmDji3qn2JR+wj4bA4VYXHkv7r78Dmkksg4GqMr2Q2RP/
 BOr5b2WH659tZ24wsa1hcZFJr1bBSmY9jXDB991WezK6SNFqeYQFHE2Yd3PCBAM/vNKP
 eumw==
X-Gm-Message-State: AOJu0YzAuewn8qMjJU6waHEjSpn650rJzo+MHpq/+muUtUMXKMPBMoCj
 UjjMEetQ1fRZi+/PtowftJUEIBTT08qRbvOiSRQZYUO7nJmFrLLLNZIGXa6Gc+Tybc3OynUB8L/
 c
X-Gm-Gg: ASbGnctn1q2JW5hp52l2jGjwDQ/8fkQQhWJlET/6RMGGYFYWsS0x3JBitl4tOyjBTe1
 ZlBm06vo1/LBSHa99Xq9fGxFcrcti4xlTCD/vK+Xxem86jNOPNy2qStjtXdEKfLPh9yLx21cF91
 nL8AxutNRpKnjeXS/D7ZEbHP1rhhkumfF6oSOiGLnl5QYghnW7Wjq8oH2mJMnDbVKdSXx+nRyNr
 F70F7WBalipm2o6GEn/4ImDRlToK3cCFMCJbhj7JF9leyHTjcMjhAspywYTia1U8363cMGsFRlJ
 zVAX6MkkWE111m6vjjoa7cTjE8jLLAk8JvOKvvH1IVoLGYV0P/rgFidX3Aq78icWnVCuckvOxSz
 yOV77yCDZUQ==
X-Google-Smtp-Source: AGHT+IFETkr1GFBzVdS4a1t66eOFePgTZI/+zqsgH3LGBbJTNBavPRLaZd9DIMFYyarrQ2iWrhMmQA==
X-Received: by 2002:a05:6000:420a:b0:391:3998:2660 with SMTP id
 ffacd0b85a97d-39c120cb8aemr8465713f8f.7.1743490894837; 
 Tue, 01 Apr 2025 00:01:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13701760f8f.54.2025.04.01.00.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:01:34 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 4/6] ARM: dts: add stm32f769-disco-mb1166-reva09
Date: Tue,  1 Apr 2025 09:00:55 +0200
Message-ID: <20250401070125.3705126-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
References: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Reviewed-by tag of Patrice Chotard

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

