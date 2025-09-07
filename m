Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F41DCA101F
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 19:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F314D802C1;
	Sun,  7 Sep 2025 21:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ikq2z9QD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mTk/TnsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09EF803F5; Sun,  7 Sep 2025 21:16:59 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6B8800D7
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 21:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cKfw90wVNz9tJh;
 Sun,  7 Sep 2025 21:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757272617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oyS1rqhtn92HA8/dWy9CzsGLBavkxGH9DNeU8J2IlsY=;
 b=ikq2z9QDxwZS7T7/20QiEjPnMRdBmSZUu6neTTbjCyNhwq+ZNQt8COG86KHeobGOZpdvF+
 qRqOsiC/tYyK2EEhBXrT94eDEokRErVxGNQ+B5tnFH2GCgRUA9/tlEPWwPB6Kqhm/DC8w0
 DgNZ4bFmvNwyOWBj8gzFGqZJKO4xHQLofFCUfQIVWFsBgrZ34ZIjSjWfbPUhuBvATALhds
 2mkUcjkrtwLmWBWJdGcMY5Z+vpZlrgzV/NblVrni4i4A2Ow06QS/XIoKVXjOJY+SiPQS5T
 LN/DA5kLkYWej4+PajgroLb2MtdbDBuA7vkgdch0SaDB6j8b6tp4Ny95xCW2Bw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757272615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oyS1rqhtn92HA8/dWy9CzsGLBavkxGH9DNeU8J2IlsY=;
 b=mTk/TnsBbnPOTXnr4pO18Jqge2U5txIU/4+6UCra3I2mMsQLIbZvkcMsbJ919TcOJOjs1M
 yaLyHtbHbS+cdGbRTB8MCWAFdgRMtj+Ajpg4yyJd6wAiVHxKTqfoSY8WG1iFaKBPzd1d7J
 Di5HxKYB5gAbuuajRH/kQHUE6Y1IUkXRLdmcinFq6rTmcH14l8AlLHEo3CXalU5NKELX4c
 7odYrF5+PjoTfVa+p0TlmvcCOLgSxraPcvSFYMiniiQBtvL5fBHRcanaTuR3ROMZExm39s
 Vcqchdt0NORbiCJedhxmRKc5M6T+c9uB6y7zf6hZ3ibXSLnhxlP3FJiHcBtRqw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] serial: sh: Handle HSCIF RX FIFO overflow
Date: Sun,  7 Sep 2025 21:16:27 +0200
Message-ID: <20250907191645.331925-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9wewo5o5ndgszfhtkcrrduw7nn65o9ry
X-MBO-RS-ID: 42bdb9e14c6d328605c
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

The HSCIF RX FIFO may overflow when data are streaming from remote end
into the HSCIF while U-Boot is still starting up. In that case, HSFSR
bit RDF is set, but HSFDR field R is zero. This confuses .tstc callback
into considering RX FIFO to be empty, which leads to .getc to be never
invoked, even when user attempts to pass more input onto the command
line.

Fix this by considering the RDF flag in serial_rx_fifo_level(), which
is called from .tstc in case of no errors. If RDF flag is set, trigger
the .getc callback and let it clear the RX FIFO.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/serial/serial_sh.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index e4cc4ee4260..7ab62e0e90b 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -112,7 +112,16 @@ static int serial_raw_putc(struct uart_port *port, const char c)
 
 static int serial_rx_fifo_level(struct uart_port *port)
 {
-	return scif_rxfill(port);
+	int ret;
+
+	ret = scif_rxfill(port);
+	if (ret)
+		return ret;
+
+	if (sci_in(port, SCxSR) & SCxSR_RDxF(port))
+		return 1;
+
+	return 0;
 }
 
 static int sh_serial_tstc_generic(struct uart_port *port)
-- 
2.51.0

