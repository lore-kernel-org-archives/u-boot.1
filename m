Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EDA107637F
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908D184142;
	Wed,  1 Apr 2026 16:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZaxOtRYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1CE83F7D; Wed,  1 Apr 2026 16:34:20 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CA9840F1
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so1850116f8f.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054057; x=1775658857; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
 b=ZaxOtRYGi6fWTe+e9HiINuo7iKWCFvsSpSneuaPxZsy7PZzn+M1FkDjocEHv/C6aII
 FP4ho4I5wY5AV7PM5pna580k07z/sw+PO2Nscdib0bW03URyoVkqk6Km+X6IucW3Zjm8
 eQymO7ZdSM+zz8wMcvwbr3YcyyrCifGsw8rIx5eJib2vybd//WeXlRoqiZ7/V2FZcVhf
 LB7+VxNENIBUdrcH69KL63wlenjHr8qHscYnofNm+3TH7Am9bYT/shPpS79whz9NlAIX
 6Jikx7pVxRaqJ0Jvkg548CD63bOfFHVfmi14OvWklNRcXQwVsmfyA1ebNrzvgtk1cnTD
 tL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054057; x=1775658857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
 b=a7ub2hvtWKxUsxnhMtFLo/JvjXH+44kA4qXoRrPGyJvr3mXGaIJ39vL5sZu7ALUzxJ
 VNcNBYdbEpDFL2A5MCqevCWGTGwZ8E3E2UZDXAcJTDGjVeYsGk1k34GtMO8CDrqFTZsC
 q5+BmWM14tJlubvEPTvqOZ9anYI+rhsBGDoyq40Zqc6P4/LLqoSl0IvgJH2NpSUmsos7
 ORsZjlGt5kjV7tXUk3/PL4/7xctolMZMKznBoUAQc9Sh6vgyc/v05gINB5IpnLuCQRwk
 B6NSNmoCHiVNGCVHsH5UPoVspYBdTs48+98NE+7ewBxeQPvKpwDRnmkMJN9B0iFk1AI8
 ivlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrykNnonZ6EZ+TQy1kOfc8m8YWcMgFwHxyCk3TE+RsttITyO1BCsunI31jNKJAZQILBa8t7hg=@lists.denx.de
X-Gm-Message-State: AOJu0YzzGIoQzSxPeuz6utek8rp0nAvYKgdFnDt53nX6x4UJLornpVlP
 inr6dv4XupXJQ0Smmcjy2O6xxgUVkwrQOEzVbPpB8OvTgH72wWpj4NxV3POjucMijFw=
X-Gm-Gg: ATEYQzzxG01KXP7I4StxN29q5V93nSGvsLGbFHg2Ma8822xTr/HEEMzgx1Hdn9sj1v8
 unmIQcvKVkkpWSrjKl1QaF62q1WCX8Wej+oLIKQnp25eQOrj8j71MIxGoAZlT81iFOCsIbsIGzh
 CIDQh4ik7/kXHCHT5QWz5xeSTRWWG28QrEQAmhU8Cpbmfrfh9tOPQyCEIUFN7+K2UyQdWr2tjyZ
 VICj13WsLljHLdRFfmofp9ixYfpA4Qjy+1Uv42o/ldk/FXNlNO5PgyCd6pHASjGrQOD5O0sMWH1
 kaWy8TbZjyTrmQejFjLdv8U+domQmgf31dxFabzTrsgY/w808K5LdefXUHG7MN4FQHDMfmPfF3R
 9V2JL5zgMFuF2OqiK6RVEebrc92lCkFURD3LSIN58ed0IjzBBvHSyzqhJw2UXOQYv5Hbv1M+hcg
 dwBlHlHpVBSX7UaxmeYzbCWoENy3Oe/H1FyGK8gPOraW5WXZV8JmhONzUnc18N5xAf67FhR9Gr8
 /GmS/Y=
X-Received: by 2002:a05:600d:11:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-4888355df72mr65982025e9.1.1775054057529; 
 Wed, 01 Apr 2026 07:34:17 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:34:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:05 +0200
Subject: [PATCH v2 4/7] clk: move fixed clocks to clk/basic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-clk-prep-v2-4-16a78c8c62da@linaro.org>
References: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
In-Reply-To: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=715igzV4HS4mUxyYAOfpPGBwwmJ9nlDFxPe0UC3c4oY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo9r1U2LkmY2VDpEOEs8V/0nlvzyyZmVoVfyJvjfk
 Hn6hf1ORykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIbTMjw8az0790hjZHJYQ8
 jp19k3+RZduvLSc7Ajemmu1dp/DkiAnDP8Pr/k8O/2B8YvcpTXPD09cy2c1FX1WdHFd1sGZMPex
 TbgwA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Linux CCF has incompatible implementations of fixed-rate/fixed-factor
clocks, move the U-Boot versions of these drivers to clk/basic and only
build them if CCF_FULL is not enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile                       | 8 ++++++--
 drivers/clk/basic/Makefile                 | 7 +++++++
 drivers/clk/{ => basic}/clk_fixed_factor.c | 0
 drivers/clk/{ => basic}/clk_fixed_rate.c   | 0
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 30991e9f55d7..23f381eb0d9f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,16 +4,20 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 # U-Boot/IMX "micro" CCF port
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
 
+# U-Boot basic fixed clocks, full CCF has a
+# different and incompatible implementation
+ifndef CONFIG_CLK_CCF_FULL
+obj-y += basic/
+endif
+
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
 obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
diff --git a/drivers/clk/basic/Makefile b/drivers/clk/basic/Makefile
new file mode 100644
index 000000000000..4cf9469d2312
--- /dev/null
+++ b/drivers/clk/basic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026 Linaro Ltd.
+#
+
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
diff --git a/drivers/clk/clk_fixed_factor.c b/drivers/clk/basic/clk_fixed_factor.c
similarity index 100%
rename from drivers/clk/clk_fixed_factor.c
rename to drivers/clk/basic/clk_fixed_factor.c
diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/basic/clk_fixed_rate.c
similarity index 100%
rename from drivers/clk/clk_fixed_rate.c
rename to drivers/clk/basic/clk_fixed_rate.c

-- 
2.51.0

