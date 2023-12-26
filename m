Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3B6C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2393386F87;
	Tue, 26 Dec 2023 16:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="slb72ob8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF6C86F56; Tue, 26 Dec 2023 16:48:57 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAFE387968
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e7aed08f4so1322855e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605735; x=1704210535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvQDLylMZZyItYAARaG/slPihLAB8fb3RjCohXg8958=;
 b=slb72ob8ODUgX3OxB7iItdmJ6ng9TuRBVyM1f3y5bRFejpQ2oiJ3DGcw0BUYW33njc
 fdCthGSKop/tvKHt/a6Bxh92Mv43G/SSrpXPs5R25N7jYgWgBcpa+takxbPCWQ8uV9pL
 ao56QZSmP2pvBWWwFX9C5eINsA2q14Kn9UnsTIkP1gdG9h0Yz0D8H9ZAGEHbhBrrCQR6
 PbHd3oylpewFvduaTa2xN9enzcEwGvt/KwXSmyXBJa+14h4hSLeu4tCeBldNGyVNuM5r
 AZdk72T6evKB/HzunKRs1J3S12JtMwqmEPUNbpEwFXfTzFiQ8MRpSILTDTWyTCpSGTTo
 8Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605735; x=1704210535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvQDLylMZZyItYAARaG/slPihLAB8fb3RjCohXg8958=;
 b=SmzxoGU5uLQykME1uOk55JIkO2+93Q4ndVs7TYGL0wrSevCo95OycYLTuhBbbeEFr3
 MAWyuSmYqqSvjp9rqdRGXspHjF1MThsKpsvbLgoOcZE4+rPnvWQOs0vPzYuDBETu63cp
 2fR+odYnIbGtvIGr/LtgtHoLunb5/g/yHwvlZJEqp2DagBqlPn/ju9OJAoSXgUC1q9P9
 iCUymttDkkUweGqh6GXzlkFxD7wrUwqFADxacahfhkB5vLdt/OyCGJ5AkFiihsGkQLTe
 vMbBixE2f9Bi4FystzSZMmvxwUtUv/7JEMfiNMjp2xqsMTq92sms9wXIybSFujNsQ8fX
 mgPQ==
X-Gm-Message-State: AOJu0YxYD5cZz0dp0SzjGtsNA+lSufPkZ5MWU8pPKT9NP4T1B+ow1wGk
 BHbXtFjVRJYV1q3rSA1b2G51yLeLYYaJNzSrstcbrJRHXdo=
X-Google-Smtp-Source: AGHT+IEfxq0HF/RLLLTi0+QIFqw6QZR6HcaWY2URDGST9j5jjLo0owlslwTex8qrGieaLH87/GzI/g==
X-Received: by 2002:a05:6512:128b:b0:50e:7f5c:6c7f with SMTP id
 u11-20020a056512128b00b0050e7f5c6c7fmr1140310lfs.17.1703605734639; 
 Tue, 26 Dec 2023 07:48:54 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:54 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATHv3 6/8] bcm_ns3: use device specific naming for variables
Date: Tue, 26 Dec 2023 21:46:17 +0600
Message-Id: <20231226154619.5071-7-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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

Use device specific naming for variables so as to not overlap
with common function names.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
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

