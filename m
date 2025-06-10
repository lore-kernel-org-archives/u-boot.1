Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42429C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90EB882B33;
	Tue, 10 Jun 2025 17:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="rvbkyD7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AEE82BBF; Tue, 10 Jun 2025 17:19:12 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2738582B26
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=srv_ts003@codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9yfeUw+Ix4Yhy72iOtwogxpOg7oECbsvT3Otax+5pjY=; b=rvbkyD7Sp461VeGF4h9lAjVp0W
 dFcNF0lrfgtDz3uB22xclTr5UbmEyuo4B5mZDP1pIHKfDVlmeVl/nwTVuviOlOgxmAmIoyB/iEgi/
 a1LD2zyD1AIyxIG/usZ/93PrBPM9z5r71LAKflvP71D2Rh6+TN8MUWOLj8RvkEzIb8B48M5jexBsa
 6VCp1lwRRfUcZhw5E4uKovfDWRd9Jd6Zd8BgioGn1QtnGcq35UMWe3mygbFfVMp2d41+AQg43ik70
 6B6QPCxcLjR3A1WaNeARVIl4ngupXYbABuaCS+DiMXndfqx59+8bTqNK9xY0qg9APpKCMQvZbDZkj
 tAR9RMRg==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uP0ka-00C1Ev-PZ; Tue, 10 Jun 2025 16:18:56 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uP0kV-000000071IG-0qnQ;
 Tue, 10 Jun 2025 16:18:51 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: rick@andestech.com, ycliang@pr-suspensions-neuweb-biz.expedrion.biz,
 u-boot@lists.denx.de
Cc: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 ben.dooks@codethink.co.uk, trini@konsulko.com
Subject: [PATCH 1/2] riscv: add build support for big-endian
Date: Tue, 10 Jun 2025 16:18:49 +0100
Message-Id: <20250610151850.1673111-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
References: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
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

Add support to build code big-endian if the board supports
it. Updates the makefile to pass the correct compiler and
elf flags.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/config.mk | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
index 9f16dda92a0..2eeeb433748 100644
--- a/arch/riscv/config.mk
+++ b/arch/riscv/config.mk
@@ -10,19 +10,29 @@
 # Rick Chen, Andes Technology Corporation <rick@andestech.com>
 #
 
-32bit-emul		:= elf32lriscv
-64bit-emul		:= elf64lriscv
+ifdef CONFIG_SYS_BIT_ENDIAN
+small-endian		:= b
+large-endian		:= big
+else
+small-endian		:= b
+large-endian		:= big
+PLATFORM_CPPFLAGS       += -mbig-endian
+KBUILD_LDFLAGS          += -mbig-endian
+endif
+
+32bit-emul		:= elf32$(small-endian)riscv
+64bit-emul		:= elf64$(small-endian)riscv
 
 ifdef CONFIG_32BIT
 KBUILD_LDFLAGS		+= -m $(32bit-emul)
 EFI_LDS			:= elf_riscv32_efi.lds
-PLATFORM_ELFFLAGS	+= -B riscv -O elf32-littleriscv
+PLATFORM_ELFFLAGS	+= -B riscv -O elf32-$(large-endian)riscv
 endif
 
 ifdef CONFIG_64BIT
 KBUILD_LDFLAGS		+= -m $(64bit-emul)
 EFI_LDS			:= elf_riscv64_efi.lds
-PLATFORM_ELFFLAGS	+= -B riscv -O elf64-littleriscv
+PLATFORM_ELFFLAGS	+= -B riscv -O elf64-$(large-endian)riscv
 endif
 
 PLATFORM_CPPFLAGS	+= -ffixed-x3 -fpic
-- 
2.37.2.352.g3c44437643

