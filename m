Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C5D42BBF
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050B789432;
	Tue, 12 Nov 2024 19:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OXSdMBCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35138927A; Tue, 12 Nov 2024 15:57:53 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE12A89448
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FF5340007;
 Tue, 12 Nov 2024 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1731423470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOkK1PsSWVZzwSEoZtGTyzngDRpdFE6oZTu3/N36TgY=;
 b=OXSdMBCF2NnCADW9leyIWK9kiM/tk6V8XgX2drAeQInpBqcqKeKuzbX8PyMra1SHPkdvAN
 MptgcGX5cLssW+qShBR2fewyw/5IdVF9q70+rsQ7UQEMleLHprs3WqNme9KdBZWfMsHgWK
 Ak2sbIO/gLlWWttf0+eKX5EyGJ8N1Rj8BHWhkpNQaVMCLjdrNmk7n1Fjz62OkUMnPCYYPt
 fsCySaE7xGpnM/J5uR7JcWoM85qAvWLi/di7thP3tPBpxYm7V/87RrWAAoAy6lG8DboDoE
 9nucEmuBfQ0QLp2RqB3O0flBfmKZB5XtsSxxvlTYnbgrMX4mYNQvKek6cYHCHA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 12 Nov 2024 15:57:37 +0100
Subject: [PATCH 2/3] riscv: dts: sophgo: add device tree for LicheeRV Nano
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-licheerv-nano-v1-2-bf75d1eb560e@bootlin.com>
References: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
In-Reply-To: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: thomas.bonnefille@bootlin.com
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

Import a slightly modified version of the LicheeRV Nano and SG2002
device trees from the Linux Kernel. The current supported IPs are UART,
MMC, Timer, PLIC and CLINT.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/dts/Makefile                   |  1 +
 arch/riscv/dts/sg2002-licheerv-nano-b.dts | 45 +++++++++++++++++++++++++++++++
 arch/riscv/dts/sg2002.dtsi                | 34 +++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 17cda483e128996bb944f5a2b9b7676d32e45ae5..0848cded398d45955dcc17b339dc1869829c6467 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -3,6 +3,7 @@
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
+dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
diff --git a/arch/riscv/dts/sg2002-licheerv-nano-b.dts b/arch/riscv/dts/sg2002-licheerv-nano-b.dts
new file mode 100644
index 0000000000000000000000000000000000000000..9871a75836c04a0b0943dc44c6a1090c90752dbd
--- /dev/null
+++ b/arch/riscv/dts/sg2002-licheerv-nano-b.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ */
+
+/dts-v1/;
+
+#include "sg2002.dtsi"
+
+/ {
+	model = "LicheeRV Nano B";
+	compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", "sophgo,sg2002";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/dts/sg2002.dtsi b/arch/riscv/dts/sg2002.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..0f97000fa8beaaa10a08d03211f7c4a0c2f6e001
--- /dev/null
+++ b/arch/riscv/dts/sg2002.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "cv18xx.dtsi"
+
+/ {
+	compatible = "sophgo,sg2002";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+&plic {
+	compatible = "sophgo,sg2002-plic", "sophgo,cv1800b-plic", "thead,c900-plic";
+};
+
+&clint {
+	compatible = "sophgo,sg2002-plic", "sophgo,cv1800b-clint", "thead,c900-clint";
+};
+
+&clk {
+	compatible = "sophgo,sg2002-clk", "sophgo,cv1800-clk";
+};
+
+&sdhci0 {
+	compatible = "sophgo,sg2002-dwcmshc", "sophgo,cv1800b-dwcmshc";
+};

-- 
2.47.0

