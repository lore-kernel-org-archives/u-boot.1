Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD9CC61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B859982BAA;
	Sat,  7 Jun 2025 11:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IsSLsprD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C6C282C03; Sat,  7 Jun 2025 11:37:46 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5974582B07
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad89c32a7b5so454344666b.2
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289064; x=1749893864;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NO5t2sCjJwDY57c4qoGlRa7h3BkXE9AaZMo2w9AJr4=;
 b=IsSLsprDCoTwT/OdcLb4vU2lvmVFVeyoEfBWY2EY9+PORVZ5PXKa9fM5giRH8o2DQ6
 Hp4tV3Z6zuqzrjlMejDclGKpAKwu5zmCnJEA8jmqik1qBfjHB9CwlfA/E4zBJqqs9v3c
 6UlO9Eh+oOrLKBUexkP3nOMNKVxMVCIthaemY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289064; x=1749893864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NO5t2sCjJwDY57c4qoGlRa7h3BkXE9AaZMo2w9AJr4=;
 b=HKZnN0mtxhuVpXFz0EEXMX2hL7lIwhaddZu0btuu6MPJbtFqWwaVwF+lBrASvkyDNT
 kcfc84gj2JlHYsP9IsVjgUN13q3tVqc57v4UqWPfLMYvnv5M0L51DL87eNtxpoi8xycD
 Y4U7G9eSe+Pk+tPTO0PJDfW1nSHdNkIT+lHA8No6WjdAKuVJPwnpdT4rD8hXJ76ol5W3
 PBH7nodXXw+6uSxUZ3If7cExJmTzY/ZjvEryZjMBtyOPN5SPfJc19HxT+dsRchgmqdhE
 7FkUd6SPT5WWJIQkDssMCallRYovN3cpcac1Ha9CjM/rk/GRLXH2fWXtgHbBJC7De1T+
 ZmWQ==
X-Gm-Message-State: AOJu0YxGgy3l0FbEoPmnnHeVSuru1VZVzyWcqDNuiWtmCep0JrBxneNl
 OY0IDm690Ayk3X8oKS12FG7IOdNgnwe8xdid1kHol+3bXaRRdj2z/I01xdOjsz9LW7LFBqOyfGz
 caDf4
X-Gm-Gg: ASbGncvDHu1GP4SqrRE5PPOg7iHfPe7Bod6sdyols+i/erdyax/g1txrKl5ptLrh0+Q
 OQnjN11P1GCd+JhVbJSkpcJDy+k2oElntU7nhkxaRKH8jUBfgBuctBAxngmnJQF+GeY+pKGRo8Q
 pqI1LWApOs4eRX+FyJIg04HpOw3j5/eR41ISP5IXx0LFobzuIi3pgeNyIYL2fxsNAiYnqK0lTqr
 /9qJZnlqyO89w7YFHvQ8m4uZCoXoxGwyV7DW2QNoNeN1In66kOy1TXudYM+BPBT3nmApel26rgt
 nyetbSNsB+upId+INQtazZ6NRl0COVJFre38JlFxA7iRibliqhMd3fkjFgZTTeVf2LVdqixjHYj
 TfC1teb+MzwtblX9IKEZ7SADTkCJw4RTdGj+anyS+92WwYnoOZI2vi4HCziKPXs+b07OZBi2Dp9
 tgymChra647tOs
X-Google-Smtp-Source: AGHT+IEBowOeC9/dzflnqZN5u8XfRgr21rHywOKJFUnkT3+WO4E5ova2jAJIOXk6cSoELUV6dlioAg==
X-Received: by 2002:a17:906:4794:b0:ad5:372d:87e3 with SMTP id
 a640c23a62f3a-ade1aa157fcmr606984566b.27.1749289063562; 
 Sat, 07 Jun 2025 02:37:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:43 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dillon Min <dillon.minfei@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 8/9] ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
Date: Sat,  7 Jun 2025 11:37:16 +0200
Message-ID: <20250607093730.2249536-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
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

Add stm32h747i-disco-u-boot DTS file with FMC SDRAM node and its
pinmux settings.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32h747i-disco-u-boot.dtsi | 104 ++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/arm/dts/stm32h747i-disco-u-boot.dtsi

diff --git a/arch/arm/dts/stm32h747i-disco-u-boot.dtsi b/arch/arm/dts/stm32h747i-disco-u-boot.dtsi
new file mode 100644
index 000000000000..ff297cc91fa8
--- /dev/null
+++ b/arch/arm/dts/stm32h747i-disco-u-boot.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <stm32h7-u-boot.dtsi>
+
+&fmc {
+
+	/*
+	 * Memory configuration from sdram datasheet IS42S32800G-6BLI
+	 * first bank is bank@0
+	 * second bank is bank@1
+	 */
+	bank1: bank@1 {
+		st,sdram-control = /bits/ 8 <NO_COL_9
+					     NO_ROW_12
+					     MWIDTH_32
+					     BANKS_4
+					     CAS_2
+					     SDCLK_3
+					     RD_BURST_EN
+					     RD_PIPE_DL_0>;
+		st,sdram-timing = /bits/ 8 <TMRD_1
+					    TXSR_1
+					    TRAS_1
+					    TRC_6
+					    TRP_2
+					    TWR_1
+					    TRCD_1>;
+		st,sdram-refcount = <1539>;
+	};
+};
+
+&pinctrl {
+	fmc_pins: fmc@0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 0, AF12)>,
+				 <STM32_PINMUX('D', 1, AF12)>,
+				 <STM32_PINMUX('D', 8, AF12)>,
+				 <STM32_PINMUX('D', 9, AF12)>,
+				 <STM32_PINMUX('D',10, AF12)>,
+				 <STM32_PINMUX('D',14, AF12)>,
+				 <STM32_PINMUX('D',15, AF12)>,
+
+				 <STM32_PINMUX('E', 0, AF12)>,
+				 <STM32_PINMUX('E', 1, AF12)>,
+				 <STM32_PINMUX('E', 7, AF12)>,
+				 <STM32_PINMUX('E', 8, AF12)>,
+				 <STM32_PINMUX('E', 9, AF12)>,
+				 <STM32_PINMUX('E',10, AF12)>,
+				 <STM32_PINMUX('E',11, AF12)>,
+				 <STM32_PINMUX('E',12, AF12)>,
+				 <STM32_PINMUX('E',13, AF12)>,
+				 <STM32_PINMUX('E',14, AF12)>,
+				 <STM32_PINMUX('E',15, AF12)>,
+
+				 <STM32_PINMUX('F', 0, AF12)>,
+				 <STM32_PINMUX('F', 1, AF12)>,
+				 <STM32_PINMUX('F', 2, AF12)>,
+				 <STM32_PINMUX('F', 3, AF12)>,
+				 <STM32_PINMUX('F', 4, AF12)>,
+				 <STM32_PINMUX('F', 5, AF12)>,
+				 <STM32_PINMUX('F',11, AF12)>,
+				 <STM32_PINMUX('F',12, AF12)>,
+				 <STM32_PINMUX('F',13, AF12)>,
+				 <STM32_PINMUX('F',14, AF12)>,
+				 <STM32_PINMUX('F',15, AF12)>,
+
+				 <STM32_PINMUX('G', 0, AF12)>,
+				 <STM32_PINMUX('G', 1, AF12)>,
+				 <STM32_PINMUX('G', 2, AF12)>,
+				 <STM32_PINMUX('G', 4, AF12)>,
+				 <STM32_PINMUX('G', 5, AF12)>,
+				 <STM32_PINMUX('G', 8, AF12)>,
+				 <STM32_PINMUX('G',15, AF12)>,
+
+				 <STM32_PINMUX('H', 5, AF12)>,
+				 <STM32_PINMUX('H', 6, AF12)>,
+				 <STM32_PINMUX('H', 7, AF12)>,
+				 <STM32_PINMUX('H', 8, AF12)>,
+				 <STM32_PINMUX('H', 9, AF12)>,
+				 <STM32_PINMUX('H',10, AF12)>,
+				 <STM32_PINMUX('H',11, AF12)>,
+				 <STM32_PINMUX('H',12, AF12)>,
+				 <STM32_PINMUX('H',13, AF12)>,
+				 <STM32_PINMUX('H',14, AF12)>,
+				 <STM32_PINMUX('H',15, AF12)>,
+
+				 <STM32_PINMUX('I', 0, AF12)>,
+				 <STM32_PINMUX('I', 1, AF12)>,
+				 <STM32_PINMUX('I', 2, AF12)>,
+				 <STM32_PINMUX('I', 3, AF12)>,
+				 <STM32_PINMUX('I', 4, AF12)>,
+				 <STM32_PINMUX('I', 5, AF12)>,
+				 <STM32_PINMUX('I', 6, AF12)>,
+				 <STM32_PINMUX('I', 7, AF12)>,
+				 <STM32_PINMUX('I', 9, AF12)>,
+				 <STM32_PINMUX('I',10, AF12)>;
+
+			slew-rate = <3>;
+		};
+	};
+};
-- 
2.43.0

