Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D71CEDD97
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF7E83C5E;
	Tue, 18 Nov 2025 15:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k+y/UjAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F5783CB1; Tue, 18 Nov 2025 15:26:46 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A2D83B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-450ccefe573so909046b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763476003; x=1764080803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Se2jFJLb8F6RvK+rV9RRp6TANaIHpCT56+vpSQ0+zV0=;
 b=k+y/UjAoN6b9Aws06rq38/Uxf9Utq/z0GPND6fl9W7EusJd9t3mJaV216uYsrc6x0E
 2AzmPL1t+x46LY3F6xW6ms2qA6C8FCUQOXQLi3XpKyv8MBslKEjN3aI8CyuTwN7rzEyZ
 CPiMObxuAQzKLIcCHXkFcEflnYSTrMJcuWoyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763476003; x=1764080803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Se2jFJLb8F6RvK+rV9RRp6TANaIHpCT56+vpSQ0+zV0=;
 b=HI0OUIpVzqLv10o75Vq983oG7XP1MBQkIq4mcN3TjVUtL/MO3JGshrmGoAKlRb7Mur
 1LIUREPNRMBOCKComoRyzODb/PbwtKJBFs0CHmpkE0yqUFtdQD6SXmCPPhORaGisoBJA
 sliwBcPojkEjVqMFRmc5XuFhlwrjNoeieozBHKdaV0TTOlwewZSUWXdKwNs/r6cEE83v
 no02JtDUvgN0wa2F1dbHML3Q2I2uFOovxK6fnulLZvdxGUgB7BSs5hQjb8ZLPNPkLR0L
 DwOH5dA+P983/3Nl0aMxBMUkf2dBlZuw980dhDQ+7UrAeD7dtBUbQgHUeXkcmZsnypFp
 uAeQ==
X-Gm-Message-State: AOJu0YwpuP/+tPaF39WXxJGNwOi6YCvd79brhRfVH7yklT+fjdI6cpph
 4QlgEE5t19hE0+p+WouJAjo1RwyhQoGXWydJiSL2Pf48OdGPWiRe+H/TchTKHDCF1059HZ/ef/V
 lnTIeH1PmeQ==
X-Gm-Gg: ASbGnctyG4xPZXFStkKh2NVV5dylQsXGmZmSk7JK2/tZJI+A5INmG9DkcJqFvvxyiuA
 MAjzSeDr4AdCNFar0f3xJXUUm7rsJE/ybw6Q8bSfOTcNXknOEwUYhKZ/YUjEO1zal7T5JUrEKJx
 8SrAF86GdQK2YvROu9EGDGOymkFVYDIDovY0cYyrGwBfJ8+4gqIeTnTqkzPXELUPu6vEtjDRYjA
 Esn6WdxfdvkgrAgGdPtWOndrBKZ0R+w5vMcy6wBa10rhxpvBjV5oOtrHdPQRvruHlXpgCt9M4H2
 CWJuKNRS7bgPnb4QVdTEJvDvm8WQaXKWWUkWiHcSDaeBaeQlHFUIXJS05jEM1YO2KTyR8yZs1J0
 doiRCHzRjOQ/ZueRVz+8RqQx6h99jzg4Kh5G/RBzSfBsPsqMuIIH0vzo6CJ8s6ViIAoL0YCdjwi
 lC3M29pDMc5oZ5f1uKjRHo/ZVR3ZIRAs08WzWwu2n/s4BdCS0uovLCLy8MU9tZbI0=
X-Google-Smtp-Source: AGHT+IHmLpkKfhspquF3ifNKVoPZeFLI3odNjqlAkqDgp0CCZBPPo2hwO+yUV8mEzUKyzRD9U4En1g==
X-Received: by 2002:a05:6808:4fca:b0:44d:bc43:11a4 with SMTP id
 5614622812f47-4509734986cmr7159921b6e.4.1763476003351; 
 Tue, 18 Nov 2025 06:26:43 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6575441939bsm1950598eaf.16.2025.11.18.06.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:26:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Subject: [PATCH] adi: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 08:26:40 -0600
Message-ID: <20251118142641.526356-1-trini@konsulko.com>
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

Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc: Greg Malysa <malysagreg@gmail.com>
Cc: Ian Roberts <ian.roberts@timesys.com>
Cc: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Cc: Utsav Agarwal <utsav.agarwal@analog.com>
Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>
Cc: adsp-linux@analog.com
---
 include/env/adi/adi_boot.env | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index d56b14f51726..e266c89b110f 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -20,10 +20,8 @@ ethaddr=02:80:ad:20:31:e8
 eth1addr=02:80:ad:20:31:e9
 uart_console=CONFIG_UART_CONSOLE
 #ifdef CONFIG_SC59X_64
-fdt_high=0xffffffffffffffff
 initrd_high=0xffffffffffffffff
 #else
-fdt_high=0xffffffff
 initrd_high=0xffffffff
 #endif
 
-- 
2.43.0

