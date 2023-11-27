Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196FC07CB1
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94645876D7;
	Mon, 27 Nov 2023 14:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WcihVUXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D8C87633; Mon, 27 Nov 2023 14:01:04 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A17C876D7
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507c5249d55so6338709e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090060; x=1701694860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/ApHZZokfYNAhQkIrUJHXefSMXsGfI8Z1dkA9PV0nk=;
 b=WcihVUXQ7Mqev/v3gs8epfn9cZ4qs94uSKdL8zCFgPYYlySrI5mH0spM3exr2kVu50
 Djie+4k0yaZSlVsNC0CDp/TCCvGtGc0eWEFKyUeNcqLMp5uzezYXTfEtFBY1iHWxsfyC
 8GXiB/MB4omEJM150sSmXJigofThoiCAQ31aOoK5/x0mUvLD2/m5VaIPgAW/RhyPfunK
 ZnecpSOAi0hs31zO9Px7Vzv4wU4UrnHnojdTeUnHSgQ+qLhBj/RHsaNdCjIQnFjS3nd6
 MD7vtcZJlx9qdAq5HE2SdW5XnutO++9QiXEr8LStrICdErjK6gUGK5VNu2/QVYIOcczV
 O9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090060; x=1701694860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/ApHZZokfYNAhQkIrUJHXefSMXsGfI8Z1dkA9PV0nk=;
 b=UxTfEjxijRFEuNtLax6lpsfrDp1A5D+PtYf+A1B4LIG2Ln+o3wfBsKs2CaBm38BrWz
 /HrHj2K5/B8PyiCTyPFE/bKlduJyYkzEp6JULm3YwWfJS+pifGyWd0+JEYOyxkWGk8an
 weQHofwHfoegVP0MUIPoMKa2Zg1JtnfEaEjohy58TclKIkr6YrnGsksc14RGWLzsNTfU
 03TTR7a6FiMEgJvhdi7yr71+YxM5tdEQ9lww+m9rvcVM0y0wetddtNA0Hi4F0R9QeHjo
 lYQCtIVAi2GhoVGAgOvCc5srBPbq7bBGzUDIqsSCdYHXktJ657GdTAwqwZ/mTpAWsNqk
 8gmw==
X-Gm-Message-State: AOJu0YylLy58bFxZBPOpu3COjyXJF1kTONX8KvQoAaT/Flb0b6vTxvuB
 ZASY+7EE6Nksi9ku6wPq05xg26l5Lk/zX6LF3x+mOQ==
X-Google-Smtp-Source: AGHT+IHGa1gFNSuudBcyl7mzaQEGgiIfYHl0DrsZzPqNDoGp3v9/gjLywqHI9rHMa3y5uQseGL2c5Q==
X-Received: by 2002:a05:6512:909:b0:50a:aa80:546e with SMTP id
 e9-20020a056512090900b0050aaa80546emr7117109lft.59.1701090060204; 
 Mon, 27 Nov 2023 05:01:00 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:59 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 22/43] bcm_ns3: fix overlap define with lwip
Date: Mon, 27 Nov 2023 18:57:05 +0600
Message-Id: <20231127125726.3735-23-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Rename declaration to not overlap with lwip.

aarch64:  +   bcm_ns3
+In file included from net/lwip/lwip-external/src/include/lwip/etharp.h:53,
+                 from net/lwip/lwip-external/src/core/init.c:55:
+net/lwip/lwip-external/src/include/lwip/prot/ethernet.h:69:
		  error: "ETH_ADDR" redefined [-Werror]
+   69 | #define ETH_ADDR(b0, b1, b2, b3, b4, b5) {{b0, b1, b2, b3, b4, b5}}
+      |
+In file included from include/config.h:3,
+                 from arch/arm/include/asm/string.h:4,
+                 from include/linux/string.h:21,
+                 from include/malloc.h:369,
+                 from include/stdlib.h:9,
+                 from net/lwip/lwip-external/src/include/lwip/arch.h:83,
+                 from net/lwip/lwip-external/src/include/lwip/debug.h:40,
+                 from net/lwip/lwipopts.h:93,
+                 from net/lwip/lwip-external/src/include/lwip/opt.h:51,
+                 from net/lwip/lwip-external/src/core/init.c:38:
+include/configs/bcm_ns3.h:52: note: this is the location of the previous definition
+   52 | #define ETH_ADDR

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/configs/bcm_ns3.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/configs/bcm_ns3.h b/include/configs/bcm_ns3.h
index 47de4bc201..7c6e0725a6 100644
--- a/include/configs/bcm_ns3.h
+++ b/include/configs/bcm_ns3.h
@@ -45,11 +45,11 @@
 #define PCIE_ARGS "pcie_args=pci=pcie_bus_safe pcie_ports=native vfio_pci.disable_idle_d3=1\0"
 
 #ifdef CONFIG_BCM_SF2_ETH
-#define ETH_ADDR "ethaddr=00:0A:F7:95:65:A4\0"
+#define BCM_ETH_ADDR "ethaddr=00:0A:F7:95:65:A4\0"
 #define NET_ARGS "bgmac_platform.ethaddr=${ethaddr} " \
 	"ip=${ipaddr}::${gatewayip}:${netmask}::${ethif}:off"
 #else
-#define ETH_ADDR
+#define BMC_ETH_ADDR
 #define NET_ARGS
 #endif
 
@@ -749,7 +749,7 @@
 	OS_LOG_LEVEL \
 	EXTRA_ARGS \
 	PCIE_ARGS \
-	ETH_ADDR \
+	BMC_ETH_ADDR \
 	RESERVED_MEM \
 	SETBOOTARGS \
 	UPDATEME_FLASH_PARAMS \
-- 
2.30.2

