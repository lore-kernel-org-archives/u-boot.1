Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A83C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2E883655;
	Sat, 24 May 2025 01:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hY9KDHMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D04A8333D; Sat, 24 May 2025 00:59:26 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B7183340
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so200654a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041162; x=1748645962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xS/5SPAiUxuPu7wbCfrZA9hWr6DgHyOeezj13xagxYE=;
 b=hY9KDHMPYpeQXFmq8TMMwPmvhdnAtEAy/SAV/hNRtihU+Iq1imlRB7tTyyz2hAOODA
 JeMCz7ZHkw6Ir2H4cY171opNwlOkdvsiE1Xhyx248gk3Hm0HRIiEYX9zn4U3zUiGIR5T
 qjNzGZfBMbKnZw7/tO2esmBiuCe7QmAOdyqTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041162; x=1748645962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xS/5SPAiUxuPu7wbCfrZA9hWr6DgHyOeezj13xagxYE=;
 b=N62P33n7JIrrSsJNYWy0NDWYw+IBkwJlzdtt93eCr1kEFgQomEGzYdNiRuQOJMXcP8
 YYEvQHdCHAfXU563db77k/8cgm2LLdoBVpnzf+hhU6JTNAoPL1bok+bwHkjyuE5PVEJY
 gbW2WqC+gzEwCRjw0z83bCvqYr8hsFRX/nRfZWGtEQTh0KirFWdHlSRxmbfo6i6/luib
 2AqeF5ArZe6GDneasCOaccN/RdbA29nqHkCSvDRKkw+YtKAkkrAyC9nmSs9rKq47RPvz
 uHO9swpmWqVNNVtYX/hcHUASbWrUPx6FTwnbGn+PrKgb9m7HPK9Ig1NZvsrj8OGyyb+9
 zWbQ==
X-Gm-Message-State: AOJu0YxWeMkTeGMtwC9Z0OCLo4v+8sHyUXGh1+C+kBkLf/2ptY9Qg3tC
 qH9BcsT1b6WsuDlaYGk0qCB3nFqIfXhDiTDZCsFmCdxshLh3unMILsXLrgRjzjV0F+oEybwZM3B
 QiT0=
X-Gm-Gg: ASbGnctsuv6EqZAHT0tjOeTYV+l18G0AQyt8wVZGeKuYGKiCHcvBfVpHmBi8/8s9vBc
 aiGCikrh8YF5R6y8TZSwifdLgUPc47x4cwSAQG2UfJG6IncaNUdbglZJlVH6+buAsScnqa7w8TZ
 yGMvX7ur0u0PnIrsvRZTIwVcsGRKUrqrDE2dDFeEOIt0mZT25PDGn855AYfc/a2x9Ndwm+2i9VP
 q2WRkqek0L2OV2DFLjy5wVKBTew6DNFAid1qMLSqf6K5karG45V5wcBRbAEJETFRI0lGYvSPIAc
 RDL+h/E9MZspOeChJHOIobbCPKbEsaFwBYFhVSP1x5LL2vV/qpDIm116vMJFfKjKftwnTCtVnKO
 bl77PAMOzfTb39i60C/EIX6djTQ==
X-Google-Smtp-Source: AGHT+IFdCyYXFP3Dobr5S87uq//v02NuZTZvYB2UtpIqD219w/Dnnj3r0LL8vLZHAhVWCZ+pLg502w==
X-Received: by 2002:a17:902:eccb:b0:22c:3609:97ed with SMTP id
 d9443c01a7336-23414f9ee88mr16917565ad.30.1748041162405; 
 Fri, 23 May 2025 15:59:22 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23401ad40c9sm10051375ad.76.2025.05.23.15.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:21 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 23/28] mach-snapdragon: Allow usb3 to work when a coreboot
 payload
Date: Fri, 23 May 2025 15:58:38 -0700
Message-ID: <20250523225845.2311989-24-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Coreboot already initializes the USB3 controller and PHY on Qualcomm
devices. Skip fixing up the USB node on platforms that are a coreboot
payload. This provides a working USB-A port on device like Lazor.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 1ea0c18c2f27..fd4aa3ba7055 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -41,13 +41,6 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
 
 	debug("Fixing up %s\n", glue_np->name);
 
-	/* Tell the glue driver to configure the wrapper for high-speed only operation */
-	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
-	if (ret) {
-		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
-		return ret;
-	}
-
 	/* Find the DWC3 node itself */
 	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
 	if (!dwc3) {
@@ -92,6 +85,21 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
 		return ret;
 	}
 
+	/*
+	 * Coreboot already initialized USB to the point that USB SuperSpeed
+	 * works, don't tell the glue driver to only use high-speed.
+	 */
+	if (gd->arch.coreboot_table)
+		return 0;
+
+	/* Tell the glue driver to configure the wrapper for high-speed only operation */
+	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
+	if (ret) {
+		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
+		return ret;
+	}
+
+	/* Tell the core driver to configure for high-speed only operation */
 	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed") + 1, "high-speed");
 	if (ret) {
 		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
-- 
Sent by a computer, using git, on the internet

