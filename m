Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DADE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC77F8020D;
	Tue, 10 Dec 2024 17:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N8srTBCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9988020E; Tue, 10 Dec 2024 17:02:05 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5A28020B
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa692211331so361431166b.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846522; x=1734451322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XnFJgCMF2ztKHQ2ghXIErNwhvhxM9H8v7nzAPdWGnHo=;
 b=N8srTBCVQLAYWE1L27Gy+D7dh7VKxFBg1yUYKAtuf4yPUSMMBbQdt3uPOImIrFIJiA
 W4+lzb9nQm6XXyR2Q33n51Ibah6zU3I9g13LIpzUBiUC55A5vAJRAbyDsQYx5WZYMyUW
 zPgh/CLqWta+s6VQPqNEC9KRqYkuhbIqAaESKDSyvSsTS+61oMAt5uz77Haux4N2JAXU
 SAThiqWekahbX2J33pBauKPNmdfUFKCRG49Mb9qDMOdeKWntdKvmdMKPTRZrNiVbL8fT
 VjvZhrYs0ywtwdCyW6L6PrF8azCyyxbpeOdlJzOgojuEYvEcihTsV1rGYXITaOvWL0Cc
 JHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846522; x=1734451322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XnFJgCMF2ztKHQ2ghXIErNwhvhxM9H8v7nzAPdWGnHo=;
 b=fsHa6Ck1Gn3MdEaD0OgOch16HZ8Hzactcz8lWfNPQ2FX/jk6KpQIF3U7u/15Oj2bih
 6wpoIC1E0Ud5teIwyehGEfnlgdGWm/6521AAVvsd5xQdM4NhG/uyX8d9Fhxus1VJeId6
 KuzCcS6f0LlZOVru6dJ2rixv2VffTJtUPjocZB15BfC9XqXCuYKskfYCUoLKz8YzGos0
 TR6QP3qcuMbNLhaL4OLpxJtsIoIjSJ/6HNrVu3BNWq9Zf2xyBcloM4xkCuNWaktVoEQ8
 Nen44yQKv9SJBvTEvUWG029uOoHuwGKaWWa8lwIlCOgtraqVdIJ5P077J28sJk72C7Zk
 CfGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/i53Vm7Zxh/OmdYpqENAAf2FyHcKE/toZSxmXaPywlWVa7T7STCFx2TClY9/J9HNMrJ3nydM=@lists.denx.de
X-Gm-Message-State: AOJu0YxFm8C+XBXW070JOwCBT0nHfnQTpH1LTBuCv6hPCiPbv9H4HQhz
 hpBDiUryl3e3wZ342fzq+IUOwm4BtiOT4oslC9SHn4RYwujC6n8bVOhScHRsgTw=
X-Gm-Gg: ASbGncuKy0OCVeGdqt9JRoAQWR7FZIkgB3tBAWlWdW8hnWSzx195q0XClvIjxG/dplP
 ZO4+zR0Y6OcUQg4mzjumND0F2WtFVPhXobDvioAF+KDaH94c9lLiKx3ryh6nhIlwySGUnxDgtBr
 hpBZ/yEGA0nvN18DTwV7LwB7wvPAQAb7e/t+xDP9vxBdDeJ2NtV/w+/dqdsfspjL/Lqmkah3mMn
 RdzV5ahVbPEAPeV9GyjFEFNU8FroPUk5W6FXy3c9whNkKBxALf2oCK70j0QX4GjUhi1vrU7pQF4
 TI+8/iNgguaJh1kRC+d7oLISTAggoHc=
X-Google-Smtp-Source: AGHT+IFCJmyv+tce7Y9al6BaKF3VtpPs1dehQLnywCGwoY7UH3szeA45O845WkB6PnVp/rZ1C515FQ==
X-Received: by 2002:a17:907:7156:b0:aa6:88be:729d with SMTP id
 a640c23a62f3a-aa6a01c50a9mr331273366b.21.1733846521871; 
 Tue, 10 Dec 2024 08:02:01 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6651c01c5sm534771466b.23.2024.12.10.08.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:02:01 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Fix section alignment on EFI binaries
Date: Tue, 10 Dec 2024 18:01:49 +0200
Message-ID: <20241210160150.244773-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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
---
 arch/arm/lib/elf_aarch64_efi.lds | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index 5dd98091698c..e382254a6cf5 100644
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
2.45.2

