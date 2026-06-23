Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6328CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D28F84A0A;
	Tue, 23 Jun 2026 16:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ScyI/2Sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E8DA849EA; Tue, 23 Jun 2026 16:16:03 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36739849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B835F3F640
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782224160;
 bh=zxPsqseeyOjIQcmRnwIQHiBd27MFmly254OyOvw7Tns=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ScyI/2SlpKIqeF4m71gRT39UXjSTVaVuVrQCrjM8T1VT6ZrCjD7LuJNiP12Iq1DJO
 sF4+Esz36kowxELKaHenUnMc78+WVAHUIAWDfupg9FyvOcz95Cjv3qnI+eiQNJLg3W
 nEw7Z5SEam2RoSpOUYBC1Zk62UWcXzPAkquwzqYZrXvq4XNHUOL7K1BlpbdJ7EgQRv
 am0SyYE9ry/bkswFCRNGESrifsQUPUrlONeckN8/qYwDR+GnHlFlL0W5jALoetZpLU
 35UjjPIU1fxeXMCsVQVnxgRu5LgG9WDwDEYSFyxgkkEHwd/hyW3/AYxajHPPi/mrG4
 yFHt3ZJ5bsGw63FIj8HHQbf9FfxcmpqxHN/VNHI7o7ZG4bBa+8ZEusGqJRlK2gOpEY
 5zwmFjLYz7psoFro87k022ofLa6TvrgYgbDZYqCsWyVnNy5xFkX4e1NESyLGvfbIQN
 nTnwTpZ1ygVwWzc1xKdqBJql1O8t52ppKoD2OqvJRf3efGiAJvtKeQKwNVBe2boX5Y
 yxwOTM3sWAAJqYFlSepklWhL3swKeCjsf0LqV20zaxH1dKW5rBK2WNbEBQHaUGiL5A
 qC9771MC15g7oYMS8T9SqqbeDc4oSRbDOroL1hyePbgN74qB5wfCGUeSK9o5poWL1M
 XfTpH4ddU4m3AuQh9u35DONg=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso117218565ad.3
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782224159; x=1782828959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxPsqseeyOjIQcmRnwIQHiBd27MFmly254OyOvw7Tns=;
 b=Bii2IkcZmFRN40TLU2wyKev0Vz6mzYn42DADH1aF/gR/XEmIdtJrSniL5+PwCNj0Oe
 W5hEnnveH6hUKbpL0fyeWKZc1pfDE1oQUYf8hwIJuptUy2mZ16yLK3mAbLmJOtKgCUss
 t8QrcoT+v05mzB02QtTOgYLOCeFFpZw5ge0vAIFjFKc/xVIIU/bsiD7XoNCwyoK8FIdV
 XNLveg0eNLLzecqeJN+9f/p0TF7vX/57tNC/oFUKxSjiwa8TNJmpXBCRReo1oO7DpFrO
 Zqat2xxSBUkrlmNetak3FtBcu/I3Dku6vnydYq4p97iDXNhSJKjVSdhtBnqHc75tiidO
 JbUQ==
X-Gm-Message-State: AOJu0YznpOaoufwka0R1KQgAs3muhMpe52qoPTXHLRnud/MgqBb6EyY0
 H8HmclNaKKrYhBDyAkD5zcD3qEY2H5zrn3L7bshbM7g/ir/NSDeuBoyUdJoNLjXlGhK5EMB3LOy
 9Ch7Hpp+Wp5tL3YPuZPdkreMKzqmWewQUcv60hL3jFwmeocfGXjJugJb7enKvMhkxE1fie7WkRF
 CoAhC3UQ==
X-Gm-Gg: AfdE7cl1NeHWt9cWXLA70LypInQ16ZuN5xhOWRJfLIZtdQLs5JXyC624NDvH/AUseqI
 fbNVrghHnHAxgUXH0zS7YR7YZ3MbH+1DhDlPUYddFrbGFCMBnHIRetb4vseLyxrq3XvKLt/iI1p
 7iySwrfSoQ3nXf6G6onO6NY11Fz2v374xen9RZRL0qFjdgcCmbg9e4T8zeqFmP0BLpkyl/+emCT
 TeGNy2bVELE77TIDA7KFCfxfAKlaa6Yw4tdWhH76hukSi31Qoe2YAJH6lqBMkYM5l+nUNdc1rrc
 Amy9ZcECilVG1EOof2E2O5k8Ry4wkJQ/7gOZ4PF4l6i/PVsd5YbHxCBlv4D7aq1QZLA5Zwtyt1U
 virt+avQtK2NGrKVE2Tvf6nVJF44yHKOm2ZbRrPdswTggUx2tk/v8AY5Cfutagw==
X-Received: by 2002:a17:903:2383:b0:2c7:d603:116e with SMTP id
 d9443c01a7336-2c7d6031502mr15759765ad.36.1782224159303; 
 Tue, 23 Jun 2026 07:15:59 -0700 (PDT)
X-Received: by 2002:a17:903:2383:b0:2c7:d603:116e with SMTP id
 d9443c01a7336-2c7d6031502mr15759275ad.36.1782224158875; 
 Tue, 23 Jun 2026 07:15:58 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436d3505sm110410325ad.19.2026.06.23.07.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:15:57 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>,
 Bryan Brattlof <bb@ti.com>, Suhaas Joshi <s-joshi@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>,
 upstream@lists.phytec.de
Subject: [PATCH v2 2/4] board: phytec: phycore-am62: select tifsstub via FIT
 config
Date: Tue, 23 Jun 2026 14:15:16 +0000
Message-ID: <20260623141540.618272-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623141540.618272-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260623141540.618272-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 16:25:36 +0200
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

Use the k3_fit_config_match_security_state() helper introduced in the
earlier "arm: k3: select tifsstub via board_fit_config_name_match"
patch to pick the right tifsstub variant on phycore AM62x and AM62Ax
SoMs at FIT config selection time.

The k3-am625-phycore-som-binman.dtsi and
k3-am62a-phycore-som-binman.dtsi FIT images are split into
per-security-state configurations (conf-hs-se, conf-hs-fs), and
board_fit_config_name_match() in each phycore board file forwards to
the shared K3 helper.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 42 ++++++++++++++-----
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 15 ++++---
 board/phytec/phycore_am62ax/phycore-am62ax.c  |  6 +++
 board/phytec/phycore_am62x/phycore-am62x.c    |  6 +++
 4 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 5e777a1f305..e2e0f9a2471 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -309,13 +309,24 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
+				conf-hs-fs {
+					description = "k3-am625-phyboard-lyra-rdk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am625-phyboard-lyra-rdk-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-gp {
+					description = "k3-am625-phyboard-lyra-rdk-gp";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
@@ -547,13 +558,24 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am625-phyboard-lyra-rdk";
+				conf-hs-fs {
+					description = "k3-am625-phyboard-lyra-rdk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am625-phyboard-lyra-rdk-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-gp {
+					description = "k3-am625-phyboard-lyra-rdk-gp";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index 6f82a40908f..cdc9a100a04 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -247,13 +247,18 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am62a7-phyboard-lyra-rdk";
+				conf-hs-fs {
+					description = "k3-am62a7-phyboard-lyra-rdk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl", "tifsstub-fs";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am62a7-phyboard-lyra-rdk-hs-se";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl",
-					"tifsstub-hs", "tifsstub-fs";
+					loadables = "tee", "dm", "spl", "tifsstub-hs";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/board/phytec/phycore_am62ax/phycore-am62ax.c b/board/phytec/phycore_am62ax/phycore-am62ax.c
index 3e1c4102cc1..b22ffe9072f 100644
--- a/board/phytec/phycore_am62ax/phycore-am62ax.c
+++ b/board/phytec/phycore_am62ax/phycore-am62ax.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <spl.h>
 #include <fdt_support.h>
+#include <image.h>
 
 #include "../common/am6_som_detection.h"
 
@@ -57,3 +58,8 @@ void spl_board_init(void)
 	dram_init_banksize();
 }
 #endif
+
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 3cdcbf2ecc9..464da89d2a0 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -9,6 +9,7 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include <fdt_support.h>
+#include <image.h>
 
 #include "phycore-ddr-data.h"
 #include "../common/k3/k3_ddrss_patch.h"
@@ -237,3 +238,8 @@ void spl_board_init(void)
 	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
 }
 #endif
+
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
-- 
2.43.0

