Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078EFCD3423
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 20:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6416488D3D;
	Sat, 31 Aug 2024 22:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N49OQMA7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Wr3ZiCpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9C088D86; Sat, 31 Aug 2024 22:32:12 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDBB8861D
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 22:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wx6Bd3lBqz9sWF;
 Sat, 31 Aug 2024 22:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WCLt5JRccAfowenUJSezdNcgirjlnH5Uc0LuUqIW1hA=;
 b=N49OQMA7M2FAW82Nu31Vi6iaVxZpdaUgOQOJSysb/BBKkKSp+93o6O2Ucz0s/0kbstsUc6
 7tHHeKkqMSOPK7lauhp0D/CE4Dphqg1ZmRkU0zmdYqSL9bjhQNxYtAGKQ9k6KTTnuLIPUS
 U3Ww38uodjdlpEHCSvRSPY9bnsSfvufBeR+FAtdO4N21CJd7WwyLSdzM4AuoRRa3rvpsKc
 TjknGBnY5qe18drwFDZD/hRqEijk9B37LzW5mqe1OSoWGZQD4Wmc+gsGkVyLDisjrtD/y5
 Zw8IskgGp+vbjJoFNA5T4QBsnJIZWbPetbaimxhDMACyIHexj/sb+kIKC+BuyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WCLt5JRccAfowenUJSezdNcgirjlnH5Uc0LuUqIW1hA=;
 b=Wr3ZiCpGkcmnr2rIGJXtTLOC6aKlZuOmaOVwHyFkkWoD6a3WcYaRtcWljw8vbgS6Z9lbYw
 e+dpSRTocXLGYcBR/W4rziCE32Ev8mC0QKTaKQkNhql/rNx4t8o/07peiaEUxw5BPnF6rP
 +yucIBCAsqJUdPeEFCInh7YUSNvOVi6WJ7uo5dU8+BUL9wkoGJJ15CClKtTuNDmyr7fHgv
 XnLnO5EgDWngYneLKp7B8L01k7+E0lvdGgCovl9RBOL60B46uykdUtyzJx7EBgWGhb92R/
 Q2E2FL3zfO28yNyr1bmLD7avhyqNEfl09joUkWfe+ZzPojnvOBn63c1bmEZkcw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 1/5] mtd: spi: renesas: Write DREAR register once
Date: Sat, 31 Aug 2024 22:31:44 +0200
Message-ID: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0346725e6fc4e2924d6
X-MBO-RS-META: 1nw6r9gtnsnzcpomqcs8riay6j4tuh5w
X-Rspamd-Queue-Id: 4Wx6Bd3lBqz9sWF
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

Instead of writing DREAR with 0 first and then overwriting DREAR again
in case of 4 byte addressing mode, write DREAR in every case once with
the correct content right away. No functional change.

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
 drivers/spi/renesas_rpc_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index e6b602cf7b4..749c686a6c4 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -277,14 +277,15 @@ static int rpc_spi_mem_exec_op(struct spi_slave *spi,
 		writel(RPC_DRCMR_CMD(op->cmd.opcode), priv->regs + RPC_DRCMR);
 		smenr |= RPC_DRENR_CDE;
 
-		writel(0, priv->regs + RPC_DREAR);
 		if (op->addr.nbytes == 4) {
 			writel(RPC_DREAR_EAV(offset >> 25) | RPC_DREAR_EAC(1),
 			       priv->regs + RPC_DREAR);
 			smenr |= RPC_DRENR_ADE(0xF);
 		} else if (op->addr.nbytes == 3) {
+			writel(0, priv->regs + RPC_DREAR);
 			smenr |= RPC_DRENR_ADE(0x7);
 		} else {
+			writel(0, priv->regs + RPC_DREAR);
 			smenr |= RPC_DRENR_ADE(0);
 		}
 
-- 
2.45.2

