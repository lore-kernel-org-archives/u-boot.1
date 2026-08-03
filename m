Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA40C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48133606D4;
	Mon,  3 Aug 2026 20:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WJ677TYvQ6dW; Mon,  3 Aug 2026 20:58:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAB8B6069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790692;
	bh=R0F9waf/WBZ13HC1oBStvVebaMyT9q8ZGspn4nlRluM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=OSOMJkEXsWWLLtr8gMPGgLfLcnlJoioBlyVbrKfKbeJru2mjjgImN4Vm6EUzNGu7n
	 ovoN/o890Aru42x1eQYADDZapEOhA0ub/80UvlpiBGaNI3arOLJazxHoPHGYEpQkqP
	 9Vcg37QApyi+LYnYVSskvQ5GMqFsG82ODqcFjgRHe4/n/dMy9zT+npNYMJp8rVlYqJ
	 rAXD8hhHcFU8odwDH87vJFmk15MvZtK98rtt6XEAkOrh8r7c5z653MiZk5/v0Dja09
	 fR4MJ+vZuSn6mckrqG6/GqWOztmDw2q6FLArmlMNXlTKskMfPBp2A/kZ8lydbGvPZV
	 otgk1Vg4xG4QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAB8B6069C;
	Mon,  3 Aug 2026 20:58:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D77692DE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD52F80C0B
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XFfXFLQUBTf for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:58:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 03BE980C06
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03BE980C06
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03BE980C06
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:58:09 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hDTXb6c4vzKmVr;
 Mon, 03 Aug 2026 22:58:07 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: rpc: renesas: Switch to dev_read_addr_name()
Date: Mon,  3 Aug 2026 22:57:38 +0200
Message-ID: <20260803205804.134692-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f51d7e72579b26dc023
X-MBO-RS-META: qopjr1izc1y1z481rkz7msecyd43b8wc
X-Rspamd-Queue-Id: 4hDTXb6c4vzKmVr
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R0F9waf/WBZ13HC1oBStvVebaMyT9q8ZGspn4nlRluM=;
 b=Me6LByp/7CS3XhMbxKY+QVGwPeDRywXlebFYLEJKvTx+UzkR/n3Iu8pHvEIA0FRMGOBXNK
 /OZTZlUcrb9jp2fqef5E+/dPVDysdOYTatyGJ1AHs6prr+GcJQbBgV4tVbjYW4eQz2rmMv
 65+tAZvCGrlxKYcgo/tZghDGo2o5GsGyZnbY4n82tl6hzVk/DFZCGKtQjYgiIwt/CQ0MdP
 fdDmh8RWgxuruy+I0B7x8XPC7KJaa6+37QtKguvrDXVUb1Lgjyu+5p1MqmOFGtn2jhB5Al
 YYBZD3j7dL08o3+53Capy2calQXR0Zz1vWUYZS5/CPxyMcP4BamARXmzD0NPPw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R0F9waf/WBZ13HC1oBStvVebaMyT9q8ZGspn4nlRluM=;
 b=yb2A50wYO1aqGWiMgjIM5RcQ2AKiPrtj6+x+e54p9mU5uusR7psUEZQ7vG+eXrKWwYK8SN
 Ce8YltlSp42diEsJextHYKgfwKoTV9lSe4a0v8k76hMoh/0o45odFcje6FQIpu3eoqbQCz
 99s2u7VUfG1VNDnIipbPRwemU6fQPSn+kXV8mZHeJ9VIdpkl9ADYVi1UjKbglShWNuItSm
 iJvLoxozcQUsLqMmALcssozkwz4O0UrQaOVS7yrXKxcMoej7n4SsLajPsE5TDbhlFYM5dz
 qGZbJq9TFxaMZnYZyEjAeeUtGbfelSZgqdgO2dXECveN8q0NO4lkB/liz/L8hQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Me6LByp/; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=yb2A50wY
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=yb2A50wY;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Simplify the DT register address parsing using dev_read_addr_name(),
switch away from raw fdt_*() functions. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/mtd/renesas_rpc_hf.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index 9390c9e9ab3..0b4459df4d6 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -344,21 +344,21 @@ static int rpc_hf_bind(struct udevice *parent)
 
 static int rpc_hf_probe(struct udevice *dev)
 {
-	void *blob = (void *)gd->fdt_blob;
-	const fdt32_t *cell;
-	int node = dev_of_offset(dev);
-	int parent, addrc, sizec, len, ret;
-	struct clk clk;
 	phys_addr_t flash_base;
+	struct clk clk;
+	int ret;
 
-	parent = fdt_parent_offset(blob, node);
-	fdt_support_default_count_cells(blob, parent, &addrc, &sizec);
-	cell = fdt_getprop(blob, node, "reg", &len);
-	if (!cell)
-		return -ENOENT;
+	rpc_base = dev_read_addr_name(dev, "regs");
+	if (rpc_base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Failed to get RPC control registers\n");
+		return -EINVAL;
+	}
 
-	if (addrc != 2 || sizec != 2)
+	flash_base = dev_read_addr_name(dev, "dirmap");
+	if (flash_base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Failed to get RPC direct map registers\n");
 		return -EINVAL;
+	}
 
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret < 0) {
@@ -372,9 +372,6 @@ static int rpc_hf_probe(struct udevice *dev)
 		return ret;
 	}
 
-	rpc_base = fdt_translate_address(blob, node, cell);
-	flash_base = fdt_translate_address(blob, node, cell + addrc + sizec);
-
 	flash_info[0].dev = dev;
 	flash_info[0].base = flash_base;
 	cfi_flash_num_flash_banks = 1;
-- 
2.53.0

