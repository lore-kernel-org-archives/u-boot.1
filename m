Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5E5CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 11:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8C38400E;
	Tue,  7 Oct 2025 13:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NVx0lFl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878F58400F; Tue,  7 Oct 2025 13:42:16 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D036683FFE
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 13:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso4652450f8f.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759837333; x=1760442133; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pIak7GNIXLkHw/UXLwekW34kcYX7IE/C3+Wfgg2sVOg=;
 b=NVx0lFl+Oc+iIw2tGiCeO5Y4hzbHdD5IFeLfp0O0qzlkfXe3WYoHepVBLk5JNjVDL8
 sDCMBuygJXYftRYM60itb4xPxaWfm8gwm/EoJv8KcD82EPBWG9IhRnNvtotbwuPIZf+E
 WZLfGifS84GSYpeOnwXc8/xYIm/bLsQEZ9tGOZkFGS6GCAi3ciYi41ne4kqqejcdL2I6
 tTg8ONBHlHGle53qw58JFvtPZTj+gz9HdNlwZmXhLw+tclPkkZqbE0MidHFrVLd5HIm4
 +vtJw6HfBwGtWyMQvZu8f9sUYOJbJcqPlw6SXRWx2eOXR2BgT6m8vuVIuF1Nlq5gHlVQ
 Pbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759837333; x=1760442133;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pIak7GNIXLkHw/UXLwekW34kcYX7IE/C3+Wfgg2sVOg=;
 b=vy9MrOiv5TR4iDKxcl5DGMZ2S17JbkWMA6YAf7MjvLaPoM4IMb09X99IPcAh4mq0qc
 15YxMlu/Yabl2TXEZY7D9JUDlQHJRX/+BZr2ux8dvoDZTw3tSg2EHv7Zj+bh4FX2zYHb
 oT/Rf2sjt9BmJJ5uP4fRJoFNDXkClmBNDBqYu0IHDhWc2HoF7Xns7YPYeuiyGrfRYPL6
 SMzWCLuC4F7VMSug8Ico2qmMx1tGWUGGqsuSkjLDnglRohVE1cb5q+LOnHcIiq5pSFnB
 Lixu+PhUjPorf0hwo60LRDHPA3jFW7aAtacFboJdoz6YRUO3xzjz1kBNKLwjk1DIttX5
 Y10A==
X-Gm-Message-State: AOJu0Yw/BNllWFQCp3vLlO63mucladpNuZ/kFDA7XGj7umuX+Umrfs0U
 o5vCpsyOJFzDaGLUVCyyNCWtdcgtdOFbWv3gGhIAjrHlYtgsdkVq/UYj9RZUN+qmQz0=
X-Gm-Gg: ASbGnctEdsVlkO1blgkNCLgy0o0+y23svi+fOylGtQXkikr0pjgz+EfKl7UCRjdDt+J
 8rkE9hytUxjjl7jQ+xlSTgYrPwsYhgZ+yL+PEwihXPxx/wjR3PxYBHS4jsmOcL1thPaRNayDbfA
 GcdPyFHibubiYfO1PGaB40MAVWVCN5FsnBS6u8g1/xyA/sGo+zBTkGgLHGUPLl+MsLj99dlvKyW
 h3CsDGw7+eW3mPdvQdoZKVbpGOyyCJS3KcBrzJQ+Tp7FFRhFyEG/0WoQ4jsUga0Wjkv/cpvQ7wh
 AAJ0v2l9r5LaCa592vULYk4QklqZlVfXAukMb8yGxAB33cfdTuHq7XLh7LzQxT30LW1a6sbg/2S
 CzXDv5cQnt87qk17XrdWM3ev6twivlp9MEEwCTei1wIg6SM5V1OUES9y3XsBdKktVsYKqx6P6bS
 Aj
X-Google-Smtp-Source: AGHT+IFxh0ndMcAl/6H6ioMaAvrSu6/riW9xQqLE6jpnEEIrh4pE8zBeoTxG2Uxak2bZticmm7HHtA==
X-Received: by 2002:a05:6000:4029:b0:3f2:b077:94bc with SMTP id
 ffacd0b85a97d-4256713a783mr7231517f8f.4.1759837333172; 
 Tue, 07 Oct 2025 04:42:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:c90:3de5:5f6:3a69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm25122672f8f.41.2025.10.07.04.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:42:12 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 07 Oct 2025 12:42:12 +0100
Subject: [PATCH v2] ufs: ti-j721e: Correct error detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-ufs_ti-v2-1-501f575b6947@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJP85GgC/2WNzQqDMBCEX0X23JT8VFt76nsUKTGuulAS2VixS
 N690WuZ0zd8zGwQkQkj3IsNGBeKFHwGfSrAjdYPKKjLDFrqUt6UEZ8+vmYSXVfVNbZVqS8IWW5
 tRNGy9W7cdY/rvNcTY0/rsf9sMo8U58Df425Re/u3vCiRY5x00ih9NeXjTd5yOAceoEkp/QDxp
 dMNtAAAAA==
X-Change-ID: 20250813-ufs_ti-dd699eb6524e
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

In ti_j721e_ufs_probe there is a call to clk_get_rate but the code after
that attempts to detect an error from that call incorrectly uses
IS_ERR_VALUE.  Instead the test should just be for regular error codes.
The call returns an unsigned long so that needs to be cast to a signed type
first of all.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Also check for clk_get_rate returning 0 and return -EIO if so.
- Link to v1: https://lore.kernel.org/r/20250813-ufs_ti-v1-1-13c0c0312735@linaro.org
---
 drivers/ufs/ti-j721e-ufs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/ti-j721e-ufs.c b/drivers/ufs/ti-j721e-ufs.c
index c5c08610ffd0422c9cf9d8e85b0396e6102cb29a..176d9b0e5c3910915552088a0371859afee30f39 100644
--- a/drivers/ufs/ti-j721e-ufs.c
+++ b/drivers/ufs/ti-j721e-ufs.c
@@ -17,7 +17,7 @@
 static int ti_j721e_ufs_probe(struct udevice *dev)
 {
 	void __iomem *base;
-	unsigned int clock;
+	unsigned long clock;
 	struct clk clk;
 	u32 reg = 0;
 	int ret;
@@ -29,9 +29,9 @@ static int ti_j721e_ufs_probe(struct udevice *dev)
 	}
 
 	clock = clk_get_rate(&clk);
-	if (IS_ERR_VALUE(clock)) {
+	if ((long)clock <= 0) {
 		dev_err(dev, "failed to get rate\n");
-		return ret;
+		return clock ? clock : -EIO;
 	}
 
 	base = dev_remap_addr_index(dev, 0);

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-ufs_ti-dd699eb6524e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

