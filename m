Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B5AC369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D4582D33;
	Wed, 16 Apr 2025 09:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TuGDxwYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFCC382D09; Wed, 16 Apr 2025 09:49:02 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C2C82CE7
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso45635485e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 00:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744789739; x=1745394539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7ACoAnFin0+NaIJsTjXj6GO64iPv6oRILYAQkJCXQI=;
 b=TuGDxwYAMHCYMZZ3xKZR/pevDY9FPDGT4Abb5e39EiYvMPcah0omEGxCYG/nu5WJ82
 wN//pIKj8n2c6mCmRuF/bnH93N2zsR3QrHz103M2n6lPfLVqq14+lntOXqLJxNC4M+n6
 damb7opwCR847ESzy+N5r1+zZqyj48qTnBWPzPkg1G6ct4Ri5/uGJ6Mxahda1SBuANhW
 s1WgNgnismvU+P0Ohx3kYg5ebfNzcUvUMRTXrmTkuNh5GSJ0qKULUj8IlAcZI0uE33rz
 647axONpAQOAXml3ZIGyIfnlTLUPXA0xDq5t8fSmcWGDE/eQ6znBoQHcUiWNzamipF2J
 zI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744789739; x=1745394539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7ACoAnFin0+NaIJsTjXj6GO64iPv6oRILYAQkJCXQI=;
 b=a2RjulqfanYFzx0B2EpHUR7GmUydXi/AlJ0Gkw/37xHAblnlilH71PH87V8HyCmaC5
 +aN1yuHKGMAv7uunlsBp3Ye5BOCPZwqqfiEGOORJYIz1yDUgsYwSSRwxS5BTlJNf8jPW
 SCqg9T2e+a6XMqPwL4Y4U2yyg4lYkiZgEiKjIZ8Ni59ZZJkiq3HVqpttJzKV88a6zxqJ
 AxihVFc/iiolRb3R9ey0xuYCNl3qKJ4dwbAdJTP/8wmYBPwqb456DCv4Ri3bkf0RiIX1
 MY96ETC5A+B960YoBUlcWfrecXxA1leul699gzylnxsbWeLjq1ES2ODeW+U2olhpBIme
 bvkw==
X-Gm-Message-State: AOJu0Yxdv6aL8YrSjCRTc54Vd9X4o6pFSYUNOM0/IOTx1av5qJ8d9LD+
 ktFcMSIvFLSD8yre7lQAdKSryBzs2ydRiVpoY9FA0ybBJ51Y88+xOo3bYJJR0d0Y23nGwmo/nTY
 C3jU=
X-Gm-Gg: ASbGncvInzqbVSotpcd4QP3TP8tP5x4FwTzssmLScxeDqzE+qyS0uIAyLQUWhjLgUJT
 542kHNe2d74yU/FgCSEJ4Op5X2bqxs8hTSUZHbPZK5pa0RI5ZZBt7j71VE2tDaTzptkt+dy6aeX
 Gd/X+cYFYhtdnPox9Rn0UIHFFXSVMF74yuWZ2DhTdZ2DTIpdddb8ZeotKyUCT+rolGGzJZQpkvl
 gneB+wQWKu46rqq1M1jv5pOHNPjqEswt8OCL5OAG61GSWdPG2cz/PYBlrqbcL/YsrTsNnua/vq9
 WZgLCTYnfwoQSXXzM2BElVjutHYPeiOyrmad0ZYa9bBga+Wh
X-Google-Smtp-Source: AGHT+IEOnoAG/+kZTNi2P6cMTG8g7BsnEm2V3AltJlWg7rHKTzus56s+DJsO0q3+SzDebgmzIHS/AA==
X-Received: by 2002:a05:600c:35d3:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-4405d638014mr7201175e9.18.1744789739532; 
 Wed, 16 Apr 2025 00:48:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44043529fdbsm26929035e9.1.2025.04.16.00.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 00:48:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v3 2/2] qemu-arm64: enable UNIT_TEST
Date: Wed, 16 Apr 2025 09:48:21 +0200
Message-ID: <20250416074839.1267396-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416074839.1267396-1-jerome.forissier@linaro.org>
References: <20250416074839.1267396-1-jerome.forissier@linaro.org>
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

Enable CONFIG_UNIT_TEST in configs/qemu_arm64_defconfig so that the unit
tests are run in CI.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

(no changes since v1)

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 6c9d2505a69..cd9a4f2ae26 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -75,3 +75,4 @@ CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TPM_PCR_ALLOCATE=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_UNIT_TEST=y
-- 
2.43.0

