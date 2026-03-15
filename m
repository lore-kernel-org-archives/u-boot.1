Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A638F3027F
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D40FD838BB;
	Mon, 16 Mar 2026 00:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LXqH1II1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QZlZpt5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9EFB83952; Mon, 16 Mar 2026 00:56:07 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F368352B
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fYw901V1Rz9vBD;
 Mon, 16 Mar 2026 00:56:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P0BQYjvSbE/YkjXkHyhrxTDAkJ4v8QVQqS+H8B5fJi8=;
 b=LXqH1II1mdWeB89uTVpJ7d1Fafj6En0/QHK/SUSZW8Icz4DN8cQRp8meDHOptgCDRJweB8
 FlKAWGF3Ve0d0WCKVngFo+tnCMvR3mX2F6YGO0Y1Dgn+kobX9gAORk0MBham3Gm0ny8E5q
 JNticBrPJVNS34Gz5doR+4kCHJB8cEpspp5JwQDA6Zie5BAhHrm6/LDoJaEG1Hsg6aJ5zb
 VhWH9R9WB0YEo5c6tP56DxUPz4+RqfvAHpUDILhjNYTaIFH1+ox3sv6treWzOjzJh1+r1n
 n+tYtxyZIuEFUnYGgSsx2+n4a9VRKR3p2m21BxNYJLMJi9FfhL42Jqb0v0hP9g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QZlZpt5c;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P0BQYjvSbE/YkjXkHyhrxTDAkJ4v8QVQqS+H8B5fJi8=;
 b=QZlZpt5cB4x/ZAMfdHEH6bXF9zLoni0mEr08jVAJjaslWLSa+6Bs6jNfGoOOe/Slq/yX8w
 126BbZOC5rRUzmiC9vRe2CqeBdYo6Svol+9sWo1/75xackqT4WB0sF3Mz67FDcLGzV/ul0
 BRJaKo/ppU5ighv7YLq2QlwXnF+CAuO3De4wNUNETyw17nAKkM2MQ5tpZta1Jt5/Il4mZ7
 AHacfk7daoqHei2s/ES5lTKlL/Gk2vFm44SpUsnKYeMCx3nadukblNx0wdfhjiI0Y8tF+0
 0oPJCxO00ILPXTyz8T4hBFc7ioQN/Cq689c6GEy2AMKQEpeiOJrTmCFp1AgwPA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] serial: sh: Handle HSCIF on all 64-bit R-Car SoC
Date: Mon, 16 Mar 2026 00:55:33 +0100
Message-ID: <20260315235559.304721-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g64hwana5xopet7js51kd6xawzcnk174
X-MBO-RS-ID: 436d656a84e06c97048
X-Rspamd-Queue-Id: 4fYw901V1Rz9vBD
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

The HSCIF variant present on Renesas R-Car Gen5 SoC is compatible
with the HSCIF variant present on Renesas R-Car Gen4 SoC. Enable
HSSRR register programming for HSCIF present on all 64-bit R-Car
SoCs, which covers R-Car Gen3, Gen4 and newly also Gen5.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/serial/serial_sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index 7ab62e0e90b..bc205234e24 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -59,7 +59,7 @@ static void sh_serial_init_generic(struct uart_port *port)
 	sci_out(port, SCSPTR, 0x0003);
 #endif
 
-#if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_GEN3) || IS_ENABLED(CONFIG_RCAR_GEN4)
+#if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_GEN3) || IS_ENABLED(CONFIG_RCAR_GEN4) || IS_ENABLED(CONFIG_RCAR_GEN5)
 	if (port->type == PORT_HSCIF)
 		sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
 #endif
-- 
2.51.0

