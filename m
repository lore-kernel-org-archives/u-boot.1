Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6424CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F3284B8D;
	Thu,  7 May 2026 18:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q4IxxHJn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M3CBQEiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A75FD84B5D; Thu,  7 May 2026 18:42:31 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E574E84A4F
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBJ2F4b5Qz9vHF;
 Thu,  7 May 2026 18:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kmJjuIhxBcLzBONJFWikbAvxYK9b7+uIkxIF7LGiIi8=;
 b=q4IxxHJnHsqEaxcy5HrbboGDi0BgwvBxHU85Iy9t54ErZhH6O8CbLq0++mOzVJZYmtrymB
 KqHdgLwToqYDkTVYC9jQzIOlWbgvdCcIcAEUV7HuwEEZ3dnZLhsfP1/z0LQx+myftRquQ7
 gSGYbROdTo5SlATRc/KYXevzzZ7T3iVPxHi3UD47Mz/FQ5bY0IY4NMYkncHQX0Szg+Wjx7
 jt00vhWKAQ0+m1UK2KqM25q5gmdNljuZzVaUIfBjCxUbDgGXA/GlZ3OpYPLMbVCOD5qrM7
 IMZq0fepmsCvw/nAM8zzKyZjDhNJ1s0+mrtA9Jifckq8YSOEx8vUG6MODSDPIQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kmJjuIhxBcLzBONJFWikbAvxYK9b7+uIkxIF7LGiIi8=;
 b=M3CBQEiPjK2FqrDajsxr47xDeBsFl47MipNephfYlTvVzi+kEwxou7uTE33eUH2G1HLF7z
 MyVuizXuFg8hm4SN+0V0SNtilfGwfPUQEZlC5TZtVJQT8rOpHom80HpQV6xf0wym/1vWRg
 xAlwNv6p7hqzMsxsCF+OLVp60LT/3zwVbQTw2V1DvgrGRLDep3tAHbsyqZV5xPxDE8EEhp
 0/QoLKGPfBA+gOG/a4L2vlmBV+CfpErKgvn4qKAR+Bg/NtGjlTPNq8wn2gaWBCludN/44t
 zzAcnVP5cTd7c3O8M2RIHqpo3PRbd8E26cXHhh4jC0XQRMlP89M/tbW6+5LOJw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] ata: fsl_sata: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:42:06 +0200
Message-ID: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: brgdxumxin54ca53wxr84ftsc6q3mqh1
X-MBO-RS-ID: 454a40200b560857d57
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
 drivers/ata/fsl_sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/fsl_sata.c b/drivers/ata/fsl_sata.c
index 4990148388b..a29735f7609 100644
--- a/drivers/ata/fsl_sata.c
+++ b/drivers/ata/fsl_sata.c
@@ -960,7 +960,7 @@ static int sata_fsl_scan(struct udevice *dev)
 	return 0;
 }
 
-struct ahci_ops sata_fsl_ahci_ops = {
+static const struct ahci_ops sata_fsl_ahci_ops = {
 	.scan = sata_fsl_scan,
 };
 
-- 
2.53.0

