Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40766CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC6C83F5C;
	Tue, 18 Nov 2025 19:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qbFBgDtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1057F83FC8; Tue, 18 Nov 2025 19:04:37 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA54283B99
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c76607b968so673012a34.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489074; x=1764093874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ahmcISltOIL2OEUOrfoRti67PE/Fyo8zinQoEjISlyk=;
 b=qbFBgDtAlefxrWALJanCTOU/kFca/be898nL1Z+2MK0Y+g8VBBwTcGTAQeSqZS0hID
 n88LI/zc9BtaYwAQ4+zBGtBfhwwis58UHP+0FnmtE41ku/HBQyu4gA9yUaVJeGmrZylR
 U6jC4/NXrNyBYWkn60H92/aDMXKs2/wGyTQDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489074; x=1764093874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahmcISltOIL2OEUOrfoRti67PE/Fyo8zinQoEjISlyk=;
 b=efwK29R4/ssY3BvsLSE51oA33C55+XBeiWgFuy+60g2lM9CUUmc7EfAVgHKV7M+0y2
 A8662iH2k3xvSQ/v2mcJ2JDSBo0rDUVlfxgCdokrYJuoUTRu5eia4+rRZ+hvGjconpxN
 sydZRNz1ckcHig57g1kiCgRgqEvV17wFuBr975sXUH3+9oQwWsSSPcG1wYn+4utlc37z
 GINhYyvPAw2bMDnHG99+lJaWWhBfcaUez1IhpmNuuKHvi5nB5xRUioK4E6TDGZOtTZkn
 mo3kRQHH1hLtIF2OXKKAr369HU2v4QeXRgI8X080sXqaZNSqxTP+9xPLusjqZmE4EGft
 U56A==
X-Gm-Message-State: AOJu0YwJd22AL1jDhwivv9+H04Fa+R9Egb7BB6X+8Bcnzd3LwLfjil9Z
 20/H5V4/zBOrTLwn/eBeBfb/YTML+JkDk/zlBqlHpMYdixBli4m85DoM+mcgoUUa3sKw56+G94t
 zWsq/MIvfTw==
X-Gm-Gg: ASbGncuAlXk38i74TPkuSuT5HKQxkSwBmRva8F601unO3yGDPk4+8oCVVV2lHJ/vphK
 thVlzpfdjqBz3xcxvZAnWNKKLVtq7GzujbY7uGZSuW/173rJ6hSdOV+vghtwEdZarl/v3mRqwtB
 w7tZH/pDs5wioWCJjeFam+GWr57eQgCeg/TCKGH4RbZWjCLTILLUIo7vBQ1fM3rYiWHg+KlnQhU
 Y4BYjTQkBKcSud82Y114OqcELem8clAZcfkdprBJ8aQNd6bWGl479LhKoYExzEMuz0X5uXbUslY
 IQmk+Ew4Q6WOMshk0SAhuyUFlykCCOWWjZ4tKRDvvkQqLRMkWD4WHy5SlBauuS2rg5QVjRwvNk3
 O4KfOyLUg4dOcppmhGxazz4NWte89bT0HyGdZa6PuuSdo5Yheah7asNuy0slDTskkMi4tNL2Gg7
 aq28ARpRoyCQWne9z4M6919eCCNN3rK5i1nWPZxw1tysG9Xv1mV8ACSXzCLHSVRNs=
X-Google-Smtp-Source: AGHT+IHw5mUeKWWknVcnJ2lN15ZcUZcOD+TssbpwTucDOwLx0KhXjdkJEHNWUnbhvE2VAq2kE7QHcQ==
X-Received: by 2002:a05:6808:1207:b0:450:1552:371e with SMTP id
 5614622812f47-45097427259mr7215717b6e.27.1763489073614; 
 Tue, 18 Nov 2025 10:04:33 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450d5ffdc84sm1488880b6e.19.2025.11.18.10.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH] pico-imx7d: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:32 -0600
Message-ID: <20251118180432.591467-1-trini@konsulko.com>
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

Cc: Otavio Salvador <otavio@ossystems.com.br>
---
 include/configs/pico-imx7d.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/pico-imx7d.h b/include/configs/pico-imx7d.h
index 89850d8e4a7e..cc5c8b011590 100644
--- a/include/configs/pico-imx7d.h
+++ b/include/configs/pico-imx7d.h
@@ -56,7 +56,6 @@
 	"splashpos=m,m\0" \
 	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"console=ttymxc4\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"videomode=video=ctfb:x:800,y:480,depth:24,mode:0,pclk:30000,le:46,ri:210,up:22,lo:23,hs:20,vs:10,sync:0,vmode:0\0" \
-- 
2.43.0

