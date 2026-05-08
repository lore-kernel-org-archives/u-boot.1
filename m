Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13653CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAFF84C7E;
	Fri,  8 May 2026 14:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pCyYKalM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ct7fNgO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A465B84AC1; Fri,  8 May 2026 14:21:09 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D7584AC1
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpBC3csZz9t6F;
 Fri,  8 May 2026 14:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pLz4BM1pVwkrIR9dtwg+Wb4MCYyauB+M0ahi0+4Qa0U=;
 b=pCyYKalMLcfMpeZpvk4E8X9Xd67DvhTJBYapNqLNL4PCYDSGaXyKjAHNNacdbvOxtr0Iyp
 8nSe8jVnV00rn8fEMY5PwvFlz6EDTJtiZFrBqUq7MMmSebwo3GNEwPbM+KkEJYyRGstbOP
 cNvpviyD2nDtExsitlQnyngrIFYSnfpOyreBLGel6wgpuvnqwMPWGCoR2+o77Yi7F2Ukdw
 HmZctz7TI3xzb3Sz/ju3Hwm0LSE7s1GOcXnSbIgU9Vm2sSUxDGGTEvvmDEhc9bhM7X6RRW
 VInErtKNQ1I5i/BMndz+rCfX2uz6uBcDyc7adz0nUsekZnC2IyNjGFBmP2F/vg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Ct7fNgO5;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pLz4BM1pVwkrIR9dtwg+Wb4MCYyauB+M0ahi0+4Qa0U=;
 b=Ct7fNgO5CyRj+SPATWPtGIYG2Ul174WTUPX3QCVF+NHJfMakqRWCFpom7oqxZOEP3D5qDJ
 MfUKW8w+dtOvhwd97BUeVvEk1FljrgK1XBuUd/wO08XjxkS3w8lYK45bYPWM6T8ptbmqOV
 2g0WX6ZZ6dlCYYjefThF7uEvGNCgfP6gziLlxlENBR8YROffak4jEMFoxZNdX4lOzYcohG
 h5JObYqQzTEtA8sRrQ3Jus6wfZfaORvFVUXM11a1SDijrG7F7Bx37GbFJVoYmd/CMpGJ97
 FpkUCZnRImXM1WlsBClcr9yckFYUHCASs+NCjzS5680xFPo88E0Y92hPKg7Q/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Maarten Brock <Maarten.Brock@sttls.nl>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] i2c: designware_i2c: Staticize driver ops
Date: Fri,  8 May 2026 14:20:51 +0200
Message-ID: <20260508122102.512765-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y8py5647gmtjuenzmekj4ht9fbuq1jrs
X-MBO-RS-ID: 15db38dfb95452d3dce
X-Rspamd-Queue-Id: 4gBpBC3csZz9t6F
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

Set the ops structure as static. The structure is not accessible
from outside of this driver.

Reviewed-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Add RB from Heiko
    - Drop the const part, this conflicts with ACPI_OPS_PTR macro
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

