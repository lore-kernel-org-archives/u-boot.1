Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0886BC71130
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 16:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA088319C;
	Mon,  7 Jul 2025 18:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qcD1ukP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759A28319F; Mon,  7 Jul 2025 18:26:57 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383198318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 18:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4537fdec39fso9744095e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751905614; x=1752510414; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tfZxB8kSIsWbiAe8oGrnHvSUWJzK6X542ZDDiFYMJuc=;
 b=qcD1ukP7Ms3gDa/6Me7K9yWuU05KpLC3ZZnYhJK9QTOKKLhQt5L3DzaUzh1m0jxiFh
 pnL+nftaAesUcLkh8jdD6nBCztPK4rKQEakxtgHvfLs9HppAEdDjBGhkPC+mtosMWr1E
 Y4VgfvOt+kz+I59ba0kDBpr0yLLPC5j00XLlIT3UpsVhFLapkDiK1z/pGN7zwRohTxkw
 MpkRXUI6koHLgtwz8ugf7hQM955ip5vSAhEzb7hwDTFXEDrnVqlGGQSbKlRE1Fsg4n74
 u/OeB5xw60GEOrLpGdLqVvDn8rX9P0LTWVy0r9oj2Ky9u2uwqMq4zMYbDdecF/h8pe2I
 J7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751905614; x=1752510414;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfZxB8kSIsWbiAe8oGrnHvSUWJzK6X542ZDDiFYMJuc=;
 b=NK/4IDGnCkG6bvHiJE3T2LxBmjD61pu1QRe84ycfT2GBlOI0VbRZFyY7b4DE2jZR/8
 1Z714K5LRLkC1p4NteUZdFS1REIGsZqapcehwkjKmoZB0t3GBSdEhqlRrfUqboEZzCBv
 2TbpH0X1Gt7NVVB3cADpjWDGO93y3x/qHljiWHXw2isPA4Or2fIQvhKlnyT88+VSv1xN
 zNMhymO0tZEAflLFBrAI3DE/YXHSZyZX2iia/llL/nvhz/NvPPBdMvBZ0ZBXcnF9z9Of
 xLZzHFVZaczIVR/guZ5fKprDME246wzS4loHiETYmXExqq1ky3VFlsdqf8JmfYz5DcL/
 8Hww==
X-Gm-Message-State: AOJu0YyBSumnrMCnY1KHc7BVRb7zcm7GFEqPYRKPsV3cipHjjedbS9eK
 RSmm5Fdo24HVUDv25lJop9guznT51gmfWil01CQ3wdgB8nQspbFN+wYdPnx+RCqMbr7iYaiCDTl
 JVtgn
X-Gm-Gg: ASbGncticpdll6+AruY8rVwcJfwetW8Q4WQ/v8jvK054FF7MVI6xlpB8AZDtQ6M9Dez
 vEpgSNNLlhqTCkeA/0do7vqZRFe3akUkxsUeO+TOdVXmywtweO7VaxP2hBP+xXYVBptBvjPlw5q
 8y9YnU9+SXOLGWBHG9g3G5riXcOASFiNGDmqrP2Es+8xy5Wtod9FxazFOqMBAhu/+ZkrMmRxwbT
 tgrTF7wEeHQwLmK4lGMiRKQTkz54hYURb+/tqt46PxjnLOwQz9U9ev6YMHPa8BKxW/yO0QY71D4
 oSzVksapA2GlWtcEIXKt3VMN4RMc+1ehh5duaUBSKRP3QIK+qXHMIeUr9oNndCIbdR+2w9tULXN
 0Q6nKwPu6OPJWsQ==
X-Google-Smtp-Source: AGHT+IEonF3ZLjDR6LOATPxijdMWNxubJDKQdjU6Yd9Au+o0uEn7gRqlrvxBKcsE4PxWN2OFSqjiZA==
X-Received: by 2002:a05:600c:19c9:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-454b305fcb1mr131554425e9.0.1751905614478; 
 Mon, 07 Jul 2025 09:26:54 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bdf21csm148548115e9.29.2025.07.07.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 09:26:54 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 07 Jul 2025 17:26:53 +0100
Subject: [PATCH] pci: Assign a default value on reads on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-pci_fix-v1-1-42ae0de98a0c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEz1a2gC/x3N0QqDMAyF4VeRXFtoherYq8iQNMY1F6uSDBmI7
 77q5c/54BxgrMIGz+YA5V1M1lIjtA1QxvJmJ3Nt6HwX/eAHt5FMi/xcfFAgjH1PaYaqExq7pFg
 oX/6D9mW9hk25+vtifJ3nHzwIp75yAAAA
To: Tom Rini <trini@konsulko.com>
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

Many callers of PCI read functions do not check the return value for
error before using the variable that should contain the value read were
there not to be an error. However in the error case this variable is
never assigned to and so will contain uninitialised data.
To provide some certainty as to behaviour in the error case assign a
default value of all bits set.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pci/pci-uclass.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 59894d2430b..c370f8c6400 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -385,8 +385,10 @@ static int pci_read_config(pci_dev_t bdf, int offset, unsigned long *valuep,
 	int ret;
 
 	ret = pci_get_bus(PCI_BUS(bdf), &bus);
-	if (ret)
+	if (ret) {
+		*valuep = 0xffffffff;
 		return ret;
+	}
 
 	return pci_bus_read_config(bus, bdf, offset, valuep, size);
 }
@@ -408,8 +410,10 @@ int pci_read_config32(pci_dev_t bdf, int offset, u32 *valuep)
 	int ret;
 
 	ret = pci_read_config(bdf, offset, &value, PCI_SIZE_32);
-	if (ret)
+	if (ret) {
+		*valuep = 0xffffffff;
 		return ret;
+	}
 	*valuep = value;
 
 	return 0;
@@ -421,8 +425,10 @@ int pci_read_config16(pci_dev_t bdf, int offset, u16 *valuep)
 	int ret;
 
 	ret = pci_read_config(bdf, offset, &value, PCI_SIZE_16);
-	if (ret)
+	if (ret) {
+		*valuep = 0xffff;
 		return ret;
+	}
 	*valuep = value;
 
 	return 0;
@@ -434,8 +440,10 @@ int pci_read_config8(pci_dev_t bdf, int offset, u8 *valuep)
 	int ret;
 
 	ret = pci_read_config(bdf, offset, &value, PCI_SIZE_8);
-	if (ret)
+	if (ret) {
+		*valuep = 0xff;
 		return ret;
+	}
 	*valuep = value;
 
 	return 0;
@@ -447,8 +455,10 @@ int dm_pci_read_config8(const struct udevice *dev, int offset, u8 *valuep)
 	int ret;
 
 	ret = dm_pci_read_config(dev, offset, &value, PCI_SIZE_8);
-	if (ret)
+	if (ret) {
+		*valuep = 0xff;
 		return ret;
+	}
 	*valuep = value;
 
 	return 0;
@@ -460,8 +470,10 @@ int dm_pci_read_config16(const struct udevice *dev, int offset, u16 *valuep)
 	int ret;
 
 	ret = dm_pci_read_config(dev, offset, &value, PCI_SIZE_16);
-	if (ret)
+	if (ret) {
+		*valuep = 0xffff;
 		return ret;
+	}
 	*valuep = value;
 
 	return 0;
@@ -473,8 +485,10 @@ int dm_pci_read_config32(const struct udevice *dev, int offset, u32 *valuep)
 	int ret;
 
 	ret = dm_pci_read_config(dev, offset, &value, PCI_SIZE_32);
-	if (ret)
+	if (ret) {
+		*valuep = 0xffffffff;
 		return ret;
+	}
 	*valuep = value;
 
 	return 0;

---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250707-pci_fix-58c1ca566cbd

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

