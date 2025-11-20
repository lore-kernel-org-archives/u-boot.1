Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C954CF256D
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 04:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A748F84021;
	Thu, 20 Nov 2025 05:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZhVb13Ce";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="brNmjB9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4346584034; Thu, 20 Nov 2025 05:15:33 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7249083952
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 05:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dBlPv13k1z9tKJ;
 Thu, 20 Nov 2025 05:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ygIhrMFqk28090N2ak2JrvSJjWxjxZpZ5DGWc5ibbdA=;
 b=ZhVb13CecQMiP6W4zDL7gBo7WCc4EYCyiHsB5QJC46M4QfjGXJqv/JRvotBDGW6N0Qrjfd
 Olcei8VS5ziWB52oUW/LGtiUMGXxpKaWw8lah9ijMXHGp1u+ZyWK5yA0jcIZcNGxhqmSQl
 uQb62tdIBkXJKHl132cp2hFCaFqaHv9dTXjBZKLbcD/rv+7Ze9afWVzgbREpLkK5DMyP2J
 35WuWTc2NSYhBPMho08HqPcEm5giGtoV+lnbdwZ7TRRXB66vUkwujA0lkGg+zw1Yx2gebM
 KvKc5m/d7+YrqRwXIIPFyJb4mvxsZGDzjful0gIDJWZjJZb5CrauBYcmDEcAyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ygIhrMFqk28090N2ak2JrvSJjWxjxZpZ5DGWc5ibbdA=;
 b=brNmjB9JAdA1dXnsnqjVfGJde5BDY2dX969Ct5/DxXa6F/qFIcKQsK/AsidvxPuVre5Hsd
 dRG+scZCS0f2c9wpE2SXwujNeFosizbAwr9U1ZXgdiBKoARtLtttRR1Hm3o41mDIjhCKAx
 IoyeHDZjQmFPm3SfzDPOOcKIjnYyHzeMUvQj5agc1aitoRscig10YJAeyElrUvrrRgCwxv
 QczcffgsT9PzVcae2KwtlOtFXyGaNNgX9OfqccG4RFDq3RnowZT6nxV3qJc32bR8RHZNXa
 +ZhXfaCcWMD9CMlfOo53/BCkA6wzc/xcI0uY7tM+4lpLFfExK7mO2H7RrJ5LIw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Date: Thu, 20 Nov 2025 05:15:08 +0100
Message-ID: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bc7cwyui9ezeq1thqfbct376qedctqsh
X-MBO-RS-ID: cb7c320599fcfd43825
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

If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
and passes result of ofnode_to_offset(node) as an offset parameter into it.

The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
because libfdt can not handle negative node offsets without full tree check,
which U-Boot inhibits to keep size lower.

Since i2c_child_post_bind() already calls dev_has_ofnode(dev), reuse the
same call and assign i2c->speed_hz = I2C_SPEED_STANDARD_RATE in case the
device has no valid node associated with it, and do not call any of the
dev_read_*() functions for devices without valid nodes.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/i2c/i2c-uclass.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index 380a9f8f3ad..d0e9dad7202 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
 #if CONFIG_IS_ENABLED(OF_REAL)
 	struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
 
-	i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
-					     I2C_SPEED_STANDARD_RATE);
+	if (!dev_has_ofnode(dev))
+		i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
+	else
+		i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
+						     I2C_SPEED_STANDARD_RATE);
 
 	return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
 #else
-- 
2.51.0

