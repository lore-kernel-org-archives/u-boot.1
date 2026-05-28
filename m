Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F28CCD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 13:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B8B846D0;
	Thu, 28 May 2026 15:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="l/ntV39t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF88D80398; Thu, 28 May 2026 15:28:26 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD7D80398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 15:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B0FE3FA72
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779974904;
 bh=eS2XIiXiiR7Beb65AW3SyRhMbTH7dd2Su5jPxxdG1wo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=l/ntV39tl7HPl3RACZt4ibcOAgRsTWgWTYNMRbGnPMg4idrXDGakR09XF/gONSVbL
 cvFjoefKIHjZG4H6Sor0Vs0eHkcfK0UJK9TDcuusDjB6dJ0px8IhbeiCp/sc/pF+Ov
 m9CIVShZpibF+wHq/ZHWtcjnAqQMdjHbQdBDXiYzWbUF+f3ZooLS1BxVZwn5KBJcCu
 7/36ayKiXW/0cqTGjQemxDqpJYYSfs84UIPHZp9JEQssRZ+a29HkWmQy7cjCC6BjDE
 PBpEvnZzvRENKRfgO3MNxY0M3KusbHJ9WFMQBiWcG0ylPOQYde9WhqyBBLxxuFdf4z
 5LIAYtDmP+3UQgYLFjxfiPFlcwWX3CX9gBuxAiSOgfgZfGjKJMqJx2crAQ2s0z5CHO
 43++GM+E86Wp4ZGYy6NZnP67DtYskeBaVNC8sgbfqFb4o4kcnDv5kTNRBn9DvKGNBR
 shbPllVenp+NCn1LCa/y5E6npbC7X3D0FHX2EVmOX8fCwbScYXf4pascqkYUM7GOOI
 z0VwH2Kq0qOm3Yya+r+57+0rNcDoGlnOp1F535ZdF+E3UdHpT7/yrp8eVnp4JlnyPm
 tpi8IVrNDczLtgjOyr6SEWfk9hBSCaQ/zy56kp4jJwn3V/V01uIBOhnHZK3hTGuGAU
 oTdfWMpCXBsX7XkAu/Ise6TI=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd5b20aaa6so135240635ad.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 06:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974903; x=1780579703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eS2XIiXiiR7Beb65AW3SyRhMbTH7dd2Su5jPxxdG1wo=;
 b=eHbXe3C1xpKUNNFX04Jvyrmu3sVyGuK+9d/DvihK8Po3YOoDAW80YDnzKSxepoJIke
 0aRfTbv8F6mSDfWOEUdsVju/j7Fj4uVpUfPacmRiMXvPR0EyEPdI3dXyMXCJrAtG0Ppm
 xQQtTCs6eoZFoo1IaDRWcltw4i5gsZ7Ua9r2FtAxgDVAlEdwnn/HY4vA1MPQwJ2f6ERZ
 oNzyx7wGDMjlt/x0A6nRxNPan2LFHS4IwiRK86OOZAFJYIjV+npTYFamZYshJJ+KY7tw
 E6NHQB18O45wK7n+XzlIAt2LRrLKG+6WMRXIYeBJS5CVc+Sn/3pSQ6QuD6+/oqEWUQXb
 u9TQ==
X-Gm-Message-State: AOJu0YymZPM5M9Lak9HqFtvObgEJH+cvoPTQCDI+oM97Qch6SDXnVVaK
 0cQP08wPEdhpXsUy16EjGZHJEnqOrzlDda0cjRKux4YJ2aUW7Ptkgj5yILAXYbHYwJJZTZ1zP+o
 sw04jacnoPrYEHQRd6DyOjeAZCpYEPj+t6y4gKp5rnf4SMWwNDaPsjrbElEsHd99WTZOciGayPJ
 6+n2tNKg==
X-Gm-Gg: Acq92OEObE7TWwAd1cAbMIOt/0WpAjHga5K42ElLjV+KTWuS+f44RWZzyPeEugXpPrj
 QxqboX1NUBLJNbCV6ETS+TZ4J2LLzwACzeoq+6OzMQ5G8zPyV0RK//lwb9FMKx649QJBWlMw5Qu
 /gfnQRDi/AzviNMj1NI/O7VsZwtnD/mIgrf285dno+kMg9d7YVtuWOZuHO32LAVPbSmVzwL6KA3
 zH2ydNMbFuckN8mkFHqS8Fu34H38ldSy6FjqDMXFsKFP5YhswSU4Sx+sSPb4bSLv2g45gAkzq/K
 xzLVDew1uilxQhdK3DyJ4pgTF1m9S+uYVoQiw7BuJvBJEDERlg+jeDIBY4/fyV8V1QyUTGl2sgT
 7L+hCQI+hsSqU98jvpmFA2uXQPr17FqoIOabbqJmAkBj++6t723Z2tNTlDDMcf5yj9jUb4VVnVZ
 STL6eleKs=
X-Received: by 2002:a17:903:3808:b0:2ba:5f24:cae2 with SMTP id
 d9443c01a7336-2beb07bb69dmr304933435ad.35.1779974903002; 
 Thu, 28 May 2026 06:28:23 -0700 (PDT)
X-Received: by 2002:a17:903:3808:b0:2ba:5f24:cae2 with SMTP id
 d9443c01a7336-2beb07bb69dmr304933105ad.35.1779974902633; 
 Thu, 28 May 2026 06:28:22 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3058sm187006315ad.39.2026.05.28.06.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:28:22 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>,
 Suhaas Joshi <s-joshi@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 upstream@lists.phytec.de
Subject: [PATCH v1 2/4] board: phytec: phycore-am62: select tifsstub via FIT
 config
Date: Thu, 28 May 2026 13:27:11 +0000
Message-ID: <20260528132746.719699-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528132746.719699-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 15:30:21 +0200
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
 board/phytec/phycore_am62ax/phycore-am62ax.c  |  8 ++++
 board/phytec/phycore_am62x/phycore-am62x.c    |  8 ++++
 4 files changed, 58 insertions(+), 15 deletions(-)

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
index 3e1c4102cc1..acd0cecfe6d 100644
--- a/board/phytec/phycore_am62ax/phycore-am62ax.c
+++ b/board/phytec/phycore_am62ax/phycore-am62ax.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <spl.h>
 #include <fdt_support.h>
+#include <image.h>
 
 #include "../common/am6_som_detection.h"
 
@@ -57,3 +58,10 @@ void spl_board_init(void)
 	dram_init_banksize();
 }
 #endif
+
+#if defined(CONFIG_SPL_LOAD_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+#endif
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 3cdcbf2ecc9..2d1a893540c 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -9,6 +9,7 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include <fdt_support.h>
+#include <image.h>
 
 #include "phycore-ddr-data.h"
 #include "../common/k3/k3_ddrss_patch.h"
@@ -237,3 +238,10 @@ void spl_board_init(void)
 	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
 }
 #endif
+
+#if defined(CONFIG_SPL_LOAD_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+#endif
-- 
2.43.0

