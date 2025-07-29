Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00262C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44916829F5;
	Tue, 29 Jul 2025 13:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lTgQptbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E150282ADA; Tue, 29 Jul 2025 13:50:50 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C2882103
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b77b8750acso623107f8f.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753789848; x=1754394648; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EJBTIpchyI3wEqaczadtzQXr7w+gP5mylFxJOB9BVBU=;
 b=lTgQptbckwJ5S3mZfH8ToUJiNa7Lq7D3reyZkDkVHgmXnGMiWZWOt6ZXkFaQuAy6/f
 gY0e4G2F7rITzrZg1ZyJ1MBFtXEAvAHfioIKe/D7OEhXjOqQVvljbM8gvWgbWsR2Gj2+
 jTT6wWARlYizvDALe7PY8pUIPZ//22VLGNzEu6hCCPmqX6Q/06fRX+clOTn68buMTUgs
 eYRLyZqEOvQBbI1NrDQnfnmnKtMVzeYLAJEU+lVsLxiftSLjWYf8lUSAep6goFBYGveJ
 ZhhTxI9PLq5ayLP5+MKsCRIVMajtNItx03Sf+aQqiyNm0WB6LxPnlnRQCZc332hWhHBH
 3RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753789848; x=1754394648;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJBTIpchyI3wEqaczadtzQXr7w+gP5mylFxJOB9BVBU=;
 b=Qcqq7s7aAmZfEaVUXYhSl54Q0VtjaKMRAaQ2FdrmGtWtL4hnfU3au54DmFi6COp7tx
 gWbxaa3lU6cyRqaVcQGqr1IGxnv8PsRyIuWxAhnGKKJ4+y3yeA23xdFVgfkjyggaRR3l
 6JD5LqiFAVTpAfEI9Qld01YJWhAHdHQWrzUXZPbXjQ5OdH2Cks4Gs5J+9JV1+kB7GiOv
 z1FSD95RuYf4T24eKxuKACqQ143Mz4s7QG6HurcPY+oXTXmiWs1zkXkmHO1U0s3I6KpD
 xw2TNHn+EAUjtJYaVm8YzveWAc60duAgvUty09XFOMGP8NVo8afmcnft2RCHoEWtWfiL
 UjdA==
X-Gm-Message-State: AOJu0YwWo7wKTHkBOgurbJTcyNyoD/v9c4/lloAEJMxr2BW0qCeQzmC2
 2bp5U92SkG3Hlqpa8Kdisn5oj+4tY+BFggs/b0itE+fDJbK2EvkjRCnA6yX3vslMQH+Bmz4mnK5
 zpYHL
X-Gm-Gg: ASbGncuigiXeTqJeKv6yVPE6LDPBgCeFiKwnFUtv/oyK2TGquyDmN2nxTvJb/w3oj/T
 a6Vx4mvKyAmY2vsuTZm92LLwZURJq4jHuxXDdvIF8om7NaqE+M6ZnMdIUPG2Magz9xFHS8vyE8K
 VltNzXQhPtEMwsNpGWuXjUTqEGMUu4QyCVOJa25uPiFnwmG2VaLMTAyeXxo1KGtWu6ZtQZc47Ue
 zoL6CCvs6c5dgGnpOm5sBje7wam2ff+ui22+C5hIYruFBVT59fgDMkJW2fNB4PHzGgeCHyDK63V
 kG2VYM0JrOHGQHl0ldXtviPJn3nyKZnh5LwYskIbTwpjachPIynfYQDOhw79WBpJLhm8KliJCfA
 mdaePchGnNTKkRuxYAsWhWQ1jVLBN35VAT/ukyGMSIkCFyflX7Xq0iHbwdZMpuw==
X-Google-Smtp-Source: AGHT+IGOZa6HujiexvSoiyLGqmKWBs4jISLbKXaTMobJNI+kwnleJo+tWq5XYfxxtOWHlt4S5ltC0w==
X-Received: by 2002:a05:6000:24c7:b0:3a5:281b:9fac with SMTP id
 ffacd0b85a97d-3b78e50252amr2378452f8f.17.1753789848013; 
 Tue, 29 Jul 2025 04:50:48 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:b80c:a2c7:328a:9067])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f104ffsm11773779f8f.66.2025.07.29.04.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 04:50:47 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 29 Jul 2025 12:50:47 +0100
Subject: [PATCH] socfpga_dtreg: Ensure reg is initialised before use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-socfpga_dtreg-v1-1-346cc5d367a9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJa1iGgC/x2N0QqDMAwAf0XyvEIXJ879yhgjrWnNw6okMgbiv
 6/6eBzHbWCswgaPZgPlr5jMpcL10kCcqGR2MlYG9Nj5Hgdnc0xLpve4Kmc3UO9DurXY4h1qE8j
 YBaUSp6P6kK2sh1iUk/zO0fO173/PoSy5eAAAAA==
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

In socfpga_dtreg_probe it is possible that if mask is 0 then reg will
not be assigned to before first use. Refactor the code slightly to
ensure that reg is always assigned to and remove a piece of duplicated
code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/misc/socfpga_dtreg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/socfpga_dtreg.c b/drivers/misc/socfpga_dtreg.c
index ea5d0bcdf51..dd6809433e3 100644
--- a/drivers/misc/socfpga_dtreg.c
+++ b/drivers/misc/socfpga_dtreg.c
@@ -76,16 +76,15 @@ static int socfpga_dtreg_probe(struct udevice *dev)
 				return -EINVAL;
 			}
 
+			reg = base + offset;
+
 			if (mask != 0) {
 				if (mask == 0xffffffff) {
-					reg = base + offset;
 					writel(val, (uintptr_t)reg);
 				} else {
 					/* Mask the value with the masking bits */
 					set_mask = val & mask;
 
-					reg = base + offset;
-
 					/* Clears and sets specific bits in the register */
 					clrsetbits_le32((uintptr_t)reg, mask, set_mask);
 				}

---
base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
change-id: 20250729-socfpga_dtreg-9a70bf432328

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

