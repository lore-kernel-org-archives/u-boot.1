Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA36C02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B4580758;
	Thu, 16 Jan 2025 12:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Kl/gTxsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB7E80758; Thu, 16 Jan 2025 12:39:34 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B1280726
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A30E93F662
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737027558;
 bh=9HTKI3j0/W20feFUsgT7A1BiaYYAQ1bwpkmXrY1y2FE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Kl/gTxsUDSppvMK2no0IoDiGULovnGbi0syf5hYKaT28PobD8BasnmgcOAPr9DNih
 zx+2Symd+h+V2Plv1bYm0FPgSGwAQ7ZeYREKE3GLQM2Q0XuQZnYWWqO1QBuwC8oB/y
 byyTPbQdBavYkNy1t6RYts80lxDoA8JgYj3cfmzgOyBmqhmQ+DfPoxgPwsjJD8L+ix
 OskdBuH06UDfBuLoqq6Blnx93XL5/VEHEOeXlnQfOKYBHreP3TG6M3MoeJnOxreRfn
 +9d44cIY+GeWtugdyNRE+FGVJmtHz6P8549QJAYIrMXZR5utynJ8Y3Pa9nKdEUUkQ/
 vVhINjUUDAgGg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38bee05f396so302179f8f.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 03:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737027557; x=1737632357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HTKI3j0/W20feFUsgT7A1BiaYYAQ1bwpkmXrY1y2FE=;
 b=Z9ZG9e7eH5dGi92rpIF+qJ1uiny9KYDcjgJ6O4dudC6gPpqhXV3f8JAk7+eCyc6pxD
 SA7GFTlk8qrYk9RQYYWTrLaH+LGZteVFL2hvnGPRtVsES8tX3NKgn+q0HUVtQEcfuYUW
 Bzn+6SfJJDJgSSCTZp7V56xpim7eNYYc+wf04Qjystqnx/jjkEKjhBWddbCdQZ8V/XfC
 XnZR8gFfbgAWmFxi6a9JjyA07Ua8DXRZKI4LhvWJKEXQFKch+r5Z+zHn5zKw8DHGL+7b
 X2JVO6+H17m7qluIAs30k93TXI9C8fdRU9tpB4uiZwqhsVZfYH0m5l/Vw1R8OUaPAIWA
 QF8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS+tTBAiPqA0ZBAr0zVVkBwLtZvJgVAmfcfnDw40QBZKVoy1O7QBqxK4IXJAmtRaHttdMJ0gk=@lists.denx.de
X-Gm-Message-State: AOJu0YxUBE0jEcAq6gzRvcj+QDFD49LQ7fajj7ttF7LBaPQL5Z9ObfVc
 GIS+1IZiP5wegDeFrJNnOL12bUpm3vBqpv4cJXryNgHwPNuxXjI11aFp4jjWGd+DwHw9zTYsFIw
 ShE86f5dnBEHjcySa0CJkfY0ajareYV7uw1awxo9uRYYIz3SzeNruT5HYwf6l5ODJYKo=
X-Gm-Gg: ASbGncu0HGXo0MSXtGROFwdzLISxgQaT3JWvX0l7gLcIOKJu0ngSo3c5xd+gZrYaGih
 6LNWiTM2TIZQ5Xx9/Knbx/mMxT0vKnjHhC2MmoMNWeAZ4Cz+T+YnOg4EYhWGxEP6CJzsfllNGcw
 mHAYmOeFs+AUOkoww9evDj+CbM0gsWtG+yE3vcdfiN3YN9HgQcpriXo/vQRPBbLL4D87Ym4P5DW
 Z0//R6YuOu1U6etin+Mw1nJrl+sKDbeb36Ye5DWDdJy718a/4bylcy5an4ZCkC6tc+EJ8z25XLH
 B7U85PqAQ6XV7A==
X-Received: by 2002:a5d:5f55:0:b0:38b:e22e:aee0 with SMTP id
 ffacd0b85a97d-38bec5075ddmr2331843f8f.23.1737027557305; 
 Thu, 16 Jan 2025 03:39:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGspij2uLp9SLwmaDEuIsr2xK3ePdKIc+bElvgQJ/DXVn0zgD2QItck2iJLp0rghVgTM7AzoA==
X-Received: by 2002:a5d:5f55:0:b0:38b:e22e:aee0 with SMTP id
 ffacd0b85a97d-38bec5075ddmr2331810f8f.23.1737027556954; 
 Thu, 16 Jan 2025 03:39:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm20606320f8f.39.2025.01.16.03.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:39:16 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/5] efi_loader: Fix section alignment on EFI binaries
Date: Thu, 16 Jan 2025 12:39:05 +0100
Message-ID: <20250116113909.113950-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
References: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

When creating EFI binaries, the alignment of the text section isn't
correctly factored in. As a result trying to load signed EFI binaries
throws an error with:

efi_image_region_add() efi_image_region_add: new region already part of another
Image not authenticated

Running the binary through sbverify has a similar warning
sbverify ./lib/efi_loader/helloworld.efi
warning: gap in section table:
    .text   : 0x00001000 - 0x00001c00,
    .data   : 0x00002000 - 0x00002200,
gaps in the section table may result in different checksums
warning: data remaining[7680 vs 12720]: gaps between PE/COFF sections?
.....

If we include the alignment in the text section, the signed binary boots
fine, and the relevant sbverify warning goes away
sbverify ./lib/efi_loader/helloworld.efi
warning: data remaining[8704 vs 12720]: gaps between PE/COFF sections?
.....

We should look into the remaining warning at some point as well
regarding the gaps between PE/COFF sections.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 arch/arm/lib/elf_aarch64_efi.lds | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index 5dd98091698..e382254a6cf 100644
--- a/arch/arm/lib/elf_aarch64_efi.lds
+++ b/arch/arm/lib/elf_aarch64_efi.lds
@@ -32,9 +32,9 @@ SECTIONS
 	.rela.plt : { *(.rela.plt) }
 	.rela.got : { *(.rela.got) }
 	.rela.data : { *(.rela.data) *(.rela.data*) }
+	. = ALIGN(4096);
 	_etext = .;
 	_text_size = . - _text;
-	. = ALIGN(4096);
 	.data : {
 		_data = .;
 		*(.sdata)
-- 
2.47.1

