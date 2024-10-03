Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2BACF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD3488E6C;
	Thu,  3 Oct 2024 17:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iPr6Pqzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D629B88E19; Thu,  3 Oct 2024 17:23:43 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B2888E3A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37cc60c9838so682839f8f.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969021; x=1728573821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqiyAoroPIcERV5UdiZ9NbI4bh3DuJ6aBo7wOO8WXf4=;
 b=iPr6PqzuS91pThZrZNVmymkjff8ENeEmZlWdvU4lQKdc+GUX8aZXXaTMJGmrjQd8x/
 PMxNT8z4OWV7PbLIByNt7NGTyx4Ghu2jazLzPupazMIJ3HaxFk1XbMEgnObISjuLY7bc
 EXA5ZqIk1zIyqKGynZmmPyJWtYCVQqHiSanbfPctjix7NQVh0v4XNX8XDA3M+dGHm8k2
 7XKQXdAWTT+DMZ/OK+CaiQK3X2LLEt3KR9Wo/PtwUMW92akg5tu/5QM2XrkcsGDqmS5i
 xTeTb7e68oDOG0X9GygavRKVLG6G8ldjRRbWd7U6ZTDFcPGoYb4r3154SFLw6VPToUx1
 QwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969021; x=1728573821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqiyAoroPIcERV5UdiZ9NbI4bh3DuJ6aBo7wOO8WXf4=;
 b=QTVbb9f8ku1AovjQX2Ja3jEMql7jGJyqqAMN3STRQ7H6Cr70HqgUycl87hzsNN4MZA
 lDMnGCcz8AtSSEF2vfMv9/ik2+DxFJ/PyQraxMhR0QsV7mPxscwkcs05SSeLCfajM6e4
 GEk0V1SfJRL7IqiQIay5HN3W3KsxIV6vriCcT73AZMnaSytMlGiH+6m+mGQ4soAlBrp+
 QbYhbLUD2kKNet/B5wyG44iTXkSTr/zxJb0ojldqQ+lnqm+R9/ozod3i2E4bOtyhDSyp
 HmUPlfnhE79EUGmJ28b8hKdtJvRWDqlismv7SrFC780whYNiQARd7gwkzrYNZzY496/f
 o3eA==
X-Gm-Message-State: AOJu0YwwjurnZqdKAgGD+f/1Byhon8bdfLQqkAGghO49tPXLZhYxJL9F
 9OofcNpeDONPE06ydAmEhSSRhzDQl9flo6Mya6IbPIAxRsHAagjqWkOQ2NJulpQ2xIppSpWSEOh
 D4swGTA==
X-Google-Smtp-Source: AGHT+IH7ubaoeNlKfcJKMwdIEKo4YqG/TLplp4yK4AYbYQN9wwDMWDASILllRVSfv+k0CinnIHUrRQ==
X-Received: by 2002:adf:f2cf:0:b0:374:bd00:d1e with SMTP id
 ffacd0b85a97d-37d049b7650mr2155164f8f.3.1727969020741; 
 Thu, 03 Oct 2024 08:23:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:23:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v11 03/29] linker_lists: set LINKER_LIST_ALIGN to 8 for
 CPU_MIPS64
Date: Thu,  3 Oct 2024 17:22:49 +0200
Message-Id: <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

Note: Patch posted separately [0].

[0] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610222-1-jerome.forissier@linaro.org/

CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
exception may occur. Fixes an issue found on malta64 with QEMU:

 Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
 31                      if (!strcmp(name, entry->name))
 [...]
 ld      a1,0(s0)

 (gdb) p/x &entry->name
 0xffffffffbe04b0d4
 (gdb) p/x $s0
 0xffffffffbe04b0d4

 $ grep __u_boot_list /tmp/malta64/u-boot.objdump
 4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8f1f4667012..8f4df849801 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
 config LINKER_LIST_ALIGN
 	int
 	default 32 if SANDBOX
-	default 8 if ARM64 || X86
+	default 8 if ARM64 || X86 || CPU_MIPS64
 	default 4
 	help
 	  Force the each linker list to be aligned to this boundary. This
-- 
2.40.1

