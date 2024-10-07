Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CD8CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 09:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39DBB889FC;
	Mon,  7 Oct 2024 11:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GR3EV/vb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7F6884DB; Mon,  7 Oct 2024 11:42:36 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB852888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 11:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d1eda8c7cso651032f8f.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728294154; x=1728898954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=thaYmYO0xbXl1CGK8cciXePNLK3whxHXeRIVQ2I8dTU=;
 b=GR3EV/vbuJHDjgRybs3Q9HQvUk4zgcOw9C5waUjJuI23igcQEF4AWo5J1e4BZwfYGa
 hZArLtft6wmk4JaQaoU3OBb5jZ5XPCF/sFyTtUVVt6lKN59CkyYyrvaq5Kx2ykHnq+9D
 WYJUBPvrG2qryY4LHoAmobwbYVz6jAgsdUD2fzHtUOhrLlIlV4IbCh9pA1JUG+AfQ872
 ay6jVEk9oBvFksNTWPu4K3pts4O+CVL4keYg1/Xs7Q5be6jgmUGzb6kC5slD2uEvxc2u
 rrDhEsYbjVfpqXrCCOgYUZdV6maKe1PH4P060QWdmXyr9UiB4YSs1KezaSufebBfq5sY
 P04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728294154; x=1728898954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thaYmYO0xbXl1CGK8cciXePNLK3whxHXeRIVQ2I8dTU=;
 b=HMOVZFF7wmyiWTSmdGtP0+smvKZQB6/95Jl10SGSSOSuaAM0Woy+CEVu1aFjOzx5UW
 ZUw1+NoouzagERYDS1cggWLFGKzL4iyV6LZ+fQ58+ofabvjvXogylU3E/l7tYaF6u8xH
 TA0ZYC6FhcRTLuNZNkrl2ou1ItpgQGYlhI+hdGJzCsey/fhrtUBHd/Pi+r+3CzAhS/jd
 wScfU1t5ftFRBAU64UlT2OiMfZZP1VU65njzqARrA6rnT9eqvFHjIBc1VPHl6Bnka0QK
 KzTSy9enOkpB1NKv9VxM9Py96GCssst7s1xY1z6LHLUKWX0NucqD9A76dNMXltqekdh8
 Abcw==
X-Gm-Message-State: AOJu0YwDStNO5BnP24W5wJwVAas81+G4VpnNLBCObYQ+Y/kRijB5nzCx
 Y6rpz0zzLvQss1MeaKR5wrJinezUcBHvaE15qcOUaB9T7G+/ERicEAY6KfpRBNFV//UUfygvqKP
 NVgM+6Q==
X-Google-Smtp-Source: AGHT+IGXJ665kYJt21Mo5M/OIjddioJN/1A4ZX7QbSPKXuk38SVesYQp32U8RswQe91YGYvqjIkzLQ==
X-Received: by 2002:a5d:51c7:0:b0:374:c05f:231d with SMTP id
 ffacd0b85a97d-37d0e4e447bmr5968063f8f.0.1728294154039; 
 Mon, 07 Oct 2024 02:42:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:287a:3d8d:7a32:9534])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1698fcacsm5273659f8f.116.2024.10.07.02.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 02:42:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 if 64BIT
Date: Mon,  7 Oct 2024 11:42:06 +0200
Message-Id: <20241007094206.2928071-1-jerome.forissier@linaro.org>
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
exception may occur. In fact all 64BIT architectures should default
to 8; that's what this patch does.
Fixes an issue found on malta64 with QEMU:

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
index 8f1f4667012..72bf4029251 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
 config LINKER_LIST_ALIGN
 	int
 	default 32 if SANDBOX
-	default 8 if ARM64 || X86
+	default 8 if 64BIT
 	default 4
 	help
 	  Force the each linker list to be aligned to this boundary. This
-- 
2.40.1

