Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD37CD3425
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 20:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C552988D94;
	Sat, 31 Aug 2024 22:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GX18Jngi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WdVJAc8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3DCB88D96; Sat, 31 Aug 2024 22:32:13 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B8388D64
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 22:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wx6Bg4WW3z9shq;
 Sat, 31 Aug 2024 22:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HZIGEJXEb0Zv1CoMrZj8X8LO6uRMlierx6Ef6qL01Q=;
 b=GX18JngidtwIh/gidFMog5WGprp4i8LrSXrrgz7hTJ4AxQ1n1tGje9xPMVlWOregGaI36g
 XsiMNW9Z7wa/rNNUz+5DASIi/mVHwklRpXFXhsjxkZlw2azctjS07ishyZatmATuj7d4uf
 M0DEPMKWe8KtGGc85KXJMDNuulvFkABQsnAUo6B4NJ7mb6wq5GanysLqxv+c5mOUSLoEvb
 PAj9gBTUQ+KLldQXYSrKSKo+jdCy7+da5buw+T3Fy+AZ4gF7JR8qxkL7OStqWKjdW2c9oc
 HYiUNa/guYVCd/8nYzIsRxDK4JLtHy7oI1s+B9d89I1y8LpCqfTnbBu9MyZE5w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HZIGEJXEb0Zv1CoMrZj8X8LO6uRMlierx6Ef6qL01Q=;
 b=WdVJAc8owYIs1gf2DwR8D4UZlUtyBlRj896T+CuiF3o3ywN24nPP8y7zaPukdS2Ja1PQ++
 CMW2qcFQBaCD3RE4mSo26RDxg49zv0vl9OWW0sZFKoDBQbzqOF9Pw5q6jSCHYbxh2l8NY1
 YXKvyoKYCxw2slelUZSrQKCIxoAbOds8ZHbd1O9ooFJoI3JE/kWlOo22j9G6ptaWSCsk7N
 ytBhu7Oi4pf5Yduj1XeLu567QUqNjozfv5ktGHv598z9Yybs/mDLuQqkER/OQt86XltA3M
 WFd+7Do5eSk+LkYZgFfgB1u8zgZVcay4pbkvv/R6aIdqHW5hUXj04IeRX10lkA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 2/5] mtd: spi: renesas: Write DRDMCR register once
Date: Sat, 31 Aug 2024 22:31:45 +0200
Message-ID: <20240831203153.547743-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
References: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b3d7b8862b08f487e2f
X-MBO-RS-META: eogfiqgoj33mabttkp5znsz1z75uxdka
X-Rspamd-Queue-Id: 4Wx6Bg4WW3z9shq
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

Instead of writing DRDMCR with 0 first and then overwriting DRDMCR again
in case any dummy bytes have to be sent out, write DRDMCR in every case
with the amount of dummy bytes that have to be sent out. In case no dummy
bytes have to be sent out, the value written into DRDMCR is zero, so no
dummy bytes are sent out. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: William Zhang <william.zhang@broadcom.com>
Cc: u-boot@lists.denx.de
---
 drivers/spi/renesas_rpc_spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 749c686a6c4..a2ac5525b90 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -289,12 +289,10 @@ static int rpc_spi_mem_exec_op(struct spi_slave *spi,
 			smenr |= RPC_DRENR_ADE(0);
 		}
 
-		writel(0, priv->regs + RPC_DRDMCR);
-		if (op->dummy.nbytes) {
-			writel(8 * op->dummy.nbytes - 1, priv->regs + RPC_DRDMCR);
+		if (op->dummy.nbytes)
 			smenr |= RPC_DRENR_DME;
-		}
 
+		writel(8 * op->dummy.nbytes - 1, priv->regs + RPC_DRDMCR);
 		writel(0, priv->regs + RPC_DROPR);
 		writel(smenr, priv->regs + RPC_DRENR);
 
-- 
2.45.2

