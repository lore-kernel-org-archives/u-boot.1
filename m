Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCAECA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C12B840EBD;
	Sat,  3 Oct 2026 15:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b0uBAq8syBy3; Sat,  3 Oct 2026 15:20:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7759240ED4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791040816;
	b=bTP4Os3LMZs/SrhC/pOHIc7bFIKyChRBhJD+nHKO0GEEOmxRB2IDEy/RB4OdDfv+HZWZ
	 XcTo9ymmfWARgRIEXOqRhrP8SGuERreIrZlgfdFjEUUzKAtdsKBxrEsAiZvr4zznx6T20
	 fTHaHmIkjF3opEOw9BC8StTkC4g29JPVQsaec92uN61e3iJYFiDOJdafEhVN/gUqREZpc
	 EFMjSrbXMbWRkHDAPhuAGU0LPh6e7pJma837wmmDggl3UwskzOuJYh9FYPtqGMEKVAeeG
	 9AgW93n2NkUEHgEITnR5NrTJZ8Y8BJY2qsOTfxLqAyeuqA2lm6uiGpn1ZfN1kAEjbDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791040816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i7l6EKtfJueNmOLbq4fXk8UYV+DRIXiNnrtLOq5y40U=;
	b=OhecmrPpwYmU6E/PT3y1DkT5iyPrJB+tnuUAhPmgff3bpryKPm/cUWzL31f5358aT5Ii
	 krNJm3linkrUXU7BSZEIBG1C0La3kG4y2ge88zdVCBSLIeSkpb7UdNaoty6Rv0XJZjMWb
	 opgJr+piP9eQuXK6lJW2sBbqSgslqBrNRkFQGjLjSIcWjO5VgGLe3NmlNd+Ma9mN92evm
	 x/hg8XE2Sj32ytnEQNrojPHxWdC6Vez8KrtJyCUUEScizFrJNfVwNqdvlczxV2vawyMSj
	 Ypp9CUuxkTGiKdJZZMTQ4tHkgFkPddxO0zxiVzUpjrcDcEgrqGFP540eMOlnvWYwEaQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T5am9c3F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791040816;
	bh=i7l6EKtfJueNmOLbq4fXk8UYV+DRIXiNnrtLOq5y40U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v5hgRs0C2QniHX/AKecBniSkbDO1kqsWum0N5SeRR06hRnOB8hnHBDamvxDdRNqq1
	 sGh7cOF26iElGbppkZLmja9GOEMQ7U6ssoVvEpXQTF2raPMjWjXQH2kN30avcJMyAW
	 OpDZ4o6qgb4ChgEBVBSCUTYfOYdOcxrh1Rvm/dV6cvN42T3OAnJ2wGJRIp2f1cGnFW
	 f7FYmgxe2I8F4MQbxAYDiZ+gHaZNJoJKw6L1slKXo8aus1xLKKbw2nGhjWqgiymC3K
	 cKsF6E7XdBAXv+50uWiC1zMnFkWeVGTXRcrWhxHPLbpl20lbHO68vI9oRxNzzYF91h
	 P+1CbX+J+a3XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7759240ED4;
	Sat,  3 Oct 2026 15:20:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F455435
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 303E841497
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZYVO7YdqKdE for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:45:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B0B741496
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791038718;
 b=bMQEXISGNx7o6jnoCb9hL02hOJv5C8WwDCnZhtzrlELK96XQIS3cSNx0qOb27akkFedB
 lJq+jq7vH6QXdEDO8+Osm22Pd7NgBH7nF3cQoQEdRcAhP99Lt/TpdXOseDf1bepGrV7V0
 CuC19bvkEojajD4mCOsJhiVK5mQ+cnK78fEsxTd4Khb6hIweu31EJDrGFQdz2m2CsRGlW
 WECjEBLmtfqXShYBWVG88mRfky8yxfo3GLDCpQk39nWdklzyco1uZaCV9zLZ0hytNmxuI
 y8W8ejrlZd6vPDZg4pExj4rbh9tLr3AGSM55mbwlpg5pUeMTfjb8a0f3CtTRB2OvuvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791038718;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=i7l6EKtfJueNmOLbq4fXk8UYV+DRIXiNnrtLOq5y40U=;
 b=hGrx4hnMKFEDooloEqAhF374XwaDy30zhkmq/pSMv+H6Q/vcI3aHuAzI/Ns6uDFM5K3z
 7sS0OoJ1desTfN2cdOJNjVy+efgvFB0MB0XTb6nSR29wiYklr81DgXm/dgByokq79CTgv
 ZJZb3KwSYzGw1ipno37e9Pkc+fgE5lmSCG1M5Za4PJbn4exML4ue2q18mfd71b0O9rqIW
 /SBbnlMFQb0ASkMYSLhnTsj3Yed8G8NNvAnVJE7g7nttEtvCNVgL28pPdJeJ3vTIebxTV
 7FzJLYgxPdpSzTTXBRqWz5ShVgf/L72nsh8H6w6+guFYCSRsJJpdoN9LBZn8rqao5Bw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=T5am9c3F; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=T5am9c3F
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B0B741496
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:17 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso5542535e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791038716; x=1791643516;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i7l6EKtfJueNmOLbq4fXk8UYV+DRIXiNnrtLOq5y40U=;
 b=T5am9c3FoSNqg+jacL+B/iQrgKH+X4gHh3evjrWtCrX9Nxs0uG9QVZMh7GXMiSr7KH
 j4ykCyXGdioSfRdWmIkMMrl03zXCpr63QL/mgzCG6Ija9IHomroCbqPx2CrLrbYFSMia
 5aciKQEfvFNdjVWljtwP/u3T19ekx2V5+uAx//dSx8oYu9IZkhKahhSjICx13i1lqSIR
 32yHoLZOqwTLnq9FLZG+ikm/ViU7JIG9IUCorgdUmc+JIFM6E5IJmenqy+bTV3/wbim8
 bO7+JLCBgxcxygvrFdFXnqGYoHUSPViqEo1XKbR1wQrcRP+Zhpgp/jyM27obfiO4/v6O
 Eq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791038716; x=1791643516;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7l6EKtfJueNmOLbq4fXk8UYV+DRIXiNnrtLOq5y40U=;
 b=2vkWV3izJVbJxHbVH0SmziOFuS9Ev13O5wpauHpsrq9lv9X+oDThMKpH/AS9AbJvfQ
 gaPPZdaEry1AeR5Rrk/EP8bJlxXib+Vbgb3vGiehV4in1tN4GjtTsTmMCHdmhaUpu3+3
 9So5toDeLlbb8ftsYGEjWq+Aklz7yrNB72PvPpjMIpZj/d5oEMVeFHED/geoFKZAnd5z
 YDvGzogPrLDSXuaLzAFDtXYABSpPNYNCANvaljbVw0aYD2NL9rwlq9IeqD7TyzDePXF7
 xqlaUqQFPpx75QKaBihzELZWNoD6JxzCTzQtJ6+l5h/iLk2zehw50npN+FeMVdKI2d7k
 +4dQ==
X-Gm-Message-State: AFuF++k5yGkijwiIBTUNH2cuC6XRTihFusGq6rqeAepZ03pO35/wKHeM
 qaq1uksKOWWtxMwlQK39ZP/6bh1ZIrSzkrhxSYawDFY+O1ZapgmE6j4g582EyA==
X-Gm-Gg: AYBFou0bF2OcvDDAsaQtxc8JYe4JLxIVDRbnCB1q3B223JigOrxfYcNh2fRv0bq+OAY
 kxIMOaVNz+Qk4A/fieuqzyIqke35t+tA7ao2oBqGjScmVrbBW/HEiAGtpZ4syXTmuvl0CiTmufW
 faxEXZApGp1DPplzIQqQ4uO2FYmyq20e0SdVQlhTeExsofG+flNwTTDajhf64Oudk0eNnzGFgQM
 XT5PVnH07EVS1ePRaIZYLIGtin9ZbnPvsuHWw7hr0IlKX3zdJWkqW2UaBY6PmhuoAXHhjJ/PWj+
 zq2frmUz9GgZGyYPIOCUwa7DMhMPd3DjK+Q93PsmXTdEi34Cixy0WNaCKYSCCiZsmdLaw1SlVXf
 8+D6W8JIsfZZ01LILjmvIPd/Pqra1G2Eghn313+xgKxjaqtF8JNJHBOnxK98ifd4ecAPbMtnqUR
 CJDilR07VR5kzMVA/UZMNgUD0QCZRppojj335bNBHJJlS/qMKXMYzD/d85RhgSRIgBDIZxoVae7
 R93lOMFJSxY3VgoFVG0MCZ8PtMxUnKPYbS68repqHvY8rnD6D0V5kyfpNTypqQMbiUjpi8Yu3ur
 +rTO
X-Received: by 2002:a05:600c:3144:b0:4a0:1c0e:b2a8 with SMTP id
 5b1f17b1804b1-4a0275780d3mr91110165e9.28.1791038715533; 
 Sat, 03 Oct 2026 07:45:15 -0700 (PDT)
Received: from lap.lan (xdsl-31-165-251-31.adslplus.ch. [31.165.251.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm186553995e9.8.2026.10.03.07.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 07:45:15 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v7 3/3] sandbox: spi: Add SPI EEPROM emulator and DM test
Date: Sat,  3 Oct 2026 16:45:07 +0200
Message-ID: <7a246d79905323672af1df9ea44f1e3a84d7d377.1791038319.git.joaofl@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791038319.git.joaofl@gmail.com>
References: <cover.1791038319.git.joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Oct 2026 15:20:09 +0000
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

Add a sandbox emulator for an AT25-style SPI EEPROM so the new SPI
EEPROM uclass can be exercised without real hardware.

The sandbox SPI controller previously always bound the SPI flash
emulator for every chip select. Allow a slave node to select its own
emulator through a sandbox,emul phandle (mirroring the sandbox I2C
bus), falling back to the SPI flash emulator when none is given so that
existing behaviour is preserved.

A test EEPROM is wired up on chip select 3 of the sandbox SPI bus and a
test/dm test verifies size reporting, patterned reads, out-of-bounds
rejection and the unimplemented write path. The node follows the
atmel,at25 binding: it carries the "atmel,at25" fallback compatible and
the required size, pagesize and address-width properties.

Signed-off-by: João Loureiro <joaofl@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # sandbox
---
 MAINTAINERS                    |   2 +
 arch/sandbox/dts/test.dts      |  16 +++-
 drivers/misc/Makefile          |   1 +
 drivers/misc/spi_eeprom_emul.c | 130 +++++++++++++++++++++++++++++++++
 drivers/spi/sandbox_spi.c      |  37 +++++++++-
 test/dm/Makefile               |   1 +
 test/dm/spi_eeprom.c           |  46 ++++++++++++
 7 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 test/dm/spi_eeprom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c45c47000c0..47f04166879 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1712,8 +1712,10 @@ SPI EEPROM
 M:	João Loureiro <joaofl@gmail.com>
 S:	Maintained
 F:	drivers/misc/spi_eeprom.c
+F:	drivers/misc/spi_eeprom_emul.c
 F:	drivers/misc/spi_eeprom_priv.h
 F:	include/spi_eeprom.h
+F:	test/dm/spi_eeprom.c
 
 SPI NAND
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index d24feec5422..7d7f0376348 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1618,7 +1618,7 @@
 		#size-cells = <0>;
 		reg = <0 1>;
 		compatible = "sandbox,spi";
-		cs-gpios = <0>, <0>, <&gpio_a 0>;
+		cs-gpios = <0>, <0>, <&gpio_a 0>, <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinmux_spi0_pins>;
 
@@ -1636,6 +1636,20 @@
 			spi-cpol;
 			spi-cpha;
 		};
+		eeprom@3 {
+			reg = <3>;
+			compatible = "microchip,at25160bn", "atmel,at25";
+			spi-max-frequency = <1000000>;
+			size = <2048>;
+			pagesize = <32>;
+			address-width = <16>;
+			sandbox,emul = <&spi_eeprom_emul>;
+		};
+	};
+
+	spi_eeprom_emul: spi-eeprom-emul {
+		compatible = "sandbox,spi-eeprom";
+		sandbox,size = <2048>;
 	};
 
 	syscon0: syscon@0 {
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 8c9f8eb9cfa..201055d89e0 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CROS_EC_I2C) += cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI) += cros_ec_spi.o
 obj-$(CONFIG_SANDBOX) += p2sb_sandbox.o p2sb_emul.o
 obj-$(CONFIG_SANDBOX) += swap_case.o
+obj-$(CONFIG_SANDBOX) += spi_eeprom_emul.o
 endif
 
 ifdef CONFIG_$(PHASE_)DM_I2C
diff --git a/drivers/misc/spi_eeprom_emul.c b/drivers/misc/spi_eeprom_emul.c
new file mode 100644
index 00000000000..397e73cf0cd
--- /dev/null
+++ b/drivers/misc/spi_eeprom_emul.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sandbox emulation of an AT25-style SPI EEPROM.
+ *
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ * Copyright (c) 2026 João Loureiro <joaofl@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_SPI_EMUL
+
+#include <dm.h>
+#include <malloc.h>
+#include <spi.h>
+#include <linux/err.h>
+
+#include "spi_eeprom_priv.h"
+
+#define SANDBOX_SPI_EEPROM_SIZE		2048
+
+/**
+ * struct sandbox_spi_eeprom - state of the emulated EEPROM
+ *
+ * @data:	Backing store for the memory array
+ * @size:	Size of the memory array in bytes
+ * @cmd:	Opcode of the command currently being processed
+ * @cmd_len:	Number of command/address bytes consumed so far
+ * @addr:	Byte address decoded from the command
+ */
+struct sandbox_spi_eeprom {
+	u8 *data;
+	uint size;
+	u8 cmd;
+	uint cmd_len;
+	uint addr;
+};
+
+static int sandbox_spi_eeprom_xfer(struct udevice *dev, uint bitlen,
+				   const void *dout, void *din, ulong flags)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+	const u8 *tx = dout;
+	u8 *rx = din;
+	uint bytes = bitlen / 8;
+	uint i;
+
+	if (bitlen % 8)
+		return -EINVAL;
+
+	/* A new transaction starts with the command/address phase */
+	if (flags & SPI_XFER_BEGIN) {
+		priv->cmd = 0;
+		priv->cmd_len = 0;
+		priv->addr = 0;
+	}
+
+	for (i = 0; i < bytes; i++) {
+		if (tx) {
+			/* Command phase: first byte is the opcode */
+			if (priv->cmd_len == 0)
+				priv->cmd = tx[i];
+			else if (priv->cmd == AT25_CMD_READ_DATA)
+				priv->addr = (priv->addr << 8) | tx[i];
+			priv->cmd_len++;
+		} else if (rx) {
+			/* Data phase: serve the requested register/array */
+			switch (priv->cmd) {
+			case AT25_CMD_READ_STATUS:
+				/* Ready, write disabled, not protected */
+				rx[i] = 0x00;
+				break;
+			case AT25_CMD_READ_DATA:
+				rx[i] = priv->addr < priv->size ?
+					priv->data[priv->addr] : 0xff;
+				priv->addr++;
+				break;
+			default:
+				rx[i] = 0xff;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int sandbox_spi_eeprom_probe(struct udevice *dev)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+	uint i;
+
+	priv->size = dev_read_u32_default(dev, "sandbox,size",
+					  SANDBOX_SPI_EEPROM_SIZE);
+	priv->data = calloc(1, priv->size);
+	if (!priv->data)
+		return -ENOMEM;
+
+	/* Fill with a known pattern so reads can be verified */
+	for (i = 0; i < priv->size; i++)
+		priv->data[i] = i & 0xff;
+
+	return 0;
+}
+
+static int sandbox_spi_eeprom_remove(struct udevice *dev)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+
+	free(priv->data);
+
+	return 0;
+}
+
+static const struct dm_spi_emul_ops sandbox_spi_eeprom_ops = {
+	.xfer	= sandbox_spi_eeprom_xfer,
+};
+
+static const struct udevice_id sandbox_spi_eeprom_ids[] = {
+	{ .compatible = "sandbox,spi-eeprom" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_spi_eeprom) = {
+	.name		= "sandbox_spi_eeprom",
+	.id		= UCLASS_SPI_EMUL,
+	.of_match	= sandbox_spi_eeprom_ids,
+	.probe		= sandbox_spi_eeprom_probe,
+	.remove		= sandbox_spi_eeprom_remove,
+	.priv_auto	= sizeof(struct sandbox_spi_eeprom),
+	.ops		= &sandbox_spi_eeprom_ops,
+};
diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index 3ee97d67f4a..aa4edcf64b2 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -77,6 +77,41 @@ static int sandbox_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
 	return 0;
 }
 
+/**
+ * sandbox_spi_emul_get() - find the emulator for a SPI slave
+ *
+ * A slave can name a dedicated emulator through a "sandbox,emul" phandle (for
+ * example an SPI EEPROM). When no such phandle is present we fall back to the
+ * built-in SPI flash emulator, preserving the previous behaviour.
+ *
+ * @state: Sandbox state, used to cache the bound emulator per chip select
+ * @bus: SPI bus the slave is attached to
+ * @slave: SPI slave to find the emulator for
+ * @emulp: Returns the emulator device on success
+ * Return: 0 if OK, -ve on error
+ */
+static int sandbox_spi_emul_get(struct sandbox_state *state, struct udevice *bus,
+				struct udevice *slave, struct udevice **emulp)
+{
+	struct sandbox_spi_info *info;
+	int ret;
+
+	info = &state->spi[dev_seq(bus)][spi_chip_select(slave)];
+	if (info->emul) {
+		*emulp = info->emul;
+		return 0;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_SPI_EMUL, slave, "sandbox,emul",
+					   emulp);
+	if (!ret) {
+		info->emul = *emulp;
+		return 0;
+	}
+
+	return sandbox_spi_get_emul(state, bus, slave, emulp);
+}
+
 static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 			    const void *dout, void *din, unsigned long flags)
 {
@@ -106,7 +141,7 @@ static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 		       busnum, cs);
 		return -ENOENT;
 	}
-	ret = sandbox_spi_get_emul(state, bus, slave, &emul);
+	ret = sandbox_spi_emul_get(state, bus, slave, &emul);
 	if (ret) {
 		printf("%s: busnum=%u, cs=%u: no emulation available (err=%d)\n",
 		       __func__, busnum, cs, ret);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index cc51fd33079..51ee02ea873 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_SMEM) += smem.o
 obj-$(CONFIG_SOC_DEVICE) += soc.o
 obj-$(CONFIG_SOUND) += sound.o
 obj-$(CONFIG_DM_SPI) += spi.o
+obj-$(CONFIG_SPI_EEPROM) += spi_eeprom.o
 obj-$(CONFIG_SPMI) += spmi.o
 obj-y += syscon.o
 obj-$(CONFIG_RESET_SYSCON) += syscon-reset.o
diff --git a/test/dm/spi_eeprom.c b/test/dm/spi_eeprom.c
new file mode 100644
index 00000000000..b943ada0035
--- /dev/null
+++ b/test/dm/spi_eeprom.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tests for the SPI EEPROM uclass
+ *
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ * Copyright (c) 2026 João Loureiro <joaofl@gmail.com>
+ */
+
+#include <dm.h>
+#include <spi_eeprom.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Read from the emulated SPI EEPROM and check the uclass operations */
+static int dm_test_spi_eeprom(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 buf[16];
+	int i;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_EEPROM, "eeprom@3",
+					      &dev));
+
+	/* The emulator advertises a 2 KiB array */
+	ut_asserteq(2048, spi_eeprom_size(dev));
+
+	/* The backing store is filled with a (addr & 0xff) pattern */
+	ut_assertok(spi_eeprom_read(dev, 0, buf, sizeof(buf)));
+	for (i = 0; i < sizeof(buf); i++)
+		ut_asserteq(i & 0xff, buf[i]);
+
+	/* Reads honour the requested offset */
+	ut_assertok(spi_eeprom_read(dev, 0x100, buf, sizeof(buf)));
+	for (i = 0; i < sizeof(buf); i++)
+		ut_asserteq((0x100 + i) & 0xff, buf[i]);
+
+	/* Reads past the end of the array are rejected */
+	ut_asserteq(-EINVAL, spi_eeprom_read(dev, 2040, buf, sizeof(buf)));
+
+	/* Writing is not implemented yet */
+	ut_asserteq(-ENOSYS, spi_eeprom_write(dev, 0, buf, 1));
+
+	return 0;
+}
+DM_TEST(dm_test_spi_eeprom, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.55.0

