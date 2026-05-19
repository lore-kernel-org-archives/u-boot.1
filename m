Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C164CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2D7846FD;
	Tue, 19 May 2026 00:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Sx9xau/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDE9846A4; Tue, 19 May 2026 00:30:35 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79A08465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bc85eda6b6so13081455ad.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143431; x=1779748231;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hNEP+qYOlMA4IJBFdWY1TQG5awu7aX58QZBI7Ujhjao=;
 b=Sx9xau/X9PZuT2+OSOKP9RrylExPt0pgqn8+449bsHjMDLkIYpR7njqymLhOok2D7p
 fpgAueO1+ifYG3tpSb6SStJ4MJ/cIN/dtYYwhxgLtTlO0DdJvtSrk+0lRxbL0+A+xbs5
 F6cOPLENqJFeRd9fUkSGUJAHfZke0D2SjEUrRx4jowBoT/xOrn8kA7QCN2l0Svr3x7oJ
 hNeuQfEe+qyyy6xqDwRQG+N0M/WOVKvDspEaesT3/fFdQBl7art2iI8ZnJy1TMBTi19H
 vyAZBsP8FDimwcQrGCoPtB9S4yixim+7/xjUt3EZMsRkoCkbaavSBrvwK3tfL3ydgm+q
 28kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143431; x=1779748231;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hNEP+qYOlMA4IJBFdWY1TQG5awu7aX58QZBI7Ujhjao=;
 b=aSidewFfRnjVMUUF8CsYM8REFc6bjL3XkczaFjdzpRXoM4CXtOPRkF1FOe2/PVhWCL
 job8i+kV5QYcn/WzM2j1o5tbX0V77bpjtrfhsABVPzUGHkItoGTGyHL95Lm/J7+m+UAS
 dWpjjlAH+135YdCfd2YHlIDttxDMXsyVBLhYkx1M1l/Qs6+LrUYSBk9taT/Ni2bKq8Wv
 yfeZAhOs/VdPugAyKFdvOQTOhI13XxGWuBkFMqp6FPTCAhXC7ROjZL06w2EMKpawL/7k
 Rjx+T0/CFVx1nVPmBwoskq+SQd0Qgj6gLIwdoloZUKFE8xEns8v4e29B7BzxpQOJNrg8
 /bWw==
X-Gm-Message-State: AOJu0YwfR/ZAE2wNVxjuyAbSVzBOVaEtf65ci2K/dtmeWpEK+UYaosuh
 DvdPpSmDUnxkry1JMEJJae7fCe1ECK9S40OkIf+hyPV01T+YNCWgsMyCaZIKIR5CDwQ=
X-Gm-Gg: Acq92OEctFjBABoj30vpg6FmZb0bagvvKB8FjW0QzNynLCSsp8QMgpftISyefMn0PhW
 PWl1l/tMeuT9WBz7CSBbYD3j/1QadTG5WBZU3r329fqe33iqx0YsTwRwjJf6Z8Z5255X8mhAaby
 /q78dHOn0KAdKWgDl9xEs1DtVqTd+uXi9WomLHJ8q/KuYgwwcOVdCF3TYCFd/0Db4AEdgOfae4N
 QiazaWREfBVWidPU+pdLnougAibDm4FdlORndh1LqL5uybX9ljRDx4yIBq4+HwPWMAueFQ2/0Nh
 /Af8H0qWe4h9wNJzXUFt9zXyzshbgchk6CWXyJLt0SR1lRpypTuFw1rStHhIWOsbei+pmfVoGA6
 Ha3mms36e8sdjd1M+/kAiaDLhMPbZ4nh4+vWVTxJ7ZlSCyEkyhyCXDaiZaROLwsDe/taqtpL1mX
 2AHPqLsvx6r52BmrCttwQCqnwYWvc1v46NnvThdJO3qNM=
X-Received: by 2002:a17:902:bc44:b0:2b4:604c:ec6f with SMTP id
 d9443c01a7336-2bd7e94c9edmr126704565ad.32.1779143431351; 
 Mon, 18 May 2026 15:30:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:30:30 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:25 -0400
Subject: [PATCH v4 07/14] board: k1: initialize clock and serial devices in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-7-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

From: Raymond Mao <raymond.mao@riscstar.com>

Initialize clock and serial devices in SPL. Otherwise, the device
driver won't be loaded in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v4:
- No change.
---
 board/spacemit/k1/spl.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index e15cf5f1abf..78f26616347 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -3,8 +3,45 @@
  * Copyright (c) 2025-2026, RISCstar Ltd.
  */
 
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <log.h>
 #include <spl.h>
 
+static void clk_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@d4090000", &dev);
+	if (ret)
+		panic("Fail to detect clock-controller@d4090000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4050000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4050000\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4282800", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4282800\n");
+	ret = uclass_get_device_by_name(UCLASS_CLK, "system-controller@d4015000", &dev);
+	if (ret)
+		panic("Fail to detect system-controller@d4015000\n");
+
+	if (device_active(dev))
+		log_debug("clk: device is active\n");
+	else
+		log_debug("clk: device not active, probing...\n");
+}
+
+void serial_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SERIAL, 0, &dev);
+	if (ret)
+		panic("Serial uclass init failed: %d\n", ret);
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -15,6 +52,8 @@ void board_init_f(ulong dummy)
 
 	riscv_cpu_setup();
 
+	clk_early_init();
+	serial_early_init();
 	preloader_console_init();
 }
 

-- 
2.43.0

