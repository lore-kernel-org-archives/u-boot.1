Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA77CF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AA083FDC;
	Wed, 19 Nov 2025 15:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vk6s/lLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A064D83FDA; Wed, 19 Nov 2025 15:55:36 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C878004F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4503ee5c160so3140559b6e.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564133; x=1764168933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ohR3fm+x8RRfXsNaA2Pkd6uZUJiWgOAZe6PqbZ0DwnE=;
 b=Vk6s/lLI0PVbKx/SW/xkQLOT6FvO2VWEQRUDgalv1SuBuTmuYz5j2wBJnayYjR3Tr1
 r9+cwsBcRQnzIQ6PmRr0Y8iyyCKKxy6ulnqyR0ZJzKEnx5cPn42sUPq6NwzmJGxR7k/P
 J0xHRuP4Llrqi8AVEeYUoh2zOw6jqdlIwc+EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564133; x=1764168933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohR3fm+x8RRfXsNaA2Pkd6uZUJiWgOAZe6PqbZ0DwnE=;
 b=kK/hmd6NSh7JRelYT/VaG0zZgXNq4ApWHqy2sktwtJ9yaMYXbrNh2Io53VCZ4IVQCc
 qu8VS+sbdiio2RrEGqQjk5+C/XmcFOfi3kZiwWPPIb+G7clT8rmSIMsZe6fUsMKdYvcn
 S93+V/TwVCLG0G6VnTUCAHuFJkNrC+gFYetQ2roJpSGg1yRI6Y1RMNqBKy18sLs4h3T6
 rFxgDpZtbRBBaP3DR6r/AqJVCnrUHjvJiypRq6sw5InouoRY4qP2XMUzzSPB3NnBNDCn
 6u+l+onRuACxCqQNORJ22E3NQHXsmo8HHi0Y81+atvJS1tqPe0t1MJQFcL2aSeNRA7OQ
 fx6Q==
X-Gm-Message-State: AOJu0Yx3wM19Hq2lzwXWgJ8Wx1RHOhqZyh568wkEkO+4h3iOob8XzEU9
 xTL+zSosJBEm2XesIsKdBkTkk4P2Eh5vHiOd4FAZMUwP4BBeGdVoJJZ9xAJyL9cut4xBcC3EDSL
 o3zICG4+R3Q==
X-Gm-Gg: ASbGncuPNWE0ScpZXGnDyamyL5O/cfDbYr9aYhheuOfmA0c5g6r27ecdjoWoG0ItNB9
 BhYk7oYG9NUdQpZNkSDIFrkoS5HoEcBsKIbhfemBejI2w66JLPfGe8+EcT6T0Cj1f52Z2bP49b6
 JL/0zuWLw8cpurqU5llU/hP0foGCKbPBe3VDY5liphLVEN5rJTMyFqpstvJJHlfn17qMZ07qI/i
 z0U7+SHMPqqowt9EEQj0hLwVJnV9z3BaSNetGDKuEfE6WHKGDp3AhnXfmMhgsyxtBgl1+hol1J6
 QluC4X189b0nmySJ9vxKL4f0/oyodgE4cBq74ptZ8Wh36TpFlFmgRVYOkmf0q8MzicXgrrc5sxy
 4vCbsUBafVImWHRSiZZdQdlrOxJhAbBoPnjemM95xU39ECs+Q+vc1LfJUPAMml8YTLQ6OhBIZD3
 ryTT8cvTze7v3JzFN+1rptr9pagYHq/IZDbaBhIkEPIkZ1i0GLtXkVMlmf71GDYkt3op2FN0XBX
 A==
X-Google-Smtp-Source: AGHT+IFngq2jkml2QmalVD4PZL8KRaIVHHLgommzh5O4rjP2Z4cbvA3sHKT2fPIjVt7G+Zg6E0Bkuw==
X-Received: by 2002:a05:6808:2e48:b0:450:d3af:ba4c with SMTP id
 5614622812f47-450d3afbdf2mr4214930b6e.52.1763564133351; 
 Wed, 19 Nov 2025 06:55:33 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6df248sm6060673b6e.22.2025.11.19.06.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH] omap3_evm: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:32 -0600
Message-ID: <20251119145532.843346-1-trini@konsulko.com>
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

Cc: "Derald D. Woods" <woods.technical@gmail.com>

---
 include/configs/omap3_evm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/omap3_evm.h b/include/configs/omap3_evm.h
index 2cb2e52ad251..788e1d1d5e72 100644
--- a/include/configs/omap3_evm.h
+++ b/include/configs/omap3_evm.h
@@ -74,7 +74,6 @@
 	DEFAULT_MMC_TI_ARGS \
 	DEFAULT_FIT_TI_ARGS \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"fdt_high=0xffffffff\0" \
 	"console=ttyO0,115200n8\0" \
 	"bootdir=/boot\0" \
 	"bootenv=uEnv.txt\0" \
-- 
2.43.0

