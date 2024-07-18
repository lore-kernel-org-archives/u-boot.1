Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1831C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCE188B59;
	Thu, 18 Jul 2024 19:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="meALOkOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0CC88B34; Thu, 18 Jul 2024 19:36:56 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FF588B35
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eea8ea8c06so16135641fa.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324207; x=1721929007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZ7tnch+wxD3yWZ0D3mB/5hvkukjhZ586xHwPBhVjTM=;
 b=meALOkOEO+ytMneHTJbFTd/TrmgTjSCoocqrqY/JLkyv8cqYIaIZYkFz9aizc2ZJfn
 PgeH02J7k5CTMPnYFjdaycB8QuDj6gGbDyzh9pczSIiWBUYGQj88A6ljhKJC9FPAIy7n
 TyZgKhq4flTUeZSetDzxLPB4pp9PPD/coG1tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324207; x=1721929007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZ7tnch+wxD3yWZ0D3mB/5hvkukjhZ586xHwPBhVjTM=;
 b=BEzEt1+WxzZPqz4cQViDUAYuuuUt5rZ9JiqlPQyMDQVQDjyoudxvUYZjD2ykF3HnCi
 Hf9tfcqca1VU13tTZhQwTyJGIzKYPZhRjj8BKkh7sZCsxCN9duVDhPe2C7X6uKtESYY+
 NFQ2hSRN5GvaQHHjAamlxVw37Qzl3WqGD4EN9DQisqmFoyvPDj2QZi/LVIN8Vm3pFug3
 g8QcpYlKqkiqbDkIfaJzR+SV9DkhO/TEVHYnhsVdVhxgav97crlQCRWrGnPgRvhgc5gF
 iUQtgQRK6vqeoVKxr1LoR0B1NZ69KlKzpLO+Mx1PIiGdwokr+2cHpNeWlvlnrEeBIRdl
 tNfA==
X-Gm-Message-State: AOJu0Yx1UX9CZ5xFQddPtZMW/5UJr9Gh9I29suGaoYvgfeDoFwbHBWpn
 x2rRM2P9BK6NPyPIH6Cau+mifywAwO/bk7FkoRQ0Ad/0iMlrOFNImR5uM+R7CDSgysg9kYrercM
 =
X-Google-Smtp-Source: AGHT+IFSlR7CVC+j5lBhKkLlK5nCGolThOpNisJkigZ0wZACOnHWGXZyoAVUG2uA6tEoFCxpMWcBkg==
X-Received: by 2002:a2e:be24:0:b0:2ee:7bed:2cf4 with SMTP id
 38308e7fff4ca-2ef05c91135mr26613731fa.23.1721324207172; 
 Thu, 18 Jul 2024 10:36:47 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH 15/20] i2c: Remove I2C_SET_BUS()
Date: Thu, 18 Jul 2024 18:36:06 +0100
Message-Id: <20240718173611.4014274-16-sjg@chromium.org>
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

This is very old, predating even the legacy I2C support, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/power/power_i2c.c | 5 -----
 include/i2c.h             | 7 -------
 2 files changed, 12 deletions(-)

diff --git a/drivers/power/power_i2c.c b/drivers/power/power_i2c.c
index a871fc41987..c2fc1c6b42f 100644
--- a/drivers/power/power_i2c.c
+++ b/drivers/power/power_i2c.c
@@ -33,8 +33,6 @@ int pmic_reg_write(struct pmic *p, u32 reg, u32 val)
 		       p->bus);
 		return -ENXIO;
 	}
-#else /* Non DM I2C support - will be removed */
-	I2C_SET_BUS(p->bus);
 #endif
 
 	switch (pmic_i2c_tx_num) {
@@ -93,9 +91,6 @@ int pmic_reg_read(struct pmic *p, u32 reg, u32 *val)
 		return -ENXIO;
 	}
 	ret = dm_i2c_read(dev, reg, buf, pmic_i2c_tx_num);
-#else /* Non DM I2C support - will be removed */
-	I2C_SET_BUS(p->bus);
-	ret = i2c_read(pmic_i2c_addr, reg, 1, buf, pmic_i2c_tx_num);
 #endif
 	if (ret)
 		return ret;
diff --git a/include/i2c.h b/include/i2c.h
index 45ca3d63e3f..1d1430b74a6 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -954,13 +954,6 @@ static inline unsigned int I2C_GET_BUS(void)
 	return I2C_MULTI_BUS ? i2c_get_bus_num() : 0;
 }
 
-static inline void I2C_SET_BUS(unsigned int bus) __attribute__((always_inline));
-static inline void I2C_SET_BUS(unsigned int bus)
-{
-	if (I2C_MULTI_BUS)
-		i2c_set_bus_num(bus);
-}
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

