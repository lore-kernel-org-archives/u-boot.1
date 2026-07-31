Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72A9C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55F0580E4F;
	Fri, 31 Jul 2026 14:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0abfOnGYpc3; Fri, 31 Jul 2026 14:37:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1E7580CEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785508633;
	bh=y9vJE3d946722X/1Bhxfyv37K62sj6nMqeZ/UAUospw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BlXNOVSuQyFfNTehs5H6BJHBo6LlzeCGtyTg3LyjQZmsk6LQEhN3YyHHgLwVSO80g
	 fezwE06ftgBuiPbig+cuP3scD+eGNKNCHobTKkMbc+tzbMEB8AF4btDjh6ZBjI97z9
	 h9IjpV7UNBXmt8DWN9vKA1nzkqZY63UNReWj3epSy3nMB7ffdOTRYhpGDjtNrtjyAk
	 DtHtC62f3jWUCGIVAF3r5XoH354CAzFOV44EI/yp23hr/9FMhY6Mz6kj6fLkHa+ou/
	 rZo3X33PzxrXw8s8V1JMyXp/pIuP2OcUZ5ZPpybJBuw0ypAHSCebrO5bTSNcOlORRf
	 RFd6ImoWm8tew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1E7580CEC;
	Fri, 31 Jul 2026 14:37:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D63037F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 236A260650
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMROGB9jRkXW for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:37:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0EDC160642
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EDC160642
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EDC160642
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785508624; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mlX/kdqwX36FdvpVkwH0pUMD20iOgdGa8c0DK36QD5YvxIkNTTkVPRk2Vqg8/QPSnhp0iBJJZnY1Lfu6KjzMAHhSCM4rnSzs1cBM7enQn41NFtuQ0Q5QtBb3avvI+AHPqT4P+PHDNIKGf6AUq25PpUdRjJ/D6FbYcgwftlthJoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785508624;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=y9vJE3d946722X/1Bhxfyv37K62sj6nMqeZ/UAUospw=; 
 b=npdzCRuKsLtzrIBCqRSGbcb0NX78kHRI9rcAiJJmHYY4pFZL8DwQZcMz830vSxT2qdEE62ohhc22aEzwGd+8JlwVzsp7mg73ylbvXwvuGJKEfMtzfEiIjwrw9PwbBVfVAv4D2NdiLecMwFgkeb+gj4P0EB6SY1wFCH+TsU5gVcw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 178550862109414.307321792962284;
 Fri, 31 Jul 2026 07:37:01 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:36:51 +0000
From: Yao Zi <me@ziyao.cc>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 2/2] CI: Dockerfile: Add LoongArch64 support
Message-ID: <amyy2Lyg2Xypz__p@pie>
References: <20260731114720.2212170-1-me@ziyao.cc>
 <20260731114720.2212170-3-me@ziyao.cc>
 <23f5f012-589c-4710-8b93-4c6bd509e4c4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f5f012-589c-4710-8b93-4c6bd509e4c4@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.486.37
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785508624; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=y9vJE3d946722X/1Bhxfyv37K62sj6nMqeZ/UAUospw=;
 b=GN+BZUFoIMvBc3F+P3otADxGn4ng7NirYbJA3sMdb4BsglEyb2DyK4DwZB7ZN6Ib
 JzeEXbpWgMaO94Rh/HrNfyJjT/E3kp0ibefUSGluB/7ktPfQ+2EmdDzlowOrODKKd7m
 xvDgHtlFEInJVxzMe+F20uPlc1aA5KoReZoGTxeA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=GN+BZUFo
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

Adding the list to Cc so at least this discussion could be archived...

On Fri, Jul 31, 2026 at 04:16:38PM +0200, Heinrich Schuchardt wrote:
> On 7/31/26 13:47, Yao Zi wrote:
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > 
> > Install LoongArch64 toolchains, build LoongArch64 QEMU,
> > build LoongArch64 GRUB.
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> >   tools/docker/Dockerfile | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index fb8e2c523aad..187320c26d59 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -17,7 +17,7 @@ ARG BUILDPLATFORM
> >   ENV DEBIAN_FRONTEND=noninteractive
> >   # Set architectures to build for (leaving out ARM which is an exception)
> > -ENV ARCHS="aarch64 arc i386 m68k mips microblaze nios2 powerpc riscv64 riscv32 sh2 x86_64"
> > +ENV ARCHS="aarch64 arc i386 loongarch64 m68k mips microblaze nios2 powerpc riscv64 riscv32 sh2 x86_64"
> >   # Mirror containing the toolchains
> >   ENV MIRROR=https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin
> > @@ -153,7 +153,8 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >   	xxd \
> >   	zip
> > -# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
> > +# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit, and LoongArch
> > +# 64-bit
> >   RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
> >   	cd /tmp/grub && \
> >   	git checkout grub-2.14 && \
> > @@ -189,6 +190,20 @@ RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
> >   	search search_fs_file search_fs_uuid search_label serial sleep test \
> >   	true && \
> >   	make clean && \
> > +	./configure --target=loongarch64 --with-platform=efi \
> > +	CC=gcc \
> > +	TARGET_CC=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-gcc \
> > +	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-objcopy \
> > +	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-strip \
> > +	TARGET_NM=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-nm \
> > +	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarch64-linux-ranlib && \
> > +	make -j$(nproc) && \
> > +	./grub-mkimage -O loongarch64-efi -o /opt/grub/grubloongarch64.efi --prefix= -d \
> > +	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
> > +	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
> > +	search search_fs_file search_fs_uuid search_label serial sleep test \
> > +	true && \
> > +	make clean && \
> 
> We repeat ourselves a lot in the Dockerfile for building grub.
> 
> How about:
> 
> for arch in aarch64, i386, loongarch64, riscv64, x86_64; do
> 	./configure --target=$arch --with-platform=efi \
> 	CC=gcc \
> 	TARGET_CC=/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-linux-gcc \
> 	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-linux-objcopy \
> 	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-linux-strip \
> 	TARGET_NM=/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-linux-nm \
> 	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-linux-ranlib && \
> 	make -j$(nproc) && \
> 	./grub-mkimage -O $arch -o /opt/grub/grubloongarch64.efi --prefix= -d \
> 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
> 	lsefi lsefimmap lsefisystab loadenv lvm minicmd normal part_msdos part_gpt
> reboot \
> 	search search_fs_file search_fs_uuid search_label serial sleep test tftp \
> 	true && \
> done
> 
> Adding a few more modules to each architecture does not harm.

This is a good idea, but some of grub file names don't match the arch name
in the triple,

- i386: grub_x86.efi
- x86_64: grub_x64.efi
- arm: grubarm.efi
- aarch64: grubaa64.efi
- riscv64: grubriscv64.efi
- loongarch64: grubloongarch64.efi

so we need a mapping between them, maybe a bash array. Or, these names
seem to be refered only in u-boot-test-hooks as
env__efi_loader_grub_file, so I think alternatively we could update the
repository to use file names consistent with the tripple.

I'd prefer the latter since it looks cleaner, though the change might be
a little complex to fit in this series (involving updating workflow and
u-boot-test-hooks in a correct order so no CI run gets broken).

Best regards,
Yao Zi

> Best regards
> 
> Heinrich
> 
> >   	grub_cv_cc_mcmodel=no ./configure --target=riscv64 --with-platform=efi \
> >   	CC=gcc \
> >   	TARGET_CC=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
> > @@ -232,7 +247,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
> >   	# config user.name and user.email to make 'git am' happy
> >   	git config user.name u-boot && \
> >   	git config user.email u-boot@denx.de && \
> > -	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
> > +	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,loongarch64-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
> >   	make -j$(nproc) all install && \
> >   	rm -rf /tmp/qemu
> 
