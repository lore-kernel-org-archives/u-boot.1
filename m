Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ED6CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D1E846F1;
	Fri, 15 May 2026 15:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N5P8n267";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B582846E7; Fri, 15 May 2026 15:53:13 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BBF2846C1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso80276625e9.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778853191; x=1779457991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcA9D2G58TVyS5qU83cWhqXqPh2Ie2fiFN8BBRBwybU=;
 b=N5P8n267aBos7AYPEHx9Su6S+/VlDaY1FVz3m1RZv8k9I8lOmzorJp2bv6mGgW5AtV
 KcEAQ4oDgc5oNF5vnuCsHmXE4z0qZeXXYDQvZySjOcIOIZSG8LJp42hHUCFaRVLpo8WZ
 8ruKNQH6jhl4dslvi4NW0232jb2E3J1LaSxo1ulYTsAWa4iWmB0wZcEoXZ1Msz6bJcHz
 aIoMggoRFL7jWPSZH4NXoDJQniGESAj2WiLNxXwZVOY7rUoCxJerKRiO9JjOJhB6wLhg
 VF5YrHn1Z+1JuOzx9v16IAeuCpSU5xOlEdpEabjG/h/K1fgmOKB56KREgNXmKLKGMNFn
 lGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853191; x=1779457991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KcA9D2G58TVyS5qU83cWhqXqPh2Ie2fiFN8BBRBwybU=;
 b=PAIR8AnFwYzwi8tf7iqCqO2qhQHXyBgHsPH7Opc43nVHrgmXzyFIfD70vFgfAADxX8
 CTs8XofnPFuwLZ/FIolCGfCSa5yBVfyl65yjdGnSG34EBustTC9OmSTqrkpOaAyITFt9
 KqaBHKaCEt5lBR04gyJxXm5yDTsaAgKn3TjWhuO8YMoka2hVQu6O1ahcpLtOhzewMJZn
 YhA+PBlK4ypjxzPJHK3OwFmEfpkxu8ZxK8vFoPL5QjF60yu1EyvOQxXU20c/6UePrf1p
 eNptSCfeaAAOeS1iVKpdADJ8ipHCP9bk35yftwHOSI2vE59S2y/53r4F1j86KWdWj1nQ
 W+NA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JOaTo5XMv8i12jKI73ToBVxl8ToDnHzkJdRIQA+3fmx9n2/FTRwfBp1KHtg3/+nwUuhOeR7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwL712sTK4d76Nzi5C0ws/BiGzGeC6ArB7M+cjicaNP2MX6rI7G
 a7szk0hAuQ4ockZy5k9eWwqqFXNCN/keYoRArOeChJ1kxGZu9YP44GfHixTK0Y5GUhg=
X-Gm-Gg: Acq92OHhuGBlH6Czk39MqPiuqW5EjteoAhT3gxsycLl/5KIlDTw7sLoh362GzjdO3u8
 ssCbr6oVXIL8TxGan3HBJTHS7RnTMQKU2qZza3d1iNfLjAQP1yOml7VabcE52xyi2cBE29nxrnQ
 A7ArXhyBuZj3az6P6Ynelp/QGtwGOEofXxIpPhsl+nasBk3UXYgeuIE8qG1O/BHlIEPO/wLpYrE
 CFYUg1fogbaPcwWOACRicTZus5Pxuiy3CwR0xiqnG5cc78i2jQYUjIbPeW7QV9JrPy0aSPyMmB0
 0OUbTaU1GsnGeNwpOv3iHSaE4J+tLASIECyTXoCIwtBgoUHgetXImTwI/39athO5w6vuQL8mZrn
 +QMLTFiByPY7jv2EjuJE1gfK8zh5GNOTXQ3BtYW9kWX1dNUM5U2XQV5Bjpw1fLYmJDXMjmTGTkg
 2G4S4KtqNL04LUC0l4pujwbWKrmIpW66TKshOr10ywlkI3peILFMlDohgxBmb/29mOUzaur2xQM
 hmx0sTEwmVo7G44pFgNa2OMz1CuyAo/Hmz4rhfSJQTdZ//FZpeh45Mx/f6ilte4SkCf+QZufmXh
 8jyPYlcJ4Wr/jGQ1RipAy4xyr9ol0q/WAEWy2SbN2gnRb04hg7M7FWdwdwGxv4HkjhVWfdWDbAH
 n3dQeBkVpAalwa3uvT3UGhHTNqjBHIF5tAEDMulPYwYju65Njv4CCACaaGcIAVDkaabdPbKQsDN
 QE9AGGqt1QabCudoyKuA/NHaVagIzeIZHJRmT5EhD3VIpHDZxfZgDR9mhMAn1R6xpC19GYpjlzk
 pdJrvqxunA9ftdMrjCg4GWGl80A
X-Received: by 2002:a05:600c:1505:b0:48f:ed68:6760 with SMTP id
 5b1f17b1804b1-48fed6867famr17444625e9.29.1778853190739; 
 Fri, 15 May 2026 06:53:10 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm65854525e9.6.2026.05.15.06.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:53:10 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v4 5/6] configs: Enable RELOC_ADDR_TOP on arm64
Date: Fri, 15 May 2026 16:52:26 +0300
Message-ID: <20260515135245.45067-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
References: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
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

