Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A364AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E9A87ED3;
	Fri, 12 Apr 2024 20:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V7/QfB/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6745087FED; Fri, 12 Apr 2024 20:10:58 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CFF87E82
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4167fce0a41so12819495e9.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712945456; x=1713550256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hYfRHMxRKccz/VtQHHnfWA50Q3udn+ze01RK20ZMWMQ=;
 b=V7/QfB/sBII1nR7w9b0jF8EgvDQJeDK+91VGGzJPNYJUPH4jMI2rey2bjX38Ouxl8x
 EAQWgkvhTDuuWu/NKqUQlFynMEuB285Tv1TGKlQ/Ge5elCOk5TUuA42uJwGhu/al3Uc+
 /SA0f98CLieo6zkDtWoZ+WiMoKN+HoWh0qxyVhujX7L+fPU/5BNdp1ogokB2v533IYk5
 gQPksbYEGuNy1Z+tje2IJrY8wZeF3iQTHWZQwUaldfpzwCoSh5/ifUt5+GzARw4LcYWo
 pdWLcI6itNVtE9FSGjh6rsLFYc469BpWe8hvef2qr+2FTjEvD5t+vyucejFJ6iDJo6zS
 ezlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712945456; x=1713550256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYfRHMxRKccz/VtQHHnfWA50Q3udn+ze01RK20ZMWMQ=;
 b=F/IGODa5/hRijmcALRN8qAHE8iBsqgmkIrOIm0N2Sn6OIKIa2mP0w15MdCCQXhloRn
 tDkfOf+wpO87SjC2LID57SmIDnk6K7gChZV3MbGSvbhpvq79VjxJIsD+HETvVC2z9Yke
 SYYS5HeSI6j3o3b+ZZIryuzcR8dtxpDDt8rYmNlI4BGSZ7bVzuUDhLCX4c7vIysTfk0Q
 dqKVC76JQfo1vV7dkMvQVf5APTml6QnIbJHkDqLFiqegPRAisSTtvhNeC5fP/cAV7c1q
 a068Zu/N/GJBxePVPoV8+dMP/dmB2hQiUxF2MO7vMr/r7e41dc32c32vmeyxHhrDriWV
 Bezg==
X-Gm-Message-State: AOJu0Yyl3x6mmkzURaibW/JqIPPcpbiDRJnKwHw0NcsfmJtmoap/xWLn
 MN5VyEDGUtCUbMZaodS3insCkjA5xyTUF9qJzVG0NDdf1YaK4Y4ZScJTM7Vb6Io=
X-Google-Smtp-Source: AGHT+IGI1HZAabw+IbAgtVK6QqEIT6O4TropCEOSuuhoM/oik0Mrbh2Ms+CdxZ0srIcgORL5fbSySg==
X-Received: by 2002:a05:6000:e50:b0:347:2489:ba3c with SMTP id
 dy16-20020a0560000e5000b003472489ba3cmr1454674wrb.3.1712945455745; 
 Fri, 12 Apr 2024 11:10:55 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech (92.40.205.160.threembb.co.uk.
 [92.40.205.160]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c4fc400b004170e0aff7asm9188250wmq.35.2024.04.12.11.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:10:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH] mmc: msm_sdhci: fix vendor_spec_cap0 registers
Date: Fri, 12 Apr 2024 20:10:21 +0200
Message-ID: <20240412181031.1513372-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

The addresses were mistakenly swapped. Put them right.

Reported-by: Sumit Garg <sumit.garg@linaro.org>
Fixes: a737d8962cae ("mmc: msm_sdhci: correct vendor_spec_cap0 register for v5")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 2144772ac325..5e9d66526a83 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -255,15 +255,15 @@ static int msm_sdc_bind(struct udevice *dev)
 
 static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
 
-	.core_vendor_spec_capabilities0 = 0x21c,
+	.core_vendor_spec_capabilities0 = 0x11c,
 };
 
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
 
-	.core_vendor_spec_capabilities0 = 0x11c,
+	.core_vendor_spec_capabilities0 = 0x21c,
 };
 
 static const struct udevice_id msm_mmc_ids[] = {
 	{ .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },
-- 
2.44.0

