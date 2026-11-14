Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF9606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fj/YG3ng;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=U1R/zB1d;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=M3NUZiBc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE69B606C6;
	Sat, 14 Nov 2026 16:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4nAh3dsLSaOd; Sat, 14 Nov 2026 16:22:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AD436076D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673323;
	b=U+GFBCO/200ExWe/gVlPs1Qjz01l2ec0P4bdEyZls2Fu5A7Ai4LBVJJ8wAJ8h10sunBm
	 TG/VJpWjXH4CkWfQ0Dtl8XblFsFybnwzwFlR2Ao2ByvES1G5PMJApjew+VewVewcNy6ah
	 L2sKy2oyT3S4roPIod17SyBJWhZWkhEN7IXShsetA4sdYVi0k1rr0P8joXJuBtEhvdV6M
	 qW2t+CMJjvWMePTZN3V8JSl96sbXZxe9GjHNpRIATgd/pmB3FrxeLzWnjXJIgglpf1s9c
	 FZCh/FHO+AeZ4CChI4eB+T147zi8sGuX8e7BZQ7Hu0dVW3typcZ2lWUGCjAaja7pWsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9tXQ6a0vXpklBvavKcpOT+QJq4J2gwhXkx/X+SOzhJ0=;
	b=JFHWkPsGd4qSNa6ope0zkXqxcCkBdHa8N+Zz1KNSjuTSU1lpPOJwIxpwd851KIVyoc3b
	 Eux8fgBFQFqTCoGlYifp3mpe1SbZkkg79Yl8S2ejSPi/DqwU992tMYj/ugPTTYQpkcCzC
	 +3sF5H0tGPGwvt9uXVYbghMkLYSzjt5N1uru1MaV4ElzgVaCab3xVEkDnNbr+i6+x2zO3
	 GqL+t5urI8AC8mhBMu/CE3z2MgBdavu01i1oITT4yGCmUj1CI3gyE+gyo7KYHbEzrAJi6
	 /Ahv80I/IGDQ6GVfHQ6/vXAAPKqpQba+BHbzjIXBBkxz4mvjFWnft5ya/Y82H9BfyhQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673323;
	bh=9tXQ6a0vXpklBvavKcpOT+QJq4J2gwhXkx/X+SOzhJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fj/YG3nguTL49k+mKgp6hOWlCD8zawV4SSV+xR2GiUv+wnCtem4QsFTnrkQGVyh7s
	 HLDJs+VRHlVRFwRq8VihcJs04eDcbZJVvwRd5hsZ8PzmHDlCRk+x/LuHOIFyvOxynp
	 E37vpwxn4RA99oxA4FSYti3iMW4DfG/e9OedDZQ/h3h7tNrf9Vyx8PTgft58tICDG2
	 7/4pQDoLeZESUozcDgwmPpVWX2SXxA9yeSJmyiEL01vwPp2xx3ePBfFF08CqAC+QqL
	 ePACcmYsCsoDIcb3vU177ZOVUIhZoHD7Mctrq7rMKHX9hJ36IEsZk3l4KPqJofiLgY
	 4SbpqT/ei8r5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AD436076D;
	Sat, 14 Nov 2026 16:22:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC75028C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE7DE814A0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZP6Hy2dF5UAr for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56FF3814A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.11;
 helo=b224-11.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd747d-bda32de9-1708-4370-8f42-8f024bbc8eb0-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=U1R/zB1d; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=M3NUZiBc
Received: from b224-11.smtp-out.eu-central-1.amazonses.com
 (b224-11.smtp-out.eu-central-1.amazonses.com [69.169.224.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56FF3814A1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673309;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=7lhUVa+Fp4dM1xsk7t+6bvixmXXhbgaXrpPJVPWcU9s=;
 b=U1R/zB1d/hlDTNyuEXjZH4Jp0YolkxURHOOR+2jrMB9/SZhTmXmbSnqntqvzFWCs
 4glorx0HZ66K7Xf8GZBDmVoua8HP+06koUrTIupruNlYluBpKv258TIMDgx+1TBfBCd
 T3nOaoXcPX1Ap/AOI8b+/LsimnDb2Rhg/QR5GBIwSUL/oB2vCwWXuWdKGUyVczpByTE
 bYylW4gZ2UG7qGLktrdPUs/s8H2Ju5QfNlvQrIxhpaFOs8sVyHjFSUPgq42Cly2xBh/
 +wtDxOIkIhaXT6juAnBO4XcpHXmA8+oIpkjt3QSDlRIJ/s3W61RE57PTgqk7Gs7vwaj
 2mnj6EyrBg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673309;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=7lhUVa+Fp4dM1xsk7t+6bvixmXXhbgaXrpPJVPWcU9s=;
 b=M3NUZiBcxFefR9Q5qmYsvbPGjt/X9Cruqgp5llwLiEnUs3JAZUyuICBSCuS1hwj0
 nvpgxU8NQrcg83gifoSaiZTyn1AKYtnBQKfpNBCvVsVshedHotaG2TuGOql3llPS7xk
 qQi3ZVdgWuJFPOpyYu/+z1Je7W/q1m3/Zm75olmY=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:48 +0000
Subject: [PATCH v3 07/13] Common files for the whole S5L87xx SoC family and
 the Nxx board series
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd747d-bda32de9-1708-4370-8f42-8f024bbc8eb0-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=15174;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=7lhUVa+Fp4dM1xsk7t+6bvixmXXhbgaXrpPJVPWcU9s=;
 b=y0QwHK+NtTmvn1HTNVDRer1Y29JPGqUjJtgYJoK+zv/33E4D0eV7Gm2fXsxeouaSs20jmgOrf
 UloB1eLi7TYDJdRimyzqZ1KTxMIv15I8NuAG4yM18MMgSITQYpkBZz1
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.11
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

Marketing name: Apple iPod nano/classic series

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 MAINTAINERS                                 |  3 ++
 arch/arm/Kconfig                            |  2 +
 arch/arm/Makefile                           |  1 +
 arch/arm/dts/s5l87xx-nxx.dtsi               | 22 ++++++++
 arch/arm/dts/s5l87xx.dtsi                   | 78 ++++++++++++++++++++++++++++
 arch/arm/include/asm/arch-s5l87xx/clk.h     | 19 +++++++
 arch/arm/include/asm/arch-s5l87xx/s5l87xx.h | 79 +++++++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig               | 60 ++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Makefile              |  7 +++
 arch/arm/mach-s5l87xx/s5l87xx-clk.c         | 66 ++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l87xx.c             | 22 ++++++++
 board/apple/nxx-common/nxx.c                | 47 +++++++++++++++++
 12 files changed, 406 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da8e413dd35..fccc5b2e886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -603,7 +603,10 @@ F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
 ARM SAMSUNG S5L87XX SOC
 M:	Vencislav Atanasov <user890104@freemyipod.org>
 S:	Maintained
+F:	arch/arm/dts/s5l87*
 F:	arch/arm/include/asm/arch-s5l87*
+F:	arch/arm/mach-s5l87*
+F:	board/apple/n*
 
 ARM SAMSUNG SOC DRIVERS
 M:	Sam Protsenko <semen.protsenko@linaro.org>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aec410811ab..ad70fcae945 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2430,6 +2430,8 @@ source "arch/arm/mach-qemu/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
 
+source "arch/arm/mach-s5l87xx/Kconfig"
+
 source "arch/arm/mach-s5pc1xx/Kconfig"
 
 source "arch/arm/mach-sc5xx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index de975fc9368..d27808dfd05 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -80,6 +80,7 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_OWL)		+= owl
 machine-$(CONFIG_ARCH_RENESAS)		+= renesas
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
+machine-$(CONFIG_ARCH_S5L87XX)		+= s5l87xx
 machine-$(CONFIG_ARCH_S5PC1XX)		+= s5pc1xx
 machine-$(CONFIG_ARCH_SC5XX)		+= sc5xx
 machine-$(CONFIG_ARCH_SNAPDRAGON)	+= snapdragon
diff --git a/arch/arm/dts/s5l87xx-nxx.dtsi b/arch/arm/dts/s5l87xx-nxx.dtsi
new file mode 100644
index 00000000000..152d8fc23a7
--- /dev/null
+++ b/arch/arm/dts/s5l87xx-nxx.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (2nd, 3rd, 4th, 5th, 6th and 7th generation) and iPod classic (6th generation)
+ *
+ * This file contains parts common to all Apple iPod devices using the s5l87xx.
+ *
+ * target-type: N36, N46, N58s, N33, N20, N31, N25
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/ {
+	memory: memory {
+		device_type = "memory";
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "clkref";
+	};
+};
diff --git a/arch/arm/dts/s5l87xx.dtsi b/arch/arm/dts/s5l87xx.dtsi
new file mode 100644
index 00000000000..ac985ee6c37
--- /dev/null
+++ b/arch/arm/dts/s5l87xx.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L87xx SoC family
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clkgates: clkgates {
+			compatible = "samsung,s5l87xx-clkgates";
+		};
+
+		uart0: uart@3cc00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3cc00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <0>;
+			status = "disabled";
+		};
+
+		uart1: uart@3db00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3db00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <1>;
+			status = "disabled";
+		};
+
+		uart2: uart@3dc00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3dc00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <2>;
+			status = "disabled";
+		};
+
+		uart3: uart@3dd00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3dd00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <3>;
+			status = "disabled";
+		};
+
+		usbphy: usbphy@3c400000 {
+			compatible = "apple,s5l87xx-otgphy";
+			reg = <0x3c400000 0x100>;
+			#phy-cells = <0>;
+		};
+	};
+};
diff --git a/arch/arm/include/asm/arch-s5l87xx/clk.h b/arch/arm/include/asm/arch-s5l87xx/clk.h
new file mode 100644
index 00000000000..ad6a9ceca87
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/clk.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __S5L87XX_CLK_H_
+#define __S5L87XX_CLK_H_
+
+#include <inttypes.h>
+
+/*
+ * Ungate a single clock gate by raw {gate, bit}. Unlike s5l87xx_enable_clkgate()
+ * this needs no device tree, so it is safe in pre-relocation paths (e.g. the
+ * debug UART init, which runs before the FDT is set up).
+ */
+void s5l87xx_enable_clkgate_bit(u8 gate, u8 bit);
+void s5l87xx_enable_clkgate(const char *id);
+
+#endif //__S5L87XX_CLK_H_
diff --git a/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h b/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h
new file mode 100644
index 00000000000..ebcfe51e8b3
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __S5L87XX_H_
+#define __S5L87XX_H_
+
+#include <linux/types.h>
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_LCD_BASE 0x38600000
+#else
+#define S5L87XX_LCD_BASE 0x38300000
+#endif
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_OTG_BASE 0x38800000
+#else
+#define S5L87XX_OTG_BASE 0x38400000
+#endif
+
+#define S5L87XX_VIC_BASE         0x38E00000
+#define S5L87XX_VIC_OFFSET       0x1000
+#define S5L87XX_VICBASE(v)       (S5L87XX_VIC_BASE + S5L87XX_VIC_OFFSET * (v))
+#define S5L87XX_VICINTENCLEAR(v) (S5L87XX_VICBASE(v) + 0x14)
+
+#define S5L87XX_INT_BASE 0x39C00000
+/*
+ * Determines which interrupt source is masked.
+ * The masked interrupt source will not be serviced.
+ */
+#define S5L87XX_INTMSK   (S5L87XX_INT_BASE + 0x08)
+
+#define IRQ_USB_FUNC 16
+
+#define S5L87XX_PHY_BASE 0x3C400000
+
+#define S5L87XX_CLK_BASE  0x3C500000
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_SWRCON    (S5L87XX_CLK_BASE + 0x30) /* Software reset control register */
+#define S5L87XX_PWRCON(i) (S5L87XX_CLK_BASE + ((i) == 1 ? 0x40 : 0x28))
+#else
+#define S5L87XX_SWRCON    (S5L87XX_CLK_BASE + 0x50)
+/* S5L8702 only uses PWRCON(0) and PWRCON(1) */
+#define S5L87XX_PWRCON(i) (S5L87XX_CLK_BASE + \
+							((i) == 4 ? 0x6C : \
+							((i) == 3 ? 0x68 : \
+							((i) == 2 ? 0x58 : \
+							((i) == 1 ? 0x4C : \
+								0x48)))))
+#endif
+
+#define S5L87XX_TIMER_BASE 0x3C700000
+
+#define S5L87XX_WDT_BASE 0x3C800000
+#define S5L87XX_WDTCON   S5L87XX_WDT_BASE			/* Control Register */
+#define S5L87XX_WDTCNT   (S5L87XX_WDT_BASE + 0x04)	/* 11-bits internal counter */
+
+#define S5L87XX_GPIO_BASE    0x3CF00000
+#define S5L87XX_PCON(n) (S5L87XX_GPIO_BASE + 0x00 + (n) * 0x20)
+#define S5L87XX_PUNB(n) (S5L87XX_GPIO_BASE + 0x0c + (n) * 0x20)
+#define S5L87XX_PUNC(n) (S5L87XX_GPIO_BASE + 0x10 + (n) * 0x20)
+#define S5L87XX_PPIE(n) (S5L87XX_GPIO_BASE + 0x14 + (n) * 0x20)
+
+#define S5L87XX_PCON_PINS_CLEAR_FN(rx_pin, tx_pin) (~(GENMASK((((rx_pin) + 1) * 4) - 1, \
+	(rx_pin) * 4) | GENMASK((((tx_pin) + 1) * 4) - 1, (tx_pin) * 4)))
+#define S5L87XX_PCON_PINS_SET_FN(rx_pin, tx_pin, fn) (((fn) << ((rx_pin) * 4)) |\
+	((fn) << ((tx_pin) * 4)))
+
+#define S5L87XX_BUS_BASE 0x3E000000
+
+/* Move 0xd3 value to CPSR register to enable SVC mode */
+#define svc32_mode_en() __asm__ __volatile__				\
+			("@ I&F disable, Mode: 0x13 - SVC\n\t"		\
+			 "msr     cpsr_c, %0\n\t" : : "r"(0x13 | 0xC0))
+
+#endif //__S5L87XX_H_
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
new file mode 100644
index 00000000000..39de1039495
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -0,0 +1,60 @@
+if ARCH_S5L87XX
+
+choice
+	prompt "S5L87xx SoC select"
+	help
+	  Choose which Samsung S5L87xx SoC are you building for.
+	  S5L8701 - N36 (iPod nano 2nd generation)
+	  S5L8702 - N46 (iPod nano 3rd generation) and N25 (iPod classic
+	            6th generation)
+	  S5L8720 - N58s (iPod nano 4th generation)
+	  S5L8723 - N20 (iPod nano 6th generation)
+	  S5L8730 - N33 (iPod nano 5th generation)
+	  S5L8740 - N31 (iPod nano 7th generation)
+
+config S5L8701
+	bool "S5L8701"
+	# Actually an ARM940T
+	select CPU_ARM920T
+	help
+	  The Samsung S5L8701 is an ARM-based SoC with a single core ARM940T.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8702
+	bool "S5L8702"
+	select CPU_ARM926EJS
+	help
+	  The Samsung S5L8702 is an ARM-based SoC with a single core ARM926EJ-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8720
+	bool "S5L8720"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8720 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8723
+	bool "S5L8723"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8723 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8730
+	bool "S5L8730"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8730 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8740
+	bool "S5L8740"
+	select CPU_V7A
+	help
+	  The Samsung S5L8740 is an ARM-based SoC with a single core ARM Cortex A5.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+endchoice
+
+endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
new file mode 100644
index 00000000000..c8d200479c3
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += s5l87xx.o
+obj-y += s5l87xx-clk.o
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-clk.c b/arch/arm/mach-s5l87xx/s5l87xx-clk.c
new file mode 100644
index 00000000000..13a7453a30a
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-clk.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <dm/ofnode.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+
+/*
+ * Sentinel for an unused second clock gate in the device-tree
+ * "samsung,clock-gates" property. A real gate is encoded as gate * 32 + bit.
+ */
+#define S5L87XX_CLKGATE_NONE 0xffffffff
+
+void s5l87xx_enable_clkgate_bit(u8 gate, u8 bit)
+{
+	u32 reg = S5L87XX_PWRCON(gate);
+	u32 mask = ~BIT(bit);
+	u32 value = readl(reg);
+
+	value &= mask;
+	writel(value, reg);
+}
+
+static void s5l87xx_ungate_encoded(u32 encoded)
+{
+	if (encoded == S5L87XX_CLKGATE_NONE)
+		return;
+
+	s5l87xx_enable_clkgate_bit(encoded / 32, encoded % 32);
+}
+
+/*
+ * Ungate a clock by name. The name -> {gate, bit} mapping lives in the device
+ * tree under the "samsung,s5l87xx-clkgates" node ("clock-gate-names" paired
+ * with "samsung,clock-gates", two cells per gate). Works pre-relocation: it
+ * reads the flat tree directly, so callers earlier than the FDT setup (e.g.
+ * the debug UART) must use s5l87xx_enable_clkgate_bit() instead.
+ */
+void s5l87xx_enable_clkgate(const char *id)
+{
+	ofnode node = ofnode_by_compatible(ofnode_null(),
+									   "samsung,s5l87xx-clkgates");
+
+	if (!ofnode_valid(node))
+		panic("%s: no clkgates node in device tree", __func__);
+
+	int idx = ofnode_stringlist_search(node, "clock-gate-names", id);
+
+	if (idx < 0)
+		panic("%s: unknown id %s", __func__, id);
+
+	u32 gate1, gate2;
+
+	if (ofnode_read_u32_index(node, "samsung,clock-gates", idx * 2, &gate1))
+		panic("%s: malformed gate1 for %s", __func__, id);
+
+	if (ofnode_read_u32_index(node, "samsung,clock-gates", idx * 2 + 1, &gate2))
+		panic("%s: malformed gate2 for %s", __func__, id);
+
+	log_debug("s5l87xx: ungating %s\n", id);
+	s5l87xx_ungate_encoded(gate1);
+	s5l87xx_ungate_encoded(gate2);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l87xx.c b/arch/arm/mach-s5l87xx/s5l87xx.c
new file mode 100644
index 00000000000..b9a1c54c13e
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+
+void reset_cpu(void)
+{
+	svc32_mode_en();
+	// According to S5L8700X datasheet
+	// rSWRCON = 0xA5 triggers a Software Reset
+	// rWDTCON = 0x100000 is not documented but might trigger a Watchdog Reset
+	// writel(0xA5, S5L87XX_SWRCON);
+
+	writel(0x100000, S5L87XX_WDTCON);
+
+	while (1)
+		;	/* loop forever till reset */
+}
diff --git a/board/apple/nxx-common/nxx.c b/board/apple/nxx-common/nxx.c
new file mode 100644
index 00000000000..72b21c1867b
--- /dev/null
+++ b/board/apple/nxx-common/nxx.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <fdtdec.h>
+#include <env.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+__weak int board_init(void)
+{
+	return 0;
+}
+
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	char buf[96];
+	ulong start;
+	ulong size;
+
+	if (!env_get("dfu_alt_info")) {
+		/* don't touch the upper 4M, U-boot is relocated there
+		 * use upper half of the remaining space for loading
+		 * and the lower for booting the payload, e.g. Linux
+		 */
+		size = (gd->ram_size - SZ_4M) / 2;
+		start = gd->ram_base + size;
+		snprintf(buf, sizeof(buf), "firmware ram 0x%08lx 0x%08lx;"
+				 "bootrom ram 0x20000000 0xc800", start, size);
+		env_set("dfu_alt_info", buf);
+
+		env_set_hex("loadaddr", start);
+	}
+}

-- 
Git-157)

