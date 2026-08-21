Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EDAC5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24C9B8111A;
	Fri, 21 Aug 2026 08:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mfs5y8jqpZ_i; Fri, 21 Aug 2026 08:45:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301915;
	bh=GLXko89Oh0+4RWKag/ACpp1u6LBUCKApkM/e4HolWEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6UTOawSVYFksoC2EvAxCmsKjbc6CjMyiM/Yl8t+4JL05bLqUGX7XhsBC6jx4bUKn
	 rEQsxUyAHCs6fGwcgub48MRa4K6MBFn7uC/7zDTWOoXgW1GxTGc7GEvtdcg0k/Vadf
	 yl4g2KIeHw8MrzshnFwzo3D81jMeBg5y8/LpaYGw/lVd6YLdIRRLVWBzPl16LzUoH7
	 AEl9va4Hf0jYs4G29K3qR8zTduDeCURLtwdvS3ywOxm3AQhUCJQ16Vb1tp8VqWAOPI
	 0TWnOgWDQdSiB8kx61euJolROcXQggC4itX0H0JaA9vP1k7XTQH4tGLeFDqGz3Ewp/
	 lY/ZUZVth/hpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 312AD8112C;
	Fri, 21 Aug 2026 08:45:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A28C1B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F16940927
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r1z-9rx5Qcch for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:45:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=LY3rBdAK
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 820F840911
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301905; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U3inVtZx3Rxh0L2GCqqlqAp3einii+WgqNhZ8cqltL7u+un+WZwCgP6gYQ7N3GDVOGgpbMz2in7hvyleCHynMhPFXEx012S9KfGRCN9K6fgtqK230+VvkS3HuJbqJddKw+YWLqHuoRHorWdf0SO9fsA+THj1COUxRTtEOMuZDDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301905;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GLXko89Oh0+4RWKag/ACpp1u6LBUCKApkM/e4HolWEw=; 
 b=VOoU70LF/kNKJ3vAYdtmHsbK2BoRjLF6FIeQhMZuTJPTJd1RLsTXpwnms4jKL8sBtj1cKv7i88tTyUJz9lMsykf6d5I/cLemmKuUuq/aUDUColHrUyvwR5CQY2sCsZKWqa0sIeP8bbJlrpd1BQDvDQw5BcPBMDhe7mKId4+t9Z0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301905; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=GLXko89Oh0+4RWKag/ACpp1u6LBUCKApkM/e4HolWEw=;
 b=LY3rBdAKkvJ3EVg/1ZEpa+19OTvG2JIbCrOqAlF+62ciAckWhOh0xP30zq3A+yMV
 5axDS3/WhfEoaCR05dkBntx0mi/BWyyS8rC5ArsV91XQ/Vm609FqgJWUJu96WJbmZ67
 wShnnsGvyXCf1qR4Ntj6kAk9Dljs7I1xknSqA4sY=
Received: by mx.zohomail.com with SMTPS id 1787301903404670.6522515543304;
 Fri, 21 Aug 2026 01:45:03 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 17/19] doc: arch: Add documentation for LoongArch
Date: Fri, 21 Aug 2026 08:42:17 +0000
Message-ID: <20260821084219.1703743-18-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Add a brief introduction to LoongArch architecture, some notes on the
implementation, and the toolchain supporting status.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

New patch since v3

 doc/arch/index.rst     |  1 +
 doc/arch/loongarch.rst | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 doc/arch/loongarch.rst

diff --git a/doc/arch/index.rst b/doc/arch/index.rst
index 60c93b3b6640..10903b806d2c 100644
--- a/doc/arch/index.rst
+++ b/doc/arch/index.rst
@@ -9,6 +9,7 @@ Architecture-specific doc
    arc
    arm64
    arm64.ffa
+   loongarch
    m68k
    mips
    nios2
diff --git a/doc/arch/loongarch.rst b/doc/arch/loongarch.rst
new file mode 100644
index 000000000000..d744db6a4999
--- /dev/null
+++ b/doc/arch/loongarch.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+
+LoongArch
+=========
+
+LoongArch is a RISC ISA developed by Loongson Technology. It currently defines
+three variants: a reduced 32-bit version (LA32R), a standard 32-bit version
+(LA32S) for embedded devices, and a 64-bit version (LA64).
+
+Notes
+-----
+
+1. Currently U-Boot only runs on LA64 variant with the highest privilege level
+   (PLV0).
+
+2. LA64 is distinguished with 32-bit LoongArch with CONFIG_ARCH_LA64.
+
+3. U-Boot expects hardware-maintained coherency between I-D cache. Cache
+   topology is probed through CPUCFG; L2 and L3 caches, if present, must be
+   unified or instruction-only. This is true for all commercial LA64 hardware.
+   Refer to arch/loongarch/lib/cache.c for further description.
+
+Toolchain
+---------
+
+LoongArch is supported in upstream binutils, gcc, and LLVM. GCC 12.1 started to
+support LA64, and GCC 16 started to support LA32.
+`kernel.org <https://mirrors.edge.kernel.org/pub/tools/crosstool/>`_ provides
+pre-built toolchain for both 32-bit and 64-bit LoongArch.
-- 
2.55.0

