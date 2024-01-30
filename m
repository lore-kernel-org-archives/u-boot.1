Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913F1C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858EE87DE3;
	Tue, 30 Jan 2024 15:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IZ5VLF/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5C987DEF; Tue, 30 Jan 2024 15:05:13 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A0287DC1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40fafae5532so2998365e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623509; x=1707228309; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BlwLKns/59/R3MiixPKZiqZJiJvLjgygGD+wM3O6NRU=;
 b=IZ5VLF/yMSjg+zf1n4LY0sH1m6Elz7Fr8YCcwRrzw5Du8eFjl6t2CeC6x3ZVrygQ5z
 0i6DhXtnQD1rQpO4gnfLGnMbiIXcz73VkAf+UMtvZAQqrsj4EktOdt2latMMUEOGmK6+
 b9oGNAIL2g+dpHsAouxf7E9Lx3EEduRjKQ43KHCN+vmldnfyB/Ei7n4ihwJLTCbEu0ur
 z52q+SV3ZHuoQoXLbLULuuEdYcthFrjUTkcy/ccC7n7WccKz2hHlzx3J2/3bwLu5p54f
 BBtdK0MHSofuNQeJs2YiD/oCr3/Nxs03RPyJrhUx+DSw9BlYMan/Qks9lTqTWVEEepf7
 jzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623509; x=1707228309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlwLKns/59/R3MiixPKZiqZJiJvLjgygGD+wM3O6NRU=;
 b=L9vLiZwyu9R7MUQUVwFN1dn8WNPVnRipJlgPv1SrH6n0oBHaxbD4j5FHoQmsvq/9pW
 dIZOuI715+aBPmbaPc0mBhKLkUfE/D0T5StF0qQ6SzoloyK6SiU5ntZPnOqCeCINl3X6
 tiXuVpM62N/wLRZHZib9B7S2DGnQ9s08X0nW3l6F7KqsG+KdmFVCdWE1XlPtDd/zp//i
 d2MD0uFrPF+VUHQ7JTYYqpFyx7feC1WSZLwDhMDbhS0T/NiCgBZL7zHbppSdPOR5OMh9
 AeiKYjYdnHMjo28kn7+m1DSIXQj0Nog1aWjhpGGR/8tI1kh8fakiP702SELwFWL8nHU+
 j16A==
X-Gm-Message-State: AOJu0Ywrr//g57yX5MNo9iuQR0lesdEiOGwHkWAey971S44jaFXaXJa5
 hPPc+4VzMaqCVvOMXK68eDIBWJSgZCF0a7oBk4e5+6IRSTxFM+IsR4nePXx7u6Q=
X-Google-Smtp-Source: AGHT+IFjhHugRxhRKKvJvLfNhuCLkmCk5quEUGtbTKdRG7OpmU5kBvKa3a7inrPVz2s9dxIuDaqC7Q==
X-Received: by 2002:a05:600c:5123:b0:40e:5933:e2c2 with SMTP id
 o35-20020a05600c512300b0040e5933e2c2mr9494604wms.19.1706623509693; 
 Tue, 30 Jan 2024 06:05:09 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:09 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:49 +0000
Subject: [PATCH v3 01/36] arm: init: export prev_bl_fdt_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-1-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=eNhNBu7hxBtGKiHmy0H7+R0rAFesn+W4Qw9aXxb/3IE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTPyNpmKJU+9dKFXU/Fsy+QRrJic7418t95MiKlvNv
 ptGn6rsKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNZs4zhn2nLJWmpZ3eeT79W
 +fWB6DaVdmmmJvFb7/Z9FfQwWcU9fQHDP7v/5ub1XjO8q/wm3k2UYXU6uHea0xbRjasebVmyJCg
 g9BkA
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

When booting U-Boot on board with a locked down first-stage bootloader,
we emulate the Linux boot header. By passing the U-Boot FDT through this
first-stage bootloader and retrieving it afterwards we can pre-populate
the memory nodes and other info like the KASLR address.

Add a function to export the FDT addr so that boards can use it over the
built-in FDT.

Don't check is_addr_accessible() here because we might not yet have a
valid mem_map if it's going to be populated from the FDT, let the board
do their own validation instead.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch has no dependencies

Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/save_prev_bl_data.c |  5 +++++
 include/init.h                   | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index f7b23faf0d66..b286bac9bf00 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -45,6 +45,11 @@ bool is_addr_accessible(phys_addr_t addr)
 	return false;
 }
 
+phys_addr_t get_prev_bl_fdt_addr(void)
+{
+	return reg0;
+}
+
 int save_prev_bl_data(void)
 {
 	struct fdt_header *fdt_blob;
diff --git a/include/init.h b/include/init.h
index 9a1951d10a01..630d86729c4e 100644
--- a/include/init.h
+++ b/include/init.h
@@ -168,6 +168,17 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
  * Return: 0 if ok; -ENODATA on error
  */
 int save_prev_bl_data(void);
+
+/**
+ * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
+ * of the FDT passed by the previous bootloader.
+ *
+ * Return: the address of the FDT passed by the previous bootloader
+ * or 0 if not found.
+ */
+phys_addr_t get_prev_bl_fdt_addr(void);
+#else
+#define get_prev_bl_fdt_addr() 0LLU
 #endif
 
 /**

-- 
2.43.0

