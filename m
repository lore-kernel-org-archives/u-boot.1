Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CBDCF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF54B84002;
	Wed, 19 Nov 2025 15:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/eWE5vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BBD84002; Wed, 19 Nov 2025 15:55:46 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F8F83FBC
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65752954c38so1609110eaf.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564143; x=1764168943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TbV7mwzznvldwoTY1KauDf5zyppuX9eQlel+/qhbJR0=;
 b=X/eWE5vwAlj2BsiMuZH5FvS9mx3are06BijWhgxdqP8dOcjyb3t0y9uqpIs+EL0l62
 SDX0BmekradLxfP2DYgH0lTmTm4XYOLiB9BaR+KZ6O/0w6lLryX4v1O3WdQ0PWMyA/Nc
 cdqOlwaRipkquDr1REjh0rmzOnpJ7GtDgpfMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564143; x=1764168943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbV7mwzznvldwoTY1KauDf5zyppuX9eQlel+/qhbJR0=;
 b=oXlbvLKbEuRgBYOdG+sUZg4bQxr8jNwYTsa5lulUcQ0xcXBX8CRgvs9nV7vnZw88b5
 bMW/g8hZ0/plat5XKReYArlBOg6f5OGtY4gUOnx79vRkZSu0b1pdjS8odQW648OsPtyC
 zOd81qCAPNUV0LkwVc74g1R8NZ/BmsA1Ruv0S6XlkxrQIYw9eicWV39Zen1hyx0ffTck
 IlmXWn/MrwVXtxVTMoOUrjGwFmwZUl0lYY1WurZgPeFSpaCv1dtcCtCw4gMptE1QeJVi
 rHlsvetpVpefNC/6hn+IiIOwBVaAaTNh6kD9OduWmuaAHB8xhLVo9JoqfbxPCtakpNuG
 iqRw==
X-Gm-Message-State: AOJu0YzyV7vus4cnhH0a/vVUmcVOVH2GO5T7suQ0TMkLt9YYlmaSVGco
 U7IfduOdhNYt2l4u5XBxE9ZCIV9LIaFJQ9FZPcTzrLnclagiUkUtJR0hjz+9mP1dVlyOSsKOyhj
 rt+/kJErjag==
X-Gm-Gg: ASbGncvYCtG++4yXKa7m6wJGHMyH0YYuO/tUV/ezpPbsC5NfT9PH0BOR5XXge7PRo6L
 WmxR+ROBik2MrckgpJMeT7m1jx7GyUIoiCk6g+DDTrD1vShCKym9kPjSAJUwtHaxMUDVdFf+pi8
 BnvJgdFRyhxhe/lQEkjuBzIkKZ19YVFEUYO+RfeI0aTWf2FVxdBKHS6m03F4PkhGl0tGfEuYY11
 0VwBSNXCXgClP6DKHYW0HuJ7mP5IXhZkbUsAsoG6mKVLRTnYEk5hOPB3PwYEjweriQvju2Z8bZH
 Gh6vGhYcQn6nJbAxzIsms800LpL+HdNUIRd4s81dUxUEsLQl5HKa7drcc7crBVxBbvsA/pKPivZ
 /CUDqy6fwbTZe1etY3eiamlht7uy68td61pUuUXyvT15iyKwgL+z6lUPz2gJwq/Sga2M8helKb6
 Z9qS+tpAZqc2wtAa66PfT2LYS+ShRGWSWZQ4ymMVrKQ45ebycNgDhX
X-Google-Smtp-Source: AGHT+IHZsVsuXr0iR0ajJWoesBcml0pDYy5GVQbsQVT9GdwL55alHcLGrXvuA59cLLCyJG6B2lBOTg==
X-Received: by 2002:a05:6870:178e:b0:381:e796:fbdd with SMTP id
 586e51a60fabf-3e869184d8cmr9990475fac.35.1763564143087; 
 Wed, 19 Nov 2025 06:55:43 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8952f7e89sm4663307fac.14.2025.11.19.06.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: David Feng <fenghua@phytium.com.cn>,
 Linus Walleij <linus.walleij@linaro.org>, Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH] vexpress_aemv8: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:41 -0600
Message-ID: <20251119145541.843466-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: David Feng <fenghua@phytium.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
---
 include/configs/vexpress_aemv8.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
index 5eee13b3fc01..fc4727b4a380 100644
--- a/include/configs/vexpress_aemv8.h
+++ b/include/configs/vexpress_aemv8.h
@@ -179,7 +179,6 @@
 		"  bootm ${boot_addr_r} ${boot_addr_r} ${fdt_addr_r};"	\
 		"else"							\
 		"  if load hostfs - ${kernel_addr_r} ${kernel_name}; then"	\
-		"    setenv fdt_high 0xffffffffffffffff;"		\
 		"    setenv initrd_high 0xffffffffffffffff;"		\
 		"    if test -n load hostfs - ${fdt_addr_r} ${fdtfile}; then"			\
 		"        fdt move $fdtcontroladdr $fdt_addr_r;"			\
-- 
2.43.0

