Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1AFC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F6B388A66;
	Wed, 17 Jul 2024 16:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Ypwm6Ids";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGyEyz6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AF688AA5; Wed, 17 Jul 2024 16:30:57 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F69C88A48
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 95E4111400FA;
 Wed, 17 Jul 2024 10:30:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 17 Jul 2024 10:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226653;
 x=1721313053; bh=Cv0zjo6OyoAZHNEq65EiOIoiiHEYSpsunDaqFZ6jSB8=; b=
 Ypwm6IdsolDARvHdOG1JniyS6ebCKCyMamWfK/YoejZ83GWmCesGhsce/k6ue8Qk
 2bY/za+IQ2AdIpUKprg+Vqz1txVUsYaIoxFJ9n8oXtjnpDp4AbDPxODyBXBsQi1o
 S4zGB6RLsFMc6/Kw/oT0hF1gULuYRUvTT5c1KMnjWM/bZ99n1m40cZt9fwS2hUMN
 whOqyn9+ji67RQmGE3orvWEKSPuT35DCI+5VhB/++wo25Eeq3CPF2buM0LH9R5bE
 8jZgVUt+9RSIkZDFBola5Y6zw632jqLP7JB2YG5OD9jm9x5nUx7n0NX4rXc7kwEh
 M1/1nDV5vTOdjD/sECWT6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226653; x=
 1721313053; bh=Cv0zjo6OyoAZHNEq65EiOIoiiHEYSpsunDaqFZ6jSB8=; b=X
 GyEyz6iNCL+vwb+n4cRonVhSZ7kocEc0we34feYGoeehMdku0B7fXqJ/BX2gFNPm
 iaA08FmeBC9KGO20U10R0NUZchYD+B49MKdVPsO9Gk1TAjVs1dDhiKPtFJyKWgNa
 x2JxCn64fRkiWkv6+h+AW8eT3sGCkscTyPO4YSgktA/bw+eAnmqNsVEjQ2WNgvsf
 619v5atsDXXoXI4hVlnpBCIsxDRe8GTDhlOIMkIw1VO6jZ6T7Sv1qcPgdW72Iy9L
 Ynf/5bmdhP7NqOIifxebJ3WBkXBtyeejECs2UVzBZtP0xPIbOE4knRLcIRGeGhKr
 vL9+oyHtqqumwGwphjOFw==
X-ME-Sender: <xms:ndWXZqjSQ0Q2r2wujJONwFtUPrL4NzJI3LEmCctCErCt26zX63riGw>
 <xme:ndWXZrC9-Sqs2ZqIU5q5r8ZMp0dF61fZdxTXO86Swe0TDIjc62366QqNaUrX43neG
 aEFkvjvJ3xpCMMHSZk>
X-ME-Received: <xmr:ndWXZiE8YiLyiDy6SIdTRPqbsw8Aj2e1Q4NCWlq0ubVL_bjpddqmXbhe-DMyaBqUE5BG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeehteeiudfhtdeuleejveeigfehkedvheevgfeglefhieehieff
 geffvdeutddvudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgnhhurdhorhhgpd
 hgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:ndWXZjSsKDc6r5DuoqNWXN0Pbt_s1De1gRtlL-gjT9lFGkb9VrNiKw>
 <xmx:ndWXZnzOOxtgMVuj0JIHslUvUSJuoaYYC8_7R7Dc9yv6n5M-HRBkKQ>
 <xmx:ndWXZh7vMLcWwjr-KaIWJSuAnCJ0Xg45v3rHjASXn1bIBWEYJgTLiw>
 <xmx:ndWXZkxV8Nwxt7C9qdd3FEOHIY-XG_BknvDLWY-Lk4uISgv9SaPlRQ>
 <xmx:ndWXZuwTDsMTLzDa3RqmlftasGPgxwC-2nostCXDG1XtbYvCO64vSlWT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:30:49 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:28 +0800
Subject: [PATCH 17/18] CI: Dockerfile: Add LoongArch64 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-17-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4027;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=cXHzxSbZrEaS8hfAvzJFJrMewJ8yO8KoiMbAEWIrPHg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV104LhlMV2fIltgrFHZ3t/67zHOPV5fOrqn8zr4h4
 sWKGwGnO0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAims6MDN+u7PfaI+fKsU+T
 69L+aIuo8/5XEw1mtFQn2l5PvLNIyoGR4VmNwvTgoNZf9rb6S0u1T9bIf6jd27dcbVeDoTBD3Lc
 oRgA=
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
 tools/docker/Dockerfile | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5ff1ac449e1f..3522c3627af9 100644
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
@@ -133,7 +134,7 @@ RUN git config --global user.name "U-Boot CI" && \
 # Make kernels readable for libguestfs tools to work correctly
 RUN chmod +r /boot/vmlinu*
 
-# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
+# Build GRUB UEFI targets for ARM & LoongArch64 & RISC-V, 32-bit and 64-bit
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.12 && \
@@ -167,6 +168,20 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
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
@@ -185,7 +200,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
 	git checkout v9.0.1 && \
-	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
+	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,loongarch64-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 

-- 
2.45.2

