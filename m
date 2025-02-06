Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842DBC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 09:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4529807EE;
	Thu,  6 Feb 2025 10:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YKbZC2b/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0CD807FB; Thu,  6 Feb 2025 10:29:06 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE065807E1
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 10:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso3505595a12.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 01:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738834144; x=1739438944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=73CNj4vJWLXX9YnlLmVpy4QLsUaW5s1T1wlGVo61w78=;
 b=YKbZC2b/TB8GuxFbuldnyyWCHY5ZDGe3c9MKqNXN8bvFLvZqgqqBAnYWB/vVeE1XX2
 mcatN5vibJvJRI45ArMLtE5ziwkz7XxWggNRULmRPB5Qoqc5IqYqduMYST1UPtqdVIjO
 CqWatduemLJZ2lWFeWPncNc8gS2APuAq38LwmfyHhQujzAx1aSZm2UNVN+eIZRINVXiI
 0xHo/4/ld2Yc8J56TcapDCBtUnKmUxi/iBZndgPgSTftqUk3vYl0OaDIlH3j9YR63SKd
 eUL08n+mvHkeUwr5hm9SNcR/KFNlzWLq9yN6d3JF5h/MG6Hn36SwriD14BJzwJ4XqbjH
 Cz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738834144; x=1739438944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73CNj4vJWLXX9YnlLmVpy4QLsUaW5s1T1wlGVo61w78=;
 b=e+mYhLy8iAfKYjktSC8g+IkdH+7yL5vOdKy/Wu9gwn1Byt1qA+fykhHtnOFWwJFIg4
 +5MYHbG/M/g2Z2G7tf7zw9IXdAn+EeWTqmkDgmyPG5hG1iPWglnL/mj+0jmZtI9C4CEh
 bnYkuF/m6iT9SB7t3EYs6wpaYsZPgf3xasWFULSJwgUaLCEQrxNNdVvNq7zp4dU4Kg1k
 vN0JyhnrnCzPq5TxT+Kug/nRO4ZStsrXjT3XnBgoMCIiwoJCktKYrR9dVEZ4gLHl7BFU
 LIfufGEZP7kFyoaHzuwPY/t460NFrrCRn+jxgk7SLghJCJ0Hsy32ldt9FI24wwwAMhTr
 T14A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgmdnB0QP7AgQ0YD3/oeoLVUGPvDSn5sFLeVudImDNUmmFjpcixOtxEt8QzDGwjg2T+7mdo58=@lists.denx.de
X-Gm-Message-State: AOJu0YyYYdiS3LsQCjXMZyxI1Hm80/o9zKcDu5ExCGXl3w9LQmIcDX2y
 D5FiIqbYB0brNT04V529YlTNdY7yWQFxLzq8HKdmXBwB8R6zPBW86a0garO6U9Q=
X-Gm-Gg: ASbGncsNBYykWAeJN2CV7Z1KLzNdWEdmRH6Uw5ihkd6yOFIEbOOdq6HvXQUfNijO3Gt
 13f8bLqKvpMbmpMVbGSKVg54kgEC9+tz+iPaq2MiBEgJbVQpUp9P//jJkHEc8r3JOA44clToC9J
 FeOKx7WKIv6ybpTrEZXmbHsTBhzdliZvjXO0HpFw95j8mH639ZSET/rT2aimBMpC99yZZFVlHOG
 +59fjSWEU9Aoxn+qY9fMTz4rhcJDBttxYbBw10Ouwa+jmMaLSYvTgPNnxKjqA9erWxJY5fJiLn6
 TWj2KAwirx0p0GIicLSIJaJ13cPxOcJ3ZDi92/wmE9ygU0bji8Md6HUWilo2m2vbqw+sqA==
X-Google-Smtp-Source: AGHT+IElKsXn9tUui2neOaYwouNzvDbod0eb76xlvU8kuf0QPnDbI9LlJjAweddtILheLPFu1XfPxQ==
X-Received: by 2002:a17:907:7fa3:b0:ab6:e04e:b29 with SMTP id
 a640c23a62f3a-ab76e84c376mr186000466b.3.1738834144057; 
 Thu, 06 Feb 2025 01:29:04 -0800 (PST)
Received: from localhost.localdomain (ppp176092155198.access.hol.gr.
 [176.92.155.198]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f4846asm70806166b.10.2025.02.06.01.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 01:29:03 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] tpm: unconstify tpm_tis_chip_data
Date: Thu,  6 Feb 2025 11:28:56 +0200
Message-ID: <20250206092857.46510-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
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

The struct contains an iomem pointer that we later remap and update.
Remove const from the struct definition.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tpm/tpm2_tis_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tpm/tpm2_tis_mmio.c b/drivers/tpm/tpm2_tis_mmio.c
index dee5503c055f..fc62dcda9efe 100644
--- a/drivers/tpm/tpm2_tis_mmio.c
+++ b/drivers/tpm/tpm2_tis_mmio.c
@@ -135,7 +135,7 @@ static const struct tpm_ops tpm_tis_ops = {
 	.cleanup	= tpm_tis_cleanup,
 };
 
-static const struct tpm_tis_chip_data tpm_tis_std_chip_data = {
+static struct tpm_tis_chip_data tpm_tis_std_chip_data = {
 	.pcr_count = 24,
 	.pcr_select_min = 3,
 };
-- 
2.47.2

