Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E034BC55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4F1740688;
	Mon,  3 Aug 2026 20:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJiNbZeepf1h; Mon,  3 Aug 2026 20:58:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 791B240648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790711;
	bh=zepptAEG9qqJMJnxlHzq0QtDTZY6wm82rSGv/hbk2eE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=hXsTNSOTQt1IVHOD7Yf9yiFzDtN6l+wB8rVT1JZu0LhV7DM6DyKm06jKM5FhcooDj
	 3TRk401o2mLogQFzu7lTIsUvY/p6LYd+4mHY08pTcFWXFGRwGGeONLCGsKIqljYsR9
	 5r/2sVuK+opj6pjWEGOLGi87/1lULTmjUleWC9KdD/ehYCqJBDWzWFpyhGqC7Dw8H9
	 1utLU2jG37EMriXrOrs0IszRKFrOEA6FwWuR32mPtYnwMZzHie/kEhyJb+Q4ZOk8Oy
	 UTrkqEBMBnfMZdhoUM3/euUYbaoAwJudFlc/9Aldhiqp26vgxQpo5mv6BnQPJmb9ZF
	 UB278qsqqavew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 791B240648;
	Mon,  3 Aug 2026 20:58:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84D3F218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AA2480C09
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JGI4xkxxac5F for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:58:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 615FB80C06
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 615FB80C06
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 615FB80C06
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:58:28 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDTXy1sR5zMlGJ;
 Mon, 03 Aug 2026 22:58:26 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: rpc: renesas: Add R-Car Gen5 DT compatible
Date: Mon,  3 Aug 2026 22:58:08 +0200
Message-ID: <20260803205822.134713-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 181520a1eb241831048
X-MBO-RS-META: wyw1syrbmm8r1bxt9ogq4mzkhmh5fuft
X-Rspamd-Queue-Id: 4hDTXy1sR5zMlGJ
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zepptAEG9qqJMJnxlHzq0QtDTZY6wm82rSGv/hbk2eE=;
 b=kBRJUSUsdZJga4PYfzW/nKew5btxTm6Snh8JyR2tnp2Pud5tLaSlWM8SNI1OWAIg2FCCc5
 fxFn9esKbTHRScpSikD1id2sP1rfxRxyDmgyKnCexgTEUqCl4zYYoti6ZfX6wsl3+5L1xi
 16fn+eKZUlBPg9WPAuaTyaZ3AJNH8htQC0h5RdZvrVfbdqr8SYg17DUd+RyH/F9lzkqZ9n
 ehSVqzbcIX1SFsHprfpGXYhss5XIgLC2/VFf3UY0Fe2MVVmVmsBJBsexNXucu9gsjjPDCK
 GKTnUvrDdDukprdxo6/FQtBNKs06BP5LJyblwsLqslT81fkCT73NsThfVJMidQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zepptAEG9qqJMJnxlHzq0QtDTZY6wm82rSGv/hbk2eE=;
 b=jeXnep7bZwWITsFjr5+FW87+OSlbYWki7quCjJ0ZgGXH6Jymk/+I1VR3qd/lg7Z0ielIRX
 WRxR1o7sMhwUqtdXpsUsfanJtgzjDFTLImGa2ZdljoGyZd3uJtVIyuROsvnI8o/aNKUFRA
 D5X+kzXS5xuNbcVpiSpuGH/au6/AgMZT/8N1kNBYochTw+qlzD47ZBk1fZAoCnx8I/XELK
 CXYJ+V7oOXCcnUDCfFsMcPBnJZ5itQX2QB5ETjP0TLB1yh4AdAfj490NBUaZ643pLpyTnZ
 g21vQmWqQskb0GzyzN/hxPXTlyz8pO1bpfj4EvPOSLkyOE+vn2afoInv+VmfuA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=kBRJUSUs; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jeXnep7b
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jeXnep7b;
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

Add device tree compatible string "renesas,rcar-gen5-rpc-if" to
the driver to match on upstream RPC DT node in R-Car Gen5 DTs.
Adjust Kconfig to allow driver enablement on all 64bit R-Car.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/mtd/Kconfig          | 2 +-
 drivers/mtd/renesas_rpc_hf.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 38d6dd142dd..f6bd9f6f2e9 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -196,7 +196,7 @@ config ALTERA_QSPI
 
 config RENESAS_RPC_HF
 	bool "Renesas R-Car Gen3 RPC HyperFlash driver"
-	depends on RCAR_GEN3 && DM_MTD
+	depends on RCAR_64 && DM_MTD
 	help
 	  This enables access to HyperFlash memory through the Renesas
 	  R-Car Gen3 RPC controller.
diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index 0b4459df4d6..c94a25fe6a1 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -384,6 +384,7 @@ static const struct udevice_id rpc_hf_ids[] = {
 	{ .compatible = "renesas,r7s72100-rpc-if" },
 	{ .compatible = "renesas,rcar-gen3-rpc-if" },
 	{ .compatible = "renesas,rcar-gen4-rpc-if" },
+	{ .compatible = "renesas,rcar-gen5-rpc-if" },
 	{}
 };
 
-- 
2.53.0

