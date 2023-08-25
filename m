Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2551C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 03:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062D886A1A;
	Fri, 25 Aug 2023 05:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LTX4OjWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695CE865D9; Fri, 25 Aug 2023 03:24:48 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0908653D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peteryin.openbmc@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68bed286169so420397b3a.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692926684; x=1693531484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02Z/Cv2tfMuANlTI1w+OEAtuzLTlgxs0SBDXlQ1/UFI=;
 b=LTX4OjWpiEVSGXoF9uQ2Uhy1Ze7K1j5aAwDfCoEeImpvDKzat5Jm4OleZX8dCnqXjX
 asGDWvTnNqP7afXD5FUtn+bYWClCuisWLeEjbAT9RElqx1th+H3Vza2Itge/enixCXwk
 o3jIgbyuLwPKsqEfXCM3qlhAltYo/KNKZeqPDmAZhWArfN1mnpYsj5vGc2HE67w3n3iF
 thwkjcXwPGWStAjnJl8oVuOFW1+L6691B1R2L8nSC/+VjovOGe9RR9ytNonAjGv70lUK
 PHpTMD/x0+fY0906M1HXFiV/FONvvjfN/aq+k0R1XIbUti2CI2PiMtZ1ilpPrm8fsZ63
 LWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692926684; x=1693531484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02Z/Cv2tfMuANlTI1w+OEAtuzLTlgxs0SBDXlQ1/UFI=;
 b=RieT1IDcMScLlT58yalDSl6NsFH0xJGlEgARls975eu/vb4cRLjh16Iwr+8aKMOGMl
 37pexyVS4itQ/LBd7Lm4CMtuCGb5Rnp+IR8+TaBcsmKeCIyYn5B3/Cz2Od7aoit3hwvG
 09PojWZgtMU5D54mH3YpkPMMo2rMt625ntt5B/WBar4E9H0DWJzsLnQSmW74cIMbeBad
 aMfKY3jJ/hDRkD9VNLVn/KaleEi+m6EcIpjYjZSsjkRm9Ma63gmIXVyweCONmhcFqkGU
 +WhA8RUNLTzlBq5g0b/j2xAW/FM8dYoKAcyP1f2nV/Kd7TQv3kun4jOWD+SW1k0l/aUy
 GCBA==
X-Gm-Message-State: AOJu0Yy2bfTLZ/+1hJ8RZywgvQEYgyXgl4WMy+7JRjbyizHx12H/pVAq
 nZPg7a2zeUKkwg605jsnGpM=
X-Google-Smtp-Source: AGHT+IEsxllGkJdib6J9pm5oeRARlSgOY+kBS1KPZtaMSYMDZlKP6rwQ0qDGEEJVe6VfOSoFSWhF1g==
X-Received: by 2002:a05:6a00:39a3:b0:68c:479:b4f with SMTP id
 fi35-20020a056a0039a300b0068c04790b4fmr1182122pfb.33.1692926683717; 
 Thu, 24 Aug 2023 18:24:43 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local
 (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
 by smtp.gmail.com with ESMTPSA id
 i2-20020aa78b42000000b0068bc461b68fsm355995pfd.204.2023.08.24.18.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 18:24:43 -0700 (PDT)
From: peteryin <peteryin.openbmc@gmail.com>
To: albert.u.boot@aribaud.net,
	u-boot@lists.denx.de
Cc: peteryin <peteryin.openbmc@gmail.com>
Subject: [PATCH 2/2] Title: Add Meta OpenBMC Minerva dts in uboot.
Date: Fri, 25 Aug 2023 09:17:32 +0800
Message-Id: <20230825011732.1606958-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825011732.1606958-1-peteryin.openbmc@gmail.com>
References: <20230825011732.1606958-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Aug 2023 05:46:38 +0200
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

Add dts file for Meta OpenBMC Minerva.

Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
---
 arch/arm/dts/Makefile            |  1 +
 arch/arm/dts/ast2600-minerva.dts | 93 ++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 arch/arm/dts/ast2600-minerva.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0a893baf64..d3faab78b1 100755
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -684,6 +684,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	ast2600a0-evb.dtb \
 	ast2600a1-evb.dtb \
 	ast2600-bletchley.dtb \
+	ast2600-minerva.dtb \
 	ast2600-evb.dtb \
 	ast2600-dcscm.dtb \
 	ast2600-fpga.dtb \
diff --git a/arch/arm/dts/ast2600-minerva.dts b/arch/arm/dts/ast2600-minerva.dts
new file mode 100644
index 0000000000..2399525b24
--- /dev/null
+++ b/arch/arm/dts/ast2600-minerva.dts
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2022 Meta Platforms Inc.
+/dts-v1/;
+
+#include "ast2600-u-boot.dtsi"
+
+/ {
+	model = "Facebook Minerva BMC";
+	compatible = "facebook,minerva-bmc", "aspeed,ast2600";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	aliases {
+		spi0 = &fmc;
+		ethernet3 = &mac3;
+	};
+
+	cpus {
+		cpu@0 {
+			clock-frequency = <800000000>;
+		};
+		cpu@1 {
+			clock-frequency = <800000000>;
+		};
+	};
+};
+
+&uart5 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&sdrammc {
+	clock-frequency = <400000000>;
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&wdt3 {
+	status = "okay";
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
+
+&fmc {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fmcquad_default>;
+
+	flash@0 {
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+
+	flash@1 {
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+
+	flash@2 {
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+};
+
+&hace {
+	status = "okay";
+};
-- 
2.25.1

