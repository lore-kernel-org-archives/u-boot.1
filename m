Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA3C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD4388B3A;
	Thu, 18 Jul 2024 19:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gvs5s0PA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E61788ADC; Thu, 18 Jul 2024 19:37:00 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8C088B6C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so6003275e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324210; x=1721929010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJPdkOfC2My7Wh0TCDOKIznmGdbwC5ScCSatU30Jp5w=;
 b=Gvs5s0PAGYMoNsJSSXOIdnubqyZF+Bl3FwrP0K/xgrQLyyfwh/wikB0uaTXUsCCZpt
 2oOwQlVrZJ/Yx2fO3URtDjy57nd8DJeC4bGvFK50D4IuM0ECNX6lPUVEklR9ZJbQBQga
 QDwcZ2QWTAUzBr45JSi+Wzpfm3DuA/sL7uExc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324210; x=1721929010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJPdkOfC2My7Wh0TCDOKIznmGdbwC5ScCSatU30Jp5w=;
 b=LQigm+06B2o9dXLvK+1hgVIwkFgvNvGvgAvUJNc/tV099ZWrgYwTJBtMzKBK24aFFR
 GQJaC7GWBioyp8ofKw0BVv0cArlaFXsApizwtE2wg/+Z9GEew4aQRY17G2LZ2l0tAJgN
 6uxKRqyn9AjvyLT8oG7xpYMW1JfFjkScg/sus2YXBjFhealEV+5JoN9WsLOcJ85uy8zr
 xyDMrjyq0ff4Ig2UoCKJ47Hq0l0R5iVkyebavLuGiuFhCQY0IvIv4qKzQg3Zk9L/71wF
 8snGLF92twS01Q5SHJtIYmPPURfn6P4S5pRp4CxXZme163+FXNriHW+n9YZZ9WSdCgec
 nucQ==
X-Gm-Message-State: AOJu0Yx1VxQLbpdYncwEHAIddZ1crKQxgMlCCurcyu4Y4oecpfef3vUV
 JAeezbdWTFxVtYpEHBScpaynnAsNueEArpDOoYWNz/FJLSShovvGXvRgFzq/xpNM/kM8JymsgGc
 =
X-Google-Smtp-Source: AGHT+IGTxlGfGcFDIIjOVQICrwJGmaggHbh6IbMRr4bSq5mp6tprmq3Z8OgKTJJh+j+DKmzEwqc7RQ==
X-Received: by 2002:a05:600c:511c:b0:426:6416:aa83 with SMTP id
 5b1f17b1804b1-427c2cad6b3mr52799615e9.6.1721324209989; 
 Thu, 18 Jul 2024 10:36:49 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Aaron Williams <awilliams@marvell.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH 18/20] i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
Date: Thu, 18 Jul 2024 18:36:09 +0100
Message-Id: <20240718173611.4014274-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

These functions are 11 years old and are not actually used by any board,
even though one board (cl-som-imx7) does enable CONFIG_PCA953X

Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/mips/mach-octeon/octeon_fdt.c | 15 ---------------
 include/i2c.h                      | 18 ------------------
 2 files changed, 33 deletions(-)

diff --git a/arch/mips/mach-octeon/octeon_fdt.c b/arch/mips/mach-octeon/octeon_fdt.c
index 15ce292be95..aa5d7d00c0d 100644
--- a/arch/mips/mach-octeon/octeon_fdt.c
+++ b/arch/mips/mach-octeon/octeon_fdt.c
@@ -908,21 +908,6 @@ int octeon_fdt_get_gpio_info(int fdt_node, enum octeon_gpio_type *type,
 		debug("%s: Found PCA953x compatible GPIO", __func__);
 		*type = GPIO_TYPE_PCA953X;
 	}
-#endif
-#if defined(CONFIG_PCA953X) || \
-	defined(CONFIG_PCA9555) || defined(CONFIG_PCA9554)
-	if (!i2c_addr || !i2c_bus) {
-		printf("%s: Error: i2c_addr or i2c_bus is NULL\n", __func__);
-		return -1;
-	}
-
-	*i2c_addr = fdtdec_get_int(fdt, fdt_node, "reg", -1);
-	i2c_bus_node = fdt_parent_offset(fdt, fdt_node);
-	if (i2c_bus_node < 0) {
-		printf("%s: Invalid parent\n", __func__);
-		return -1;
-	}
-	*i2c_bus = i2c_get_bus_num_fdt(i2c_bus_node);
 #endif
 	return (*type != GPIO_TYPE_UNKNOWN) ? 0 : -1;
 }
diff --git a/include/i2c.h b/include/i2c.h
index 282f3cd700f..f468b52cd7b 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -933,24 +933,6 @@ int i2c_set_bus_speed(unsigned int);
 unsigned int i2c_get_bus_speed(void);
 #endif /* CONFIG_SYS_I2C_LEGACY */
 
-/**
- * Find the I2C bus number by given a FDT I2C node.
- *
- * @param blob  Device tree blbo
- * @param node  FDT I2C node to find
- * Return: the number of I2C bus (zero based), or -1 on error
- */
-int i2c_get_bus_num_fdt(int node);
-
-/**
- * Reset the I2C bus represented by the given a FDT I2C node.
- *
- * @param blob  Device tree blbo
- * @param node  FDT I2C node to find
- * Return: 0 if port was reset, -1 if not found
- */
-int i2c_reset_port_fdt(const void *blob, int node);
-
 #endif /* !CONFIG_DM_I2C */
 
 #endif	/* _I2C_H_ */
-- 
2.34.1

