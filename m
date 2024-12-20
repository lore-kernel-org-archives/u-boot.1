Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC43E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 865A980291;
	Fri, 20 Dec 2024 01:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Wzmr0IRx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VMf5zKp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969038032B; Fri, 20 Dec 2024 01:50:30 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6EB8021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YDpjw0F0Zz9sm6;
 Fri, 20 Dec 2024 01:50:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734655828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+xgOOqijnRxuswVcp6hNrWmXpZ1Jvjg1SP8nDmIpBMs=;
 b=Wzmr0IRxViCT7Lkt1brdcEmRIY0hLOdoOMuYp14WI+IGhn8HvVqzLeEnSMimPAKcCxdb3U
 zl/Qqc+UfBlnNosLhU+pXHDF76KU/N2BeWJy6qkZtBAMvX9ebr0iRoo0N0IEDUk4M81KF6
 jGkykxo7NSdOmZXvZNkygS89OfGzNXzRi15xGjdPyXqMF61i0okYYybPYS2sMq21JJzzQh
 XPrxm7G7vit1X2JCTY9hMb4TMibNBqcibXNVSag3cwZnZXjdrrcz3X9TZSyAYqfM6/7Hla
 BTZb+0EvJYYpYpybKmQIcocjjL1qsk8DIWiLj3/r4OuzsLX2hJUnK3oflJ6jSQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734655826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+xgOOqijnRxuswVcp6hNrWmXpZ1Jvjg1SP8nDmIpBMs=;
 b=VMf5zKp3SRhWf7pK9Xk6GTU3yxvQwX3ebku2yjHCP+yVEB6l6XBbwzkF0Vr789IicitBAi
 dUX4a8C8WIkCBVc9b+g+t5Qqi+PijbdVTUbSMlrcIY82xMuY0oPxFCqQaxzv0G0kzLde5p
 Zjo1kK8+bE3YEW2qsgHwJn9B0bs4YRHGxDHVKh67WArjDgkHJ79zazpnuqVCm6+C1dXXMi
 xML/Ps0s5jr9+GIw09URb2X1uN6QnfEly61hWYpbSsOMyU0I/0Q0QwcuQg8mKzNKa3bxlh
 S2nT2lhFXVmjmJ8d2atr3R9G81X9Tq+1YZoY810PR2kVv5IQ0PVgd2GIB+jO8Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] net: rswitch: Fold MPSM C45 setting into
 rswitch_mii_access_c45()
Date: Fri, 20 Dec 2024 01:48:40 +0100
Message-ID: <20241220005007.169383-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cb39845f3d45e65f6b3
X-MBO-RS-META: iayuboiytmpna7r8npptdyj1zdi5i6up
X-Rspamd-Queue-Id: 4YDpjw0F0Zz9sm6
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

The Set Station Management Mode : Clause 45 setting of MFF bit in MPSM
register can be done in rswitch_mii_access_c45() once, instead of this
being done before each rswitch_mii_access_c45() call. Deduplicate the
bit setting into rswitch_mii_access_c45(). No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 247eb139ff9..5dc5de15f6f 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -365,6 +365,9 @@ static int rswitch_mii_access_c45(struct rswitch_etha *etha, bool read,
 	if (devad == 0xffffffff)
 		return 0;
 
+	/* Set Station Management Mode : Clause 45 */
+	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
+
 	/* Clear completion flags */
 	writel(MMIS1_CLEAR_FLAGS, etha->addr + MMIS1);
 
@@ -429,9 +432,6 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 			MPIC_MDC_CLK_SET);
 
-	/* Set Station Management Mode : Clause 45 */
-	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
-
 	/* Access PHY register */
 	val = rswitch_mii_access_c45(etha, true, phyad, devad, regad, 0);
 
@@ -460,9 +460,6 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 			MPIC_MDC_CLK_SET);
 
-	/* Set Station Management Mode : Clause 45 */
-	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
-
 	/* Access PHY register */
 	rswitch_mii_access_c45(etha, false, phyad, devad, regad, data);
 
-- 
2.45.2

