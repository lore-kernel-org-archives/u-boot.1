Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8982BCD13D9
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 20:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D88C88DB1;
	Sat, 31 Aug 2024 22:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xdY4KUtO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WkjeS+qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DDFA88D96; Sat, 31 Aug 2024 22:32:15 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6CE588D92
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 22:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wx6Bj2lQwz9slX;
 Sat, 31 Aug 2024 22:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l++f/OBvNFarYjUVLXIMeDXzuY4pCvZXfQ+5Dg7YxTE=;
 b=xdY4KUtOf5vId17dXfvkMDOmAcS/sKWpjZ3xL9GJw2gCkHgxLF4VoKY1aJSvnRHH4XSIWN
 vDgxKEcTPTEhJRLmXTR1uOKFAtrioJJTR6eE//zIx2fjLDOtBikU+/HUIxwaa6S7AGPvx9
 x8+rh8gdeeHzxxXUPzf2XScSf0/z9G+9VMuvdQNWPyh5Doz7P4awRqgblgMdqQ3/pzZndK
 lFAASoPA64wr/Fk/Xf/FQT0Ibhz/ViRXnoEXyhLBdX4BHlkqGPZwR+iUv35cqs1fIIrLcn
 V18f1/pzQAs48M9+fGeFQlBbz84xMm4V93claOkB/h+/ykHV3ZEU6fGMq+BVwg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l++f/OBvNFarYjUVLXIMeDXzuY4pCvZXfQ+5Dg7YxTE=;
 b=WkjeS+qpYZKjLWqvh5PHJyrtda7VSQiNv05bplulPc6ez0H7TJgWLVjn8HGOA303N9UXgV
 MPH84d+x44iDfucxSB2GFBUeHnYtuED95bCbz4zWyfEbALh8tLunbswnzgz9jGMJVZtyls
 stHbtxh013ZNBTq8LPuQ5hPWIAWPq5eU4Kug9bcGES2lEMygjGjuPD9ssIFqxiQg7kfFMN
 crvqPy7wpA/b72dTlWT9Y/p0wVKS+PX/ykGdC2YQrfeo0ePG5Ipp9o34k9D10qQkkBCyIB
 LmBYuASWkq5yLfQ83MrCTxiMX23aHDYz0puFj6+oZculeY85MOgkRpAr9KzUJQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 3/5] mtd: spi: renesas: Configure DRDRENR register
Date: Sat, 31 Aug 2024 22:31:46 +0200
Message-ID: <20240831203153.547743-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
References: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b3def2f327face91a3d
X-MBO-RS-META: 6yki3b439ze6h5b5hy696ipofdr4qzkx
X-Rspamd-Queue-Id: 4Wx6Bj2lQwz9slX
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

Make sure DRDRENR register is configured before performing external
address space read. This register might have been configured by a
prior stage bootloader and leaving it unconfigured would interfere
with U-Boot operation. Since U-Boot RPC SPI driver does not support
DDR data transfer mode yet, set this register unconditionally to 0.

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
 drivers/spi/renesas_rpc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index a2ac5525b90..50890981149 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -294,6 +294,7 @@ static int rpc_spi_mem_exec_op(struct spi_slave *spi,
 
 		writel(8 * op->dummy.nbytes - 1, priv->regs + RPC_DRDMCR);
 		writel(0, priv->regs + RPC_DROPR);
+		writel(0, priv->regs + RPC_DRDRENR);
 		writel(smenr, priv->regs + RPC_DRENR);
 
 		memcpy_fromio(din, (void *)(priv->extr + offset), op->data.nbytes);
-- 
2.45.2

