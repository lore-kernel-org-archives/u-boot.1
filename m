Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A2FC55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CC6140648;
	Mon,  3 Aug 2026 20:57:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iE0UJP9_0FXW; Mon,  3 Aug 2026 20:57:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AB0840566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790639;
	bh=AUtEqKgyziy6NlD3V/w34HepEvlhAt/tPl+G5N6GkhQ=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=uWBN2reYwcNYtS4gUFjBMw+FvC25cjFZY7g/WjIKYH8gE5jvn+BzIgcmRijY662x6
	 /7x4uJT7F2YmAMDLzd+4A5yMd8iQSe+UrqcpT8XArR/hYNm1rzq6PX1RipFGy4GKsU
	 gtaBs3YcotsFm/U4p9Jd8/LFmxCGAYrnE6yWXJyfg9vHNJZcO51D/EzjtRMnMkQUG3
	 5PAG22LumI0wOarletdtuGKRbbrs7/RJUTUgzkh1HLL1u/mebMHbHBrQcG0uBrj100
	 xLNIEmFcIo0ZacPxDrhHA0rYEnROPbW/nYBg8aljtFRBrcmTCBnPddCLz/5xcFG81C
	 +m4F1SlLblIhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AB0840566;
	Mon,  3 Aug 2026 20:57:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31D7928F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FE4780C06
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qwga7KqP_rkk for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:57:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 472F580C04
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 472F580C04
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 472F580C04
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:17 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDTWb0h6hzMlG1;
 Mon, 03 Aug 2026 22:57:15 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: spi: renesas: Align macro prefixes
Date: Mon,  3 Aug 2026 22:56:55 +0200
Message-ID: <20260803205711.134654-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 74hopetu7pr4tsuhu49p1ag1haprkytc
X-MBO-RS-ID: 2a459ec330612e6f3a1
X-Rspamd-Queue-Id: 4hDTWb0h6hzMlG1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AUtEqKgyziy6NlD3V/w34HepEvlhAt/tPl+G5N6GkhQ=;
 b=q89qnzQuHvjJAp0pcrjGDWgGBaQ3y8GkJse5n9AgRllBjmNAFiONT4gIF+svvl+HugvYBQ
 1n3hSTEnzKWQ8cTb9jz04Zo804cpuOy0ewtG7Rrg4KrZ2d995pb/3jta7fUnkQu0Wwg1V4
 cVG7SG+GLG5C6FneEnovdlSY9thQ6FEt6l3euYaKjr4hsdRg9kfsndh6xqAt7wdo3bhVQ/
 UkIoFpd+l/p6Rzs6RzxiClQVYwHz3+KYoH3tKunBdqj29bvxtUp7GfqphXL+UbTWgO/5qu
 dM9k1NoB1Qb88O7burTlKjNyrfVjYwMIkCKLcTs8xxWIgzi9Sycr8eHdQ51Dtw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AUtEqKgyziy6NlD3V/w34HepEvlhAt/tPl+G5N6GkhQ=;
 b=ohvOZWrD9EcZ+eK87UBdDyqB7z9nTv5gomsSr8mUt1sPb8L91EeA+z/1PTCvGiZtP/drxu
 gMWXaj8eT7cnTHYh/hm9vtSEekZbm+e+BVX3JHloiwuTp8DnQIQM9d9SeVbQiDDp4/Vn6L
 WXR6J8QGz1PP0+iO2/7rklhMuJj+64Ef5kAeMCOvPb6THCda9q0pK0liAcwRSLjdcPcYTb
 l4jJbSqZLLM042TumCHPeRwGYg/Zp4VAjm0HvX3wEJqLN7RxCxuYdhaH4pJOGn5BlwvJor
 UqeqKvLSFLDRKXD+gxi5OT1U0PUThrErM8HZMg+Thp6qp1jwJoA4bGi3lik5qg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=q89qnzQu; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ohvOZWrD
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ohvOZWrD;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
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

Remove the IF from RPCIF to align the register macros with each other.
No functional change.

Fixes: d5162463243d ("mtd: spi: renesas: Configure RPC PHY timing registers")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/spi/renesas_rpc_spi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 7103d786c7e..640607793c3 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -145,11 +145,11 @@
 #define RPC_PHYCNT_WBUF		BIT(2)
 #define RPC_PHYCNT_MEM(v)	(((v) & 0x3) << 0)
 
-#define RPCIF_PHYOFFSET1	0x0080	/* R/W */
-#define RPCIF_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
+#define RPC_PHYOFFSET1	0x0080	/* R/W */
+#define RPC_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
 
-#define RPCIF_PHYOFFSET2	0x0084	/* R/W */
-#define RPCIF_PHYOFFSET2_OCTTMG(v) (((v) & 0x7) << 8)
+#define RPC_PHYOFFSET2	0x0084	/* R/W */
+#define RPC_PHYOFFSET2_OCTTMG(v) (((v) & 0x7) << 8)
 
 #define RPC_PHYINT		0x0088	/* R/W */
 #define RPC_PHYINT_RSTEN	BIT(18)
@@ -233,11 +233,11 @@ static int rpc_spi_claim_bus(struct udevice *dev, bool manual)
 	struct udevice *bus = dev->parent;
 	struct rpc_spi_priv *priv = dev_get_priv(bus);
 
-	setbits_le32(priv->regs + RPCIF_PHYOFFSET1,
-		     RPCIF_PHYOFFSET1_DDRTMG(3));
-	clrsetbits_le32(priv->regs + RPCIF_PHYOFFSET2,
-			RPCIF_PHYOFFSET2_OCTTMG(7),
-			RPCIF_PHYOFFSET2_OCTTMG(4));
+	setbits_le32(priv->regs + RPC_PHYOFFSET1,
+		     RPC_PHYOFFSET1_DDRTMG(3));
+	clrsetbits_le32(priv->regs + RPC_PHYOFFSET2,
+			RPC_PHYOFFSET2_OCTTMG(7),
+			RPC_PHYOFFSET2_OCTTMG(4));
 
 	/* NOTE: The 0x260 are undocumented bits, but they must be set. */
 	writel(RPC_PHYCNT_CAL | rpc_spi_get_strobe_delay() | 0x260,
-- 
2.53.0

