Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E63C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 23:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA49489087;
	Fri, 26 Apr 2024 01:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714086105;
	bh=J96QMBhWOZ22tLa0iKMRvQnHoKmvd9U+3BRd8rfadF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBkStOs+ibDEo8nQ9yhCzAeATfD/V+AipzZyBENXztddlWhoqSt8oSQfRL7FhS+MS
	 CvEqAAZDFifarJnMIzk+3+xLBAfyGdAVhx+EkaXC+htqQEHP6qdTwFHd78gHdVIM/r
	 Xe6wKBauAcDFn6wIjdpXN9vQiE2ZqIpEFAYWw9+MtiQKy3tKP6N95GTnghXtC2MQTa
	 l/ElyjK61RYxBtX1mjk4wO9Drl+hjOVufp4tq8ZFYTXnxnLTN9+D9I9A8//eunkRT9
	 j+QUHl5OkyZUhxZB27qxEaNri1zHuUd6OlnFtdvC52rWTdHEbIP8JVR56Q0O/VFHSc
	 aUUd4sEDNbhKQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F26618907F;
 Fri, 26 Apr 2024 01:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714086102;
 bh=J96QMBhWOZ22tLa0iKMRvQnHoKmvd9U+3BRd8rfadF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dBKMo82/jBGd5oXP7VwS2cUj0P1jsD8mr6JcTtFqv4ST8VpcWhsl+mbfmZskU2jOT
 cBADUfl0YxzDASR735bNI7nbG2vKOdJ6Prr36gfo2iWrMPI6/DIQrJA6PCAemRHfXY
 WmAbijGidSWuYBHq0B0acgJKD7udkT5lhq6v31YhgJwKapa9kt0YcN6o9Nq8HlRlBu
 zHMkPB/+7iul5H+U+3cfpEpF+Qrn/px/sZkqfmlK2C90SyP200N+781XjHAxdMWEM3
 jJpunOvhLLj/+tC1/roxbM4AlWkjmGty7k0efpkmqIFEcYuVKoW/fDODHbAwPSjcfr
 fGpVycI10AdGg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: [PATCH v2 2/3] ARM: dts: imx: Switch Ronetix iMX8MQ-CM to
 imx8mq-u-boot.dtsi
Date: Fri, 26 Apr 2024 01:00:36 +0200
Message-ID: <20240425230102.497160-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425230102.497160-1-marex@denx.de>
References: <20240425230102.497160-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Include imx8mq-u-boot.dtsi in the board -u-boot.dtsi to pull in binman
configuration instead of duplicating it in the board -u-boot.dtsi again.
Drop the duplicate binman configuration.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: kernel@puri.sm
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: No change
---
 arch/arm/dts/imx8mq-cm-u-boot.dtsi | 111 +----------------------------
 1 file changed, 1 insertion(+), 110 deletions(-)

diff --git a/arch/arm/dts/imx8mq-cm-u-boot.dtsi b/arch/arm/dts/imx8mq-cm-u-boot.dtsi
index e23998f5aba..819501337e9 100644
--- a/arch/arm/dts/imx8mq-cm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-cm-u-boot.dtsi
@@ -3,11 +3,7 @@
  * Copyright 2019 NXP
  */
 
-/ {
-	binman: binman {
-		multiple-images;
-	};
-};
+#include "imx8mq-u-boot.dtsi"
 
 &pinctrl_uart1 {
 	bootph-pre-ram;
@@ -16,108 +12,3 @@
 &uart1 {
 	bootph-pre-ram;
 };
-
-&binman {
-	 u-boot-spl-ddr {
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-		align-size = <4>;
-		align = <4>;
-
-		u-boot-spl {
-			align-end = <4>;
-		};
-
-		ddr-1d-imem-fw {
-			filename = "lpddr4_pmu_train_1d_imem.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
-
-		ddr-1d-dmem-fw {
-			filename = "lpddr4_pmu_train_1d_dmem.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
-
-		ddr-2d-imem-fw {
-			filename = "lpddr4_pmu_train_2d_imem.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
-
-		ddr-2d-dmem-fw {
-			filename = "lpddr4_pmu_train_2d_dmem.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
-	};
-
-	flash {
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8mimage -e 0x7e1000";
-
-			blob {
-				filename = "u-boot-spl-ddr.bin";
-			};
-		};
-	};
-
-	itb {
-		filename = "u-boot.itb";
-
-		fit {
-			description = "Configuration to load ATF before U-Boot";
-			#address-cells = <1>;
-			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-
-			images {
-				uboot {
-					description = "U-Boot (64-bit)";
-					type = "standalone";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-
-					uboot_blob: blob-ext {
-						filename = "u-boot-nodtb.bin";
-					};
-				};
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					load = <0x910000>;
-					entry = <0x910000>;
-
-					atf_blob: blob-ext {
-						filename = "bl31.bin";
-					};
-				};
-
-				fdt {
-					description = "NAME";
-					type = "flat_dt";
-					compression = "none";
-
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf";
-
-				conf {
-					description = "NAME";
-					firmware = "uboot";
-					loadables = "atf";
-					fdt = "fdt";
-				};
-			};
-		};
-	};
-};
-- 
2.43.0

