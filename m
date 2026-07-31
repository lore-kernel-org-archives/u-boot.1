Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B08DC5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90593813CF;
	Fri, 31 Jul 2026 12:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGsfInMLUDrU; Fri, 31 Jul 2026 12:08:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 814DA81300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785499695;
	bh=yOMfkmpktTPSxMAfnyF7zPWDFitjcZRufG41A8CY+dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6E/EtaEYKdH2MAcWMaz4BKqC458Hyf0CrrVKG5y73iAGa9wEEJLYe3E//zDwO2u7
	 1teOgpG01Ug/juodaWweNDBUUhGZ5Wjpuc06m+UmZQckwa1pxMmblYyGMGxvhd0JwU
	 hXy8lzrSy8lCDlYGz9+zt7cwdBiT+RFOkPTWxe9PtmQE/QCo5sizUwL6uY15t4LWbx
	 y0onET2cF677KqsLou40QrxNeGqcBGRUpqG4NDZh9spOxjC4ppATwqqctHiGZhorUs
	 C+8escMd/BSFh8Z6dNJ0qi/v0YwB8ZAyA3xWPRSfFJ2KaTScouiRKD6FRHphHDRC9d
	 eg+YFGxkIIqaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 814DA81300;
	Fri, 31 Jul 2026 12:08:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99FAF36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 814BC60B11
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KNyvg7hnORh2 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:08:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BFD8E60AE2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFD8E60AE2
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFD8E60AE2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785499683; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N96R29JznT6EmGqS3FTqeToqq0L97ZKlpOdkOS+L2RE2ynKfrYSUqEKLoDyvklPpLmn1Cj0wO7y3QpOaUFlr1IGrawiqOYuiVRJo6btGWl/Gpk5TaqTF7jyyff78SCBwAJkl/68M9a5d3m+Wm1lcdrbs6tejx4BBfd2k5cu+83k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785499683;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yOMfkmpktTPSxMAfnyF7zPWDFitjcZRufG41A8CY+dE=; 
 b=mMbQ4QGMROoG16o969aUzdtXDNq+vqNpz/dsH2e0y9t3zf+nr6E1pCCBIXDBBNwKhg0SE4SCI0qfS8CDtnxDrALWEF1HGtdptyAmjzLEbrRGLosmRLwQS6GPZIX3sAm+KaXelabo2uxK8bzmb72dgTJKtqO0mJcrBVH/rlvHiYM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785499682148359.7322298275071;
 Fri, 31 Jul 2026 05:08:02 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Subject: [RESEND PATCH v2 2/2] CI: Dockerfile: Add LoongArch64 support
Date: Fri, 31 Jul 2026 12:07:50 +0000
Message-ID: <20260731120750.2212394-3-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731120750.2212394-1-me@ziyao.cc>
References: <20260731120750.2212394-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785499683; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=yOMfkmpktTPSxMAfnyF7zPWDFitjcZRufG41A8CY+dE=;
 b=FyeFwYpXyQVhc/+LoFXtzE6jazHXUzEXGis+eDE9ZMpxVzF8EUsrR5w6b2svggRb
 8cluTh9z7pXm9YyE0Ic3zAPbrmUbQgWHVfLUzgXTsQ/18UDROLCTHHFP3dfZY6OHGev
 NXJGLEVFTy8iFaNPxlVeXH2IXw91ObWd0lg+nF6g=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=FyeFwYpX
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Install LoongArch64 toolchains, build LoongArch64 QEMU,
build LoongArch64 GRUB.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 tools/docker/Dockerfile | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index fb8e2c523aad..187320c26d59 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -17,7 +17,7 @@ ARG BUILDPLATFORM
 ENV DEBIAN_FRONTEND=noninteractive
 
 # Set architectures to build for (leaving out ARM which is an exception)
-ENV ARCHS="aarch64 arc i386 m68k mips microblaze nios2 powerpc riscv64 riscv32 sh2 x86_64"
+ENV ARCHS="aarch64 arc i386 loongarch64 m68k mips microblaze nios2 powerpc riscv64 riscv32 sh2 x86_64"
 
 # Mirror containing the toolchains
 ENV MIRROR=https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin
@@ -153,7 +153,8 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	xxd \
 	zip
 
-# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
+# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit, and LoongArch
+# 64-bit
 RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.14 && \
@@ -189,6 +190,20 @@ RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	search search_fs_file search_fs_uuid search_label serial sleep test \
 	true && \
 	make clean && \
+	./configure --target=loongarch64 --with-platform=efi \
+	CC=gcc \
+	TARGET_CC=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-strip \
+	TARGET_NM=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-ranlib && \
+	make -j$(nproc) && \
+	./grub-mkimage -O loongarch64-efi -o /opt/grub/grubloongarch64.efi --prefix= -d \
+	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
+	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
+	search search_fs_file search_fs_uuid search_label serial sleep test \
+	true && \
+	make clean && \
 	grub_cv_cc_mcmodel=no ./configure --target=riscv64 --with-platform=efi \
 	CC=gcc \
 	TARGET_CC=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
@@ -232,7 +247,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
+	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,loongarch64-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-- 
2.54.0

