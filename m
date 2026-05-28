Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F0CCD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 13:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4252E846F4;
	Thu, 28 May 2026 15:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CzpsrRSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F3C8056B; Thu, 28 May 2026 15:28:31 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A14680398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 15:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E0533FA6C
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779974909;
 bh=uQOQnu6nh0K64RUQ7V8N7SN8O5sYHe7PUVN2DFyRziM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CzpsrRSt2Dnimn6sRgRPGutoEk9Rxp8n26BiVLoKGTkvGw8+mbWwjIbSGXz5IiZ0s
 BeWTz8Qbs2/P1vzEOBdiTYe2YxqUUQnAl5kCU70YqZ6raWt9sxj3qHO1z/ASW5LV0x
 tNSGK+glOxd2/OE0CPXApFEUCVLmnNy8p2oGhLl5ChmlZq21Ojcfr7Hf96nUeLudKz
 5jbnoSeFq95nX1GP7o1P2cX6DY1lGWXiHQNKWdc6BBknEoa9iW9iElVMebQrD9tBii
 YeS9q5HO1TMPAnSWk7ZncvWYEFz7D3boj0WOe0o2TZWd1lsFBiM3lpoV7FhMSxhqJn
 VHnPTro92Arz8UubewjKS0d5CMLRrv388iu8jNyCI6yaAWR6jRQd3J95YijBR8r7XS
 KeSZHsNXkS9RVvXJxHfcdIshM7L5s1nUFfuN9OKCDZAUtZNJMnFP0nrDOlvtQ2JccO
 hGI+5+3jaxF4o8ggZdxsgpj1hm0RsZ35wy/qZlsg2xc95GiVjHHbFDuBcnodcp8qro
 hWfq4u8xu0xlRkbE8UhNGXqGZjR+xh9xaNE7JBtomOlGqCe4hRrbgDfb/Z4WulRhMw
 FTTr0LQ/R3bVXfoY9vYqY8vN0VbMem8rkW7CVFW+zL2Ia2wxVL5HMl8amHXDObXqLn
 pqUjUmV5fVCMcadVsKCMkLeU=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso90773895ad.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 06:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974907; x=1780579707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uQOQnu6nh0K64RUQ7V8N7SN8O5sYHe7PUVN2DFyRziM=;
 b=p3ikGs+Bke/oSbyTLbIA2pBr/KxfJc4R6x/Kgfk3gHyI7TLxM20UH+RCUsiu9xVTpg
 3n7ZI6pNzr1OkxG8zfDZ8EZa/6wEs9YcqHAZRWrNvTKO/A38HAnyxb3qffs8GSPUBSjr
 o8iOA7DZ01BHFGLQVg+NdTkzR2qTY2W8PMhM5hlqQgrqNvWBxQE5SyGYiy/4h+eblstj
 IrVtCLiKTPcp86xIa4FPBTfXwX1ac9oest1AffQdE8/xuTZdEMbnXYSSDupcXexZrSSI
 pFLbeMd+aqA3ZZ0nHAEQN9wBExWUVRgs+w5qNRVYBu+HZb+GvXfqISQOUA+/UzJtcPRK
 Nr6w==
X-Gm-Message-State: AOJu0Yy3aUUBiKjxiVksETJNjieXSiQ4cMI5J9yM3b1CQ5psUkF6rKLF
 qNLUmAMkl/UH0zeClUM2I6ogCfttLrXaxHYgb2aohs46Ih5VFY7n3N1FCIsTfCoVQJ7agx7gFId
 vsUI/B1HiDIWmIPwIYz3kN3WTmbjP4GD8Hv4B/zpy7E+2qjeJg4hslFnPQ7K61Sd7Jcs85UCmYu
 GiA1NX6w==
X-Gm-Gg: Acq92OGz+0o0QG3wmrnK39+RSVIaYbpGTd6t2aDX/Mqew4EdjkpV9urGhy42z+YrgbF
 t0rdJpF3RX+s7x+777Zzwa+bKM+FEt3LYLEcehMEkDAjLwrU3lm2uucRkpFICqsG8fyypOWkVjW
 Nm2qRVS7g+YCCmWuhmk6tO+ch9wWhDtYjQStd1hgYldue8d4m9LqmhEUKCnHmr6xCz+HTdTWVNG
 uRgFhjQZMhKfpqTIX7UHZBK37brN5valkQ/CdRfZIN7kUmbejKGEpvAiLefzne7bFA0yQMllmUs
 dk7qGFYWYhqfcsKE7iG0m086ceuMe2+mfML2scXHXPwa1nkhpUOSh8XDJ5UkfFWFoHoza/+w7rx
 BF9C9mF8/lSFJ4Y/ZZZDKDlw6CGX3SCeBkvK56gH5orVmVSMa6gk4ghkEJxDDZ2rHrANT0Nsv7d
 AzoVFbUFc=
X-Received: by 2002:a17:902:f650:b0:2ae:55eb:f82d with SMTP id
 d9443c01a7336-2beb038f177mr329145735ad.1.1779974907653; 
 Thu, 28 May 2026 06:28:27 -0700 (PDT)
X-Received: by 2002:a17:902:f650:b0:2ae:55eb:f82d with SMTP id
 d9443c01a7336-2beb038f177mr329145435ad.1.1779974907354; 
 Thu, 28 May 2026 06:28:27 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3058sm187006315ad.39.2026.05.28.06.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:28:26 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Andrew Davis <afd@ti.com>, Vitor Soares <vitor.soares@toradex.com>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: [PATCH v1 3/4] board: toradex: verdin-am62: select tifsstub via FIT
 config
Date: Thu, 28 May 2026 13:27:12 +0000
Message-ID: <20260528132746.719699-4-aristo.chen@canonical.com>
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
patch to pick the right tifsstub variant on Verdin AM62 and AM62P
SoMs at FIT config selection time.

The k3-am625-verdin-wifi-dev-binman.dtsi and
k3-am62p5-verdin-wifi-dev-binman.dtsi FIT images are split into
per-security-state configurations (conf-hs-se, conf-hs-fs), and
board_fit_config_name_match() in each verdin board file forwards to
the shared K3 helper. The previous implementation returned 0
unconditionally which matched the first listed configuration
regardless of the actual silicon, which after the dtsi split would
load the wrong tifsstub variant on HS-SE parts.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 42 ++++++++++++++-----
 .../dts/k3-am62p5-verdin-wifi-dev-binman.dtsi | 15 ++++---
 board/toradex/verdin-am62/verdin-am62.c       |  3 +-
 board/toradex/verdin-am62p/verdin-am62p.c     |  3 +-
 4 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 7b646629587..ae9d337e070 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -295,13 +295,24 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am625-verdin-wifi-dev";
+				conf-hs-fs {
+					description = "k3-am625-verdin-wifi-dev-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am625-verdin-wifi-dev-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-gp {
+					description = "k3-am625-verdin-wifi-dev-gp";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
@@ -414,13 +425,24 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am625-verdin-wifi-dev";
+				conf-hs-fs {
+					description = "k3-am625-verdin-wifi-dev-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am625-verdin-wifi-dev-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-gp {
+					description = "k3-am625-verdin-wifi-dev-gp";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
index b46e871ef8a..9228ac83e11 100644
--- a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
@@ -248,13 +248,18 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am62p5-verdin-wifi-dev";
+				conf-hs-fs {
+					description = "k3-am62p5-verdin-wifi-dev-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am62p5-verdin-wifi-dev-hs-se";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "dm", "spl";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 19ac2ae9313..d91ffcf077e 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -12,6 +12,7 @@
 #include <dm/uclass.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <k3-ddrss.h>
 #include <spl.h>
@@ -60,7 +61,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 #if defined(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	return 0;
+	return k3_fit_config_match_security_state(name);
 }
 #endif
 
diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 1234b3887c6..77de9feffb5 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.c
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -14,6 +14,7 @@
 #include <dm/uclass.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <k3-ddrss.h>
 #include <spl.h>
@@ -86,7 +87,7 @@ int dram_init_banksize(void)
 #if IS_ENABLED(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	return 0;
+	return k3_fit_config_match_security_state(name);
 }
 #endif
 
-- 
2.43.0

