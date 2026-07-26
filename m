Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF235C531C9
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 13:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B792440681;
	Sun, 26 Jul 2026 13:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PoN1ts7A1otM; Sun, 26 Jul 2026 13:12:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A63BB40674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785071546;
	bh=+XSvx3cPCwUW7msEEDPDZsNfzfjFxX8opzyHqk081tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kErHAWuXhishro1PP3fLfOdVTZd0jVQgxJhaxcFAFZ5GIAaLj5NgKD/FCMLikMfrS
	 rcH3xJ/oZvg31onkHv8H5fmczjiJHOhukq7TTt0hV5bWNgPEgWZCwiNTK/ERkhTLG0
	 +CJg1D9/IigeU29dl5SzNURHvsJTg/1kJg4Fgs3UmAcad5Riq9REacGeh2WglE9Yzq
	 i9WQkA8HRiRC249PphFw1sMGQR0yAQDwBFkWNunt2SdpQWnrg5knKLPS3q7xnsj0uk
	 Je0qQGHGyh24sLpmyM1HwB7tv34oE73DnPu77simGg2Ok7lWS6PFMejp1WDqfRvyso
	 +Rk+C6FjkeSpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A63BB40674;
	Sun, 26 Jul 2026 13:12:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2222F69
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0862D60638
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1a2tGSbn3UzO for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 11:57:29 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=bhargavdas100@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BB3B06062D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB3B06062D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB3B06062D
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC66D844F6; Sun, 26 Jul 2026 13:57:26 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63858005D
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 13:57:24 +0200 (CEST)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2598548a91.1
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 04:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785067043; x=1785671843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+XSvx3cPCwUW7msEEDPDZsNfzfjFxX8opzyHqk081tU=;
 b=c++XJhRMmHcq9404kDltevAk6M5X/3wz8+Abhuz50WawH+eoYiXCM0XKJvK0HysMKE
 v1mQz1n5fmDm7kwJ9LYsT+GmmliLJDuU9DXIiuEtc8cqtkmufRHmwh2gqsL/SXzr+XL2
 YmXiBfdba4qECSBIbQ8r7RfcQ0D3QR9k0bK+DCNwLCOFG2i1o0R8aRXTr7EwU3TMMakp
 FK1H0s6Xsfuex+dWqGgrJx+UwljW/dkJCdn61faDrTAza8TfEZjD8jCp0klswoWZWXHk
 Q2p2FEmLKVRu8erCsykdO0BiXHpHXHmSyZ8AP8+iT9xT+G0y4LGe1nqCsA5Rt5zZ5nH6
 vHqw==
X-Gm-Message-State: AOJu0YylCIm9IHWYrsVsqldu6hu3EsE5Wfaerlr1UhJ2UuVpwggop120
 Q1vErwioioyFnSqfgO7Emje/ObxLOONIaPPyiK2LwSemBKTHM08Z+MYeeNY8DqMk
X-Gm-Gg: AR+sD13kzXtnLm5zWLhQ2nai+BA8uN9Fnsh2RjBf2vVSHoPX+rpheVvVyGcT1v7NoJz
 merrmCwr5ogA6B4OFGLbmUSIU9xOF53gkF7ZlP7mwKbGUyf43lqME53CRVP3hoxLinQVrPaIFT7
 Q4XriHLWYk9VjUt9S+JVzFO69cLtHHgasAloF60GKI/6STbZnVCqqm0SzRtbsaJd3uObPMdxMUa
 KvJaWl6gbz3YnDoz5pZwxYmLoVuYdYcyDOG1wVGmcmnIWSxejf5Z+XAPjRSDlZ/cHYIvFKR0MjU
 bpe9iSOVnREm9qNr2XhR4u+qEWCZpBWrLNpCQZsbFNFK8K+tMBYl/E1h/CNGbviqhjk87vNg4VS
 Lb8Ajkr10vlFrU8EyVk6RCRDr8XHvqWWXfjPofcDB/dgwKzgkdfdqODIkCiqPIN3w4IRaozYtHD
 aOwjBn3QJsbkpNHH6tUI4=
X-Received: by 2002:a05:6a20:4304:b0:3c3:7427:5ed8 with SMTP id
 adf61e73a8af0-3c67d9b3dd2mr4825611637.8.1785067043123; 
 Sun, 26 Jul 2026 04:57:23 -0700 (PDT)
Received: from bhargav-Legion-Y540.. ([49.207.202.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a67f3sm20811168eec.29.2026.07.26.04.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 04:57:22 -0700 (PDT)
From: Bhargav Das <bhargavdas100@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	bhargavdas100@gmail.com
Subject: [RFC PATCH 2/3] arm: dts: Add RP2350 device tree
Date: Sun, 26 Jul 2026 17:26:47 +0530
Message-ID: <20260726115702.15397-3-bhargavdas100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726115702.15397-1-bhargavdas100@gmail.com>
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 26 Jul 2026 13:12:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785067043; x=1785671843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+XSvx3cPCwUW7msEEDPDZsNfzfjFxX8opzyHqk081tU=;
 b=V3cp4jD54y8/pz9xOtrmf9vsdoR3HKzMVTOLAQYJ7rpG3LukVL1VuCauG7WFD1nF3G
 t7kUH39iRQRHrQmvhAV+kgn3pLGoNXrKjh/s861gStDkBHbxumg2zsjV9pOZWclpJg8D
 N7n1SJjIIp0YfbR//tvRY3f8U+VbuwWbsJoqSPRbKAcTtaMM+xnHsuTJrIDpU9lxH9pM
 kBFwvsmPToJq72Vc0TqEyxvO+43mNmo/4x9TkW0+chXWG6YOspE+gM/dhZfkOR4Uls02
 VI+8Uq1lC8oMHTAF3EZq6SMGwiqE0koFTFc7OQ5qvukV3c4bjf2M46eqgEPVPkm4Xzp6
 cyxg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=V3cp4jD5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bhargavdas100@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="V3cp4jD5"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add device tree for the RP2350 SoC (rp2350.dtsi) and the Raspberry Pi
Pico 2 board (rp2350-pico2.dts).

rpi_pico2_defconfig selects CONFIG_OF_EMBED, building the dtb from
u-boot's source rather than CONFIG_OF_UPSTREAM.

Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
---
 arch/arm/dts/Makefile         |  1 +
 arch/arm/dts/rp2350-pico2.dts | 30 ++++++++++++++++++++++++++++++
 arch/arm/dts/rp2350.dtsi      | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm/dts/rp2350-pico2.dts
 create mode 100644 arch/arm/dts/rp2350.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 82ad3035308..3dced44f4ec 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1196,6 +1196,7 @@ dtb-$(CONFIG_TARGET_SC594_SOM_EZKIT) += sc594-som-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZLITE) += sc594-som-ezlite.dtb
 dtb-$(CONFIG_TARGET_SC598_SOM_EZKIT) += sc598-som-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC598_SOM_EZLITE) += sc598-som-ezlite.dtb
+dtb-$(CONFIG_TARGET_RPI_PICO2) += rp2350-pico2.dtb
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
diff --git a/arch/arm/dts/rp2350-pico2.dts b/arch/arm/dts/rp2350-pico2.dts
new file mode 100644
index 00000000000..f882f971770
--- /dev/null
+++ b/arch/arm/dts/rp2350-pico2.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree for Raspberry Pi Pico 2 (RP2350)
+ */
+
+/dts-v1/;
+
+#include "rp2350.dtsi"
+
+/ {
+	model = "Raspberry Pi Pico 2";
+	compatible = "raspberrypi,pico2", "raspberrypi,rp2350";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x00082000>;	/* 520 KB SRAM */
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rp2350.dtsi b/arch/arm/dts/rp2350.dtsi
new file mode 100644
index 00000000000..f4b1dda59e3
--- /dev/null
+++ b/arch/arm/dts/rp2350.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree Include file for Raspberry Pi RP2350 SoC
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "raspberrypi,rp2350";
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		uart0: serial@40070000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x40070000 0x1000>;
+			clock = <150000000>;	/* CLK_PERI = clk_sys 150MHz */
+			status = "disabled";
+		};
+
+		uart1: serial@40078000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x40078000 0x1000>;
+			clock = <150000000>;	/* CLK_PERI = clk_sys 150MHz */
+			status = "disabled";
+		};
+	};
+};
-- 
2.43.0

