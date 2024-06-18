Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A37C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A90C8834B;
	Tue, 18 Jun 2024 15:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="XauZQ/Ef";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnRSoyOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8849D88307; Tue, 18 Jun 2024 15:56:29 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0AFC8786C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id F1B1B18000E4;
 Tue, 18 Jun 2024 09:56:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 18 Jun 2024 09:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718984;
 x=1718805384; bh=HSd75T7nLaTJY/hAAlsehz59myiyl7wNtMcuOyrusPc=; b=
 XauZQ/EfOKHsokQccK62zHh+7CzIsOKID3+0wRKTI1a6VNWSs2itECZTBIBtApWH
 Eg65rdOQBY6ecM7Iobiscw2+NvlXGWuoXyuCIv7O/ozowZeUhCgp+f/VN/Zlx9WV
 kJ/K+LGPtQjwkKuC4D1YMWCY7h9q6dw+/KQPqBOI3uu3DroEbcb/uCwqPDnzT74x
 kDXz7iXCTyOfAzWXZZ5EKEECUW+WOUWbfg4QA/5DmWKs0UeJIRc6YT7VoLtw+uV7
 amMGQ+lU7NcFHbfndr4+H607V20+IjAyEHFqXAHWhb2xTtsKlnADvr9ZrTZIZbSA
 cMdryrUqkKr+IE62IeYFLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718984; x=
 1718805384; bh=HSd75T7nLaTJY/hAAlsehz59myiyl7wNtMcuOyrusPc=; b=T
 nRSoyOvKZGlU1GdEYd1vfIxAa1SD3LEYI2PI91ibBhopV+D4M6MPugg6ra03lM2x
 3QOxdp+R6Bpl8lSxD4mq/+CT2q/NZiUoUgNTzVOCGpRTSNM+Q7qYaBHg1D/jThyn
 otUY97pJf4YMj8F0qeAdHgELu3w7KDkzWHtD2WIfbtyQlXG63ukbHFimrvSrOzPi
 5ZqU+pd6vLtj0Mm17gF7dnPJKqwRnetkaNgza7O7OI6GdMcWZLkY9G1qiMC3LOJd
 HKzElV5zRHAFeuw+kpsrv6QlqDmuj/TwtVTZO1P06YZkEP6TUfxS3s09nwsTg3wK
 BatmblW8DBPxAuAOqg9bA==
X-ME-Sender: <xms:CJJxZqpccR4miw0ZhdNfjb887walPzsCjHa81OWlLdXCmujEiV6xwg>
 <xme:CJJxZopMM_Aajeji6MbjGRcWVPFam4b1W-EWwF7quA8UkOLQ5sRce4k-hXEIGZ7Tg
 KEgU7MBHKcxzdXX110>
X-ME-Received: <xmr:CJJxZvPqM48H0w_XqJHWmqH6SrtD_sfmQSuQcq6iOi5QiB2ed-rRigo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:CJJxZp7HGDW3VtvAjVa4w7TjfFqf7WaE0UgEVZvW3esNZBd-CEVyXw>
 <xmx:CJJxZp620CR7ihBdRl8Y7691MyL_ZLahcqi2XIy1T1AQW_aSCnr4fA>
 <xmx:CJJxZphRfg_tnDtNOVlxlbdIJMXx_Ba0TgGCwA5BN369mHNyr_qvCw>
 <xmx:CJJxZj7f1JDV922SlkphdjOlu2kJhhJfdaNvCSlAfoUXI-i8he7iiQ>
 <xmx:CJJxZmtA9wWG33QWJjHYgxwjI0TLCApkyl3Xz-3wDMlN0jvJuGCJiz8Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:03 +0100
Subject: [PATCH v3 03/12] xtensa: Implement phys virt conversion for
 PTP_MMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-3-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=pCpFt4Od7VIN5VInTKC3EZ2MLltCnK6OVsxCbS0laaU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYyaoaIm6ustBe7G/HX9vny1zYwV3PuylKfofJa5t
 uvm9O03OkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiuxwY/icy2Tk4/LlmtiLO
 c/msLze9dC2VLFTP2d7I2PFvjbW0tDcjw5WFZnsFglq943lKPe/fiDUS2F53XbrwSPTih3ZHXPj
 y+QE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

For PTP_MMU our physical address is not directly mapped
into virtual address space, we need to access physical
memory from those fixed map segments.

Implement phys_to_virt and virt_to_phys hook to reflect
this setting.

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/xtensa/include/asm/addrspace.h |  2 ++
 arch/xtensa/include/asm/io.h        | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/xtensa/include/asm/addrspace.h b/arch/xtensa/include/asm/addrspace.h
index 920b5fd26b20..c8bed8834b55 100644
--- a/arch/xtensa/include/asm/addrspace.h
+++ b/arch/xtensa/include/asm/addrspace.h
@@ -7,6 +7,8 @@
 #ifndef _XTENSA_ADDRSPACE_H
 #define _XTENSA_ADDRSPACE_H
 
+#include <config.h>
+
 #include <asm/arch/core.h>
 
 /*
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index 87ad9faa2995..ab2438b829ac 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -12,6 +12,8 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
+#include <asm/addrspace.h>
+
 /*
  * swap functions to change byte order from little-endian to big-endian and
  * vice versa.
@@ -127,6 +129,36 @@ static inline void sync(void)
 {
 }
 
+#if XCHAL_HAVE_PTP_MMU
+static inline void *phys_to_virt(phys_addr_t paddr)
+{
+	if (paddr >= CFG_SYS_IO_BASE)
+		return (void *)(unsigned long)paddr;
+
+	if (paddr < CFG_MAX_MEM_MAPPED)
+		return (void *)(unsigned long)MEMADDR(paddr);
+
+	return NULL;
+}
+
+#define phys_to_virt phys_to_virt
+
+static inline phys_addr_t virt_to_phys(void *vaddr)
+{
+	unsigned long addr = (unsigned long)vaddr;
+
+	if (addr >= CFG_SYS_IO_BASE)
+		return addr;
+
+	if (addr >= CFG_SYS_SDRAM_BASE && addr < MEMADDR(CFG_MAX_MEM_MAPPED))
+		return PHYSADDR(addr);
+
+	return 0;
+}
+
+#define virt_to_phys virt_to_phys
+#endif /* XCHAL_HAVE_PTP_MMU */
+
 #include <asm-generic/io.h>
 
 #endif	/* _XTENSA_IO_H */

-- 
2.43.0

