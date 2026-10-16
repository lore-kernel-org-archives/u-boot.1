Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE27CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBF8340768;
	Fri, 16 Oct 2026 06:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JV9l7QP6vsnz; Fri, 16 Oct 2026 06:58:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF776407CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133924;
	b=jt2fCmAHg2aY/NJsI6bedK+ENgmAHOzothUzfyWUGYtNMPdEtv8mysLZnGEYlHM0M6Bp
	 F83nX2iHWh8LmAB8HnbXkyWLCMDNalxsv/Y4t5eyN0FIpZJddqHf+5iUETf8VpOq92lXC
	 I8PWFBL87b9I7ZAKjFqV6gjoNV8ZFqrU23wJYod2NC0Y2iPy7Fuxb+uzdxvOFvelFwhkV
	 hsDj3QhmrsOQ5KthVr7IMCpbGu7gyco7JZKXqQEcjTvwAVUCuZbbXB2Q2zmpgvPdlAenx
	 Y7WkYCFEhsVQI5TvzYu5Z1DsbsReqOp9JBfK9pKwDiZr0RZECDVtlvkfbIv16n8uTSw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133924;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pXCy61Sb0dceuy7Tl6+dldQfvE9LUs3qPMp/X9VBuOg=;
	b=qDkkhCDDpkUPY6FsHPlLEUSZ78k8aQS4M2URJDUJPKHtnn5uj8uaYaAMzY4kkAdonsOr
	 l3pmLsfojHw/AnPnnoqGAvO4nB811iPR7e+sBzRUfkaICzikG0qTbJHTpO++STYFUub3o
	 S/7PGL1SXDWKYa4hlQRIDrhjARTtHtWEo58MgUl7NsNsnZf2OQWTUS6KaEjDGyuxcZZsX
	 xZsZlvZ/slOAoNWZi10t6j5JNmw80SIzhwTrNO6/QV+nm3twKce1nPllDKRMWvVRHSqlx
	 Pvmd/HQqbSKO88cgB627jTwMgWV6axcB09eBvMj7T9LQNwoiU0ayvx2hykrsHZ6eqmw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133924;
	bh=pXCy61Sb0dceuy7Tl6+dldQfvE9LUs3qPMp/X9VBuOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wjLNmWPF2E3il3N0Q+fq9xu0fXqJPqEMa5DkF9txJTJSsuMf8JwhNWZ0cTInPnPY8
	 QXlpRWTSP8WeevDm+rT9MVKVpSGG/m5Xl/PMY3F7qBd5E5HFRa38oLbJmDBxBBR3CS
	 BrUv/HpeJyiMe6FS/QIOI7V9ubAXRlogeL4mxNwlJvGxV0xaphCdYb5SLMD2+mUmpq
	 woRWV9fEy357gn1V0s001XQfPILlf0kijmCubA74oq3TTKLSCtHlmrahVaaMaI/atJ
	 xv+osBvWIL6mnmJ9pfw/L8kOPlbJ9KS7xV6GjvN3C0wAOXZkpHWXBU+F+5vGwUP2cb
	 XmTJ5V9A/pahw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF776407CF;
	Fri, 16 Oct 2026 06:58:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DE1E362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FE9A60AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fzSNe8tj5-F for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA3716087B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133919;
 b=YuNUWb0OaGdWGJieUoyUAX0itk+12fcM+jeN0TQszSRUexAiWheEVhtk049iRf2AiJEJ
 PbzOP7B48+TacNzrqbQ3s4GJFDKj9VhMEhxb3avWe5H6HldusjQMG4rXm27egaTNUtwjV
 a0D1mzxH9uudlaGhiu0UJlpuAuIx+JwKZ39feJixclj7hp3lUnatY85q7kmV9+FOZk7B5
 WBHiXQ/ajajk4bec4UmdBUckILEvcQkra0+VfsC6TL9NZd9+NxClGM96KtFMXWomUm2y+
 ywl2ktTKqHZX8D4+J2iv8ESJ56hSD2Xw7WnaL7a4ZiMlvrcUQvz8OtBK2f+sPg1ZeLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133919;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=pXCy61Sb0dceuy7Tl6+dldQfvE9LUs3qPMp/X9VBuOg=;
 b=LuUkYfsaUAEDmwKKueDPUCoOF6OJI4T8mlGJTgH5ipXZwISD1Td3OADE5UKDjqN4iX/5
 Bcq9h6fM1P9i143RnxNkiH5eWE7vP2tZ1+eTlr6HTPNQ4IY2v3uIiaKW1mu4XUUkBhCjC
 FonfLgLFXTA4tyqEb8kJ6GWOVa5UHe2OFo0wdXjB+9bCaRD7nPkz64UtrZqVMDjcQw8zv
 imt9JPhZAa0ZcrJUOShuCHE/2Wr81PNdTPGahDBFlw2GqEmSBf34pMDV38PEvVW9WViY6
 wKEYW1+09eb2UNG77X5E9A8la1mmouOBLnXEmHpKTgLmbqFUFkJ8KI4cmhri3DpOa+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=otKypbdz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=otKypbdz
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA3716087B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133913; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dQjCh0NUDjBio/OKz0KjLm+CPyCMzyhTDHfQew9Y74PM+yb7lhCtSTjb+LLKwnNOx3q+5xYhjroyzVIVkhOEaqo1rtu3KRD5lwFUmiyFkRb9+PkJIVqVbZbP6SuEWpC71mvwcOaFRkZVa+Qz+tYRO02wya63q2QJVE2TNsz+b74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133913;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pXCy61Sb0dceuy7Tl6+dldQfvE9LUs3qPMp/X9VBuOg=; 
 b=BBB/OTePL9vK77dlUkg1WWs9cGcvW5belV/6r8HVWnOOW2zcSUoxXnRy3O4cnk//UGclqjLINqfAlhSw05kyG0u4eAy96bgwZbXWIfCIMDXFMDAXCbcyydSMJOTyj29/LdWxzHl9dNIxlaKKvI6Z5Y3uR1qwc/RuLSmCrnb7H5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133913; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=pXCy61Sb0dceuy7Tl6+dldQfvE9LUs3qPMp/X9VBuOg=;
 b=otKypbdzncUwuI7m/Jev4oI+MFKA0tg/nYORHIWwB2ffP0pzaJtd5xWD6SR2iPLy
 XzvY12CHEj3GuXkNY3x68PYj0oWv8ldcHTlkPagvNKR5Cwcc7laIYDsTGgyRiXJSAEx
 jsoxePInaqAouCASKrPCjrWN9p/BDRMbdCqsiUDQ=
Received: by smtp.zohomail.com with SMTPS id 1792133911962264.5502124522068;
 Thu, 15 Oct 2026 23:58:31 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 18/20] doc: arch: Add documentation for LoongArch
Date: Fri, 16 Oct 2026 06:54:58 +0000
Message-ID: <20261016065500.137544-19-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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

New patch, no changes since v3
---
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

