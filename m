Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624D6C021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD43C80FC8;
	Mon, 24 Feb 2025 06:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G5ZsxST9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7347D80F88; Mon, 24 Feb 2025 06:56:18 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C905680FDE
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso114507805ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376574; x=1740981374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HthBEodV7YS2fKwyudsDePzDyTAobsouKTigKLnQiE=;
 b=G5ZsxST9AVYWn1BJJY9HrelbghZ8UvvQw05jPuXlKMwCNnh9XrUuDPYSRgQSIkEDP/
 gpyyFNBk/BsCul4mME0F2GQdwKNattasLVWJN1Byrt9mYFjc1Fj7mPx/rDtk6WGnVqip
 iLu6ei7lLXzHcvlpAB92NhvW6lFX8rzP5fx6JyAp2WmV9e5fs2BEf/eN39jGkAxbJGj/
 i/KKrOulkZ7Nfxw9RZoYbWQwAQ/2x3cqxvs5hiy/zeuQBd92y2hTcNLpI8slitwiqHQ1
 XDPkfMl/x4JiDzUpbT/2tG3/3xKya4rGK4W7B8tuzEvJJcYGxTq+t3XXxVgnw9qo+w/A
 LKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376574; x=1740981374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HthBEodV7YS2fKwyudsDePzDyTAobsouKTigKLnQiE=;
 b=a19SRpa4vyVEf7Z9CM+wGjWjbZmhLNU0AeeLtsc0NPvhcwhsYyShVw/SojhzPE6qYD
 e5U2cqbvi2pxxZjcBD7zrTa/gJnvCT1WiP4p/Kpdq+X5PaeyCAk1setBu6UGiWax1Ots
 HmryDTxdq5yompmh+hA8SL9a9BnKgZeZZwfAfrzyJNm/xOVvw05wml8FB1aQQGy9fKBS
 SW17c08KMFAflEfHL5deeBj7NyaZLeEcrNT8tg+oSLGoyA8crhjhQtQd6hYYnw2pF0Q7
 EbyGH7Bqi48Q65uBVrYXWAv4AteGSjnI/T/BhhAVXiMkanmKZOtOXVWfDZoRGGFWB53i
 EcAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXumP0GE6xbXVSo8yjQU4NAtWG868AzjEKZnrRNF0b0xaBUiA9q1UsXcVo3vLl3edVTfKrRpxc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9rKjL9lC61ofwOE7kkSg/j+udGUpreuFj0O2d23TC3hrt59RL
 iVOgOaFzINykrvF3rirCHyNEy2CKxU9fjS1zAuRBI+Xo9Hjz0i+Q
X-Gm-Gg: ASbGncvyqbe49rO5ncudMTFUa2Z25gJEU73OtbQeDNH7XEcHGwMYEqKEDRR6F5Hctxb
 fDupk2UXfNZEHP+Vc1Cq8S9Eqv+UT28ZQ1FVjq3yTQDlUQiM6YgsuHjQDtq6hSltadnEhJw2ftb
 7kVNcRfc7HHc5ZnjPLb/U921S32KzFCPw0/FQWWXm8VS1OPeHCU0fCB15LRKAm4vWi068uM2CvK
 YupRxmj7wKV3CJY7rWeB/1kyQJRf+KeobxQMPS3bZAOdKg4JMjjvfv/nT2tL5HGW6AfhVtk0dN4
 Zd3c/pg+7yDWKHqpmWNyB5mVHj0e1GbqyQbyeg==
X-Google-Smtp-Source: AGHT+IGcXxUtjsG0b0rrX5HeUHSvJLq2jOMuXjX45ToxKSqiLI453wyDOzZ4RGtnqJKH3yF7x5Pluw==
X-Received: by 2002:a17:902:fa85:b0:220:f1a1:b6e1 with SMTP id
 d9443c01a7336-2219ff5602emr143881895ad.19.1740376574266; 
 Sun, 23 Feb 2025 21:56:14 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:13 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 12/17] makefile: Avoid objcopy --gap-fill for .hex/.srec
Date: Sun, 23 Feb 2025 21:55:19 -0800
Message-ID: <20250224055524.1334929-13-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

This flag only makes sense for `binary` output, because .hex/.srec are
sparse formats and represent gaps without filler. While the GNU binutils
version of objcopy does not seem to mind the extra flag being passed,
llvm-objcopy considers this a fatal error.

There is already a version of the objcopy command template in the
Makefile that doesn't use --gap-fill, which is provided for EFI. So use
this other version for all .hex/.srec outputs as well.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index a9194b46ae1..87b07d8989a 100644
--- a/Makefile
+++ b/Makefile
@@ -1067,7 +1067,7 @@ quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) --gap-fill=0xff $(OBJCOPYFLAGS) \
 	$(OBJCOPYFLAGS_$(@F)) $< $@
 
-# Provide a version which does not do this, for use by EFI
+# Provide a version which does not do this, for use by EFI and hex/srec
 quiet_cmd_zobjcopy = OBJCOPY $@
 cmd_zobjcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 
@@ -1282,7 +1282,7 @@ OBJCOPYFLAGS_u-boot.hex := -O ihex
 OBJCOPYFLAGS_u-boot.srec := -O srec
 
 u-boot.hex u-boot.srec: u-boot FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 OBJCOPYFLAGS_u-boot-elf.srec := $(OBJCOPYFLAGS_u-boot.srec)
 
@@ -1296,12 +1296,12 @@ OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x50000000
 endif
 
 u-boot-elf.srec: u-boot.elf FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 OBJCOPYFLAGS_u-boot-spl.srec = $(OBJCOPYFLAGS_u-boot.srec)
 
 spl/u-boot-spl.srec: spl/u-boot-spl FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 %.scif: %.srec
 	$(Q)$(MAKE) $(build)=arch/arm/mach-renesas $@
@@ -1436,7 +1436,7 @@ OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
 OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
 
 u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 ifdef CONFIG_SPL_LOAD_FIT
 MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
-- 
2.45.2

