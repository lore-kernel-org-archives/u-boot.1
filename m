Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D307D5CCA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941A589216;
	Wed, 30 Oct 2024 14:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="VQveYEiW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CCA88FCB; Wed, 30 Oct 2024 14:01:03 +0100 (CET)
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D90588EDE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1730293260;
 bh=VKZJGSeD5HczZPy25NecTEQUX3F24Yap9L2KMVYYvWU=;
 h=Date:From:To:Subject:Message-ID:Content-Type:From;
 b=VQveYEiWwwPqqKx3XZ8QT2FCxq36ZRJ4NzTPfezQSNaw9CerVkHQ1m/M3mIRxJFBH
 +7hEYfDxgwO52kZfFrsQxqucdUoaXBQHtgbyNt8ZTUtP+9/YVWVnrPRwv+yFM5VCay
 XXqSaXw9sTjj9VyS1uR8Gcw6A6riHuDhPUzJLV8Y=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr4.vodafonemail.de (Postfix) with ESMTPS id 4XdnLN2kwyz1y0t
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:01:00 +0000 (UTC)
Received: from qrv-systems.net (ip-095-222-025-162.um34.pools.vodafone-ip.de
 [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XdnLJ1R2qz905B
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:00:53 +0000 (UTC)
Date: Wed, 30 Oct 2024 14:00:51 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Subject: [PATCH] bios_emulator: define the comment symbol for RISC-V
 assembler too
Message-ID: <ZyIuA1Ieq4ff7iqV@qrv-systems.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 976
X-purgate-ID: 155817::1730293256-9DFFA477-39CECDD0/0/0
X-Mailman-Approved-At: Wed, 30 Oct 2024 14:17:52 +0100
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

The bios_emulator driver cannot be compiled for RISC-V because the x86emu.h
header file doesn't define the comment symbol ("#") for the assembler.
With this patch, use the same symbol as for e.g. x86.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/include/x86emu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/include/x86emu.h b/drivers/bios_emulator/include/x86emu.h
index d2650a8d16..cfdcd7b3e1 100644
--- a/drivers/bios_emulator/include/x86emu.h
+++ b/drivers/bios_emulator/include/x86emu.h
@@ -54,7 +54,7 @@ typedef u16 X86EMU_pioAddr;
 
 #if defined(CONFIG_ARM)
 #define GAS_LINE_COMMENT	"@"
-#elif defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_X86)
+#elif defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_X86) || defined(CONFIG_RISCV)
 #define GAS_LINE_COMMENT	"#"
 #elif defined (CONFIG_SH)
 #define GAS_LINE_COMMENT	"!"
-- 
2.39.5

