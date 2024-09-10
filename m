Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23867ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F6188F86;
	Tue, 10 Sep 2024 11:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lhMvgX2M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0C088F75; Tue, 10 Sep 2024 11:20:39 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F3D88F71
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-374ca65cafdso3313872f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960034; x=1726564834; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3m7Q+AqHnJtFLnPxeYXXhUgB8nIPlDQz0O1xPV0ygqg=;
 b=lhMvgX2MA+VdedGWL0PkL76KMD4yf/RIdISNGoE8LpDrGkj8KfMtgoF0mcxHS+AUPR
 puMe7PEbJ4MYQh7V66swUHcrE5sX4dsHV8rvUqaiRQJdyxsZXQRzu1jpKckwoJsTO//p
 o1hBZBNn/gCYU2E2Did8rho28a7H6UArI5wNsjOUe+6QgfSkY8uhleH67Hg9PxhwUzfj
 mcfbI+uToUnLAfjKpy7oB5xOP5P9bXneAjYLpYrMP2/LCCejqcLZw5nMQxxYvgjUH9KA
 rVX5NgSmUkTJ5FG8S0sTaSWQvCSh5R3hNvxI57VsyQncnWRAVhrcRTzw8/JN3jwsvwyx
 jsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960034; x=1726564834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3m7Q+AqHnJtFLnPxeYXXhUgB8nIPlDQz0O1xPV0ygqg=;
 b=KGavvQSMRqCtE4sJdi7OrEbjks3AnSu+sMz8WxaxnPPH1UmAW9RreV+w9Gc7B8FnsR
 bfEz3CV+2DwWEtMyiXu23MUHjIklsHRPEllOYuYeRDrwF+qKPcDhjAD55SQY7K7DUm08
 9gGs1Sy3jH7Q3R2b3rWtTbdYdpY9ONqpYXIVc7i45jRKae68MPXAnsxPQTRIa5QVK5G5
 whhK4OdPztGWPDMHGhrWKMvrENz9NvAyjYAYj/c1/k2VOM4K9gD38mJG7XUW4sfgfzU+
 C1vhNnmAxpSM0ZynxquwtCuNs7H9cP2O+0O5Kk7XBZ8IYn2JeBkWHv5D1lURXJR0APGe
 JtQA==
X-Gm-Message-State: AOJu0YzJFugS4C1SEChLs3Lp2KRuMX09vNj/ggRyRceQR3h2F/b+27V/
 1z/9b3uN/ExYOAN69cWJGpoJJ/j6hgAcIZb+9mLLyDupvTvjq6ILaXM62J/AXCg=
X-Google-Smtp-Source: AGHT+IEekeKiFW5aPHkwkoEwWNLZYIjUksIhjKx1C579YBpQDCfvcBl+59UMdelSPFx9OnSd+BHe5g==
X-Received: by 2002:a5d:58e7:0:b0:378:81aa:2662 with SMTP id
 ffacd0b85a97d-378949ef189mr6367476f8f.7.1725960033725; 
 Tue, 10 Sep 2024 02:20:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:33 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:20:24 +0200
Subject: [PATCH 07/13] ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-7-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=n6sWzFGKN/U+YwB57DGrAsU0A4QspTvAYyw+DnuGD8k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9Yg80Meq/DkdL3QnMmX4btuNj2Xeb0Ic+Nm+93
 cDyzfEmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWAAKCRB33NvayMhJ0fvwEA
 DQ7dD+27vRZoV+7Z2U/Llw9NPJf085YQu006d6L4/WcO8Xq5oqfcBSx+cnm+n+8Yxl+p0Xz4AoGn3C
 2F/IdVQbEZFjNiGWouMyKANj2HtvRopV8avK3UPeCTSBIsiJbrHOS9LlzzMpyuCFGhwLaiTYllEwJ7
 qp8YN9s9HU2QmH7wXHBMKnFJMY9brXHzlRNMT5bZrgcy3dMvvWI+xliGipQ1z9Xsd7Xlo/kSC/UiuK
 f+q++ZJM4/X4IdREjWKx7SSUCSFihvoNmqxmncin95965p8wYKDggOnhLJdHKiM2EhXJA8ZNJaYLwp
 HHVOWwar55YGNTro34qrZEiv6Ng27MWe7Xa/3Znt0fELFTE0AsB5zf9WVc8Wg5IQr+f3AYoJQrhSlU
 sm20IMjvsdJirUHkMiQOnyPqEIfQroeNGqIbqIa1NbN2Z4YpZVGNnRx9uF9535ZN2X2OCVkXeH4Nag
 3jNgQVBtoNgppxjSF9mU5yq36HHX/t9HqmEaqcHHV8+NPuzR6KkFuxVWsb2WAGMfFKyGB7BKpzjzpR
 QuA6GdqYO5uu7qReN2yF1DyK6ToIWTE5/CjwKDury9KGBlgGg1i+LTvilg5/KPcox/3zNrBNBHTHr8
 UV2TnI01A50bv4nmNgKCqCliz+XLHWZ0Nfit7PW8YZkwyfLOLeDU3k2tE6OA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Add definition of 'ufshcd_rmwl()' helper function
which would be later used by Qualcomm UFS driver
to read-modify-write registers.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index b55c4a9e996..555f8a6857d 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -3,6 +3,7 @@
 #define __UFS_H
 
 #include <linux/types.h>
+#include <asm/io.h>
 #include "unipro.h"
 
 struct udevice;
@@ -933,6 +934,23 @@ enum {
 #define ufshcd_readl(hba, reg) \
 	readl((hba)->mmio_base + (reg))
 
+/**
+ * ufshcd_rmwl - perform read/modify/write for a controller register
+ * @hba: per adapter instance
+ * @mask: mask to apply on read value
+ * @val: actual value to write
+ * @reg: register address
+ */
+static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
+{
+	u32 tmp;
+
+	tmp = ufshcd_readl(hba, reg);
+	tmp &= ~mask;
+	tmp |= (val & mask);
+	ufshcd_writel(hba, tmp, reg);
+}
+
 /* UTRLRSR - UTP Transfer Request Run-Stop Register 60h */
 #define UTP_TRANSFER_REQ_LIST_RUN_STOP_BIT	0x1
 

-- 
2.34.1

