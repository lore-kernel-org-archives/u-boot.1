Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0191ACD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B1D84C92;
	Fri,  8 May 2026 14:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qvh+WM2C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NKhMRjSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA8D84CA7; Fri,  8 May 2026 14:24:11 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A63B8488B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBpFj3B6wz9skt;
 Fri,  8 May 2026 14:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2IMfzeOSHDG3wwJSPDf6cFeLciqJx9p8afCBhhhmWgM=;
 b=qvh+WM2C7pLP1SCtJSabEMY85UKfZh5HbfNWQMwrkCsLftuWL7kUn1juNf0Kl6qK2fUoGs
 U3E6t5tF/76BtUEuRGheI9l9eVG98EvKoRClIq4uFTcyMZzpJ1O4Tvn1WYWZx6A++jDIrE
 ugT0BcJCb8onhWKOLwiJOXKAqOYW9UNFAsgsOkVw6bd2AQ5yOW/Pl0L6G68AxdM7iUhsCM
 qmsqzXc+Ooc8hKaSKelrb0Fh+VHM/BnCeVURAWoSuvPCaI87VXFTWUSLYM4FkPghGb6ADw
 Tbn+6zs+ppYWgmhaRiXpoUsJMdh28FXGG0USwTLtfbF+oHFvDUxk2L5pawNySA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2IMfzeOSHDG3wwJSPDf6cFeLciqJx9p8afCBhhhmWgM=;
 b=NKhMRjSKhOcB/9e5C/kCSXn1xsqMYh43tzNVbc7upIDz9NDxiTWwbQcxIVmjT/cyDL53N4
 zMTyhsEBjwGq8ku1Emk7mwUWtR6Rz0iA1clSCgANUsYo6Dj5oOjoTB4g2BW9CN+a2Racpj
 kR7iaInNSzngbQsgnPrSyLx7RycW8vV+drwKmSdYPN0T647nqg5TVdoiDY1yPrc7vFfx1A
 aLCaiF1WnRKgktMWiga2T/qnuODCFaPOwp4rTUPNn2wKO4bOImjpMeygzTU0kEM9lrIOK6
 wxfZDimirfsE/u1XRxnNkm/Mt8iXD2vsG53AHRqAE/LIar2Ktwxo0d8UdsfP+Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] power: pmic: emul: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:23:58 +0200
Message-ID: <20260508122403.512925-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7hhmrxtqbu4dzuxxwz6gz333eqarw5pa
X-MBO-RS-ID: 92dd3a0b3c394e7d5f1
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
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/power/pmic/i2c_pmic_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/i2c_pmic_emul.c b/drivers/power/pmic/i2c_pmic_emul.c
index 6e81b9c3427..b5c8efd427a 100644
--- a/drivers/power/pmic/i2c_pmic_emul.c
+++ b/drivers/power/pmic/i2c_pmic_emul.c
@@ -146,7 +146,7 @@ static int sandbox_i2c_pmic_probe(struct udevice *emul)
 	return 0;
 }
 
-struct dm_i2c_ops sandbox_i2c_pmic_emul_ops = {
+static const struct dm_i2c_ops sandbox_i2c_pmic_emul_ops = {
 	.xfer = sandbox_i2c_pmic_xfer,
 };
 
-- 
2.53.0

