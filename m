Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0081EC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FEA88811;
	Tue, 11 Jun 2024 23:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="aqK9UbVN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="MabG8kpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA768881F; Tue, 11 Jun 2024 23:04:59 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B8B88813
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.west.internal (Postfix) with ESMTP id 77C741C00178;
 Tue, 11 Jun 2024 17:04:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 11 Jun 2024 17:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139894;
 x=1718226294; bh=+qcMdSgXpHGutY8CBF7lo8lu51tWpDPRli+5vctuUyo=; b=
 aqK9UbVNN81mR7MhYbh6993NzDYYUkXZ0eU+iLg99/gr0hjbHG6lBfLEzkXbFlW6
 d5K9C6hlWS91WVadtP0SHrOH1exKC7mBGR36x5BR2f2nHv6RtOaI6dy4g8s3fn7G
 QojFtKaA7i3ozNQl0xSUiTHIpi9OoPqpMAJ+aQyS2TArbRN4KzvfetjdLMDcCHA4
 aPB648SN1DUe42GHehI6q4xhUOuWJLy7kcAb0E6n00yLNu2MNeXAU/jTS093UcY5
 5GhBjAN2nZX7x9fYJvyBiZcrG/vQR/q0qIk9J15BAUvJRwTo1ek+GwupVW4nZI5s
 BD0OhaYrYpwvJpVboX6gFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139894; x=
 1718226294; bh=+qcMdSgXpHGutY8CBF7lo8lu51tWpDPRli+5vctuUyo=; b=M
 abG8kpaep/IxPw5oAg9CicHqSPXRl+HGQSSjpTsxwROyhPEwjdzCZZZksOUUJvXU
 2178EGgnLES6NUD1ZjFvkiFL8mTcckO/V68ZgUGE8nVeS/3PNylukuA3exqQKpit
 ms4XbsIJ2MyXrhm32wPKvHjgPJ1oSetgsNK3DFm+iSiERDvCrjUvnUJNrzQlBkzk
 Hk0J/WPqWERDKXqoMq/ZMiRhvtZ0SWpLjdV85WC4/irhF1G8ac8l6QKhta3OThPu
 JZ+VHoQnUV5PiWQzzGZaRp7PA08pHDdSM3td87GaJDJPV6GZzXgaBPPdLrMUEynF
 0thdOcNwN9JDPxT4DnQDA==
X-ME-Sender: <xms:9btoZpnSefCfxgATjjsl3USyzc1GebhN0lL1KwXtSeUtV4oB9ZNCng>
 <xme:9btoZk09FvJUrBxcRaqJChoopOL5HdcX8ycogo5DlzfWoe2MFWjoPMRahQ5NwMHzL
 Cqo3eAqGt85O-QIrzM>
X-ME-Received: <xmr:9btoZvqf505CwhgQIOi6oLr2kc4dukc-yc6G_NbllRExe3OS-zaAueI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpeevkeefjeffieejuefgtdfggeffjeefgeffiedugedvvddv
 ueefueefffeihfekgfenucffohhmrghinheplhhlvhhmrdhorhhgpdhkvghrnhgvlhdroh
 hrghdpghhnuhdrohhrghdpghhithhlrggsrdgtohhmpdhtrhhushhtvggufhhirhhmfigr
 rhgvrdhorhhgpdhgihhthhhusgdrtghomhdptghorhgvsghoohhtrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:9btoZpkltT3F3JrIhfcOiFg0V3yHfEJMqfsvQ0t63d8t0mUcSTW4KA>
 <xmx:9btoZn08OJnSAoQZt8uIUokM4wRaxZe24PyGo6CuJmWfhGZCX7obNA>
 <xmx:9btoZourbG3uROelCe9l_c4ex73DN4hijevPN5GsgxkxFlBwC84osA>
 <xmx:9btoZrV9JVoeHhl_YYVPUM642TwSDXuMD6FBaiysk9pwotSC2lrc5A>
 <xmx:9rtoZgJ7Bk04HMxlyNw-HcIRL4TpFQ1UgEnTsxQoxRxoebg4jQeHze5j>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:52 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:15 +0100
Subject: [PATCH 16/20] CI: Dockerfile: Bump various software version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-16-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5723;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6O5Uwyojv6JUEBzmFxuROz1OzzUFhJrQKE0OQwh0jX4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3efC+lcstNn1dPONFaVnZ/j2bMv9Hi8Yu/ipxfuaz
 lSXLcf1O0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiaaoM//2a3Qtj5Jt/ualL
 pd6ffe1D0V+X47+Pv5La96d+0qYrZx8wMnzYeH9SmctaCcWolYYGJyw+VPTVM77lYJu4gS3/i7X
 8MT4A
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

Bump base OS to Ubuntu noble, grub to 2.12, QEMU to 9.0 (drop
cherry-pick for m68k as it's already in 9.0) and other tools
to latest version.

Remove unsupported python2.

Install some required python packages for buildman/binman.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/docker/Dockerfile | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5824d371f259..e3b2c2d57555 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20240227
+FROM ubuntu:noble
 MAINTAINER Tom Rini <trini@konsulko.com>
 LABEL Description=" This image is for building U-Boot inside a container"
 
@@ -12,7 +12,7 @@ ENV DEBIAN_FRONTEND=noninteractive
 # Add LLVM repository
 RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib/apt/lists/*
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
-RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main | tee /etc/apt/sources.list.d/llvm.list
+RUN echo deb http://apt.llvm.org/noble/ llvm-toolchain-noble-17 main | tee /etc/apt/sources.list.d/llvm.list
 
 # Manually install the kernel.org "Crosstool" based toolchains for gcc-13.2.0
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-aarch64-linux.tar.xz | tar -C /opt -xJ
@@ -55,6 +55,7 @@ RUN apt-get update && apt-get install -y \
 	gawk \
 	gdisk \
 	git \
+	gnat \
 	gnu-efi \
 	gnutls-dev \
 	graphviz \
@@ -95,13 +96,14 @@ RUN apt-get update && apt-get install -y \
 	parted \
 	pkg-config \
 	python-is-python3 \
-	python2.7 \
 	python3 \
 	python3-dev \
+	python3-jsonschema \
 	python3-pip \
 	python3-pyelftools \
 	python3-sphinx \
 	python3-virtualenv \
+	python3-yaml \
 	rpm2cpio \
 	sbsigntool \
 	socat \
@@ -118,6 +120,7 @@ RUN apt-get update && apt-get install -y \
 	vboot-utils \
 	xilinx-bootgen \
 	xxd \
+	yamllint \
 	zip \
 	&& rm -rf /var/lib/apt/lists/*
 
@@ -131,9 +134,7 @@ RUN chmod +r /boot/vmlinu*
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
-	git checkout grub-2.06 && \
-	git cherry-pick 049efdd72eb7baa7b2bf8884391ee7fe650da5a0 && \
-	git cherry-pick 403d6540cd608b2706cfa0cb4713f7e4b490ff45 && \
+	git checkout grub-2.12 && \
 	./bootstrap && \
 	mkdir -p /opt/grub && \
 	./configure --target=aarch64 --with-platform=efi \
@@ -181,10 +182,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v8.2.0 && \
-	git format-patch 0c7ffc977195~..0c7ffc977195 && \
-	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
-	git cherry-pick d3c79c3974 && \
+	git checkout v9.0.0 && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
@@ -192,7 +190,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 # Build fiptool
 RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
 	cd /tmp/tf-a/ && \
-	git checkout v2.10.0 && \
+	git checkout lts-v2.10.4 && \
 	cd tools/fiptool && \
 	make && \
 	mkdir -p /usr/local/bin && \
@@ -200,12 +198,12 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
 	rm -rf /tmp/tf-a
 
 # Build genimage (required by some targets to generate disk images)
-RUN wget -O - https://github.com/pengutronix/genimage/releases/download/v14/genimage-14.tar.xz | tar -C /tmp -xJ && \
-	cd /tmp/genimage-14 && \
+RUN wget -O - https://github.com/pengutronix/genimage/releases/download/v17/genimage-17.tar.xz | tar -C /tmp -xJ && \
+	cd /tmp/genimage-17 && \
 	./configure && \
 	make -j$(nproc) && \
 	make install && \
-	rm -rf /tmp/genimage-14
+	rm -rf /tmp/genimage-17
 
 # Build libtpms
 RUN git clone https://github.com/stefanberger/libtpms /tmp/libtpms && \
@@ -236,22 +234,23 @@ RUN mkdir /tmp/trace && \
     cd /tmp/trace/libtracefs && \
     make -j$(nproc) && \
     sudo make install && \
-    git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cmd && \
+    git clone https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git /tmp/trace/trace-cmd && \
     cd /tmp/trace/trace-cmd && \
     make -j$(nproc) && \
     sudo make install && \
     rm -rf /tmp/trace
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-4.22.01.tar.xz | tar -C /tmp -xJ && \
-    cd /tmp/coreboot-4.22.01 && \
+RUN wget -O - https://coreboot.org/releases/coreboot-24.05.tar.xz | tar -C /tmp -xJ && \
+    cd /tmp/coreboot-24.05 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
     make olddefconfig && \
     make -j $(nproc) && \
     sudo mkdir /opt/coreboot && \
-    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/
+    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
+    rm -rf /tmp/coreboot-24.05
 
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot

-- 
2.43.0

