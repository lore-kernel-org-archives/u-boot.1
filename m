Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B6DCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2AD84BC7;
	Fri,  8 May 2026 00:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xeP4Ifie";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ob8fEkhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3344884C12; Fri,  8 May 2026 00:06:23 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1023684B86
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBRCw6Xc5z9tMq;
 Fri,  8 May 2026 00:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MmOOzYUSCSoj37rOEhBDY17OL1B9P3/u73HCaRNBYSg=;
 b=xeP4IfieaGrLRK4tTqupNjGYFkpRNdsuBnSWsnhRrjWc2fbuYwgswjA6s0cYTzeLOeVwXN
 j8JGSqLqhOydS7qUdh+zVLGp3tziwkmhDPLw6kg6phho/WL5gihvUkyQLRP3ydLyCU2MGn
 SqRa6tkRh1qtUd5RwfB43Ws72mm7R0QP7w3z3/IZfAGTPoJG0rHCN8skNMb//Qz4nUWETh
 dKoDcsgNnkelFynVMZCxpMHrPKWRlX8T+z8KenZUI0ZpvlXzaNJsJXb7qOVkQQEJAXbd+U
 hq+jVHZgUG27+GeyVdurQWXYLGUf/3W1uVwa6+3cC5CfXQbU5XyQ1+2N1NHWEQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MmOOzYUSCSoj37rOEhBDY17OL1B9P3/u73HCaRNBYSg=;
 b=ob8fEkhkbyHk4vAQjJ68PqktqR2sn5YaBawVg1MN6PgdZfFqkfiTJOPQwhGICUHN3yzWNM
 Ta+wsSCEioencKRWZvSKIPONI5Z8r3x0LYHWd5UgpbJvErI6UIlX2lnrkU4VqtI6M/r2IW
 0ZjxduomeMMVqCAqa9qPwGZfswOpObqWWe8FYT3DSDwpvnUyfocOlAxf6Xy15Ky+E2NxIw
 u4F0F5b+HgXgU1HJY5vWucc3639VtZigCO5kMLxkvb5QAwxS9SMKs/13dkMyOTRoh+MNp4
 Xj5BdAJKBb3M8PyZ6F0F2jD/+oRWjhN0/U84OXFcRFzGzXOFMEVFuzhBMIvALQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: designware_i2c: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:06:11 +0200
Message-ID: <20260507220617.209146-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2c8ab343b723670e146
X-MBO-RS-META: o187c6m48sbgoojpb99ztpk76p5844xs
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
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/i2c/designware_i2c_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/designware_i2c_pci.c b/drivers/i2c/designware_i2c_pci.c
index c21c412231c..ad4122c2abd 100644
--- a/drivers/i2c/designware_i2c_pci.c
+++ b/drivers/i2c/designware_i2c_pci.c
@@ -168,7 +168,7 @@ static int dw_i2c_acpi_fill_ssdt(const struct udevice *dev,
 	return 0;
 }
 
-struct acpi_ops dw_i2c_acpi_ops = {
+static struct acpi_ops dw_i2c_acpi_ops = {
 	.fill_ssdt	= dw_i2c_acpi_fill_ssdt,
 };
 
-- 
2.53.0

