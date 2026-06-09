Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1CCD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 13:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFDD84975;
	Tue,  9 Jun 2026 15:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fGpZFgQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1020C8496E; Tue,  9 Jun 2026 15:23:04 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEF684894
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 15:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-46019b190b6so4148331f8f.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781011381; x=1781616181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znjt4HvLb4pvKX6Gcw6K36cGBOgZKJqIlmHQc2lpq+E=;
 b=fGpZFgQ2n4fRjwACjfQrL93S9Sp2fxQqjOsaBL6etzLBQAAIirzmzlvWjaprzS9P6l
 XAoGeimpTPUJuUm1gJO6qrBTtgDk4voxTLyi1XOC3iBcNcwyVKfCC0sHBf+cXFUeEBjm
 cV/BpomsoRY7RfXjOYZUTiKS8X7oBdba4KFNh1BLXbNCt67f5Es2Vqy/4fktvJoiU8Vs
 o1YkAqM6B8PWKXxD0lNSCNWbW76xN9BqropljBxgfCVZJVkJS1NBJpTzmy5oI7wgxGrq
 I2gKSoiCKrsC1dmeJn75TYRfLeKlEqOGR/d8L5/yaRzkDFPwqykA6q79uIDoIdFMFUMf
 Besg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781011381; x=1781616181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=znjt4HvLb4pvKX6Gcw6K36cGBOgZKJqIlmHQc2lpq+E=;
 b=VeYiwRnYYzr4pBJ5ZK/us53wAYGaC5o79oyCpDH8QrBmJRZ3wBx7vSvkENxzt/ZhtP
 dr44LfVE5T+BvoKlllVyyEZ+kL/vGOSdgV8BNavXGW1Kmqt0F3jebfGBuPBxYcQIE1v4
 11s3IYcWHjVG/IuCTmhJJBFKUSdDo3yFNXcYU3/3FlwjFJzFCCHeA1bljR4J/UT5XCbI
 JSy9tjcQqtK1WVdG0fh6snCKhVjs+0t6FCeJF5pfcmx19sCFeoUiVJDa0Z5BEANhfHgG
 Q8z+EY8AZYEyhFXXaAcpzAhVZ3ixSIb5s9TxhxZv6KiofKpLww/XQIYKuHycNhjJXzQJ
 GE/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zpGFgZBxjVz5P9w5WxT3gFQmeDh/Wx5BLKYkpZhQYpWHK7SpzK1Z0IQcwlh+qwo7SaGmkAuU=@lists.denx.de
X-Gm-Message-State: AOJu0YzVslO4CUVA5lSECVNhAPpx1NSufpo58W+Tq9W1Vz8bRiRURT9n
 3ArGvzTd+c4VdmIEoDAu7Izogq59Be9L5K/RogfgaCTL3W0iuA+9AD1PL/vFr1b34Oc=
X-Gm-Gg: Acq92OEXw+ev2oZGvea/Sp8bImovX9I6Nc9rw/Ir+MIymYpCujp+HWdr86VHs/UEdeJ
 nmNBTMGt3qbSYD5ZtjOUcHV5d31CgCZ9A6i0K2iuA+Gt3ndCEqSFQQDJ0JmIK5JuTLzvzxkKBSF
 T2Oi68eZl5QKgRWdP/sB7cP19UX0RAFmlbxrFu+DVK0l620Q+h9rf5U9p7MDsl2/1OQw7Vt4Nj5
 DqgsnyyoVhK/nsE2dy1/5Jhf2mzgKgvZ3VY7ughISytrD5R/XPM3nctxrawV8sPMW2x+5Ga7ZQb
 NEsgrwWAxyZo0s1/U3t8WNVjjCbTAv5wmhmyMPJ5RjIv/gYAySC3O5/XNN4TFQKagn/76B8RzcC
 Pi/vtDDWHSQ69YUNkiW1Z/vwWe3YHiQkW1uCFsns5HOtCvfhrsmP4tdoJ6MUgkr0MjR7b1Ckxp1
 wxwVoV8JX0n4oPivXy8ihYtrpzsjWpBkH7WfDJTB6FDwuX3BKAnqNcejbqboTJoP2YTNWDPhVxV
 8XSN3l1JdD/3MW1hArnmclXyMCK4iB6IYeB8x6khq28cq/oqmU/lky3IB2k/oez/QhoMkI9AYhK
 WPUEvpv8iN+7QWXGm9p3PubzBzZ84OWnl+nBgV8MXzj+tBrlZ5oixI+9SVaJgPlrkm/Ze0DgbWr
 qiktAVtH3dnGLjIeY2awMAo0090Uhi4a4Cy0TKdcVLbXKtetCGevix1sK7EklfypKMkzMxaB70d
 laolWH/mmJOk/ZsRWa47XIye0ktO3lkGO3MGsHFLBis1vwCz8j/BBtuS+H0E+mtQcAZPhg6v1zG
 bdZXsvjNyPYF09smPUeTddWRZ4Cm3b3wagT1pk=
X-Received: by 2002:a5d:4811:0:b0:45e:7997:8b7a with SMTP id
 ffacd0b85a97d-460302e8170mr23318300f8f.16.1781011381488; 
 Tue, 09 Jun 2026 06:23:01 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm68477564f8f.24.2026.06.09.06.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:23:01 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v6 6/7] configs: Enable RELOC_ADDR_TOP on arm64
Date: Tue,  9 Jun 2026 16:15:48 +0300
Message-ID: <20260609131611.46399-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.43.0

