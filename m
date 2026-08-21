Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BCDC5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADF4440947;
	Fri, 21 Aug 2026 08:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwquC63uHc60; Fri, 21 Aug 2026 08:42:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301772;
	bh=o+/uJQgOO0m3/FygjGLaOzF1m4ovrh8RVgNiPVIEaSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c3w0ux1l9s82fkU3M8VKUHfLXC9codc0yv2K/l0Qrep8PhDkXI4rdi9L+HNEBpE9V
	 kof+zWKJGFjxks39Xg/9g31XC8WS0UygXMGRp4SubD2JQuyWlIGgX/9nPI1CYcI25g
	 4OjodWsueKJPUo4rU29uLu6enDuamfAmZIjPnmkB0LH1GN8s3mIPBSSw7yLJrCzSBQ
	 WxyaE314YHDUMNAuritgXYvEdShPWb4x7vBmdoFdPmClPap9Vwrf04fren9iN54ClA
	 FmWSJIeHDSGfAuG80Eqi1NF9uIecd4tKzQCWvMbHA7zX5y+cnrY/kYvC7Tci7Afr5w
	 CB5nEd4/hy0Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C785408AD;
	Fri, 21 Aug 2026 08:42:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BEDBB1B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B10AA6067B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujTZuRLgzfln for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:42:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bZ4oYe+9
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0FFE60661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301763; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JqEZYT1vUIWyHeFRDlUErq3/GCALojPx8XwysPVWrzQxHiirohgVYW8JA6C+MJNbxdfrvwLDv1aVU5ghYMlEyuhtpi1YqaLjD9Pa2Nfy9M+UP658NP3iQ0uDz5Q/45sqMXVluftft96DiZkItoiKwjvUSIk/7FP6olfqrq3iSpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301763;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=o+/uJQgOO0m3/FygjGLaOzF1m4ovrh8RVgNiPVIEaSw=; 
 b=MAB43p0sh36Us8VIreSgX0HodpyLYNzY02tPk7il1LB6KQPIDlQSGdZQ9bpU/YcFD03FZHsjAYbNKaBZUQxN4z0JWRb1QO4QHyTLo/4MuRhfNyALFmsYZACf4yp7BqgJhfYThvpva0z5q6J+gfupJX8S0+L4xbVPLPh89HOcHJA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301763; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=o+/uJQgOO0m3/FygjGLaOzF1m4ovrh8RVgNiPVIEaSw=;
 b=bZ4oYe+96ryico6R5qQ9SFLUl3BG5D60heljl3aZ5OxnbfOv/rvhFPZpasCVQabp
 nPEwtc1mxYxkpPxv7NMhhrbQkCN6nVsqCPMsPsjxfpzQCle69wvjqkSzVLuEnRjsVhR
 2hq40X0WvqU5DuPim7m76VTh07ItaNV5oBAf+LOA=
Received: by mx.zohomail.com with SMTPS id 178730176137157.82591135947439;
 Fri, 21 Aug 2026 01:42:41 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 04/19] elf: Define LoongArch bits
Date: Fri, 21 Aug 2026 08:42:04 +0000
Message-ID: <20260821084219.1703743-5-me@ziyao.cc>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

They all come from glibc's elf.h

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed from v2
- Collect tags
- Drop a redundant blank line between /* Version */ comment and
  EM_LOONGARCH definition

Changed from v1
- Re-title to "elf: Define LoongArch bits" (with the semicolon)
- No function changes involved

 include/elf.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index b88e6cf4032b..67d519cd9174 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -225,7 +225,7 @@ typedef struct {
 #define EM_MN10300	89		/* Matsushita MN10200 */
 #define EM_MN10200	90		/* Matsushita MN10200 */
 #define EM_PJ		91		/* picoJava */
-#define EM_NUM		92		/* number of machine types */
+#define EM_LOONGARCH	258	/* LoongArch */
 
 /* Version */
 #define EV_NONE		0		/* Invalid */
@@ -705,6 +705,12 @@ unsigned long elf_hash(const unsigned char *name);
 #define R_RISCV_64		2
 #define R_RISCV_RELATIVE	3
 
+/* LoongArch Relocations */
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_RELATIVE			3
+
 #ifndef __ASSEMBLY__
 unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
 			   int argc, char *const argv[]);
-- 
2.55.0

