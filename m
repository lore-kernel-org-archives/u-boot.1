Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173F5CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFEF84008;
	Tue, 18 Nov 2025 19:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qi0F5tw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7813B83FCD; Tue, 18 Nov 2025 19:04:38 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62ADD83CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6d699610cso1423265a34.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489075; x=1764093875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=akKgrp4GRbCr4R8IAKt9D7PPZAJe9GDP6wB/PmVb28g=;
 b=Qi0F5tw8adIXh1MYGg0Nz8FOxsmD5iYOsvXzqHlzkAR+aUlz2oecZioXlJdioDRCb4
 mbX+PZ1JCw+HfLpQoC8NITZfW7QCcR6TIAnF1AiiK/DhAfQ2k6IGMSySDZc5WbrZm6Zc
 xQbqP2VHVwoGlXLGn6cRVlVxcX30lqb2CLGnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489075; x=1764093875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akKgrp4GRbCr4R8IAKt9D7PPZAJe9GDP6wB/PmVb28g=;
 b=aiOgnQ5GwhoGy4reYMtRsFEtVEOOYm02TKNAohiFaCfi26xO91+KhrzaexORqHsEAP
 FNXR8hd7uWEQkLDwvrpIHFqYa8JMwy9j0Sm9v70tddrPH8D0S0RwZ6R4GyqV+huglfzf
 JVd2g3X7ChrcyToZqlfnJGCM9f33mEnjkYjVQ5s9WBo6wN4Xewpq3DG23y6l2i6fRrBq
 zlYtZkBqW/QHTUPJO2Wrzr6hd6yO920DPeDSrprzyT0E8hEfAAvOiFyCXa+vK59G66ZP
 dSLyWQSElMhsxiHjo26R4bFkfwHPEwW7xfo3bpk5gyodV8tN6AzzJXgCbNm0IJPFYwya
 9u+Q==
X-Gm-Message-State: AOJu0YycAU4rwFC/meZhJ5drUwKIji+eU/XntSbNGZJsj5y/5gSkrIhZ
 SMe1OBT3cY33ConLTkkY0SdIIatQvaYA00vXACJMZgksi0TM4eBs+iD5RBVNolB2sWtpqKaEFIB
 5dE6lzppQYQ==
X-Gm-Gg: ASbGncvCtjxDIikHUho/R9x1oi7qkdrUI5ITZ5JwXb+QQ1xzG+UAlyDAEIDsgbSji2H
 wMUH1ftW/boDvXBqbY6e2SFIPEBcyt/LH/v/Kx/v8mGVPffXGFRVy7MFHqPmzNcGhL1nQA++z3g
 gFhEIX+ilQ0S+sncmoMnjCTwN4rsR7mI1BZBMFuDenZmqvvnuWnmp/ecDQfD3OF2EH8sl9XfHA3
 /hKgVw1FQt11JE1zx1M/3IhAd+8CiLWGBxi1gmQKIBJ1jZdPhAObMlgnGRDh/D395dqSGQ/WVb4
 f0e+ogWl/76u0LiR+sTAWjjJQMfgr+BeCN9y0MqdSNX/cY0RtzdwsZV0998GTOUSLCv/u6E+kOs
 bvEsRI7PCnnC/QYOJmN3ULorE7a91GLp0ExKYNja3xIZJ2vd6elf3jmOvQGzxf5/MP6M0zvBfAp
 hwaeleO+sl/4kDW3y+Kh5sp8/B9LJjE3uPt0lAee5Se068vLc1jbeP
X-Google-Smtp-Source: AGHT+IEw8ICsHzGhqPyfFRDjckOb4fszMhxNMthD4wrKNaIF4lN/nUmO46gHAi3MPpIP/y8lsCPUoQ==
X-Received: by 2002:a05:6808:6c8c:b0:450:cfd3:cfa7 with SMTP id
 5614622812f47-450cfd3e927mr4301050b6e.58.1763489075116; 
 Tue, 18 Nov 2025 10:04:35 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450a5f5e1a9sm3327987b6e.12.2025.11.18.10.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Markus Niebel <Markus.Niebel@tq-group.com>
Subject: [PATCH] tqma6: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:33 -0600
Message-ID: <20251118180433.591487-1-trini@konsulko.com>
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

Cc: Markus Niebel <Markus.Niebel@tq-group.com>
---
 include/configs/tqma6.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 329fe3c86ed9..7a360e382178 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -203,7 +203,6 @@
 	"fdt_addr="__stringify(TQMA6_FDT_ADDRESS)"\0"                          \
 	"console=" CONSOLE_DEV "\0"                                            \
 	"cma_size="__stringify(TQMA6_CMA_SIZE)"\0"                             \
-	"fdt_high=0xffffffff\0"                                                \
 	"initrd_high=0xffffffff\0"                                             \
 	"rootfsmode=ro\0"                                                      \
 	"addcma=setenv bootargs ${bootargs} cma=${cma_size}\0"                 \
-- 
2.43.0

