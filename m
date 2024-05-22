Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D9EC25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A275888B5;
	Wed, 22 May 2024 19:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="OcE2NUEX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLHaB7Z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087C5888B2; Wed, 22 May 2024 19:08:12 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362A18889F
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 66E4C1800159;
 Wed, 22 May 2024 13:08:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 22 May 2024 13:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397686;
 x=1716484086; bh=NsrkSuV8RmpBH30BptZufEhcSWZsZMDUf0peTeuaIjU=; b=
 OcE2NUEXfHq0laN4fE+P+TAedNSF2GAg+31hXxkmJ795XwAXfEwt6l1zRSb+EuJl
 bst4tIE0v1iXqCtyKIQXAso7Wr2cboZqpIXjgwledQMtSCN3MJbOuDY5Bp+iWvLY
 DXSu302Hv8qheikFC9vF4Gn7WPZ2/yBkhmU+7KTi94HSYy/6z1ZN1zMRo7Ct6dR1
 Ix3taoV0bn1oEc6+U1QydUUhDvHZPq6XgIRECDVWaXfWV2JeNxx9iCaCHx3aWnlV
 B6raE7TCeiPqG+5i3AsvHgMkhrJDo4tlrHDGtZuwtZ8n0oM9gyl4XPPCnv2wjVxT
 G0n+TE6mgBtlc6uvXKE7jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397686; x=
 1716484086; bh=NsrkSuV8RmpBH30BptZufEhcSWZsZMDUf0peTeuaIjU=; b=g
 LHaB7Z07qmAnSm89wnrNwSvROVGjGKE5vAshWI08gT4JmvXlJZ787S0TYQxKCMjP
 4sMepkvJ/UgGqyoD3GFrw+fS7Z5SY61TGVCrpFr3KtrnkEtGA3DXbNHCnmqTLGWf
 J5y9Qdt1fm04RgEGV6Y5NV7TtFJdZOA6DRj93iN/b9OBecTyEALrGRNtZAMZgtkb
 agsVXsfRL4JoTv7ankQ4btBjNOCoWrG4SFhbOPW+5G1EyTPFJdzbOvBGxsgTqNOr
 bUMoa+ubVUUQpFK+46szqtZitXcv4l4jEjiFvsZ5iLEjnXdnN45d+OI+ACiRndLB
 ows84N9gxpva8403orf/Q==
X-ME-Sender: <xms:dSZOZr4hGZerZOasEWRW1PuEoiIPQa29RCQd1MBjjrrqJpKjxbbHOw>
 <xme:dSZOZg4uIhFPkW4xe0fsUZ2W53cQyTnnKrjBIdWAUyw4bKNtATZLTZQCPtScZG0RV
 nMCfghr5xybn5kYR_4>
X-ME-Received: <xmr:dSZOZieINpFDbeHUymWRlXqYjOMk3_NjsKUmqdGF18AaCaqf_tFBwio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:dSZOZsJuYm3pjn-puyRGmt62tPZBLQrse2P5AjhAXrXDRfMcvhA5GA>
 <xmx:dSZOZvI4h5VpTCpp0k8dBGur1WZJpalAHRNVIe36zL5xspl8hEFMdA>
 <xmx:dSZOZlxHuwNA-FJN54BpFEHVDJajNp0pHhaLvRsVZZ0JWaSG0IKBTQ>
 <xmx:dSZOZrKbR9wuGekZbGpIA9G1WuhreEXm7EFW5yaGtN3ltAe3D2gQ5Q>
 <xmx:dSZOZn9yKsWyaESOAQ_lRPI9FjV0iN4Sp0lPNFbAPBYoM16ncb0gYi4S>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:04 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:07:59 +0100
Subject: [PATCH v2 03/10] xtensa: Implement phys virt conversion for
 PTP_MMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-3-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=i66e2H8mL9AQRiPd5Y0iBlvD+fpKKl6Al3uT1QeU5ts=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tbxTMb/YRcO+3ZPf6xh0asetsOpPPsfF/9s9E5rJd
 ofn+4c9HaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRp36MDOfvbTxV8NejKefX
 wXiNIg7uRPVzuy3e7V/mVreu4tyjAz0M/x0V7kiLvQg3Yl03Iyn9Dc8RxqsfGR7y3r0nk3ruZnF
 nHCsA
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

