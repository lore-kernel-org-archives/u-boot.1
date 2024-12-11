Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C971AE7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 00:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775E98020B;
	Wed, 11 Dec 2024 01:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LlugVkAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F8C80217; Wed, 11 Dec 2024 01:45:16 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9A380209
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 01:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844ba46e0e6so109007239f.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733877912; x=1734482712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkmjQo7HK40GxP19kvhPug+eGwTkPBoHH5+Vl/rPjbE=;
 b=LlugVkAgCk45nvBE3wL976I3PW+pg8CCvoTq+XALHCHVTtWmuKS9grnijJuPAkGuSP
 hkfM/sflINHLtCGBbmTd7/dmqG7jvn4MKONdsaO0LanGL4UWw2NKz0jnx+TO3QP3H8dj
 UhRZvhr90l0XtDtUSj4bLCaxSrhHeWx3rPfTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733877912; x=1734482712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkmjQo7HK40GxP19kvhPug+eGwTkPBoHH5+Vl/rPjbE=;
 b=ofuRYoed77Mmp7zyIZYQDjixgieJrAoahnrCosF2lStgJkCAqLdyZMwD/N2BirPvUC
 X+/j6nwnBtyaDEqJH2swo86zv5fggor0Ox6JAibXz+2Lrh/rM36V9hMnmpHYbT4ajj4a
 j7YlsMPfNKjCIOyEfPr/YnW3DUQZ83gLawM5u2NApXnYErpSxy6mXlc2ztiAeH6h2VAL
 kF1YFUvzc7wXlO3dRkmSdR85u+QnIVjrLCKiswPjubJipuUwBMJAVX/APGLV/08cbOmP
 nicVfsilhaJxTzJAJ90CT0ExAY5myypKR0nX+3PXP6i/yZNSYPmlr1NRIYO5GdZ87eUt
 BMnA==
X-Gm-Message-State: AOJu0YzRS3dNW4yMiEhuwAjgiMpb42RKlR3iX25vtx95GcE+0AmmP1/F
 7YlCyEOr6VIJFH6qWmMvIUM0yHRfZy1fn+fmC8I10QB6ww21IMsZA9ww8SJZMBrvK3jlUDQX89U
 =
X-Gm-Gg: ASbGncu5qFA3W15JV5YFxHJY2XSwd1OLit3RjGr0hyoyK1CdGDCeIo/24NdWJiZJeAy
 5Uf0Yj2z9w1Wy7Hz+gUm6guTjgjwlx8vc0POq+bflefMnJwKOWdhdghQ0nwAwICRS1IjCBlE9pK
 /gizfiL9jGnzAiuDxdz1PFjv2AHZB5US5i3YoRFU7I5gLNAqgJmM2xv/sxwmf0PcamIrBPooXmT
 HaCpASNA4nf+ZR7VL43jOtM8ouKfs4twa/JcjaQnRlKhlwUP7sp+027FyBRokcl28I//uUEusDt
 tkqzLX2CJd7dKGk=
X-Google-Smtp-Source: AGHT+IGVQjrVbqG+6pNzdcAw9iHRY7otg9vGBVE0ClfphQz2TIjxb9tEJbl+u6hWX4lWeGZlnS3QqQ==
X-Received: by 2002:a05:6e02:1a2d:b0:3a7:e539:c27b with SMTP id
 e9e14a558f8ab-3aa08c888e0mr8449345ab.17.1733877912324; 
 Tue, 10 Dec 2024 16:45:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a9ced6dfafsm17251305ab.54.2024.12.10.16.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 16:45:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
Date: Tue, 10 Dec 2024 17:45:01 -0700
Message-Id: <20241211004503.3775922-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211004503.3775922-1-sjg@chromium.org>
References: <20241211004503.3775922-1-sjg@chromium.org>
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

While we do plan to switch to OF_SEPARATE now it is supported, it seems
worth at least showing how OF_EMBED could be used instead, just for the
record.

So make the Makefile rule conditional on OF_SEPARATE and adjust fdtdec
to avoid a build error when OF_EMBED is used.

Finally. the dtb symbol has a double underscore, so update it to avoid a
build warning.

With future patches, OF_EMBED will no-longer be used with the EFI app,
so it is expected that it will eventually stop working.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI app")
---

 Makefile                       | 2 +-
 include/asm-generic/sections.h | 2 +-
 lib/fdtdec.c                   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d46ff166a00..cbc0feff279 100644
--- a/Makefile
+++ b/Makefile
@@ -1678,7 +1678,7 @@ endif # CONFIG_X86
 
 OBJCOPYFLAGS_u-boot-app.efi := $(OBJCOPYFLAGS_EFI)
 u-boot-app.efi: u-boot dts/dt.dtb FORCE
-	$(call if_changed,embeddtb)
+	$(if $(CONFIG_OF_SEPARATE),$(call if_changed,embeddtb))
 	$(call if_changed,zobjcopy)
 
 u-boot.bin.o: u-boot.bin FORCE
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 4113ea2a866..5b040d0acd0 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -70,7 +70,7 @@ extern char __image_copy_start[], __image_copy_end[];
 extern char __bss_end[];
 extern char __rel_dyn_start[], __rel_dyn_end[];
 extern char _image_binary_end[];
-extern char _dtb[];
+extern char __dtb[];
 
 /*
  * This is the U-Boot entry point - prior to relocation it should be same
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c1eb1c9f825..a5f55cc6223 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1236,7 +1236,7 @@ static void *fdt_find_separate(void)
 		fdt_blob = (ulong *)_image_binary_end;
 	else
 		fdt_blob = (ulong *)__bss_end;
-#elif defined CONFIG_EFI_APP
+#elif defined CONFIG_EFI_APP && defined CONFIG_OF_SEPARATE
 	/* FDT is in a separate section */
 	fdt_blob = (ulong *)__dtb;
 #else
-- 
2.34.1

