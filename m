Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F07C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E0C8366C;
	Sat, 24 May 2025 01:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JsbYuk0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED66A83416; Sat, 24 May 2025 00:59:27 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707638338C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b26ee6be1ecso214793a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041164; x=1748645964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yq5wgqbMAs0DcqXSGyjpyUTajIBzFtmL7NdeuCP05UU=;
 b=JsbYuk0emS8GrlxZei45tUw9NKnD4MOZOjN9B3LLSOE0oXKN5M74SkfaccMYV2b8Zw
 /nym6cwU/m+TNZSub7X71HJEYSk0k4izP3M8AG8yfiZHnfx7gwE/ssIqJE6ciZuOwHnm
 Eb5xBB/3iw8OFCG4Bp+okmXbyoaMlGSX+vNN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041164; x=1748645964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yq5wgqbMAs0DcqXSGyjpyUTajIBzFtmL7NdeuCP05UU=;
 b=rAO9BvaVQYGhHmO/jBc5u0rWmdw9YbQQdX8MlmUHqVKKkOQQDoL4R0QDkDAqW8fkCH
 zsSE06X5Lzkb17zX6og2qKR1V1z/EU2OGV7k7CtaJGsfmGbJpOfso/1TAY6EGxdAQZBr
 1hZEDkaMk2VX91KMXaQOxiX2hZjXjF2ybqGn9BTPKdmSPHxwlo3hwU1D6MUwkD6sk3RP
 zENw8iE8zG/OA0tWqVV4sUJ8KWniGzhXmT8lBg7Z1VzdZGa0WZlASCPDKW1RuKRyFPQx
 NEVlGz7OcaTfK5D9DlpMBNqJmVhP/lcf+rtnHQbScwDRcw99jQjzO7PvVL6Xs6bQFDhc
 6iCA==
X-Gm-Message-State: AOJu0YyJyb8NsvrDKcS2y10JueDm+Wi832gkjJj9eE4G4FA71OrWO6PO
 nNGWAGDvbNB/H/dMcTprMq2VV5lNA/LjlOWonbI8WKw05PckUyp89ng2dXbZL375cD83JzPUmuE
 /u9c=
X-Gm-Gg: ASbGncv6zo6Z9TlpPHH8j5ho3GP8U/o8/anwZ3XI7WalP66xWqs8VRvAzQcU2U7BUUc
 1lxmb8HGAO9AJOIjONIltdDjbBHwu8qfyVhEVaualXn7MhqpmbgT1/3B3HOAVF5RjMIM+oNs9sO
 awJkMmDFMBirHD612aISsIY18WLknlbmCfGQ3LV1WKYvcqsAXdP6g+xJ1nM9bpx0y7IxLd1wF6p
 xLVr3DQWoIs7ce7uBXIt3hqhrlJAumaKAFag39ZtVIzn3vkOxECuIsdjGOIsxMmNqYQPciwm8an
 Qt0xbAnJbZjE+0rDOUiZqhBgI5y7Nl12LDP5x8ooniXcP63nESCK2kiuQ8llbvPcyd8K67P0o/F
 1DhM5+OXJ2fPZVWc=
X-Google-Smtp-Source: AGHT+IH6V5Uk7SdbHkeznbtJ+ylIW0UaJ9gd/eiayGpQwaF8gXftI5nGcYr7ol/1ADaecctZUPmAXg==
X-Received: by 2002:a17:902:d4c8:b0:22f:b040:9751 with SMTP id
 d9443c01a7336-23414fce4eamr16408815ad.45.1748041163786; 
 Fri, 23 May 2025 15:59:23 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-231d4eba220sm128152755ad.165.2025.05.23.15.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:23 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 24/28] board: google: Add board_debug_uart_init() for
 Trogdor
Date: Fri, 23 May 2025 15:58:39 -0700
Message-ID: <20250523225845.2311989-25-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Implement board_debug_uart_init() for Trogdor boards so that the debug
UART can be used. Initialize the clk to XO speed (19.2MHz) and change
the pin configuration to mux out the uart hardware on the pins that are
connected to the closed case debug (CCD) port for the AP. This is enough
to get the early debug console working on boards like Lazor, but it
should work for all Google Trogdor boards.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 board/google/trogdor/Makefile     |  3 +++
 board/google/trogdor/debug.config |  6 +++++
 board/google/trogdor/debug_uart.c | 41 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 board/google/trogdor/Makefile
 create mode 100644 board/google/trogdor/debug.config
 create mode 100644 board/google/trogdor/debug_uart.c

diff --git a/board/google/trogdor/Makefile b/board/google/trogdor/Makefile
new file mode 100644
index 000000000000..fd2933cf1e6f
--- /dev/null
+++ b/board/google/trogdor/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DEBUG_UART_BOARD_INIT) += debug_uart.o
diff --git a/board/google/trogdor/debug.config b/board/google/trogdor/debug.config
new file mode 100644
index 000000000000..7d8a6706a92e
--- /dev/null
+++ b/board/google/trogdor/debug.config
@@ -0,0 +1,6 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xa88000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=36864000
+CONFIG_DEBUG_UART_BOARD_INIT=y
diff --git a/board/google/trogdor/debug_uart.c b/board/google/trogdor/debug_uart.c
new file mode 100644
index 000000000000..3d15d0d77728
--- /dev/null
+++ b/board/google/trogdor/debug_uart.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/io.h>
+#include <debug_uart.h>
+#include <linux/delay.h>
+
+/*
+ * Enable the UART8 clks and pinctrl settings for SC7180.
+ *
+ * The debug UART goes out over CCD. The debug uart clk setting is 36864000 to
+ * make the buad rate calculation come out properly for the qcom geni serial
+ * driver.
+ */
+void board_debug_uart_init(void)
+{
+	u32 val, mask;
+	unsigned int timeout = 100;
+
+	/* Enable wrap1_s2 clk */
+	val = readl(0x100000 + 0x52008);
+	val |= BIT(24);
+	writel(val, 0x100000 + 0x52008);
+	/* Wait for enable */
+	do {
+		val = readl(0x100000 + 0x18274);
+		mask = GENMASK(30, 28) | BIT(31);
+		val &= mask;
+		if ((val & BIT(31)) == 0 || ((val >> 28) & 7) == 1)
+			break;
+		udelay(10);
+	} while (timeout--);
+
+	/*
+	 * Configure GPIOs
+	 * Bits: 0-1 = pull
+	 * Bits: 2-4 = func
+	 * Bits: 6-8 = drive strength
+	 */
+	writel(0x3 | (1 << 2), 0x3900000 + (0x1000 * 44)); // Pin 44 - PULL_UP, func1 (qup12), 2ma
+	writel(0x3 | (1 << 2), 0x3900000 + (0x1000 * 45)); // Pin 45 - PULL_UP, func1 (qup12), 2ma
+}
-- 
Sent by a computer, using git, on the internet

