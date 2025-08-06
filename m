Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9ABC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 16:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC86842C7;
	Wed,  6 Aug 2025 18:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tSU08Qcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC28842C7; Wed,  6 Aug 2025 18:43:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF2D84370
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 18:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-458ba079338so1002215e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754498608; x=1755103408; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k3P61qDEuwnqRZZrLjZ9m7z2BgW5uq3c4fG1F0Uce1c=;
 b=tSU08Qcma/dHdQxuBz/C3fs1YDRXkNxnzUQM3cRdXeNmO6MBbSmDneXdo/Auw+163A
 0lOqujasgeCA1In15zAjDzmJNB7EBdxjOlOxF4ZbkLiX1qsRVi1+f3+XREhIt2MURbKG
 XiLfgTgjvCZN8B9/jfmf19h8KLF6wwAJGXTx4vvqJR0fVJ6SUblL+fnjInVwRIGQX4h+
 Jxfx7v7PdENQLolPDO68ka1rvcJ2vCu1VVdavjHOQxKFLbZ+XZr6I9PzwVKXS1t7iq1p
 Lx+ZZng6k6nKmZMEQ3XvAcqgI0qLqxc79KJNnd3x1a7RBq40D5URPstTkXcRGt15TPHY
 G6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754498608; x=1755103408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3P61qDEuwnqRZZrLjZ9m7z2BgW5uq3c4fG1F0Uce1c=;
 b=ZZLnlYtOKn03b4AFV0fnxYIFPMN6nqtojTAhOV4UhNb1RU/9V2EArUBI4QVMmVrT1h
 xCFD5KfFAmrO+g3jxj4af0wkpJxoEbiwuD0RSBpP+zGUZN3MOihsYe9opkvUefTnVbzb
 VJoXUrBfxw/k6L9xAFeWSvEH8dxHS+MAj3IExGp19CcQcZYq0yyMFVJOX7E3CehYslp0
 RwTniA4VIc9K5ydc3G+J2kWA1bW+qk9JgK/CSlZeKs0aHz/8farVMnAiBrq+rDUCd5k5
 BBiKPyqogbNYfV7Yvo3DftQwvkxQ/GuTp0IsD+USLLUJLadchd7ppoZ2FcP7do1ugd8V
 XsRA==
X-Gm-Message-State: AOJu0YyYw9sGcwFTlUjDDf9QEnMBb+0Px/y7SJJkVs55bKoOIPxuWomw
 CwZOSUrHoM43hAhZmBlRBrjsp884O8v6qvyHsO6TFSjcRL9dl7VnFwLus/16D2onrUUz2ZOZtu+
 Hmkcv
X-Gm-Gg: ASbGnctdQ7sZjXXtq814+KhNBV+9N1RjlzLjS1DPriDyvVDjHGxMF9odbQajfUwd00M
 RWBrsd6zO463mbix5pQdk8Vq9NB0ZD754bv2EnO5f3RKXkXBYTgo7E9vAlVdNyWYiuXcEpl6gIL
 imAm1vqShg0aNUJSzHuSFmhFzhf9mw6VmuBzaknWnTxZmgV68BFoq+hHfJA+igUJXcXdg/MUsN9
 7YXvN5v3Wf3nZY6n2byaCoGvDNKfeObNMEtqnQagq84Unoz2aEW3DI12PgDUG7tgY2Abvwrnc00
 khp/1SaKG89tzQ+FZ7Em60HC7RFvX7LYTl9Wn7ivrvnlIr+Tcz5hwjSo4uSbygIYWxxWJf+rcmx
 3SV5cXOS+xdyF85wDmXK+MbDh3msr4sZbyYRufQ5HygbLl2YjhTE=
X-Google-Smtp-Source: AGHT+IHCLjOxwsf0dY34DXiWSxKU9cjHC2uhgqP89UOYe1RsTRYTCRz3pg+iFR+xX3EksFIntcUSsQ==
X-Received: by 2002:a05:600c:358b:b0:459:dd1d:2ee0 with SMTP id
 5b1f17b1804b1-459ede03686mr2685875e9.0.1754498608257; 
 Wed, 06 Aug 2025 09:43:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5868fd7sm61287685e9.18.2025.08.06.09.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:43:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 17:43:25 +0100
Subject: [PATCH 2/2] phy: marvell: Cannot test unsigned field to be
 negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy_marvell_comphy-v1-2-ad9f4e789d5b@linaro.org>
References: <20250806-phy_marvell_comphy-v1-0-ad9f4e789d5b@linaro.org>
In-Reply-To: <20250806-phy_marvell_comphy-v1-0-ad9f4e789d5b@linaro.org>
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In comphy_cp110_init_serdes_map in comphy_cp110.c there are two fields
in cfg, comphy_lanes_count and comphy_mux_bitcount, which are fetched
from the FDT blob with fdtdec_get_int which returns an int. These two
fields are then tested for being negative. However the fields are
declared as unsigned so those tests must always fail. Change the
declaration of those fields to be int instead of u32 and the code will
work as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/marvell/comphy_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/comphy_core.h b/drivers/phy/marvell/comphy_core.h
index f3d04939387..086a4d82f26 100644
--- a/drivers/phy/marvell/comphy_core.h
+++ b/drivers/phy/marvell/comphy_core.h
@@ -47,8 +47,8 @@ struct chip_serdes_phy_config {
 	int (*rx_training)(struct chip_serdes_phy_config *, u32);
 	void __iomem *comphy_base_addr;
 	void __iomem *hpipe3_base_addr;
-	u32 comphy_lanes_count;
-	u32 comphy_mux_bitcount;
+	int comphy_lanes_count;
+	int comphy_mux_bitcount;
 	const fdt32_t *comphy_mux_lane_order;
 	u32 cp_index;
 	struct comphy_map comphy_map_data[MAX_LANE_OPTIONS];

-- 
2.39.5

