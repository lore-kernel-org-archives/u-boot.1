Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2D0C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBAF488813;
	Tue, 11 Jun 2024 23:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="JQ2LaPyg";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4+SXoQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69CEB887FE; Tue, 11 Jun 2024 23:05:01 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01404887DB
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 016161C000EF;
 Tue, 11 Jun 2024 17:04:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139896;
 x=1718226296; bh=VuwniDOIikTVr/NSBMtljsRgfd50WHxDuzPnH6QA908=; b=
 JQ2LaPygyAGZyN5Wv17FV2gtCWDm/yjo0Qm7jmv/4ulxQ7a2rVpBoaE21k07bTCn
 Yvigt+QGPoDTz62mXMXQFZPqJj5ZDp14BDCu1S8vhIonO6RVrKLCRXOuuF+IRhwi
 jkUkTRJe1zHmZ+waDqvdab7Mw/5oTrmWrWjNciyWJTgBJg3tRf7IAgFoegT7kUM4
 TzrWHp1N/S35+1ULA0/WpEZ65V4JAVjI1cxgaehpGvBYqGd4sqhJMMe79auqgcAf
 O++O2SWnGUyEaqxuRTglMA8T1qDN8NrVbSFZyCiS2PaO4XJicahp/spASJFYN8Ow
 teHEnJoXAwszsTygWedZAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139896; x=
 1718226296; bh=VuwniDOIikTVr/NSBMtljsRgfd50WHxDuzPnH6QA908=; b=B
 4+SXoQWJUZmCbfiGNHfxK2XmXNJxjz2KyyR/y+9zbeXQGNGr5n38t0BYkUvt4Ir+
 sK7/fgbQWlNtTed7W4Vdm9LdfJEshRBYYGCzigcWsuPgGyq3pmwUf+ZZ+M2iEyCn
 zNvQ1vOz05wR/nxyox4Ccfzm/tlCkxxPQ/4xv+14jDI0eCUHzSszyHy4mRQydiEt
 MwZH7PeEmVAMqQ9/qU60q9BsZZ5nLz0W8/6sXajJZwceaQSuFzWaqruy+VGsxUln
 2W09s9GtqEIYF7pHwXQcDxjP0nYDM9Z2GOx+zpwHrOZO/82EpLW83BEsiy0XFaWa
 iZ6VLTQkTVIBC3Aof90iw==
X-ME-Sender: <xms:-LtoZgMeF30GqDWsJwc-Ya2g6OtXjLtH0PEv-wsX5S5p_ACTjkYJQw>
 <xme:-LtoZm-ViJTIf-tTyNMajqNdxPb_-4jEkcBJR-BTI0urRfPq7p2ezVV6P-ff4tlki
 n5dXVfx1Vh7JYdYegY>
X-ME-Received: <xmr:-LtoZnSyHfCqG46xgo1jyCoRwPUltLIxucen7aKL8u7YLYo1GBDf0es>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpeehteeiudfhtdeuleejveeigfehkedvheevgfeglefhieeh
 ieffgeffvdeutddvudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgnhhurdhorh
 hgpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
 mhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:-LtoZoufzErjOrGI7A_UoEyINlByEv0rU8v9TDrb6-eDHnzbtgjcig>
 <xmx:-LtoZoeU3oqCP9YelZMBQAE2m6c-4L0vaHF0gzf7nmdq_oTzhCtAhg>
 <xmx:-LtoZs0jkZlAvgkOPxrVqoOErMUxS3E3PO18-iCUvVkHxBSpQhhPYQ>
 <xmx:-LtoZs_9jwLvde53JMctaJcrnqrvkMDcNOlFjCGlRv_wMFB33detfQ>
 <xmx:-LtoZvwfLsemkA8Wg7Enle1TOdkGFajnjrnUlFCkXQXqft2S1SCXseJl>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:55 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:16 +0100
Subject: [PATCH 17/20] CI: Dockerfile: Add LoongArch64 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-17-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4160;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=bj5jijC301W/sLQ0F7C+UlHOs92vCFpXQzlewLYMCsk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3eeU13E/ivb6lrBG/ILaH7u4cI/8t+1TN4vuOxC26
 ZHqCzuLjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIwgSG/06rakuPpQR9/iI9
 mb8sK9Uu4ZMv31R+H8M+/vQZWVKzVzIy/Hl4MUxu1vkdqSd+/LSQ06uc8GrNb4F41YibRdUrvpU
 xcQIA
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

Install LoongArch64 toolchains, build LoongArch64 QEMU,
build LoongArch64 GRUB.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/docker/Dockerfile | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index e3b2c2d57555..26b0e36fec05 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -19,6 +19,7 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-arc-linux.tar.xz | tar -C /opt -xJ
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-arm-linux-gnueabi.tar.xz | tar -C /opt -xJ
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-i386-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-loongarch64-linux.tar.xz | tar -C /opt -xJ
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-m68k-linux.tar.xz | tar -C /opt -xJ
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-mips-linux.tar.xz | tar -C /opt -xJ
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-microblaze-linux.tar.xz | tar -C /opt -xJ
@@ -131,7 +132,7 @@ RUN git config --global user.name "U-Boot CI" && \
 # Make kernels readable for libguestfs tools to work correctly
 RUN chmod +r /boot/vmlinu*
 
-# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
+# Build GRUB UEFI targets for ARM & LoongArch64 & RISC-V, 32-bit and 64-bit
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.12 && \
@@ -165,6 +166,20 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	search search_fs_file search_fs_uuid search_label serial sleep test \
 	true && \
 	make clean && \
+	./configure --target=loongarch64 --with-platform=efi \
+	CC=gcc \
+	TARGET_CC=/opt/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-strip \
+	TARGET_NM=/opt/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ranlib && \
+	make && \
+	./grub-mkimage -O loongarch64-efi -o /opt/grub/grubloongarch64.efi --prefix= -d \
+	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
+	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
+	search search_fs_file search_fs_uuid search_label serial sleep test \
+	true && \
+	make clean && \
 	./configure --target=riscv64 --with-platform=efi \
 	CC=gcc \
 	TARGET_CC=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
@@ -183,7 +198,9 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
 	git checkout v9.0.0 && \
-	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
+	git cherry-pick 16b1ecee52effa3346fb34dcc351e4645e4ab53e && \
+ 	git cherry-pick 085446905000d6b80978815594a7cd34d54ff46b && \
+	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,loongarch64-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 

-- 
2.43.0

