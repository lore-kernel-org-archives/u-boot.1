Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FAAC83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 10:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A20A783933;
	Fri, 25 Jul 2025 12:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xTt6hDUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9EA83939; Fri, 25 Jul 2025 12:41:16 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18ADF8391C
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso22008815e9.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753440073; x=1754044873; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=chCS5EiJdfuSwCoOrsHC2dYJgKvFyVp3Vb3gvJVM0AI=;
 b=xTt6hDUZe2QJtp1mzuUD6CkmGoMLbaNak9l64fHBUzDxWCTLS72gahYpb/Eks56O8/
 ufMJxIcDTyTi5gP6hamEpxjq9ygItE3UBl9zdsc3VauuW5QxuxBFTXkg4floyeew7be+
 IsFj9U134yRQ9SZy/T0mgAsDn6WG6mPtcn/97To0xcjpp4HJAzZozBcqXdfrLOpU3agM
 Eu4uIDyO4S3Z5gmLheEVCF5doQ268MnYbybxCKhJKJk9S0dE19LKhqd7hOizaT6TCcOj
 Z1CgyP3lQbzyPHdiXjF87pkAOwxg6NaXHsoaMK0UwYuDtI1MkyXuC/txRRdsG90wzTc4
 ySqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753440073; x=1754044873;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chCS5EiJdfuSwCoOrsHC2dYJgKvFyVp3Vb3gvJVM0AI=;
 b=bdsHpiCuVOxpVbO37eKqGfHt7dTqZDfgLr5q6irFrXmdSloZs9JV9YfDy/Yo26rvoV
 XMUY7fwNywsCTp2IejWlbxDpU/gT9VUI7iQR8uJKdjQXRO5wUPhDlbuW9yQYELY+jdRd
 tbyGNPBH42iopMqM0z8dkmjjoh1uEjQa9xOtgRFG1dm+tfG484LqeoPkNgXoBufDJrCe
 GuLFVi4atvAZlkZuAQetQceTQiXV7U1X3pKN5WK4gnTVDzyoK6z8VePLXSDwVgU5mStJ
 cxkslswT5v5wCUg0bQU4oUJ4I5EudUdXJSgbHDa1aamG+Xn+KI2KUVG0u9sdnNcfYYPC
 kSTA==
X-Gm-Message-State: AOJu0YwV7+nObrxj2Tv94ZWiLf6sXW9PMRzHgHeUkMlAeJWHZvUqkBVL
 lBBGMNixGzlBCRJj6oYx2DhQ3rD4i1xAa/DwVvCg3AhjoFisxSAImYbIMfODfS0F0V4=
X-Gm-Gg: ASbGncuM69RWnwpGhaE5l/d8W6KwWFHBGOFu0zFOdRXhExrGfTgAti1Ok9KgJnr8Wpp
 P8mz7xB4DSwiLvqSb6NeOXpCsYUkOVXPHnayqNdgwLBE4y7PD7ObQXLL8OBrhuB7ZQ8mQem1sRq
 fJTz4t7FvSb1rWIPH4jciU730yEeUh1g3YtzJUI/duqXvzJAXXPVXHzGeyJLaZt0ud0akWg54TZ
 3QRT7G23ji0P4e1Fcqn3BFIKnziTtLDglJmVlG23xagVfmYwUK4Y+pl0sU1r4qEMxuMzidZGpIC
 7PZcXMWlia6ICnJsL2a5PfYSNBvJKV3N3y6/GcdoKzPHjYRmo24hOyjBRFOoCIkW1bCHVJUjdK1
 DOzv+vV5XH1KBfTevXLpHl3AefhcXGLDKHaV3KycXO/yRRE051Q==
X-Google-Smtp-Source: AGHT+IEFNFWdP7qveAoYRafGZwAa19sJHaesU0t7fZM5u8Q4I61siiUc4mQ3sA3VkXSrazH0TVe1YA==
X-Received: by 2002:a05:600c:1c86:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-45876307432mr12670825e9.4.1753440073422; 
 Fri, 25 Jul 2025 03:41:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc71437sm4658047f8f.29.2025.07.25.03.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 03:41:12 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 25 Jul 2025 11:41:12 +0100
Subject: [PATCH v2] clk: cdce9xx: Fix use of dev_read_u32_default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdce9xx_clk-v2-1-3ba5a5bdf6b3@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEdfg2gC/22NQQ6CMBBFr2K6tqYtasGV9zDEtMMAE7E1U0Iwh
 LtbWLt8/+flLSIhEyZxOyyCcaJEMWQwx4OA3oUOJTWZhVHmoqwpJDSA1Tw/YXjJCrVSJdiy8VZ
 kw7uE0rML0G/O26UReTs+jC3Ne+ZRZ+4pjZG/e3XS2/o/MGmpZQVet7Y4Xwvr7wMFx/EUuRP1u
 q4/LRItoMAAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

The function dev_read_u32_default does not return an error and the
variable 'val' is unsigned so testing for >= 0 will always be true. It
looks like the code was attempting to return -1 if xtal-load-pf was not
present but that cannot work. Instead use dev_read_u32 which returns an
error code separately from writing the value into the passed pointer.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Instead of removing the always true test use the non-default version
  of dev_read_u32 which can return an error while writing to a u32.
- Link to v1: https://lore.kernel.org/r/20250723-cdce9xx_clk-v1-1-9cb1f734637b@linaro.org
---
 drivers/clk/clk-cdce9xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
index e5f74e714d5..996cc30683e 100644
--- a/drivers/clk/clk-cdce9xx.c
+++ b/drivers/clk/clk-cdce9xx.c
@@ -116,8 +116,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
 	ret = clk_get_by_index(dev, 0, &clk);
 	data->xtal_rate = clk_get_rate(&clk);
 
-	val = dev_read_u32_default(dev, "xtal-load-pf", -1);
-	if (val >= 0)
+	if (!dev_read_u32(dev, "xtal-load-pf", &val))
 		cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);
 
 	return 0;

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-cdce9xx_clk-9e1008c78db7

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

