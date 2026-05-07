Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8110BCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1857A84BC7;
	Fri,  8 May 2026 00:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="liExTu/i";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bKrVtiIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276FF84BE5; Fri,  8 May 2026 00:07:33 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AB484B86
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBRFG2XvBz9tZ5;
 Fri,  8 May 2026 00:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ir8hJJus36QvD0U9zCAmL9ClKfYbF0QM5xP9d/On5UM=;
 b=liExTu/icIOyxiVfJwEBV5UEUihyaaMHNnah0QwbvTqV3I0NvQLsQUpo2T2+iMUDVb4DOj
 Lsk2UvktkOQAPOUov0JD3XTpxzce9xpoQrS7cOzCeYRqhDaW7ZmHZSZgXYdgZbU8RH/DTb
 gV7hDhbIAtwkpJ6U32RPjX1Elr0fO1zwudBwZhYPYaBTYloasQ5rXZFH0zsBDDMeQh3oTU
 h9DvxpmZYJs0GtMVFftJPpeFA2qlXNLtMzutkbaZ0g9m55Ve7kfsQeJInSF0JVyIZfrcHS
 4YZAqObwHyn3Cc8j9kH287k4XOL/JQNXAjHzbQoN7O/jWM1BaTH0AZ8GF2z4/A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bKrVtiIt;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ir8hJJus36QvD0U9zCAmL9ClKfYbF0QM5xP9d/On5UM=;
 b=bKrVtiItSNXuXUInL7veaO1Z2nX1KtIPGePpEXEmkrpKUKvRKwOObl5+d14mvpkSDxanq4
 ujUrEbiLZl3bkL8x/MzgwQuPBViUTil8BWIEurmO1wz0F4n5Ma11OkZtfDROcLmGl/2SP1
 Y0U2CRAaFfJDqqHQa34+b3vSg7lIVGfGohJrCwFdMInw/7gsGcJuIn/z50xDaqB6leBcZ3
 2MkRe19NtXiiCPImLLrI+lIaKQM6jb01xS2h1AavpZVX3U0lkCcrVuZTDd1lI7Rs4nw30f
 o8KZrwcmOTsvjDAFaCmKA8dcunArIsaxhrGu1TyQVtwT1sWA5grNGCjONVqXQA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] misc: cros_ec: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:07:14 +0200
Message-ID: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cgg6o7oagxoeb13sd7m5cusqdo7ytdtp
X-MBO-RS-ID: ff843b1ff13bf1b70b1
X-Rspamd-Queue-Id: 4gBRFG2XvBz9tZ5
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
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/misc/cros_ec_sandbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
index 432b1fbb0c4..5b9c6354bef 100644
--- a/drivers/misc/cros_ec_sandbox.c
+++ b/drivers/misc/cros_ec_sandbox.c
@@ -726,7 +726,7 @@ int cros_ec_probe(struct udevice *dev)
 	return cros_ec_register(dev);
 }
 
-struct dm_cros_ec_ops cros_ec_ops = {
+static const struct dm_cros_ec_ops cros_ec_ops = {
 	.packet = cros_ec_sandbox_packet,
 	.get_switches = cros_ec_sandbox_get_switches,
 };
-- 
2.53.0

