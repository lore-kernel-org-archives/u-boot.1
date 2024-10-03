Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F2CF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926C088D69;
	Thu,  3 Oct 2024 16:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XmtBlMgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C111B88D9E; Thu,  3 Oct 2024 16:20:51 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E588899C
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so10194315e9.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727965249; x=1728570049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/FWzsTuXUiq6n4GExM3adT1S2Aww8TLy+lCVt9oNaE=;
 b=XmtBlMgt/C2QDV4vkGfe7qoLLdTLRGuW/Fkob86e2iwF8fzpisALpJP6W0eNeEWCuc
 c90eErI3aWcgB2jmYlJU9oDA33yaQ56nkfEsZE/vCyP8no56iiHSjJkBCb8fqwHNPpSN
 EAU8+M5qTQFddxfWub7c4TR2fmn8U2Sn5+6EH02/8S2I72tSzxjQPo1Ffr35mxKfwT0E
 tC61FVnRRV0RdZ718rARczJ/AeVi/gzds8MhPYYELu0QG2OfKwVmpwyI5JELPyiN7NZp
 3X5eQ7uySZJubIHIRatOtuUvshNuT09FmjSadB3sz4l91LcNyOlfEovORh2DZjv4Yk5l
 D15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727965249; x=1728570049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/FWzsTuXUiq6n4GExM3adT1S2Aww8TLy+lCVt9oNaE=;
 b=vNNOCXtjE96+7EagD5MhbVgGbkpcXWXyNuDJJpb6kgSeZAQcklNWVY8z2+pGWkG8oV
 fFXx6Rx46dstoZrShXYj09lrI3tR1/ECdC8pYUeSFsbz/ka/kEZ81CQiCgwqFRI6gLLF
 yg7V53woPCsutUI6ZPnDHW3MtR37CEp4u1MbVRCVlldh1gFuNb0GcCP/wrxHW7RwsAvU
 E274ECze5Pt0wcFSAbhg4xsuNgxWvvmxdqU4/ckIh6bqriAPRJh1SOvOajRM4QM5IVMM
 bAs/IhyoLqw2WcW/+OJ2Y7LbULZRvwo0h4TDF4QsrDDAlE8lTgigAVof+widTzl/LhQM
 oNDA==
X-Gm-Message-State: AOJu0Yx+NEunUfP8b7KZbW6Cng4IrN0T1kuOQvcyYjygQ5CPY+4dS8/+
 WLvbrRovGyVXXsCy4rx4GxSy0Vi3V/sfyiixl5V5vVNazLCoc3g57ImuwLOljf3uBheDmP+OAq0
 AuznaQA==
X-Google-Smtp-Source: AGHT+IHt1G47ZWb0uyKXiK/s7XyHobAsZVTwFCPxQMgkWcdoN45Fctr82YpvQzz4x7a/3/MDIuw9LA==
X-Received: by 2002:adf:9b97:0:b0:374:ba2c:3028 with SMTP id
 ffacd0b85a97d-37cfba0598bmr4189624f8f.36.1727965248752; 
 Thu, 03 Oct 2024 07:20:48 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08247911sm1372948f8f.57.2024.10.03.07.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:20:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 for CPU_MIPS64
Date: Thu,  3 Oct 2024 16:20:30 +0200
Message-Id: <20241003142030.1610222-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

