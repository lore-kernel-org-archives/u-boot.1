Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B76FB5EA6
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 02:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1676D83FA3;
	Tue, 17 Mar 2026 03:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NqsLaTBl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qrVXERbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8844283FC5; Tue, 17 Mar 2026 03:18:06 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6A983F86
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 03:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fZbGK4llLz9tZ3;
 Tue, 17 Mar 2026 03:18:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773713881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NiqC2p10ysaaiKrB2pS0OjxApi0KCBGpKbWvll0zm6k=;
 b=NqsLaTBlMObgHaDLqLgtOyea8mNwoncj6g880xOTa225Brf7QZ9rCVqCp+Zu0IWQRy43ru
 fPUW1BlYhyGnPZBb4ID2GdbM+chsQq8qbX41IUIClAw9NlD9VF1uD6mUplOWatenSvf92O
 UuO5ji/2DLDc+QzbcyEFMJxLiBr3UnVA3TTf+8HlAW5r3IKEK8S8+DnN17LfSeUT/PxZw7
 nS6+1Ic0xOzDKB9+xSrcHrNo+W8qsJKR+oqzxAWSl3yRrWt7YD9VoSOQ9aYSk1bYbrc5Ia
 lQot+z29PyxjJOUA7K2LX4hZRxDV0IBYie4B9O50eU865203ehCHzuSUWWzH/Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qrVXERbj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773713880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NiqC2p10ysaaiKrB2pS0OjxApi0KCBGpKbWvll0zm6k=;
 b=qrVXERbjNnyOcXCcXpVPMenANqWGvDKBUZ2tbGdZOpGv4v46vzaNw3F3GyYNMXWuF8sChT
 7NUb7g+INEaEY0mjALRZEi0U0EpQ2gbK23Ng/Q4/8EgJCHzdXCb9VrxOPnSlHtoWEoKqZ3
 TvND/TsyQdkln+2ul4ge+9YtBs8nTFz3c5Ib8k9rZRb/cSlQnGJyTb9xWMGlTtXNEYmJRp
 Sm7CFcKkEW3Yw7R31rfDwLpSpNX80vR4vxBSEuE80KeDY8VxnSi23FSHYFadgt+jbAqTEI
 CS2GZFOfryX1s5gkcYggXzFFLBn6QxIl36gJBpqQv/3yPIfvg4uO/Fy6NzRbPg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] console: Prefer currently selected serial console as stdio
 device
Date: Tue, 17 Mar 2026 03:17:40 +0100
Message-ID: <20260317021756.196402-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0fe8165ce5a6889aa2a
X-MBO-RS-META: ycp51f6ozfdi4zwjezi7xc819atgq1n7
X-Rspamd-Queue-Id: 4fZbGK4llLz9tZ3
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

The scan now iterates over the entire list of stdio devices. If the
current iterator stdio device is the current serial device, or there
is no input or output stdio device assigned to the input or output
stream yet, then the current iterator stdio device is assigned to that
stream. This way, the first suitable stdio device is assigned to the
stream, but the current serial console stdio device can override that
assignment.

As a small optimization, if the current iterator stdio device is the
current serial device and both input and output streams as assigned,
then the loop can terminate, because the current serial device has a
chance to be used as a stdio device at this point.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Merge the two loops into one
---
 common/console.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/common/console.c b/common/console.c
index 48586fd2166..22e554cf203 100644
--- a/common/console.c
+++ b/common/console.c
@@ -1212,13 +1212,16 @@ int console_init_r(void)
 	list_for_each(pos, list) {
 		dev = list_entry(pos, struct stdio_dev, list);
 
-		if ((dev->flags & DEV_FLAGS_INPUT) && (inputdev == NULL)) {
+		if ((dev->flags & DEV_FLAGS_INPUT) &&
+		    (dev->priv == gd->cur_serial_dev || !inputdev))
 			inputdev = dev;
-		}
-		if ((dev->flags & DEV_FLAGS_OUTPUT) && (outputdev == NULL)) {
+
+		if ((dev->flags & DEV_FLAGS_OUTPUT) &&
+		    (dev->priv == gd->cur_serial_dev || !outputdev))
 			outputdev = dev;
-		}
-		if(inputdev && outputdev)
+
+		/* The current serial console is the preferred stdio. */
+		if (dev->priv == gd->cur_serial_dev && inputdev && outputdev)
 			break;
 	}
 
-- 
2.51.0

