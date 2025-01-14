Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93D4C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 10:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F081A806D4;
	Tue, 14 Jan 2025 11:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h3kWOYph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CAA38069A; Tue, 14 Jan 2025 11:30:08 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF7580658
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D39CB3F869
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736850604;
 bh=NGxOCAteRU1OcEooFNp5fvNfrKobBQg6Y+saaDvF7/k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=h3kWOYphNC1q9xtflfKcFrh1tSf46GNTafoiQsph07Rti9E1v2eqviuti9FxkbL3S
 a81dFsp98z+90dr5Ruv6Ruwg/Olz22Vo9C+D/pw+eXgkP6jiyv7VCFkdexhK647XWd
 4BkrwQw5uyFrVgZOMVoxXW2iVAy7ufWy6TF/9DV9OMBMum+Nwzh66zvyHu4LPBG118
 rdyE0rpzJ/y7ouakPCNRko4vPgdtfu3bsI3Ni7zKUs7HOnKa3IdFJd/TaUoUAviIFh
 3wg6gy5zDkxpTnO6udrc3LL1rv4sHqgExl+hhnbXBOKS5fdDx9rKBc9L1NQjEvBWbT
 Yi6sp8EcDFq3Q==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so36368215e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736850604; x=1737455404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGxOCAteRU1OcEooFNp5fvNfrKobBQg6Y+saaDvF7/k=;
 b=mu51uSm41TjfhA1I3kzi+JNZY2leqmHdKJKAH+xsgbg5JbRUyrKT6NR+HxE63X2y7V
 IWF7mT0Bmf4//h3ksC+7I/GZKh0NvBPzbX3xxZbwnWzGWCf82Z22OFOpo1nxp8euxOmf
 iIl1kU1yFwGWXA738/eRsiDM1CJX7jIXlU7wmoVQywWssXZw8wR494FXkxGRQKi0TfKr
 Ze2kQcpArVc7VVGaxjJ0fWrcyOFBqIau5Ta8tmys4CH8Zad1FvtQlPoCR1VaeCu8MD2q
 eH9N5jdTmGVfdhjsO/CwEUeXpDQpRfshBs5a3/yqnraUzyyYi18YfvroHGlBUb56+l96
 0ikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+qti1RPkEBkOiBa7husqqalCt4OnVEqAKGt5+lYInoJcipYMdHDYdI51JkKY1ZP1cXMYe6pw=@lists.denx.de
X-Gm-Message-State: AOJu0YzgUbtc+U7+8t/TLLnSnGta7t6YWroA12048w9bXTcVzWKtFt5M
 eOlWt5zI1XgucfHY3ZNAn70TVGiSrBCaNFghci05jvg+lpR5cCqGKVgoN4/qiBGwAtuWnV2vFyu
 c1pCjgZiotOPCpKbbhH2BOTEdZczBMzGqkL1137twCi7f47UMNp+eb/ZCbBvhlHJe23E=
X-Gm-Gg: ASbGncsoRkzUicmVSZ/0xJOj9LASGbXBkf0BKlBpUEZuPsSg7awoFxgL4mO5nc/vDSk
 0SrkEFUHsE0BzNNaxaLUGq8fWb4JGuSjSlKZl0A+1eKGFbuc4C5VYKF2bwuYoMCWi/KFS/Dp7K4
 K22BXKeafieJY5AqWMoWgek/9iWsPv11GX+Lp4S1So01ZBouP5CRuCYfDrP8gZR31clM6PBOydj
 V+9D2nx1ubPYfQFnkXQgOX08ixZpXzn9i+Lztdwz/W9GWcMXAlXXfyI1Olh1WZURG9lCZ2cbq9F
 JOPLDygobrvGJqc=
X-Received: by 2002:a05:600c:3554:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-436e270708fmr188569825e9.24.1736850604188; 
 Tue, 14 Jan 2025 02:30:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGCoa23OPYS2LNmf8Sf4IJdtgZL7h8l3Ryq0bUhRF1dvvcuylbqy4yvVKHRPX7G9TMsqTcMA==
X-Received: by 2002:a05:600c:3554:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-436e270708fmr188569555e9.24.1736850603819; 
 Tue, 14 Jan 2025 02:30:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:642a:6b6a:606c:5383:21d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8826sm169996455e9.11.2025.01.14.02.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:30:03 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] efi_loader: Fix section alignment on EFI binaries
Date: Tue, 14 Jan 2025 11:29:50 +0100
Message-ID: <20250114102953.64381-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
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

efi_image_region_add() efi_image_region_add: new region already part of
another Image not authenticated

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

