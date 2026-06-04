Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E290ECD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 07:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A441E8485F;
	Thu,  4 Jun 2026 09:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SU+urbkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90BD8490B; Thu,  4 Jun 2026 09:37:48 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC60783314
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 09:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so177422f8f.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 00:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780558666; x=1781163466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcA9D2G58TVyS5qU83cWhqXqPh2Ie2fiFN8BBRBwybU=;
 b=SU+urbkvAaW0Iv3iRt8uWUbM2/pCjUAlgxxBH6CeAtkTvCaAZ8FmvaxyQHBG1g/7oC
 uRZtafyuQ8xWHiEXgl28W4XDkOXy1R8Yym1tfMZDYccMEE8uuREUzyeKUDIEG8Xo7w+6
 N27I45P/zAyJpGCFIGz9hPl93G+LJkT+3nqjUgk95RNHF8CUh7t0I++ViwUEH48qTIWd
 TLsogWP+AXXnHLch4F9tM+NhvSRuDG+NbUoQSRA2Clg8b4SmgTd58/OXlkCsD7LAsrfJ
 7oy4VzhEx0z3jgK9bND3ES8OYPCf7wp9T84Q+tdtOVuHq0+GzKAB0Pw1IzO+QvAuCBCO
 FaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780558666; x=1781163466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KcA9D2G58TVyS5qU83cWhqXqPh2Ie2fiFN8BBRBwybU=;
 b=kSXBSG7QaOsmERdQEjvPyM64zN3MxKXgbU2Pda3xQMfjRcLjKr9eHXaWSjH4mAGc1J
 ecxID3VTXoa/M1CzDwMYtQ8O5SYXuiz+JoDcos2POxA0JWpI4Zyg7RvYPZ+iNi2LfXrn
 uaQCakrowBA+WFNUVGB12wtaRTc+MZFnV1tdlJVZuqK3Q2dFA6W1CoWauJYIA8Rpgjlr
 pwlXj+ReZsQuCOnk6rv2Zr7nQMxbU/jqouk94PTbCtHwm9NCLBTMcuUeqZ/dUv6DbWM9
 mc7JhvFg6bYvbGaoCbQNW7cZoNS34/lYHthL3euRQHUsgJ5W2tv29LV85dmKZocNlOiq
 q7Xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QEH5X7B4qBht0hKNNu7GDDCjGvhKHCOHgj3WOaShmqEa+hKtRafensxHqt2e1XGhNCE0nnrc=@lists.denx.de
X-Gm-Message-State: AOJu0YzCHts571cM5h16QZNAH7XCDcQRj2VZt1ELMzLwvcEgrFpZjab+
 rd7P/YlK39+hhz0JYTHMMttGXJ4o4RUb1+FyCuEk5q4OMKv3EVkUBJV4+cw2Dllotps=
X-Gm-Gg: Acq92OGT5dU2BWW4plJx5KzcirVIU29ST2IskhjTskn5fqVZ4V716GYEb0H5/zgy97J
 fkQ8PEz2a7vOV8twRcsEIjtm+2bE8pI2kN67uUHotoTSL8tjrIVIfFI81BINs++IGIf0O1Vrw41
 SQBlElvYqaEjq1Z1on7J/9ilDWJLzvSY3BbMQNGRATiSTMK4EDJ6PqVmFshPPSIP+Y7A4SNmAAi
 RoKu7PibNp8UwdxmVQujCnK1uJYgJWxPDnarGKiwdBvhTqqQgwEcUXnAwClIgm7qZibuMsDxEuY
 OcAY1Q+k42gB09nhxCgyhx1+shkHdZiRQCJLYlu8D7ITrNgHJYNfcgTGXno9ZnyechP3NLXzcnr
 VnuzYAbxD1Mtj0s1pUFQidpdMEOUG466TVQHFlvWyc4MzTcGaaJ8Ih58M8K5nQFSqju8ZlTB6I4
 x5b4hDOoNt+zPW8L3k9S4hSvHlo3weFC1ODNKS5ML5dKdeho/RfjaiKh8l5M10hbWsNZeCV4iIE
 M09QjqFKzpA5tQ/Un6rRb5vTXBHKefNv5mIy61dvsFddEvhoNp3G5YF0lH2OYbuqYNsIlAN93Iz
 atFlDRPvBgXiJGwZ6f/+zMKxu4WJrapvCBU8wBC3gNOZoZ+SQIxDomsYAL0e7idmJThFGRs3rZ3
 x/iAc/+iDAmoctNJzYla3WIvzxGBwaFOvPMWtz/Iqw/eldHjaNGbpXiCJSrAa1vBqLVtDES0+BE
 X87eT3By3vj9oVY8qo2woYksijQY66FISjKlJ5an5gObs6ALmeN4jMwEKn6zh5v4jYtEvdtVMqy
 /Y6vd5r6+jsrV3ITf0NOBGIBflSlOXyFFjv
X-Received: by 2002:a05:600c:4513:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490b5fe9bd8mr114516485e9.25.1780558666288; 
 Thu, 04 Jun 2026 00:37:46 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm46436675e9.2.2026.06.04.00.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 00:37:45 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v5 6/7] configs: Enable RELOC_ADDR_TOP on arm64
Date: Thu,  4 Jun 2026 10:37:11 +0300
Message-ID: <20260604073719.48723-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
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

Since we added an option for relocating U-Boot to the last memory bank,
enable it for QEMU to get some coverage

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5bdbd6fb59a4..ae6dd770f3e3 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARMV8_CRYPTO=y
 CONFIG_ENV_ADDR=0x4000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_RELOC_ADDR_TOP=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
-- 
2.53.0

