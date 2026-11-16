Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99151606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dWXSokkV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=TFGIsA53
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D97180FAB;
	Mon, 16 Nov 2026 16:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVlgCXRdsjq7; Mon, 16 Nov 2026 16:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C71080F65
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846469;
	b=MBzUIi1FLYbz73GOiJSJuACsA0UX73Fm0+rvLoUzVkvipL5d7dXk6HafYOa+O+LgbvZR
	 rqroT3ToPUdIjDE3gVX+HtpITIxIVxRU6BEgSeBuafZZKynv75cJ6z1gAQDTZYB19FL6P
	 sATsOk39dAERGLP/Ia4T4/BsiFYOmbeTPZ3mYoog/loJlNEAeoxU6Ws0a9vP/gnfNv/Sy
	 tYQvgBjoxTIGOM4FE3J1couhZW0lrcRrmyGCNFuFOX5JTfhfQmtNwrkP5RHklTL7ucDyI
	 Jcn+V5Kdq3yHR1wQRMJvI4ZT3SCdZV/aCRFKOx99a/NA1uUy9m6ZjJ/jAsIrMUWHjIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s5QMD1dJsemYqhxA+iBqrhVrcXUBtF2E+/jA0h6ZFwQ=;
	b=QjeLKKlUh4dDFS/cotQJ/KKvb2IyN8n4WsyfJWLMxhQdCPILuKegFYdCo9luuC70fNww
	 w8Q6wlLQUEmdtjR0l72GfrL2jnp5+j/HEExKsg+NOfswbKcXTpcSORHMATK56NaBX8JJf
	 iNIB/+LGfDJ6U/fVCHU4fBqRcJRPgYscNP1xgJbk2SX3l9a8RW3mHI8G+szQaOKptLHPA
	 IcK1OG329gatsNDhrq5jUNwS8bL+3bB1n/qR1/TS+QlxPDXWiN+BpIG4D2HamPY+qqE/3
	 JE9y7AeaxhTliyPK0gnIjDjVJSb6lYu26/WAcJxZTk7vcLak4SFV5lnWEWOvRvA1New==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846469;
	bh=s5QMD1dJsemYqhxA+iBqrhVrcXUBtF2E+/jA0h6ZFwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dWXSokkVKhAug9srpaGO7ME+jZLEv0hIefLyfk2Ifo8VV0xk9q5L7MOBKsNOZ5MIy
	 hZw5em50fmQgw4u8nCaIxhwgZghxGYjq9KPCBL+UrHxE9SXEGA9XTz9wgqxzufFQjo
	 +Cqj2B3QZo69HbTEuSg4ZfgaenGtAkKfo45MbLyevZdBlkF55nwYhran1NX3J0/pya
	 zFWNhgvR2+MIaduNxJlCw7NyD6WtA4EmsB9iuwfQMMfS+HonQyUchhSeuhmzXprRgI
	 kr/GPmx7059ku/jXYbIc9r2XRhnTEWm9ZH0Gt68SeWwZNJChLTGY3AEaUTPu11FIsF
	 EU7bKbR9xuJeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C71080F65;
	Mon, 16 Nov 2026 16:27:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB76A4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D171640636
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBOdD43FFw-8 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:27:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A89BC40612
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=TFGIsA53
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A89BC40612
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=TFGIsA53hpEcVqADtPztcO2tLQhpRhnShWzfwnKIQco9B+v9eYs5NwcKQepG1eTFS+LBhTi7Dg3EX/HVHMOufmOj0wEzyB5scIWxPTE8NlOP/MGjbl+punvcVATLGzN+eVs1MDfSiOFeJ9gp7IHVlCFe3n6ZfABUIob1ZXJnclQ=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=s5QMD1dJsemYqhxA+iBqrhVrcXUBtF2E+/jA0h6ZFwQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794846453632967.4080917025087;
 Mon, 16 Nov 2026 08:27:33 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 17 Nov 2026 00:26:16 +0800
Subject: [PATCH v2 1/4] fdt_support: Skip memory fixup when the banks
 already match
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-riscv-fixup-memory-v2-1-4731aa6c3fb5@pigmoral.tech>
References: <20261117-riscv-fixup-memory-v2-0-4731aa6c3fb5@pigmoral.tech>
In-Reply-To: <20261117-riscv-fixup-memory-v2-0-4731aa6c3fb5@pigmoral.tech>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=znn9RG7UYqmNYq206+GvXN6qVWbhlOwcBpn6vOOLMXw=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJ+6x1hlL4mYCpTuCSqVeWZf/3kRtW8h+F2NzKFrh4p/
 n5fwNWjo5SFQYyLQVZMkYXLX/yftQ7PtyMCrfdh5rAygQxh4OIUgIm8ZGD4H5q01+gyY1aY/Utv
 q1mxTdJiyYYRFzhNrZ5YbHdcPsm+kJFhxs4LX3s/r5hXt9BR8EbsibaIbYef7NFQX30gsdOlIdK
 EEQA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fdt_fixup_memory_banks() writes all banks into the first memory node,
leaving any other memory nodes untouched. For device trees with multiple
memory nodes, this can duplicate memory ranges even when the existing
layout already matches the supplied banks.

Compare the packed banks with the reg properties of enabled memory nodes
in DT order and return without modifying the tree when they match.

Updating differing multi-node layouts remains unsupported. Platforms
that need to preserve such layouts should disable
CONFIG_ARCH_FIXUP_FDT_MEMORY.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 boot/fdt_support.c | 56 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 2941df559962..aecf5dd3ecaa 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -525,6 +525,35 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
 #define MEMORY_BANKS_MAX 4
 #endif
 
+/*
+ * fdt_memory_banks_match - compare packed banks with memory nodes in DT order
+ */
+static bool fdt_memory_banks_match(const void *blob, const u8 *banks, int remaining)
+{
+	const void *reg;
+	int off = -1;
+	int len;
+
+	for (;;) {
+		off = fdt_node_offset_by_prop_value(blob, off, "device_type", "memory", 7);
+		if (off < 0)
+			break;
+		if (!fdtdec_get_is_enabled(blob, off))
+			continue;
+
+		reg = fdt_getprop(blob, off, "reg", &len);
+		if (!reg || len <= 0 || len > remaining)
+			return false;
+		if (memcmp(reg, banks, len))
+			return false;
+
+		banks += len;
+		remaining -= len;
+	}
+
+	return remaining == 0;
+}
+
 /**
  * fdt_fixup_memory_banks - Update DT memory node
  * @blob: Pointer to DT blob
@@ -561,6 +590,21 @@ int fdt_fixup_memory_banks(void *blob, u64 start[], u64 size[], int banks)
 		return err;
 	}
 
+	for (i = 0; i < banks; i++) {
+		if (start[i] == 0 && size[i] == 0)
+			break;
+	}
+
+	banks = i;
+
+	if (!banks)
+		return 0;
+
+	len = fdt_pack_reg(blob, tmp, start, size, banks);
+
+	if (fdt_memory_banks_match(blob, tmp, len))
+		return 0;
+
 	/* find or create "/memory" node. */
 	nodeoffset = fdt_find_or_add_subnode(blob, 0, "memory");
 	if (nodeoffset < 0)
@@ -574,18 +618,6 @@ int fdt_fixup_memory_banks(void *blob, u64 start[], u64 size[], int banks)
 		return err;
 	}
 
-	for (i = 0; i < banks; i++) {
-		if (start[i] == 0 && size[i] == 0)
-			break;
-	}
-
-	banks = i;
-
-	if (!banks)
-		return 0;
-
-	len = fdt_pack_reg(blob, tmp, start, size, banks);
-
 	err = fdt_setprop(blob, nodeoffset, "reg", tmp, len);
 	if (err < 0) {
 		printf("WARNING: could not set %s %s.\n",

-- 
2.56.1

