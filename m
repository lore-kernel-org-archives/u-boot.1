Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79C606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mFY2HU4w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=jAjdU01d
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B76E8811F5;
	Thu, 12 Nov 2026 12:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ds3d5ODqZWkt; Thu, 12 Nov 2026 12:02:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD58D811D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484960;
	b=RwgUOtxsKfnXANSehXKg+87uEnEoo8Pr2N0HJRlfXu4q5DPQvgZcinNfrKJLWlN2FFlM
	 Qp7mkjrurXKKvdrfl20k8B3qtWIbqcYqblIQnExAcUYPwiVBICmhTzlpTLMv7aBC/g74X
	 kcqGFOumOZFcVzlij9tXqAo+EDWCrHwH1qLULMR9iLBuE3KhjeWAkwzPVIzGqKPPGhBp4
	 /JGydJcCh8vro91kpBAdELkg94wdFA7JJF5UG8GA2kmxS3NJsoPTRwQWVnBIoWRsSNHKL
	 XbsI3woulVgzPN6E2aoZ0wK5n3Qk27khR8Stb2tlzUBobmDES8nNs+O3jXpHm8Bw0OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=;
	b=rOZS+kjSkhJxiYVgG/ZhWLDQq/zfHXcvabx3yItbEU19wjNWaqhjLnv7vGe5R5KabMmS
	 ASEtkBDug/NTHlA27/XDkyyfAtqj1hSV5/KuAfN4epty5FlTY9Gvnvrsb52fzOl1rM/1F
	 AKBniIEY4/8uuu3ORAHsCncVi6prsltthHfX8pyjDKAMqldrlC8uFB4mj8SfhogpRJJ8K
	 sfs+MoP07AVa622J+Gk+rcBnjfhICRsXtJtpEtg3TpaDTvV3t/czH+UxPUDuWUm9pmTKU
	 7Tiky859imDQu8oxP+RqrGmuZULLg9Z3Pwvd1K9crfhxQqh+YcUZzVH98FatYjQIatw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484960;
	bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFY2HU4wQX0j+uM7/4q0YSFPc1lB0gmbyHJRp/IbfLPvJXMaIdtG4xOqVQRNXbV/D
	 c7OYT5I2+fAoVHhwouOZAjYtSDvoMS36J27ATzytlt/qPGPUak4QYZzS3vKvibB93N
	 HR9Fl6Hy0Z89wqS6nwTmMM2Y64aBKGH5rjrQY7cjUtngfl9YsJBIMnoTO4wL0S2YC2
	 XLr7qFYFttNoUbdVtLpETx2eCn7RatSY337X1M9hj3WPqw+zjlqCr4u7HMihAODy9O
	 h34TZnmMkKSuIhypgHtuP6kWjbGZIOExCp91coUi2Lt+uM36IpRIFuHBsWHm0q+1Gr
	 1rPH2Ib1v3OUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD58D811D8;
	Thu, 12 Nov 2026 12:02:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED4BD177B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3C2F400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1XB0noKO2GV1 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 12:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D469A40042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=jAjdU01d
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D469A40042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:02:32 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=jAjdU01dqCs9yUeHypI0CAQDt/2t8wa5f2rSsCV3klyDffFqKh5Eo/OJPMbefNgQulMF7P+biBnlTCr4nxy7rVEVZdZNvZma5CXFPrQrdYxR2cGDdqmTY1eXiIv+aLzR4M9mS6rH4jS/za5frNXP7Mda6MuuWeGZzarVTL1kSrk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484680764295.16065734195786; 
 Thu, 12 Nov 2026 03:58:00 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 18/20] doc: arch: Add documentation for LoongArch
Date: Thu, 12 Nov 2026 11:54:36 +0000
Message-ID: <20261112115438.1837663-19-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a brief introduction to LoongArch architecture, some notes on the
implementation, and the toolchain supporting status.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed from v5
- Improve the documentation

New patch, no changes since v3
---
 doc/arch/index.rst     |  1 +
 doc/arch/loongarch.rst | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
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
index 000000000000..93eed74fe666
--- /dev/null
+++ b/doc/arch/loongarch.rst
@@ -0,0 +1,31 @@
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
+2. CONFIG_ARCH_LA64=y selects support for 64-bit LoongArch variant.
+
+3. U-Boot requires hardware-maintained coherency of different levels of
+   instruction and data caches. It determines the cache topology by reading
+   CPUCFG registers; L2 and L3 caches, if present, must be unified or
+   instruction-only. This is true for all commercial LA64 hardware. Refer to
+   arch/loongarch/lib/cache.c for further description.
+
+Toolchain
+---------
+
+LoongArch is supported in upstream binutils, gcc, and LLVM. GCC 12.1 started to
+support LA64, and GCC 16 started to support LA32.
+`kernel.org <https://mirrors.edge.kernel.org/pub/tools/crosstool/>`_ provides
+pre-built toolchain for both 32-bit and 64-bit LoongArch.
-- 
2.56.0

