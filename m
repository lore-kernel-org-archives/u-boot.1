Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC41C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 06:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17798210D;
	Sat, 10 May 2025 08:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746860006;
	bh=NEh//dowW1jPWMv1h+gaF6OZx0be15GKB1n3eRXb/cg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UXarom89WebWWo0mfvW8RwFA9HVj3QDVvcvU+nQVyIAD7hruNk8L1BrdYjOVk29B9
	 HUnJLOZldP+Plq2K4Z2rXpCuNN4C+TfAtVOMiYLch3ziEkX0vhEIKgYUBeDwPLYiot
	 rF5KJnE1cBXbyeHqT3pMY9YQ750J7B4/053D5kp8FN2gNN18iU/6sXmuvhhj84kxSY
	 M8U2ob3HZtpMgossvZ8sYhmVF3zCMYLSPGpMxnmbkkzt2F0/W2JdtRKt4KR7+OIZbg
	 mAEgKs2/J1Kxne5Y+MrQ9ecSZtvIx4TndbF435s4ZAsxWvkhgip7xsWLQw6M0djMOE
	 YGa5grNXw7izw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDCEB8211F; Sat, 10 May 2025 08:53:24 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7C980EE5
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 08:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="G30QAzlP"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1D69E1048C2EC; 
 Sat, 10 May 2025 08:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746860001; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=NEh//dowW1jPWMv1h+gaF6OZx0be15GKB1n3eRXb/cg=;
 b=G30QAzlPLKWz5TC5VBsnsbxUHymNdaao+nTiZL3jVB6LCBD7XVsSmzGuT0OLECY+SBXkc2
 kaiGbi8OTUmrupE7G9y77UYFDojnsAiaBgr9MH4l16LQ817cnrCnZFF4RC+iAyNJYi/ABk
 /Oj3ZTUKL+wQ5CqtY3jpB/kOjtnyvc8V/3GDNVBHxmT31yc69+lrfRJHJo602M5JxqjJIU
 RAX44rGJf5RSD4aeK7U6bTARr03z4S8aHTc6b4aFOzBc/f3/ctv/KKZdUK6ELZnJhIoViJ
 oDDgDmY8DunreVQPpsaehDjJFGS4ytbitp9PlQ31MJTjIyprLRpN9mp3XGHt8Q==
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ARM: stm32mp: Correct sign extension for memory address in
 dram_bank_mmu_setup()
Date: Sat, 10 May 2025 08:52:56 +0200
Message-Id: <20250510065256.267546-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On a system based on stm32mp157c, with 1GiB SDRAM (starting from
0xC0000000) and CONFIG_PHYS_64BIT enabled (so the phys_addr_t becomes
'unsigned long long') the mainline u-boot hangs.

It is caused by marking for this memory region the TLB entry as invalid
in the dram_bank_mmu_setup().

To be more specific the condition of 'addr >= gd->ram_top' is met
in this case.

The reason for it is that the 'addr' variable in that function has sign
extension from 'int' typed i automatic variable:
addr = i << MMU_SECTION_SHIFT;

For example i = 0xc01 causes addr = 0xffffffffc0000000 as int typed i
variable (with MSB bit set) is sign extended to unsigned long long addr.

The proposed fix is to change i type from 'int' to 'unsigned int', so the
sign extension will not take place and addr = 0xc0000000, which is smaller
than gd->ram_top = 0x100000000.

This change shall be safe as i shall not be negative as it represents the
SDRAM areas (in granularity of 1MiB areas).

Fixes: 25fb58e88aba ("ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located above ram_top")

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/mach-stm32mp/stm32mp1/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index d5eaf6711b6..0ed5eda47d0 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -51,7 +51,7 @@ u32 get_bootauth(void)
 void dram_bank_mmu_setup(int bank)
 {
 	struct bd_info *bd = gd->bd;
-	int	i;
+	unsigned int i;
 	phys_addr_t start;
 	phys_addr_t addr;
 	phys_size_t size;
-- 
2.39.5

