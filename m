Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE81C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F3288BBB;
	Fri,  9 Aug 2024 01:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w3uGD7Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521D588BC9; Fri,  9 Aug 2024 01:59:47 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682CD87A09
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7ad02501c3so192569066b.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161585; x=1723766385; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k0ESLrS1WTFOEAW/3y23+jWpZgNn4RlJc729y8exhfQ=;
 b=w3uGD7PxZBCNygIpWP0duflu5MuWs1OHcnDqy2bALODNGU6fz1mYiELdpd/6dcoxz9
 ICUzifSLl9JJeDranJSphsCZ1NY5P6a8/J2EqcDULrVob8L1Y54J68/MOKfteIf6wjyI
 wztrpaOyh5j4IEBr0v3D3wNIrbM4kkP7Sc8/u1MNoXTglQH+y8x6sgMuNtfbsXPWALBW
 Q53N0eFdoQgPnRUy/Fc/Hv6cf9h3dRuYyJAt0ngI78etTU23wPdTldHgnHTgojLIiHCt
 cKrTpKZcnBDa9heK9NqhlNmF4OXplTM0059oP19eUDjT0BBY7q2thGYrlOTZNbtmc+Wq
 CnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161585; x=1723766385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0ESLrS1WTFOEAW/3y23+jWpZgNn4RlJc729y8exhfQ=;
 b=Se+9MQmWCbwwEnnpAc6tJNrT5fQih91MmGa1QioH5QtxqFX2Aq84tkG0V7IYIKXUI1
 tjk+LHPtw0Iv0MYf7s10eHPz95GPmsaUcuEIBeMmVTnvO9ZNg3OuhuE2WH4WIb/TdTkF
 ilWmuOAmB6/ZO52+3xkQ0y3cRQmjMDib7yhqC+64uSkgHsOR8vB0vZ+8rhCcC+5hRNHM
 JygKC87KXuuaFvqKvQen5eRb6nTCpVP+RYO+tzJ6Ja49aofV/M6cczUzE7rQFmYJDqO4
 HFrzsdy9DW3hTkvh0o7/+DQxWzPlQ1dcA40AZdqYx/wZLKJGOyO5ZiOu6RShgjruALul
 voOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX82WGag1HCIWeP1PfBDIybW1tw1Ch0WVP5mDF+FHkFgKnfMfXSKHhqVD6bIDeG1wq6LPAwi7o0F1Rg0IzHkcRojXMmbQ==
X-Gm-Message-State: AOJu0Yy+YCEA9fFwHSdweP2mjw/DRTxL/9tPoefZGSmmDVza/DZOgehS
 GpKi6NgRKUY8TIyMTJdPodCJc6i6JH5tBLATuTHu28SmirUFEpDz7VClnHj5kP0=
X-Google-Smtp-Source: AGHT+IEpJWbOtbwjdDZ9h8lzkJkrSS6T9W5mo3Ez85Bs0AzSMdVZRa8icd9NG02/feuk54k16oyn1w==
X-Received: by 2002:a17:907:ea1:b0:a75:2495:a6a3 with SMTP id
 a640c23a62f3a-a8090f03f38mr304491566b.67.1723161584803; 
 Thu, 08 Aug 2024 16:59:44 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:30 +0200
Subject: [PATCH 07/11] mach-snapdragon: set loadaddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-7-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=RYwtQiwDCsdlciqjR2RQjWC0/HwaN0JY5loErdjEXF8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvohVNQmSQ2+FsGoKL2wCaLzEg6TIab3ezQV
 AcQX4xmMlGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb6AAKCRAFgzErGV9k
 tvLKEACD569XhZCokm5e7nXIS1xZ2O8bN5SjE0+T4QcjdRGRVee9rQ70OQhs5XmFpkRW1wI/OaD
 Hp0JOH639WpNiUH/ipQRYv7HJxtXRAE+BEn1pDNQtal4uG08fP8wmmgGDSBxKNKDUm/9gDIQcE4
 i6giY8jjvEjjgQUVtAeFAToJOocK2LAv4DAJI+okoHnh8gI1HAm8uqBJgZgJry+A+floh9m34+R
 z80HNXTXPI5cz2Ot1d/WuqLSNV36NNHMgaBn2x0l+yU5KFlN1s/F4vDtqXmiOWbzGflkpW5fTMB
 CeGaWwI7zpxc9eczc1QjCswibtoQOFk4adpL7wIDxbwzK44pOyaQTxEQNyfUidRQRwturDFFdEj
 xyejaNOs7Z5h0GRoFFhD9SH4U7mxGZS9/R8c1ZSYox/s/DiLa0bjUKBoy/AziPSiP70OrUX/l/K
 8npXC+vmKKUXDmYib9cUiZiijO+91VSI7wBc3rhOaNl7XuXbOoRyudF57T4z/XRPOoHr1lITqHK
 6oA58b/oEO9sxGvCXSaggwYYjVrJTaa46tKXXftZ266zMEKRBXvqUmo7vqQ5hR3LXJYJ+l+Dnyv
 fVXJlUGP6Jy3enbxRa9zs8SeRmusDbNT+w4NPUYCLGQMTg3OLgFwtZyBlMn+JMgJlVw/cQic310
 HDfwrExyq87TMbA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This variable is used by default in some commands, set it to the same as
kernel_addr_r.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 8c0c7394698b..43bff2c5e5f8 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -423,29 +423,31 @@ void __weak qcom_late_init(void)
 int board_late_init(void)
 {
 	struct lmb lmb;
 	u32 status = 0;
-	phys_addr_t fdt_addr;
+	phys_addr_t addr;
 
 	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
 
 	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
-	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
+	addr = addr_alloc(&lmb, SZ_128M);
+	status |= env_set_hex("kernel_addr_r", addr);
+	status |= env_set_hex("loadaddr", addr);
 	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
 	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
 	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
 	if (IS_ENABLED(CONFIG_FASTBOOT))
 		status |= env_set_hex("fastboot_addr_r", addr_alloc(&lmb, FASTBOOT_BUF_SIZE));
 	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
 	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
-	fdt_addr = addr_alloc(&lmb, SZ_2M);
-	status |= env_set_hex("fdt_addr_r", fdt_addr);
+	addr = addr_alloc(&lmb, SZ_2M);
+	status |= env_set_hex("fdt_addr_r", addr);
 
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
 	/* By default copy U-Boots FDT, it will be used as a fallback */
-	memcpy((void *)fdt_addr, (void *)gd->fdt_blob, gd->fdt_size);
+	memcpy((void *)addr, (void *)gd->fdt_blob, gd->fdt_size);
 
 	configure_env();
 	qcom_late_init();
 

-- 
2.46.0

