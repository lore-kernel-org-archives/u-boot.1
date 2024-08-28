Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A62C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B837288B31;
	Wed, 28 Aug 2024 03:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZazlyDdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A9288B6C; Wed, 28 Aug 2024 03:45:59 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE2B88B8F
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-829e856a14eso98085839f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809555; x=1725414355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3tmL5SAk33s5ffDuko3N2U4xqpTpNWxbpWnkka4C7Y=;
 b=ZazlyDdM8EnKq6OOnuOzvBWN8g0k8gjr6N6H6midoGNIAh4BU4hgm+Agwcb6UCG+Eb
 a3mH2EfGCJndOikk/OA3ja0L64ETZAYfZVrulgpB/TaOCoUL+62oN6N3KziWXW9iKiP3
 J+onRkHF5T1sST0kVwcbK2l9qqPtR0g7hg4VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809555; x=1725414355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3tmL5SAk33s5ffDuko3N2U4xqpTpNWxbpWnkka4C7Y=;
 b=vRCeopN6sULldHSP4dnUJUhBg9/YSRqzPFhzwPGGtGTW3/eLlmaDLv+YBSCU4D78vz
 aJHRuMbw0ydbNFFVTWtszwVSojiytQJdS4OIRcIwA1G7zuqDg0k1HHpjpo6gUTHougQ2
 lnUbDx+OqWmFYk+1yOAF7We22X4rVJ4awkuLLTsAM3cyIqg52PeYkruSiZIN/4O2BtsU
 iTRbtZtT2KKxlgBacaTm9tnH9brf57v7/+zU1ih0Yk1F7ztACSN1cy41XQsNOoJgezBw
 JXvuOhOwL4ZecRvzK2q4q2G0r3daOcAscKUnzL0BX26bSZmtQvUVs6zFOZq3d4xu9Bzf
 SEEw==
X-Gm-Message-State: AOJu0YwUqfuyj2T1sfqqOaSFliTvNABE0Ilsszp/UZlX3awL3IOisgFp
 0u5AVkt814Phb6ncynWUp0uUOZdHXAvVEU90k1KKO7NhfWlK2N6UV4Eq1v6R87pAtqzFxZuY/ss
 =
X-Google-Smtp-Source: AGHT+IHIOc0evuVlpGvMLA+W80bHpMpZBicLCZUQK/LAEIoXQVyckx2qA/wQ1ExFJUDCdVI+ra/XSQ==
X-Received: by 2002:a05:6e02:1cac:b0:375:e04f:55ac with SMTP id
 e9e14a558f8ab-39e3c98c830mr186230535ab.16.1724809555206; 
 Tue, 27 Aug 2024 18:45:55 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/18] armv8: Support not having separate BSS
Date: Tue, 27 Aug 2024 19:45:28 -0600
Message-Id: <20240828014538.3322013-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

Separate BSS is current mandatory on armv8 but this is not useful for
early boot phases. Add support for the combined BSS.

Use an #ifdef to avoid using CONFIG_SPL_BSS_START_ADDR which is not
valid in this case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/u-boot-spl.lds | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index 215cedd69a8..fed69644b55 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -13,8 +13,10 @@
 
 MEMORY { .sram : ORIGIN = IMAGE_TEXT_BASE,
 		LENGTH = IMAGE_MAX_SIZE }
+#ifdef CONFIG_SPL_SEPARATE_BSS
 MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
 		LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
+#endif
 
 OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
 OUTPUT_ARCH(aarch64)
@@ -56,12 +58,22 @@ SECTIONS
 	_end = .;
 	_image_binary_end = .;
 
+#ifdef CONFIG_SPL_SEPARATE_BSS
 	.bss : {
 		__bss_start = .;
 		*(.bss*)
 		. = ALIGN(8);
 		__bss_end = .;
 	} >.sdram
+#else
+	.bss (NOLOAD) : {
+		__bss_start = .;
+		*(.bss*)
+		 . = ALIGN(8);
+		__bss_end = .;
+	} >.sram
+#endif
+	__bss_size = __bss_end - __bss_start;
 
 	/DISCARD/ : { *(.rela*) }
 	/DISCARD/ : { *(.dynsym) }
-- 
2.34.1

