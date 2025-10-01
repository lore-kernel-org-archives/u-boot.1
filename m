Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800A1CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 842BE835B0;
	Wed,  1 Oct 2025 22:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="utSSTC+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D853383677; Wed,  1 Oct 2025 22:30:47 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07F1835D8
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce892b7dso202872fac.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350644; x=1759955444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IzbxEVTQ3DNX7qT4UQBAGN4f4eO2FTw1BVNUYnPmu24=;
 b=utSSTC+ApLqrkzh2fYhxuSZMVJmnf5HIcujGU3IZrZystDgRPSE1nrCl2NxA72VCXG
 ky05crShBzO3CtKEq8sr9Ee3TMsru0l8CksaTKDZ46QLjbzzgaW8nFePx4xgNdSZIzDz
 WjwTaF3NrofxeLZzQ0A+drUN5NosFmfFNeKnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350644; x=1759955444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IzbxEVTQ3DNX7qT4UQBAGN4f4eO2FTw1BVNUYnPmu24=;
 b=lnzKN91kttYydXpdeJvAXIAfQwGonYV8YRFtzUWy4+1Rj/LF94ZUe2rRlakihyV4ET
 azWIh3Fuh7BLyCzHWJeFi403KyZkvG8zwlM1ZNnAIMKXuYq8k+Snu6lnF777vYf+FYu/
 kPJpVmQBHi7LQYLxg22ZJH98BUf0w/D4ZjUG1NU59Z6oM0cNT6n+vwF9fIL4AaqMsTjx
 KKyCyI7R+r+sfn4tB3VBVLLfjPXAHXYcDGPVMCO7ra3Ym1v8YOFLPRp9MNsPx60Dahzh
 XodT2tZwjZKnjk8GAOyuF5wpQk68QclnQrPsdo96YvkmQ4B6k2owi8vuD6pLD9litOtX
 WOjw==
X-Gm-Message-State: AOJu0Yxh7MmPnV56hkDJqOw6eJWlgjjuWa9o5W2Q6//ETD2K3TK7Zs/C
 CwAOd3BHwBiOvVAWTC9xqt7EtATA9uV1dr3I8JUJfwblpzJ+mcuJtqdvR4OsjiMVS4kUwHxSelk
 eREDFl6E=
X-Gm-Gg: ASbGncvZT8kxVYADIIGavhxV29Fo0doEgrTnKjVcGz8ShjcknlRgAcPodPPgQgvzld+
 jRnzNA1pSnPGCKnGMdCUed6643Ne4YXyMW0LXPePGxqrNb4m0LeUYVh77nZ7yEP63SA9cK+fyFv
 UPyhybunxPPdz+t8g9J/Ooyw/QhMmYQrOGn7bwFxnZksLQNcGcuPftqp75PWL8lq+FQ0wqe5fU/
 DCJB+wsrkbZmDvEIOyVadVFEYr1bD6Lhs6hKLXWxn4dCHK/ruEmsEpFsbPLrlQwH/uBjoFK/QXm
 yECyPBGHVdRArurh11TAFeHFfkZsEK8D9+8xbrveWvADN9bCVYkYlSUQo+ou8QFD1NSeseUKJUT
 DLTbaDvIL/v+qktEi6QuG0DGqFMCvno9qbYKVP9n6Kkf9C+cT3S+3cnP+c7KM98aT3oRgjfeDZi
 L6m1Us7x0=
X-Google-Smtp-Source: AGHT+IEJsZ9tk/yTdQfZnSjz9RdspzVbMsMKbcsUwtPZIfbmekx4G5IMUjN2ZR5IEJ+MycdzCfHRHQ==
X-Received: by 2002:a05:6871:1cc:b0:31d:7326:c3a7 with SMTP id
 586e51a60fabf-39bb29e1888mr3031754fac.41.1759350644530; 
 Wed, 01 Oct 2025 13:30:44 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab962cbd4asm217090fac.30.2025.10.01.13.30.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] net: dwc_eth_ops: Correct check for FDT_64BIT
Date: Wed,  1 Oct 2025 14:30:43 -0600
Message-ID: <20251001203043.2828376-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

There is no xPL_FDT_64BIT symbol and it would furthermore not likely
make sense for there to be one. Correct this check to use
CONFIG_IS_ENABLED and not IS_ENABLED.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/dwc_eth_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 551ee0ea6a02..a098916a674b 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1411,7 +1411,7 @@ static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr
 	struct eqos_priv *eqos = dev_get_priv(dev);
 
 	if (addr == FDT_ADDR_T_NONE) {
-#if CONFIG_IS_ENABLED(FDT_64BIT)
+#if IS_ENABLED(CONFIG_FDT_64BIT)
 		dev_err(dev, "addr=0x%llx is invalid.\n", addr);
 #else
 		dev_err(dev, "addr=0x%x is invalid.\n", addr);
-- 
2.43.0

