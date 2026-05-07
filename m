Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D49CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01CB884BBE;
	Thu,  7 May 2026 18:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KEUHDQEh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qt8guWD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8E584BBE; Thu,  7 May 2026 18:42:36 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9DEB84BB3
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBJ2L1HqTz9t1y;
 Thu,  7 May 2026 18:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20tstPaSwFgt/8NjHeurCqVUnmhDUiF5YqWgduYAmc0=;
 b=KEUHDQEhLZIWqyhSXCCJnToaGWAlDfHPMgoP3JpZaeCiQmdAqEf5tWG0CPfqk6rWaU9cmW
 p7O28WZnd6Q9LTObzqYk1bpLkH0na0AulUsz/CYjE8VB+dAxqfSUEVC0jEhRgxqClN9arp
 fjGtZ+ZVgXhHfezTL/YxmCPqHO1IKup8UwAGDLw5WYPftQmIglqsRbhRTwTz6dHDkNaYYI
 3OZcoCH7W4ii4d4eD6DE+/X17dMPX1VBMXBkQ2BiCHFG8VWdrRnX6hfVZKU7bGo/ZbboCg
 AW77jP1gv/4Y6L0FunPzOTi6EG2SZGoG2BoOGayM8wji6WVb0vo+lyy+YTaIOw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20tstPaSwFgt/8NjHeurCqVUnmhDUiF5YqWgduYAmc0=;
 b=qt8guWD7TiL0edpXZDZ9w2sR3EtCnQHZ6iMo0NYMflaz/eh88QM9YCoVfx94S6n8oalU34
 8wwpeeCdJua9P6yUMHIhcIYD0MH4F8XVkxT/ZoEzyPqj0Gv+zMP0D1nMkSZ+5UQqZme59n
 B6645QCeS5f8s5HJhmNobgycsFW9ePDAzhtHFNrAifQ1XBZiH2CAQLok6xorj2jSvS/zCX
 yKeCzdhnCsiUyQNEw3xbQH+qSkkH1bOqwfaQ2W8HVaejKKghSpcvNdGcbAtu+nzJGikgpS
 NHPKsl2ROZ/jVJwz5OBmzgCT0JFu5xX00W9A0i3HkdJHpkPYtuF0PK+p3Hu5mA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] ata: sata_mv: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:42:08 +0200
Message-ID: <20260507164225.59325-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
References: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3fqzaxcqk75uex1r1oehhuex6r6x5ott
X-MBO-RS-ID: 100742df0381ff68491
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
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ata/sata_mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index b8c73b4a9dd..3fb1a245698 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1122,7 +1122,7 @@ static const struct udevice_id sata_mv_ids[] = {
 	{ }
 };
 
-struct ahci_ops sata_mv_ahci_ops = {
+static const struct ahci_ops sata_mv_ahci_ops = {
 	.scan = sata_mv_scan,
 };
 
-- 
2.53.0

