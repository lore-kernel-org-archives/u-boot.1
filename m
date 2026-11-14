Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD7606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y+6njrHN;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=tQFtcd2n;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=FcgtTMyI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB20D409E6;
	Sat, 14 Nov 2026 16:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FBhWGyERaC8; Sat, 14 Nov 2026 16:22:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CED3A409D3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673327;
	b=AcubQdR6tnKIBWmoY1glwFVPuIC8AvZ8LhXcJsGiS7aC9ePd7/f3nW4UKaJdaMruGPeP
	 kOqGbyETpl2baWH/BSvKBFsJXnfrYQrbZSokaAgKMRC1kNDrVPs/VXM8IXtwNTd4Znag/
	 VuAj5dvbwn4yT8SaHqGVyqVRGtKODOXzo4RdrHLnr397ho3QC70z+CVl+blYywVDiqsJj
	 7UJ/iUaT1R7uLRrv4HTGqzOLSfAgSlGkWTkaymUIq+8LUaeEj0DHodw29l4Ksn/FfinLR
	 fLmiFcXAlEUACwP0bg1frcUQNBHOiz+BAXAlP5GcB4JEI7jhubwpnKYCBtq6+U2iumA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6b2Y5Xn0qiVY0YMwVp3FghUSnfmTHkqko8YUmPWi/Oo=;
	b=DeZqrIunyvjn4OpGM6OPu20Nc9P2LS8NAZLCQGlrAXuVy3DbEPXC8aTLPTueK8n5y37c
	 4LHti+PXsNc8ptv7Axg7lBbeknLHspzCYi9+KHmTDqx61b7obsN+q9auZWgzczxtGqVGF
	 yAGPQoXfe1crwK1CByazzteI/HdkCiQoNFAfhAMrwgASQhv3X8T18IoyMl5oz3zC9neXg
	 NHLQYR+ashaP/NxrdOpMVvIJ0gLapB6no5vQrtkhDhIf04aHYog8+vYLbq90INi0RpHvg
	 l4Z/8pX3wOsQcCfnEXM0S1le9E6uCwWSIzreZyAolCn3BhXGfdXOd5jdskvzcGoFk0A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673327;
	bh=6b2Y5Xn0qiVY0YMwVp3FghUSnfmTHkqko8YUmPWi/Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+6njrHNKUBN6LwqW1hSCRvkZPNLU7IWrIHFy3fPD5XubmG+SVmjE8a3iDR5SSJU+
	 03vS4hxzPYV8AXQdS6PlbF9EQwHd29CgnJLCOeZdqVr5V8Y9uBI3udEiliiuVZDDV6
	 au9J4hKH6OzZR3lud0WSPA61zXqFoSyw8x94bLYi1ZEo85hoGBYdqiU+2+W9FUCuNP
	 dOziU/y32wgXfnd2us6DmtDrn+uuNTDtwISB9pJS75VXF4Wp+Dn44WkkmooTB9AFiI
	 sjcXCm9dtj2u0Kn4WiovzJ9wC7JI3DXTcFitsPzQhjD9rCg7hBdhNOP0YRv8wV7A36
	 Lo84kBYDVsHaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CED3A409D3;
	Sat, 14 Nov 2026 16:22:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A5F39B6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D4CD60759
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qaxl_KUBWOL1 for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9193160726
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=69.169.224.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.10;
 helo=b224-10.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd818d-c13e64f4-996f-436b-8992-900d2529b551-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=tQFtcd2n; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=FcgtTMyI
Received: from b224-10.smtp-out.eu-central-1.amazonses.com
 (b224-10.smtp-out.eu-central-1.amazonses.com [69.169.224.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9193160726
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673312;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=k2+r3uKo3MaxkcoKVQ0K1f235XBZoqHBSk4nqa78fMk=;
 b=tQFtcd2nzv+JGp5XcjtQM+2z3NV+diohEQdoGMUorsRLQobM+Wshe0JxvC6tVAd5
 aszFDfWpOnrAHF/rlBZsH1wdudFRfIJ1CTfPyoApKxkYGEK8D6YM4pslMi9geKqLWiv
 eRNr2YuZbWhSMBXR/cCJDMV9Hsi5PpxrZeEeTXQ9N1Zglqcft5XAg9MgMugthCMVPnn
 cOlLS93rT5vTdanV3WnmRS5CNmylQzKyLkzTHH7oMrHek2WO5VSLiP9h6P5N+Uc9fbS
 Vkn6grB9eFw2WD00M1147HVB/zfc3ZEEE2ykg1UA+iqsoKL8A+vs5rkCwbfSVld2mZV
 PovocMYgmA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673312;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=k2+r3uKo3MaxkcoKVQ0K1f235XBZoqHBSk4nqa78fMk=;
 b=FcgtTMyIHxK6b8jzG3PKsIoThznH2c5ny68FGYqCpfMxftB2LqbHz84WgFNrU69i
 cajszxXxFoPVscnss6bRAW/osdlRJ9FhL/nFzaCtl8leN96rn5ySTkGCtPePzPk3ECE
 ddZg75A3v1Iru+XUjsPVRR6ZXIH4opZVNyywf2A8=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:52 +0000
Subject: [PATCH v3 10/13] New SoC/board: S5L8720/N58s
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd818d-c13e64f4-996f-436b-8992-900d2529b551-000000@eu-central-1.amazonses.com>
References: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
In-Reply-To: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Vencislav Atanasov <user890104@freemyipod.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Honbo He <hehongbo918@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=10369;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=k2+r3uKo3MaxkcoKVQ0K1f235XBZoqHBSk4nqa78fMk=;
 b=l/kk3i/lmBBTU8feX7emrziqmapb83AVqFTMp01elcgFCGMwu+Y9tgFIVKCLk0r0vqA7WBEej
 uKjgt643rhdDWHQargINV7/NnlTxmp/TDOpbQFTeiiPi5dALrSUNgMS
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.10
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marketing name: Apple iPod nano (4th generation)

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/dts/s5l8720-n58s.dts           | 26 +++++++++++++++
 arch/arm/dts/s5l8720.dtsi               | 42 ++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig           |  1 +
 arch/arm/mach-s5l87xx/Makefile          |  5 +++
 arch/arm/mach-s5l87xx/s5l8720.c         | 18 +++++++++++
 arch/arm/mach-s5l87xx/s5l8720/Kconfig   | 12 +++++++
 arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c | 55 +++++++++++++++++++++++++++++++
 board/apple/n58s/Kconfig                | 15 +++++++++
 board/apple/n58s/Makefile               |  7 ++++
 board/apple/n58s/n58s.c                 | 57 +++++++++++++++++++++++++++++++++
 configs/apple_n58s_defconfig            | 33 +++++++++++++++++++
 include/configs/apple_n58s.h            | 15 +++++++++
 12 files changed, 286 insertions(+)

diff --git a/arch/arm/dts/s5l8720-n58s.dts b/arch/arm/dts/s5l8720-n58s.dts
new file mode 100644
index 00000000000..033127ebe28
--- /dev/null
+++ b/arch/arm/dts/s5l8720-n58s.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (4th generation)
+ *
+ * target-type: N58s
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8720.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n58s", "samsung,s5l8720", "apple,arm-platform";
+	model = "Apple iPod nano (4th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x02000000>; /* 32 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8720.dtsi b/arch/arm/dts/s5l8720.dtsi
new file mode 100644
index 00000000000..1c6853deaa6
--- /dev/null
+++ b/arch/arm/dts/s5l8720.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8720 SoC
+ *
+ * Other names: M2S
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8720", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm1176jzf-s";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate.
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer5", "timer6", "timer7", "timer8",
+					   "uart0", "usb-otg", "usb2-phy", "bootrom";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <59 133>, <60 134>, <69 150>, <70 151>,
+						  <41 135>, <2 0xffffffff>, <35 0xffffffff>,
+						  <13 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
index 11eeb4d7467..6a873f10675 100644
--- a/arch/arm/mach-s5l87xx/Kconfig
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -59,5 +59,6 @@ endchoice
 
 source "arch/arm/mach-s5l87xx/s5l8701/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8702/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8720/Kconfig"
 
 endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
index 4cccb797da2..62564a34645 100644
--- a/arch/arm/mach-s5l87xx/Makefile
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -14,3 +14,8 @@ obj-$(CONFIG_S5L8702) += relocate.o
 obj-$(CONFIG_S5L8702) += s5l8702.o
 obj-$(CONFIG_S5L8702) += s5l8702-otg-phy.o
 obj-$(CONFIG_S5L8702) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8720) += relocate.o
+obj-$(CONFIG_S5L8720) += s5l8720.o
+obj-$(CONFIG_S5L8720) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8720) += s5l87xx-timer.o
diff --git a/arch/arm/mach-s5l87xx/s5l8720.c b/arch/arm/mach-s5l87xx/s5l8720.c
new file mode 100644
index 00000000000..84d049ec4f0
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8720.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8720 (ARM1176JZF-S)\n");
+	return 0;
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8720/Kconfig b/arch/arm/mach-s5l87xx/s5l8720/Kconfig
new file mode 100644
index 00000000000..ce3db2e7c78
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8720/Kconfig
@@ -0,0 +1,12 @@
+if S5L8720
+
+config TARGET_N58S
+	bool "Apple N58s - iPod nano (4th generation)"
+	default y
+	help
+	  Apple iPod nano (4th generation) is a digital audio player, introduced in
+	  September 2008. It has a NAND flash of either 8 or 16 GiB.
+
+source "board/apple/n58s/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c b/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c
new file mode 100644
index 00000000000..058ae8406ab
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/clk.h>
+#include <linux/delay.h>
+
+struct s5l87xx_otgphy {
+	u32 pwr;		// 0x00
+	u32 con;		// 0x04
+	u32 rstcon;		// 0x08
+	u32 unk[4];		// 0x0c, 0x10, 0x14, 0x18
+	u32 unkcon;		// 0x1c
+	u32 pad[36];	// 0x20 - 0x44
+	u32 unk44;		// 0x44
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l87xx_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+	mdelay(10);
+
+	// Disable USB suspend.
+	writel(0, S5L87XX_OTG_BASE + 0xe00);
+
+	writel(0, &otgphy->pwr); /* PHY: Power up */
+	mdelay(10);
+	writel(1, &otgphy->rstcon);
+	mdelay(10);
+	writel(0, &otgphy->rstcon);
+	mdelay(10);
+	writel(6, &otgphy->unkcon);
+	writel(1, &otgphy->con);
+	mdelay(400);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l87xx_otgphy: turning off\n");
+	writel(0xFF, &otgphy->pwr);
+	mdelay(10);
+	writel(0xFF, &otgphy->rstcon);
+	mdelay(10);
+	writel(4, &otgphy->unkcon);
+}
diff --git a/board/apple/n58s/Kconfig b/board/apple/n58s/Kconfig
new file mode 100644
index 00000000000..6a61a9973d9
--- /dev/null
+++ b/board/apple/n58s/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N58S
+
+config SYS_BOARD
+	default "n58s"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8720"
+
+config SYS_CONFIG_NAME
+	default "apple_n58s"
+
+endif
diff --git a/board/apple/n58s/Makefile b/board/apple/n58s/Makefile
new file mode 100644
index 00000000000..293c92895e3
--- /dev/null
+++ b/board/apple/n58s/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n58s.o
diff --git a/board/apple/n58s/n58s.c b/board/apple/n58s/n58s.c
new file mode 100644
index 00000000000..ec6dbf01714
--- /dev/null
+++ b/board/apple/n58s/n58s.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/clk.h>
+
+static void board_gpio_init(void)
+{
+	// UART0
+	u32 gpio = readl(S5L87XX_PCON(0));
+
+	gpio &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	gpio |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(gpio, S5L87XX_PCON(0));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+static void board_vic_init(void)
+{
+	// Disable all VIC interrupts.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable clocking */
+	board_clock_init();
+
+	/* Configure VIC */
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable UART clocking. Runs before the FDT is set up, so ungate uart0 by
+	 * raw {gate, bit} ({1,9} + {4,7}) rather than the device-tree name lookup.
+	 */
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/configs/apple_n58s_defconfig b/configs/apple_n58s_defconfig
new file mode 100644
index 00000000000..137941209e1
--- /dev/null
+++ b/configs/apple_n58s_defconfig
@@ -0,0 +1,33 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8720-n58s"
+CONFIG_S5L8720=y
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART=y
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_FIT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_CMD_DFU=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_DFU_RAM=y
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/include/configs/apple_n58s.h b/include/configs/apple_n58s.h
new file mode 100644
index 00000000000..79192cc4497
--- /dev/null
+++ b/include/configs/apple_n58s.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 192K SRAM total, first 64K is the fastest, then 128K slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00030000
+
+#endif	/* __CONFIG_H */

-- 
Git-157)

