Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CACFCDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7848284A12;
	Tue, 23 Jun 2026 16:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qZpYUDQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBB4849CE; Tue, 23 Jun 2026 16:16:07 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B78849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D5ADB3F60A
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782224164;
 bh=Hzve5l/rDqgKhs5tf00L9YjoRvBSuFik8+bdSK22Oww=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qZpYUDQrQJ0vu3HOXAURBDYlMguE/fzqqBA29miBvTw6a8as4jORkqm8Zqr45w8r6
 Qq0tlOIdAKLvCuUWuOAcozfhgqX1OG+o2DbVe5JRVGIJQfIQp0M0VemgNBGYAfD7fI
 7rxgaIhUGRALWTusAqzpobFn75gH1Dsz4rcqm9ha6VtwJkhvu/EWq93b77ppetxjV9
 HR/AatuCOQ1j5u3BsJsdUEu6FXFB7sz0/a9WpJsvDHo2WOBzAwC8Kj01r3SpXTXRho
 r/lNs3b2qAByYmAxBWJMelpLxiCEmxhdkAnPHa4hhzWEvtGqkgrEoT+5KkTxt9H4en
 l2sv2RJxxLcCzXvXVOiyoKjPwDTZIpfqifpyaeaTnnQTMv94xYDil7p+XTdlRUu5fo
 3kDVeREvyE/dg+oWkmjsOieNLROrIMsomRHRuTgqkIc92uS0e5vJFTpPRY535P159r
 clZXNzV9b1Vxtkqafu0lwL5ifN3azJYw7lnpxfWF+736YAF0onarpoWXOdfcmqr+4r
 rr9pQ9NtYIlLbT88yg+tjndlI5k9tybBMMD/zTbwjx0/ZINywUZnhXXJMxJvul45it
 HtJz021UWl0L+l5WC1gaHhan/wg5yfD0o54ussR4HnuvYlYIAgk7JZWz/qE9ZAaypq
 /AlZIxmCIlQznIDAT9kU6g7o=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c6bf305403so51601615ad.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782224163; x=1782828963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hzve5l/rDqgKhs5tf00L9YjoRvBSuFik8+bdSK22Oww=;
 b=BLskIUzRCu19VWuwuciWrayAPqpV6tr5lnTHcw66BCjsw9XKX8jgFA/bpFZDMZgpm/
 H7gt6IuLC++hrWl2v2OAndPSS3R8EitloX+PZQ7dwDc5WcbtBY9IniucvcQjqqFRGwll
 qagN4ZV4SexbnsC2H9ZDZftX9hAArCNe3GLjdaBnYJuzBnPygTbRZsFCAtVBGqXOhiFk
 LY1tfW3OFbCb5KHLc6kGRaPDQOP0VeePX2gz7pqB+AJnN+Ft+PhiFCmRl5I1guH3v55p
 jb85cIXWvczuoHoQmt5G6hJsOkNk/An+PBCeyVw6yJBpHcu3EpgAFAVNdZcZrtnz3sGm
 281Q==
X-Gm-Message-State: AOJu0Yz1EIt+Bp0Yb5mKFcRYCdZ/0OeaprkUXwmj+SukYolicnsNkyX8
 GUFQy9OAru0wXYjSw/krTZAA/DeJPKTRYPWhPtvLqa/0MPMbNOIfTRm29YY9wWcaxHvNpM5QUfN
 kR2bmptpiLDromYW/Qc4VEzd5zW+0gBZmebTZY8JFwfyQovLbn0CFlH/PtIfg90e8sAlK9ruhR6
 OPLq/k1A==
X-Gm-Gg: AfdE7cnWXKECDSk+1uZ1iGUNVCxLC2NcR75jiSVjNdq9GLNvQJbh79qA1ZEAUJY0s/j
 YJ7J9+10L5Bc5e0eXOqRA3gmtFS+ywU9hLE2DNHyPZ3B1VYb+W2A9B9336VYX9lBM/SaHv+JEkz
 p2pFzqkn9ibm80kauWJn2gTAXDv1HH1tYU0Xv4cC/8pbSRYWLVj9AfhU/Z6MsYLk/glnZVPYKXt
 OKJwe5Lz8bDeJ81BTsx9RqiqnZ5kLLB9+ReeWH3R1byIQUXueXegKA6S658cu6aAr/foIXN0k6x
 mv3yH0xY8jMQHUSlLQBNPEn/fMDZGB3+LMx/FyXa7srwZVPjloY62G22UTxL13MEaoYAOHZvst6
 RCTRJKfjPqkoOaymjiHlqaPjOnB+dGq1d9u0OE0Rul2l2A4uiYdFOFfq3kqLczQ==
X-Received: by 2002:a17:902:e5c5:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2c7c7386f94mr35498285ad.0.1782224163336; 
 Tue, 23 Jun 2026 07:16:03 -0700 (PDT)
X-Received: by 2002:a17:902:e5c5:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2c7c7386f94mr35497635ad.0.1782224162664; 
 Tue, 23 Jun 2026 07:16:02 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436d3505sm110410325ad.19.2026.06.23.07.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:16:02 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
 Suhaas Joshi <s-joshi@ti.com>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: [PATCH v2 3/4] board: toradex: verdin-am62: select tifsstub via FIT
 config
Date: Tue, 23 Jun 2026 14:15:17 +0000
Message-ID: <20260623141540.618272-4-aristo.chen@canonical.com>
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
 board/toradex/verdin-am62/verdin-am62.c       |  5 +--
 board/toradex/verdin-am62p/verdin-am62p.c     |  5 +--
 4 files changed, 46 insertions(+), 21 deletions(-)

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
index 19ac2ae9313..c4bdf8a19af 100644
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
@@ -57,12 +58,10 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return 0x9C000000;
 }
 
-#if defined(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	return 0;
+	return k3_fit_config_match_security_state(name);
 }
-#endif
 
 #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 1234b3887c6..95c270d6078 100644
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
@@ -83,12 +84,10 @@ int dram_init_banksize(void)
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	return 0;
+	return k3_fit_config_match_security_state(name);
 }
-#endif
 
 #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
-- 
2.43.0

