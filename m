Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227E7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739BE876D7;
	Mon,  4 Dec 2023 13:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QclteVqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F771876FB; Mon,  4 Dec 2023 13:07:31 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0848876D7
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50be24167efso2497344e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691649; x=1702296449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vD97G0JJPrjstx9DxxLj3RhYbyE5f2FSKSx/K3ncJMM=;
 b=QclteVqNaDvZAnTvnEUw9mzHMcaLT99lR1P566li1NL7PCIcFGus+8MdL8hPsqS288
 t2q5fVGyC1iHZ5+gnQ3VmDk72psHIQD4u+Pfo5MQrZj1yMwBqLXzBaC6+K2w2v1yO3ss
 p3uoYtWtnxuZduSAqxsdafzGzFL8bEoz9SAx9bRChp/L/RZxvVw+LIOD4yUYtVeesH2n
 /J0nTFESLUnIqwfscxrzrGT3gaesOj9IFRIw1bwarHZxj4b0J+tcTe4h0oJfANdn7VXB
 P8afC0AMOuwaJIbmbea9UasIk383DuDumD/IoXjYxb9sFS7P7AZzXhuL3mA4RgbPKYjC
 BzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691649; x=1702296449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vD97G0JJPrjstx9DxxLj3RhYbyE5f2FSKSx/K3ncJMM=;
 b=vJzHcuNnIv6FxXk6KBIqIpWX1DJIzzzECGInPo6Lit64jNazwW+65hQsYuJxcH0xYl
 A0Xdvz4gTdCYWIp0dRuURn3gaKwNBj2S1F9Y/3m5JqI45FGfzV9pcxIcwKmuJVT+GP8A
 zRVUJq+pPz4fvi3t1gvkM/5iFe96vV4uobjVYGWrhwrDjI2F92JEEGKMztXczobNVXrc
 0tMTLE1qsizCgtkCt0BQEjeCGjp6PeGUPmKiTDFcnm89pCqLLgVjVQpdIfhVwpZ0Lose
 Z2IiKDGKbj7oyWlYeSE/oB1w2KxEh4E0q+5yR4YPc2quEzcuCESp6PomKQbXeHdiJ+nk
 LJVg==
X-Gm-Message-State: AOJu0YzSlkgVAgmSMT+GbR3YJOowjwMjkZ9QySKJXBQ6q57CgYKY1l/J
 KBHbhY5ReFvP0fKtfKU+6VDR1uw1E8VIrytEagTcdA==
X-Google-Smtp-Source: AGHT+IHsOYhaKefDNXQTAgA99No/qjdTxqlZzOACy5Ubw56TXrAiMJKRYrp2o9ZFDFoDWJ/48tn7Dg==
X-Received: by 2002:a05:6512:1388:b0:50b:f304:3bed with SMTP id
 fc8-20020a056512138800b0050bf3043bedmr518647lfb.49.1701691648830; 
 Mon, 04 Dec 2023 04:07:28 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:28 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 7/9] bcm_ns3: fix overlap define with lwip
Date: Mon,  4 Dec 2023 18:04:44 +0600
Message-Id: <20231204120446.3277-8-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
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

