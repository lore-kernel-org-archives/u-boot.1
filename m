Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA81C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7317984BC6;
	Wed,  1 Jul 2026 13:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="AIB1YVI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C361384BCB; Wed,  1 Jul 2026 13:18:37 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEE984BC6
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904711; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zd8ajNVzPRR3OFUuxWh8KkRdbH1xndZeHzYe2PH37mnZKnseCgvFY69/KuklAvqUEse03tImtw82eByMMoslQIOUnQrEaPNXfWFq9tj3Wfd6U3b/4ENrfLnb/M11up3i+4kA8D7q3Q73t2lT4VOyMYyApxqNL8ogm7nY91udE6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904711;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CF3ktiK8m9GN3xZbK/Mq/snVKifkD1nO2w/ErmW8d0I=; 
 b=iMnpHrKQ+6o092M0X6Sa5B7keUn2LM7hQrjxWWjumF/DILcNedtiJDLdjUtT2Wr7YyaUz+mFr56gX9baAjL2sYuhXlsHtx7aaOnPsJmlEdvSeITb30Cv0yMP8+yxDqo6Q+MsrvtkAAvt6FK7h4hWyHgq7MVXYS4zLWAtPObdtBM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904711; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=CF3ktiK8m9GN3xZbK/Mq/snVKifkD1nO2w/ErmW8d0I=;
 b=AIB1YVI0v2NQHI92mcVy0jvsciEK6H/+KLLuvTJAbdCgxF6pMvHhOGBIy3B6W6+c
 2JOzJxotkNQqYTTnkMAnSAAxmIcN/abK0Zv3Ku5rsLh3yEcolhVTM/4sIxB3m/5tfER
 VpwXOOgdb/igk5XCeZsjvBOrU4qdr9IbqhAyiP6A=
Received: by mx.zohomail.com with SMTPS id 1782904709640630.4097182445254;
 Wed, 1 Jul 2026 04:18:29 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 04/16] elf: Define LoongArch bits
Date: Wed,  1 Jul 2026 11:17:56 +0000
Message-ID: <20260701111808.870705-5-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

They all come from glibc's elf.h

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v1
- Re-title to "elf: Define LoongArch bits" (with the semicolon)
- No function changes involved

 include/elf.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index b88e6cf4032b..b69b1adc404e 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -225,7 +225,8 @@ typedef struct {
 #define EM_MN10300	89		/* Matsushita MN10200 */
 #define EM_MN10200	90		/* Matsushita MN10200 */
 #define EM_PJ		91		/* picoJava */
-#define EM_NUM		92		/* number of machine types */
+#define EM_LOONGARCH	258	/* LoongArch */
+
 
 /* Version */
 #define EV_NONE		0		/* Invalid */
@@ -705,6 +706,12 @@ unsigned long elf_hash(const unsigned char *name);
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
2.54.0

