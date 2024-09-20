Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A24FCF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC262893E3;
	Fri, 20 Sep 2024 09:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g/BDjMc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EDB893E8; Fri, 20 Sep 2024 09:25:19 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803F0893E1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso14235385e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817110; x=1727421910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OwixvFz10aZ8S3Ea9+iNARHXLqM7Ve08vWOKPqm+9o=;
 b=g/BDjMc88M1C5R3gOHcdPHSZophT/lBgGmYocIL0VyvNAhT3vwJTRR60XQgjUV5fBt
 5bJ88Q6nMiwCvlu0aa+NFIxWJQBhyShAKkAYL4sASzmBfGxnhHtxibikTBMluf/8npd3
 Agq2yOp02Ak6Cpiwn34+hy7wAQm1QLoJDDSRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817110; x=1727421910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OwixvFz10aZ8S3Ea9+iNARHXLqM7Ve08vWOKPqm+9o=;
 b=RA+mQH7copZ0SUGJc9+PHrLGJkp59eu5IwrGPca7OP1pm4WaBfN0BMr2PJCYvr3Bnh
 3xAr6nlBaM9LK2lYDd5ED/1U52vd14flTKLJqhFl4kc+JA8jcfbuBIHe1wb7PamuWxe2
 67sgeuqxSrZtqb2B2aLnUOcMxng9s6ZcMPfTUFhMVcsLGPjPDVGTg8/6I+/MFPTKq205
 wIMGXPfs1dD2ObOhuTbk2huLG0bEsscs3/acCKyuSaaEzAESeqX3KgnfYWSUHHrAdgCG
 8jCk63cmx/ZAI5/dNGcvGz4Ye+QrzPv3tqYhZbFCRPBVw+vUKltEvssLDsJds76hhxvU
 PrFA==
X-Gm-Message-State: AOJu0YyAC0mYw6hgihGlqp0312WmRp8kNlH64YFGcGU9Pl6LrkuQFaiV
 cIasSLwuKVgqUdaK3Rj1PKCEKF5UzAJINnLT8n97smHOcMYYbGFP69W1IYkBVa783u8K1HRXXYe
 eW1sL
X-Google-Smtp-Source: AGHT+IGMStWQc6w7dVjiFrGlLeiWPMRnm9Ike/ZhBunBcil/zuJ1g+VshNUH4d5nW+I8lp3FwoZU3g==
X-Received: by 2002:a05:600c:35ce:b0:42c:bfd6:9d4d with SMTP id
 5b1f17b1804b1-42e7abe03cdmr12529375e9.2.1726817109606; 
 Fri, 20 Sep 2024 00:25:09 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/18] armv8: Support not having separate BSS
Date: Fri, 20 Sep 2024 09:24:33 +0200
Message-ID: <20240920072444.134997-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0

