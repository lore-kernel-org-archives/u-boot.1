Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EC1C5AE59
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E659382CC9;
	Sat, 31 May 2025 10:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VcGYrYOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F230482D17; Sat, 31 May 2025 10:45:17 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1333C82C15
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a375d758a0so2314158f8f.0
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681115; x=1749285915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTyyT1/gq7Vm00i/X1rgzvZvZDeRTupa5lCBEkr92hI=;
 b=VcGYrYOlJ36degfuLmoDRuGIgZ5ogjiRIYTA338NM+TZutC/JXsSvzVcrCq+pNGZCD
 zar8YRsSIvXUQeZxfIk0NPwTpj3Xm0vmHE6f25oih7cBdVRoAlEPhdHFDgrCY89bQxno
 a+nGEBk7jAFSPKIMO+iQ1zQE9TbNL8P4txdX+QJsa1SOfao6nM2v5k8K+y/lzQzsjTw8
 YPeWYUmdERjOhQPnDqeSwYL5ZaouW5DbrSsJVM8Lw5Zpiksl1DLsuzzBh64BecBbyNIk
 YPl01MimSU3a4AESiLAhi6G30zsAgI4o3JEX8yy/y29SatdEYmgxLtjG42i3ci+H3bNL
 9yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681115; x=1749285915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTyyT1/gq7Vm00i/X1rgzvZvZDeRTupa5lCBEkr92hI=;
 b=gHTfr+OC4fO9TRFWnIlk/HniGp9dTetAs7BmEqE8X5maHuE0OZE8b9JrovIWDFjYKW
 Bf60kNKMESm0a9baZEWBeco0UYujpGdXbtoszqE+0ObBg/qbr6JYZatLWHE/xDnoqZHl
 ouy3TaaNgtiVnhJ8Q5vkBCKzNtThBsQcZcD/qlw0bzGAWZBV6acl0FoFbhUrhhL6udjh
 SKMImkf3IfyzsVrIO5LUcRJFT94bCDUOm5kbCJHvloRsTh7Rusw+dHZz6iGVWvHosnZ9
 hl3oyi4JyIoMUqBTsDXn8PEyvZ49m9Y+q85dTpTm/mzPuiZaMaGpDH9x26d+fV8jzSfO
 tQiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8+QzyjayAKo1nUZbxUOX55wHTpwT27hmrt5TAdSJdcJJJrQdrJqIsF9rvj/oLJ6TuSLh/Pfc=@lists.denx.de
X-Gm-Message-State: AOJu0YzZmXVdt7XqkAyy/1C0hZSjylkpSxG34fVs9Qagk30oyc/lhGHI
 kfvRsmfaap9NZTkyILmwQ9KgprVh5V18Il6cjG2N8m1mhteeroS5K2kPoNmSjqlTuWQ=
X-Gm-Gg: ASbGncuLGQ1YLjuKPCzpdB8bWpduTJJM2Wt4g0brES9MHK5/pK8XNxP0CT1Zp/7q+74
 ShnhfqQkv5AY5IZloZ3CtBmjh/8/Lrq59TAjjkiHrkqdaJ/h0xWDbQVaoSo/RS00NiSdJnWdvTb
 vtuoO+DxAR8P+X+GqeeH8bie1oNnOYFJroQXSnm6Nnk6oRm4cS9C/uzg8ChyJc51xxww+O22DmC
 pc5nC2F7Vaze/sXIzWVlYMRPBv+q3GsLmTEQyGH6hHqHAQqH5d73TkOkL6w2M3CPJbmIVKtynWz
 biTEWQgW9iySg8g1f2Ra6SoyiTUAJUCjD3d+uNcGcKh2b9Drmt9tvCC1VEFLc6ODiBO5LOZ0oXc
 BKk3oxEJe+G5GhTY5BEA65pqNh1Z74NSongsTX1Vo
X-Google-Smtp-Source: AGHT+IEgYiJ2Zvz0WUZIH99tfjT0VtvQ98g9iJhxR8B1qvzPOX9FHpQaV2WhdoHTRcFhwbwgHflGwg==
X-Received: by 2002:a05:6000:40ca:b0:3a4:d8f2:d9d with SMTP id
 ffacd0b85a97d-3a4fe3987efmr1021369f8f.38.1748681115486; 
 Sat, 31 May 2025 01:45:15 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:15 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 11/13] kbuild: mark prepare0 as PHONY to fix external module
 build
Date: Sat, 31 May 2025 11:44:39 +0300
Message-ID: <20250531084449.4125187-11-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit e00d88804814 ("kbuild: mark prepare0 as PHONY to fix external module build")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 24d6cd8fd7aa..03f88e736a61 100644
--- a/Makefile
+++ b/Makefile
@@ -1739,6 +1739,7 @@ u-boot.elf: u-boot.bin u-boot-elf.lds
 u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
 	$(call if_changed_dep,cpp_lds)
 
+PHONY += prepare0
 # MediaTek's ARM-based u-boot needs a header to contains its load address
 # which is parsed by the BootROM.
 # If the SPL build is enabled, the header will be added to the spl binary,
@@ -1950,7 +1951,7 @@ include/config/uboot.release: include/config/auto.conf FORCE
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare3
+PHONY += prepare archprepare prepare1 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
-- 
2.49.0

