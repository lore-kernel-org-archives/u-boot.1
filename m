Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B85BCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 06:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A4783A64;
	Tue,  2 Sep 2025 08:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ekdiY8cq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A47B839A7; Tue,  2 Sep 2025 08:08:27 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050DA83A64
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 08:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7e69570bso24463995e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756793304; x=1757398104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uHA420BX6JoWOAx//eAwTad2eFGl+WcwJzMnR7XOS7Q=;
 b=ekdiY8cqe4RZFIehAYSWLaNnz5gXViwvGgh3jJcP/v2RUPi78Kz3xaPfFa2KNZv/IH
 XzSspP/peojB7ZJ4XPEtW61NFWee6MwfPE8PclTb/qu8s+zlKtN0L6C3n82DLOQ5cF68
 O7x6dCVCWRR0xa+G/GTdFFQoxeFhD1u2uz3+jV4LyJOlepzxxuu8XqQjbOB5OMI6c7GH
 GARqDC4eaeXl6wSAijhb8XujNEF3ogd6YM3+8SuokUxde7K+KrP0NuPZdKf2OkZzrwAB
 0hMTO52yhnUdY8cV0ejUCkZ6bitGfGUUsNn2Z0oZQZfyyG8Q0qwiRX0h7UHafeEN+W/Z
 zmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756793304; x=1757398104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHA420BX6JoWOAx//eAwTad2eFGl+WcwJzMnR7XOS7Q=;
 b=je+ATYEsy+9oU90u2x2AF8FkWXh4byF77mOekczegOOfq8y1YjFkvroXtp9Mt0Q5xs
 8lF5I5DSW2wqA8+st/jCA8s1oAhQeSI0QJnC0V2G5XF9P31u57/WGLKRkYxHnWZhNkVS
 SElFZQddt4CB8S5IxWrFX7tobka3iVVJMns/AZ/EORdUpStpeMSaLz7idG4DQk2qrzPN
 1vyeZiLdTgyFQKpKaVbSkolLiYIB4b1HUNXipjo8OYwXfdQMSjxyqHxGMv8Ag119uu+R
 H2b8hE4bQ3ht53TyyiHWA+xj3XcgogWAlFwR8Ojd3PFB4gyuQ/hlQdbq+nB6DqEX/JFy
 0c6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMga3dSE5NXSKEAga1hqkLY6TFlR6FeP3fnfZisBvM0fvB8P8bPDzZTeQtotzCKjgfZW70qv4=@lists.denx.de
X-Gm-Message-State: AOJu0YzasldmYr1tlTbht1JJJ7SUVQGnbllaA/SgS7cgLfnYBDRmZWXv
 ROiySbHtwGUAztzquY07djb5Buh8u2F2Ll5VIMyuLa+9ZlZD+UYYGM2zhwPUOtKZMn0=
X-Gm-Gg: ASbGncuSFerw2CGv0C7mybcMLley9rJ/xsu1JE1uLHhLKGkLWAYGDm/Gt83ovwkpfIQ
 3NP4R0Gc1XwoabAE5y924QRagCJOOK/cqslh4EauEAu2T9CJ/aFyIt0VAHYtCBX8OUkCypkdnNc
 0B0CBeDGRI7GO1oAqg7gPpqEGiK8HybflvQz6xXW4g2ewlsUb6XNE+dazvlF1o+ln/vhgoEau57
 a+on6lhh79czjdbU+xPQBBAlXPftAd7eTyw+xetwsTUlG+aSx10rgeemuoDcIEtMpw2A7DYiN80
 Ll+9pI7etFEmeFzXm2M3KI2p+BxMkR6MK3xZkawYCaEopBHd0FHO7bh2j2i31VZGoYahPxD9/5w
 BH3pJCfFcScbeuwXfEGcrEf5SboYEpkZTFqs3YN8JaBS7JAHYuQQ5v5j38yRNYQ6DP0MPw5WARH
 ik0H02CBy/THbf9xgULqcmnEBNw2ICLXybNh1Npd5C6oit1WGdF5EB6+p77VdZ1MmQQalBvuOwe
 RC6/Gaqknsf7JZG36FJpzRJbaLrpZNVe+XV/8eNKcNN+w==
X-Google-Smtp-Source: AGHT+IEsMllBzZagTEDgN9EcVTaWrCyYJjMwYVo1X64dFe5r9HRpS06wA+Y0+lpbtApnLsTas+x0DQ==
X-Received: by 2002:a05:600c:c8a:b0:45b:9afe:ad48 with SMTP id
 5b1f17b1804b1-45b9afeaeefmr1484625e9.16.1756793304433; 
 Mon, 01 Sep 2025 23:08:24 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b74950639sm234412365e9.17.2025.09.01.23.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 23:08:23 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: heinrich.schuchardt@canonical.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 brock_zheng <yzheng@techyauld.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH] arm64: Properly clear BSS
Date: Tue,  2 Sep 2025 09:08:12 +0300
Message-ID: <20250902060813.2481257-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
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

Brock reports a breakage on an RK3568 SoC. His patch is
correct but he never followed up on the requested changes.

We currently use ldr to calculate the address of __bss_start and
__bss_end. However the absolute addresses of the literal pool are never
relocated and we end up clearing the wrong memory section. Use
PC-relative addressing instead.

Link: https://lore.kernel.org/u-boot/zfknlzcemnnaka5w2er5wjwefwoidrpndc4gjhx6d5xr6nlcjr@pasfayjiutii/

Suggested-by: brock_zheng <yzheng@techyauld.com>
Reported-by: brock_zheng <yzheng@techyauld.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/crt0_64.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index f3f279f2c39c..3e7627aa389b 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -158,8 +158,10 @@ relocation_return:
 /*
  * Clear BSS section
  */
-	ldr	x0, =__bss_start		/* this is auto-relocated! */
-	ldr	x1, =__bss_end			/* this is auto-relocated! */
+	adrp	x0, __bss_start
+	add	x0, x0, #:lo12:__bss_start
+	adrp	x1, __bss_end
+	add	x1, x1, #:lo12:__bss_end
 clear_loop:
 	str	xzr, [x0], #8
 	cmp	x0, x1
-- 
2.50.1

