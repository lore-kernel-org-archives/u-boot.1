Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFE9C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 18:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E55982F7F;
	Fri, 13 Jun 2025 20:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d/oNVwXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2D782D5E; Fri, 13 Jun 2025 20:10:24 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F5282F35
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 20:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so1402032f8f.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749838222; x=1750443022; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/ChcbGDY2c0IGn7C4U/oe3atwht945xOB+uopiC8Q8=;
 b=d/oNVwXW6WW7TtPZpHU8Veddn6UwcxijQqKdHmjGLXOle284Hk4FAcR86gHYkgCXAj
 /0ef5NpnXnQweOutCSRyTW+EEsjsWQatqzj98yT5ODAtCowKTpu6G6IVIJlPeOjEvBu2
 Vn/HlO3trH4wZi0cDH5XURmrh4OWmmDvxSoBB7xTUsl6MQAX9e+Gw+ABPcy8dgkBClIa
 UVuHs6gozwYdB5iaPCEbR1VMeQiNdsVsIWhfz9nHVtrfgIFrwh5xWTVRyM5Iq9vqRkC+
 FUrB0iwD1n5RTkf6H53U7GePWWed8+Hthe7cZobYuKl4zN2rn6aXwmCkQ9n8jOYDmdkv
 AUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749838222; x=1750443022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/ChcbGDY2c0IGn7C4U/oe3atwht945xOB+uopiC8Q8=;
 b=dBtPAfm4IoIjfdAq3lz075RKbgld6HgavTiWtjzrQRuvd/Pz6s7MPxN/VgxkQ6TjYY
 3zurygO3b3+yMj+enHz7+J8KbbB+SxT6bqJz1CB4KxaN/z3Qp1phGsjRh1BrgbJ1Hm6F
 rNzUe299Q0fBFifu4PVjfhNmIDxljUyjxCj6xX9aNI/Wt5RUuEfhaHo2GIzUI7WAbDAw
 YcDxFtB3QEjEH0mxGCZNZLpN62aB14Po7rjIJtfOTlNXaL4rS9IIbQe3ZP/lsCCyZKBh
 G/ZVXoS8o9flXwvOMIBGpgkS9PR1UNksEY6ToY/39ETyxP+42Bj2GCwn5mTevl0RqShp
 ltWw==
X-Gm-Message-State: AOJu0YyzkNGo3pp97IEYSdI1bef7YeNypj6MVx5H+ZUqrQti2msBMsj5
 Lp65Djd5QiWrPfUq3qCN3ex9ISVriltvSjPEb+blcJKm6aXS5krQ0QwFNXs3G5+RWXQ=
X-Gm-Gg: ASbGncsrU7z1ecmvxUfGOVr8JQhyI/MXqRihG09wShQ5lax5NIn/cI6Sn3HnyEhj4Xs
 Zpdi9yDaR972CO4KvKXtY7p9M8UyNuFxzm55RO7oZu2VeWm0bMNqVxyIyPHQwdcL90Wws5uABZj
 Yz0pIXsUjmMrIuPPVb0U9kx0knCgXrKLf/qT3f31HfvA6DRElrT/yhBUmq8e4YmiIny5qMs0TUF
 me0d22kOtToPf+W4UvQcB5mbmOUGxpftn5n1eWsFTf+yiN+RhPQ7vHyGdU33B4C8qcgEjVSjgOr
 WMX7f/7ZYm60dLdtgOC3Tsgvc3s1kVeyIl8oTOtSAYyPAox4A0WPbg4EjxgbpCQrnA0YjZMIt4a
 dIeM=
X-Google-Smtp-Source: AGHT+IGYZxgLrXPkbewkN+inJhk8v5OmLd/aYtvVDFMkO+3FI4Q8FNBTftDcbRjJdmUZntqzqlqKiA==
X-Received: by 2002:a5d:5885:0:b0:3a4:f6c4:355a with SMTP id
 ffacd0b85a97d-3a572e59b50mr731121f8f.57.1749838222522; 
 Fri, 13 Jun 2025 11:10:22 -0700 (PDT)
Received: from toyger.lan ([213.240.182.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc98sm61511975e9.29.2025.06.13.11.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 11:10:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 20:10:16 +0200
Subject: [PATCH v3 3/5] i2c: geni: load firmware if required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-geni-load-fw-v3-3-be778b3b101b@linaro.org>
References: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
In-Reply-To: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=C9cV1XlqKOFnv1pfqDdwPR7Q+zPvojzlL4zUYBp01dw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTGmIHp9Uans2nrQvbyJSXhqiOcfWFfJ3inkvV
 040dsNZUEWJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExpiAAKCRAFgzErGV9k
 tprTD/9DOOPuU4qQv1fVix9gSc7rhkXhEQSMzdFwpGBwHzwQAgLszi/7lO+LnDvqqP7rT/RgiUo
 NEA2jyJq9T1uirjjgrAfnGGffCTS978Q8vChh3Q1e/gB1yvqg3dx5fzwRYT9PbU5DXMWDNXBR3y
 saHVOvSgrAKge/bOeXUHym6nT9OQTIQIko2jH0/YfvP65ermfd3NZj6OScj2mBMzwsIuEYIZe56
 hPSMxGWY4PxReVMbRp+wWiH2ff/Fm23OGJhchA06sEsr+fQCYFLP0eNV8Ql7/60hV+997x5az6y
 HLz3is4YOOxzKFZJe45E+YB6KInFNowTuorOCpvCyYqjuGk0BhOQcUM3G/5EJqR143V2QiengPk
 J2EgJcc8YZGSi2YAonSPl17VaIDnmItN8fV07zSnR25F0pjhEM2zhINDnRp/hgM/AgmqBkp2sOa
 h+/XZxJubOsHgIQUyQ/i8zjilJlG+qkqRFMzfSwdSt61RdBXgJP4k+cD2x9mHbde7ergIewIoS8
 wDwLFo9qLSmNyP6cSqrWLos61QnBpvXBpxlcdFpRm9dnXwaXkAd8KDAIVprKyWI+9rDN56hGEh+
 xCTkCqHm4bMvptN+Oxe41k9ag5ZKqs8bQi/aZMe2RTH1Lgyqj8PrmxY2iRKL1/4qrsSKEEaZIO8
 SmolBPseY032oGg==
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

Load firmware for the peripheral if necessary.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 4eb41ba852f7790ca646c8ba38f29fdb727fa804..d29e00fdf41df1d7a95d8d9b3b98f784f5b2a3e1 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -21,8 +21,9 @@
 #include <clk.h>
 #include <reset.h>
 #include <time.h>
 #include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
 
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
 #define SE_I2C_SCL_COUNTERS		0x278
@@ -498,8 +499,15 @@ static int geni_i2c_probe(struct udevice *dev)
 	proto = readl(geni->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
 	proto >>= FW_REV_PROTOCOL_SHFT;
 
+	if (proto == GENI_SE_INVALID_PROTO) {
+		qcom_geni_load_firmware(geni->base, dev);
+		proto = readl(geni->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
 	if (proto != GENI_SE_I2C) {
 		dev_err(dev, "Invalid proto %d\n", proto);
 		geni_i2c_disable_clocks(dev, geni);
 		return -ENXIO;

-- 
2.49.0

