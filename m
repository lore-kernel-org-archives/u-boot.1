Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C1CCD98E4
	for <u-boot@archiver.kernel.org>; Sat, 20 Jun 2026 16:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51AAF84873;
	Sat, 20 Jun 2026 18:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFj4/WNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79955848EB; Sat, 20 Jun 2026 17:07:32 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E98F84873
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 17:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qstrydom0@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4923fb1f095so17606615e9.1
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781968050; x=1782572850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVnh/OTfagkBJM+4vJ/aZxmAh70/tvsHk/MlYaO7aSc=;
 b=kFj4/WNw6sz6rxxYEJHFMI8Any9ZtE7wPQAwrjZ1MMB3Jh2Lm2WPvL45CK2hXIlZhh
 9EVRucqtIJelGRMIRHA7cIKr+JXmVo8QgtZ8w5k8LLgTlYglqgFMnp3yc9begbCalRGu
 YHiwcHo0CAg5wlTe6eva4F11k/90R+5yL2uAVSClhlIyZ6F9vyjc0I++KwoLrft+PWRo
 ZG1A7jEs0+UYXUlQ2CQmd4YmKN54d1FmEUyk52UEXBx9m9BQnRPmJlxkSY7QPt0LT/aK
 Z5KBGiujeA3s2yfBZXRTn+I1T6zZ8Tb7LpEU0YNaCR5sPvMq23evAiid1r/x8hKEJ2sG
 n41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781968050; x=1782572850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVnh/OTfagkBJM+4vJ/aZxmAh70/tvsHk/MlYaO7aSc=;
 b=DrwHFrvuwOAdInNJrKo4fgJ8BLvhB7uub8DiEeNgYIiOo+/l43GVDKftEgKyhdcc38
 n5QEiZ3uPT/W9di95G/Wi/JmFnsRTpXsugdkyB5eUtMhrImiMIhipXL9z5Y/1e41HJvx
 mmTfeOMNaDPyobeYcS7AOTe9UTHBEdyPpNCrUpiblS9oEQJZ2jqdFBJXxbES6RvMPeLV
 2/GPGirlj7ZYxnP/I37lAZJqHG++mICxGziF4QmAqXT/dBMz/YgLbRVBnDoaaDei0WVV
 SAIuQxboBIORjVU+WkmKykB6V+jxw743oAeP12xWTZ7GqFSuxJtdWlrT1V4uGYgiV6mB
 IDJA==
X-Gm-Message-State: AOJu0YywFOi7tKjm6H2szCFYPLTItjQ3oZ7dgTpmjXAW9e0DMyuSZdo9
 2iLNgyhIHcz1i2ESfyrLRXkOm9nayACdMGTbeZRrt9pNSFOgJuxBy6XUlE5df7SQ
X-Gm-Gg: AfdE7cnlmVf4yFqaJsRH1H4s8QXK9INe1GWOXeDzCdxe83bRuNLQOhO6qPuHw0nLAS0
 +EYKjyvQVUExi7EK/GV7SB899Xq8QDQPhHa4AuyRj3FFjzk9ljuJwJUqHRhXZRIanrH4PLrcV7O
 azMUdqynDCWzc5L8agQqUZV7jwR2g+xUKXkA+nF2M4NWIZIQiOB0CELpqso+0JODA5HD9I0z1uS
 TZorYqUWkHcK16EP1bmuy+wd2+vyOC1g0FQ2Y66U/P/LjeI+yYYdAz83b0wfVMZgeTdASUiStWm
 UGyQdKGGhq47xFBRsAC/weD47h7ss/MqCJW3yxsLcLeLuXD1TnWbzOf6MzsYg0B96qLHhUkijqv
 7what/PleXl8DrIdzv64I8FY18Pvrs3H429LqEZJysa8LHZUr4Z4XHwbQnlxndJWAZ0NvKB1qcM
 2vooXDTp0wUEZU
X-Received: by 2002:a05:600c:8189:b0:490:d079:2919 with SMTP id
 5b1f17b1804b1-4924233ef64mr95903435e9.14.1781968049862; 
 Sat, 20 Jun 2026 08:07:29 -0700 (PDT)
Received: from home.powerhub ([2a0a:ef40:30:7801:1a54:b103:341:c23])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923392dsm115301805e9.2.2026.06.20.08.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 08:07:29 -0700 (PDT)
From: Quentin Strydom <qstrydom0@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 james.hilliard1@gmail.com, malysagreg@gmail.com, tien.fong.chee@altera.com,
 sughosh.ganu@arm.com, philip.molloy@analog.com, qstrydom0@gmail.com
Subject: [PATCH v2] arm: aspeed: Fix AST2600 SPL external DTB alignment
Date: Sat, 20 Jun 2026 16:07:24 +0100
Message-ID: <20260620150724.126315-1-qstrydom0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619200419.GW382693@bill-the-cat>
References: <20260619200419.GW382693@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jun 2026 18:19:37 +0200
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

For AST2600 SPL with CONFIG_SPL_SEPARATE_BSS=y and
CONFIG_OF_SEPARATE=y, fdt_find_separate() expects the appended control
DTB at _image_binary_end.

The AST2600 SPL linker script aligned _image_binary_end via the
.binman_sym_table section. In builds where that section has no emitted
contents, objcopy -O binary does not include the alignment bytes in
spl/u-boot-spl-nodtb.bin. This causes the nodtb binary to end before
_image_binary_end, so the appended DTB is placed too early.

On evb-ast2600 this produced:

  sizeof(spl/u-boot-spl-nodtb.bin) = 0xc92c
  _image_binary_end                = 0xc930

SPL then looked four bytes past the FDT header and failed with:

  Missing DTB
  No serial driver found

Move the 8-byte alignment into the preceding emitted __u_boot_list
section so the objcopy output and _image_binary_end agree.

Signed-off-by: Quentin Strydom <qstrydom0@gmail.com>
---


Changes in v2:
- Replace the Makefile padding change with an AST2600 SPL linker script
  fix.
- Move the 8-byte alignment into the emitted __u_boot_list section so
  spl/u-boot-spl-nodtb.bin and _image_binary_end agree.
- This was reproduced and tested with QEMU ast2600-evb, not physical
  hardware.


 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
index 303ace2f61c..894eda1db77 100644
--- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
+++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
@@ -42,6 +42,7 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} > .nor
 
 	. = ALIGN(4);
@@ -49,7 +50,6 @@ SECTIONS
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
-		. = ALIGN(8);
 	} > .nor
 
 	/*
-- 
2.43.0

