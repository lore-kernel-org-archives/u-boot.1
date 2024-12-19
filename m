Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C50E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 10:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471F48021D;
	Thu, 19 Dec 2024 11:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g1Lhbh8t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vv7UuNLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B331802B4; Thu, 19 Dec 2024 11:53:44 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06BB68021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 11:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YDS8P5YxTz9t80;
 Thu, 19 Dec 2024 11:53:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734605621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uskY3RpKuo7UwtCBxIY2geIsu9shVACXbf/uIF56CV4=;
 b=g1Lhbh8tB6MJ6PSD/VUNd6WFXTPWAMLCPxcfE9blrre+srTPTLK8kVEROCa3+SK4K6FSLn
 RCms1AXGY/2dXzsDvfJxYzgX4v8osZYfpHBrDNXHOMQ1qynt+zxQY85Xx/pShSbzBO4why
 n6CXAbL6s7BMxxGA7H5PVXAfRRAJCwdbo7BkYuvQ8ZPlh0lkji1bpOwdbg/RqVoK+1eM+B
 +Wd7Ru+UkaZngP75wl4kzsuWKcRCZfjepKkThIeBjM19c6oFJLyllvzHSu9JJhUWfWObLz
 x7AS8B5ePwMN5/1z3ExvhE8+JbJ/kmCLbHccEfDMhcwGH+2UeaFghDsDWZusAw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734605619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uskY3RpKuo7UwtCBxIY2geIsu9shVACXbf/uIF56CV4=;
 b=Vv7UuNLvbKWI+K1vOvYBk0cVo1GoQpG7i1Ct+DB6G8Ia5rNqJgWwn94aHnJo+urFCvks+T
 55IHhJioFMSvrhXsmMLDBtWkIfXDGdRcIsR0W7oxkaFCwEUNZei+8gn9FuEtsjYM0uxvWD
 vgTTqWhsH0WyhtaDkKlvHYmd5xQHSBlA/UDu+TVjx6j0TIbRg1TeFXlcTJFEcltlqofCg4
 GZiteVTEUD8y3qhcOwMX4qVN94qC0ac9rOT7H5hzdFKBlYewMIzb32QuITnexcTaS9xgga
 x4qDUfVNHoQXziprvNwonUgqdhNWqWHUTjzT45h+baoRqsyqQhbDUBdY4mxHQw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: rswitch: Simplify code using clrsetbits_le32()
Date: Thu, 19 Dec 2024 11:53:19 +0100
Message-ID: <20241219105326.6988-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9sjjrstikuupobtksys1rdjwn95ed8gx
X-MBO-RS-ID: a446c8bdae596dccc52
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

Use clrsetbits_le32() to make this complicated construct simpler.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 259d584ac98..9ebe1e97bd1 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -426,9 +426,9 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 	rswitch_etha_change_mode(priv, EAMC_OPC_CONFIG);
 
 	/* Enable Station Management clock */
-	reg = readl(etha->addr + MPIC);
-	reg &= ~MPIC_PSMCS_MASK & ~MPIC_PSMHT_MASK;
-	writel(reg | MPIC_MDC_CLK_SET, etha->addr + MPIC);
+	clrsetbits_le32(etha->addr + MPIC,
+			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
+			MPIC_MDC_CLK_SET);
 
 	/* Set Station Management Mode : Clause 45 */
 	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
@@ -458,9 +458,9 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 	rswitch_etha_change_mode(priv, EAMC_OPC_CONFIG);
 
 	/* Enable Station Management clock */
-	reg = readl(etha->addr + MPIC);
-	reg &= ~MPIC_PSMCS_MASK & ~MPIC_PSMHT_MASK;
-	writel(reg | MPIC_MDC_CLK_SET, etha->addr + MPIC);
+	clrsetbits_le32(etha->addr + MPIC,
+			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
+			MPIC_MDC_CLK_SET);
 
 	/* Set Station Management Mode : Clause 45 */
 	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
-- 
2.45.2

