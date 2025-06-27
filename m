Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26412C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 11:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5481282E27;
	Fri, 27 Jun 2025 13:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NaZ96zPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A761382E9A; Fri, 27 Jun 2025 13:51:10 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E43801BE
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 13:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so1890341f8f.0
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751025063; x=1751629863; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3+RkbpqM4jqgm8tVVTM8dJ8YRf4gfeS32FJApBu7HJI=;
 b=NaZ96zPl07rq7NKj/99LglOLtdl327ckUkYB5NCF79KoyTGoFRkZdbX05r85wphEkH
 Y/Af4FWNQXBL6aDWyYHQHa3FM1WshClvWbATKUim89zZtJKF+5yaQ9N/HqctOcG0QJg8
 ejT3sAWbAqLc6BIOFbXsrceqfgYXj/UqBtcCbW7nEeWAmsWhQ22Zie6Jyr9Ca/PfNKHI
 /PqW9HyelhqrOQo76FWyOmnCAq3bCYsANH/Ws8M7Rq1EusZ+HJXSJ7n+Oe08yQMSNWu6
 AlGp60nvzWLCLSxTKFyfpbYrHVVPoUhbOHMZ85ZI3/ex+TK/2wTm5zPJckPWXSbAfEVZ
 2ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751025063; x=1751629863;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+RkbpqM4jqgm8tVVTM8dJ8YRf4gfeS32FJApBu7HJI=;
 b=npbtI6Az6y5jEMb5tf1V6TfMP7J11mo6cOQuGkUYeVqc6IweZKGEmMI+fWYBChFemB
 XS0B8LJ1KV8eJsAwl16kHi7xivy25yGOb1PR9+tKZXil+KAewiAxTYpTdAb8WoQHf46U
 GVUVWu0ZCSBd7D8iTWzF8JJYFwcRXAZDuoR4DaOJDDQnfwSNxlr83neepA9d6+g2KWwF
 f1PPcGDuUJTgm0l7dwKjMlVJ9qAYG9A6e4uA3pVNqawO92VcsNS2n2R13fzPnWgwoYZj
 0Ich+eSUU1c4VYUkukjGCst41by5hHi2meCG0UClGlEupwt34taSziqlbAjLrba7kdEB
 er/w==
X-Gm-Message-State: AOJu0YwPI6fKYA20Hb/wAb0exzc/rzItk5pk8J5oSbs5rWBoNxcSc2Bk
 BtCLutbxcuzbn3I8oQhnL2MfOi7Ralc3qipxuMtNBCNbn+irYfnJOJ/pRKMNNmT2fP0=
X-Gm-Gg: ASbGnctZ8j7fmVMAtRW2w+UUhjl+lHNRAaxqPe/rG40tRv4/GmR3RsRcOBuW3LpnkwB
 WO1Ve7+sk72rasoPwzfZF9H2iAPVO5ltat4atAmrGQHI5SszRclV1RMYcsoHSbkMlIPli4LgXBR
 ttdS+RVenrw96hvw0jrmQKyXeJcVxZnWbqzhp12TwilhkuASqC+70rVKbDKUkHASr75BWiQUax3
 NcIH/o4C/fss70k2P2EFeHk7deHqZ/t7OO2zBEFyLGWnRtzL3XWCE+LZ0P4lxhBHb+TkJiQsm4X
 u1kY5YTfhvklyLtVZaVCeRurqtfORkMXCS93Tuyp+Sj+/MOKZUlE7YrP8uogeXdBXD72a7nDOLM
 LYfV02qyc8MeYig==
X-Google-Smtp-Source: AGHT+IEcmHfpIObVpGbyiNrhovfLP73iK1Z0dtYqU6VAmI+XPGeP7/zI2Dx+B+lsX2x4/ULjCuGHcg==
X-Received: by 2002:a05:6000:2dc3:b0:3a4:ebc2:d6ec with SMTP id
 ffacd0b85a97d-3a90d5a7adbmr2766415f8f.14.1751025062925; 
 Fri, 27 Jun 2025 04:51:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:c61f:677:c14a:b7e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5966csm2510653f8f.72.2025.06.27.04.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:51:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 27 Jun 2025 12:51:02 +0100
Subject: [PATCH] boot: Ensure that ranges is not used uninitialised
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-boot_fdt_fix-v1-1-d2e0c4b13762@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKWFXmgC/x2NwQrCMBBEf6Xs2UAbTLT9FRHZJKvdg0nZLSKU/
 rtbD3N4zDxmAyVhUpi6DYQ+rNyqwXDqIM9YX+S4GIPvfeijv7jU2vp4Fgt/HZ0pxDKGmK8IpiR
 Uckmw5vmQ3qgryVEsQrb//9zu+/4DsTtBG3cAAAA=
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

The local variable ranges may be used uninitialised if the function
fdt_get_dma_range is called with node < 0. Ensure this does not
happen by initialising ranges when declared.

This issue was found with Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 boot/fdt_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee0..4f63ce9a763 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -1547,7 +1547,7 @@ int fdt_get_dma_range(const void *blob, int node, phys_addr_t *cpu,
 {
 	bool found_dma_ranges = false;
 	struct of_bus *bus_node;
-	const fdt32_t *ranges;
+	const fdt32_t *ranges = NULL;
 	int na, ns, pna, pns;
 	int parent = node;
 	int ret = 0;

---
base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
change-id: 20250627-boot_fdt_fix-e4e56d956c8a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

