Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ED3CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5404A84C20;
	Fri,  8 May 2026 00:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tZwKRVj3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cVlbZCVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D84084BC7; Fri,  8 May 2026 00:07:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B62E84C20
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBRFG6rnRz9ttL;
 Fri,  8 May 2026 00:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FW1gTeeMchtZ6Ts1DP3lTp439UYANoGxDcLTK59OzW0=;
 b=tZwKRVj3uXvXYJAbOJj8SUZRlvjq/VEqNHF521NqhAXNsJhE+YiJmbmsnG+MLJ8wtbwYma
 yfewUreUAaLdCThZkEnmweaYjiGRZXhePmIGpZvDDILphLKy/g0B9BelcWBRebk8gQPTyT
 1NwICSWLV6tDLHFyQFyIGjBnc2VRmoGSKlxPUwLSbka/hd+w4zPccnyf5Cnc0PnRF8BmoX
 ZLsjXnfBDLFwbZJGvIDCBxAISGVZFuvqTgR9dgA3mhJ3HB7msJNmdp82aI1Tywa0hd7Sat
 ogFG1kMf7hpnW86xQh5wzt5Otv/CoewPPyHAYok/STKxKUneM0SqVaL7dTbS6Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=cVlbZCVF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FW1gTeeMchtZ6Ts1DP3lTp439UYANoGxDcLTK59OzW0=;
 b=cVlbZCVFXfSZbWz+VvsbowtFmUjLyBJVHWFoFrm86l0WNIQDwzFpplI4LhzQNBUxpOkqLO
 S2DUPrRrgeRbe8MR9sAah6leEzoUBTtVknyKbyaQ3f+XrR1bIP22lu5JOUxdwVLMiDetmw
 sNlvKm7MmQGcEEv6/Rr69dfEPS3Z7LSXm6B2Cim4bN/9NoSx/1CEtgVKMBi4pHFCCQmAe6
 UH3dcVT9oGgviEioaoG2iHheT387z9ycaZbT0R9w3dUawHQHsfznnEOYYkfY2QcduTeQPb
 pKjQlCVG3v6sLsGCHT1fA7ntlC6SE8JKbnYQqeNcZQuJaGJUVQ63MF8TymuQKA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] misc: i2c: eeprom-emul: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:07:15 +0200
Message-ID: <20260507220725.209205-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gtckii6p59udad5q4jxyinge5qyh8mci
X-MBO-RS-ID: e2d9f0fc6416baca4bf
X-Rspamd-Queue-Id: 4gBRFG6rnRz9ttL
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/misc/i2c_eeprom_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/i2c_eeprom_emul.c b/drivers/misc/i2c_eeprom_emul.c
index 3ad2e047ee3..40f34ad03a4 100644
--- a/drivers/misc/i2c_eeprom_emul.c
+++ b/drivers/misc/i2c_eeprom_emul.c
@@ -144,7 +144,7 @@ static int sandbox_i2c_eeprom_xfer(struct udevice *emul, struct i2c_msg *msg,
 	return 0;
 }
 
-struct dm_i2c_ops sandbox_i2c_emul_ops = {
+static const struct dm_i2c_ops sandbox_i2c_emul_ops = {
 	.xfer = sandbox_i2c_eeprom_xfer,
 };
 
-- 
2.53.0

