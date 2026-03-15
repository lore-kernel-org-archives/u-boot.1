Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7B2F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83AE984497;
	Mon, 16 Mar 2026 00:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Iazq9Uca";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NBo5/nYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4FD84486; Mon, 16 Mar 2026 00:54:02 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A63283E36
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fYw6b1YxGz9twG;
 Mon, 16 Mar 2026 00:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aLnegvGqtlNkmptHyoVmaTskoeKjzrQmS6W80gFGhZY=;
 b=Iazq9UcagraGy02Yphf017Oc7yA0ga6sLTYYu+o8Cj+x/6jiU7bWdbE8KTEh5uo5c+Wvw1
 lm3auywB5bwmvi/kMM7EcE/XiwFQUxhyDXokOdBiuZojzSSWEtK1g7ktsIH2iz2mdIZqdG
 lMsq0NYdu5BT/+sebo6ch0j/DM8Ds1QGUU5SCaYFp/UWWJxYSH78V3zID0YeJ2sNiOOuTG
 3MecwqGIQhAsTWMYU9VD/zXv7BZ1Cw7ZvGs3mvD5cqK+NgshQyJzpJGOmY7+y/11w0WHb0
 LSi0J0JnG30cXCa/cU1X2UWQa2PkRlA3dhNXWmvTF84DrAemIYRZKTTyWCRe7g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="NBo5/nYm";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aLnegvGqtlNkmptHyoVmaTskoeKjzrQmS6W80gFGhZY=;
 b=NBo5/nYmr16nmIM/uAkarABEUPZo/2H0ss4LrBm7RVWv4HD8BTo+y5txTTh39FaUf0lFdd
 EkV4BV7E3ytgT4UbN8/RUiXRRN4nLaXwpBjKCjEXiJBPtOYuhVx/D/H47T85UE+hJaVNEt
 vEl+ch+N8s61KRFsoluKshPEPym0xaIlVPNXhXo0zyyu8pRC3B267e9IOMkqeNrZdpKqhI
 PTunCyzW9wEGEiL8UguGV2G0636h4k3Lnjzf9WXkeZVQ20vsp33CY6lGv/SOSeKlyAKwch
 fFA0D28jWUAA3AlVpAYKEENKCtJg6nmZ4Nfvnp7leKRbO1i5nxosQWuJZBMp9g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] console: Prefer currently selected serial console as stdio
 device
Date: Mon, 16 Mar 2026 00:53:32 +0100
Message-ID: <20260315235353.304637-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wwjt3wrdka8juyadtnsrcpnrxiuxnt45
X-MBO-RS-ID: a1985c3f1bb1d2f4063
X-Rspamd-Queue-Id: 4fYw6b1YxGz9twG
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

Adjust the scan for default console stdio device to prefer the
currently selected serial device. This is useful in combination
with CONFIG_SERIAL_PROBE_ALL=y, in which case the system would
instantiate all serial devices as stdio devices in the order in
which they are listed in control DT. The currently selected serial
device may not be the first device listed in DT, in which case the
current console_init_r() implementation unexpectedly switches to
another serial console after listing stderr using "Err:" line, and
just before showing U-Boot shell, which is not the desired behavior.

The scan runs twice. The first round looks up the current serial
console device and tests whether it is suitable as a console. If
yes, then the scanning ends, otherwise the second round starts.
The second round of scanning simply picks up the first suitable
console device.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 common/console.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/common/console.c b/common/console.c
index 48586fd2166..3de53c66094 100644
--- a/common/console.c
+++ b/common/console.c
@@ -1208,17 +1208,35 @@ int console_init_r(void)
 			outputdev = console_search_dev (DEV_FLAGS_OUTPUT, "serial");
 	}
 
-	/* Scan devices looking for input and output devices */
-	list_for_each(pos, list) {
-		dev = list_entry(pos, struct stdio_dev, list);
-
-		if ((dev->flags & DEV_FLAGS_INPUT) && (inputdev == NULL)) {
-			inputdev = dev;
-		}
-		if ((dev->flags & DEV_FLAGS_OUTPUT) && (outputdev == NULL)) {
-			outputdev = dev;
+	/*
+	 * Scan devices looking for input and output devices.
+	 * The scan runs twice. The first round looks up the current
+	 * serial console device and tests whether it is suitable as
+	 * a console. If yes, then the scanning ends, otherwise the
+	 * second round starts. The second round of scanning simply
+	 * picks up the first suitable console device. This scanning
+	 * method allows retaining the currently selected serial
+	 * console, especially in case DM contains multiple suitable
+	 * serial consoles and the currently selected one is not the
+	 * first stdio device in the list.
+	 */
+	for (i = 0; i < 1; i++) {
+		list_for_each(pos, list) {
+			dev = list_entry(pos, struct stdio_dev, list);
+			if (!i && dev->priv != gd->cur_serial_dev)
+				continue;
+
+			if ((dev->flags & DEV_FLAGS_INPUT) && (inputdev == NULL)) {
+				inputdev = dev;
+			}
+			if ((dev->flags & DEV_FLAGS_OUTPUT) && (outputdev == NULL)) {
+				outputdev = dev;
+			}
+			if (inputdev && outputdev)
+				break;
 		}
-		if(inputdev && outputdev)
+
+		if (inputdev && outputdev)
 			break;
 	}
 
-- 
2.51.0

