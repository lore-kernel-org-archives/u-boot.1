Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EB9C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A5388865;
	Wed, 22 May 2024 17:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="33AzliW3";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="MEfXPSey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DA688849; Wed, 22 May 2024 17:35:31 +0200 (CEST)
Received: from wfout5-smtp.messagingengine.com
 (wfout5-smtp.messagingengine.com [64.147.123.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3693388881
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id 696691C00180;
 Wed, 22 May 2024 11:35:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 22 May 2024 11:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392127;
 x=1716478527; bh=8daWqXHNwDUr4H7GVQ0TMa6/RYNmKYzu3tSgEmnLpxc=; b=
 33AzliW3gXFoxN9xZyIR9A08rLuUMrm7m+KpP7Zx3Dd4RNuaRVboM7Oo5gZc/sjl
 GoGP4E0cdit0IbVbX71O/9ANJQf94N0cv8YdVUDza18ShCdKXnoQLo7xj8fcfG+u
 5JylU6QNde7n0u6xQyZAFHvidsnZ4zu8jYX/QVu5Br7ag0tWFvUdc6Rtm1AMSDjf
 Ew9+6Pf1RIEVjrNukIObOT2/uR99HfFqfaWGov4WK/Nr+zXEqUZXD9n2Qe8obtVe
 xwK2eAEf2WqntZvQyeighD8t8rov1KtWMg8WdOhuOUB8ihNzLFHkF3bmwMom2xZw
 Af2KRciarTkn1TlRDCO64A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392127; x=
 1716478527; bh=8daWqXHNwDUr4H7GVQ0TMa6/RYNmKYzu3tSgEmnLpxc=; b=M
 EfXPSeyMRNE3hnVWKp9s9ct7gmgC3ZfQ8+cTsXdPvyYniiIEheQ8CS86CUmCjiIv
 7PZ4g6PV5VT5f0cxmMgjzWUjTm1jlfHeQavOEyjphLfd4n+Gg+3m7ulXheCr3kmb
 Eq+AnkPcj5J6H1+itndZQjskakZiKxWRldwlYCKLP99H5JEg09yLORctTVfr9QDE
 pbAgnwLphEVZyjFp98py+nMKAqCFSmuQx9W0J5mwi0PAW36vrulEGENob9V9NI+g
 G9LO7CvTSW8wBB/jLGJF+oATqx+ouvdfAQsr1OY6+vse354eD4F20CJxqdXjnOU4
 dQYOLM4MCAX5bCtXx85bw==
X-ME-Sender: <xms:vhBOZh3L1vS-l1JPQ25HWyXhpQdrAobK7kO0hb9aXOFnFfpo5kTLZw>
 <xme:vhBOZoGlouZjeViFg2VVhdy-HhJcKCqeKTpl-GDBfzgZNJiGTJPTylYlzzxn5TqyP
 I4cTSypY_Im2UKwjkc>
X-ME-Received: <xmr:vhBOZh62PryJEZBooTlQxRvVDn3-1fefk06ci1ZjToKu9naMCZBHFK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:vhBOZu3q3aq9WB4Jz-FDhG-kzgYgmREvQEDFpa2laW53tg3DlvMC8w>
 <xmx:vhBOZkG5TXYCRzvzcqS1H2MquMCBzeVEJ7KJD8bIseosBVwI7ZD0YQ>
 <xmx:vhBOZv_iWtqNRs80I_tb0l9P5RLj5ihXMXyX1Uog9wmQ-nIJceI9bQ>
 <xmx:vhBOZhlSVXhMnI-idtyKmmrk10tuIdl6lyTsWz60NqkyIdhHIoB7YA>
 <xmx:vxBOZp4xsWz9xRQ1FOYSB2G_3h31qmrdOa-t9xUW0u2kA171OnZXS-TP>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:25 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:54 +0100
Subject: [PATCH 11/16] LoongArch: Generic CPU type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-11-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=+liNdnJHPI6s4GWBLwhXuSXAC+ptaVoQ+IcIdPQW1sM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geUuV26H9P2JMT2ltsA64BSj07XPxi2Jl+ZP2jBV6
 +Xpbt77HaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRazsZ/se6Mmr3H7Z5tvNb
 5TrPJMnmi7FrutVsPp37Wz3D4V0lpy0jw7mQecxJFdezFrK9u6Vvv1Ipx+rTX63Xs+VvzHlgvmX
 bVz4A
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

Provide a generic CPU type with some common routines
that expected to be implemented at CPU level.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
 arch/loongarch/cpu/generic/Makefile |  7 +++++++
 arch/loongarch/cpu/generic/cpu.c    | 22 ++++++++++++++++++++++
 arch/loongarch/cpu/generic/dram.c   | 21 +++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 109d37d8e2c7..5254afb2cd05 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -12,6 +12,7 @@ endchoice
 # board-specific options below
 
 # platform-specific options below
+source "arch/loongarch/cpu/generic/Kconfig"
 
 # architecture-specific options below
 choice
diff --git a/arch/loongarch/cpu/generic/Kconfig b/arch/loongarch/cpu/generic/Kconfig
new file mode 100644
index 000000000000..ac7556d6d4d0
--- /dev/null
+++ b/arch/loongarch/cpu/generic/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+config GENERIC_LOONGARCH
+	bool
+	select SYS_CACHE_SHIFT_6
+	imply CPU
+	imply CPU_LOONGARCH
+	imply LOONGARCH_TIMER
+	imply CMD_CPU
+
diff --git a/arch/loongarch/cpu/generic/Makefile b/arch/loongarch/cpu/generic/Makefile
new file mode 100644
index 000000000000..c98d63b4f831
--- /dev/null
+++ b/arch/loongarch/cpu/generic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+obj-y += dram.o
+obj-y += cpu.o
diff --git a/arch/loongarch/cpu/generic/cpu.c b/arch/loongarch/cpu/generic/cpu.c
new file mode 100644
index 000000000000..5c849faf2bac
--- /dev/null
+++ b/arch/loongarch/cpu/generic/cpu.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <irq_func.h>
+#include <asm/cache.h>
+
+/*
+ * cleanup_before_linux() is called just before we call linux
+ * it prepares the processor for linux
+ *
+ * we disable interrupt and caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	cache_flush();
+
+	return 0;
+}
diff --git a/arch/loongarch/cpu/generic/dram.c b/arch/loongarch/cpu/generic/dram.c
new file mode 100644
index 000000000000..101b45786194
--- /dev/null
+++ b/arch/loongarch/cpu/generic/dram.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base_lowest();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}

-- 
2.43.0

