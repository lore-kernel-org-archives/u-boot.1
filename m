Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0303DCA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B22C882E34;
	Fri, 22 Aug 2025 20:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="oE/7S6US";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F87280548; Fri, 22 Aug 2025 20:56:34 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74A380548
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755888991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jk1lqSbGoMkBBwnjX4YPpTUFq1ihGMaiygQOUlSdZ08=;
 b=oE/7S6US+rl/Yq0uMRDQoUq60K6z8EzugepKIXUt0vfDqgh2wDQvs2+yKjVv0oav5PkvdF
 wd6BuJjy2VrVyT4PmX5lPy/MsHc4nCutSmAicoM1uKLK0ZvAYybT1rX2tIL4Sxqb4RBV6Y
 FJe+9F78FzFgkoapSR/OiXTEnvalgu4=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:54:40 +0200
Subject: [PATCH 3/3] ARM: exynos: pinmux: add newlines to debug messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-exynos-origen-and-pinmux-debug-msg-v1-3-e6384177b42b@grimler.se>
References: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
In-Reply-To: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
To: Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4105; i=henrik@grimler.se;
 h=from:subject:message-id; bh=HvT6I61GP3ABoeM77wNdrfdQazdZjCEe+Qf866BLkek=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqL1XfE0uURkRfYqYIValxdX3AOp1fQdjykMdA
 egQj5vsHImJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi9VwAKCRCwB25JC3Fh
 a2PWCACcb42okKuufU4rCmede6+rqyUn7dv9XMCv2TVlwyt0lCdKqgcR3Vn6y0kQLUqxUFMgVKA
 SK9KFx9AIz0t30oy+WaOIuwPovz0kBVRg7fa44ypCG3oEt10y/ejusffxQrK381QBTQ34mlkZLv
 5gDaQu3EHgWSgS4CEeAD1l8r3K6V8p9OQUpf3Z4eo/m+VPX2qp07Fi5GQg06DFOssJWeImMDqan
 PBTx2EDtp3kppUiEyqqXvJ9Qxwq4cXROVJa17QF+2ce0RsdWqY/4tTyfTlEw8ChTx/zi1iqWAEz
 rwCBX+2aubIHLqxqgeIlApav8kYmUXUM/ZczXJfVjtAnGCm+
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

To make stdout messages easier to read and understand.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/mach-exynos/pinmux.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
index bd82e1ac750d8b5b7dc1e2e02324ded3009f93d4..ed46ea033558149d261cffea59a777a86215a5ed 100644
--- a/arch/arm/mach-exynos/pinmux.c
+++ b/arch/arm/mach-exynos/pinmux.c
@@ -32,7 +32,7 @@ static void exynos5_uart_config(int peripheral)
 		count = 2;
 		break;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return;
 	}
 	for (i = start; i < start + count; i++) {
@@ -63,7 +63,7 @@ static void exynos5420_uart_config(int peripheral)
 		count = 2;
 		break;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return;
 	}
 
@@ -97,11 +97,11 @@ static int exynos5_mmc_config(int peripheral, int flags)
 		start_ext = 0;
 		break;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return -1;
 	}
 	if ((flags & PINMUX_FLAG_8BIT_MODE) && !start_ext) {
-		debug("SDMMC device %d does not support 8bit mode",
+		debug("SDMMC device %d does not support 8bit mode\n",
 		      peripheral);
 		return -1;
 	}
@@ -145,12 +145,12 @@ static int exynos5420_mmc_config(int peripheral, int flags)
 		break;
 	default:
 		start = 0;
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return -1;
 	}
 
 	if ((flags & PINMUX_FLAG_8BIT_MODE) && !start_ext) {
-		debug("SDMMC device %d does not support 8bit mode",
+		debug("SDMMC device %d does not support 8bit mode\n",
 		      peripheral);
 		return -1;
 	}
@@ -453,7 +453,7 @@ void exynos5420_spi_config(int peripheral)
 	default:
 		cfg = 0;
 		pin = 0;
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return;
 	}
 
@@ -522,7 +522,7 @@ static int exynos5_pinmux_config(int peripheral, int flags)
 		gpio_cfg_pin(EXYNOS5_GPIO_B20, S5P_GPIO_FUNC(2));
 		break;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return -1;
 	}
 
@@ -570,7 +570,7 @@ static int exynos5420_pinmux_config(int peripheral, int flags)
 		gpio_cfg_pin(EXYNOS5420_GPIO_B20, S5P_GPIO_FUNC(2));
 		break;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return -1;
 	}
 
@@ -683,7 +683,7 @@ static void exynos4_uart_config(int peripheral)
 		count = 2;
 		break;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return;
 	}
 	for (i = start; i < (start + count); i++) {
@@ -797,7 +797,7 @@ static void exynos4x12_uart_config(int peripheral)
 		count = 2;
 		break;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return;
 	}
 	for (i = start; i < (start + count); i++) {
@@ -834,7 +834,7 @@ static int exynos4_pinmux_config(int peripheral, int flags)
 		debug("SDMMC device %d not implemented\n", peripheral);
 		return -1;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return -1;
 	}
 
@@ -869,7 +869,7 @@ static int exynos4x12_pinmux_config(int peripheral, int flags)
 		debug("SDMMC device %d not implemented\n", peripheral);
 		return -1;
 	default:
-		debug("%s: invalid peripheral %d", __func__, peripheral);
+		debug("%s: invalid peripheral %d\n", __func__, peripheral);
 		return -1;
 	}
 

-- 
2.50.1

