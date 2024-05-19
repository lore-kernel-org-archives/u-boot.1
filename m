Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1CCC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6B388047;
	Sun, 19 May 2024 22:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="5KSq12VQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbNwJOH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F2E882BE; Sun, 19 May 2024 22:53:57 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7696F88193
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id A9B6113803B4;
 Sun, 19 May 2024 16:53:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 19 May 2024 16:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152034;
 x=1716238434; bh=NsrkSuV8RmpBH30BptZufEhcSWZsZMDUf0peTeuaIjU=; b=
 5KSq12VQgjdhsp9+3FO1vhQ81QyykmOrr0WRoh+bLRaCU/pbTvbbLEZCIX+puflj
 aiGW3GKPSP0pRHnaGl7VSFsUKIAmlYPK3Gp1OoCcAdlaMTgkBOLOmDcmbKjkuKHI
 w8PT7xyNzbk81cC6FBbBiiGGOm0Q3ogk9gSduXF687gHETP5ZQhvpYKdoAtTIeTa
 R0mTeVxybgzMMt0uym6lijQprp0d2PwG+qrUqzi/UZkPCbmtvTcl+FuBo7WfNknV
 lBOo3g/+PDZAiLWP/C2zmzTgDS+QjVzWkpCkSm4/QIC+aOgWqluSyrXxLUEM/V0p
 v0gWBB82GZQlktK/7eTmXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152034; x=
 1716238434; bh=NsrkSuV8RmpBH30BptZufEhcSWZsZMDUf0peTeuaIjU=; b=Q
 bNwJOH8UFh9c5gcR47gL9qLNH0nBAPIUid8Ne4PcFmP0rE+K8UkOnZni0HObZxGr
 noJdnzjmPANDA/Y4HxjNoB4WVcpm1JI7rRygCr7Z2QbUkwVfCSuXg3pqSIUkR7vW
 t+aERzsNiFQVq6DUniNXbV6Z4t+hmtN9Ci6lOs3PkLprcMkjwpexr052IzAeYwfD
 9HSJLo17KrCse2rYAc8eiRkCbRhwWgYw+x2FcEIaBgvx8vLuY+U1Ht8NJLJ1EOw1
 Q3/MSk3ZA4YwFD0LpYE35CSATd8yuukzo0u5vNZMP8uQPLjD2mnn2HzWDRycwJ+I
 ZReDSLSkreyqr+QTAyb1A==
X-ME-Sender: <xms:4mZKZhvzZd5fY8SORkKt3RLFkef3jjBL3znLEtskRQJabtr1EUzpbQ>
 <xme:4mZKZqfgrBhxBPUkHxEirPF57jSPx7_un0OoQUQq8IxaSL-GLRR9PN3eRsAUmheUt
 ZHkeK6qAFjinhJmdno>
X-ME-Received: <xmr:4mZKZkwJxrYYOXliqsNzIPL7G60IDezhD2qwQ4UTCzd2ti7RBb4hmlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:4mZKZoOpn322sPiX_fpXwjWppLXh6JaJoYkmGMYGZ4ldn5-51ULGOQ>
 <xmx:4mZKZh-jTgpK2B8ds01qj2vzl2o885TZSrcRTeeHhUMEFAIl5QYA9g>
 <xmx:4mZKZoXqg82209cEe8rk8--WmGAHqrhBJAXDaXo6gBx7EXOkRIryaQ>
 <xmx:4mZKZifqFwFur9E9RUgH8JxE3o9XOZy-ITO_qv4J-pLNgeAKB0WUFQ>
 <xmx:4mZKZhxVcjdi-GBT3Blv2IhfHo39IpuzsBIwhk0Zo9apOiDdv2ceXwSs>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:53 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:50 +0100
Subject: [PATCH 03/10] xtensa: Implement phys virt conversion for PTP_MMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-3-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=i66e2H8mL9AQRiPd5Y0iBlvD+fpKKl6Al3uT1QeU5ts=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHuNL9S+MWuJnixdqGX7t5rxke7/He41uQltVg9kV
 2cHXz/SUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABO5/ZeRYa5CWuUcPcVLM08d
 OM5u/3HCbkGjmaYpVx2+PvjGuCoz2pCR4R2DdWj/8VOm2dMCo1d8+CmSw7vg9/ONsirlziJG8zj
 NmAE=
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

